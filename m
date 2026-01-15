Return-Path: <linux-kselftest+bounces-49033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF1BD24D90
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 14:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFCED307156B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 13:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEC13A0E9C;
	Thu, 15 Jan 2026 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c3SjWwFL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZYpIqDvV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E014C38A715;
	Thu, 15 Jan 2026 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768485422; cv=none; b=oVJ8p7ApNsSfuOEjX5PQgOyZRRKQsWIuGbP2iyj5TquWauG6j9SIldRLtZOg04iwyCG7rLGOqQyj1AyrGTWDHV0D3XnmZRrTJkAirlaeS3kLQhNZ6HpkjUM+aKG0h7fIGKN53y5GxGwOyJB1xW8JNhGPKBOBZsrArc04kcK3LR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768485422; c=relaxed/simple;
	bh=xnBk4++j8iadegOBxyQHNrq1ZuM/cEYaTI2boxx1ESA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KAM0WtRlRckOG80p0W3PvU9hzOpBJXT7yHZHINLis0LNl5ub/d7cdSICrIK798UWbhkcecxiR/1dyrsA3ufOg1aZ6Js3vChoJoN0GZBWeKb10v6iNOVuQVB6QyFePfPMt2S7vvwyu86+WsVLFJGyEjUg/yyilZOeiInejnJWp9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c3SjWwFL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZYpIqDvV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768485419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ioaoVuaJfEQ5EGbTDdqs+MOF8tJucsIZuUVx2o5zi+U=;
	b=c3SjWwFLW+aNmMx/JzMp1Qoju40RZE91mSAy7mNlhz862WjFUgIOP9XcwsM6+zFvSNXgZM
	SIlFW3Y47cAK2rsLAcm9SVaeLkWohLrv13m4bVrHoEWOH5PIJSDa7ctFLAsy8ovBNweZ01
	AD1c6x+MFuX2Dq86VdAGwO4iD5xh5TTTiCMARMgJlpq8MWladZpgsUanF6i1w28r+BHIRZ
	gXzgQCYsURQD5pGof8gCnf97HGG/NjSfQptQ2pFkUlQHz1neDw/cvhr+pPpPDvE78XKqz6
	6dLl450fYjI95brKvYXViX8474aK1RbbWTSpW+SZZUOoEzPC72yOQ7cjBbE2cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768485419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ioaoVuaJfEQ5EGbTDdqs+MOF8tJucsIZuUVx2o5zi+U=;
	b=ZYpIqDvVf1R7143yT7F6tkahFcN4NJqjG/oYAn/GK34dqNHzmvDWJQ7bOl+U5w5DKqsi3K
	zdXy/cX/qlHjOlCA==
Date: Thu, 15 Jan 2026 14:56:52 +0100
Subject: [PATCH] selftests: vDSO: getrandom: Fix path to s390 chacha
 implementation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260115-vdso-s390-getrandom-v1-1-771dfa6d1c6d@linutronix.de>
X-B4-Tracking: v=1; b=H4sIACPyaGkC/x3MMQqAMAxA0atIZgOpUkWvIg7VRs1gK42IIN7d4
 viG/x9QTsIKffFA4ktUYsgwZQHz5sLKKD4bKqoaMsbi5TWi1h3hymdywccdfU0tdXaeHFnI5ZF
 4kfu/DuP7fpKUNe5lAAAA
X-Change-ID: 20260115-vdso-s390-getrandom-d307095cba05
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
 Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768485413; l=1187;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=xnBk4++j8iadegOBxyQHNrq1ZuM/cEYaTI2boxx1ESA=;
 b=frHUIFnC6Ig/7O4r7tFxrauctZPMp4OZLvv3KFnCGMWVZb/UzRHMFJ49BN7P4bBqigC8KWfZm
 reeaPisGLOIDx/02apjbMjy2lImulZVF99l1I1fZ/OkgCyPfA0qAvfw
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The s390 vDSO source directory was recently moved,
but this reference was not updated.

Fixes: c0087d807ae8 ("s390/vdso: Rename vdso64 to vdso")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vgetrandom-chacha.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vgetrandom-chacha.S b/tools/testing/selftests/vDSO/vgetrandom-chacha.S
index a4a82e1c28a9..8c3cbf4dfd6a 100644
--- a/tools/testing/selftests/vDSO/vgetrandom-chacha.S
+++ b/tools/testing/selftests/vDSO/vgetrandom-chacha.S
@@ -14,7 +14,7 @@
 #elif defined(__riscv) && __riscv_xlen == 64
 #include "../../../../arch/riscv/kernel/vdso/vgetrandom-chacha.S"
 #elif defined(__s390x__)
-#include "../../../../arch/s390/kernel/vdso64/vgetrandom-chacha.S"
+#include "../../../../arch/s390/kernel/vdso/vgetrandom-chacha.S"
 #elif defined(__x86_64__)
 #include "../../../../arch/x86/entry/vdso/vgetrandom-chacha.S"
 #endif

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260115-vdso-s390-getrandom-d307095cba05

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


