Return-Path: <linux-kselftest+bounces-30562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA35A85769
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C5227B6AA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4E82BF3F0;
	Fri, 11 Apr 2025 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HxclRMsm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T2JSuJfq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E42D2BEC27;
	Fri, 11 Apr 2025 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362123; cv=none; b=kcUn32wWsDjzzS2bo/ZumwkAkHBTmtp2xyxDkYr74UcwYxaAs9LIXy0PnErbdgrzvN89dJFE+tMSE5gMG9mx9CpCxHiUfi0RKiT5wJOXQ7rT56r5md8kXr4fREe36mAG2mackZZpG+YArpvGGKSIMPqe6+BXMrI0iHe5iqNVaOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362123; c=relaxed/simple;
	bh=HtVJce/zltJfmoUxHSGByH8pfwgO3OfNF4RtzIB7sOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ecKAn4fPfWTWjgM39EHQQDdPQc0UlkZLQECpA7N//H5BSOn9cUNSDCFbB0KkpA6jZuH2VN4mF7CUWZ41Mnqe1b6AI6vnSV2l3Xn4dS35JZN7VO94e7Mwv3L1lorRDhOg9TZj/1QXZ2Z1X2NGip6jn5/8zLAXtfP8ODsWnA9JjqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HxclRMsm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T2JSuJfq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvBGqGX78XvKEVW6i13ta4x/bQjOWTVre+e55nvMR/A=;
	b=HxclRMsmdO2PwC6Ss8eIbcBNKZveR3YAh+oPIaFiMYcWi62VLqjF2OmXltBhWvj0wjhx0h
	HKmIvWPaGBDJXkSemzlnZGF6xV9TDbMf1unbFxCNQNicYk8EV+8bz6FSDLf/3EI8hplnS5
	U2CDGbA9EH4Vr+0bYkLGfPTRLnx2UzALjVD0ftw0AlrdntGnW7OO6/Pj48UWDcqadHOH8n
	wdwW3+zYsESVuX7+6bnBp0NntuheYwtN9995LUwBgtbt1OffPknp/npOruDfCOHqRbdocg
	Gc2BdzTiiFv8ILTcRntnB9FSRqves7RASb1exsWcIK+70IPayfA87GDTdvv1Dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvBGqGX78XvKEVW6i13ta4x/bQjOWTVre+e55nvMR/A=;
	b=T2JSuJfqPkOs+Eob1PFvZJb1Zjk0iIOF+xWnZB4i8lu9zhaRXdHyWqGmtU5qemplA2UTQ8
	eOmPl3SmzoA2n6CA==
Date: Fri, 11 Apr 2025 11:00:50 +0200
Subject: [PATCH v3 26/32] tools/nolibc: allow limiting of printf
 destination size
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-26-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=2100;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=HtVJce/zltJfmoUxHSGByH8pfwgO3OfNF4RtzIB7sOk=;
 b=X++XRbGT3Ihlo34Xl+EkOikRbEDLjhE3kwPUwM9/2x+3aLY7KpDjwJ5Z3c44OIw1MFJrfZDrs
 nDdl9F38r2dC44Yz/EFNwr2vcoZ56JWZIgBNeOSxdNIWELVavuh+VNY
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

snprintf() allows limiting the output buffer, while still returning the
number of all bytes that would have been written.
Implement the limitation logic in preparation for snprintf().

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdio.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 5c893b4903a3040a366e11b600ccde30913d7db2..b17b473bd8751a6283309178b4848e61e1683305 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -215,13 +215,13 @@ char *fgets(char *s, int size, FILE *stream)
  */
 typedef int (*__nolibc_printf_cb)(intptr_t state, const char *buf, size_t size);
 
-static __attribute__((unused, format(printf, 3, 0)))
-int __nolibc_printf(__nolibc_printf_cb cb, intptr_t state, const char *fmt, va_list args)
+static __attribute__((unused, format(printf, 4, 0)))
+int __nolibc_printf(__nolibc_printf_cb cb, intptr_t state, size_t n, const char *fmt, va_list args)
 {
 	char escape, lpref, c;
 	unsigned long long v;
 	unsigned int written;
-	size_t len, ofs;
+	size_t len, ofs, w;
 	char tmpbuf[21];
 	const char *outstr;
 
@@ -306,8 +306,12 @@ int __nolibc_printf(__nolibc_printf_cb cb, intptr_t state, const char *fmt, va_l
 			outstr = fmt;
 			len = ofs - 1;
 		flush_str:
-			if (cb(state, outstr, len) != 0)
-				break;
+			if (n) {
+				w = len < n ? len : n;
+				n -= w;
+				if (cb(state, outstr, w) != 0)
+					break;
+			}
 
 			written += len;
 		do_escape:
@@ -331,7 +335,7 @@ static int __nolibc_fprintf_cb(intptr_t state, const char *buf, size_t size)
 static __attribute__((unused, format(printf, 2, 0)))
 int vfprintf(FILE *stream, const char *fmt, va_list args)
 {
-	return __nolibc_printf(__nolibc_fprintf_cb, (intptr_t)stream, fmt, args);
+	return __nolibc_printf(__nolibc_fprintf_cb, (intptr_t)stream, SIZE_MAX, fmt, args);
 }
 
 static __attribute__((unused, format(printf, 1, 0)))

-- 
2.49.0


