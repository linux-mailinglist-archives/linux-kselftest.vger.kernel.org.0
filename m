Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF6D7D0BD8
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 11:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376715AbjJTJdA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 05:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376649AbjJTJcy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 05:32:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2109AE8;
        Fri, 20 Oct 2023 02:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697794373; x=1729330373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UhxPLZHsNBaJpuPmPuZrs6VDspZflofqLeRUV4csYhM=;
  b=KKJ35bEH4NiF3L+pJuxuilZoyuXpcQ+4IX5QMG87sCHZR0lWwkG/QxCH
   eFN0rMph4t8HZPlzvqp0/7VHnTMXI/ws5B597phEyMGM93ODh8Gjgr6eO
   hUmmDSRNkm330aylFL8h3fXiKe5n/Z41uMXZEZQioCTsMlzpnXrNXHA+Y
   nsY+1Vgvf6GfBc4DotXXb+VU0ioiNoeZAuS+/kf4C0jRWTkhQIpsBuyQc
   Uud4oFS0bcpVKUPkDPBAXk+D8PCxcjXrwLoUoK76XwltbbkjOgXdlZ4NI
   pT7z5TQSnT/9fxWkNURHXtemusqVul5fCdbyEI/IcvGm5AA2+pUZSk6DA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="450691703"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="450691703"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:32:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="733906298"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="733906298"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2023 02:32:52 -0700
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
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
        xin.zeng@intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v6 3/8] iommu/vt-d: Add helper for nested domain allocation
Date:   Fri, 20 Oct 2023 02:32:41 -0700
Message-Id: <20231020093246.17015-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020093246.17015-1-yi.l.liu@intel.com>
References: <20231020093246.17015-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

This adds helper for accepting user parameters and allocate a nested
domain.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/Makefile |  2 +-
 drivers/iommu/intel/iommu.h  |  2 ++
 drivers/iommu/intel/nested.c | 55 ++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 1 deletion(-)
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
index a91077a063ee..ff55184456dd 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -866,6 +866,8 @@ void *alloc_pgtable_page(int node, gfp_t gfp);
 void free_pgtable_page(void *vaddr);
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
 struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
+struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *s2_domain,
+					       const struct iommu_user_data *user_data);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
new file mode 100644
index 000000000000..5a2920a98e47
--- /dev/null
+++ b/drivers/iommu/intel/nested.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * nested.c - nested mode translation support
+ *
+ * Copyright (C) 2023 Intel Corporation
+ *
+ * Author: Lu Baolu <baolu.lu@linux.intel.com>
+ *         Jacob Pan <jacob.jun.pan@linux.intel.com>
+ *         Yi Liu <yi.l.liu@intel.com>
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
+					       const struct iommu_user_data *user_data)
+{
+	struct iommu_hwpt_vtd_s1 vtd;
+	struct dmar_domain *domain;
+	int ret;
+
+	ret = iommu_copy_struct_from_user(&vtd, user_data,
+					  IOMMU_HWPT_DATA_VTD_S1, __reserved);
+	if (ret)
+		return ERR_PTR(ret);
+
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL_ACCOUNT);
+	if (!domain)
+		return NULL;
+
+	domain->use_first_level = true;
+	domain->s2_domain = to_dmar_domain(s2_domain);
+	domain->s1_pgtbl = vtd.pgtbl_addr;
+	domain->s1_cfg = vtd;
+	domain->domain.ops = &intel_nested_domain_ops;
+	domain->domain.type = IOMMU_DOMAIN_NESTED;
+	INIT_LIST_HEAD(&domain->devices);
+	INIT_LIST_HEAD(&domain->dev_pasids);
+	spin_lock_init(&domain->lock);
+	xa_init(&domain->iommu_array);
+
+	return &domain->domain;
+}
-- 
2.34.1

