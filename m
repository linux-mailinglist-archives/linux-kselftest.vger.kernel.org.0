Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A323D767EFB
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 14:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjG2MFU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 08:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjG2MFT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 08:05:19 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7819A2681;
        Sat, 29 Jul 2023 05:05:16 -0700 (PDT)
X-QQ-mid: bizesmtp75t1690632305tpfow7ca
Received: from linux-lab-host.localdomain ( [61.141.77.223])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 29 Jul 2023 20:05:04 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: ZkxZBO9qcf5TzSamM3iLzcIMmI8nzZ+P8ApbE6JgxgKC0gTgL+L4tvN+rOxxG
        XW8zRduJjhDXEBMtJ9jDUZ/fkuOtr7EjS7kAAPLQ9hFholaQZjJpYYYk2cTg6uuy9qLRVEd
        +wA3A/LO5DD+vjMLYZH6smiFaP0M6uac0InYKXA8IoMCzQAFKHJI3qxSAsJI8FSoPX1VIAj
        7WzEPke6ceMqvXvw9sbodXUVUoJf9noYR0Kh02yFoh+q9TjP8abdaDJYZemfXKsyQL+/Xhr
        HjsMGbDJD+Dwf++TzdUHWwQr4wxJyolVhPhZM6wJxMvnBi18PaH+bKOtM7A/kQYGGINPTuH
        IoVUmzpIkFDOfcL5mii9BZISYs/5XK7M9Z1kVxoTOkZPE+Kwfs4TKV56C5zWA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7671463311839371990
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu, thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 08/12] selftests/nolibc: allow quit qemu-system when poweroff fails
Date:   Sat, 29 Jul 2023 20:05:00 +0800
Message-Id: <20230729120500.12663-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230729082950.GL956@1wt.eu>
References: <20230729082950.GL956@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

> On Sat, Jul 29, 2023 at 09:59:55AM +0200, Thomas Weißschuh wrote:
> > On 2023-07-28 04:30:31+0800, Zhangjin Wu wrote:
> > > The kernel of some architectures can not poweroff qemu-system normally,
> > > especially for tinyconfig.
> (...)
> > This feels fairly hacky.
> 
> and totally unmaintainable in the long term. It may even fail for
> some users having localization.
>

Agree very much in some degree, especially about some of the new added
expected string, although I'm carefully choose some. but it is possible
to restore the first version and shrink it as possible as we can.

Perhaps I still not explained the background clearly, let me try again
to describe ;-)

The added more expected string are used to fill the gap when without
output to screen (as suggested by Willy, I have dropped the "print
running log to screen" change), quiet output is not friendly to a
potential hang and even amplify the influence of a hang experience, but
these more expected string did make things more complicated and worse:

    TIMEOUT_CMD = t=$(QEMU_TIMEOUT); past=0; err=""; bios=0; kernel=0; init=0; test=0; poweredoff=0;                                                   \
	bios_timeout=$$(expr $$t - 7); kernel_timeout=$$(expr $$t - 5); init_timeout=$$(expr $$t - 3); test_timeout=$$(expr $$t - 1);              \
	echo "Running $(IMAGE_NAME) on qemu-system-$(QEMU_ARCH)";                                                                                  \
	while [ $$t -gt 0 ]; do                                                                                                                    \
	    sleep 1; t=$$(expr $$t - 1); past=$$(expr $$past + 1);                                                                                 \
	    if [ $$bios -eq 0 ] && grep -E "Linux version|Kernel command line|printk: console" "$(RUN_OUT)"; then bios=1; fi;                      \
	    if [ $$bios -eq 1 -a $$kernel -eq 0 ] && grep -E "Run .* as init process" "$(RUN_OUT)"; then kernel=1; fi;                             \
	    if [ $$kernel -eq 1 -a $$init -eq 0 ] && grep -E "Running test" "$(RUN_OUT)"; then init=1; fi;                                         \
	    if [ $$init -eq 1 -a $$test -eq 0 ] && grep -E "Leaving init with final status|Total number of errors" "$(RUN_OUT)"; then test=1; fi;  \
	    if [ $$init -eq 1 ] && grep -E "Kernel panic - not syncing: Attempted to kill init" "$(RUN_OUT)"; then err="test"; sleep 1; break; fi; \
	    if [ $$test -eq 1 ] && grep -E "reboot: System halted|reboot: Power down" "$(RUN_OUT)"; then poweredoff=1; sleep 1; break; fi;         \
	    if [ $$past -gt $$bios_timeout -a $$bios -eq 0 ]; then err="bios"; break; fi;                                                          \
	    if [ $$past -gt $$kernel_timeout -a $$kernel -eq 0 ]; then err="kernel"; break; fi;                                                    \
	    if [ $$past -gt $$init_timeout -a $$init -eq 0 ]; then err="init"; break; fi;                                                          \
	    if [ $$past -gt $$test_timeout -a $$test -eq 0 ]; then err="test"; break; fi;                                                          \
	done;                                                                                                                                      \
	if [ -z "$$err" -a $$poweredoff -eq 0 ]; then err="qemu-system-$(QEMU_ARCH)"; fi;                                                          \
	if [ -n "$$err" ]; then echo "$$err may timeout, test failed"; tail -10 $(RUN_OUT); else echo "powered off, test finish"; fi;              \
	pkill -15 qemu-system-$(QEMU_ARCH) || true

The new added lines are just want to keep the console active to tell
users the test is running at background, even there is potential hang,
users will learn what the progress it is, but if we allow print the
running log to screen (may still have the issues mentioned by Willy in
another email thread), these lines can be simply removed to get a
cleaner version.

The old version didn't add such logic, beside timeout logic, it simply
try to match the expected 'reboot: ' string, but we do need to match the
'Kernel panic' string too to catch a crash nolibc-test case, so, a
simplified version looks like this:

    TIMEOUT_CMD = t=$(QEMU_TIMEOUT); finish=0;                                                                               \
        echo "Running $(IMAGE_NAME) on qemu-system-$(QEMU_ARCH)";                                                            \
	while [ $$t -gt 0 ]; do                                                                                              \
	    sleep 1; t=$$(expr $$t - 1);                                                                                     \
	    grep -E "reboot: System halted|reboot: Power down|Kernel panic" "$(RUN_OUT)"; then finish=1; sleep 1; break; fi; \
	done;                                                                                                                \
	if [ $$finish -eq 1 ]; then echo "test finish"; else echo "test timeout"; fi;                                        \
	pkill -15 qemu-system-$(QEMU_ARCH) || true

Now, the lines are not too many, and the left expected strings should be
stable enough, do you like this one? I do expect the timeout command has
a "-m" option like this:

    timeout --foreground 10 -m "reboot: |Kernel panic" qemu-system-$(QEMU_ARCH) ...

> > Before we complicated nolibc-test to handle the no-procfs case to save a
> > few seconds building the kernel and now we have fairly big timeouts.

In reality, the answer is NO to "now we have fairly big timeouts".

Firstly, If there is no hang or no poweroff failure, every run will quit
normally.

Secondly, even there is a poweroff failure or kernel panic, a 'reboot: '
line will be always printed as expected and quit normally.

Thirdly, just only when there is a hang (not specific to tinyconfig),
such as wrong bios version or missing firmware or even kernel hang with
new changes (for example, the irqstack related riscv kernel hang I
reported), blabla. such hangs will be detected by the fixed timeout
value (like a watchdog).

When poweroff fails on a target qemu, it still prints the 'reboot: '
line as below, but will hang there after this line, our timeout logic
will detect this line and tell qemu quit as a normal poweroff.

    Total number of errors: 0
    Leaving init with final status: 0
    reboot: System halted             /* This line which be printed when reboot() issues, not depends on qemu or kernel driver */
    ---> detecting reboot: System halted|reboot: Power down|Kernel panic - not syncing: Attempted to kill init|Rebooting ...
    test finish                       /* Even qemu not poweroff successfully, we will kill it while the above line detected */
    LOG: Boot run successfully.
    Running boot-finish

The oldest method I used locally is the 'timeout' command itself only,
it is really a dead wait for a fixed timeout, the new method we used
here to match the expected string does help a lot to simulate a always
sucessful qemu poweroff support, no kernel and qemu dependent,
lightweight enough.

> > And a statemachine that relies on the specific strings emitted by the
> > testsuite.
> > 
> > I would like to get back to something more deterministic and obvious,
> > even at the cost of some time spent compiling the test kernels.
> > (saying this as somebody developing on a 2016 ultrabook)
> 
> Agreed!
>

Is the above explaination clearer? ;-)

Based on the kernel versions from v2.6.10 - v6.x which I have used on
more than 7 architectures in my own Linux Lab project, the poweroff
support of qemu + kernel is never deterministic, some versions ok, some
versions fail, even with the defconfig, that's why an external timeout
is always required. I used the raw timeout command + a fixed timeout
before, but after we have this patch, I have thought about the expected
string logic and it does help to aviod a dead fixed-time wait.

> > "Since the low-level poweroff support is heavily kernel & qemu dependent"
> > 
> > The kernel we can control.
> > 
> > How common are qemus with that are missing poweroff support? 
> > As this worked before I guess the only architecture where this could
> > pose a problem would be ppc.
> > 

Yes, as explained above, based on the experience I have on tons of
kernel versions of different architecture, it is really hard to make
poweroff work as expected all the time, as the kernel and qemu changes,
it may fail at any version randomly.

Beside ppc, all of my local tinyconfig config files of every
architecture are ready for boot and print and also of course for the
'reboot: ' line print. but it is 'hard' to find and enable the left
options to just further enable 'poweroff' support.

Firstly, I have tried to enable some of them, but it deviates the
tinyconfig goal, for example, x86 requires to enable both ACPI and PCI
to just let poweroff work, so, I'm not planning to really enable them.

Secondly, the time cost to just find and enable the poweroff options for
every architecture (and even for the new nolibc portings) is huge, I
give up after several tries, and they may fail in some future versions
randomly, I do think we may be not really interested in fixing up such
bugs in kernel drivers side ;-)

Thirdly, as Thomas mentioned before, the wireguard test use tinyconfig
too, just found it also gives up the poweroff support in its config
options and it use a simple raw timeout command, but the timeout is
really 'huge', 20m v.s. 10 seconds ;-)

    grep timeout tools/testing/selftests/wireguard/qemu/Makefile
	timeout --foreground 20m qemu-system-$(QEMU_ARCH) \
	timeout --foreground 20m $< \

> > 
> > An alternative I would like to put up for discussion:
> > 
> > qemu could provide a watchdog device that is pinged by nolibc-test for
> > each testcase.
> > After nolibc-test is done and didn't poweroff properly the watchdog will
> > reset the machine. ( -watchog-action poweroff ).
> > 
> > The disadvantages are that we would need to add watchdog drivers to the
> > kernels and figure out the correct watchdog devices and drivers for each arch.
> 
> It's an interesting idea, though at first glance it does not seem to
> have one for PPC.

Good idea, I even asked one of the QEMU maintainers whether is possible
to add something like -boot-timeout option to QEMU and let qemu quit
in a target timeout after start, but it may also function as a dead
fixed-time wait.


    qemu-system-xxx -boot-timeout <TIMEOUT>

    |<-----------------<TIMEOUT>---------------------->
                                                     
    ^                              ^                  ^
    qemu start                     |                  qemu timeout and quit
                                   |
				   power off string may be detected here
				   and quit normally

> 
> I think I have a much simpler idea: we don't care about PPC32. I mean
> OK it can be supported if it happens to work, we will just not include
> it in default runs, because it will require Ctrl-C to finish, and so
> what ? nolibc has been in the kernel for 5 years or so, nobody ever
> cared about PPC, why should we suddenly break or complicate everything
> just to support a sub-arch that nobody found interesting to add till
> now?
>

Yes, this timeout logic is ok to be removed from this patchset, till we
get a better solution.

> > It seems virtio-watchdog is not yet usable.
> 
> Then it might become an option for the future when it eventually works.
>

Thanks,
Zhangjin

> Thanks,
> Willy
