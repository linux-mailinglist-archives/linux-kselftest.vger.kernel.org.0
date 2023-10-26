Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801797D7B9C
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 06:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbjJZEkA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 00:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjJZEjw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 00:39:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CF6191;
        Wed, 25 Oct 2023 21:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698295190; x=1729831190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YGpQoHBpgo+OtwHOFnMkEmlWaRuCkfvoPjSEMKpnnvY=;
  b=dm/4RCjrra4/SADvHw2fZ6jnKmg5VxJTSjN0Xs6v2ZBTwzUl6LrRlnog
   5wZp3ygOX8TQGmWC6bDOGe0Fbnq0x4CxPtAbsUPmrVTf7+5QrlYNJkgFG
   aLoecVZG2y4jQ9CDIohFBxrJbgUYir1hkO2v+bsK28/bSw3iMqRaM9RW+
   IlhbGwupMNsrm+KmIWUt/Vpd4xcesRp6wEafk0HpsMCHTmRXo73tEkcHN
   o8CpTRl8vJYlG6/9TitADXM8+BRxE/wGfyL9p60U5MEOYut886uSaxSpY
   1xeBgy50TBfsojEBNjGQtoQ5DY2JFVbuLwjvENuG6w0NjM35E7hR3JEGr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="9014512"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="9014512"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 21:39:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="708931321"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="708931321"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2023 21:39:45 -0700
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
Subject: [PATCH v7 06/10] iommu: Pass in parent domain with user_data to domain_alloc_user op
Date:   Wed, 25 Oct 2023 21:39:34 -0700
Message-Id: <20231026043938.63898-7-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026043938.63898-1-yi.l.liu@intel.com>
References: <20231026043938.63898-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

domain_alloc_user op already accepts user flags for domain allocation, add
a parent domain pointer and a driver specific user data support as well.
The user data would be tagged with a type for iommu drivers to add their
own driver specific user data per hw_pagetable.

Add a struct iommu_user_data as a bundle of data_ptr/data_len/type from an
iommufd core uAPI structure. Make the user data opaque to the core, since
a userspace driver must match the kernel driver. In the future, if drivers
share some common parameter, there would be a generic parameter as well.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c            |  9 ++++++---
 drivers/iommu/intel/iommu.c          |  7 ++++++-
 drivers/iommu/iommufd/hw_pagetable.c |  3 ++-
 drivers/iommu/iommufd/selftest.c     |  7 ++++++-
 include/linux/iommu.h                | 27 ++++++++++++++++++++++++---
 5 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index caad10f9cee3..b399c5741378 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2219,12 +2219,15 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned int type)
 	return domain;
 }
 
-static struct iommu_domain *amd_iommu_domain_alloc_user(struct device *dev,
-							u32 flags)
+static struct iommu_domain *
+amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
+			    struct iommu_domain *parent,
+			    const struct iommu_user_data *user_data)
+
 {
 	unsigned int type = IOMMU_DOMAIN_UNMANAGED;
 
-	if (flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
+	if ((flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING) || parent || user_data)
 		return ERR_PTR(-EOPNOTSUPP);
 
 	return do_iommu_domain_alloc(type, dev, flags);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index eb92a201cc0b..fe67f8d77b09 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4076,7 +4076,9 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 }
 
 static struct iommu_domain *
-intel_iommu_domain_alloc_user(struct device *dev, u32 flags)
+intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
+			      struct iommu_domain *parent,
+			      const struct iommu_user_data *user_data)
 {
 	struct iommu_domain *domain;
 	struct intel_iommu *iommu;
@@ -4086,6 +4088,9 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags)
 	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
 		return ERR_PTR(-EOPNOTSUPP);
 
+	if (parent || user_data)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	iommu = device_to_iommu(dev, NULL, NULL);
 	if (!iommu)
 		return ERR_PTR(-ENODEV);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 6bce9af0cb8d..198ecbd536f7 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -108,7 +108,8 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	hwpt_paging->ioas = ioas;
 
 	if (ops->domain_alloc_user) {
-		hwpt->domain = ops->domain_alloc_user(idev->dev, flags);
+		hwpt->domain =
+			ops->domain_alloc_user(idev->dev, flags, NULL, NULL);
 		if (IS_ERR(hwpt->domain)) {
 			rc = PTR_ERR(hwpt->domain);
 			hwpt->domain = NULL;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 068928ba7950..d71007234896 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -241,7 +241,9 @@ static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
 }
 
 static struct iommu_domain *
-mock_domain_alloc_user(struct device *dev, u32 flags)
+mock_domain_alloc_user(struct device *dev, u32 flags,
+		       struct iommu_domain *parent,
+		       const struct iommu_user_data *user_data)
 {
 	struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
 	struct iommu_domain *domain;
@@ -250,6 +252,9 @@ mock_domain_alloc_user(struct device *dev, u32 flags)
 	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
 		return ERR_PTR(-EOPNOTSUPP);
 
+	if (parent || user_data)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if ((flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING) &&
 	    (mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY))
 		return ERR_PTR(-EOPNOTSUPP);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index bc303cb2af37..2ddd99f55471 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -265,6 +265,21 @@ struct iommu_dirty_ops {
 				    struct iommu_dirty_bitmap *dirty);
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
@@ -279,8 +294,12 @@ struct iommu_dirty_ops {
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
@@ -313,7 +332,9 @@ struct iommu_ops {
 
 	/* Domain allocation and freeing by the iommu driver */
 	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
-	struct iommu_domain *(*domain_alloc_user)(struct device *dev, u32 flags);
+	struct iommu_domain *(*domain_alloc_user)(
+		struct device *dev, u32 flags, struct iommu_domain *parent,
+		const struct iommu_user_data *user_data);
 
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
-- 
2.34.1

