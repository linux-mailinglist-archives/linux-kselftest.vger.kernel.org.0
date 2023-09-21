Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41857A9BEE
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 21:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjIUTFQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 15:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjIUTE3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 15:04:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D99417CF;
        Thu, 21 Sep 2023 10:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318586; x=1726854586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YklQvM01f0djWHMXvFMLwaLIOjNmAe73GMb89vbfk9Y=;
  b=W6wuM3I9z02x7IGNrJRKjpvGRig3tmP0m2IVrP0/zfUpZbJilmDEv3rS
   YUA8a61Sqo4RPAftmqWYL2mXlAfJ1ZzNckWvihIjTMtJCrI2kiV1jSXXJ
   dLLEuwsr1yVwLghmuSfsm4bNvevZnlvkpGot9lHqiVNC7vGW7yQ+9ztdX
   QGk5SmF/HE4/ZvhO7uK8XNa7p54O/VRfeRK4A4XPDqdOViKKdxW11XBcz
   taGHvWKJeaa56ek8vnD8f+c2FzL7aVLVpFW5Ii58dRyWGw/9KR3QFSssR
   x9QDX/GR2j8CRqDczjCGjkHlXPOC7FjcBGBebKxpOK/T+inQajHaC4B8l
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359832813"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="359832813"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:52:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723649496"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="723649496"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2023 00:52:08 -0700
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
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: [PATCH v4 02/17] iommu: Add nested domain support
Date:   Thu, 21 Sep 2023 00:51:23 -0700
Message-Id: <20230921075138.124099-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921075138.124099-1-yi.l.liu@intel.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

Introduce a new domain type for a user I/O page table, which is nested on
top of another user space address represented by a UNMANAGED domain. The
mappings of a nested domain are managed by user space software, so it is
not necessary to have map/unmap callbacks. But the updates of the PTEs in
the nested page table will be propagated to the hardware caches on both
IOMMU (IOTLB) and devices (DevTLB/ATC).

A nested domain is allocated by the domain_alloc_user op, and attached to
a device through the existing iommu_attach_device/group() interfaces.

Add a new domain op cache_invalidate_user for the userspace to flush the
hardware caches for a nested domain through iommufd. No wrapper for it,
as it's only supposed to be used by iommufd.

Pass in invalidation requests to the cache_invalidate_user op, in form of
a user data array that conatins a number of invalidation entries. Add an
iommu_user_data_array struct and an iommu_copy_user_data_from_array helper
for iommu drivers to walk through the invalidation request array and fetch
the data entry inside.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/linux/iommu.h | 59 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 12e12e5563e6..439e295c91a3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -66,6 +66,9 @@ struct iommu_domain_geometry {
 
 #define __IOMMU_DOMAIN_SVA	(1U << 4)  /* Shared process address space */
 
+#define __IOMMU_DOMAIN_NESTED	(1U << 5)  /* User-managed address space nested
+					      on a stage-2 translation        */
+
 #define IOMMU_DOMAIN_ALLOC_FLAGS ~__IOMMU_DOMAIN_DMA_FQ
 /*
  * This are the possible domain-types
@@ -92,6 +95,7 @@ struct iommu_domain_geometry {
 				 __IOMMU_DOMAIN_DMA_API |	\
 				 __IOMMU_DOMAIN_DMA_FQ)
 #define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SVA)
+#define IOMMU_DOMAIN_NESTED	(__IOMMU_DOMAIN_NESTED)
 
 struct iommu_domain {
 	unsigned type;
@@ -241,6 +245,21 @@ struct iommu_user_data {
 	size_t len;
 };
 
+/**
+ * struct iommu_user_data_array - iommu driver specific user space data array
+ * @uptr: Pointer to the user buffer array for copy_from_user()
+ * @entry_len: The fixed-width length of a entry in the array, in bytes
+ * @entry_num: The number of total entries in the array
+ *
+ * A array having a @entry_num number of @entry_len sized entries, each entry is
+ * user space data, i.e. an uAPI that is defined in include/uapi/linux/iommufd.h
+ */
+struct iommu_user_data_array {
+	void __user *uptr;
+	size_t entry_len;
+	int entry_num;
+};
+
 /**
  * iommu_copy_user_data - Copy iommu driver specific user space data
  * @dst_data: Pointer to an iommu driver specific user data that is defined in
@@ -263,6 +282,34 @@ static inline int iommu_copy_user_data(void *dst_data,
 				     src_data->uptr, src_data->len);
 }
 
+/**
+ * iommu_copy_user_data_from_array - Copy iommu driver specific user space data
+ *                                   from an iommu_user_data_array input
+ * @dst_data: Pointer to an iommu driver specific user data that is defined in
+ *            include/uapi/linux/iommufd.h
+ * @src_data: Pointer to a struct iommu_user_data_array for user space data array
+ * @index: Index to offset the location in the array to copy user data from
+ * @data_len: Length of current user data structure, i.e. sizeof(struct _dst)
+ * @min_len: Initial length of user data structure for backward compatibility.
+ *           This should be offsetofend using the last member in the user data
+ *           struct that was initially added to include/uapi/linux/iommufd.h
+ */
+static inline int
+iommu_copy_user_data_from_array(void *dst_data,
+				const struct iommu_user_data_array *src_array,
+				int index, size_t data_len, size_t min_len)
+{
+	struct iommu_user_data src_data;
+
+	if (WARN_ON(!src_array || index >= src_array->entry_num))
+		return -EINVAL;
+	if (!src_array->entry_num)
+		return -EINVAL;
+	src_data.uptr = src_array->uptr + src_array->entry_len * index;
+	src_data.len = src_array->entry_len;
+	return iommu_copy_user_data(dst_data, &src_data, data_len, min_len);
+}
+
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
@@ -374,6 +421,15 @@ struct iommu_ops {
  * @iotlb_sync_map: Sync mappings created recently using @map to the hardware
  * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
  *            queue
+ * @cache_invalidate_user: Flush hardware cache for user space IO page table.
+ *                         The @domain must be IOMMU_DOMAIN_NESTED. The @array
+ *                         passes in the cache invalidation requests, in form
+ *                         of a driver data structure. The driver must update
+ *                         array->entry_num to report the number of handled
+ *                         invalidation requests. The 32-bit @error_code can
+ *                         forward a driver specific error code to user space.
+ *                         Both the driver data structure and the error code
+ *                         must be defined in  include/uapi/linux/iommufd.h
  * @iova_to_phys: translate iova to physical address
  * @enforce_cache_coherency: Prevent any kind of DMA from bypassing IOMMU_CACHE,
  *                           including no-snoop TLPs on PCIe or other platform
@@ -403,6 +459,9 @@ struct iommu_domain_ops {
 			       size_t size);
 	void (*iotlb_sync)(struct iommu_domain *domain,
 			   struct iommu_iotlb_gather *iotlb_gather);
+	int (*cache_invalidate_user)(struct iommu_domain *domain,
+				     struct iommu_user_data_array *array,
+				     u32 *error_code);
 
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain,
 				    dma_addr_t iova);
-- 
2.34.1

