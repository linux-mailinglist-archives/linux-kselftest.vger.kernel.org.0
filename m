Return-Path: <linux-kselftest+bounces-2576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4A6821DEA
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 15:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E9D28350B
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 14:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085BF15AF1;
	Tue,  2 Jan 2024 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SdLgbPm5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDB0156F0;
	Tue,  2 Jan 2024 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704206327; x=1735742327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pEYBNa0M9lZzJ/nWD3V7BKxpMiETKpIwIqr86MnTO2s=;
  b=SdLgbPm5bgFc+GQLBVR9dGVphI93+U2OixdDF6SBG5F2hhb6K/mxNk+5
   Hh2bjLjwMwMqOjoy8YtgUrHpIBtKyqXQJzlT1o7X33tYd23Ed7Kl4XLcW
   LANhIuIp+tS0HdocvlcQwEZzlZR5hCz2QiCCmHvZgNoqbZteJFG1G6nJW
   OmG3IQC9BUTkq7EkJD4GpI7aO8jJic+r7x+4psqy7L2LMsKG5g3eTTAuc
   xpm7A2iFlT4vau+JbyYOGnvZSDk1cQg+CCe+9Y09a1sKagpdYVv+l2gS+
   ONd2YgMzcfEXvIevH2pgpU/J5NwFqqzPZcb7ccRbIHCVbEg9VkmsO5sbw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="10270491"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="10270491"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 06:38:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="923234307"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="923234307"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jan 2024 06:38:45 -0800
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
Subject: [PATCH v10 07/10] iommu/vt-d: Allow qi_submit_sync() to return the QI faults
Date: Tue,  2 Jan 2024 06:38:31 -0800
Message-Id: <20240102143834.146165-8-yi.l.liu@intel.com>
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

This allows qi_submit_sync() to return back faults to callers.

qi_submit_sync() has a retry when timeout error happens, thus it cannot
return timeout error back to the caller. This was discussed in a separate
thread [1]. Here we keep it intact and just make sure no retry for the
newly added user domain cache invalidation by checking if the caller is
interested in the fault or not.

[1] https://lore.kernel.org/all/20231228001646.587653-6-haifeng.zhao@linux.intel.com/

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/dmar.c          | 35 +++++++++++++++++++----------
 drivers/iommu/intel/iommu.h         |  2 +-
 drivers/iommu/intel/irq_remapping.c |  2 +-
 drivers/iommu/intel/pasid.c         |  2 +-
 drivers/iommu/intel/svm.c           |  6 ++---
 5 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 23cb80d62a9a..c3251c36c567 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1267,7 +1267,8 @@ static void qi_dump_fault(struct intel_iommu *iommu, u32 fault)
 	       (unsigned long long)desc->qw1);
 }
 
-static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
+static int qi_check_fault(struct intel_iommu *iommu, int index,
+			  int wait_index, u32 *fsts)
 {
 	u32 fault;
 	int head, tail;
@@ -1278,8 +1279,12 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 		return -EAGAIN;
 
 	fault = readl(iommu->reg + DMAR_FSTS_REG);
-	if (fault & (DMA_FSTS_IQE | DMA_FSTS_ITE | DMA_FSTS_ICE))
+	fault &= DMA_FSTS_IQE | DMA_FSTS_ITE | DMA_FSTS_ICE;
+	if (fault) {
+		if (fsts)
+			*fsts |= fault;
 		qi_dump_fault(iommu, fault);
+	}
 
 	/*
 	 * If IQE happens, the head points to the descriptor associated
@@ -1324,8 +1329,9 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
 		} while (head != tail);
 
+		/* No need to retry if the caller is interested in the timeout error */
 		if (qi->desc_status[wait_index] == QI_ABORT)
-			return -EAGAIN;
+			return fsts ? -ETIMEDOUT : -EAGAIN;
 	}
 
 	if (fault & DMA_FSTS_ICE) {
@@ -1342,9 +1348,11 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
  * time, a wait descriptor will be appended to each submission to ensure
  * hardware has completed the invalidation before return. Wait descriptors
  * can be part of the submission but it will not be polled for completion.
+ * If callers are interested in the QI faults that occur during the handling
+ * of requests, the QI faults are saved in @fault.
  */
 int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
-		   unsigned int count, unsigned long options)
+		   unsigned int count, unsigned long options, u32 *fault)
 {
 	struct q_inval *qi = iommu->qi;
 	s64 devtlb_start_ktime = 0;
@@ -1422,6 +1430,9 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 	 */
 	writel(qi->free_head << shift, iommu->reg + DMAR_IQT_REG);
 
+	if (fault)
+		*fault = 0;
+
 	while (qi->desc_status[wait_index] != QI_DONE) {
 		/*
 		 * We will leave the interrupts disabled, to prevent interrupt
@@ -1430,7 +1441,7 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 		 * a deadlock where the interrupt context can wait indefinitely
 		 * for free slots in the queue.
 		 */
-		rc = qi_check_fault(iommu, index, wait_index);
+		rc = qi_check_fault(iommu, index, wait_index, fault);
 		if (rc)
 			break;
 
@@ -1476,7 +1487,7 @@ void qi_global_iec(struct intel_iommu *iommu)
 	desc.qw3 = 0;
 
 	/* should never fail */
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, NULL);
 }
 
 void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid, u8 fm,
@@ -1490,7 +1501,7 @@ void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid, u8 fm,
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, NULL);
 }
 
 void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
@@ -1514,7 +1525,7 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, NULL);
 }
 
 void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
@@ -1545,7 +1556,7 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, NULL);
 }
 
 /* PASID-based IOTLB invalidation */
@@ -1586,7 +1597,7 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
 				QI_EIOTLB_AM(mask);
 	}
 
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, NULL);
 }
 
 /* PASID-based device IOTLB Invalidate */
@@ -1639,7 +1650,7 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 		desc.qw1 |= QI_DEV_EIOTLB_SIZE;
 	}
 
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, NULL);
 }
 
 void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did,
@@ -1649,7 +1660,7 @@ void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did,
 
 	desc.qw0 = QI_PC_PASID(pasid) | QI_PC_DID(did) |
 			QI_PC_GRAN(granu) | QI_PC_TYPE;
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, NULL);
 }
 
 /*
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index ce030c5b5772..c6de958e4f54 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -881,7 +881,7 @@ void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu,
 			  u32 pasid);
 
 int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
-		   unsigned int count, unsigned long options);
+		   unsigned int count, unsigned long options, u32 *fault);
 /*
  * Options used in qi_submit_sync:
  * QI_OPT_WAIT_DRAIN - Wait for PRQ drain completion, spec 6.5.2.8.
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 29b9e55dcf26..f834afa3672d 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -153,7 +153,7 @@ static int qi_flush_iec(struct intel_iommu *iommu, int index, int mask)
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	return qi_submit_sync(iommu, &desc, 1, 0);
+	return qi_submit_sync(iommu, &desc, 1, 0, NULL);
 }
 
 static int modify_irte(struct irq_2_iommu *irq_iommu,
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 74e8e4c17e81..67f924760ba8 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -467,7 +467,7 @@ pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, NULL);
 }
 
 static void
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index ac12f76c1212..660d049ad5b6 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -543,7 +543,7 @@ void intel_drain_pasid_prq(struct device *dev, u32 pasid)
 			QI_DEV_IOTLB_PFSID(info->pfsid);
 qi_retry:
 	reinit_completion(&iommu->prq_complete);
-	qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN);
+	qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN, NULL);
 	if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO) {
 		wait_for_completion(&iommu->prq_complete);
 		goto qi_retry;
@@ -646,7 +646,7 @@ static void handle_bad_prq_event(struct intel_iommu *iommu,
 		desc.qw3 = 0;
 	}
 
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, NULL);
 }
 
 static irqreturn_t prq_event_thread(int irq, void *d)
@@ -811,7 +811,7 @@ int intel_svm_page_response(struct device *dev,
 				ktime_to_ns(ktime_get()) - prm->private_data[0]);
 		}
 
-		qi_submit_sync(iommu, &desc, 1, 0);
+		qi_submit_sync(iommu, &desc, 1, 0, NULL);
 	}
 out:
 	return ret;
-- 
2.34.1


