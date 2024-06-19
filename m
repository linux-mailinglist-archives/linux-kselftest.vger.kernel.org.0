Return-Path: <linux-kselftest+bounces-12187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A8590E06A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 02:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D0028329E
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 00:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55893DDBD;
	Wed, 19 Jun 2024 00:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ox6jmTii"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F5A17EF;
	Wed, 19 Jun 2024 00:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718755537; cv=none; b=CpOvQ11cbx77ZPe8r+pi/OeMs567T3aBQwO4EnhJfUoMsLZvVODjmQI4kPyn4X+//WmIMdZNrVvW8EwhTWUnMrGRlmP7zS+JMKBzAlNoz+rIudGQoAM/72JaAIEZI2pMHb42sIRv/d5xll+KgyRaXzjZqbhCDrVnXC8vL9xz8wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718755537; c=relaxed/simple;
	bh=b++cIeHBx13QkfY4xwxrEOQsXIxlcHqPbLn3jtu1ON8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Rqhju3ui1PEOh0FNSQv8qhTEiXIB+f2tOZMmQnNnizD8dO1Fcq/35M1y72oXUQMkDg22o//ZbF5vkHTGw7Q3YYUoXUyhahTvH7m4bgEj7rDWCAEoZm+TTPsBUqdy3pBE8CS6EV1YqGFc8NTowEygbDxSxAS7NbQDuITOk94fg+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ox6jmTii; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILcmhp008764;
	Wed, 19 Jun 2024 00:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Pdz9/HkhqVOEA9g7xL2yq+OHaJU30ffU6niiZoYVcdE=; b=ox6jmTiiLNHGqjgh
	KTUecqGu4t9dr97sxEjvvPIIrWyk570X0NTtmxMw43BqntSgStcrqmf+GhulZ4sL
	BBsW9sIJXypcGMeWn08B7oQEsGPb/VJM81uXiwnsxc0u0eCw2y21c2ILpZ8AuCBv
	xcav7jkify34Sl75n+/hCEUj8SLHBK4Ibq3X7k5uQdXV1/FJt2/XY9PFb0wmtEil
	dPLsXNKSQ4pKBMbaIYNJHyV0uYRXI4tXEPlslPuyBWSYeS0pAo/jcOYx0etIvLIF
	6NXPF4FZwuMX3PYj2zWhTdEh9vp79nZZpYGWs6W0Y16AeVuxXxeejU+VQc9bcShJ
	6HKIZA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuja787bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 00:05:18 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45J05H2f006583
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 00:05:17 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Jun 2024 17:05:16 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Tue, 18 Jun 2024 17:05:08 -0700
Subject: [PATCH RFC 2/5] mm/gup: Add an option for obtaining an exclusive
 pin
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240618-exclusive-gup-v1-2-30472a19c5d1@quicinc.com>
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
In-Reply-To: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, <maz@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <pbonzini@redhat.com>,
        Elliot Berman
	<quic_eberman@quicinc.com>,
        Fuad Tabba <tabba@google.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vSrJ-1fL5TL-mlKFMXsXbosJI6IXdRVp
X-Proofpoint-GUID: vSrJ-1fL5TL-mlKFMXsXbosJI6IXdRVp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_06,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=802 malwarescore=0
 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180176

From: Fuad Tabba <tabba@google.com>

Introduce the ability to obtain an exclusive long-term pin on a
page. This exclusive pin can only be held if there are no other
pins on the page, regular, or exclusive. Moreover, once this pin
is held, no other pins can be grabbed until the exclusive pin is
released.

This pin is grabbed using the (new) FOLL_EXCLUSIVE flag, and is
gated by the EXCLUSIVE_PIN configuration option.

Similar to how the normal GUP pin is obtain, the exclusive PIN
overloads the _refcount field for normal pages, or the _pincount
field for large pages. It appropriates bit 30 of these two
fields, which still allows the detection of overflows into bit
31. It does however, half the number of potential normals pins
for a page.

In order to avoid the possibility of COWing such a page, once an
exclusive pin has been obtained, it's marked as AnonExclusive.

Co-Developed-by: Elliot Berman <quic_eberman@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
Signed-off-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 include/linux/mm.h       |  24 +++++
 include/linux/mm_types.h |   2 +
 include/linux/page_ref.h |  36 +++++++
 mm/Kconfig               |   5 +
 mm/gup.c                 | 239 +++++++++++++++++++++++++++++++++++++++++------
 5 files changed, 279 insertions(+), 27 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fd0d10b08e7ac..d03d62bceba08 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1583,9 +1583,13 @@ static inline void put_page(struct page *page)
 void unpin_user_page(struct page *page);
 void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 				 bool make_dirty);
+void unpin_exc_pages_dirty_lock(struct page **pages, unsigned long npages,
+				bool make_dirty);
 void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
 				      bool make_dirty);
 void unpin_user_pages(struct page **pages, unsigned long npages);
+void unpin_exc_pages(struct page **pages, unsigned long npages);
+void unexc_user_page(struct page *page);
 
 static inline bool is_cow_mapping(vm_flags_t flags)
 {
@@ -1958,6 +1962,26 @@ static inline bool folio_needs_cow_for_dma(struct vm_area_struct *vma,
 	return folio_maybe_dma_pinned(folio);
 }
 
+static inline bool folio_maybe_exclusive_pinned(const struct folio *folio)
+{
+	unsigned int count;
+
+	if (!IS_ENABLED(CONFIG_EXCLUSIVE_PIN))
+		return false;
+
+	if (folio_test_large(folio))
+		count = atomic_read(&folio->_pincount);
+	else
+		count = folio_ref_count(folio);
+
+	return count >= GUP_PIN_EXCLUSIVE_BIAS;
+}
+
+static inline bool page_maybe_exclusive_pinned(const struct page *page)
+{
+	return folio_maybe_exclusive_pinned(page_folio(page));
+}
+
 /**
  * is_zero_page - Query if a page is a zero page
  * @page: The page to query
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index af3a0256fa93b..dc397e3465c23 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1465,6 +1465,8 @@ enum {
 	 * hinting faults.
 	 */
 	FOLL_HONOR_NUMA_FAULT = 1 << 12,
+	/* exclusive PIN only if there aren't other pins (including this) */
+	FOLL_EXCLUSIVE = 1 << 13,
 
 	/* See also internal only FOLL flags in mm/internal.h */
 };
diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index e6aeaafb143ca..9d16e1f4db094 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -94,6 +94,14 @@ static inline void __page_ref_unfreeze(struct page *page, int v)
  */
 #define GUP_PIN_COUNTING_BIAS (1U << 10)
 
+/*
+ * GUP_PIN_EXCLUSIVE_BIAS is used to grab an exclusive pin over a page.
+ * This exclusive pin can only be taken once, and only if no other GUP pins
+ * exist for the page.
+ * After it's taken, no other gup pins can be taken.
+ */
+#define GUP_PIN_EXCLUSIVE_BIAS (1U << 30)
+
 static inline int page_ref_count(const struct page *page)
 {
 	return atomic_read(&page->_refcount);
@@ -147,6 +155,34 @@ static inline void init_page_count(struct page *page)
 	set_page_count(page, 1);
 }
 
+static __must_check inline bool page_ref_setexc(struct page *page, unsigned int refs)
+{
+	unsigned int old_count, new_count;
+
+	if (WARN_ON_ONCE(refs >= GUP_PIN_EXCLUSIVE_BIAS))
+		return false;
+
+	do {
+		old_count = atomic_read(&page->_refcount);
+
+		if (old_count >= GUP_PIN_COUNTING_BIAS)
+			return false;
+
+		if (check_add_overflow(old_count, refs + GUP_PIN_EXCLUSIVE_BIAS, &new_count))
+			return false;
+	} while (atomic_cmpxchg(&page->_refcount, old_count, new_count) != old_count);
+
+	if (page_ref_tracepoint_active(page_ref_mod))
+		__page_ref_mod(page, refs);
+
+	return true;
+}
+
+static __must_check inline bool folio_ref_setexc(struct folio *folio, unsigned int refs)
+{
+	return page_ref_setexc(&folio->page, refs);
+}
+
 static inline void page_ref_add(struct page *page, int nr)
 {
 	atomic_add(nr, &page->_refcount);
diff --git a/mm/Kconfig b/mm/Kconfig
index b4cb45255a541..56f8c80b996f5 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1249,6 +1249,11 @@ config IOMMU_MM_DATA
 config EXECMEM
 	bool
 
+config EXCLUSIVE_PIN
+	def_bool y
+	help
+	  Add support for exclusive pins of pages.
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/gup.c b/mm/gup.c
index ca0f5cedce9b2..7f20de33221da 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -97,6 +97,65 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
 	return folio;
 }
 
+static bool large_folio_pin_setexc(struct folio *folio, unsigned int pins)
+{
+	unsigned int old_pincount, new_pincount;
+
+	if (WARN_ON_ONCE(pins >= GUP_PIN_EXCLUSIVE_BIAS))
+		return false;
+
+	do {
+		old_pincount = atomic_read(&folio->_pincount);
+
+		if (old_pincount > 0)
+			return false;
+
+		if (check_add_overflow(old_pincount, pins + GUP_PIN_EXCLUSIVE_BIAS, &new_pincount))
+			return false;
+	} while (atomic_cmpxchg(&folio->_pincount, old_pincount, pins) != old_pincount);
+
+	return true;
+}
+
+static bool __try_grab_folio_excl(struct folio *folio, int pincount, int refcount)
+{
+	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_EXCLUSIVE_PIN)))
+		return false;
+
+	if (folio_test_large(folio)) {
+		if (!large_folio_pin_setexc(folio, pincount))
+			return false;
+	} else if (!folio_ref_setexc(folio, refcount)) {
+		return false;
+	}
+
+	if (!PageAnonExclusive(&folio->page))
+		SetPageAnonExclusive(&folio->page);
+
+	return true;
+}
+
+static bool try_grab_folio_excl(struct folio *folio, int refs)
+{
+	/*
+	 * When pinning a large folio, use an exact count to track it.
+	 *
+	 * However, be sure to *also* increment the normal folio
+	 * refcount field at least once, so that the folio really
+	 * is pinned.  That's why the refcount from the earlier
+	 * try_get_folio() is left intact.
+	 */
+	return __try_grab_folio_excl(folio, refs,
+				     refs * (GUP_PIN_COUNTING_BIAS - 1));
+}
+
+static bool try_grab_page_excl(struct page *page)
+{
+	struct folio *folio = page_folio(page);
+
+	return __try_grab_folio_excl(folio, 1, GUP_PIN_COUNTING_BIAS);
+}
+
 /**
  * try_grab_folio() - Attempt to get or pin a folio.
  * @page:  pointer to page to be grabbed
@@ -161,19 +220,41 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
 		return NULL;
 	}
 
-	/*
-	 * When pinning a large folio, use an exact count to track it.
-	 *
-	 * However, be sure to *also* increment the normal folio
-	 * refcount field at least once, so that the folio really
-	 * is pinned.  That's why the refcount from the earlier
-	 * try_get_folio() is left intact.
-	 */
-	if (folio_test_large(folio))
-		atomic_add(refs, &folio->_pincount);
-	else
-		folio_ref_add(folio,
-				refs * (GUP_PIN_COUNTING_BIAS - 1));
+	if (unlikely(folio_maybe_exclusive_pinned(folio))) {
+		if (!put_devmap_managed_folio_refs(folio, refs))
+			folio_put_refs(folio, refs);
+		return NULL;
+	}
+
+	if (unlikely(flags & FOLL_EXCLUSIVE)) {
+		if (!try_grab_folio_excl(folio, refs))
+			return NULL;
+	} else {
+		/*
+		 * When pinning a large folio, use an exact count to track it.
+		 *
+		 * However, be sure to *also* increment the normal folio
+		 * refcount field at least once, so that the folio really
+		 * is pinned.  That's why the refcount from the earlier
+		 * try_get_folio() is left intact.
+		 */
+		if (folio_test_large(folio))
+			atomic_add(refs, &folio->_pincount);
+		else
+			folio_ref_add(folio,
+				      refs * (GUP_PIN_COUNTING_BIAS - 1));
+
+		if (unlikely(folio_maybe_exclusive_pinned(folio))) {
+			if (folio_test_large(folio))
+				atomic_sub(refs, &folio->_pincount);
+			else
+				folio_put_refs(folio,
+					       refs * (GUP_PIN_COUNTING_BIAS - 1));
+
+			return NULL;
+		}
+	}
+
 	/*
 	 * Adjust the pincount before re-checking the PTE for changes.
 	 * This is essentially a smp_mb() and is paired with a memory
@@ -198,6 +279,26 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 			refs *= GUP_PIN_COUNTING_BIAS;
 	}
 
+	if (unlikely(flags & FOLL_EXCLUSIVE)) {
+		if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_EXCLUSIVE_PIN)))
+			goto out;
+		if (is_zero_folio(folio))
+			return;
+		if (folio_test_large(folio)) {
+			if (WARN_ON_ONCE((atomic_read(&folio->_pincount) < GUP_PIN_EXCLUSIVE_BIAS)))
+				goto out;
+			atomic_sub(GUP_PIN_EXCLUSIVE_BIAS, &folio->_pincount);
+		} else {
+			if (WARN_ON_ONCE((unsigned int)refs >= GUP_PIN_EXCLUSIVE_BIAS))
+				goto out;
+			if (WARN_ON_ONCE(folio_ref_count(folio) < GUP_PIN_EXCLUSIVE_BIAS))
+				goto out;
+
+			refs += GUP_PIN_EXCLUSIVE_BIAS;
+		}
+	}
+
+out:
 	if (!put_devmap_managed_folio_refs(folio, refs))
 		folio_put_refs(folio, refs);
 }
@@ -242,16 +343,35 @@ int __must_check try_grab_page(struct page *page, unsigned int flags)
 		if (is_zero_page(page))
 			return 0;
 
-		/*
-		 * Similar to try_grab_folio(): be sure to *also*
-		 * increment the normal page refcount field at least once,
-		 * so that the page really is pinned.
-		 */
-		if (folio_test_large(folio)) {
-			folio_ref_add(folio, 1);
-			atomic_add(1, &folio->_pincount);
+		if (unlikely(folio_maybe_exclusive_pinned(folio)))
+			return -EBUSY;
+
+		if (unlikely(flags & FOLL_EXCLUSIVE)) {
+			if (!try_grab_page_excl(page))
+				return -EBUSY;
 		} else {
-			folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);
+			/*
+			 * Similar to try_grab_folio(): be sure to *also*
+			 * increment the normal page refcount field at least once,
+			 * so that the page really is pinned.
+			 */
+			if (folio_test_large(folio)) {
+				folio_ref_add(folio, 1);
+				atomic_add(1, &folio->_pincount);
+			} else {
+				folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);
+			}
+
+			if (unlikely(folio_maybe_exclusive_pinned(folio))) {
+				if (folio_test_large(folio)) {
+					folio_put_refs(folio, 1);
+					atomic_sub(1, &folio->_pincount);
+				} else {
+					folio_put_refs(folio, GUP_PIN_COUNTING_BIAS);
+				}
+
+				return -EBUSY;
+			}
 		}
 
 		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, 1);
@@ -288,6 +408,9 @@ void folio_add_pin(struct folio *folio)
 	if (is_zero_folio(folio))
 		return;
 
+	if (unlikely(folio_maybe_exclusive_pinned(folio)))
+		return;
+
 	/*
 	 * Similar to try_grab_folio(): be sure to *also* increment the normal
 	 * page refcount field at least once, so that the page really is
@@ -301,6 +424,15 @@ void folio_add_pin(struct folio *folio)
 		WARN_ON_ONCE(folio_ref_count(folio) < GUP_PIN_COUNTING_BIAS);
 		folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);
 	}
+
+	if (unlikely(folio_maybe_exclusive_pinned(folio))) {
+		if (folio_test_large(folio)) {
+			folio_put_refs(folio, 1);
+			atomic_sub(1, &folio->_pincount);
+		} else {
+			folio_put_refs(folio, GUP_PIN_COUNTING_BIAS);
+		}
+	}
 }
 
 static inline struct folio *gup_folio_range_next(struct page *start,
@@ -355,8 +487,8 @@ static inline struct folio *gup_folio_next(struct page **list,
  * set_page_dirty_lock(), unpin_user_page().
  *
  */
-void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
-				 bool make_dirty)
+static void __unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
+					  bool make_dirty, unsigned int flags)
 {
 	unsigned long i;
 	struct folio *folio;
@@ -395,11 +527,28 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 			folio_mark_dirty(folio);
 			folio_unlock(folio);
 		}
-		gup_put_folio(folio, nr, FOLL_PIN);
+		gup_put_folio(folio, nr, flags);
 	}
 }
+
+void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
+				 bool make_dirty)
+{
+	__unpin_user_pages_dirty_lock(pages, npages, make_dirty, FOLL_PIN);
+}
 EXPORT_SYMBOL(unpin_user_pages_dirty_lock);
 
+void unpin_exc_pages_dirty_lock(struct page **pages, unsigned long npages,
+				bool make_dirty)
+{
+	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_EXCLUSIVE_PIN)))
+		return;
+
+	__unpin_user_pages_dirty_lock(pages, npages, make_dirty,
+				      FOLL_PIN | FOLL_EXCLUSIVE);
+}
+EXPORT_SYMBOL(unpin_exc_pages_dirty_lock);
+
 /**
  * unpin_user_page_range_dirty_lock() - release and optionally dirty
  * gup-pinned page range
@@ -466,7 +615,7 @@ static void gup_fast_unpin_user_pages(struct page **pages, unsigned long npages)
  *
  * Please see the unpin_user_page() documentation for details.
  */
-void unpin_user_pages(struct page **pages, unsigned long npages)
+static void __unpin_user_pages(struct page **pages, unsigned long npages, unsigned int flags)
 {
 	unsigned long i;
 	struct folio *folio;
@@ -483,11 +632,35 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
 	sanity_check_pinned_pages(pages, npages);
 	for (i = 0; i < npages; i += nr) {
 		folio = gup_folio_next(pages, npages, i, &nr);
-		gup_put_folio(folio, nr, FOLL_PIN);
+		gup_put_folio(folio, nr, flags);
 	}
 }
+
+void unpin_user_pages(struct page **pages, unsigned long npages)
+{
+	__unpin_user_pages(pages, npages, FOLL_PIN);
+}
 EXPORT_SYMBOL(unpin_user_pages);
 
+void unpin_exc_pages(struct page **pages, unsigned long npages)
+{
+	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_EXCLUSIVE_PIN)))
+		return;
+
+	__unpin_user_pages(pages, npages, FOLL_PIN | FOLL_EXCLUSIVE);
+}
+EXPORT_SYMBOL(unpin_exc_pages);
+
+void unexc_user_page(struct page *page)
+{
+	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_EXCLUSIVE_PIN)))
+		return;
+
+	sanity_check_pinned_pages(&page, 1);
+	gup_put_folio(page_folio(page), 0, FOLL_EXCLUSIVE);
+}
+EXPORT_SYMBOL(unexc_user_page);
+
 /*
  * Set the MMF_HAS_PINNED if not set yet; after set it'll be there for the mm's
  * lifecycle.  Avoid setting the bit unless necessary, or it might cause write
@@ -2610,6 +2783,18 @@ static bool is_valid_gup_args(struct page **pages, int *locked,
 	if (WARN_ON_ONCE(!(gup_flags & FOLL_PIN) && (gup_flags & FOLL_LONGTERM)))
 		return false;
 
+	/* EXCLUSIVE can only be specified when config is enabled */
+	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_EXCLUSIVE_PIN) && (gup_flags & FOLL_EXCLUSIVE)))
+		return false;
+
+	/* EXCLUSIVE can only be specified when pinning */
+	if (WARN_ON_ONCE(!(gup_flags & FOLL_PIN) && (gup_flags & FOLL_EXCLUSIVE)))
+		return false;
+
+	/* EXCLUSIVE can only be specified when LONGTERM */
+	if (WARN_ON_ONCE(!(gup_flags & FOLL_LONGTERM) && (gup_flags & FOLL_EXCLUSIVE)))
+		return false;
+
 	/* Pages input must be given if using GET/PIN */
 	if (WARN_ON_ONCE((gup_flags & (FOLL_GET | FOLL_PIN)) && !pages))
 		return false;

-- 
2.34.1


