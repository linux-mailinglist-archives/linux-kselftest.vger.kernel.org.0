Return-Path: <linux-kselftest+bounces-2835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A09B882A6E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 05:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183361F21FFF
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 04:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F1515D5;
	Thu, 11 Jan 2024 04:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="asQJoT0o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C117ADF69;
	Thu, 11 Jan 2024 04:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704946234; x=1736482234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sjL5Dfrqx7fX931BlScUsmc+6VABv8SzlS11acNijUI=;
  b=asQJoT0oeFC4yI2fXJKJ0sZW3UljPh8MAM5s2Fkw00Pq87Ve3NDOGndd
   SdtJycS7sx/GZfQsg/smnOF79ZxNV6apITivBFYkItyvGctxd3eGtyN2M
   5DDT3Um4e9h3i5/tl0vIGr9YG2strzIW3i/f+n9DcTcd5IE6JDemmoBmp
   1oX/Ed5a9v4sLiPOozPZNwJeaNttSrzuJ3mC+HIdy+h5HwGIDL00gCFNq
   MpxHkBH2T4lKcJ3w6tNZ19virCUgqmsM0PUAGnfKXAjEXUACZSO9Rcun2
   oHMjX6Cu6JFxRPByyA/Sp6T8z2Kbhy1fonvd/f/AaJkFjx/fvSfae7qHa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="389167702"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="389167702"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 20:10:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="1113691918"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="1113691918"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jan 2024 20:10:32 -0800
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
Subject: [PATCH v11 8/8] iommu/vt-d: Add iotlb flush for nested domain
Date: Wed, 10 Jan 2024 20:10:15 -0800
Message-Id: <20240111041015.47920-9-yi.l.liu@intel.com>
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

This implements the .cache_invalidate_user() callback to support iotlb
flush for nested domain.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Co-developed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/nested.c | 88 ++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index b5a5563ab32c..1e866ed02fef 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -73,9 +73,97 @@ static void intel_nested_domain_free(struct iommu_domain *domain)
 	kfree(to_dmar_domain(domain));
 }
 
+static void nested_flush_dev_iotlb(struct dmar_domain *domain, u64 addr,
+				   unsigned mask)
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
+				   qdep, addr, mask);
+		quirk_extra_dev_tlb_flush(info, addr, mask,
+					  IOMMU_NO_PASID, qdep);
+	}
+	spin_unlock_irqrestore(&domain->lock, flags);
+}
+
+static void intel_nested_flush_cache(struct dmar_domain *domain, u64 addr,
+				     unsigned long npages, bool ih)
+{
+	struct iommu_domain_info *info;
+	unsigned long i;
+	unsigned mask;
+
+	xa_for_each(&domain->iommu_array, i, info)
+		qi_flush_piotlb(info->iommu,
+				domain_id_iommu(domain, info->iommu),
+				IOMMU_NO_PASID, addr, npages, ih);
+
+	if (!domain->has_iotlb_device)
+		return;
+
+	if (npages == U64_MAX)
+		mask = 64 - VTD_PAGE_SHIFT;
+	else
+		mask = ilog2(__roundup_pow_of_two(npages));
+
+	nested_flush_dev_iotlb(domain, addr, mask);
+}
+
+static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
+					      struct iommu_user_data_array *array)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct iommu_hwpt_vtd_s1_invalidate inv_entry;
+	u32 index, processed = 0;
+	int ret = 0;
+
+	if (array->type != IOMMU_HWPT_INVALIDATE_DATA_VTD_S1) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	for (index = 0; index < array->entry_num; index++) {
+		ret = iommu_copy_struct_from_user_array(&inv_entry, array,
+							IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
+							index, __reserved);
+		if (ret)
+			break;
+
+		if ((inv_entry.flags & ~IOMMU_VTD_INV_FLAGS_LEAF) ||
+		    inv_entry.__reserved) {
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
+					 inv_entry.flags & IOMMU_VTD_INV_FLAGS_LEAF);
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


