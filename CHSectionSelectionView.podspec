Pod::Spec.new do |s|
  s.name         = "CHSectionSelectionView"
  s.version      = "0.5.0"
  s.summary      = "Easy to use and highly customizable View that displays selector controls for (e.g.) UITableView Sections."

  s.description  = <<-DESC
                   Easy to use and highly customizable View that displays selector controls for (e.g.) UITableView Sections.
                   This project is inspired by the iPads Address Book application.
                   DESC

  s.homepage     = "https://github.com/alexandreos/CHSectionSelectionView"
  s.license      = { :type => 'Apache License, Version 2.0', :text => <<-LICESNSE
                      Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

                      http://www.apache.org/licenses/LICENSE-2.0

                      Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

                      Attribution is appreciated.
                      LICESNSE
                    }

  s.authors      = { "Alexandre Santos" => "alexandre_o_s@yahoo.com", "Clemens Beat" => "beat84@me.com" }
  s.platform     = :ios, '5.0'
  s.source       = { :git => "https://github.com/alexandreos/CHSectionSelectionView.git", :tag => "0.5.0" }
  s.source_files = 'CHSectionSelectionView/CHSectionSelectionView/*.{h,m}'
  s.requires_arc = true

end
