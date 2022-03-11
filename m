Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449D04D6655
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Mar 2022 17:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344223AbiCKQ3t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 11:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350558AbiCKQ14 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 11:27:56 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10B51D529E;
        Fri, 11 Mar 2022 08:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1647015977;
  x=1678551977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mFUerXsYecLMbfF90aqK9kLZr/AsxHAsijhoN1YRpYE=;
  b=E51iE8mo73xG45s6o3lJCeIESUQx03qmsA4jvTlpN/FHgFnYzLtCciuI
   Y6u1gU0icDErxJ2e2SImtEqMYiNTSORUH9gYBXKzOAm9P7fZdi2oqIp1l
   HLwS2c0pNDcGSaDm81ETNrSS48V6zCfIhbU+uFWYMgu6DCZpD8RRgVlHi
   8cytBP8KeYjKt5tDr05GrWzPsISpKGijhvh9DeKsZRbp3doArhMzSb+PW
   8hAug48G7Q9h16Q5sblPxP0BnHO/+6QcEDImzdBiwWeFNYN9vhcbIP24V
   9lHRLDgrb4yX3QY9tpCf4JfGJQm0tGgg5C6eix/HVJoaMzeP4ICUmZIz8
   w==;
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
Subject: [RFC v1 10/10] rtc: pcf8563: add roadtest
Date:   Fri, 11 Mar 2022 17:24:45 +0100
Message-ID: <20220311162445.346685-11-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220311162445.346685-1-vincent.whitchurch@axis.com>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a roadtest for the PCF8563 RTC driver, testing many of the features
including alarm and invalid time handling.  Since it's the first
roadtest for RTC, some helper code for handling the ABI is included.

The following fixes were posted for problems identified during
development of these tests:

 - rtc: fix use-after-free on device removal
   https://lore.kernel.org/lkml/20211210160951.7718-1-vincent.whitchurch@axis.com/

 - rtc: pcf8563: clear RTC_FEATURE_ALARM if no irq
   https://lore.kernel.org/lkml/20220301131220.4011810-1-vincent.whitchurch@axis.com/

 - rtc: pcf8523: fix alarm interrupt disabling
   https://lore.kernel.org/lkml/20211103152253.22844-1-vincent.whitchurch@axis.com/
   (not the same hardware/driver, but this was the original target for
    test development)

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 .../roadtest/roadtest/tests/rtc/__init__.py   |   0
 .../roadtest/roadtest/tests/rtc/config        |   1 +
 .../roadtest/roadtest/tests/rtc/rtc.py        |  73 ++++
 .../roadtest/tests/rtc/test_pcf8563.py        | 348 ++++++++++++++++++
 4 files changed, 422 insertions(+)
 create mode 100644 tools/testing/roadtest/roadtest/tests/rtc/__init__.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/rtc/config
 create mode 100644 tools/testing/roadtest/roadtest/tests/rtc/rtc.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/rtc/test_pcf8563.py

diff --git a/tools/testing/roadtest/roadtest/tests/rtc/__init__.py b/tools/testing/roadtest/roadtest/tests/rtc/__init__.py
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/testing/roadtest/roadtest/tests/rtc/config b/tools/testing/roadtest/roadtest/tests/rtc/config
new file mode 100644
index 000000000000..f3654f9d7c19
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/tests/rtc/config
@@ -0,0 +1 @@
+CONFIG_RTC_DRV_PCF8563=m
diff --git a/tools/testing/roadtest/roadtest/tests/rtc/rtc.py b/tools/testing/roadtest/roadtest/tests/rtc/rtc.py
new file mode 100644
index 000000000000..1a2855bfc195
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/tests/rtc/rtc.py
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+import contextlib
+import fcntl
+import struct
+import typing
+from pathlib import Path
+from typing import Any, cast
+
+RTC_RD_TIME = 0x80247009
+RTC_SET_TIME = 0x4024700A
+RTC_WKALM_SET = 0x4028700F
+RTC_VL_READ = 0x80047013
+
+RTC_IRQF = 0x80
+RTC_AF = 0x20
+
+RTC_VL_DATA_INVALID = 1 << 0
+
+
+class RTCTime(typing.NamedTuple):
+    tm_sec: int
+    tm_min: int
+    tm_hour: int
+    tm_mday: int
+    tm_mon: int
+    tm_year: int
+    tm_wday: int
+    tm_yday: int
+    tm_isdst: int
+
+
+class RTC(contextlib.AbstractContextManager):
+    def __init__(self, devpath: Path) -> None:
+        rtc = next(devpath.glob("rtc/rtc*")).name
+        self.filename = f"/dev/{rtc}"
+
+    def __enter__(self) -> "RTC":
+        self.file = open(self.filename, "rb")
+        return self
+
+    def __exit__(self, *_: Any) -> None:
+        self.file.close()
+
+    def read_time(self) -> RTCTime:
+        s = struct.Struct("9i")
+        buf = bytearray(s.size)
+        fcntl.ioctl(self.file.fileno(), RTC_RD_TIME, buf)
+        return RTCTime._make(s.unpack(buf))
+
+    def set_time(self, tm: RTCTime) -> int:
+        s = struct.Struct("9i")
+        buf = bytearray(s.size)
+        s.pack_into(buf, 0, *tm)
+        return fcntl.ioctl(self.file.fileno(), RTC_SET_TIME, buf)
+
+    def set_wake_alarm(self, enabled: bool, time: RTCTime) -> int:
+        s = struct.Struct("2B9i")
+        buf = bytearray(s.size)
+        s.pack_into(buf, 0, enabled, False, *time)
+        return fcntl.ioctl(self.file.fileno(), RTC_WKALM_SET, buf)
+
+    def read(self) -> int:
+        s = struct.Struct("L")
+        buf = self.file.read(s.size)
+        return cast(int, s.unpack(buf)[0])
+
+    def read_vl(self) -> int:
+        s = struct.Struct("I")
+        buf = bytearray(s.size)
+        fcntl.ioctl(self.file.fileno(), RTC_VL_READ, buf)
+        return cast(int, s.unpack(buf)[0])
diff --git a/tools/testing/roadtest/roadtest/tests/rtc/test_pcf8563.py b/tools/testing/roadtest/roadtest/tests/rtc/test_pcf8563.py
new file mode 100644
index 000000000000..a9f4c6d92762
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/tests/rtc/test_pcf8563.py
@@ -0,0 +1,348 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+import errno
+import logging
+from typing import Any, Final, Optional
+
+from roadtest.backend.i2c import I2CModel
+from roadtest.core.devicetree import DtFragment, DtVar
+from roadtest.core.hardware import Hardware
+from roadtest.core.modules import insmod
+from roadtest.core.suite import UMLTestCase
+from roadtest.core.sysfs import I2CDriver
+
+from . import rtc
+
+logger = logging.getLogger(__name__)
+
+REG_CONTROL_STATUS_1: Final = 0x00
+REG_CONTROL_STATUS_2: Final = 0x01
+REG_VL_SECONDS: Final = 0x02
+REG_VL_MINUTES: Final = 0x03
+REG_VL_HOURS: Final = 0x04
+REG_VL_DAYS: Final = 0x05
+REG_VL_WEEKDAYS: Final = 0x06
+REG_VL_CENTURY_MONTHS: Final = 0x07
+REG_VL_YEARS: Final = 0x08
+REG_VL_MINUTE_ALARM: Final = 0x09
+REG_VL_HOUR_ALARM: Final = 0x0A
+REG_VL_DAY_ALARM: Final = 0x0B
+REG_VL_WEEKDAY_ALARM: Final = 0x0C
+REG_CLKOUT_CONTROL: Final = 0x0D
+REG_TIMER_CONTROL: Final = 0x0E
+REG_TIMER: Final = 0x0F
+
+REG_CONTROL_STATUS_2_AIE: Final = 1 << 1
+REG_CONTROL_STATUS_2_AF: Final = 1 << 3
+
+REG_VL_CENTURY_MONTHS_C: Final = 1 << 7
+
+REG_VL_ALARM_AE: Final = 1 << 7
+
+
+class PCF8563(I2CModel):
+    def __init__(self, int: Optional[int] = None, **kwargs: Any) -> None:
+        super().__init__(**kwargs)
+        self.int = int
+        self._set_int(False)
+
+        self.reg_addr = 0
+        # Reset values from Table 27 in datasheet, with X and - bits set to 0
+        self.regs = {
+            REG_CONTROL_STATUS_1: 0b_0000_1000,
+            REG_CONTROL_STATUS_2: 0b_0000_0000,
+            REG_VL_SECONDS: 0b_1000_0000,
+            REG_VL_MINUTES: 0b_0000_0000,
+            REG_VL_HOURS: 0b_0000_0000,
+            REG_VL_DAYS: 0b_0000_0000,
+            REG_VL_WEEKDAYS: 0b_0000_0000,
+            REG_VL_CENTURY_MONTHS: 0b_0000_0000,
+            REG_VL_YEARS: 0b_0000_0000,
+            REG_VL_MINUTE_ALARM: 0b_1000_0000,
+            REG_VL_HOUR_ALARM: 0b_1000_0000,
+            REG_VL_DAY_ALARM: 0b_1000_0000,
+            REG_VL_WEEKDAY_ALARM: 0b_1000_0000,
+            REG_CLKOUT_CONTROL: 0b_1000_0000,
+            REG_TIMER_CONTROL: 0b_0000_0011,
+            REG_TIMER: 0b_0000_0000,
+        }
+
+    def _set_int(self, active: int) -> None:
+        # Active-low
+        self.backend.gpio.set(self.int, not active)
+
+    def _check_alarm(self, addr: int) -> None:
+        alarmregs = [
+            REG_VL_MINUTE_ALARM,
+            REG_VL_HOUR_ALARM,
+            REG_VL_DAY_ALARM,
+            REG_VL_WEEKDAY_ALARM,
+        ]
+        timeregs = [
+            REG_VL_MINUTES,
+            REG_VL_HOURS,
+            REG_VL_DAYS,
+            REG_VL_WEEKDAYS,
+        ]
+
+        if addr not in alarmregs + timeregs:
+            return
+
+        af = all(
+            self.regs[a] == self.regs[b]
+            for a, b in zip(alarmregs, timeregs)
+            if not self.regs[a] & REG_VL_ALARM_AE
+        )
+        self.reg_write(REG_CONTROL_STATUS_2, self.regs[REG_CONTROL_STATUS_2] | af << 3)
+
+    def _update_irq(self) -> None:
+        aie = self.regs[REG_CONTROL_STATUS_2] & REG_CONTROL_STATUS_2_AIE
+        af = self.regs[REG_CONTROL_STATUS_2] & REG_CONTROL_STATUS_2_AF
+
+        logger.debug(f"{aie=} {af=}")
+        self._set_int(aie and af)
+
+    def reg_read(self, addr: int) -> int:
+        val = self.regs[addr]
+        return val
+
+    def reg_write(self, addr: int, val: int) -> None:
+        assert addr in self.regs
+        self.regs[addr] = val
+        logger.debug(f"{addr=:x} {val=:x}")
+        self._check_alarm(addr)
+        self._update_irq()
+
+    def read(self, len: int) -> bytes:
+        data = bytearray(len)
+
+        for i in range(len):
+            data[i] = self.reg_read(self.reg_addr)
+            self.reg_addr = self.reg_addr + 1
+
+        return bytes(data)
+
+    def write(self, data: bytes) -> None:
+        self.reg_addr = data[0]
+
+        for i, byte in enumerate(data[1:]):
+            addr = self.reg_addr + i
+            self.backend.mock.reg_write(addr, byte)
+            self.reg_write(addr, byte)
+
+
+class TestPCF8563(UMLTestCase):
+    dts = DtFragment(
+        src="""
+#include <dt-bindings/interrupt-controller/irq.h>
+
+&i2c {
+    rtc@$addr$ {
+        compatible = "nxp,pcf8563";
+        reg = <0x$addr$>;
+    };
+
+    rtc@$irqaddr$ {
+        compatible = "nxp,pcf8563";
+        reg = <0x$irqaddr$>;
+        interrupt-parent = <&gpio>;
+        interrupts = <$gpio$ IRQ_TYPE_LEVEL_LOW>;
+    };
+};
+        """,
+        variables={
+            "addr": DtVar.I2C_ADDR,
+            "irqaddr": DtVar.I2C_ADDR,
+            "gpio": DtVar.GPIO_PIN,
+        },
+    )
+
+    @classmethod
+    def setUpClass(cls) -> None:
+        insmod("rtc-pcf8563")
+
+    @classmethod
+    def tearDownClass(cls) -> None:
+        # Can't rmmod since alarmtimer holds permanent reference
+        pass
+
+    def setUp(self) -> None:
+        self.driver = I2CDriver("rtc-pcf8563")
+        self.hw = Hardware("i2c")
+        self.hw.load_model(PCF8563, int=self.dts["gpio"])
+
+    def tearDown(self) -> None:
+        self.hw.close()
+
+    def test_read_time_invalid(self) -> None:
+        addr = self.dts["addr"]
+        with self.driver.bind(addr) as dev, rtc.RTC(dev.path) as rtcdev:
+            self.assertEqual(rtcdev.read_vl(), rtc.RTC_VL_DATA_INVALID)
+
+            with self.assertRaises(OSError) as cm:
+                rtcdev.read_time()
+            self.assertEqual(cm.exception.errno, errno.EINVAL)
+
+    def test_no_alarm_support(self) -> None:
+        addr = self.dts["addr"]
+        with self.driver.bind(addr) as dev, rtc.RTC(dev.path) as rtcdev:
+            # Make sure the times are valid so we don't get -EINVAL due to
+            # that.
+            tm = rtc.RTCTime(
+                tm_sec=10,
+                tm_min=1,
+                tm_hour=1,
+                tm_mday=1,
+                tm_mon=0,
+                tm_year=121,
+                tm_wday=0,
+                tm_yday=0,
+                tm_isdst=0,
+            )
+            rtcdev.set_time(tm)
+
+            alarmtm = tm._replace(tm_sec=0, tm_min=2)
+            with self.assertRaises(OSError) as cm:
+                rtcdev.set_wake_alarm(True, alarmtm)
+            self.assertEqual(cm.exception.errno, errno.EINVAL)
+
+    def test_alarm(self) -> None:
+        addr = self.dts["irqaddr"]
+        with self.driver.bind(addr) as dev, rtc.RTC(dev.path) as rtcdev:
+            tm = rtc.RTCTime(
+                tm_sec=10,
+                tm_min=1,
+                tm_hour=1,
+                tm_mday=1,
+                tm_mon=0,
+                tm_year=121,
+                tm_wday=5,
+                tm_yday=0,
+                tm_isdst=0,
+            )
+            rtcdev.set_time(tm)
+
+            alarmtm = tm._replace(tm_sec=0, tm_min=2)
+            rtcdev.set_wake_alarm(True, alarmtm)
+
+            mock = self.hw.update_mock()
+            mock.assert_last_reg_write(self, REG_VL_MINUTE_ALARM, 0x02)
+            mock.assert_last_reg_write(self, REG_VL_HOUR_ALARM, 0x01)
+            mock.assert_last_reg_write(self, REG_VL_DAY_ALARM, 0x01)
+            mock.assert_last_reg_write(self, REG_VL_WEEKDAY_ALARM, 5)
+            mock.assert_last_reg_write(
+                self, REG_CONTROL_STATUS_2, REG_CONTROL_STATUS_2_AIE
+            )
+            mock.reset_mock()
+
+            self.hw.reg_write(REG_VL_MINUTES, 0x02)
+            self.hw.kick()
+
+            # This waits for the interrupt
+            self.assertEqual(rtcdev.read() & 0xFF, rtc.RTC_IRQF | rtc.RTC_AF)
+
+            alarmtm = tm._replace(tm_sec=0, tm_min=3)
+            rtcdev.set_wake_alarm(False, alarmtm)
+
+            mock = self.hw.update_mock()
+            mock.assert_last_reg_write(self, REG_CONTROL_STATUS_2, 0)
+
+    def test_read_time_valid(self) -> None:
+        self.hw.reg_write(REG_VL_SECONDS, 0x37)
+        self.hw.reg_write(REG_VL_MINUTES, 0x10)
+        self.hw.reg_write(REG_VL_HOURS, 0x11)
+        self.hw.reg_write(REG_VL_DAYS, 0x25)
+        self.hw.reg_write(REG_VL_WEEKDAYS, 0x00)
+        self.hw.reg_write(REG_VL_CENTURY_MONTHS, REG_VL_CENTURY_MONTHS_C | 0x12)
+        self.hw.reg_write(REG_VL_YEARS, 0x21)
+
+        addr = self.dts["addr"]
+        with self.driver.bind(addr) as dev, rtc.RTC(dev.path) as rtcdev:
+            tm = rtcdev.read_time()
+            self.assertEqual(
+                tm,
+                rtc.RTCTime(
+                    tm_sec=37,
+                    tm_min=10,
+                    tm_hour=11,
+                    tm_mday=25,
+                    tm_mon=11,
+                    tm_year=121,
+                    tm_wday=0,
+                    tm_yday=0,
+                    tm_isdst=0,
+                ),
+            )
+
+    def test_set_time_after_invalid(self) -> None:
+        addr = self.dts["addr"]
+        with self.driver.bind(addr) as dev, rtc.RTC(dev.path) as rtcdev:
+            self.assertEqual(rtcdev.read_vl(), rtc.RTC_VL_DATA_INVALID)
+
+            tm = rtc.RTCTime(
+                tm_sec=37,
+                tm_min=10,
+                tm_hour=11,
+                tm_mday=25,
+                tm_mon=11,
+                tm_year=121,
+                tm_wday=0,
+                tm_yday=0,
+                tm_isdst=0,
+            )
+
+            rtcdev.set_time(tm)
+            tm2 = rtcdev.read_time()
+            self.assertEqual(tm, tm2)
+
+            mock = self.hw.update_mock()
+            mock.assert_reg_write_once(self, REG_VL_SECONDS, 0x37)
+            mock.assert_reg_write_once(self, REG_VL_MINUTES, 0x10)
+            mock.assert_reg_write_once(self, REG_VL_HOURS, 0x11)
+            mock.assert_reg_write_once(self, REG_VL_DAYS, 0x25)
+            mock.assert_reg_write_once(self, REG_VL_WEEKDAYS, 0x00)
+            # The driver uses the wrong polarity of the Century bit
+            # if the time was invalid.  This probably doesn't matter(?).
+            mock.assert_reg_write_once(self, REG_VL_CENTURY_MONTHS, 0 << 7 | 0x12)
+            mock.assert_reg_write_once(self, REG_VL_YEARS, 0x21)
+
+            self.assertEqual(rtcdev.read_vl(), 0)
+
+    def test_set_time_after_valid(self) -> None:
+        self.hw.reg_write(REG_VL_SECONDS, 0x37)
+        self.hw.reg_write(REG_VL_MINUTES, 0x10)
+        self.hw.reg_write(REG_VL_HOURS, 0x11)
+        self.hw.reg_write(REG_VL_DAYS, 0x25)
+        self.hw.reg_write(REG_VL_WEEKDAYS, 0x00)
+        self.hw.reg_write(REG_VL_CENTURY_MONTHS, REG_VL_CENTURY_MONTHS_C | 0x12)
+        self.hw.reg_write(REG_VL_YEARS, 0x21)
+
+        addr = self.dts["addr"]
+        with self.driver.bind(addr) as dev, rtc.RTC(dev.path) as rtcdev:
+            tm = rtc.RTCTime(
+                tm_sec=37,
+                tm_min=10,
+                tm_hour=11,
+                tm_mday=25,
+                tm_mon=11,
+                tm_year=121,
+                tm_wday=0,
+                tm_yday=0,
+                tm_isdst=0,
+            )
+
+            rtcdev.set_time(tm)
+            tm2 = rtcdev.read_time()
+            self.assertEqual(tm, tm2)
+
+            mock = self.hw.update_mock()
+            mock.assert_reg_write_once(self, REG_VL_SECONDS, 0x37)
+            mock.assert_reg_write_once(self, REG_VL_MINUTES, 0x10)
+            mock.assert_reg_write_once(self, REG_VL_HOURS, 0x11)
+            mock.assert_reg_write_once(self, REG_VL_DAYS, 0x25)
+            mock.assert_reg_write_once(self, REG_VL_WEEKDAYS, 0x00)
+            mock.assert_reg_write_once(
+                self, REG_VL_CENTURY_MONTHS, REG_VL_CENTURY_MONTHS_C | 0x12
+            )
+            mock.assert_reg_write_once(self, REG_VL_YEARS, 0x21)
-- 
2.34.1

