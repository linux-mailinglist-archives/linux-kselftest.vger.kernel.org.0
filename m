Return-Path: <linux-kselftest+bounces-28177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94205A4D48F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E83C18988F2
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17511FF5EA;
	Tue,  4 Mar 2025 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wOTfJARl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/8d+Fybs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6A61FE47D;
	Tue,  4 Mar 2025 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072287; cv=none; b=THHx3kap+h01UNBQbbUo1UTVQke9O2Xt4jX6AmVPsjJWxhlLjCRSRUzQa3uJecfLnD8rXxRqUpqw9CWNknXnzAN0L4SNNkIYj4zhiMvn2QDLI86a+aHXmoXi9ngdaSI/imike54LBV1Y2e4fNd81RltToe4rPePKcAJeq1nwO64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072287; c=relaxed/simple;
	bh=lqlncDo1UCxd5Qb+0OWEvVEY/WGNcq650GyEc6hW+zw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b1jnr41aowgB+Ab5Q3CxGNOuHUhKTMjT7G0Us+ra/+wLzZieVcwsKejcRuhboOC1DrPCQhFLUxUeXF0NzhFQ1LA1hmjSfuflZmo8yT9bnxfsWYnJ4tc70k6d2pjyobwoPbSRKq7haUAx08s/jtwcoHN3QZDv64+Aurdf6MGiPfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wOTfJARl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/8d+Fybs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9keINKbLYtSgKZkTaGHpd26ZQfIBYzWs7KdJylwBu3Q=;
	b=wOTfJARlFblqJUNgUSrXISsh52ee2xDvchXLRQ9eCE/0b8bn7ED2BRDIkETxVoAtyOopMV
	HqbXUnX904jygmrfs17X3KiwTK54wM+LDIifjzYjhuMef7DkLPsKn/dRQ4+MM5lpnB5DZ+
	vqmXURM+Bda9bak5iFbeYNe4ZSAdyY8Tm5QwwigYC4lODd87YqmV8uVhwBXaW29Pi73LMA
	EG+d5NuXSW6w2uhDOA/YAzdRiFqSku6s7/UyrpDd6X+2eq/xznHSu03SF3LYpTKefUyxUd
	8sZr/VH5rR4i8ikKNKCeKh3hI5yNxTvlOlueHBFPEAzCWQtFV9/XdKQisOUGEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9keINKbLYtSgKZkTaGHpd26ZQfIBYzWs7KdJylwBu3Q=;
	b=/8d+FybsM9Ik5LZlA19OTBlgK/N+NT7JuUAoyZWK9+TwwSzrRd9lRr7hSYN8NAoiOqbgiw
	VGctFv+eONjHFEBQ==
Date: Tue, 04 Mar 2025 08:11:00 +0100
Subject: [PATCH 30/32] selftests/nolibc: add test for snprintf() truncation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-30-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=1516;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=lqlncDo1UCxd5Qb+0OWEvVEY/WGNcq650GyEc6hW+zw=;
 b=fXlq3eRMc/xgbn6BxLxO00FbysIYO7xKjAZGH1130AoFqlBXr4W6Sh6YQO2L8MnEEkL1l2AGA
 M1n2JOonOnGB58KKCvgb+9SK39WcybEJQL6njmcMg2tZNWs6pVEcyBw
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Now that we have a proper snprintf() implementation,
make sure truncation is handled properly.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index a45fded42c14110c97c4c899d04dba8e676dfd49..0a891c40e2afbb398ae39b43dbe977efdab042e2 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1290,7 +1290,8 @@ static int expect_vfprintf(int llen, int c, const char *expected, const char *fm
 
 
 	va_start(args, fmt);
-	w = vsnprintf(buf, sizeof(buf), fmt, args);
+	/* Only allow writing 21 bytes, to test truncation */
+	w = vsnprintf(buf, 21, fmt, args);
 	va_end(args);
 
 	if (w != c) {
@@ -1396,6 +1397,7 @@ static int run_printf(int min, int max)
 		CASE_TEST(pointer);      EXPECT_VFPRINTF(3, "0x1", "%p", (void *) 0x1); break;
 		CASE_TEST(uintmax_t);    EXPECT_VFPRINTF(20, "18446744073709551615", "%ju", 0xffffffffffffffffULL); break;
 		CASE_TEST(intmax_t);     EXPECT_VFPRINTF(20, "-9223372036854775807", "%jd", 0x8000000000000001LL); break;
+		CASE_TEST(truncation);   EXPECT_VFPRINTF(25, "01234567890123456789", "%s", "0123456789012345678901234"); break;
 		CASE_TEST(scanf);        EXPECT_ZR(1, test_scanf()); break;
 		case __LINE__:
 			return ret; /* must be last */

-- 
2.48.1


