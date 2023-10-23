Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A36D7D381A
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Oct 2023 15:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbjJWNdJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 09:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjJWNdE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 09:33:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD092D6B;
        Mon, 23 Oct 2023 06:23:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D217C433C9;
        Mon, 23 Oct 2023 13:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698067439;
        bh=puDfEO1kotD4qFSC3EfqcfkBLrETnjNBFvX+npWIo7Q=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=vBUUwq+llRi1d+VXUlq4rIne0cNQFC9mBVdsJRmxA6hw1zuo4pa8pz5tFLgRvfIMa
         AApvDuCZMsviwORUf7q917sqJVGET4k73uK0lHCCy4o8D9qx5GwLpZZwBKkky7XwCK
         Uku+f6rp+Ukxor9ASvVVOoHHHI2+EFa5ecUAhjDh1hRkjr86MuN2DcRdCQmj011eG+
         JueoVwWNcgb5Xq8A51ihzweh8u0tsXmPGoEwH4zgrg82Y1XtJbs8v7gMSvUtBjsXhq
         2FBqqm+CfGqRehD9XcYS+C6ls2HtQMWMh0+hfzgiAJ2lW8Z9ebWN4bmdYxhbbKGfxZ
         oXc1+uktT9USg==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 23 Oct 2023 14:20:44 +0100
Subject: [PATCH RFC RFT 5/5] kselftest/clone3: Test shadow stack support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-clone3-shadow-stack-v1-5-d867d0b5d4d0@kernel.org>
References: <20231023-clone3-shadow-stack-v1-0-d867d0b5d4d0@kernel.org>
In-Reply-To: <20231023-clone3-shadow-stack-v1-0-d867d0b5d4d0@kernel.org>
To:     "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=5429; i=broonie@kernel.org;
 h=from:subject:message-id; bh=puDfEO1kotD4qFSC3EfqcfkBLrETnjNBFvX+npWIo7Q=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlNnPGxljfEiyeibQJM6yYflz/X64pYKiaOUmyiJKa
 TnfCRYOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZTZzxgAKCRAk1otyXVSH0KSEB/
 403D86ruPvelfqkNIt6c/l8os/uTJdhOhCAE7zQCqlEgXrWHHmDNSbag3fzY2TseKC4cjC0u4KjcBS
 FEpJ2Jq9+VlO2yBeJKmMOPvHorf9snbL+rrfzNBNRXYW4QyEBlUtp+iA/eE+6tiZD8ukp6p3oAQ1Se
 cy6dJmjs7rBkA/9tu1oI7ORqSu+sRXjn6xTY2H/AYrOc2F9GDiEClE1CRMglM1CxEDzqb7zE+e4nk+
 jH2flJfgkHQK9eVFgko1GPZblC1zaVqhep54grPsBSoWq5LajKx77sfLZ2CIhyEQlUt0lQzgu1yciW
 weMEQgloUcc9nBdW3xmbj/nMiwdjKe
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add basic test coverage for specifying the shadow stack for a newly
created thread via clone3(), including coverage of the newly extended
argument structure. We detect support for shadow stacks on the running
system by attempting to allocate a shadow stack page during initialisation
using map_shadow_stack().

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3.c           | 97 +++++++++++++++++++++++
 tools/testing/selftests/clone3/clone3_selftests.h |  5 ++
 2 files changed, 102 insertions(+)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index f1802db82e4e..33c35fdfcdfc 100644
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
@@ -21,6 +22,10 @@
 #include "../kselftest.h"
 #include "clone3_selftests.h"
 
+static bool shadow_stack_supported;
+static __u64 shadow_stack;
+static size_t max_supported_args_size;
+
 enum test_mode {
 	CLONE3_ARGS_NO_TEST,
 	CLONE3_ARGS_ALL_0,
@@ -28,6 +33,9 @@ enum test_mode {
 	CLONE3_ARGS_INVAL_EXIT_SIGNAL_NEG,
 	CLONE3_ARGS_INVAL_EXIT_SIGNAL_CSIG,
 	CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG,
+	CLONE3_ARGS_SHADOW_STACK,
+	CLONE3_ARGS_SHADOW_STACK_SIZE_ONLY,
+	CLONE3_ARGS_SHADOW_STACK_POINTER_ONLY,
 };
 
 typedef bool (*filter_function)(void);
@@ -44,6 +52,28 @@ struct test {
 	filter_function filter;
 };
 
+#ifndef __NR_map_shadow_stack
+#define __NR_map_shadow_stack 453
+#endif
+
+static void test_shadow_stack_supported(void)
+{
+	shadow_stack = syscall(__NR_map_shadow_stack, 0, getpagesize(), 0);
+	if (shadow_stack == -1) {
+		ksft_print_msg("map_shadow_stack() not supported\n");
+	} else if ((void *)shadow_stack == MAP_FAILED) {
+		ksft_print_msg("Failed to map shadow stack\n");
+	} else {
+		ksft_print_msg("Shadow stack supportd\n");
+		shadow_stack_supported = true;
+	}
+
+	/* Dummy stack to use for validating error checks */
+	if (!shadow_stack_supported) {
+		shadow_stack = (__u64)malloc(getpagesize());
+	}
+}
+
 static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
 {
 	struct __clone_args args = {
@@ -89,6 +119,16 @@ static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
 	case CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG:
 		args.exit_signal = 0x00000000000000f0ULL;
 		break;
+	case CLONE3_ARGS_SHADOW_STACK:
+		args.shadow_stack = shadow_stack;
+		args.shadow_stack_size = getpagesize();
+		break;
+	case CLONE3_ARGS_SHADOW_STACK_SIZE_ONLY:
+		args.shadow_stack_size = getpagesize();
+		break;
+	case CLONE3_ARGS_SHADOW_STACK_POINTER_ONLY:
+		args.shadow_stack = shadow_stack;
+		break;
 	}
 
 	memcpy(&args_ext.args, &args, sizeof(struct __clone_args));
@@ -167,6 +207,26 @@ static bool not_root(void)
 	return false;
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
@@ -309,6 +369,42 @@ static const struct test tests[] = {
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
+		.name = "Shadow stack with only size specified",
+		.flags = 0,
+		.size = 0,
+		.expected = -EINVAL,
+		.e2big_valid = true,
+		.test_mode = CLONE3_ARGS_SHADOW_STACK_SIZE_ONLY,
+		.filter = no_shadow_stack,
+	},
+	{
+		.name = "Shadow stack with only pointer specified",
+		.flags = 0,
+		.size = 0,
+		.expected = -EINVAL,
+		.e2big_valid = true,
+		.test_mode = CLONE3_ARGS_SHADOW_STACK_POINTER_ONLY,
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
@@ -319,6 +415,7 @@ int main(int argc, char *argv[])
 	ksft_print_header();
 	ksft_set_plan(ARRAY_SIZE(tests));
 	test_clone3_supported();
+	test_shadow_stack_supported();
 
 	for (i = 0; i < ARRAY_SIZE(tests); i++)
 		test_clone3(&tests[i]);
diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/testing/selftests/clone3/clone3_selftests.h
index e81ffaaee02b..a77db460211b 100644
--- a/tools/testing/selftests/clone3/clone3_selftests.h
+++ b/tools/testing/selftests/clone3/clone3_selftests.h
@@ -43,6 +43,11 @@ struct __clone_args {
 	__aligned_u64 cgroup;
 #ifndef CLONE_ARGS_SIZE_VER2
 #define CLONE_ARGS_SIZE_VER2 88	/* sizeof third published struct */
+#endif
+	__aligned_u64 shadow_stack;
+	__aligned_u64 shadow_stack_size;
+#ifndef CLONE_ARGS_SIZE_VER3
+#define CLONE_ARGS_SIZE_VER3 104 /* sizeof fourth published struct */
 #endif
 };
 

-- 
2.30.2

