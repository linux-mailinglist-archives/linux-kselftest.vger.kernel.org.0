Return-Path: <linux-kselftest+bounces-4064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E70B847D85
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 01:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 250E6287591
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 00:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13742582;
	Sat,  3 Feb 2024 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6hjWje2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D27883D;
	Sat,  3 Feb 2024 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706918768; cv=none; b=PMIvLJzbblLuZSUqpGyVwyMbp3KYszsnHzpYZc0z8mXZNKgjfRPWOCml4KzofgGPkmGeOX6Mahgb9bKfyZ7N0G+rkqyZXmJYj7cKYodSq6Wxd76qkrwz5/LoiPXUejiOYl40y+0YSo8pgjzOqXXOOy+La69Qhi4hesQSS4fj+j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706918768; c=relaxed/simple;
	bh=tLwTbiFrM4HHqU9nz4FbJLnTenWOwfYkzVrlMYdP4yc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gFv9Zq+aWvvpZCYbl3/nNCHUZ/AqU6ABN4Nbz2QaO9XmACiS9QFy7CobBPtLfKFoOerngEZLsQQF4qPmJ1oxPdV7ragLWL8se1D/Qe3GK9NHceJ0kqeTS+gcxln6B61OBg4po5MdefrQDkj9I3lh7ErbdLcwVqe0X55w+4H0S3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6hjWje2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B596DC43390;
	Sat,  3 Feb 2024 00:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706918768;
	bh=tLwTbiFrM4HHqU9nz4FbJLnTenWOwfYkzVrlMYdP4yc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h6hjWje2Jzr3dORUU62oOWti7/PsRPfDsI5xxwBJnfa/gvaY0Cd9ejPfSZ16qM05z
	 4q5kU4pfQdim/3iY1O2NVxBwmkh8dvR2FZ8FbRuB3VwU4iFDvJ3j8ryoOoa+lY/uS+
	 8E53dhY7bS1T8bcwA/Vn9E34TGaJMlmN5sQv2GnY2bcM9NoP/jubW917TKm1XhyEz4
	 8NffObNR2RRY/l3+QFzWpzwwzkXDFQaG3aAhevbFzYwm1VV3gdoOFM29+tDOMsSyXR
	 ecilIxpR6yTLEP+NjzepPJxXoJwjz1oucmjjyq7hp5RDW/47wvP2fAlUN2zaAg2xXI
	 CEbkDxTGP3jmw==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 00:05:03 +0000
Subject: [PATCH RFT v5 7/7] selftests/clone3: Test shadow stack support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-clone3-shadow-stack-v5-7-322c69598e4b@kernel.org>
References: <20240203-clone3-shadow-stack-v5-0-322c69598e4b@kernel.org>
In-Reply-To: <20240203-clone3-shadow-stack-v5-0-322c69598e4b@kernel.org>
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
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=7047; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tLwTbiFrM4HHqU9nz4FbJLnTenWOwfYkzVrlMYdP4yc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvYM9GU3402XETN5uhtlMqpBMbL/h7l8ItCThuT/D
 ssUeLFaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb2DPQAKCRAk1otyXVSH0L57B/
 47zDNvJKiHQAEn8Z/Z/aea4Zqk1sJzbkNpOUpfdDV+NejHcDlJSIo5yOuqKpCF0kBfi51t/wZUQoty
 2G1w1bAPR6vHljsyHmSFvL1YlpGgQXDL+IXKISeaA5snKrt6P/4b80iLmvv7n8RZYAHnfU7kMPzWUe
 XyV2i6GF8g8EXV/xaucNSyeBQyCZRW9v5lcyg4/IyJ26+SPACcdJ8gZG0exYhhYyVaY2p9B0WrFCQG
 qRluJAiAP72RE6UhbHW/30Q7TD3VE/9mIPOBPInxM7I/diNQVTTC/q2Vnh50wp4HP1pI6gdnpYxhut
 gO1ZIknxByjcp0Wf5TPf8n6Ke7dXcS
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Add basic test coverage for specifying the shadow stack for a newly
created thread via clone3(), including coverage of the newly extended
argument structure.

In order to facilitate testing on systems without userspace shadow stack
support we manually enable shadow stacks on startup, this is architecture
specific due to the use of an arch_prctl() on x86. Due to interactions with
potential userspace locking of features we actually detect support for
shadow stacks on the running system by attempting to allocate a shadow
stack page during initialisation using map_shadow_stack(), warning if this
succeeds when the enable failed.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3.c           | 128 ++++++++++++++++++++++
 tools/testing/selftests/clone3/clone3_selftests.h |   8 ++
 2 files changed, 136 insertions(+)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index 6adbfd14c841..c468d9b87bd5 100644
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
@@ -44,6 +54,43 @@ struct test {
 	filter_function filter;
 };
 
+/*
+ * We check for shadow stack support by attempting to use
+ * map_shadow_stack() since features may have been locked by the
+ * dynamic linker resulting in spurious errors when we attempt to
+ * enable on startup.  We warn if the enable failed.
+ */
+static void test_shadow_stack_supported(void)
+{
+        long ret;
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
@@ -89,6 +136,20 @@ static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
 	case CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG:
 		args.exit_signal = 0x00000000000000f0ULL;
 		break;
+	case CLONE3_ARGS_SHADOW_STACK:
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
@@ -179,6 +240,26 @@ static bool no_timenamespace(void)
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
@@ -322,6 +403,50 @@ static const struct test tests[] = {
 		.expected = -EINVAL,
 		.test_mode = CLONE3_ARGS_NO_TEST,
 	},
+	{
+		.name = "Shadow stack on system with shadow stack",
+		.flags = CLONE_VM,
+		.size = 0,
+		.expected = 0,
+		.e2big_valid = true,
+		.test_mode = CLONE3_ARGS_SHADOW_STACK,
+		.filter = no_shadow_stack,
+	},
+	{
+		.name = "Shadow stack with no pointer",
+		.flags = CLONE_VM,
+		.size = 0,
+		.expected = -EINVAL,
+		.e2big_valid = true,
+		.test_mode = CLONE3_ARGS_SHADOW_STACK_NO_POINTER,
+	},
+	{
+		.name = "Shadow stack with no size",
+		.flags = CLONE_VM,
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
@@ -329,9 +454,12 @@ int main(int argc, char *argv[])
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
index 3d2663fe50ba..1011dae85098 100644
--- a/tools/testing/selftests/clone3/clone3_selftests.h
+++ b/tools/testing/selftests/clone3/clone3_selftests.h
@@ -31,6 +31,14 @@ struct __clone_args {
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
 
 static pid_t sys_clone3(struct __clone_args *args, size_t size)

-- 
2.30.2


