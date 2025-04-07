Return-Path: <linux-kselftest+bounces-30216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3C1A7D4D3
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 09:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823173B0A8C
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D1622E3E8;
	Mon,  7 Apr 2025 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k6IaNKBM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/7BeNvxC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A5E22D7B9;
	Mon,  7 Apr 2025 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008800; cv=none; b=uoSDH2gKB3DmWc5vlAamwtUps/hhHi6X+GskngAWuQ2saCWSSH4n/lUt/pxjt41fwlxxHVFW7qLf1jhfGtveVxIiDE/kZfIiW/DHqyES7ToSHWcNrVjlymsgYwMcMKU/mTojwQAZcLR1dRSOa1N6s1XtTiOuTouPlT/kinovEb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008800; c=relaxed/simple;
	bh=8gx2j4OH7y+ey3+O8eHa4G2jocjuirJqpQ8j8E98oto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MxMJgogTI+TwmhjVxTwAJej/E5RGJGXNJQjcA2V5zpkenaVvhkkFQ1ddl3GxE58DikR+7hj/PZVZTT0mWc9sRmEinvrjluauSAOGVyp9AKdaLQX7r2OGSHjn8Hhp2N3wz15w0Iy5BJwC2T/kE4OyAJOyWPrZimNUbC/xCxWJncE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k6IaNKBM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/7BeNvxC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tGncphnL/iwYpyKH8kWhkIbaBWNrCOh1asPqEQP8sdM=;
	b=k6IaNKBMjL8R82hCIbmOKz2Z54NT6rH6WZMazn/Njx/FYvUpHmVZlUXGMGFUPgNSayQ5lU
	8W/HRKBgpzuU9aPWEDijEXKmRBeL+JdMyA1Zc206ZNM31w8vRyQISWaFC3uJTsFb+65g/R
	UoajDcyZpQG5w7u8wQmIFyfzt3EZ6T1JiipYsK4VXWS4yT4rcN1/0IGM6k78+wt825NLmh
	tzZLzNvy+acB75eVyTlT006seJCvYcQv5eYDB+MtGbuCoiBUn1/lv7+iQ9oCQ+b5elXL0N
	hNn2pLX7As9oV8zBkO6EV8odtSXqfDqVCfmFpJ0XJFX8z94RF+qDFpY0oeIocg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tGncphnL/iwYpyKH8kWhkIbaBWNrCOh1asPqEQP8sdM=;
	b=/7BeNvxCd+2GBts2slRFBZ+gX7MSP8fHsKeDu9dkIJ/kALR2DyEGuWJMsP9hIpxjelws50
	DrpPRU5b2FwmSBCQ==
Date: Mon, 07 Apr 2025 08:52:53 +0200
Subject: [PATCH v2 30/32] selftests/nolibc: add test for snprintf()
 truncation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-30-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=1552;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=8gx2j4OH7y+ey3+O8eHa4G2jocjuirJqpQ8j8E98oto=;
 b=BhC7h+puBd4O9DmWI8gn+gRsb3fFR4Thhp6iWt+25q3//CLAwF5mxhioFtd2wZjVxnsWdje2X
 MPTX7bEuAYoDo/mXkYN4DgF6Wx3imMzkyHdZUs6sH+VEG6HEZ1ASbi3
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Now that we have a proper snprintf() implementation,
make sure truncation is handled properly.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 6dfa94df37547dae46ab19195a763fe22b065bab..9bd0a9c68b903cbd660ff81d4b0386b0b7c13977 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1307,7 +1307,8 @@ static int expect_vfprintf(int llen, int c, const char *expected, const char *fm
 
 
 	va_start(args, fmt);
-	w = vsnprintf(buf, sizeof(buf), fmt, args);
+	/* Only allow writing 21 bytes, to test truncation */
+	w = vsnprintf(buf, 21, fmt, args);
 	va_end(args);
 
 	if (w != c) {
@@ -1413,6 +1414,7 @@ static int run_printf(int min, int max)
 		CASE_TEST(pointer);      EXPECT_VFPRINTF(3, "0x1", "%p", (void *) 0x1); break;
 		CASE_TEST(uintmax_t);    EXPECT_VFPRINTF(20, "18446744073709551615", "%ju", 0xffffffffffffffffULL); break;
 		CASE_TEST(intmax_t);     EXPECT_VFPRINTF(20, "-9223372036854775807", "%jd", 0x8000000000000001LL); break;
+		CASE_TEST(truncation);   EXPECT_VFPRINTF(25, "01234567890123456789", "%s", "0123456789012345678901234"); break;
 		CASE_TEST(scanf);        EXPECT_ZR(1, test_scanf()); break;
 		case __LINE__:
 			return ret; /* must be last */

-- 
2.49.0


