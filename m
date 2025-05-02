Return-Path: <linux-kselftest+bounces-32185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C5EAA7247
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0BF4C3795
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D6C254B11;
	Fri,  2 May 2025 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b0Sh8LE1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X0GcpFz8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76261252904;
	Fri,  2 May 2025 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746189626; cv=none; b=uG4hmbGxIXgrGMyfv4HRfzPAJ57J6/ReA4mNPsSYHd8+dgj8kRJyNQx+1oJO3SIM6ciPaFAMke58uEhEOaBojxWuEVS+anYg5MEIkBEYMeh005CJ7a0vUp7tkqmuGrflnyfrQSdqv0uHQbJlqONebM2F/9YDvy2+9Ye8OQuOc84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746189626; c=relaxed/simple;
	bh=a2u6ldDIJJRlQc6S4JF37e3cdZ/6pGHUGAoaL6wXdkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UfyeJfDKBdnJJ++/rYtM7ADehK0P9z29M7JG6Rkgp7up9GCdI/GpglfYuKYHmrcxL8xr9mzUR0egAuvB96+dLAmPzlu1EsKso5XZk2b+3FHD7mGDpt1tm13ASKmSCh+TONHbQDn6dDBjrFgRRry+07Yv4yxVQ92UsoDz0Z26bRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b0Sh8LE1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X0GcpFz8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746189622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PYL8XT5C/K0QuW45nIsP/rM0RYTKpeNtOsJCvPm97s8=;
	b=b0Sh8LE1IHZIRmo1PJ+ZNzozjo96z2Tt40vuupx1OWfc6Y6+mPbB76ws3XaiHu5XWRfLkp
	TMO/Pe5XXqEXnRyx3tHYhzkXvhzwv1GfL16CAbtjWkp53FEYMumW8ZGmvYWW0pHOHExcCJ
	l6txCoeDh0i0CHor+60HH4ucAdHD65RdD/oYNtpRu/qL/xYFPv8jSpoLIXq0fHq2tvANIo
	ebaLKuJ6bleFe76u/vL8t1LD8ECy1L/Hafy8ELiu2qcj2ub9kN7d25MqT5WP01HNvOSLJl
	9EvTm1UNyP2+vmSDO1wOsJkRoxjBRyRLPuTtHkHfYY+6b+7RViRht/GgUGU0eQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746189622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PYL8XT5C/K0QuW45nIsP/rM0RYTKpeNtOsJCvPm97s8=;
	b=X0GcpFz8pQpvys9MXgT5eSrVVREMPbbUa5EpPkgQDSwHK1I8kdSyPMwFE8Z/j7qcKTx42g
	TdocPtctGkkaIuDw==
Date: Fri, 02 May 2025 14:40:13 +0200
Subject: [PATCH 1/7] selftests: vDSO: chacha: Correctly skip test if
 necessary
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250502-selftests-vdso-fixes-v1-1-fb5d640a4f78@linutronix.de>
References: <20250502-selftests-vdso-fixes-v1-0-fb5d640a4f78@linutronix.de>
In-Reply-To: <20250502-selftests-vdso-fixes-v1-0-fb5d640a4f78@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746189620; l=1633;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=a2u6ldDIJJRlQc6S4JF37e3cdZ/6pGHUGAoaL6wXdkM=;
 b=Qw4LjFn9DgHq6+hWN7uakM5REj+wGSp+NDGGnTBMIUfWPvc5Lhy/br8y7MyEdWblPm8Q4ZnDe
 tlz83AKlmUOARCJJi4jNP9ZNb81ryxVjFP8p+JRVbNGld4cOLUavDlh
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

According to kselftest.h ksft_exit_skip() is not meant to be called when
a plan has already been printed.

Use the recommended function ksft_test_result_skip().

This fixes a bug, where the TAP output would be invalid when skipping:

	TAP version 13
	1..1
	ok 2 # SKIP Not implemented on architecture

The SKIP line should start with "ok 1" as the plan only contains one test.

Fixes: 3b5992eaf730 ("selftests: vDSO: unconditionally build chacha test")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

---
I'm not sure if this is not a general bug in ksft_exit_skip().
First ksft_xskip is incremented then read back through ksft_test_num() and
then that result is incremented again.

In any case, using the correct function is better.
---
 tools/testing/selftests/vDSO/vdso_test_chacha.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_chacha.c b/tools/testing/selftests/vDSO/vdso_test_chacha.c
index 8757f738b0b1a76a48c83c5e5df79925a30c1bc7..0aad682b12c8836efabb49a65a47cf87466891a3 100644
--- a/tools/testing/selftests/vDSO/vdso_test_chacha.c
+++ b/tools/testing/selftests/vDSO/vdso_test_chacha.c
@@ -76,7 +76,8 @@ static void reference_chacha20_blocks(uint8_t *dst_bytes, const uint32_t *key, u
 
 void __weak __arch_chacha20_blocks_nostack(uint8_t *dst_bytes, const uint32_t *key, uint32_t *counter, size_t nblocks)
 {
-	ksft_exit_skip("Not implemented on architecture\n");
+	ksft_test_result_skip("Not implemented on architecture\n");
+	ksft_finished();
 }
 
 int main(int argc, char *argv[])

-- 
2.49.0


