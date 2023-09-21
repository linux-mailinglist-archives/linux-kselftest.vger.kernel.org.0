Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390ED7A9F47
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 22:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjIUUUV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 16:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjIUUUE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 16:20:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF62FAD21;
        Thu, 21 Sep 2023 10:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695316280; x=1726852280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S7OPx85gN2G+8RHarCfjHgmntx38eLMzDBOfexGdmYM=;
  b=jcDgCkeNqhdoytre2wP3usuY6Ibq/k2L8CW0yCKU1TLPiDv+v3HyxDnS
   aXzEpvR7Rytu27rkHs2qXsAS3Yw/n/BjTR9/ayUwEL3TU9f0nheYRuPts
   PIwsZkHF+dGYp0s+AK6HN6VnXQVESjr/hBQ50DPGjjVlne7pGVZGy+H+6
   MfE1hYK2fHZT01uhnhikNx/EC+XDe0izY15KvBsWrgcbcQfALqKCznqOz
   C5tolYr0haI8xyDPIzVCDh8MohakGLPH6/VSd7PnHDxx5WXjDP2ttP+qw
   yn8vFN4LJegOghvfva0y8B/E0MSDOlrr0X/LrAArw56x6YMis28F8RINI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="370764450"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="370764450"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:54:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="812523164"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="812523164"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga008.fm.intel.com with ESMTP; 21 Sep 2023 00:54:51 -0700
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
Subject: [PATCH v5 07/11] iommufd: Add data structure for Intel VT-d stage-1 cache invalidation
Date:   Thu, 21 Sep 2023 00:54:27 -0700
Message-Id: <20230921075431.125239-8-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921075431.125239-1-yi.l.liu@intel.com>
References: <20230921075431.125239-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds the data structure for flushing iotlb for the nested domain
allocated with IOMMU_HWPT_TYPE_VTD_S1 type.

This only supports invalidating IOTLB, but no for device-TLB as device-TLB
invalidation will be covered automatically in the IOTLB invalidation if the
underlying IOMMU driver has enabled ATS for the affected device.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/uapi/linux/iommufd.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 18a502e206c3..3050efbceb57 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -510,6 +510,40 @@ struct iommu_hw_info {
 };
 #define IOMMU_GET_HW_INFO _IO(IOMMUFD_TYPE, IOMMUFD_CMD_GET_HW_INFO)
 
+/**
+ * enum iommu_hwpt_vtd_s1_invalidate_flags - Flags for Intel VT-d
+ *                                           stage-1 cache invalidation
+ * @IOMMU_VTD_QI_FLAGS_LEAF: The LEAF flag indicates whether only the
+ *                           leaf PTE caching needs to be invalidated
+ *                           and other paging structure caches can be
+ *                           preserved.
+ */
+enum iommu_hwpt_vtd_s1_invalidate_flags {
+	IOMMU_VTD_QI_FLAGS_LEAF = 1 << 0,
+};
+
+/**
+ * struct iommu_hwpt_vtd_s1_invalidate - Intel VT-d cache invalidation
+ *                                       (IOMMU_HWPT_TYPE_VTD_S1)
+ * @addr: The start address of the addresses to be invalidated.
+ * @npages: Number of contiguous 4K pages to be invalidated.
+ * @flags: Combination of enum iommu_hwpt_vtd_s1_invalidate_flags
+ * @__reserved: Must be 0
+ *
+ * The Intel VT-d specific invalidation data for user-managed stage-1 cache
+ * invalidation under nested translation. Userspace uses this structure to
+ * tell host about the impacted caches after modifying the stage-1 page table.
+ *
+ * Invalidating all the caches related to the page table by setting @addr
+ * to be 0 and @npages to be __aligned_u64(-1).
+ */
+struct iommu_hwpt_vtd_s1_invalidate {
+	__aligned_u64 addr;
+	__aligned_u64 npages;
+	__u32 flags;
+	__u32 __reserved;
+};
+
 /**
  * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
  * @size: sizeof(struct iommu_hwpt_invalidate)
-- 
2.34.1

