Return-Path: <linux-kselftest+bounces-2578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74999821DF2
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 15:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F322838C0
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 14:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B575412E4D;
	Tue,  2 Jan 2024 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GBVAPcaJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A06815AF7;
	Tue,  2 Jan 2024 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704206329; x=1735742329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pIwuSBuivaLiuysTG8SR9U5i6WTksuS89VvUb25xUrk=;
  b=GBVAPcaJSTmBzpBxXX0MCBb3qVmexi6bWxw7/x3M4/DwdxNMLaRmyF/1
   G4dMX7sTVd4PxAefMsCoRxpL55RSewMYxZe0dgcw8oAyoQP+Wh2h1OuiH
   yMNurTB92kTmkntD+PaWDGrLyMrRnODjkzCw47cR6KrPEeCQxKB+fOKwy
   KSrsqD0BVZ0l2XWorm7RpOjoFVVrlUdVcLIpG/Hue3/W5j12T0SPlRHWr
   zCBQn7rAgG2bPUqbzzetkp6WurVPCGzsN1m0GiBGG6/T1+riRLmSrzOWt
   doHXYchtffZ3GnPi1o5T6xYv17RIO0K/guetR2kdnxXu79Y99nZ+YF+2E
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="10270514"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="10270514"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 06:38:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="923234326"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="923234326"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jan 2024 06:38:47 -0800
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
Subject: [PATCH v10 09/10] iommufd: Add data structure for Intel VT-d stage-1 cache invalidation
Date: Tue,  2 Jan 2024 06:38:33 -0800
Message-Id: <20240102143834.146165-10-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102143834.146165-1-yi.l.liu@intel.com>
References: <20240102143834.146165-1-yi.l.liu@intel.com>
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


