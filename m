Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA580765E23
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 23:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjG0V1A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 17:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjG0V04 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 17:26:56 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD6D1BC1
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 14:26:54 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686ea67195dso1148737b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 14:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690493214; x=1691098014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTyjwJ6/AkKvsr8TkfjD+hMv/+AP+4ITK7UKxmmUnHc=;
        b=Sg1Dwaa2hhNk+ptzUWDlhDziLQ7BYdhCwNr7XG+A7ALHhZ6cxngoMChZZks5hfTrMs
         MphNFVoom+/MTDIlLL3A0DgafopRx4dG9XeqhwbGAxXetU1et0fbhYOxFtD5wZX4Un9f
         MxohIFvJ3Bx15Dy3QaN+juClp/XtolsHoBP7WewspMul+5TyY3LFsvYFsa+p+F7dASAs
         8KzKQ7sAuXE9YTKFSYoI2gSyDYJbuSzFCX3R0xBHM0kWH/4hzGeWQQwKjUtC3LPWQUqZ
         hvRPDa8Gi9VIS6DsUtg8Guw7ADzJjJpxUC95YnIXmy9ctQprbV7s12dIRS4wmTWwrHqA
         LhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690493214; x=1691098014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTyjwJ6/AkKvsr8TkfjD+hMv/+AP+4ITK7UKxmmUnHc=;
        b=PaxwuXLE1zF7wHtMmPoiWRso/Rk6mubDwu+B01L/l8562Eah1cXK/yOHCmn4Jp3QC2
         +9HbWQdt+3fM3jKxiVrvrSje73lE1DR907X7GekgVOn9MS4MsvCl+poGorsk5qFnVP5f
         70imCaQYoeVm6AXXssWq0cBw7PhxEFzstZLHzELWjE//kRukSahTfr6ExUWQ9jlf0Aak
         /W3psRoQdBwPZ+u6vPxJrGszlGmHhznUJI9XURoXgsd54QDzPjkBKp+iUw/nzdRGl+AQ
         mWdrYtMOOr9soBF5i6USSZZc0PU8waQlJ6n+9Szsc9QHidTkXjCUdQW6K0gGlzNiCDoG
         pMPQ==
X-Gm-Message-State: ABy/qLaWoIGwQoWoKQTFZm/WLGXe5LTD1JfAPqCN5+l8dX6HGOGzGl1U
        YLJ/St6R3I/PYj/TmkYqqrjvAg==
X-Google-Smtp-Source: APBJJlFFWYLTEbKLA8egXy5s3u+cXeAgzBIdat1e55NXRuoAca70SNRbD9GZigSou7wX9EmZTVDckA==
X-Received: by 2002:a05:6a20:3d21:b0:134:f040:e967 with SMTP id y33-20020a056a203d2100b00134f040e967mr255099pzi.61.1690493213881;
        Thu, 27 Jul 2023 14:26:53 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id c5-20020aa78c05000000b00682562b1549sm1912312pfd.24.2023.07.27.14.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 14:26:53 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: [PATCH v8 2/4] RISC-V: mm: Add tests for RISC-V mm
Date:   Thu, 27 Jul 2023 14:26:27 -0700
Message-ID: <20230727212647.4182407-3-charlie@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727212647.4182407-1-charlie@rivosinc.com>
References: <20230727212647.4182407-1-charlie@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add tests that enforce mmap hint address behavior. mmap should default
to sv48. mmap will provide an address at the highest address space that
can fit into the hint address, unless the hint address is less than sv39
and not 0, then it will return a sv39 address.

These tests are split into two files: mmap_default.c and mmap_bottomup.c
because a new process must be exec'd in order to change the mmap layout.
The run_mmap.sh script sets the stack to be unlimited for the
mmap_bottomup.c test which triggers a bottomup layout.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/testing/selftests/riscv/Makefile        |  2 +-
 tools/testing/selftests/riscv/mm/.gitignore   |  2 +
 tools/testing/selftests/riscv/mm/Makefile     | 15 +++++
 .../riscv/mm/testcases/mmap_bottomup.c        | 35 ++++++++++
 .../riscv/mm/testcases/mmap_default.c         | 35 ++++++++++
 .../selftests/riscv/mm/testcases/mmap_test.h  | 64 +++++++++++++++++++
 .../selftests/riscv/mm/testcases/run_mmap.sh  | 12 ++++
 7 files changed, 164 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/riscv/mm/.gitignore
 create mode 100644 tools/testing/selftests/riscv/mm/Makefile
 create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap_bottomup.c
 create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap_default.c
 create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap_test.h
 create mode 100755 tools/testing/selftests/riscv/mm/testcases/run_mmap.sh

diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
index f4b3d5c9af5b..4a9ff515a3a0 100644
--- a/tools/testing/selftests/riscv/Makefile
+++ b/tools/testing/selftests/riscv/Makefile
@@ -5,7 +5,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),riscv))
-RISCV_SUBTARGETS ?= hwprobe vector
+RISCV_SUBTARGETS ?= hwprobe vector mm
 else
 RISCV_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/riscv/mm/.gitignore b/tools/testing/selftests/riscv/mm/.gitignore
new file mode 100644
index 000000000000..5c2c57cb950c
--- /dev/null
+++ b/tools/testing/selftests/riscv/mm/.gitignore
@@ -0,0 +1,2 @@
+mmap_bottomup
+mmap_default
diff --git a/tools/testing/selftests/riscv/mm/Makefile b/tools/testing/selftests/riscv/mm/Makefile
new file mode 100644
index 000000000000..11e0f0568923
--- /dev/null
+++ b/tools/testing/selftests/riscv/mm/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 ARM Limited
+# Originally tools/testing/arm64/abi/Makefile
+
+# Additional include paths needed by kselftest.h and local headers
+CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
+
+TEST_GEN_FILES := testcases/mmap_default testcases/mmap_bottomup
+
+TEST_PROGS := testcases/run_mmap.sh
+
+include ../../lib.mk
+
+$(OUTPUT)/mm: testcases/mmap_default.c testcases/mmap_bottomup.c testcases/mmap_tests.h
+	$(CC) -o$@ $(CFLAGS) $(LDFLAGS) $^
diff --git a/tools/testing/selftests/riscv/mm/testcases/mmap_bottomup.c b/tools/testing/selftests/riscv/mm/testcases/mmap_bottomup.c
new file mode 100644
index 000000000000..b29379f7e478
--- /dev/null
+++ b/tools/testing/selftests/riscv/mm/testcases/mmap_bottomup.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <sys/mman.h>
+#include <testcases/mmap_test.h>
+
+#include "../../kselftest_harness.h"
+
+TEST(infinite_rlimit)
+{
+// Only works on 64 bit
+#if __riscv_xlen == 64
+	struct addresses mmap_addresses;
+
+	EXPECT_EQ(BOTTOM_UP, memory_layout());
+
+	do_mmaps(&mmap_addresses);
+
+	EXPECT_NE(MAP_FAILED, mmap_addresses.no_hint);
+	EXPECT_NE(MAP_FAILED, mmap_addresses.on_37_addr);
+	EXPECT_NE(MAP_FAILED, mmap_addresses.on_38_addr);
+	EXPECT_NE(MAP_FAILED, mmap_addresses.on_46_addr);
+	EXPECT_NE(MAP_FAILED, mmap_addresses.on_47_addr);
+	EXPECT_NE(MAP_FAILED, mmap_addresses.on_55_addr);
+	EXPECT_NE(MAP_FAILED, mmap_addresses.on_56_addr);
+
+	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.no_hint);
+	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_37_addr);
+	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_38_addr);
+	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_46_addr);
+	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.on_47_addr);
+	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.on_55_addr);
+	EXPECT_GT(1UL << 56, (unsigned long)mmap_addresses.on_56_addr);
+#endif
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/riscv/mm/testcases/mmap_default.c b/tools/testing/selftests/riscv/mm/testcases/mmap_default.c
new file mode 100644
index 000000000000..d1accb91b726
--- /dev/null
+++ b/tools/testing/selftests/riscv/mm/testcases/mmap_default.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <sys/mman.h>
+#include <testcases/mmap_test.h>
+
+#include "../../kselftest_harness.h"
+
+TEST(default_rlimit)
+{
+// Only works on 64 bit
+#if __riscv_xlen == 64
+	struct addresses mmap_addresses;
+
+	EXPECT_EQ(TOP_DOWN, memory_layout());
+
+	do_mmaps(&mmap_addresses);
+
+	EXPECT_NE(MAP_FAILED, mmap_addresses.no_hint);
+	EXPECT_NE(MAP_FAILED, mmap_addresses.on_37_addr);
+	EXPECT_NE(MAP_FAILED, mmap_addresses.on_38_addr);
+	EXPECT_NE(MAP_FAILED, mmap_addresses.on_46_addr);
+	EXPECT_NE(MAP_FAILED, mmap_addresses.on_47_addr);
+	EXPECT_NE(MAP_FAILED, mmap_addresses.on_55_addr);
+	EXPECT_NE(MAP_FAILED, mmap_addresses.on_56_addr);
+
+	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.no_hint);
+	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_37_addr);
+	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_38_addr);
+	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_46_addr);
+	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.on_47_addr);
+	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.on_55_addr);
+	EXPECT_GT(1UL << 56, (unsigned long)mmap_addresses.on_56_addr);
+#endif
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/riscv/mm/testcases/mmap_test.h b/tools/testing/selftests/riscv/mm/testcases/mmap_test.h
new file mode 100644
index 000000000000..98a892de5d19
--- /dev/null
+++ b/tools/testing/selftests/riscv/mm/testcases/mmap_test.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _TESTCASES_MMAP_TEST_H
+#define _TESTCASES_MMAP_TEST_H
+#include <sys/mman.h>
+#include <sys/resource.h>
+#include <stddef.h>
+
+#define TOP_DOWN 0
+#define BOTTOM_UP 1
+
+struct addresses {
+	int *no_hint;
+	int *on_37_addr;
+	int *on_38_addr;
+	int *on_46_addr;
+	int *on_47_addr;
+	int *on_55_addr;
+	int *on_56_addr;
+};
+
+void do_mmaps(struct addresses *mmap_addresses)
+{
+	/*
+	 * Place all of the hint addresses on the boundaries of mmap
+	 * sv39, sv48, sv57
+	 * User addresses end at 1<<38, 1<<47, 1<<56 respectively
+	 */
+	void *on_37_bits = (void *)(1UL << 37);
+	void *on_38_bits = (void *)(1UL << 38);
+	void *on_46_bits = (void *)(1UL << 46);
+	void *on_47_bits = (void *)(1UL << 47);
+	void *on_55_bits = (void *)(1UL << 55);
+	void *on_56_bits = (void *)(1UL << 56);
+
+	int prot = PROT_READ | PROT_WRITE;
+	int flags = MAP_PRIVATE | MAP_ANONYMOUS;
+
+	mmap_addresses->no_hint =
+		mmap(NULL, 5 * sizeof(int), prot, flags, 0, 0);
+	mmap_addresses->on_37_addr =
+		mmap(on_37_bits, 5 * sizeof(int), prot, flags, 0, 0);
+	mmap_addresses->on_38_addr =
+		mmap(on_38_bits, 5 * sizeof(int), prot, flags, 0, 0);
+	mmap_addresses->on_46_addr =
+		mmap(on_46_bits, 5 * sizeof(int), prot, flags, 0, 0);
+	mmap_addresses->on_47_addr =
+		mmap(on_47_bits, 5 * sizeof(int), prot, flags, 0, 0);
+	mmap_addresses->on_55_addr =
+		mmap(on_55_bits, 5 * sizeof(int), prot, flags, 0, 0);
+	mmap_addresses->on_56_addr =
+		mmap(on_56_bits, 5 * sizeof(int), prot, flags, 0, 0);
+}
+
+int memory_layout(void)
+{
+	int prot = PROT_READ | PROT_WRITE;
+	int flags = MAP_PRIVATE | MAP_ANONYMOUS;
+
+	void *value1 = mmap(NULL, sizeof(int), prot, flags, 0, 0);
+	void *value2 = mmap(NULL, sizeof(int), prot, flags, 0, 0);
+
+	return value2 > value1;
+}
+#endif /* _TESTCASES_MMAP_TEST_H */
diff --git a/tools/testing/selftests/riscv/mm/testcases/run_mmap.sh b/tools/testing/selftests/riscv/mm/testcases/run_mmap.sh
new file mode 100755
index 000000000000..ca5ad7c48bad
--- /dev/null
+++ b/tools/testing/selftests/riscv/mm/testcases/run_mmap.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+original_stack_limit=$(ulimit -s)
+
+./mmap_default
+
+# Force mmap_bottomup to be ran with bottomup memory due to
+# the unlimited stack
+ulimit -s unlimited
+./mmap_bottomup
+ulimit -s $original_stack_limit
-- 
2.41.0

