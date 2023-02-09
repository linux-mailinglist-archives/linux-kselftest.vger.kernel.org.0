Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4945668FF48
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 05:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjBIEe7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 23:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjBIEdt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 23:33:49 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53820457F1;
        Wed,  8 Feb 2023 20:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675917160; x=1707453160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RfT4R/xTBwZsk8AEoHLAHBvK4hYBuXf+5pIwXQ6TqQw=;
  b=nT9GYdMVpkOL5y2Y74N2jEJ8RvrkFcJM1Y2qgEtjSH4Z0dHdbpJOjceE
   uBCHDNZp7kWrkCJevRc/hwELompD/r2oaWKpsYc4wIYRHciLZfsUu5TVV
   U555ilUofG6ccxY/WnU9wM010fTrbKH1+R03S/QPEdriThmjK3lAsX5T7
   h3Rae6Dix1aMQG3IKgcDAPE+P+PYhUcReREmZcIfbdQRrqicSUCJKPLiY
   3owLTeviEMmljGKwM6XHb3j99YHeOVgE5zYic3gL8fXTnuG8z78t2K9Sd
   KSMnNSafmVVc8j4eMAbfR3uv+PQkQHNSXExkUEhe/rxljzE+UOQqB5XSj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331298694"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="331298694"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:32:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669447517"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="669447517"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2023 20:32:08 -0800
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
        baolu.lu@linux.intel.com
Subject: [PATCH 06/17] iommufd/hw_pagetable: Use domain_alloc_user op for domain allocation
Date:   Wed,  8 Feb 2023 20:31:42 -0800
Message-Id: <20230209043153.14964-7-yi.l.liu@intel.com>
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

This converts iommufd to use iommu_domain_alloc_user() for iommu_domain
creation.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 43d473989a06..08d963ee38c7 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -30,6 +30,7 @@ struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			   struct device *dev)
 {
+	const struct iommu_ops *ops;
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
@@ -37,7 +38,13 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	if (IS_ERR(hwpt))
 		return hwpt;
 
-	hwpt->domain = iommu_domain_alloc(dev->bus);
+	ops = dev_iommu_ops(dev);
+	if (!ops || !ops->domain_alloc_user) {
+		rc = -EOPNOTSUPP;
+		goto out_abort;
+	}
+
+	hwpt->domain = ops->domain_alloc_user(dev, NULL, NULL);
 	if (!hwpt->domain) {
 		rc = -ENOMEM;
 		goto out_abort;
-- 
2.34.1

