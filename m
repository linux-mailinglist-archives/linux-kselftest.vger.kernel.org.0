Return-Path: <linux-kselftest+bounces-28171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D85B9A4D482
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B971888FEC
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3F01FE473;
	Tue,  4 Mar 2025 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JOZiM7on";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E4Ln4FLT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0BE1FDA78;
	Tue,  4 Mar 2025 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072285; cv=none; b=C8rC7xDfssmVM0zWlnzGemO/iuUamY1IZTrBZZWo9XLBMoT/qeSw+A0Jh6u3GJtRwcblAP3IgXcSU1JiyB3mvvFFXaIZXjrjPs48gmW3eTyJsLfYAOgmo0bSSmzVdJ6SFlZY8RzTk1M3+J6ZOSSy7Zl2DZac1+xE9jdWXrypyjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072285; c=relaxed/simple;
	bh=VAitc4TpEayA62P7PzIris09IKbI6DnHkqqiFFANP2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FrRnqFZ8PceqrjOcL8B/NOnMMSFitA8FGvs17pfOCrosktZTcBpDJHoBZvcvl81zpBy48MtgHzfy9fmfgQchHbpdLhJhXl2Y8G4qzBEEapVS+X7tiqTbuQKGcsh5du3FEVzpEQnHtNSPCWr+uJMJ9B6B3jVOxuTeIY8hRqz4Q1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JOZiM7on; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E4Ln4FLT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lP373sJm7fLQ44Jh21r4D7xLZ1+CcxGOeWWhA71PxgQ=;
	b=JOZiM7onQBRPaC143jCUAdy5pXbodMe7NGoalCg2nXC7p2tUI1KY2Cu+txCh76zJi96f2b
	66iIRY5918U5D9gXgIUASXxGZ6MnM6rlndc6+N7HeZ6R0PCL/irWPnrAyZsSQ/mT3aaobD
	9V4rxRAIjniCmvdViXxESCUkUWhUU6KqOSSEgGOHK4RmbbEwDz7nh4w8bnBrY9ey/EF6hw
	tAinbAZREuF11lfOCxd+QmKU6ficPRqkXEGIH0mVPBAHtc44jmXKgYDKJAmXfUEHk/9IZv
	WNAJgX9Afbf7k7J5y70bMg4OIYDOfBvjwczLXIgWsTLtCSABauFeNgfVlV6UzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lP373sJm7fLQ44Jh21r4D7xLZ1+CcxGOeWWhA71PxgQ=;
	b=E4Ln4FLToAv5kFatqppDjnktR3RjR4MtwZ/V9ioYLZ68gkA9sJ3WG3O32cB5rnFcOhKUZ1
	KrrVGtKXHIRDgHCg==
Date: Tue, 04 Mar 2025 08:10:55 +0100
Subject: [PATCH 25/32] tools/nolibc: allow different write callbacks in
 printf
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-25-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=1990;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=VAitc4TpEayA62P7PzIris09IKbI6DnHkqqiFFANP2o=;
 b=36r1jcdLB7HWYJLkaB9ww4n3omXOBiOYNGXvuAsoRisC7XkNElex38a27q9s091lgCW45SVwb
 z3rNMFH/3QFCQPD/UN3a6g5QkRyffof/Cg31oBtodkzxG3Wxrezse3X
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Decouple the formatting logic from the writing logic to later enable
writing straight to a buffer in sprintf().

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/stdio.h | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 262d0da4da9062e0c83b55661b2509f36548cf88..434fbaddae7a216159fecf618da85889d631dff7 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -208,13 +208,15 @@ char *fgets(char *s, int size, FILE *stream)
 }
 
 
-/* minimal vfprintf(). It supports the following formats:
+/* minimal printf(). It supports the following formats:
  *  - %[l*]{d,u,c,x,p}
  *  - %s
  *  - unknown modifiers are ignored.
  */
-static __attribute__((unused, format(printf, 2, 0)))
-int vfprintf(FILE *stream, const char *fmt, va_list args)
+typedef int (*_printf_cb)(intptr_t state, const char *buf, size_t size);
+
+static __attribute__((unused, format(printf, 3, 0)))
+int _printf(_printf_cb cb, intptr_t state, const char *fmt, va_list args)
 {
 	char escape, lpref, c;
 	unsigned long long v;
@@ -304,7 +306,7 @@ int vfprintf(FILE *stream, const char *fmt, va_list args)
 			outstr = fmt;
 			len = ofs - 1;
 		flush_str:
-			if (_fwrite(outstr, len, stream) != 0)
+			if (cb(state, outstr, len) != 0)
 				break;
 
 			written += len;
@@ -321,6 +323,17 @@ int vfprintf(FILE *stream, const char *fmt, va_list args)
 	return written;
 }
 
+static int _fprintf_cb(intptr_t state, const char *buf, size_t size)
+{
+	return _fwrite(buf, size, (FILE *)state);
+}
+
+static __attribute__((unused, format(printf, 2, 0)))
+int vfprintf(FILE *stream, const char *fmt, va_list args)
+{
+	return _printf(_fprintf_cb, (intptr_t)stream, fmt, args);
+}
+
 static __attribute__((unused, format(printf, 1, 0)))
 int vprintf(const char *fmt, va_list args)
 {

-- 
2.48.1


