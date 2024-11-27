import SwiftUI

struct AddLocationCell: View {
    
    //MARK: - Properties
    
    let viewModel: AddLocationCellViewModel
    
    let didTapPlusButton: () -> ()
    
    //MARK: - View
    
    var body: some View {
        HStack {
            Button (action: didTapPlusButton) {
                Image(systemName: "plus")
                    .padding()
                    .tint(.green)
                    .frame(width: 5, height: 5)
            }
            .padding(10)
            .background(.white)
            
            Spacer()
                .frame(width: 20)

            VStack(alignment: .leading) {
                Text(viewModel.name)
                    .font(.headline)
                    .foregroundColor(.accentColor)
                Text(viewModel.country)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(viewModel.coordinates)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
    }
}

#Preview {
    AddLocationCell(viewModel: .init(location: .preview), didTapPlusButton: { })
}
