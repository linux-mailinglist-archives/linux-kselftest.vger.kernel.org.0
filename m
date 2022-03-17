Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2F64DCACA
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Mar 2022 17:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbiCQQKa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Mar 2022 12:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiCQQK3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Mar 2022 12:10:29 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02BDE9C88;
        Thu, 17 Mar 2022 09:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1647533352;
  x=1679069352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GCK73NAHwWh0xTIrNJAiZh4vvH5OIpID7Fc8LsMvkc0=;
  b=kYTiOh/hoSrid38RuazzBbBQP+Tpg4augX7V9U5IlobLkATf8oTMd7Oj
   6Po3Pj9I+yctKZ6MaI8Yz36r09QUxf6c8UeCXK6gh52zHMpOuQDALQSAZ
   Sw6+FwTOarocYJfBH4bZTYoNvmLhNcrvAQY0KnrUuAYSNAWiPcrIiBtXe
   ELlk4LsKK+J3hWhAnP1aR9F8dBVo8uZmLawvqRoL2SDSi/3SRfEqDLMPa
   z/99gsIabP8A5UhKTTmcvpmbafVgTTsFa0iEriU7pvNzFAaFwGlktV/eQ
   3tgSZ2Qr5dc8V2qvfjT58ezkPsIDQQGlPaPHKy66IfnYjaQDNVpw2Af4m
   A==;
Date:   Thu, 17 Mar 2022 17:09:08 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Brendan Higgins <brendanhiggins@google.com>
CC:     Dmitry Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [RFC v1 00/10] roadtest: a driver testing framework
Message-ID: <20220317160908.GA20347@axis.com>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
 <CAFd5g45zwSNr-_PSbtGn1MiQgombSBTCjXOG-cvcQW8xQQUo+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFd5g45zwSNr-_PSbtGn1MiQgombSBTCjXOG-cvcQW8xQQUo+Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 14, 2022 at 11:24:59PM +0100, Brendan Higgins wrote:
> +Kees Cook - I imagine you have already seen this, but I figured you
> would be interested because of your recent work on the KUnit UAPI and
> the mocking discussions.
> +Dmitry Vyukov - This made me think of the syzkaller/KUnit experiments
> we did a couple of years back - this would probably work a bit better.
> 
> On Fri, Mar 11, 2022 at 11:24 AM Vincent Whitchurch
> <vincent.whitchurch@axis.com> wrote:
> >
> > This patchset proposes roadtest, a device-driver testing framework.  Drivers
> > are tested under User Mode Linux (UML) and interact with mocked/modelled
> > hardware.  The tests and hardware models are written in Python, the former
> > using Python's built-in unittest framework.
> 
> Wow! This sounds awesome! I was hoping to get some kind of hardware
> modeling with KUnit eventually. I did some experiments, but this looks
> way more mature.

Thank you for the comments!

> > Drivers are tested via their userspace interfaces.  The hardware models allow
> > tests to inject values into registers and assert that drivers control the
> > hardware in the right way and react as expected to stimuli.
> 
> I already took a look at the documentation patch - I'll comment there
> more in detail, but I like the hardware modelling and device tree
> code; it seems very usable.
> 
> > Roadtest is meant to be used for relatively simple drivers, such as the ones
> > part of the IIO, regulator and RTC subsystems.
> 
> Obviously for an initial version going after simple stuff makes sense,
> but I would hope there is applicability to any driver stack
> eventually.

Yes, there is no inherent restriction to only simple hardware, but these
kinds of subsystem are the ones where it's easier to apply the framework
since there's simply less stuff to model/mock in the hardware.

Supporting different busses also requires some work in the framework and
potentially some new drivers.  For I2C we use virtio-i2c but there's no
ready-made virtio-spi for example.  For MMIO (PCI / platform drivers), I
did some basic experiments with UML's virtio-mmio in the early stages of
writing this framework.

> > = How does this relate to kselftests?
> >
> > Tests in kselftests also test kernel code using the userspace interfaces, but
> > that's about what's common between the frameworks.  kselftests has other goals
> > and does not provide any kind of mechanism for hardware mocking.
> 
> I had a question that after thinking about it; I think I know the
> answer, so I am going to ask the question anyway and attempt to answer
> it myself:
> 
> I agree in regard to mocking, but why not use kselftest for driving
> tests that check drivers from userspace? I believe there are other
> kselftest tests implemented in Python, why can't you just run your
> tests inside of kselftest?
> 
> Now, I believe the answer to this question is that you need to control
> spinning up your own kernel to run inside your test harness because
> you need to control the environment that the kernel runs in - is this
> correct?

Yes, that is correct.  For example, the devicetree stuff requires that
the kernel be booted with the devicetree.  For the other tests also it's
simpler to have a controlled environment without being affected by other
stuff going on on the host.  And generally it's of course easier if the
kernel which is inevitably going to crash and burn due to buggy drivers
isn't the one powering your workstation.

Also, there is no currently way to use virtio drivers such as virtio-i2c
and virtio-gpio (which roadtest uses) with the virtio device side
implemented in userspace on the same system, so that would have also
required a fair bit of work to get running.

(On a side note, I've wondered why kselftest doesn't provide a standard
way to run all the tests under kvm or something similar with all the
correct configs.  For example, the kernels I work with are on embedded
systems and I rarely recompile my host kernel, and I assume that there
are plenty of others in the same situation.)

> > = How does this relate to kunit?
> >
> > Kunit is for unit testing of functions in kernel code, and is not meant for
> > testing kernel code via userspace interfaces.  It could in theory be used to
> > test some of the simple drivers too, but that would require (1) a large amount
> > of mocking code in various kernel frameworks, and, more importantly, (2)
> > refactoring of the drivers to be tested.
> 
> I mostly agree, but I think there is something that is missing here:
> so roadtest seems to depend on having a user interface to test a
> driver - for a simple smoke test on a simple driver without a big
> driver stack on top, that makes sense, but what about testing error
> paths or a platform driver buried beneath a deep driver stack? I think
> there is potential for a powerful combination using KUnit to test the
> low level kernel API and using roadtest to mock the hardware
> environment and provide configuration.

Yes, that could be useful.  I have previously written some kunit tests
for some experimental memory management code which required different
devicetree reserved-memory nodes and arm64 (no hardware mocking) to run,
and I ran them by having a shell script which ran QEMU several times
with appropriate -append kunit.filter_glob=foo and -dtb options and
post-processing the logs with kunit.py.

> I am imagining that we could have an in-kernel KUnit/roadtest API that
> we can use to have an in-kernel test request changes to the
> environment for creating error cases and the like that can be
> validated by KUnit test cases.
> 
> Going even further, I wonder if we could run kselftests inside of
> roadtest since roadtest allows us to change the environment on the
> fly.

Sounds interesting, but I would likely need to see concrete examples to
understand what kind of environment we'd want to change from within the
kernel.

> > This can be contrasted with roadtest which works with mostly unmodified drivers
> > and which mocks the hardware at the lowest level without having to change
> > kernel frameworks.
> 
> I think that is both potentially an advantage and a disadvantage.
> 
> The advantage is that your test is very general; roadtests would
> likely be portable across kernel versions.
> 
> The disadvantage is that you don't get as much code introspection: I
> imagine roadtest is not as good as testing error paths for example.
> 
> I also think that having to change code to make it more testable is
> often an advantage as much as a disadvantage.

Yes, that's true, but I highlighted the unmodified drivers bit because
(1) the process of refactoring drivers which don't have tests to make
them testable in itself carries it with a risk of breaking stuff, and
(2) and there are simply so many existing drivers that it's very
unlikely that most of them get refactored, but it should be relatively
easy to, for example, add a regression test for a specific bug fix with
roadtest.

> 
> Still, I think that is a good set of tradeoffs for roadtest to make
> when set against KUnit and kselftest since roadtest seems to fit in
> where kselftest and KUnit are weak.
