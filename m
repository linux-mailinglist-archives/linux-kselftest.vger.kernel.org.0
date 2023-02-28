Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C0B6A56C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Feb 2023 11:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjB1Kbn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Feb 2023 05:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjB1Kbm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Feb 2023 05:31:42 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FF06EB4
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Feb 2023 02:31:37 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:9202:974e:f0e0:414c])
        by michel.telenet-ops.be with bizsmtp
        id SaXZ2900M1hKVeJ06aXZ5Z; Tue, 28 Feb 2023 11:31:35 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pWxGC-00ANGo-KM;
        Tue, 28 Feb 2023 11:31:33 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pWxGf-00FbNQ-5O;
        Tue, 28 Feb 2023 11:31:33 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] kunit: tool: Add support for SH under QEMU
Date:   Tue, 28 Feb 2023 11:31:03 +0100
Message-Id: <c72e5884711da51424ad2f9c7933bb294129aef3.1677579750.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1677579750.git.geert+renesas@glider.be>
References: <cover.1677579750.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add basic support to run SH under QEMU via kunit_tool using the
virtualized r2d platform.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
All tests succeed, except for the usual suspects.
drivers/clk/.kunitconfig cannot be run as CONFIG_COMMON_CLK is not
available.
---
 tools/testing/kunit/qemu_configs/sh.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 tools/testing/kunit/qemu_configs/sh.py

diff --git a/tools/testing/kunit/qemu_configs/sh.py b/tools/testing/kunit/qemu_configs/sh.py
new file mode 100644
index 0000000000000000..78a474a5b95f3a7d
--- /dev/null
+++ b/tools/testing/kunit/qemu_configs/sh.py
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+from ..qemu_config import QemuArchParams
+
+QEMU_ARCH = QemuArchParams(linux_arch='sh',
+			   kconfig='''
+CONFIG_CPU_SUBTYPE_SH7751R=y
+CONFIG_MEMORY_START=0x0c000000
+CONFIG_SH_RTS7751R2D=y
+CONFIG_RTS7751R2D_PLUS=y
+CONFIG_SERIAL_SH_SCI=y''',
+			   qemu_arch='sh4',
+			   kernel_path='arch/sh/boot/zImage',
+			   kernel_command_line='console=ttySC1',
+			   serial='null',
+			   extra_qemu_params=[
+					    '-machine', 'r2d',
+					    '-serial', 'mon:stdio'])
-- 
2.34.1

