Return-Path: <linux-kselftest+bounces-33012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F49BAB7C5E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 05:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78EAE4E14EC
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 03:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580FD29375F;
	Thu, 15 May 2025 03:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vd+WaEXQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842FB2920A5
	for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 03:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747280390; cv=none; b=QWx8StNnGpvJHdtc57CmqR9eVCdVEIqi3u7od67/KXZxO3Hq8jVy1CPQxljj/H0WS24b+W+On5CKA/RLZx6lyka40mSZ/zI5mY3RrK3fY/d6HxBTjijqFQBBrj/coIgK71nFTSOqqOrWEM3H3bGeZ1FlCfP3g12pfZBWpYiX75s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747280390; c=relaxed/simple;
	bh=IQfoJgb8b3FMmomPOPPPp27biP5OlIdFMeSBihDo49U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQJUjw1vkfeYGPF2wkLAkELN9CfXTePWxdI5DtN1spzO/1tQh0L3+FZ8rhJrJsjlFIduS0G1RCCFJM1wOnKUJXBR6py8pA/gsQPnYv+543akzAD/h7JUm3cIze9AvgKFSXkr9a5V3QXfu5Csq2AUxMONlMnQcmGtUmX5ULBsZP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vd+WaEXQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747280387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BQb3Gd4y9CLA3GzXKNCccBYdyfEwUNAPaSPoLscp5Es=;
	b=Vd+WaEXQoY7YSZ4siduPOBWPFQ3bHFYFt8awlQ04uCacmqL/pXHA8FqJNrHJzUD7aNxKb5
	Fv7TTVQSq/N4KjXS5yKpRSaI4fgRKlqE1+EmiuKf24Np3rrqDnhwadqUI+Tf0QQZFSpsU9
	8mry3JfCTI5dZy8dheCAGZlfmdiAvYc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-n3UWDWEqPxSdmjHv7ZPF_A-1; Wed,
 14 May 2025 23:39:43 -0400
X-MC-Unique: n3UWDWEqPxSdmjHv7ZPF_A-1
X-Mimecast-MFC-AGG-ID: n3UWDWEqPxSdmjHv7ZPF_A_1747280379
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AD921800256;
	Thu, 15 May 2025 03:39:38 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.116])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99DCF1953B85;
	Thu, 15 May 2025 03:39:22 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: rientjes@google.com,
	hannes@cmpxchg.org,
	lorenzo.stoakes@oracle.com,
	rdunlap@infradead.org,
	mhocko@suse.com,
	Liam.Howlett@oracle.com,
	zokeefe@google.com,
	surenb@google.com,
	jglisse@google.com,
	cl@gentwo.org,
	jack@suse.cz,
	dave.hansen@linux.intel.com,
	will@kernel.org,
	tiwai@suse.de,
	catalin.marinas@arm.com,
	anshuman.khandual@arm.com,
	dev.jain@arm.com,
	raquini@redhat.com,
	aarcange@redhat.com,
	kirill.shutemov@linux.intel.com,
	yang@os.amperecomputing.com,
	thomas.hellstrom@linux.intel.com,
	vishal.moola@gmail.com,
	sunnanyong@huawei.com,
	usamaarif642@gmail.com,
	wangkefeng.wang@huawei.com,
	ziy@nvidia.com,
	shuah@kernel.org,
	peterx@redhat.com,
	willy@infradead.org,
	ryan.roberts@arm.com,
	baolin.wang@linux.alibaba.com,
	baohua@kernel.org,
	david@redhat.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	corbet@lwn.net,
	akpm@linux-foundation.org,
	npache@redhat.com
Subject: [PATCH v6 1/4] mm: defer THP insertion to khugepaged
Date: Wed, 14 May 2025 21:38:54 -0600
Message-ID: <20250515033857.132535-2-npache@redhat.com>
In-Reply-To: <20250515033857.132535-1-npache@redhat.com>
References: <20250515033857.132535-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

setting /transparent_hugepages/enabled=always allows applications
to benefit from THPs without having to madvise. However, the page fault
handler takes very few considerations to decide weather or not to actually
use a THP. This can lead to a lot of wasted memory. khugepaged only
operates on memory that was either allocated with enabled=always or
MADV_HUGEPAGE.

Introduce the ability to set enabled=defer, which will prevent THPs from
being allocated by the page fault handler unless madvise is set,
leaving it up to khugepaged to decide which allocations will collapse to a
THP. This should allow applications to benefits from THPs, while curbing
some of the memory waste.

Acked-by: Zi Yan <ziy@nvidia.com>
Co-developed-by: Rafael Aquini <raquini@redhat.com>
Signed-off-by: Rafael Aquini <raquini@redhat.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 include/linux/huge_mm.h | 15 +++++++++++++--
 mm/huge_memory.c        | 31 +++++++++++++++++++++++++++----
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e3d15c737008..02038e3db829 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -48,6 +48,7 @@ enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_UNSUPPORTED,
 	TRANSPARENT_HUGEPAGE_FLAG,
 	TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
+	TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG,
 	TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG,
 	TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG,
 	TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG,
@@ -186,6 +187,7 @@ static inline bool hugepage_global_enabled(void)
 {
 	return transparent_hugepage_flags &
 			((1<<TRANSPARENT_HUGEPAGE_FLAG) |
+			(1<<TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG) |
 			(1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG));
 }
 
@@ -195,6 +197,12 @@ static inline bool hugepage_global_always(void)
 			(1<<TRANSPARENT_HUGEPAGE_FLAG);
 }
 
+static inline bool hugepage_global_defer(void)
+{
+	return transparent_hugepage_flags &
+			(1<<TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG);
+}
+
 static inline int highest_order(unsigned long orders)
 {
 	return fls_long(orders) - 1;
@@ -291,13 +299,16 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 				       unsigned long tva_flags,
 				       unsigned long orders)
 {
+	if ((tva_flags & TVA_IN_PF) && hugepage_global_defer() &&
+			!(vm_flags & VM_HUGEPAGE))
+		return 0;
+
 	/* Optimization to check if required orders are enabled early. */
 	if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
 		unsigned long mask = READ_ONCE(huge_anon_orders_always);
-
 		if (vm_flags & VM_HUGEPAGE)
 			mask |= READ_ONCE(huge_anon_orders_madvise);
-		if (hugepage_global_always() ||
+		if (hugepage_global_always() || hugepage_global_defer() ||
 		    ((vm_flags & VM_HUGEPAGE) && hugepage_global_enabled()))
 			mask |= READ_ONCE(huge_anon_orders_inherit);
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 700988a0d5cf..ce0ee74753af 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -297,12 +297,15 @@ static ssize_t enabled_show(struct kobject *kobj,
 	const char *output;
 
 	if (test_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags))
-		output = "[always] madvise never";
+		output = "[always] madvise defer never";
 	else if (test_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
 			  &transparent_hugepage_flags))
-		output = "always [madvise] never";
+		output = "always [madvise] defer never";
+	else if (test_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG,
+			  &transparent_hugepage_flags))
+		output = "always madvise [defer] never";
 	else
-		output = "always madvise [never]";
+		output = "always madvise defer [never]";
 
 	return sysfs_emit(buf, "%s\n", output);
 }
@@ -315,13 +318,20 @@ static ssize_t enabled_store(struct kobject *kobj,
 
 	if (sysfs_streq(buf, "always")) {
 		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG, &transparent_hugepage_flags);
 		set_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags);
+	} else if (sysfs_streq(buf, "defer")) {
+		clear_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
+		set_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG, &transparent_hugepage_flags);
 	} else if (sysfs_streq(buf, "madvise")) {
 		clear_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG, &transparent_hugepage_flags);
 		set_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
 	} else if (sysfs_streq(buf, "never")) {
 		clear_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG, &transparent_hugepage_flags);
 	} else
 		ret = -EINVAL;
 
@@ -954,18 +964,31 @@ static int __init setup_transparent_hugepage(char *str)
 			&transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
 			  &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG,
+			  &transparent_hugepage_flags);
 		ret = 1;
+	} else if (!strcmp(str, "defer")) {
+		clear_bit(TRANSPARENT_HUGEPAGE_FLAG,
+			  &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
+			  &transparent_hugepage_flags);
+		set_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG,
+			  &transparent_hugepage_flags);
 	} else if (!strcmp(str, "madvise")) {
 		clear_bit(TRANSPARENT_HUGEPAGE_FLAG,
 			  &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG,
+			  &transparent_hugepage_flags);
 		set_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
-			&transparent_hugepage_flags);
+			  &transparent_hugepage_flags);
 		ret = 1;
 	} else if (!strcmp(str, "never")) {
 		clear_bit(TRANSPARENT_HUGEPAGE_FLAG,
 			  &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
 			  &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG,
+			  &transparent_hugepage_flags);
 		ret = 1;
 	}
 out:
-- 
2.49.0


