Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8C96A56CC
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Feb 2023 11:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjB1Kbo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Feb 2023 05:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjB1Kbm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Feb 2023 05:31:42 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22336EBF
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Feb 2023 02:31:37 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:9202:974e:f0e0:414c])
        by laurent.telenet-ops.be with bizsmtp
        id SaXZ2900H1hKVeJ01aXZmY; Tue, 28 Feb 2023 11:31:35 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pWxGC-00ANGn-K0;
        Tue, 28 Feb 2023 11:31:33 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pWxGf-00FbNK-4c;
        Tue, 28 Feb 2023 11:31:33 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] kunit: tool: Add support for overriding the QEMU serial port
Date:   Tue, 28 Feb 2023 11:31:02 +0100
Message-Id: <f12e6f606a2612fab4d1038d088959710a423a9f.1677579750.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1677579750.git.geert+renesas@glider.be>
References: <cover.1677579750.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On some platforms, the console is not the first serial port.  To make
this work, the first serial port in QEMU must be set to "null".

Add support for this by adding an optional "serial" parameter, which
defaults to "stdio", and can be overridden by platform-specific
configuration.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 tools/testing/kunit/kunit_kernel.py | 3 ++-
 tools/testing/kunit/qemu_config.py  | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 53e90c3358348dbe..64262875993ff070 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -106,6 +106,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
 		self._kernel_path = qemu_arch_params.kernel_path
 		self._kernel_command_line = qemu_arch_params.kernel_command_line + ' kunit_shutdown=reboot'
 		self._extra_qemu_params = qemu_arch_params.extra_qemu_params
+		self._serial = qemu_arch_params.serial
 
 	def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
 		kconfig = kunit_config.parse_from_string(self._kconfig)
@@ -121,7 +122,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
 				'-append', ' '.join(params + [self._kernel_command_line]),
 				'-no-reboot',
 				'-nographic',
-				'-serial', 'stdio'] + self._extra_qemu_params
+				'-serial', self._serial] + self._extra_qemu_params
 		# Note: shlex.join() does what we want, but requires python 3.8+.
 		print('Running tests with:\n$', ' '.join(shlex.quote(arg) for arg in qemu_command))
 		return subprocess.Popen(qemu_command,
diff --git a/tools/testing/kunit/qemu_config.py b/tools/testing/kunit/qemu_config.py
index 0b6a80398cccb50f..b1fba9016eed00d0 100644
--- a/tools/testing/kunit/qemu_config.py
+++ b/tools/testing/kunit/qemu_config.py
@@ -17,3 +17,4 @@ class QemuArchParams:
   kernel_path: str
   kernel_command_line: str
   extra_qemu_params: List[str]
+  serial: str = 'stdio'
-- 
2.34.1

