Return-Path: <linux-kselftest+bounces-30561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C365A85767
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95CB07B5BEC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7D92BF3D1;
	Fri, 11 Apr 2025 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2eXvzZUl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aNRCmvA9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B984229AAFE;
	Fri, 11 Apr 2025 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362122; cv=none; b=cf9PRVRMgdL/FdD2o1YtT5WKUQp/PqSE8fQBhdvZAk6F2pqLmCGTXrAe/HjCObc2OvpLxrVd29XKYe7QFR3DUVrFSKTNlaRajZBN510sMXkdk0l6M35zdG0RjVinD9HMk1oPtld1v6ZIJBW9vJ3AJLpm24+emqULJvL8x2Yv3XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362122; c=relaxed/simple;
	bh=P5LbQi17NAkuvW7XclFYFaQVXn+26pugbIFKqyTCxcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KieHH4rWMpNfvpd1bkcT510CyAD/OvhzYE+WfYlcaWw8h+ETBYnhycZX1/lriT9czprnMMoTxaBp+FQl50o4CAeAJAIRKNapMJIpOe2BIM1uKfHxvfNkLW3C8VGtXhz85An78aU3ws0CNFdNYvT/u7Gz4It11yTBfUnQdkm131E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2eXvzZUl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aNRCmvA9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2c+JQsB+d6lrmsGdRgSEPuvJuQzEcudvCh2/xlKMBJo=;
	b=2eXvzZUlecNijtcEzXBQfARUaU9rsYNu0d5QGmA+abbjpnYrXhp2tbRGiAoeH2+Dd0vzpX
	sVnNtvHybArh+9r9uLUd11hzSvzJ4Wa7+zKVtXU0RWczrwU25bHGHnu/2xPdmtrqtMmrvL
	2Y9bqxGkROrbBpbWDUur4+0fVuV1bUwWLhJt22w+MdlU3PSxtb2eAu0dGCHx8de4IE9NFM
	GLewyKnYN67+EJ0KkJZz/REWwN1aA1xv5b7e7qgHVXr0kYKdX39mcOdxHcBgIrSes9ICHs
	F3IGA3RpGfKrLiZmXYtetY8fHMTef9x13wWMoZz0ZZrDcqONG6oPh3y+R4zM/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2c+JQsB+d6lrmsGdRgSEPuvJuQzEcudvCh2/xlKMBJo=;
	b=aNRCmvA9TM189Q/Aj82AUMKVL3VNaq10JQbe6JnlE/gBrezEP5YTxeAlcEa1PbSIbMWWyR
	pN9b2fpvzFJErRDg==
Date: Fri, 11 Apr 2025 11:00:49 +0200
Subject: [PATCH v3 25/32] tools/nolibc: allow different write callbacks in
 printf
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-25-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=2074;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=P5LbQi17NAkuvW7XclFYFaQVXn+26pugbIFKqyTCxcY=;
 b=NoiWYraaCzekOYaUanULW6h0LSwm1ZPQqwfmsQsIoWe0/QpUPKwRqD6bkGe4E8Xx4DdV+Bsf6
 PMYpMkCIuvsDX8CUK2Ev5LJXhP9f8UyL/Bkp9U7fqtaQne9WUYmWl0H
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Decouple the formatting logic from the writing logic to later enable
writing straight to a buffer in sprintf().

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdio.h | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 262d0da4da9062e0c83b55661b2509f36548cf88..5c893b4903a3040a366e11b600ccde30913d7db2 100644
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
+typedef int (*__nolibc_printf_cb)(intptr_t state, const char *buf, size_t size);
+
+static __attribute__((unused, format(printf, 3, 0)))
+int __nolibc_printf(__nolibc_printf_cb cb, intptr_t state, const char *fmt, va_list args)
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
 
+static int __nolibc_fprintf_cb(intptr_t state, const char *buf, size_t size)
+{
+	return _fwrite(buf, size, (FILE *)state);
+}
+
+static __attribute__((unused, format(printf, 2, 0)))
+int vfprintf(FILE *stream, const char *fmt, va_list args)
+{
+	return __nolibc_printf(__nolibc_fprintf_cb, (intptr_t)stream, fmt, args);
+}
+
 static __attribute__((unused, format(printf, 1, 0)))
 int vprintf(const char *fmt, va_list args)
 {

-- 
2.49.0


