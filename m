Return-Path: <linux-kselftest+bounces-244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE827EF361
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 14:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BCE0B20B1A
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 13:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D78531A92;
	Fri, 17 Nov 2023 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LrRUbDWK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4FAD52;
	Fri, 17 Nov 2023 05:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700226443; x=1731762443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Wo9y1JQIbLR8wVw2lV1MCg+VVnAFhtNKN38CjSbjfo=;
  b=LrRUbDWKWtlwCQp+2miXUvX3w0feOzUCvzaamrtiuEWcnX23Cs+tMIo3
   HE5X0Y0lmoEdiii7t2YDFB4hrCp4k3nbrKS9ng8ZsyqATCbFxjB5CCkdy
   OSdObPW0OEntFR8XYTNAncE1HtBSdyMw+uWGUEF0L5m5eyP9JyFelDxQE
   qUHN2zCeXK2NkjX3yWK22epM5MZ1Sh2N7/X1bDIJc7NGNX/i2U9P3JkKB
   SSE31lYjD6rXxaXpVY+Z+COggyVDq6PqLgR7mryzD7pL6FisvnI6up5lL
   y+fWFedQ2qMiqTaz5Fl1I5bKPP+j991/F3Kxv5ctP6b0Ss3rG0rARXN7A
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="388446378"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="388446378"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 05:07:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="836072054"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="836072054"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 17 Nov 2023 05:07:22 -0800
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
	yan.y.zhao@intel.com
Subject: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Date: Fri, 17 Nov 2023 05:07:13 -0800
Message-Id: <20231117130717.19875-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117130717.19875-1-yi.l.liu@intel.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
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

Check cache_invalidate_user op in the iommufd_hw_pagetable_alloc_nested,
since all nested domains need that.

Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c    | 35 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  9 +++++++
 drivers/iommu/iommufd/main.c            |  3 +++
 include/uapi/linux/iommufd.h            | 35 +++++++++++++++++++++++++
 4 files changed, 82 insertions(+)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 2abbeafdbd22..367459d92f69 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -238,6 +238,11 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 		rc = -EINVAL;
 		goto out_abort;
 	}
+	/* Driver is buggy by missing cache_invalidate_user in domain_ops */
+	if (WARN_ON_ONCE(!hwpt->domain->ops->cache_invalidate_user)) {
+		rc = -EINVAL;
+		goto out_abort;
+	}
 	return hwpt_nested;
 
 out_abort:
@@ -370,4 +375,34 @@ int iommufd_hwpt_get_dirty_bitmap(struct iommufd_ucmd *ucmd)
 
 	iommufd_put_object(&hwpt_paging->common.obj);
 	return rc;
+};
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
+	int rc = 0;
+
+	if (cmd->req_type == IOMMU_HWPT_DATA_NONE)
+		return -EINVAL;
+	if (!cmd->reqs_uptr || !cmd->req_len || !cmd->req_num)
+		return -EINVAL;
+
+	hwpt = iommufd_hw_pagetable_get_nested(ucmd, cmd->hwpt_id);
+	if (IS_ERR(hwpt))
+		return PTR_ERR(hwpt);
+
+	rc = hwpt->domain->ops->cache_invalidate_user(hwpt->domain, &data_array,
+						      &cmd->out_driver_error_code);
+	cmd->req_num = data_array.entry_num;
+	if (iommufd_ucmd_respond(ucmd, sizeof(*cmd)))
+		return -EFAULT;
+	iommufd_put_object(&hwpt->obj);
+	return rc;
 }
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index a74cfefffbc6..160521800d9b 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -301,6 +301,7 @@ void iommufd_hwpt_paging_abort(struct iommufd_object *obj);
 void iommufd_hwpt_nested_destroy(struct iommufd_object *obj);
 void iommufd_hwpt_nested_abort(struct iommufd_object *obj);
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd);
+int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd);
 
 static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
 					    struct iommufd_hw_pagetable *hwpt)
@@ -318,6 +319,14 @@ static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
 	refcount_dec(&hwpt->obj.users);
 }
 
+static inline struct iommufd_hw_pagetable *
+iommufd_hw_pagetable_get_nested(struct iommufd_ucmd *ucmd, u32 id)
+{
+	return container_of(iommufd_get_object(ucmd->ictx, id,
+					       IOMMUFD_OBJ_HWPT_NESTED),
+			    struct iommufd_hw_pagetable, obj);
+}
+
 struct iommufd_group {
 	struct kref ref;
 	struct mutex lock;
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 45b9d40773b1..6edef860f91c 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -309,6 +309,7 @@ union ucmd_buffer {
 	struct iommu_hwpt_alloc hwpt;
 	struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap;
 	struct iommu_hwpt_set_dirty_tracking set_dirty_tracking;
+	struct iommu_hwpt_invalidate cache;
 	struct iommu_ioas_alloc alloc;
 	struct iommu_ioas_allow_iovas allow_iovas;
 	struct iommu_ioas_copy ioas_copy;
@@ -348,6 +349,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 struct iommu_hwpt_get_dirty_bitmap, data),
 	IOCTL_OP(IOMMU_HWPT_SET_DIRTY_TRACKING, iommufd_hwpt_set_dirty_tracking,
 		 struct iommu_hwpt_set_dirty_tracking, __reserved),
+	IOCTL_OP(IOMMU_HWPT_INVALIDATE, iommufd_hwpt_invalidate,
+		 struct iommu_hwpt_invalidate, out_driver_error_code),
 	IOCTL_OP(IOMMU_IOAS_ALLOC, iommufd_ioas_alloc_ioctl,
 		 struct iommu_ioas_alloc, out_ioas_id),
 	IOCTL_OP(IOMMU_IOAS_ALLOW_IOVAS, iommufd_ioas_allow_iovas,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 0b2bc6252e2c..7f92cecc87d7 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -49,6 +49,7 @@ enum {
 	IOMMUFD_CMD_GET_HW_INFO,
 	IOMMUFD_CMD_HWPT_SET_DIRTY_TRACKING,
 	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP,
+	IOMMUFD_CMD_HWPT_INVALIDATE,
 };
 
 /**
@@ -613,4 +614,38 @@ struct iommu_hwpt_get_dirty_bitmap {
 #define IOMMU_HWPT_GET_DIRTY_BITMAP _IO(IOMMUFD_TYPE, \
 					IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP)
 
+/**
+ * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
+ * @size: sizeof(struct iommu_hwpt_invalidate)
+ * @hwpt_id: HWPT ID of a nested HWPT for cache invalidation
+ * @reqs_uptr: User pointer to an array having @req_num of cache invalidation
+ *             requests. The request entries in the array are of fixed width
+ *             @req_len, and contain a user data structure for invalidation
+ *             request specific to the given hardware page table.
+ * @req_type: One of enum iommu_hwpt_data_type, defining the data type of all
+ *            the entries in the invalidation request array. It should suit
+ *            with the data_type passed per the allocation of the hwpt pointed
+ *            by @hwpt_id.
+ * @req_len: Length (in bytes) of a request entry in the request array
+ * @req_num: Input the number of cache invalidation requests in the array.
+ *           Output the number of requests successfully handled by kernel.
+ * @out_driver_error_code: Report a driver speicifc error code upon failure.
+ *                         It's optional, driver has a choice to fill it or
+ *                         not.
+ *
+ * Invalidate the iommu cache for user-managed page table. Modifications on a
+ * user-managed page table should be followed by this operation to sync cache.
+ * Each ioctl can support one or more cache invalidation requests in the array
+ * that has a total size of @req_len * @req_num.
+ */
+struct iommu_hwpt_invalidate {
+	__u32 size;
+	__u32 hwpt_id;
+	__aligned_u64 reqs_uptr;
+	__u32 req_type;
+	__u32 req_len;
+	__u32 req_num;
+	__u32 out_driver_error_code;
+};
+#define IOMMU_HWPT_INVALIDATE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_INVALIDATE)
 #endif
-- 
2.34.1


