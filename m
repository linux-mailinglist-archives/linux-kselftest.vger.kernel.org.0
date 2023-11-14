Return-Path: <linux-kselftest+bounces-112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140967EB748
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 21:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8ED8B20B39
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 20:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF77F35EEA;
	Tue, 14 Nov 2023 20:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uxh8I9pc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC13A35EE9;
	Tue, 14 Nov 2023 20:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0514EC433C7;
	Tue, 14 Nov 2023 20:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699992401;
	bh=ZmJrvmANp1kG9kAUuq4ZkamJ4qQyGfBTGbaFEhsSApg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Uxh8I9pcemFU+yGRtS7Vuo8DeS1M2BfZvhrOG5xhsC6Vl9YyuKMKsy6cEUNGdNfiv
	 YmA3bhEelh6LltyPaU9bt3Zc3Lg3i0sjQu9Zwd7nzaVlur7sQZ70zDACZyeTab0nm2
	 dYQCYAY7bxQ6e77mhy4d2sMZjrl3x4mjjvQgv6fqT1RWKnja7bFeIBoZBnfkz79M8t
	 pahN+VpPRyQrkpJSMfwLojoddj2xVk0MDgpJlE5I3DF5TQ9lHSxgt94f8gOmTvIjLR
	 XTiOU+i0gIO0xfAHPC7G4I7x3lpMx865OJ2rAlENPzHA48GKK10BLFPoG2+w92sY3P
	 zU/cCwv7UzeQg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 14 Nov 2023 20:05:57 +0000
Subject: [PATCH RFC RFT v2 4/5] selftests/clone3: Allow tests to flag if
 -E2BIG is a valid error code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-clone3-shadow-stack-v2-4-b613f8681155@kernel.org>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
In-Reply-To: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
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
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1887; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZmJrvmANp1kG9kAUuq4ZkamJ4qQyGfBTGbaFEhsSApg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU9MvjU45KxHk6MXI07uEtQfGL2f1juaDoVQx1uQt
 jstsNW6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVPTLwAKCRAk1otyXVSH0Cn2B/
 9NNiANJ4S5XcTNlqQbxd9WuKQLoSseYwhfB+36m1g1HI6ZznOzMdea9h1Mw5JQ4ab4pNSnRgZSJ+uX
 7ViidqykpVO08D3UL5GDOfiTf+5qsshyDTU822KPe4CV40HJlVyaS/hHqiT5b1V7f0j/X501W+iEBi
 N2c9NmMSgFTMPwbfDm078r34xcxrNsRq2PnhO7RsS4aC461EufZRU4KhF3FqI+tGBgEdGW4gAlVBOD
 AaCdWmgGOc3CuiDQK33lkd06u7bHZAGM1J96SbZAmWcAbXHizTMc5jCafHbgNWM+Kkdbb+m0oMStL7
 bRS0J5f9pVElfhbFo0IcbtqUrqkZJD
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


