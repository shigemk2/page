# -*- coding: utf-8 -*-
class PageViewController < UIViewController
  def viewDidLoad
    super

    pageSize = 5 # ページ数
    width = self.view.bounds.size.width
    height = self.view.bounds.size.height

    @pageControl = UIPageControl.alloc.init
    @scrollView = UIScrollView.alloc.init
    @scrollView.frame = self.view.bounds

    # 横スクロールのインジケータを非表示にする
    @scrollView.showsHorizontalScrollIndicator = false

    # ページングを有効にする
    @scrollView.pagingEnabled = true

    @scrollView.userInteractionEnabled = true
    @scrollView.delegate = self

    # スクロールの範囲を指定
    @scrollView.setContentSize(CGSizeMake((pageSize * width), height))

    # スクロールビューを貼り付ける
    self.view.addSubview(@scrollView)

    # スクロールビューにラベルを貼付ける
    i = 0
    while i < pageSize
      label = UILabel.alloc.initWithFrame(CGRectMake(i * width, 0, width, height))
      label.text = (i + 1).to_s
      label.font = UIFont.fontWithName("Arial", size:92)
      label.backgroundColor = UIColor.yellowColor
      label.textAlignment = UITextAlignmentCenter
      @scrollView.addSubview(label)
      i += 1
    end

    # ページコントロールのインスタンス化
    x = (width - 300) / 2
    y = height - 50
    @pageControl = UIPageControl.alloc.initWithFrame(CGRectMake(x, y, 300, 50))

    # 背景色を設定
    @pageControl.backgroundColor = UIColor.blackColor

    # ページ数を設定
    @pageControl.numberOfPages = pageSize

    # 現在のページを設定
    @pageControl.currentPage = 0

    # ページコントロールをタップされたときに呼ばれるメソッドを設定
    @pageControl.userInteractionEnabled = true
    @pageControl.addTarget(self,
                           action:"pageControl_Tapped",
                           forControlEvents:UIControlEventValueChanged)

    # ページコントロールを貼付ける
    self.view.addSubview(@pageControl)
  end

  # スクロールビューがスワイプされたとき
  def scrollViewDidScroll(scrollView)
    pageWidth = scrollView.frame.size.width;
    if (scrollView.contentOffset.x % pageWidth) == 0
      # ページコントロールに現在のページを設定
      @pageControl.currentPage = scrollView.contentOffset.x / pageWidth
    end
  end
  # ページコントロールがタップされたとき
  def pageControl_Tapped(scrollView)
    frame = scrollView.frame
    frame.origin.x = frame.size.width * @pageControl.currentPage
    scrollView.scrollRectToVisible(frame, animated:true)
  end
end
