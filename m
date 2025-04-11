Return-Path: <linux-kselftest+bounces-30567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002ABA85770
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14FB93B650C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F442D1F69;
	Fri, 11 Apr 2025 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d+Mnz3H5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vDQJRCHY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513062C3766;
	Fri, 11 Apr 2025 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362125; cv=none; b=UiROqwrpO4CbG5YpBF15tT8kFnTNZaDCqS1O7fIaXxQPMXYLi7dxZ8XkpIXlC48pN4hR1VoHW1xpivWVsDSmIMA6kY0oHroxySDTQPQCgU4t0VZAY0IxCgu94WJQQyxwXI7dR+PgDtqJ7g1I2PU79c4WQAqXnrKbsSn/Ao9UK8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362125; c=relaxed/simple;
	bh=8gx2j4OH7y+ey3+O8eHa4G2jocjuirJqpQ8j8E98oto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=buLXMBYRBHuN2aYiApy2QBAVSGxcWjGQgWcgR0QduRXtPPjcivPtGRfOEdEwOU7dtV2QzYt3mz8wXZNpBX128Y1v2/iuKNdJsI6GyDdSA3dchPdYs492MYCPnco6kbBdffD/KFbQqLy6tAZN0u9GIghY2jGlhwxmGbGSGm4LvEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d+Mnz3H5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vDQJRCHY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tGncphnL/iwYpyKH8kWhkIbaBWNrCOh1asPqEQP8sdM=;
	b=d+Mnz3H5mWnAz+lXedwf2qFKsa6zZ0dz2H6e4l6kMEMXzY2sswM1yrYpvUvNf09e2JRN/i
	He5/WyYUS7xOXqbE8erB9YK/jfXwmtewLf9ib3dvhsPveSWsgWR9SZPlngRddteBVIDZVL
	kEsmTYeDeQpcXpwmSkV29QhliezXEFYjMP4MZKIGt2TR8LIpADKlokifqytqadJDF3tp5V
	bcVq9dM5Ni5nVqxIfpjPQ0AE0+APfO2zxD+ZXJJsibvYI2e8nSPjxNocAayMiz2Uu9umqk
	Fgo8rG++IhK5/Ro95Jaob9Txt/0320kGa2R8VClDcUmmXfMIE2OwNIcsZHo09w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tGncphnL/iwYpyKH8kWhkIbaBWNrCOh1asPqEQP8sdM=;
	b=vDQJRCHY3ADikZq0+Nlg137YaXR9Uu1NFR2qwMO/e0DIqarmwBob8D0j2Closf/nw7GSfE
	0WJ1UPoMZUeqlsDw==
Date: Fri, 11 Apr 2025 11:00:54 +0200
Subject: [PATCH v3 30/32] selftests/nolibc: add test for snprintf()
 truncation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-30-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=1552;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=8gx2j4OH7y+ey3+O8eHa4G2jocjuirJqpQ8j8E98oto=;
 b=W4PT4hcs+ounZRtN8/fdcsRsqxiBBR+4Sd7+Hdn9BFHblOajV5LCF8VHl0Fl/a5vLr2kMSOCd
 F9dkI34IkBDBQvq7aAOK4EWBIeic6rocoZnDvwl0Lh3Th5nZaFNs0qJ
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


