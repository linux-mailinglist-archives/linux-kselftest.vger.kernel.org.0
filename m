Return-Path: <linux-kselftest+bounces-15017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B74694B8D7
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 10:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DD5DB27E4A
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 08:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA11E1898F5;
	Thu,  8 Aug 2024 08:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ioxw37Oi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C59188CA4;
	Thu,  8 Aug 2024 08:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723105064; cv=none; b=Nyr0Eu8Ivbg4F0w+lnZhi2rfyEv0GW8HpMkJKydaTY5PpJEUkdOUIfJJ1/8qY8rHy1ioGLlUKMC/kK7kFnRk8yuuz8mflbD5ZJZyut8vQhnGmyOn0g2V3KP7DkyC+7cxgkBj5WsXVma94EHfRkAshvMRcPrxBFmZmg0BoHYsUbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723105064; c=relaxed/simple;
	bh=OrLlJZLIdpu8469ekNLVgxT7+eFxGI9yqTN5LZeTdZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ah1F+O+HjTCPWecTQlwdm+7frdJDgYdi2yMLnQiEHljXM+shDfiT6UTzXEOqeMjnkgUIKjgJjBJpc+1v1jjlIlma0bemVX4rSa54UYCvOkuUQZ4P5pEmsyyU1VLSiMVOuXec0rJZkFFkEXwIVlBHGxp2EeQbNIkPaTym18dD2rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ioxw37Oi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CCCC4AF16;
	Thu,  8 Aug 2024 08:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723105064;
	bh=OrLlJZLIdpu8469ekNLVgxT7+eFxGI9yqTN5LZeTdZg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ioxw37Oima6PVBah/shmp5Ter51Q/TISbJaYTLYUASaTIgzJBlo7dhI/v6psdMgSI
	 MyqkYhE5WLwbj1iOUxpWxDrDD1OBiR6QvzdoJRgZQB7UND7omn0dfxEJcU+PYrYtjt
	 V73qb2Z4dGXvtvO/rk/l6bklY+qkWSiRLbAe41EVnMj/kOjyBBr0Thq5de+OCys3d7
	 NcvZ4QciF/viz2orK3T+0lvdS9FQ8ixl6cy7xLta+Hg29+GXTtktnlr9lflDJ3SJiH
	 N560rbGY7rKu2amZQUwXQhvOeSDuPigVzhumlCHLYg9gvzkEGEBpWbVVaw8pQuBoO9
	 iHsLISpy+eiDQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 08 Aug 2024 09:15:29 +0100
Subject: [PATCH RFT v8 8/9] selftests/clone3: Allow tests to flag if -E2BIG
 is a valid error code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-clone3-shadow-stack-v8-8-0acf37caf14c@kernel.org>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
In-Reply-To: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
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
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1887; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OrLlJZLIdpu8469ekNLVgxT7+eFxGI9yqTN5LZeTdZg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmtH7PF8qRF2BJmh32y0RmrHBzpwv8UR9FcqUq4
 jSMVpDSLRWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZrR+zwAKCRAk1otyXVSH
 0C5XB/0cRSLnJkkl/RUdqEyjK4e+rrlHnGZ3l1sf7QgUfhJAfjRIjUcNwvf0eV0+QBsa+kIIglQ
 348zMED92ZaZ+qQbrlbDtdl7vKd+B5QYU2u4RR1pHr2yc7ZJ1vB5Ts0WSnw/OkRyuH73CuNZ6X7
 lDjHb0h21KhsspDThWrU2dWOpKHCceJWkYmY+A+wBuL1H2O2WZ2bxg9h49ia1ukFE2U0izn8Qf9
 yn/a5tA2PXWGGNYwrm/CtB9l/ATWbWy9c1UGF2qL5SS6k3qXHaNNcM2OErisBRJvQMhqgJMp/d/
 MfgG8xekX8ppkSlVEad5S4Y3rRg+FKbmbZYNreOrrsYt+LYq
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

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index 3b3a08e6a34d..26221661e9ae 100644
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
@@ -153,6 +154,11 @@ static void test_clone3(const struct test *test)
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


