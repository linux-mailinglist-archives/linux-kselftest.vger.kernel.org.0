Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E3975F411
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 13:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjGXLAO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 07:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbjGXLAM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 07:00:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA7BE65;
        Mon, 24 Jul 2023 03:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196394; x=1721732394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4sa+xq3Q9e41JXFT2qIhbuD5DTnjShAP6BzvAmrGcDM=;
  b=W+7EJVTOobD47VNvL25JkZaxeuCHN8OyRqPJs0YIqV2MyevCsAQfPfrt
   GZ/+PKvIUbZHa8vfpEewSL+k9j26FrESHkGRJY6IKrb0V/pujtZCUiUbP
   LL7QBQSW85yHO7Zm9lj8ZCF0FB2O6Qtw/AZRW+ZCZZanf/61g/qDpOqBB
   nNYIXpMPUg6xeIS5Ul3eTXuoS+L04JpMlcwtWyq+MfuxVIG9G5Yh+kqwq
   DNZBzSW0fy5dlCC6mO7gz7n3SS0fhEiAsJqZBMexMf3tq/OzlI6djeMCv
   iWz102C1uIWpVWp+c2UPQ+viW9gjiTVUBBY91YFIlIc4ejjOQRKOrrXmz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347012264"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347012264"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 03:59:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="839409046"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="839409046"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2023 03:59:39 -0700
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
Subject: [PATCH v4 2/4] iommu: Add new iommu op to get iommu hardware information
Date:   Mon, 24 Jul 2023 03:59:34 -0700
Message-Id: <20230724105936.107042-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724105936.107042-1-yi.l.liu@intel.com>
References: <20230724105936.107042-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

Introduce a new iommu op to get the IOMMU hardware capabilities for
iommufd. This information will be used by any vIOMMU driver which is
owned by userspace.

This op chooses to make the special parameters opaque to the core. This
suits the current usage model where accessing any of the IOMMU device
special parameters does require a userspace driver that matches the kernel
driver. If a need for common parameters, implemented similarly by several
drivers, arises then there's room in the design to grow a generic parameter
set as well. No wrapper API is added as it is supposed to be used by
iommufd only.

Different IOMMU hardware would have different hardware information. So the
information reported differs as well. To let the external user understand
the difference. enum iommu_hw_info_type is defined. For the iommu drivers
that are capable to report hardware information, it should have a unique
iommu_hw_info_type. The iommu_hw_info_type is stored in struct iommu_ops.
For the driver doesn't report hardware information, just use
IOMMU_HW_INFO_TYPE_NONE.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/linux/iommu.h        | 16 ++++++++++++++++
 include/uapi/linux/iommufd.h |  8 ++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e0245aa82b75..4199e13b34e6 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <uapi/linux/iommu.h>
+#include <uapi/linux/iommufd.h>
 
 #define IOMMU_READ	(1 << 0)
 #define IOMMU_WRITE	(1 << 1)
@@ -228,6 +229,11 @@ struct iommu_iotlb_gather {
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
+ * @hw_info: IOMMU hardware information. The type of the returned data is
+ *           marked by @hw_info_type. The data buffer returned by this op
+ *           is allocated in the IOMMU driver and the caller should free it
+ *           after use. Return the data buffer if success, or ERR_PTR on
+ *           failure.
  * @domain_alloc: allocate iommu domain
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
@@ -252,11 +258,20 @@ struct iommu_iotlb_gather {
  * @remove_dev_pasid: Remove any translation configurations of a specific
  *                    pasid, so that any DMA transactions with this pasid
  *                    will be blocked by the hardware.
+ * @hw_info_type: One of enum iommu_hw_info_type defined in
+ *                include/uapi/linux/iommufd.h. It is used to tag the type
+ *                of data returned by .hw_info callback. The drivers that
+ *                support .hw_info callback should define a unique type
+ *                in include/uapi/linux/iommufd.h. For the drivers that do
+ *                not implement .hw_info callback, this field is
+ *                IOMMU_HW_INFO_TYPE_NONE which is 0. Hence, such drivers
+ *                do not need to care this field.
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  * @owner: Driver module providing these ops
  */
 struct iommu_ops {
 	bool (*capable)(struct device *dev, enum iommu_cap);
+	void *(*hw_info)(struct device *dev, u32 *length);
 
 	/* Domain allocation and freeing by the iommu driver */
 	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
@@ -285,6 +300,7 @@ struct iommu_ops {
 	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid);
 
 	const struct iommu_domain_ops *default_domain_ops;
+	enum iommu_hw_info_type hw_info_type;
 	unsigned long pgsize_bitmap;
 	struct module *owner;
 };
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 8245c01adca6..1f616b0f8ae0 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -370,4 +370,12 @@ struct iommu_hwpt_alloc {
 	__u32 __reserved;
 };
 #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)
+
+/**
+ * enum iommu_hw_info_type - IOMMU Hardware Info Types
+ * @IOMMU_HW_INFO_TYPE_NONE: Used by the drivers that does not report hardware info
+ */
+enum iommu_hw_info_type {
+	IOMMU_HW_INFO_TYPE_NONE,
+};
 #endif
-- 
2.34.1

