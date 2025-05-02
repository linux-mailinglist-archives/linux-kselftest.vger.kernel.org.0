Return-Path: <linux-kselftest+bounces-32188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6FBAA724D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD204C38C8
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E47825524A;
	Fri,  2 May 2025 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vxcB5FPb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z7gGEHJy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EFA254B01;
	Fri,  2 May 2025 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746189627; cv=none; b=fohZPapEK8xb4zh1BDUTjiHpBCKHEiwKW5KP2BFTfOZCNpbEuA89cX/Trc3wspqTA4eJKayGq2ksEtqQdGCLbNwLhudFmZoqlVb5y8UoLiUzqv4Md7Ucf2njYGCfTKZLZNs6fABaH+tloHJwnllGnQTa44HRhBvkT1P8tFrqgWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746189627; c=relaxed/simple;
	bh=Rqf9Ybql9mWv2FDqbi7vecIXl64pB64/atVfT6XP3fg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sacoPzFRDooGQ3dwuBH89XCP1raC6tb/ylGi1FxC6wtzfFbkwmInf1KKsxFKtROATG1NcmIwXe8KWfKIKO8wfNPvr+XyZNJQX454yKAKmW33ZHUvajXOujWzvjnWodF22PO+ybkiev29+Utcq5SuNoG7Z2T4+M2ZhCf4gDeh2GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vxcB5FPb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z7gGEHJy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746189624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQzNOCNFp/mc7w++e/8s7o1Kxroe/aW5+25iJWwhE3E=;
	b=vxcB5FPb6FIIELJ+mypUCnbg43pTODm54CtWTuKq3zeIiqoJUfU+zaxbasPxHATiuTwViE
	Tf2eSwcQmd0vkHyvwkjSYc0IwhT9NY2cGa26kAQgIQybhuR1mfP8Edc/mDelSJHoj87nj9
	X2oNvopl5SsDbx+ADpU47QmnOOntlaynUDV8gbci01f3pt1gKCYReBTT62w2M0vPCnkJ5Y
	z+pHKV2iwQRxcw3O5IvwVSlvP+0qxhbhdBdNtwRMqyWP9gtM/0fHoys5RAsYMdznhUYpWx
	AFlXY7vidTrQ+xUDX3U8cqZxLSPRvPkwyzWFDkvJ6iqCvF2jcYqXRbB5qriOwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746189624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQzNOCNFp/mc7w++e/8s7o1Kxroe/aW5+25iJWwhE3E=;
	b=Z7gGEHJyYdHFwONfzvffrwmhG/AsUvUmk16o5GtQwxPnzyC3vYbgFFRkcKPfHjhe0ltSgl
	ZxsGvwhjI0tmxXDA==
Date: Fri, 02 May 2025 14:40:16 +0200
Subject: [PATCH 4/7] selftests: vDSO: vdso_test_getrandom: Drop unused
 include of linux/compiler.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250502-selftests-vdso-fixes-v1-4-fb5d640a4f78@linutronix.de>
References: <20250502-selftests-vdso-fixes-v1-0-fb5d640a4f78@linutronix.de>
In-Reply-To: <20250502-selftests-vdso-fixes-v1-0-fb5d640a4f78@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746189620; l=887;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Rqf9Ybql9mWv2FDqbi7vecIXl64pB64/atVfT6XP3fg=;
 b=ProtjfH2x3FGS6C4KoEv+s812KTiGnrCt/YxkgmN5F5XJ2E9QGofSyukkpis32AU8RshTji1b
 TfCk+TB+c9MBw0aNFMlyLHNrJnKyR252uAJVLtGzERWKvLph+oYutx0
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


