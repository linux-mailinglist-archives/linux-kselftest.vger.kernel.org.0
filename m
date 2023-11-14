Return-Path: <linux-kselftest+bounces-113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114557EB74A
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 21:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351911C2082C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 20:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D65735EEB;
	Tue, 14 Nov 2023 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COcQPXbg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E264135EEA;
	Tue, 14 Nov 2023 20:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DABDC433CA;
	Tue, 14 Nov 2023 20:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699992407;
	bh=E/vO68ZFg6z/6OFrFC7xPTTrAHCnKC1HTh6WooalFG0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=COcQPXbgQRtRh6McXlLmwmXao6NZB3DoRessUOEzmGfXy4Q/yfYUiqe2WOLh/IYGF
	 FMBnikyOgbZ4guVGrh4thejR7lpM9/J7elIeMvqn0TvaqPkguJ+s3Aq37l4LuqxRFC
	 v4p5MmzIlI1cXY3d+ExzvWO6rv1/BAv2iZM/SxWfFH+irRYyhcVt5iA5XOIAtofqZs
	 ff55nzUXFCkjKqaW3ENaYA+/zyjpH1diIaH8FSe0+DzEzNzf12qZRNKc9wraAurRpB
	 QTq0/Y8N6T3asG2FNY6JVFVGgPdEAYk1sGStNyZsJR1xaOjloUaEo2iNq1d878F5q1
	 KPBFNtezCOfpA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 14 Nov 2023 20:05:58 +0000
Subject: [PATCH RFC RFT v2 5/5] kselftest/clone3: Test shadow stack support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-clone3-shadow-stack-v2-5-b613f8681155@kernel.org>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
In-Reply-To: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
To: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, 
 "H.J. Lu" <hjl.tools@gmail.com>, Florian Weimer <fweimer@redhat.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, 
 Daniel Bristot de Oliveira <bristot@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>, 
 jannh@google.com, bsegall@google.com, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4655; i=broonie@kernel.org;
 h=from:subject:message-id; bh=E/vO68ZFg6z/6OFrFC7xPTTrAHCnKC1HTh6WooalFG0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU9Mw/E0ZsNXT9pAEZkYqPqXgi0HGwFTiejBMba7Z
 6cP6PmaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVPTMAAKCRAk1otyXVSH0LQGB/
 4oDg/SgcY9WyortMyVY5pGTeVD+7/87/hOdY7hfIp+F1K7NuGnb1VAshA9GDrQrRrVDJR33MztYPws
 ERtdrqnCijOhMif91Jz0Mb6PPxhuPwdQM2wrWk3v7RpgcOyxMN0RaDlVwz4cfhfT8lM1btzDn+R8gP
 lv1fW6naRVaEBk1u+XByiBjDcNuC2gN6PnxA2uviZWaJEfRitQhRtzZLzcS7JF7G/LDzK9DX985Qcp
 XKNXyEOsQRryZb01iDaU7uZElG619LThNkspj0Ssw4LBsC1LbumQi+5yiwNW1+WR1Ms0PvU5OPq8JD
 Gq2E+E1TMJzFmDyydw6e59q55JmVey
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Add basic test coverage for specifying the shadow stack for a newly
created thread via clone3(), including coverage of the newly extended
argument structure. We detect support for shadow stacks on the running
system by attempting to allocate a shadow stack page during initialisation
using map_shadow_stack().

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3.c           | 68 +++++++++++++++++++++++
 tools/testing/selftests/clone3/clone3_selftests.h |  7 +++
 2 files changed, 75 insertions(+)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index 6adbfd14c841..10e0487c402a 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -11,6 +11,7 @@
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <sys/mman.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <sys/un.h>
@@ -21,6 +22,9 @@
 #include "../kselftest.h"
 #include "clone3_selftests.h"
 
+static bool shadow_stack_supported;
+static size_t max_supported_args_size;
+
 enum test_mode {
 	CLONE3_ARGS_NO_TEST,
 	CLONE3_ARGS_ALL_0,
@@ -28,6 +32,7 @@ enum test_mode {
 	CLONE3_ARGS_INVAL_EXIT_SIGNAL_NEG,
 	CLONE3_ARGS_INVAL_EXIT_SIGNAL_CSIG,
 	CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG,
+	CLONE3_ARGS_SHADOW_STACK,
 };
 
 typedef bool (*filter_function)(void);
@@ -44,6 +49,27 @@ struct test {
 	filter_function filter;
 };
 
+#ifndef __NR_map_shadow_stack
+#define __NR_map_shadow_stack 453
+#endif
+
+static void test_shadow_stack_supported(void)
+{
+        long shadow_stack;
+
+	shadow_stack = syscall(__NR_map_shadow_stack, 0, getpagesize(), 0);
+	if (shadow_stack == -1) {
+		ksft_print_msg("map_shadow_stack() not supported\n");
+	} else if ((void *)shadow_stack == MAP_FAILED) {
+		ksft_print_msg("Failed to map shadow stack\n");
+	} else {
+		ksft_print_msg("Shadow stack supportd\n");
+		shadow_stack_supported = true;
+
+		munmap((void *)shadow_stack, getpagesize());
+	}
+}
+
 static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
 {
 	struct __clone_args args = {
@@ -89,6 +115,9 @@ static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
 	case CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG:
 		args.exit_signal = 0x00000000000000f0ULL;
 		break;
+	case CLONE3_ARGS_SHADOW_STACK:
+		args.shadow_stack_size = getpagesize();
+		break;
 	}
 
 	memcpy(&args_ext.args, &args, sizeof(struct __clone_args));
@@ -179,6 +208,26 @@ static bool no_timenamespace(void)
 	return true;
 }
 
+static bool have_shadow_stack(void)
+{
+	if (shadow_stack_supported) {
+		ksft_print_msg("Shadow stack supported\n");
+		return true;
+	}
+
+	return false;
+}
+
+static bool no_shadow_stack(void)
+{
+	if (!shadow_stack_supported) {
+		ksft_print_msg("Shadow stack not supported\n");
+		return true;
+	}
+
+	return false;
+}
+
 static size_t page_size_plus_8(void)
 {
 	return getpagesize() + 8;
@@ -322,6 +371,24 @@ static const struct test tests[] = {
 		.expected = -EINVAL,
 		.test_mode = CLONE3_ARGS_NO_TEST,
 	},
+	{
+		.name = "Shadow stack on system with shadow stack",
+		.flags = 0,
+		.size = 0,
+		.expected = 0,
+		.e2big_valid = true,
+		.test_mode = CLONE3_ARGS_SHADOW_STACK,
+		.filter = no_shadow_stack,
+	},
+	{
+		.name = "Shadow stack on system without shadow stack",
+		.flags = 0,
+		.size = 0,
+		.expected = -EINVAL,
+		.e2big_valid = true,
+		.test_mode = CLONE3_ARGS_SHADOW_STACK,
+		.filter = have_shadow_stack,
+	},
 };
 
 int main(int argc, char *argv[])
@@ -332,6 +399,7 @@ int main(int argc, char *argv[])
 	ksft_print_header();
 	ksft_set_plan(ARRAY_SIZE(tests));
 	test_clone3_supported();
+	test_shadow_stack_supported();
 
 	for (i = 0; i < ARRAY_SIZE(tests); i++)
 		test_clone3(&tests[i]);
diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/testing/selftests/clone3/clone3_selftests.h
index 3d2663fe50ba..2e06127091f5 100644
--- a/tools/testing/selftests/clone3/clone3_selftests.h
+++ b/tools/testing/selftests/clone3/clone3_selftests.h
@@ -31,6 +31,13 @@ struct __clone_args {
 	__aligned_u64 set_tid;
 	__aligned_u64 set_tid_size;
 	__aligned_u64 cgroup;
+#ifndef CLONE_ARGS_SIZE_VER2
+#define CLONE_ARGS_SIZE_VER2 88	/* sizeof third published struct */
+#endif
+	__aligned_u64 shadow_stack_size;
+#ifndef CLONE_ARGS_SIZE_VER3
+#define CLONE_ARGS_SIZE_VER3 96 /* sizeof fourth published struct */
+#endif
 };
 
 static pid_t sys_clone3(struct __clone_args *args, size_t size)

-- 
2.30.2


