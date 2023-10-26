Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D7B7D7BC6
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 06:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjJZEn3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 00:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343812AbjJZEm7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 00:42:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9774B1B6;
        Wed, 25 Oct 2023 21:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698295376; x=1729831376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eEUcP5KcutX2o5j+Ufm6y0KGFrXJgHvpAP1Vmptmk8I=;
  b=b4xzFrz4UvpxXND4UP32DT7Nj1Jt57BY7JlQnuxVm8B418QsJAxxtIwU
   CMurICzLsr/U39grCbRYzh2KXYUatMZOfVhxebMxzvUdt01NWciAdxpEV
   7kOt9dfE5+zG5+GCOLO7kRB/89UAGjlOUieMQiqUpQM6lskWRqrFRzPQw
   AKuUuU7MPqnT27TXvNUY8XIFrxfSL0sRqXYFyI/2AmZIJMYnaCU0lShf4
   jPODkqTlpAnP2SkAvaAwyBP44C1FcZGkyBP81FOrkrBPB88s5Pjmz5+bl
   kgXGKv2LzbERxdsyIlWSQu8teYa4QVBiAYqwPznk+ElbR+TS8VUo6bJIl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="367670776"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="367670776"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 21:42:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="829478580"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="829478580"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 25 Oct 2023 21:42:26 -0700
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
Subject: [PATCH v8 6/8] iommu/vt-d: Set the nested domain to a device
Date:   Wed, 25 Oct 2023 21:42:14 -0700
Message-Id: <20231026044216.64964-7-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026044216.64964-1-yi.l.liu@intel.com>
References: <20231026044216.64964-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/intel/nested.c | 54 ++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 56bb205fca06..b560ab76e126 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -12,8 +12,61 @@
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
+	/*
+	 * Stage-1 domain cannot work alone, it is nested on a s2_domain.
+	 * The s2_domain will be used in nested translation, hence needs
+	 * to ensure the s2_domain is compatible with this IOMMU.
+	 */
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
@@ -21,6 +74,7 @@ static void intel_nested_domain_free(struct iommu_domain *domain)
 }
 
 static const struct iommu_domain_ops intel_nested_domain_ops = {
+	.attach_dev		= intel_nested_attach_dev,
 	.free			= intel_nested_domain_free,
 };
 
-- 
2.34.1

