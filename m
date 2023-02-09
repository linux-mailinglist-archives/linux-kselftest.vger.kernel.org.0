Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1B068FF4A
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 05:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjBIEfC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 23:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjBIEeA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 23:34:00 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61874ED1A;
        Wed,  8 Feb 2023 20:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675917173; x=1707453173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5M/kZqRgdz7DjKd5EA9KM6slqre8Qy9hIAk9VjeyYIM=;
  b=AwXsxu/uy7kYBfTosBT7Wr7a/17meIDG/nyWhn9NOOh2MZvsi5/0KL1P
   ZGoGAcPyHi1EaTHX2uF710X6Wi6CkS2X/3Y3aiNbfqQSsyWybSe4B/LPf
   FV+Xl9KjiH9JwGIMiQ6yZTiV1VwPjFXKBLcQWediO/L2rhT6GyVnq4/Dk
   zEskHJBxK02aqVyQi8Rz+jzHhLwfjkDB33GYUO7MysBeNqix/qrKm3uH9
   G4BaHdCrruFGeBnzajHk9xrLHZnNsaFT//qQN9M2l1XpqCl3gqLvs+s27
   IBGLCrigXLSivvbV7iqcQ7B4NOYjqs4RtNqjiqhWgdCWQCO5M0VFLx1SE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331298761"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="331298761"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:32:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669447563"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="669447563"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2023 20:32:14 -0800
From:   Yi Liu <yi.l.liu@intel.com>
To:     joro@8bytes.org, alex.williamson@redhat.com, jgg@nvidia.com,
        kevin.tian@intel.com, robin.murphy@arm.com
Cc:     cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        baolu.lu@linux.intel.com
Subject: [PATCH 09/17] iommufd: Add kernel-managed hw_pagetable allocation for userspace
Date:   Wed,  8 Feb 2023 20:31:45 -0800
Message-Id: <20230209043153.14964-10-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209043153.14964-1-yi.l.liu@intel.com>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
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

Today iommufd allocates the kernel-managed hw_pagetabe implicitly when
device is attached to an IOAS. This links the hw_pagetable to IOPT within
IOAS.

However, this is not the perfect way. It makes much sense to let userspace
explicitly request hw_pagtable allocation via iommufd. The reason is even
though the hw_pagetable is kernel-managed, the mappings are feed by
userspace. Also, this makes the lifecircle of kernel-managed hw_pagetable
more clear during usage. This is very important in the usage of nested
translation, in which the kernel-managed hw_pagetable would be used as the
stage-2 hw_pagetable. In such case, both stage-1 and stage-2 hw_pagetable
should be allocated by userspace to ensure the life-circle.

This adds an ioctl IOMMU_HWPT_ALLOC for the hw_pagetable allocation. For
kernel-managed hw_pagetable, userspace should provide an IOAS ID in the
allocation request.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          |  11 ++-
 drivers/iommu/iommufd/hw_pagetable.c    | 116 ++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  15 +++
 drivers/iommu/iommufd/main.c            |   3 +
 include/uapi/linux/iommufd.h            |  48 ++++++++++
 5 files changed, 191 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 71a8c4f1c4a9..dd7943ff02e4 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -146,8 +146,7 @@ static int iommufd_zero_fill_user(u64 ptr, int bytes)
 	return 0;
 }
 
-static struct device *
-iommufd_obj_dev(struct iommufd_object *obj)
+struct device *iommufd_obj_dev(struct iommufd_object *obj)
 {
 	struct device *dev = NULL;
 
@@ -160,6 +159,14 @@ iommufd_obj_dev(struct iommufd_object *obj)
 	return dev;
 }
 
+/*
+ * bitmaps of supported page table data types of hardware iommu,
+ * indexed by the members defined in enum iommu_device_data_type.
+ */
+const u64 iommufd_supported_pgtbl_types[] =  {
+	[IOMMU_DEVICE_DATA_INTEL_VTD] = BIT_ULL(IOMMU_PGTBL_DATA_NONE),
+};
+
 int iommufd_device_get_info(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_device_info *cmd = ucmd->cmd;
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index ee97d2f3cf43..998d01490a74 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -92,3 +92,119 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 {
 	return __iommufd_hw_pagetable_alloc(ictx, ioas, dev, NULL, NULL);
 }
+
+/*
+ * size of page table type specific data, indexed by
+ * enum iommu_pgtbl_data_type.
+ */
+static const size_t iommufd_hwpt_info_size[] = {
+	[IOMMU_PGTBL_DATA_NONE] = 0,
+};
+
+int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
+{
+	struct iommufd_hw_pagetable *hwpt;
+	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
+	struct iommufd_ctx *ictx = ucmd->ictx;
+	struct iommufd_object *pt_obj = NULL;
+	struct iommufd_ioas *ioas = NULL;
+	struct iommufd_object *dev_obj;
+	struct device *dev;
+	const struct iommu_ops *ops;
+	void *data = NULL;
+	u32 driver_type, klen;
+	int rc;
+
+	if (cmd->__reserved || cmd->flags)
+		return -EOPNOTSUPP;
+
+	dev_obj = iommufd_get_object(ucmd->ictx, cmd->dev_id,
+				     IOMMUFD_OBJ_ANY);
+	if (IS_ERR(dev_obj))
+		return PTR_ERR(dev_obj);
+
+	dev = iommufd_obj_dev(dev_obj);
+	if (!dev) {
+		rc = -EINVAL;
+		goto out_put_dev;
+	}
+
+	ops = dev_iommu_ops(dev);
+	if (!ops) {
+		rc = -EOPNOTSUPP;
+		goto out_put_dev;
+	}
+
+	driver_type = ops->driver_type;
+
+	/* data_type should be a supported type by the hardware */
+	if (!((1 << cmd->data_type) &
+			iommufd_supported_pgtbl_types[driver_type])) {
+		rc = -EINVAL;
+		goto out_put_dev;
+	}
+
+	pt_obj = iommufd_get_object(ictx, cmd->pt_id, IOMMUFD_OBJ_ANY);
+	if (IS_ERR(pt_obj)) {
+		rc = -EINVAL;
+		goto out_put_dev;
+	}
+
+	switch (pt_obj->type) {
+	case IOMMUFD_OBJ_IOAS:
+		ioas = container_of(pt_obj, struct iommufd_ioas, obj);
+		break;
+	default:
+		rc = -EINVAL;
+		goto out_put_pt;
+	}
+
+	klen = iommufd_hwpt_info_size[cmd->data_type];
+	if (klen) {
+		if (!cmd->data_len) {
+			rc = -EINVAL;
+			goto out_put_pt;
+		}
+
+		data = kzalloc(klen, GFP_KERNEL);
+		if (!data) {
+			rc = -ENOMEM;
+			goto out_put_pt;
+		}
+
+		rc = copy_struct_from_user(data, klen,
+					   u64_to_user_ptr(cmd->data_uptr),
+					   cmd->data_len);
+		if (rc)
+			goto out_free_data;
+	}
+
+	mutex_lock(&ioas->mutex);
+	hwpt = __iommufd_hw_pagetable_alloc(ictx, ioas, dev, NULL, data);
+	mutex_unlock(&ioas->mutex);
+	if (IS_ERR(hwpt)) {
+		rc = PTR_ERR(hwpt);
+		goto out_free_data;
+	}
+
+	cmd->out_hwpt_id = hwpt->obj.id;
+
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_destroy_hwpt;
+
+	kfree(data);
+	iommufd_object_finalize(ucmd->ictx, &hwpt->obj);
+	iommufd_put_object(pt_obj);
+	iommufd_put_object(dev_obj);
+	return 0;
+out_destroy_hwpt:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &hwpt->obj);
+out_free_data:
+	kfree(data);
+out_put_pt:
+	iommufd_put_object(pt_obj);
+out_put_dev:
+	iommufd_put_object(dev_obj);
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 604ad29f87b8..ee5344baf135 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -257,7 +257,22 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			   struct device *dev);
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 
+static inline struct iommufd_hw_pagetable *
+iommufd_get_hwpt(struct iommufd_ucmd *ucmd, u32 id)
+{
+	return container_of(iommufd_get_object(ucmd->ictx, id,
+					       IOMMUFD_OBJ_HW_PAGETABLE),
+			    struct iommufd_hw_pagetable, obj);
+}
+
+int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd);
+
+struct device *iommufd_obj_dev(struct iommufd_object *obj);
+
 void iommufd_device_destroy(struct iommufd_object *obj);
+
+extern const u64 iommufd_supported_pgtbl_types[];
+
 int iommufd_device_get_info(struct iommufd_ucmd *ucmd);
 
 struct iommufd_access {
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 59aa30ad1090..831303d64abe 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -251,6 +251,7 @@ static int iommufd_option(struct iommufd_ucmd *ucmd)
 union ucmd_buffer {
 	struct iommu_destroy destroy;
 	struct iommu_device_info info;
+	struct iommu_hwpt_alloc hwpt;
 	struct iommu_ioas_alloc alloc;
 	struct iommu_ioas_allow_iovas allow_iovas;
 	struct iommu_ioas_copy ioas_copy;
@@ -284,6 +285,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct iommu_destroy, id),
 	IOCTL_OP(IOMMU_DEVICE_GET_INFO, iommufd_device_get_info, struct iommu_device_info,
 		 __reserved),
+	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
+		 __reserved),
 	IOCTL_OP(IOMMU_IOAS_ALLOC, iommufd_ioas_alloc_ioctl,
 		 struct iommu_ioas_alloc, out_ioas_id),
 	IOCTL_OP(IOMMU_IOAS_ALLOW_IOVAS, iommufd_ioas_allow_iovas,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index bbffb63d2513..f501add5ffe9 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -46,6 +46,7 @@ enum {
 	IOMMUFD_CMD_OPTION,
 	IOMMUFD_CMD_VFIO_IOAS,
 	IOMMUFD_CMD_DEVICE_GET_INFO,
+	IOMMUFD_CMD_HWPT_ALLOC,
 };
 
 /**
@@ -373,6 +374,14 @@ struct iommu_device_info_vtd {
 	__aligned_u64 ecap_reg;
 };
 
+/**
+ * enum iommu_pgtbl_data_type - IOMMU Page Table User Data type
+ * @IOMMU_PGTBL_DATA_NONE: no user data
+ */
+enum iommu_pgtbl_data_type {
+	IOMMU_PGTBL_DATA_NONE,
+};
+
 /**
  * struct iommu_device_info - ioctl(IOMMU_DEVICE_GET_INFO)
  * @size: sizeof(struct iommu_device_info)
@@ -461,6 +470,45 @@ struct iommu_hwpt_intel_vtd {
 	__u32 __reserved;
 };
 
+/**
+ * struct iommu_hwpt_alloc - ioctl(IOMMU_HWPT_ALLOC)
+ * @size: sizeof(struct iommu_hwpt_alloc)
+ * @flags: Must be 0
+ * @dev_id: The device to allocate this HWPT for
+ * @pt_id: The parent of this HWPT (IOAS or HWPT)
+ * @data_type: One of enum iommu_pgtbl_data_type
+ * @data_len: Length of the type specific data
+ * @data_uptr: User pointer to the type specific data
+ * @out_hwpt_id: Output HWPT ID for the allocated object
+ * @__reserved: Must be 0
+ *
+ * Allocate hw_pagetable for managing page tables in userspace. Such page
+ * tables can be user-managed or kernel-managed. @pt_id is needed for either
+ * case. While the @data_type, @data_len and @data_uptr are optional. For
+ * the user-managed page tables, userspace should provide the data_type, the
+ * data_len and the type speficific data. While for the kernel-managed page
+ * tables, use the IOMMU_PGTBL_DATA_NONE data_type, @data_len and @data_uptr
+ * will be ignored.
+ *
+ * +==============================+=====================================+
+ * | @data_type                   |      Data structure in @data_uptr   |
+ * +------------------------------+-------------------------------------+
+ * | IOMMU_PGTBL_DATA_NONE        |                 N/A                 |
+ * +------------------------------+-------------------------------------+
+ */
+struct iommu_hwpt_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 dev_id;
+	__u32 pt_id;
+	__u32 data_type;
+	__u32 data_len;
+	__aligned_u64 data_uptr;
+	__u32 out_hwpt_id;
+	__u32 __reserved;
+};
+#define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)
+
 /**
  * enum iommu_vtd_qi_granularity - Intel VT-d specific granularity of
  *				   queued invalidation
-- 
2.34.1

