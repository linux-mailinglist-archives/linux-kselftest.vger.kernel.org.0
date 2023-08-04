Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969717703E1
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 17:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjHDPFO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 11:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjHDPFN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 11:05:13 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0278CAC;
        Fri,  4 Aug 2023 08:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1691161506; bh=jwRDFSplB+qoEdGFLdvGwfxrXzcFjgoaGwpHXscjPt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LOk3onHcKvjldcauMFL5KN6ZBy08BVfAa6/0RzEIXqHlRC2n+OE+DBY8nJy3t5oLH
         R52dWnjUcNUFESjhzY2oVKyZneom3kK5D6Yp71Sgpu8sM1zsh0BB4EvRz8dgCBZ3zA
         o+HSftd1/M1Ca6PPDQXoo06ULiKQ56/+N0DbiVLw=
Date:   Fri, 4 Aug 2023 17:05:06 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org, w@1wt.eu
Subject: Re: [PATCH v1 2/3] selftests/nolibc: fix up O= option support
Message-ID: <058a264d-45bd-4f1f-8af3-56ed337b3251@t-8ch.de>
References: <20b43e63-fcf9-4e36-a983-5ed3211efc7e@t-8ch.de>
 <20230804074342.28248-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804074342.28248-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-08-04 15:43:42+0800, Zhangjin Wu wrote:
> Hi, Thomas
> 
> > On 2023-08-03 22:45:52+0800, Zhangjin Wu wrote:
> > > To avoid pollute the source code tree and avoid mrproper for every
> > > architecture switch, the O= argument must be supported.
> > > 
> > > Both IMAGE and .config are from the building directory, let's use
> > > objtree instead of srctree for them.
> > > 
> > > If no O= option specified, means building kernel in source code tree,
> > > objtree should be srctree in such case.
> > > 
> > > Suggested-by: Willy Tarreau <w@1wt.eu>
> > > Link: https://lore.kernel.org/lkml/ZK0AB1OXH1s2xYsh@1wt.eu/
> > > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > > ---
> > >  tools/testing/selftests/nolibc/Makefile | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > > index 51fef5e6a152..af590aee063a 100644
> > > --- a/tools/testing/selftests/nolibc/Makefile
> > > +++ b/tools/testing/selftests/nolibc/Makefile
> > > @@ -9,6 +9,9 @@ ifeq ($(srctree),)
> > >  srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))
> > >  endif
> > >  
> > > +# add objtree for O= argument, required by IMAGE and .config
> > > +objtree ?= $(srctree)
> > 
> > Isn't this already set by the included tools/scripts/Makefile.include?
> >
> 
> Good question, but it is empty if no O= specified, checked it several
> times before ;-)

For me it is not empty when I am in tools/testing/selftests/nolibc/.

> > Also I'm not entirely if O= works as intended currently.
> > When using O=foo in the $LINUX/tools/testing/selftests/nolibc directory
> 
> It does work, I have used it to test all of the run targets of the
> tinyconfig patches like this:
> 
>     $ make run O=kernel-$arch RUN_OUT=run.$arch.out ...
> 
> Everything about the kernel will be built in $(O).

It does not work for me:

$ cd $HOME/src/linux/tools/testing/selftests/nolibc
$ make O=out kernel
../../../scripts/Makefile.include:4: *** O=out does not exist.  Stop.
$ mkdir out
$ make O=out kernel
... Stuff happens
... all the output is in $HOME/src/linux/out not in
    tools/testing/selftests/nolibc/out where I would expect it.
    The new out directory for which an error was reported before is
    completely empty.

> Just rechecked the O variable in top-level Makefile, selftests/nolibc Makefile
> and tools/nolibc Makefile, all of them get the right O value from command line.

But the one from the command line is a relative path. And it seems to be
resolved from the kernel source tree instead of from where make is
executed.

> From my Makefile experience, an option from command line will be passed
> to every sub Makefile via $(-*-command-variables-*-), it has the highest
> priority then the others, except when we use 'override' keyword
> internally.
> 
> > the build instead is happening in $LINUX/foo. But the Makefile first
> > validates that $LINUX/tools/testing/selftests/nolibc/foo exists.
> >
> 
> Sorry, I didn't get your meaning above?
> 
> Do you mean this line:
> 
>     srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))
> 
> by removing tools/testing/selftests/ of curdir's dir (means no nolibc itself),
> srctree above is just the top-level kernel source code tree.

No, srctree should be fine.

> > It seems we need to pass $(COMMAND_O) to the recursive calls to $(MAKE),
> > too?
> >
> 
> So, no need to pass O or COMMAND_O.

As above, it doesn't work for me.

If I add COMMAND_O to all the $(MAKE) commands that are executed
explicitly, how it is also done in Makefile.include itself, things start
to work as I would expect:
All the kernel build output is in out/ in the current directory.

> Thanks,
> Zhangjin
> 
> > > +
> > >  ifeq ($(ARCH),)
> > >  include $(srctree)/scripts/subarch.include
> > >  ARCH = $(SUBARCH)
> > > @@ -217,12 +220,12 @@ kernel: initramfs
> > >  
> > >  # run the tests after building the kernel
> > >  run: kernel
> > > -	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> > > +	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(objtree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> > >  	$(Q)$(REPORT) $(CURDIR)/run.out
> > >  
> > >  # re-run the tests from an existing kernel
> > >  rerun:
> > > -	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> > > +	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(objtree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> > >  	$(Q)$(REPORT) $(CURDIR)/run.out
> > >  
> > >  # report with existing test log
> > > -- 
> > > 2.25.1
> > > 
