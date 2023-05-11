Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB666FF512
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 16:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238204AbjEKOxP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 10:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238641AbjEKOwb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 10:52:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FFC11B4A;
        Thu, 11 May 2023 07:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683816717; x=1715352717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bXtmswM4fcZmRyz4ffkT34RI+fzlROFvWgl83sjywhU=;
  b=ld8fMPTPArpIWvnkUyNC52zVQHeWyg7AVMoi+qRAtXZEtkzcWJNW9DQl
   snvWKDsgGkKCwYw0FNAvoUL4Bjk81iI8iHcl3cVJfhjHQQ2FMNK4MneYe
   izR1TyETNPBhRJ2OhGAiYtLEbHqgxfMAc2ssqkErYXoHXGtOR2mU9TbBF
   iOdBCa/chxCwCVk5FTiRJIrRBpvL1hj7qPkWqVsowM2p/1rp/sxEYnRsB
   ytQhqfaO/HE9LeFYEsufB9WtyYjPI+GH8CmB57cVF+lHSVcxC82+p+5hr
   /lswZ2nJqLBZpQKQvFC3WxpMaopP2x1tcR2GSXFIyg5NOsnamLeh11Dgm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="335025498"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="335025498"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 07:51:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="769355185"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="769355185"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2023 07:51:19 -0700
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
Subject: [PATCH v3 07/10] iommu/vt-d: Add iotlb flush for nested domain
Date:   Thu, 11 May 2023 07:51:07 -0700
Message-Id: <20230511145110.27707-8-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511145110.27707-1-yi.l.liu@intel.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is needed as the stage-1 page table of the nested domain is
maintained outside the iommu subsystem, hence, needs to support iotlb
flush requests.

This adds the data structure for flushing iotlb for the nested domain
allocated with IOMMU_HWPT_TYPE_VTD_S1 type and the related callback
to accept iotlb flush request from IOMMUFD.

This only exposes the interface for invalidating IOTLB, but no for
device-TLB as device-TLB invalidation will be covered automatically
in IOTLB invalidation if the affected device is ATS-capable.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c  | 10 +++---
 drivers/iommu/intel/iommu.h  |  6 ++++
 drivers/iommu/intel/nested.c | 69 ++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c |  6 ++++
 include/uapi/linux/iommufd.h | 59 ++++++++++++++++++++++++++++++
 5 files changed, 145 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e6536a43dd82..5f27cee4656a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1474,10 +1474,10 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
-static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
-				  struct dmar_domain *domain,
-				  unsigned long pfn, unsigned int pages,
-				  int ih, int map)
+void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
+			   struct dmar_domain *domain,
+			   unsigned long pfn, unsigned int pages,
+			   int ih, int map)
 {
 	unsigned int aligned_pages = __roundup_pow_of_two(pages);
 	unsigned int mask = ilog2(aligned_pages);
@@ -1550,7 +1550,7 @@ static inline void __mapping_notify_one(struct intel_iommu *iommu,
 		iommu_flush_write_buffer(iommu);
 }
 
-static void intel_flush_iotlb_all(struct iommu_domain *domain)
+void intel_flush_iotlb_all(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct iommu_domain_info *info;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index ccb93aed6cf2..581596d90c1b 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -859,6 +859,12 @@ int prepare_domain_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
 bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain);
 void domain_update_iommu_cap(struct dmar_domain *domain);
+void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
+			   struct dmar_domain *domain,
+			   unsigned long pfn, unsigned int pages,
+			   int ih, int map);
+void intel_flush_iotlb_all(struct iommu_domain *domain);
+
 
 int dmar_ir_support(void);
 
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index fd38424b78f0..d13fbcd3f5a6 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -64,8 +64,77 @@ static void intel_nested_domain_free(struct iommu_domain *domain)
 	kfree(to_dmar_domain(domain));
 }
 
+static void intel_nested_invalidate(struct device *dev,
+				    struct dmar_domain *domain,
+				    u64 addr, unsigned long npages)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+
+	if (addr == 0 && npages == -1)
+		intel_flush_iotlb_all(&domain->domain);
+	else
+		iommu_flush_iotlb_psi(iommu, domain,
+				      addr >> VTD_PAGE_SHIFT,
+				      npages, 1, 0);
+}
+
+static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
+					      void *user_data)
+{
+	struct iommu_hwpt_invalidate_request_intel_vtd *req = user_data;
+	struct iommu_hwpt_invalidate_intel_vtd *inv_info = user_data;
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	unsigned int entry_size = inv_info->entry_size;
+	u64 uptr = inv_info->inv_data_uptr;
+	u64 nr_uptr = inv_info->entry_nr_uptr;
+	struct device_domain_info *info;
+	u32 entry_nr, index;
+	unsigned long flags;
+	int ret = 0;
+
+	if (WARN_ON(!user_data))
+		return 0;
+
+	if (get_user(entry_nr, (uint32_t __user *)u64_to_user_ptr(nr_uptr)))
+		return -EFAULT;
+
+	if (!entry_nr)
+		return -EINVAL;
+
+	for (index = 0; index < entry_nr; index++) {
+		ret = copy_struct_from_user(req, sizeof(*req),
+					    u64_to_user_ptr(uptr + index * entry_size),
+					    entry_size);
+		if (ret) {
+			pr_err_ratelimited("Failed to fetch invalidation request\n");
+			break;
+		}
+
+		if (req->__reserved || (req->flags & ~IOMMU_VTD_QI_FLAGS_LEAF) ||
+		    !IS_ALIGNED(req->addr, VTD_PAGE_SIZE)) {
+			ret = -EINVAL;
+			break;
+		}
+
+		spin_lock_irqsave(&dmar_domain->lock, flags);
+		list_for_each_entry(info, &dmar_domain->devices, link)
+			intel_nested_invalidate(info->dev, dmar_domain,
+						req->addr, req->npages);
+		spin_unlock_irqrestore(&dmar_domain->lock, flags);
+	}
+
+	if (ret && put_user(index, (uint32_t __user *)u64_to_user_ptr(nr_uptr)))
+		return -EFAULT;
+
+	return ret;
+}
+
 static const struct iommu_domain_ops intel_nested_domain_ops = {
 	.attach_dev		= intel_nested_attach_dev,
+	.cache_invalidate_user	= intel_nested_cache_invalidate_user,
+	.cache_invalidate_user_data_len =
+		sizeof(struct iommu_hwpt_invalidate_intel_vtd),
 	.free			= intel_nested_domain_free,
 	.enforce_cache_coherency = intel_iommu_enforce_cache_coherency,
 };
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 39922f83ce34..b338b082950b 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -282,6 +282,12 @@ union ucmd_buffer {
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
+	/*
+	 * hwpt_type specific structure used in the cache invalidation
+	 * path.
+	 */
+	struct iommu_hwpt_invalidate_intel_vtd vtd;
+	struct iommu_hwpt_invalidate_request_intel_vtd req_vtd;
 };
 
 struct iommufd_ioctl_op {
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index c2658394827a..2e658fa346ad 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -505,6 +505,63 @@ struct iommu_hw_info {
 };
 #define IOMMU_DEVICE_GET_HW_INFO _IO(IOMMUFD_TYPE, IOMMUFD_CMD_DEVICE_GET_HW_INFO)
 
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
+ * struct iommu_hwpt_invalidate_request_intel_vtd - Intel VT-d cache invalidation request
+ * @addr: The start address of the addresses to be invalidated.
+ * @npages: Number of contiguous 4K pages to be invalidated.
+ * @flags: Combination of enum iommu_hwpt_intel_vtd_invalidate_flags
+ * @__reserved: Must be 0
+ *
+ * The Intel VT-d specific invalidation data for user-managed stage-1 cache
+ * invalidation under nested translation. Userspace uses this structure to
+ * tell host about the impacted caches after modifying the stage-1 page table.
+ *
+ * Invalidating all the caches related to the hw_pagetable by setting
+ * @addr==0 and @npages==__u64(-1).
+ */
+struct iommu_hwpt_invalidate_request_intel_vtd {
+	__u64 addr;
+	__u64 npages;
+	__u32 flags;
+	__u32 __reserved;
+};
+
+/**
+ * struct iommu_hwpt_invalidate_intel_vtd - Intel VT-d cache invalidation info
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
+struct iommu_hwpt_invalidate_intel_vtd {
+	__u32 flags;
+	__u32 entry_size;
+	__u64 entry_nr_uptr;
+	__u64 inv_data_uptr;
+};
+
 /**
  * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
  * @size: sizeof(struct iommu_hwpt_invalidate)
@@ -520,6 +577,8 @@ struct iommu_hw_info {
  * +==============================+========================================+
  * | @hwpt_type                   |     Data structure in @data_uptr       |
  * +------------------------------+----------------------------------------+
+ * | IOMMU_HWPT_TYPE_VTD_S1       | struct iommu_hwpt_invalidate_intel_vtd |
+ * +------------------------------+----------------------------------------+
  */
 struct iommu_hwpt_invalidate {
 	__u32 size;
-- 
2.34.1

