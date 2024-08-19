Return-Path: <linux-kselftest+bounces-15696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5C795746D
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545071F23B6C
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBA71DF66E;
	Mon, 19 Aug 2024 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmQEAi85"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67B11DC495;
	Mon, 19 Aug 2024 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724095611; cv=none; b=SY0MZ4nYy1LIRpyMKcHmbZUWf4ljycDid0EnpBde31Xa0dtyGHjAlbGciycjZ0RKZvnovTkHYqGLdr+eDbhzJt3TCAtsTIHTxpCltoQaC3QMABrB6BYwgPHkAI1HqfXkwSHICH5+q9uSkZK0+wF1dxX5tdUbiGkt2ZSfcWQNK6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724095611; c=relaxed/simple;
	bh=2JIySYLy5Zx4h3HBoI1rUprWAIQuQf3PAf28WNSsOzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xn4EoZIgk9BmXqxMw3sgW8+kEa2jZ2a7zaxnvzGm1UAYxZeqQ778cOAO3vm8kw81qjoZRwznKja/5TwGJ57F0qYbyzIN5Sr3uxm2yPoKVAqQzs37QY3v/0uJDYOttsij+WSyFYBdFyUHxhbV1pf2YJwUiGvu0u/L9Sbf4Mvc5oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmQEAi85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D69CC32782;
	Mon, 19 Aug 2024 19:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724095611;
	bh=2JIySYLy5Zx4h3HBoI1rUprWAIQuQf3PAf28WNSsOzU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UmQEAi85HOG8xPxY1ajE0Eh+r5Q2W9Bybb5uF8yIbJRlPriOVS0cqkZ/dA9qZFImt
	 IH/cM9rtxNsQd+faaIz/oBu/7ugy7fAYxJwSilhKH+hTZD2qbTqqjTaLvK4mfaAmoJ
	 oqBXn5/WDW87xVthbfs0pnhb+70FFcTTN9QyZ4WwWDL3slPcJm4J1SQFHFPpjYDJ4/
	 hkVy/RODl5UxqWA3EVuLf60m4G70KhNZPaZDoZz31TPrbOcWaOeWZkNXeRUIImkzei
	 X4JtXwxhAiHfSW6CFSJEC67pkC0trRQGxs/Z4yLM2sVV36dDQGEqOAynhY5fUmij1c
	 HieeUc4Rb/CWg==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 19 Aug 2024 20:24:28 +0100
Subject: [PATCH RFT v9 7/8] selftests/clone3: Allow tests to flag if -E2BIG
 is a valid error code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-clone3-shadow-stack-v9-7-962d74f99464@kernel.org>
References: <20240819-clone3-shadow-stack-v9-0-962d74f99464@kernel.org>
In-Reply-To: <20240819-clone3-shadow-stack-v9-0-962d74f99464@kernel.org>
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
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2019; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2JIySYLy5Zx4h3HBoI1rUprWAIQuQf3PAf28WNSsOzU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmw5xH6zvJ3/IIuidECJVeszRpi1MgxvvTIvjEbc4j
 AWfNUTCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsOcRwAKCRAk1otyXVSH0G+AB/
 4ro9bm570C7JGnCmzFAWBy4xxRRUoMPzf0Xl+xZlRZ0eUz5T/NB3iKDPaioEVkh6E7Y3SjN+6m57Lh
 t41CgRp96n/2Ok9Z/4oUwOSd8ve1cQ6uidYZWFIKtb6yRbTeOh7y9VS7NHMjAJSsSChQiCUSWhiA8/
 DgShaEmv7PWiJUlIIk0650c5l3wxbZXKZc2seGyuc36qC9m64iP7EiG7VBAcE/gP/aoF4l1yZq5Fla
 m4eIKbtr4CSuI+vgRHxBwfXX+l+ECTMFYwD5n3Pym3eoaTbiwIAM4FSBb+H+jy4nR02217Q8rx26iF
 b3lvv8nRX7RvOw1Tm2XTPZ7ISESUsq
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
2.39.2


