Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4157A9760
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 19:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjIURXU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 13:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjIURW5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 13:22:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EC6901D;
        Thu, 21 Sep 2023 10:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695316263; x=1726852263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TKXjR4j9x1jDQI3p6zjb5Rlhbhk6itQVPUNBhJA2+j8=;
  b=AI+OKJaLLtZOh1MPuG5RMXEbkuHPxHAWEfEkA/prH+x3l50Li+BAHC0E
   SdNpIjGZHNARKA2a46WKf5j46QnAovK5WF9IgYXl9TdeTaBgBxx14bhAU
   6hTR1rtoqEc2tc5QxHZV9MyjRnkPxRYpC2pwkyWVD/YBhpla3E7Yn+iK3
   AGOFamuF6KJ/QRlbmWtiqyGOwAjzqb9MJkVIsXnnJjf06M/OUM9K2wW8u
   7jBKtH1YxgGM/AARNh0Ku2jPAXOSwTl6vfIXLhIBmTrKZHV2u5Ffn160S
   7zFO6D7HBGV+q6HWK/FR6D6A4bpVLm9r1kHq+VRqoo7SbDdnw2izW44m6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="370764439"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="370764439"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:54:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="812523157"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="812523157"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga008.fm.intel.com with ESMTP; 21 Sep 2023 00:54:49 -0700
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
Subject: [PATCH v5 06/11] iommu/vt-d: Set the nested domain to a device
Date:   Thu, 21 Sep 2023 00:54:26 -0700
Message-Id: <20230921075431.125239-7-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921075431.125239-1-yi.l.liu@intel.com>
References: <20230921075431.125239-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds the helper for setting the nested domain to a device hence
enable nested domain usage on Intel VT-d.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/nested.c | 50 ++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 012d5ff60265..f9c6ade72416 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -11,8 +11,57 @@
 #define pr_fmt(fmt)	"DMAR: " fmt
 
 #include <linux/iommu.h>
+#include <linux/pci.h>
+#include <linux/pci-ats.h>
 
 #include "iommu.h"
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
+	if (iommu->agaw < dmar_domain->s2_domain->agaw) {
+		dev_err_ratelimited(dev, "Adjusted guest address width not compatible\n");
+		return -ENODEV;
+	}
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
+				       IOMMU_NO_PASID, dmar_domain);
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
+
+	return 0;
+}
 
 static void intel_nested_domain_free(struct iommu_domain *domain)
 {
@@ -20,6 +69,7 @@ static void intel_nested_domain_free(struct iommu_domain *domain)
 }
 
 static const struct iommu_domain_ops intel_nested_domain_ops = {
+	.attach_dev		= intel_nested_attach_dev,
 	.free			= intel_nested_domain_free,
 };
 
-- 
2.34.1

