Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F129A74DB5F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 18:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjGJQqA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 12:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjGJQp7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 12:45:59 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA93F4;
        Mon, 10 Jul 2023 09:45:56 -0700 (PDT)
X-QQ-mid: bizesmtp82t1689007545tbaedb4v
Received: from linux-lab-host.localdomain ( [116.30.126.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 11 Jul 2023 00:45:44 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: Lc4bMlOoZUFbRFKipiqts0TvmsJAMcFxqII+5IdR+oOiXLeiNhln7Mh30GDGA
        tjJBIIKTMmHa9uTxTjXqHzdRPbv0r7b/foWfvRj13r8YfV2jN207PeP8t5P3As/t/d2lVOq
        qgXdZqFDhdX1WVfZJzebVzp/fJt3iTdR6EBQjZdF4JCW2/xQ7gg4ut/3cyeJ1Bust1Z1fY0
        e5sjnXX+csYHdmU66n3qqXtR0fQpYRXcBDgz/KjMAWifUAmY2GdyZejTzH7nUfGW8BpNf3j
        oTAiuhLayvFn0s1SfR7iNqm9cv3UYG3a+G6oXUe93kB3D7uW7MjTPpoKcA7AnFuBi4B44Sv
        TeAp8Dteuy/2hVdoSGwesX+CBo3EA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4750259835239617674
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v2 04/12] tools/nolibc: crt.h: add _start_c
Date:   Tue, 11 Jul 2023 00:45:43 +0800
Message-Id: <20230710164543.6284-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <195a189b-b9d5-45a1-8901-c9bdb52da2f3@t-8ch.de>
References: <195a189b-b9d5-45a1-8901-c9bdb52da2f3@t-8ch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas

> On 2023-07-10 17:26:43+0800, Zhangjin Wu wrote:
> > > On 2023-07-08 23:29:58+0800, Zhangjin Wu wrote:
[...]
> 
> > > It also seems like a good opportunity to add some tests for
> > > argv/environment variable passing.
> > 
> > Yes, and even further, we can do more on auxv, just like musl does in
> > src/env/__libc_start_main.c, not that urgent currently:
> 
> With tests I mean nolibc-test.c to make sure we don't introduce any
> regressions.
> Only some tiny testcases to validate that argv and environ are picked
> up correctly by the startup code on all arches.
>

Thomas, seems we already have some testcases for argv, environ and auxv
currently:

    run_syscall: chmod_argv0 <-- argv[0]
		 chdir_root  <-- chdir(getenv("PWD"))
                 getpagesize <-- getauxval(AT_PAGESZ)
    run_stdlib : getenv_TERM <-- getenv

> > 
[...]
> > >
> > 
> > Ok, welcome to discuss more in this thread:
> > 
> >     https://lore.kernel.org/lkml/20230710072340.10798-1-falcon@tinylab.org/
> > 
> > and let's choose a better method as possible as we can, Just replied Willy to
> > explain more.
> 
> Will do.
> 
> > > > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > > > ---
> > > >  tools/include/nolibc/crt.h | 44 ++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 44 insertions(+)
> > > > 
> > > > diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
> > > > index 221b7c5346ca..b269294e9664 100644
> > > > --- a/tools/include/nolibc/crt.h
> > > > +++ b/tools/include/nolibc/crt.h
> > > > @@ -13,4 +13,48 @@
> > > >  char **environ __attribute__((weak));
> > > 
> > > The old code seems to avoid putting "environ" into the global symbol
> > > namespace. Could this declaration be moved into the function like in
> > > getenv()?
> > >
> > 
> > ok, do you mean just move it to stdlib.h like this? I moved _auxv (used
> > by getauxv()) to stdlib.h too:
> 
> Nevermind, I got confused by the in-function declaration of
> "extern char **environ" inside "getenv()".
> Actually this in-function declaration doesn't do anything and can be
> dropped.
>

Yes. for nolibc application is in one-file style, let's remove it.

> > 
[...]
> > > 
> > > This will lead to conflicting declarations if the users use a different
> > > signature. I'm not (yet?) sure how to work around this.
> > >
> > 
> > Ah yes, I forgot this critical case, people may use something like:
> > 
> >     int main(void)
> >     int main(int argc, char *argv[])
> 
> > [..]
> 
> I thought about this general problem and it turns out that there is
> nothing that any libc can do to distinguish these special cases.
> So it has to be handled in the compiler and we do not have to care.

Ok.

Thanks,
Zhangjin

> 
> Thomas
