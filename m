Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D1B776CC7
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 01:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjHIXYa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 19:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjHIXY3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 19:24:29 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2131E42
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Aug 2023 16:24:24 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bba54f7eefso10513625ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Aug 2023 16:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691623464; x=1692228264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqoPeA6wKcuCb1RtSAVao8nNOFMZCDDFQoFYxZEN+6o=;
        b=gm83jILUNh6/zUoHxIyJIwVa+3RhunqO72lQbd7nCP8mXnRB6+Q8xAJWnBgKIxVv/Z
         xK5JgJo0QvTKYA7DYV/AHIrOZ1B5IbILi3JVN3JmDwfaP2D6wMjQlPAjGIWqhmKCPxHi
         PxK3A+wH/hdiwJiOuTAivkS+xdvLEkANWyAJRr66/sAkUjh3MLlNgn0m5W0nG7o6OBjQ
         luhey6ythegI/26xUwHqziHB5B2ze0H/YpU4ElAtp4496rPsdLsI1CozqbhwHtNFSo8O
         P3p726zTROCmGKUUDst8emxPfWRQsLv5dRQ8HWgZZFM2zUtJ0TmIcnWUOoOKiXjhnXHV
         rYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691623464; x=1692228264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqoPeA6wKcuCb1RtSAVao8nNOFMZCDDFQoFYxZEN+6o=;
        b=lbDMiqxFwKOxuzE4ibdZ5EqLcbJDhiuh1Za7wSDiDn2spFfZTj0kCGdH2OoIDmkBkI
         /wihLiYei78V5qZZ9TnQ2DR4zv55M+Blesr7wMk6iLLd1qOUJa94756qmvOj4GUfWzLz
         1b/NgnrBHGzPtLZY64zMrz75RrlePg8q5UoNFqw2bkxfT9xJ0RuYB828oEXzLl6IpXT6
         74QybFj4Y8FcKMrjbdRvw3gx8YCJrj1XH6pazStkAzzxC9+4BKqceoVCQrIjlekyHD1K
         YacS7Vb4fDF2vLBqMTRPDYvoA4pJvpsfeYW8KVkpJo6rfWWagL+pLNm2EVh9THIhp92N
         sHyA==
X-Gm-Message-State: AOJu0Ywf2WJeoRDpqu6mXGPIuinLkfzNfSOkvsvpZm69mOLbRyhMj/Pm
        XrQZZDCfu89xeTPQdKONrYdVBQ==
X-Google-Smtp-Source: AGHT+IHcvB5aZ1/jH0xEHaj38dn4RpyZuSnSm8co06xmNZJ+mCf4bPmLMzzwfzqyOgM8RXZLwQ3GHw==
X-Received: by 2002:a17:902:c101:b0:1b6:9954:2030 with SMTP id 1-20020a170902c10100b001b699542030mr458836pli.8.1691623464252;
        Wed, 09 Aug 2023 16:24:24 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id l18-20020a170902d35200b001b54d064a4bsm82765plk.259.2023.08.09.16.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 16:24:23 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: [PATCH v10 2/4] RISC-V: mm: Add tests for RISC-V mm
Date:   Wed,  9 Aug 2023 16:22:02 -0700
Message-ID: <20230809232218.849726-3-charlie@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809232218.849726-1-charlie@rivosinc.com>
References: <20230809232218.849726-1-charlie@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index 000000000000..9b8434f62f57
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
+static inline void do_mmaps(struct addresses *mmap_addresses)
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
+static inline int memory_layout(void)
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
2.34.1

