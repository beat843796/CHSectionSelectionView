## CHSectionSelectionView
Easy to use and highly customizable View that displays selector controls for (e.g.) UITableView Sections. This project is inspired by the iPads Address Book application.


## Usage
- Refer to the **Demo project**.
- Drag and Drop CHSectionSelectionView.h/.m and CHSectionSelectionItemView to your project
- Subclass CHSectionSelectionItemView to handle communication between static and sliding controller
- Implement the delegate and datasource protocol in your ViewController


Setting up the SectionSelectionView (Example)

```objc
	_selectionView = [[CHSectionSelectionView alloc] init];
    _selectionView.backgroundColor = [UIColor whiteColor];
    _selectionView.dataSource = self;
    _selectionView.delegate = self; 
    _selectionView.showCallouts = YES; // the view should show a callout when an item is selected
    _selectionView.calloutDirection = SectionCalloutDirectionRight; // Callouts should appear on the right side
    [self.view addSubview:_selectionView];
```

Implement the Datasource

```objc
	-(CHSectionSelectionItemView *)sectionSelectionView:(CHSectionSelectionView *)sectionSelectionView sectionSelectionItemViewForSection:(NSInteger)section;
	-(NSInteger)numberOfSectionsInSectionSelectionView:(CHSectionSelectionView *)sectionSelectionView;

	@optional
	-(UIView *)sectionSelectionView:(CHSectionSelectionView *)sectionSelectionView callOutViewForSelectedSection:(NSInteger)section;
```

Implement the delegate

```objc
    @optional
	-(void)sectionSelectionView:(CHSectionSelectionView *)sectionSelectionView didSelectSection:(NSInteger)section;
```

## License
Copyright 2012 Clemens Hammerl

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
 limitations under the License. 

Attribution is appreciated.