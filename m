Return-Path: <linux-kselftest+bounces-15018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B91694B8DA
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 10:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF632B27FD7
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 08:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1868A18A6D2;
	Thu,  8 Aug 2024 08:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uslPJluZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E280C1898ED;
	Thu,  8 Aug 2024 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723105074; cv=none; b=l5K/7b7t7o8WwDwZcb1hH5ombw+XL4wkfCknCb07Cm1SzfwUXyzfN7IZ6fjCVchNgJwOZIeKPUXQ+Zo1E30zKL5Mc47yWdUwjV/v9qgwWkAFrm/Bd5DP1FDCpu4AEeh3fpjS6LcE8TXGBuEBrtncmud0lwWzrUf8hMN16x4Tc7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723105074; c=relaxed/simple;
	bh=ePficpvEcImrfJYxAgXbKEtc0fEAKvtwRYbBp5UBY5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RDpypQjZskx/mN/9m+RUAtJ4gY1pIAZ0fmfZmQefFxeVxaPnYCZjPAiq2qyad/jo8f9y2YHHD9ILfJmmhShdPpbXJdTpRdOhUcUuVqGlU2/Q5iNY1yQcLIK/tA+3UFgAL3vDZCvnf87JM16du6h9pWmDp+48KhYTYNIUns08Pls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uslPJluZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E02CC32782;
	Thu,  8 Aug 2024 08:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723105073;
	bh=ePficpvEcImrfJYxAgXbKEtc0fEAKvtwRYbBp5UBY5U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uslPJluZIk7AoZ+52rhqYv4bldYUW3R0nKjbrDQWd9DLnQxPyY+D21h3DycL6nfDq
	 Z8PrE82ZlKJ60OhXeoHSQCTqtAxlj1Qxl2vomnb50a9mZuELDjo7WqX8x064ISxdVB
	 Mo3IGDSMBqhyJeTTpU88MHBaBbHpax3ojat/36GCsZYu31ewK9oM2d9Ueo0HczsVNr
	 Wv3vrTppQpbHt2ISffVR5auspKuaNAUyrad8yGLeI4VHGmgJYXT0xFRQ3o9fDuNMIk
	 cKHuHmlfxKZA+9ICqQklcnwyCw77hO15UAfuvDUrSBH/PQq+J9aECIchpylH1VCa97
	 n+rh92ksfgajA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 08 Aug 2024 09:15:30 +0100
Subject: [PATCH RFT v8 9/9] selftests/clone3: Test shadow stack support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-clone3-shadow-stack-v8-9-0acf37caf14c@kernel.org>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
In-Reply-To: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
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
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, jannh@google.com, bsegall@google.com, 
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=9005; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ePficpvEcImrfJYxAgXbKEtc0fEAKvtwRYbBp5UBY5U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmtH7QOIgKQXc8zuHRze2x7rw75u/L6H5dHcUNY
 lXRNQsbv/2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZrR+0AAKCRAk1otyXVSH
 0CIKB/0VKXyXqakZmhYnnqalOHv07rQ74Uvhm4l74xcz+j+Yo75WQGDcfh455QWu3BJGkePXpIz
 V93iEBcr3GNXEKqsrboeLVcU6SDD3gscaVhd+Z321LF0w4o3WSmTeH8h9jdxb1uv8UXD9yTZq2D
 MD/7NudOi4lh0kErU9FCq7IsE2pGERLQuMkC24jrhW+uUAFRvmg0dVWDEMhiuVahFFeqkHknH1j
 XIoWwJ3+OCdZtb/Y4fYpy5mSvgAvjKP/kh9SV2nwZkuZ5a6C3lHB9g+3suB0FLrAjklRxf9/HKI
 eXpkw1kJgjrUurgaU1q5gEniorykgM+vDqWzP1GawgxrGs5Q
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Add basic test coverage for specifying the shadow stack for a newly
created thread via clone3(), including coverage of the newly extended
argument structure.  We check that a user specified shadow stack can be
provided, and that invalid combinations of parameters are rejected.

In order to facilitate testing on systems without userspace shadow stack
support we manually enable shadow stacks on startup, this is architecture
specific due to the use of an arch_prctl() on x86. Due to interactions with
potential userspace locking of features we actually detect support for
shadow stacks on the running system by attempting to allocate a shadow
stack page during initialisation using map_shadow_stack(), warning if this
succeeds when the enable failed.

In order to allow testing of user configured shadow stacks on
architectures with that feature we need to ensure that we do not return
from the function where the clone3() syscall is called in the child
process, doing so would trigger a shadow stack underflow.  To do this we
use inline assembly rather than the standard syscall wrapper to call
clone3().  In order to avoid surprises we also use a syscall rather than
the libc exit() function., this should be overly cautious.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3.c           | 134 +++++++++++++++++++++-
 tools/testing/selftests/clone3/clone3_selftests.h |  38 ++++++
 2 files changed, 171 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index 26221661e9ae..81c2e8648e8b 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -3,6 +3,7 @@
 /* Based on Christian Brauner's clone3() example */
 
 #define _GNU_SOURCE
+#include <asm/mman.h>
 #include <errno.h>
 #include <inttypes.h>
 #include <linux/types.h>
@@ -11,6 +12,7 @@
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <sys/mman.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <sys/un.h>
@@ -19,8 +21,12 @@
 #include <sched.h>
 
 #include "../kselftest.h"
+#include "../ksft_shstk.h"
 #include "clone3_selftests.h"
 
+static bool shadow_stack_supported;
+static size_t max_supported_args_size;
+
 enum test_mode {
 	CLONE3_ARGS_NO_TEST,
 	CLONE3_ARGS_ALL_0,
@@ -28,6 +34,10 @@ enum test_mode {
 	CLONE3_ARGS_INVAL_EXIT_SIGNAL_NEG,
 	CLONE3_ARGS_INVAL_EXIT_SIGNAL_CSIG,
 	CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG,
+	CLONE3_ARGS_SHADOW_STACK,
+	CLONE3_ARGS_SHADOW_STACK_NO_SIZE,
+	CLONE3_ARGS_SHADOW_STACK_NO_POINTER,
+	CLONE3_ARGS_SHADOW_STACK_NO_TOKEN,
 };
 
 typedef bool (*filter_function)(void);
@@ -44,6 +54,44 @@ struct test {
 	filter_function filter;
 };
 
+
+/*
+ * We check for shadow stack support by attempting to use
+ * map_shadow_stack() since features may have been locked by the
+ * dynamic linker resulting in spurious errors when we attempt to
+ * enable on startup.  We warn if the enable failed.
+ */
+static void test_shadow_stack_supported(void)
+{
+	long ret;
+
+	ret = syscall(__NR_map_shadow_stack, 0, getpagesize(), 0);
+	if (ret == -1) {
+		ksft_print_msg("map_shadow_stack() not supported\n");
+	} else if ((void *)ret == MAP_FAILED) {
+		ksft_print_msg("Failed to map shadow stack\n");
+	} else {
+		ksft_print_msg("Shadow stack supportd\n");
+		shadow_stack_supported = true;
+
+		if (!shadow_stack_enabled)
+			ksft_print_msg("Mapped but did not enable shadow stack\n");
+	}
+}
+
+static unsigned long long get_shadow_stack_page(unsigned long flags)
+{
+	unsigned long long page;
+
+	page = syscall(__NR_map_shadow_stack, 0, getpagesize(), flags);
+	if ((void *)page == MAP_FAILED) {
+		ksft_print_msg("map_shadow_stack() failed: %d\n", errno);
+		return 0;
+	}
+
+	return page;
+}
+
 static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
 {
 	struct __clone_args args = {
@@ -89,6 +137,21 @@ static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
 	case CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG:
 		args.exit_signal = 0x00000000000000f0ULL;
 		break;
+	case CLONE3_ARGS_SHADOW_STACK:
+		/* We need to specify a normal stack too to avoid corruption */
+		args.shadow_stack = get_shadow_stack_page(SHADOW_STACK_SET_TOKEN);
+		args.shadow_stack_size = getpagesize();
+		break;
+	case CLONE3_ARGS_SHADOW_STACK_NO_POINTER:
+		args.shadow_stack_size = getpagesize();
+		break;
+	case CLONE3_ARGS_SHADOW_STACK_NO_SIZE:
+		args.shadow_stack = get_shadow_stack_page(SHADOW_STACK_SET_TOKEN);
+		break;
+	case CLONE3_ARGS_SHADOW_STACK_NO_TOKEN:
+		args.shadow_stack = get_shadow_stack_page(0);
+		args.shadow_stack_size = getpagesize();
+		break;
 	}
 
 	memcpy(&args_ext.args, &args, sizeof(struct __clone_args));
@@ -102,7 +165,12 @@ static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
 
 	if (pid == 0) {
 		ksft_print_msg("I am the child, my PID is %d\n", getpid());
-		_exit(EXIT_SUCCESS);
+		/*
+		 * Use a raw syscall to ensure we don't get issues
+		 * with manually specified shadow stack and exit handlers.
+		 */
+		syscall(__NR_exit, EXIT_SUCCESS);
+		ksft_print_msg("CHILD FAILED TO EXIT PID is %d\n", getpid());
 	}
 
 	ksft_print_msg("I am the parent (%d). My child's pid is %d\n",
@@ -191,6 +259,26 @@ static bool no_timenamespace(void)
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
@@ -334,6 +422,47 @@ static const struct test tests[] = {
 		.expected = -EINVAL,
 		.test_mode = CLONE3_ARGS_NO_TEST,
 	},
+	{
+		.name = "Shadow stack on system with shadow stack",
+		.size = 0,
+		.expected = 0,
+		.e2big_valid = true,
+		.test_mode = CLONE3_ARGS_SHADOW_STACK,
+		.filter = no_shadow_stack,
+	},
+	{
+		.name = "Shadow stack with no pointer",
+		.size = 0,
+		.expected = -EINVAL,
+		.e2big_valid = true,
+		.test_mode = CLONE3_ARGS_SHADOW_STACK_NO_POINTER,
+	},
+	{
+		.name = "Shadow stack with no size",
+		.size = 0,
+		.expected = -EINVAL,
+		.e2big_valid = true,
+		.test_mode = CLONE3_ARGS_SHADOW_STACK_NO_SIZE,
+		.filter = no_shadow_stack,
+	},
+	{
+		.name = "Shadow stack with no token",
+		.flags = CLONE_VM,
+		.size = 0,
+		.expected = SIGSEGV,
+		.e2big_valid = true,
+		.test_mode = CLONE3_ARGS_SHADOW_STACK_NO_TOKEN,
+		.filter = no_shadow_stack,
+	},
+	{
+		.name = "Shadow stack on system without shadow stack",
+		.flags = CLONE_VM,
+		.size = 0,
+		.expected = -EINVAL,
+		.e2big_valid = true,
+		.test_mode = CLONE3_ARGS_SHADOW_STACK,
+		.filter = have_shadow_stack,
+	},
 };
 
 int main(int argc, char *argv[])
@@ -341,9 +470,12 @@ int main(int argc, char *argv[])
 	size_t size;
 	int i;
 
+	enable_shadow_stack();
+
 	ksft_print_header();
 	ksft_set_plan(ARRAY_SIZE(tests));
 	test_clone3_supported();
+	test_shadow_stack_supported();
 
 	for (i = 0; i < ARRAY_SIZE(tests); i++)
 		test_clone3(&tests[i]);
diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/testing/selftests/clone3/clone3_selftests.h
index 39b5dcba663c..38d82934668a 100644
--- a/tools/testing/selftests/clone3/clone3_selftests.h
+++ b/tools/testing/selftests/clone3/clone3_selftests.h
@@ -31,12 +31,50 @@ struct __clone_args {
 	__aligned_u64 set_tid;
 	__aligned_u64 set_tid_size;
 	__aligned_u64 cgroup;
+#ifndef CLONE_ARGS_SIZE_VER2
+#define CLONE_ARGS_SIZE_VER2 88	/* sizeof third published struct */
+#endif
+	__aligned_u64 shadow_stack;
+	__aligned_u64 shadow_stack_size;
+#ifndef CLONE_ARGS_SIZE_VER3
+#define CLONE_ARGS_SIZE_VER3 104 /* sizeof fourth published struct */
+#endif
 };
 
+/*
+ * For architectures with shadow stack support we need to be
+ * absolutely sure that the clone3() syscall will be inline and not a
+ * function call so we open code.
+ */
+#ifdef __x86_64__
+static pid_t __always_inline sys_clone3(struct __clone_args *args, size_t size)
+{
+	long ret;
+	register long _num  __asm__ ("rax") = __NR_clone3;
+	register long _args __asm__ ("rdi") = (long)(args);
+	register long _size __asm__ ("rsi") = (long)(size);
+
+	__asm__ volatile (
+		"syscall\n"
+		: "=a"(ret)
+		: "r"(_args), "r"(_size),
+		  "0"(_num)
+		: "rcx", "r11", "memory", "cc"
+	);
+
+	if (ret < 0) {
+		errno = -ret;
+		return -1;
+	}
+
+	return ret;
+}
+#else
 static pid_t sys_clone3(struct __clone_args *args, size_t size)
 {
 	return syscall(__NR_clone3, args, size);
 }
+#endif
 
 static inline void test_clone3_supported(void)
 {

-- 
2.39.2


