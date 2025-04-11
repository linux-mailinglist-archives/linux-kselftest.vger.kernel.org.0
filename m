Return-Path: <linux-kselftest+bounces-30551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86426A85750
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085051BC0961
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC8829C35B;
	Fri, 11 Apr 2025 09:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WXbZEC8/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zd42oo+L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C8829B201;
	Fri, 11 Apr 2025 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362116; cv=none; b=D4QsNQULxN4fwgdhMvpkzg+KpNMUhQACgVvkunExSs1pYImITgjgTax8gAXz31cwIabqt8QieTH5g1Kfb8NgNdZVFDe73nIoDNfq/KMnjd81zDK60EJaqHZGFvNPy49jVePEpN+C0k0dbwDFdZo9W7xwXUNJTVnuIGR3B5rwZ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362116; c=relaxed/simple;
	bh=vziCUdNp26ABjp35XwXDT3/Jp4kbGW8VzXFVpyrSY4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bU9CrffFyRzn8xkdst5v1b8jwkgz/3RUfC1UM0dl55SaygYp6AwK8L7yyzfAuvk1KxrLHE0nEac/R0n8Ph1UXjtZy70yN4oBBbkDtEkcmvyB/q1fNiUbeX6S86EC8lfMPz5fuXH0WEB6uAWERi0etGEbo49EtClAHL1xJPeXYzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WXbZEC8/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zd42oo+L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pGXtZX2jgI41oXqZ0O6HteDy6lpCTkO9gddogCmzDs8=;
	b=WXbZEC8/ShQ6z2aCvZCIdIh2Rhv3UVnLYlkRCRZ81lVOJotzqs/DTYU2hf5LFGaDu4A7mO
	DX83wHE40LKHnipoTQzLAvf7ngRVB2NkNLfX7RljB4JE1WtqkDvccpmfIV9DulVXhyUgLu
	bOJhGdMyMx5h/j8ySd9vDprDBgYquFNG3vBsdBrEge5J7Z85FEp1vUc9NoPpBwRbMY624F
	6Saddn8G7G4ENp0IkjVkdCo++jVaAdxiJ3XmpuKQ4Z1wEAgM7Y9eUFYWZeLR7nz0veQqxX
	Ap1hnEY7xJrZgaUQNs+h/3N/zRuwtQ5406JAvQv7J8bpcOlbeIxE43NjfXSa9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pGXtZX2jgI41oXqZ0O6HteDy6lpCTkO9gddogCmzDs8=;
	b=zd42oo+LPjA2hF+sSlimpviSDzKdXP7SU6T3VwfRiIyEZHtgUR5f81ySXNygBIdiQf9+X1
	Mg4NVN45t2mjT/BA==
Date: Fri, 11 Apr 2025 11:00:38 +0200
Subject: [PATCH v3 14/32] tools/nolibc: handle intmax_t/uintmax_t in printf
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-14-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=1971;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=vziCUdNp26ABjp35XwXDT3/Jp4kbGW8VzXFVpyrSY4M=;
 b=PLbqpCC012hKUcWGifHM0QPMDEkkoMaNWpkg74bMxuSu81PMfVS7K+hu5JonzHNQLxg6MCcAE
 6N5w7UyN12gDt0CB7eNUcP9IRwSOWJPtQVOHytym+Ei8WeGduODHtxx
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In nolibc intmax_t and uintmax_t are always the same as
(unsigned) long long/uint64_t as 128bit numbers are not supported.
Even libcs that do support 128bit numbers often fix intmax_t to 64bit
as it is used in ABIs and any change would break those.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
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
index 5884a891c491544050fc35b07322c73a1a9dbaf3..ccf865e80eb715488f4ee5d623b7a02d9dd8abec 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1430,6 +1430,8 @@ static int run_vfprintf(int min, int max)
 		CASE_TEST(char);         EXPECT_VFPRINTF(1, "c", "%c", 'c'); break;
 		CASE_TEST(hex);          EXPECT_VFPRINTF(1, "f", "%x", 0xf); break;
 		CASE_TEST(pointer);      EXPECT_VFPRINTF(3, "0x1", "%p", (void *) 0x1); break;
+		CASE_TEST(uintmax_t);    EXPECT_VFPRINTF(20, "18446744073709551615", "%ju", 0xffffffffffffffffULL); break;
+		CASE_TEST(intmax_t);     EXPECT_VFPRINTF(20, "-9223372036854775807", "%jd", 0x8000000000000001LL); break;
 		CASE_TEST(scanf);        EXPECT_ZR(1, test_scanf()); break;
 		case __LINE__:
 			return ret; /* must be last */

-- 
2.49.0


