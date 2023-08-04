Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B89C76FB55
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 09:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjHDHoB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 03:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjHDHoA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 03:44:00 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6582E70;
        Fri,  4 Aug 2023 00:43:57 -0700 (PDT)
X-QQ-mid: bizesmtp81t1691135024tn36g6cq
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 04 Aug 2023 15:43:42 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: W+onFc5Tw4O/6k6LPXFF7TnECbyW8I91QNQffkKagRPrNJwHTEycicRkOeY4B
        CQdQVd6xdU6bqbtWBxMhwALkE4MBcKfDfncxUqm02+B/lDzmcZYe1q5PWweAfy6VvOOPiRM
        jfkSuTmwOShSLZbRTBF8Bu0vGbEoCDq+K9NdaEqdI6+GpECpWRTCI4jGByYJoZb/4coFHG+
        gL6EmNK6UosaFxp9hpvsrSTb/t73QqCBfda+kcuzz1NbfPbrq76M1OJte7jr8fymmGIu1pP
        FYw72b/U48cmdJeL8W0Wgi+ifPrm9Ajp7L8N8/U36jNyL5swdaSR4PVryyjQyP6ZBNCOW8u
        AP2yf6n5sGiia55kAwRPWyBzp4mD7I5bOQRTH69
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9264227934890769926
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org, w@1wt.eu
Subject: Re: [PATCH v1 2/3] selftests/nolibc: fix up O= option support
Date:   Fri,  4 Aug 2023 15:43:42 +0800
Message-Id: <20230804074342.28248-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20b43e63-fcf9-4e36-a983-5ed3211efc7e@t-8ch.de>
References: <20b43e63-fcf9-4e36-a983-5ed3211efc7e@t-8ch.de>
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

Hi, Thomas

> On 2023-08-03 22:45:52+0800, Zhangjin Wu wrote:
> > To avoid pollute the source code tree and avoid mrproper for every
> > architecture switch, the O= argument must be supported.
> > 
> > Both IMAGE and .config are from the building directory, let's use
> > objtree instead of srctree for them.
> > 
> > If no O= option specified, means building kernel in source code tree,
> > objtree should be srctree in such case.
> > 
> > Suggested-by: Willy Tarreau <w@1wt.eu>
> > Link: https://lore.kernel.org/lkml/ZK0AB1OXH1s2xYsh@1wt.eu/
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/testing/selftests/nolibc/Makefile | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > index 51fef5e6a152..af590aee063a 100644
> > --- a/tools/testing/selftests/nolibc/Makefile
> > +++ b/tools/testing/selftests/nolibc/Makefile
> > @@ -9,6 +9,9 @@ ifeq ($(srctree),)
> >  srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))
> >  endif
> >  
> > +# add objtree for O= argument, required by IMAGE and .config
> > +objtree ?= $(srctree)
> 
> Isn't this already set by the included tools/scripts/Makefile.include?
>

Good question, but it is empty if no O= specified, checked it several
times before ;-)

> Also I'm not entirely if O= works as intended currently.
> When using O=foo in the $LINUX/tools/testing/selftests/nolibc directory

It does work, I have used it to test all of the run targets of the
tinyconfig patches like this:

    $ make run O=kernel-$arch RUN_OUT=run.$arch.out ...

Everything about the kernel will be built in $(O).

Just rechecked the O variable in top-level Makefile, selftests/nolibc Makefile
and tools/nolibc Makefile, all of them get the right O value from command line.

From my Makefile experience, an option from command line will be passed
to every sub Makefile via $(-*-command-variables-*-), it has the highest
priority then the others, except when we use 'override' keyword
internally.

> the build instead is happening in $LINUX/foo. But the Makefile first
> validates that $LINUX/tools/testing/selftests/nolibc/foo exists.
>

Sorry, I didn't get your meaning above?

Do you mean this line:

    srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))

by removing tools/testing/selftests/ of curdir's dir (means no nolibc itself),
srctree above is just the top-level kernel source code tree.

> It seems we need to pass $(COMMAND_O) to the recursive calls to $(MAKE),
> too?
>

So, no need to pass O or COMMAND_O.

Thanks,
Zhangjin

> > +
> >  ifeq ($(ARCH),)
> >  include $(srctree)/scripts/subarch.include
> >  ARCH = $(SUBARCH)
> > @@ -217,12 +220,12 @@ kernel: initramfs
> >  
> >  # run the tests after building the kernel
> >  run: kernel
> > -	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> > +	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(objtree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> >  	$(Q)$(REPORT) $(CURDIR)/run.out
> >  
> >  # re-run the tests from an existing kernel
> >  rerun:
> > -	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> > +	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(objtree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> >  	$(Q)$(REPORT) $(CURDIR)/run.out
> >  
> >  # report with existing test log
> > -- 
> > 2.25.1
> > 
