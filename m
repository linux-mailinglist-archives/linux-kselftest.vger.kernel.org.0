Return-Path: <linux-kselftest+bounces-12183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EC790E05C
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 02:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18FD71C20B93
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 00:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D9615CE;
	Wed, 19 Jun 2024 00:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="licRGVV3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E68191;
	Wed, 19 Jun 2024 00:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718755535; cv=none; b=JV6F1V2mtuLvZN239cdvl/N2ipLhoJEpItBKksL+2cqI3AJ+iy+WoSvM9Itpc+Yh5I9atlgRnTuy6m+ZyL6uhhRzPAaFgzjO0b0emDQaFSViJizzWqvXErrpf9d/KZd6h0NBo5Wq5Cs6ACVy07fTJ+PcL4RvWgrLs1k2ZeGTfxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718755535; c=relaxed/simple;
	bh=RDA0qEcvJY2mO+lnI56e4nT/ja162SWL44U6M9WUuCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kzDOi2MBBKY2WBc+62n8e10wcyEveI6adjUVyxpj3k1cT5xAFc0Uvy9SHmyg6r7ZyH9/oOShE9oz3Xrzd2plhLueXmrEPnfaykRy3KBg4IxEDaXxNNWBvQXfsTJKFiLwNKkLhBYOOfoUd9nzthdirpFwppvtQPYmXw/ubLMvZ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=licRGVV3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILaNQ0001140;
	Wed, 19 Jun 2024 00:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/OyteV4yM0qUOEafhhbvbTmI9bXZz54sg4qnQFhyy5A=; b=licRGVV3sGtCHq36
	0d7qxPKp8nHzVyyyjoDtjlEIvyc2Yl9kIh+zg/1vUDXoiMeuH4qrR8zEBbzYvhCQ
	NUka56yx1u+Ai8QeAN5kLA66MICuH0QcNTBlA5cchSBCmxBCfR9SAatx+pkRTzTm
	U7JSMQHJjmxKZZ5qhWtr2sjgInmJwV+pwQWrv6eqnmFQWGNJI7kTZqe4CDsTYn+p
	rO7Fsy2I/oduWoMg66mamclM2wjvvYcWlIzaHJlxeGOKpUs/sDqA8E+tKKKQBQEw
	sznWTshLaFRzYo2tyLd5eaELSFmOvfjHrcBKRTRdLqyrO51KbVbmiZSfjF94kRxC
	y12OOQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuja287fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 00:05:18 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45J05GcX029964
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 00:05:16 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Jun 2024 17:05:16 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Tue, 18 Jun 2024 17:05:07 -0700
Subject: [PATCH RFC 1/5] mm/gup: Move GUP_PIN_COUNTING_BIAS to page_ref.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240618-exclusive-gup-v1-1-30472a19c5d1@quicinc.com>
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
X-Proofpoint-GUID: eoEoI_FFBsbRB2SSN34e9igotn1wcWa9
X-Proofpoint-ORIG-GUID: eoEoI_FFBsbRB2SSN34e9igotn1wcWa9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_06,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=684 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180176

From: Fuad Tabba <tabba@google.com>

No functional change intended.

Signed-off-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 include/linux/mm.h       | 32 --------------------------------
 include/linux/page_ref.h | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9849dfda44d43..fd0d10b08e7ac 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1580,38 +1580,6 @@ static inline void put_page(struct page *page)
 	folio_put(folio);
 }
 
-/*
- * GUP_PIN_COUNTING_BIAS, and the associated functions that use it, overload
- * the page's refcount so that two separate items are tracked: the original page
- * reference count, and also a new count of how many pin_user_pages() calls were
- * made against the page. ("gup-pinned" is another term for the latter).
- *
- * With this scheme, pin_user_pages() becomes special: such pages are marked as
- * distinct from normal pages. As such, the unpin_user_page() call (and its
- * variants) must be used in order to release gup-pinned pages.
- *
- * Choice of value:
- *
- * By making GUP_PIN_COUNTING_BIAS a power of two, debugging of page reference
- * counts with respect to pin_user_pages() and unpin_user_page() becomes
- * simpler, due to the fact that adding an even power of two to the page
- * refcount has the effect of using only the upper N bits, for the code that
- * counts up using the bias value. This means that the lower bits are left for
- * the exclusive use of the original code that increments and decrements by one
- * (or at least, by much smaller values than the bias value).
- *
- * Of course, once the lower bits overflow into the upper bits (and this is
- * OK, because subtraction recovers the original values), then visual inspection
- * no longer suffices to directly view the separate counts. However, for normal
- * applications that don't have huge page reference counts, this won't be an
- * issue.
- *
- * Locking: the lockless algorithm described in folio_try_get_rcu()
- * provides safe operation for get_user_pages(), page_mkclean() and
- * other calls that race to set up page table entries.
- */
-#define GUP_PIN_COUNTING_BIAS (1U << 10)
-
 void unpin_user_page(struct page *page);
 void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 				 bool make_dirty);
diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 1acf5bac7f503..e6aeaafb143ca 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -62,6 +62,38 @@ static inline void __page_ref_unfreeze(struct page *page, int v)
 
 #endif
 
+/*
+ * GUP_PIN_COUNTING_BIAS, and the associated functions that use it, overload
+ * the page's refcount so that two separate items are tracked: the original page
+ * reference count, and also a new count of how many pin_user_pages() calls were
+ * made against the page. ("gup-pinned" is another term for the latter).
+ *
+ * With this scheme, pin_user_pages() becomes special: such pages are marked as
+ * distinct from normal pages. As such, the unpin_user_page() call (and its
+ * variants) must be used in order to release gup-pinned pages.
+ *
+ * Choice of value:
+ *
+ * By making GUP_PIN_COUNTING_BIAS a power of two, debugging of page reference
+ * counts with respect to pin_user_pages() and unpin_user_page() becomes
+ * simpler, due to the fact that adding an even power of two to the page
+ * refcount has the effect of using only the upper N bits, for the code that
+ * counts up using the bias value. This means that the lower bits are left for
+ * the exclusive use of the original code that increments and decrements by one
+ * (or at least, by much smaller values than the bias value).
+ *
+ * Of course, once the lower bits overflow into the upper bits (and this is
+ * OK, because subtraction recovers the original values), then visual inspection
+ * no longer suffices to directly view the separate counts. However, for normal
+ * applications that don't have huge page reference counts, this won't be an
+ * issue.
+ *
+ * Locking: the lockless algorithm described in folio_try_get_rcu()
+ * provides safe operation for get_user_pages(), page_mkclean() and
+ * other calls that race to set up page table entries.
+ */
+#define GUP_PIN_COUNTING_BIAS (1U << 10)
+
 static inline int page_ref_count(const struct page *page)
 {
 	return atomic_read(&page->_refcount);

-- 
2.34.1


