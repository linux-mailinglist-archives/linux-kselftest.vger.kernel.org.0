Return-Path: <linux-kselftest+bounces-44916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748C2C3A18E
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 11:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489CB1A458F0
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 10:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A66130CDB4;
	Thu,  6 Nov 2025 10:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tbND+MAM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KJxy0Hu0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57A33148C5;
	Thu,  6 Nov 2025 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423349; cv=none; b=EPjtBltkQ1EjXZBhNYJ8oqwRx/0jZS066TX63YRjtbg6f1fwS+EOuXz8Yn9zD8mogS9ojn4COgW3sHD7r3QIPW4sSpV9qKhEud+2L2kIzsjqCuwFmbDPtBPgIE3WR+M7rxhznsAU+eRDaDT4tsuE4oa3RQnxLdIVh481U2u3Arg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423349; c=relaxed/simple;
	bh=T+uiAGc1CKmq8YVTkteEEzyKwhHBee7QKhXDO+NLJos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mqvJM/n7WLbFBiBNY0G3MI25JkUULmIdeGI24An2hpt1/SCBhK62tnr86xgw2GkPEPZOxN8LZa2FSH7IS82znDl6JMTZ8UK7QFUwV/dd3mKALpYCgqAiVWiuHylI5N7ipMv7dGTSESdUFAtDxQyZETL9yZnHoM1unDrOOTtxpRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tbND+MAM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KJxy0Hu0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762423344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXnY5RDni4beXSbCleFNj0bRZgRx9ddsylJ7nscxaEI=;
	b=tbND+MAMeyx+fk0yJ/fd24KGe5mJWd1cpYUF+EgEy5RSMWNU9wVKBFuZYuVDE0ZKa2FEK+
	W8fOKOfS90fbs7xsRINOdinHo39c88MVnDe5/117liIbYwLgOL/lTECYOP+9IsfjWCDYqJ
	CWfH13aFVOnG27l6AZN+9QhOdCyMcFh7MWNVicil+DbnVZ7IwFynyz9dt7qCBWjMNhxbeW
	GCwDQun6KMhFpv40hsVTFVyhZVASE11p/ufs+S/uqPKRRF9KkWq37UarEwHZkIB9R9XgSb
	aSesWat6wMyC2ENPjNaBUMEQXsfU/nf7vY8MMienT1glPNzLtNaOTk8pSTeg5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762423344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXnY5RDni4beXSbCleFNj0bRZgRx9ddsylJ7nscxaEI=;
	b=KJxy0Hu0nIBB0e3Xqn7BzYWIodf33bvrkshbLjQ3LDFKz2LO6cHs19pUT2WMB6WMI6WIGu
	YulAuRKpCrMmrfBw==
Date: Thu, 06 Nov 2025 11:02:15 +0100
Subject: [PATCH v5 22/34] vdso/datastore: Drop inclusion of
 linux/mmap_lock.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251106-vdso-sparc64-generic-2-v5-22-97ff2b6542f7@linutronix.de>
References: <20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de>
In-Reply-To: <20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de>
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
 Sven Schnelle <svens@linux.ibm.com>, Shannon Nelson <sln@onemain.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762423327; l=869;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=T+uiAGc1CKmq8YVTkteEEzyKwhHBee7QKhXDO+NLJos=;
 b=l/pDlRvM2BSxqqMkxOdOUvUnuXngh23FFVWXSCYQvPR+cRdcuQH2SRNBlbp3Bc8G73DYayDcK
 5pW8XK3eTAaAwV+0g4nLCmb2Ffn03OnxY51ln9XIdb5JvG1h5gFOsl7
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


