Return-Path: <linux-kselftest+bounces-30212-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F14A7D4B6
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC0E17A3D48
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFF622D7AC;
	Mon,  7 Apr 2025 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LjKZNFeK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LG3JWloy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBC822D4DB;
	Mon,  7 Apr 2025 06:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008798; cv=none; b=XdP8Js+qfIR466dgD/7nBQvPFJaJgHhSUiHwswfwRI1MqBCl2M6Kv5CB/j9BF5a9hxHx+xuQkwsESaGRCq3pSKUAOgqNkvGBA8Z+FE2dtOhnosWFpeS5KTAo0/U2VIlVUcblMy0zU+JW2nAV9Ld1eSxRMkbQpNI/IIXxnSMAEL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008798; c=relaxed/simple;
	bh=HtVJce/zltJfmoUxHSGByH8pfwgO3OfNF4RtzIB7sOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eIYWU2+x9gnUxUT/blrgHdr7LC+MCTodQOHjptlg98poK9rBDSSj/oZguy9+l5AUpbRiON2UEyQ/oLOiwY55esqmBSPQsS/b8CGoGt9CP4GIU5XmQsIm1rZGGZf+LZ5u3I1yz5QLRgQ0cSkpzyiTiEFUDcTGDwpJG+ybh0h4fqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LjKZNFeK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LG3JWloy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvBGqGX78XvKEVW6i13ta4x/bQjOWTVre+e55nvMR/A=;
	b=LjKZNFeKaT5zlIG0HQqN+TdGrfIZkHYq+m9pS6BXEA1IZ946yhU1d9QUuiV+FKg9wcFeeA
	y+KrTekmnLlsHN9fDld0c1OKCK+VXLaeEVCYoDUP8Uy2NLuJRcx3xC51ycXVj1NaCzn2r7
	ou5tCsXzZVZRhdNYyYDM0u6YVuHXX2RB5zCdR/bnaZa94ENPxkZxbQBFE1eSnDgMMuizZy
	AunHcxoAOZXzqhlIOuLVueyXihf05dq1FGAgGLFxq/SJ8Vx+IzJoju9flVpvi2Xqws4mB7
	JmagNIe3R5aupFsg9RZlxaVOOqqOFDdPKgMn3S5xL8bl7tKAN2cTsXRnZI6zVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvBGqGX78XvKEVW6i13ta4x/bQjOWTVre+e55nvMR/A=;
	b=LG3JWloykDvoRMJEKshLOVrrzK6rE2Tx/36yZrKqYlpCXI0ckO72s21bTvnwcXQlScR0Db
	BoWibW9NDiiS7oAw==
Date: Mon, 07 Apr 2025 08:52:49 +0200
Subject: [PATCH v2 26/32] tools/nolibc: allow limiting of printf
 destination size
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-26-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=2100;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=HtVJce/zltJfmoUxHSGByH8pfwgO3OfNF4RtzIB7sOk=;
 b=IqgTPpO3PWnUMN4VmPuep8LFP/X0mBYJeu1nuF5O9IQhGCEnuk4jDyCNBDcwdzqaacw/3ljjX
 YdrUmm3BSikDE7XGyiTwRvMH1lTnDW8LogMKafJh/1w2cEAoA7Vao4I
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


