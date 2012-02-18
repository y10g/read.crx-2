module "Thread::get",
  setup: ->
    @ch_url = "http://__mockjax.2ch.net/test/read.cgi/dummy/200/"
    @ch_dat = """
    ﾉtasukeruyo </b>忍法帖【Lv=10,xxxPT】<b> </b>◆0a./bc.def <b><><>2011/04/04(月) 10:19:46.92 ID:abcdEfGH0 BE:1234567890-2BP(1)<> テスト。 <br> http://qb5.2ch.net/test/read.cgi/operate/132452341234/1 <br> <hr><font color="blue">Monazilla/1.00 (V2C/2.5.1)</font> <>[test] テスト 123 [ﾃｽﾄ]
     </b>【東電 84.2 %】<b>  </b>◆0a./bc.def <b><>sage<>2011/04/04(月) 10:21:08.27 ID:abcdEfGH0<> てすとてすとテスト! <>
     </b>忍法帖【Lv=11,xxxPT】<b> <>sage<>2011/04/04(月) 10:24:46.33 ID:abc0DEFG1<> <a href="../test/read.cgi/operate/1234567890/1" target="_blank">&gt&gt1</a> <br> 乙 <br> てすとてすと試験てすと <>
    動け動けウゴウゴ２ちゃんねる<>sage<>2011/04/04(月) 10:25:17.27 ID:ABcdefgh0<> てすと、テスト <>
    動け動けウゴウゴ２ちゃんねる<><>2011/04/04(月) 10:25:51.88 ID:aBcdEfg+0<> てす <>

    """
    @ch_expected =
      title: "[test] テスト 123 [ﾃｽﾄ]"
      res: [
        {
          name: "ﾉtasukeruyo </b>忍法帖【Lv=10,xxxPT】<b> </b>◆0a./bc.def <b>"
          mail: ""
          message: ' テスト。 <br> http://qb5.2ch.net/test/read.cgi/operate/132452341234/1 <br> <hr><font color="blue">Monazilla/1.00 (V2C/2.5.1)</font> '
          other: "2011/04/04(月) 10:19:46.92 ID:abcdEfGH0 BE:1234567890-2BP(1)"
        }
        {
          name: " </b>【東電 84.2 %】<b>  </b>◆0a./bc.def <b>"
          mail: "sage"
          message: " てすとてすとテスト! "
          other: "2011/04/04(月) 10:21:08.27 ID:abcdEfGH0"
        }
        {
          name: " </b>忍法帖【Lv=11,xxxPT】<b> "
          mail: "sage"
          message: ' <a href="../test/read.cgi/operate/1234567890/1" target="_blank">&gt&gt1</a> <br> 乙 <br> てすとてすと試験てすと '
          other: "2011/04/04(月) 10:24:46.33 ID:abc0DEFG1"
        }
        {
          name: "動け動けウゴウゴ２ちゃんねる"
          mail: "sage"
          message: " てすと、テスト "
          other: "2011/04/04(月) 10:25:17.27 ID:ABcdefgh0"
        }
        {
          name: "動け動けウゴウゴ２ちゃんねる"
          mail: ""
          message: " てす "
          other: "2011/04/04(月) 10:25:51.88 ID:aBcdEfg+0"
        }
      ]

    @ch_broken_url = "http://__mockjax.2ch.net/test/read.cgi/dummy/3526345446225/"
    @ch_broken_dat = """
      偽*** ★<><>2011/10/21(金) 19:26:30.52 ID:???<> てすと　試験テスト <>***を追跡する #dummy
      </b> dummy <b><><>11/10/21(金) 20:49:40 ID:ehenfox<>62¥¥¥
      ぬふあ <br> <>twitter
      ***<><>2011/10/21(金) 20:50:00.66 ID:abcDeFgh<> よ <>
    """
    @ch_broken_expected =
      title: "***を追跡する #dummy"
      res: [
        {
          name: "偽*** ★"
          mail: ""
          message: " てすと　試験テスト "
          other: "2011/10/21(金) 19:26:30.52 ID:???"
        }
        {
          name: "</b>データ破損<b>"
          mail: ""
          message: "データが破損しています"
          other: ""
        }
        {
          name: "</b>データ破損<b>"
          mail: ""
          message: "データが破損しています"
          other: ""
        }
        {
          name: "***"
          mail: ""
          message: " よ "
          other: "2011/10/21(金) 20:50:00.66 ID:abcDeFgh"
        }
      ]

    @machi_url = "http://__mockjax.machi.to/bbs/read.cgi/dummy/511234524356/"
    @machi_dat = """
      1<>まちこさん<><>2007/06/10(日) 09:20:35 ID:aBC.DeFG<>テストテストテスト。<br><br>sage推奨<>【test】色々testスレ（トリップテストとか）【テスト】　７題目
      2<>◆</b>1a2BC3DeFg<b><><>2007/06/11(月) 22:33:18 ID:Ab0cdeFG<>あ　い　う　え　tesu<>
      5<>◆</b>abcd.EfGHI<b><>sage<>2007/06/13(水) 14:49:19 ID:aBcdEfgH<>あ　い　う　え　tesu３<>
    """
    @machi_expected =
      title: "【test】色々testスレ（トリップテストとか）【テスト】　７題目"
      res: [
        {
          name: "まちこさん"
          mail: ""
          message: "テストテストテスト。<br><br>sage推奨"
          other: "2007/06/10(日) 09:20:35 ID:aBC.DeFG"
        }
        {
          name: "◆</b>1a2BC3DeFg<b>"
          mail: ""
          message: "あ　い　う　え　tesu"
          other: "2007/06/11(月) 22:33:18 ID:Ab0cdeFG"
        }
        {
          name: "あぼーん"
          mail: "あぼーん"
          message: "あぼーん"
          other: "あぼーん"
        }
        {
          name: "あぼーん"
          mail: "あぼーん"
          message: "あぼーん"
          other: "あぼーん"
        }
        {
          name: "◆</b>abcd.EfGHI<b>"
          mail: "sage"
          message: "あ　い　う　え　tesu３"
          other: "2007/06/13(水) 14:49:19 ID:aBcdEfgH"
        }
      ]

    @jbbs_url = "http://jbbs.livedoor.jp/bbs/read.cgi/__mockjax/42710/1290070091/"
    @jbbs_dat = """
      1<><font color=#FF0000>awef★</font><><>2010/11/18(木) 17:48:11<>read.crxについての質問・要望・不具合報告等を気楽に書き込んで下さい<br><br>インストールはこちらから<br>ttps://chrome.google.com/extensions/detail/hhjpdicibjffnpggdiecaimdgdghainl<br>関連文章<br>ttp://wiki.livedoor.jp/awef/d/read.crx<br>UserVoice<br>ttp://readcrx.uservoice.com/<br>前スレ<br>ttp://jbbs.livedoor.jp/bbs/read.cgi/computer/42710/1273802908/<br><br>既出の要望・バグ等は全てUserVoiceで管理します<br>直接UserVoiceに投稿しちゃっても構いません<>read.crx総合 part2<>???
      2<>名無しさん<><>2010/12/03(金) 02:50:42<>試験用削除<><>ABCD0eFg
      5<>名無しさん<>sage<>2010/12/04(土) 22:57:40<><a href="/bbs/read.cgi/computer/42710/1290070091/2" target="_blank">&gt&gt2</a><br>少なくとも、今のブックマーク表示は、他の板とそれ程区別する必要は無いと思ってます<br><br><a href="/bbs/read.cgi/computer/42710/1290070091/4" target="_blank">&gt&gt4</a><br>サッとプロトコル見てみましたけど、多分無理っすね<br>こちら側も鯖立てないとムリっぽいし<><>.aBCefGh
    """
    @jbbs_expected =
      title: "read.crx総合 part2"
      res: [
        {
          name: "<font color=#FF0000>awef★</font>"
          mail: ""
          message: "read.crxについての質問・要望・不具合報告等を気楽に書き込んで下さい<br><br>インストールはこちらから<br>ttps://chrome.google.com/extensions/detail/hhjpdicibjffnpggdiecaimdgdghainl<br>関連文章<br>ttp://wiki.livedoor.jp/awef/d/read.crx<br>UserVoice<br>ttp://readcrx.uservoice.com/<br>前スレ<br>ttp://jbbs.livedoor.jp/bbs/read.cgi/computer/42710/1273802908/<br><br>既出の要望・バグ等は全てUserVoiceで管理します<br>直接UserVoiceに投稿しちゃっても構いません"
          other: "2010/11/18(木) 17:48:11 ID:???"
        }
        {
          name: "名無しさん"
          mail: ""
          message: "試験用削除"
          other: "2010/12/03(金) 02:50:42 ID:ABCD0eFg"
        }
        {
          name: "あぼーん"
          mail: "あぼーん"
          message: "あぼーん"
          other: "あぼーん"
        }
        {
          name: "あぼーん"
          mail: "あぼーん"
          message: "あぼーん"
          other: "あぼーん"
        }
        {
          name: "名無しさん"
          mail: "sage"
          message: '<a href="/bbs/read.cgi/computer/42710/1290070091/2" target="_blank">&gt&gt2</a><br>少なくとも、今のブックマーク表示は、他の板とそれ程区別する必要は無いと思ってます<br><br><a href="/bbs/read.cgi/computer/42710/1290070091/4" target="_blank">&gt&gt4</a><br>サッとプロトコル見てみましたけど、多分無理っすね<br>こちら側も鯖立てないとムリっぽいし'
          other: "2010/12/04(土) 22:57:40 ID:.aBCefGh"
        }
      ]

    @jbbs_deleted_url = "http://jbbs.livedoor.jp/bbs/read.cgi/__mockjax/42710/1310968239/"
    @jbbs_deleted_dat = """
      1<><font color=#FF0000>awef★</font><><>2011/07/18(月) 14:50:39<>テスト<>削除レスとかの動作を確認するためのスレ<>???
      2<><font color=#FF0000>awef★</font><><>2011/07/18(月) 14:51:47<>テスト2<><>???
      3<>＜削除＞<>＜削除＞<>＜削除＞<>＜削除＞<><>
      4<><font color=#FF0000>awef★</font><><>2011/07/18(月) 14:53:07<><a href="/bbs/read.cgi/computer/42710/1310968239/3" target="_blank">&gt;&gt;3</a><br>削除<><>???
      6<><font color=#FF0000>awef★</font><><>2011/07/18(月) 14:54:08<><a href="/bbs/read.cgi/computer/42710/1310968239/5" target="_blank">&gt;&gt;5</a><br>透明削除<><>???
      7<><font color=#FF0000>awef★</font><><>2011/07/18(月) 14:55:04<><a href="/bbs/read.cgi/computer/42710/1310968239/8" target="_blank">&gt;&gt;8</a>, 9<br>透明削除<><>???
    """
    @jbbs_deleted_expected =
      title: "削除レスとかの動作を確認するためのスレ"
      res: [
        {
          name: "<font color=#FF0000>awef★</font>"
          mail: ""
          message: "テスト"
          other: "2011/07/18(月) 14:50:39 ID:???"
        }
        {
          name: "<font color=#FF0000>awef★</font>"
          mail: ""
          message: "テスト2"
          other: "2011/07/18(月) 14:51:47 ID:???"
        }
        {
          name: "＜削除＞"
          mail: "＜削除＞"
          message: "＜削除＞"
          other: "＜削除＞"
        }
        {
          name: "<font color=#FF0000>awef★</font>"
          mail: ""
          message: '<a href="/bbs/read.cgi/computer/42710/1310968239/3" target="_blank">&gt;&gt;3</a><br>削除'
          other: "2011/07/18(月) 14:53:07 ID:???"
        }
        {
          name: "あぼーん"
          mail: "あぼーん"
          message: "あぼーん"
          other: "あぼーん"
        }
        {
          name: "<font color=#FF0000>awef★</font>"
          mail: ""
          message: '<a href="/bbs/read.cgi/computer/42710/1310968239/5" target="_blank">&gt;&gt;5</a><br>透明削除'
          other: "2011/07/18(月) 14:54:08 ID:???"
        }
        {
          name: "<font color=#FF0000>awef★</font>"
          mail: ""
          message: '<a href="/bbs/read.cgi/computer/42710/1310968239/8" target="_blank">&gt;&gt;8</a>, 9<br>透明削除'
          other: "2011/07/18(月) 14:55:04 ID:???"
        }
      ]

    @pink_url = "http://__mockjax.bbspink.com/test/read.cgi/erobbs/23455435345543/"
    @pink_dat = """
      名無し編集部員<><>2008/03/22(土) 03:34:04 ID:aBcD0Ef1<> てすとてすとてすと <>レス削除練習用のスレ
      うふ～ん<>うふ～ん<>うふ～ん ID:DELETED<>うふ～ん<>うふ～ん<>
       </b>◆ABC/1/DEF. <b><><>2008/03/22(土) 03:53:57 ID:aB+C0Def<> てすと <>
    """
    @pink_expected =
      title: "レス削除練習用のスレ"
      res: [
        {
          name: "名無し編集部員"
          mail: ""
          message: " てすとてすとてすと "
          other: "2008/03/22(土) 03:34:04 ID:aBcD0Ef1"
        }
        {
          name: "うふ～ん"
          mail: "うふ～ん"
          message: "うふ～ん"
          other: "うふ～ん ID:DELETED"
        }
        {
          name: " </b>◆ABC/1/DEF. <b>"
          mail: ""
          message: " てすと "
          other: "2008/03/22(土) 03:53:57 ID:aB+C0Def"
        }
      ]
    return

  teardown: $.mockjaxClear

asyncTest "2chのスレを取得出来る", 3, ->
  $.mockjax
    url: ///^http://__mockjax\.2ch\.net/dummy/dat/200\.dat///
    status: 200
    responseText: @ch_dat
    response: ->
      ok(true)
      return

  app.module null, ["thread"], (Thread) =>
    thread = new Thread(@ch_url)
    thread.get().done =>
      strictEqual(thread.title, @ch_expected.title)
      deepEqual(thread.res, @ch_expected.res)
      start()
      return
  return

asyncTest "404時はrejectする", 4, ->
  $.mockjax
    url: ///^http://__mockjax\.2ch\.net/dummy/dat/404\.dat///
    status: 404
    response: ->
      ok(true)
      return

  #DAT取得失敗時、鯖移転の検出処理が走る
  $.mockjax
    url: ///^http://__mockjax\.2ch\.net/dummy/ ///
    response: ->
      ok(true)
      return

  app.module null, ["thread"], (Thread) =>
    thread = new Thread("http://__mockjax.2ch.net/test/read.cgi/dummy/404/")
    thread.get().fail =>
      strictEqual(thread.title, null)
      deepEqual(thread.res, null)
      start()
      return
  return

asyncTest "2chのDATの破損部分は、破損メッセージで代替する", 3, ->
  $.mockjax
    url: ///^http://__mockjax\.2ch\.net/dummy/dat/3526345446225\.dat///
    status: 200
    responseText: @ch_broken_dat
    response: ->
      ok(true)
      return

  app.module null, ["cache", "thread"], (Cache, Thread) =>
    new Cache("http://__mockjax.2ch.net/dummy/dat/3526345446225.dat").delete().done =>
      thread = new Thread(@ch_broken_url)
      thread.get().done =>
        strictEqual(thread.title, @ch_broken_expected.title)
        deepEqual(thread.res, @ch_broken_expected.res)
        start()
        return
      return
  return

asyncTest "まちBBSのスレを取得出来る", 3, ->
  $.mockjax
    url: ///^http://__mockjax\.machi\.to/bbs/offlaw\.cgi/dummy/511234524356///
    status: 200
    responseText: @machi_dat
    response: ->
      ok(true)
      return

  app.module null, ["cache", "thread"], (Cache, Thread) =>
    new Cache("http://__mockjax.machi.to/bbs/offlaw.cgi/dummy/511234524356/").delete().done =>
      thread = new Thread(@machi_url)
      thread.get().done =>
        strictEqual(thread.title, @machi_expected.title)
        deepEqual(thread.res, @machi_expected.res)
        start()
        return
      return
  return

asyncTest "したらばのスレを取得出来る", 3, ->
  $.mockjax
    url: ///^http://jbbs\.livedoor\.jp/bbs/rawmode\.cgi/__mockjax/42710/1290070091///
    status: 200
    responseText: @jbbs_dat
    response: ->
      ok(true)
      return

  app.module null, ["cache", "thread"], (Cache, Thread) =>
    new Cache("http://jbbs.livedoor.jp/bbs/rawmode.cgi/__mockjax/42710/1290070091/").delete().done =>
      thread = new Thread(@jbbs_url)
      thread.get().done =>
        strictEqual(thread.title, @jbbs_expected.title)
        deepEqual(thread.res, @jbbs_expected.res)
        start()
        return
      return
  return

asyncTest "したらばのスレを取得出来る(削除系確認)", 3, ->
  $.mockjax
    url: ///^http://jbbs\.livedoor\.jp/bbs/rawmode\.cgi/__mockjax/42710/1310968239///
    status: 200
    responseText: @jbbs_deleted_dat
    response: ->
      ok(true)
      return

  app.module null, ["cache", "thread"], (Cache, Thread) =>
    new Cache("http://jbbs.livedoor.jp/bbs/rawmode.cgi/__mockjax/42710/1310968239/").delete().done =>
      thread = new Thread(@jbbs_deleted_url)
      thread.get().done =>
        strictEqual(thread.title, @jbbs_deleted_expected.title)
        deepEqual(thread.res, @jbbs_deleted_expected.res)
        start()
        return
      return
  return

asyncTest "BBSPINKのスレをパース出来る", 3, ->
  $.mockjax
    url: ///^http://__mockjax\.bbspink\.com/erobbs/dat/23455435345543\.dat///
    status: 200
    responseText: @pink_dat
    response: ->
      ok(true)
      return

  app.module null, ["thread"], (Thread) =>
    thread = new Thread(@pink_url)
    thread.get().done =>
      strictEqual(thread.title, @pink_expected.title)
      deepEqual(thread.res, @pink_expected.res)
      start()
      return
  return