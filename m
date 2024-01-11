Return-Path: <linux-kselftest+bounces-2830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CBC82A6D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 05:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27AB328874D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 04:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0824663B2;
	Thu, 11 Jan 2024 04:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QQyJihhQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFFF468E;
	Thu, 11 Jan 2024 04:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704946227; x=1736482227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7jTK0zsrD6iUZ/k8/QLoj03D3txfzWkMPindf/3ehAE=;
  b=QQyJihhQerTcRzYUQGugYghfNodVvJVSWskfzT3ErNIkReR8g2cM8E8Z
   aHEmeLVitaBcaLR/oxoDDzDTbm3yffnKT5qaEd+0S4Sdq3zDzbAqc3MBg
   Oivujk9DsccwkkCoNlfTmrV2UToHvDST90m8NMOnU2WPy5eEyq/ut1vGG
   iF9CI46SDddeUOeCqCcA62s0d/vz2s305VgaEyqfs8Os92btLpq+LmGJh
   it3sO3KbfEecEAQAk2ujzsVoj9u701cnLMFMKAAQok86BQAXOSyKC9y3d
   KRMPYoE0eg3XS7ic7r/BTciiV7ITVM6KJt8+DIYIbJ8Jxqjo1G32iz9uj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="389167639"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="389167639"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 20:10:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="1113691842"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="1113691842"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jan 2024 20:10:25 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com
Cc: cohuck@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	mjrosato@linux.ibm.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	yi.y.sun@linux.intel.com,
	peterx@redhat.com,
	jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com,
	lulu@redhat.com,
	suravee.suthikulpanit@amd.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com,
	xin.zeng@intel.com,
	yan.y.zhao@intel.com,
	j.granados@samsung.com,
	binbin.wu@linux.intel.com
Subject: [PATCH v11 3/8] iommu: Add iommu_copy_struct_from_user_array helper
Date: Wed, 10 Jan 2024 20:10:10 -0800
Message-Id: <20240111041015.47920-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111041015.47920-1-yi.l.liu@intel.com>
References: <20240111041015.47920-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolin Chen <nicolinc@nvidia.com>

Wrap up the data pointer/num sanity and __iommu_copy_struct_from_user
call for iommu drivers to copy driver specific data at a specific location
in the struct iommu_user_data_array.

And expect it to be used in cache_invalidate_user ops for example.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/linux/iommu.h | 53 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 93c0d12dd047..580ba74a3d5d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -341,6 +341,59 @@ static inline int __iommu_copy_struct_from_user(
 				      sizeof(*kdst),                      \
 				      offsetofend(typeof(*kdst), min_last))
 
+/**
+ * __iommu_copy_struct_from_user_array - Copy iommu driver specific user space
+ *                                       data from an iommu_user_data_array
+ * @dst_data: Pointer to an iommu driver specific user data that is defined in
+ *            include/uapi/linux/iommufd.h
+ * @src_array: Pointer to a struct iommu_user_data_array for a user space array
+ * @data_type: The data type of the @dst_data. Must match with @src_array.type
+ * @index: Index to the location in the array to copy user data from
+ * @data_len: Length of current user data structure, i.e. sizeof(struct _dst)
+ * @min_len: Initial length of user data structure for backward compatibility.
+ *           This should be offsetofend using the last member in the user data
+ *           struct that was initially added to include/uapi/linux/iommufd.h
+ */
+static inline int
+__iommu_copy_struct_from_user_array(void *dst_data,
+				    const struct iommu_user_data_array *src_array,
+				    unsigned int data_type, unsigned int index,
+				    size_t data_len, size_t min_len)
+{
+	struct iommu_user_data src_data;
+
+	if (WARN_ON(!src_array || index >= src_array->entry_num))
+		return -EINVAL;
+	if (!src_array->entry_num)
+		return -EINVAL;
+	src_data.uptr = src_array->uptr + src_array->entry_len * index;
+	src_data.len = src_array->entry_len;
+	src_data.type = src_array->type;
+
+	return __iommu_copy_struct_from_user(dst_data, &src_data, data_type,
+					     data_len, min_len);
+}
+
+/**
+ * iommu_copy_struct_from_user_array - Copy iommu driver specific user space
+ *                                     data from an iommu_user_data_array
+ * @kdst: Pointer to an iommu driver specific user data that is defined in
+ *        include/uapi/linux/iommufd.h
+ * @user_array: Pointer to a struct iommu_user_data_array for a user space
+ *              array
+ * @data_type: The data type of the @kdst. Must match with @user_array->type
+ * @index: Index to the location in the array to copy user data from
+ * @min_last: The last member of the data structure @kdst points in the
+ *            initial version.
+ * Return 0 for success, otherwise -error.
+ */
+#define iommu_copy_struct_from_user_array(kdst, user_array, data_type,   \
+					  index, min_last)                \
+	__iommu_copy_struct_from_user_array(kdst, user_array, data_type, \
+					    index, sizeof(*kdst),        \
+					    offsetofend(typeof(*kdst),   \
+							min_last))
+
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
-- 
2.34.1


