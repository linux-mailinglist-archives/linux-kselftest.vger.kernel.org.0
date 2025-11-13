Return-Path: <linux-kselftest+bounces-45559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E768C58829
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 16:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 80EB135620D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 15:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB761357700;
	Thu, 13 Nov 2025 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eVbTXIZA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="crLKsI8a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE863563D8;
	Thu, 13 Nov 2025 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047876; cv=none; b=V1W2J1LVK6vRTDu9tkvwqqq2ancVz5ZJfDMdxqk1iRDJltl28JmJZDceYFUbRT8efc0jBVZXAQP0vmLs7eSPFnbEbZBTNyX2WFzPYhs/umgvgjF5zUTilAl/kIT73PGdqvbJxWCARbOzkjX3TveOqSixxlseTaxjqX2NIi0YMkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047876; c=relaxed/simple;
	bh=mgBbhqKXIVtDgBpWnLQNQGMfOsIij1eGHRln0s0hly4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uFjfb14Jm9rD1igC0ddKa3GiJVvoM1ZnqUayWMWZ5pV2Zj+BD3DlMdKSXSapdHrdb5CJteR30LqU+AQuuD2oRBwi6VDw/EkBmZTW0bWQZVfOr3HjsC2GPeIxxjhgKoMngEn2TiAJ+yZjvNh/58IDKqvEq70svj1EAFxlQRzX/kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eVbTXIZA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=crLKsI8a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763047873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sistUqI+ZNMZcEsNWeX14s6eyv+7oxVPQusG72kG8mg=;
	b=eVbTXIZA6Eio0HCEoTMPZ7vqAVCaunDnZfiA0iqoo9DB4UQeQo/CWIC9I9thEwGX3snjgI
	hW1KIp/5zXu6Jt0kjRJoAWGoXaga2NcjysA8pjuLNLHSFzS3aL8cQLPDMVu3aQFgrauTjh
	kv78qdo0grLeBalNw7r6c1fOBddRQNsSsBRT+4B6+VsZqmpRAPd0CpGfu2IFxLb9vs+4m9
	F4JotsCjchKpGF0JHD4MnMRSB7wV8XlWDMYwFT8pIzCYVdMKbBoAroCGEkhxWfJqGB5WUJ
	hs7MdEJuPhqpSp8VJrnk7+4xFc70G6uK97hl84eC1Ct7ogZQoTXwIXTP7CtbkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763047873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sistUqI+ZNMZcEsNWeX14s6eyv+7oxVPQusG72kG8mg=;
	b=crLKsI8alXLU9TCgt51PCfeh1WaKZmM9BErit0gg4iibG6yUM13F9I7eEZnnX7eNGQJycH
	MfvPMT3j9EyFUZAw==
Date: Thu, 13 Nov 2025 16:30:25 +0100
Subject: [PATCH v2 09/14] selftests: vDSO: vdso_test_correctness: Drop
 SYS_getcpu fallbacks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251113-vdso-test-types-v2-9-0427eff70d08@linutronix.de>
References: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
In-Reply-To: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763047863; l=858;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=mgBbhqKXIVtDgBpWnLQNQGMfOsIij1eGHRln0s0hly4=;
 b=w0+FcXUkyU/yo3cDZBtV91GtB+2iil2GEo/ayiXAbPTNnnSj8iFZ2azle1Js87gyNUVWYhz5S
 XAY3z94IhvqD7r4QDk0wTElINjr+o/5EJTb2AmULuR9uyWWeGgPGuMK
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


