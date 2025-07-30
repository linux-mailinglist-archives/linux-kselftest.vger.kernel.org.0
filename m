Return-Path: <linux-kselftest+bounces-38086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3698EB16652
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 20:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712571AA7894
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 18:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6788E2DFF19;
	Wed, 30 Jul 2025 18:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEgCSfkT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA65B15D1;
	Wed, 30 Jul 2025 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753900416; cv=none; b=mLYaHd7HyWcU5iyCEWRdVUxhWzCtlDWVkkcHwlj4JvxR7ry6OMsuTdSoKcm0BuvoivCiUjwl0pN1UDOx3oIH/tN1FRKuCwPxeIEuVl79DcJn3YSU+hH1HuOxq0+ITNm7m44/VAunwyzOyx9q/UhliblF4OjW3YTeqrn1XNjvMXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753900416; c=relaxed/simple;
	bh=K75OD8oDjI/AOWUQUKexEk5vDgahZSkGDyUgITfjITc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uslNbtWZvkxaiMdWfQzGbIv/I1dSNH3WgaFAjXbmehc2fsAP7Xk7kzksDI+hFWuCQ9zjarNBxZZu8ILDn9pRlDATbd+fl3BSUqzEfCAJMVZNxlqvli5wXppL1Cpd5A/Gb/zZr+C1GQPIHCAWvExujDT2KtXmOO2srewP1p009R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEgCSfkT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-240418cbb8bso954235ad.2;
        Wed, 30 Jul 2025 11:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753900414; x=1754505214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LXC/P3UhtK4ADtDq003zjxL7YJD8iyJ1al2gSLKcFg=;
        b=XEgCSfkTMQPmvhQ5FCPzyW0hHvGPRoEVIav36jcDexUN5QJDkauu29ybhBHuvZkg0g
         jE1dS0l7RcjMYERN0oDgWUmJbZAOAyXih40b4afyj3P4BKJk8cOND5DdU/KOHDegmHZY
         R4edQsIhpZAi7lke3EgkiLxWegSpQOxjszlMja+glVo33pAFp0XgjQFlTed6lxpUoOH2
         hDmImDGHHCc30SnkDn9JVsJu9bihbTl37VknIEDnX6rJjAKsMsrrTaQCyHmloY0SO4SS
         MsZcWHB5XE4TGlcV+PoDLShDHTxc5f5wpbh/a5WkeuQm9OVtYkPkkxsMCkMAWCq/q/35
         61+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753900414; x=1754505214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LXC/P3UhtK4ADtDq003zjxL7YJD8iyJ1al2gSLKcFg=;
        b=lS/B37vBU57P4dBYWokVqTLi+1rd8cPOaS0rWTdjzaP1sErt0nj5xR6b9I5xl6FUO/
         CIdM7jSR6AO4Y0iHY+9Rcu+KUshR+8Wf+eRD+Glc7wcas2RHV4iQE0CVF9oxXGK0g93X
         2KRllhg8wh4Sfz8s9VfxwlEgiXOq4WPIsqGZC+kNgzd8ld7BwAcJIuuD9yTECFqCZKYN
         L4vphayNfHakT8O7+OSZbXAiu0FK/50HAmjzTtMVklBhE6B64XvK0HP1mDrV9EhD2oaB
         B8tL2cyAwOgWkdb6+wnmjOHOyYzT8Mm3Og12pRkiywNovoglDRRjxm87o2fRUcdlNNZ2
         Hcqw==
X-Forwarded-Encrypted: i=1; AJvYcCXS/cASSsE29ya6vZ+xF61Ctz8IicAPswutDBhE5qY8j9Ms7ahFxbF2vJGDe5JxAob5+6rUfi5ScpQvHiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjP5y6yuW62zOkUXOgUFHDmVuxLoNXpfC566UBhjUBzt4hUQEc
	m6CNStWXPly4SFLdnzXbayLcLYKMSf8hIRYaL5lVna0dVoZfaSlmimzo
X-Gm-Gg: ASbGncuL/inWvf5WugRcmQn35rcsgf/98gCqAzAkwNwd/cBpAHpclYiSjFwQh4LXRSI
	X771ZpbIwTrpAcsRaQv65EbKr0j9c0WiUmJfllzMKCWKdTkk9nkI6yPZJ2h5A4gBHvwZn13b/he
	aeWuWADQ6PlAYwnJjA4m/IsQyaI2H02jTAp/GUB6T/Zp8WHTP0I8bmNUW74ET7fBcwHxViHpr4H
	ed5yCTrEhySgjKnSk1zP3jmoM82PVLx2g44VKNsgxpy8lDWY/fYpU2gqXGSaSkpTTQe0UXEA/ol
	Hkhm0Hw6fYsaH60vwKQVUTcVlVIGitiIp2ewPR3WIMRXaOmIk81ueePcn9HyiKOMxe4oCHhcI5a
	vF92SOVbtFp5NfsaZfbrUWe2asbqUpxiSYmcrbYFdLbG6AhU1KbAh
X-Google-Smtp-Source: AGHT+IHpBy+0LBCwjzZmW3aB+1tGd+YleBhuJ3andCoDufWYPAvK8XzlVHgKxfLqC4B5sYbKRBXdmQ==
X-Received: by 2002:a17:903:198d:b0:23f:b112:2eaa with SMTP id d9443c01a7336-24096b23962mr61649835ad.41.1753900413613;
        Wed, 30 Jul 2025 11:33:33 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d021:481c:67c7:4b27:6088:74d5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fc5a9d219sm104643095ad.98.2025.07.30.11.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 11:33:32 -0700 (PDT)
From: Vishal Parmar <vishistriker@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vishal Parmar <vishistriker@gmail.com>
Subject: [PATCH v2] Subject: [PATCH] selftests: panic: Add test module to trigger kernel panic
Date: Thu, 31 Jul 2025 00:03:27 +0530
Message-Id: <20250730183327.1001875-1-vishistriker@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730172707.999401-1-vishistriker@gmail.com>
References: <20250730172707.999401-1-vishistriker@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a new test module under tools/testing/selftests/panic
that intentionally triggers a kernel panic for test and diagnostic
purposes. The goal is to provide a reproducible and isolated kernel
panic event for testing crash dump mechanisms or validating kernel
panic handling behavior.

The test includes:
- A kernel module that calls panic() in init.
- A Makefile to build the kernel module.
- A run.sh script to load the module and capture panic logs.

Changes in v2:
- Added run.sh
- Added reference output log of run.sh

Signed-off-by: Vishal Parmar <vishistriker@gmail.com>
---
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/panic/Makefile        | 13 +++++++++
 .../selftests/panic/panic_trigger_test.c      | 26 +++++++++++++++++
 .../selftests/panic/reference_output_log.txt  | 29 +++++++++++++++++++
 tools/testing/selftests/panic/run.sh          | 17 +++++++++++
 5 files changed, 86 insertions(+)
 create mode 100644 tools/testing/selftests/panic/Makefile
 create mode 100644 tools/testing/selftests/panic/panic_trigger_test.c
 create mode 100644 tools/testing/selftests/panic/reference_output_log.txt
 create mode 100755 tools/testing/selftests/panic/run.sh

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 339b31e6a6b5..7b824470a9b3 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -78,6 +78,7 @@ TARGETS += net/packetdrill
 TARGETS += net/rds
 TARGETS += net/tcp_ao
 TARGETS += nsfs
+TARGETS += panic
 TARGETS += pci_endpoint
 TARGETS += pcie_bwctrl
 TARGETS += perf_events
diff --git a/tools/testing/selftests/panic/Makefile b/tools/testing/selftests/panic/Makefile
new file mode 100644
index 000000000000..e4a1b88a63b2
--- /dev/null
+++ b/tools/testing/selftests/panic/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-m := panic_trigger_test.o
+
+KDIR := $(abspath ../../../../)
+PWD  := $(shell pwd)
+
+all:
+	$(MAKE) -C $(KDIR) M=$(PWD) modules
+
+clean:
+	$(MAKE) -C $(KDIR) M=$(PWD) clean
+	rm -f *.mod.c *.o *.ko *.order *.symvers
diff --git a/tools/testing/selftests/panic/panic_trigger_test.c b/tools/testing/selftests/panic/panic_trigger_test.c
new file mode 100644
index 000000000000..4e2e043fe3ad
--- /dev/null
+++ b/tools/testing/selftests/panic/panic_trigger_test.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * panic_test.c - Module to test kernel panic
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+
+static int __init panic_test_init(void)
+{
+    pr_info("Triggering a deliberate kernel panic now.\n");
+    panic("Triggered by panic_test module.");
+    return 0;
+}
+
+static void __exit panic_test_exit(void)
+{
+    pr_info("This should not be printed, as system panics on init.\n");
+}
+
+module_init(panic_test_init);
+module_exit(panic_test_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Vishal Parmar");
+MODULE_DESCRIPTION("Module to trigger kernel panic for testing");
diff --git a/tools/testing/selftests/panic/reference_output_log.txt b/tools/testing/selftests/panic/reference_output_log.txt
new file mode 100644
index 000000000000..2c8143bf6c4a
--- /dev/null
+++ b/tools/testing/selftests/panic/reference_output_log.txt
@@ -0,0 +1,29 @@
+[*] Inserting module: panic_trigger_test.ko
+[   30.377307] panic_trigger_test: loading out-of-tree module taints kernel.
+[   30.380328] Triggering a deliberate kernel panic now.
+[   30.382369] Kernel panic - not syncing: Triggered by panic_test module.
+[   30.383349] CPU: 1 UID: 0 PID: 99 Comm: insmod Tainted: G           O        6.16.0-rc7-00140-gec2df4364666 #1 PREEMPT(voluntary) 
+[   30.383349] Tainted: [O]=OOT_MODULE
+[   30.383349] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
+[   30.383349] Call Trace:
+[   30.383349]  <TASK>
+[   30.383349]  panic+0x325/0x380
+[   30.383349]  ? __pfx_panic_test_init+0x10/0x10 [panic_trigger_test]
+[   30.383349]  panic_test_init+0x1c/0xff0 [panic_trigger_test]
+[   30.383349]  do_one_initcall+0x55/0x220
+[   30.383349]  do_init_module+0x5b/0x230
+[   30.383349]  __do_sys_init_module+0x150/0x180
+[   30.383349]  do_syscall_64+0xa4/0x260
+[   30.383349]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
+[   30.383349] RIP: 0033:0x7f88f09177d9
+[   30.383349] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f7 05 8
+[   30.383349] RSP: 002b:00007ffc16317848 EFLAGS: 00000206 ORIG_RAX: 00000000000000af
+[   30.383349] RAX: ffffffffffffffda RBX: 000055a4a84b0eae RCX: 00007f88f09177d9
+[   30.383349] RDX: 000055a4a84b0eae RSI: 00000000000019e8 RDI: 000055a4c9b4b370
+[   30.383349] RBP: 00007ffc16317bd0 R08: 000055a4c9b4b310 R09: 00000000000019e8
+[   30.383349] R10: 0000000000000007 R11: 0000000000000206 R12: 00007ffc16317bd8
+[   30.383349] R13: 00007ffc16317be0 R14: 000055a4a84b0eae R15: 00007f88f0b25020
+[   30.383349]  </TASK>
+[   30.383349] Kernel Offset: 0x10000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
+[   30.383349] ---[ end Kernel panic - not syncing: Triggered by panic_test module. ]---
+
diff --git a/tools/testing/selftests/panic/run.sh b/tools/testing/selftests/panic/run.sh
new file mode 100755
index 000000000000..ffa20dc22708
--- /dev/null
+++ b/tools/testing/selftests/panic/run.sh
@@ -0,0 +1,17 @@
+# tools/testing/selftests/panic/run.sh
+
+#!/bin/sh
+set -e
+
+MOD_NAME="panic_trigger_test.ko"
+LOG_FILE="panic_log.txt"
+
+echo "[*] Clearing dmesg..."
+dmesg -c
+
+echo "[*] Inserting module: $MOD_NAME"
+insmod ./$MOD_NAME
+
+echo "[*] Capturing dmesg..."
+dmesg > "$LOG_FILE"
+
-- 
2.39.5


