Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC164D6642
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Mar 2022 17:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350329AbiCKQ3O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 11:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350557AbiCKQ14 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 11:27:56 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823C91D529C;
        Fri, 11 Mar 2022 08:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1647015977;
  x=1678551977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2fctezGvjdiZGRh6wrKTd5SnqfgQb4vo1grBqwFZpAI=;
  b=iFesEgyjAepWdHK4B12tyAObVFUQq4lTL4E6Z7nyzkO7YsHLINHcp45I
   Nt1ZWM9PtbYvB8d7QvMeKdJBd0ZFjA2fXVyPsBBlFSSHkcu8KFN1gggT3
   vcC2X4NDiu1gLJzWfv3FVwABfJAi5s72HF4KvOLH4HOSHMs9V86H5C4cg
   q9p0RXI6o+LEywCy+os/HsPDbmU8pveddBS38+4qZlZWebwJzLyyLtAjG
   zps+oiUl57w3yqASJzSBhigFT2tflkTPw1+PTjECgwikR5Of5G8O2DPm9
   OPy+weL5DAAPPcA2g5zJRdCwPzy2P+xRScRJnoYcwrw95OwFxszOdsIst
   g==;
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
Subject: [RFC v1 08/10] iio: light: vcnl4000: add roadtest
Date:   Fri, 11 Mar 2022 17:24:43 +0100
Message-ID: <20220311162445.346685-9-vincent.whitchurch@axis.com>
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

Add roadtests for the vcnl4000 driver, testing several of the driver's
features including buffer and event handling.  Since it's the first IIO
roadtest testing the non-sysfs parts, some support code for using the
IIO ABI is included.

The different variants supported by the driver are in separate tests and
models since no two variants have fully identical register interfaces.
This duplicates some of the test code, but it:

 - Avoids the tests duplicating the same multi-variant logic as the
   driver, reducing the risk for both the test and the driver being
   wrong.

 - Allows each variant's test and model to be individually understood
   and modified looking at only one specific datasheet, making it easier
   to extend tests and implement new features in the driver.

During development of these tests, two oddities were noticed in the
driver's handling of VCNL4040, but the tests simply assume that the
current driver knows what it's doing (although we may want to fix the
first point later):

 - The driver reads an invalid/undefined register on the VCNL4040 when
   attempting to distinguish between that one and VCNL4200.

 - The driver uses a lux/step unit which differs from the datasheet (but
   which is specified in an application note).

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 .../roadtest/roadtest/tests/iio/iio.py        | 112 +++++++
 .../roadtest/roadtest/tests/iio/light/config  |   1 +
 .../roadtest/tests/iio/light/test_vcnl4000.py | 132 ++++++++
 .../roadtest/tests/iio/light/test_vcnl4010.py | 282 ++++++++++++++++++
 .../roadtest/tests/iio/light/test_vcnl4040.py | 104 +++++++
 .../roadtest/tests/iio/light/test_vcnl4200.py |  96 ++++++
 6 files changed, 727 insertions(+)
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/iio.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/light/test_vcnl4000.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/light/test_vcnl4010.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/light/test_vcnl4040.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/light/test_vcnl4200.py

diff --git a/tools/testing/roadtest/roadtest/tests/iio/iio.py b/tools/testing/roadtest/roadtest/tests/iio/iio.py
new file mode 100644
index 000000000000..ea57b28ea9d3
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/tests/iio/iio.py
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+import contextlib
+import enum
+import fcntl
+import struct
+from dataclasses import dataclass, field
+from typing import Any
+
+IIO_GET_EVENT_FD_IOCTL = 0x80046990
+IIO_BUFFER_GET_FD_IOCTL = 0xC0046991
+
+
+class IIOChanType(enum.IntEnum):
+    IIO_VOLTAGE = 0
+    IIO_CURRENT = 1
+    IIO_POWER = 2
+    IIO_ACCEL = 3
+    IIO_ANGL_VEL = 4
+    IIO_MAGN = 5
+    IIO_LIGHT = 6
+    IIO_INTENSITY = 7
+    IIO_PROXIMITY = 8
+    IIO_TEMP = 9
+    IIO_INCLI = 10
+    IIO_ROT = 11
+    IIO_ANGL = 12
+    IIO_TIMESTAMP = 13
+    IIO_CAPACITANCE = 14
+    IIO_ALTVOLTAGE = 15
+    IIO_CCT = 16
+    IIO_PRESSURE = 17
+    IIO_HUMIDITYRELATIVE = 18
+    IIO_ACTIVITY = 19
+    IIO_STEPS = 20
+    IIO_ENERGY = 21
+    IIO_DISTANCE = 22
+    IIO_VELOCITY = 23
+    IIO_CONCENTRATION = 24
+    IIO_RESISTANCE = 25
+    IIO_PH = 26
+    IIO_UVINDEX = 27
+    IIO_ELECTRICALCONDUCTIVITY = 28
+    IIO_COUNT = 29
+    IIO_INDEX = 30
+    IIO_GRAVITY = 31
+    IIO_POSITIONRELATIVE = 32
+    IIO_PHASE = 33
+    IIO_MASSCONCENTRATION = 34
+
+
+@dataclass
+class IIOEvent:
+    id: int
+    timestamp: int
+    type: IIOChanType = field(init=False)
+
+    def __post_init__(self) -> None:
+        self.type = IIOChanType((self.id >> 32) & 0xFF)
+
+
+class IIOEventMonitor(contextlib.AbstractContextManager):
+    def __init__(self, devname: str) -> None:
+        self.devname = devname
+
+    def __enter__(self) -> "IIOEventMonitor":
+        self.file = open(self.devname, "rb")
+
+        s = struct.Struct("L")
+        buf = bytearray(s.size)
+        fcntl.ioctl(self.file.fileno(), IIO_GET_EVENT_FD_IOCTL, buf)
+        eventfd = s.unpack(buf)[0]
+        self.eventf = open(eventfd, "rb")
+
+        return self
+
+    def read(self) -> IIOEvent:
+        s = struct.Struct("Qq")
+        buf = self.eventf.read(s.size)
+        return IIOEvent(*s.unpack(buf))
+
+    def __exit__(self, *_: Any) -> None:
+        self.eventf.close()
+        self.file.close()
+
+
+class IIOBuffer(contextlib.AbstractContextManager):
+    def __init__(self, devname: str, bufidx: int) -> None:
+        self.devname = devname
+        self.bufidx = bufidx
+
+    def __enter__(self) -> "IIOBuffer":
+        self.file = open(self.devname, "rb")
+
+        s = struct.Struct("L")
+        buf = bytearray(s.size)
+        s.pack_into(buf, 0, self.bufidx)
+        fcntl.ioctl(self.file.fileno(), IIO_BUFFER_GET_FD_IOCTL, buf)
+        eventfd = s.unpack(buf)[0]
+        self.eventf = open(eventfd, "rb")
+
+        return self
+
+    def read(self, spec: str) -> tuple:
+        s = struct.Struct(spec)
+        buf = self.eventf.read(s.size)
+        return s.unpack(buf)
+
+    def __exit__(self, *_: Any) -> None:
+        self.eventf.close()
+        self.file.close()
diff --git a/tools/testing/roadtest/roadtest/tests/iio/light/config b/tools/testing/roadtest/roadtest/tests/iio/light/config
index b9753f2d0728..3bd4125cbb6b 100644
--- a/tools/testing/roadtest/roadtest/tests/iio/light/config
+++ b/tools/testing/roadtest/roadtest/tests/iio/light/config
@@ -1 +1,2 @@
 CONFIG_OPT3001=m
+CONFIG_VCNL4000=m
diff --git a/tools/testing/roadtest/roadtest/tests/iio/light/test_vcnl4000.py b/tools/testing/roadtest/roadtest/tests/iio/light/test_vcnl4000.py
new file mode 100644
index 000000000000..16a5bed18b7e
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/tests/iio/light/test_vcnl4000.py
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+import errno
+import logging
+from typing import Any, Final
+
+from roadtest.backend.i2c import SMBusModel
+from roadtest.core.devicetree import DtFragment, DtVar
+from roadtest.core.hardware import Hardware
+from roadtest.core.modules import insmod, rmmod
+from roadtest.core.suite import UMLTestCase
+from roadtest.core.sysfs import I2CDriver, read_float, read_int, read_str
+
+logger = logging.getLogger(__name__)
+
+REG_COMMAND: Final = 0x80
+REG_PRODUCT_ID_REVISION: Final = 0x81
+REG_IR_LED_CURRENT: Final = 0x83
+REG_ALS_PARAM: Final = 0x84
+REG_ALS_RESULT_HIGH: Final = 0x85
+REG_ALS_RESULT_LOW: Final = 0x86
+REG_PROX_RESULT_HIGH: Final = 0x87
+REG_PROX_RESULT_LOW: Final = 0x88
+REG_PROX_SIGNAL_FREQ: Final = 0x89
+
+REG_COMMAND_ALS_DATA_RDY: Final = 1 << 6
+REG_COMMAND_PROX_DATA_RDY: Final = 1 << 5
+
+
+class VCNL4000(SMBusModel):
+    def __init__(self, **kwargs: Any) -> None:
+        super().__init__(regbytes=1, **kwargs)
+        self.regs = {
+            REG_COMMAND: 0b_1000_0000,
+            REG_PRODUCT_ID_REVISION: 0x11,
+            # Register "without function in current version"
+            0x82: 0x00,
+            REG_IR_LED_CURRENT: 0x00,
+            REG_ALS_PARAM: 0x00,
+            REG_ALS_RESULT_HIGH: 0x00,
+            REG_ALS_RESULT_LOW: 0x00,
+            REG_PROX_RESULT_HIGH: 0x00,
+            REG_PROX_RESULT_LOW: 0x00,
+            REG_PROX_RESULT_LOW: 0x00,
+        }
+
+    def reg_read(self, addr: int) -> int:
+        val = self.regs[addr]
+
+        if addr in (REG_ALS_RESULT_HIGH, REG_ALS_RESULT_LOW):
+            self.regs[REG_COMMAND] &= ~REG_COMMAND_ALS_DATA_RDY
+        if addr in (REG_PROX_RESULT_HIGH, REG_PROX_RESULT_LOW):
+            self.regs[REG_COMMAND] &= ~REG_COMMAND_PROX_DATA_RDY
+
+        return val
+
+    def reg_write(self, addr: int, val: int) -> None:
+        assert addr in self.regs
+
+        if addr == REG_COMMAND:
+            rw = 0b_0001_1000
+            val = (self.regs[addr] & ~rw) | (val & rw)
+
+        self.regs[addr] = val
+
+    def inject(self, addr: int, val: int, mask: int = ~0) -> None:
+        old = self.regs[addr] & ~mask
+        new = old | (val & mask)
+        self.regs[addr] = new
+
+
+class TestVCNL4000(UMLTestCase):
+    dts = DtFragment(
+        src="""
+&i2c {
+    light-sensor@$addr$ {
+        compatible = "vishay,vcnl4000";
+        reg = <0x$addr$>;
+    };
+};
+        """,
+        variables={
+            "addr": DtVar.I2C_ADDR,
+        },
+    )
+
+    @classmethod
+    def setUpClass(cls) -> None:
+        insmod("vcnl4000")
+
+    @classmethod
+    def tearDownClass(cls) -> None:
+        rmmod("vcnl4000")
+
+    def setUp(self) -> None:
+        self.driver = I2CDriver("vcnl4000")
+        self.hw = Hardware("i2c")
+        self.hw.load_model(VCNL4000)
+
+    def tearDown(self) -> None:
+        self.hw.close()
+
+    def test_lux(self) -> None:
+        with self.driver.bind(self.dts["addr"]) as dev:
+            scale = read_float(dev.path / "iio:device0/in_illuminance_scale")
+            self.assertEqual(scale, 0.25)
+
+            data = [
+                (0x00, 0x00),
+                (0x12, 0x34),
+                (0xFF, 0xFF),
+            ]
+            luxfile = dev.path / "iio:device0/in_illuminance_raw"
+            for high, low in data:
+                self.hw.inject(REG_ALS_RESULT_HIGH, high)
+                self.hw.inject(REG_ALS_RESULT_LOW, low)
+                self.hw.inject(
+                    REG_COMMAND,
+                    val=REG_COMMAND_ALS_DATA_RDY,
+                    mask=REG_COMMAND_ALS_DATA_RDY,
+                )
+
+                self.assertEqual(read_int(luxfile), high << 8 | low)
+
+    def test_lux_timeout(self) -> None:
+        with self.driver.bind(self.dts["addr"]) as dev:
+            # self.hw.set_never_ready(True)
+            with self.assertRaises(OSError) as cm:
+                luxfile = dev.path / "iio:device0/in_illuminance_raw"
+                read_str(luxfile)
+            self.assertEqual(cm.exception.errno, errno.EIO)
diff --git a/tools/testing/roadtest/roadtest/tests/iio/light/test_vcnl4010.py b/tools/testing/roadtest/roadtest/tests/iio/light/test_vcnl4010.py
new file mode 100644
index 000000000000..929db970405f
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/tests/iio/light/test_vcnl4010.py
@@ -0,0 +1,282 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+import errno
+import logging
+from pathlib import Path
+from typing import Any, Final, Optional
+
+from roadtest.backend.i2c import SMBusModel
+from roadtest.core.devicetree import DtFragment, DtVar
+from roadtest.core.hardware import Hardware
+from roadtest.core.modules import insmod, rmmod
+from roadtest.core.suite import UMLTestCase
+from roadtest.core.sysfs import (
+    I2CDriver,
+    read_float,
+    read_int,
+    read_str,
+    write_int,
+    write_str,
+)
+from roadtest.tests.iio import iio
+
+logger = logging.getLogger(__name__)
+
+REG_COMMAND: Final = 0x80
+REG_PRODUCT_ID_REVISION: Final = 0x81
+REG_PROXIMITY_RATE: Final = 0x82
+REG_IR_LED_CURRENT: Final = 0x83
+REG_ALS_PARAM: Final = 0x84
+REG_ALS_RESULT_HIGH: Final = 0x85
+REG_ALS_RESULT_LOW: Final = 0x86
+REG_PROX_RESULT_HIGH: Final = 0x87
+REG_PROX_RESULT_LOW: Final = 0x88
+REG_INTERRUPT_CONTROL: Final = 0x89
+REG_LOW_THRESHOLD_HIGH: Final = 0x8A
+REG_LOW_THRESHOLD_LOW: Final = 0x8B
+REG_HIGH_THRESHOLD_HIGH: Final = 0x8C
+REG_HIGH_THRESHOLD_LOW: Final = 0x8D
+REG_INTERRUPT_STATUS: Final = 0x8E
+
+REG_COMMAND_ALS_DATA_RDY: Final = 1 << 6
+REG_COMMAND_PROX_DATA_RDY: Final = 1 << 5
+
+
+class VCNL4010(SMBusModel):
+    def __init__(self, int: Optional[int] = None, **kwargs: Any) -> None:
+        super().__init__(regbytes=1, **kwargs)
+        self.int = int
+        self._set_int(False)
+        self.regs = {
+            REG_COMMAND: 0b_1000_0000,
+            REG_PRODUCT_ID_REVISION: 0x21,
+            REG_PROXIMITY_RATE: 0x00,
+            REG_IR_LED_CURRENT: 0x00,
+            REG_ALS_PARAM: 0x00,
+            REG_ALS_RESULT_HIGH: 0x00,
+            REG_ALS_RESULT_LOW: 0x00,
+            REG_PROX_RESULT_HIGH: 0x00,
+            REG_PROX_RESULT_LOW: 0x00,
+            REG_INTERRUPT_CONTROL: 0x00,
+            REG_LOW_THRESHOLD_HIGH: 0x00,
+            REG_LOW_THRESHOLD_LOW: 0x00,
+            REG_HIGH_THRESHOLD_HIGH: 0x00,
+            REG_HIGH_THRESHOLD_LOW: 0x00,
+            REG_INTERRUPT_STATUS: 0x00,
+        }
+
+    def _set_int(self, active: int) -> None:
+        # Active-low
+        self.backend.gpio.set(self.int, not active)
+
+    def _update_irq(self) -> None:
+        selftimed_en = self.regs[REG_COMMAND] & (1 << 0)
+        prox_en = self.regs[REG_COMMAND] & (1 << 1)
+        prox_data_rdy = self.regs[REG_COMMAND] & REG_COMMAND_PROX_DATA_RDY
+        int_prox_ready_en = self.regs[REG_INTERRUPT_CONTROL] & (1 << 3)
+
+        logger.debug(
+            f"{selftimed_en=:x} {prox_en=:x} {prox_data_rdy=:x} {int_prox_ready_en=:x}"
+        )
+
+        if selftimed_en and prox_en and prox_data_rdy and int_prox_ready_en:
+            self.regs[REG_INTERRUPT_STATUS] |= 1 << 3
+
+        low_threshold = (
+            self.regs[REG_LOW_THRESHOLD_HIGH] << 8 | self.regs[REG_LOW_THRESHOLD_LOW]
+        )
+        high_threshold = (
+            self.regs[REG_HIGH_THRESHOLD_HIGH] << 8 | self.regs[REG_HIGH_THRESHOLD_LOW]
+        )
+        proximity = (
+            self.regs[REG_PROX_RESULT_HIGH] << 8 | self.regs[REG_PROX_RESULT_LOW]
+        )
+        int_thres_en = self.regs[REG_INTERRUPT_CONTROL] & (1 << 1)
+
+        logger.debug(
+            f"{low_threshold=:x} {high_threshold=:x} {proximity=:x} {int_thres_en=:x}"
+        )
+
+        if int_thres_en:
+            if proximity < low_threshold:
+                logger.debug("LOW")
+                self.regs[REG_INTERRUPT_STATUS] |= 1 << 1
+            if proximity > high_threshold:
+                logger.debug("HIGH")
+                self.regs[REG_INTERRUPT_STATUS] |= 1 << 0
+
+        self._set_int(self.regs[REG_INTERRUPT_STATUS])
+
+    def reg_read(self, addr: int) -> int:
+        val = self.regs[addr]
+
+        if addr in (REG_ALS_RESULT_HIGH, REG_ALS_RESULT_LOW):
+            self.regs[REG_COMMAND] &= ~REG_COMMAND_ALS_DATA_RDY
+        if addr in (REG_PROX_RESULT_HIGH, REG_PROX_RESULT_LOW):
+            self.regs[REG_COMMAND] &= ~REG_COMMAND_PROX_DATA_RDY
+
+        return val
+
+    def reg_write(self, addr: int, val: int) -> None:
+        assert addr in self.regs
+
+        if addr == REG_COMMAND:
+            rw = 0b_0001_1111
+            val = (self.regs[addr] & ~rw) | (val & rw)
+        elif addr == REG_INTERRUPT_STATUS:
+            val = self.regs[addr] & ~(val & 0xF)
+
+        self.regs[addr] = val
+        self._update_irq()
+
+    def inject(self, addr: int, val: int, mask: int = ~0) -> None:
+        old = self.regs[addr] & ~mask
+        new = old | (val & mask)
+        self.regs[addr] = new
+        self._update_irq()
+
+    def set_bit(self, addr: int, val: int) -> None:
+        self.inject(addr, val, val)
+
+
+class TestVCNL4010(UMLTestCase):
+    dts = DtFragment(
+        src="""
+#include <dt-bindings/interrupt-controller/irq.h>
+
+&i2c {
+    light-sensor@$addr$ {
+        compatible = "vishay,vcnl4020";
+        reg = <0x$addr$>;
+        interrupt-parent = <&gpio>;
+        interrupts = <$gpio$ IRQ_TYPE_EDGE_FALLING>;
+    };
+};
+        """,
+        variables={
+            "addr": DtVar.I2C_ADDR,
+            "gpio": DtVar.GPIO_PIN,
+        },
+    )
+
+    @classmethod
+    def setUpClass(cls) -> None:
+        insmod("vcnl4000")
+
+    @classmethod
+    def tearDownClass(cls) -> None:
+        rmmod("vcnl4000")
+
+    def setUp(self) -> None:
+        self.driver = I2CDriver("vcnl4000")
+        self.hw = Hardware("i2c")
+        self.hw.load_model(VCNL4010, int=self.dts["gpio"])
+
+    def tearDown(self) -> None:
+        self.hw.close()
+
+    def test_lux(self) -> None:
+        with self.driver.bind(self.dts["addr"]) as dev:
+
+            scale = read_float(dev.path / "iio:device0/in_illuminance_scale")
+            self.assertEqual(scale, 0.25)
+
+            data = [
+                (0x00, 0x00),
+                (0x12, 0x34),
+                (0xFF, 0xFF),
+            ]
+            luxfile = dev.path / "iio:device0/in_illuminance_raw"
+            for high, low in data:
+                self.hw.inject(REG_ALS_RESULT_HIGH, high)
+                self.hw.inject(REG_ALS_RESULT_LOW, low)
+                self.hw.set_bit(REG_COMMAND, REG_COMMAND_ALS_DATA_RDY)
+
+                self.assertEqual(read_int(luxfile), high << 8 | low)
+
+    def test_lux_timeout(self) -> None:
+        with self.driver.bind(self.dts["addr"]) as dev:
+            with self.assertRaises(OSError) as cm:
+                luxfile = dev.path / "iio:device0/in_illuminance_raw"
+                read_str(luxfile)
+            self.assertEqual(cm.exception.errno, errno.EIO)
+
+    def test_proximity_thresh_rising(self) -> None:
+        with self.driver.bind(self.dts["addr"]) as dev:
+            high_thresh = (
+                dev.path / "iio:device0/events/in_proximity_thresh_rising_value"
+            )
+            write_int(high_thresh, 0x1234)
+
+            mock = self.hw.update_mock()
+            mock.assert_last_reg_write(self, REG_HIGH_THRESHOLD_HIGH, 0x12)
+            mock.assert_last_reg_write(self, REG_HIGH_THRESHOLD_LOW, 0x34)
+            mock.reset_mock()
+
+            self.assertEqual(read_int(high_thresh), 0x1234)
+
+            with iio.IIOEventMonitor("/dev/iio:device0") as mon:
+                en = dev.path / "iio:device0/events/in_proximity_thresh_either_en"
+                write_int(en, 1)
+
+                self.hw.inject(REG_PROX_RESULT_HIGH, 0x12)
+                self.hw.inject(REG_PROX_RESULT_LOW, 0x35)
+                self.hw.set_bit(REG_COMMAND, REG_COMMAND_PROX_DATA_RDY)
+                self.hw.kick()
+
+                self.assertEqual(read_int(en), 1)
+
+                event = mon.read()
+                self.assertEqual(event.type, iio.IIOChanType.IIO_PROXIMITY)
+
+    def test_proximity_thresh_falling(self) -> None:
+        with self.driver.bind(self.dts["addr"]) as dev:
+            high_thresh = (
+                dev.path / "iio:device0/events/in_proximity_thresh_falling_value"
+            )
+            write_int(high_thresh, 0x0ABC)
+
+            mock = self.hw.update_mock()
+            mock.assert_last_reg_write(self, REG_LOW_THRESHOLD_HIGH, 0x0A)
+            mock.assert_last_reg_write(self, REG_LOW_THRESHOLD_LOW, 0xBC)
+            mock.reset_mock()
+
+            self.assertEqual(read_int(high_thresh), 0x0ABC)
+
+            with iio.IIOEventMonitor("/dev/iio:device0") as mon:
+                write_int(
+                    dev.path / "iio:device0/events/in_proximity_thresh_either_en", 1
+                )
+
+                event = mon.read()
+                self.assertEqual(event.type, iio.IIOChanType.IIO_PROXIMITY)
+
+    def test_proximity_triggered(self) -> None:
+        with self.driver.bind(self.dts["addr"]) as dev:
+            data = [
+                (0x00, 0x00, 0),
+                (0x00, 0x01, 1),
+                (0xF0, 0x02, 0xF002),
+                (0xFF, 0xFF, 0xFFFF),
+            ]
+
+            trigger = read_str(Path("/sys/bus/iio/devices/trigger0/name"))
+
+            write_int(dev.path / "iio:device0/buffer0/in_proximity_en", 1)
+            write_str(dev.path / "iio:device0/trigger/current_trigger", trigger)
+
+            with iio.IIOBuffer("/dev/iio:device0", bufidx=0) as buffer:
+                write_int(dev.path / "iio:device0/buffer0/length", 128)
+                write_int(dev.path / "iio:device0/buffer0/enable", 1)
+
+                for low, high, expected in data:
+                    self.hw.inject(REG_PROX_RESULT_HIGH, low)
+                    self.hw.inject(REG_PROX_RESULT_LOW, high)
+                    self.hw.set_bit(REG_COMMAND, REG_COMMAND_PROX_DATA_RDY)
+                    self.hw.kick()
+
+                    scanline = buffer.read("H")
+
+                    val = scanline[0]
+                    self.assertEqual(val, expected)
diff --git a/tools/testing/roadtest/roadtest/tests/iio/light/test_vcnl4040.py b/tools/testing/roadtest/roadtest/tests/iio/light/test_vcnl4040.py
new file mode 100644
index 000000000000..f2aa2cb9f3d5
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/tests/iio/light/test_vcnl4040.py
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+import logging
+from typing import Any
+
+from roadtest.backend.i2c import SMBusModel
+from roadtest.core.devicetree import DtFragment, DtVar
+from roadtest.core.hardware import Hardware
+from roadtest.core.modules import insmod, rmmod
+from roadtest.core.suite import UMLTestCase
+from roadtest.core.sysfs import I2CDriver, read_float, read_int
+
+logger = logging.getLogger(__name__)
+
+
+class VCNL4040(SMBusModel):
+    def __init__(self, **kwargs: Any) -> None:
+        super().__init__(regbytes=2, byteorder="little", **kwargs)
+        self.regs = {
+            0x00: 0x0101,
+            0x01: 0x0000,
+            0x02: 0x0000,
+            0x03: 0x0001,
+            0x04: 0x0000,
+            0x05: 0x0000,
+            0x06: 0x0000,
+            0x07: 0x0000,
+            0x08: 0x0000,
+            0x09: 0x0000,
+            0x0A: 0x0000,
+            0x0A: 0x0000,
+            0x0B: 0x0000,
+            0x0C: 0x0186,
+            # The driver reads this register which is undefined for
+            # VCNL4040.  Perhaps the driver should be fixed instead
+            # of having this here?
+            0x0E: 0x0000,
+        }
+
+    def reg_read(self, addr: int) -> int:
+        return self.regs[addr]
+
+    def reg_write(self, addr: int, val: int) -> None:
+        assert addr in self.regs
+        self.regs[addr] = val
+
+
+class TestVCNL4040(UMLTestCase):
+    dts = DtFragment(
+        src="""
+&i2c {
+    light-sensor@$addr$ {
+        compatible = "vishay,vcnl4040";
+        reg = <0x$addr$>;
+    };
+};
+        """,
+        variables={
+            "addr": DtVar.I2C_ADDR,
+        },
+    )
+
+    @classmethod
+    def setUpClass(cls) -> None:
+        insmod("vcnl4000")
+
+    @classmethod
+    def tearDownClass(cls) -> None:
+        rmmod("vcnl4000")
+
+    def setUp(self) -> None:
+        self.driver = I2CDriver("vcnl4000")
+        self.hw = Hardware("i2c")
+        self.hw.load_model(VCNL4040)
+
+    def tearDown(self) -> None:
+        self.hw.close()
+
+    def test_illuminance_scale(self) -> None:
+        with self.driver.bind(self.dts["addr"]) as dev:
+            scalefile = dev.path / "iio:device0/in_illuminance_scale"
+            # The datasheet says 0.10 lux/step, but the driver follows
+            # the application note "Designing the VCNL4040 Into an
+            # Application" which claims a different value.
+            self.assertEqual(read_float(scalefile), 0.12)
+
+    def test_illuminance(self) -> None:
+        with self.driver.bind(self.dts["addr"]) as dev:
+            luxfile = dev.path / "iio:device0/in_illuminance_raw"
+
+            data = [0x0000, 0x1234, 0xFFFF]
+            for regval in data:
+                self.hw.reg_write(0x09, regval)
+                self.assertEqual(read_int(luxfile), regval)
+
+    def test_proximity(self) -> None:
+        with self.driver.bind(self.dts["addr"]) as dev:
+            rawfile = dev.path / "iio:device0/in_proximity_raw"
+
+            data = [0x0000, 0x1234, 0xFFFF]
+            for regval in data:
+                self.hw.reg_write(0x08, regval)
+                self.assertEqual(read_int(rawfile), regval)
diff --git a/tools/testing/roadtest/roadtest/tests/iio/light/test_vcnl4200.py b/tools/testing/roadtest/roadtest/tests/iio/light/test_vcnl4200.py
new file mode 100644
index 000000000000..d1cf819e563e
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/tests/iio/light/test_vcnl4200.py
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+import logging
+from typing import Any
+
+from roadtest.backend.i2c import SMBusModel
+from roadtest.core.devicetree import DtFragment, DtVar
+from roadtest.core.hardware import Hardware
+from roadtest.core.modules import insmod, rmmod
+from roadtest.core.suite import UMLTestCase
+from roadtest.core.sysfs import I2CDriver, read_float, read_int
+
+logger = logging.getLogger(__name__)
+
+
+class VCNL4200(SMBusModel):
+    def __init__(self, **kwargs: Any) -> None:
+        super().__init__(regbytes=2, byteorder="little", **kwargs)
+        self.regs = {
+            0x00: 0x0101,
+            0x01: 0x0000,
+            0x02: 0x0000,
+            0x03: 0x0001,
+            0x04: 0x0000,
+            0x05: 0x0000,
+            0x06: 0x0000,
+            0x07: 0x0000,
+            0x08: 0x0000,
+            0x09: 0x0000,
+            0x0A: 0x0000,
+            0x0D: 0x0000,
+            0x0E: 0x1058,
+        }
+
+    def reg_read(self, addr: int) -> int:
+        return self.regs[addr]
+
+    def reg_write(self, addr: int, val: int) -> None:
+        assert addr in self.regs
+        self.regs[addr] = val
+
+
+class TestVCNL4200(UMLTestCase):
+    dts = DtFragment(
+        src="""
+&i2c {
+    light-sensor@$addr$ {
+        compatible = "vishay,vcnl4200";
+        reg = <0x$addr$>;
+    };
+};
+        """,
+        variables={
+            "addr": DtVar.I2C_ADDR,
+        },
+    )
+
+    @classmethod
+    def setUpClass(cls) -> None:
+        insmod("vcnl4000")
+
+    @classmethod
+    def tearDownClass(cls) -> None:
+        rmmod("vcnl4000")
+
+    def setUp(self) -> None:
+        self.driver = I2CDriver("vcnl4000")
+        self.hw = Hardware("i2c")
+        self.hw.load_model(VCNL4200)
+
+    def tearDown(self) -> None:
+        self.hw.close()
+
+    def test_illuminance_scale(self) -> None:
+        with self.driver.bind(self.dts["addr"]) as dev:
+            scalefile = dev.path / "iio:device0/in_illuminance_scale"
+            self.assertEqual(read_float(scalefile), 0.024)
+
+    def test_illuminance(self) -> None:
+        with self.driver.bind(self.dts["addr"]) as dev:
+            luxfile = dev.path / "iio:device0/in_illuminance_raw"
+
+            data = [0x0000, 0x1234, 0xFFFF]
+            for regval in data:
+                self.hw.reg_write(0x09, regval)
+                self.assertEqual(read_int(luxfile), regval)
+
+    def test_proximity(self) -> None:
+        with self.driver.bind(self.dts["addr"]) as dev:
+            rawfile = dev.path / "iio:device0/in_proximity_raw"
+
+            data = [0x0000, 0x1234, 0xFFFF]
+            for regval in data:
+                self.hw.reg_write(0x08, regval)
+                self.assertEqual(read_int(rawfile), regval)
-- 
2.34.1

