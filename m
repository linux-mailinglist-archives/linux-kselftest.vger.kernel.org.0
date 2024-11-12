Return-Path: <linux-kselftest+bounces-21857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1639C589C
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 14:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B72B2810B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 13:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60CD143890;
	Tue, 12 Nov 2024 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVayi9D3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2AC143736;
	Tue, 12 Nov 2024 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731416910; cv=none; b=ES+JYeVafm66C7DasDkBgf5NP28/og/0lJ8+gs7GcJiPZEYO/7DrjeCokwvO4WZPD8EDibGWn1sdwK0TiUteTh2FYtHtdpdIgjzAxw8hjVdgwSVC2GJW3oOtsviJS26Mrmkml5IZa0geii2tKPPSSknRE06gO6bUPiF2Vk+p5Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731416910; c=relaxed/simple;
	bh=Po9pxFWk2HFHIhixUOhSXupXUnhxhB+nhL5Y2znWJoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BFZfnHfW9iAnIxDq96CZX2tN5QaWXaz7QnaPlE+lQh9DWFGT1dhfK1p56W20JPx5apv0lHoEhM1/L/8LKL6VuMkFojJw7yY0RxrI4dZ/ufS7XsHXu2uPogxyTGlUqp09M1k5krhj1gVanWWXRy6+ipif3UdgCfUzXjAXoMm91Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVayi9D3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF23BC4CED0;
	Tue, 12 Nov 2024 13:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731416910;
	bh=Po9pxFWk2HFHIhixUOhSXupXUnhxhB+nhL5Y2znWJoI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UVayi9D3PDmZldTVrKzIKrmL5g3qgpbmFV0igy1C1DktP9zQwVvHRzqjSI7/V5m9w
	 LRfDN9/Z9PbcnjRxOfUVDFmQkMW0bzNILZuL+a0B26aqZvv2c+1s1qTbllH08XJKky
	 4lt0iFASUgBO0AfXo5jMwa/wZkYZm1cnNupKOl4xVJPUOf8k3g02kY0ZPzqZcf+J+x
	 9mCMI1E336P6EdjjV2wgo9GzsQ3OTjhSOg8PpE95sXM/cGJpdNFvwFM+Y2GUOM3G9X
	 aWg15WLtYSDETW8aCZOjnKqz9tdbzRuMBy/IQRiBfL96MFHUDTgjmtCxc1g0yLGmnY
	 iMWAZf5hTPq5Q==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 12 Nov 2024 13:08:14 +0000
Subject: [PATCH v2 1/3] kselftets/arm64: Use flag bits for features in
 fp-ptrace assembler code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-arm64-fp-ptrace-fpmr-v2-1-250b57c61254@kernel.org>
References: <20241112-arm64-fp-ptrace-fpmr-v2-0-250b57c61254@kernel.org>
In-Reply-To: <20241112-arm64-fp-ptrace-fpmr-v2-0-250b57c61254@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5038; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Po9pxFWk2HFHIhixUOhSXupXUnhxhB+nhL5Y2znWJoI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnM1NHEx61YFzQeBViB8PBNV/DuW81eT68euXuL
 LPjTZzScAyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZzNTRwAKCRAk1otyXVSH
 0Kw3B/0cm9pPUWblWpgD4vVtCbfQxkB+arVRZY7rzgDu1NfwVtUS7XzcAKZ9iHnv0bWz39RR3yU
 0DRV6x+16Yq6i8JEdgHUZYXmpRq08c4gCrJ7A+tWIR9LCnAh9o27uqOVuzgNmEfRRc5cBTvJ21V
 Bi89JYhXojX3V065MdXDpQDEUVlNEGVMFwjzMLiDv5BElZS+N9fEcZrmAwl1YgKQgT6Nq77lQXB
 +2QZVm/UCvfuyqfWi/S8UCELG6+ElQw3SFHMPKBrdM/cn7nxeIq4cOSrNzssbn5Kz5xX4KGIIs/
 /Dp6Kov0TwlyExGUacF1puaQE0j3yC7MNWDE5RFlkpQucsZA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The assembler portions of fp-ptrace are passed feature flags by the C code
indicating which architectural features are supported. Currently these use
an entire register for each flag which is wasteful and gets cumbersome as
new flags are added. Switch to using flag bits in a single register to make
things easier to maintain.

No functional change.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-ptrace-asm.S | 32 +++++++++++++-----------
 tools/testing/selftests/arm64/fp/fp-ptrace.c     | 17 ++++++++++---
 tools/testing/selftests/arm64/fp/fp-ptrace.h     | 10 ++++++++
 3 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-ptrace-asm.S b/tools/testing/selftests/arm64/fp/fp-ptrace-asm.S
index 7ad59d92d02b28e4a6b328fde96039329ea8862a..5e7e9c878f2ce797e3ba5f4033a42526830393e6 100644
--- a/tools/testing/selftests/arm64/fp/fp-ptrace-asm.S
+++ b/tools/testing/selftests/arm64/fp/fp-ptrace-asm.S
@@ -15,10 +15,7 @@
 
 // Load and save register values with pauses for ptrace
 //
-// x0 - SVE in use
-// x1 - SME in use
-// x2 - SME2 in use
-// x3 - FA64 supported
+// x0 - HAVE_ flags indicating which features are in use
 
 .globl load_and_save
 load_and_save:
@@ -44,7 +41,7 @@ load_and_save:
 	ldp	q30, q31, [x7, #16 * 30]
 
 	// SME?
-	cbz	x1, check_sve_in
+	tbz	x0, #HAVE_SME_SHIFT, check_sve_in
 
 	adrp	x7, svcr_in
 	ldr	x7, [x7, :lo12:svcr_in]
@@ -64,7 +61,7 @@ load_and_save:
 	bne	1b
 
 	// ZT?
-	cbz	x2, check_sm_in
+	tbz	x0, #HAVE_SME2_SHIFT, check_sm_in
 	adrp	x6, zt_in
 	add	x6, x6, :lo12:zt_in
 	_ldr_zt 6
@@ -72,12 +69,16 @@ load_and_save:
 	// In streaming mode?
 check_sm_in:
 	tbz	x7, #SVCR_SM_SHIFT, check_sve_in
-	mov	x4, x3		// Load FFR if we have FA64
+
+	// Load FFR if we have FA64
+	mov	x4, #0
+	tbz	x0, #HAVE_FA64_SHIFT, load_sve
+	mov	x4, #1
 	b	load_sve
 
 	// SVE?
 check_sve_in:
-	cbz	x0, wait_for_writes
+	tbz	x0, #HAVE_SVE_SHIFT, wait_for_writes
 	mov	x4, #1
 
 load_sve:
@@ -165,8 +166,7 @@ wait_for_writes:
 	stp	q28, q29, [x7, #16 * 28]
 	stp	q30, q31, [x7, #16 * 30]
 
-	// SME?
-	cbz	x1, check_sve_out
+	tbz	x0, #HAVE_SME_SHIFT, check_sve_out
 
 	rdsvl	11, 1
 	adrp	x6, sme_vl_out
@@ -187,7 +187,7 @@ wait_for_writes:
 	bne	1b
 
 	// ZT?
-	cbz	x2, check_sm_out
+	tbz	x0, #HAVE_SME2_SHIFT, check_sm_out
 	adrp	x6, zt_out
 	add	x6, x6, :lo12:zt_out
 	_str_zt 6
@@ -195,12 +195,16 @@ wait_for_writes:
 	// In streaming mode?
 check_sm_out:
 	tbz	x7, #SVCR_SM_SHIFT, check_sve_out
-	mov	x4, x3				// FFR?
+
+	// Do we have FA64 and FFR?
+	mov	x4, #0
+	tbz	x0, #HAVE_FA64_SHIFT, read_sve
+	mov	x4, #1
 	b	read_sve
 
 	// SVE?
 check_sve_out:
-	cbz	x0, wait_for_reads
+	tbz	x0, #HAVE_SVE_SHIFT, wait_for_reads
 	mov	x4, #1
 
 	rdvl	x7, #1
@@ -271,7 +275,7 @@ wait_for_reads:
 	brk #0
 
 	// Ensure we don't leave ourselves in streaming mode
-	cbz	x1, out
+	tbz	x0, #HAVE_SME_SHIFT, out
 	msr	S3_3_C4_C2_2, xzr
 
 out:
diff --git a/tools/testing/selftests/arm64/fp/fp-ptrace.c b/tools/testing/selftests/arm64/fp/fp-ptrace.c
index c7ceafe5f4712b2c93823c1025f3a23ac0594325..d96af27487fa642e94ecc971f53cb78c233e7b44 100644
--- a/tools/testing/selftests/arm64/fp/fp-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/fp-ptrace.c
@@ -82,7 +82,7 @@ uint64_t sve_vl_out;
 uint64_t sme_vl_out;
 uint64_t svcr_in, svcr_expected, svcr_out;
 
-void load_and_save(int sve, int sme, int sme2, int fa64);
+void load_and_save(int flags);
 
 static bool got_alarm;
 
@@ -198,7 +198,7 @@ static int vl_expected(struct test_config *config)
 
 static void run_child(struct test_config *config)
 {
-	int ret;
+	int ret, flags;
 
 	/* Let the parent attach to us */
 	ret = ptrace(PTRACE_TRACEME, 0, 0, 0);
@@ -224,8 +224,17 @@ static void run_child(struct test_config *config)
 	}
 
 	/* Load values and wait for the parent */
-	load_and_save(sve_supported(), sme_supported(),
-		      sme2_supported(), fa64_supported());
+	flags = 0;
+	if (sve_supported())
+		flags |= HAVE_SVE;
+	if (sme_supported())
+		flags |= HAVE_SME;
+	if (sme2_supported())
+		flags |= HAVE_SME2;
+	if (fa64_supported())
+		flags |= HAVE_FA64;
+
+	load_and_save(flags);
 
 	exit(0);
 }
diff --git a/tools/testing/selftests/arm64/fp/fp-ptrace.h b/tools/testing/selftests/arm64/fp/fp-ptrace.h
index db4f2c4d750c5c04e3d257e37a1966296ca74956..36ca627e1980f6a384d9ed0f2e9d4bd32d90f893 100644
--- a/tools/testing/selftests/arm64/fp/fp-ptrace.h
+++ b/tools/testing/selftests/arm64/fp/fp-ptrace.h
@@ -10,4 +10,14 @@
 #define SVCR_SM (1 << SVCR_SM_SHIFT)
 #define SVCR_ZA (1 << SVCR_ZA_SHIFT)
 
+#define HAVE_SVE_SHIFT		0
+#define HAVE_SME_SHIFT		1
+#define HAVE_SME2_SHIFT		2
+#define HAVE_FA64_SHIFT		3
+
+#define HAVE_SVE	(1 << HAVE_SVE_SHIFT)
+#define HAVE_SME	(1 << HAVE_SME_SHIFT)
+#define HAVE_SME2	(1 << HAVE_SME2_SHIFT)
+#define HAVE_FA64	(1 << HAVE_FA64_SHIFT)
+
 #endif

-- 
2.39.5


