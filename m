Return-Path: <linux-kselftest+bounces-26311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20265A2FF9F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39FC61698A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78A81D88BE;
	Tue, 11 Feb 2025 00:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPbatkrZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE85F1D7989
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 00:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234543; cv=none; b=IyLM5nj4vc75FWkXKAVlgkfXZhTi9+FiTCOGTMrN97rT+0fpVgwhH20PCg0/FDTkoVl+IgyxX6Kw6dzhfDiKY+amAUkLNRGRnFTq2GNY9Vi4NeJ9lwPNQuKIi4Jnjs0hjavzBdXMVwpG5eUQlSk1NTkLU20J3Xsj8dlZbZQpAd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234543; c=relaxed/simple;
	bh=qsE1MWZwROW/ZNkPM3IAffjHVmiqi47rpN+1E5Wd1+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNwBKC0nNIbLn5RmT135ltb6munQ0WgGzcBTntrBwWDbXTmunUID7LYI9V3S3mfcxVeKSM+T6uvbZTatmECAy9Usz2XCZvia0wJOo2Eq1Jjo9asenvCd795/j9UymuO41VewO1tYXxo4qcrpSnHeqtlLrgqlgQJ0Q1E9ntNLwAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SPbatkrZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739234540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8P/mybpr+hwfsZO+hj/GAqlx+mlfaphH1WhdGIZk2Qg=;
	b=SPbatkrZPX6DwgaNy4ElKK5gIodT7WvNB74A+u6Op7GwB+Eianu7H2VhjLVDii/lIYOF+Y
	X53DwsXCKLuYNAz2wJjQ80Wpb4rtYG+vHep1CF/CzgIiz3iZvuroaVN/MjSLsTQlyk+Guo
	2oddOAVUJJejgA8tsqcCkTJponpxNsc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-RBpm614cNu6jwsq17rWxBQ-1; Mon,
 10 Feb 2025 19:42:15 -0500
X-MC-Unique: RBpm614cNu6jwsq17rWxBQ-1
X-Mimecast-MFC-AGG-ID: RBpm614cNu6jwsq17rWxBQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 118561800268;
	Tue, 11 Feb 2025 00:42:10 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.129])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6CC5818004A7;
	Tue, 11 Feb 2025 00:42:00 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Cc: ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	vbabka@suse.cz,
	mhocko@suse.com,
	apopple@nvidia.com,
	dave.hansen@linux.intel.com,
	will@kernel.org,
	baohua@kernel.org,
	jack@suse.cz,
	srivatsa@csail.mit.edu,
	haowenchao22@gmail.com,
	hughd@google.com,
	aneesh.kumar@kernel.org,
	yang@os.amperecomputing.com,
	peterx@redhat.com,
	ioworker0@gmail.com,
	wangkefeng.wang@huawei.com,
	ziy@nvidia.com,
	jglisse@google.com,
	surenb@google.com,
	vishal.moola@gmail.com,
	zokeefe@google.com,
	zhengqi.arch@bytedance.com,
	jhubbard@nvidia.com,
	21cnbao@gmail.com,
	willy@infradead.org,
	kirill.shutemov@linux.intel.com,
	david@redhat.com,
	aarcange@redhat.com,
	raquini@redhat.com,
	dev.jain@arm.com,
	sunnanyong@huawei.com,
	usamaarif642@gmail.com,
	audra@redhat.com,
	akpm@linux-foundation.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	tiwai@suse.de,
	baolin.wang@linux.alibaba.com,
	corbet@lwn.net,
	shuah@kernel.org
Subject: [RFC v2 4/5] khugepaged: add defer option to mTHP options
Date: Mon, 10 Feb 2025 17:40:53 -0700
Message-ID: <20250211004054.222931-5-npache@redhat.com>
In-Reply-To: <20250211004054.222931-1-npache@redhat.com>
References: <20250211004054.222931-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
index fb381ca720ea..8173a9ab0f3b 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -92,6 +92,7 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
 #define TVA_SMAPS		(1 << 0)	/* Will be used for procfs */
 #define TVA_IN_PF		(1 << 1)	/* Page fault handler */
 #define TVA_ENFORCE_SYSFS	(1 << 2)	/* Obey sysfs configuration */
+#define TVA_IN_KHUGEPAGE	((1 << 2) | (1 << 3)) /* Khugepaged defer support */
 
 #define thp_vma_allowable_order(vma, vm_flags, tva_flags, order) \
 	(!!thp_vma_allowable_orders(vma, vm_flags, tva_flags, BIT(order)))
@@ -173,6 +174,7 @@ extern unsigned long transparent_hugepage_flags;
 extern unsigned long huge_anon_orders_always;
 extern unsigned long huge_anon_orders_madvise;
 extern unsigned long huge_anon_orders_inherit;
+extern unsigned long huge_anon_orders_defer;
 
 static inline bool hugepage_global_enabled(void)
 {
@@ -297,6 +299,9 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 	/* Optimization to check if required orders are enabled early. */
 	if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
 		unsigned long mask = READ_ONCE(huge_anon_orders_always);
+
+		if ((tva_flags) & (TVA_IN_KHUGEPAGE))
+			mask |= READ_ONCE(huge_anon_orders_defer);
 		if (vm_flags & VM_HUGEPAGE)
 			mask |= READ_ONCE(huge_anon_orders_madvise);
 		if (hugepage_global_always() || hugepage_global_defer() ||
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a5e66a12bae8..de45595b0f98 100644
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
@@ -991,7 +1005,7 @@ static char str_dup[PAGE_SIZE] __initdata;
 static int __init setup_thp_anon(char *str)
 {
 	char *token, *range, *policy, *subtoken;
-	unsigned long always, inherit, madvise;
+	unsigned long always, inherit, madvise, defer;
 	char *start_size, *end_size;
 	int start, end, nr;
 	char *p;
@@ -1003,6 +1017,8 @@ static int __init setup_thp_anon(char *str)
 	always = huge_anon_orders_always;
 	madvise = huge_anon_orders_madvise;
 	inherit = huge_anon_orders_inherit;
+	defer = huge_anon_orders_defer;
+
 	p = str_dup;
 	while ((token = strsep(&p, ";")) != NULL) {
 		range = strsep(&token, ":");
@@ -1042,18 +1058,28 @@ static int __init setup_thp_anon(char *str)
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
@@ -1064,6 +1090,8 @@ static int __init setup_thp_anon(char *str)
 	huge_anon_orders_always = always;
 	huge_anon_orders_madvise = madvise;
 	huge_anon_orders_inherit = inherit;
+	huge_anon_orders_defer = defer;
+
 	anon_orders_configured = true;
 	return 1;
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index fc30698b8e6e..a83bc812ea64 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -488,7 +488,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
 {
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
 	    hugepage_pmd_enabled()) {
-		if (thp_vma_allowable_order(vma, vm_flags, TVA_ENFORCE_SYSFS,
+		if (thp_vma_allowable_order(vma, vm_flags, TVA_IN_KHUGEPAGE,
 					    PMD_ORDER))
 			__khugepaged_enter(vma->vm_mm);
 	}
@@ -943,7 +943,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 				   struct collapse_control *cc, int order)
 {
 	struct vm_area_struct *vma;
-	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
+	unsigned long tva_flags = cc->is_khugepaged ? TVA_IN_KHUGEPAGE  : 0;
 
 	if (unlikely(khugepaged_test_exit_or_disable(mm)))
 		return SCAN_ANY_PROCESS;
@@ -1393,7 +1393,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 	bool writable = false;
 	int chunk_none_count = 0;
 	int scaled_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - MIN_MTHP_ORDER);
-	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
+	unsigned long tva_flags = cc->is_khugepaged ? TVA_IN_KHUGEPAGE : 0;
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 
 	result = find_pmd_or_thp_or_none(mm, address, &pmd);
@@ -2505,7 +2505,7 @@ static int khugepaged_collapse_single_pmd(unsigned long addr, struct mm_struct *
 				   struct collapse_control *cc)
 {
 	int result = SCAN_FAIL;
-	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
+	unsigned long tva_flags = cc->is_khugepaged ? TVA_IN_KHUGEPAGE : 0;
 
 	if (!*mmap_locked) {
 		mmap_read_lock(mm);
@@ -2595,7 +2595,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
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


