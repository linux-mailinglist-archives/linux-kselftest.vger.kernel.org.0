Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7926B1D6B
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 09:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjCIIJq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 03:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjCIIJk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 03:09:40 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C6B7F00A;
        Thu,  9 Mar 2023 00:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678349379; x=1709885379;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j/S4apaXyrmximWwHCUE+Zj/DjMfF+CJS1FfehESmPI=;
  b=EdI+WVFtTEflbRP3undErShgH9qHqhO2H76ulix3W5s0kjArTpKm8B33
   1wzxqeNwly2GadETrupWxbhGK5uaj4pq3C6x8zSQCyEEDhHv70oNOXqgg
   +Mwvpx2mUYxzfT27dohJ5CX53fSPCa8zRM8vSOp4uwwLNxiB3i/GH/aNW
   +DRGI/yUA+nNlCBMhrfAXphIitziNhPTSmJw7KBbqiddgt4yZ/rnqHAHh
   DWzECE4t50b3mGMzRZYQ2m/yAZO/qmxwyEVdNCvnO9a5I6ve8ynqtnwgs
   9Y8cmFRLfex3rHYJbYqE6CbOg325Jzg16eFscnwzZexmKCJqjca1u5mZE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364023116"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364023116"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787471389"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787471389"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2023 00:09:30 -0800
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
Subject: [PATCH 07/12] iommufd: Add IOMMU_HWPT_INVALIDATE
Date:   Thu,  9 Mar 2023 00:09:05 -0800
Message-Id: <20230309080910.607396-8-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309080910.607396-1-yi.l.liu@intel.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
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

In nested translation, the stage-1 page table is user-managed and used
by IOMMU hardware, so destroying mappings in the stage-1 page table should
be followed with an IOTLB invalidation.

This adds IOMMU_HWPT_INVALIDATE for IOTLB invalidation.

Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c    | 56 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  9 ++++
 drivers/iommu/iommufd/main.c            |  3 ++
 include/uapi/linux/iommufd.h            | 27 ++++++++++++
 4 files changed, 95 insertions(+)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 64e7cf7142e1..67facca98de1 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -284,3 +284,59 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(&idev->obj);
 	return rc;
 }
+
+/*
+ * size of page table type specific invalidate_info, indexed by
+ * enum iommu_hwpt_type.
+ */
+static const size_t iommufd_hwpt_invalidate_info_size[] = {};
+
+int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_hwpt_invalidate *cmd = ucmd->cmd;
+	struct iommufd_hw_pagetable *hwpt;
+	u64 user_ptr;
+	u32 user_data_len, klen;
+	int rc = 0;
+
+	/*
+	 * For a user-managed HWPT, type should not be IOMMU_HWPT_TYPE_DEFAULT.
+	 * data_len should not exceed the size of iommufd_invalidate_buffer.
+	 */
+	if (cmd->data_type == IOMMU_HWPT_TYPE_DEFAULT || !cmd->data_len ||
+	    cmd->data_type >= ARRAY_SIZE(iommufd_hwpt_invalidate_info_size))
+		return -EOPNOTSUPP;
+
+	hwpt = iommufd_get_hwpt(ucmd, cmd->hwpt_id);
+	if (IS_ERR(hwpt))
+		return PTR_ERR(hwpt);
+
+	/* Do not allow any kernel-managed hw_pagetable */
+	if (!hwpt->parent) {
+		rc = -EINVAL;
+		goto out_put_hwpt;
+	}
+
+	klen = iommufd_hwpt_invalidate_info_size[cmd->data_type];
+	if (!klen) {
+		rc = -EINVAL;
+		goto out_put_hwpt;
+	}
+
+	/*
+	 * Copy the needed fields before reusing the ucmd buffer, this
+	 * avoids memory allocation in this path.
+	 */
+	user_ptr = cmd->data_uptr;
+	user_data_len = cmd->data_len;
+
+	rc = copy_struct_from_user(cmd, klen,
+				   u64_to_user_ptr(user_ptr), user_data_len);
+	if (rc)
+		goto out_put_hwpt;
+
+	hwpt->domain->ops->cache_invalidate_user(hwpt->domain, cmd);
+out_put_hwpt:
+	iommufd_put_object(&hwpt->obj);
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 182c074eecdc..d879264d1acf 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -265,6 +265,7 @@ struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_detach(struct iommufd_device *idev);
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd);
+int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd);
 
 static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
 					    struct iommufd_hw_pagetable *hwpt)
@@ -276,6 +277,14 @@ static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
 		refcount_dec(&hwpt->obj.users);
 }
 
+static inline struct iommufd_hw_pagetable *
+iommufd_get_hwpt(struct iommufd_ucmd *ucmd, u32 id)
+{
+	return container_of(iommufd_get_object(ucmd->ictx, id,
+					       IOMMUFD_OBJ_HW_PAGETABLE),
+			    struct iommufd_hw_pagetable, obj);
+}
+
 struct iommufd_group {
 	struct kref ref;
 	struct mutex lock;
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 7ab1e2c638a1..2cf45f65b637 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -263,6 +263,7 @@ union ucmd_buffer {
 	struct iommu_destroy destroy;
 	struct iommu_hwpt_alloc hwpt;
 	struct iommu_hw_info info;
+	struct iommu_hwpt_invalidate cache;
 	struct iommu_ioas_alloc alloc;
 	struct iommu_ioas_allow_iovas allow_iovas;
 	struct iommu_ioas_copy ioas_copy;
@@ -298,6 +299,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 data_uptr),
 	IOCTL_OP(IOMMU_DEVICE_GET_HW_INFO, iommufd_device_get_hw_info,
 		 struct iommu_hw_info, __reserved),
+	IOCTL_OP(IOMMU_HWPT_INVALIDATE, iommufd_hwpt_invalidate,
+		 struct iommu_hwpt_invalidate, data_uptr),
 	IOCTL_OP(IOMMU_IOAS_ALLOC, iommufd_ioas_alloc_ioctl,
 		 struct iommu_ioas_alloc, out_ioas_id),
 	IOCTL_OP(IOMMU_IOAS_ALLOW_IOVAS, iommufd_ioas_allow_iovas,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 48781ff40a37..d0962c41f8d6 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -47,6 +47,7 @@ enum {
 	IOMMUFD_CMD_VFIO_IOAS,
 	IOMMUFD_CMD_HWPT_ALLOC,
 	IOMMUFD_CMD_DEVICE_GET_HW_INFO,
+	IOMMUFD_CMD_HWPT_INVALIDATE,
 };
 
 /**
@@ -447,4 +448,30 @@ struct iommu_hw_info {
 	__u32 __reserved;
 };
 #define IOMMU_DEVICE_GET_HW_INFO _IO(IOMMUFD_TYPE, IOMMUFD_CMD_DEVICE_GET_HW_INFO)
+
+/**
+ * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
+ * @size: sizeof(struct iommu_hwpt_invalidate)
+ * @hwpt_id: HWPT ID of target hardware page table for the invalidation
+ * @data_type: One of enum iommu_hwpt_type
+ * @data_len: Length of the type specific data
+ * @data_uptr: User pointer to the type specific data
+ *
+ * Invalidate the iommu cache for user-managed page table. Modifications
+ * on user-managed page table should be followed with this operation to
+ * sync the IOTLB. This is only needed by user-managed hw_pagetables, so
+ * the @data_type should never be IOMMU_HWPT_TYPE_DEFAULT.
+ *
+ * +==============================+========================================+
+ * | @data_type                   |     Data structure in @data_uptr       |
+ * +------------------------------+----------------------------------------+
+ */
+struct iommu_hwpt_invalidate {
+	__u32 size;
+	__u32 hwpt_id;
+	__u32 data_type;
+	__u32 data_len;
+	__aligned_u64 data_uptr;
+};
+#define IOMMU_HWPT_INVALIDATE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_INVALIDATE)
 #endif
-- 
2.34.1

