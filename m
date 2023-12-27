Return-Path: <linux-kselftest+bounces-2475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4231581F031
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 17:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D85D1B22707
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 16:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9C84988C;
	Wed, 27 Dec 2023 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDF7m4SM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B07E48CE5;
	Wed, 27 Dec 2023 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703693651; x=1735229651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WdtqJXn4o/JksNspoDogjPrqBmrQwHzi0UiIL1TFC3M=;
  b=oDF7m4SMhO/maK+SVnqW4DfJ0Y8rRl5SZgIkMtQLVqk/DFIPwyjgvkA8
   zpEzd8jaNPzHvphLK8SCrkr/s2gU4ZHVcErUQke+PmDRf59cmjAU1bt6Q
   oYZ2cecKy7TI8VEHp4UBQpuBIuEJX29hfZzHWodIVWzecipgNDDb9Zdpc
   IGGrm/hywDgL95db8wkomQiBl6t67xLBbAGhxSa9DB8tgWjPh1bRAUChA
   m32Nem728GsZ4broB9j2WF8ZpISrUNDeba6Q8abFi7XfH8ZrJgSzV0mUM
   zujhtJzr1Hy85lHuYCuBJfFbbfNucqwb/SXxlR7WeSi/MnWrxVQsRTISz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="396186309"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="396186309"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:14:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="781775227"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="781775227"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 27 Dec 2023 08:14:09 -0800
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
Subject: [PATCH v8 09/10] iommufd: Add data structure for Intel VT-d stage-1 cache invalidation
Date: Wed, 27 Dec 2023 08:13:53 -0800
Message-Id: <20231227161354.67701-10-yi.l.liu@intel.com>
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

This adds the data structure invalidating caches for the nested domain
allocated with IOMMU_HWPT_DATA_VTD_S1 type.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/uapi/linux/iommufd.h | 55 ++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 824560c50ec6..2067aa00d2a3 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -623,6 +623,61 @@ enum iommu_hwpt_invalidate_data_type {
 	IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
 };
 
+/**
+ * enum iommu_hwpt_vtd_s1_invalidate_flags - Flags for Intel VT-d
+ *                                           stage-1 cache invalidation
+ * @IOMMU_VTD_INV_FLAGS_LEAF: Indicates whether the invalidation applies
+ *                            to all-levels page structure cache or just
+ *                            the leaf PTE cache.
+ */
+enum iommu_hwpt_vtd_s1_invalidate_flags {
+	IOMMU_VTD_INV_FLAGS_LEAF = 1 << 0,
+};
+
+/**
+ * enum iommu_hwpt_vtd_s1_invalidate_error - Hardware error of invalidation
+ * @IOMMU_HWPT_INVALIDATE_VTD_S1_ICE: Invalidation Completion Error, details
+ *                                    refer to 11.4.7.1 Fault Status Register
+ *                                    of VT-d specification.
+ * @IOMMU_HWPT_INVALIDATE_VTD_S1_ITE: Invalidation Time-out Error, details
+ *                                    refer to 11.4.7.1 Fault Status Register
+ *                                    of VT-d specification.
+ */
+enum iommu_hwpt_vtd_s1_invalidate_error {
+	IOMMU_HWPT_INVALIDATE_VTD_S1_ICE = 1 << 0,
+	IOMMU_HWPT_INVALIDATE_VTD_S1_ITE = 1 << 1,
+};
+
+/**
+ * struct iommu_hwpt_vtd_s1_invalidate - Intel VT-d cache invalidation
+ *                                       (IOMMU_HWPT_INVALIDATE_DATA_VTD_S1)
+ * @addr: The start address of the range to be invalidated. It needs to
+ *        be 4KB aligned.
+ * @npages: Number of contiguous 4K pages to be invalidated.
+ * @flags: Combination of enum iommu_hwpt_vtd_s1_invalidate_flags
+ * @hw_error: One of enum iommu_hwpt_vtd_s1_invalidate_error
+ *
+ * The Intel VT-d specific invalidation data for user-managed stage-1 cache
+ * invalidation in nested translation. Userspace uses this structure to
+ * tell the impacted cache scope after modifying the stage-1 page table.
+ *
+ * Invalidating all the caches related to the page table by setting @addr
+ * to be 0 and @npages to be U64_MAX.
+ *
+ * The device TLB will be invalidated automatically if ATS is enabled.
+ *
+ * The @hw_error is meaningful when the entry is handled by the kernel.
+ * Check the entry_num output of IOMMU_HWPT_INVALIDATE ioctl to know the
+ * handled entries. @hw_error only covers the errors detected by hardware.
+ * The software detected errors would go through the normal ioctl errno.
+ */
+struct iommu_hwpt_vtd_s1_invalidate {
+	__aligned_u64 addr;
+	__aligned_u64 npages;
+	__u32 flags;
+	__u32 hw_error;
+};
+
 /**
  * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
  * @size: sizeof(struct iommu_hwpt_invalidate)
-- 
2.34.1


