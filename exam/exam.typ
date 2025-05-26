#import "@preview/a2c-nums:0.0.1": int-to-cn-num
#import "@preview/cuti:0.3.0": show-cn-fakebold
#show: show-cn-fakebold

#set page(paper: "a4")
#set par(spacing: 1.5em, leading: 1.5em)
#show raw.where(block: true): set par(leading: 0.5em)

#set page(
  margin: (
    x: 3cm,
    top: 1cm,
    inside: 3cm,
    outside: 1cm,
  ),
)

#set text(font: ("Times New Roman", "KaiTi"))

#set underline(offset: 1.5pt, stroke: 1pt)

#set par(justify: true)

#let blackline(width) = box(width: width, stroke: (bottom: 0.5pt), none)

#set page(
  header: context {
    let p = counter(page).get().first()
    let blackline = blackline(4cm)
    if calc.odd(p) {
      place(
        left + top,
        dx: -10.5cm,
        dy: 18.5cm,
        rotate(
          -90deg,
          [
            #set text(size: 13pt)
            #grid(
              columns: (6.5cm, 7.5cm, 6.5cm, 6.5cm),
              [学院：#blackline], [专业班级：#blackline], [姓名:#blackline], [学号:#blackline],
            )
            #box[#h(5cm)#text(size: 8pt)[（密封线外不要写姓名、学号、班级、密封线内不准答题，违者按零分计）]]

            #place(dx: -1.5cm, dy: 0.2cm)[
              #box(width: 28.5cm)[
                #set text(size: 10pt)
                #place(dy: 0.3em)[#line(start: (0%, 0%), end: (100%, 0%), stroke: (dash: "dash-dotted"))]
                #grid(
                  columns: (1fr,) * 4,
                  [], [#box(fill: white)[密]], [#box(fill: white)[封]], [#box(fill: white)[线]]
                )
              ]]
          ],
        ),
      )
    }
  },
)

#let examType = "A卷"

#set page(
  numbering: (..nums) => {
    let numArr = nums.pos().map(str)
    text(size:11pt)[#examType 第 #numArr.at(0) 页，共 #numArr.at(1) 页]
  },
)

#set text(size: 15pt)

#align(right)[考试方式：#underline[闭卷]]

#align(center)[#text(size: 1.5em, weight: "bold")[太原理工大学#underline[Java程序设计#examType]试卷]]

#let questionCounter = counter("question")
#let bigQuestionCounter = counter("bigQuestion")

#text(size: 0.85em)[
  #align(center)[适用专业：#underline[数科、智能、医工 2022 级] 考试日期:#underline[2024.5.13] 时间:#underline[120 分钟 共 #context [#counter(page).final().at(0)] 页]]]
#align(center)[#context table(
    columns: (1fr,) * (bigQuestionCounter.final().first() + 2),
    inset: 0.6em,
    align: center,
    [题号], ..(range(1, bigQuestionCounter.final().first() + 1).map(int-to-cn-num)), [总分],
    [得分]
  )
]

#let questionHeader(desc) = {
  bigQuestionCounter.step();
  context block(breakable:false)[
  #table(
  columns: (auto, auto),
  align: (center, left + horizon),
  table.cell(inset: 0.35cm, [得分]),
  table.cell(rowspan: 2, inset: 0.8cm, strong[#int-to-cn-num(bigQuestionCounter.get().first())、#desc]),
  questionCounter.update(1),
)]}

#questionHeader[选择题（每空2分，共20分）]

#align(center)[#table(
    columns: (1.7cm,) + (1.4cm,) * 10,
    inset: 0.3cm,
    align: center,
    [题号], ..range(1, 11).map(str), [答案], ..([],)*10
  )]


#let choiceQuestion(ist: 0.4em, num, question, a, b, c, d) = context block(
  breakable: false,
)[#set par(leading: 0.7em, spacing: 1.0em)
#questionCounter.display(). #question
  #grid(
    columns: (1fr,) * num,
    inset: ist,
    [A. #a], [B. #b], [C. #c], [D. #d]
  )
  #questionCounter.step()
]

#let question(idnt:0em, problem) = context block(breakable: false)[#h(idnt)#questionCounter.display(). #problem#questionCounter.step()]

#choiceQuestion(4, [Java源程序的后缀名是什么？], [.java], [.cpp], [.py], [.c])

#choiceQuestion(
  1,
  [在 Java 中定义一个接口的正确语法是：#lorem(20)],
  [`interface InterfaceName {}`],
  [`class InterfaceName {}`],
  [`Interface InterfaceName {}`],
  [以上都不对],
)

#show math.equation: it => {
  if it.body.fields().at("size", default: none) != "display" {
    return math.display(it)
  }
  it
}

#choiceQuestion(
  2,
  [以下哪个是$e^x$的泰勒展开？],
  [$sum_(i=0)^oo x^i / i!$],
  [$sum_(i=0)^oo (-x)^i / i!$],
  [以上都对],
  [以上都不对],
  ist: 1.1em,
)

#questionHeader[填空题：（每题2分，共20分）]

#question(idnt:2em)[在 Java 中，当子类实现一个接口的方法时，可以使用#blackline(5em)注解进行声明，从而可以在编译期间对相关方法的名称和类型进行检查。]
#question(idnt:2em)[#lorem(20) #blackline(5em) #lorem(20)]
#question(idnt:2em)[#lorem(30) #blackline(5em) #lorem(10)]
#question(idnt:2em)[#blackline(5em) #lorem(20)]
#question(idnt:2em)[#lorem(5) #blackline(5em) #lorem(5)]

#pagebreak()



#questionHeader[简答题（每小题 5 分，共 10 分）]

#question[什么是类？什么是对象？他们之间有何联系与区别？请谈谈你的理解。]
#v(10cm)
#question[谈谈你对于多继承与单继承的理解。]

#pagebreak()


#questionHeader[程序分析题（每小题10分，共20分）]

#question[请简述以下程序的功能及实现原理：]
```
import java.util.ArrayList;
public class Primes {
  static ArrayList<Integer> primes = new ArrayList<>();
  static int currentNum = 2;
  static { primes.add(2); }
  static void getPrimes(int max) {
    if (currentNum >= max) return;
    while (currentNum < max) {
      currentNum++; boolean isPrime = true;
      for (int p : primes)
        if (currentNum % p == 0) {
          isPrime = false; break;
        }
      if (isPrime) primes.add(currentNum);
    }
  }
  public static void main(String[] args) {
    getPrimes(100); System.out.println(primes);
  }
}
```

#pagebreak()

#question[说明以下代码的作用:]


```java
import java.util.Arrays;
class GfG {
  static int partition(int[] arr, int low, int high) {
    int pivot = arr[high]; int i = low - 1;
    for (int j = low; j <= high - 1; j++) {
      if (arr[j] < pivot) {
        i++; swap(arr, i, j); }}
    swap(arr, i + 1, high); return i + 1;
  }
  static void swap(int[] arr, int i, int j) {
    int temp = arr[i]; arr[i] = arr[j]; arr[j] = temp;
  }
  static void qs(int[] arr, int low, int high) {
    if (low < high) {
      int pi = partition(arr, low, high);
      qs(arr, low, pi - 1); qs(arr, pi + 1, high); }}
  public static void main(String[] args) {
    int[] arr = {10, 7, 8, 9, 1, 5}; int n = arr.length;
    qs(arr, 0, n - 1);
    for (int val : arr) System.out.print(val + " ");  
  }
}
```

#pagebreak()


#questionHeader[程序设计题（每题10分，共30分）]

#question[请用Java实现一个操作系统。]

#pagebreak()

#question[请用Java实现一棵红黑树。]

#pagebreak()

#question[请用Java实现惰性链表。]