Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6F61BDA9A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Apr 2020 13:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgD2L3H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Apr 2020 07:29:07 -0400
Received: from foss.arm.com ([217.140.110.172]:37524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgD2L3E (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Apr 2020 07:29:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B947012FC;
        Wed, 29 Apr 2020 04:29:03 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D509C3F73D;
        Wed, 29 Apr 2020 04:29:02 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 4/4] kselftest: Move test_vdso to the vDSO test suite
Date:   Wed, 29 Apr 2020 12:28:34 +0100
Message-Id: <20200429112834.24908-5-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200429112834.24908-1-vincenzo.frascino@arm.com>
References: <20200429112834.24908-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Move test_vdso from x86 to the vDSO test suite.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 tools/testing/selftests/vDSO/Makefile                  | 10 ++++++++--
 .../test_vdso.c => vDSO/vdso_correctness_test_x86.c}   |  0
 tools/testing/selftests/x86/Makefile                   |  2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)
 rename tools/testing/selftests/{x86/test_vdso.c => vDSO/vdso_correctness_test_x86.c} (100%)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 7b096eedfd5d..cdffb51cb413 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -7,12 +7,14 @@ ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 TEST_GEN_PROGS := $(OUTPUT)/vdso_test
 TEST_GEN_PROGS += $(OUTPUT)/vdso_full_test
 TEST_GEN_PROGS += $(OUTPUT)/vdso_clock_getres
-ifeq ($(ARCH),x86)
+ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
 TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
+TEST_GEN_PROGS += $(OUTPUT)/vdso_correctness_test_x86
 endif
 
 CFLAGS := -std=gnu99
 CFLAGS_vdso_standalone_test_x86 := -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
+LDFLAGS_vdso_correctness_test_x86 := -ldl
 ifeq ($(CONFIG_X86_32),y)
 LDLIBS += -lgcc_s
 endif
@@ -25,4 +27,8 @@ $(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
 	$(CC) $(CFLAGS) $(CFLAGS_vdso_standalone_test_x86) \
 		vdso_standalone_test_x86.c parse_vdso.c \
 		-o $@
-
+$(OUTPUT)/vdso_correctness_test_x86: vdso_correctness_test_x86.c
+	$(CC) $(CFLAGS) \
+		vdso_correctness_test_x86.c \
+		-o $@ \
+		$(LDFLAGS_vdso_correctness_test_x86)
diff --git a/tools/testing/selftests/x86/test_vdso.c b/tools/testing/selftests/vDSO/vdso_correctness_test_x86.c
similarity index 100%
rename from tools/testing/selftests/x86/test_vdso.c
rename to tools/testing/selftests/vDSO/vdso_correctness_test_x86.c
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 5d49bfec1e9a..d20586a4cfd2 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -12,7 +12,7 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
 
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
-			protection_keys test_vdso test_vsyscall mov_ss_trap \
+			protection_keys test_vsyscall mov_ss_trap \
 			syscall_arg_fault
 TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
-- 
2.25.2

