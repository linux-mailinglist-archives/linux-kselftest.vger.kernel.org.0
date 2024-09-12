Return-Path: <linux-kselftest+bounces-17840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B93E976A4E
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 15:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCB5285379
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 13:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD0C1AD26F;
	Thu, 12 Sep 2024 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yp5eWzb6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17291AD254;
	Thu, 12 Sep 2024 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147058; cv=none; b=Hp7DpKifPw4Mo0Mh62EjEgu+UnVy/BCunbf66kYTZkjmKoGo7OjgN2nJrGZEWciUHu8l8Uy6g+gel5QpvmYadZaOghGg45P7LfBh62jFxM9aNYpWpvCNkcDizzm6KxJGnml/T5x17Q50kyGnzL3QUvY+c/4TY11/2rZEwjVqINI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147058; c=relaxed/simple;
	bh=xiJujwLBntP9KRvpgzQiLeGTCAt53O0ftrZZ+WURJ+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=re0XP0aupZJOn5cMjVX4vPIgyADO4ZpDdUWu6U9BIXshnPWpw3PCK3lTLJc7NUyrO2+gFkz60GWc/v+sfgxbvTz3vxZKGGScAbtSSU5ol+bhSGw49XVlOpgbVrPSEh5H7I26LJRtzTeEAMvxg9HRVXlc2kTuDOZvXLp83kw2stY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yp5eWzb6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726147056; x=1757683056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xiJujwLBntP9KRvpgzQiLeGTCAt53O0ftrZZ+WURJ+w=;
  b=Yp5eWzb6t+w4JjMQFYTx2UryiXZ65r3KFPstMDETHB02BEDUd8w98JS0
   o4JUjicOCQbnv1vHKMGHLwpo0lZc4FArU7DaSVuAwHtNNELSh9+6PRY31
   g6A8GMLa9+7oyi0WXVEGKfJBAUSEpSns+2KnPXBaFDRzHgWPfk9DIvnfV
   6jg4MJhySt0187Ue/N18xemQQbMVXvJwiJxYoL7taPg902icduEGRhWug
   XWe7imyV9z3ama1ReNtVa9eV3HPBg3hubyK23tRuTrNezbUsQJHPXVS3m
   kJg6WsHWcuV/ekqx7O+9QdjusAsCGyShzBsTojXk/+5Db7s7OCIKFPIzw
   w==;
X-CSE-ConnectionGUID: C5bIbJ5NTlS3/HP+yZydwg==
X-CSE-MsgGUID: 1pSpAdtIRu+VN+n8bmTwdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="13493307"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="13493307"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:17:32 -0700
X-CSE-ConnectionGUID: TYg44gLbTWaIrOMZ1t0xPQ==
X-CSE-MsgGUID: UBSUep3/R0ifG0bPr1dwNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="72692535"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 12 Sep 2024 06:17:32 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	linux-kselftest@vger.kernel.org,
	vasant.hegde@amd.com,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 1/4] ida: Add ida_find_first_range()
Date: Thu, 12 Sep 2024 06:17:26 -0700
Message-Id: <20240912131729.14951-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912131729.14951-1-yi.l.liu@intel.com>
References: <20240912131729.14951-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no helpers for user to check if a given ID is allocated or not,
neither a helper to loop all the allocated IDs in an IDA and do something
for cleanup. With the two needs, a helper to get the lowest allocated ID
of a range and two variants based on it.

Caller can check if a given ID is allocated or not by:

	bool ida_exists(struct ida *ida, unsigned int id)

Caller can iterate all allocated IDs by:

	int id;
	while ((id = ida_find_first(&pasid_ida)) > 0) {
		//anything to do with the allocated ID
		ida_free(pasid_ida, pasid);
	}

Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/linux/idr.h | 11 ++++++++
 lib/idr.c           | 67 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index da5f5fa4a3a6..718f9b1b91af 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -257,6 +257,7 @@ struct ida {
 int ida_alloc_range(struct ida *, unsigned int min, unsigned int max, gfp_t);
 void ida_free(struct ida *, unsigned int id);
 void ida_destroy(struct ida *ida);
+int ida_find_first_range(struct ida *ida, unsigned int min, unsigned int max);
 
 /**
  * ida_alloc() - Allocate an unused ID.
@@ -328,4 +329,14 @@ static inline bool ida_is_empty(const struct ida *ida)
 {
 	return xa_empty(&ida->xa);
 }
+
+static inline bool ida_exists(struct ida *ida, unsigned int id)
+{
+	return ida_find_first_range(ida, id, id) == id;
+}
+
+static inline int ida_find_first(struct ida *ida)
+{
+	return ida_find_first_range(ida, 0, ~0);
+}
 #endif /* __IDR_H__ */
diff --git a/lib/idr.c b/lib/idr.c
index da36054c3ca0..6644d3d1af02 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -476,6 +476,73 @@ int ida_alloc_range(struct ida *ida, unsigned int min, unsigned int max,
 }
 EXPORT_SYMBOL(ida_alloc_range);
 
+/**
+ * ida_find_first_range - Get the lowest used ID.
+ * @ida: IDA handle.
+ * @min: Lowest ID to get.
+ * @max: Highest ID to get.
+ *
+ * Get the lowest used ID between @min and @max, inclusive.  The returned
+ * ID will not exceed %INT_MAX, even if @max is larger.
+ *
+ * Context: Any context. Takes and releases the xa_lock.
+ * Return: The lowest used ID, or errno if no used ID is found.
+ */
+int ida_find_first_range(struct ida *ida, unsigned int min, unsigned int max)
+{
+	unsigned long index = min / IDA_BITMAP_BITS;
+	unsigned int offset = min % IDA_BITMAP_BITS;
+	unsigned long *addr, size, bit;
+	unsigned long flags;
+	void *entry;
+	int ret;
+
+	if ((int)min < 0)
+		return -EINVAL;
+	if ((int)max < 0)
+		max = INT_MAX;
+
+	xa_lock_irqsave(&ida->xa, flags);
+
+	entry = xa_find(&ida->xa, &index, max / IDA_BITMAP_BITS, XA_PRESENT);
+	if (!entry) {
+		ret = -ENOENT;
+		goto err_unlock;
+	}
+
+	if (index > min / IDA_BITMAP_BITS)
+		offset = 0;
+	if (index * IDA_BITMAP_BITS + offset > max) {
+		ret = -ENOENT;
+		goto err_unlock;
+	}
+
+	if (xa_is_value(entry)) {
+		unsigned long tmp = xa_to_value(entry);
+
+		addr = &tmp;
+		size = BITS_PER_XA_VALUE;
+	} else {
+		addr = ((struct ida_bitmap *)entry)->bitmap;
+		size = IDA_BITMAP_BITS;
+	}
+
+	bit = find_next_bit(addr, size, offset);
+
+	xa_unlock_irqrestore(&ida->xa, flags);
+
+	if (bit == size ||
+	    index * IDA_BITMAP_BITS + bit > max)
+		return -ENOENT;
+
+	return index * IDA_BITMAP_BITS + bit;
+
+err_unlock:
+	xa_unlock_irqrestore(&ida->xa, flags);
+	return ret;
+}
+EXPORT_SYMBOL(ida_find_first_range);
+
 /**
  * ida_free() - Release an allocated ID.
  * @ida: IDA handle.
-- 
2.34.1


