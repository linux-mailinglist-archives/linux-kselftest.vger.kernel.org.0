Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE13F77054A
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 17:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjHDPwz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 11:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjHDPwq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 11:52:46 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3260D4C21;
        Fri,  4 Aug 2023 08:52:38 -0700 (PDT)
X-QQ-mid: bizesmtp83t1691164345te33whu7
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 04 Aug 2023 23:52:23 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: QityeSR92A2WHQhmoeg7K5p+HHxaQw1CAzbcXhBB+k9MHkxF255k+wK2V27sg
        OuRVc4CWgf+AnDmbDSlD24XVMySgqQ03CDw+ZDomb9YVO75v6D3LSlHBbLbh0thUg8RMq51
        evWGOq4hPqHAcKZFGyiUfaKRchAbMyUEaFT+8pd7/IE2UGKuiMVVxYh7Wc5nepDn5P092F7
        vaboTHhKJ5gRvkCZPCfOW4JoPAnLvfPiWOk0HWKn5rPgoACioAfCazLGYYraEvdtix3SqOm
        dWVcBFOXbcN/sPmo10zbPUGvTu60vJ/Y8MTNa6UArGAh4weoifkehMKILv0z37qRBIUb2uq
        oPZNsSHCSy6W4JaAuxEQBn3lcIAq0BEAhw3qtLGMg/fVJe7IMmg/JOpmoCWSA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1441371231323318569
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org, w@1wt.eu
Subject: Re: [PATCH v1 2/3] selftests/nolibc: fix up O= option support
Date:   Fri,  4 Aug 2023 23:52:18 +0800
Message-Id: <20230804155218.293995-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <058a264d-45bd-4f1f-8af3-56ed337b3251@t-8ch.de>
References: <058a264d-45bd-4f1f-8af3-56ed337b3251@t-8ch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On 2023-08-04 15:43:42+0800, Zhangjin Wu wrote:
> > Hi, Thomas
> > 
> > > On 2023-08-03 22:45:52+0800, Zhangjin Wu wrote:
> > > > To avoid pollute the source code tree and avoid mrproper for every
> > > > architecture switch, the O= argument must be supported.
> > > > 
> > > > Both IMAGE and .config are from the building directory, let's use
> > > > objtree instead of srctree for them.
> > > > 
> > > > If no O= option specified, means building kernel in source code tree,
> > > > objtree should be srctree in such case.
> > > > 
> > > > Suggested-by: Willy Tarreau <w@1wt.eu>
> > > > Link: https://lore.kernel.org/lkml/ZK0AB1OXH1s2xYsh@1wt.eu/
> > > > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > > > ---
> > > >  tools/testing/selftests/nolibc/Makefile | 7 +++++--
> > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > > > index 51fef5e6a152..af590aee063a 100644
> > > > --- a/tools/testing/selftests/nolibc/Makefile
> > > > +++ b/tools/testing/selftests/nolibc/Makefile
> > > > @@ -9,6 +9,9 @@ ifeq ($(srctree),)
> > > >  srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))
> > > >  endif
> > > >  
> > > > +# add objtree for O= argument, required by IMAGE and .config
> > > > +objtree ?= $(srctree)
> > > 
> > > Isn't this already set by the included tools/scripts/Makefile.include?
> > >
> > 
> > Good question, but it is empty if no O= specified, checked it several
> > times before ;-)
> 
> For me it is not empty when I am in tools/testing/selftests/nolibc/.
>

Interesting, here is the code I added to check the value:

    diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
    index 22f1e1d73fa8..1ae19e896e24 100644
    --- a/tools/testing/selftests/nolibc/Makefile
    +++ b/tools/testing/selftests/nolibc/Makefile
    @@ -12,6 +12,8 @@ include $(srctree)/scripts/subarch.include
     ARCH = $(SUBARCH)
     endif
    
    +$(error objtree=$(objtree), srctree=$(srctree))
    +

Whenever I do defconfig or run,

    $ make help
    Makefile:15: *** objtree=, srctree=/labs/linux-lab/src/linux-stable.  Stop.

It is only not empty when we pass O explicitly:

    $ mkdir out
    $ make help O=out
    Makefile:15: *** objtree=out, srctree=/labs/linux-lab/src/linux-stable.  Stop.
    $ make help O=$PWD/out
    Makefile:15: *** objtree=/labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/out, srctree=/labs/linux-lab/src/linux-stable.  Stop.

> > > Also I'm not entirely if O= works as intended currently.
> > > When using O=foo in the $LINUX/tools/testing/selftests/nolibc directory
> > 
> > It does work, I have used it to test all of the run targets of the
> > tinyconfig patches like this:
> > 
> >     $ make run O=kernel-$arch RUN_OUT=run.$arch.out ...
> > 
> > Everything about the kernel will be built in $(O).
> 
> It does not work for me:
> 
> $ cd $HOME/src/linux/tools/testing/selftests/nolibc
> $ make O=out kernel
> ../../../scripts/Makefile.include:4: *** O=out does not exist.  Stop.
> $ mkdir out
> $ make O=out kernel
> ... Stuff happens
> ... all the output is in $HOME/src/linux/out not in
>     tools/testing/selftests/nolibc/out where I would expect it.
>     The new out directory for which an error was reported before is
>     completely empty.
>

Oh, yeah, my fault, I have always used the absolute path, but pasted a relative
one above, this is the one I really used for every test:

    $ make run O=$PWD/kernel-$arch RUN_OUT=run.$arch.out ...

> > Just rechecked the O variable in top-level Makefile, selftests/nolibc Makefile
> > and tools/nolibc Makefile, all of them get the right O value from command line.
> 
> But the one from the command line is a relative path. And it seems to be
> resolved from the kernel source tree instead of from where make is
> executed.
>

That's exactly:

    $ make defconfig O=out
    Makefile:15: objtree=out, srctree=/labs/linux-lab/src/linux-stable
    Makefile:114: O=/labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/out

The COMMAND_O suggested by you have prefixed $(PWD) for us, it is the right way
we should apply. Seems I have passed O=something to all kernel targets before,
but that is a little ugly, and when the O=$PWD/out always work for me, I even
forgot to check the simpler O=out again.

And it also works perfectly with $PWD:

    $ make defconfig O=$PWD/out
    Makefile:15: objtree=/labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/out, srctree=/labs/linux-lab/src/linux-stable
    Makefile:114: O=/labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/out

> > From my Makefile experience, an option from command line will be passed
> > to every sub Makefile via $(-*-command-variables-*-), it has the highest
> > priority then the others, except when we use 'override' keyword
> > internally.
> > 
> > > the build instead is happening in $LINUX/foo. But the Makefile first
> > > validates that $LINUX/tools/testing/selftests/nolibc/foo exists.
> > >
> > 
> > Sorry, I didn't get your meaning above?
> > 
> > Do you mean this line:
> > 
> >     srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))
> > 
> > by removing tools/testing/selftests/ of curdir's dir (means no nolibc itself),
> > srctree above is just the top-level kernel source code tree.
> 
> No, srctree should be fine.
> 
> > > It seems we need to pass $(COMMAND_O) to the recursive calls to $(MAKE),
> > > too?
> > >
> > 
> > So, no need to pass O or COMMAND_O.
> 
> As above, it doesn't work for me.
> 
> If I add COMMAND_O to all the $(MAKE) commands that are executed
> explicitly, how it is also done in Makefile.include itself, things start
> to work as I would expect:
> All the kernel build output is in out/ in the current directory.
> 

Ok, let's use it. Thanks very much.

After align the empty objtree value with you, will renew this patch.

Best regards,
Zhangjin
