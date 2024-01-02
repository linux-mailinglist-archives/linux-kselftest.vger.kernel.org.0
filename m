Return-Path: <linux-kselftest+bounces-2571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD39821DD6
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 15:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FF80B21F33
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 14:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9378614A9C;
	Tue,  2 Jan 2024 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLfGvQ1o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE26C13AC5;
	Tue,  2 Jan 2024 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704206321; x=1735742321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cNouUsps1r+dmbqyfgc6rMPqSKe8Zay6ScVLkagmhB4=;
  b=mLfGvQ1oGLyRsScjnIlEtOapSxNOYog+kRTnWCF7D5O1vjMH9wVwjMlo
   NSSEfRoz8HrguRLDUe8q5wC5Togkbx9B6lRhVS6bky1OSVFmwwUD5tLIB
   1pUszp+/zigjCOLMM8fsxrc93Rkp5GLO4L1c/V0WgaJSRCrhV/lMBUdL6
   pgG9HuyfUFga1w5Cs13tDa/rX8yNnx8kZhCZf0HE4YirkODYA1qoNTRGE
   vFgKbmUwITJkhqagdznIPBUWkTIyQjeeA3EfpskkBFGY/VnqMk5kgHHSR
   6oCURWDcYAJ9ed2v5xcuZyyEbDsGQ4dr0xIUszQnwxFMm9Kis5o6SKNk3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="10270425"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="10270425"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 06:38:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="923234264"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="923234264"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jan 2024 06:38:39 -0800
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
Subject: [PATCH v10 02/10] iommufd: Add IOMMU_HWPT_INVALIDATE
Date: Tue,  2 Jan 2024 06:38:26 -0800
Message-Id: <20240102143834.146165-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102143834.146165-1-yi.l.liu@intel.com>
References: <20240102143834.146165-1-yi.l.liu@intel.com>
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
support multiple invalidation data in one ioctl.

enum iommu_hwpt_invalidate_data_type is defined to tag the data type of
the entries in the multi-entry array.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c    | 41 +++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h | 10 ++++++
 drivers/iommu/iommufd/main.c            |  3 ++
 include/uapi/linux/iommufd.h            | 43 +++++++++++++++++++++++++
 4 files changed, 97 insertions(+)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index cbb5df0a6c32..4e8711f19f72 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -371,3 +371,44 @@ int iommufd_hwpt_get_dirty_bitmap(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &hwpt_paging->common.obj);
 	return rc;
 }
+
+int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_hwpt_invalidate *cmd = ucmd->cmd;
+	struct iommu_user_data_array data_array = {
+		.type = cmd->data_type,
+		.uptr = u64_to_user_ptr(cmd->data_uptr),
+		.entry_len = cmd->entry_len,
+		.entry_num = cmd->entry_num,
+	};
+	struct iommufd_hw_pagetable *hwpt;
+	u32 done_num = 0;
+	int rc;
+
+	if (cmd->__reserved) {
+		rc = -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (cmd->entry_num && (!cmd->data_uptr || !cmd->entry_len)) {
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
+	cmd->entry_num = done_num;
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
index c9091e46d208..39b32932c61e 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -322,6 +322,7 @@ union ucmd_buffer {
 	struct iommu_hw_info info;
 	struct iommu_hwpt_alloc hwpt;
 	struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap;
+	struct iommu_hwpt_invalidate cache;
 	struct iommu_hwpt_set_dirty_tracking set_dirty_tracking;
 	struct iommu_ioas_alloc alloc;
 	struct iommu_ioas_allow_iovas allow_iovas;
@@ -360,6 +361,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_HWPT_GET_DIRTY_BITMAP, iommufd_hwpt_get_dirty_bitmap,
 		 struct iommu_hwpt_get_dirty_bitmap, data),
+	IOCTL_OP(IOMMU_HWPT_INVALIDATE, iommufd_hwpt_invalidate,
+		 struct iommu_hwpt_invalidate, __reserved),
 	IOCTL_OP(IOMMU_HWPT_SET_DIRTY_TRACKING, iommufd_hwpt_set_dirty_tracking,
 		 struct iommu_hwpt_set_dirty_tracking, __reserved),
 	IOCTL_OP(IOMMU_IOAS_ALLOC, iommufd_ioas_alloc_ioctl,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 0b2bc6252e2c..824560c50ec6 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -49,6 +49,7 @@ enum {
 	IOMMUFD_CMD_GET_HW_INFO,
 	IOMMUFD_CMD_HWPT_SET_DIRTY_TRACKING,
 	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP,
+	IOMMUFD_CMD_HWPT_INVALIDATE,
 };
 
 /**
@@ -613,4 +614,46 @@ struct iommu_hwpt_get_dirty_bitmap {
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
+ * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
+ * @size: sizeof(struct iommu_hwpt_invalidate)
+ * @hwpt_id: ID of a nested HWPT for cache invalidation
+ * @data_uptr: User pointer to an array of driver-specific cache invalidation
+ *             data.
+ * @data_type: One of enum iommu_hwpt_invalidate_data_type, defining the data
+ *             type of all the entries in the invalidation request array. It
+ *             should be a type supported by the hwpt pointed by @hwpt_id.
+ * @entry_len: Length (in bytes) of a request entry in the request array
+ * @entry_num: Input the number of cache invalidation requests in the array.
+ *             Output the number of requests successfully handled by kernel.
+ * @__reserved: Must be 0.
+ *
+ * Invalidate the iommu cache for user-managed page table. Modifications on a
+ * user-managed page table should be followed by this operation to sync cache.
+ * Each ioctl can support one or more cache invalidation requests in the array
+ * that has a total size of @entry_len * @entry_num.
+ *
+ * An empty invalidation request array by setting @entry_num==0 is allowed, and
+ * @entry_len and @data_uptr would be ignored in this case. This can be used to
+ * check if the given @data_type is supported or not by kernel.
+ */
+struct iommu_hwpt_invalidate {
+	__u32 size;
+	__u32 hwpt_id;
+	__aligned_u64 data_uptr;
+	__u32 data_type;
+	__u32 entry_len;
+	__u32 entry_num;
+	__u32 __reserved;
+};
+#define IOMMU_HWPT_INVALIDATE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_INVALIDATE)
 #endif
-- 
2.34.1


