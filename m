Return-Path: <linux-kselftest+bounces-243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF167EF35A
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 14:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB911C20A65
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 13:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1855E315B3;
	Fri, 17 Nov 2023 13:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YQsYqQuK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F74DD55;
	Fri, 17 Nov 2023 05:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700226442; x=1731762442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vaTxwDbLmSBYOxhRb599MKI2fDSAMYmUmZoB2I2eqn8=;
  b=YQsYqQuKwonglfZEEOlGpGCGYgvery9aZAslR7Hk3Gi75GewamVHgX++
   3o9QsVZLSxo2DkvbP0d1O0xo9PCb8ZVR7nxj5jSPFN1O0HIY3hy93rt6Y
   5HHeVCe9QYqGZddOvkQqboypEy7RgKuwa5MN/RsgIPjUxlRm7Bn4HhimJ
   SaGLr6IaYbbfk/azg4Px4RgzcsnI9OkrnQYOFPoBBbeP+vobnMYfDJCzy
   K7mN9JRGjDqrkTqwyDrmeL9Sv+21ZZxqh6f33GYzuuVKU4hjpe2/YmCjj
   WPRqqQd6Fh3gzjk/+/2F92hL+lSW7YlML/SnYfvy2aIZnGpSQNAFhLoEc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="388446358"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="388446358"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 05:07:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="836072051"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="836072051"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 17 Nov 2023 05:07:20 -0800
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
	yan.y.zhao@intel.com
Subject: [PATCH v6 1/6] iommu: Add cache_invalidate_user op
Date: Fri, 17 Nov 2023 05:07:12 -0800
Message-Id: <20231117130717.19875-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117130717.19875-1-yi.l.liu@intel.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

The updates of the PTEs in the nested page table will be propagated to the
hardware caches on both IOMMU (IOTLB) and devices (DevTLB/ATC).

Add a new domain op cache_invalidate_user for the userspace to flush the
hardware caches for a nested domain through iommufd. No wrapper for it,
as it's only supposed to be used by iommufd. Then, pass in invalidation
requests in form of a user data array conatining a number of invalidation
data entries.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/linux/iommu.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ec289c1016f5..0c1ff7fe4fa1 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -284,6 +284,24 @@ struct iommu_user_data {
 	size_t len;
 };
 
+/**
+ * struct iommu_user_data_array - iommu driver specific user space data array
+ * @type: The data type of all the entries in the user buffer array
+ * @uptr: Pointer to the user buffer array for copy_from_user()
+ * @entry_len: The fixed-width length of a entry in the array, in bytes
+ * @entry_num: The number of total entries in the array
+ *
+ * A array having a @entry_num number of @entry_len sized entries, each entry is
+ * user space data, an uAPI defined in include/uapi/linux/iommufd.h where @type
+ * is also defined as enum iommu_xyz_data_type.
+ */
+struct iommu_user_data_array {
+	unsigned int type;
+	void __user *uptr;
+	size_t entry_len;
+	int entry_num;
+};
+
 /**
  * __iommu_copy_struct_from_user - Copy iommu driver specific user space data
  * @dst_data: Pointer to an iommu driver specific user data that is defined in
@@ -440,6 +458,15 @@ struct iommu_ops {
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
+ *                         must be defined in include/uapi/linux/iommufd.h
  * @iova_to_phys: translate iova to physical address
  * @enforce_cache_coherency: Prevent any kind of DMA from bypassing IOMMU_CACHE,
  *                           including no-snoop TLPs on PCIe or other platform
@@ -465,6 +492,9 @@ struct iommu_domain_ops {
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


