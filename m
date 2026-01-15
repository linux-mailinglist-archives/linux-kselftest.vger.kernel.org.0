Return-Path: <linux-kselftest+bounces-48995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2097CD232DD
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 09:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E7533112D29
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 08:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82E42DAFDE;
	Thu, 15 Jan 2026 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gnHN9FJn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PKCvkpui"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB20335BBB;
	Thu, 15 Jan 2026 08:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465811; cv=none; b=sSCHLhdKKUozKVujcJnf4LD+X61gtsgEiO9hm5l61ULboUjVYXma2kYUdFxVC/HdStVGRSS5CK/ecR2J+Pif2Syhz3s3Zy62eUqwecHBajiRhI6/OHs10V76w7DJwqz5Wis9KzNfpj/sLEXSAjao3KjFt9hrfWcpiXTMGC0RUGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465811; c=relaxed/simple;
	bh=ZETxfq7n2DPqI0spm6KBNywIJerE0qImcjNxJ2mRPO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eQZUZWCtm+uIpPM67ZMnCHR+V7SiTj/aTzIB+pLUuDqRM8t4QF6N1wi3GHptjBcH+rKzyuk0bIkdiXGlvYM2LNpl7kwYIThYjKpHnznSiy2L/RsFIq9ErNggE8rljXwZ43IkWbmw26LvmwPNOkKRBI0/oPEW6paA087wipJv4x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gnHN9FJn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PKCvkpui; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768465801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hCYJf6bn90uM7fZf12d3m2XhGe/TVg9oCIF9d52fnDk=;
	b=gnHN9FJn089Jq7Eo1HeQqDS5NNC2/dkvLRreHgvDF7NxMVF4Sw4mB4GDTg8+FScQZ9DChW
	LjOZT2PqoDphkVGJOItHhztbhCKJY2CzxkpZx1du3XCMU57iPVLGAKGCQSGTMiZvozFThw
	KMQ8fomnfy9IN/Vc96OSNHUfwC4gZHksTAqs2KoDnAwKR5IQvD69s/LLpKFJ1wYlHkCRxl
	j4G7991CEak4wcvpji1V6c0C2jBpUHE9bPCAIdfGmyCIBbYAYW0cMK8tJre7skEIPNBS2t
	heppGG/cPWGRDrjFBh29JvqTbPGo7hyalhPviosq+vnJWHgnm/PVdmzvyIvlpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768465801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hCYJf6bn90uM7fZf12d3m2XhGe/TVg9oCIF9d52fnDk=;
	b=PKCvkpui59OKXdmNQpJ86a42OWXomV5MSPvRcMp+nYJI3QIeJYeRha+yuRoQ3GSf9zleR/
	Wn+aYn6CpIMhxXBw==
Date: Thu, 15 Jan 2026 09:29:54 +0100
Subject: [PATCH 2/6] selftests: vDSO: vdso_test_gettimeofday: Remove nolibc
 checks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260115-vdso-selftest-cleanups-v1-2-103e1ccbfdc3@linutronix.de>
References: <20260115-vdso-selftest-cleanups-v1-0-103e1ccbfdc3@linutronix.de>
In-Reply-To: <20260115-vdso-selftest-cleanups-v1-0-103e1ccbfdc3@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768465799; l=719;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ZETxfq7n2DPqI0spm6KBNywIJerE0qImcjNxJ2mRPO0=;
 b=6+5a2g25nQzm9LJh+bTgBhNHPFZrQ7q7/ccA3URxH2CYaOEG9VXWRbSf+2KOO2yTRxQ6sDSOR
 2otp6WwfbzaAeFujXazAXhp978RIA78r0mvMiNEataKoLm0Tx2cuq7W
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

nolibc now provides these headers, making the check unnecessary.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_gettimeofday.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
index 912edadad92c..990b29e0e272 100644
--- a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
+++ b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
@@ -11,10 +11,8 @@
  */
 
 #include <stdio.h>
-#ifndef NOLIBC
 #include <sys/auxv.h>
 #include <sys/time.h>
-#endif
 
 #include "kselftest.h"
 #include "parse_vdso.h"

-- 
2.52.0


