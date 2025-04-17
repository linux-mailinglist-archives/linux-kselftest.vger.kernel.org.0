Return-Path: <linux-kselftest+bounces-30994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAF9A91026
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 02:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1135A2518
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 00:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2E618FC67;
	Thu, 17 Apr 2025 00:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0Cyl2y4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F2F38384
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 00:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849220; cv=none; b=pW1mttDbDPKydR0X/aRu7tsjpeYmoPRGM3dESGknvgkC5xEBEQX6DscTm5MFyAXOPSthJAkEPSZMcqBrBOEzKf+8hV9euYrACSAM7/12ZAMcXXWRqPTLoqVJjSsbWyBDX+eSUMWVbby/uGnVSytZvRFcgr51BG3UzZBhV7ogExc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849220; c=relaxed/simple;
	bh=XISuESK73OE0cGQUSmH3MWiiWeZkzQzLF/btVh6CIG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsQt/ZuNIat3ffZwkS+MIVLR9hCV0QYbE0QXYc5zCg4X1qOx+Ps9EhabL82yVMowSJqkZAxjsJw6Tzl7c+ikr610J9/Nx77fDV/knxdLq17CKJLuMxpQdJphHta+Xan24/PgpR6Gnb8v+I7J8zrYzpKL0XMjgkmXhLyXNQ8eVqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S0Cyl2y4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744849217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/aa301+ZC5m1Jmr7HKjW+aJT0ZB78SKeCvyWSDZD8g=;
	b=S0Cyl2y47s10laxzfZNCR5yGKr7aglroNoMeEIcsF7JZwLuWhk43U+IYZtyg9NZLRP2tgP
	QQENREY4yZB6Tdnnmww0Xs2ism/oPUicp4UaSC2PBthFeyov32dNnDGwfp8wjQajZKEj+J
	BGSJhKnnxCRBR/nIKrnpkC+HoSnYWhE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-XyJ2qnAJPimeKMMSR_u8JQ-1; Wed,
 16 Apr 2025 20:20:12 -0400
X-MC-Unique: XyJ2qnAJPimeKMMSR_u8JQ-1
X-Mimecast-MFC-AGG-ID: XyJ2qnAJPimeKMMSR_u8JQ_1744849208
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CED4019560BB;
	Thu, 17 Apr 2025 00:20:07 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.34])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BEB1519560B9;
	Thu, 17 Apr 2025 00:19:57 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	david@redhat.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	ryan.roberts@arm.com,
	willy@infradead.org,
	peterx@redhat.com,
	shuah@kernel.org,
	ziy@nvidia.com,
	wangkefeng.wang@huawei.com,
	usamaarif642@gmail.com,
	sunnanyong@huawei.com,
	vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com,
	yang@os.amperecomputing.com,
	kirill.shutemov@linux.intel.com,
	aarcange@redhat.com,
	raquini@redhat.com,
	dev.jain@arm.com,
	anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	tiwai@suse.de,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	jack@suse.cz,
	cl@gentwo.org,
	jglisse@google.com,
	surenb@google.com,
	zokeefe@google.com,
	hannes@cmpxchg.org,
	rientjes@google.com,
	mhocko@suse.com,
	rdunlap@infradead.org
Subject: [PATCH v4 3/4] khugepaged: add defer option to mTHP options
Date: Wed, 16 Apr 2025 18:18:45 -0600
Message-ID: <20250417001846.81480-4-npache@redhat.com>
In-Reply-To: <20250417001846.81480-1-npache@redhat.com>
References: <20250417001846.81480-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Now that we have defer to globally disable THPs at fault time, lets add
a defer setting to the mTHP options. This will allow khugepaged to
operate at that order, while avoiding it at PF time.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 include/linux/huge_mm.h |  5 +++++
 mm/huge_memory.c        | 38 +++++++++++++++++++++++++++++++++-----
 mm/khugepaged.c         | 10 +++++-----
 3 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index b88cc3154ec0..a4c87d80badc 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -96,6 +96,7 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
 #define TVA_SMAPS		(1 << 0)	/* Will be used for procfs */
 #define TVA_IN_PF		(1 << 1)	/* Page fault handler */
 #define TVA_ENFORCE_SYSFS	(1 << 2)	/* Obey sysfs configuration */
+#define TVA_IN_KHUGEPAGE	((1 << 2) | (1 << 3)) /* Khugepaged defer support */
 
 #define thp_vma_allowable_order(vma, vm_flags, tva_flags, order) \
 	(!!thp_vma_allowable_orders(vma, vm_flags, tva_flags, BIT(order)))
@@ -182,6 +183,7 @@ extern unsigned long transparent_hugepage_flags;
 extern unsigned long huge_anon_orders_always;
 extern unsigned long huge_anon_orders_madvise;
 extern unsigned long huge_anon_orders_inherit;
+extern unsigned long huge_anon_orders_defer;
 
 static inline bool hugepage_global_enabled(void)
 {
@@ -306,6 +308,9 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 	/* Optimization to check if required orders are enabled early. */
 	if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
 		unsigned long mask = READ_ONCE(huge_anon_orders_always);
+
+		if ((tva_flags & TVA_IN_KHUGEPAGE) == TVA_IN_KHUGEPAGE)
+			mask |= READ_ONCE(huge_anon_orders_defer);
 		if (vm_flags & VM_HUGEPAGE)
 			mask |= READ_ONCE(huge_anon_orders_madvise);
 		if (hugepage_global_always() || hugepage_global_defer() ||
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 568ae2363959..f10d307091d8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -81,6 +81,7 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
 unsigned long huge_anon_orders_always __read_mostly;
 unsigned long huge_anon_orders_madvise __read_mostly;
 unsigned long huge_anon_orders_inherit __read_mostly;
+unsigned long huge_anon_orders_defer __read_mostly;
 static bool anon_orders_configured __initdata;
 
 static inline bool file_thp_enabled(struct vm_area_struct *vma)
@@ -505,13 +506,15 @@ static ssize_t anon_enabled_show(struct kobject *kobj,
 	const char *output;
 
 	if (test_bit(order, &huge_anon_orders_always))
-		output = "[always] inherit madvise never";
+		output = "[always] inherit madvise defer never";
 	else if (test_bit(order, &huge_anon_orders_inherit))
-		output = "always [inherit] madvise never";
+		output = "always [inherit] madvise defer never";
 	else if (test_bit(order, &huge_anon_orders_madvise))
-		output = "always inherit [madvise] never";
+		output = "always inherit [madvise] defer never";
+	else if (test_bit(order, &huge_anon_orders_defer))
+		output = "always inherit madvise [defer] never";
 	else
-		output = "always inherit madvise [never]";
+		output = "always inherit madvise defer [never]";
 
 	return sysfs_emit(buf, "%s\n", output);
 }
@@ -527,25 +530,36 @@ static ssize_t anon_enabled_store(struct kobject *kobj,
 		spin_lock(&huge_anon_orders_lock);
 		clear_bit(order, &huge_anon_orders_inherit);
 		clear_bit(order, &huge_anon_orders_madvise);
+		clear_bit(order, &huge_anon_orders_defer);
 		set_bit(order, &huge_anon_orders_always);
 		spin_unlock(&huge_anon_orders_lock);
 	} else if (sysfs_streq(buf, "inherit")) {
 		spin_lock(&huge_anon_orders_lock);
 		clear_bit(order, &huge_anon_orders_always);
 		clear_bit(order, &huge_anon_orders_madvise);
+		clear_bit(order, &huge_anon_orders_defer);
 		set_bit(order, &huge_anon_orders_inherit);
 		spin_unlock(&huge_anon_orders_lock);
 	} else if (sysfs_streq(buf, "madvise")) {
 		spin_lock(&huge_anon_orders_lock);
 		clear_bit(order, &huge_anon_orders_always);
 		clear_bit(order, &huge_anon_orders_inherit);
+		clear_bit(order, &huge_anon_orders_defer);
 		set_bit(order, &huge_anon_orders_madvise);
 		spin_unlock(&huge_anon_orders_lock);
+	} else if (sysfs_streq(buf, "defer")) {
+		spin_lock(&huge_anon_orders_lock);
+		clear_bit(order, &huge_anon_orders_always);
+		clear_bit(order, &huge_anon_orders_inherit);
+		clear_bit(order, &huge_anon_orders_madvise);
+		set_bit(order, &huge_anon_orders_defer);
+		spin_unlock(&huge_anon_orders_lock);
 	} else if (sysfs_streq(buf, "never")) {
 		spin_lock(&huge_anon_orders_lock);
 		clear_bit(order, &huge_anon_orders_always);
 		clear_bit(order, &huge_anon_orders_inherit);
 		clear_bit(order, &huge_anon_orders_madvise);
+		clear_bit(order, &huge_anon_orders_defer);
 		spin_unlock(&huge_anon_orders_lock);
 	} else
 		ret = -EINVAL;
@@ -1002,7 +1016,7 @@ static char str_dup[PAGE_SIZE] __initdata;
 static int __init setup_thp_anon(char *str)
 {
 	char *token, *range, *policy, *subtoken;
-	unsigned long always, inherit, madvise;
+	unsigned long always, inherit, madvise, defer;
 	char *start_size, *end_size;
 	int start, end, nr;
 	char *p;
@@ -1014,6 +1028,8 @@ static int __init setup_thp_anon(char *str)
 	always = huge_anon_orders_always;
 	madvise = huge_anon_orders_madvise;
 	inherit = huge_anon_orders_inherit;
+	defer = huge_anon_orders_defer;
+
 	p = str_dup;
 	while ((token = strsep(&p, ";")) != NULL) {
 		range = strsep(&token, ":");
@@ -1053,18 +1069,28 @@ static int __init setup_thp_anon(char *str)
 				bitmap_set(&always, start, nr);
 				bitmap_clear(&inherit, start, nr);
 				bitmap_clear(&madvise, start, nr);
+				bitmap_clear(&defer, start, nr);
 			} else if (!strcmp(policy, "madvise")) {
 				bitmap_set(&madvise, start, nr);
 				bitmap_clear(&inherit, start, nr);
 				bitmap_clear(&always, start, nr);
+				bitmap_clear(&defer, start, nr);
 			} else if (!strcmp(policy, "inherit")) {
 				bitmap_set(&inherit, start, nr);
 				bitmap_clear(&madvise, start, nr);
 				bitmap_clear(&always, start, nr);
+				bitmap_clear(&defer, start, nr);
+			} else if (!strcmp(policy, "defer")) {
+				bitmap_set(&defer, start, nr);
+				bitmap_clear(&madvise, start, nr);
+				bitmap_clear(&always, start, nr);
+				bitmap_clear(&inherit, start, nr);
 			} else if (!strcmp(policy, "never")) {
 				bitmap_clear(&inherit, start, nr);
 				bitmap_clear(&madvise, start, nr);
 				bitmap_clear(&always, start, nr);
+				bitmap_clear(&defer, start, nr);
+
 			} else {
 				pr_err("invalid policy %s in thp_anon boot parameter\n", policy);
 				goto err;
@@ -1075,6 +1101,8 @@ static int __init setup_thp_anon(char *str)
 	huge_anon_orders_always = always;
 	huge_anon_orders_madvise = madvise;
 	huge_anon_orders_inherit = inherit;
+	huge_anon_orders_defer = defer;
+
 	anon_orders_configured = true;
 	return 1;
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 38643a681ba5..f9faff6917d3 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -491,7 +491,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
 {
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
 	    hugepage_pmd_enabled()) {
-		if (thp_vma_allowable_order(vma, vm_flags, TVA_ENFORCE_SYSFS,
+		if (thp_vma_allowable_order(vma, vm_flags, TVA_IN_KHUGEPAGE,
 					    PMD_ORDER))
 			__khugepaged_enter(vma->vm_mm);
 	}
@@ -955,7 +955,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 				   struct collapse_control *cc, int order)
 {
 	struct vm_area_struct *vma;
-	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
+	unsigned long tva_flags = cc->is_khugepaged ? TVA_IN_KHUGEPAGE  : 0;
 
 	if (unlikely(khugepaged_test_exit_or_disable(mm)))
 		return SCAN_ANY_PROCESS;
@@ -1430,7 +1430,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 	bool writable = false;
 	int chunk_none_count = 0;
 	int scaled_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER);
-	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
+	unsigned long tva_flags = cc->is_khugepaged ? TVA_IN_KHUGEPAGE : 0;
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 
 	result = find_pmd_or_thp_or_none(mm, address, &pmd);
@@ -2550,7 +2550,7 @@ static int khugepaged_collapse_single_pmd(unsigned long addr,
 {
 	int result = SCAN_FAIL;
 	struct mm_struct *mm = vma->vm_mm;
-	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
+	unsigned long tva_flags = cc->is_khugepaged ? TVA_IN_KHUGEPAGE : 0;
 
 	if (thp_vma_allowable_order(vma, vma->vm_flags,
 					tva_flags, PMD_ORDER)) {
@@ -2635,7 +2635,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 			break;
 		}
 		if (!thp_vma_allowable_order(vma, vma->vm_flags,
-					TVA_ENFORCE_SYSFS, PMD_ORDER)) {
+					TVA_IN_KHUGEPAGE, PMD_ORDER)) {
 skip:
 			progress++;
 			continue;
-- 
2.48.1


