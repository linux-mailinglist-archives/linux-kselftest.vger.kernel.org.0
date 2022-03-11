Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F104D661D
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Mar 2022 17:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350403AbiCKQ0t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 11:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350342AbiCKQ0g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 11:26:36 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F41F1B8BF7;
        Fri, 11 Mar 2022 08:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1647015902;
  x=1678551902;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eqHYnpjKDOMF1TwiA1Bf1WVBNshhdDSbtR3z1p21pAk=;
  b=LkpaT22z9yzvNZbzx0/U1CPCP2w2+HflUInWlFPV5q44tzUtQbOhBmWT
   LJVC/RPbvDDO9siDFpGN6BLms1CZOz6Ab+h0tZFH2O2hTk7Pi/Mqu39yg
   alOd7kEXNLs6jq6a6zuQGQfLvzlF69e0m0vT/q+TBmlntQW7A+Lp3y7b3
   WAJSlvzconIXizP5VIR0cIs1t+WnsIvIndtVhFaGkpcpu0xuxeVwMfPXR
   369R4GwH+Qjsx/4JHbFoy6SuHzeFqMj7Om0gZ1VCBCLZrrTE8396ujnCT
   7UD6NFa/9w2g2PWK7MD+nZUHRnkVKjEUxUl3VMnsSIN8wzx70y/K5MKaQ
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <devicetree@vger.kernel.org>, <linux-um@lists.infradead.org>,
        <shuah@kernel.org>, <brendanhiggins@google.com>,
        <linux-kselftest@vger.kernel.org>, <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <linux-rtc@vger.kernel.org>,
        <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: [RFC v1 00/10] roadtest: a driver testing framework
Date:   Fri, 11 Mar 2022 17:24:35 +0100
Message-ID: <20220311162445.346685-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patchset proposes roadtest, a device-driver testing framework.  Drivers
are tested under User Mode Linux (UML) and interact with mocked/modelled
hardware.  The tests and hardware models are written in Python, the former
using Python's built-in unittest framework.

Drivers are tested via their userspace interfaces.  The hardware models allow
tests to inject values into registers and assert that drivers control the
hardware in the right way and react as expected to stimuli.

Roadtest is meant to be used for relatively simple drivers, such as the ones
part of the IIO, regulator and RTC subsystems.

Questions and answers:

= Why do we need this?

There are a large amount of these kind of drivers in the kernel.  Most of the
hardware is not available in current CI systems so most drivers can only, at
best, be build-tested there.  Even basic soundness such as a driver
successfully probing and binding to the devices it tries to be support cannot
be tested.  Drivers cannot be easily regression-tested to ensure that bugs
fixed once do not get reintroduced.

Many drivers support multiple related hardware variants, and far from all patch
submitters have access to all the variants which the driver that they are
patching supports, so there is no way for them to easily verify that they
haven't broken something basic on a variant which they do not own.

Furthermore, hardware can be used in many different configurations with drivers
supporting many different devicetree properties, so even just having access to
all the variants would be insufficient.

On top of that, some of the chips measure environmental conditions such as
temperature, so testing extreme cases may not be simple even if one has access
to the hardware.

All this makes development, modification, maintenance, and reviewing of these
drivers harder than it necessarily needs to be.  Roadtest hopes to make some of
these things slightly easier by providing a framework to create hardware
models/mocks and to write testcases which exercise drivers using these models.

= Do you have some specific examples of the kind of code this could be used to
  test?

Here is an example of a patch which can easily be regression-tested using
roadtest (in fact, this series includes such a regression test) but is much
harder to do so automatically with real hardware since it requires specific
environmental conditions:

 iio: light: opt3001: Fixed timeout error when 0 lux
 https://lore.kernel.org/lkml/20210920125351.6569-1-valek@2n.cz/

Here is another example.  This driver has code which correctly parses a
documented devicetree property (amstaos,proximity-diodes) but which then fails
to actually communicate this setting to the hardware in any way.  Such code can
be easily tested with roadtest since the framework integrates devicetree
support and provides functions to assert that drivers writes expected registers
with expected values:

 drivers/iio/light/tsl2772.c tsl2772_read_prox_diodes()

(Both the above examples happen to be from the same subsystem but that should
in no way be taken to imply that such issues are unique to that subsystem or
that that subsystem has more of them.)

= How does this relate to kselftests?

Tests in kselftests also test kernel code using the userspace interfaces, but
that's about what's common between the frameworks.  kselftests has other goals
and does not provide any kind of mechanism for hardware mocking.

= How does this relate to kunit?

Kunit is for unit testing of functions in kernel code, and is not meant for
testing kernel code via userspace interfaces.  It could in theory be used to
test some of the simple drivers too, but that would require (1) a large amount
of mocking code in various kernel frameworks, and, more importantly, (2)
refactoring of the drivers to be tested.

This can be contrasted with roadtest which works with mostly unmodified drivers
and which mocks the hardware at the lowest level without having to change
kernel frameworks.

= How do I use it?

See Documentation/dev-tools/roadtest.rst added by the documentation patch for
more information about running and writing tests using this framework.

= What's included in the patchset?

The current framework allows developing tests for hardware which uses the I2C
bus.  Hardware models can also control GPIOs and use them to trigger
interrupts.

This series includes tests for some IIO, regulator and RTC drivers.  The
regulator and RTC tests depend on a few driver patches which are either in
review or in linux-next.  These are noted in the commit messages.

The entire patch set, including the required dependencies, is also available in
a git tree:

 https://github.com/vwax/linux/commits/roadtest/rfc-v1

Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-um@lists.infradead.org

Cc: shuah@kernel.org
Cc: brendanhiggins@google.com
Cc: linux-kselftest@vger.kernel.org

Cc: jic23@kernel.org
Cc: linux-iio@vger.kernel.org

Cc: lgirdwood@gmail.com
Cc: broonie@kernel.org

Cc: a.zummo@towertech.it
Cc: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org

Cc: corbet@lwn.net
Cc: linux-doc@vger.kernel.org

Vincent Whitchurch (10):
  roadtest: import libvhost-user from QEMU
  roadtest: add C backend
  roadtest: add framework
  roadtest: add base config
  roadtest: add build files
  roadtest: add documentation
  iio: light: opt3001: add roadtest
  iio: light: vcnl4000: add roadtest
  regulator: tps62864: add roadtest
  rtc: pcf8563: add roadtest

 Documentation/dev-tools/index.rst             |    1 +
 Documentation/dev-tools/roadtest.rst          |  669 ++++
 tools/testing/roadtest/.gitignore             |    2 +
 tools/testing/roadtest/Dockerfile             |   25 +
 tools/testing/roadtest/Makefile               |   84 +
 tools/testing/roadtest/init.sh                |   19 +
 tools/testing/roadtest/pyproject.toml         |   10 +
 tools/testing/roadtest/requirements.txt       |    4 +
 tools/testing/roadtest/roadtest/__init__.py   |    2 +
 .../roadtest/roadtest/backend/__init__.py     |    0
 .../roadtest/roadtest/backend/backend.py      |   32 +
 .../testing/roadtest/roadtest/backend/gpio.py |  111 +
 .../testing/roadtest/roadtest/backend/i2c.py  |  123 +
 .../testing/roadtest/roadtest/backend/main.py |   13 +
 .../testing/roadtest/roadtest/backend/mock.py |   20 +
 .../roadtest/roadtest/backend/test_gpio.py    |   98 +
 .../roadtest/roadtest/backend/test_i2c.py     |   84 +
 .../testing/roadtest/roadtest/cmd/__init__.py |    0
 tools/testing/roadtest/roadtest/cmd/main.py   |  146 +
 tools/testing/roadtest/roadtest/cmd/remote.py |   48 +
 .../roadtest/roadtest/core/__init__.py        |    0
 .../testing/roadtest/roadtest/core/control.py |   52 +
 .../roadtest/roadtest/core/devicetree.py      |  155 +
 .../roadtest/roadtest/core/hardware.py        |   94 +
 tools/testing/roadtest/roadtest/core/log.py   |   42 +
 .../testing/roadtest/roadtest/core/modules.py |   38 +
 .../testing/roadtest/roadtest/core/opslog.py  |   35 +
 tools/testing/roadtest/roadtest/core/proxy.py |   48 +
 tools/testing/roadtest/roadtest/core/suite.py |  286 ++
 tools/testing/roadtest/roadtest/core/sysfs.py |   77 +
 .../roadtest/roadtest/core/test_control.py    |   35 +
 .../roadtest/roadtest/core/test_devicetree.py |   31 +
 .../roadtest/roadtest/core/test_hardware.py   |   41 +
 .../roadtest/roadtest/core/test_log.py        |   54 +
 .../roadtest/roadtest/core/test_opslog.py     |   27 +
 .../roadtest/roadtest/tests/__init__.py       |    0
 .../roadtest/roadtest/tests/base/config       |   84 +
 .../roadtest/roadtest/tests/iio/__init__.py   |    0
 .../roadtest/roadtest/tests/iio/config        |    1 +
 .../roadtest/roadtest/tests/iio/iio.py        |  112 +
 .../roadtest/tests/iio/light/__init__.py      |    0
 .../roadtest/roadtest/tests/iio/light/config  |    2 +
 .../roadtest/tests/iio/light/test_opt3001.py  |   95 +
 .../roadtest/tests/iio/light/test_vcnl4000.py |  132 +
 .../roadtest/tests/iio/light/test_vcnl4010.py |  282 ++
 .../roadtest/tests/iio/light/test_vcnl4040.py |  104 +
 .../roadtest/tests/iio/light/test_vcnl4200.py |   96 +
 .../roadtest/tests/regulator/__init__.py      |    0
 .../roadtest/roadtest/tests/regulator/config  |    4 +
 .../roadtest/tests/regulator/test_tps62864.py |  187 ++
 .../roadtest/roadtest/tests/rtc/__init__.py   |    0
 .../roadtest/roadtest/tests/rtc/config        |    1 +
 .../roadtest/roadtest/tests/rtc/rtc.py        |   73 +
 .../roadtest/tests/rtc/test_pcf8563.py        |  348 ++
 tools/testing/roadtest/src/.gitignore         |    1 +
 tools/testing/roadtest/src/backend.c          |  884 +++++
 .../src/libvhost-user/include/atomic.h        |  310 ++
 .../src/libvhost-user/libvhost-user.c         | 2885 +++++++++++++++++
 .../src/libvhost-user/libvhost-user.h         |  691 ++++
 59 files changed, 8798 insertions(+)
 create mode 100644 Documentation/dev-tools/roadtest.rst
 create mode 100644 tools/testing/roadtest/.gitignore
 create mode 100644 tools/testing/roadtest/Dockerfile
 create mode 100644 tools/testing/roadtest/Makefile
 create mode 100755 tools/testing/roadtest/init.sh
 create mode 100644 tools/testing/roadtest/pyproject.toml
 create mode 100644 tools/testing/roadtest/requirements.txt
 create mode 100644 tools/testing/roadtest/roadtest/__init__.py
 create mode 100644 tools/testing/roadtest/roadtest/backend/__init__.py
 create mode 100644 tools/testing/roadtest/roadtest/backend/backend.py
 create mode 100644 tools/testing/roadtest/roadtest/backend/gpio.py
 create mode 100644 tools/testing/roadtest/roadtest/backend/i2c.py
 create mode 100644 tools/testing/roadtest/roadtest/backend/main.py
 create mode 100644 tools/testing/roadtest/roadtest/backend/mock.py
 create mode 100644 tools/testing/roadtest/roadtest/backend/test_gpio.py
 create mode 100644 tools/testing/roadtest/roadtest/backend/test_i2c.py
 create mode 100644 tools/testing/roadtest/roadtest/cmd/__init__.py
 create mode 100644 tools/testing/roadtest/roadtest/cmd/main.py
 create mode 100644 tools/testing/roadtest/roadtest/cmd/remote.py
 create mode 100644 tools/testing/roadtest/roadtest/core/__init__.py
 create mode 100644 tools/testing/roadtest/roadtest/core/control.py
 create mode 100644 tools/testing/roadtest/roadtest/core/devicetree.py
 create mode 100644 tools/testing/roadtest/roadtest/core/hardware.py
 create mode 100644 tools/testing/roadtest/roadtest/core/log.py
 create mode 100644 tools/testing/roadtest/roadtest/core/modules.py
 create mode 100644 tools/testing/roadtest/roadtest/core/opslog.py
 create mode 100644 tools/testing/roadtest/roadtest/core/proxy.py
 create mode 100644 tools/testing/roadtest/roadtest/core/suite.py
 create mode 100644 tools/testing/roadtest/roadtest/core/sysfs.py
 create mode 100644 tools/testing/roadtest/roadtest/core/test_control.py
 create mode 100644 tools/testing/roadtest/roadtest/core/test_devicetree.py
 create mode 100644 tools/testing/roadtest/roadtest/core/test_hardware.py
 create mode 100644 tools/testing/roadtest/roadtest/core/test_log.py
 create mode 100644 tools/testing/roadtest/roadtest/core/test_opslog.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/__init__.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/base/config
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/__init__.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/config
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/iio.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/light/__init__.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/light/config
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/light/test_opt3001.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/light/test_vcnl4000.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/light/test_vcnl4010.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/light/test_vcnl4040.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/light/test_vcnl4200.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/regulator/__init__.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/regulator/config
 create mode 100644 tools/testing/roadtest/roadtest/tests/regulator/test_tps62864.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/rtc/__init__.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/rtc/config
 create mode 100644 tools/testing/roadtest/roadtest/tests/rtc/rtc.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/rtc/test_pcf8563.py
 create mode 100644 tools/testing/roadtest/src/.gitignore
 create mode 100644 tools/testing/roadtest/src/backend.c
 create mode 100644 tools/testing/roadtest/src/libvhost-user/include/atomic.h
 create mode 100644 tools/testing/roadtest/src/libvhost-user/libvhost-user.c
 create mode 100644 tools/testing/roadtest/src/libvhost-user/libvhost-user.h

-- 
2.34.1

