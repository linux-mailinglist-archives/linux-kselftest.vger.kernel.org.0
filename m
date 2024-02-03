Return-Path: <linux-kselftest+bounces-4063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E9C847D83
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 01:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D95A1F2C26D
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 00:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8752A3D;
	Sat,  3 Feb 2024 00:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sC8XyJ2t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2248472;
	Sat,  3 Feb 2024 00:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706918761; cv=none; b=mLC7FmPdqxC2t+2o+8fnKcq9AHGA3QaTdtxrvdus3aFuWJsm9o4Kvsc31i+NWfrb3lEwDIlwSPR16tujgfBKB7GHdjMlAk58MLES9BCHFduRO+qAvo4k5jUzLduTI/8qdNolwHAbpKISwDGZjE2gRmE7cbh5/yH1X+9mxmUKbmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706918761; c=relaxed/simple;
	bh=ZmJrvmANp1kG9kAUuq4ZkamJ4qQyGfBTGbaFEhsSApg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S54Yua9nkLBmktmZaIzyz3Y32n3S7lOOdP6MexXQVg6XcwkTJkBjg6USLnVsrVo7qugJwxQcPRHKqzAcquTwQLIOf+7UXA4GzK8jifk83b+OLxc49ttmu8vDpagmMr0sYGMIWYx8xOo7+9zdVoSpimmKoQZXOkdOuP/tO43zseY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sC8XyJ2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B329C433C7;
	Sat,  3 Feb 2024 00:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706918761;
	bh=ZmJrvmANp1kG9kAUuq4ZkamJ4qQyGfBTGbaFEhsSApg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sC8XyJ2tl+Jv+nMg7kAlHTfGiiunwtOdzY+vfI6myXuzX17FY60/s+/g23rHbGyvG
	 jTc4DgipAAux9rkk+UZog/myaTd9S6nIAmbFNNuIaaBthYVH7BKRWy+5WOGU9DqKwr
	 NZrDPQzFph7iezj64I2aL1EP1oPqfa+PMP/IIfe8X6IPEM/ZMFbL75oUbnUMxRUHo2
	 urzWWHW/4NGel5+UD90WjjZdYDoOJfcLtpivixnVqVVuUq2nMd4zTafrF0krut2Xf8
	 3tGuVpMJuGSYFuN0rlLIcGfOt+nulzQivVfvQJ9R/QC0H1CMC8qYScaDIatY3Ni4xR
	 /vq9YbEFIChHA==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 00:05:02 +0000
Subject: [PATCH RFT v5 6/7] selftests/clone3: Allow tests to flag if -E2BIG
 is a valid error code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-clone3-shadow-stack-v5-6-322c69598e4b@kernel.org>
References: <20240203-clone3-shadow-stack-v5-0-322c69598e4b@kernel.org>
In-Reply-To: <20240203-clone3-shadow-stack-v5-0-322c69598e4b@kernel.org>
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
 Mel Gorman <mgorman@suse.de>, 
 Daniel Bristot de Oliveira <bristot@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>, 
 jannh@google.com, bsegall@google.com, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1887; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZmJrvmANp1kG9kAUuq4ZkamJ4qQyGfBTGbaFEhsSApg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvYM8du2iMR3YFLO+fn1uPqS0LIf1mYcOElHC1XUz
 znsriz2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb2DPAAKCRAk1otyXVSH0JSSB/
 9YIPz1a2MqXlpuNlxfN51p6rKezpSkt4SG83/Wnn8gJWOrgIRIJno9fDwno9O5GIk3S1DscMBpDNSB
 hkyVSXw3CUoHdyDbhHNDsmPhFRa0zPMdVzBMnw27UDOz0Vrvf9h5wCebi/Mu5wU00fA3NWjnBCXkso
 bbk+u6pZczo4Iu4DvGybrgkUGlCb7HbLRZqSu5ptNGBHXTSN9oDoklorKd3xandZ4RlDek34HmuuCl
 eCiw+J2PkZ/Aqiz5TNosuM8KbBeChhq+/KBZ0G7gXah72pHKTFO35E7bnxXY1QBBVxsM/Le7QME6O8
 sT6TWuSlqvEsWXnv6loxFoNKrmnZ6M
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
index 1108bd8e36d6..6adbfd14c841 100644
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
@@ -141,6 +142,11 @@ static void test_clone3(const struct test *test)
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
2.30.2


