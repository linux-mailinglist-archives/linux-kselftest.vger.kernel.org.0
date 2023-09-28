Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128657B146A
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 09:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjI1HPh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 03:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjI1HPe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 03:15:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F901B5;
        Thu, 28 Sep 2023 00:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695885332; x=1727421332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=19oLqUtwSE9KQwWhP3qN2eLoUKpEnDmNF77eh1iFefY=;
  b=ZMz6z7oYm22qq7jjCQEA7Pv5OKKQRvVGG97/dCMeT0usd82JAcTkFnKg
   TnUlHIgXv+R/9ozjsmdVHxv2oeUG8LjdouJ3trktr0QiYj39H5aQmRO8A
   MHDqDO7oEOUHwKPHzY7A4k5eTVyGtnnlLomfPzg+0G+TLylzzq2SUf59V
   W87YIzov6BpNTaKxHuu/DNzQdp0Za0C4pnCrPykfi/g0/7hteonB32YdO
   Vn08kXGO1VrFB20KPg2Eyksw7yyMrzbs9Izp1kg5y1TynL7t21KPN9QHM
   gvUrraGsgNdu+lILE2KDs+vJpCj3SM08LlxtLyUkOlb4ka+XQNSY/31W0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="412914825"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="412914825"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 00:15:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="784601963"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="784601963"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga001.jf.intel.com with ESMTP; 28 Sep 2023 00:15:31 -0700
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
Subject: [PATCH v2 1/6] iommu: Add new iommu op to create domains owned by userspace
Date:   Thu, 28 Sep 2023 00:15:23 -0700
Message-Id: <20230928071528.26258-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928071528.26258-1-yi.l.liu@intel.com>
References: <20230928071528.26258-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
 include/linux/iommu.h        | 11 ++++++++++-
 include/uapi/linux/iommufd.h | 12 +++++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c50a769d569a..3861d66b65c1 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -234,7 +234,15 @@ struct iommu_iotlb_gather {
  *           op is allocated in the iommu driver and freed by the caller after
  *           use. The information type is one of enum iommu_hw_info_type defined
  *           in include/uapi/linux/iommufd.h.
- * @domain_alloc: allocate iommu domain
+ * @domain_alloc: allocate and return an iommu domain if success. Otherwise
+ *                NULL is returned. The domain is not fully initialized until
+ *                the caller iommu_domain_alloc() returns.
+ * @domain_alloc_user: Allocate an iommu domain corresponding to the input
+ *                     parameters as defined in include/uapi/linux/iommufd.h.
+ *                     Unlike @domain_alloc, it is called only by IOMMUFD and
+ *                     must fully initialize the new domain before return.
+ *                     Upon success, a domain is returned. Upon failure,
+ *                     ERR_PTR must be returned.
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
@@ -267,6 +275,7 @@ struct iommu_ops {
 
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

