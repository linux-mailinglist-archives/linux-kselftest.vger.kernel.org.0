Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D9F50916E
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 22:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382145AbiDTUdT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Apr 2022 16:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382143AbiDTUdR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Apr 2022 16:33:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BFB377C7
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Apr 2022 13:30:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b11-20020a5b008b000000b00624ea481d55so2500184ybp.19
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Apr 2022 13:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AXD6tg0Y/lSZ4l/KU4T2EXjDq6mZdsK/9IDg33E4+DA=;
        b=qwZe0Qz42RUbQQDExper1fKktpd02nJILCYCAaAF8IT4RrvRn/Sgg/K9iLi6C9d7Z7
         CefqGeUGfmTZbYxwBHWGjNzcPIwDcG1ruhL9E9q+tm34m3EuhQNo7gZvDOKouClwoZwY
         Anzy9OvgJPS2lFEb4dWeSSQIQfrw2IjnOqYj7JjPWTfuc5L2zQnT8wLJyqrH+mnyK7xH
         G22pVzEcPGxVfrM7mWqUfhQ79H3/SU2vp+9AqtdaFjJxzH8Qb01Dibznk5cJn+qtZ6bK
         Ekr6iFjyoSNuuV1noVL1hNL35cwbkREvHwc6PkuWBQ6lXmZmfsOSnHU91c4vAHo0a4ed
         BsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AXD6tg0Y/lSZ4l/KU4T2EXjDq6mZdsK/9IDg33E4+DA=;
        b=sZ7OzNRW1Fhw5m9yzPkB15BiOQL81KEepoaKN6QK9Agsm/99aSqvhZ8Sy2d41ucdqf
         lwM60z1cL0wOgdX86//7X9D/zyU7dEgHFV/1BnWZQiU8pEb6sRXgX+wD2lLHpzJkkyUc
         KwmhXb4DhfqgwaUQcElfTqf77lR98jD+GU8Uoi1PEymH0wmAR6g2hiuVISbkFfrcOKYm
         69STvFePFdd3r0dk4efn5IfnS8DZTbWpoPUOYEnO8uf+LR295b3AN9Zv0kPytAyFmkyE
         PwQehOaZ5A0MEDAj997830RX7kiYZ3ZKakpHoM9mFrEwbR9map1mmtQKKicUMhnyfws+
         UGcg==
X-Gm-Message-State: AOAM530MwSMQWccgZ/Rqthw5IeEl5vXH2YaqKulwnZ2OTS83k2TNyJvZ
        IO9mrKgc0Y+5mQv6cCcq+OCAmk8ZXbd1ZQ==
X-Google-Smtp-Source: ABdhPJyeZNWg0oaUVoRVWM+O13/EhmeQRvWqCylEwV+94Me2sT9LP1a8LKqYUGIgbvH6iw+XwaE92QePTs6rjg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:ccc:f7fa:7a7e:1435])
 (user=dlatypov job=sendgmr) by 2002:a25:bc04:0:b0:641:cfe9:ff38 with SMTP id
 i4-20020a25bc04000000b00641cfe9ff38mr21647645ybh.213.1650486629286; Wed, 20
 Apr 2022 13:30:29 -0700 (PDT)
Date:   Wed, 20 Apr 2022 13:30:20 -0700
Message-Id: <20220420203020.1412886-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH] kunit: tool: stop using a shell to run kernel under QEMU
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 35e9de24f0db..6c901149726b 100644
--- a/tools/testing/kunit/qemu_configs/powerpc.py
+++ b/tools/testing/kunit/qemu_configs/powerpc.py
@@ -9,4 +9,4 @@ CONFIG_HVC_CONSOLE=y''',
 			   qemu_arch='ppc64',
 			   kernel_path='vmlinux',
 			   kernel_command_line='console=ttyS0',
-			   extra_qemu_params=['-M pseries', '-cpu power8'])
+			   extra_qemu_params=['-M', ' pseries', '-cpu', 'power8'])
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

base-commit: 59729170afcd4900e08997a482467ffda8d88c7f
-- 
2.36.0.rc0.470.gd361397f0d-goog

