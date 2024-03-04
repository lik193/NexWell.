//
//  quoteView.swift
//  NexWell.
//
//  Created by Keoni Li on 10/17/23.
//

import SwiftUI

struct QuoteManager {
    static var shared = QuoteManager()
    
    private let lastIndexKey = "lastQuoteIndex"
    private let lastDateKey = "lastQuoteDate"
    
    var lastQuoteIndex: Int {
        get { UserDefaults.standard.integer(forKey: lastIndexKey) }
        set { UserDefaults.standard.set(newValue, forKey: lastIndexKey) }
    }
    
    var lastQuoteDate: Date? {
        get { UserDefaults.standard.object(forKey: lastDateKey) as? Date }
        set { UserDefaults.standard.set(newValue, forKey: lastDateKey) }
    }
    
    func needsToUpdate() -> Bool {
        guard let lastDate = lastQuoteDate else { return true }
        return !Calendar.current.isDate(lastDate, inSameDayAs: Date())
    }
    
    mutating func updateQuoteIndex() {
        lastQuoteIndex = (lastQuoteIndex + 1) % 60
        lastQuoteDate = Date()
    }
}

struct quoteView: View {
    @State private var quoteIndex: Int = QuoteManager.shared.lastQuoteIndex
    var light : Bool
    let widthDiv : CGFloat
    
    let quotes: [String] = [
        "Nothing ever goes away until it teaches us what we need to know.\n -Pema Chodron",
        "Old ways won’t open new doors.\n -Unknown",
        "Whether you think you can or think you can’t— you are right.\n -Henry Ford",
        "Interrupt anxiety with gratitude.\n -Unknown",
        "Dead people receive more flowers than living ones because regret is stronger than gratitude.\n -Anne Frank",
        "Breathe. Let go. And remind yourself that this very moment is the only one you know you have for sure.\n -Oprah Winfrey",
        "A positive attitude gives you power over your circumstances instead of your circumstances having power over you.\n -Joyce Meyer",
        "Your life is as good as your mindset.\n -Unknown",
        "Be kind. Everyone you meet is fighting a battle you know nothing about.\n -Unknown",
        "Gratitude and attitude are not challenges; they are choices.\n -Robert Braathe",
        "I am not what happened to me, I am what I choose to become.\n -Carl Jung",
        "Your life isn’t yours if you always care what others think.\n -Unknown",
        "Worrying does not take away tomorrow’s troubles, it takes away today’s peace.\n -Unknown",
        "If you see someone without a smile, give them one of yours.\n -Dolly Parton",
        "Who you spend your time with will have a great impact on what kind of life you live. Spend time with the right people.\n -Joel Osteen",
        "Do not give your past the power to define your future.\n -Unknown",
        "If your dreams don’t scare you, they are too small.\n -Richard Branson",
        "When thinking about life, remember this:\n no amount of guilt can change the past\n and no amount of anxiety can change the future.\n -Unknown",
        "A ship in harbor is safe, but that is not what ships are built for.\n -John A. Shedd",
        "Life always offers you a second chance. It’s called tomorrow.\n -Unknown",
        "If you stay positive in a negative situation, you win.\n -Unknown",
        "You can’t go back and change the beginning, but you can start where you are and change the ending.\n -C.S. Lewis",
        "Twenty years from now you will be more disappointed by the things you didn’t do than by the things you did.\n -Mark Twain",
        "Accept both compliments and criticism. It takes both sun and rain for a flower to grow.\n -Unknown",
        "Do the one thing you think you cannot do. Fail at it. Try again. Do better the second time. The only people who never tumble are those who never mount the high wire. This is your moment. Own it.\n -Oprah Winfrey",
        "Decide what kind of life you want, then say no to anything that isn’t that.\n -Unknown",
        "Each day you must choose, the pain of discipline, or the pain of regret.\n -Eric Mangini",
        "Your mind will always believe everything you tell it.\n Feed it hope.\n Feed it truth.\n Feed it with love.\n -Unknown",
        "You will have bad times, but they will always wake you up to the stuff you weren’t paying attention to.\n -Robin Williams",
        "Anything’s possible if you’ve got enough nerve.\n -J.K. Rowling",
        "The best view comes after the hardest climb.\n -Unknown",
        "How you love yourself is how you teach others to love you.\n -Rupi Kaur",
        "Don’t wait for things to get better. Life will always be complicated. Learn to be happy right now, otherwise you’ll run out of time.\n -Unknown",
        "The best part about life?\n Every morning you have a new opportunity to become a happier version of yourself.\n -Unknown",
        "If someone is judging you, that’s their problem. Don’t make it yours.\n -Mel Robbins",
        "Don’t wish for it, work for it.\n -Unknown",
        "Two things you are in control of in life are your attitude and your effort.\n -Unknown",
        "Remember that failure is an event, not a person. Yesterday ended last night.\n -Zig Ziglar",
        "Trust the timing of your life.\n -Unknown",
        "If you talk about it, it’s a dream, if you envision it, it’s possible, but if you schedule it, it’s real.\n -Tony Robbins",
        "Be fearless in the pursuit of what sets your soul on fire.\n -Unknown",
        "Be stubborn about your goals and flexible about your methods.\n -Unknown",
        "Starve your distractions, feed your focus.\n -Unknown",
        "A goal without a plan is just a wish.\n -Antoine de Saint-Exupery",
        "The big secret in life is that there is no big secret. Whatever your goal, you can get there if you’re willing to work.\n -Oprah Winfrey",
        "Almost everything will work again if you unplug it for a few minutes. Including you.\n -Anne Lamott",
        "When you really want something you will find a way. When you don’t really want something, you’ll find an excuse.\n -Rachel Hollis",
        "If you don’t like something, change it. If you can’t change it, change your attitude.\n -Maya Angelou",
        "Comparison is the death of all joy, and the only person you need to be better than is the one you were yesterday.\n -Rachel Hollis",
        "When you change the way you look at things, the things you look at change.\n -Wayne Dyer",
        "Life is 10% what happens to you and 90% how you react to it.\n — Charles R. Swindoll",
        "Change your thoughts, and you change your world.\n — Norman Vincent Peale",
        "All our dreams can come true if we have the courage to pursue them.\n — Walt Disney",
        "Success is a journey not a destination.\n — Ben Sweetland",
        "What you get by achieving your goals is not as important as what you become by achieving your goals.\n — Zig Ziglar",
        "It always seems impossible until it's done.\n — Nelson Mandela",
        "Success is liking yourself, liking what you do, and liking how you do it.\n — Maya Angelou",
        "Aim for the moon. If you miss, you may hit a star.\n — W. Clement Stone",
        "If you cannot do great things, do small things in a great way.\n — Napoleon Hill",
        "Success only comes to those who dare to attempt.\n — Mallika Tripathi"
    ]

    var body: some View {
        Text(quotes[quoteIndex])
            .foregroundStyle(light ? .black : .white)
            .font(.system(size: quotes[quoteIndex].split(separator: " ").count > 30 ? 12.5 : 15, weight: .bold))
            .frame(width: UIScreen.main.bounds.width / widthDiv)
            .padding()
            .onAppear {
                if QuoteManager.shared.needsToUpdate() {
                    QuoteManager.shared.updateQuoteIndex()
                    quoteIndex = QuoteManager.shared.lastQuoteIndex
                }
            }
        }
        
}

#Preview {
    quoteView(light: true, widthDiv: 1.2)
}

