source 'https://cdn.cocoapods.org/'

platform :ios, '12.0'
use_frameworks!

install! 'cocoapods',
         :deterministic_uuids => false,
         :preserve_pod_file_structure => true,
         :generate_multiple_pod_projects => true,
         :incremental_installation => true,
         :share_schemes_for_development_pods => true

pod 'StateUIModel', :path => './Libraries/Core/StateUIModel'
pod 'BaseRepo', :path => './Libraries/Core/BaseRepo'
pod 'Bindable', :path => './Libraries/Core/Bindable'
pod 'CoreNetworking', :path => './Libraries/Core/CoreNetworking',  :testspecs => ['CoreNetworkingTests']
pod 'CoreError', :path => './Libraries/Core/CoreError'
pod 'Utils', :path => './Libraries/Core/Utils'

target 'MVVMR' do
  use_frameworks!
end

target 'MVVMRTests' do
  inherit! :search_paths
end

target 'MVVMRUITests' do
end
