//
//  IntoroView.swift
//  UI-770
//
//  Created by nyannyan0328 on 2022/10/17.
//

import SwiftUI

struct IntoroView: View {
    @State var showHome : Bool = false
    
    @State var showWorkThroughtScreen : Bool = false
    
    @State var currentIndex : Int = 0
    
   
      @Namespace var animation
    var body: some View {
        ZStack{
            
          
                if showHome{
                    
                    SampleHome()
                        .transition(.identity)
                    
                }
                else{
                    ZStack{
                        
                        
                        Color("BG").ignoresSafeArea()
                        
                        IntoroScreen()
                        
                        WorkThroughScrrens()
                        
                        NavBar()
                    }
                    .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85), value: showWorkThroughtScreen)
                }
            
        }
    }
    @ViewBuilder
    func WorkThroughScrrens ()->some View{
     
        let islast = currentIndex ==  intros.count
        GeometryReader{
            
            let size = $0.size
         
            ZStack{
                
                ForEach(intros.indices ,id:\.self){index in
                    
                    ScrrenView(index: index, size: size)
                        
                    
                }
                WelcomView(index: intros.count, size: size)
          
                
            }
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .overlay(alignment:.bottom) {
                  
                  Indicators()
                      .opacity(islast ? 0 : 1)
                      .animation(.easeInOut, value: islast)
                      .offset(y:-180)
                  
              }
              
                     
             
              .overlay(alignment:.bottom) {
                  
                  ZStack{
                      Image(systemName: "chevron.right")
                          .font(.title)
                          .scaleEffect(!islast ? 1 : 0.001)
                          .opacity(!islast ? 1 : 0)
                      
                      HStack{
                          
                          Text("Sign up")
                              .font(.custom(sansBold, size: 13))
                              .foregroundColor(.white)
                                .frame(maxWidth: .infinity,alignment: .leading)
                          
                          
                          Image(systemName: "arrow.right")
                              .font(.caption)
                              .foregroundColor(.white)
                      }
                      
                      .padding(.horizontal,15)
                      .scaleEffect(islast ? 1 : 0.001)
                      .frame(height: islast ? nil : 0)
                      .opacity(islast ? 1 : 0)
                      
                  }
                  
                 
                  .frame(width: islast ? size.width / 1.5 : 55,height: islast ? 50 : 55)
                   .foregroundColor(.white)
                   .background{
                    
                       RoundedRectangle(cornerRadius: islast ? 10 : 30, style: islast ? .continuous : .circular)
                           .fill(Color("Blue"))
                   }
               
                   .onTapGesture {
                       if currentIndex == intros.count{
                           
                           showHome = true
                           
                           
                       }
                       else{
                           currentIndex += 1
                       }
                   }
                   .offset(y:islast ? -40 : -90)
                   .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85), value: islast)
                
              }
              .overlay(alignment: .bottom) {
                  
                  
                  let islast = currentIndex == intros.count
                  
                  
                  HStack(spacing: 5) {
                      
                      Text("Already have an account")
                          .font(.custom(sansSemiBold, size: 15))
                          .foregroundColor(.gray)
                      
                      Button("Login"){
                          
                          showHome = true
                          
                          
                      }
                      .font(.custom(sansRegular, size: 15))
                      .foregroundColor(Color("Blue"))
                      
                  }
                  .offset(y:islast ? -12 : 120)
                  .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85), value: islast)
              }
           
              .offset(y:showWorkThroughtScreen ? 0 : size.height)
        
        }
        
    }
    @ViewBuilder
    func Indicators ()->some View{
     
        HStack(spacing: 8) {
            
            ForEach(intros.indices ,id:\.self){index in
                
                Circle()
                    .fill(.gray.opacity(0.5))
                    .frame(width: currentIndex == index ? 15 : 10,height: currentIndex == index ? 15 : 10)
                    .overlay {
                        if currentIndex == index{
                            
                            Circle()
                                .fill(Color("Blue"))
                               .frame(width: 15,height: 15)
                               .matchedGeometryEffect(id: "INDICATOR", in: animation)
                            
                        }
                        
                    }
            }
            
        }
        .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85), value: currentIndex)
        
    }
    @ViewBuilder
    func ScrrenView (index : Int,size : CGSize)->some View{
        
        
        let intro = intros[index]
        
        VStack(spacing: 15) {
            
            
            Text(intro.title)
                .font(.custom(sansBold, size: 28))
                .offset(x:-size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9,dampingFraction: 0.85,blendDuration: 0.85).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
                
            
            
            Text(dummyText)
                .font(.custom(sansBold, size: 15))
                .multilineTextAlignment(.center)
                .padding(.horizontal,14)
                .offset(x:-size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9,dampingFraction: 0.85,blendDuration: 0.85).delay(0.1).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            
            Image(intro.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .offset(x:-size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9,dampingFraction: 0.85,blendDuration: 0.85).delay(currentIndex == index ? 0 : 0.2).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            
            
        }
        .offset(y:-30)
        
    }
    
    @ViewBuilder
    func WelcomView (index : Int,size : CGSize)->some View{
        
        
       
        VStack(spacing: 15) {
            
          Image("Welcome")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .offset(x:-size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9,dampingFraction: 0.85,blendDuration: 0.85).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
                
            
            
            Text("Welcome")
                .font(.custom(sansBold, size: 15))
                .multilineTextAlignment(.center)
                .padding(.horizontal,14)
                .offset(x:-size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9,dampingFraction: 0.85,blendDuration: 0.85).delay(0.1).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            
           Text("Sample TextSample TextSample TextSample TextSample TextSample Text")
                .font(.custom(sansBold, size: 20))
                .offset(x:-size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9,dampingFraction: 0.85,blendDuration: 0.85).delay(currentIndex == index ? 0 : 0.2).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            
            
        }
        .offset(y:-30)
        
    }
    @ViewBuilder
    func NavBar ()->some View{
        
        let isLast = currentIndex == intros.count
        
        HStack{
            
            Button {
                
                if currentIndex > 0{
                    currentIndex -= 1
                }
                else{
                    
                    showWorkThroughtScreen.toggle()
                }
                
            } label: {
                
                Image(systemName: "chevron.left")
                    .font(.title3.weight(.bold))
                    .foregroundColor(Color("Blue"))
                
                
                
                
            }
            
            Spacer()
            
            Button {
                
                currentIndex = intros.count
                
            } label: {
             
                Text("Skip")
                    .font(.custom(sansRegular, size: 15))
                    .foregroundColor(Color("Blue"))
                
            }
            .opacity(isLast ? 0 : 1)
            .animation(.easeInOut, value: isLast)
        }
        .padding(.horizontal)
        .padding(.top,15)
        .frame(maxHeight: .infinity,alignment: .top)
        .offset(y:showWorkThroughtScreen ? 0 : -120)
       
        
        
        
    }
    @ViewBuilder
    func IntoroScreen ()->some View{
        GeometryReader{
            
            let size = $0.size
            VStack(spacing: 10) {
                
                   Image("Intro")
                       .resizable()
                       .aspectRatio(contentMode: .fit)
                       .frame(width: size.width,height: size.height / 2)
                
                
                Text("ClearHead")
                    .font(.custom(sansBold, size: 15))
                    .padding(.top,55)
                  
                
                Text(dummyText)
                    .font(.custom(sansRegular, size: 13))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,30)
                
                Text("Lets Bigin")
                    .font(.custom(sansSemiBold, size: 20))
                    .padding(.vertical,10)
                    .padding(.horizontal,25)
                    .foregroundColor(.white)
                    .background{
                     
                        Capsule()
                            .fill(Color("Blue"))
                    }
                    .padding(.top,23)
                    .onTapGesture {
                        
                        showWorkThroughtScreen.toggle()
                    }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
            .offset(y:showWorkThroughtScreen ? -size.height : 0)
            
            
            
        }
        .ignoresSafeArea()
        
    }
}

struct IntoroView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SampleHome : View{
    
    var body: some View{
        
        NavigationStack{
            
            Text("Home")
                .font(.largeTitle)
                .navigationTitle("Home")
        }
    }
}

