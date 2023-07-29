Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D50F7680B1
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 19:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjG2RHD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 13:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjG2RHC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 13:07:02 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7967D183;
        Sat, 29 Jul 2023 10:07:00 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36TH6pMj005390;
        Sat, 29 Jul 2023 19:06:51 +0200
Date:   Sat, 29 Jul 2023 19:06:51 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     thomas@t-8ch.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 08/12] selftests/nolibc: allow quit qemu-system when
 poweroff fails
Message-ID: <20230729170651.GB5219@1wt.eu>
References: <20230729082950.GL956@1wt.eu>
 <20230729120500.12663-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729120500.12663-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jul 29, 2023 at 08:05:00PM +0800, Zhangjin Wu wrote:
(...)
> The new added lines are just want to keep the console active to tell
> users the test is running at background, even there is potential hang,
> users will learn what the progress it is, but if we allow print the
> running log to screen (may still have the issues mentioned by Willy in
> another email thread), these lines can be simply removed to get a
> cleaner version.
> 
> The old version didn't add such logic, beside timeout logic, it simply
> try to match the expected 'reboot: ' string, but we do need to match the
> 'Kernel panic' string too to catch a crash nolibc-test case, so, a
> simplified version looks like this:
> 
>     TIMEOUT_CMD = t=$(QEMU_TIMEOUT); finish=0;                                                                               \
>         echo "Running $(IMAGE_NAME) on qemu-system-$(QEMU_ARCH)";                                                            \
> 	while [ $$t -gt 0 ]; do                                                                                              \
> 	    sleep 1; t=$$(expr $$t - 1);                                                                                     \
> 	    grep -E "reboot: System halted|reboot: Power down|Kernel panic" "$(RUN_OUT)"; then finish=1; sleep 1; break; fi; \
> 	done;                                                                                                                \
> 	if [ $$finish -eq 1 ]; then echo "test finish"; else echo "test timeout"; fi;                                        \
> 	pkill -15 qemu-system-$(QEMU_ARCH) || true
> 
> Now, the lines are not too many, and the left expected strings should be
> stable enough, do you like this one?

Do you realize how unreadable and undebuggable this is for the casual
reader who just tries to figure what command line to pass to qemu to
run the test manually ? You seem to focus a lot on "if the test hangs"
but nobody ever reported such a problem in the last few years. However
we've been spending weeks discussing how to add support for extra
features or architectures and such hacky stuff definitely steps in the
way and complicates everything.

> I do expect the timeout command has
> a "-m" option like this:
> 
>     timeout --foreground 10 -m "reboot: |Kernel panic" qemu-system-$(QEMU_ARCH) ...

I suggest that we give up on this timeout thing completely. You've shown
that it significantly complicates everything and we yet have to find a
single valid use case. Other subsystems also use QEMU without this.
rcutorture does perform some process management but it's way more advanced
and complete, and there's a reason: the tests are usually not supposed to
end by themselves.

> > > Before we complicated nolibc-test to handle the no-procfs case to save a
> > > few seconds building the kernel and now we have fairly big timeouts.
> 
> In reality, the answer is NO to "now we have fairly big timeouts".
> 
> Firstly, If there is no hang or no poweroff failure, every run will quit
> normally.

Which is one good reason for not complexifying everything.

> Secondly, even there is a poweroff failure or kernel panic, a 'reboot: '
> line will be always printed as expected and quit normally.

This is not supposed to happen in automated tests, and archs that fail
at this will simply be either excluded from automated tests, or will
be run through whatever external timeout mechanism.

> Thirdly, just only when there is a hang (not specific to tinyconfig),
> such as wrong bios version or missing firmware or even kernel hang with
> new changes (for example, the irqstack related riscv kernel hang I
> reported), blabla. such hangs will be detected by the fixed timeout
> value (like a watchdog).

These are local tools issues, we can't fix them all and it's not our
job. We're just providing an easy and hopefully convenient framework
to test syscalls. We're not supposed to require users to have to go
through complex debugging in this. And if they face a failure due to
their local tools (like I had with my old qemu version), they'll just
work around it by rebuilding it and that will be done. In the worst
case, some archs might require a Ctrl-C once in a while during a
manual test. No big deal. Definitely not as big as spending 10 minutes
trying to figure how to find one's way through a complicated makefile,
or wondering what's that runaway qemu process in the background that
refuses to die, etc.

> When poweroff fails on a target qemu, it still prints the 'reboot: '
> line as below, but will hang there after this line, our timeout logic
> will detect this line and tell qemu quit as a normal poweroff.
> 
>     Total number of errors: 0
>     Leaving init with final status: 0
>     reboot: System halted             /* This line which be printed when reboot() issues, not depends on qemu or kernel driver */
>     ---> detecting reboot: System halted|reboot: Power down|Kernel panic - not syncing: Attempted to kill init|Rebooting ...
>     test finish                       /* Even qemu not poweroff successfully, we will kill it while the above line detected */
>     LOG: Boot run successfully.
>     Running boot-finish
> 
> The oldest method I used locally is the 'timeout' command itself only,
> it is really a dead wait for a fixed timeout, the new method we used
> here to match the expected string does help a lot to simulate a always
> sucessful qemu poweroff support, no kernel and qemu dependent,
> lightweight enough.

I'm still definitely not fond of it because it turns something super simple
into something complex and likely unreliable, for very little benefit.

> Is the above explaination clearer? ;-)

At least given the numerous approaches we've seen, now I'm convinced I
don't want to see that anymore. Too much complication, a feeling of
hackish and unreliable solution that will very likely cause lots of
fixes in the future.

> Based on the kernel versions from v2.6.10 - v6.x which I have used on
> more than 7 architectures in my own Linux Lab project, the poweroff
> support of qemu + kernel is never deterministic, some versions ok, some
> versions fail, even with the defconfig, that's why an external timeout
> is always required.

Again, never ever experienced such a problem with the default configs
for the supported archs, with one of my machines having a qemu version
as old as 2.7. Paul always runs all the tests as well and never reported
this problem either. Thus I would like that we stick to precise facts
about problems that occur rather than just papering over them in a
generic way.

> > > "Since the low-level poweroff support is heavily kernel & qemu dependent"
> > > 
> > > The kernel we can control.
> > > 
> > > How common are qemus with that are missing poweroff support? 
> > > As this worked before I guess the only architecture where this could
> > > pose a problem would be ppc.
> > > 
> 
> Yes, as explained above, based on the experience I have on tons of
> kernel versions of different architecture, it is really hard to make
> poweroff work as expected all the time, as the kernel and qemu changes,
> it may fail at any version randomly.

Please could you provide us with a reproducer for this problem, with
the mainline commit ID, arch, toolchain used, qemu version, because I
think you're generalizing over a few cases that happened during your
tinyconfig tests, for various possible reasons, but which are likely
not good reasons for complicating everything.

> Beside ppc, all of my local tinyconfig config files of every
> architecture are ready for boot and print and also of course for the
> 'reboot: ' line print. but it is 'hard' to find and enable the left
> options to just further enable 'poweroff' support.

If tinyconfig is not fixable, it's not usable, period. Right now all
archs stop fine for many of us with defconfig. If only a few tinyconfig
fail we'd rather invest time on these specific ones trying to figure
what options you need to add to the extra_config.

> Firstly, I have tried to enable some of them, but it deviates the
> tinyconfig goal, for example, x86 requires to enable both ACPI and PCI
> to just let poweroff work, so, I'm not planning to really enable them.
> 
> Secondly, the time cost to just find and enable the poweroff options for
> every architecture (and even for the new nolibc portings) is huge, I
> give up after several tries, and they may fail in some future versions
> randomly, I do think we may be not really interested in fixing up such
> bugs in kernel drivers side ;-)

OK so better just give up on tinyconfig if it's not suitable for the
tests ? The more you present the shortcomings that come with them, the
less appealing it looks now.

> Thirdly, as Thomas mentioned before, the wireguard test use tinyconfig
> too, just found it also gives up the poweroff support in its config
> options and it use a simple raw timeout command, but the timeout is
> really 'huge', 20m v.s. 10 seconds ;-)
> 
>     grep timeout tools/testing/selftests/wireguard/qemu/Makefile
> 	timeout --foreground 20m qemu-system-$(QEMU_ARCH) \
> 	timeout --foreground 20m $< \

As I previously mentioned, I'm not fundamentally against a simple
timeout command *iff* we can validate the exact problem and the
conditions where it happens and we decide that it's the best workaround.
And I suspect that even once we find it we'll prefer to just not run
that specific setup by default and that's all.

> > I think I have a much simpler idea: we don't care about PPC32. I mean
> > OK it can be supported if it happens to work, we will just not include
> > it in default runs, because it will require Ctrl-C to finish, and so
> > what ? nolibc has been in the kernel for 5 years or so, nobody ever
> > cared about PPC, why should we suddenly break or complicate everything
> > just to support a sub-arch that nobody found interesting to add till
> > now?
> >
> 
> Yes, this timeout logic is ok to be removed from this patchset, till we
> get a better solution.

Thanks.

It would really help if your series could focus on *one thing* at a
time. Currently I feel like in almost all patch series you've sent
there are good stuff that could have been merged already, but which
are mixed with hacks or unacceptable massive reworks that just result
in the rest being kept on hold.

I would really appreciate it if you thought about clearly presenting
the problems you're trying to solve before sending patch series, so
that we can collectively decide whether these problems deserve being
fixed or can be ignored, and if the cost of addressing them outweigh
their cost. It would save many hours of review of patches whose goal
is not always very clear. A good rule of thumb is that something that
is only added and that provides a specific feature generally suffers
not much discussion (beyond the usual style/naming etc). But patches
that modify existing process, code organization or affect reliability
should be discussed and argumented before even being created. It's
easier to discuss a purpose than to try to review a patch for a context
that is not very clear.

Thanks,
Willy
