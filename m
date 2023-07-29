Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51422767D0E
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 10:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjG2IE3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 04:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjG2IE2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 04:04:28 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A41E93C30;
        Sat, 29 Jul 2023 01:04:26 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36T84ILs004323;
        Sat, 29 Jul 2023 10:04:18 +0200
Date:   Sat, 29 Jul 2023 10:04:18 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 09/14] selftests/nolibc: allow quit qemu-system when
 poweroff fails
Message-ID: <20230729080418.GJ956@1wt.eu>
References: <20230722130248.GK17311@1wt.eu>
 <20230725145955.37685-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725145955.37685-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 25, 2023 at 10:59:55PM +0800, Zhangjin Wu wrote:
> > On Wed, Jul 19, 2023 at 09:27:08PM +0800, Zhangjin Wu wrote:
> > > The kernel of some architectures can not poweroff qemu-system normally,
> > > especially for tinyconfig.
> > > 
> > > Some architectures may have no kernel poweroff support, the others may
> > > require more kernel config options and therefore slow down the
> > > tinyconfig build and test. and also, it's very hard (and some even not
> > > possible) to find out the exact poweroff related kernel config options
> > > for every architecture.
> > > 
> > > Since the low-level poweroff support is heavily kernel & qemu dependent,
> > > it is not that critical to both nolibc and nolibc-test, let's simply
> > > ignore the poweroff required kernel config options for tinyconfig (and
> > > even for defconfig) and quit qemu-system after a specified timeout or
> > > with an expected system halt or poweroff string (these strings mean our
> > > reboot() library routine is perfectly ok).
> > > 
> > > QEMU_TIMEOUT value can be configured for every architecture based on
> > > their time cost requirement of boot+test+poweroff.
> > > 
> > > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > > ---
> > >  tools/testing/selftests/nolibc/Makefile | 23 +++++++++++++++++++++--
> > >  1 file changed, 21 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > > index 541f3565e584..a03fab020ebe 100644
> > > --- a/tools/testing/selftests/nolibc/Makefile
> > > +++ b/tools/testing/selftests/nolibc/Makefile
> > > @@ -93,6 +93,9 @@ QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1
> > >  QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
> > >  QEMU_ARGS            = $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_EXTRA)
> > >  
> > > +# QEMU_TIMEOUT: some architectures can not poweroff normally, especially for tinyconfig
> > > +QEMU_TIMEOUT             = $(QEMU_TIMEOUT_$(XARCH))
> > > +
> > >  # OUTPUT is only set when run from the main makefile, otherwise
> > >  # it defaults to this nolibc directory.
> > >  OUTPUT ?= $(CURDIR)/
> > > @@ -224,16 +227,32 @@ kernel: extconfig
> > >  # common macros for qemu run/rerun targets
> > >  QEMU_SYSTEM_RUN = qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(KERNEL_IMAGE)" -serial stdio $(QEMU_ARGS)
> > >  
> > > +ifneq ($(QEMU_TIMEOUT),)
> > > +TIMEOUT_CMD = t=$(QEMU_TIMEOUT); \
> > > +	while [ $$t -gt 0 ]; do                                                       \
> > > +	    sleep 5; t=$$(expr $$t - 5); echo "detecting power off ...";              \
> > > +	    if grep -qE "reboot: System halted|reboot: Power down" "$(RUN_OUT)"; then \
> > > +		pkill -9 qemu-system-$(QEMU_ARCH);                                    \
> > > +		echo "powered off, test finish"; t=1; break;                          \
> > > +	    fi;                                                                       \
> > > +	done;                                                                         \
> > > +	if [ $$t -le 0 ]; then pkill -9 qemu-system-$(QEMU_ARCH); echo "qemu-system-$(QEMU_ARCH) timeout"; fi
> > 
> > Please have a look at the "timeout" command whichi makes all this much
> > simpler.
> 
> Yeah, I used 'timeout --forgeground' before, but it is still a dead wait
> and it is very hard for us to configure a just right wait time.
> 
> If the configured wait time is short, the qemu will be killed during the
> test or before running the test, If the configured wait time is long, we
> will need to dead wait there even if the test is finished, although
> during interactive running, we can press 'CTRL + A X', but for
> background running, it is just time waste.
> 
> To fix up this issue, the above method used at last allow to detect the
> output string, when the test finish and print something lines like:
> 
>     reboot: System halted
>     reboot: Power down.
> 
> We will use pkill to send signal to tell qemu quit, so, it is ok for us
> to configure a even'big' timeout, if the kernel can normally poweroff or
> if nolibc can successfully send the poweroff syscall, the above message
> will be detected and qemu will quit as expected, it will completely
> avoid dead wait, the configured timeout will never happen, this is
> comfortable.
> 
> The worst case is only when qemu or kernel reject to boot, for example,
> a qemu bios missing or mismatch issue or a kernel regression or a wrong
> kernel config option, for these cases, the real timeout logic will work
> for us.
> 
> As a summary, our timeout logic here include two parts: one is
> 'poweroff' related string detection, another is the real timeout logic. 
> 
> Based on current implementation, I even plan to add the test finish
> string in the expected strings:
> 
>     Leaving init with final status
> 
> And even further, when a hang detected (no normal poweroff or test
> finish string detected), print the whole or last part of running log to
> tell users what happens.

Again, all of this seems ridiculously complicated for what seems to be
a very unlikely issue. You mentioned earlier:

  > > > The kernel of some architectures can not poweroff qemu-system
  > > > normally, especially for tinyconfig.

Till now all those I tested do power off correctly. So if the problem
is related to one specific arch, first it should be mentioned in the
commit message, and maybe we need to look closer why it's doing that
instead of papering over it, and if it's caused by tinyconfig, it just
means we need to produce a more reasonable config. But I still don't
like the idea of causing a problem on one side, and making the other
side totally ugly just because of the problem. The timeout solution
should be a last resort one which clearly explains why we can't do
differently.

Also, defconfig and tinyconfig are for people who work on nolibc. These
ones should support working in batch mode, being called from a script
iterating over multiple archs. For other config, we should not interfer
with what the user does. Maybe some will consider that it's fine to run
a test slowly on a simulated platform for example.

Willy
