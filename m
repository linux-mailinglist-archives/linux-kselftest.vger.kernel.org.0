Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2067A9F2E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 22:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjIUUTL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 16:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjIUUSp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 16:18:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC7BAD3E;
        Thu, 21 Sep 2023 10:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695316281; x=1726852281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t9shzln1aiQ0VVrVLLLhztKgUvVIxQF/AjCqw0E9eAk=;
  b=deszTiL24loTM14oU0l0QMq5Qo6TsLOT5UeO89Ta0p4UuTqeCIexV9hB
   wBMlDOXzdtLqQuhy01dlS8dPlnzxRgBezn44bmU2YhyaCa2wnsThzqhUY
   GiTEdn7h7NfBWLEtmmVHxqLs7qfYyGS7+w4EHSxkDc06EbSa9/Sn10Lh7
   K9CwMGK6nkryfrxH7s1PN8ESd8Nc/v1o+lRdqWYES1N06n7RW5lHficIE
   nWdGlZB6DP2QIWjLZBLaszZ24OJJoufi7f9DVLPeK60xW31e3E76Sce0m
   zUPUgxqKfIozOU1Z6LD/j5UJQzp+7OMHkOkDOYYDJ38lUTMov3Yu0zBNo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="370764493"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="370764493"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:54:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="812523184"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="812523184"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga008.fm.intel.com with ESMTP; 21 Sep 2023 00:54:53 -0700
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
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: [PATCH v5 10/11] iommu/vt-d: Add nested domain allocation
Date:   Thu, 21 Sep 2023 00:54:30 -0700
Message-Id: <20230921075431.125239-11-yi.l.liu@intel.com>
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

From: Lu Baolu <baolu.lu@linux.intel.com>

This adds the support for IOMMU_HWPT_TYPE_VTD_S1 type.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c93c91ed4ee2..9b10e4b1d400 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4077,19 +4077,35 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 			      struct iommu_domain *parent,
 			      const struct iommu_user_data *user_data)
 {
+	bool request_nest_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
 	struct iommu_domain *domain;
 	struct intel_iommu *iommu;
 
+	if (hwpt_type != IOMMU_HWPT_TYPE_DEFAULT &&
+	    hwpt_type != IOMMU_HWPT_TYPE_VTD_S1)
+		return ERR_PTR(-EINVAL);
+
+	if ((hwpt_type == IOMMU_HWPT_TYPE_DEFAULT) == !!parent)
+		return ERR_PTR(-EINVAL);
+
+	if (parent && request_nest_parent)
+		return ERR_PTR(-EINVAL);
+
 	iommu = device_to_iommu(dev, NULL, NULL);
 	if (!iommu)
 		return ERR_PTR(-ENODEV);
 
-	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !ecap_nest(iommu->ecap))
+	if ((parent || request_nest_parent) && !ecap_nest(iommu->ecap))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	domain = iommu_domain_alloc(dev->bus);
-	if (!domain)
-		domain = ERR_PTR(-ENOMEM);
+	if (parent) {
+		domain = intel_nested_domain_alloc(parent, user_data);
+	} else {
+		domain = iommu_domain_alloc(dev->bus);
+		if (!domain)
+			domain = ERR_PTR(-ENOMEM);
+	}
+
 	return domain;
 }
 
-- 
2.34.1

