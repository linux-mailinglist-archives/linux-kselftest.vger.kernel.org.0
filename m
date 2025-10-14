Return-Path: <linux-kselftest+bounces-43097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A03BD7B59
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 08:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4593A423270
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 06:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A2F30E0F9;
	Tue, 14 Oct 2025 06:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dva6KHun";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CePrGsnF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1206930F7E0;
	Tue, 14 Oct 2025 06:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424567; cv=none; b=anZ4trZUs2ypIRJUkNogttznZ5Lg0k2wO/gKW56MWnlFWvxmlVexwhP3E2i/vR2+XJUjZcN3gZDUlwAqFzBDfozwtpPCKNSai3Z8hP2/EisTt9FB8td3Kbuhxm8srMa49abBObRj9z5f51l6tTbplDFVLpqx4xG7c/QhawXqZyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424567; c=relaxed/simple;
	bh=GlpQP2ovZSCDOGxS8s5nj5uE5YbM4kkpY+anU8ERtBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K5gplnh0sDz5mMrxgHOScnnFGCM8hK/jVfqyMja7gUdTvP6acxMdEybUE/dkXPl7k8ZD2nSIvyYVtjAbyg/1E+fVgm/KuLGV8MNGUyka5X9BakXZtquWJS8+LeuvCiVZh4CBuZ9RHjqFEPOac/DAV3f2sBOwQZn6IjSb27eWaeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dva6KHun; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CePrGsnF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760424561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iK+MuStgP9LYq96Rw1QlhWknm6Ic3/FbgcY09qE0/8Q=;
	b=dva6KHun4SHZO3CF0DWTyYjZwdzjdid0XSRCDNGvJUWgCdmeGxbOsrxLhNX3UbIBShWuqi
	wkV0v7v3WdjaVC3aO6ViYdnY+bPmRdZ2Kp6+30TTx2Xc0DA4jrZqvAEN/9WmEVLe1mpeRB
	Rte2dFCf1AvS+QkU8CSjrMPiILunOoWeBxlYuaMFL+dHEkvNvtLoJmMxdqvapC0bdfHWed
	arFPykJD8FkOqyoPJOeSzvxgOLxpymV61rc2KQ2e6tD04xR+3ie46qNUoo91lAigZnxL8M
	LSSBXSvQ3BJZ6SpuPEQi6psL140j+xMxWwaBcTNkhu23yipVJ+F7XBDXriU2Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760424561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iK+MuStgP9LYq96Rw1QlhWknm6Ic3/FbgcY09qE0/8Q=;
	b=CePrGsnF1VwArn9P+Buz8BoLT1mEbMIt82mCzQVb8ECz0JqgNWwt/DxTO1p3wduT/t2KdA
	galRONxNndh6qKBA==
Date: Tue, 14 Oct 2025 08:49:09 +0200
Subject: [PATCH v4 23/35] vdso/datastore: Map pages through struct page
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-vdso-sparc64-generic-2-v4-23-e0607bf49dea@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760424546; l=3383;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=GlpQP2ovZSCDOGxS8s5nj5uE5YbM4kkpY+anU8ERtBk=;
 b=9srfjekW0ACLWEnnbN460RbJBa5iFjAY5gkDai4i+4epl7bSlqGXV5PRxJsd46eKGlWW/VJSD
 0c+mk+hSEp3Dt2g0aBiJd9xPp6FwZoqr3G3E388Uc7M0MdIDPabWt/m
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

An upcoming change will allocate the datapages dynamically instead of as
part of the kernel image. Such pages can only be mapped through
'struct page' and not through PFNs.

Prepare for the dynamic allocation by mapping through 'struct page'.

VM_MIXEDMAP is necessary for the call to vmf_insert_page() in the timens
prefault path to work.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
---
 lib/vdso/datastore.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index 7377fcb6e1dfe31d02ffcae371fdf9da069ae4c1..6e5feb4a95b85f5a1cbdced7cdeddc593fcbad40 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -39,14 +39,15 @@ struct vdso_arch_data *vdso_k_arch_data = &vdso_arch_data_store.data;
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			     struct vm_area_struct *vma, struct vm_fault *vmf)
 {
-	struct page *timens_page = find_timens_vvar_page(vma);
-	unsigned long pfn;
+	struct page *page, *timens_page;
+
+	timens_page = find_timens_vvar_page(vma);
 
 	switch (vmf->pgoff) {
 	case VDSO_TIME_PAGE_OFFSET:
 		if (!IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY))
 			return VM_FAULT_SIGBUS;
-		pfn = __phys_to_pfn(__pa_symbol(vdso_k_time_data));
+		page = virt_to_page(vdso_k_time_data);
 		if (timens_page) {
 			/*
 			 * Fault in VVAR page too, since it will be accessed
@@ -56,10 +57,10 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			vm_fault_t err;
 
 			addr = vmf->address + VDSO_TIMENS_PAGE_OFFSET * PAGE_SIZE;
-			err = vmf_insert_pfn(vma, addr, pfn);
+			err = vmf_insert_page(vma, addr, page);
 			if (unlikely(err & VM_FAULT_ERROR))
 				return err;
-			pfn = page_to_pfn(timens_page);
+			page = timens_page;
 		}
 		break;
 	case VDSO_TIMENS_PAGE_OFFSET:
@@ -72,24 +73,25 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		 */
 		if (!IS_ENABLED(CONFIG_TIME_NS) || !timens_page)
 			return VM_FAULT_SIGBUS;
-		pfn = __phys_to_pfn(__pa_symbol(vdso_k_time_data));
+		page = virt_to_page(vdso_k_time_data);
 		break;
 	case VDSO_RNG_PAGE_OFFSET:
 		if (!IS_ENABLED(CONFIG_VDSO_GETRANDOM))
 			return VM_FAULT_SIGBUS;
-		pfn = __phys_to_pfn(__pa_symbol(vdso_k_rng_data));
+		page = virt_to_page(vdso_k_rng_data);
 		break;
 	case VDSO_ARCH_PAGES_START ... VDSO_ARCH_PAGES_END:
 		if (!IS_ENABLED(CONFIG_ARCH_HAS_VDSO_ARCH_DATA))
 			return VM_FAULT_SIGBUS;
-		pfn = __phys_to_pfn(__pa_symbol(vdso_k_arch_data)) +
-			vmf->pgoff - VDSO_ARCH_PAGES_START;
+		page = virt_to_page(vdso_k_arch_data) + vmf->pgoff - VDSO_ARCH_PAGES_START;
 		break;
 	default:
 		return VM_FAULT_SIGBUS;
 	}
 
-	return vmf_insert_pfn(vma, vmf->address, pfn);
+	get_page(page);
+	vmf->page = page;
+	return 0;
 }
 
 const struct vm_special_mapping vdso_vvar_mapping = {
@@ -101,7 +103,7 @@ struct vm_area_struct *vdso_install_vvar_mapping(struct mm_struct *mm, unsigned
 {
 	return _install_special_mapping(mm, addr, VDSO_NR_PAGES * PAGE_SIZE,
 					VM_READ | VM_MAYREAD | VM_IO | VM_DONTDUMP |
-					VM_PFNMAP | VM_SEALED_SYSMAP,
+					VM_MIXEDMAP | VM_SEALED_SYSMAP,
 					&vdso_vvar_mapping);
 }
 

-- 
2.51.0


