Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2247A9BEB
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 21:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjIUTFO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 15:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjIUTEr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 15:04:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A11C45608;
        Thu, 21 Sep 2023 10:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318586; x=1726854586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fvPPNNrDP2tXqIqwpVeYqNI5pvCMrqvAU0Xuz1h8Bs8=;
  b=Dgm7o1zPyIifV4UUjjkISxTSg4cH5ipRtgpjubVhZE1urX/paf9qK8ev
   Yib8r1D7pRVKKjPfJ14h5945cDtriuvm0tDcFIGyIcGcxx2JIFGiKaA3w
   eIHVHJZQFd8A2pPlQtOpU1PDn0mNOzqt49Wr3bhvdntsE9A1kjL9OeEVd
   1rk4sJ8Y1AV5IXlJlOE6PpWFH1GnRD7ONPKw998cpzK5lNnd8uhGpO7yO
   zS6ILGTTd8UWp2qXaw9hRec+MqvD42zZVbLY4NwA9kmoOroUaQ6smDNDI
   gRX2Ci0TaPvgQi7oeVWWyG1NdRjz90Cv5Z4ThlF0W/yNKk0O6QK9DPRd/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359832802"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="359832802"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:52:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723649491"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="723649491"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2023 00:52:07 -0700
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
Subject: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for domain_alloc_user op
Date:   Thu, 21 Sep 2023 00:51:22 -0700
Message-Id: <20230921075138.124099-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921075138.124099-1-yi.l.liu@intel.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
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

domain_alloc_user op already accepts user flags for domain allocation,
add hwpt_type and user_data support as well. This op chooses to make the
special parameters opaque to the core. This suits the current usage model
where accessing any of the IOMMU device special parameters does require
a userspace driver that matches the kernel driver. If a need for common
parameters, implemented similarly by several drivers, arises then there
is room in the design to grow a generic parameter set as well.

Define enum iommu_hwpt_type to differentiate the user parameters used by
different iommu vendor drivers in the future. For backward compatibility
and the allocations without any specified hwpt_type or user parameters,
add an IOMMU_HWPT_TYPE_DEFAULT in the list.

Also, add a struct iommu_user_data as a package of data_ptr and data_len
from an iommufd core uAPI structure, then provide a helper function for
a driver to run data length sanity and copy a defined hwpt_type specific
driver user data.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c          |  5 ++-
 drivers/iommu/iommufd/hw_pagetable.c |  4 ++-
 drivers/iommu/iommufd/selftest.c     |  5 ++-
 include/linux/iommu.h                | 51 ++++++++++++++++++++++++++--
 include/uapi/linux/iommufd.h         |  8 +++++
 5 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 491bcde1ff96..4ffc939a71f0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4075,7 +4075,10 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 }
 
 static struct iommu_domain *
-intel_iommu_domain_alloc_user(struct device *dev, u32 flags)
+intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
+			      enum iommu_hwpt_type hwpt_type,
+			      struct iommu_domain *parent,
+			      const struct iommu_user_data *user_data)
 {
 	struct iommu_domain *domain;
 	struct intel_iommu *iommu;
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 26a8a818ffa3..1d7378a6cbb3 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -96,7 +96,9 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	hwpt->ioas = ioas;
 
 	if (ops->domain_alloc_user) {
-		hwpt->domain = ops->domain_alloc_user(idev->dev, flags);
+		hwpt->domain = ops->domain_alloc_user(idev->dev, flags,
+						      IOMMU_HWPT_TYPE_DEFAULT,
+						      NULL, NULL);
 		if (IS_ERR(hwpt->domain)) {
 			rc = PTR_ERR(hwpt->domain);
 			hwpt->domain = NULL;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index b54cbfb1862b..2205a552e570 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -171,7 +171,10 @@ static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
 }
 
 static struct iommu_domain *
-mock_domain_alloc_user(struct device *dev, u32 flags)
+mock_domain_alloc_user(struct device *dev, u32 flags,
+		       enum iommu_hwpt_type hwpt_type,
+		       struct iommu_domain *parent,
+		       const struct iommu_user_data *user_data)
 {
 	struct iommu_domain *domain;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 660dc1931dc9..12e12e5563e6 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <uapi/linux/iommu.h>
+#include <uapi/linux/iommufd.h>
 
 #define IOMMU_READ	(1 << 0)
 #define IOMMU_WRITE	(1 << 1)
@@ -227,6 +228,41 @@ struct iommu_iotlb_gather {
 	bool			queued;
 };
 
+/**
+ * struct iommu_user_data - iommu driver specific user space data info
+ * @uptr: Pointer to the user buffer for copy_from_user()
+ * @len: The length of the user buffer in bytes
+ *
+ * A user space data is an uAPI that is defined in include/uapi/linux/iommufd.h
+ * Both @uptr and @len should be just copied from an iommufd core uAPI structure
+ */
+struct iommu_user_data {
+	void __user *uptr;
+	size_t len;
+};
+
+/**
+ * iommu_copy_user_data - Copy iommu driver specific user space data
+ * @dst_data: Pointer to an iommu driver specific user data that is defined in
+ *            include/uapi/linux/iommufd.h
+ * @src_data: Pointer to a struct iommu_user_data for user space data info
+ * @data_len: Length of current user data structure, i.e. sizeof(struct _dst)
+ * @min_len: Initial length of user data structure for backward compatibility.
+ *           This should be offsetofend using the last member in the user data
+ *           struct that was initially added to include/uapi/linux/iommufd.h
+ */
+static inline int iommu_copy_user_data(void *dst_data,
+				       const struct iommu_user_data *src_data,
+				       size_t data_len, size_t min_len)
+{
+	if (WARN_ON(!dst_data || !src_data))
+		return -EINVAL;
+	if (src_data->len < min_len || data_len < src_data->len)
+		return -EINVAL;
+	return copy_struct_from_user(dst_data, data_len,
+				     src_data->uptr, src_data->len);
+}
+
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
@@ -237,11 +273,17 @@ struct iommu_iotlb_gather {
  * @domain_alloc: allocate iommu domain
  * @domain_alloc_user: Allocate an iommu domain corresponding to the input
  *                     parameters like flags defined as enum iommufd_ioas_map_flags
+ *                     and the @hwpt_type that is defined as enum iommu_hwpt_type
  *                     in include/uapi/linux/iommufd.h. Different from the
  *                     domain_alloc op, it requires iommu driver to fully
  *                     initialize a new domain including the generic iommu_domain
- *                     struct. Upon success, a domain is returned. Upon failure,
- *                     ERR_PTR must be returned.
+ *                     struct.
+ *                     Upon success, if the @user_data is valid and the @parent
+ *                     points to a kernel-managed domain, the new domain must be
+ *                     IOMMU_DOMAIN_NESTED type; otherwise, the @parent must be
+ *                     NULL while the @user_data can be optionally provided, the
+ *                     new domain must be IOMMU_DOMAIN_UNMANAGED type.
+ *                     Upon failure, ERR_PTR must be returned.
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
@@ -274,7 +316,10 @@ struct iommu_ops {
 
 	/* Domain allocation and freeing by the iommu driver */
 	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
-	struct iommu_domain *(*domain_alloc_user)(struct device *dev, u32 flags);
+	struct iommu_domain *(*domain_alloc_user)(struct device *dev, u32 flags,
+						  enum iommu_hwpt_type hwpt_type,
+						  struct iommu_domain *parent,
+						  const struct iommu_user_data *user_data);
 
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 4a7c5c8fdbb4..3c8660fe9bb1 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -357,6 +357,14 @@ enum iommufd_hwpt_alloc_flags {
 	IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
 };
 
+/**
+ * enum iommu_hwpt_type - IOMMU HWPT Type
+ * @IOMMU_HWPT_TYPE_DEFAULT: default
+ */
+enum iommu_hwpt_type {
+	IOMMU_HWPT_TYPE_DEFAULT,
+};
+
 /**
  * struct iommu_hwpt_alloc - ioctl(IOMMU_HWPT_ALLOC)
  * @size: sizeof(struct iommu_hwpt_alloc)
-- 
2.34.1

