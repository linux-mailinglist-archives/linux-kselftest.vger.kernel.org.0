Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9756977E143
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 14:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245007AbjHPMPH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 08:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245017AbjHPMOn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 08:14:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0A926A5;
        Wed, 16 Aug 2023 05:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692188071; x=1723724071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=njUq9CwODpx5bz5eoFfrRtDr6es/px3ELZkYHa18we4=;
  b=OI++fgUiz8PDI5wehwcciNwUm0oBjyoLmpDsCfnqKcEHLNNL6EiQpQcI
   nVqKSH4/wiOEQ/cKnQjJZe6ggZGk0ETUGmJOAIv30JQud3P5Mwkj3A/jt
   cOe2+4CA6j3Ah1KOFY95o/MBbjTRbWjWjPDs4TroSCoHzLCU6o2scY4nr
   kUUqIIOrRW+IWi5b3a7CTkHi/12ZbBMBdKuHAAHdQlYJcjKI+EbTPTl6G
   d4F85sma6VCvNaiYwkuApDdWWP3Zfo6a1CAAwXhmu0xr1Tz3uBIaWM8g9
   GmBROj9XAe2tLkDiT4U25KrV6kh+wv2OtCUjh4ZhvhnwJ+AD/v/dnBq9q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436411647"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="436411647"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 05:14:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="727730767"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="727730767"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga007.jf.intel.com with ESMTP; 16 Aug 2023 05:14:09 -0700
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
Subject: [PATCH v8 2/5] iommu: Add new iommu op to get iommu hardware information
Date:   Wed, 16 Aug 2023 05:13:46 -0700
Message-Id: <20230816121349.104436-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816121349.104436-1-yi.l.liu@intel.com>
References: <20230816121349.104436-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

Introduce a new iommu op to get the IOMMU hardware capabilities for
iommufd. This information will be used by any vIOMMU driver which is owned
by userspace.

This op chooses to make the special parameters opaque to the core. This
suits the current usage model where accessing any of the IOMMU device
special parameters does require a userspace driver that matches the kernel
driver. If a need for common parameters, implemented similarly by several
drivers, arises then there's room in the design to grow a generic
parameter set as well. No wrapper API is added as it is supposed to be
used by iommufd only.

Different IOMMU hardware would have different hardware information. So the
information reported differs as well. To let the external user understand
the difference. enum iommu_hw_info_type is defined. For the iommu drivers
that are capable to report hardware information, it should have a unique
iommu_hw_info_type and return to caller. For the driver doesn't report
hardware information, caller just uses IOMMU_HW_INFO_TYPE_NONE if a type
is required.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/linux/iommu.h        | 9 +++++++++
 include/uapi/linux/iommufd.h | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e0245aa82b75..f2d6a3989713 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -228,6 +228,14 @@ struct iommu_iotlb_gather {
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
+ * @hw_info: IOMMU hardware information. The type of the returned data is
+ *           marked by the output type of this op. Type is one of
+ *           enum iommu_hw_info_type defined in include/uapi/linux/iommufd.h.
+ *           The drivers that support this op should define a unique type
+ *           in include/uapi/linux/iommufd.h. The data buffer returned by this
+ *           op is allocated in the IOMMU driver and the caller should free it
+ *           after use. Return the data buffer if success, or ERR_PTR on
+ *           failure.
  * @domain_alloc: allocate iommu domain
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
@@ -257,6 +265,7 @@ struct iommu_iotlb_gather {
  */
 struct iommu_ops {
 	bool (*capable)(struct device *dev, enum iommu_cap);
+	void *(*hw_info)(struct device *dev, u32 *length, u32 *type);
 
 	/* Domain allocation and freeing by the iommu driver */
 	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 8245c01adca6..ac11ace21edb 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -370,4 +370,13 @@ struct iommu_hwpt_alloc {
 	__u32 __reserved;
 };
 #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)
+
+/**
+ * enum iommu_hw_info_type - IOMMU Hardware Info Types
+ * @IOMMU_HW_INFO_TYPE_NONE: Used by the drivers that do not report hardware
+ *                           info
+ */
+enum iommu_hw_info_type {
+	IOMMU_HW_INFO_TYPE_NONE,
+};
 #endif
-- 
2.34.1

