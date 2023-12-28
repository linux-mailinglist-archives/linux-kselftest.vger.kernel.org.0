Return-Path: <linux-kselftest+bounces-2498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D16781F95A
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 16:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DAB11C21E94
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 15:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96289DDB2;
	Thu, 28 Dec 2023 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iVVLOZcD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F7EF4E4;
	Thu, 28 Dec 2023 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703775994; x=1735311994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y9zEpidkk+p5pkry7bIuq4ZUGve0T4w0aUbFgMriFaU=;
  b=iVVLOZcDa5jc0TGngTkEHztBACciRzM8yuZmEwU72U12LUwNFH/1yhcM
   8lWz85CnvBB6yqMniIWHz7E1JaLjYByhktSroe8Qa3H0OprNmw0yjENLC
   NqcNloo3SkdwW3kXH0kiWtfDKbCCucS98bxjgNf89YDMpgB+Y7L5Zi2Rm
   UZ5IItDVdhCOp1hbtw8BKztWdjYGaIAS4++SPYKk9DFjcOcErawwiTfTJ
   flkRAj30eQOF5JT4fAbzA12wkXBLe+Af0iYG32jPF/7aYodb9KG/kX/8j
   0Qn69ZS1+iBPs0ZK54pttTdAwtnBwEg5PAgQ1DpEgqa86g+X9efWMUq4+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="393701900"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="393701900"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 07:06:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="869155158"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="869155158"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Dec 2023 07:06:32 -0800
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
Subject: [PATCH v9 01/10] iommu: Add cache_invalidate_user op
Date: Thu, 28 Dec 2023 07:06:20 -0800
Message-Id: <20231228150629.13149-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228150629.13149-1-yi.l.liu@intel.com>
References: <20231228150629.13149-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

The updates of the PTEs in the nested page table will be propagated to the
hardware caches.

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
 include/linux/iommu.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 6291aa7b079b..93c0d12dd047 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -284,6 +284,23 @@ struct iommu_user_data {
 	size_t len;
 };
 
+/**
+ * struct iommu_user_data_array - iommu driver specific user space data array
+ * @type: The data type of all the entries in the user buffer array
+ * @uptr: Pointer to the user buffer array
+ * @entry_len: The fixed-width length of an entry in the array, in bytes
+ * @entry_num: The number of total entries in the array
+ *
+ * The user buffer includes an array of requests with format defined in
+ * include/uapi/linux/iommufd.h
+ */
+struct iommu_user_data_array {
+	unsigned int type;
+	void __user *uptr;
+	size_t entry_len;
+	u32 entry_num;
+};
+
 /**
  * __iommu_copy_struct_from_user - Copy iommu driver specific user space data
  * @dst_data: Pointer to an iommu driver specific user data that is defined in
@@ -440,6 +457,13 @@ struct iommu_ops {
  * @iotlb_sync_map: Sync mappings created recently using @map to the hardware
  * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
  *            queue
+ * @cache_invalidate_user: Flush hardware cache for user space IO page table.
+ *                         The @domain must be IOMMU_DOMAIN_NESTED. The @array
+ *                         passes in the cache invalidation requests, in form
+ *                         of a driver data structure. The driver must update
+ *                         array->entry_num to report the number of handled
+ *                         invalidation requests. The driver data structure
+ *                         must be defined in include/uapi/linux/iommufd.h
  * @iova_to_phys: translate iova to physical address
  * @enforce_cache_coherency: Prevent any kind of DMA from bypassing IOMMU_CACHE,
  *                           including no-snoop TLPs on PCIe or other platform
@@ -465,6 +489,8 @@ struct iommu_domain_ops {
 			      size_t size);
 	void (*iotlb_sync)(struct iommu_domain *domain,
 			   struct iommu_iotlb_gather *iotlb_gather);
+	int (*cache_invalidate_user)(struct iommu_domain *domain,
+				     struct iommu_user_data_array *array);
 
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain,
 				    dma_addr_t iova);
-- 
2.34.1


