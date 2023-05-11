Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1FC6FF4BB
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 16:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbjEKOmz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 10:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238340AbjEKOma (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 10:42:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1391310E42;
        Thu, 11 May 2023 07:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683815928; x=1715351928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LthEg6EGU/MY/viwuO2PF5RAMF9yzjhBqwVfgZnbeuQ=;
  b=IK8cRKaVh986bbPDLgLOiqOcYBFSdFbX4ZAS1EKLOpODF9FCS9R1T+a7
   ug01Tv7xuj68qxoHBd94+HJI4TDI/Xo+98Wz5EnnzrsdR+7KUXdcQRH/l
   ZCYedpXJzqwT9LQMdK9rBMBtNC5hm1hwgPUefe1wBL1xRKpLXYF5GHPCd
   0k7GoaFnd7HHBYtv2gzFwpRmiLJajBCy6CXG3xxjUwqfUNP10Z0xhNd9N
   YYQhElV3/rBY7Xq50IyP6vuOpv0lLjnU/eSuFRTOLMDQZrLx1vqfIoJZF
   PZDDkC2QB+qFh4K2SYiQtPyrhOKkHvmKsUCKT282/Mxp2BKM9OHsm3Uk3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="339812846"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="339812846"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 07:38:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="730382596"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="730382596"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga008.jf.intel.com with ESMTP; 11 May 2023 07:38:47 -0700
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
Subject: [PATCH v2 01/11] iommu: Add new iommu op to create domains owned by userspace
Date:   Thu, 11 May 2023 07:38:34 -0700
Message-Id: <20230511143844.22693-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511143844.22693-1-yi.l.liu@intel.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
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

From: Lu Baolu <baolu.lu@linux.intel.com>

Introduce a new iommu_domain op to create domains owned by userspace,
e.g. through iommufd. These domains have a few different properties
compares to kernel owned domains:

 - They may be UNMANAGED domains, but created with special parameters.
   For instance aperture size changes/number of levels, different
   IOPTE formats, or other things necessary to make a vIOMMU work

 - We have to track all the memory allocations with GFP_KERNEL_ACCOUNT
   to make the cgroup sandbox stronger

 - Device-specialty domains, such as NESTED domains can be created by
   iommufd.

The new op clearly says the domain is being created by IOMMUFD, that
the domain is intended for userspace use, and it provides a way to pass
a driver specific uAPI structure to customize the created domain to
exactly what the vIOMMU userspace driver requires.

iommu drivers that cannot support VFIO/IOMMUFD should not support this
op. This includes any driver that cannot provide a fully functional
UNMANAGED domain.

This op chooses to make the special parameters opaque to the core. This
suits the current usage model where accessing any of the IOMMU device
special parameters does require a userspace driver that matches the
kernel driver. If a need for common parameters, implemented similarly
by several drivers, arises then there is room in the design to grow a
generic parameter set as well.

This new op for now is only supposed to be used by iommufd, hence no
wrapper for it. iommufd would call the callback directly. As for domain
free, iommufd would use iommu_domain_free().

Also, add an op to return the length of supported user data structures
that must be added to include/uapi/include/iommufd.h file. This helps
the iommufd core to sanitize the input data before it forwards the data
to an iommu driver.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/linux/iommu.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a748d60206e7..7f2046fa53a3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -220,6 +220,15 @@ struct iommu_iotlb_gather {
 	bool			queued;
 };
 
+/*
+ * The user data to allocate a specific type user iommu domain
+ *
+ * This includes the corresponding driver data structures in
+ * include/uapi/linux/iommufd.h.
+ */
+union iommu_domain_user_data {
+};
+
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
@@ -229,6 +238,15 @@ struct iommu_iotlb_gather {
  *           after use. Return the data buffer if success, or ERR_PTR on
  *           failure.
  * @domain_alloc: allocate iommu domain
+ * @domain_alloc_user: allocate user iommu domain
+ * @domain_alloc_user_data_len: return the required length of the user data
+ *                              to allocate a specific type user iommu domain.
+ *                              @hwpt_type is defined as enum iommu_hwpt_type
+ *                              in include/uapi/linux/iommufd.h. The returned
+ *                              length is the corresponding sizeof driver data
+ *                              structures in include/uapi/linux/iommufd.h.
+ *                              -EOPNOTSUPP would be returned if the input
+ *                              @hwpt_type is not supported by the driver.
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
@@ -269,6 +287,10 @@ struct iommu_ops {
 
 	/* Domain allocation and freeing by the iommu driver */
 	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
+	struct iommu_domain *(*domain_alloc_user)(struct device *dev,
+						  struct iommu_domain *parent,
+						  const union iommu_domain_user_data *user_data);
+	int (*domain_alloc_user_data_len)(u32 hwpt_type);
 
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
-- 
2.34.1

