Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CB77A5DC4
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 11:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjISJ0M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 05:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjISJ0J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 05:26:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7325612E;
        Tue, 19 Sep 2023 02:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695115559; x=1726651559;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2u453SswpKakc0NOsEhGqMN9HDyZwW3XZ2U2N48J7YQ=;
  b=cEJ5ZlqRGQodnm+BbID6byANhSAcQS0D/pdTLSCsmafieJX3UnXg/Lh1
   3/Awx24gTmqkRMF1nSsvUUKM0v7r75Ev/Wbz0DrTYIDUVmPmR5vPFgX/i
   9AST63r2Kk6jz7/VWCDR9lH0r01wjAqjLLfKdwveMNcTUdb2j20YtMj9t
   IGqP1Epkys4WmqWgBme9FekHltzrLoaeCa1I2RXYVNjZ5tqLuOJCgN8/W
   3JPL8tNXiLntg1+JLmJOUKdYcq/h/S2oPdTIVQ/DTeSi8rQxgbu4A3nZ8
   iYrxhtb8BulAT9NpxXW0cuYeKKY8RR8HmMBVBiQ9AfU3G+ptrFn0tMp3I
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="446368918"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="446368918"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 02:25:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="722804768"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="722804768"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 19 Sep 2023 02:25:26 -0700
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
Subject: [PATCH 2/6] iommufd/hw_pagetable: Use domain_alloc_user op for domain allocation
Date:   Tue, 19 Sep 2023 02:25:19 -0700
Message-Id: <20230919092523.39286-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919092523.39286-1-yi.l.liu@intel.com>
References: <20230919092523.39286-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

