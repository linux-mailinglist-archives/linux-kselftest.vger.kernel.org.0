Return-Path: <linux-kselftest+bounces-41541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE98B58843
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 01:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58E437AF8F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 23:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2092DF152;
	Mon, 15 Sep 2025 23:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaGx/9Jo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621212DCF43;
	Mon, 15 Sep 2025 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757978783; cv=none; b=Jr15currZCD+zrYMntGBEEnsYKv7HT90NVOfvnJmhe+cDTMt6y+8w4AgLhBCWeVrnO5qDwVLGxryd0WVPJr6jzyrf2S79HK90/jIRdQkjrdbzOpn2oyOCvyTnMB0i+zraHH0fDJ0M82oBcnUQLt6EH70siCFgHG2tveiSEuto78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757978783; c=relaxed/simple;
	bh=G8bBSQKlO7rId1LDmFNrephPZ8IGhE5zllPW+If3ahk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I3xKR5OvqHTNF+QmbeHkFagvHdbj1EYYxvbKYG7ekjUxIrTNckP6crMG/4CrlIhWMZ6M7S9uqEHpDjkfWWnicT3TKuoNL+OblNc7zWY+Ta8+d0QFS1qRmPRknCxA8l56oaMXjg2SH1DrTMFTxzmyEp9HCzwckH4HAg1s3GAGF+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaGx/9Jo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C74C4CEF1;
	Mon, 15 Sep 2025 23:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757978781;
	bh=G8bBSQKlO7rId1LDmFNrephPZ8IGhE5zllPW+If3ahk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PaGx/9JoGqUqCuPoEb13QF373OQ8nSRla/Vvk2KM6l8jL4MCb2tHeD992oZaUbWQF
	 Bm16fmgYzKznmSbBepKNjLruUNjo5hsZPfLFLXPnb2xsMQ2RFYY6Yce+1HgH8DxwA9
	 OlGy82FLkBuKk1aomzF27C9qZbE55/y6ZzQmXi5SrRsOPdrBhqSmoUBU89u+8ITWqq
	 UfVJmJwK6NaN8Wyoo+afqQX3kcK4RAHdx2Sfcar1e6aMXJ5hSspiQIUAI0oltjwxUO
	 whIvtNNv5eF+HjtfRnGI/DNoIWvh3ziAS+3Fvw8tSlad8mAfomkKwHq1cVqtMruAiI
	 Zdllmr4HfQFtQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 16 Sep 2025 00:12:12 +0100
Subject: [PATCH v21 7/8] selftests/clone3: Allow tests to flag if -E2BIG is
 a valid error code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-clone3-shadow-stack-v21-7-910493527013@kernel.org>
References: <20250916-clone3-shadow-stack-v21-0-910493527013@kernel.org>
In-Reply-To: <20250916-clone3-shadow-stack-v21-0-910493527013@kernel.org>
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
 Kees Cook <kees@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=2131; i=broonie@kernel.org;
 h=from:subject:message-id; bh=G8bBSQKlO7rId1LDmFNrephPZ8IGhE5zllPW+If3ahk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoyKBrj/9VORK27OaGXKVsa6G9aW9VAnn0l8sez
 61D/6Ami5iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaMigawAKCRAk1otyXVSH
 0EX0B/44IfZUAOUZgcBs7shHYoo8iaJqZfM4eAGKgd5cKcfSqxZGFBrzUCEQPrgPApsTljvIsiX
 +XIWQUXt8nX40WBIFXkarfqQ417k+cr4pPnA+lT1sYcVUBQ0WkhZySfy6PUK5jugIvY2uI4Dvo5
 1V4BKkxu9Y+YUTpMGli31JDz43mbqO5NdH58w2SxAtJYaOZnmoea6unjKD8Q4XyMoG1HtxbbkdC
 Cf9cj76IPNqpX7wR8yREg0zaA2zfr6YY0wgT3gjZM5pJzL848DlVs/V8Px+11yM5uEaIphtWaFK
 wpD7UJt13Ind8LstiqJLLZ6jPonucTaEnrhmXRmuQ+k+SJte
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
Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
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
2.47.2


