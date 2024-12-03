Return-Path: <linux-kselftest+bounces-22774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B819E2B46
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 19:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB27F168444
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 18:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A726207A3B;
	Tue,  3 Dec 2024 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIoTsrO3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AF71FE444;
	Tue,  3 Dec 2024 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733251479; cv=none; b=tCxrTDQMEF63+/m2qQN+obbo7luPTx3LUjes96yyCrxeYrruMuYZe0XYx8rfOzrozCdK5PmNwpQBUbLJdGaxSVAQVFCwwuJtNM5scaNNJyBN/1AdbXFRumOx505T6ND0T1wU+k0/B5gRHGjBVLSCx8pgYg3cECBMDRhjdZdGF2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733251479; c=relaxed/simple;
	bh=3K2UKwx+vuFRYwPgSWWdw27/XxZ/PQnIsnZQ3nrGTtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=diFaM3ajOxjMGLbrf5+2ppZ5/RIhXMpTQ+6Ha0VGictOrKqoru9/oXzVDjGz+pFZoksYg/L1MlWAgI7k4Sk2a1IKuKwGwaP1CDEZ/4v0JOlWJGppmjt7RXSkiH7Gj1os0Tg0jqg1zGEf/gHXJxCmVQe43X6AW3Fei/H2e+E09j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIoTsrO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD65C4CED9;
	Tue,  3 Dec 2024 18:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733251478;
	bh=3K2UKwx+vuFRYwPgSWWdw27/XxZ/PQnIsnZQ3nrGTtc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nIoTsrO35egBGyHSoEHIzZBuCtwVvIhL1ASRJ7hWiu4yyWWqFpaqgkvASpqrWy7aI
	 t/4Ntsq7U9WTstU8+DpcqPv+PUyS8GtuKi2chM2mZJrq0BBaCeWVnw6z3y7ulMjJ2n
	 tQF0RIFVDl7gRhoF4BP2VNslqPdEhXWshblUpCEvRZ2rGrULTc1k2CLEtxrBoEX5Xs
	 +31kWwppvfwFx4GQVxWR87mg2UQULMaX7dqqxm+XGdjOdU0M1hDsXHrqZULB+Eq8tL
	 soty2ulCvpruEAAeQ8T39CovI+AWG96q4gQofYxqNDnyhBLZBy1c3unCegI2dgQJ8M
	 HTU7u0bEmbkpQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 03 Dec 2024 18:43:41 +0000
Subject: [PATCH RFT v13 7/8] selftests/clone3: Allow tests to flag if
 -E2BIG is a valid error code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-clone3-shadow-stack-v13-7-93b89a81a5ed@kernel.org>
References: <20241203-clone3-shadow-stack-v13-0-93b89a81a5ed@kernel.org>
In-Reply-To: <20241203-clone3-shadow-stack-v13-0-93b89a81a5ed@kernel.org>
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
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=2131; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3K2UKwx+vuFRYwPgSWWdw27/XxZ/PQnIsnZQ3nrGTtc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnT1FjO+RUyrRU5i3S6IrLR2NQaXuoRwl4o5L4r16y
 MEL2/7iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ09RYwAKCRAk1otyXVSH0P2tB/
 4tYfKtZXuAIPpEeqmCQmIZpyU7d+UAMDuEkgHzxoSlrDJ8M65bNnUBRBeDw6Cs+lLLkc8cYQWT9Arf
 Oh9Ve2hvvpQbdzCMeCYzkeaxLx2pf5m6MM/Ceq0uByfcAbeub1ONDh7cRsskDBy74zhHZTn65RYv2w
 3XGb/AHq264k+77m6xXOtd1A/0BklMr2dLs5kS3f3xiOgqASDtbWM//fL+Pju7t2HXW30nuEeUcWJv
 No+MLmtgFtsVhc7XuhfFLUUG+TuUwtqQLzoOsGXXPz41PskX2hDcjO+Xd6fnMIQkinfZnRGgjcU2T/
 6DYbKyz6Nv9/31E2Y+wy26M56Eb/lQ
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
index e066b201fa64eb17c55939b7cec18ac5d109613b..5b8b7d640e70132242fc6939450669acd0c534f9 100644
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


