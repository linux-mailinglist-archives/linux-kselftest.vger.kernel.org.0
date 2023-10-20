Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124277D0BD7
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 11:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376745AbjJTJdG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 05:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376720AbjJTJdD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 05:33:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39701D60;
        Fri, 20 Oct 2023 02:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697794376; x=1729330376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L8v6hkJ+JIrDo8fqWs8a0xtoOtnuvQ0CSEXJ3O4E29A=;
  b=CAnUi3VcB1BoyEt1OGnhJqYbQvUSHLjNQbzZF/OYoR6IvbKDDPdw9HFM
   5e6J69zmgPVYOejCzAIgD1LH+IKsdfTh9lUPsLlP7ZX15KmqDlOuobnFj
   49nVmCbsOQx9+TdfZkda1Sn8g/JcSDNg2vSHcoNSl7YTo3zGEt5LA+w12
   /8b5HNvIz8g5dc0HmYmBNNinCom9/Z7I7xYWx+yHFEdmH8d/MDjrOLd7x
   UZP/wik1R3W6y+GvcKh8EN3GIjFxdyLslxBCRw7tICcUfRQIASibimS2G
   1s8S5aQ0iwEXCDqXNyRWSGcV+ynoC0hhMoGXFwwxKLOAWTtgXZYKzQ+Cc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="450691749"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="450691749"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:32:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="733906311"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="733906311"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2023 02:32:55 -0700
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
        xin.zeng@intel.com
Subject: [PATCH v6 7/8] iommu/vt-d: Add nested domain allocation
Date:   Fri, 20 Oct 2023 02:32:45 -0700
Message-Id: <20231020093246.17015-8-yi.l.liu@intel.com>
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

This adds the support for IOMMU_HWPT_DATA_VTD_S1 type.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 39 ++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b47025fbdea4..c7704e7efd4a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4076,7 +4076,7 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 			      struct iommu_domain *parent,
 			      const struct iommu_user_data *user_data)
 {
-	struct iommu_domain *domain;
+	bool request_nest_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
 	struct intel_iommu *iommu;
 
 	if (flags & (~IOMMU_HWPT_ALLOC_NEST_PARENT))
@@ -4086,18 +4086,35 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 	if (!iommu)
 		return ERR_PTR(-ENODEV);
 
-	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !ecap_nest(iommu->ecap))
+	if (!user_data) { /* Must be PAGING domain */
+		struct iommu_domain *domain;
+
+		if (request_nest_parent && !ecap_nest(iommu->ecap))
+			return ERR_PTR(-EOPNOTSUPP);
+		if (parent)
+			return ERR_PTR(-EINVAL);
+		/*
+		 * domain_alloc_user op needs to fully initialize a domain
+		 * before return, so uses iommu_domain_alloc() here for
+		 * simple.
+		 */
+		domain = iommu_domain_alloc(dev->bus);
+		if (!domain)
+			return ERR_PTR(-ENOMEM);
+		return domain;
+	}
+
+	/* Must be nested domain */
+	if (!ecap_nest(iommu->ecap))
+		return ERR_PTR(-EOPNOTSUPP);
+	if (user_data->type != IOMMU_HWPT_DATA_VTD_S1)
 		return ERR_PTR(-EOPNOTSUPP);
+	if (!parent || parent->ops != intel_iommu_ops.default_domain_ops)
+		return ERR_PTR(-EINVAL);
+	if (request_nest_parent)
+		return ERR_PTR(-EINVAL);
 
-	/*
-	 * domain_alloc_user op needs to fully initialize a domain
-	 * before return, so uses iommu_domain_alloc() here for
-	 * simple.
-	 */
-	domain = iommu_domain_alloc(dev->bus);
-	if (!domain)
-		domain = ERR_PTR(-ENOMEM);
-	return domain;
+	return intel_nested_domain_alloc(parent, user_data);
 }
 
 static void intel_iommu_domain_free(struct iommu_domain *domain)
-- 
2.34.1

