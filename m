Return-Path: <linux-kselftest+bounces-15917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E49395A580
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 21:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0EDD1C21715
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 19:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E286A170A19;
	Wed, 21 Aug 2024 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRwPRqJn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8576170855;
	Wed, 21 Aug 2024 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724269872; cv=none; b=cDHFZxSURQNkuASzdloGgnncAgyF3fWZ8HBV5PnTupLiepZfNaKRLVt1CJZOSNQLZXns86s2Toz0wyNTx4rHo5zSF1qnbHMh8ErYcPXgA3QrzlZ8uFj/mLjZlZH5BS4oxXfRWXxChD9sBGQ0N4gbW8aynp6PvMZZVm+7gCpQieY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724269872; c=relaxed/simple;
	bh=2JIySYLy5Zx4h3HBoI1rUprWAIQuQf3PAf28WNSsOzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fKtbkp167q3+1uh+kRz4Iv3oALnVyiSG0S+IhRbINhMFRQF6Tn/zSDe6Ke+p3ZnqgeEKbzvMMp8KIlGb7QpFLyhze16l8G6MHLs1vQx78oA81zisi3XzCssoNZKvhGiJL5uhQ+hp8uYrimZVXhnr3T01D26/0VOp/vEVvP2BUf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRwPRqJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD058C4AF0E;
	Wed, 21 Aug 2024 19:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724269872;
	bh=2JIySYLy5Zx4h3HBoI1rUprWAIQuQf3PAf28WNSsOzU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hRwPRqJnYBbPgMUhlyqAHi8FVMJjtGtrlmGixrMuBxwXsRqk3NUQqChuq3JpBHayW
	 +Lymxrbp6NiGRdpnxg6nTI4OIU6x+2XEQ26OMgu18Vj8rZOv/r9E3sOhBGEptxoHji
	 t7Y3wh3RDqSb+qb4ZO1w/Bh2Dd7jivf6h+17M6puOgqXyPo8RTDKDyFvm1r7Q0vM64
	 1c6IFeghp3u/yjFNkmzqXBhhFzq/pbbMkMHCMU9n1sTAR7ZyKmX2RadPfGD2IvHZOK
	 lS0HwqdhK6jnZy8J31fzgPwOLQy8jr3zP6kYrw9EKMTk1yl+XVajTT+w3gbiIbX9J3
	 NKVgMJP0y3F3Q==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 21 Aug 2024 20:49:53 +0100
Subject: [PATCH RFT v10 7/8] selftests/clone3: Allow tests to flag if
 -E2BIG is a valid error code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-clone3-shadow-stack-v10-7-06e8797b9445@kernel.org>
References: <20240821-clone3-shadow-stack-v10-0-06e8797b9445@kernel.org>
In-Reply-To: <20240821-clone3-shadow-stack-v10-0-06e8797b9445@kernel.org>
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
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmxkT40EpADXcYp8wA8JPtLKZznOrn0MPunDTJ0rVY
 9K37166JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsZE+AAKCRAk1otyXVSH0FpIB/
 9zHnOLYBiS253oINoN3buiNPqjjiAdxdUjMHy23VQoqzAUEravIyKT7lzsLNKmkAcsAj+MKV9jLVdY
 Oxs04fpqNS7oLGrD7+uJ24G7vGu9s+clIp83Egw39hPvDuXGjXLmuAUfb4X6sRsA2N6GqN9zy3K6W0
 sPXRgdE5SzwUJxii0uwP8Jk8f0YP1LE81xswiwau8rAv6Ks9jmfUNlO4baR6ZGWgprLJRkuHYekoKb
 S4vy8UYcs1BkvgRi5y3WMtzzaO4YG8pF7zFcvMgxkPpkj683clk1Bi8GSjVvST9nuS1cnhlvWSeOIm
 LZ7uN47i7j+k0WhYCzSVATLZC6InzV
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


