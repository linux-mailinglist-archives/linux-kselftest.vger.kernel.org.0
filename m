Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9526B9EA4
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 19:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjCNSfB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 14:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjCNSem (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 14:34:42 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF16B56150
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Mar 2023 11:34:09 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id ix20so11050345plb.3
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Mar 2023 11:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678818771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9pHjuYHTV1jwIa+yTaMhteDvvpQj1ERo7dHlvgskt4=;
        b=KiUg5097LeF/j7i5KvuYGtASQQhq3N8JtMhG38XK8+76BA/FxIZjIKIlXkdOFsuRnj
         Li1odfe9+ia+MHLeIJVd3J2xwZfzk2KxtMQx3Ul92KkdQmqNxmYS0fozuFA4rU3E+rGT
         kSg92KYLKSNAJRxXLADE7PtPq2vEMoNukbjJyTPAQaB8VhuLrBLxLiERelw2iBZ4FGbs
         OVvBngBK8n7BhcLMYHsbOsg8CLfHSdfOEvbM+Cb4KIckp8A4tw1r5doc+yKdSpMEx9vU
         +CcPivC49xx4wgAQvK8F5xq53vDHkXcVVfAKMXhVKs+SGAj3QP5KBLDAIrVbGJ3Tq/Q7
         gbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678818771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9pHjuYHTV1jwIa+yTaMhteDvvpQj1ERo7dHlvgskt4=;
        b=0VBBDyp7JInjQx8JSIW4Qi3w2k5iay/rdRe1EIAAmvX3T6FgsuD4NQu+9XlrO7D3wg
         ZHz89hY+TsuZDUajku+LdsIoA+D1wq/1oL/zZjL7JNkuN0z4xQMweIsVN4s4znvu3EJ7
         chkR46xqstgVXzmNaep3H2M9ssKH6xwW4nPpy4HiiRyiNxSGQMmkJdtyg8qYQGnKGjGW
         JgVwhG63iYT/uKFZ2cRzL7l+mVyNSMb7prPk44uX10YkXTJmnBSMb6Kz39P042ioBhew
         wtW9FpGLt8gx1tspQifA37Jug+z4Vdca5e0kOMfgaIPxAlC9/nfmld5NbIjNTglJ1dIX
         I2TQ==
X-Gm-Message-State: AO0yUKXnOp6sGkChY3QoKpi1Qf1liMvcjpcSt9SRZPJ85UVEaqRSe7Y/
        RkckN4HPneSAmfMBO3lce0VzIQ==
X-Google-Smtp-Source: AK7set/wQMmEaZj2KMkqT56JMMbAGHCfckB9OTdTe5KEZjFBskKFirBxhIFoD3oaI8Z10C6al/d4Qw==
X-Received: by 2002:a17:903:234a:b0:196:595b:2580 with SMTP id c10-20020a170903234a00b00196595b2580mr141744plh.0.1678818771704;
        Tue, 14 Mar 2023 11:32:51 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id kn3-20020a170903078300b0019d397b0f18sm2072019plb.214.2023.03.14.11.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:32:51 -0700 (PDT)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     slewis@rivosinc.com, heiko@sntech.de,
        Conor Dooley <conor@kernel.org>, vineetg@rivosinc.com,
        Evan Green <evan@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v4 5/6] selftests: Test the new RISC-V hwprobe interface
Date:   Tue, 14 Mar 2023 11:32:19 -0700
Message-Id: <20230314183220.513101-6-evan@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314183220.513101-1-evan@rivosinc.com>
References: <20230314183220.513101-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds a test for the recently added RISC-V interface for probing
hardware capabilities.  It happens to be the first selftest we have for
RISC-V, so I've added some infrastructure for those as well.

Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Evan Green <evan@rivosinc.com>

---

Changes in v4:
 - Fixed selftests commit description, no more tiny libc (Mark Brown)
 - Fixed selftest syscall prototype types to match v4.

Changes in v2:
 - Updated the selftests to the new API and added some more.
 - Fixed indentation, comments in .S, and general checkpatch complaints.


---
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/riscv/Makefile        | 58 ++++++++++++
 .../testing/selftests/riscv/hwprobe/Makefile  | 10 +++
 .../testing/selftests/riscv/hwprobe/hwprobe.c | 90 +++++++++++++++++++
 .../selftests/riscv/hwprobe/sys_hwprobe.S     | 12 +++
 5 files changed, 171 insertions(+)
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
index 000000000000..09f290a67420
--- /dev/null
+++ b/tools/testing/selftests/riscv/hwprobe/hwprobe.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stddef.h>
+#include <asm/hwprobe.h>
+
+/*
+ * Rather than relying on having a new enough libc to define this, just do it
+ * ourselves.  This way we don't need to be coupled to a new-enough libc to
+ * contain the call.
+ */
+long riscv_hwprobe(struct riscv_hwprobe *pairs, size_t pair_count,
+		   size_t cpu_count, unsigned long *cpus, unsigned int flags);
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

