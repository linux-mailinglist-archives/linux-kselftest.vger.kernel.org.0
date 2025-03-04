Return-Path: <linux-kselftest+bounces-28175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC42A4D486
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2F81890684
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F6A1FECD4;
	Tue,  4 Mar 2025 07:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DK/Mdxuw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5XQBtEfd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D69B1FDE35;
	Tue,  4 Mar 2025 07:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072286; cv=none; b=Njxwgn9AsiBUHkAiSJzsJW1oR12X8t8FoLcZd9sxha4Jgx86WErxDBb+yXATZEuSfF537SZp/SSMjEcvJJHMzSomKVlqqz8r4TkyUaA1OLly7Hp4ENYf4J89LFTNV1JWw3ejhIkj09JJ7CsrpDzwNW/3Aavo+zLdiaUUYspKyCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072286; c=relaxed/simple;
	bh=kIfkjPOgDVYeocxM7s+nHpNJMKMVlvbxbWh7QtSGrBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o9rLksSQn0M+QGOI97Z1C6tbNWcjBaWYNPmqyO23kpe4Cpox+NV6QrQPqBastxduTX71EN6F66OFeaG+viVHzt4RN4p4gptNXLHudd3Pl0vngVeQ0wITdWQ+LtNDELT1c+KOlHMsdNMCj9pUJzZZPt2LjgJfWBnU+45c5kr/qm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DK/Mdxuw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5XQBtEfd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yvU+4hUcgr7XKuM6SRyjgFbmMqNDLhbciRivlXgQHe0=;
	b=DK/Mdxuw8sfwhTAPhlBfxB2DyRgBNB9y2jMBsALIUB9elG1o3AM4d+32URNdHrbL7Y22zr
	1m4YxTnql4IKthRgxiF4JaZLeqfwSdUQmij8dwdNR8sarOmTxcdtLL53+DnefwT+WpkWT5
	Ioi/nb9UMLRlLut+IX/cXtlsRd3mDCpd/XgUqdaO1DZpULVAb4gQMHg2HkIok0haBR5cWY
	tamtBzGPhysIUdatzx5W4L5Xkl3jo9yAs6G9oyXcmiexEzo4HUUn78aA0rsABF4pjY9LW0
	qP0Nf/ti7+UyUTJr50jyjKHtyh0CvVAeUmjQzAe1f72JsCxUgzSGsvjnLlzMWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yvU+4hUcgr7XKuM6SRyjgFbmMqNDLhbciRivlXgQHe0=;
	b=5XQBtEfd82JC7KfmqIpgCQqvUBTC0lxd2swZGcFGR5LhQ7ltVR1IQTKqCwtC9lOVRQf+8t
	AEjChuNC1MDc0dBA==
Date: Tue, 04 Mar 2025 08:10:58 +0100
Subject: [PATCH 28/32] selftests/nolibc: use snprintf() for printf tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-28-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=1733;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=kIfkjPOgDVYeocxM7s+nHpNJMKMVlvbxbWh7QtSGrBE=;
 b=QmYkSqbdKkmQIzzNr8atDg4RwgZEJUhhF6a1kFnWagiXGqy2ILkajmCYA4XZzCHDupbSZv53S
 uUIMEQ0W59XA4YnHzFWw8ZCnJXQMwezwGFCYPHy04LttQJaQZ1H05a4
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

With a proper snprintf() implementation in place, the ugly pipe usage is
not necessary anymore.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 30 +++-------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 6fa659429cfc38c9d42f36f80ab6c529890d9ad7..1b60eb848c02ef4e90782a83e90987b7efb71031 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1283,27 +1283,14 @@ int run_stdlib(int min, int max)
 
 static int expect_vfprintf(int llen, int c, const char *expected, const char *fmt, ...)
 {
-	int ret, pipefd[2];
-	ssize_t w, r;
 	char buf[100];
-	FILE *memfile;
 	va_list args;
+	ssize_t w;
+	int ret;
 
-	ret = pipe(pipefd);
-	if (ret == -1) {
-		llen += printf(" pipe() != %s", strerror(errno));
-		result(llen, FAIL);
-		return 1;
-	}
-
-	memfile = fdopen(pipefd[1], "w");
-	if (!memfile) {
-		result(llen, FAIL);
-		return 1;
-	}
 
 	va_start(args, fmt);
-	w = vfprintf(memfile, fmt, args);
+	w = vsnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
 
 	if (w != c) {
@@ -1312,17 +1299,6 @@ static int expect_vfprintf(int llen, int c, const char *expected, const char *fm
 		return 1;
 	}
 
-	fclose(memfile);
-
-	r = read(pipefd[0], buf, sizeof(buf) - 1);
-
-	if (r != w) {
-		llen += printf(" written(%d) != read(%d)", (int)w, (int)r);
-		result(llen, FAIL);
-		return 1;
-	}
-
-	buf[r] = '\0';
 	llen += printf(" \"%s\" = \"%s\"", expected, buf);
 	ret = strncmp(expected, buf, c);
 

-- 
2.48.1


