Return-Path: <linux-kselftest+bounces-35288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C492ADEDFF
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 15:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4CB17EBF0
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 13:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35DD2E9732;
	Wed, 18 Jun 2025 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SOetsZYA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+e7qUvtH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07202165E9;
	Wed, 18 Jun 2025 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750253952; cv=none; b=PmvwpxgBoHo+00D1vGiKn2LoyUoQQtgpnXRIH01Vlnaw2CTfvPZbauTjJoiiewCtQI9taDlxrBPR4+qLnruuKsbGUwlyMzk8Z2TV5BCtAyGMqlRCdoNkhlbzWeEIUTnKvWACgsxuCZg9qzlTSmWkv0XhWPvhGhq70NVxLymfdU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750253952; c=relaxed/simple;
	bh=kZNt/+SoLtE8mbNdVJEgvI/PD3uE96lLdcdgRRVPBj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=roDq7VBw78WtjwIACem8p1yOAW6vDWdbVOPaMKCPhYp4SiInv9JGB7eD4Xxq73QXWTgYiTw4Ss+/qB2EXTA1bu+/k4pyG8CeCmC4FDE4q0asNi1b9buBs2cPPmndAvJlcxoygjgsNYV2T50g1Boriqxar/zEheyUrlL+IQtZDeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SOetsZYA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+e7qUvtH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750253948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Uy/zoObKSkIlcQFqFxyzoY+zrIRXL01SRXNK5uTNq0w=;
	b=SOetsZYAdnvpwkJBClzih9mQmqkd4FPbTWhc8R2uq/t/Xsm3dYGYMNjT+CI5bWW1/U2UzQ
	WKoGTxl/Ggx3y9uHLLb+F+WRfQZ/clLkBvXoypQj2YCt1TJjzpPJXjvEageRzHEy5DSLth
	DUVwb6WSuOgqAnlS18QaROTGrfUU9RnoNsvao/PoURTFKqu1ewyL9Y+Wc0w6ZHEfMNrs/S
	DyPKgznSs/FqHgSv8VJcuyyy+YYs0rFEJlZweJvKiy4AYoqpN+NhIbuT42MxfqBjQbW9GJ
	3gQZKB+3tKMMQbPThZBIozcVSuJqu3f7Ms+KjR0uk0O3RGLjyHX2ynRrpfKANg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750253948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Uy/zoObKSkIlcQFqFxyzoY+zrIRXL01SRXNK5uTNq0w=;
	b=+e7qUvtHU7bYh9SzFdYKVEPD00iccsL1hnRhYDjVxsvxZvMIhJj1ZHhl+q+N+/kbWAUD9B
	jD20gkAKJaaLSXDw==
Date: Wed, 18 Jun 2025 15:39:03 +0200
Subject: [PATCH] selftests: vDSO: fix -Wunitialized in powerpc VDSO_CALL()
 wrapper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250618-vdso-vdso_call-uninit-v1-1-aff2735b6c10@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAHbBUmgC/x2MQQqAIBAAvxJ7TrBEib4SEbVutRAWWhJIf0+8D
 MxhJkEgzxSgrxJ4ihz4dFmaugLcZ7eRYJsdWtlqaZpORBvOggnn4xCPY8e3QESlFpJSmw5ye3l
 a+S3fYfy+H6SKP/9nAAAA
X-Change-ID: 20250618-vdso-vdso_call-uninit-ccc33be00568
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
 kernel test robot <lkp@intel.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750253947; l=2997;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=kZNt/+SoLtE8mbNdVJEgvI/PD3uE96lLdcdgRRVPBj0=;
 b=aPctxPJBORdm/AThaEYQ9zYw32DX6Ah5J2ID0YMeyw8dIKi7iOKPW5lkxWHwH3Ea0MWYP9MYL
 OmP5tDzCW5PDmLZbD2dDuMkejJl5WAB7clmuf82B8ZK4lnvVYquq3u6
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The _rval register variable is meant to be an output operand of the asm
statement but is instead used as input operand.
clang 20.1 notices this and triggers -Wuninitialized warnings:

tools/testing/selftests/timers/auxclock.c:154:10: error: variable '_rval' is uninitialized when used here [-Werror,-Wuninitialized]
  154 |                 return VDSO_CALL(self->vdso_clock_gettime64, 2, clockid, ts);
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/testing/selftests/timers/../vDSO/vdso_call.h:59:10: note: expanded from macro 'VDSO_CALL'
   59 |                 : "r" (_rval)                                           \
      |                        ^~~~~
tools/testing/selftests/timers/auxclock.c:154:10: note: variable '_rval' is declared here
tools/testing/selftests/timers/../vDSO/vdso_call.h:47:2: note: expanded from macro 'VDSO_CALL'
   47 |         register long _rval asm ("r3");                                 \
      |         ^

It seems the list of input and output operands have been switched around.
However as the argument registers are not always initialized they can not
be marked as pure inputs as that would trigger -Wuninitialized warnings.
Adding _rval as another input and output operand does also not work as it
would collide with the existing _r3 variable.

Instead reuse _r3 for both the argument and the return value.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506180223.BOOk5jDK-lkp@intel.com/
Fixes: 6eda706a535c ("selftests: vDSO: fix the way vDSO functions are called for powerpc")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_call.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_call.h b/tools/testing/selftests/vDSO/vdso_call.h
index bb237d771051bd4103367fc60b54b505b7586965..e7205584cbdca5e10c13c1e9425d2023b02cda7f 100644
--- a/tools/testing/selftests/vDSO/vdso_call.h
+++ b/tools/testing/selftests/vDSO/vdso_call.h
@@ -44,7 +44,6 @@
 	register long _r6 asm ("r6");					\
 	register long _r7 asm ("r7");					\
 	register long _r8 asm ("r8");					\
-	register long _rval asm ("r3");					\
 									\
 	LOADARGS_##nr(fn, args);					\
 									\
@@ -54,13 +53,13 @@
 		"	bns+	1f\n"					\
 		"	neg	3, 3\n"					\
 		"1:"							\
-		: "+r" (_r0), "=r" (_r3), "+r" (_r4), "+r" (_r5),	\
+		: "+r" (_r0), "+r" (_r3), "+r" (_r4), "+r" (_r5),	\
 		  "+r" (_r6), "+r" (_r7), "+r" (_r8)			\
-		: "r" (_rval)						\
+		:							\
 		: "r9", "r10", "r11", "r12", "cr0", "cr1", "cr5",	\
 		  "cr6", "cr7", "xer", "lr", "ctr", "memory"		\
 	);								\
-	_rval;								\
+	_r3;								\
 })
 
 #else

---
base-commit: 52da431bf03b5506203bca27fe14a97895c80faf
change-id: 20250618-vdso-vdso_call-uninit-ccc33be00568

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


