Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA6375F4AA
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 13:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjGXLOB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 07:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjGXLNr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 07:13:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE31E42;
        Mon, 24 Jul 2023 04:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690197226; x=1721733226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vjsd+ZC0uwe3yf7q5tPiMoMF6UD3qhRFLwMcJx16kDY=;
  b=f4XPjomGcf1iT0ekuZcKrX0zGe0/y+Hdnxg2V0ZaQuL4ipOuNmA8+cLH
   xgklfLKuPdr0pNLxdVZIsLFInl5cmtzDuMq/qd1a0EmBeXaO6bGquYhhE
   JklOP6r+6wbZ1sOwW94KURrLUKUZqX0ktn/pk9pO/REGwNWkwtQa0/g5r
   AmJBl4ora58eh3ULt1OjSH0hyxOzq2unXj25+jtFya3YSsCKjnlL7527G
   YwLiZrINvwI1NTLhVOhisDX2li3QeyA+vx2tXWC1+Wa29HT9N8wg0nEIy
   EMq2+OWTzdbVUlhD6wRQ5fvfOShPNaEBkmVAJk213xiPK/GKwnvVWQjOI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347015003"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347015003"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:13:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="839415541"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="839415541"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2023 04:13:44 -0700
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
Subject: [PATCH v4 07/12] iommufd: Add data structure for Intel VT-d stage-1 cache invalidation
Date:   Mon, 24 Jul 2023 04:13:29 -0700
Message-Id: <20230724111335.107427-8-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724111335.107427-1-yi.l.liu@intel.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds the data structure for flushing iotlb for the nested domain
allocated with IOMMU_HWPT_TYPE_VTD_S1 type.

Cache invalidation path is performance path, so it's better to avoid
memory allocation in such path. To achieve it, this path reuses the
ucmd_buffer to copy user data. So the new data structures are added in
the ucmd_buffer union to avoid overflow.

This only supports invalidating IOTLB, but no for device-TLB as device-TLB
invalidation will be covered automatically in the IOTLB invalidation if the
underlying IOMMU driver has enabled ATS for the affected device.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/main.c |  6 ++++
 include/uapi/linux/iommufd.h | 58 ++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index d49837397dfa..b927ace7f3af 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -485,6 +485,12 @@ union ucmd_buffer {
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
+	/*
+	 * hwpt_type specific structure used in the cache invalidation
+	 * path.
+	 */
+	struct iommu_hwpt_vtd_s1_invalidate vtd;
+	struct iommu_hwpt_vtd_s1_invalidate_desc req_vtd;
 };
 
 struct iommufd_ioctl_op {
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 90b0d3f603a7..2c1241448c87 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -523,6 +523,64 @@ struct iommu_resv_iova_ranges {
 };
 #define IOMMU_RESV_IOVA_RANGES _IO(IOMMUFD_TYPE, IOMMUFD_CMD_RESV_IOVA_RANGES)
 
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
+ * struct iommu_hwpt_vtd_s1_invalidate_desc - Intel VT-d stage-1 cache
+ *                                            invalidation descriptor
+ * @addr: The start address of the addresses to be invalidated.
+ * @npages: Number of contiguous 4K pages to be invalidated.
+ * @flags: Combination of enum iommu_hwpt_vtd_s1_invalidate_flags
+ * @__reserved: Must be 0
+ *
+ * The Intel VT-d specific invalidation data for user-managed stage-1 cache
+ * invalidation under nested translation. Userspace uses this structure to
+ * tell host about the impacted caches after modifying the stage-1 page table.
+ *
+ * Invalidating all the caches related to the hw_pagetable by setting @addr
+ * to be 0 and @npages to be __aligned_u64(-1).
+ */
+struct iommu_hwpt_vtd_s1_invalidate_desc {
+	__aligned_u64 addr;
+	__aligned_u64 npages;
+	__u32 flags;
+	__u32 __reserved;
+};
+
+/**
+ * struct iommu_hwpt_vtd_s1_invalidate - Intel VT-d cache invalidation
+ *                                       (IOMMU_HWPT_TYPE_VTD_S1)
+ * @flags: Must be 0
+ * @entry_size: Size in bytes of each cache invalidation request
+ * @entry_nr_uptr: User pointer to the number of invalidation requests.
+ *                 Kernel reads it to get the number of requests and
+ *                 updates the buffer with the number of requests that
+ *                 have been processed successfully. This pointer must
+ *                 point to a __u32 type of memory location.
+ * @inv_data_uptr: Pointer to the cache invalidation requests
+ *
+ * The Intel VT-d specific invalidation data for a set of cache invalidation
+ * requests. Kernel loops the requests one-by-one and stops when failure
+ * is encountered. The number of handled requests is reported to user by
+ * writing the buffer pointed by @entry_nr_uptr.
+ */
+struct iommu_hwpt_vtd_s1_invalidate {
+	__u32 flags;
+	__u32 entry_size;
+	__aligned_u64 entry_nr_uptr;
+	__aligned_u64 inv_data_uptr;
+};
+
 /**
  * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
  * @size: sizeof(struct iommu_hwpt_invalidate)
-- 
2.34.1

