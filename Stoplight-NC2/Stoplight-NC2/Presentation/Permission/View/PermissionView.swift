//
//  PermissionView.swift
//  Stoplight-NC2
//
//  Created by kyungsoolee on 6/14/24.
//

import SwiftUI

struct PermissionView: View {
    @StateObject private var viewModel = PermissionViewModel()
    
    var body: some View {
        VStack(alignment: .center) {
            navigationHeaderLikeView()
            decorationView()
            permissionButtonView()
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )
        .sheet(isPresented: $viewModel.isSheetActive) {
            sheetView()
        }
        .onAppear {
            viewModel.handleTranslationView()
        }
    }
}

// MARK: - Views
extension PermissionView {
    private func navigationHeaderLikeView() -> some View {
        HStack {
            Button {
                viewModel.showIsSheetActive()
            } label: {
                Image(systemName: viewModel.HEADER_ICON_LABEL)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.secondary)
            }
            .frame(width: 40, height: 40)
        }
        .padding(8)
        .frame(maxWidth: .infinity, maxHeight: 42, alignment: .trailing)
        .opacity(viewModel.isViewLoaded ? 1 : 0)
    }
    
    private func decorationView() -> some View {
        VStack(spacing: 12) {
            Image(viewModel.DECORATION_TEXT_INFO.imgSrc)
                .resizable()
                .frame(width: 100, height: 100)
            if viewModel.isViewLoaded {
                Text(viewModel.DECORATION_TEXT_INFO.title)
                    .font(.largeTitle)
                    .foregroundColor(Color.black)
                    .bold()
                Text(viewModel.DECORATION_TEXT_INFO.subTitle)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                Text(viewModel.DECORATION_TEXT_INFO.author)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func permissionButtonView() -> some View {
        HStack {
            Button {
                viewModel.handleRequestAuthorization()
            } label: {
                Text(viewModel.PERMISSION_BUTTON_LABEL)
            }
            .buttonStyle(.borderless)
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: 128)
        .opacity(viewModel.isViewLoaded ? 1 : 0)
    }
    
    private func sheetView() -> some View {
        VStack {
            Text(viewModel.SHEET_INFO_LIST[0])
                .multilineTextAlignment(.center)
                .padding(.bottom, 24)
                .font(.title2)
            Text(viewModel.SHEET_INFO_LIST[1])
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.bottom, 24)
                .font(.body)
        }
        .padding(24)
    }
}

struct PermissionView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionView()
    }
}
