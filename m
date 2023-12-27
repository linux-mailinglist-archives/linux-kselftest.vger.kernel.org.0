Return-Path: <linux-kselftest+bounces-2469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33F181F01E
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 17:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 516CAB219B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 16:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8A446BA7;
	Wed, 27 Dec 2023 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzvQWq4y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787A246522;
	Wed, 27 Dec 2023 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703693643; x=1735229643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a0MtJfDdMrZSQXPjcVw/ypmtgFbBgW6CUZyjsKPTKtk=;
  b=BzvQWq4ylseL8HXf1RswmyvgF0l8VR7e15wtV2leCVELn/kZejpDrfmi
   aI10/IRPg4rvNa4frozSM7C+K7KQOavAw8wiPalLbP1J6C+GnuWOhjiSn
   r3t/8qMVU8MSA0jipIEeudBdr3Ss60fT7lwcy5zmP7XLhvnxQEo1FsKvn
   lt1RpqgO1KP3EGGc3rJN1bbZyd+1av2wVpZFzSGrUF+9eoyelNFDWS8iv
   o+IQUKS2ZbhbttovwhxSYbMEhKS89zg6YZomvOi6wdK6pc+tyPbNYjEjF
   0aEDtUGEsUvkRI9rfe0MdFF62GS85JC4P2UjDV0mMuXFunFwJ1EIi4ftG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="396186218"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="396186218"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:14:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="781775196"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="781775196"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 27 Dec 2023 08:14:01 -0800
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
	j.granados@samsung.com
Subject: [PATCH v8 03/10] iommu: Add iommu_copy_struct_from_user_array helper
Date: Wed, 27 Dec 2023 08:13:47 -0800
Message-Id: <20231227161354.67701-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227161354.67701-1-yi.l.liu@intel.com>
References: <20231227161354.67701-1-yi.l.liu@intel.com>
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
in the struct iommu_user_data_array, and iommu_respond_struct_to_user_array()
to copy response to a specific location in the struct iommu_user_data_array.

And expect it to be used in cache_invalidate_user ops for example.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/linux/iommu.h | 74 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 93c0d12dd047..c3434c9eaa6d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -341,6 +341,80 @@ static inline int __iommu_copy_struct_from_user(
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
+ * @min_last: The last memember of the data structure @kdst points in the
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
+/**
+ * iommu_respond_struct_to_user_array - Copy the response in @ksrc back to
+ *                                      a specific entry of user array
+ * @user_array: Pointer to a struct iommu_user_data_array for a user space
+ *              array
+ * @index: Index to the location in the array to copy response
+ * @ksrc: Pointer to kernel structure
+ * @klen: Length of @ksrc struct
+ *
+ * This only copies response of one entry (@index) in @user_array.
+ */
+static inline int
+iommu_respond_struct_to_user_array(const struct iommu_user_data_array *array,
+				   unsigned int index, void *ksrc, size_t klen)
+{
+	if (copy_to_user(array->uptr + array->entry_len * index,
+			 ksrc, min_t(size_t, array->entry_len, klen)))
+		return -EFAULT;
+	return 0;
+}
+
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
-- 
2.34.1


