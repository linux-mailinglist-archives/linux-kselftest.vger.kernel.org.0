Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF34B6FF4C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 16:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238666AbjEKOnA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 10:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238084AbjEKOmd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 10:42:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636153AA7;
        Thu, 11 May 2023 07:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683815933; x=1715351933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P3Z9fChHliVhZ3K/FQvxa8gf6rEJaR17QbcaA/Ou5nQ=;
  b=E6MDvM3c53xDpLFWtJ9sWgLMo2jn+QH8HfD1k9iyv6QVIaMpe9n+SBrp
   nSJvlxiX0GD4GOqX7b/nfiszjjeaWc1qtbudMN9GJzW3H8/85nJjXmXlQ
   fLvf06QLb5+kXgiYWkYMwK8sueywv85v0esFfs2Xv1EXo7GmpQLwgqorY
   BLxlu5ltq0DP+3wQIflpmEnmG28tl4lDqEjRMX1U6Xja2s+6WqQrs1sSx
   uT3aDVvm9hmDkh34o+SUaAxsMSLQmVIl9NHneH4IiUW0k/ArNSgSFbR/D
   r8miESpVpKFaE2jQ6l6PIdmgh5WuUWoAWuJowxYSvWJCopSDj+XJ+4N8o
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="339812925"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="339812925"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 07:38:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="730382626"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="730382626"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga008.jf.intel.com with ESMTP; 11 May 2023 07:38:50 -0700
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
Subject: [PATCH v2 07/11] iommufd: Add IOMMU_HWPT_INVALIDATE
Date:   Thu, 11 May 2023 07:38:40 -0700
Message-Id: <20230511143844.22693-8-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511143844.22693-1-yi.l.liu@intel.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In nested translation, the stage-1 page table is user-managed and used
by IOMMU hardware, so update of any present page table entry in the stage-1
page table should be followed with an IOTLB invalidation.

This adds IOMMU_HWPT_INVALIDATE for IOTLB invalidation.

Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c    | 45 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  9 +++++
 drivers/iommu/iommufd/main.c            |  3 ++
 include/uapi/linux/iommufd.h            | 26 ++++++++++++++
 4 files changed, 83 insertions(+)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index e84270eb6e49..8206367b8d83 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -300,3 +300,48 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(&idev->obj);
 	return rc;
 }
+
+int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_hwpt_invalidate *cmd = ucmd->cmd;
+	struct iommufd_hw_pagetable *hwpt;
+	u32 user_data_len, klen;
+	u64 user_ptr;
+	int rc = 0;
+
+	if (!cmd->data_len || cmd->__reserved)
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
+	klen = hwpt->domain->ops->cache_invalidate_user_data_len;
+	if (!hwpt->domain->ops->cache_invalidate_user || !klen) {
+		rc = -EOPNOTSUPP;
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
+	rc = hwpt->domain->ops->cache_invalidate_user(hwpt->domain, cmd);
+out_put_hwpt:
+	iommufd_put_object(&hwpt->obj);
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 9fe807e0aed6..1f9f48e45e05 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -268,6 +268,7 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev);
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 void iommufd_hw_pagetable_abort(struct iommufd_object *obj);
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd);
+int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd);
 
 static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
 					    struct iommufd_hw_pagetable *hwpt)
@@ -279,6 +280,14 @@ static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
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
index ac81403ba78e..d80c312f4ebe 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -270,6 +270,7 @@ union ucmd_buffer {
 	struct iommu_destroy destroy;
 	struct iommu_hwpt_alloc hwpt;
 	struct iommu_hw_info info;
+	struct iommu_hwpt_invalidate cache;
 	struct iommu_ioas_alloc alloc;
 	struct iommu_ioas_allow_iovas allow_iovas;
 	struct iommu_ioas_copy ioas_copy;
@@ -305,6 +306,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 data_uptr),
 	IOCTL_OP(IOMMU_DEVICE_GET_HW_INFO, iommufd_device_get_hw_info,
 		 struct iommu_hw_info, __reserved),
+	IOCTL_OP(IOMMU_HWPT_INVALIDATE, iommufd_hwpt_invalidate,
+		 struct iommu_hwpt_invalidate, data_uptr),
 	IOCTL_OP(IOMMU_IOAS_ALLOC, iommufd_ioas_alloc_ioctl,
 		 struct iommu_ioas_alloc, out_ioas_id),
 	IOCTL_OP(IOMMU_IOAS_ALLOW_IOVAS, iommufd_ioas_allow_iovas,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 699e735828db..6b82ef6d268b 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -47,6 +47,7 @@ enum {
 	IOMMUFD_CMD_VFIO_IOAS,
 	IOMMUFD_CMD_HWPT_ALLOC,
 	IOMMUFD_CMD_DEVICE_GET_HW_INFO,
+	IOMMUFD_CMD_HWPT_INVALIDATE,
 };
 
 /**
@@ -444,4 +445,29 @@ struct iommu_hw_info {
 	__u32 __reserved;
 };
 #define IOMMU_DEVICE_GET_HW_INFO _IO(IOMMUFD_TYPE, IOMMUFD_CMD_DEVICE_GET_HW_INFO)
+
+/**
+ * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
+ * @size: sizeof(struct iommu_hwpt_invalidate)
+ * @hwpt_id: HWPT ID of target hardware page table for the invalidation
+ * @data_len: Length of the type specific data
+ * @__reserved: Must be 0
+ * @data_uptr: User pointer to the type specific data
+ *
+ * Invalidate the iommu cache for user-managed page table. Modifications
+ * on user-managed page table should be followed with this operation to
+ * sync the IOTLB. The data in @data_uptr differs per the hwpt type.
+ *
+ * +==============================+========================================+
+ * | @hwpt_type                   |     Data structure in @data_uptr       |
+ * +------------------------------+----------------------------------------+
+ */
+struct iommu_hwpt_invalidate {
+	__u32 size;
+	__u32 hwpt_id;
+	__u32 data_len;
+	__u32 __reserved;
+	__aligned_u64 data_uptr;
+};
+#define IOMMU_HWPT_INVALIDATE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_INVALIDATE)
 #endif
-- 
2.34.1

