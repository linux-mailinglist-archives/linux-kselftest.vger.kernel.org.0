Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8056FF520
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 16:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238745AbjEKOxT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 10:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238652AbjEKOwl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 10:52:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C0BE735;
        Thu, 11 May 2023 07:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683816725; x=1715352725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RiJbUCRtwm5Znm9STMCxtijeo+jb5c7PnzMHxXPV1jU=;
  b=QZeeo8kUy/k/yZDW3eWkq2hIAW0kqi3m7deAAXzfQVYVnNNIntBDR2WY
   Pz3NS3yYSNgcKZ7qJ9isIfX5A3GyxH6+PQKYqpnt4TdYEY6knuaMAj+Fa
   Y29lzwM04B5KU42aXMxT18JaQsYyt7tsb8QBbNc/hyNoXpheMaLI1aEom
   pQDJ4T7ePlOUJJlzWfRpYjD6ezAH/qaa8WwfDMU4W0XpmjE7EbaIt9nPQ
   b8g+Qv0+S4m48lptjTKUghbhE0jF1/acIGx03SuNVFdxldp5H5zHStEVM
   g/c/w5ughn+YpWZa0pGU3qZRpcKhlFs5QJ9ZMUuhtJYJkaZjpm0Vys3M8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="335025523"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="335025523"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 07:51:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="769355194"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="769355194"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2023 07:51:20 -0700
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
Subject: [PATCH v3 09/10] iommu/vt-d: Implement hw_info for iommu capability query
Date:   Thu, 11 May 2023 07:51:09 -0700
Message-Id: <20230511145110.27707-10-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511145110.27707-1-yi.l.liu@intel.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add intel_iommu_hw_info() to report cap_reg and ecap_reg information.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c  | 19 +++++++++++++++++++
 include/uapi/linux/iommufd.h | 23 +++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 51612da4a1ea..20d4ae1cb8a6 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4746,6 +4746,23 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
 }
 
+static void *intel_iommu_hw_info(struct device *dev, u32 *length)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	struct iommu_hw_info_vtd *vtd;
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
 static int intel_iommu_domain_user_data_len(u32 hwpt_type)
 {
 	if (hwpt_type != IOMMU_HWPT_TYPE_VTD_S1)
@@ -4755,6 +4772,7 @@ static int intel_iommu_domain_user_data_len(u32 hwpt_type)
 
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
+	.hw_info		= intel_iommu_hw_info,
 	.domain_alloc		= intel_iommu_domain_alloc,
 	.domain_alloc_user	= intel_iommu_domain_alloc_user,
 	.domain_alloc_user_data_len = intel_iommu_domain_user_data_len,
@@ -4769,6 +4787,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.def_domain_type	= device_def_domain_type,
 	.remove_dev_pasid	= intel_iommu_remove_dev_pasid,
 	.pgsize_bitmap		= SZ_4K,
+	.hw_info_type		= IOMMU_HW_INFO_TYPE_INTEL_VTD,
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	.page_response		= intel_svm_page_response,
 #endif
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 2e658fa346ad..b46270a4cf46 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -464,9 +464,32 @@ struct iommu_hwpt_alloc {
 
 /**
  * enum iommu_hw_info_type - IOMMU Hardware Info Types
+ * @IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d iommu info type
  */
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_NONE,
+	IOMMU_HW_INFO_TYPE_INTEL_VTD,
+};
+
+/**
+ * struct iommu_hw_info_vtd - Intel VT-d hardware information
+ *
+ * @flags: Must be 0
+ * @__reserved: Must be 0
+ *
+ * @cap_reg: Value of Intel VT-d capability register defined in VT-d spec
+ *           section 11.4.2 Capability Register.
+ * @ecap_reg: Value of Intel VT-d capability register defined in VT-d spec
+ *            section 11.4.3 Extended Capability Register.
+ *
+ * User needs to understand the Intel VT-d specification to decode the
+ * register value.
+ */
+struct iommu_hw_info_vtd {
+	__u32 flags;
+	__u32 __reserved;
+	__aligned_u64 cap_reg;
+	__aligned_u64 ecap_reg;
 };
 
 /**
-- 
2.34.1

