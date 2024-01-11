Return-Path: <linux-kselftest+bounces-2833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C728C82A6DD
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 05:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8621F2148B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 04:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94B815CA;
	Thu, 11 Jan 2024 04:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CqhF6760"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F29DD304;
	Thu, 11 Jan 2024 04:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704946233; x=1736482233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fC5z37HXi07mvbopXKTyjsrDjk4TmLvNb4c2PaNCrJ4=;
  b=CqhF6760gBcLRxJFAsL5vzdG1tk5RkeAagwIaTUD6QkAd48c6SZjjc7Z
   WsuQd/9D/XNlB3k22ftQnEAtXc5sa22CkcyxJ9WBWBAtR6UnMIAwT/fUy
   bHVuGzyVtAYijTNQE6toEDX5IivVTx+A8aToGDk5fpHV8s5ndd7ivGX9v
   NRUPKlfexGgaCT2r4sRe65D4M9LYKGBd7EVRVRee384kcjMF/O8GxVAlw
   VLl326l2Zmjx9PkRDemKWIcMuEWq4f6WHdarSkUBfFiTyK0R6XPJU4+4c
   6LJFsV15xlvkECxi65CvE8J6MpcuriUegDuuP+lt50DHd5TVIGmpnMgUV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="389167690"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="389167690"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 20:10:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="1113691901"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="1113691901"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jan 2024 20:10:31 -0800
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
Subject: [PATCH v11 7/8] iommufd: Add data structure for Intel VT-d stage-1 cache invalidation
Date: Wed, 10 Jan 2024 20:10:14 -0800
Message-Id: <20240111041015.47920-8-yi.l.liu@intel.com>
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

This adds the data structure invalidating caches for the nested domain
allocated with IOMMU_HWPT_DATA_VTD_S1 type.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/uapi/linux/iommufd.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 824560c50ec6..1dfeaa2e649e 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -623,6 +623,42 @@ enum iommu_hwpt_invalidate_data_type {
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
+ * struct iommu_hwpt_vtd_s1_invalidate - Intel VT-d cache invalidation
+ *                                       (IOMMU_HWPT_INVALIDATE_DATA_VTD_S1)
+ * @addr: The start address of the range to be invalidated. It needs to
+ *        be 4KB aligned.
+ * @npages: Number of contiguous 4K pages to be invalidated.
+ * @flags: Combination of enum iommu_hwpt_vtd_s1_invalidate_flags
+ * @__reserved: Must be 0
+ *
+ * The Intel VT-d specific invalidation data for user-managed stage-1 cache
+ * invalidation in nested translation. Userspace uses this structure to
+ * tell the impacted cache scope after modifying the stage-1 page table.
+ *
+ * Invalidating all the caches related to the page table by setting @addr
+ * to be 0 and @npages to be U64_MAX.
+ *
+ * The device TLB will be invalidated automatically if ATS is enabled.
+ */
+struct iommu_hwpt_vtd_s1_invalidate {
+	__aligned_u64 addr;
+	__aligned_u64 npages;
+	__u32 flags;
+	__u32 __reserved;
+};
+
 /**
  * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
  * @size: sizeof(struct iommu_hwpt_invalidate)
-- 
2.34.1


