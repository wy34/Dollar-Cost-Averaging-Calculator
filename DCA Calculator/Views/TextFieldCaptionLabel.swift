//
//  TextFieldCaptionLabel.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/7/21.
//

import SwiftUI

struct TextFieldCaptionLabel: View {
    var caption: String?
    var currency: String?
    
    var body: some View {
        HStack {
            Text("\(caption ?? "") \(currency ?? "")")
                .font(.system(size: 14, weight: .regular, design: .rounded))
                .foregroundColor(Color(.darkGray))
        }
    }
}

struct TextFieldCaptionLabel_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldCaptionLabel()
    }
}
