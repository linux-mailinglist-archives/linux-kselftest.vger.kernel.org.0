Return-Path: <linux-kselftest+bounces-2506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C7081F974
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 16:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2FA1F22ED3
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 15:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1981311CB6;
	Thu, 28 Dec 2023 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TKFDMsST"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDAD11726;
	Thu, 28 Dec 2023 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703776006; x=1735312006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pIwuSBuivaLiuysTG8SR9U5i6WTksuS89VvUb25xUrk=;
  b=TKFDMsSTWT9chyIj0YQxG2cSMjxL9WR+LmdXSXBN/eGqtLd977gmvyxx
   dPgjXTDHlUFRBkbe+LuzZBKTt07G5qX+dfHARUU3MFLnB/H87/D5pxfkR
   fO6gjMH1H3JCwRI9KPUKPnvN7rRKsBrmXO/X5KS6QhlvkzOfW7cuDH3HK
   Q7VeLJvabvsj7uWT/SWkUmdbOIcHN3df4E4nhSYYP9BqEicr8Y6BzXZe6
   0na00xnSO45TrWhcCZysH2TAoi+lq8AzYDEiG77y400PklJiLSxtGs1kY
   FQvoMX+eVjukDzs2BS97H5dRMlhnYG50ChJ6UfmySzg2rhIIX7SYLN7Jl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="393702019"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="393702019"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 07:06:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="869155186"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="869155186"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Dec 2023 07:06:45 -0800
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
Subject: [PATCH v9 09/10] iommufd: Add data structure for Intel VT-d stage-1 cache invalidation
Date: Thu, 28 Dec 2023 07:06:28 -0800
Message-Id: <20231228150629.13149-10-yi.l.liu@intel.com>
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

This adds the data structure invalidating caches for the nested domain
allocated with IOMMU_HWPT_DATA_VTD_S1 type.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/uapi/linux/iommufd.h | 58 ++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 824560c50ec6..37c778055201 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -623,6 +623,64 @@ enum iommu_hwpt_invalidate_data_type {
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
+ * An entry is considered 'handled' after it passes the audit and submitted
+ * to the IOMMU by the underlying driver. Check the @entry_num output of
+ * struct iommu_hwpt_invalidate for the number of handled entries. A 'handled'
+ * request may still fail in hardware for various reasons, e.g. due to timeout
+ * on waiting for device response upon a device TLB invalidation request. In
+ * such case the hardware error info is reported in the @hw_error field of the
+ * handled entry.
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


