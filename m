Return-Path: <linux-kselftest+bounces-30560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69930A85765
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF134E0D73
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B182BEC36;
	Fri, 11 Apr 2025 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RHebHj+T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m4hgC8vt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75572BD5A6;
	Fri, 11 Apr 2025 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362121; cv=none; b=IkHbXlEO1F5ur/t90AN/lKVNLiFiZUmezNlua2jFKO3KqwZvCVL2Ew6Q60AryEA/mHDSZhxXF6nHaLjTqAusFu5Oe3fQwormbisnDIzfQjiyXpj4fejs1NERznmXEtWMvjONPxfWr/ZrTqjQS7zG5+ovYJppcnUNuJ0pbrkv2S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362121; c=relaxed/simple;
	bh=orWxm+0HgDh0luacmmPqHBYqPsziQRKvdvp7XdrcWAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UliXl1iHo3uQjutGAgzNEXtZYiUSrL4p24MaIwqAUVLTb1zY3AOfYzr5JlBjemt4badzqvz8xcU1KTPfewP4ldffVqENdLvdGVfUOlfTMIrfR7SuZMEm8/BSHbWvR4DGTZuSvyGCVJjRCVFmGhJ+JMeHPhDDm7rAuNTh84r+H/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RHebHj+T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m4hgC8vt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxPxFvYnts74EjizYrncbr+uFIPm2JowqVuGA565ZYE=;
	b=RHebHj+TS5jQwonBzS0LvlndpECqRYQ3DDS44F/N6kPme5HJWMW/P3+LLkaf01Qoda/5jx
	fE88mxeEbRJQJ4VJi0s29Ev8ILfbS3+Pp0d/+joytDKLPK+o/E3vFWhc40omIgEuFIl1bU
	DarbkzPiV9lj+9RfR0jAyE33yKY6S+g4X56kjW+d81lmMLmN/NvgJLd+dozDZLb7BP5TP6
	Ei21yQldA4HjjtUaBqvGUwyyO3zd3K90jo3IyqXMsjHjUwBO/7i/eOvx78TrFo4Be8aX5g
	K7eeXAHVmgnAtZt57baHXrzXuDaeIW6O1NDoyYyZ6iGwdKNZVVMdgwZFEtmeqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxPxFvYnts74EjizYrncbr+uFIPm2JowqVuGA565ZYE=;
	b=m4hgC8vtGtTnEKaIX5ic4MnD9+YgzAaD/mRY2lLCRqQM5CWw7XyOrO9h7OJ5OIDE4VNlpR
	PHUsv94TKLlSDfBw==
Date: Fri, 11 Apr 2025 11:00:47 +0200
Subject: [PATCH v3 23/32] tools/nolibc: add dprintf() and vdprintf()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-23-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=1389;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=orWxm+0HgDh0luacmmPqHBYqPsziQRKvdvp7XdrcWAY=;
 b=I+JkNvjvxstCdZam6IZGTOLheZRXF+73nF88w5y9S34dXwZrRkYNtCHLZab4QQ4rHu9Y7aoly
 dfZWJ1v55feBDCM1ytDFXP41/k1dCxbNcqX276MpIORrvod4WYxDKCR
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

dprintf() and vdprintf() are printf() variants printing directly into a
filedescriptor. As FILE in nolibc is based directly on filedescriptors,
the implementation is trivial.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdio.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index b32b8b794015276ab6242c2be18f860c095f90a3..262d0da4da9062e0c83b55661b2509f36548cf88 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -351,6 +351,30 @@ int printf(const char *fmt, ...)
 	return ret;
 }
 
+static __attribute__((unused, format(printf, 2, 0)))
+int vdprintf(int fd, const char *fmt, va_list args)
+{
+	FILE *stream;
+
+	stream = fdopen(fd, NULL);
+	if (!stream)
+		return -1;
+	/* Technically 'stream' is leaked, but as it's only a wrapper around 'fd' that is fine */
+	return vfprintf(stream, fmt, args);
+}
+
+static __attribute__((unused, format(printf, 2, 3)))
+int dprintf(int fd, const char *fmt, ...)
+{
+	va_list args;
+	int ret;
+
+	va_start(args, fmt);
+	ret = vdprintf(fd, fmt, args);
+	va_end(args);
+	return ret;
+}
+
 static __attribute__((unused))
 int vsscanf(const char *str, const char *format, va_list args)
 {

-- 
2.49.0


