Return-Path: <linux-kselftest+bounces-19099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AD699161C
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 12:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971451C21E47
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 10:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECD814D6EB;
	Sat,  5 Oct 2024 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fd3o9dVg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225DD149C7A;
	Sat,  5 Oct 2024 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728124414; cv=none; b=XxRo7u0AspQedOXbIcw5EQz5OavpE77PwxLyY51Zz2PvusrOAr5AEdoZD/T8agi8pXYWDj1pLhu2MND48sme41GGojyC5MexHR0ZniJ0WbAaQe0LX9vkXZIE0DGOayUigujk6qF8fD4/Id0McA3vXOWIxmqjoXXZQsO2Vrp1tVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728124414; c=relaxed/simple;
	bh=Asc7C0Q7KkIXRwzVZKZVujDysoWfmsSfVozRj/Ti9m8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FpTtPMjiE96eqvciY5dQ8CDcqwuM/20Eee/PEIctazr9b0INtJDpVENTAtCCuNuaBT1/FxINTcjDgLbmmF8ZdL6PyOpJpkwez/MphwSxGqZ05Nt/EwpZ7H2uUJ3sB13XR+JWRJhZGr+iWAQCzQPcEAgPYMWP9q9uNqWr7CynepE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fd3o9dVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6689C4CECF;
	Sat,  5 Oct 2024 10:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728124413;
	bh=Asc7C0Q7KkIXRwzVZKZVujDysoWfmsSfVozRj/Ti9m8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Fd3o9dVgffJ/jxguRI+vFsd8dGojs8L26/wliymcQzHDESfykIRlsypO0UzF8ra+2
	 Rwk1eb5os7fGELkeVh3GcleTN6Y9c6TfCgLtGlyt8fqJlQD01AU5UYpPE3e4KTQ5P0
	 4JbjCjfVwpLr4EIH+hvmXcr712sXGQPAHGYM32vT6/14ZRbbrgzeV35WcEKOCp3Uly
	 7fwURFsjBBhKCWjTQR06ISBsNHrgq+TkcV/q5u/Qo6cjTleS3pZiP/LxYliMUupfvR
	 pkbIDI7sRHqk7y3UYvrWUSHF8Q/6xCwp78KKYq3Dq/+SrR5t6i7ZyI1EZy9t9z+w2F
	 VBdB378RZuaEw==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 05 Oct 2024 11:31:35 +0100
Subject: [PATCH RFT v11 8/8] selftests/clone3: Test shadow stack support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241005-clone3-shadow-stack-v11-8-2a6a2bd6d651@kernel.org>
References: <20241005-clone3-shadow-stack-v11-0-2a6a2bd6d651@kernel.org>
In-Reply-To: <20241005-clone3-shadow-stack-v11-0-2a6a2bd6d651@kernel.org>
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
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Kees Cook <kees@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=10296; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Asc7C0Q7KkIXRwzVZKZVujDysoWfmsSfVozRj/Ti9m8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnARXAHVFTZz2fpP/IlFfIdUYojAWZBCX/qD5OSpDf
 5/GfQ3CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZwEVwAAKCRAk1otyXVSH0IiIB/
 4qGOPUGIu5Ardm43irbJgaOKxTzSeACiDbk89SUpmcpRp5WL7LMjMmEFNAjdiOGJ9jSgJHvDSSyPqQ
 S7ulVyQ0YXlGYzTaaHnOZgN426RyZ7O7bJhjyjJXMJPDeWi+rP683K+tOhNACoIEnOjNWcW+HOjTD9
 GEZ8OJOKXIHcY/B0GgrtF1vQ255HBcUMD5R2dFqul04PvcKnk8rXHXQalnaeP3pLQaVWv1dY1iWcEn
 Y3TbwrAkxEjFAuyNwtuSaQkBMmrIEdVwK333Zo8rZu+bVyKC7saBgvXIcx8RaXw9smkslFAxf+Csef
 NTZ4lsoiIKE7XE5ClYBY5hiqFbPgPI
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

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3.c           | 143 +++++++++++++++++++++-
 tools/testing/selftests/clone3/clone3_selftests.h |  63 ++++++++++
 2 files changed, 205 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index 5b8b7d640e70132242fc6939450669acd0c534f9..b0378d7418cc8b00caebc6f92f58280bc04b0f80 100644
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
+	CLONE3_ARGS_SHADOW_STACK_MISALIGNED,
+	CLONE3_ARGS_SHADOW_STACK_NO_TOKEN,
+	CLONE3_ARGS_SHADOW_STACK_NORMAL_MEMORY,
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
+static void *get_shadow_stack_page(unsigned long flags)
+{
+	unsigned long long page;
+
+	page = syscall(__NR_map_shadow_stack, 0, getpagesize(), flags);
+	if ((void *)page == MAP_FAILED) {
+		ksft_print_msg("map_shadow_stack() failed: %d\n", errno);
+		return 0;
+	}
+
+	return (void *)page;
+}
+
 static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
 {
 	struct __clone_args args = {
@@ -57,6 +105,7 @@ static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
 	} args_ext;
 
 	pid_t pid = -1;
+	void *p;
 	int status;
 
 	memset(&args_ext, 0, sizeof(args_ext));
@@ -89,6 +138,26 @@ static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
 	case CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG:
 		args.exit_signal = 0x00000000000000f0ULL;
 		break;
+	case CLONE3_ARGS_SHADOW_STACK:
+		p = get_shadow_stack_page(SHADOW_STACK_SET_TOKEN);
+		p += getpagesize() - sizeof(void *);
+		args.shadow_stack_pointer = (unsigned long long)p;
+		break;
+	case CLONE3_ARGS_SHADOW_STACK_MISALIGNED:
+		p = get_shadow_stack_page(SHADOW_STACK_SET_TOKEN);
+		p += getpagesize() - sizeof(void *) - 1;
+		args.shadow_stack_pointer = (unsigned long long)p;
+		break;
+	case CLONE3_ARGS_SHADOW_STACK_NORMAL_MEMORY:
+		p = malloc(getpagesize());
+		p += getpagesize() - sizeof(void *);
+		args.shadow_stack_pointer = (unsigned long long)p;
+		break;
+	case CLONE3_ARGS_SHADOW_STACK_NO_TOKEN:
+		p = get_shadow_stack_page(0);
+		p += getpagesize() - sizeof(void *);
+		args.shadow_stack_pointer = (unsigned long long)p;
+		break;
 	}
 
 	memcpy(&args_ext.args, &args, sizeof(struct __clone_args));
@@ -102,7 +171,12 @@ static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
 
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
@@ -184,6 +258,26 @@ static bool no_timenamespace(void)
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
@@ -327,6 +421,50 @@ static const struct test tests[] = {
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
+		.name = "Shadow stack with misaligned address",
+		.flags = CLONE_VM,
+		.size = 0,
+		.expected = -EINVAL,
+		.e2big_valid = true,
+		.test_mode = CLONE3_ARGS_SHADOW_STACK_MISALIGNED,
+		.filter = no_shadow_stack,
+	},
+	{
+		.name = "Shadow stack with normal memory",
+		.flags = CLONE_VM,
+		.size = 0,
+		.expected = -EFAULT,
+		.e2big_valid = true,
+		.test_mode = CLONE3_ARGS_SHADOW_STACK_NORMAL_MEMORY,
+		.filter = no_shadow_stack,
+	},
+	{
+		.name = "Shadow stack with no token",
+		.flags = CLONE_VM,
+		.size = 0,
+		.expected = -EINVAL,
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
@@ -334,9 +472,12 @@ int main(int argc, char *argv[])
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
index 39b5dcba663c30b9fc2542d9a0d2686105ce5761..26ff1554408a59af26bd708dc9c852210e370828 100644
--- a/tools/testing/selftests/clone3/clone3_selftests.h
+++ b/tools/testing/selftests/clone3/clone3_selftests.h
@@ -31,12 +31,75 @@ struct __clone_args {
 	__aligned_u64 set_tid;
 	__aligned_u64 set_tid_size;
 	__aligned_u64 cgroup;
+#ifndef CLONE_ARGS_SIZE_VER2
+#define CLONE_ARGS_SIZE_VER2 88	/* sizeof third published struct */
+#endif
+	__aligned_u64 shadow_stack_pointer;
+#ifndef CLONE_ARGS_SIZE_VER3
+#define CLONE_ARGS_SIZE_VER3 96 /* sizeof fourth published struct */
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
+#elif defined(__aarch64__)
+static pid_t __always_inline sys_clone3(struct __clone_args *args, size_t size)
+{
+	register long _num  __asm__ ("x8") = __NR_clone3;
+	register long _args __asm__ ("x0") = (long)(args);
+	register long _size __asm__ ("x1") = (long)(size);
+	register long arg2 __asm__ ("x2") = 0;
+	register long arg3 __asm__ ("x3") = 0;
+	register long arg4 __asm__ ("x4") = 0;
+
+	__asm__ volatile (
+		"svc #0\n"
+		: "=r"(_args)
+		: "r"(_args), "r"(_size),
+		  "r"(_num), "r"(arg2),
+		  "r"(arg3), "r"(arg4)
+		: "memory", "cc"
+	);
+
+	if ((int)_args < 0) {
+		errno = -((int)_args);
+		return -1;
+	}
+
+	return _args;
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


