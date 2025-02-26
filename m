Return-Path: <linux-kselftest+bounces-27591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE01A45D74
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 12:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1818C16A801
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 11:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67AD218AD8;
	Wed, 26 Feb 2025 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q6RHVpOp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wxpAzBBk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A56215F65;
	Wed, 26 Feb 2025 11:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570314; cv=none; b=pSGB6N59GLF3NjIvGhf+hA4jSq4PBlTEoaRoxXGWDq66BIZHEmi5F/hyydRYKvNld5gpvu1PyGeugscqPsCWheMuHaHumsuiGb4W7qr8nioe2pskiSHLZ44OOmZa21LVDTafeT5eLIxPeoZnA0UQQ53B223fndPyWkpZlJWVLy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570314; c=relaxed/simple;
	bh=s4dcBFTBzdnkfHgUh3Q9G83Mq/JS/VsS9PhICcoi080=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YjNdQVUehbswj7oPD0OZg2RHWNMoeqy5pBOB777GMKX3I1G6F8dWmUqesDySwvJnZbmLSnK6JTMZ93wNmdE9eGya2a/SaMttb3xHfpTA3jPvYsKRgq9EFWgfozqXF/QDKEi5JC4sMW0pckwp61ZnCB60oY/t3drpj0PvORVDyJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q6RHVpOp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wxpAzBBk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740570311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X459Nbf9XrEWha7iYfzDJ/XKmZSxaaM7+gUIBcjKP7M=;
	b=Q6RHVpOpx4zEsk1vhQBMerXcZfxYjUqVTslkHIIAE0kETSlRP+VTu4KB6Ar3suj0p0ABEb
	EXSAONKWx+hJlht02+6RTGP6S4iwhZw4LUzzfGx8wRx7W/6Id4QKh/oyPpvVqB3JmXaWcN
	9s+hnX9QotHEv41wZmKEA3xLsYc6kq/45ol1Qu7p2d/S1mOA5cBaniZ1x5/74jWtqgFO7S
	SHmrXV63IcWdYrdXd+KRhfXgNMSu3R/qj08gFcCU3W8fqpxFfFcgPfr5B12x0UcXC8oDjq
	QlXnIH0pIJzGyOjnco6JVy00lodeEFdR3L3UbHQgNrrIRFbZn10m7+QgHGW2cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740570311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X459Nbf9XrEWha7iYfzDJ/XKmZSxaaM7+gUIBcjKP7M=;
	b=wxpAzBBkGPD/yd/UvVvq3B9eE3sYMv29zNLt5TKz00Qmo5uoyB+ri0QozhIXJSlVvWqHGh
	19+lwFcgC6SL43CA==
Date: Wed, 26 Feb 2025 12:44:43 +0100
Subject: [PATCH v2 04/16] elf, uapi: Add definitions for VER_FLG_BASE and
 VER_FLG_WEAK
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-parse_vdso-nolibc-v2-4-28e14e031ed8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740570307; l=976;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=s4dcBFTBzdnkfHgUh3Q9G83Mq/JS/VsS9PhICcoi080=;
 b=cT1LjlV6MdAalhb0317TK/ZKKu9q9wZ1kkpTwpuGLCiGqy4w/CIFAzQGbV6a9D6L9/Rfxha5V
 c/aBJB5puZ7AZw+MOZLGj/TcVagcBoDUWnKGS0tv2nYQKmO2YDmVmZv
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The definitions are used by tools/testing/selftests/vDSO/parse_vdso.c.
To be able to build the vDSO selftests without a libc dependency,
add the definitions to the kernels own UAPI headers.

Link: https://docs.oracle.com/cd/E19683-01/816-1386/chapter6-80869/index.html
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/uapi/linux/elf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index c5383cc7bb13c931fea083de5243c4006f795006..d040f12ff1c0ae3dde5c371c81d6089118fbe8ed 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -136,6 +136,9 @@ typedef __s64	Elf64_Sxword;
 #define STT_COMMON  5
 #define STT_TLS     6
 
+#define VER_FLG_BASE 0x1
+#define VER_FLG_WEAK 0x2
+
 #define ELF_ST_BIND(x)		((x) >> 4)
 #define ELF_ST_TYPE(x)		((x) & 0xf)
 #define ELF32_ST_BIND(x)	ELF_ST_BIND(x)

-- 
2.48.1


