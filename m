Return-Path: <linux-kselftest+bounces-45301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A6DC4D32F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 11:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10AC189D1E7
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 10:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CE635502D;
	Tue, 11 Nov 2025 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kX62CJfs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vdkja6jT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC91354ACB;
	Tue, 11 Nov 2025 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858206; cv=none; b=oXLNEJCTkMLNmuMUEjAGVJ1Fv8XnIaZI8v7zqZid/yMgXH1cEodTXzwo0MFnDnracG4GLJLYa45QZZztCiDhR01CaWMX5S/kJieijnjyfmRUwY2uUisMJTxcGIscmrqeywZnlGZa4Ytu5I7K9cigcnIP1+7TiVMm6Afs+sBVJqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858206; c=relaxed/simple;
	bh=mgBbhqKXIVtDgBpWnLQNQGMfOsIij1eGHRln0s0hly4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bjMmvr4z29tHx0i++nyU3G/RDGpy00X2a2JG9BNUh6rFkC/L6LW7KtN+w+qftb4bprDLKgNbA1ntT083GfcazLkmuSBSvkPUOMSoKBQAFEjePNFLmdaOI1oqg+Lv3uoidFbbRPiq1dPTtpBfNrvjhbZ3w3bK+iw2m8IbGNR6amw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kX62CJfs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vdkja6jT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762858202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sistUqI+ZNMZcEsNWeX14s6eyv+7oxVPQusG72kG8mg=;
	b=kX62CJfsu34b/p1ELlKrVuaLCRDsqj0cf/1o9ndnkd4WUERKUdUwjC9YEiJePnTq01MaS8
	jYjuRW34m638jv9FGL1diWmcgES4mJ9LE2ez2QCq4YL+YXH9ahMSS/jxi588lyb+C2dHY1
	gbUjpqzLXoogfH1WiS4TFoZLqyE6kC23nWemczjEfLWu6tF2QpLkercb4Is/WGsp5wcvzP
	Bqkk5GrhDBLtWZz01JX/gTcszoSDf7JvQOLqU/kW0ygidqJAUCODq17hdoof2Yx/oiXbGu
	fkFF3q0K82L23crkHgnGPfYx8vzWCcOIITkjX3zBtlfo6XyNPLabpA/CGcfdnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762858202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sistUqI+ZNMZcEsNWeX14s6eyv+7oxVPQusG72kG8mg=;
	b=vdkja6jTT93WzFXfEgOaffywrrBGK9186pEZyLOwk24KsUjVuKPPGglUH66EmOUjp4skVw
	42/EC200V9LuN0Dw==
Date: Tue, 11 Nov 2025 11:49:53 +0100
Subject: [PATCH 07/10] selftests: vDSO: vdso_test_correctness: Drop
 SYS_getcpu fallbacks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251111-vdso-test-types-v1-7-03b31f88c659@linutronix.de>
References: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
In-Reply-To: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762858197; l=858;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=mgBbhqKXIVtDgBpWnLQNQGMfOsIij1eGHRln0s0hly4=;
 b=+mz60Gl3j8aCAxam+h0y27sD2AoYMmH2/BdXJEx63i/d4+4aTD+zsi4iUfoO5vZKqueBFaeN6
 iijz2PaVHSJD+YlmkH2GRBR8oWQnBJ4IS2qiM7alGDGwsKeDMaKKr9o
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

These fallbacks are only valid on x86 and unused in the first place.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_correctness.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
index da651cf53c6ca4242085de109c7fc57bd807297c..66cd1d4c19872e78c0e608f5e0fb5215cf902b50 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -25,14 +25,6 @@
 
 static const char **name;
 
-#ifndef SYS_getcpu
-# ifdef __x86_64__
-#  define SYS_getcpu 309
-# else
-#  define SYS_getcpu 318
-# endif
-#endif
-
 #ifndef __NR_clock_gettime64
 #define __NR_clock_gettime64	403
 #endif

-- 
2.51.0


