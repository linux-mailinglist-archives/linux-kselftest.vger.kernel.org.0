Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9F64D6627
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Mar 2022 17:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350313AbiCKQ1D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 11:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350271AbiCKQ0h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 11:26:37 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094111BF930;
        Fri, 11 Mar 2022 08:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1647015909;
  x=1678551909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a4jqKhMbsN8UJ3i116koA51lQKLvtPhDM9o1oRoAbiw=;
  b=ID5Ud+pNpe7qiXGAX1K2P14GHr/qtfMPrmNNrLT8T+EK5n6s8erXWLTS
   6oKvZAnrueSIGy/qHi6/fc5sEmX+t7iIdHtvCa8XWrVUT1LONsErISc0X
   nbD+hXPd/l8BIOzRRm4iKLzj3nXETpLf3RvOCK/+0D4re8T6SPPTjuRmB
   QYYRpLh0ekRPTdP3orTgEX7iWd75kGfl+gAjaDikXIeXQ0r7RbQ/IzUjz
   fsNUjLw5iFyCeRnU+fcl1OYS+vPyJ0A+i9kWY+vloBO8hAayXTmC28m5q
   Li+VY47M1hCfqBrX22hc0COVp5FcXFjDURFpqitSIzfeJErsbU0DJMJrc
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
Subject: [RFC v1 04/10] roadtest: add base config
Date:   Fri, 11 Mar 2022 17:24:39 +0100
Message-ID: <20220311162445.346685-5-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220311162445.346685-1-vincent.whitchurch@axis.com>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the base config options for the roadtest kernel (generated with
"savedefconfig").

roadtest uses a single kernel for all tests and the drivers under test
are built as modules.  Additional config options are added by merging
config fragments from each subsystems' test directory.

The kernel is built with several debug options to catch more problems
during testing.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 .../roadtest/roadtest/tests/base/config       | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 tools/testing/roadtest/roadtest/tests/base/config

diff --git a/tools/testing/roadtest/roadtest/tests/base/config b/tools/testing/roadtest/roadtest/tests/base/config
new file mode 100644
index 000000000000..c1952d047c8e
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/tests/base/config
@@ -0,0 +1,84 @@
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_EXPERT=y
+CONFIG_HOSTFS=y
+CONFIG_UML_TIME_TRAVEL_SUPPORT=y
+CONFIG_NULL_CHAN=y
+CONFIG_PORT_CHAN=y
+CONFIG_PTY_CHAN=y
+CONFIG_TTY_CHAN=y
+CONFIG_XTERM_CHAN=y
+CONFIG_CON_CHAN="pts"
+CONFIG_SSL=y
+CONFIG_SSL_CHAN="pts"
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_VIRTIO_UML=y
+CONFIG_UML_PCI_OVER_VIRTIO=y
+CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID=1234
+CONFIG_GCOV_KERNEL=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_BINFMT_MISC=m
+# CONFIG_COMPACTION is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_OF=y
+# CONFIG_INPUT is not set
+CONFIG_LEGACY_PTY_COUNT=32
+CONFIG_HW_RANDOM=y
+# CONFIG_HW_RANDOM_IXP4XX is not set
+# CONFIG_HW_RANDOM_STM32 is not set
+# CONFIG_HW_RANDOM_MESON is not set
+# CONFIG_HW_RANDOM_CAVIUM is not set
+# CONFIG_HW_RANDOM_MTK is not set
+# CONFIG_HW_RANDOM_EXYNOS is not set
+# CONFIG_HW_RANDOM_NPCM is not set
+# CONFIG_HW_RANDOM_KEYSTONE is not set
+CONFIG_RANDOM_TRUST_BOOTLOADER=y
+CONFIG_I2C=y
+# CONFIG_I2C_COMPAT is not set
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_VIRTIO=y
+CONFIG_I2C_STUB=m
+CONFIG_PPS=y
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_VIRTIO=y
+CONFIG_NET=y
+CONFIG_UNIX=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_RTC_CLASS=y
+# CONFIG_RTC_HCTOSYS is not set
+# CONFIG_RTC_SYSTOHC is not set
+CONFIG_RTC_DEBUG=y
+# CONFIG_RTC_NVMEM is not set
+CONFIG_VIRTIO_INPUT=y
+# CONFIG_BCM_VIDEOCORE is not set
+CONFIG_QUOTA=y
+CONFIG_AUTOFS4_FS=m
+CONFIG_PROC_KCORE=y
+CONFIG_TMPFS=y
+CONFIG_NLS=y
+CONFIG_CRYPTO=y
+CONFIG_CRYPTO_CRC32C=y
+CONFIG_CRYPTO_JITTERENTROPY=y
+CONFIG_CRC16=y
+CONFIG_PRINTK_TIME=y
+CONFIG_PRINTK_CALLER=y
+CONFIG_DYNAMIC_DEBUG=y
+CONFIG_DEBUG_INFO=y
+CONFIG_FRAME_WARN=1024
+CONFIG_READABLE_ASM=y
+CONFIG_DEBUG_FS=y
+CONFIG_UBSAN=y
+CONFIG_PAGE_EXTENSION=y
+CONFIG_DEBUG_OBJECTS=y
+CONFIG_DEBUG_OBJECTS_FREE=y
+CONFIG_DEBUG_OBJECTS_TIMERS=y
+CONFIG_DEBUG_OBJECTS_WORK=y
+CONFIG_PROVE_LOCKING=y
+CONFIG_ENABLE_DEFAULT_TRACERS=y
-- 
2.34.1

