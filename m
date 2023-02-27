Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCBA6A4062
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 12:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjB0LNo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 06:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjB0LNi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 06:13:38 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A2B1E1FA
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Feb 2023 03:13:18 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:9202:974e:f0e0:414c])
        by laurent.telenet-ops.be with bizsmtp
        id SBCs2900D1hKVeJ01BCs35; Mon, 27 Feb 2023 12:12:53 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pWbQe-00AE6w-Et;
        Mon, 27 Feb 2023 12:12:52 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pWbR6-006zp4-B9;
        Mon, 27 Feb 2023 12:12:52 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] kunit: tool: Add support for m68k under QEMU
Date:   Mon, 27 Feb 2023 12:12:45 +0100
Message-Id: <108676ae57ac8cade69806ff92768866bf8dd200.1677496263.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add basic support to run m68k under QEMU via kunit_tool.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Does this need CONFIG_VIRTIO_CONSOLE=y? It seems to work fine without.

drivers/clk/.kunitconfig:

    Fails because m68k uses big-endian I/O ops

drivers/gpu/drm/tests/.kunitconfig

    kernel BUG at drivers/gpu/drm/drm_buddy.c:21!
    (also on arm, ignored)

drivers/gpu/drm/vc4/tests/.kunitconfig

    Depends on arm, works on arm

drivers/hid/.kunitconfig

    Unable to handle kernel NULL pointer dereference at virtual address (ptrval)
    Oops: 00000000
    PC: [<001d7380>] uclogic_params_ugee_v2_has_battery+0x6/0x68
    (also on arm, ignored)

fs/ext4/.kunitconfig: OK

fs/fat/.kunitconfig: OK

kernel/kcsan/.kunitconfig

    Needs HAVE_ARCH_KCSAN and SMP
    (the former also on arm, ignored)

lib/kunit/.kunitconfig: OK

mm/kfence/.kunitconfig

    Needs HAVE_ARCH_KFENCE
    (fails on arm due to missing CONFIG_KFENCE_KUNIT_TEST=y, which
    depends on TRACEPOINTS)

net/sunrpc/.kunitconfig

    After dropping CONFIG_STACKTRACE=y (why is this needed?) from
    net/sunrpc/.kunitconfig:
    Unable to handle kernel NULL pointer dereference at virtual address (ptrval)
    (also on arm, ignored)
---
 tools/testing/kunit/qemu_configs/m68k.py | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 tools/testing/kunit/qemu_configs/m68k.py

diff --git a/tools/testing/kunit/qemu_configs/m68k.py b/tools/testing/kunit/qemu_configs/m68k.py
new file mode 100644
index 0000000000000000..287fc386f8a7ff16
--- /dev/null
+++ b/tools/testing/kunit/qemu_configs/m68k.py
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+from ..qemu_config import QemuArchParams
+
+QEMU_ARCH = QemuArchParams(linux_arch='m68k',
+			   kconfig='''
+CONFIG_VIRT=y''',
+			   qemu_arch='m68k',
+			   kernel_path='vmlinux',
+			   kernel_command_line='console=hvc0',
+			   extra_qemu_params=['-machine', 'virt'])
-- 
2.34.1

