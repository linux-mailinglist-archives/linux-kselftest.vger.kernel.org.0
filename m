Return-Path: <linux-kselftest+bounces-2474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9210C81F02E
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 17:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08293B227AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 16:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC7848CEF;
	Wed, 27 Dec 2023 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JYOWIVKU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59A6482FE;
	Wed, 27 Dec 2023 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703693649; x=1735229649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6z+F2MIobYMCwciVcWcITx/eB+oS3TBjMhYvHV4t75M=;
  b=JYOWIVKURPhzRAJ96fQRwycbM+pd7HaeFBoxrbfE1hHI4xS86hfPMaFq
   xiOwAbMunbIKBH+PzFIeFfECjNzrjDShCmi4dkAVHKHwoJTb/0P9CymzE
   sBOyaQ1PrBNROGNfYjma+X+RQ6i54tneRrnmWVj676Ufl7GWdLRbV2O3r
   sbihlYA08dVjDcwI9GiOpNjkomaoFJgig4o+TvUleymgwAIdgLvyThGQ/
   Kg1QasZ3U8tsC9dHBR6YM1xYjKKBg6cHLjEn+DZHXIYx1RGXp9HN3PXbq
   Ij1YrqU6gYYS0leOqfA6wHcS7zO51h0qjbhH1Yz0sDNd4Tkxsz7Qnfti2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="396186294"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="396186294"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:14:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="781775222"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="781775222"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 27 Dec 2023 08:14:07 -0800
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
Subject: [PATCH v8 08/10] iommu/vt-d: Convert stage-1 cache invalidation to return QI fault
Date: Wed, 27 Dec 2023 08:13:52 -0800
Message-Id: <20231227161354.67701-9-yi.l.liu@intel.com>
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

From: Lu Baolu <baolu.lu@linux.intel.com>

This makes the pasid based cache invalidation and device TLB invalidation
to return QI faults to callers. This is needed when usersapce invalidates
cache after modifying the stage-1 page table used in nested translation.
Hardware errors during invalidation should be reported to user.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/dmar.c  | 13 +++++++------
 drivers/iommu/intel/iommu.c | 12 ++++++------
 drivers/iommu/intel/iommu.h |  6 +++---
 drivers/iommu/intel/pasid.c | 12 +++++++-----
 drivers/iommu/intel/svm.c   |  8 ++++----
 5 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 701705b3a8ea..91635bd6493d 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1527,7 +1527,7 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 }
 
 void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
-			u16 qdep, u64 addr, unsigned mask)
+			u16 qdep, u64 addr, unsigned mask, u32 *fault)
 {
 	struct qi_desc desc;
 
@@ -1554,12 +1554,12 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	qi_submit_sync(iommu, &desc, 1, 0, NULL);
+	qi_submit_sync(iommu, &desc, 1, 0, fault);
 }
 
 /* PASID-based IOTLB invalidation */
 void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
-		     unsigned long npages, bool ih)
+		     unsigned long npages, bool ih, u32 *fault)
 {
 	struct qi_desc desc = {.qw2 = 0, .qw3 = 0};
 
@@ -1595,12 +1595,13 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
 				QI_EIOTLB_AM(mask);
 	}
 
-	qi_submit_sync(iommu, &desc, 1, 0, NULL);
+	qi_submit_sync(iommu, &desc, 1, 0, fault);
 }
 
 /* PASID-based device IOTLB Invalidate */
 void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
-			      u32 pasid,  u16 qdep, u64 addr, unsigned int size_order)
+			      u32 pasid,  u16 qdep, u64 addr,
+			      unsigned int size_order, u32 *fault)
 {
 	unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order - 1);
 	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
@@ -1648,7 +1649,7 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 		desc.qw1 |= QI_DEV_EIOTLB_SIZE;
 	}
 
-	qi_submit_sync(iommu, &desc, 1, 0, NULL);
+	qi_submit_sync(iommu, &desc, 1, 0, fault);
 }
 
 void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did,
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 897159dba47d..68e494f1d03a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1462,7 +1462,7 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
 	sid = info->bus << 8 | info->devfn;
 	qdep = info->ats_qdep;
 	qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
-			   qdep, addr, mask);
+			   qdep, addr, mask, NULL);
 	quirk_extra_dev_tlb_flush(info, addr, mask, IOMMU_NO_PASID, qdep);
 }
 
@@ -1490,7 +1490,7 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 					 PCI_DEVID(info->bus, info->devfn),
 					 info->pfsid, dev_pasid->pasid,
 					 info->ats_qdep, addr,
-					 mask);
+					 mask, NULL);
 	}
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
@@ -1505,10 +1505,10 @@ static void domain_flush_pasid_iotlb(struct intel_iommu *iommu,
 
 	spin_lock_irqsave(&domain->lock, flags);
 	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain)
-		qi_flush_piotlb(iommu, did, dev_pasid->pasid, addr, npages, ih);
+		qi_flush_piotlb(iommu, did, dev_pasid->pasid, addr, npages, ih, NULL);
 
 	if (!list_empty(&domain->devices))
-		qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr, npages, ih);
+		qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr, npages, ih, NULL);
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
@@ -5195,10 +5195,10 @@ void quirk_extra_dev_tlb_flush(struct device_domain_info *info,
 	sid = PCI_DEVID(info->bus, info->devfn);
 	if (pasid == IOMMU_NO_PASID) {
 		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
-				   qdep, address, mask);
+				   qdep, address, mask, NULL);
 	} else {
 		qi_flush_dev_iotlb_pasid(info->iommu, sid, info->pfsid,
-					 pasid, qdep, address, mask);
+					 pasid, qdep, address, mask, NULL);
 	}
 }
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index c6de958e4f54..ce9bd08dcd05 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -866,14 +866,14 @@ void qi_flush_context(struct intel_iommu *iommu, u16 did,
 void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 		    unsigned int size_order, u64 type);
 void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
-			u16 qdep, u64 addr, unsigned mask);
+			u16 qdep, u64 addr, unsigned mask, u32 *fault);
 
 void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
-		     unsigned long npages, bool ih);
+		     unsigned long npages, bool ih, u32 *fault);
 
 void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 			      u32 pasid, u16 qdep, u64 addr,
-			      unsigned int size_order);
+			      unsigned int size_order, u32 *fault);
 void quirk_extra_dev_tlb_flush(struct device_domain_info *info,
 			       unsigned long address, unsigned long pages,
 			       u32 pasid, u16 qdep);
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 67f924760ba8..4a7fe551d8a6 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -492,9 +492,11 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 	 * efficient to flush devTLB specific to the PASID.
 	 */
 	if (pasid == IOMMU_NO_PASID)
-		qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 - VTD_PAGE_SHIFT);
+		qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0,
+				   64 - VTD_PAGE_SHIFT, NULL);
 	else
-		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid, qdep, 0, 64 - VTD_PAGE_SHIFT);
+		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid, qdep, 0,
+					 64 - VTD_PAGE_SHIFT, NULL);
 }
 
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
@@ -521,7 +523,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
 
 	if (pgtt == PASID_ENTRY_PGTT_PT || pgtt == PASID_ENTRY_PGTT_FL_ONLY)
-		qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
+		qi_flush_piotlb(iommu, did, pasid, 0, -1, 0, NULL);
 	else
 		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
 
@@ -543,7 +545,7 @@ static void pasid_flush_caches(struct intel_iommu *iommu,
 
 	if (cap_caching_mode(iommu->cap)) {
 		pasid_cache_invalidation_with_pasid(iommu, did, pasid);
-		qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
+		qi_flush_piotlb(iommu, did, pasid, 0, -1, 0, NULL);
 	} else {
 		iommu_flush_write_buffer(iommu);
 	}
@@ -834,7 +836,7 @@ void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
 	 *      Addr[63:12]=0x7FFFFFFF_FFFFF) to affected functions
 	 */
 	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
-	qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
+	qi_flush_piotlb(iommu, did, pasid, 0, -1, 0, NULL);
 
 	/* Device IOTLB doesn't need to be flushed in caching mode. */
 	if (!cap_caching_mode(iommu->cap))
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 660d049ad5b6..bf7b4c5c21f4 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -179,11 +179,11 @@ static void __flush_svm_range_dev(struct intel_svm *svm,
 	if (WARN_ON(!pages))
 		return;
 
-	qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, address, pages, ih);
+	qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, address, pages, ih, NULL);
 	if (info->ats_enabled) {
 		qi_flush_dev_iotlb_pasid(sdev->iommu, sdev->sid, info->pfsid,
 					 svm->pasid, sdev->qdep, address,
-					 order_base_2(pages));
+					 order_base_2(pages), NULL);
 		quirk_extra_dev_tlb_flush(info, address, order_base_2(pages),
 					  svm->pasid, sdev->qdep);
 	}
@@ -225,11 +225,11 @@ static void intel_flush_svm_all(struct intel_svm *svm)
 	list_for_each_entry_rcu(sdev, &svm->devs, list) {
 		info = dev_iommu_priv_get(sdev->dev);
 
-		qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, 0, -1UL, 0);
+		qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, 0, -1UL, 0, NULL);
 		if (info->ats_enabled) {
 			qi_flush_dev_iotlb_pasid(sdev->iommu, sdev->sid, info->pfsid,
 						 svm->pasid, sdev->qdep,
-						 0, 64 - VTD_PAGE_SHIFT);
+						 0, 64 - VTD_PAGE_SHIFT, NULL);
 			quirk_extra_dev_tlb_flush(info, 0, 64 - VTD_PAGE_SHIFT,
 						  svm->pasid, sdev->qdep);
 		}
-- 
2.34.1


