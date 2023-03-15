//
//  Binder.swift
//  VIPER_Example
//
//  Created by Hussam Elsadany on 19/07/2022.
//
//
// MARK: - Bindables
public protocol BindableProtocol {
    associatedtype T
    typealias Listener = (T) -> Void
    func bind(_ listener: @escaping Listener) -> DisposableProtocol
    func bindAndFire(_ listener: @escaping Listener) -> DisposableProtocol
}

public class Bindable<T>: BindableProtocol {
    
    public typealias T = T
    private let strategy: CallbackBindable<T>
    
    //MARK:- Init
    public init(_ value: T) {
        strategy = CallbackBindable(value)
    }
    
    
    //MARK:- Binding
    public func bind(_ listener: @escaping Listener) -> DisposableProtocol {
        strategy.bind(listener)
    }
    
    public func bindAndFire(_ listener: @escaping Listener) -> DisposableProtocol {
        strategy.bindAndFire(listener)
    }
    
    //MARK:- Accessors
    public func next(_ value: T) {
        strategy.next(value)
    }
    
    public var value: T {
        return strategy.value
    }
    
}

private protocol BindableValueAccessorsProtocol: BindableProtocol {
    var value: T { get }
    func next(_ :T)
}

private class CallbackBindable<T>: BindableValueAccessorsProtocol {
    
    typealias T = T
    
    private(set) var value: T
    
    private var listeners: [(identifier: UUID, listener: Listener)] = []
    
    init(_ value: T) {
        self.value = value
    }
    
    func next(_ value: T) {
        self.value = value
        notifyListeners(value)
    }
    
    func bind(_ listener: @escaping Listener) -> DisposableProtocol {
        let listenerId = UUID()
        let disposable = BindDisposable(){ [weak self] in
            self?.removeListener(with: listenerId)
        }
        
        self.listeners.append((identifier: listenerId, listener: listener))
        return disposable
    }
    
    func bindAndFire(_ listener: @escaping Listener) -> DisposableProtocol {
        let disposable = self.bind(listener)
        listener(value)
        return disposable
    }
    
    private func removeListener(with id: UUID) {
        self.listeners.removeAll(where: { $0.identifier == id })
    }
    
    private func notifyListeners(_ value: T) {
        self.listeners.forEach({ $0.listener(value) })
    }
}

// MARK: - Disposables
public protocol DisposableProtocol {
    func dispose()
    func add(to disposeBag: DisposableBag)
}

private class BindDisposable: DisposableProtocol {
    
    private let onDispose: (() -> Void)
    
    init(onDispose: @escaping () -> Void) {
        self.onDispose = onDispose
    }
    
    public func dispose() {
        onDispose()
    }
    
    public func add(to disposeBag: DisposableBag) {
        disposeBag.add(self)
    }
    
    deinit {
        dispose()
    }
}

// MARK: - Disposable Bag
public class DisposableBag {
    
    private var disposables: [DisposableProtocol] = []
    
    public init(){}
    
    public func add(_ disposable: DisposableProtocol) {
        disposables.append(disposable)
    }
    
    deinit {
        disposables.forEach { disposable in
            disposable.dispose()
        }
    }
}
