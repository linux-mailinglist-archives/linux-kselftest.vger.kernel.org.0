Return-Path: <linux-kselftest+bounces-30209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C08A7D4B7
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8601886AAE
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B8C225771;
	Mon,  7 Apr 2025 06:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XINUmWGS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GSA1f0R4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F6C22CBD5;
	Mon,  7 Apr 2025 06:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008796; cv=none; b=RYI15q7WJJX16ZM0YT2YT0ufhmt3Ij8fy6YPvlISEpPC1tVu8HNLbaIQSFXm0wBjKMNvmgV2hZS4dWXoMibYVT8NnHXe0eB1LgQzH/zxnOYlmssFMkawnYCMn0PUzWq7xvF/vLiyRuniur1qGvzBwykELId6KCkVXpThyefWbkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008796; c=relaxed/simple;
	bh=orWxm+0HgDh0luacmmPqHBYqPsziQRKvdvp7XdrcWAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m/IPOxa4PWlEIjEL4eJX/REYJnMOzpRjrn9UGAc1taHTn++Dns5fjl3BsyJly+CHoOD29CcCpeqhSJ4rUTeUJmqethx+U8yx/Al5LbNi3+Et8zlxhgOY1O+VxJfGPNFdiut9/tCVUJkFKyOEgWFv2OK4RLpNpwL/G4/c22tFaEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XINUmWGS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GSA1f0R4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxPxFvYnts74EjizYrncbr+uFIPm2JowqVuGA565ZYE=;
	b=XINUmWGSqm3ZLtQ/RUTAc9kRwyuBaDhz68Ht45lK8O7a+9qFsBgK0e3VJnO/ziQsr57wkg
	Uy5bL/db4YTcTNTj46czPVkSC1L1EDE38hFhq7ZCq25UWbXzu1QYuABFdd9DTdA5SOprMT
	/7mOKmstaP0qAfyGENQeRz1kYM9kX3ELqf2QIpuP/af1587JnpXZJruvyBIcyECiPZx3AH
	EWvxMJYyqmrM+RLlqSsi/DNQ6qyTYbOx7XGW2z82ssWYJ6iqghV5YNYnRwEq+CkKkMYMpI
	3JdDHxF7/DKjoLAGC1FUEAva1nUAcYOa/YeeM/HJ88dvJns4IRDC1YEQJ1u1Dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxPxFvYnts74EjizYrncbr+uFIPm2JowqVuGA565ZYE=;
	b=GSA1f0R49mBlFEqFJenZ0hBd5VDKslLpNspKQzJfMpaa5PGc8OqVqv6RUpQ+Sg+6N4c9Pp
	LdqCFJDpCv60JDDw==
Date: Mon, 07 Apr 2025 08:52:46 +0200
Subject: [PATCH v2 23/32] tools/nolibc: add dprintf() and vdprintf()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-23-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=1389;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=orWxm+0HgDh0luacmmPqHBYqPsziQRKvdvp7XdrcWAY=;
 b=zgu6bhfIbTzLSbHAGSc9RMoJXQxadrdVuWFlyKVdA8snPXsAOEQabrhfz0KG9RSCs8p02vfER
 LjB7FDssy2RAfBOU65TC3kuAEhXr92h+7GnqmfqdA/Qw/QEUpaT5FhL
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


