Return-Path: <linux-kselftest+bounces-14547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B377B942E18
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 14:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D941C21A26
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 12:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C1D1B1430;
	Wed, 31 Jul 2024 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOFFvtqM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E2D1AE853;
	Wed, 31 Jul 2024 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428392; cv=none; b=b/vF3l8hVkETVce5cMR6c7PiehENd3rjroiSuSp1YGZe+X8JAHeUHje2wOfU8aFRTiWlgDia68wchOH6dhKYNsIDA3pA1tmTTK60Pde56mLWtGZyM4pxY2hswub7WInZ6OZomLCPkGu1d+m+lSPh39NIDXmJvht4yqA1MEDzTD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428392; c=relaxed/simple;
	bh=OrLlJZLIdpu8469ekNLVgxT7+eFxGI9yqTN5LZeTdZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sv6vx91AO1kyiBYIJ82JHAibYGVrLjCkNns6EiM49i3eqQaJnydZ7YJ/FfZVc8CCoinBrNw/nJ0/UNsiPrPvLllUdr2fHuDEn1yjo0Lk8fD2Jckp3U8xFR83q+jHdcUuvuGkcFHyG9p9eEBLZ4dM2aYrBW9EwTHi0iL4UL/+6Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOFFvtqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FC3C4AF0E;
	Wed, 31 Jul 2024 12:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722428391;
	bh=OrLlJZLIdpu8469ekNLVgxT7+eFxGI9yqTN5LZeTdZg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jOFFvtqMOGTGoUH5asW8YOPnPFK/+M3cMtk5WN2yWsB7hVmcUrsyYQtza0vG+0FFA
	 c+Ru4JhfFyQpZSmYibj0EATrJ/eM0sgoYOkqh+HHtp0Ekk7ZOCds6hMY5DTdP0D5xr
	 Eco0kR1Ebsvi/8m/S92+2Oz5REP0qn0b30B22FfBUK6NzDDTRtLUIFicLGgLm8NGaE
	 57pUX9EdMWxPpR2p/Cipp5xgsF3hZfCKYocrmkd0vuaUb7TgIs3HhRvHzRe0LoqIAo
	 y6aOETfc01ZYRgbNCGJNLiOHg+0dInUZe5FSnarbPre/hUAyyAg/MrU/6SzjdvJRiv
	 Wg9RwXht2V3ZA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 31 Jul 2024 13:14:14 +0100
Subject: [PATCH RFT v7 8/9] selftests/clone3: Allow tests to flag if -E2BIG
 is a valid error code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-clone3-shadow-stack-v7-8-a9532eebfb1d@kernel.org>
References: <20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org>
In-Reply-To: <20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org>
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
 Will Deacon <will@kernel.org>, jannh@google.com, bsegall@google.com, 
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1887; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OrLlJZLIdpu8469ekNLVgxT7+eFxGI9yqTN5LZeTdZg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmqiuxOoTUUwb/oJnYCd+qB32Ynk8XPuZ3cOEJ8w6u
 uABPoKSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZqorsQAKCRAk1otyXVSH0BEnB/
 9vHf4XSsUVnoB83DVXXn5TSfUE8u8e7JrkManpAIL7gqJCGOQMDhTxxn2z2Oc4/DXUyFWcu4wCXuOz
 FJoX6XVItKjUCUpjNZGmWX8A6ZqID0txxaJcOjVqe+21cpHITZiaV0ofT0SGhRiMYxj4qod+FT6gsp
 53og5bZYZBkq43TWWyQfywZNU4coMpRByxDJF2DVFDADAQznMooGuVyR2noV7aMVtUlozit0Oq3I6a
 QvwFmMj/RiJaV8wtZ5HI50QnyZZT8vjqLSnDD8Ejs9xzZdyw0b8uU0CKEDLcYV82TmW3WATQUIdWe7
 WuD6ahBlfs31DoXwJtMQyDzVDlODpt
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


