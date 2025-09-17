Return-Path: <linux-kselftest+bounces-41708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F393B7FD88
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 16:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4BE543B26
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3513D2E7F20;
	Wed, 17 Sep 2025 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vYy29jAZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8rpn2Bjn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7D02E5B21;
	Wed, 17 Sep 2025 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117732; cv=none; b=rHLvxZNFrSPRH/angpeOuPSTnKt8Oa4IMhfe1zmLLmqZaN7OruIV3Z9E+aNTHUFDgjnxTZNlYO8s3dUGLeRCHkDlvckkhSjPI5TeZtG65XxuB1hVPUbRFq/z/kdMRJyxGq6Av7TN7+vcIKSnoe8lAHgearhyhVjdFEiCmlv1JsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117732; c=relaxed/simple;
	bh=wJ2ZQvnRu7lReSnB3moga2OR6vDIxnQa442GGRRHccQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gjdoRO7XAJJ3lvW7NbdQklhwnsSkdktl9UvH9PdepaBg6KG2FHOUGC/kaHcfrRTIT7UTxeBKxtvhcpdjAfhzV8fVESe6IQ8/0vtVMlEmk+176Oqh+NwhSCTBqb7h1AFuglx5CWoKd8kHwY7/aYsSJqYdlO+E4J3SkDDrGJBQgKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vYy29jAZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8rpn2Bjn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758117725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7aeGdc4h/xbTU28LGIZWy8TrSPx7BLpfWZuTxuR8H4=;
	b=vYy29jAZQnRR5kkZwIC9/NqHVRT/v1e2p/cWs+5f7g7fNNC/qoT+53uKFSNXNXsKpN8B2E
	m+3qCLLbTTZ4+Q96GqGryHaf5zSkRuKSrLOv7JNnwp/ax9lb75MCIt7UbsTlifunq53XTQ
	B46ki2hXNpwpzRE1odnOnVvVzvtZoGaksRKLigLO3C4JTMPhUMIipfkhqk+D3ihmvMV4vl
	Qgeomg1DaO3T2zUH8ztRienoHkEnpRBu2zZqtaT43Cw/vXV7Xeom7hcqtVDV/wqkpkDpmo
	aRVRkGuzAn/IPoV9lK7w3+GPH9smyZ20TYSXiCbrIviD1Kg2xx7cUNP1q+dATw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758117725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7aeGdc4h/xbTU28LGIZWy8TrSPx7BLpfWZuTxuR8H4=;
	b=8rpn2BjnZVsb8tPf6dmKjqucj8fOf5/3u7+hCpbjStyZMv/tfE9fcq9R0uNWBv39P6QgxG
	B3rJO306ctdpmgAw==
Date: Wed, 17 Sep 2025 16:00:23 +0200
Subject: [PATCH v3 21/36] vdso/datastore: Reduce scope of some variables in
 vvar_fault()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-vdso-sparc64-generic-2-v3-21-3679b1bc8ee8@linutronix.de>
References: <20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de>
In-Reply-To: <20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758117712; l=1194;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=wJ2ZQvnRu7lReSnB3moga2OR6vDIxnQa442GGRRHccQ=;
 b=K0LFnuU1SD/ZvOVTq6nddMBtV2MFVwXdiwVEqfkJP7aZOr/CzMJ7BNdx4j5egkqUW+ECu+RO0
 nzTKkm9h79bBlr1IYgrhBtUrkRW+sWDBvTh59Nbyi6vQt3hEpQrsVjR
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

These variables are only used inside a single branch.

Move their declarations there.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/vdso/datastore.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index a565c30c71a04ff4116c14f43f4450210eba99c5..2cca4e84e5b5e7686d6a2b42b41af4f399cc5261 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -41,8 +41,7 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			     struct vm_area_struct *vma, struct vm_fault *vmf)
 {
 	struct page *timens_page = find_timens_vvar_page(vma);
-	unsigned long addr, pfn;
-	vm_fault_t err;
+	unsigned long pfn;
 
 	switch (vmf->pgoff) {
 	case VDSO_TIME_PAGE_OFFSET:
@@ -54,6 +53,9 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			 * Fault in VVAR page too, since it will be accessed
 			 * to get clock data anyway.
 			 */
+			unsigned long addr;
+			vm_fault_t err;
+
 			addr = vmf->address + VDSO_TIMENS_PAGE_OFFSET * PAGE_SIZE;
 			err = vmf_insert_pfn(vma, addr, pfn);
 			if (unlikely(err & VM_FAULT_ERROR))

-- 
2.51.0


