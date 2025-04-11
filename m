Return-Path: <linux-kselftest+bounces-30543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB49EA85740
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35F04A1A01
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6C129AAEC;
	Fri, 11 Apr 2025 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oAiz2VPK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UutyLoWG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E419D298CB1;
	Fri, 11 Apr 2025 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362113; cv=none; b=M9gpdQVlDkwb2WtpTk3cr2HRmXgWn2yoKxn8jXndRRrHjvo6GUPvkdXUTC2cX1zv4sjikHQ60LqhxruVrkH4zhhBea9bQ74DcL7bv5K0BMHIfS1UgOr73Ax3ctOwASRdN5/rN7CCJo5++teNTCwMVLWLFvBpIJMu4LDh7NgEo44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362113; c=relaxed/simple;
	bh=DYq0rbz3jmlhEduwTAuGV0UE7Ds8U5rzr+9vob1udYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ub9hx3EEhSqjZtbAV7WkU8wQ+0/8lF5yqW7/3kgZlZ9f4YoVoYZDDokZ+DH3lMAZn5SGJjKSPEQgcrsvp+eXZ4tXqlMfh4Msl+11FNCrKeqWU5Aq1mf2tUF/seJCjTt6FRsYeRrR3H0obVZLxpMavoV2LV1vDozKcVVIkkegNpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oAiz2VPK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UutyLoWG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qg3M61XE6rp6LYbeiMFWtQMLhXgLKx330vGb2tHj74s=;
	b=oAiz2VPKoqCFjua9EstODh5uRBB5JT26EhynUkw9u7JAKlEkjZJZaghTM1eu7M4ev8BW57
	PJnF6M+D5ailDgO6KBJTTIY+m/lYAIgSQr33nxc6HY+AJwCmExSAqiOLIyIYkNM5eIw5i3
	+jGwX9/ccb8TlxCV/4raY7/kB1cZ7Z9ZXJLuaf5Hz44xi7vLWtCDl8ByU253jwURDo6wg9
	O2p6dBeZJ5pEJ/dPwY6FikE6cdYUL2kmVaowEZlam7ait9rnkVylZz2UfqfN/DW3aI2Hro
	0TZYX67jv9+8UtJfRPzUjKthlEMSE7HPeYD3nY5X/sQgl8MGxpYJwc+6YlX1eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qg3M61XE6rp6LYbeiMFWtQMLhXgLKx330vGb2tHj74s=;
	b=UutyLoWGsjZcKBhKKomWvMPg60WTrDaEduT63KQ1ldU1th/uKZQv+qfeOABX4n1DZGs0Z6
	ahUkxUHY4leYt6Bw==
Date: Fri, 11 Apr 2025 11:00:32 +0200
Subject: [PATCH v3 08/32] selftests: harness: Don't set setup_completed for
 fixtureless tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-8-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=862;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=DYq0rbz3jmlhEduwTAuGV0UE7Ds8U5rzr+9vob1udYk=;
 b=lgB9Bn/YJBOTVV8FuM39D8RkAbpRERD7AErOPC+EY3mT/WH18iIZ3NfOua/Ndi9lQX9rnt2Yq
 XGM/4Pg5GCdBYxAC9bMISl5RTD4IU1djOEAtFEORi9zmRfVaH7//00u
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This field is unused and has no meaning for tests without fixtures.
Don't set it for them.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/kselftest_harness.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 1e459619fe8657d7d213a7b16d7bcbc58e76e892..905986debbfb0ce8c9659dbd52b6c67c6759cae7 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -178,7 +178,6 @@
 		struct __test_metadata *_metadata, \
 		struct __fixture_variant_metadata __attribute__((unused)) *variant) \
 	{ \
-		_metadata->setup_completed = true; \
 		if (setjmp(_metadata->env) == 0) \
 			test_name(_metadata); \
 		__test_check_assert(_metadata); \

-- 
2.49.0


