Return-Path: <linux-kselftest+bounces-34473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2725AD1E69
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 15:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B076F188D4CC
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 13:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034AF25B1CF;
	Mon,  9 Jun 2025 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vh3zGnuN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2BE2594B4;
	Mon,  9 Jun 2025 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749474118; cv=none; b=CCt+GwwKUZr/AKh1msbxyTbPZcRoUkObmieDhhwq7xQfMDV7FKWFKIJ04WB02dlVu+lMjzSU4P2jBRF4nNDMPD6W/4I4uWTThE5UvOawfKFl3xv3gXtLZWOs4BXzGrFIJNO7kE/9Q1+mj+wXUVl3VEDAIfiWBPoGIytDqwf9JjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749474118; c=relaxed/simple;
	bh=58+3HJOajqHhaBuOa7ipEd3ah9IrK8/b0nQffaXKgLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K6cAwauOGQfbsCQyMl9a1wi262BYMevnUl6QauPGeBdp5gwtnHwdnoPHPdg0mH7Rw/rL9e1NZOfoTUmZIv/MznAF6nMSuQo2Zdxyj7j0Xwg7Ybhz1cID28+KJWy4pzF1UngH6CLbp7m8K9tLfLnD4AQZ+Bl4zZzNO+3++OhmWas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vh3zGnuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5781C4CEF2;
	Mon,  9 Jun 2025 13:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749474118;
	bh=58+3HJOajqHhaBuOa7ipEd3ah9IrK8/b0nQffaXKgLE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vh3zGnuNEHNlYyDHc/2eG90bOBkkGQravSAO9oO9avblTTP+ZdV5k9oLNdzToUGS9
	 962DMOboZQgHBU0VximkX63EzXBv2hSND3plxruAp66Fn08tYn/afyhU1Rdph1vcXK
	 XpihCspXUzN0fKOVVKE2dDudl7woj/ndV8Fbt4nRXJl6hqrxz7xcIunvr1r18gT9p2
	 /ewv/Ce//xmh4CX65RHxYKKz/LFZ5LnD5EMhii/qI7smD3RpAEdp3LTwO+oHDMetoX
	 845TDyz0MovM9/QX3WLwvnGE6WTQc/w/vf596+qiu6kFEVe2wXusTbVL2XsUe+tMmb
	 G0opQXTMCw4GA==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 09 Jun 2025 13:54:08 +0100
Subject: [PATCH RFT v17 7/8] selftests/clone3: Allow tests to flag if
 -E2BIG is a valid error code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-clone3-shadow-stack-v17-7-8840ed97ff6f@kernel.org>
References: <20250609-clone3-shadow-stack-v17-0-8840ed97ff6f@kernel.org>
In-Reply-To: <20250609-clone3-shadow-stack-v17-0-8840ed97ff6f@kernel.org>
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
 Kees Cook <kees@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2075; i=broonie@kernel.org;
 h=from:subject:message-id; bh=58+3HJOajqHhaBuOa7ipEd3ah9IrK8/b0nQffaXKgLE=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhgy32yICf5cKLNx3TOp04LtcxaeHgncu7Hqr/ISP5UUKkw97
 qlpsJ6MxCwMjF4OsmCLL2mcZq9LDJbbOfzT/FcwgViaQKQxcnAIwETd29j/cG18oa/qGhba+vS0szr
 0m8J7On5vHQ24eP+LYNiEmen3vhmvNXwUPc3w+qpjDsScxSqf90kvN6tml0TJJLZl5TafWeMZv1GTT
 zN+y81thenykNE/V9NVuaW+Emkt6Zq6L5Jgy1daDPbi79Y3rnuusUtcqGa4tiizeOKN4U0Xb557XJs
 7561V+mk4Rlwq+KLn14kJ2U+HzrqVdMhsYfF3cdfNFzTwE/jnrGS1bzxHHuKPwvugsh2uP3NekZEm+
 ZE7xj5YwONP7meXkr9tqmz943EjSiWbqNzS7EFOe4LzGvGvxztzOFYqmW3msvR66mZY8+zKDzZsj/V
 L1fsbP5nfcWRUO+vNtUb7ftDEFAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The clone_args structure is extensible, with the syscall passing in the
length of the structure. Inside the kernel we use copy_struct_from_user()
to read the struct but this has the unfortunate side effect of silently
accepting some overrun in the structure size providing the extra data is
all zeros. This means that we can't discover the clone3() features that
the running kernel supports by simply probing with various struct sizes.
We need to check this for the benefit of test systems which run newer
kselftests on old kernels.

Add a flag which can be set on a test to indicate that clone3() may return
-E2BIG due to the use of newer struct versions. Currently no tests need
this but it will become an issue for testing clone3() support for shadow
stacks, the support for shadow stacks is already present on x86.

Reviewed-by: Kees Cook <kees@kernel.org>
Tested-by: Kees Cook <kees@kernel.org>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index e066b201fa64..5b8b7d640e70 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -39,6 +39,7 @@ struct test {
 	size_t size;
 	size_function size_function;
 	int expected;
+	bool e2big_valid;
 	enum test_mode test_mode;
 	filter_function filter;
 };
@@ -146,6 +147,11 @@ static void test_clone3(const struct test *test)
 	ksft_print_msg("[%d] clone3() with flags says: %d expected %d\n",
 			getpid(), ret, test->expected);
 	if (ret != test->expected) {
+		if (test->e2big_valid && ret == -E2BIG) {
+			ksft_print_msg("Test reported -E2BIG\n");
+			ksft_test_result_skip("%s\n", test->name);
+			return;
+		}
 		ksft_print_msg(
 			"[%d] Result (%d) is different than expected (%d)\n",
 			getpid(), ret, test->expected);

-- 
2.39.5


