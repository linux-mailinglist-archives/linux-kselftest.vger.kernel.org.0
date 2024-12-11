Return-Path: <linux-kselftest+bounces-23173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 844379ECAED
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 12:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0BB169F0A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 11:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C02239BDA;
	Wed, 11 Dec 2024 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkvRaW2Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEA1239BBE;
	Wed, 11 Dec 2024 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733915820; cv=none; b=CgTe93VwI/JGiL972EcyZfwwIXQOU3gps0Uicft3WE6gFOnkBuG+D/fnTCCoNae9cxmEzmwQbG/AClhaX8DHyTl5OHlSw1CZWmpscNRBxKaoZ7+szaxxOA5u8NcULndg3OcSn0sN1XuMXA+APy3isMZbecZZZdyd9NRpphcwT4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733915820; c=relaxed/simple;
	bh=ZkL7qCN+GSAkGyFEuCkVDV2/m53LeTnqD7Bt/7sSoDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ItAWK7c9vvtxxP4Pp/Rs3AuVd0ZoHunF2nJRTB4IyyGEtse0z2XzwWjoSJC31VqwzpNtKsoXlPHFXPwwgxmkCDffXCy9BNOq33MUbkKjmgGPMP0tL3rAObQCyPTkVaZD/ZlzOGWWIsc1+4/R8h6DE8ekjFyRLCUbOSTNEr7sxMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkvRaW2Z; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-728e729562fso1262875b3a.0;
        Wed, 11 Dec 2024 03:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733915818; x=1734520618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wmIZwPmlDItBIvSBStS3M9me7k3FbH6ZwGmimj0cflw=;
        b=dkvRaW2Z25zmfm0AOtMhf+CrG46DNHtATu7yVxkgs0TIMii7ds8zUfEHpSH8GP8Flp
         KmCmQnF6DXlifn8AYe6/wX6Ol7sUgoBVgi6jHXcpsmnmO5WpQjSpIn12gdH1OCWE9SKS
         qVXptL75FE2MGSHAoAjYDNkGIJECj7ApVNyJ2/beENxIhC30AkzGOTv0LvtqOgWVE1tm
         NH1LXqn7gGkyVKGQPbFGmQcqggSkg3VceDSdtIZc5e3GOjDUUMjlpFYr2Vq0BSigcdiA
         H7qZOTfZ2xjPB76cX+e96N2aCeGJwlWueIVNadatPP6tjmo189oPSGF559koL5MsYsKT
         R1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733915818; x=1734520618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmIZwPmlDItBIvSBStS3M9me7k3FbH6ZwGmimj0cflw=;
        b=PBCsA2Z5eUf25tcTP6hE6airAWOlxjURSQ+m9OoXGlEIECSeVi6OyDnaQAoHe99mrC
         CVtcSZsJ2pPhPd/HdGa/BLpITT7jT08AT3sueXNnse70Fh4VPqyC7FpwuxcRvkn46vGs
         LRMr0ZFoCTll5rgi+InjcBeoH04cx6oBXgmQEvpFNxOtanZHpfryJTYzjzXuKVCDrII2
         09N9tNEuM94QtNaJ/XqOhxFR+XHVAdZbHxogZR6nt2ZP6cw+5sRJgSgB/MUpc07I4eV1
         v7SJykqUBr3QF4GmOSVqxqr643taTykLRpOAYMDUebmLzh8SvGDwXVBC2fRdvrxISK4j
         owBw==
X-Forwarded-Encrypted: i=1; AJvYcCViHI91ky/k7YdUfFYTZNgoqXw42OCQFOczzTm7BcxGixFfK3uw2G45XZ8PMONbzIj6NHoLFxLwFscCnO6h3Lee@vger.kernel.org, AJvYcCVjdgGPhjw/XdE4DvKpU1OOUNVF/gt2SSMDhxzRww/kD4nY7K1NAJwixaPkzEiSZuOh3r9W/sGGcXeBqvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVY9RqxhbiWz/F4cg8GmhQrfyhlND+K379UIrYfgEPVDGTGMRC
	R7H+P+JbWn+uBf2R8/yf5FPCUcKFLM57y2sJ7r3gvykB10kg7zZt
X-Gm-Gg: ASbGncuwsxR1ThtrkjkvMMrhtC/UIzymxS6WbOooLSTKNyikZ1n6acaDGv5n/LsRBOM
	T8YcM39VSWClx9IxSbdd01slXAew5AuoKEH4j7pFWgMmWnVLVQme8htqHIKsHfk49Ssmp2K2UD1
	i/7w1VFF1t2LtFWIj103xJEfBA+MDxUxnBaRgePRvksfnUkeTmpXbvlAZ0YGZJ6uTszouhCcXbm
	z5dhhyRPo7DTdF1mECg00l/Kv7wRYLXYaJosiUgEcGqq4tF1hrwxhWSGDaiPCHivWBX
X-Google-Smtp-Source: AGHT+IHSi/8yxD89dgGKzdJcVyw/Qs3K0iIuRyxvcQq/9US7gLCDwtgVLuR8LLk/UjirsvcXRBj2WA==
X-Received: by 2002:a05:6a21:6d95:b0:1e1:ab51:f531 with SMTP id adf61e73a8af0-1e1c12df4f3mr5561010637.22.1733915817578;
        Wed, 11 Dec 2024 03:16:57 -0800 (PST)
Received: from ownia.localdomain ([2400:e3e0:f5a9:dd52:f8f3:1167:a723:6521])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725ce38be98sm7606482b3a.52.2024.12.11.03.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 03:16:57 -0800 (PST)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Weizhao Ouyang <o451686892@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] kselftest/arm64: abi: fix SVCR detection
Date: Wed, 11 Dec 2024 19:16:39 +0800
Message-ID: <20241211111639.12344-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using svcr_in to check ZA and Streaming Mode, we should make sure
that the value in x2 is correct, otherwise it may trigger an Illegal
instruction if FEAT_SVE and !FEAT_SME.

Fixes: 43e3f85523e4 ("kselftest/arm64: Add SME support to syscall ABI test")
Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
 .../selftests/arm64/abi/syscall-abi-asm.S     | 32 +++++++++----------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/syscall-abi-asm.S b/tools/testing/selftests/arm64/abi/syscall-abi-asm.S
index df3230fdac39..66ab2e0bae5f 100644
--- a/tools/testing/selftests/arm64/abi/syscall-abi-asm.S
+++ b/tools/testing/selftests/arm64/abi/syscall-abi-asm.S
@@ -81,32 +81,31 @@ do_syscall:
 	stp	x27, x28, [sp, #96]
 
 	// Set SVCR if we're doing SME
-	cbz	x1, 1f
+	cbz	x1, load_gpr
 	adrp	x2, svcr_in
 	ldr	x2, [x2, :lo12:svcr_in]
 	msr	S3_3_C4_C2_2, x2
-1:
 
 	// Load ZA and ZT0 if enabled - uses x12 as scratch due to SME LDR
-	tbz	x2, #SVCR_ZA_SHIFT, 1f
+	tbz	x2, #SVCR_ZA_SHIFT, load_gpr
 	mov	w12, #0
 	ldr	x2, =za_in
-2:	_ldr_za 12, 2
+1:	_ldr_za 12, 2
 	add	x2, x2, x1
 	add	x12, x12, #1
 	cmp	x1, x12
-	bne	2b
+	bne	1b
 
 	// ZT0
 	mrs	x2, S3_0_C0_C4_5	// ID_AA64SMFR0_EL1
 	ubfx	x2, x2, #ID_AA64SMFR0_EL1_SMEver_SHIFT, \
 			 #ID_AA64SMFR0_EL1_SMEver_WIDTH
-	cbz	x2, 1f
+	cbz	x2, load_gpr
 	adrp	x2, zt_in
 	add	x2, x2, :lo12:zt_in
 	_ldr_zt 2
-1:
 
+load_gpr:
 	// Load GPRs x8-x28, and save our SP/FP for later comparison
 	ldr	x2, =gpr_in
 	add	x2, x2, #64
@@ -125,9 +124,9 @@ do_syscall:
 	str	x30, [x2], #8		// LR
 
 	// Load FPRs if we're not doing neither SVE nor streaming SVE
-	cbnz	x0, 1f
+	cbnz	x0, check_sve_in
 	ldr	x2, =svcr_in
-	tbnz	x2, #SVCR_SM_SHIFT, 1f
+	tbnz	x2, #SVCR_SM_SHIFT, check_sve_in
 
 	ldr	x2, =fpr_in
 	ldp	q0, q1, [x2]
@@ -148,8 +147,8 @@ do_syscall:
 	ldp	q30, q31, [x2, #16 * 30]
 
 	b	2f
-1:
 
+check_sve_in:
 	// Load the SVE registers if we're doing SVE/SME
 
 	ldr	x2, =z_in
@@ -256,32 +255,31 @@ do_syscall:
 	stp	q30, q31, [x2, #16 * 30]
 
 	// Save SVCR if we're doing SME
-	cbz	x1, 1f
+	cbz	x1, check_sve_out
 	mrs	x2, S3_3_C4_C2_2
 	adrp	x3, svcr_out
 	str	x2, [x3, :lo12:svcr_out]
-1:
 
 	// Save ZA if it's enabled - uses x12 as scratch due to SME STR
-	tbz	x2, #SVCR_ZA_SHIFT, 1f
+	tbz	x2, #SVCR_ZA_SHIFT, check_sve_out
 	mov	w12, #0
 	ldr	x2, =za_out
-2:	_str_za 12, 2
+1:	_str_za 12, 2
 	add	x2, x2, x1
 	add	x12, x12, #1
 	cmp	x1, x12
-	bne	2b
+	bne	1b
 
 	// ZT0
 	mrs	x2, S3_0_C0_C4_5	// ID_AA64SMFR0_EL1
 	ubfx	x2, x2, #ID_AA64SMFR0_EL1_SMEver_SHIFT, \
 			#ID_AA64SMFR0_EL1_SMEver_WIDTH
-	cbz	x2, 1f
+	cbz	x2, check_sve_out
 	adrp	x2, zt_out
 	add	x2, x2, :lo12:zt_out
 	_str_zt 2
-1:
 
+check_sve_out:
 	// Save the SVE state if we have some
 	cbz	x0, 1f
 
-- 
2.45.2


