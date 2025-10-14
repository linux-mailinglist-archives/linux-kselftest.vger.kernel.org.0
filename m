Return-Path: <linux-kselftest+bounces-43098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AACBD7BDD
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 08:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C851923203
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 06:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6075530FF33;
	Tue, 14 Oct 2025 06:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lHHuBXo6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+9Sa4lKV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39B430F92F;
	Tue, 14 Oct 2025 06:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424568; cv=none; b=OOC8/8sdl7B94uuTK6Jyjr2lACMsYo5YdY3LzqYSn01cBHKO4CpdR5nh561tjiE+bQxOT1I7XSGeP2nB8v1XC4buyeoVmxnJsBd+6GarGCVGctSpkrPhQ+bm//bROOmPyX+P7CtAg4iU36SxFEpJlS0ctShogJpIYJ+3HPGm5RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424568; c=relaxed/simple;
	bh=uo1l/RYkTM1Gx0yX/twKp1GoORCp8qlfFI8d0qS/wuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QWp6oGlB40mfB2m+9A2/WyXzDXAnoJfb7CRGYrWWhGbgdgRuDN9dZzllb3QYDlfyhgFOwKlddL9+iOzGG1DirllzvPcZBaGUBtXDPRBh10fT+QfKdEwcHhlcS7E5V4MS4o0qq8GH/0m4gaLHlDN9E5ktpSxtMUkhZ+lUM4oWZGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lHHuBXo6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+9Sa4lKV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760424561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8A3GzlpfQU5MOaqPZoiqgoB+BubkEdHa0fQFBAgCrM4=;
	b=lHHuBXo6QcCi+aKop7U78/fGq57bqcJWll4Q0WS/dbPl6KT+BeQJfH2W69L6B1iXucjiR7
	IBNBYSgKBPWMhhbkxsJuQltSnpKJppc63D7WF7jELKRaystTyMEtPBuvRFOU0QTZ4UmSK2
	goOhuFfDE2XpXa7pPZz0kgDLBtfs38O6+Nu+Xp0Qw+JC0+kTdDS5+yHtLvJJ+GPGEnVoZg
	VCD5jrwZr+OYVRL+91LFH8mbmmYgQO4hcQDdAMLfxGtauhoRFwFL3B5mPK3He0jIwRYpo8
	xwKV+722OPaIciBqkYN5kf0fEDDsszloOJbTaHyguR9hj9QL0OQHtilUySWoTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760424561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8A3GzlpfQU5MOaqPZoiqgoB+BubkEdHa0fQFBAgCrM4=;
	b=+9Sa4lKV6LsQdyGxAPy4ol1DrwboOmBcivHLcesRKI1EgsP2E5WyM2YQZ8OL/quNp/eTuu
	FjP4A0vnxU68gRDQ==
Date: Tue, 14 Oct 2025 08:49:10 +0200
Subject: [PATCH v4 24/35] vdso/datastore: Allocate data pages dynamically
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-vdso-sparc64-generic-2-v4-24-e0607bf49dea@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760424546; l=4786;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=uo1l/RYkTM1Gx0yX/twKp1GoORCp8qlfFI8d0qS/wuU=;
 b=thtgQgTj5ne88KgGZXD4edmvKJI3QoEFyUdV8a4WIqfBg68x589HET+QZWwgjCevZC8BeM0VT
 JS03Ak5voHeAKT4ockxqBl7LUZky6JEg3NlUkDbdHFDqJk7ghK2Bufg
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Allocating the datapages as part of the kernel image does not work on
SPARC. It is also problematic with regards to dcache aliasing as there is
no guarantee that the virtual addresses used by the kernel are compatible
with those used by userspace.

Allocate the data pages through the page allocator instead.
Unused pages in the vDSO VMA are still allocated to keep the virtual
addresses aligned.

These pages are used by both the timekeeping, random pool and architecture
initialization code. Introduce a new early initialization step, to make
sure they are available when needed.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
---
 include/linux/vdso_datastore.h |  6 ++++++
 init/main.c                    |  2 ++
 lib/vdso/datastore.c           | 44 ++++++++++++++++++++++--------------------
 3 files changed, 31 insertions(+), 21 deletions(-)

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
index 6e5feb4a95b85f5a1cbdced7cdeddc593fcbad40..67799e8919c202e0800cb78ff70919f9604ac492 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -1,41 +1,43 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-#include <linux/linkage.h>
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
+	struct folio *folio = folio_alloc(GFP_KERNEL, order);
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

-- 
2.51.0


