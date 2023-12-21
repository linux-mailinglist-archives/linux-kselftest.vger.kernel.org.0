Return-Path: <linux-kselftest+bounces-2303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5614481BB09
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 16:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FB43B22D76
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 15:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C44F5820B;
	Thu, 21 Dec 2023 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="km4fJOE4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657B153A10;
	Thu, 21 Dec 2023 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703173194; x=1734709194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b1UI5G06mRXLChsOzN57nWe8J+AMhEsuLLIPBNMd0H8=;
  b=km4fJOE4ApvMH2anujv1IDOKLRjVEqvYfS4NS8g8I/XW4Y1JQ0pRBL0P
   2k3C/3iPCjBr3HMVYA3kEJ4FUumFVpoIGYPSD0lzEYIB2HoSLN/er1UBT
   WWPZifnQoyTUj18dG1ecQLnpuClU0T3TFIrXu9lQiOLim1VyPEDe/9u43
   Kdymkm/cWU0350u4BR/vmKazf/R6JtbFf0qLBB7JnBhk3UC7LbLKKTUry
   n8BWCIwKq+P3y6KcBtp4T8Kvi7f0I05gcZyctlF38oz6FSTBCTD9a+NVe
   z8lAKhjxpW5NwIooK7dyi+C084zgHzcpeLfGq6hSoCR7aOQnMOXUqkLYp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="393155497"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="393155497"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 07:39:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="949957238"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="949957238"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga005.jf.intel.com with ESMTP; 21 Dec 2023 07:39:51 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com
Cc: cohuck@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	mjrosato@linux.ibm.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	yi.y.sun@linux.intel.com,
	peterx@redhat.com,
	jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com,
	lulu@redhat.com,
	suravee.suthikulpanit@amd.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com,
	xin.zeng@intel.com,
	yan.y.zhao@intel.com,
	j.granados@samsung.com
Subject: [PATCH v7 2/9] iommufd: Add IOMMU_HWPT_INVALIDATE
Date: Thu, 21 Dec 2023 07:39:41 -0800
Message-Id: <20231221153948.119007-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221153948.119007-1-yi.l.liu@intel.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In nested translation, the stage-1 page table is user-managed but cached
by the IOMMU hardware, so an update on present page table entries in the
stage-1 page table should be followed with a cache invalidation.

Add an IOMMU_HWPT_INVALIDATE ioctl to support such a cache invalidation.
It takes hwpt_id to specify the iommu_domain, and a multi-entry array to
support multiple invalidation requests in one ioctl.

This also adds the cache invalidation data structure for Intel VT-d to have
a complete story. Intel iommu driver support will be added in later patch.

Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c    |  36 +++++++++
 drivers/iommu/iommufd/iommufd_private.h |  10 +++
 drivers/iommu/iommufd/main.c            |   3 +
 include/uapi/linux/iommufd.h            | 100 ++++++++++++++++++++++++
 4 files changed, 149 insertions(+)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index cbb5df0a6c32..6389a9809c7b 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -371,3 +371,39 @@ int iommufd_hwpt_get_dirty_bitmap(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &hwpt_paging->common.obj);
 	return rc;
 }
+
+int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_hwpt_invalidate *cmd = ucmd->cmd;
+	struct iommu_user_data_array data_array = {
+		.type = cmd->req_type,
+		.uptr = u64_to_user_ptr(cmd->reqs_uptr),
+		.entry_len = cmd->req_len,
+		.entry_num = cmd->req_num,
+	};
+	struct iommufd_hw_pagetable *hwpt;
+	u32 done_num = 0;
+	int rc;
+
+	if (cmd->req_num && (!cmd->reqs_uptr || !cmd->req_len)) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	hwpt = iommufd_get_hwpt_nested(ucmd, cmd->hwpt_id);
+	if (IS_ERR(hwpt)) {
+		rc = PTR_ERR(hwpt);
+		goto out;
+	}
+
+	rc = hwpt->domain->ops->cache_invalidate_user(hwpt->domain,
+						      &data_array);
+	done_num = data_array.entry_num;
+
+	iommufd_put_object(ucmd->ictx, &hwpt->obj);
+out:
+	cmd->req_num = done_num;
+	if (iommufd_ucmd_respond(ucmd, sizeof(*cmd)))
+		return -EFAULT;
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index abae041e256f..991f864d1f9b 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -328,6 +328,15 @@ iommufd_get_hwpt_paging(struct iommufd_ucmd *ucmd, u32 id)
 					       IOMMUFD_OBJ_HWPT_PAGING),
 			    struct iommufd_hwpt_paging, common.obj);
 }
+
+static inline struct iommufd_hw_pagetable *
+iommufd_get_hwpt_nested(struct iommufd_ucmd *ucmd, u32 id)
+{
+	return container_of(iommufd_get_object(ucmd->ictx, id,
+					       IOMMUFD_OBJ_HWPT_NESTED),
+			    struct iommufd_hw_pagetable, obj);
+}
+
 int iommufd_hwpt_set_dirty_tracking(struct iommufd_ucmd *ucmd);
 int iommufd_hwpt_get_dirty_bitmap(struct iommufd_ucmd *ucmd);
 
@@ -345,6 +354,7 @@ void iommufd_hwpt_paging_abort(struct iommufd_object *obj);
 void iommufd_hwpt_nested_destroy(struct iommufd_object *obj);
 void iommufd_hwpt_nested_abort(struct iommufd_object *obj);
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd);
+int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd);
 
 static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
 					    struct iommufd_hw_pagetable *hwpt)
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index c9091e46d208..e4f6dfc3474f 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -323,6 +323,7 @@ union ucmd_buffer {
 	struct iommu_hwpt_alloc hwpt;
 	struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap;
 	struct iommu_hwpt_set_dirty_tracking set_dirty_tracking;
+	struct iommu_hwpt_invalidate cache;
 	struct iommu_ioas_alloc alloc;
 	struct iommu_ioas_allow_iovas allow_iovas;
 	struct iommu_ioas_copy ioas_copy;
@@ -362,6 +363,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 struct iommu_hwpt_get_dirty_bitmap, data),
 	IOCTL_OP(IOMMU_HWPT_SET_DIRTY_TRACKING, iommufd_hwpt_set_dirty_tracking,
 		 struct iommu_hwpt_set_dirty_tracking, __reserved),
+	IOCTL_OP(IOMMU_HWPT_INVALIDATE, iommufd_hwpt_invalidate,
+		 struct iommu_hwpt_invalidate, __reserved),
 	IOCTL_OP(IOMMU_IOAS_ALLOC, iommufd_ioas_alloc_ioctl,
 		 struct iommu_ioas_alloc, out_ioas_id),
 	IOCTL_OP(IOMMU_IOAS_ALLOW_IOVAS, iommufd_ioas_allow_iovas,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 0b2bc6252e2c..e501ef4f7ec1 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -49,6 +49,7 @@ enum {
 	IOMMUFD_CMD_GET_HW_INFO,
 	IOMMUFD_CMD_HWPT_SET_DIRTY_TRACKING,
 	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP,
+	IOMMUFD_CMD_HWPT_INVALIDATE,
 };
 
 /**
@@ -613,4 +614,103 @@ struct iommu_hwpt_get_dirty_bitmap {
 #define IOMMU_HWPT_GET_DIRTY_BITMAP _IO(IOMMUFD_TYPE, \
 					IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP)
 
+/**
+ * enum iommu_hwpt_invalidate_data_type - IOMMU HWPT Cache Invalidation
+ *                                        Data Type
+ * @IOMMU_HWPT_INVALIDATE_DATA_VTD_S1: Invalidation data for VTD_S1
+ */
+enum iommu_hwpt_invalidate_data_type {
+	IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
+};
+
+/**
+ * enum iommu_hwpt_vtd_s1_invalidate_flags - Flags for Intel VT-d
+ *                                           stage-1 cache invalidation
+ * @IOMMU_VTD_INV_FLAGS_LEAF: The LEAF flag indicates whether only the
+ *                            leaf PTE caching needs to be invalidated
+ *                            and other paging structure caches can be
+ *                            preserved.
+ */
+enum iommu_hwpt_vtd_s1_invalidate_flags {
+	IOMMU_VTD_INV_FLAGS_LEAF = 1 << 0,
+};
+
+/**
+ * enum iommu_hwpt_vtd_s1_invalidate_error - Result of invalidation
+ * @IOMMU_HWPT_INVALIDATE_VTD_S1_ICE: Invalidation Completion Error, details
+ *                                     refer to 11.4.7.1 Fault Status Register
+ *                                     of VT-d specification.
+ * @IOMMU_HWPT_INVALIDATE_VTD_S1_ITE: Invalidation Time-out Error, details
+ *                                     refer to 11.4.7.1 Fault Status Register
+ *                                     of VT-d specification.
+ */
+enum iommu_hwpt_vtd_s1_invalidate_error {
+	IOMMU_HWPT_INVALIDATE_VTD_S1_ICE = 1 << 0,
+	IOMMU_HWPT_INVALIDATE_VTD_S1_ITE = 1 << 1,
+};
+
+/**
+ * struct iommu_hwpt_vtd_s1_invalidate - Intel VT-d cache invalidation
+ *                                       (IOMMU_HWPT_INVALIDATE_DATA_VTD_S1)
+ * @addr: The start address of the addresses to be invalidated. It needs
+ *        to be 4KB aligned.
+ * @npages: Number of contiguous 4K pages to be invalidated.
+ * @flags: Combination of enum iommu_hwpt_vtd_s1_invalidate_flags
+ * @inv_error: One of enum iommu_hwpt_vtd_s1_invalidate_error
+ *
+ * The Intel VT-d specific invalidation data for user-managed stage-1 cache
+ * invalidation in nested translation. Userspace uses this structure to
+ * tell the impacted cache scope after modifying the stage-1 page table.
+ *
+ * Invalidating all the caches related to the page table by setting @addr
+ * to be 0 and @npages to be U64_MAX.
+ *
+ * @inv_error is meaningful only if the request is handled by kernel. This
+ * can be known by checking struct iommu_hwpt_invalidate::req_num output.
+ * @inv_error only covers the errors detected by hardware after submitting the
+ * invalidation. The software detected errors would go through the normal
+ * ioctl errno.
+ */
+struct iommu_hwpt_vtd_s1_invalidate {
+	__aligned_u64 addr;
+	__aligned_u64 npages;
+	__u32 flags;
+	__u32 inv_error;
+};
+
+/**
+ * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
+ * @size: sizeof(struct iommu_hwpt_invalidate)
+ * @hwpt_id: HWPT ID of a nested HWPT for cache invalidation
+ * @reqs_uptr: User pointer to an array having @req_num of cache invalidation
+ *             requests. The request entries in the array are of fixed width
+ *             @req_len, and contain a user data structure for invalidation
+ *             request specific to the given hardware page table.
+ * @req_type: One of enum iommu_hwpt_invalidate_data_type, defining the data
+ *            type of all the entries in the invalidation request array. It
+ *            should be a type supported by the hwpt pointed by @hwpt_id.
+ * @req_len: Length (in bytes) of a request entry in the request array
+ * @req_num: Input the number of cache invalidation requests in the array.
+ *           Output the number of requests successfully handled by kernel.
+ * @__reserved: Must be 0.
+ *
+ * Invalidate the iommu cache for user-managed page table. Modifications on a
+ * user-managed page table should be followed by this operation to sync cache.
+ * Each ioctl can support one or more cache invalidation requests in the array
+ * that has a total size of @req_len * @req_num.
+ *
+ * An empty invalidation request array by setting @req_num==0 is allowed, and
+ * @req_len and @reqs_uptr would be ignored in this case. This can be used to
+ * check if the given @req_type is supported or not by kernel.
+ */
+struct iommu_hwpt_invalidate {
+	__u32 size;
+	__u32 hwpt_id;
+	__aligned_u64 reqs_uptr;
+	__u32 req_type;
+	__u32 req_len;
+	__u32 req_num;
+	__u32 __reserved;
+};
+#define IOMMU_HWPT_INVALIDATE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_INVALIDATE)
 #endif
-- 
2.34.1


