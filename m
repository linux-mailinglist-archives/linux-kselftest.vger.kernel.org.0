Return-Path: <linux-kselftest+bounces-30376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5909A81518
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 20:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC70C1B66567
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 18:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975F724394F;
	Tue,  8 Apr 2025 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSUBVb/F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E89D24290F;
	Tue,  8 Apr 2025 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744138272; cv=none; b=ZqXydFJTNtv2NVqSIQqXIVECoD3PQF0x0JeHntIgvlOOaMxyFYNOTvlRFrP/VKvn4E0dOux9Q7IsAI14wA3uyGnzzEMLS3NRY8sqaZ0MTMUKSrgDX7/hP83SwbZp2CdGWPTrkLqx6lluXHjAvc6ZfFsBCPIv6zxuee6aWpphupM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744138272; c=relaxed/simple;
	bh=58+3HJOajqHhaBuOa7ipEd3ah9IrK8/b0nQffaXKgLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qnjTwN90qYI+T1PkMIROd9Yv7WTI/Jq8WJXlrMkHK3z0VcTOkq/XoFSta6y2HOUI5PYoXMIcuAZHrD2YQSjYzvp72KLUC+bki0KhxdEvyMHqMBbgnY9zQ0GDSoKpWxhqcbmzbG+SbVr5MK+0MWzWOTP71wNCnlMUyASOCKCPhGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSUBVb/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF77DC4CEE8;
	Tue,  8 Apr 2025 18:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744138271;
	bh=58+3HJOajqHhaBuOa7ipEd3ah9IrK8/b0nQffaXKgLE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gSUBVb/F1PN9ub4RGkOs3bcYYUXZSF4KKDRLTPsa6tY/7hN5Vk/9zvZeg1v+UV8E9
	 fRNf3hTDqkSGed28QNcvNoPUQsC/Zk6n8DxgTixcE1HTTgzcQ8WgiqzDpv7qeto6CR
	 LHuAkaUi7Fi7d9cmVGbVOv2yS9byjGibO+kKr0BiyrkmtwRtrcr91WlAC0J0YAij0C
	 y/U69qzK4nEa6+y0PetK7+Jb5glrRdSmTzJAhMhO8041kSDzwoMRAaPsH0kAJIW18L
	 9vlz9OxSwMHL9DRpCEcnb7GrCsbOUljrIqTv5Ud0b5ystvumXnC1qc6u7tUVVzsb+z
	 +9kdIVh8DpzGA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 08 Apr 2025 19:49:47 +0100
Subject: [PATCH RFT v15 7/8] selftests/clone3: Allow tests to flag if
 -E2BIG is a valid error code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-clone3-shadow-stack-v15-7-3fa245c6e3be@kernel.org>
References: <20250408-clone3-shadow-stack-v15-0-3fa245c6e3be@kernel.org>
In-Reply-To: <20250408-clone3-shadow-stack-v15-0-3fa245c6e3be@kernel.org>
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
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn9W/rzEXC8qaSvjynqhm0QUrtxc5lFCc5P7cnVQYe
 ZsKOru2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ/Vv6wAKCRAk1otyXVSH0Ok7B/
 9npPrGfpneWB4nGE0oaFH6NX67+HHUx25iuZ4gd+y3vn2qwswOsu+2AwvgNUkdchV/ZCd4wLHtLGOk
 jGntNKx75rG5G02q6l3vHHjXPT0CQ44+IMdsY41jBUCmxcGuXpZ5UkSKWYK36+YZKi/EKJePEugyNd
 d9OxYYAtXU2mMQL7SiiBwqZeQK+tRAXbwDEo7YxhikMiwj0iducYIrAKeXGEgat779aTLPmbYiffQN
 Y5Wb0Zxao4+iuM+6p9OmSRvCTb/nKKXGCLApwFgQxkKaMF4ffGzJcOyR2SPeZR0Yp+kF/pKMT0NYdz
 9VcVv9IN+/ZorSHqTinZXXOu/o30EY
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


