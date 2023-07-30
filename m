Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E3D768919
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 00:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjG3W2V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Jul 2023 18:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjG3W2U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Jul 2023 18:28:20 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCF410E2;
        Sun, 30 Jul 2023 15:28:14 -0700 (PDT)
X-QQ-mid: bizesmtp79t1690756083twjdn302
Received: from linux-lab-host.localdomain ( [61.141.77.223])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 31 Jul 2023 06:28:02 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: BYUemv+qiN20N0IXYy3KikA3P9sw0+4stSjdfYybwyjoZusf3FcBoqTf9n2sU
        a3oqdYYEdae0n2/MABZu79pKFljimCan6XyCRQ/lRDTR0HOk3S9jukbeYmya1sqLp3Cdbsz
        RE6NNRFtgDw9NIXDZTLXdDmBudgwc/P6SGPmC0XQffBQ9CT4hNT63rCDjs63DjD0m52aBUg
        oya8XjcDFZSzFWU/ZV2pH0nuF+VCh8nrchdgZm/0VeRGznXyS0SWc1aKLMNh3u212f+l7hT
        lS8Du4t11hIfeYMDvZ0D+sq9un+4Q4B4yMFFrzDrSmmfiiQpemAwKzV/CA/i2VheFo8plid
        rtwYKD6t1qXiU9VnoWtuCZ8mO5vPsK6JFgVpwAqPW7stTOhJfMbPK0b9Z+IZA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16680043692081012713
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v3 08/12] selftests/nolibc: allow quit qemu-system when poweroff fails
Date:   Mon, 31 Jul 2023 06:28:02 +0800
Message-Id: <20230730222802.506188-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230729170651.GB5219@1wt.eu>
References: <20230729170651.GB5219@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

[...]
> You seem to focus a lot on "if the test hangs"
> but nobody ever reported such a problem in the last few years. However

Willy, as Thomas shared in another reply too, there is really a poweroff failure
(even with defconfig) in the default ppc/g3beige 32-bit PowerPC Qemu we are
adding support for.

Btw, It is possible to switch another 32-bit PowerPC board who support poweroff
in qemu+kernel side, but need more investigate and survey, I have tried another
two, no lucky, the ppce500 webpage [1] even claims there is 'Power-off
functionality via one GPIO pin', but tried to enable the related gpios and
reset options, still not work, perhaps I need help from more PowerPc users,
will ask somebody to help me ;-)

[1]: https://qemu.readthedocs.io/en/latest/system/ppc/ppce500.html

> we've been spending weeks discussing how to add support for extra
> features or architectures and such hacky stuff definitely steps in the
> way and complicates everything.

The background is, based on your feedback in another reply, printing the log to
screen (another patch I have removed in this revision) may have some issues
before. But if without any log and just hang after a poweroff failure and even
further no timeout ... then, dead hang, that is really hard to debug, edit of
Makefile and rerun and then we will know it fails at poweroff or just during
qemu start ..., as you replied below, CTRL+C may help to cat the log file too,
but it waste a CTRL+C + cat during the early development stage, especially when
we require frequenty modify and test.

[...]
> 
> This is not supposed to happen in automated tests, and archs that fail
> at this will simply be either excluded from automated tests, or will
> be run through whatever external timeout mechanism.
>

Agree with external timeout mechanism or even excluded from automated tests,
but we at least to allow to do basic test without editing the Makefile or
without forever Ctrl-C + cat run.out manually ;-)

So, what about at least restore part of my old 'print running log to screen'
patch like this:

    # run the tests after building the kernel
    run: kernel
    	$(Q)$(QEMU_SYSTEM_RUN) | tee "$(RUN_OUT)"
    	$(Q)$(REPORT) "$(RUN_OUT)"
    
    # re-run the tests from an existing kernel
    rerun:
    	$(Q)$(QEMU_SYSTEM_RUN) | tee "$(RUN_OUT)"
    	$(Q)$(REPORT) "$(RUN_OUT)"

Or even better, allow use a swtich to control it (the one we also removed from
an old patch).

    ifneq ($(QUIET_RUN),1)
    LOG_OUT= | tee "$(RUN_OUT)"
    else
    LOG_OUT= > "$(RUN_OUT)"
    endif

If missing this, the early stages of a new architecture porting is definitely
very hard, not think about poweroff failure, just think about some other
potential exceptions which simply stop the booting or testing (not continue and
not exit).
 
> > Thirdly, just only when there is a hang (not specific to tinyconfig),
> > such as wrong bios version or missing firmware or even kernel hang with
> > new changes (for example, the irqstack related riscv kernel hang I
> > reported), blabla. such hangs will be detected by the fixed timeout
> > value (like a watchdog).
> 
> These are local tools issues, we can't fix them all and it's not our
> job. We're just providing an easy and hopefully convenient framework
> to test syscalls. We're not supposed to require users to have to go
> through complex debugging in this. And if they face a failure due to
> their local tools (like I had with my old qemu version), they'll just
> work around it by rebuilding it and that will be done. In the worst
> case, some archs might require a Ctrl-C once in a while during a
> manual test. No big deal. Definitely not as big as spending 10 minutes
> trying to figure how to find one's way through a complicated makefile,
> or wondering what's that runaway qemu process in the background that
> refuses to die, etc.

Again Willy, without log and without timeout (with a tail of last 10 lines in
the old version), just a 'forever' hang, Ctrl-C helps but not much, still
require to check the log to see what happens or editing the Makefile to enable
the logging temply, it is realy time-waste during development ;-)

[...]
> 
> Again, never ever experienced such a problem with the default configs
> for the supported archs, with one of my machines having a qemu version
> as old as 2.7. Paul always runs all the tests as well and never reported
> this problem either. Thus I would like that we stick to precise facts
> about problems that occur rather than just papering over them in a
> generic way.
>

Willy, before, the old versions of this patchset did only configure
QEMU_TIMEOUT for the failed 32-bit PowerPC and not enabled for the other
boards, but later after a dicussion (perhaps I misunderstood one of your
suggestions?), this revision configure a default one for all, I also thought
about it is not good for all boards, but still a choice to a board really have
no poweroff support (external one is ok if with explicitly log printing to
screen). 

we have used something like this before:

    ifneq ($(QEMU_TIMEOUT),)
    ...
    endif
 
> > > > "Since the low-level poweroff support is heavily kernel & qemu dependent"
> > > > 
> > > > The kernel we can control.
> > > > 
> > > > How common are qemus with that are missing poweroff support? 
> > > > As this worked before I guess the only architecture where this could
> > > > pose a problem would be ppc.
> > > > 
> > 
> > Yes, as explained above, based on the experience I have on tons of
> > kernel versions of different architecture, it is really hard to make
> > poweroff work as expected all the time, as the kernel and qemu changes,
> > it may fail at any version randomly.
> 
> Please could you provide us with a reproducer for this problem, with
> the mainline commit ID, arch, toolchain used, qemu version, because I
> think you're generalizing over a few cases that happened during your
> tinyconfig tests, for various possible reasons, but which are likely
> not good reasons for complicating everything.
>

It is very hard to list all, the following one is a section [1] (not updated
for a long time) of the document of my 'Linux Lab' project:

    ### 6.2.2 Poweroff hang
    
    Both of the `poweroff` and `reboot` commands not work on these boards currently (LINUX=v5.1):
    
    * mipsel/malta (exclude LINUX=v2.6.36)
    * mipsel/ls232
    * mipsel/ls1b
    * mips64el/ls2k
    * mips64el/ls3a7a
    * aarch64/raspi3
    * arm/versatilepb
    
    System will directly hang there while running `poweroff` or `reboot`, to exit qemu, please pressing `CTRL+a x` or using `pkill qemu`.
    
    To test such boards automatically, please make sure setting `TEST_TIMEOUT`, e.g. `make test TEST_TIMEOUT=50`.
    
    Welcome to fix up them.

IMHO, since my project is mainly for kernel learning and development, I even
don't care about why it not poweroff successfully at last although I have tried
my best to find the realted options but failed at last, the reasons may be
complex, from kernel side or from qemu side, both possible, or even simply a
kernel option changed and the config options are not updated timely. 

We have so many boards with kernel version from v2.6.10 to v6.4, many poweroff
failures before:

    $ ls -1 -d */*
    aarch64/raspi3
    aarch64/virt
    arm/ebf-imx6ull
    arm/mcimx6ul-evk
    arm/versatilepb
    arm/vexpress-a9
    arm/virt
    i386/pc
    loongarch64/virt
    mips64el/loongson3-virt
    mips64el/ls2k
    mips64el/ls3a7a
    mipsel/ls1b
    mipsel/ls232
    mipsel/malta
    ppc64le/powernv
    ppc64le/pseries
    ppc64/powernv
    ppc64/pseries
    ppc/g3beige
    ppc/ppce500
    riscv32/virt
    riscv64/virt
    s390x/s390-ccw-virtio
    x86_64/pc

    The kernel we used for i386/pc:

    v2.6.10
    v2.6.11.12
    v2.6.12.6
    v2.6.21.5
    v2.6.24.7
    v2.6.34.9
    v2.6.35.14
    v2.6.36
    v3.10.108
    v4.6.7
    v5.1
    v5.13
    v5.2
    v6.1.1

[1]: https://github.com/tinyclub/linux-lab/blob/master/README.md#622-poweroff-hang
 
> > Beside ppc, all of my local tinyconfig config files of every
> > architecture are ready for boot and print and also of course for the
> > 'reboot: ' line print. but it is 'hard' to find and enable the left
> > options to just further enable 'poweroff' support.
> 
> If tinyconfig is not fixable, it's not usable, period. Right now all
> archs stop fine for many of us with defconfig. If only a few tinyconfig
> fail we'd rather invest time on these specific ones trying to figure
> what options you need to add to the extra_config.
>

Yes, that's why I plan to send the left patches by architecture, it will give
us more time to configure and confirm the missing poweroff options if really
required, I will ask somebody else to work with me together. 
 
> > Firstly, I have tried to enable some of them, but it deviates the
> > tinyconfig goal, for example, x86 requires to enable both ACPI and PCI
> > to just let poweroff work, so, I'm not planning to really enable them.
> > 
> > Secondly, the time cost to just find and enable the poweroff options for
> > every architecture (and even for the new nolibc portings) is huge, I
> > give up after several tries, and they may fail in some future versions
> > randomly, I do think we may be not really interested in fixing up such
> > bugs in kernel drivers side ;-)
> 
> OK so better just give up on tinyconfig if it's not suitable for the
> tests ? The more you present the shortcomings that come with them, the
> less appealing it looks now.
>

The only shortcoming is some 'poweroff' failures currently, I do think the
time-saved is huge, with tinyconfig, I even don't want to try the time-consumer
defconfig anymore (although it is a requirement of many kernel features for the
last release), especially for nolibc development ;-)

I'm using tinyconfig+nolibc for most of the boards supported by my Linux Lab
project, I'm really happy with it, I use similar timeout + expected string
logic now, it works better than the old pure timeout logic, then, I don't care
about which poweroff options the target board want, just ignore the
requirement. It is a very good kernel learning and development experience, I
have used a defconfig based config and also a small config customized for
nolibc for them before, but with the new tinyconfig (extra boot/print options)
suggested by Thomas, it is really a good and a whole new experience.

To be honest, from my side, it is ok to add tinyconfig for nolibc or not,
because I can use the test script from Linux Lab project to test new nolibc
features, but I do think this will help a lot for both the kernel and nolibc
developers, so, I'm happy to continue, even we are facing some real
difficulties currently.

[...] 
> > >
> > 
> > Yes, this timeout logic is ok to be removed from this patchset, till we
> > get a better solution.
>

But again as explained above, we do need something to cope with 'dead' hang
without any output.
 
> Thanks.
> 
> It would really help if your series could focus on *one thing* at a
> time. Currently I feel like in almost all patch series you've sent
> there are good stuff that could have been merged already, but which
> are mixed with hacks or unacceptable massive reworks that just result
> in the rest being kept on hold.
>

Agree, thanks, I will try my best to split a huge stuff to smaller ones, I was
a little hurried to want to upstream the non-rv32 related parts quickly, then,
we can back to rv32 asap ;-)
 
> I would really appreciate it if you thought about clearly presenting
> the problems you're trying to solve before sending patch series, so
> that we can collectively decide whether these problems deserve being
> fixed or can be ignored, and if the cost of addressing them outweigh
> their cost. It would save many hours of review of patches whose goal
> is not always very clear.

I like this suggestion, since you have mentioned before, based on your
suggestions, like the syscall.h stuff, a disucss or a proposal is fired before
a real patchset, although I think it worths a real RFC patchset, but let's
delay it and I do need more work to solve the questions asked from you, this
may be also related to some ideas mentioned by Arnd before, seems he have
planed to generate some syscall templates from the kernel .tbls, let's discuss
this in another thread, please ignore this one. 

> A good rule of thumb is that something that
> is only added and that provides a specific feature generally suffers
> not much discussion (beyond the usual style/naming etc). But patches
> that modify existing process, code organization or affect reliability
> should be discussed and argumented before even being created. It's
> easier to discuss a purpose than to try to review a patch for a context
> that is not very clear.

That's reasonable, a good rule is 'subtraction', not 'addition', sometimes, the
implementation of new idea does add more impulsion to modify anything, it
require calmness to go back to the core issue we want to solve.

Thanks a lot.

Best regards,
Zhangjin

> 
> Thanks,
> Willy
