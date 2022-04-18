Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AB7505E93
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Apr 2022 21:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbiDRTjR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Apr 2022 15:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbiDRTjQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Apr 2022 15:39:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0207D2253E;
        Mon, 18 Apr 2022 12:36:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8014660F4C;
        Mon, 18 Apr 2022 19:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABB6C385A1;
        Mon, 18 Apr 2022 19:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650310594;
        bh=opzS18o5uGo1m62aHvckfPRKloulevt82wvVatdoqkI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bTS++/LBgUArGQcmlnk2ZSEarRQ2VYdY2emsKfwjGxkfFW/wj2X50clQiGWNFcFEH
         nFWhe4kcTK12gAW2xPWT5Gb3EplV60ofv9+50uTL5rUzZZ//YMWhvwTULbYiJLGQc1
         Jnxkp2nGj7sBGfKdeobNN07tvq6u65YFBE8YzC1Pn2QfcwhpqVmdGNAgCk1919vaQ6
         2Eiqs9ednFsSjZZp5furQH9dZ7DSPfAPcC7PvvAshzmsHQkN90zs7T0X2ZgoUmkqHQ
         V4iRWqBTc11BaQYxEw43rg79iFGCBIIn6ymKvmp5gGFKw3M8tOxR4t4a12RwWNOBpd
         NMRV8fTipKIng==
Date:   Mon, 18 Apr 2022 20:44:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        <devicetree@vger.kernel.org>, <linux-um@lists.infradead.org>,
        <shuah@kernel.org>, <brendanhiggins@google.com>,
        <linux-kselftest@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <linux-rtc@vger.kernel.org>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
Subject: Re: [RFC v1 00/10] roadtest: a driver testing framework
Message-ID: <20220418204430.2e6f2553@jic23-huawei>
In-Reply-To: <20220311162445.346685-1-vincent.whitchurch@axis.com>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 11 Mar 2022 17:24:35 +0100
Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:

> This patchset proposes roadtest, a device-driver testing framework.  Drivers
> are tested under User Mode Linux (UML) and interact with mocked/modelled
> hardware.  The tests and hardware models are written in Python, the former
> using Python's built-in unittest framework.
> 
> Drivers are tested via their userspace interfaces.  The hardware models allow
> tests to inject values into registers and assert that drivers control the
> hardware in the right way and react as expected to stimuli.
> 
> Roadtest is meant to be used for relatively simple drivers, such as the ones
> part of the IIO, regulator and RTC subsystems.

Hi All,

Just wanted to very briefly report back on my experience of using this framework.

Given I wanted a suitable job to try out it's usefulness when doing refactoring
/development, I decided to tidy up one of the remaining IIO drivers in staging
and see how things went in developing tests to hit the particular code I was
modifying.  At some point I might extend this to a more comprehensive test suite
for that driver, but for now it does basic channel reading and a few other things
+ verifies some of the register state changes seen on the hardware side of things.

Whilst my python could be said to be decidedly rusty (last time I recall writing
some was for an intern project 20 years back), it was fairly easy to get something
working using the docs in this series and the fine engineering tool of cut and paste.

Road test worked very well.

Was it easier than my existing hacked up QEMU board emulation that lets me
instantiate minimal emulation pretty quickly?

Pretty similar on balance but big advantage here is I'm not having to ask people
to go fetch a tree and build QEMU just to sanity check the driver changes.
Also note I'm doing a lot of QEMU work for the day job at the moment, so it's not
really a fair comparison if the question is what would most kernel driver
developers find useful.

So for now I'll probably mix and match depending on the complexity of the device
I'm emulating, but roadtest is definitely a good addition to the toolkit.

Note this is putting aside all the advantages of having tests in tree and the
much lighter amount of infrastructure needed to run those over QEMU CI.

If anyone is curious patch set with tests and the staging graduation of
the AD7746 CDC driver.

https://lore.kernel.org/all/20220418192907.763933-18-jic23@kernel.org/

Great work Vincent. I'm looking forward to using this more.

Thanks,

Jonathan

> 
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
> 
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
> 
> = How does this relate to kunit?
> 
> Kunit is for unit testing of functions in kernel code, and is not meant for
> testing kernel code via userspace interfaces.  It could in theory be used to
> test some of the simple drivers too, but that would require (1) a large amount
> of mocking code in various kernel frameworks, and, more importantly, (2)
> refactoring of the drivers to be tested.
> 
> This can be contrasted with roadtest which works with mostly unmodified drivers
> and which mocks the hardware at the lowest level without having to change
> kernel frameworks.
> 
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

