Return-Path: <linux-kselftest+bounces-17818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA149769F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 15:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BDAEB22F80
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 13:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFCF1A725E;
	Thu, 12 Sep 2024 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="murYvYre"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84901E4AF
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146277; cv=none; b=o2SGEIHowtg3bjyggsKl7obedkYq7u3mOUbBoAIvam0hgByn1+hRoKJdGhTk687ODfGpotTHzKhn8gNi03FBIkCmdEEEt8TSsT3/C4Cpvb3ia1GgpBWRKQhtijC+4YwWWE+Tfyc+NTfAUO0kuK4k9TD61E3bhkuWf9oW1gpB0LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146277; c=relaxed/simple;
	bh=onVquu5oC+6ms7xpsV6VzKaqZfXj4okdcYo5OlHXftk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DhjKhEgsG/+d7hZwxEOd+B6qSYeE4nzdbQH+Sj+itnnRu1b8e5CyLVIhMOvL1LJVi1Ezxe6/cwlvJIo4E82mb+WcwyXina59F07Gq5zgRbDUO56BSiKRXLzICH7SZQV6wG84zaiNUEjx+4FSuTwyVRw/1uTErgEo9I2sgdnqktM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=murYvYre; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726146275; x=1757682275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=onVquu5oC+6ms7xpsV6VzKaqZfXj4okdcYo5OlHXftk=;
  b=murYvYrecNTUJRBnvb2D1PV6a5ef0BseeZfV0CPIJk3vJhncZzmDgud2
   ZPte2n7yMrBUUlwFrFDtrLNRWcvoKXb0OpEwvi7U1hT8kbvA+kAY5efTu
   FOvY7XBGAc1voAVW3Fs6PRloerlUBhh7M7W4y17ktr2dQVXS2hvOo/MIW
   rER0/v9+aJA4H2D/XG8zasLyA5QF46uGlutPk6KUJhLeS7S/M1smLNOIE
   5iHbpRsd3Q/fTV4Q+fQNeMOcVVixwUwcx8FINGTsjTpFMEO2AWahg56Nd
   ow6zmCWvnvEOlc5O6uSrCaqYfaH2LB8Q2oB/hYeCRn6rqCsPBio2I6ooX
   Q==;
X-CSE-ConnectionGUID: AE8D9dAWTOmjNJbMpQPlVA==
X-CSE-MsgGUID: GqFnZjMISdKaXPzulTP/HA==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="36380534"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="36380534"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:04:33 -0700
X-CSE-ConnectionGUID: XrTzIH2dRc+d8LnCiJpcWw==
X-CSE-MsgGUID: qrFuWBf6SFC9Kk65i3Ha+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="72509919"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa005.jf.intel.com with ESMTP; 12 Sep 2024 06:04:33 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	linux-kselftest@vger.kernel.org,
	vasant.hegde@amd.com
Subject: [PATCH v2 2/6] iommu/vt-d: Move intel_drain_pasid_prq() into intel_pasid_tear_down_entry()
Date: Thu, 12 Sep 2024 06:04:23 -0700
Message-Id: <20240912130427.10119-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912130427.10119-1-yi.l.liu@intel.com>
References: <20240912130427.10119-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Draining PRQ is mostly conjuncted with pasid teardown, and with more callers coming,
move it into it in the intel_pasid_tear_down_entry(). But there is scenario that only
teardown pasid entry but no PRQ drain, so passing a flag to mark it.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c |  8 ++++----
 drivers/iommu/intel/pasid.c | 13 +++++++++++--
 drivers/iommu/intel/pasid.h |  8 +++++---
 drivers/iommu/intel/svm.c   |  3 ++-
 4 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1a2a5cf4ef60..80b587de226d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3376,7 +3376,7 @@ void device_block_translation(struct device *dev)
 	if (!dev_is_real_dma_subdevice(dev)) {
 		if (sm_supported(iommu))
 			intel_pasid_tear_down_entry(iommu, dev,
-						    IOMMU_NO_PASID, false);
+						    IOMMU_NO_PASID, 0);
 		else
 			domain_context_clear(info);
 	}
@@ -4258,7 +4258,7 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 	unsigned long flags;
 
 	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
-		intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+		intel_pasid_tear_down_entry(iommu, dev, pasid, 0);
 		return;
 	}
 
@@ -4278,8 +4278,8 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 	domain_detach_iommu(dmar_domain, iommu);
 	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
 	kfree(dev_pasid);
-	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
-	intel_drain_pasid_prq(dev, pasid);
+	intel_pasid_tear_down_entry(iommu, dev, pasid,
+				    INTEL_PASID_TEARDOWN_DRAIN_PRQ);
 }
 
 static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index b51fc268dc84..ceb9c5274a39 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -236,8 +236,13 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid, qdep, 0, 64 - VTD_PAGE_SHIFT);
 }
 
+/*
+ * Not all PASID entry destroy requires PRQ drain as it can be handled in
+ * the remove_dev_pasid path. Caller should be clear about it and set the
+ * @flags properly.
+ */
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
-				 u32 pasid, bool fault_ignore)
+				 u32 pasid, u32 flags)
 {
 	struct pasid_entry *pte;
 	u16 did, pgtt;
@@ -251,7 +256,8 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 
 	did = pasid_get_domain_id(pte);
 	pgtt = pasid_pte_get_pgtt(pte);
-	intel_pasid_clear_entry(dev, pasid, fault_ignore);
+	intel_pasid_clear_entry(dev, pasid,
+				flags & INTEL_PASID_TEARDOWN_IGNORE_FAULT);
 	spin_unlock(&iommu->lock);
 
 	if (!ecap_coherent(iommu->ecap))
@@ -267,6 +273,9 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 	/* Device IOTLB doesn't need to be flushed in caching mode. */
 	if (!cap_caching_mode(iommu->cap))
 		devtlb_invalidation_with_pasid(iommu, dev, pasid);
+
+	if (flags & INTEL_PASID_TEARDOWN_DRAIN_PRQ)
+		intel_drain_pasid_prq(dev, pasid);
 }
 
 /*
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index dde6d3ba5ae0..6eb849ec5fb8 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -303,9 +303,11 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 				   struct device *dev, u32 pasid);
 int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 			     u32 pasid, struct dmar_domain *domain);
-void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
-				 struct device *dev, u32 pasid,
-				 bool fault_ignore);
+
+#define INTEL_PASID_TEARDOWN_IGNORE_FAULT	(1U << 0)
+#define INTEL_PASID_TEARDOWN_DRAIN_PRQ		(1U << 1)
+void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
+				 u32 pasid, u32 flags);
 void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
 					  struct device *dev, u32 pasid);
 int intel_pasid_setup_sm_context(struct device *dev);
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 5ae1df7598b7..3c1e105b9da6 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -176,7 +176,8 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain) {
 		info = dev_iommu_priv_get(dev_pasid->dev);
 		intel_pasid_tear_down_entry(info->iommu, dev_pasid->dev,
-					    dev_pasid->pasid, true);
+					    dev_pasid->pasid,
+					    INTEL_PASID_TEARDOWN_IGNORE_FAULT);
 	}
 	spin_unlock_irqrestore(&domain->lock, flags);
 
-- 
2.34.1


