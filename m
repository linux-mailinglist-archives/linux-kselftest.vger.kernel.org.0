Return-Path: <linux-kselftest+bounces-31807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3918A9F895
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 20:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6D01A85182
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 18:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD552973CC;
	Mon, 28 Apr 2025 18:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHyvkgr/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CEE2973BE
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745864994; cv=none; b=febxUNs2uE0ZvFUJhnyCCbbLt+zkqmz4rPS1GzItKEmc2AdPGSSb9Ow9qlnsPYvkmmVVqMhKDGG4hJWPpHerz6fNmr7mLZTXMAsMdyJPolMgpqlB7NglugiwiGLkNdoz4LE9GGX+e7/oPU8ynRK/iPMn0UGjlIYp0wabJZSVKAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745864994; c=relaxed/simple;
	bh=qJjvFraYMbS3NawL5bEoBDnu1Y2hhnhcD07ng1OK+Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYz58jFgvwfA2x02leGR7l0wKkYakmdJIgyY7uEwseL8n6A8RHrf8YYU6RoS/IZ2GJGu0HQmSzUtFUH0ne8McPswKKlgL+RlqsSm1EXuDpHMs8LSKSE2K1oB4Z4X/zvVpsyhyL67iozBzseQ/gFYTEOsKtmM3+vRvNZ8l5v2LM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IHyvkgr/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745864991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0PRSRSjriKhEwGd96T6Hhqr7Fe31F3qpR+JiRPVIrvc=;
	b=IHyvkgr/tadS3yBbAavXGTVyM7AGFciZXRjCmTjR15xSuljUMh5Y/a5OyGjy10NUfv46+q
	REtrW5ukRZZaepuVy1afSon5OLYJKt9RlngQ6vWfL/PywxSbmCzYmEJmlunSj2/B6VrNXj
	H8zng4TQ4pvQZ0pmlzHM/0M8UJhF628=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-SER52d8_PymPoy6i7c89KQ-1; Mon,
 28 Apr 2025 14:29:50 -0400
X-MC-Unique: SER52d8_PymPoy6i7c89KQ-1
X-Mimecast-MFC-AGG-ID: SER52d8_PymPoy6i7c89KQ_1745864985
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 653581956086;
	Mon, 28 Apr 2025 18:29:45 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.65.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2AE9830002C3;
	Mon, 28 Apr 2025 18:29:38 +0000 (UTC)
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
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	hannes@cmpxchg.org,
	rientjes@google.com,
	mhocko@suse.com,
	rdunlap@infradead.org
Subject: [PATCH v5 3/4] khugepaged: add defer option to mTHP options
Date: Mon, 28 Apr 2025 12:29:03 -0600
Message-ID: <20250428182904.93989-4-npache@redhat.com>
In-Reply-To: <20250428182904.93989-1-npache@redhat.com>
References: <20250428182904.93989-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Now that we have defer to globally disable THPs at fault time, lets add
a defer setting to the mTHP options. This will allow khugepaged to
operate at that order, while avoiding it at PF time.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 include/linux/huge_mm.h |  5 +++++
 mm/huge_memory.c        | 38 +++++++++++++++++++++++++++++++++-----
 mm/khugepaged.c         |  8 ++++----
 3 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 57e6c962afb1..a877c59bea67 100644
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
index 17b66adef029..705467ea9265 100644
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
index 812181354c46..738870331aed 100644
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
@@ -1429,7 +1429,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 	bool writable = false;
 	int chunk_none_count = 0;
 	int scaled_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER);
-	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
+	unsigned long tva_flags = cc->is_khugepaged ? TVA_IN_KHUGEPAGE : 0;
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 
 	result = find_pmd_or_thp_or_none(mm, address, &pmd);
@@ -2632,7 +2632,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
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


