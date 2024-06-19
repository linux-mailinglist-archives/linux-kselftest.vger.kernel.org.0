Return-Path: <linux-kselftest+bounces-12185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7404790E065
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 02:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA69283323
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 00:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E6DAD58;
	Wed, 19 Jun 2024 00:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Sr6RKo8y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4074317CD;
	Wed, 19 Jun 2024 00:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718755537; cv=none; b=uUxRbx+fySCzZdYG7dN3t/qRdm3aRaLrXD61SPPSnwpCnfe1icBKRYR+XOWMtylcYYCU8N3PaxJ3H2+DCNM4Kva7dwIkErB7n7w8dDdhNNvvoDxwqQNipv8IZoaBfs4kIrENfqi9aJ0jVn4yT1z+Wx4r+DqTg4vqJOWm7t2OAko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718755537; c=relaxed/simple;
	bh=Cv+Hq6doZ0kmBCUdoel5OWpIUoYgi1z24PdLJXBPS4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=u+Jv02BHLDyavpBBDZMIKHN94n2hUAJEWcxB6undSFhGXZj+ZbNR7Hps2+fX9LVXVVrcEMdAhc6TgdjFHNI8a/VchPYnNcRXFvvJGa+PrgxBQxfFcFnKXARJw2voK0sEGyhBDplPFpLFeEtk9Gw2JBwo73BI5Bg0HZ28fGJiFD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Sr6RKo8y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILb6h3006655;
	Wed, 19 Jun 2024 00:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iRWeq01fhpWDKacRAHXGRmQhpNUX3EjJdBREfuPnW/s=; b=Sr6RKo8yez2811fS
	GciE+gQYZgtPZlfph3QNk/bpj/XO6a12duNefTd9I+nKa7/qYlcWEdAKTjEGaUqB
	jlji6Iv8+SzzzK2Pg4akuqixk+WoC24HuL7aGIY3hiJ2SHvQUAvslQ4esZ33CNXJ
	1ylsU3wftuGrYeDOGsi9QqNTTXMElSzU6I1sM5bbK4IvLrv9p9DWpv3XSRRB2L9Z
	Wg+xbwkDSHa/jySmFZEHmozR/1LKn7u87hHwXyzVHjYi9yiFhJ1v/LB5EYO2QS5B
	lHUZtwYHwz7HK+l/at3UOCA6VIbJCkt13ibVWbb2orf/Dfds9096vZsEwhQARYc5
	AOFzBw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yujag07au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 00:05:18 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45J05HIE006596
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 00:05:17 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Jun 2024 17:05:17 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Tue, 18 Jun 2024 17:05:09 -0700
Subject: [PATCH RFC 3/5] mm/gup: Add support for re-pinning a normal pinned
 page as exclusive
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240618-exclusive-gup-v1-3-30472a19c5d1@quicinc.com>
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
X-Proofpoint-GUID: RvxghgNS65Z373X2P6YCrPAm_VgGE1I5
X-Proofpoint-ORIG-GUID: RvxghgNS65Z373X2P6YCrPAm_VgGE1I5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_06,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 impostorscore=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180176

From: Fuad Tabba <tabba@google.com>

When a page is shared, the exclusive pin is dropped, but one
normal pin is maintained. In order to be able to unshare a page,
add the ability to reaquire the exclusive pin, but only if there
is only one normal pin on the page, and only if the page is
marked as AnonExclusive.

Co-Developed-by: Elliot Berman <quic_eberman@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
Signed-off-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 include/linux/mm.h       |  1 +
 include/linux/page_ref.h | 18 ++++++++++++------
 mm/gup.c                 | 48 +++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d03d62bceba0..628ab936dd2b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1590,6 +1590,7 @@ void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
 void unpin_user_pages(struct page **pages, unsigned long npages);
 void unpin_exc_pages(struct page **pages, unsigned long npages);
 void unexc_user_page(struct page *page);
+int reexc_user_page(struct page *page);
 
 static inline bool is_cow_mapping(vm_flags_t flags)
 {
diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 9d16e1f4db09..e66130fe995d 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -92,7 +92,8 @@ static inline void __page_ref_unfreeze(struct page *page, int v)
  * provides safe operation for get_user_pages(), page_mkclean() and
  * other calls that race to set up page table entries.
  */
-#define GUP_PIN_COUNTING_BIAS (1U << 10)
+#define GUP_PIN_COUNTING_SHIFT (10)
+#define GUP_PIN_COUNTING_BIAS (1U << GUP_PIN_COUNTING_SHIFT)
 
 /*
  * GUP_PIN_EXCLUSIVE_BIAS is used to grab an exclusive pin over a page.
@@ -100,7 +101,8 @@ static inline void __page_ref_unfreeze(struct page *page, int v)
  * exist for the page.
  * After it's taken, no other gup pins can be taken.
  */
-#define GUP_PIN_EXCLUSIVE_BIAS (1U << 30)
+#define GUP_PIN_EXCLUSIVE_SHIFT (30)
+#define GUP_PIN_EXCLUSIVE_BIAS (1U << GUP_PIN_EXCLUSIVE_SHIFT)
 
 static inline int page_ref_count(const struct page *page)
 {
@@ -155,7 +157,9 @@ static inline void init_page_count(struct page *page)
 	set_page_count(page, 1);
 }
 
-static __must_check inline bool page_ref_setexc(struct page *page, unsigned int refs)
+static __must_check inline bool page_ref_setexc(struct page *page,
+						unsigned int expected_pins,
+						unsigned int refs)
 {
 	unsigned int old_count, new_count;
 
@@ -165,7 +169,7 @@ static __must_check inline bool page_ref_setexc(struct page *page, unsigned int
 	do {
 		old_count = atomic_read(&page->_refcount);
 
-		if (old_count >= GUP_PIN_COUNTING_BIAS)
+		if ((old_count >> GUP_PIN_COUNTING_SHIFT) != expected_pins)
 			return false;
 
 		if (check_add_overflow(old_count, refs + GUP_PIN_EXCLUSIVE_BIAS, &new_count))
@@ -178,9 +182,11 @@ static __must_check inline bool page_ref_setexc(struct page *page, unsigned int
 	return true;
 }
 
-static __must_check inline bool folio_ref_setexc(struct folio *folio, unsigned int refs)
+static __must_check inline bool folio_ref_setexc(struct folio *folio,
+						 unsigned int expected_pins,
+						 unsigned int refs)
 {
-	return page_ref_setexc(&folio->page, refs);
+	return page_ref_setexc(&folio->page, expected_pins, refs);
 }
 
 static inline void page_ref_add(struct page *page, int nr)
diff --git a/mm/gup.c b/mm/gup.c
index 7f20de33221d..663030d03d95 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -97,7 +97,9 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
 	return folio;
 }
 
-static bool large_folio_pin_setexc(struct folio *folio, unsigned int pins)
+static bool large_folio_pin_setexc(struct folio *folio,
+				   unsigned int expected_pins,
+				   unsigned int pins)
 {
 	unsigned int old_pincount, new_pincount;
 
@@ -107,7 +109,7 @@ static bool large_folio_pin_setexc(struct folio *folio, unsigned int pins)
 	do {
 		old_pincount = atomic_read(&folio->_pincount);
 
-		if (old_pincount > 0)
+		if (old_pincount != expected_pins)
 			return false;
 
 		if (check_add_overflow(old_pincount, pins + GUP_PIN_EXCLUSIVE_BIAS, &new_pincount))
@@ -117,15 +119,18 @@ static bool large_folio_pin_setexc(struct folio *folio, unsigned int pins)
 	return true;
 }
 
-static bool __try_grab_folio_excl(struct folio *folio, int pincount, int refcount)
+static bool __try_grab_folio_excl(struct folio *folio,
+				  unsigned int expected_pins,
+				  int pincount,
+				  int refcount)
 {
 	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_EXCLUSIVE_PIN)))
 		return false;
 
 	if (folio_test_large(folio)) {
-		if (!large_folio_pin_setexc(folio, pincount))
+		if (!large_folio_pin_setexc(folio, expected_pins, pincount))
 			return false;
-	} else if (!folio_ref_setexc(folio, refcount)) {
+	} else if (!folio_ref_setexc(folio, expected_pins, refcount)) {
 		return false;
 	}
 
@@ -135,7 +140,9 @@ static bool __try_grab_folio_excl(struct folio *folio, int pincount, int refcoun
 	return true;
 }
 
-static bool try_grab_folio_excl(struct folio *folio, int refs)
+static bool try_grab_folio_excl(struct folio *folio,
+				unsigned int expected_pins,
+				int refs)
 {
 	/*
 	 * When pinning a large folio, use an exact count to track it.
@@ -145,15 +152,17 @@ static bool try_grab_folio_excl(struct folio *folio, int refs)
 	 * is pinned.  That's why the refcount from the earlier
 	 * try_get_folio() is left intact.
 	 */
-	return __try_grab_folio_excl(folio, refs,
+	return __try_grab_folio_excl(folio, expected_pins, refs,
 				     refs * (GUP_PIN_COUNTING_BIAS - 1));
 }
 
-static bool try_grab_page_excl(struct page *page)
+static bool try_grab_page_excl(struct page *page,
+			       unsigned int expected_pins)
 {
 	struct folio *folio = page_folio(page);
 
-	return __try_grab_folio_excl(folio, 1, GUP_PIN_COUNTING_BIAS);
+	return __try_grab_folio_excl(folio, expected_pins, 1,
+				     GUP_PIN_COUNTING_BIAS);
 }
 
 /**
@@ -227,7 +236,7 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
 	}
 
 	if (unlikely(flags & FOLL_EXCLUSIVE)) {
-		if (!try_grab_folio_excl(folio, refs))
+		if (!try_grab_folio_excl(folio, 0, refs))
 			return NULL;
 	} else {
 		/*
@@ -347,7 +356,7 @@ int __must_check try_grab_page(struct page *page, unsigned int flags)
 			return -EBUSY;
 
 		if (unlikely(flags & FOLL_EXCLUSIVE)) {
-			if (!try_grab_page_excl(page))
+			if (!try_grab_page_excl(page, 0))
 				return -EBUSY;
 		} else {
 			/*
@@ -661,6 +670,23 @@ void unexc_user_page(struct page *page)
 }
 EXPORT_SYMBOL(unexc_user_page);
 
+int reexc_user_page(struct page *page)
+{
+	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_EXCLUSIVE_PIN)))
+		return -EINVAL;
+
+	sanity_check_pinned_pages(&page, 1);
+
+	if (!PageAnonExclusive(page))
+		return -EINVAL;
+
+	if (!try_grab_page_excl(page, 1))
+		return -EBUSY;
+
+	return 0;
+}
+EXPORT_SYMBOL(reexc_user_page);
+
 /*
  * Set the MMF_HAS_PINNED if not set yet; after set it'll be there for the mm's
  * lifecycle.  Avoid setting the bit unless necessary, or it might cause write

-- 
2.34.1


