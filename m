Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027EE7D54C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 17:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjJXPJz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 11:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjJXPJy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 11:09:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26EB122;
        Tue, 24 Oct 2023 08:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698160190; x=1729696190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ihFSbfjzrksgMO5J3a++dqWzR2za25igudY6plXnH2o=;
  b=kVz+vbqJojbpFXSxwRnft0hQa0bI6BaakUxQlwV5RVAWTKsSmVDKDvM5
   u2IBRSA/G0lq4XGrVnsWoyNobjvhoRTWjQWD71iLOgIgkC5l7QyGvdlY4
   AkKW4FqaxYbwqiYk+ojhVy8YBcyNLxkGBQ3McoetHu0GA6V13ga7Zd1JJ
   toxWJb4btzhWQYfSRETdWVCjLShsgHYn4O3QcSe+I0H0o7Ea18rETzKyP
   5lc6rKFmVEdSCZF3IBUqFopJdcBM8yL4qNXGKPaX2UHswLDaqeQSdsRFb
   kPbB5SAmpWWgaWfYwnORUe/emTVrvD+QkwrVpFG8IKWn+dO+uN3MyEFjj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="418202942"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="418202942"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:06:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="6486167"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa001.fm.intel.com with ESMTP; 24 Oct 2023 08:06:16 -0700
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
Subject: [PATCH v6 02/10] iommu: Pass in parent domain with user_data to domain_alloc_user op
Date:   Tue, 24 Oct 2023 08:06:01 -0700
Message-Id: <20231024150609.46884-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024150609.46884-1-yi.l.liu@intel.com>
References: <20231024150609.46884-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/iommu/intel/iommu.c          |  7 ++++++-
 drivers/iommu/iommufd/hw_pagetable.c |  3 ++-
 drivers/iommu/iommufd/selftest.c     |  7 ++++++-
 include/linux/iommu.h                | 27 ++++++++++++++++++++++++---
 include/uapi/linux/iommufd.h         |  8 ++++++++
 5 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 65f46f1347e6..cb64759b3d95 100644
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
index c2b742ffeb0c..97b84d681e09 100644
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
index d8551c9d5b6c..a01a38332dc1 100644
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
index becfc8b725de..a86ce9cb3547 100644
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
+	struct iommu_domain *(*domain_alloc_user)(struct device *dev, u32 flags,
+						  struct iommu_domain *parent,
+						  const struct iommu_user_data *user_data);
 
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index c44eecf5d318..fccc6315a520 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -361,6 +361,14 @@ enum iommufd_hwpt_alloc_flags {
 	IOMMU_HWPT_ALLOC_DIRTY_TRACKING = 1 << 1,
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

