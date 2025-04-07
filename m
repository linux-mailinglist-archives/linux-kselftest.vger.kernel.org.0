Return-Path: <linux-kselftest+bounces-30210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4696CA7D4C1
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F2E3B1599
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9705A22D78D;
	Mon,  7 Apr 2025 06:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d2tldDAP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E3Bd+8Q5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E547722D4C5;
	Mon,  7 Apr 2025 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008797; cv=none; b=CRcEevP4skrDornngnCrag+3Tq+WOpcsWoWE2caobb7cqsZtBrE3TPA7jd3LNRw46ioc688mMrRJGPOaIrpCJmhG0NpacafSuEnnCKr2ZnQKX+rsPp1uqTnXfDizmca5+fmKHaDP8E51GHkSpCGs90CjIrMFRyNYqOyt+AVEMpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008797; c=relaxed/simple;
	bh=P5LbQi17NAkuvW7XclFYFaQVXn+26pugbIFKqyTCxcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J9gHquOF8CwFJt4ecBDGEfZgn2anB/xncojdwNHCMuU800knXy5cKtIhzGWtyRBZWMSI4kv7juP59z4EkIWG3aRL8EoWSnQgQ8HwK60LEaSQgMOKHxQsQT8Lc3t1snaMrZ7l/ZQbjsho1LMZXtILvObNmGs2qmw8T1QiejqSKVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d2tldDAP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E3Bd+8Q5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2c+JQsB+d6lrmsGdRgSEPuvJuQzEcudvCh2/xlKMBJo=;
	b=d2tldDAPIYCnQcLVP52sjKwsLnpfmHWo1xT75iKEAPllI0mbuxw1Rd+Y1UH72TbTMSL3Fu
	Yw4oWz5uupDjUsMrv2/8RcpoqItgVaVW+tHTxiTIh/ccQZn63C2UDlciG+BlxfthNz3DGa
	XPN44y6MryF3sE3uisTgzbcUiPR7KjbgD08w0B3TNH2M3Z1eAFNgLtoKpt7DnQJgjDyK//
	Z+IMpjlmbUNDHqh+DE/JeXEZUXPNGepmKaqb1BIvnpeocsOqwWlB9j3expslZmRIK6gVob
	N48TzCgfoYWPx5dE3VuJd4IKYD1qKlYiXm/vTSaVHdGFkgAXSdxO48TKY37aDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2c+JQsB+d6lrmsGdRgSEPuvJuQzEcudvCh2/xlKMBJo=;
	b=E3Bd+8Q5TLDEfKE66jrqrK4uiHx/3LbqHw0pDINFbcABRs6oILNcBljJrDq9tW7O35LKgR
	4YkuQ8Ju8fZpsYBg==
Date: Mon, 07 Apr 2025 08:52:48 +0200
Subject: [PATCH v2 25/32] tools/nolibc: allow different write callbacks in
 printf
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-25-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=2074;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=P5LbQi17NAkuvW7XclFYFaQVXn+26pugbIFKqyTCxcY=;
 b=Qg2kFVCMiqHSu0omQmWo/1dZsvVcHgSqeo89NnyviD/hhXSFAnBy8jInEYZPeYYoQn6FjObZ0
 w64cIZLo/qAAieO4b4fOuELoX4oSCy0vsWLqqKRbLa3IOfPS9unXeS9
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


