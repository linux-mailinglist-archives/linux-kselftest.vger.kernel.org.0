Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B77F68FF37
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 05:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjBIEeL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 23:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjBIEdo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 23:33:44 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2447F4A223;
        Wed,  8 Feb 2023 20:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675917154; x=1707453154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JZyEs44evN9cOVrCDDCu8xHdNGuyqbdYBUmmOSo2DX8=;
  b=Pq0DPRWFhI79mxKHorqpuCR7v9nemf1ob+GrT5oB9iit6Du7D2Cp9urz
   /EtBBiZNTnwfzOlax5sNnCY41UrElyOORFIdc47zkL2bygwDiEjwA4TGG
   u5oZVz5tK0+8lAorF/qOb7kodjfRWyncdltR1vgguU3K2I+WOCg3z3tDn
   6/l7weT9ZUyb3+X3OPQ4bTp6iHS0uDdzKxJj5vanL3XA64cdhUtz7EFKh
   +O25QZO3KSjGa5FHn0BzJ1wbfmosR51vqMuMrmHu+Zaq0EH8uXSZZgELG
   uMfcO8x21azQfJoj9CHmKSmDPzE45gsJ5aHHHQBkrfNNCMmNpsP1+zwfU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331298677"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="331298677"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:32:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669447505"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="669447505"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2023 20:32:06 -0800
From:   Yi Liu <yi.l.liu@intel.com>
To:     joro@8bytes.org, alex.williamson@redhat.com, jgg@nvidia.com,
        kevin.tian@intel.com, robin.murphy@arm.com
Cc:     cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        baolu.lu@linux.intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 05/17] iommu/vt-d: Add nested domain support
Date:   Wed,  8 Feb 2023 20:31:41 -0800
Message-Id: <20230209043153.14964-6-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209043153.14964-1-yi.l.liu@intel.com>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

This adds nested domain support in the Intel IOMMU driver. It allows to
allocate and free a nested domain, set the nested domain to a device,
and synchronize the caches when the userspace managed page tables are
updated.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/Makefile |   2 +-
 drivers/iommu/intel/iommu.c  |  38 ++++++----
 drivers/iommu/intel/iommu.h  |  15 ++++
 drivers/iommu/intel/nested.c | 143 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/iommufd.h |  54 +++++++++++++
 5 files changed, 236 insertions(+), 16 deletions(-)
 create mode 100644 drivers/iommu/intel/nested.c

diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index fa0dae16441c..8b324db03692 100644
--- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
-obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o
+obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o nested.o
 obj-$(CONFIG_DMAR_TABLE) += trace.o cap_audit.o
 obj-$(CONFIG_DMAR_PERF) += perf.o
 obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 929f600cc350..ea42d169afa2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -277,7 +277,6 @@ static LIST_HEAD(dmar_satc_units);
 #define for_each_rmrr_units(rmrr) \
 	list_for_each_entry(rmrr, &dmar_rmrr_units, list)
 
-static void device_block_translation(struct device *dev);
 static void intel_iommu_domain_free(struct iommu_domain *domain);
 
 int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
@@ -555,7 +554,7 @@ static unsigned long domain_super_pgsize_bitmap(struct dmar_domain *domain)
 }
 
 /* Some capabilities may be different across iommus */
-static void domain_update_iommu_cap(struct dmar_domain *domain)
+void domain_update_iommu_cap(struct dmar_domain *domain)
 {
 	domain_update_iommu_coherency(domain);
 	domain->iommu_superpage = domain_update_iommu_superpage(domain, NULL);
@@ -1497,10 +1496,10 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
-static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
-				  struct dmar_domain *domain,
-				  unsigned long pfn, unsigned int pages,
-				  int ih, int map)
+void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
+			   struct dmar_domain *domain,
+			   unsigned long pfn, unsigned int pages,
+			   int ih, int map)
 {
 	unsigned int aligned_pages = __roundup_pow_of_two(pages);
 	unsigned int mask = ilog2(aligned_pages);
@@ -1572,7 +1571,7 @@ static inline void __mapping_notify_one(struct intel_iommu *iommu,
 		iommu_flush_write_buffer(iommu);
 }
 
-static void intel_flush_iotlb_all(struct iommu_domain *domain)
+void intel_flush_iotlb_all(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct iommu_domain_info *info;
@@ -1764,8 +1763,7 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 	return domain;
 }
 
-static int domain_attach_iommu(struct dmar_domain *domain,
-			       struct intel_iommu *iommu)
+int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 {
 	struct iommu_domain_info *info, *curr;
 	unsigned long ndomains;
@@ -1814,8 +1812,7 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 	return ret;
 }
 
-static void domain_detach_iommu(struct dmar_domain *domain,
-				struct intel_iommu *iommu)
+void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 {
 	struct iommu_domain_info *info;
 
@@ -4096,7 +4093,7 @@ static void dmar_remove_one_dev_info(struct device *dev)
  * all DMA requests without PASID from the device are blocked. If the page
  * table has been set, clean up the data structures.
  */
-static void device_block_translation(struct device *dev)
+void device_block_translation(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
@@ -4197,14 +4194,24 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 	return NULL;
 }
 
+static struct iommu_domain *
+intel_iommu_domain_alloc_user(struct device *dev, struct iommu_domain *parent,
+			      const void *user_data)
+{
+	if (parent)
+		return intel_nested_domain_alloc(parent, user_data);
+	else
+		return iommu_domain_alloc(dev->bus);
+}
+
 static void intel_iommu_domain_free(struct iommu_domain *domain)
 {
 	if (domain != &si_domain->domain && domain != &blocking_domain)
 		domain_exit(to_dmar_domain(domain));
 }
 
-static int prepare_domain_attach_device(struct iommu_domain *domain,
-					struct device *dev)
+int prepare_domain_attach_device(struct iommu_domain *domain,
+				 struct device *dev)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct intel_iommu *iommu;
@@ -4436,7 +4443,7 @@ static void domain_set_force_snooping(struct dmar_domain *domain)
 						     PASID_RID2PASID);
 }
 
-static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
+bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	unsigned long flags;
@@ -4781,6 +4788,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.hw_info		= intel_iommu_hw_info,
 	.domain_alloc		= intel_iommu_domain_alloc,
+	.domain_alloc_user	= intel_iommu_domain_alloc_user,
 	.probe_device		= intel_iommu_probe_device,
 	.probe_finalize		= intel_iommu_probe_finalize,
 	.release_device		= intel_iommu_release_device,
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 4fe74f217696..25d1c99fce40 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -753,6 +753,19 @@ void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu,
 
 int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 		   unsigned int count, unsigned long options);
+int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
+void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
+void device_block_translation(struct device *dev);
+int prepare_domain_attach_device(struct iommu_domain *domain,
+				 struct device *dev);
+bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain);
+void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
+			   struct dmar_domain *domain,
+			   unsigned long pfn, unsigned int pages,
+			   int ih, int map);
+void intel_flush_iotlb_all(struct iommu_domain *domain);
+void domain_update_iommu_cap(struct dmar_domain *domain);
+
 /*
  * Options used in qi_submit_sync:
  * QI_OPT_WAIT_DRAIN - Wait for PRQ drain completion, spec 6.5.2.8.
@@ -765,6 +778,8 @@ void *alloc_pgtable_page(int node);
 void free_pgtable_page(void *vaddr);
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
 struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
+struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *s2_domain,
+					       const void *data);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 extern void intel_svm_check(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
new file mode 100644
index 000000000000..7624a3dd4603
--- /dev/null
+++ b/drivers/iommu/intel/nested.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * nested.c - nested mode translation support
+ *
+ * Copyright (C) 2023 Intel Corporation
+ *
+ * Author: Lu Baolu <baolu.lu@linux.intel.com>
+ *         Jacob Pan <jacob.jun.pan@linux.intel.com>
+ */
+
+#define pr_fmt(fmt)	"DMAR: " fmt
+
+#include <linux/iommu.h>
+#include <linux/pci.h>
+#include <linux/pci-ats.h>
+
+#include "iommu.h"
+#include "pasid.h"
+
+static int intel_nested_attach_dev(struct iommu_domain *domain,
+				   struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct intel_iommu *iommu = info->iommu;
+	unsigned long flags;
+	int ret = 0;
+
+	if (info->domain)
+		device_block_translation(dev);
+
+	/* Is s2_domain compatible with this IOMMU? */
+	ret = prepare_domain_attach_device(&dmar_domain->s2_domain->domain, dev);
+	if (ret) {
+		dev_err_ratelimited(dev, "s2 domain is not compatible\n");
+		return ret;
+	}
+
+	ret = domain_attach_iommu(dmar_domain, iommu);
+	if (ret) {
+		dev_err_ratelimited(dev, "Failed to attach domain to iommu\n");
+		return ret;
+	}
+
+	ret = intel_pasid_setup_nested(iommu, dev,
+				       PASID_RID2PASID, dmar_domain);
+	if (ret) {
+		domain_detach_iommu(dmar_domain, iommu);
+		dev_err_ratelimited(dev, "Failed to setup pasid entry\n");
+		return ret;
+	}
+
+	info->domain = dmar_domain;
+	spin_lock_irqsave(&dmar_domain->lock, flags);
+	list_add(&info->link, &dmar_domain->devices);
+	spin_unlock_irqrestore(&dmar_domain->lock, flags);
+	domain_update_iommu_cap(dmar_domain);
+
+	return 0;
+}
+
+static void intel_nested_domain_free(struct iommu_domain *domain)
+{
+	kfree(to_dmar_domain(domain));
+}
+
+static void intel_nested_invalidate(struct device *dev,
+				    struct dmar_domain *domain,
+				    void *user_data)
+{
+	struct iommu_hwpt_invalidate_intel_vtd *inv_info = user_data;
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+
+	if (WARN_ON(!user_data))
+		return;
+
+	switch (inv_info->granularity) {
+	case IOMMU_VTD_QI_GRAN_ADDR:
+		if (inv_info->granule_size != VTD_PAGE_SIZE ||
+		    !IS_ALIGNED(inv_info->addr, VTD_PAGE_SIZE)) {
+			dev_err_ratelimited(dev, "Invalid invalidation address 0x%llx\n",
+					    inv_info->addr);
+			return;
+		}
+
+		iommu_flush_iotlb_psi(iommu, domain,
+				      inv_info->addr >> VTD_PAGE_SHIFT,
+				      inv_info->nb_granules, 1, 0);
+		break;
+	case IOMMU_VTD_QI_GRAN_DOMAIN:
+		intel_flush_iotlb_all(&domain->domain);
+		break;
+	default:
+		dev_err_ratelimited(dev, "Unsupported IOMMU invalidation type %d\n",
+				    inv_info->granularity);
+		break;
+	}
+}
+
+static void intel_nested_iotlb_sync_user(struct iommu_domain *domain,
+					 void *user_data)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct device_domain_info *info;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dmar_domain->lock, flags);
+	list_for_each_entry(info, &dmar_domain->devices, link)
+		intel_nested_invalidate(info->dev, dmar_domain,
+					user_data);
+	spin_unlock_irqrestore(&dmar_domain->lock, flags);
+}
+
+static const struct iommu_domain_ops intel_nested_domain_ops = {
+	.attach_dev		= intel_nested_attach_dev,
+	.iotlb_sync_user	= intel_nested_iotlb_sync_user,
+	.free			= intel_nested_domain_free,
+	.enforce_cache_coherency = intel_iommu_enforce_cache_coherency,
+};
+
+struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *s2_domain,
+					       const void *user_data)
+{
+	const struct iommu_hwpt_intel_vtd *vtd = user_data;
+	struct dmar_domain *domain;
+
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL_ACCOUNT);
+	if (!domain)
+		return NULL;
+
+	domain->use_first_level = true;
+	domain->s2_domain = to_dmar_domain(s2_domain);
+	domain->s1_pgtbl = vtd->pgtbl_addr;
+	domain->s1_cfg = *vtd;
+	domain->domain.ops = &intel_nested_domain_ops;
+	domain->domain.type = IOMMU_DOMAIN_NESTED;
+	INIT_LIST_HEAD(&domain->devices);
+	spin_lock_init(&domain->lock);
+	xa_init(&domain->iommu_array);
+
+	return &domain->domain;
+}
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 0867900494c9..bbffb63d2513 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -460,4 +460,58 @@ struct iommu_hwpt_intel_vtd {
 	__u32 addr_width;
 	__u32 __reserved;
 };
+
+/**
+ * enum iommu_vtd_qi_granularity - Intel VT-d specific granularity of
+ *				   queued invalidation
+ * @IOMMU_VTD_QI_GRAN_DOMAIN: domain-selective invalidation
+ * @IOMMU_VTD_QI_GRAN_ADDR: page-selective invalidation
+ */
+enum iommu_vtd_qi_granularity {
+	IOMMU_VTD_QI_GRAN_DOMAIN,
+	IOMMU_VTD_QI_GRAN_ADDR,
+};
+
+/**
+ * enum iommu_hwpt_intel_vtd_invalidate_flags - Flags for Intel VT-d
+ *						stage-1 page table cache
+ *						invalidation
+ * @IOMMU_VTD_QI_FLAGS_LEAF: The LEAF flag indicates whether only the
+ *			     leaf PTE caching needs to be invalidated
+ *			     and other paging structure caches can be
+ *			     preserved.
+ */
+enum iommu_hwpt_intel_vtd_invalidate_flags {
+	IOMMU_VTD_QI_FLAGS_LEAF = 1 << 0,
+};
+
+/**
+ * struct iommu_hwpt_invalidate_intel_vtd - Intel VT-d cache invalidation info
+ * @granularity: One of enum iommu_vtd_qi_granularity.
+ * @flags: Combination of enum iommu_hwpt_intel_vtd_invalidate_flags
+ * @__reserved: Must be 0
+ * @addr: The start address of the addresses to be invalidated.
+ * @granule_size: Page/block size of the mapping in bytes. It is used to
+ *		  compute the invalidation range togehter with @nb_granules.
+ * @nb_granules: Number of contiguous granules to be invalidated.
+ *
+ * The Intel VT-d specific invalidation data for user-managed stage-1 cache
+ * invalidation under nested translation. Userspace uses this structure to
+ * tell host about the impacted caches after modifying the stage-1 page table.
+ *
+ * @addr, @granule_size and @nb_granules are meaningful when
+ * @granularity==IOMMU_VTD_QI_GRAN_ADDR. Intel VT-d currently only supports
+ * 4kB page size, so @granule_size should be 4KB. @addr should be aligned
+ * with @granule_size * @nb_granules, otherwise invalidation won't take
+ * effect.
+ */
+struct iommu_hwpt_invalidate_intel_vtd {
+	__u8 granularity;
+	__u8 padding[7];
+	__u32 flags;
+	__u32 __reserved;
+	__u64 addr;
+	__u64 granule_size;
+	__u64 nb_granules;
+};
 #endif
-- 
2.34.1

