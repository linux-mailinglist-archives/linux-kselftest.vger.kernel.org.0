Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B307D0B55
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 11:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376634AbjJTJUC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 05:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376546AbjJTJUB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 05:20:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE10D51;
        Fri, 20 Oct 2023 02:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697793598; x=1729329598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vW/H8Z4bcelxZXf/ORWAI5Dwtig9Y1wuACFD5pTvzR4=;
  b=dotNoPgdiMPBvTVvChAEsHA1yqtO4oesvXM0ctWvW6QceqKbVyfJcwgv
   PoM0e6/UP1chf58Et9zi86jWwPpuydYKXa0WqeVFGGTnDNLAZDnwW7GCh
   Z4uxcmCtyjlnfW+G34/3JCKR6pAM3Qtm2efBmS3VdFWhcQYS7YggHc2HM
   Kq5kLFp2R+0dCQqH32rtnxZPSceBB/odtnda200MNE7pdFK/0goVjc/os
   nOC/NlCeopFHxgUNuXjcDzJAq2HBQTzqMIFSV1lWUkzsI6zZnLjosWTaQ
   jbsfoNPxaVroEkxRORoOJ3GSXM1RGiUe9ZoxbP0ml7cCQbGJPk1+Ki2Rn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="366693330"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="366693330"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:19:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="707179417"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="707179417"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga003.jf.intel.com with ESMTP; 20 Oct 2023 02:19:57 -0700
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
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
        xin.zeng@intel.com
Subject: [PATCH v5 02/10] iommu: Pass in parent domain with user_data to domain_alloc_user op
Date:   Fri, 20 Oct 2023 02:19:38 -0700
Message-Id: <20231020091946.12173-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020091946.12173-1-yi.l.liu@intel.com>
References: <20231020091946.12173-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

domain_alloc_user op already accepts user flags for domain allocation, add
a parent domain pointer and a driver specific user data support as well.

Add a struct iommu_user_data as a bundle of data_ptr/data_len/type from an
iommufd core uAPI structure. Make the user data opaque to the core, since
a userspace driver must match the kernel driver. In the future, if drivers
share some common parameter, there would be a generic parameter as well.

Define an enum iommu_hwpt_data_type (with IOMMU_HWPT_DATA_NONE type) for
iommu drivers to add their own driver specific user data per hw_pagetable.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c          |  4 +++-
 drivers/iommu/iommufd/hw_pagetable.c |  3 ++-
 drivers/iommu/iommufd/selftest.c     |  4 +++-
 include/linux/iommu.h                | 27 ++++++++++++++++++++++++---
 include/uapi/linux/iommufd.h         |  8 ++++++++
 5 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 017aed5813d8..8d78149e793e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4075,7 +4075,9 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 }
 
 static struct iommu_domain *
-intel_iommu_domain_alloc_user(struct device *dev, u32 flags)
+intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
+			      struct iommu_domain *parent,
+			      const struct iommu_user_data *user_data)
 {
 	struct iommu_domain *domain;
 	struct intel_iommu *iommu;
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 8b3d2875d642..548079c8ca0a 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -96,7 +96,8 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	hwpt->ioas = ioas;
 
 	if (ops->domain_alloc_user) {
-		hwpt->domain = ops->domain_alloc_user(idev->dev, flags);
+		hwpt->domain = ops->domain_alloc_user(idev->dev, flags,
+						      NULL, NULL);
 		if (IS_ERR(hwpt->domain)) {
 			rc = PTR_ERR(hwpt->domain);
 			hwpt->domain = NULL;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index fe7e3c7d933a..2bfe8dc9adc3 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -171,7 +171,9 @@ static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
 }
 
 static struct iommu_domain *
-mock_domain_alloc_user(struct device *dev, u32 flags)
+mock_domain_alloc_user(struct device *dev, u32 flags,
+		       struct iommu_domain *parent,
+		       const struct iommu_user_data *user_data)
 {
 	struct iommu_domain *domain;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ce08a3c41446..cdb989b853a5 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -231,6 +231,21 @@ struct iommu_iotlb_gather {
 	bool			queued;
 };
 
+/**
+ * struct iommu_user_data - iommu driver specific user space data info
+ * @type: The data type of the user buffer
+ * @uptr: Pointer to the user buffer for copy_from_user()
+ * @len: The length of the user buffer in bytes
+ *
+ * A user space data is an uAPI that is defined in include/uapi/linux/iommufd.h
+ * @type, @uptr and @len should be just copied from an iommufd core uAPI struct.
+ */
+struct iommu_user_data {
+	unsigned int type;
+	void __user *uptr;
+	size_t len;
+};
+
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
@@ -245,8 +260,12 @@ struct iommu_iotlb_gather {
  *                     parameters as defined in include/uapi/linux/iommufd.h.
  *                     Unlike @domain_alloc, it is called only by IOMMUFD and
  *                     must fully initialize the new domain before return.
- *                     Upon success, a domain is returned. Upon failure,
- *                     ERR_PTR must be returned.
+ *                     Upon success, if the @user_data is valid and the @parent
+ *                     points to a kernel-managed domain, the new domain must be
+ *                     IOMMU_DOMAIN_NESTED type; otherwise, the @parent must be
+ *                     NULL while the @user_data can be optionally provided, the
+ *                     new domain must support __IOMMU_DOMAIN_PAGING.
+ *                     Upon failure, ERR_PTR must be returned.
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
@@ -279,7 +298,9 @@ struct iommu_ops {
 
 	/* Domain allocation and freeing by the iommu driver */
 	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
-	struct iommu_domain *(*domain_alloc_user)(struct device *dev, u32 flags);
+	struct iommu_domain *(*domain_alloc_user)(struct device *dev, u32 flags,
+						  struct iommu_domain *parent,
+						  const struct iommu_user_data *user_data);
 
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index be7a95042677..b459bb7ac579 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -356,6 +356,14 @@ enum iommufd_hwpt_alloc_flags {
 	IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
 };
 
+/**
+ * enum iommu_hwpt_data_type - IOMMU HWPT Data Type
+ * @IOMMU_HWPT_DATA_NONE: no data
+ */
+enum iommu_hwpt_data_type {
+	IOMMU_HWPT_DATA_NONE,
+};
+
 /**
  * struct iommu_hwpt_alloc - ioctl(IOMMU_HWPT_ALLOC)
  * @size: sizeof(struct iommu_hwpt_alloc)
-- 
2.34.1

