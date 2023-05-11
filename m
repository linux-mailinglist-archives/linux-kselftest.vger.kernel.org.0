Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D9E6FF462
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 16:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbjEKOcO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 10:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238523AbjEKObY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 10:31:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDAC10E79;
        Thu, 11 May 2023 07:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683815450; x=1715351450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RhTctlSU8kGwAHBuYtQQX127URdk3c3vFpZE39HtnRs=;
  b=R1rNBDogmNgf2odVgWj9IvvWKzVe6S/eFP20tMLAwQXv50zhWtIAf2b3
   MzeDMknwgRZ59AFS1lYynuvSXGmznffNlZeVeMxUt52kFzDH1q9gMMy37
   E/GzqYOoXZpGdqqXm3tcsJQMmLu3kruv4tSvwA+4XEIEVcSy8JosWM36Q
   enDerg6LlOGJdtIFKT1QtlcGKJzNtIF2GeIKYgNaWLnDn2N0AS8LRs49J
   4Hm4ksYa1djsRk87V4+hvxUbWI4GIGGWQgFxWdesBpy71wD10hHbQ+zh4
   zC5w8Xqb/8YPXd5RDmjZI4wvSIfJjFb9gUWKJDIj/18UDiHPD+/ybGtJG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="378639860"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="378639860"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 07:30:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="874004416"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="874004416"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga005.jf.intel.com with ESMTP; 11 May 2023 07:30:28 -0700
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
        zhenzhong.duan@intel.com
Subject: [PATCH v3 1/4] iommu: Move dev_iommu_ops() to private header
Date:   Thu, 11 May 2023 07:30:21 -0700
Message-Id: <20230511143024.19542-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511143024.19542-1-yi.l.liu@intel.com>
References: <20230511143024.19542-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

dev_iommu_ops() is essentially only used in iommu subsystem, so
move to a private header to avoid being abused by other drivers.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu-priv.h | 11 +++++++++++
 drivers/iommu/iommu.c      |  2 ++
 include/linux/iommu.h      | 11 -----------
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index 7c8011bfd153..a6e694f59f64 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -4,6 +4,17 @@
 
 #include <linux/iommu.h>
 
+static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
+{
+	/*
+	 * Assume that valid ops must be installed if iommu_probe_device()
+	 * has succeeded. The device ops are essentially for internal use
+	 * within the IOMMU subsystem itself, so we should be able to trust
+	 * ourselves not to misuse the helper.
+	 */
+	return dev->iommu->iommu_dev->ops;
+}
+
 int iommu_group_replace_domain(struct iommu_group *group,
 			       struct iommu_domain *new_domain);
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 91573efd9488..b44fd1a76997 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -38,6 +38,8 @@
 
 #include "iommu-sva.h"
 
+#include "iommu-priv.h"
+
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e8c9a7da1060..e7d70548e597 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -444,17 +444,6 @@ static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
 	};
 }
 
-static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
-{
-	/*
-	 * Assume that valid ops must be installed if iommu_probe_device()
-	 * has succeeded. The device ops are essentially for internal use
-	 * within the IOMMU subsystem itself, so we should be able to trust
-	 * ourselves not to misuse the helper.
-	 */
-	return dev->iommu->iommu_dev->ops;
-}
-
 extern int bus_iommu_probe(const struct bus_type *bus);
 extern bool iommu_present(const struct bus_type *bus);
 extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
-- 
2.34.1

