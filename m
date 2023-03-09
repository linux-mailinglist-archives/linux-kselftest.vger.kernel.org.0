Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BAF6B1DE6
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 09:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCIIYg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 03:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjCIIYD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 03:24:03 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECA8B9521;
        Thu,  9 Mar 2023 00:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678350168; x=1709886168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eosmom8m8jHTqT2C2nazDZTU+HJNVXBxSxneXzpiKIc=;
  b=LDDuv9eO4ME/7gfcJHfd1FQwcWy7hEN0OjeSUFkELIUkEYnY+hEgsUEX
   Jlz7DhST17d8dSNRu8wRK/cjZYkgmIA8wri21bejU/IUBlnKtHuV/4OBO
   sY8Wxl1qDruxcv89Wo0vIoDTOfh505UtcrV04NJsbs2ADdshodtW7hypE
   o5wRQ4TUtXj57KSfVfyILcP2y4/ZzYO+GAlkHeH2+/T59+lLU0L+uDf2Q
   VexyIwpR5gZcNPLc835Yi99GLwI4usuJ2hEScgY2dtr8lLcKBFIg5QRca
   NL1+L2VJiB/AvBe4oah3jvSgUJbs4JOqd/jsss6GxWpZnPXuu27nZzHdU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364026180"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364026180"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:22:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787474150"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787474150"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2023 00:22:11 -0800
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
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/5] iommufd: Add nesting related data structures for Intel VT-d
Date:   Thu,  9 Mar 2023 00:22:03 -0800
Message-Id: <20230309082207.612346-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309082207.612346-1-yi.l.liu@intel.com>
References: <20230309082207.612346-1-yi.l.liu@intel.com>
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

Add the following data structures for corresponding ioctls:
               iommu_hwpt_intel_vtd => IOMMU_HWPT_ALLOC
              iommu_hw_info_vtd => IOMMU_DEVICE_GET_HW_INFO
    iommu_hwpt_invalidate_intel_vtd => IOMMU_HWPT_INVALIDATE

Also, add IOMMU_HW_INFO_TYPE_INTEL_VTD and IOMMU_HWPT_TYPE_VTD_S1 to the
header and corresponding type/size arrays.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c |   7 +-
 drivers/iommu/iommufd/main.c         |   5 +
 include/uapi/linux/iommufd.h         | 136 +++++++++++++++++++++++++++
 3 files changed, 147 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 76ff228dfc1f..36e79db8a17d 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -172,6 +172,7 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
  */
 static const size_t iommufd_hwpt_alloc_data_size[] = {
 	[IOMMU_HWPT_TYPE_DEFAULT] = 0,
+	[IOMMU_HWPT_TYPE_VTD_S1] = sizeof(struct iommu_hwpt_intel_vtd),
 };
 
 /*
@@ -180,6 +181,8 @@ static const size_t iommufd_hwpt_alloc_data_size[] = {
  */
 const u64 iommufd_hwpt_type_bitmaps[] =  {
 	[IOMMU_HW_INFO_TYPE_DEFAULT] = BIT_ULL(IOMMU_HWPT_TYPE_DEFAULT),
+	[IOMMU_HW_INFO_TYPE_INTEL_VTD] = BIT_ULL(IOMMU_HWPT_TYPE_DEFAULT) |
+					 BIT_ULL(IOMMU_HWPT_TYPE_VTD_S1),
 };
 
 /* Return true if type is supported, otherwise false */
@@ -324,7 +327,9 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
  * size of page table type specific invalidate_info, indexed by
  * enum iommu_hwpt_type.
  */
-static const size_t iommufd_hwpt_invalidate_info_size[] = {};
+static const size_t iommufd_hwpt_invalidate_info_size[] = {
+	[IOMMU_HWPT_TYPE_VTD_S1] = sizeof(struct iommu_hwpt_invalidate_intel_vtd),
+};
 
 int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
 {
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 7ec3ceac01b3..514db4c26927 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -275,6 +275,11 @@ union ucmd_buffer {
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
+	/*
+	 * data_type specific structure used in the cache invalidation
+	 * path.
+	 */
+	struct iommu_hwpt_invalidate_intel_vtd vtd;
 };
 
 struct iommufd_ioctl_op {
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index e2eff9c56ab3..2a6c326391b2 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -351,9 +351,64 @@ struct iommu_vfio_ioas {
 /**
  * enum iommu_hwpt_type - IOMMU HWPT Type
  * @IOMMU_HWPT_TYPE_DEFAULT: default
+ * @IOMMU_HWPT_TYPE_VTD_S1: Intel VT-d stage-1 page table
  */
 enum iommu_hwpt_type {
 	IOMMU_HWPT_TYPE_DEFAULT,
+	IOMMU_HWPT_TYPE_VTD_S1,
+};
+
+/**
+ * enum iommu_hwpt_intel_vtd_flags - Intel VT-d stage-1 page
+ *				     table entry attributes
+ * @IOMMU_VTD_PGTBL_SRE: Supervisor request
+ * @IOMMU_VTD_PGTBL_EAFE: Extended access enable
+ * @IOMMU_VTD_PGTBL_PCD: Page-level cache disable
+ * @IOMMU_VTD_PGTBL_PWT: Page-level write through
+ * @IOMMU_VTD_PGTBL_EMTE: Extended mem type enable
+ * @IOMMU_VTD_PGTBL_CD: PASID-level cache disable
+ * @IOMMU_VTD_PGTBL_WPE: Write protect enable
+ */
+enum iommu_hwpt_intel_vtd_flags {
+	IOMMU_VTD_PGTBL_SRE = 1 << 0,
+	IOMMU_VTD_PGTBL_EAFE = 1 << 1,
+	IOMMU_VTD_PGTBL_PCD = 1 << 2,
+	IOMMU_VTD_PGTBL_PWT = 1 << 3,
+	IOMMU_VTD_PGTBL_EMTE = 1 << 4,
+	IOMMU_VTD_PGTBL_CD = 1 << 5,
+	IOMMU_VTD_PGTBL_WPE = 1 << 6,
+	IOMMU_VTD_PGTBL_LAST = 1 << 7,
+};
+
+/**
+ * struct iommu_hwpt_intel_vtd - Intel VT-d specific user-managed
+ *                               stage-1 page table info
+ * @flags: Combination of enum iommu_hwpt_intel_vtd_flags
+ * @pgtbl_addr: The base address of the user-managed stage-1 page table.
+ * @pat: Page attribute table data to compute effective memory type
+ * @emt: Extended memory type
+ * @addr_width: The address width of the untranslated addresses that are
+ *              subjected to the user-managed stage-1 page table.
+ * @__reserved: Must be 0
+ *
+ * The Intel VT-d specific data for creating hw_pagetable to represent
+ * the user-managed stage-1 page table that is used in nested translation.
+ *
+ * In nested translation, the stage-1 page table locates in the address
+ * space that defined by the corresponding stage-2 page table. Hence the
+ * stage-1 page table base address value should not be higher than the
+ * maximum untranslated address of stage-2 page table.
+ *
+ * The paging level of the stage-1 page table should be compataible with
+ * the hardware iommu. Otherwise, the allocation would be failed.
+ */
+struct iommu_hwpt_intel_vtd {
+	__u64 flags;
+	__u64 pgtbl_addr;
+	__u32 pat;
+	__u32 emt;
+	__u32 addr_width;
+	__u32 __reserved;
 };
 
 /**
@@ -389,6 +444,8 @@ enum iommu_hwpt_type {
  * +------------------------------+-------------------------------------+-----------+
  * | IOMMU_HWPT_TYPE_DEFAULT      |               N/A                   |    IOAS   |
  * +------------------------------+-------------------------------------+-----------+
+ * | IOMMU_HWPT_TYPE_VTD_S1       |      struct iommu_hwpt_intel_vtd    |    HWPT   |
+ * +------------------------------+-------------------------------------+-----------+
  */
 struct iommu_hwpt_alloc {
 	__u32 size;
@@ -405,9 +462,32 @@ struct iommu_hwpt_alloc {
 
 /**
  * enum iommu_hw_info_type - IOMMU Hardware Info Types
+ * @IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d iommu info type
  */
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_DEFAULT,
+	IOMMU_HW_INFO_TYPE_INTEL_VTD,
+};
+
+/**
+ * struct iommu_hw_info_vtd - Intel VT-d hardware information
+ *
+ * @flags: Must be set to 0
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
@@ -457,6 +537,60 @@ struct iommu_hw_info {
 };
 #define IOMMU_DEVICE_GET_HW_INFO _IO(IOMMUFD_TYPE, IOMMUFD_CMD_DEVICE_GET_HW_INFO)
 
+/**
+ * enum iommu_vtd_qi_granularity - Intel VT-d specific granularity of
+ *                                 queued invalidation
+ * @IOMMU_VTD_QI_GRAN_DOMAIN: domain-selective invalidation
+ * @IOMMU_VTD_QI_GRAN_ADDR: page-selective invalidation
+ */
+enum iommu_vtd_qi_granularity {
+	IOMMU_VTD_QI_GRAN_DOMAIN,
+	IOMMU_VTD_QI_GRAN_ADDR,
+};
+
+/**
+ * enum iommu_hwpt_intel_vtd_invalidate_flags - Flags for Intel VT-d
+ *                                              stage-1 page table cache
+ *                                              invalidation
+ * @IOMMU_VTD_QI_FLAGS_LEAF: The LEAF flag indicates whether only the
+ *                           leaf PTE caching needs to be invalidated
+ *                           and other paging structure caches can be
+ *                           preserved.
+ */
+enum iommu_hwpt_intel_vtd_invalidate_flags {
+	IOMMU_VTD_QI_FLAGS_LEAF = 1 << 0,
+};
+
+/**
+ * struct iommu_hwpt_invalidate_intel_vtd - Intel VT-d cache invalidation info
+ * @granularity: One of enum iommu_vtd_qi_granularity.
+ * @flags: Combination of enum iommu_hwpt_intel_vtd_invalidate_flags
+ * @__reserved: Must be 0
+ * @addr: The start address of the addresses to be invalidated.
+ * @granule_size: Page/block size of the mapping in bytes. It is used to
+ *                compute the invalidation range togehter with @nb_granules.
+ * @nb_granules: Number of contiguous granules to be invalidated.
+ *
+ * The Intel VT-d specific invalidation data for user-managed stage-1 cache
+ * invalidation under nested translation. Userspace uses this structure to
+ * tell host about the impacted caches after modifying the stage-1 page table.
+ *
+ * @addr, @granule_size and @nb_granules are meaningful when
+ * @granularity==IOMMU_VTD_QI_GRAN_ADDR. Intel VT-d currently only supports
+ * 4kB page size, so @granule_size should be 4KB. @addr should be aligned
+ * with @granule_size * @nb_granules, otherwise invalidation won't take
+ * effect.
+ */
+struct iommu_hwpt_invalidate_intel_vtd {
+	__u8 granularity;
+	__u8 padding[7];
+	__u32 flags;
+	__u32 __reserved;
+	__u64 addr;
+	__u64 granule_size;
+	__u64 nb_granules;
+};
+
 /**
  * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
  * @size: sizeof(struct iommu_hwpt_invalidate)
@@ -473,6 +607,8 @@ struct iommu_hw_info {
  * +==============================+========================================+
  * | @data_type                   |     Data structure in @data_uptr       |
  * +------------------------------+----------------------------------------+
+ * | IOMMU_HWPT_TYPE_VTD_S1       | struct iommu_hwpt_invalidate_intel_vtd |
+ * +------------------------------+----------------------------------------+
  */
 struct iommu_hwpt_invalidate {
 	__u32 size;
-- 
2.34.1

