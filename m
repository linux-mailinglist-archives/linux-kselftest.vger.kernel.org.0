Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC3E6B1D16
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 08:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjCIHyt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 02:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjCIHy0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 02:54:26 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305B0DCA7D;
        Wed,  8 Mar 2023 23:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678348443; x=1709884443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9puZucPj6fLkrWz4CurcGtcInzi+r97NtNBrr/RGepA=;
  b=Z8kSTJ07SglkAH7mh7QBm4FdAvoyIcXwN3H0j4hkgbyZxlBClQtM7Agc
   gB+/+VBpkv7qKTNY6Y8YPPgixp4jHscEVYzllTa0izkvEr4CbOMKhEwnN
   3xHVjm+t1b4nwbaYMDAe/9A38gstPPrSu4zZWyXhvslUTsRSKwhaQW4hd
   7bSCDhI5ansqzRTmL/8orpm+rwg+BMQynyorktBUgG9L8+xztghJHGiX4
   LaipAIp72+qVnH3zH6ZwR7T5NhflkqYmFxy4Xn85bzPXou1OUaJbbRasR
   yfMemBWSiHXTGmbRy3CA1TU5aSrTgiNAGiY1m/cLkMNfoTVjFWvphFV/b
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="422652835"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="422652835"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 23:54:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="851432742"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="851432742"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga005.jf.intel.com with ESMTP; 08 Mar 2023 23:54:01 -0800
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
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/4] iommu: Move dev_iommu_ops() to private header
Date:   Wed,  8 Mar 2023 23:53:55 -0800
Message-Id: <20230309075358.571567-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309075358.571567-1-yi.l.liu@intel.com>
References: <20230309075358.571567-1-yi.l.liu@intel.com>
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

dev_iommu_ops() is essentially only used in iommu subsystem, so
move to a private header to avoid being abused by other drivers.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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
index fd8fe2cd7303..437476c36de5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -37,6 +37,8 @@
 
 #include "iommu-sva.h"
 
+#include "iommu-priv.h"
+
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 6595454d4f48..7202d8ece343 100644
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
 extern int bus_iommu_probe(struct bus_type *bus);
 extern bool iommu_present(struct bus_type *bus);
 extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
-- 
2.34.1

