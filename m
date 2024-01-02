Return-Path: <linux-kselftest+bounces-2579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C985A821DF8
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 15:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6CA1F22DB5
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 14:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB69A15E9D;
	Tue,  2 Jan 2024 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="REQ2etLw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAF916414;
	Tue,  2 Jan 2024 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704206330; x=1735742330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NVOmCLUpjiadLIpufkixMz24Btn82kCB3C2V3+0Ea9k=;
  b=REQ2etLwb2gi5kW0E5jPTrkdWI9qunSdqYYFXJbrPgp04pmhod8/U+Tk
   NVftdg57DePg1G5Uvtwezn9zah47skegpBG0y9wdm0SsJNkZGZOhKPXQv
   snKHNbqPHM++pzmFmCotUX0k9d08is5g5Ws+IzhacC14xzC+KTBNPU8L2
   R6pQ+d3AgxtSmai4zCBVNUuSOT37Ao2twYMp9QynF9BmLasbUgHZH3r5H
   tJXN+23O0vm91hBDhK6vWd4IG+OVsMbx0VosbMR8O8O6hh1l9KG04jvN2
   TWRQbgS6s6WdOTItorrxxlrkTkxh6d99IRP/biIAPeDHSkzIOwq01YC20
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="10270524"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="10270524"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 06:38:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="923234334"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="923234334"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jan 2024 06:38:48 -0800
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
Subject: [PATCH v10 10/10] iommu/vt-d: Add iotlb flush for nested domain
Date: Tue,  2 Jan 2024 06:38:34 -0800
Message-Id: <20240102143834.146165-11-yi.l.liu@intel.com>
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

From: Lu Baolu <baolu.lu@linux.intel.com>

This implements the .cache_invalidate_user() callback to support iotlb
flush for nested domain.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Co-developed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/nested.c | 107 +++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index b5a5563ab32c..f1f86437939c 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -73,9 +73,116 @@ static void intel_nested_domain_free(struct iommu_domain *domain)
 	kfree(to_dmar_domain(domain));
 }
 
+static void nested_flush_dev_iotlb(struct dmar_domain *domain, u64 addr,
+				   unsigned mask, u32 *fault)
+{
+	struct device_domain_info *info;
+	unsigned long flags;
+	u16 sid, qdep;
+
+	spin_lock_irqsave(&domain->lock, flags);
+	list_for_each_entry(info, &domain->devices, link) {
+		if (!info->ats_enabled)
+			continue;
+		sid = info->bus << 8 | info->devfn;
+		qdep = info->ats_qdep;
+		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
+				   qdep, addr, mask, fault);
+		quirk_extra_dev_tlb_flush(info, addr, mask,
+					  IOMMU_NO_PASID, qdep);
+	}
+	spin_unlock_irqrestore(&domain->lock, flags);
+}
+
+static void intel_nested_flush_cache(struct dmar_domain *domain, u64 addr,
+				     unsigned long npages, bool ih, u32 *error)
+{
+	struct iommu_domain_info *info;
+	unsigned long i;
+	unsigned mask;
+	u32 fault;
+
+	xa_for_each(&domain->iommu_array, i, info)
+		qi_flush_piotlb(info->iommu,
+				domain_id_iommu(domain, info->iommu),
+				IOMMU_NO_PASID, addr, npages, ih, NULL);
+
+	if (!domain->has_iotlb_device)
+		return;
+
+	if (npages == U64_MAX)
+		mask = 64 - VTD_PAGE_SHIFT;
+	else
+		mask = ilog2(__roundup_pow_of_two(npages));
+
+	nested_flush_dev_iotlb(domain, addr, mask, &fault);
+
+	*error = 0;
+	/*
+	 * Invalidation queue error (i.e. IQE) will not be reported to user
+	 * as it's caused only by driver internal bug.
+	 */
+	if (fault & DMA_FSTS_ICE)
+		*error |= IOMMU_HWPT_INVALIDATE_VTD_S1_ICE;
+	if (fault & DMA_FSTS_ITE)
+		*error |= IOMMU_HWPT_INVALIDATE_VTD_S1_ITE;
+}
+
+static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
+					      struct iommu_user_data_array *array)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct iommu_hwpt_vtd_s1_invalidate inv_entry;
+	u32 processed = 0;
+	int ret = 0;
+	u32 index;
+
+	if (array->type != IOMMU_HWPT_INVALIDATE_DATA_VTD_S1) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	for (index = 0; index < array->entry_num; index++) {
+		ret = iommu_copy_struct_from_user_array(&inv_entry, array,
+							IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
+							index, hw_error);
+		if (ret)
+			break;
+
+		if (inv_entry.flags & ~IOMMU_VTD_INV_FLAGS_LEAF) {
+			ret = -EOPNOTSUPP;
+			break;
+		}
+
+		if (!IS_ALIGNED(inv_entry.addr, VTD_PAGE_SIZE) ||
+		    ((inv_entry.npages == U64_MAX) && inv_entry.addr)) {
+			ret = -EINVAL;
+			break;
+		}
+
+		intel_nested_flush_cache(dmar_domain, inv_entry.addr,
+					 inv_entry.npages,
+					 inv_entry.flags & IOMMU_VTD_INV_FLAGS_LEAF,
+					 &inv_entry.hw_error);
+
+		ret = iommu_respond_struct_to_user_array(array, index,
+							 (void *)&inv_entry,
+							 sizeof(inv_entry));
+		if (ret)
+			break;
+
+		processed++;
+	}
+
+out:
+	array->entry_num = processed;
+	return ret;
+}
+
 static const struct iommu_domain_ops intel_nested_domain_ops = {
 	.attach_dev		= intel_nested_attach_dev,
 	.free			= intel_nested_domain_free,
+	.cache_invalidate_user	= intel_nested_cache_invalidate_user,
 };
 
 struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,
-- 
2.34.1


