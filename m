Return-Path: <linux-kselftest+bounces-45553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C833C58800
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 16:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444894A1EB7
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 15:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D48355045;
	Thu, 13 Nov 2025 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BhBtzjMp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oPUg+Pej"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D48B2F39CF;
	Thu, 13 Nov 2025 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047871; cv=none; b=dsn8RVEv9mMMN0vZ+Y3SZq2l0cqgyP5bqjeKuzk4yr4HR8bBlLFJFN88wNgNNGTDESuSLpTOy/TE2OPaUB3WpnwEeWQ5eZv9k/QzkZBv4nF1W9Q1z88scrSCpQhGe7Ulw+HqBbtbAlXTaTBDXAkc8KNPC9eTJT9jfIWGajElepI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047871; c=relaxed/simple;
	bh=IhZCZpYTEfcsIhUb1OvA+o2aZg+IqFDuCoJX9+mQwCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BCwOEI2hTUYO/iWlR/9VJ7wVQjmNzSsuiLTGB6CugAfENS6Jo4wYnsna+3tFBbDcvkmKh4Dr+n1QNM4pIBdJRwXzCKMddUn4m6CklHK+0uSQmNd1UOM74x6sfKk/i0dKnZ6PmKU1cZJ9T0ctxSS7rFxtfYh/84KhoFBZHNTBVo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BhBtzjMp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oPUg+Pej; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763047868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0mBr7wG1x9Eu1Fb7Qvx7iJnYkPB3hiuiZVSG49/GyNg=;
	b=BhBtzjMpGupW2q68FyRcA6dYu+8mytE/hB6COxrMd3a3qzc8Eye4BwF14P5R8lGso/vWqx
	yD4oWbN5SZu3dcSbqewzwZij/A2YIztnIdsf5moAU5WFm1aKoPxzrMlzDGDLYU+aIEFyVb
	xcbnM9+/oORO76Im+Wm0UZbIfBmJ14Z2DvasMEgXlYN15XKV6hQe5Mi0V9cKI3bIcpk78C
	C90yAAwITNilG7eKLL1ZGDcFFLgmBb6raQl4s6wo2cmPBz0KIVc4t32LcplsXEUqZL+3rL
	XZQnUXH6Ut7GdULbH5IZATUVxmDZB//o9C441UcECN4jZ2n9ag8mzCsTz640eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763047868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0mBr7wG1x9Eu1Fb7Qvx7iJnYkPB3hiuiZVSG49/GyNg=;
	b=oPUg+Pej4n92x+9YIIckuUBMtSyyblOuO2o3y92axdJuKqC/VKNVmEjL1BoOalagUSVh4B
	WCJfdH0SlXYTN8Ag==
Date: Thu, 13 Nov 2025 16:30:20 +0100
Subject: [PATCH v2 04/14] selftests: vDSO: vdso_test_gettimeofday: Remove
 nolibc checks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251113-vdso-test-types-v2-4-0427eff70d08@linutronix.de>
References: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
In-Reply-To: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763047863; l=778;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=IhZCZpYTEfcsIhUb1OvA+o2aZg+IqFDuCoJX9+mQwCg=;
 b=wcVyOKYJVtjeugf7DXLzwHZjavlOPPBnQWiHrJiWLZoJsKj4szXTS9hGsdberS99uBaor8k+A
 toj+2v2rbc0DfFiLHgndLky/boYccYIQNaP43Jn/Y1Z/xpFQTFUC9Jl
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

nolibc now provides these headers, making the check unnecessary.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_gettimeofday.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
index 9ce795b806f0992b83cef78c7e16fac0e54750da..636a56ccf8e4e7943ca446fe3fad6897598ca77f 100644
--- a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
+++ b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
@@ -11,10 +11,8 @@
  */
 
 #include <stdio.h>
-#ifndef NOLIBC
 #include <sys/auxv.h>
 #include <sys/time.h>
-#endif
 
 #include "../kselftest.h"
 #include "parse_vdso.h"

-- 
2.51.0


