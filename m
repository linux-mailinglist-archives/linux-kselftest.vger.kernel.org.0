Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7716A752E33
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 02:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbjGNAPE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 20:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbjGNAPB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 20:15:01 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276792D4E
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 17:14:58 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso925442b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 17:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689293697; x=1689898497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0r7ylMNQwjmn0OPkYDCq51XOFGJFq+TLUQNF3+/r/M=;
        b=haAaWBwoChBxuD8Pfd0jAkJcxdJC/ed1uAjbiUoi8wxkZqPtdGIqgTjzZDWEVHfm6l
         51cEMf6gM8C228ZG9wuUj6Ivc7tJZw7r0io2/ZPsqcgxBdqiLweiZCxWUsEngg2ecRtE
         GdBQfbZVKOt60zzCFPWEmKotw0jdgng6Qx/y4iuGm/c8FyNYyzvwro/ej/o8MrP66pVo
         AaPyvF5/o9oO5Z+Xy390UDeaPuXxxrG4RrL9h6v2D1lOKHKTsgTLmmiZzMi8pzjuvV3p
         +yscdkzgS0W2beD1gigIVK8DdAuNL41aOf8gFXxon6B6Ney5K6npBCUq592PqPNl4fIe
         fRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689293697; x=1689898497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0r7ylMNQwjmn0OPkYDCq51XOFGJFq+TLUQNF3+/r/M=;
        b=gVoN4KyEYboFmj2oKtz+7GouoWIFyAsrAVKzE4BzQiBLz+cHkkFNPZiHH34OKVeysG
         w9xvxE0+/RdBkEE8KgLi7EDkFK2lk/uRo9e+GYoMwwxNVUkLU856g4l+k4HoaWFq4wOq
         DMBeCTX/bB/6ObSEy8twuShVZ8esWaGPdY53AVBkrSnDeh1srg6saSUqLkHdQ5f6uNwY
         BJbGV6jCkqvGE7rU7tNZMtN5U7i79n3olXry6//j6zGbp7YB3iAnOmt5W82ANtol5BbS
         rbExHz3TCtjj4jy8Sbo5hvTt0FyHx25lZRibhuZt+WynqyF0uDMjv85w9I9G4PTnXmDV
         /qWg==
X-Gm-Message-State: ABy/qLZhRQ9uvPx1claaH92hH9SfGOMaPYOkMiYSosaMCPWrc6Ylr7n8
        bWPxPBfdTmj5QIzB6sFx/g7Oaw==
X-Google-Smtp-Source: APBJJlHthF/xOQY29h/SyVgVkdQb7LnbuS2bmKCUB6lATpARVerASAF4xQ0wVKCbGUja7e5kDLb32A==
X-Received: by 2002:a05:6a20:3953:b0:12d:5b6:7b32 with SMTP id r19-20020a056a20395300b0012d05b67b32mr2817577pzg.3.1689293697603;
        Thu, 13 Jul 2023 17:14:57 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id x25-20020aa793b9000000b00673e652985esm5938107pff.44.2023.07.13.17.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 17:14:57 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: [PATCH v5 2/4] RISC-V: mm: Add tests for RISC-V mm
Date:   Thu, 13 Jul 2023 17:14:01 -0700
Message-ID: <20230714001430.75798-3-charlie@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714001430.75798-1-charlie@rivosinc.com>
References: <20230714001430.75798-1-charlie@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add tests that enforce mmap hint address behavior. mmap should default
to sv48. mmap will provide an address at the highest address space that
can fit into the hint address, unless the hint address is less than sv39
and not 0, then it will return a sv39 address. In addition, ensure that
rlimit changes do not cause mmap to fail.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/testing/selftests/riscv/Makefile        |   2 +-
 tools/testing/selftests/riscv/mm/.gitignore   |   1 +
 tools/testing/selftests/riscv/mm/Makefile     |  21 +++
 .../selftests/riscv/mm/testcases/mmap.c       | 133 ++++++++++++++++++
 4 files changed, 156 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/riscv/mm/.gitignore
 create mode 100644 tools/testing/selftests/riscv/mm/Makefile
 create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap.c

diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
index 32a72902d045..0fee58f990ae 100644
--- a/tools/testing/selftests/riscv/Makefile
+++ b/tools/testing/selftests/riscv/Makefile
@@ -5,7 +5,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),riscv))
-RISCV_SUBTARGETS ?= hwprobe
+RISCV_SUBTARGETS ?= hwprobe mm
 else
 RISCV_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/riscv/mm/.gitignore b/tools/testing/selftests/riscv/mm/.gitignore
new file mode 100644
index 000000000000..9a6f303edcd3
--- /dev/null
+++ b/tools/testing/selftests/riscv/mm/.gitignore
@@ -0,0 +1 @@
+mmap
diff --git a/tools/testing/selftests/riscv/mm/Makefile b/tools/testing/selftests/riscv/mm/Makefile
new file mode 100644
index 000000000000..cf68e63e7495
--- /dev/null
+++ b/tools/testing/selftests/riscv/mm/Makefile
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+# Originally tools/testing/selftests/arm64/signal
+
+# Additional include paths needed by kselftest.h and local headers
+CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
+
+SRCS := $(filter-out testcases/testcases.c,$(wildcard testcases/*.c))
+PROGS := $(patsubst %.c,%,$(SRCS))
+
+# Generated binaries to be installed by top KSFT script
+TEST_GEN_PROGS := $(notdir $(PROGS))
+
+# Get Kernel headers installed and use them.
+
+# Including KSFT lib.mk here will also mangle the TEST_GEN_PROGS list
+# to account for any OUTPUT target-dirs optionally provided by
+# the toplevel makefile
+include ../../lib.mk
+
+$(TEST_GEN_PROGS): $(PROGS)
+	cp $(PROGS) $(OUTPUT)/
diff --git a/tools/testing/selftests/riscv/mm/testcases/mmap.c b/tools/testing/selftests/riscv/mm/testcases/mmap.c
new file mode 100644
index 000000000000..d8e751f7b8c9
--- /dev/null
+++ b/tools/testing/selftests/riscv/mm/testcases/mmap.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <sys/mman.h>
+#include <sys/resource.h>
+#include <sys/time.h>
+
+#include "../../kselftest_harness.h"
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
+	// Place all of the hint addresses on the boundaries of mmap
+	// sv39, sv48, sv57
+	// User addresses end at 1<<38, 1<<47, 1<<56 respectively
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
+TEST(default_rlimit)
+{
+// Only works on 64 bit
+#if __riscv_xlen == 64
+	struct addresses mmap_addresses;
+
+	do_mmaps(&mmap_addresses);
+
+	EXPECT_NE(mmap_addresses.no_hint, MAP_FAILED);
+	EXPECT_NE(mmap_addresses.on_37_addr, MAP_FAILED);
+	EXPECT_NE(mmap_addresses.on_38_addr, MAP_FAILED);
+	EXPECT_NE(mmap_addresses.on_46_addr, MAP_FAILED);
+	EXPECT_NE(mmap_addresses.on_47_addr, MAP_FAILED);
+	EXPECT_NE(mmap_addresses.on_55_addr, MAP_FAILED);
+	EXPECT_NE(mmap_addresses.on_56_addr, MAP_FAILED);
+
+	EXPECT_LT((unsigned long)mmap_addresses.no_hint, 1UL << 47);
+	EXPECT_LT((unsigned long)mmap_addresses.on_37_addr, 1UL << 38);
+	EXPECT_LT((unsigned long)mmap_addresses.on_38_addr, 1UL << 38);
+	EXPECT_LT((unsigned long)mmap_addresses.on_46_addr, 1UL << 38);
+	EXPECT_LT((unsigned long)mmap_addresses.on_47_addr, 1UL << 47);
+	EXPECT_LT((unsigned long)mmap_addresses.on_55_addr, 1UL << 47);
+	EXPECT_LT((unsigned long)mmap_addresses.on_56_addr, 1UL << 56);
+#endif
+}
+
+TEST(zero_rlimit)
+{
+// Only works on 64 bit
+#if __riscv_xlen == 64
+	struct addresses mmap_addresses;
+	struct rlimit rlim_new = { .rlim_cur = 0, .rlim_max = RLIM_INFINITY };
+
+	setrlimit(RLIMIT_STACK, &rlim_new);
+
+	do_mmaps(&mmap_addresses);
+
+	EXPECT_NE(mmap_addresses.no_hint, MAP_FAILED);
+	EXPECT_NE(mmap_addresses.on_37_addr, MAP_FAILED);
+	EXPECT_NE(mmap_addresses.on_38_addr, MAP_FAILED);
+	EXPECT_NE(mmap_addresses.on_46_addr, MAP_FAILED);
+	EXPECT_NE(mmap_addresses.on_47_addr, MAP_FAILED);
+	EXPECT_NE(mmap_addresses.on_55_addr, MAP_FAILED);
+	EXPECT_NE(mmap_addresses.on_56_addr, MAP_FAILED);
+
+	EXPECT_LT((unsigned long)mmap_addresses.no_hint, 1UL << 47);
+	EXPECT_LT((unsigned long)mmap_addresses.on_37_addr, 1UL << 38);
+	EXPECT_LT((unsigned long)mmap_addresses.on_38_addr, 1UL << 38);
+	EXPECT_LT((unsigned long)mmap_addresses.on_46_addr, 1UL << 38);
+	EXPECT_LT((unsigned long)mmap_addresses.on_47_addr, 1UL << 47);
+	EXPECT_LT((unsigned long)mmap_addresses.on_55_addr, 1UL << 47);
+	EXPECT_LT((unsigned long)mmap_addresses.on_56_addr, 1UL << 56);
+#endif
+}
+
+TEST(infinite_rlimit)
+{
+// Only works on 64 bit
+#if __riscv_xlen == 64
+	struct addresses mmap_addresses;
+	struct rlimit rlim_new = { .rlim_cur = RLIM_INFINITY,
+				   .rlim_max = RLIM_INFINITY };
+
+	setrlimit(RLIMIT_STACK, &rlim_new);
+
+	do_mmaps(&mmap_addresses);
+
+	EXPECT_NE(mmap_addresses.no_hint, MAP_FAILED);
+	EXPECT_NE(mmap_addresses.on_37_addr, MAP_FAILED);
+	EXPECT_NE(mmap_addresses.on_38_addr, MAP_FAILED);
+	EXPECT_NE(mmap_addresses.on_46_addr, MAP_FAILED);
+	EXPECT_NE(mmap_addresses.on_47_addr, MAP_FAILED);
+	EXPECT_NE(mmap_addresses.on_55_addr, MAP_FAILED);
+	EXPECT_NE(mmap_addresses.on_56_addr, MAP_FAILED);
+
+	EXPECT_LT((unsigned long)mmap_addresses.no_hint, 1UL << 47);
+	EXPECT_LT((unsigned long)mmap_addresses.on_37_addr, 1UL << 38);
+	EXPECT_LT((unsigned long)mmap_addresses.on_38_addr, 1UL << 38);
+	EXPECT_LT((unsigned long)mmap_addresses.on_46_addr, 1UL << 38);
+	EXPECT_LT((unsigned long)mmap_addresses.on_47_addr, 1UL << 47);
+	EXPECT_LT((unsigned long)mmap_addresses.on_55_addr, 1UL << 47);
+	EXPECT_LT((unsigned long)mmap_addresses.on_56_addr, 1UL << 56);
+#endif
+}
+
+TEST_HARNESS_MAIN
-- 
2.41.0

