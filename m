Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746877D568E
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 17:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343746AbjJXPez (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 11:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343730AbjJXPer (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 11:34:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74C01FD5;
        Tue, 24 Oct 2023 08:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698161148; x=1729697148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yc31Hj1XFcKLSYQzFgKTkbbG88zsmwpxwtOXR4n5QGQ=;
  b=LG3E6WeKKdR/ODTzkvmVYWD8z0cmG9QwjyAiLbR1hgecsQ5oJNckBt1g
   JcvleUG34DJvszhXIjnNlJ2/VrlsXB1gR8KV9oaT8vlZER1/radjJq5KG
   yNV77uyV/ZPpPZtlMLWaQcLT6VobCKBZur/h5bApBpdgV7QgM0AEvu0Zf
   TTvw/2z7f3wj1Xv6yxQbfyrglK5LmEMgqwRkqgR0+Nd9sEbg/nTpCZT6T
   jLlqiL8+VXCn9ggyypzj/5lmP2YwBLOnJV7eZlbPyJn5RgY48mrxHvAyu
   n5ox25ZxmhzW+E+4spoZTTf5Ghwkm9Baf8xcAvpvfUg319eX8Xu/1GzgN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="418212129"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="418212129"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:14:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="1005688908"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="1005688908"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga006.fm.intel.com with ESMTP; 24 Oct 2023 08:14:15 -0700
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
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v7 3/8] iommu/vt-d: Add helper for nested domain allocation
Date:   Tue, 24 Oct 2023 08:14:07 -0700
Message-Id: <20231024151412.50046-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024151412.50046-1-yi.l.liu@intel.com>
References: <20231024151412.50046-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 244f111ea0bb..43108424f315 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -884,6 +884,8 @@ void *alloc_pgtable_page(int node, gfp_t gfp);
 void free_pgtable_page(void *vaddr);
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
 struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
+struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *s2_domain,
+					       const struct iommu_user_data *user_data);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
new file mode 100644
index 000000000000..859c60bead05
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
+		return ERR_PTR(-ENOMEM);
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

