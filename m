Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249B7761CCE
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 17:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjGYPBm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 11:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjGYPBQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 11:01:16 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938951FC9;
        Tue, 25 Jul 2023 08:00:09 -0700 (PDT)
X-QQ-mid: bizesmtp84t1690297197tmjecvk6
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 25 Jul 2023 22:59:56 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: 3M0okmaRx3iangUTIDbCNJ438ntzVhib54bv4UnU6C6+yatFS1ltpib1xaSrb
        hwEiC4EWQ7COfScGfT4jMkeXrgyjmIGGQCVeCateaUPHvEh1nM26kWCMLD0NFqNOGgSEs+w
        dl99O5meQWjVQxpFuv27/cB2q/QhBvl7IIzkVAB0nFMPHs1PqDixoXC+2qJ6eCIsNjQLqrq
        rxMInWyY1l7cx3ns/83x9w541AaMF4ltH99MmL4qszbYcSLuy/kiiJZSJ1EQBXi1ElFDWkT
        P2YajB87+QUWKwxrJase8s1624cZ8/S8e3HON/SX85kdK24UL7NsCz7AwxfkqI2rtz5Ekds
        O5WiXrqJ0P3BW5oDk+ZnqgpgrQQruGqMfVmWRIUgBPfgGVuvK6j0ip51InyWxCZgI1e9KIl
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14432237341619812258
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 09/14] selftests/nolibc: allow quit qemu-system when poweroff fails
Date:   Tue, 25 Jul 2023 22:59:55 +0800
Message-Id: <20230725145955.37685-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230722130248.GK17311@1wt.eu>
References: <20230722130248.GK17311@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> On Wed, Jul 19, 2023 at 09:27:08PM +0800, Zhangjin Wu wrote:
> > The kernel of some architectures can not poweroff qemu-system normally,
> > especially for tinyconfig.
> > 
> > Some architectures may have no kernel poweroff support, the others may
> > require more kernel config options and therefore slow down the
> > tinyconfig build and test. and also, it's very hard (and some even not
> > possible) to find out the exact poweroff related kernel config options
> > for every architecture.
> > 
> > Since the low-level poweroff support is heavily kernel & qemu dependent,
> > it is not that critical to both nolibc and nolibc-test, let's simply
> > ignore the poweroff required kernel config options for tinyconfig (and
> > even for defconfig) and quit qemu-system after a specified timeout or
> > with an expected system halt or poweroff string (these strings mean our
> > reboot() library routine is perfectly ok).
> > 
> > QEMU_TIMEOUT value can be configured for every architecture based on
> > their time cost requirement of boot+test+poweroff.
> > 
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/testing/selftests/nolibc/Makefile | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > index 541f3565e584..a03fab020ebe 100644
> > --- a/tools/testing/selftests/nolibc/Makefile
> > +++ b/tools/testing/selftests/nolibc/Makefile
> > @@ -93,6 +93,9 @@ QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1
> >  QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
> >  QEMU_ARGS            = $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_EXTRA)
> >  
> > +# QEMU_TIMEOUT: some architectures can not poweroff normally, especially for tinyconfig
> > +QEMU_TIMEOUT             = $(QEMU_TIMEOUT_$(XARCH))
> > +
> >  # OUTPUT is only set when run from the main makefile, otherwise
> >  # it defaults to this nolibc directory.
> >  OUTPUT ?= $(CURDIR)/
> > @@ -224,16 +227,32 @@ kernel: extconfig
> >  # common macros for qemu run/rerun targets
> >  QEMU_SYSTEM_RUN = qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(KERNEL_IMAGE)" -serial stdio $(QEMU_ARGS)
> >  
> > +ifneq ($(QEMU_TIMEOUT),)
> > +TIMEOUT_CMD = t=$(QEMU_TIMEOUT); \
> > +	while [ $$t -gt 0 ]; do                                                       \
> > +	    sleep 5; t=$$(expr $$t - 5); echo "detecting power off ...";              \
> > +	    if grep -qE "reboot: System halted|reboot: Power down" "$(RUN_OUT)"; then \
> > +		pkill -9 qemu-system-$(QEMU_ARCH);                                    \
> > +		echo "powered off, test finish"; t=1; break;                          \
> > +	    fi;                                                                       \
> > +	done;                                                                         \
> > +	if [ $$t -le 0 ]; then pkill -9 qemu-system-$(QEMU_ARCH); echo "qemu-system-$(QEMU_ARCH) timeout"; fi
> 
> Please have a look at the "timeout" command whichi makes all this much
> simpler.

Yeah, I used 'timeout --forgeground' before, but it is still a dead wait
and it is very hard for us to configure a just right wait time.

If the configured wait time is short, the qemu will be killed during the
test or before running the test, If the configured wait time is long, we
will need to dead wait there even if the test is finished, although
during interactive running, we can press 'CTRL + A X', but for
background running, it is just time waste.

To fix up this issue, the above method used at last allow to detect the
output string, when the test finish and print something lines like:

    reboot: System halted
    reboot: Power down.

We will use pkill to send signal to tell qemu quit, so, it is ok for us
to configure a even'big' timeout, if the kernel can normally poweroff or
if nolibc can successfully send the poweroff syscall, the above message
will be detected and qemu will quit as expected, it will completely
avoid dead wait, the configured timeout will never happen, this is
comfortable.

The worst case is only when qemu or kernel reject to boot, for example,
a qemu bios missing or mismatch issue or a kernel regression or a wrong
kernel config option, for these cases, the real timeout logic will work
for us.

As a summary, our timeout logic here include two parts: one is
'poweroff' related string detection, another is the real timeout logic. 

Based on current implementation, I even plan to add the test finish
string in the expected strings:

    Leaving init with final status

And even further, when a hang detected (no normal poweroff or test
finish string detected), print the whole or last part of running log to
tell users what happens.

> Also, please get used to never ever use kill -9 first. This
> is exactly the way to leave temporary files and IPCs wandering around
> while many programs that care about cleanups at least try to do that
> upon a regular TERM or INT signal.
>

Ok, thanks, will use TERM or INT signal instead.

> Willy
