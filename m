Return-Path: <linux-kselftest+bounces-40555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C15B3FC77
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 12:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D8BC7B00A8
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 10:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312C52F83D0;
	Tue,  2 Sep 2025 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWYGeqxD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8037283FC4;
	Tue,  2 Sep 2025 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808590; cv=none; b=U+1tS3UcI+cHmmRSpy6cU0hId/4o5fYJpEbe3JwQt1z/uE2LhvAlYLOrGz6f7Rev7HI/JhesOgpCOhaMilOXQw6i7Y3cTecCzMqy0dv8RKuOFHhAvXl67zljJ67ytfYAKkK+WS3TVNpBBYMaN+zwyZJS0WzK3awzp7kozYgJfwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808590; c=relaxed/simple;
	bh=BpkR4AzIyL5Wv4KvQJJXzhwkykopqHSofdHP/8A50zc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cGrTi4PPBZagehagdjhFisEYwm4QVLlroGsIZCiccZO0znNwm1X8lKSA13BgASejVg8vy8YK3vxSJJ+QBbvRvNNQeD8zSluRCk6yRoOqLnMYspJ92FfE+fSDX5OWCVKJkEteItkF0Cncb4jBysTRxJdeyiN8aITi/gIAV8LJ45I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWYGeqxD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26325C4CEED;
	Tue,  2 Sep 2025 10:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756808589;
	bh=BpkR4AzIyL5Wv4KvQJJXzhwkykopqHSofdHP/8A50zc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qWYGeqxDI+I5qUvgPYWbt5pAjUp3vjYLoRrrdtuEIY1ZQpMzza9WarnR5MXT9NEsT
	 g3k7ahBIq7s/KpU3p8Gz2CW3w4KBVvww6PMg5Om8ts14Jbm2LRAu+kbbCKB1k1Bgfg
	 M18NfQadBxpWvoDK42mcafoNQfvZBv/3dJD0IJtz0L/VDW9IQ9tgRVuXwxfV0G74Lx
	 81+Fgc4LyUQa3UX4BMYx0agbBrMajwRLrv++pIw4gIKvOdy+OXr8pd5cL86vRRb9jb
	 DUwjUyToBC24APe3sZvCEyShUEuX7rpMl50myeQ86mhPo4UvOWhn8v2g4zxWo9t/Gy
	 BgyIfRgP5CthQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 02 Sep 2025 11:21:52 +0100
Subject: [PATCH v20 8/8] selftests/clone3: Test shadow stack support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-clone3-shadow-stack-v20-8-4d9fff1c53e7@kernel.org>
References: <20250902-clone3-shadow-stack-v20-0-4d9fff1c53e7@kernel.org>
In-Reply-To: <20250902-clone3-shadow-stack-v20-0-4d9fff1c53e7@kernel.org>
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
 Andrew Morton <akpm@linux-foundation.org>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Kees Cook <kees@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=10244; i=broonie@kernel.org;
 h=from:subject:message-id; bh=BpkR4AzIyL5Wv4KvQJJXzhwkykopqHSofdHP/8A50zc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBotsVYK55JOPJmLu3dzlgwhu7x9/187EYf0Mx8n
 i2ljcOM2taJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaLbFWAAKCRAk1otyXVSH
 0IQEB/4kvuBt/AdPuLZx90k69H205Hlldj/GiQmhryNY6S+hHeSjlJbXMvoRz5NqR0WtDRGhLJ0
 Wx4k0w8KRdOOOOPp0s6/ni0eIeRj+MC7B3IFcHJOckD0GIUgmpvk360yUF64Fa5yCDc7ICZvcP7
 gHTlZObgqCIxwvoudhB2T5Cv9w0urO+BdVX4QxSHe10KJWYDpOgcHzhcGlApzzac3+FM/1jS28k
 kMjg8fu2TE8MG5TtHtk9/dFo9OEB6nVndyMHMmRNzdwojSJykx4tre7yobY9oWQF99FMEDlnvVL
 2vjK1Tb5LeKqFId2ERqz0oGis5nuRP2kEVSqOYR5X6rA9InC
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
Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3.c           | 143 +++++++++++++++++++++-
 tools/testing/selftests/clone3/clone3_selftests.h |  63 ++++++++++
 2 files changed, 205 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index 5b8b7d640e70..6fd2b3238e2c 100644
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
+		args.shadow_stack_token = (unsigned long long)p;
+		break;
+	case CLONE3_ARGS_SHADOW_STACK_MISALIGNED:
+		p = get_shadow_stack_page(SHADOW_STACK_SET_TOKEN);
+		p += getpagesize() - sizeof(void *) - 1;
+		args.shadow_stack_token = (unsigned long long)p;
+		break;
+	case CLONE3_ARGS_SHADOW_STACK_NORMAL_MEMORY:
+		p = malloc(getpagesize());
+		p += getpagesize() - sizeof(void *);
+		args.shadow_stack_token = (unsigned long long)p;
+		break;
+	case CLONE3_ARGS_SHADOW_STACK_NO_TOKEN:
+		p = get_shadow_stack_page(0);
+		p += getpagesize() - sizeof(void *);
+		args.shadow_stack_token = (unsigned long long)p;
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
+		.expected = -EFAULT,
+		.e2big_valid = true,
+		.test_mode = CLONE3_ARGS_SHADOW_STACK_NORMAL_MEMORY,
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
index 939b26c86d42..8151c4fc971a 100644
--- a/tools/testing/selftests/clone3/clone3_selftests.h
+++ b/tools/testing/selftests/clone3/clone3_selftests.h
@@ -31,12 +31,75 @@ struct __clone_args {
 	__aligned_u64 set_tid;
 	__aligned_u64 set_tid_size;
 	__aligned_u64 cgroup;
+#ifndef CLONE_ARGS_SIZE_VER2
+#define CLONE_ARGS_SIZE_VER2 88	/* sizeof third published struct */
+#endif
+	__aligned_u64 shadow_stack_token;
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
+static __always_inline pid_t sys_clone3(struct __clone_args *args, size_t size)
+{
+	register long _num  __asm__ ("rax") = __NR_clone3;
+	register long _args __asm__ ("rdi") = (long)(args);
+	register long _size __asm__ ("rsi") = (long)(size);
+	long ret;
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
+static __always_inline pid_t sys_clone3(struct __clone_args *args, size_t size)
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
2.39.5


