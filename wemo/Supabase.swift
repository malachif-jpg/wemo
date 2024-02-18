//
//  Supabase.swift
//  wemo
//
//  Created by Malachi Frazier on 2/17/24.
//

import Supabase
import Foundation

let supabase = SupabaseClient(
    supabaseURL: URL(string: "https://lbhpwlluqzhkruroltzv.supabase.co")!,
    supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxiaHB3bGx1cXpoa3J1cm9sdHp2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDczNjUzNTQsImV4cCI6MjAyMjk0MTM1NH0.nH3KnXELfpem-cEGiVdAc1K_p8_fbqiHJEQM0T9NA3Y"
)
