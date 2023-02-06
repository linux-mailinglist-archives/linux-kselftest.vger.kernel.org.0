Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F5668C767
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 21:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjBFUQJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 15:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjBFUP5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 15:15:57 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B142B28E
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Feb 2023 12:15:42 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id t12-20020a17090aae0c00b00229f4cff534so13925021pjq.1
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Feb 2023 12:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QMxDhZ75IYuxFalbrxLxVMgMvXcbdvnhnkaLqUhc+4=;
        b=h/K1xPkYuAladagqvnqdEObwLc3I++hRM7ygnQ2FWJr4dQ+NkKfwjCYv4AZW0J/fwi
         LQISa+kgp1HPMijrVjeord7FE0i5YBU63rWz5ruKW+VR6fz0mKm4sPzzDQ3b7sHqAJqu
         5s5FHCgSboqFOPi6+2mRfBVjb6ruhIRiLlcmgbtSOBcG3ugdpGU4nLDiyh5rS6NQjWtG
         kQKYfhoKgsFC1y4IuUgzY6yhKDZrzXd+Cd50qfizClaXRGR75Ot0gyTLgmirP0lhYesJ
         0ufnay2uR7KlqVSrC2Gw4rTerieNxMHekKe2rLvJWZHLTB4m0NJU5BYtvJ2l9lgJ2Nsf
         6lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5QMxDhZ75IYuxFalbrxLxVMgMvXcbdvnhnkaLqUhc+4=;
        b=g/G39mxzP6ggcpaZiqB9eFAquei80VhH0GJCcanEmu5Sbt4+uSqrApbjCu/t8TBVuR
         kAQGttXUJHlOT8Ys0maA4JVQFeC4+PvrptWxkvk9Ir9biRqgqZBpBhUjlcbZ+LcF5esr
         iC2OGAcxJxzwTP54aKo1RIuMQVPRvImeBmJndSdcKa+O3Y8AiEko6mFAZG8P9OlDSbRv
         DTVVnKJ2r7NFArV5JttFdugNNJ6cp+P+7CG8vpsVEWZ1DGhmiUEiow89ZHrD0B5upKo8
         Z6GKy6bJWejTCihnAfkgk6Lk941227dnlGegz5v8G0fKRPE2TQtegano0VwpeO/oCoUu
         jGSg==
X-Gm-Message-State: AO0yUKV+PaZFKrB4umn7Md8wxHDGf7PtEMxF7x4DbRRzsDVFtJmrdhex
        liOUBbfnmMdRzUDmeiDjNcIlwA==
X-Google-Smtp-Source: AK7set85zbKwtw5aODIZ5cYO4p8jjvMu57n9mPKmID0sKGJht50D5yMZ8ibBp4s5msYzjPdKfqyc8A==
X-Received: by 2002:a05:6a20:e688:b0:bc:92cd:1536 with SMTP id mz8-20020a056a20e68800b000bc92cd1536mr259465pzb.61.1675714541445;
        Mon, 06 Feb 2023 12:15:41 -0800 (PST)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id k10-20020a63ab4a000000b004df4fbb9823sm6425079pgp.68.2023.02.06.12.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 12:15:41 -0800 (PST)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Conor Dooley <conor@kernel.org>, vineetg@rivosinc.com,
        heiko@sntech.de, slewis@rivosinc.com,
        Evan Green <evan@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v2 6/6] selftests: Test the new RISC-V hwprobe interface
Date:   Mon,  6 Feb 2023 12:14:55 -0800
Message-Id: <20230206201455.1790329-7-evan@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206201455.1790329-1-evan@rivosinc.com>
References: <20230206201455.1790329-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds a test for the recently added RISC-V interface for probing
hardware capabilities.  It happens to be the first selftest we have for
RISC-V, so I've added some infrastructure for those as well.  The build
stuff looks pretty straight-forward, but there's also  a tiny C library
to avoid coupling this to any userspace implementation.

Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Evan Green <evan@rivosinc.com>

---

Changes in v2:
 - Updated the selftests to the new API and added some more.
 - Fixed indentation, comments in .S, and general checkpatch complaints.


---
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/riscv/Makefile        | 58 ++++++++++++
 .../testing/selftests/riscv/hwprobe/Makefile  | 10 +++
 .../testing/selftests/riscv/hwprobe/hwprobe.c | 89 +++++++++++++++++++
 .../selftests/riscv/hwprobe/sys_hwprobe.S     | 12 +++
 tools/testing/selftests/riscv/libc.S          | 46 ++++++++++
 6 files changed, 216 insertions(+)
 create mode 100644 tools/testing/selftests/riscv/Makefile
 create mode 100644 tools/testing/selftests/riscv/hwprobe/Makefile
 create mode 100644 tools/testing/selftests/riscv/hwprobe/hwprobe.c
 create mode 100644 tools/testing/selftests/riscv/hwprobe/sys_hwprobe.S
 create mode 100644 tools/testing/selftests/riscv/libc.S

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 41b649452560..a599ef726310 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -62,6 +62,7 @@ TARGETS += pstore
 TARGETS += ptrace
 TARGETS += openat2
 TARGETS += resctrl
+TARGETS += riscv
 TARGETS += rlimits
 TARGETS += rseq
 TARGETS += rtc
diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
new file mode 100644
index 000000000000..32a72902d045
--- /dev/null
+++ b/tools/testing/selftests/riscv/Makefile
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0
+# Originally tools/testing/arm64/Makefile
+
+# When ARCH not overridden for crosscompiling, lookup machine
+ARCH ?= $(shell uname -m 2>/dev/null || echo not)
+
+ifneq (,$(filter $(ARCH),riscv))
+RISCV_SUBTARGETS ?= hwprobe
+else
+RISCV_SUBTARGETS :=
+endif
+
+CFLAGS := -Wall -O2 -g
+
+# A proper top_srcdir is needed by KSFT(lib.mk)
+top_srcdir = $(realpath ../../../../)
+
+# Additional include paths needed by kselftest.h and local headers
+CFLAGS += -I$(top_srcdir)/tools/testing/selftests/
+
+CFLAGS += $(KHDR_INCLUDES)
+
+export CFLAGS
+export top_srcdir
+
+all:
+	@for DIR in $(RISCV_SUBTARGETS); do				\
+		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
+		mkdir -p $$BUILD_TARGET;			\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
+	done
+
+install: all
+	@for DIR in $(RISCV_SUBTARGETS); do				\
+		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
+	done
+
+run_tests: all
+	@for DIR in $(RISCV_SUBTARGETS); do				\
+		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
+	done
+
+# Avoid any output on non riscv on emit_tests
+emit_tests: all
+	@for DIR in $(RISCV_SUBTARGETS); do				\
+		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
+	done
+
+clean:
+	@for DIR in $(RISCV_SUBTARGETS); do				\
+		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
+	done
+
+.PHONY: all clean install run_tests emit_tests
diff --git a/tools/testing/selftests/riscv/hwprobe/Makefile b/tools/testing/selftests/riscv/hwprobe/Makefile
new file mode 100644
index 000000000000..614501584803
--- /dev/null
+++ b/tools/testing/selftests/riscv/hwprobe/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 ARM Limited
+# Originally tools/testing/arm64/abi/Makefile
+
+TEST_GEN_PROGS := hwprobe
+
+include ../../lib.mk
+
+$(OUTPUT)/hwprobe: hwprobe.c ../libc.S sys_hwprobe.S
+	$(CC) -o$@ $(CFLAGS) $(LDFLAGS) -nostdlib $^
diff --git a/tools/testing/selftests/riscv/hwprobe/hwprobe.c b/tools/testing/selftests/riscv/hwprobe/hwprobe.c
new file mode 100644
index 000000000000..ddfb61de2938
--- /dev/null
+++ b/tools/testing/selftests/riscv/hwprobe/hwprobe.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <asm/hwprobe.h>
+
+/*
+ * Rather than relying on having a new enough libc to define this, just do it
+ * ourselves.  This way we don't need to be coupled to a new-enough libc to
+ * contain the call.
+ */
+long riscv_hwprobe(struct riscv_hwprobe *pairs, long pair_count,
+		   long cpu_count, unsigned long *cpus, unsigned long flags);
+
+int main(int argc, char **argv)
+{
+	struct riscv_hwprobe pairs[8];
+	unsigned long cpus;
+	long out;
+
+	/* Fake the CPU_SET ops. */
+	cpus = -1;
+
+	/*
+	 * Just run a basic test: pass enough pairs to get up to the base
+	 * behavior, and then check to make sure it's sane.
+	 */
+	for (long i = 0; i < 8; i++)
+		pairs[i].key = i;
+	out = riscv_hwprobe(pairs, 8, 1, &cpus, 0);
+	if (out != 0)
+		return -1;
+	for (long i = 0; i < 4; ++i) {
+		/* Fail if the kernel claims not to recognize a base key. */
+		if ((i < 4) && (pairs[i].key != i))
+			return -2;
+
+		if (pairs[i].key != RISCV_HWPROBE_KEY_BASE_BEHAVIOR)
+			continue;
+
+		if (pairs[i].value & RISCV_HWPROBE_BASE_BEHAVIOR_IMA)
+			continue;
+
+		return -3;
+	}
+
+	/*
+	 * This should also work with a NULL CPU set, but should not work
+	 * with an improperly supplied CPU set.
+	 */
+	out = riscv_hwprobe(pairs, 8, 0, 0, 0);
+	if (out != 0)
+		return -4;
+
+	out = riscv_hwprobe(pairs, 8, 0, &cpus, 0);
+	if (out == 0)
+		return -5;
+
+	out = riscv_hwprobe(pairs, 8, 1, 0, 0);
+	if (out == 0)
+		return -6;
+
+	/*
+	 * Check that keys work by providing one that we know exists, and
+	 * checking to make sure the resultig pair is what we asked for.
+	 */
+	pairs[0].key = RISCV_HWPROBE_KEY_BASE_BEHAVIOR;
+	out = riscv_hwprobe(pairs, 1, 1, &cpus, 0);
+	if (out != 0)
+		return -7;
+	if (pairs[0].key != RISCV_HWPROBE_KEY_BASE_BEHAVIOR)
+		return -8;
+
+	/*
+	 * Check that an unknown key gets overwritten with -1,
+	 * but doesn't block elements after it.
+	 */
+	pairs[0].key = 0x5555;
+	pairs[1].key = 1;
+	pairs[1].value = 0xAAAA;
+	out = riscv_hwprobe(pairs, 2, 0, 0, 0);
+	if (out != 0)
+		return -9;
+
+	if (pairs[0].key != -1)
+		return -10;
+
+	if ((pairs[1].key != 1) || (pairs[1].value == 0xAAAA))
+		return -11;
+
+	return 0;
+}
diff --git a/tools/testing/selftests/riscv/hwprobe/sys_hwprobe.S b/tools/testing/selftests/riscv/hwprobe/sys_hwprobe.S
new file mode 100644
index 000000000000..ed8d28863b27
--- /dev/null
+++ b/tools/testing/selftests/riscv/hwprobe/sys_hwprobe.S
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2022 Rivos, Inc */
+
+.text
+.global riscv_hwprobe
+riscv_hwprobe:
+	# Put __NR_riscv_hwprobe in the syscall number register, then just shim
+	# back the kernel's return.  This doesn't do any sort of errno
+	# handling, the caller can deal with it.
+	li a7, 258
+	ecall
+	ret
diff --git a/tools/testing/selftests/riscv/libc.S b/tools/testing/selftests/riscv/libc.S
new file mode 100644
index 000000000000..1041bbea9b6b
--- /dev/null
+++ b/tools/testing/selftests/riscv/libc.S
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2022 Rivos, Inc */
+/* A C library */
+
+#if __riscv_xlen == 64
+# define REG_S sd
+#else
+# define REG_S sw
+#endif
+
+.text
+.global _start
+_start:
+.option push
+.option norelax
+	la gp, __global_pointer$
+.option pop
+
+	la sp, stack
+
+	la t0, heap
+	la t1, brk
+	REG_S t0, 0(t1)
+
+	li a0, 0
+	li a1, 0
+
+	call main
+
+	li a7, 93
+	ecall
+
+1:
+	j 1b
+
+.data
+brk:
+	.long 0
+
+.global heap
+heap:
+.rep 65536
+.byte 0
+.endr
+.global stack
+stack:
-- 
2.25.1

