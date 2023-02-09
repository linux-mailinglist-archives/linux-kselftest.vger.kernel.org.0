Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4843268FE5E
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 05:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBIETu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 23:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjBIETs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 23:19:48 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7B837B46;
        Wed,  8 Feb 2023 20:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675916317; x=1707452317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FHpZ/QqiMDOUDlV/6MH/yoSElx9gu3oQTNg7c3bopYs=;
  b=UjdcylbahddBAdOaH8Fjk75LslKMVyuzY7+zGkxwiwr1n5d1JOYvxkCK
   5nIm6Bc7GXVnv6c8ceYHyTonqExmCIDkWBXAu5joCeB28m1QdHOUKGRIA
   H+cuIdO00cC0vrwImfj/+BLE4BvctprfFQjklDohGZtdi4Oh9ymvgm4Bh
   /6B7aNUmjCpF7KEtUtp6G9Kz7NsvCpSFzBEI1Uv5iZU2CvurkaFQse43E
   GrGy4fQSjNPc9h5Cz5c6x1i9zpIFr6nyGwJLMxbIaXcEmoJO6GjB+fNUk
   KjO1JLXMNaH8Wajm7Hie8/csnRKl8r8qmf+QRXS4ta48vclESUGNPniPQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="394600718"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="394600718"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:16:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="912982088"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="912982088"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga006.fm.intel.com with ESMTP; 08 Feb 2023 20:16:47 -0800
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
Subject: [PATCH 2/6] iommu/vt-d: Implement hw_info for iommu capability query
Date:   Wed,  8 Feb 2023 20:16:38 -0800
Message-Id: <20230209041642.9346-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209041642.9346-1-yi.l.liu@intel.com>
References: <20230209041642.9346-1-yi.l.liu@intel.com>
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

From: Lu Baolu <baolu.lu@linux.intel.com>

To support nested translation in the userspace, it should check the
underlying hardware information for the capabilities.

Add intel_iommu_hw_info() to report cap_reg and ecap_reg information.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
---
 drivers/iommu/intel/iommu.c  | 19 +++++++++++++++++++
 drivers/iommu/intel/iommu.h  |  1 +
 include/uapi/linux/iommufd.h | 21 +++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 59df7e42fd53..929f600cc350 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4760,8 +4760,26 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
 }
 
+static void *intel_iommu_hw_info(struct device *dev, u32 *length)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	struct iommu_device_info_vtd *vtd;
+
+	vtd = kzalloc(sizeof(*vtd), GFP_KERNEL);
+	if (!vtd)
+		return ERR_PTR(-ENOMEM);
+
+	vtd->cap_reg = iommu->cap;
+	vtd->ecap_reg = iommu->ecap;
+	*length = sizeof(*vtd);
+
+	return vtd;
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
+	.hw_info		= intel_iommu_hw_info,
 	.domain_alloc		= intel_iommu_domain_alloc,
 	.probe_device		= intel_iommu_probe_device,
 	.probe_finalize		= intel_iommu_probe_finalize,
@@ -4774,6 +4792,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.def_domain_type	= device_def_domain_type,
 	.remove_dev_pasid	= intel_iommu_remove_dev_pasid,
 	.pgsize_bitmap		= SZ_4K,
+	.driver_type		= IOMMU_DEVICE_DATA_INTEL_VTD,
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	.page_response		= intel_svm_page_response,
 #endif
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 06e61e474856..2e70265d4ceb 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -22,6 +22,7 @@
 #include <linux/ioasid.h>
 #include <linux/bitfield.h>
 #include <linux/xarray.h>
+#include <uapi/linux/iommufd.h>
 
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 2309edb55028..fda75c8450ee 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -347,7 +347,28 @@ struct iommu_vfio_ioas {
 
 /**
  * enum iommu_device_data_type - IOMMU hardware Data types
+ * @IOMMU_DEVICE_DATA_INTEL_VTD: Intel VT-d iommu data type
  */
 enum iommu_device_data_type {
+	IOMMU_DEVICE_DATA_INTEL_VTD = 1,
+};
+
+/**
+ * struct iommu_device_info_vtd - Intel VT-d device info
+ *
+ * @flags: Must be set to 0
+ * @__reserved: Must be 0
+ * @cap_reg: Value of Intel VT-d capability register defined in chapter
+ *	     11.4.2 of Intel VT-d spec.
+ * @ecap_reg: Value of Intel VT-d capability register defined in chapter
+ *	     11.4.3 of Intel VT-d spec.
+ *
+ * Intel hardware iommu capability.
+ */
+struct iommu_device_info_vtd {
+	__u32 flags;
+	__u32 __reserved;
+	__aligned_u64 cap_reg;
+	__aligned_u64 ecap_reg;
 };
 #endif
-- 
2.34.1

