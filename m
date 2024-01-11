Return-Path: <linux-kselftest+bounces-2827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F6282A6C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 05:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 372B5B262C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 04:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93351110C;
	Thu, 11 Jan 2024 04:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gB+PzIrH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0867210F3;
	Thu, 11 Jan 2024 04:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704946224; x=1736482224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eheKmIiZIGJEgkz55tUg5C8gYGgoEc13PJeJt4LC/O0=;
  b=gB+PzIrHkIHk7/12B7FxbgX5cSgS+ZcvaDOutlljYbbX4Qxo4hwKCwT+
   9x8HMPS0iNPU4ivEQFNfzocoKss/T1WkVYt7QNubOYA8XWg2hnXnUBRmx
   4LizDIAGqudwQeJRfqc3zm5a3zqQV7TXFs6nTDTHOGrxYle9I5OJXR6S0
   1O1r+atlsgN6VCMkCJ0wm1OYMgDyhW1K02Ol9kr50wTG9N/08qdlM4RQD
   v8ZFTMyAAyeYmucD8lRTuPncoYh83zooe1AA416P5kaTXbnGRt0w8nBcm
   BTUotg2nqsSipZ3ZvsN9bSVQEnW9BW3Ah0qMCk3tk0nxk60VwoN+EZkn5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="389167612"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="389167612"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 20:10:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="1113691808"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="1113691808"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jan 2024 20:10:21 -0800
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
Subject: [PATCH v11 1/8] iommu: Add cache_invalidate_user op
Date: Wed, 10 Jan 2024 20:10:08 -0800
Message-Id: <20240111041015.47920-2-yi.l.liu@intel.com>
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

From: Lu Baolu <baolu.lu@linux.intel.com>

The updates of the PTEs in the nested page table will be propagated to the
hardware caches.

Add a new domain op cache_invalidate_user for the userspace to flush the
hardware caches for a nested domain through iommufd. No wrapper for it,
as it's only supposed to be used by iommufd. Then, pass in invalidation
requests in form of a user data array containing a number of invalidation
data entries.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
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


