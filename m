Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FA4524FEB
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 16:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352309AbiELO0M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 10:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355283AbiELO0D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 10:26:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96681A396
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 07:26:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j11-20020a05690212cb00b006454988d225so4709456ybu.10
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 07:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=j9bsN1b2L5uuxoi/IMspLNVh2Kizip/Mswp9v0VIKcw=;
        b=Ox6W1FtyoROd3nJ1Rp+QL/upobk7KTTBCqQXmIvM043PL/su4Ku4ORBWOh2DQ8EGgS
         wVMZTdtareDCyGrYmJYXosK8cn9JkaXeNy5yQmHFwV9KF/lZc3UOLClip20N421P0OEo
         Lq/Bwrdldrsw8XJY0zNEHzrrxDB1RyAIGGVC7yfKYSsYJYy4wYm/0o3Ck14bHHzwgpaT
         Gql0whJIxnuQPEMMCU493X0cVjbPKtK1DCgsw9y9/gqzSZZZrgkUNI9u0QCtXKg6YT2m
         E0Z2GYQvbxGCvZZT3GV9MqwU7qxYfMtukZ6IuWlkmQoE+lKa9oF+rT2EKKiDhCyY8xwc
         DWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=j9bsN1b2L5uuxoi/IMspLNVh2Kizip/Mswp9v0VIKcw=;
        b=6o2gD0+rVM1qXEl+ox9CK1ZOvXeGp3BDBqkfj0Z0ffvm7IZQ1/qqPz9HG96r1hoen4
         p18MBIseyo5p+FhhC53sly3OlLGFW/ui6zX2wXDaAfnKaYWaYERo9DlBW3edVWOeS6pT
         E3dyvyn4sHDln2PKphrIQOhQr6IpeJiRBZpPtFTXg82tE+NqEh7b80Tkd9+svBt2bIsS
         bVUoTsWO1Zp/kbE8Tro1U+GpKb2MaJgzCfCbQ3uXLi4SDnKe1nuTTFakv6pzzeFoUFa9
         Jr6VAsfMgn11KcHvsKwlDYncL2vVumIL/2oIfrXxL3cTx6q2NHKRVmrTujrx6WUwRv2R
         1bZg==
X-Gm-Message-State: AOAM531TaztCXx3ISuS7i+rtiyKYyAUDP0Sx4rieGKcdNalmwh5KFu3m
        T7NO7p9PvlAt9D+3iyTrCt+A/NxDZFMhfQ==
X-Google-Smtp-Source: ABdhPJw0GoGFPNVWWBCxEeoIp+rSU/N13zEDo0TIfGPwSrDhaq+2gnfAjPBHvA2Q9FF277vlpQpqZvVwllDHiQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:bd59:7b9f:6863:5402])
 (user=dlatypov job=sendgmr) by 2002:a25:dccf:0:b0:648:a757:ad34 with SMTP id
 y198-20020a25dccf000000b00648a757ad34mr86537ybe.66.1652365561816; Thu, 12 May
 2022 07:26:01 -0700 (PDT)
Date:   Thu, 12 May 2022 07:25:55 -0700
Message-Id: <20220512142555.3554396-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH v2] kunit: tool: stop using a shell to run kernel under QEMU
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Note: this potentially breaks custom qemu_configs if people are using
them! But the fix for them is simple, don't specify multiple arguments
in one string and don't add on a redundant ''.

It feels a bit iffy to be using a shell in the first place.

There's the usual shenanigans where people could pass in arbitrary shell
commands via --kernel_arg (since we're just adding '' around the
kernel_cmdline) or via a custom qemu_config.
This isn't too much of a concern given the nature of this script (and
the qemu_config file is in python, you can do w/e you want already).

But it does have some other drawbacks.

One example of a kunit-specific pain point:
If the relevant qemu binary is missing, we get output like this:
> /bin/sh: line 1: qemu-system-aarch64: command not found
This in turn results in our KTAP parser complaining about
missing/invalid KTAP, but we don't directly show the error!
It's even more annoying to debug when you consider --raw_output only
shows KUnit output by default, i.e. you need --raw_output=all to see it.

Whereas directly invoking the binary, Python will raise a
FileNotFoundError for us, which is a noisier but more clear.

Making this change requires
* splitting parameters like ['-m 256'] into ['-m', '256'] in
  kunit/qemu_configs/*.py
* change [''] to [] in kunit/qemu_configs/*.py since otherwise
  QEMU fails w/ 'Device needs media, but drive is empty'
* dropping explicit quoting of the kernel cmdline
* using shlex.quote() when we print what command we're running
  so the user can copy-paste and run it

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
v1 -> v2: fix typo (' pseries' => 'pseries')
---
 tools/testing/kunit/kunit_kernel.py         | 18 ++++++++++--------
 tools/testing/kunit/qemu_configs/alpha.py   |  2 +-
 tools/testing/kunit/qemu_configs/arm.py     |  2 +-
 tools/testing/kunit/qemu_configs/arm64.py   |  2 +-
 tools/testing/kunit/qemu_configs/i386.py    |  2 +-
 tools/testing/kunit/qemu_configs/powerpc.py |  2 +-
 tools/testing/kunit/qemu_configs/riscv.py   |  6 +++---
 tools/testing/kunit/qemu_configs/s390.py    |  4 ++--
 tools/testing/kunit/qemu_configs/sparc.py   |  2 +-
 tools/testing/kunit/qemu_configs/x86_64.py  |  2 +-
 10 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 483f78e15ce9..1b9c4922a675 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -11,6 +11,7 @@ import importlib.util
 import logging
 import subprocess
 import os
+import shlex
 import shutil
 import signal
 import threading
@@ -118,16 +119,17 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
 				'-nodefaults',
 				'-m', '1024',
 				'-kernel', kernel_path,
-				'-append', '\'' + ' '.join(params + [self._kernel_command_line]) + '\'',
+				'-append', ' '.join(params + [self._kernel_command_line]),
 				'-no-reboot',
 				'-nographic',
-				'-serial stdio'] + self._extra_qemu_params
-		print('Running tests with:\n$', ' '.join(qemu_command))
-		return subprocess.Popen(' '.join(qemu_command),
-					   stdin=subprocess.PIPE,
-					   stdout=subprocess.PIPE,
-					   stderr=subprocess.STDOUT,
-					   text=True, shell=True, errors='backslashreplace')
+				'-serial', 'stdio'] + self._extra_qemu_params
+		# Note: shlex.join() does what we want, but requires python 3.8+.
+		print('Running tests with:\n$', ' '.join(shlex.quote(arg) for arg in qemu_command))
+		return subprocess.Popen(qemu_command,
+					stdin=subprocess.PIPE,
+					stdout=subprocess.PIPE,
+					stderr=subprocess.STDOUT,
+					text=True, errors='backslashreplace')
 
 class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
 	"""An abstraction over command line operations performed on a source tree."""
diff --git a/tools/testing/kunit/qemu_configs/alpha.py b/tools/testing/kunit/qemu_configs/alpha.py
index 5d0c0cff03bd..3ac846e03a6b 100644
--- a/tools/testing/kunit/qemu_configs/alpha.py
+++ b/tools/testing/kunit/qemu_configs/alpha.py
@@ -7,4 +7,4 @@ CONFIG_SERIAL_8250_CONSOLE=y''',
 			   qemu_arch='alpha',
 			   kernel_path='arch/alpha/boot/vmlinux',
 			   kernel_command_line='console=ttyS0',
-			   extra_qemu_params=[''])
+			   extra_qemu_params=[])
diff --git a/tools/testing/kunit/qemu_configs/arm.py b/tools/testing/kunit/qemu_configs/arm.py
index b9c2a35e0296..db2160200566 100644
--- a/tools/testing/kunit/qemu_configs/arm.py
+++ b/tools/testing/kunit/qemu_configs/arm.py
@@ -10,4 +10,4 @@ CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
 			   qemu_arch='arm',
 			   kernel_path='arch/arm/boot/zImage',
 			   kernel_command_line='console=ttyAMA0',
-			   extra_qemu_params=['-machine virt'])
+			   extra_qemu_params=['-machine', 'virt'])
diff --git a/tools/testing/kunit/qemu_configs/arm64.py b/tools/testing/kunit/qemu_configs/arm64.py
index 517c04459f47..67d04064f785 100644
--- a/tools/testing/kunit/qemu_configs/arm64.py
+++ b/tools/testing/kunit/qemu_configs/arm64.py
@@ -9,4 +9,4 @@ CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
 			   qemu_arch='aarch64',
 			   kernel_path='arch/arm64/boot/Image.gz',
 			   kernel_command_line='console=ttyAMA0',
-			   extra_qemu_params=['-machine virt', '-cpu cortex-a57'])
+			   extra_qemu_params=['-machine', 'virt', '-cpu', 'cortex-a57'])
diff --git a/tools/testing/kunit/qemu_configs/i386.py b/tools/testing/kunit/qemu_configs/i386.py
index aed3ffd3937d..52b80be40e4b 100644
--- a/tools/testing/kunit/qemu_configs/i386.py
+++ b/tools/testing/kunit/qemu_configs/i386.py
@@ -7,4 +7,4 @@ CONFIG_SERIAL_8250_CONSOLE=y''',
 			   qemu_arch='x86_64',
 			   kernel_path='arch/x86/boot/bzImage',
 			   kernel_command_line='console=ttyS0',
-			   extra_qemu_params=[''])
+			   extra_qemu_params=[])
diff --git a/tools/testing/kunit/qemu_configs/powerpc.py b/tools/testing/kunit/qemu_configs/powerpc.py
index 35e9de24f0db..7ec38d4131f7 100644
--- a/tools/testing/kunit/qemu_configs/powerpc.py
+++ b/tools/testing/kunit/qemu_configs/powerpc.py
@@ -9,4 +9,4 @@ CONFIG_HVC_CONSOLE=y''',
 			   qemu_arch='ppc64',
 			   kernel_path='vmlinux',
 			   kernel_command_line='console=ttyS0',
-			   extra_qemu_params=['-M pseries', '-cpu power8'])
+			   extra_qemu_params=['-M', 'pseries', '-cpu', 'power8'])
diff --git a/tools/testing/kunit/qemu_configs/riscv.py b/tools/testing/kunit/qemu_configs/riscv.py
index 9e528087cd7c..b882fde39435 100644
--- a/tools/testing/kunit/qemu_configs/riscv.py
+++ b/tools/testing/kunit/qemu_configs/riscv.py
@@ -26,6 +26,6 @@ CONFIG_SERIAL_EARLYCON_RISCV_SBI=y''',
 			   kernel_path='arch/riscv/boot/Image',
 			   kernel_command_line='console=ttyS0',
 			   extra_qemu_params=[
-					   '-machine virt',
-					   '-cpu rv64',
-					   '-bios opensbi-riscv64-generic-fw_dynamic.bin'])
+					   '-machine', 'virt',
+					   '-cpu', 'rv64',
+					   '-bios', 'opensbi-riscv64-generic-fw_dynamic.bin'])
diff --git a/tools/testing/kunit/qemu_configs/s390.py b/tools/testing/kunit/qemu_configs/s390.py
index e310bd521113..98fa4fb60c0a 100644
--- a/tools/testing/kunit/qemu_configs/s390.py
+++ b/tools/testing/kunit/qemu_configs/s390.py
@@ -10,5 +10,5 @@ CONFIG_MODULES=y''',
 			   kernel_path='arch/s390/boot/bzImage',
 			   kernel_command_line='console=ttyS0',
 			   extra_qemu_params=[
-					   '-machine s390-ccw-virtio',
-					   '-cpu qemu',])
+					   '-machine', 's390-ccw-virtio',
+					   '-cpu', 'qemu',])
diff --git a/tools/testing/kunit/qemu_configs/sparc.py b/tools/testing/kunit/qemu_configs/sparc.py
index 27f474e7ad6e..e975c4331a7c 100644
--- a/tools/testing/kunit/qemu_configs/sparc.py
+++ b/tools/testing/kunit/qemu_configs/sparc.py
@@ -7,4 +7,4 @@ CONFIG_SERIAL_8250_CONSOLE=y''',
 			   qemu_arch='sparc',
 			   kernel_path='arch/sparc/boot/zImage',
 			   kernel_command_line='console=ttyS0 mem=256M',
-			   extra_qemu_params=['-m 256'])
+			   extra_qemu_params=['-m', '256'])
diff --git a/tools/testing/kunit/qemu_configs/x86_64.py b/tools/testing/kunit/qemu_configs/x86_64.py
index 77ab1aeee8a3..dc7949076863 100644
--- a/tools/testing/kunit/qemu_configs/x86_64.py
+++ b/tools/testing/kunit/qemu_configs/x86_64.py
@@ -7,4 +7,4 @@ CONFIG_SERIAL_8250_CONSOLE=y''',
 			   qemu_arch='x86_64',
 			   kernel_path='arch/x86/boot/bzImage',
 			   kernel_command_line='console=ttyS0',
-			   extra_qemu_params=[''])
+			   extra_qemu_params=[])

base-commit: 38289a26e1b8a37755f3e07056ca416c1ee2a2e8
-- 
2.36.0.512.ge40c2bad7a-goog

