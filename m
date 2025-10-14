Return-Path: <linux-kselftest+bounces-43096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC863BD7BBF
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 08:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33A719227E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 06:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6A430FC08;
	Tue, 14 Oct 2025 06:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZQ0CyCv1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lLzILQ60"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B9E30E0C0;
	Tue, 14 Oct 2025 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424566; cv=none; b=BtGYF7wEwwIKW/0CsItHUbK0oJp8kiF+wSYgAPYg6wnk3jdeJOgVXjvaGPa2Q2OGCylrPhVe7yBiZNlUUHYJqkqwFbn9fFXm2e+BoSqDlvCey+xzESbw2TRro5zU9QjQr44hgIbSR2Fkatn0c0pGHTRFP1/9bTrU+ibWTsxPQJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424566; c=relaxed/simple;
	bh=T+uiAGc1CKmq8YVTkteEEzyKwhHBee7QKhXDO+NLJos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UWpXgapJ8PqkWW+MBcOW4TyxpHE+ofDXKTeRmS91fI+OCYYil3aHhAGjvcfFj2g3iGxjowvjXwXcL5pOa5Vx0m2feSODwJLtQUf0rUQvzXaV1f2j0ZCELLrTX2FbiaJjMWWWag3ynoQpt/Y4PGehId8k+tUCFTId4tnYNl8/28k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZQ0CyCv1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lLzILQ60; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760424560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXnY5RDni4beXSbCleFNj0bRZgRx9ddsylJ7nscxaEI=;
	b=ZQ0CyCv1WenXTHgZMKp/bzDmotlAcjP5bsSdAqA/LXlpr+FAjTg0nxel+makNXbfIneARv
	HuyT/guyKl0HzZD7zgtTTmsDBuuPis3abU0QfakQUh57efHQRg+FiJ6FvSXBeqBx6zRobR
	rU36ouOPur3ypyyoMhYn08Cw0yeVs3eKclUryWubUlukrIeTj0/FBFXRqL0C3+jMi/a9k0
	X078Vih9EDYeonFd83wbK0SpFw+40tACcGrCIMKKqNanOzUavjgns2y0NeefraMc6KhBX/
	y59GsaINWJs4XtTbiRrZdsIwPhhjja/eA+IdQcEFZKAooj1wEwLVE21Oc0wgKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760424560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXnY5RDni4beXSbCleFNj0bRZgRx9ddsylJ7nscxaEI=;
	b=lLzILQ6086Ns9BC3W/cwSHPVvrTh305P2V0mKp+PzeSEbKKdm7n1fd0Snjt0N9cgrKzY1z
	rhXJTpTBro2kU1AA==
Date: Tue, 14 Oct 2025 08:49:08 +0200
Subject: [PATCH v4 22/35] vdso/datastore: Drop inclusion of
 linux/mmap_lock.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-vdso-sparc64-generic-2-v4-22-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
In-Reply-To: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Nick Alcock <nick.alcock@oracle.com>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Shuah Khan <shuah@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, 
 Shannon Nelson <sln@onemain.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760424546; l=869;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=T+uiAGc1CKmq8YVTkteEEzyKwhHBee7QKhXDO+NLJos=;
 b=03aN3q85VKM+A/8EJFoM6MGLfUSm8KAL+rYYl60MFXYALJNsNTZWO+3qq6gCMNS4G7Qdob9wN
 ikNxdnMFJIiCMshc2FJygl5nF+NQGnjZoaNd21066E5BOXNtCNLGw0n
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This header is unnecessary and together with some upcoming changes would
introduce compiler warnings.

Link: https://lore.kernel.org/lkml/20250916-mm-rcuwait-v1-1-39a3beea6ec3@linutronix.de/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
---
 lib/vdso/datastore.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index 2cca4e84e5b5e7686d6a2b42b41af4f399cc5261..7377fcb6e1dfe31d02ffcae371fdf9da069ae4c1 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/linkage.h>
-#include <linux/mmap_lock.h>
 #include <linux/mm.h>
 #include <linux/time_namespace.h>
 #include <linux/types.h>

-- 
2.51.0


