Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234A87A5DBA
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 11:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjISJZi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 05:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjISJZh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 05:25:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E169DA;
        Tue, 19 Sep 2023 02:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695115528; x=1726651528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HRgwNmKwP4O6YStwVfMY8tcYduf05Yuqqfm8fE3FZmw=;
  b=dm8WE+HWTfa4zpVAgaEeOb3ivBghr8EbvEJKrV1cA5Hjo/p7taSrYEt0
   03gI87KhbSRpLbNpzF/UsvJlpY1flOPTcPWVSBNPYAATyQGyiiMMHN/2I
   Z7ozXFCnhfELckP0TaQKfJ8TRolH3DWDPtQsm8QGseN32rFjtz1/UHr6p
   wfmvuuTxGVE7D8OzN6tizaY75RU7ngfCC6KazCVKXMStc+qBKutBJ6Ju+
   ZjfE285TjfsYUwWdUzJhPg6CIucILEEFc2HjMqJfwkKD1HSmHfYP/oUXq
   RjBKoEG2GHuqBDaeVObEjhvIQLI4ikjBxSJDlPlIszIg8J5oaIzoqLpVz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="446368827"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="446368827"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 02:25:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="722804619"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="722804619"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 19 Sep 2023 02:25:25 -0700
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
Subject: [PATCH 1/6] iommu: Add new iommu op to create domains owned by userspace
Date:   Tue, 19 Sep 2023 02:25:18 -0700
Message-Id: <20230919092523.39286-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919092523.39286-1-yi.l.liu@intel.com>
References: <20230919092523.39286-1-yi.l.liu@intel.com>
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

Introduce a new iommu_domain op to create domains owned by userspace,
e.g. through IOMMUFD. These domains have a few different properties
compares to kernel owned domains:

 - They may be UNMANAGED domains, but created with special parameters.
   For instance aperture size changes/number of levels, different
   IOPTE formats, or other things necessary to make a vIOMMU work

 - We have to track all the memory allocations with GFP_KERNEL_ACCOUNT
   to make the cgroup sandbox stronger

 - Device-specialty domains, such as NESTED domains can be created by
   IOMMUFD.

The new op clearly says the domain is being created by IOMMUFD, that
the domain is intended for userspace use, and it provides a way to pass
user flags or a driver specific uAPI structure to customize the created
domain to exactly what the vIOMMU userspace driver requires.

iommu drivers that cannot support VFIO/IOMMUFD should not support this
op. This includes any driver that cannot provide a fully functional
UNMANAGED domain.

This new op for now is only supposed to be used by IOMMUFD, hence no
wrapper for it. IOMMUFD would call the callback directly. As for domain
free, IOMMUFD would use iommu_domain_free().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/linux/iommu.h        |  8 ++++++++
 include/uapi/linux/iommufd.h | 12 +++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c50a769d569a..660dc1931dc9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -235,6 +235,13 @@ struct iommu_iotlb_gather {
  *           use. The information type is one of enum iommu_hw_info_type defined
  *           in include/uapi/linux/iommufd.h.
  * @domain_alloc: allocate iommu domain
+ * @domain_alloc_user: Allocate an iommu domain corresponding to the input
+ *                     parameters like flags defined as enum iommufd_ioas_map_flags
+ *                     in include/uapi/linux/iommufd.h. Different from the
+ *                     domain_alloc op, it requires iommu driver to fully
+ *                     initialize a new domain including the generic iommu_domain
+ *                     struct. Upon success, a domain is returned. Upon failure,
+ *                     ERR_PTR must be returned.
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
@@ -267,6 +274,7 @@ struct iommu_ops {
 
 	/* Domain allocation and freeing by the iommu driver */
 	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
+	struct iommu_domain *(*domain_alloc_user)(struct device *dev, u32 flags);
 
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index b4ba0c0cbab6..4a7c5c8fdbb4 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -347,10 +347,20 @@ struct iommu_vfio_ioas {
 };
 #define IOMMU_VFIO_IOAS _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VFIO_IOAS)
 
+/**
+ * enum iommufd_hwpt_alloc_flags - Flags for HWPT allocation
+ * @IOMMU_HWPT_ALLOC_NEST_PARENT: If set, allocate a domain which can serve
+ *                                as the parent domain in the nesting
+ *                                configuration.
+ */
+enum iommufd_hwpt_alloc_flags {
+	IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
+};
+
 /**
  * struct iommu_hwpt_alloc - ioctl(IOMMU_HWPT_ALLOC)
  * @size: sizeof(struct iommu_hwpt_alloc)
- * @flags: Must be 0
+ * @flags: Combination of enum iommufd_hwpt_alloc_flags
  * @dev_id: The device to allocate this HWPT for
  * @pt_id: The IOAS to connect this HWPT to
  * @out_hwpt_id: The ID of the new HWPT
-- 
2.34.1

