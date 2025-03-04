Return-Path: <linux-kselftest+bounces-28173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF4FA4D484
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BFCD188B747
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BA21F63C3;
	Tue,  4 Mar 2025 07:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VkN/Ntmu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OWj9fEX+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCC11FCD18;
	Tue,  4 Mar 2025 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072285; cv=none; b=ks/vVUOxu9vQCgGxXVVHOdA4ORGPdpcXExLpsYJWbjurERj+7DG5Y8jWP70pFQyuTxgflhGej2Se4ROyvN/7QYeRDjUJnpFcdKOZKrv1wUZulfaQXjPd92bEZKHv/+P3pv+PRY8Qty/8rViYzzzKl222LHfiZCrgaNubhGLO9cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072285; c=relaxed/simple;
	bh=gptYJeI7zIa0m6z25MFDa2zENatJrEBZvF+Qu777d3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mh2YJ4ge4Qz39t0AfNVqrnLnxkQztIAVyISE7XqcjUYlEun7TEUqjFzkDrWWcyToCKBMleTOz6AIE19Zl0u/12OO2EA/YX2CZ/4GyzUdG9qeWKku214EfiN2V3lFEfprDU/NVMjWcmOzIGICIAxCNnvhjp3bQdHQloFzWWl8VB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VkN/Ntmu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OWj9fEX+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLxRp/JkTIfoLlcPQDYEqa9/SCMFJG4UakDwlT6QSyY=;
	b=VkN/NtmugUrtHpSW0xxVfNQcwkWD3L89WDe1fXIdapPzA+WlhNau6GxJ/mTnbYzd5U8uWi
	ooK84bZ10pXC7PTPz2Vd3dBE325ewM/GWaTmRNC/yjTIE2xfnXX41bxLsakH3S6RsPcOzK
	D+wD+P3BhwBBRgBiK+K6/6puwNELdtGvzgQ+EIBBa/Zkgb7RVOalzAdIu+bYjZUhgdPq96
	nNQVDG2Z3S5mS9x+zMeEqwwyiLu0tnkceLyuZNGa4PrkS3k/jo5mBRqp+TNwivAHxfsPhS
	MNHJrew6R7GikoLnIFCbLwBtKBh7QZ9LZ73bsZg+k+Yv3ytTXDGQpYfyULT5pA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLxRp/JkTIfoLlcPQDYEqa9/SCMFJG4UakDwlT6QSyY=;
	b=OWj9fEX+yyEYPJDMI0ShPXvCRd5YAtum2o5o11R0WyXU/3vU/xl0FPoo5pZCz7oGMp4yEg
	oo1AzboF6zvpa6CA==
Date: Tue, 04 Mar 2025 08:10:56 +0100
Subject: [PATCH 26/32] tools/nolibc: allow limiting of printf destination
 size
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-26-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=1977;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=gptYJeI7zIa0m6z25MFDa2zENatJrEBZvF+Qu777d3Q=;
 b=kg8Do5Q+0Aezad9wGTryJ8SqwrVWpOnZIp+KKn+32QIIofCtR3gc17wbpjW5bSai/DAgY1l/2
 MRa09pcQU6IC/rBF9CQCZ5hxRzE9YpV3Fef+Y6qLTIieo4ytmIqo8fD
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

snprintf() allows limiting the output buffer, while still returning the
number of all bytes that would have been written.
Implement the limitation logic in preparation for snprintf().

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/stdio.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 434fbaddae7a216159fecf618da85889d631dff7..b484a19466394d55d7d21248031837238b58f3ff 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -215,13 +215,13 @@ char *fgets(char *s, int size, FILE *stream)
  */
 typedef int (*_printf_cb)(intptr_t state, const char *buf, size_t size);
 
-static __attribute__((unused, format(printf, 3, 0)))
-int _printf(_printf_cb cb, intptr_t state, const char *fmt, va_list args)
+static __attribute__((unused, format(printf, 4, 0)))
+int _printf(_printf_cb cb, intptr_t state, size_t n, const char *fmt, va_list args)
 {
 	char escape, lpref, c;
 	unsigned long long v;
 	unsigned int written;
-	size_t len, ofs;
+	size_t len, ofs, w;
 	char tmpbuf[21];
 	const char *outstr;
 
@@ -306,8 +306,12 @@ int _printf(_printf_cb cb, intptr_t state, const char *fmt, va_list args)
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
@@ -331,7 +335,7 @@ static int _fprintf_cb(intptr_t state, const char *buf, size_t size)
 static __attribute__((unused, format(printf, 2, 0)))
 int vfprintf(FILE *stream, const char *fmt, va_list args)
 {
-	return _printf(_fprintf_cb, (intptr_t)stream, fmt, args);
+	return _printf(_fprintf_cb, (intptr_t)stream, SIZE_MAX, fmt, args);
 }
 
 static __attribute__((unused, format(printf, 1, 0)))

-- 
2.48.1


