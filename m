Return-Path: <linux-kselftest+bounces-27590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A76CBA45D72
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 12:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60CD1188E57D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 11:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F97218593;
	Wed, 26 Feb 2025 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="avECu8S3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oo4q/cfI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A26216382;
	Wed, 26 Feb 2025 11:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570314; cv=none; b=r27b98fVZDNu0aRdGf92yaM2J5KlXZ2jZRd1aLYE+ClN81026t+1GeleFmk6Ljf9UcaL7URaEWm6g+RR5kSMZc9QTzmh1MwQ4X4lsdS99VBeiJdeIVKOcCJNdZVH0zeZ6AXzhBsoZkRfjSs0GEwY/M6OKfwlEtn+wlFnVw+eV7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570314; c=relaxed/simple;
	bh=+jGgP1cF5BHMiA98EteeT7PCwWeU0cio2XCj4TkDXXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kyNfnKbeGkAZ22/C7rcEOcbTGekM7i0qy/SthwbUPYJ1Oyar2Pl0FPtohSRZfPUN8/r5tljTPhZT+0TgyE6LrBoaXwwe5hmB8N59S5Bcsv5OnP+io86qsxiefAs9Idvl4GKQ7UEiX0cmMKIlYy1YihzRX1ueWfnfummNEbVNSG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=avECu8S3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oo4q/cfI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740570310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qc8k85QrRUfIwluNEgaOEIrDWlVHw34Ed+H+vO4zIyU=;
	b=avECu8S3jx/pmCIQJWaK+0SD8K6JT8SgvRapY9TNb39IEaKuSR+tpzWW6pZsMs+Bd64mxD
	DpVplJ5rC26o+kIErleSVbg4O3iGhlxVke2dumC3pDlpKiwmWMrh0p/omecDYpsTABSN4C
	r/BK/yxqHtoK1vts2FOv7jcQ5gYb/fd2F6ZDOIb3VQmuZYlTL8MOotoscRQHlG9jXFEmiO
	wz0a8tD8Dnhod6Pc31rssOViwZsomH2L8EN+qKX52SYScbEn6SfOcamhUKcuUKK3kXGTxF
	V2zaBkDidKTVBO3dw/gcnLp/iLX6mG+o9/sdPc6alFF7Xdwg7QGXU1TxvpEltA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740570310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qc8k85QrRUfIwluNEgaOEIrDWlVHw34Ed+H+vO4zIyU=;
	b=Oo4q/cfIBwhbzTTkHfzTQKj/4rS6c1d4wrt8XU482oeVg1WZfUBNM9SXPS1Er6+/GUn+Kp
	4NKpgPB/18f2H0Bw==
Date: Wed, 26 Feb 2025 12:44:42 +0100
Subject: [PATCH v2 03/16] elf, uapi: Add definition for DT_GNU_HASH
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-parse_vdso-nolibc-v2-3-28e14e031ed8@linutronix.de>
References: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
In-Reply-To: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
To: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740570307; l=992;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=+jGgP1cF5BHMiA98EteeT7PCwWeU0cio2XCj4TkDXXs=;
 b=gffFwpFiMY0sSE9DKpvTyzzTsHUi6gqoqQGzj2IUwlbRWYjFFxwMFVEexOzQSI0o+6k2ojfcr
 0YglZp5OTQgB6tOuZ7VpMYH7szsVzIHB0ASp/JLSQ82MOQMT0FTpFk7
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The definition is used by tools/testing/selftests/vDSO/parse_vdso.c.
To be able to build the vDSO selftests without a libc dependency,
add the define to the kernels own UAPI headers.

Link: https://refspecs.linuxbase.org/LSB_5.0.0/LSB-Core-generic/LSB-Core-generic/libc-ddefs.html
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/uapi/linux/elf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 448695c7364042b10682acc8223eb6053ad039dd..c5383cc7bb13c931fea083de5243c4006f795006 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -107,6 +107,7 @@ typedef __s64	Elf64_Sxword;
 #define DT_VALRNGLO	0x6ffffd00
 #define DT_VALRNGHI	0x6ffffdff
 #define DT_ADDRRNGLO	0x6ffffe00
+#define DT_GNU_HASH	0x6ffffef5
 #define DT_ADDRRNGHI	0x6ffffeff
 #define DT_VERSYM	0x6ffffff0
 #define DT_RELACOUNT	0x6ffffff9

-- 
2.48.1


