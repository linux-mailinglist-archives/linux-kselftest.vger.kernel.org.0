Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56374D8F84
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Mar 2022 23:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245547AbiCNW01 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Mar 2022 18:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241823AbiCNW00 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Mar 2022 18:26:26 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05653DA55
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Mar 2022 15:25:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id dr20so36503800ejc.6
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Mar 2022 15:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C2afl50vRzCzlzNSM1o5i8QhGcaBpuDd6T9qiMLVa1s=;
        b=eiWfqNLwPSMITSi4tZA697TINLHoTWddjX2tdwgu8rOVSjVpJDeuT64LyWwJJpv7w/
         el4YHcBT53FfPNHY0wRGqGQOPAMU5oXA0RxxJwkaoR8sVkdrxOK2mRSVie5dLEiuHNDh
         krGToc9wLAuONsOZgZ09i1aoXwtyzdKQzE0AOL//CHMUTyd7aCVKcTCfZ5FKIJDDgJNA
         LsrmgbI0VhKa5UlYxETs3bCvSh1SH5bZEqkVVTxLA/UvnI0+raKNXceSVvhs5WK4SQvj
         hkWVagKvz4P7O0uY0DVuqKCg641y0QCJ7R1AYIyovi6jz8iYloJ/5cXkF2e5L8880i1k
         zv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C2afl50vRzCzlzNSM1o5i8QhGcaBpuDd6T9qiMLVa1s=;
        b=u1Jsdy0JNIfEgXDxN0Tr5up0PeAcvBRQAvCRjrqU6mNmX0M+2Ui4RkL78lyJyqDIlf
         DzUXTMeqifgd5fG2GxpydwZiijxnC1D88oKl9nwoV9yqzPKzpRgxAIF7Q0m2BAoHvp2b
         XQ3cOft/5/XqV5oNJ2KMEl2oE8a3uxZC0VF9vXQv4Rc0LMTB8axsvUxJ3RIzfPArxHYg
         t3qV923X0GRgVW6vu/8QKWvH+GLWwdVLCUSSQUHBkzV/h6fcJNDmYv6UBZP/U2RS8t0/
         ueImPCrkDAaHfBaMfKQaroySdMhBKaUvm4ekAD9moYjEFiGCRnzOThuJ8Y5OSoVEkIR6
         dKjQ==
X-Gm-Message-State: AOAM531Np3bEiJ6tWEdiMVg7fLLGVNzzSrKJMqYJ+gv4wdBqIpIFnEn3
        hgl97RhaTrQNxG0yFXnT9y5nrqs6JJ1GYdpPz6hkH6fkLY0=
X-Google-Smtp-Source: ABdhPJxT+L+PoW2vGW+ultLAUaUQT0+vlwQouCpp/zyLolVzqtlFshODHZZJzjvlv5tGpakhMs0ZQPFx43iH18P5PGk=
X-Received: by 2002:a17:906:c14b:b0:6da:b30d:76a0 with SMTP id
 dp11-20020a170906c14b00b006dab30d76a0mr19915713ejc.279.1647296711838; Mon, 14
 Mar 2022 15:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
In-Reply-To: <20220311162445.346685-1-vincent.whitchurch@axis.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 14 Mar 2022 18:24:59 -0400
Message-ID: <CAFd5g45zwSNr-_PSbtGn1MiQgombSBTCjXOG-cvcQW8xQQUo+Q@mail.gmail.com>
Subject: Re: [RFC v1 00/10] roadtest: a driver testing framework
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kernel@axis.com,
        devicetree@vger.kernel.org, linux-um@lists.infradead.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        jic23@kernel.org, linux-iio@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+Kees Cook - I imagine you have already seen this, but I figured you
would be interested because of your recent work on the KUnit UAPI and
the mocking discussions.
+Dmitry Vyukov - This made me think of the syzkaller/KUnit experiments
we did a couple of years back - this would probably work a bit better.

On Fri, Mar 11, 2022 at 11:24 AM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> This patchset proposes roadtest, a device-driver testing framework.  Drivers
> are tested under User Mode Linux (UML) and interact with mocked/modelled
> hardware.  The tests and hardware models are written in Python, the former
> using Python's built-in unittest framework.

Wow! This sounds awesome! I was hoping to get some kind of hardware
modeling with KUnit eventually. I did some experiments, but this looks
way more mature.

> Drivers are tested via their userspace interfaces.  The hardware models allow
> tests to inject values into registers and assert that drivers control the
> hardware in the right way and react as expected to stimuli.

I already took a look at the documentation patch - I'll comment there
more in detail, but I like the hardware modelling and device tree
code; it seems very usable.

> Roadtest is meant to be used for relatively simple drivers, such as the ones
> part of the IIO, regulator and RTC subsystems.

Obviously for an initial version going after simple stuff makes sense,
but I would hope there is applicability to any driver stack
eventually.

> Questions and answers:
>
> = Why do we need this?
>
> There are a large amount of these kind of drivers in the kernel.  Most of the
> hardware is not available in current CI systems so most drivers can only, at
> best, be build-tested there.  Even basic soundness such as a driver
> successfully probing and binding to the devices it tries to be support cannot
> be tested.  Drivers cannot be easily regression-tested to ensure that bugs
> fixed once do not get reintroduced.
>
> Many drivers support multiple related hardware variants, and far from all patch
> submitters have access to all the variants which the driver that they are
> patching supports, so there is no way for them to easily verify that they
> haven't broken something basic on a variant which they do not own.
>
> Furthermore, hardware can be used in many different configurations with drivers
> supporting many different devicetree properties, so even just having access to
> all the variants would be insufficient.
>
> On top of that, some of the chips measure environmental conditions such as
> temperature, so testing extreme cases may not be simple even if one has access
> to the hardware.
>
> All this makes development, modification, maintenance, and reviewing of these
> drivers harder than it necessarily needs to be.  Roadtest hopes to make some of
> these things slightly easier by providing a framework to create hardware
> models/mocks and to write testcases which exercise drivers using these models.

Very much agree. I used to do driver development and these
difficulties are what prompted me to do KUnit.

> = Do you have some specific examples of the kind of code this could be used to
>   test?
>
> Here is an example of a patch which can easily be regression-tested using
> roadtest (in fact, this series includes such a regression test) but is much
> harder to do so automatically with real hardware since it requires specific
> environmental conditions:
>
>  iio: light: opt3001: Fixed timeout error when 0 lux
>  https://lore.kernel.org/lkml/20210920125351.6569-1-valek@2n.cz/
>
> Here is another example.  This driver has code which correctly parses a
> documented devicetree property (amstaos,proximity-diodes) but which then fails
> to actually communicate this setting to the hardware in any way.  Such code can
> be easily tested with roadtest since the framework integrates devicetree
> support and provides functions to assert that drivers writes expected registers
> with expected values:
>
>  drivers/iio/light/tsl2772.c tsl2772_read_prox_diodes()
>
> (Both the above examples happen to be from the same subsystem but that should
> in no way be taken to imply that such issues are unique to that subsystem or
> that that subsystem has more of them.)
>
> = How does this relate to kselftests?
>
> Tests in kselftests also test kernel code using the userspace interfaces, but
> that's about what's common between the frameworks.  kselftests has other goals
> and does not provide any kind of mechanism for hardware mocking.

I had a question that after thinking about it; I think I know the
answer, so I am going to ask the question anyway and attempt to answer
it myself:

I agree in regard to mocking, but why not use kselftest for driving
tests that check drivers from userspace? I believe there are other
kselftest tests implemented in Python, why can't you just run your
tests inside of kselftest?

Now, I believe the answer to this question is that you need to control
spinning up your own kernel to run inside your test harness because
you need to control the environment that the kernel runs in - is this
correct?

> = How does this relate to kunit?
>
> Kunit is for unit testing of functions in kernel code, and is not meant for
> testing kernel code via userspace interfaces.  It could in theory be used to
> test some of the simple drivers too, but that would require (1) a large amount
> of mocking code in various kernel frameworks, and, more importantly, (2)
> refactoring of the drivers to be tested.

I mostly agree, but I think there is something that is missing here:
so roadtest seems to depend on having a user interface to test a
driver - for a simple smoke test on a simple driver without a big
driver stack on top, that makes sense, but what about testing error
paths or a platform driver buried beneath a deep driver stack? I think
there is potential for a powerful combination using KUnit to test the
low level kernel API and using roadtest to mock the hardware
environment and provide configuration.

I am imagining that we could have an in-kernel KUnit/roadtest API that
we can use to have an in-kernel test request changes to the
environment for creating error cases and the like that can be
validated by KUnit test cases.

Going even further, I wonder if we could run kselftests inside of
roadtest since roadtest allows us to change the environment on the
fly.

> This can be contrasted with roadtest which works with mostly unmodified drivers
> and which mocks the hardware at the lowest level without having to change
> kernel frameworks.

I think that is both potentially an advantage and a disadvantage.

The advantage is that your test is very general; roadtests would
likely be portable across kernel versions.

The disadvantage is that you don't get as much code introspection: I
imagine roadtest is not as good as testing error paths for example.

I also think that having to change code to make it more testable is
often an advantage as much as a disadvantage.

Still, I think that is a good set of tradeoffs for roadtest to make
when set against KUnit and kselftest since roadtest seems to fit in
where kselftest and KUnit are weak.

> = How do I use it?
>
> See Documentation/dev-tools/roadtest.rst added by the documentation patch for
> more information about running and writing tests using this framework.
>
> = What's included in the patchset?
>
> The current framework allows developing tests for hardware which uses the I2C
> bus.  Hardware models can also control GPIOs and use them to trigger
> interrupts.
>
> This series includes tests for some IIO, regulator and RTC drivers.  The
> regulator and RTC tests depend on a few driver patches which are either in
> review or in linux-next.  These are noted in the commit messages.
>
> The entire patch set, including the required dependencies, is also available in
> a git tree:
>
>  https://github.com/vwax/linux/commits/roadtest/rfc-v1
>
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-um@lists.infradead.org
>
> Cc: shuah@kernel.org
> Cc: brendanhiggins@google.com
> Cc: linux-kselftest@vger.kernel.org
>
> Cc: jic23@kernel.org
> Cc: linux-iio@vger.kernel.org
>
> Cc: lgirdwood@gmail.com
> Cc: broonie@kernel.org
>
> Cc: a.zummo@towertech.it
> Cc: alexandre.belloni@bootlin.com
> Cc: linux-rtc@vger.kernel.org
>
> Cc: corbet@lwn.net
> Cc: linux-doc@vger.kernel.org
>
> Vincent Whitchurch (10):
>   roadtest: import libvhost-user from QEMU
>   roadtest: add C backend
>   roadtest: add framework
>   roadtest: add base config
>   roadtest: add build files
>   roadtest: add documentation
>   iio: light: opt3001: add roadtest
>   iio: light: vcnl4000: add roadtest
>   regulator: tps62864: add roadtest
>   rtc: pcf8563: add roadtest
>
>  Documentation/dev-tools/index.rst             |    1 +
>  Documentation/dev-tools/roadtest.rst          |  669 ++++
>  tools/testing/roadtest/.gitignore             |    2 +
>  tools/testing/roadtest/Dockerfile             |   25 +
>  tools/testing/roadtest/Makefile               |   84 +
>  tools/testing/roadtest/init.sh                |   19 +
>  tools/testing/roadtest/pyproject.toml         |   10 +
>  tools/testing/roadtest/requirements.txt       |    4 +
>  tools/testing/roadtest/roadtest/__init__.py   |    2 +
>  .../roadtest/roadtest/backend/__init__.py     |    0
>  .../roadtest/roadtest/backend/backend.py      |   32 +
>  .../testing/roadtest/roadtest/backend/gpio.py |  111 +
>  .../testing/roadtest/roadtest/backend/i2c.py  |  123 +
>  .../testing/roadtest/roadtest/backend/main.py |   13 +
>  .../testing/roadtest/roadtest/backend/mock.py |   20 +
>  .../roadtest/roadtest/backend/test_gpio.py    |   98 +
>  .../roadtest/roadtest/backend/test_i2c.py     |   84 +
>  .../testing/roadtest/roadtest/cmd/__init__.py |    0
>  tools/testing/roadtest/roadtest/cmd/main.py   |  146 +
>  tools/testing/roadtest/roadtest/cmd/remote.py |   48 +
>  .../roadtest/roadtest/core/__init__.py        |    0
>  .../testing/roadtest/roadtest/core/control.py |   52 +
>  .../roadtest/roadtest/core/devicetree.py      |  155 +
>  .../roadtest/roadtest/core/hardware.py        |   94 +
>  tools/testing/roadtest/roadtest/core/log.py   |   42 +
>  .../testing/roadtest/roadtest/core/modules.py |   38 +
>  .../testing/roadtest/roadtest/core/opslog.py  |   35 +
>  tools/testing/roadtest/roadtest/core/proxy.py |   48 +
>  tools/testing/roadtest/roadtest/core/suite.py |  286 ++
>  tools/testing/roadtest/roadtest/core/sysfs.py |   77 +
>  .../roadtest/roadtest/core/test_control.py    |   35 +
>  .../roadtest/roadtest/core/test_devicetree.py |   31 +
>  .../roadtest/roadtest/core/test_hardware.py   |   41 +
>  .../roadtest/roadtest/core/test_log.py        |   54 +
>  .../roadtest/roadtest/core/test_opslog.py     |   27 +
>  .../roadtest/roadtest/tests/__init__.py       |    0
>  .../roadtest/roadtest/tests/base/config       |   84 +
>  .../roadtest/roadtest/tests/iio/__init__.py   |    0
>  .../roadtest/roadtest/tests/iio/config        |    1 +
>  .../roadtest/roadtest/tests/iio/iio.py        |  112 +
>  .../roadtest/tests/iio/light/__init__.py      |    0
>  .../roadtest/roadtest/tests/iio/light/config  |    2 +
>  .../roadtest/tests/iio/light/test_opt3001.py  |   95 +
>  .../roadtest/tests/iio/light/test_vcnl4000.py |  132 +
>  .../roadtest/tests/iio/light/test_vcnl4010.py |  282 ++
>  .../roadtest/tests/iio/light/test_vcnl4040.py |  104 +
>  .../roadtest/tests/iio/light/test_vcnl4200.py |   96 +
>  .../roadtest/tests/regulator/__init__.py      |    0
>  .../roadtest/roadtest/tests/regulator/config  |    4 +
>  .../roadtest/tests/regulator/test_tps62864.py |  187 ++
>  .../roadtest/roadtest/tests/rtc/__init__.py   |    0
>  .../roadtest/roadtest/tests/rtc/config        |    1 +
>  .../roadtest/roadtest/tests/rtc/rtc.py        |   73 +
>  .../roadtest/tests/rtc/test_pcf8563.py        |  348 ++
>  tools/testing/roadtest/src/.gitignore         |    1 +
>  tools/testing/roadtest/src/backend.c          |  884 +++++
>  .../src/libvhost-user/include/atomic.h        |  310 ++
>  .../src/libvhost-user/libvhost-user.c         | 2885 +++++++++++++++++
>  .../src/libvhost-user/libvhost-user.h         |  691 ++++
>  59 files changed, 8798 insertions(+)
>  create mode 100644 Documentation/dev-tools/roadtest.rst
>  create mode 100644 tools/testing/roadtest/.gitignore
>  create mode 100644 tools/testing/roadtest/Dockerfile
>  create mode 100644 tools/testing/roadtest/Makefile
>  create mode 100755 tools/testing/roadtest/init.sh
>  create mode 100644 tools/testing/roadtest/pyproject.toml
>  create mode 100644 tools/testing/roadtest/requirements.txt
>  create mode 100644 tools/testing/roadtest/roadtest/__init__.py
>  create mode 100644 tools/testing/roadtest/roadtest/backend/__init__.py
>  create mode 100644 tools/testing/roadtest/roadtest/backend/backend.py
>  create mode 100644 tools/testing/roadtest/roadtest/backend/gpio.py
>  create mode 100644 tools/testing/roadtest/roadtest/backend/i2c.py
>  create mode 100644 tools/testing/roadtest/roadtest/backend/main.py
>  create mode 100644 tools/testing/roadtest/roadtest/backend/mock.py
>  create mode 100644 tools/testing/roadtest/roadtest/backend/test_gpio.py
>  create mode 100644 tools/testing/roadtest/roadtest/backend/test_i2c.py
>  create mode 100644 tools/testing/roadtest/roadtest/cmd/__init__.py
>  create mode 100644 tools/testing/roadtest/roadtest/cmd/main.py
>  create mode 100644 tools/testing/roadtest/roadtest/cmd/remote.py
>  create mode 100644 tools/testing/roadtest/roadtest/core/__init__.py
>  create mode 100644 tools/testing/roadtest/roadtest/core/control.py
>  create mode 100644 tools/testing/roadtest/roadtest/core/devicetree.py
>  create mode 100644 tools/testing/roadtest/roadtest/core/hardware.py
>  create mode 100644 tools/testing/roadtest/roadtest/core/log.py
>  create mode 100644 tools/testing/roadtest/roadtest/core/modules.py
>  create mode 100644 tools/testing/roadtest/roadtest/core/opslog.py
>  create mode 100644 tools/testing/roadtest/roadtest/core/proxy.py
>  create mode 100644 tools/testing/roadtest/roadtest/core/suite.py
>  create mode 100644 tools/testing/roadtest/roadtest/core/sysfs.py
>  create mode 100644 tools/testing/roadtest/roadtest/core/test_control.py
>  create mode 100644 tools/testing/roadtest/roadtest/core/test_devicetree.py
>  create mode 100644 tools/testing/roadtest/roadtest/core/test_hardware.py
>  create mode 100644 tools/testing/roadtest/roadtest/core/test_log.py
>  create mode 100644 tools/testing/roadtest/roadtest/core/test_opslog.py
>  create mode 100644 tools/testing/roadtest/roadtest/tests/__init__.py
>  create mode 100644 tools/testing/roadtest/roadtest/tests/base/config
>  create mode 100644 tools/testing/roadtest/roadtest/tests/iio/__init__.py
>  create mode 100644 tools/testing/roadtest/roadtest/tests/iio/config
>  create mode 100644 tools/testing/roadtest/roadtest/tests/iio/iio.py
>  create mode 100644 tools/testing/roadtest/roadtest/tests/iio/light/__init__.py
>  create mode 100644 tools/testing/roadtest/roadtest/tests/iio/light/config
>  create mode 100644 tools/testing/roadtest/roadtest/tests/iio/light/test_opt3001.py
>  create mode 100644 tools/testing/roadtest/roadtest/tests/iio/light/test_vcnl4000.py
>  create mode 100644 tools/testing/roadtest/roadtest/tests/iio/light/test_vcnl4010.py
>  create mode 100644 tools/testing/roadtest/roadtest/tests/iio/light/test_vcnl4040.py
>  create mode 100644 tools/testing/roadtest/roadtest/tests/iio/light/test_vcnl4200.py
>  create mode 100644 tools/testing/roadtest/roadtest/tests/regulator/__init__.py
>  create mode 100644 tools/testing/roadtest/roadtest/tests/regulator/config
>  create mode 100644 tools/testing/roadtest/roadtest/tests/regulator/test_tps62864.py
>  create mode 100644 tools/testing/roadtest/roadtest/tests/rtc/__init__.py
>  create mode 100644 tools/testing/roadtest/roadtest/tests/rtc/config
>  create mode 100644 tools/testing/roadtest/roadtest/tests/rtc/rtc.py
>  create mode 100644 tools/testing/roadtest/roadtest/tests/rtc/test_pcf8563.py
>  create mode 100644 tools/testing/roadtest/src/.gitignore
>  create mode 100644 tools/testing/roadtest/src/backend.c
>  create mode 100644 tools/testing/roadtest/src/libvhost-user/include/atomic.h
>  create mode 100644 tools/testing/roadtest/src/libvhost-user/libvhost-user.c
>  create mode 100644 tools/testing/roadtest/src/libvhost-user/libvhost-user.h
>
> --
> 2.34.1
>
