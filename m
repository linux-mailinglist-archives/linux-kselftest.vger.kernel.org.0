Return-Path: <linux-kselftest+bounces-27601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4405A45D86
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 12:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD173A8FBF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 11:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9EA2206A2;
	Wed, 26 Feb 2025 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i07d6hLp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aZ0cAhZ3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D765D21CA12;
	Wed, 26 Feb 2025 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570320; cv=none; b=qz3wOZ/mdHyfK6/GIVYMQx7+f7pt3EsSDSG1cy8B4jL6PZqlsKKibty36HhJebTeThfq0Ioa+Ky4C1saWT4HACBMNfK2bpWTA0BOBP0xku9e7GGJ7mTZdczVXYiI3wVZEEtvi0NTyk8GTIy0USe4sNtsotLTr3KdbhxeyUGQq6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570320; c=relaxed/simple;
	bh=tbmVgPy5yB8VdfdnJ4tJow8kzco/2Q3QjZOCjC6QEJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mjyO2qyA64NlrsZvdBbSKxDsHARiVoci2nMMQ1PBwohWfq63epLLOyB5ZE8ati3cmxAoEXRkv+gsh39X7B9KTzdZYzc8b1iesygvVWVjdpNdmM0CRx5DvTxJpmRuMyznNQH5zeGZwPEa5HFyrJsx7euFge+iCBDRr0DD4cxVwDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i07d6hLp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aZ0cAhZ3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740570317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Frurs6AseTy7r99TUsr5RPDF9RZSrY1kmlW1JOY/EA=;
	b=i07d6hLpd8GRg/0WO5Jpo1GY+NkHlsL1doz1LXrPNrHTjVuF3KVkhCjK0VrhySrSxv4HSB
	qefSAed7+5iLZndx789yLs2chd71BICnRokDw51tpySQvtOQGSOX3Zozp/ngVM7uDeZ2o4
	WaH59GBm/Som63p3aIfI9IsPiJfn03k37LbhZKPnNKycT6ftsHPyZZuuP0T5QoA26b/inI
	m0EOk6g19wrq/nmG5yn1T9ZZtcohpUsWiRo3wF/oqsKR4ChAygYS3PGha/Fz5kD76gANjw
	yKl1PPjmGXei2aSFksZQsyCI8Z0jgHq+Pad4HGy2Vosa5yzRudA3yRSSY1pT9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740570317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Frurs6AseTy7r99TUsr5RPDF9RZSrY1kmlW1JOY/EA=;
	b=aZ0cAhZ3vtmBKcWcSDLdrI5iL4bR3GxRXgPx2FX5cDJbHZNPpQjmNDpY4nIdUEQEOb02+u
	J6umpPJpSs00G0Cg==
Date: Wed, 26 Feb 2025 12:44:54 +0100
Subject: [PATCH v2 15/16] selftests: vDSO: vdso_test_gettimeofday: Make
 compatible with nolibc
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-parse_vdso-nolibc-v2-15-28e14e031ed8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740570307; l=882;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=tbmVgPy5yB8VdfdnJ4tJow8kzco/2Q3QjZOCjC6QEJI=;
 b=i7Uxstabjdg7j+J9zoPP0U58OGXCZjkCegWTxPjKC3TGUAF7tp+8mShrhr+dffxZi3sMXHudr
 +5QpKEY+MERBDeZT4FYzTLcqudiLXqH5aJAYMfkHsNZZ3oltA+l4BMP
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

nolibc does not provide sys/time.h and sys/auxv.h,
instead their definitions are available unconditionally.

Guard the includes so they are not attempted on nolibc.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_gettimeofday.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
index 636a56ccf8e4e7943ca446fe3fad6897598ca77f..9ce795b806f0992b83cef78c7e16fac0e54750da 100644
--- a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
+++ b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
@@ -11,8 +11,10 @@
  */
 
 #include <stdio.h>
+#ifndef NOLIBC
 #include <sys/auxv.h>
 #include <sys/time.h>
+#endif
 
 #include "../kselftest.h"
 #include "parse_vdso.h"

-- 
2.48.1


