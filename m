Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBF47D0B9B
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 11:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376700AbjJTJYr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 05:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376614AbjJTJYf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 05:24:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6D2D51;
        Fri, 20 Oct 2023 02:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697793873; x=1729329873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HTvHwI4EhRpQB7I9M65i/pRD2X6B+RdjiZDfOoc2Ot8=;
  b=Cd1p0UEp+PhCMy/gagfpL74wmuW8eejukpF2TfHLR4fLnC/K5xmVqd+C
   zu/q9hp4RoU+9KZ2gJXicMG8Vw5t18JuvgECVSkKHirS8URYg2cuse+f0
   PthW1zZihS3xY1s6jA05q/DWUVQGVdQIdB3GDqT5kW9+1EmFzG94Y7PA3
   /G8V4yx/8SgD69iOBDYyTTBp3MhbaoL2R8FDxYrrv76gJZ0g40Y6i8IAG
   5vCtwQ0p0BPPIaKJjz7sGwEeB44c8k/T/ZvtXPVk3G8heZwfQJiRMko/G
   Zrik4PYri6zGjZR8ha2akjI2njMKTM9t+UrhFpVhByDpGScpgtUtYgyFY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="472685490"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="472685490"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:24:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="750859678"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="750859678"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga007.jf.intel.com with ESMTP; 20 Oct 2023 02:24:29 -0700
From:   Yi Liu <yi.l.liu@intel.com>
To:     joro@8bytes.org, alex.williamson@redhat.com, jgg@nvidia.com,
        kevin.tian@intel.com, robin.murphy@arm.com,
        baolu.lu@linux.intel.com
Cc:     cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
        xin.zeng@intel.com
Subject: [PATCH v5 3/6] iommu: Add iommu_copy_struct_from_user_array helper
Date:   Fri, 20 Oct 2023 02:24:23 -0700
Message-Id: <20231020092426.13907-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020092426.13907-1-yi.l.liu@intel.com>
References: <20231020092426.13907-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Nicolin Chen <nicolinc@nvidia.com>

Wrap up the data type/pointer/num sanity and __iommu_copy_struct_from_user
call for iommu drivers to copy driver specific data at a specific location
in the struct iommu_user_data_array.

And expect it to be used in cache_invalidate_user ops for example.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/linux/iommu.h | 54 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index de52835446f4..c0ee1d5d9447 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -305,6 +305,60 @@ __iommu_copy_struct_from_user(void *dst_data,
 	__iommu_copy_struct_from_user(kdst, user_data, data_type, sizeof(*kdst), \
 				      offsetofend(typeof(*kdst), min_last))
 
+/**
+ * __iommu_copy_struct_from_user_array - Copy iommu driver specific user space
+ *                                       data from an iommu_user_data_array
+ * @dst_data: Pointer to an iommu driver specific user data that is defined in
+ *            include/uapi/linux/iommufd.h
+ * @src_array: Pointer to a struct iommu_user_data_array for a user space array
+ * @data_type: The data type of the @dst_data. Must match with @src_array.type
+ * @index: Index to offset the location in the array to copy user data from
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
+	if (src_array->type != data_type)
+		return -EINVAL;
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
+ * @user_array: Pointer to a struct iommu_user_data_array for a user space array
+ * @data_type: The data type of the @kdst. Must match with @user_array->type
+ * @index: Index to offset the location in the array to copy user data from
+ * @min_last: The last memember of the data structure @kdst points in the
+ *            initial version.
+ * Return 0 for success, otherwise -error.
+ */
+#define iommu_copy_struct_from_user_array(kdst, user_array, data_type,   \
+					  index, min_last)               \
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

