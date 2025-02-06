Return-Path: <linux-kselftest+bounces-25919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40427A2A7BC
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 12:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C6618878CB
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 11:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E6222D4EC;
	Thu,  6 Feb 2025 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThLpEZG+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D0D22ACEE;
	Thu,  6 Feb 2025 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738842053; cv=none; b=STxhtypndhkJmdFEKEHaO4nY7HGhv5Pg0+JNGqEaPjYuRbG9Pu+q6R67BurSnbjvo3v9gRcHmq4Jx6hetWldKZJpJ71p8TBos1tk1Us/W9mSXbmBAg1Ljhl5icYtMJFaURtpyOaY/RA19hKh2juCg8FpFthm2JETbPF8UiysGzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738842053; c=relaxed/simple;
	bh=3K2UKwx+vuFRYwPgSWWdw27/XxZ/PQnIsnZQ3nrGTtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MmFCJAu/dizcBPo3Q9lTHu+9CTWhr+DxNrfh8t3S1a6YRPXD/wabInFd0knOQKtsKzri6guZg+H9Jl5qnKq3DqNWN7J3FyjJs0HQf/Fg9Imn+33ASjcfEBcW5ISNeE14knJ3gOdM5qIkjUiC784vlooJwAPpijAAcm7HL7teONk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThLpEZG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DB9C4CEE4;
	Thu,  6 Feb 2025 11:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738842053;
	bh=3K2UKwx+vuFRYwPgSWWdw27/XxZ/PQnIsnZQ3nrGTtc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ThLpEZG+BiXZ+UYNrvfnTie86Bm9X3kyh0RY2KT9vRgcyKhi5L2CYTZwiaCz89eRv
	 +gF3IbAol5MDkyCUpv5/x7sLwLqQWEGQSRzT4yH9BDHGbe82rXkReMFRza0KXsUFiJ
	 xKWwoHib+NXWGPlb62KpDU9xWrT+QOcncFj1hxED8kAixbTdhUG0+3GcwRxcNNrnFA
	 b7EUb+DxNdYdcwvepT22mjILOT57Ls7VwSc5ljROFB+WpTsvQw2RakLMjWY2g2NiyA
	 SSyNkRh1gZCWjiURUVNio8tqaPSqVune9Q/bk0By7ax7MMLfKuK+IFfwNevxFcjYHd
	 IxaTzrQqL1O0Q==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 06 Feb 2025 11:38:09 +0000
Subject: [PATCH RFT v14 7/8] selftests/clone3: Allow tests to flag if
 -E2BIG is a valid error code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-clone3-shadow-stack-v14-7-805b53af73b9@kernel.org>
References: <20250206-clone3-shadow-stack-v14-0-805b53af73b9@kernel.org>
In-Reply-To: <20250206-clone3-shadow-stack-v14-0-805b53af73b9@kernel.org>
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
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2131; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3K2UKwx+vuFRYwPgSWWdw27/XxZ/PQnIsnZQ3nrGTtc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnpJ+TMvo6K8pgPknB+3dXsat7K6AeWSkktTYZLcag
 mBySj6OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ6SfkwAKCRAk1otyXVSH0DGvB/
 9i4Nj7i8bjak6cLr2dDaXeGea3z5aLG6DU6i8NU5EZilFLX5/SFTVG9ssfMJc5epdZ0UuH9AFl9HO+
 eWAtdS3vhz+ZAFof/F4bPialAXi+jMLDCejknkQROFidKwIF+htla3ZFiCdB3ckqDhxGVbxCzawjXR
 Oo3NWmVV/2CSHEmXmaqfoPXt0zDynYZ6w9DaIo2CEVJzq9/DfkcRhvdp+FllECsrpNGPTEp0ZGG8Sq
 3RxnI7sAVxfP4K2FsMO39LzhBBed2EGjVsQ8xL1UEW7E4URnEH1nAi7Yd77GYD/+cDlrIYDTWeZU6N
 Xcn7qAoTo3sIZKqK3YeuG7DQiVM1lb
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


