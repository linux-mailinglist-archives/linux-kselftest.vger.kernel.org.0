Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7803D69E816
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Feb 2023 20:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjBUTJ7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Feb 2023 14:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjBUTJw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Feb 2023 14:09:52 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF67F30B06
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Feb 2023 11:09:41 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id c1so6414533plg.4
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Feb 2023 11:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Tqclwd4xuHoIstm7B9UCq8HRirfokgGB9GqloWqZiE=;
        b=Glob1piUQen2dFOUxlhvjRQj1tFTffF+lmacJDS8QehrlDVh4nBSsxUVpti29enOmc
         Ts3wco5RVkC/XsDz7hiLoMRoqNlJ2rz+fpVTLNlKx46nR+IUjT21SYM0Ta8uD1mbYVJm
         w7GE5FT6oG9+lb+XUNup35yMK+qbWTBvqvO9GWhSk0rnPafkitJM82jwEF3qiTZRreIZ
         cbO5Cq002Bt1cu2tKL1BJe973TcIvwMkBi/OdRgdFqY/S185mPI/l/1QANji5hwDdsxi
         48Y6Qv3FKj9BmZlRAjAFkMya5T7OSCx3dzUwzhKjoZbKxJcx/mKWejGjM2WIdYKbrso+
         YWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Tqclwd4xuHoIstm7B9UCq8HRirfokgGB9GqloWqZiE=;
        b=LMvn6Dyh3SpYduIerUNW8Nxfmwmt/YxxeTF2rDCpmWYJlHp9qNUlbcbLu9x86uQp4i
         Yemq8ejpxMpaTmCts6iC3ZcCxm0BSQs0Bcjdpr2pJEtkt6ELZdkl7Uysmv7Mz/JlziTr
         U4r5bjC9DKBOCSciPNNLtNUpVJTl626doAALkV2aot5xizfOHtJuZX/w+jsyNp4tNcHY
         uBxkaq6ty3pokGCkJhlzwiN8spoh0ay5n8Mx7WhzGoOGFStA4VH7kq/hRMOvCJjnRr7w
         w2Uc2OdmKWW/nFeY+VBHCx+RVf5zg1e/3UQwctfAEobzThFMsMLbnB5b+uuuI6OPsV9d
         RcNg==
X-Gm-Message-State: AO0yUKX+9gPopw3BQI/GfIYnHa3ERnLCGlBGLNcVEWBZDoDXX5gvxztq
        Ulx5zXtAq36lcED5Ww7H0sfL0g==
X-Google-Smtp-Source: AK7set8KKr96eBrj1R/guBqOwnlQKDGOKsi6FPJZIyeJcudjAKXfowybkO6ZGH2MC0wQPkyoqLAyrg==
X-Received: by 2002:a05:6a20:394f:b0:c0:df5b:e9e7 with SMTP id r15-20020a056a20394f00b000c0df5be9e7mr6407888pzg.60.1677006581159;
        Tue, 21 Feb 2023 11:09:41 -0800 (PST)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902b61000b0019602b2c00csm1583863pls.175.2023.02.21.11.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 11:09:40 -0800 (PST)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     heiko@sntech.de, Conor Dooley <conor@kernel.org>,
        slewis@rivosinc.com, vineetg@rivosinc.com,
        Evan Green <evan@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v3 6/7] selftests: Test the new RISC-V hwprobe interface
Date:   Tue, 21 Feb 2023 11:08:57 -0800
Message-Id: <20230221190858.3159617-7-evan@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230221190858.3159617-1-evan@rivosinc.com>
References: <20230221190858.3159617-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

(no changes since v2)

Changes in v2:
 - Updated the selftests to the new API and added some more.
 - Fixed indentation, comments in .S, and general checkpatch complaints.


---
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/riscv/Makefile        | 58 ++++++++++++
 .../testing/selftests/riscv/hwprobe/Makefile  | 10 +++
 .../testing/selftests/riscv/hwprobe/hwprobe.c | 89 +++++++++++++++++++
 .../selftests/riscv/hwprobe/sys_hwprobe.S     | 12 +++
 5 files changed, 170 insertions(+)
 create mode 100644 tools/testing/selftests/riscv/Makefile
 create mode 100644 tools/testing/selftests/riscv/hwprobe/Makefile
 create mode 100644 tools/testing/selftests/riscv/hwprobe/hwprobe.c
 create mode 100644 tools/testing/selftests/riscv/hwprobe/sys_hwprobe.S

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
index 000000000000..ebdbb3c22e54
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
+$(OUTPUT)/hwprobe: hwprobe.c sys_hwprobe.S
+	$(CC) -o$@ $(CFLAGS) $(LDFLAGS) $^
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
-- 
2.25.1

