Return-Path: <linux-kselftest+bounces-34682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96367AD5214
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5D91892C9F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 10:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6D6276021;
	Wed, 11 Jun 2025 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1R1+niYs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5mIg0vC8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA0B272E57;
	Wed, 11 Jun 2025 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638045; cv=none; b=PtVlA9qxppj5W2KyKp8DRLB0f69ufAOrayi1HTy3CKDBFz8B2tIbFuZW3TNVZDW3KiB6/9aesHDXJcdw1xn9HTM6pUta/XL//DuxyNU5rmPXuaf+epz5Bl1xZNUtZfncsXRp48Uh4MBJLMrYtj7/w7zoF0O7Go+c/ZKWb402SQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638045; c=relaxed/simple;
	bh=Rqf9Ybql9mWv2FDqbi7vecIXl64pB64/atVfT6XP3fg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OA6sQ8zTgo0pB+/j7o/C75+VSwA76JqEz8XorV27wRfaJGzGzUaJ3wAA3n5WzVFE6wzDyA75Jh0flM/Upt0qme7i3m4zCoTk0jUtJdrrmpF9f10djmGG3oBiwSVgStjmziDsXV1fGv8H5djgDuOvqDwK8REpvc8oaPTH1EQH3jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1R1+niYs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5mIg0vC8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749638041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQzNOCNFp/mc7w++e/8s7o1Kxroe/aW5+25iJWwhE3E=;
	b=1R1+niYsJOpAcmSTL4zwBAeb5vbYhaS3ncEM0bRyPrkfCsFVnJAuUW0Tw3f5nnfMvp7EMm
	IdERlVOPRTmxqBpzQKpUcPuQ4uuaE3d18QF+e1FER/8iRE7aUhZBg3IZ7fsfXl+qZ9M55q
	rNiMvpqdfTbknwKAEFosRFr3ZHCKZ3K0XjW0Vr69K/+y8kfcq0DeVm7cpny+uON6WKi64q
	n2wtdQJON2Cbx3lyv+9lQfEcy9OAeuXjrEJ2+NL/rU2q+OYk5RPiX7pQuSSQ68PV+IlbjA
	AYzUpy80nnD2l1AWbEtTW0jwXZpOF7sV7wGCDp1d+zdk9kWJuf3ur2RQh7YHCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749638041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQzNOCNFp/mc7w++e/8s7o1Kxroe/aW5+25iJWwhE3E=;
	b=5mIg0vC89Cau+cAzyxsDzA9XUX60QlrppTX+f80qox8opRNpo/K6HaNMxIwYWx2kmhGKb1
	jk8+3wtMs3/ptbAg==
Date: Wed, 11 Jun 2025 12:33:53 +0200
Subject: [PATCH v3 3/9] selftests: vDSO: vdso_test_getrandom: Drop unused
 include of linux/compiler.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-selftests-vdso-fixes-v3-3-e62e37a6bcf5@linutronix.de>
References: <20250611-selftests-vdso-fixes-v3-0-e62e37a6bcf5@linutronix.de>
In-Reply-To: <20250611-selftests-vdso-fixes-v3-0-e62e37a6bcf5@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749638036; l=887;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Rqf9Ybql9mWv2FDqbi7vecIXl64pB64/atVfT6XP3fg=;
 b=BpcwGLKithkwEOVSXJ+vw7OPYpLnnW7eQ3LgQK33tusVaqC6fsCdVBjuKDeQkS8vCbUX1WWch
 FXc7oIHbUQqAM/w77FFsW7z3uw20IE8Oxy4UYLyPjAc54xyelXZ7lly
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The header is unused. Furthermore this is not a real UAPI header,
but only exists in tools/include/.
This prevents building the selftest against real UAPI headers.

Drop the include.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_getrandom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
index 95057f7567db22226d9cb09a667a56e387a33a46..f36e50f372f935e6d4da3175c81e210653bdce1d 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -21,7 +21,6 @@
 #include <sys/wait.h>
 #include <sys/types.h>
 #include <linux/random.h>
-#include <linux/compiler.h>
 #include <linux/ptrace.h>
 
 #include "../kselftest.h"

-- 
2.49.0


