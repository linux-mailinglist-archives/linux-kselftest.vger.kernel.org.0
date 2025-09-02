Return-Path: <linux-kselftest+bounces-40554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B56CFB3FC3F
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 12:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548591B246A8
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 10:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4182F744F;
	Tue,  2 Sep 2025 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1zc8cLF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3082E2EE280;
	Tue,  2 Sep 2025 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808584; cv=none; b=ALy4gbs2CCxFw50m2Ky6kaEXuaiMr+3KyvYqg0G2kp+a1g1XmuirbZJa6KUg/ChqLpF1r+Oo7NwDLBBKCWTYZjLiuKb6oGdgzhayCm1BTpwOCS5WV2EFdbj/6t34ntSISGGG5tnGEVpjuL54AlVfxhsJeqwVvzQDuOOzyeGf4ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808584; c=relaxed/simple;
	bh=8IZxQR2EJWcC8CtTN5ZvDL0ZGuJwJUzmD8bnJ/92bkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EdIUjLA8+OfVVZuP5PTF+Q8sb4zGGPbm9g7jtdH9456j/bvJZsSVcXJV+z9vBC5KYHZcQhNrInAkqFVIpRNXm10ZQdHg1ZBNN2MadXOs+kigcfpmN8jhIGo/cf5EiuXPZ855oBhSoomQFsYyebTNoU1U54bd5fz5klB3F6H3IDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1zc8cLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CC3C4CEF5;
	Tue,  2 Sep 2025 10:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756808583;
	bh=8IZxQR2EJWcC8CtTN5ZvDL0ZGuJwJUzmD8bnJ/92bkQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T1zc8cLFD7TMoNSKmJX/9bPl8/N6/Ky5R/1lGAQqkedMIDAKpy+EYlDX24AMLFNuh
	 6OgOxcv5hSeH1kHF6vL1LqonEikuATullWM6oWh6Y9h0yjoEQ4RwAK41dG5gZBzVDu
	 WbFRr/Z1N6UD47j9lVvP9ze/C8uqrS/zMG9MFzxknOKTGgeE14NqyAjMJWjhGtZh7+
	 rPkZt96fc2Y2yqmRcQn+K20eH/y7YbfViYxAUaocxVCsklzyIWyDuLwWUKDPiiaiqZ
	 nUhsDRnwxYqJnxIEKWqERAtKQowVwtxxo56nWua5p4CY8Z2sR31TxJR5tAAF1ZbY1m
	 RrH7eWaBTktLw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 02 Sep 2025 11:21:51 +0100
Subject: [PATCH v20 7/8] selftests/clone3: Allow tests to flag if -E2BIG is
 a valid error code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-clone3-shadow-stack-v20-7-4d9fff1c53e7@kernel.org>
References: <20250902-clone3-shadow-stack-v20-0-4d9fff1c53e7@kernel.org>
In-Reply-To: <20250902-clone3-shadow-stack-v20-0-4d9fff1c53e7@kernel.org>
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
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=2131; i=broonie@kernel.org;
 h=from:subject:message-id; bh=8IZxQR2EJWcC8CtTN5ZvDL0ZGuJwJUzmD8bnJ/92bkQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBotsVY6i8bkwneplIfw7BxTTwMdnW3uIvGEPRdu
 Mk+6G52SPOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaLbFWAAKCRAk1otyXVSH
 0FdIB/42KBpWiDdkKoEaqQqzrK5DxKBxcaFyg5Ngid9FKvSlvM8icwGMvW64vooiLPDipC6Zps2
 /+1ISfi2dHUl1B4ceL6h1Zq2R2mzO22/4TukwQpnYHK3IRQyeqOQcv6Lq+VxKz9vaEFinqTfPXq
 iKuDZwgZcbAPQTRG2BrX+Sk7UrDBVcjvKOsI2KNnl5JJ8gLDGubJXrnXpqK0o2WBx4Ruj3ei199
 efh2ZFW4tmb6EbrxIj52fTiDxh8yWR+yjsGOziIWjGpxXQLfSWlp4cv3D/wUTDE++93V7Pmf3Rl
 33IRXttZNCwYPYVboGIZMaacNyG4Ewa++Jj5lHSxkidL43AE
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
2.39.5


