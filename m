Return-Path: <linux-kselftest+bounces-28160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2EAA4D466
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969A11743B0
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FBF1FBEAB;
	Tue,  4 Mar 2025 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="flSvlKvF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vlDGanWH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9F81F666B;
	Tue,  4 Mar 2025 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072278; cv=none; b=r+Ag8D8Y4lPiNAM/4Ml9gSJspUnOg8q5r8NaFP1W7LwfgTurBqNC5Q9XUGexTVQiJvVrxGCXsg0xdTnHbfSSUJ44nrKRIegt25qTBTJkgvJIrTiROmOUsZgysqRN4qna1tTazj56T7iW6cOm8te8GHJ6sOsqQt1auKKvN8hHVIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072278; c=relaxed/simple;
	bh=+dzAuZVK+VzJKxIjHbNQIUNM9fWsQFyNHmkWJWjVcG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=smaSEZ3VMpY09cLDkttMfnDsKBlG6yrbc/rqRNE8VpFeEnrDS1BijblX3I6G1unCrLiHNts0xxoMjBfFnPGThOCtti4JkxslHLLdCblX7GXmCfYTsOdJycrTgFVYOgtF3f+tQRVBwPRLQp4II1mjm1fSZngEqJS4oP7bvCa5mAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=flSvlKvF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vlDGanWH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqHKi52hOjmf3plu80jTBfK3V8V/okONTq6fBQbc2Sc=;
	b=flSvlKvFCDm7hnFHiMu4uDvdSAjjhGxD+yotmL5HLUfLhrWVMWyu4Bda6+65JgAR7bFwDF
	snhCuOXHV5E1v79tYVtlCwEBk61m1D4Vqgk8Xj4kuwk9G3Keu+ahiUrOrRyFD7o8BFw0Sm
	ZUe/AtxJOHGzNtYFXL9DfdNDmfM+1/3N9lm0mPgqW9yewXSUNHv1/AaoNUyEJdB4dA7qMH
	+cTtoY0r140U58HQu/GJUJ85EL4bZTe8286GXs5LLSsJCl9HGHFy0FeybPkAfwRb1a/K1m
	ejqolMXl92v9gu/vOhmkxLS8whc3hP2oWnsX+XeKfZHP7y+Gn7UNVnBDFYPWJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqHKi52hOjmf3plu80jTBfK3V8V/okONTq6fBQbc2Sc=;
	b=vlDGanWHXrji+AIKQSqXn4N7u4Bm55pBr5QL3b1HQEi5bKD3whFxGwiyhiK6kCt0ZUbmkw
	S+02Vh3vwESd4GCg==
Date: Tue, 04 Mar 2025 08:10:44 +0100
Subject: [PATCH 14/32] tools/nolibc: handle intmax_t/uintmax_t in printf
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-14-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=1935;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=+dzAuZVK+VzJKxIjHbNQIUNM9fWsQFyNHmkWJWjVcG8=;
 b=qSFsexj3sENxtU0/wrLTSksMAJZdHBZ0MExid4XCLn0FBLvM0vO+c3yjVGb0b9kuXnSxDdYPj
 Eoto50NPAbFDLezOwqKQFErYFANPMLq70lGqRYgbq5C6XudG8BEDY0A
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In nolibc intmax_t and uintmax_t are always the same as
(unsigned) long long/uint64_t as 128bit numbers are not supported.
Even libcs that do support 128bit numbers often fix intmax_t to 64bit
as it is used in ABIs and any change would break those.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/stdio.h                 | 2 ++
 tools/testing/selftests/nolibc/nolibc-test.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index a403351dbf6098ac8292b9589ed8a054b4c5669f..b32b8b794015276ab6242c2be18f860c095f90a3 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -286,6 +286,8 @@ int vfprintf(FILE *stream, const char *fmt, va_list args)
 				if (c == 'l') {
 					/* long format prefix, maintain the escape */
 					lpref++;
+				} else if (c == 'j') {
+					lpref = 2;
 				}
 				escape = 1;
 				goto do_escape;
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 79c3e6a845f31443c768de4c1f106e5ae014358b..3c0431e9917acf57e94dc3f7a8347762e6a5335a 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1413,6 +1413,8 @@ static int run_vfprintf(int min, int max)
 		CASE_TEST(char);         EXPECT_VFPRINTF(1, "c", "%c", 'c'); break;
 		CASE_TEST(hex);          EXPECT_VFPRINTF(1, "f", "%x", 0xf); break;
 		CASE_TEST(pointer);      EXPECT_VFPRINTF(3, "0x1", "%p", (void *) 0x1); break;
+		CASE_TEST(uintmax_t);    EXPECT_VFPRINTF(20, "18446744073709551615", "%ju", 0xffffffffffffffffULL); break;
+		CASE_TEST(intmax_t);     EXPECT_VFPRINTF(20, "-9223372036854775807", "%jd", 0x8000000000000001LL); break;
 		CASE_TEST(scanf);        EXPECT_ZR(1, test_scanf()); break;
 		case __LINE__:
 			return ret; /* must be last */

-- 
2.48.1


