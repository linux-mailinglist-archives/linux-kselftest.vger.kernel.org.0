Return-Path: <linux-kselftest+bounces-21255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC699B836F
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 20:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178971C24747
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 19:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186ED1CDFC1;
	Thu, 31 Oct 2024 19:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAuiVUVN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1531CBEA2;
	Thu, 31 Oct 2024 19:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402778; cv=none; b=k/+U+vTsPcMoCy9/UcpnVLCo6/WeN+E+wEzTzFh7WlJj/8VR5oV5ZVflSyAG2FeT2Yj+BcN1aLNLhAmPsKirzKmAc/bzXC1bOJ50mXcGqwfxsYH5B09SKUhmc+XVijmi2fMUNFM7n0Ral6/Zh2+4cMgPEia2bEcDrlxwqQnJvck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402778; c=relaxed/simple;
	bh=UUjFijhOzMtWyQQfCryUuv63t56HsDnZkM9eHaAh2pY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WP6ojMeaZwYVPnbYbAtG8wpB/7Z23zdAlhcD5vKCKT4Ge2wqf8lqkr20wrWzBdqeDkD6sXX/L1vahPNl3Oxyb4skmR/OYILwFloWONZWzEWE0ARWN2UWylBdEmXC+KoTXRpGpHpYdYmwLjAnluOWLhKdcTVD8ZLzWGSjNZf+fTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAuiVUVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EEAC4CED2;
	Thu, 31 Oct 2024 19:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730402777;
	bh=UUjFijhOzMtWyQQfCryUuv63t56HsDnZkM9eHaAh2pY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EAuiVUVNi1mQGqy7yIBFTWpG42o+UpaaAqKto55xzyAX5qHcVhDaCEtscDmJwhjLd
	 FAWYW2BGcPt7jrgwdqeXSHoRwZrDkQcczRd/G4kxlw3XlLRRetAK3Mr8C44nCrqhaM
	 3TpsaWHu/C1FD9diPZhW7j7/jWouhVEV2VgMGF/cm37CNA+uDrRWmsehSF8rzDKieB
	 oeXpZfbxO75hz3WHmuETjsNwObUlxjYp7R7o2xrkTTPOeV0ZO5+wlrJl5iGAK5gt1L
	 xy6eCsHfs4TxO5E/xfQHqhw/8uDAx5a+i0N5nY32AgYxR80HAFKMFaQ8YtA1i4XL4E
	 HuFyOKJEKHZrA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 31 Oct 2024 19:25:08 +0000
Subject: [PATCH RFT v12 7/8] selftests/clone3: Allow tests to flag if
 -E2BIG is a valid error code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-clone3-shadow-stack-v12-7-7183eb8bee17@kernel.org>
References: <20241031-clone3-shadow-stack-v12-0-7183eb8bee17@kernel.org>
In-Reply-To: <20241031-clone3-shadow-stack-v12-0-7183eb8bee17@kernel.org>
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
 h=from:subject:message-id; bh=UUjFijhOzMtWyQQfCryUuv63t56HsDnZkM9eHaAh2pY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnI9mnl+auNzRE/ss2N2jZ4PrXYUyN6TLK5Ll1smzq
 LC7jrImJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyPZpwAKCRAk1otyXVSH0HG8B/
 45V1vwa0LdwATC7+tggnfK8BV1JMgqijt+RhAED9RZ+d2U0JC8pT3e5CsVD29HI5XZKNtGl5T4v90y
 eYqH4iG9FYLnhjPnPqCjAkSZy24/pZvefZmzAM7K+rsp55N8mZQfg8yqV6cRUSCs9Gw/NryFn9rKcX
 VmMmdHdHEXIWCkr28KF0cYw4zVCzAxHJH3tY0Ye9MGoIB03H7WilsbVUgAd+G94m3nnIi/2B/XBroQ
 RmUFEPzltKWvyUbA/WziXDna2ATBLCzD80rtnKomBdegXcACoAHMQH8NX0ZhhRKZ8ZkJJJGbdyUIOe
 YF46tRCYXk6RW9YHMVSn5Ym1sade/8
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
2.39.2


