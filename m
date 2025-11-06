Return-Path: <linux-kselftest+bounces-44917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9157DC3A248
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 11:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A1C050412A
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 10:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38196319852;
	Thu,  6 Nov 2025 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hod7lxXu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LDK8qDC1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA29314D19;
	Thu,  6 Nov 2025 10:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423351; cv=none; b=DLr97fg1RZ3FrG05uDkqYotDoJTWr3Y03l+gfUlvbYXkfTx7JAIoSx+57MqmCVIHop837cwcyQM7uHitd4v+/EdiD5lIAzaZuphLyw1R0c3eRFFdA/Lmq/DQh4F5BpG/NlsWr+l7R9EcHmN3pWCth0Rt+Qt2nNVHQrW8+bTgO0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423351; c=relaxed/simple;
	bh=KUrKSj/8f02prXozcbh1y+45HCCmTOvddQy/Fjvkmuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u/OEhuMrCZQYPLf95Aw6dwOAj8HWh2KWu7XN6YD45Kao3vVTbOaNq8e2unyOQ5cNDSTsd8Nsct2AoNw6vhlYLBOIJxFl50gdyeHrm0LG7xf7/X+vv1mQk79rS6/9GhA6LWJTUfQtMjSyxvf0gWP2Ebrh51vOE5Ee4vvIgUsJEbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hod7lxXu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LDK8qDC1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762423345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kc8Bzx9ugdMuBCH5n5olH8MPXze3f2dyeA69C+6Yvlo=;
	b=hod7lxXuzvWGCwvHUBLCNsxQY18vUTE1RK9tRFD5deogA9rzOQ0w6wx5uQrt6VMKb6xCoW
	OScgE1uwcl9Ppv7i5xEkq2tvqkWNhIkOZKhep5CoxHyofBFFlFWcqle1rNXqS2JONMCw8f
	1mO0iLatjFT+iS9OE3kcPHtyQZWzA2lIKlFBcsD+hDWDIXbjwpaHkv2HxDDpsz802pu9XE
	q98svr261+FIG0+dxauopgGrqbQls8HLrgcashMXPEPGyIUSb4BACdrGKDtjti8hfJLtMm
	lEGPRwWCulV5lz13eulGjv1DUfm3GFz7ij11tNDv4p6dkfaiO6k7Xjl/dUb2Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762423345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kc8Bzx9ugdMuBCH5n5olH8MPXze3f2dyeA69C+6Yvlo=;
	b=LDK8qDC1zGU5GTK2Xj8DGG7L507w7NkzJaLudz3kj4+O2fDP1Zu0sxDlpt8EQvlbVJuTx/
	6lYf6UbweJMOMOAQ==
Date: Thu, 06 Nov 2025 11:02:16 +0100
Subject: [PATCH v5 23/34] vdso/datastore: Allocate data pages dynamically
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251106-vdso-sparc64-generic-2-v5-23-97ff2b6542f7@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762423327; l=7325;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=KUrKSj/8f02prXozcbh1y+45HCCmTOvddQy/Fjvkmuc=;
 b=UxoHkOStUJytuvy/1z+V4DTApXNkZwzC41300pCa1gMdlaeqNJkUboAM5CEbEeXASFOcGSSrX
 2HydbCRqPtaCnEwbYkIx31g11CiabFv77h6qtXP25qklkR37ZudKLll
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Allocating the datapages as part of the kernel image does not work on
SPARC. It is also problematic with regards to dcache aliasing as there is
no guarantee that the virtual addresses used by the kernel are compatible
with those used by userspace.

Allocate the data pages through the page allocator instead.
Unused pages in the vDSO VMA are still allocated to keep the virtual
addresses aligned.
Switch the mapping from PFNs to 'struct page' as that is required
for dynamically allocated pages.

VM_MIXEDMAP is necessary for the call to vmf_insert_page() in the timens
prefault path to work.

These pages are also used by the timekeeping, random pool and architecture
initialization code. Introduce a new early initialization step, to make
sure they are available when needed.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
---
 include/linux/vdso_datastore.h |  6 ++++
 init/main.c                    |  2 ++
 lib/vdso/datastore.c           | 69 ++++++++++++++++++++++--------------------
 3 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/include/linux/vdso_datastore.h b/include/linux/vdso_datastore.h
index a91fa24b06e09321fdff8c2c7bdfbc1b206db574..0b530428db711e58660e797d9d3cf5dce60217fe 100644
--- a/include/linux/vdso_datastore.h
+++ b/include/linux/vdso_datastore.h
@@ -2,9 +2,15 @@
 #ifndef _LINUX_VDSO_DATASTORE_H
 #define _LINUX_VDSO_DATASTORE_H
 
+#ifdef CONFIG_HAVE_GENERIC_VDSO
 #include <linux/mm_types.h>
 
 extern const struct vm_special_mapping vdso_vvar_mapping;
 struct vm_area_struct *vdso_install_vvar_mapping(struct mm_struct *mm, unsigned long addr);
 
+void __init vdso_setup_data_pages(void);
+#else /* !CONFIG_HAVE_GENERIC_VDSO */
+static inline void vdso_setup_data_pages(void) { }
+#endif /* CONFIG_HAVE_GENERIC_VDSO */
+
 #endif /* _LINUX_VDSO_DATASTORE_H */
diff --git a/init/main.c b/init/main.c
index 07a3116811c5d72cbab48410493b3d0f89d1f1b2..01fa389eb33d58e13388bfaf6a821fe8523f2c76 100644
--- a/init/main.c
+++ b/init/main.c
@@ -104,6 +104,7 @@
 #include <linux/pidfs.h>
 #include <linux/ptdump.h>
 #include <linux/time_namespace.h>
+#include <linux/vdso_datastore.h>
 #include <net/net_namespace.h>
 
 #include <asm/io.h>
@@ -1020,6 +1021,7 @@ void start_kernel(void)
 	srcu_init();
 	hrtimers_init();
 	softirq_init();
+	vdso_setup_data_pages();
 	timekeeping_init();
 	time_init();
 
diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index 7377fcb6e1dfe31d02ffcae371fdf9da069ae4c1..222ae268715d0413f54a477c65d456bd8d58981e 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -1,52 +1,56 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-#include <linux/linkage.h>
+#include <linux/gfp.h>
 #include <linux/mm.h>
 #include <linux/time_namespace.h>
 #include <linux/types.h>
 #include <linux/vdso_datastore.h>
 #include <vdso/datapage.h>
 
-/*
- * The vDSO data page.
- */
 #ifdef CONFIG_GENERIC_GETTIMEOFDAY
-static union {
-	struct vdso_time_data	data;
-	u8			page[PAGE_SIZE];
-} vdso_time_data_store __page_aligned_data;
-struct vdso_time_data *vdso_k_time_data = &vdso_time_data_store.data;
-static_assert(sizeof(vdso_time_data_store) == PAGE_SIZE);
+struct vdso_time_data *vdso_k_time_data;
+static_assert(sizeof(struct vdso_time_data) <= PAGE_SIZE);
 #endif /* CONFIG_GENERIC_GETTIMEOFDAY */
 
 #ifdef CONFIG_VDSO_GETRANDOM
-static union {
-	struct vdso_rng_data	data;
-	u8			page[PAGE_SIZE];
-} vdso_rng_data_store __page_aligned_data;
-struct vdso_rng_data *vdso_k_rng_data = &vdso_rng_data_store.data;
-static_assert(sizeof(vdso_rng_data_store) == PAGE_SIZE);
+struct vdso_rng_data *vdso_k_rng_data;
+static_assert(sizeof(struct vdso_rng_data) <= PAGE_SIZE);
 #endif /* CONFIG_VDSO_GETRANDOM */
 
 #ifdef CONFIG_ARCH_HAS_VDSO_ARCH_DATA
-static union {
-	struct vdso_arch_data	data;
-	u8			page[VDSO_ARCH_DATA_SIZE];
-} vdso_arch_data_store __page_aligned_data;
-struct vdso_arch_data *vdso_k_arch_data = &vdso_arch_data_store.data;
+struct vdso_arch_data *vdso_k_arch_data;
 #endif /* CONFIG_ARCH_HAS_VDSO_ARCH_DATA */
 
+void __init vdso_setup_data_pages(void)
+{
+	unsigned int order = get_order(VDSO_NR_PAGES * PAGE_SIZE);
+	struct folio *folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, order);
+
+	if (!folio)
+		panic("Unable to allocate VDSO storage pages");
+
+	if (IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY))
+		vdso_k_time_data = page_address(folio_page(folio, VDSO_TIME_PAGE_OFFSET));
+
+	if (IS_ENABLED(CONFIG_VDSO_GETRANDOM))
+		vdso_k_rng_data = page_address(folio_page(folio, VDSO_RNG_PAGE_OFFSET));
+
+	if (IS_ENABLED(CONFIG_ARCH_HAS_VDSO_ARCH_DATA))
+		vdso_k_arch_data = page_address(folio_page(folio, VDSO_ARCH_PAGES_START));
+}
+
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
@@ -56,10 +60,10 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
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
@@ -72,24 +76,25 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
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
@@ -101,7 +106,7 @@ struct vm_area_struct *vdso_install_vvar_mapping(struct mm_struct *mm, unsigned
 {
 	return _install_special_mapping(mm, addr, VDSO_NR_PAGES * PAGE_SIZE,
 					VM_READ | VM_MAYREAD | VM_IO | VM_DONTDUMP |
-					VM_PFNMAP | VM_SEALED_SYSMAP,
+					VM_MIXEDMAP | VM_SEALED_SYSMAP,
 					&vdso_vvar_mapping);
 }
 

-- 
2.51.0


