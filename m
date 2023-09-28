Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B517B146B
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 09:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjI1HPi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 03:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjI1HPe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 03:15:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53018CC1;
        Thu, 28 Sep 2023 00:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695885333; x=1727421333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2u453SswpKakc0NOsEhGqMN9HDyZwW3XZ2U2N48J7YQ=;
  b=bRsbCqsjStpeOY40igeSQZ4spXGTYYTWuUKvdeoYZs62TCLPt1YULpgU
   LcKQPS7tc4INFyeVZhEMPsvc9BXZMNgqnIXKONItbL11a8Zh8T7345ynp
   1wEE/kjYSNqRY5pRgi/8XYqgNVZ4m0zOiJr6L61mce8sZ3AtrgIWKqUkn
   HFo8kGxEZrZN3cxXWF3GWyQjgdknUCxvW+eUzduk7P1c7hC20amszj/P/
   5YwivSCByqLcL9lF6geeltn3HpV0G4vpXCzw9I8mT5e6jyjs6H0N9Nqwb
   dpf0iT+5ps/bGvNWsFuXOXIsikcYVroESs/YiFlbejQCvt8DD+aaZazs9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="412914835"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="412914835"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 00:15:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="784601980"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="784601980"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga001.jf.intel.com with ESMTP; 28 Sep 2023 00:15:32 -0700
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
Subject: [PATCH v2 2/6] iommufd/hw_pagetable: Use domain_alloc_user op for domain allocation
Date:   Thu, 28 Sep 2023 00:15:24 -0700
Message-Id: <20230928071528.26258-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928071528.26258-1-yi.l.liu@intel.com>
References: <20230928071528.26258-1-yi.l.liu@intel.com>
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

This makes IOMMUFD to use iommu_domain_alloc_user() for iommu_domain
creation as IOMMUFD needs to support iommu_domain allocation with
parameters from userspace in nested support. If the iommu driver
doesn't provide domain_alloc_user callback then IOMMUFD falls back to
use iommu_domain_alloc().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index cf2c1504e20d..48874f896521 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -5,6 +5,7 @@
 #include <linux/iommu.h>
 #include <uapi/linux/iommufd.h>
 
+#include "../iommu-priv.h"
 #include "iommufd_private.h"
 
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
@@ -74,6 +75,7 @@ struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			   struct iommufd_device *idev, bool immediate_attach)
 {
+	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
@@ -88,10 +90,19 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	refcount_inc(&ioas->obj.users);
 	hwpt->ioas = ioas;
 
-	hwpt->domain = iommu_domain_alloc(idev->dev->bus);
-	if (!hwpt->domain) {
-		rc = -ENOMEM;
-		goto out_abort;
+	if (ops->domain_alloc_user) {
+		hwpt->domain = ops->domain_alloc_user(idev->dev, 0);
+		if (IS_ERR(hwpt->domain)) {
+			rc = PTR_ERR(hwpt->domain);
+			hwpt->domain = NULL;
+			goto out_abort;
+		}
+	} else {
+		hwpt->domain = iommu_domain_alloc(idev->dev->bus);
+		if (!hwpt->domain) {
+			rc = -ENOMEM;
+			goto out_abort;
+		}
 	}
 
 	/*
-- 
2.34.1

