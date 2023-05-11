Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7A06FF508
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 16:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238504AbjEKOwq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 10:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238680AbjEKOwY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 10:52:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC71011545;
        Thu, 11 May 2023 07:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683816694; x=1715352694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5lTJZJlhkGtsEK0N97DhHxz42DKV4pxspayKRRGeGUo=;
  b=RiIPF6/w+fWuGl9zkt6dSyRmnFosezYdmv8mR1fjvyjjXtOqrnhiiDCi
   IyT1jxT5EcdySiCyvsKx3JbBAaTpQsdF6EoM6OTIPcyKQQy6ekLmqKnaO
   Dw/ldOv3yzYFeoouzK/YIBUco1tOnJRnD99NBunDpqIRIpVdSLfa0Hghq
   luA82wqgR7WTdRAGbHrZbadHJiKoYfzCeOx6lZqBLgJLmt/SliSaHGrre
   X4VwwF0G7xq5Zyg3joSIKCrUUazH+7k2Bun6ZFsZLF9WrsKmCHbdXs8W6
   KhxRL64soLaqIPmAijJmPhDENIjRmumsL6foSZ/Lkgj84pXyPZAkrmLME
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="335025452"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="335025452"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 07:51:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="769355162"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="769355162"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2023 07:51:16 -0700
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
        zhenzhong.duan@intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 03/10] iommu/vt-d: Add helper for nested domain allocation
Date:   Thu, 11 May 2023 07:51:03 -0700
Message-Id: <20230511145110.27707-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511145110.27707-1-yi.l.liu@intel.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

This adds helper for accepting user parameters and allocate a nested
domain.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/Makefile |  2 +-
 drivers/iommu/intel/iommu.h  |  2 ++
 drivers/iommu/intel/nested.c | 47 ++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 1 deletion(-)
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
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index e818520f4068..8d0c7970c1ad 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -858,6 +858,8 @@ void *alloc_pgtable_page(int node, gfp_t gfp);
 void free_pgtable_page(void *vaddr);
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
 struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
+struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *s2_domain,
+					       const union iommu_domain_user_data *user_data);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
new file mode 100644
index 000000000000..f83931bb44b6
--- /dev/null
+++ b/drivers/iommu/intel/nested.c
@@ -0,0 +1,47 @@
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
+
+#include "iommu.h"
+
+static void intel_nested_domain_free(struct iommu_domain *domain)
+{
+	kfree(to_dmar_domain(domain));
+}
+
+static const struct iommu_domain_ops intel_nested_domain_ops = {
+	.free			= intel_nested_domain_free,
+};
+
+struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *s2_domain,
+					       const union iommu_domain_user_data *user_data)
+{
+	const struct iommu_hwpt_intel_vtd *vtd = (struct iommu_hwpt_intel_vtd *)user_data;
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

