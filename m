Return-Path: <linux-kselftest+bounces-38752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4E1B21CF5
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 07:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F0B681E0B
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 05:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6DA29BDAE;
	Tue, 12 Aug 2025 05:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZD7hDHnj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D7IdwDVL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4362028B7EF;
	Tue, 12 Aug 2025 05:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754977157; cv=none; b=Dv/ENSVquZV3WMcJXjNtIbNcoGnzQVIy3ygl3f1r3d541slIdtF6RN+xzxafsdtYI9J8rHn17T31jBZEyAMeapO4luuSjHpuJP/S1WM/CYM3Zf2RgNDutMibV5cXV5iUJzkap2cAz1CzWdmbRgYOf2m4va285FMG0thyUNHryQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754977157; c=relaxed/simple;
	bh=QrlHtet0JRu7nFXpAhs1+5+M+BKn0zdv3choxoyODIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vog5iNRoy89AVszYJDcqrOmZ8WFAgBLcBD5ossRsuPVJSSEQUKFJ7/uDylqU1Efuzc/Gt0cjudXgtorMVrFBaTNvoWyZ5Zt43hDaJ7Xu9L9sGFPCa8SIm/aACXzLmiWzOUR2NlD0wYqAO/JfToDdbCTHvsmBNPf0tflSmYi9w6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZD7hDHnj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D7IdwDVL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754977154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5qZ9MFGSNnbL4P8AdyY5Ik7ybFfv9o7yHGW2eLboNJw=;
	b=ZD7hDHnjZMOIm00yOQfqgAKDUFMXLm6dY4+MWqvhp/2hNjYIzyK7fKxF+OxB8Dhw7T+aWd
	sxcq9P6OmcppL1kytpTFX8p29fPjYUMj+Lf2xu0ttZcYv9ia5MdpmLVuY0Zo4uPzw2U2G6
	6u5L5VpivGWY5Yyr8omImqpWUYjun4IrWpVXWZe1nrThnHELX2n+Af78cquNexuKF/rn6J
	PVY2oDfnqN+7CIDy4yWEty3GMN6Y89fZ7+LhZDSkOW1lnOeoJ+Qyx+on2aLzfGsoFhgDQr
	l5wtNRvr/vchHE17EbQYDKvp7Wt4cxC2U2QyjKq+4mYHA6DNKur3lMqbrhidbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754977154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5qZ9MFGSNnbL4P8AdyY5Ik7ybFfv9o7yHGW2eLboNJw=;
	b=D7IdwDVLJ17shv1oM3ZQyiBryy/29fwOEhXTO4TMsQCbLH1N0Z/pHpCXmrVj2DgJFIueB5
	Jj9EQie0gcl2nRBg==
Date: Tue, 12 Aug 2025 07:39:02 +0200
Subject: [PATCH v2 1/8] selftests: vDSO: fix -Wunitialized in powerpc
 VDSO_CALL() wrapper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250812-vdso-tests-fixes-v2-1-90f499dd35f8@linutronix.de>
References: <20250812-vdso-tests-fixes-v2-0-90f499dd35f8@linutronix.de>
In-Reply-To: <20250812-vdso-tests-fixes-v2-0-90f499dd35f8@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 kernel test robot <lkp@intel.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754977153; l=2819;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=QrlHtet0JRu7nFXpAhs1+5+M+BKn0zdv3choxoyODIc=;
 b=6hS7C4wxnaTrYBbWrmH3kvLNURxJ61FT51N/WVlBUbAkXjn8DXQmvf14RLKWmDPOOESNP0F4r
 zMDuFxVVOMBBAGkYIHfd5zgNmpbj7A+W0fOcH68u2NC+Sgzex8STTf4
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

-- 
2.50.1


