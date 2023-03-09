Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAE86B1DF4
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 09:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjCIIZJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 03:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjCIIYU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 03:24:20 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BE214EAB;
        Thu,  9 Mar 2023 00:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678350183; x=1709886183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/mmYgR+89ByI+p2Zr/OCn4pE2TGeXtXXbNuoqCFUfCE=;
  b=YHz2A9Olouj6Zdn/uHh1CNiozWJ9aHR+/ysxavHGibpEqqpsScHkWezP
   GIJORlUs99UFYhP/NEsaMVozatW4Prabk5hjM6shGmvFYK7Soeem0tncn
   ssyL98RvKFIZekLqht1LkGx5fAazsBcWFrnMbTdtEeMp1DFjAzXgefv5F
   5f1uzdplw3golqEh4c6vPDE2T+tLhpFtVfX1KFyBKuxrw4qjBYQi/IdGL
   1g8sNLRfot61zplo8+vzuOLx/RNyENtqOi5nf+Y2BDcBKi0zkxQ3sUqN7
   EcKqCpxZK5yYFTZXQalwFlGmYDkLlOjjMeirMWiWmoxjFaGtCVYD7afgI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364026232"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364026232"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:22:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787474161"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787474161"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2023 00:22:14 -0800
From:   Yi Liu <yi.l.liu@intel.com>
To:     joro@8bytes.org, alex.williamson@redhat.com, jgg@nvidia.com,
        kevin.tian@intel.com, robin.murphy@arm.com,
        baolu.lu@linux.intel.com
Cc:     cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 5/5] iommu/vt-d: Add nested domain support
Date:   Thu,  9 Mar 2023 00:22:07 -0800
Message-Id: <20230309082207.612346-6-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309082207.612346-1-yi.l.liu@intel.com>
References: <20230309082207.612346-1-yi.l.liu@intel.com>
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
 4 files changed, 182 insertions(+), 16 deletions(-)
 create mode 100644 drivers/iommu/intel/nested.c

diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index 7af3b8a4f2a0..5dabf081a779 100644
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
index 004406209793..89cc7095afed 100644
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
@@ -1498,10 +1497,10 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
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
@@ -1573,7 +1572,7 @@ static inline void __mapping_notify_one(struct intel_iommu *iommu,
 		iommu_flush_write_buffer(iommu);
 }
 
-static void intel_flush_iotlb_all(struct iommu_domain *domain)
+void intel_flush_iotlb_all(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct iommu_domain_info *info;
@@ -1765,8 +1764,7 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 	return domain;
 }
 
-static int domain_attach_iommu(struct dmar_domain *domain,
-			       struct intel_iommu *iommu)
+int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 {
 	struct iommu_domain_info *info, *curr;
 	unsigned long ndomains;
@@ -1815,8 +1813,7 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 	return ret;
 }
 
-static void domain_detach_iommu(struct dmar_domain *domain,
-				struct intel_iommu *iommu)
+void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 {
 	struct iommu_domain_info *info;
 
@@ -4103,7 +4100,7 @@ static void dmar_remove_one_dev_info(struct device *dev)
  * all DMA requests without PASID from the device are blocked. If the page
  * table has been set, clean up the data structures.
  */
-static void device_block_translation(struct device *dev)
+void device_block_translation(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
@@ -4204,14 +4201,24 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
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
@@ -4450,7 +4457,7 @@ static void domain_set_force_snooping(struct dmar_domain *domain)
 						     PASID_RID2PASID);
 }
 
-static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
+bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	unsigned long flags;
@@ -4801,6 +4808,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.hw_info		= intel_iommu_hw_info,
 	.domain_alloc		= intel_iommu_domain_alloc,
+	.domain_alloc_user	= intel_iommu_domain_alloc_user,
 	.probe_device		= intel_iommu_probe_device,
 	.probe_finalize		= intel_iommu_probe_finalize,
 	.release_device		= intel_iommu_release_device,
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 9446e17dd202..661fb5050e2d 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -848,6 +848,19 @@ void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu,
 
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
@@ -860,6 +873,8 @@ void *alloc_pgtable_page(int node, gfp_t gfp);
 void free_pgtable_page(void *vaddr);
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
 struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
+struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *s2_domain,
+					       const void *data);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 extern void intel_svm_check(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
new file mode 100644
index 000000000000..64441d11a84d
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
+static void intel_nested_cache_invalidate_user(struct iommu_domain *domain,
+					       void *user_data)
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
+	.cache_invalidate_user	= intel_nested_cache_invalidate_user,
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
-- 
2.34.1

