Return-Path: <linux-kselftest+bounces-37921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 911D3B1009D
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 08:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709051C286C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 06:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6D42417F8;
	Thu, 24 Jul 2025 06:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oe6SUHPu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AOV5sDGl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D092367B1;
	Thu, 24 Jul 2025 06:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753338443; cv=none; b=h6VTAX9yWJIcCd3lFFqB7A9nkKHqzyyRV8RcssX6HtGGWIRzByE/0eMdsC4W1IyaoJaKgz/948lqlp2Ckr+EJawH+HUbnLFWtDasWlHeOAUHKoxYS0pTqn/ju3cDT8CvSLbaWNHe7N5OS/4B8dVh2RHlWlZ0+qU2jAMZO6JYDQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753338443; c=relaxed/simple;
	bh=fxgNwbguzm19mxOl+d1yMzx0FAgO/SMJ+Tt1yKD0hgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g85fe0Xd5jUHIC2MnmqG/wuXmLayZ5HRAsonuYH8Z943QDHbl5JX2WNeav6Vv4cay9Q/Pl/FhiT7EabfBdxdLUHWLThqfGvarxKJk57aKHbh6ZlYm5abNmJCBVHEu/jOJ0PLj/7wzxLb/T9xISHT+GXs+kSk1O2O7IIz6rywAsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oe6SUHPu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AOV5sDGl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753338440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G7Fn8+v2ScBzJFYv6AzzkLmPfAu+RY8HxbLfk2DOx3Y=;
	b=Oe6SUHPu7RWGz0e0883QES1I7PbBp47gqIyZoFhCCBwWIzNvRhnuF0ueDbddWfXrUUGVNX
	oJ1zJHkw7viUjWdxd2jaCqaSzEc8FXkwFxw4v8+Dh2gYn0eRFnX+0/632PHf0gNADnMqcY
	/ctCjwxctF2MOFEbtBrNSwH4Ret3xEMcCokqStnYfFCONadIhtV5eB94FHYMgyJ5jsyMCv
	rYaCgdItNRveo93Cl0WVEKUgGOT58RWgGogbPt5zZgXHsjRuuOqznqYBGbaxHaAerlPoRE
	uE1pBi2SfHHFwzbct9Z2ABBciSQ3MaTPuzAwGyvyG8TaAibSsJcEnitUATBVsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753338440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G7Fn8+v2ScBzJFYv6AzzkLmPfAu+RY8HxbLfk2DOx3Y=;
	b=AOV5sDGlYHFdp6bJ1QozapMCTmrFaJhclp89vkWSKFYJ3DUiJRQYjIMJul1+wFEWyzDsKB
	T5gpPfoYo7/smVDA==
Date: Thu, 24 Jul 2025 08:27:01 +0200
Subject: [PATCH RFC 11/14] sparc64: vdso2c: Drop sym_vvar_start handling
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250724-vdso-sparc64-generic-2-v1-11-e376a3bd24d1@linutronix.de>
References: <20250724-vdso-sparc64-generic-2-v1-0-e376a3bd24d1@linutronix.de>
In-Reply-To: <20250724-vdso-sparc64-generic-2-v1-0-e376a3bd24d1@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, 
 Shannon Nelson <shannon.nelson@amd.com>, 
 Nick Alcock <nick.alcock@oracle.com>, John Stultz <jstultz@google.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753338429; l=1958;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=fxgNwbguzm19mxOl+d1yMzx0FAgO/SMJ+Tt1yKD0hgU=;
 b=vcNduCCwy56MB8kcxqHTagC77P6QS9ci1AHq2KRbpdHwzvoP3o8bZ+fdegRcYt4W8rjDXU42s
 Ae0pawBcd+YBUimoxYLeLS/WgoPZ5vtG7jMV2iXeAcmTniDFdP0RHJy
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

After the adoption of the generic vDSO library this symbol does not exist.

The alignment invariant is now guaranteed by the generic code.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/sparc/include/asm/vdso.h | 2 --
 arch/sparc/vdso/vdso2c.c      | 6 ------
 arch/sparc/vdso/vdso2c.h      | 4 ----
 3 files changed, 12 deletions(-)

diff --git a/arch/sparc/include/asm/vdso.h b/arch/sparc/include/asm/vdso.h
index 59e79d35cd7384e2dd752e92d20bc599e38cb8b0..f08562d10215bd3e9a2d4eaa0aadc8400b40e256 100644
--- a/arch/sparc/include/asm/vdso.h
+++ b/arch/sparc/include/asm/vdso.h
@@ -8,8 +8,6 @@
 struct vdso_image {
 	void *data;
 	unsigned long size;   /* Always a multiple of PAGE_SIZE */
-
-	long sym_vvar_start;  /* Negative offset to the vvar area */
 };
 
 #ifdef CONFIG_SPARC64
diff --git a/arch/sparc/vdso/vdso2c.c b/arch/sparc/vdso/vdso2c.c
index b97af5ec9f35c01f2a976b6213b1768b677ad231..70b14a436fe2297ab446f778ab0d43155c272421 100644
--- a/arch/sparc/vdso/vdso2c.c
+++ b/arch/sparc/vdso/vdso2c.c
@@ -58,18 +58,12 @@
 
 const char *outfilename;
 
-/* Symbols that we need in vdso2c. */
-enum {
-	sym_vvar_start,
-};
-
 struct vdso_sym {
 	const char *name;
 	int export;
 };
 
 struct vdso_sym required_syms[] = {
-	[sym_vvar_start] = {"vvar_start", 1},
 };
 
 __attribute__((format(printf, 1, 2))) __attribute__((noreturn))
diff --git a/arch/sparc/vdso/vdso2c.h b/arch/sparc/vdso/vdso2c.h
index 60d69acc748f2401156a730027fe34abfb9fb6bc..ba0794659eb5af53b8c86b24f3221a5d0b3f74ab 100644
--- a/arch/sparc/vdso/vdso2c.h
+++ b/arch/sparc/vdso/vdso2c.h
@@ -104,10 +104,6 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 		}
 	}
 
-	/* Validate mapping addresses. */
-	if (syms[sym_vvar_start] % 8192)
-		fail("vvar_begin must be a multiple of 8192\n");
-
 	if (!name) {
 		fwrite(stripped_addr, stripped_len, 1, outfile);
 		return;

-- 
2.50.1


