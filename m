Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443136B1D5E
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 09:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCIIJk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 03:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCIIJf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 03:09:35 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0325173035;
        Thu,  9 Mar 2023 00:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678349374; x=1709885374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KTRiWPVEMnAblPTuUj5ebCwkle4aIieP4ZkxIOdMmhM=;
  b=kySjMN45PYRPcBCJD544N5ICv4VqXNp05kzAsctkBCyfYpg6KlGnaVda
   AlKIFvbdFA8NPqQEKG2KaAnBjCxiyMVttC7dMJTGkz51BkxmYH/KiDlLp
   i965Tn5g8d7nMY8nkf42CQ3vskUPouSy9qqtJmXuzMRPP0OMKHIKaTVtp
   a9Tdzz/92YyBhx0IDRZFRX1oe0/rtrWmcKSLLuk6xgZjBCikbrwqQzlEK
   cP08JY20fJde118y9JcWDLp8h83UrlkOcj6Stx3dkQlOIaPWIZoPOhv7n
   22/qZMb/RV5vHuIM03EO338UyJpf3bwDzNhJT6A49jTDT8lGo24l5qrW2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364023083"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364023083"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787471385"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787471385"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2023 00:09:29 -0800
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
Subject: [PATCH 06/12] iommufd: IOMMU_HWPT_ALLOC allocation with user data
Date:   Thu,  9 Mar 2023 00:09:04 -0800
Message-Id: <20230309080910.607396-7-yi.l.liu@intel.com>
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

IOMMU_HWPT_ALLOC already supports iommu_domain allocation for usersapce.
But it can only allocate hw_pagetables linked with IOAS. There are needs
to support hw_pagetable allocation with parameters specified by user. For
example, in nested translation, user needs to allocate hw_pagetable for
the stage-1 translation (e.g. a single I/O page table or a set of I/O page
tables) with user data. It also needs provide a stage-2 hw_pagetable which
is linked to the GPA IOAS.

This extends IOMMU_HWPT_ALLOC to accept user specified parameter and hwpt
ID in @pt_id field. Such as the user-managed stage-1 hwpt, which requires
a parent hwpt to point to stage-2 translation.

enum iommu_hwpt_type is defined to differentiate the user parameters use
by different usages. For the allocations that don't require user parameter,
IOMMU_HWPT_TYPE_DEFAULT is defined for backward compatibility. Other types
would be added by future iommu vendor driver extensions.

Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 94 +++++++++++++++++++++++++---
 drivers/iommu/iommufd/main.c         |  2 +-
 include/uapi/linux/iommufd.h         | 30 +++++++++
 3 files changed, 115 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 6e45ec0a66fa..64e7cf7142e1 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -165,34 +165,106 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	return ERR_PTR(rc);
 }
 
+/*
+ * size of page table type specific data, indexed by
+ * enum iommu_hwpt_type.
+ */
+static const size_t iommufd_hwpt_alloc_data_size[] = {
+	[IOMMU_HWPT_TYPE_DEFAULT] = 0,
+};
+
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
-	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_hw_pagetable *hwpt, *parent = NULL;
+	struct iommufd_object *pt_obj;
 	struct iommufd_device *idev;
 	struct iommufd_ioas *ioas;
+	const struct iommu_ops *ops;
+	void *data = NULL;
+	u32 klen;
 	int rc;
 
-	if (cmd->flags)
+	if (cmd->__reserved || cmd->flags)
 		return -EOPNOTSUPP;
 
 	idev = iommufd_get_device(ucmd, cmd->dev_id);
 	if (IS_ERR(idev))
 		return PTR_ERR(idev);
 
-	ioas = iommufd_get_ioas(ucmd, cmd->pt_id);
-	if (IS_ERR(ioas)) {
-		rc = PTR_ERR(ioas);
+	ops = dev_iommu_ops(idev->dev);
+	if (!ops) {
+		rc = -EOPNOTSUPP;
 		goto out_put_idev;
 	}
 
+	/* Only support IOMMU_HWPT_TYPE_DEFAULT for now */
+	if (cmd->data_type != IOMMU_HWPT_TYPE_DEFAULT) {
+		rc = -EINVAL;
+		goto out_put_idev;
+	}
+
+	pt_obj = iommufd_get_object(ucmd->ictx, cmd->pt_id, IOMMUFD_OBJ_ANY);
+	if (IS_ERR(pt_obj)) {
+		rc = -EINVAL;
+		goto out_put_idev;
+	}
+
+	switch (pt_obj->type) {
+	case IOMMUFD_OBJ_IOAS:
+		ioas = container_of(pt_obj, struct iommufd_ioas, obj);
+		break;
+	case IOMMUFD_OBJ_HW_PAGETABLE:
+		/* pt_id points HWPT only when data_type is !IOMMU_HWPT_TYPE_DEFAULT */
+		if (cmd->data_type == IOMMU_HWPT_TYPE_DEFAULT) {
+			rc = -EINVAL;
+			goto out_put_pt;
+		}
+
+		parent = container_of(pt_obj, struct iommufd_hw_pagetable, obj);
+		/*
+		 * Cannot allocate user-managed hwpt linking to auto_created
+		 * hwpt. If the parent hwpt is already a user-managed hwpt,
+		 * don't allocate another user-managed hwpt linking to it.
+		 */
+		if (parent->auto_domain || parent->parent) {
+			rc = -EINVAL;
+			goto out_put_pt;
+		}
+		ioas = parent->ioas;
+		break;
+	default:
+		rc = -EINVAL;
+		goto out_put_pt;
+	}
+
+	klen = iommufd_hwpt_alloc_data_size[cmd->data_type];
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
 	mutex_lock(&ioas->mutex);
 	hwpt = iommufd_hw_pagetable_alloc(ucmd->ictx, ioas, idev,
-					  NULL, NULL, false);
+					  parent, data, false);
 	mutex_unlock(&ioas->mutex);
 	if (IS_ERR(hwpt)) {
 		rc = PTR_ERR(hwpt);
-		goto out_put_ioas;
+		goto out_free_data;
 	}
 
 	cmd->out_hwpt_id = hwpt->obj.id;
@@ -200,12 +272,14 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	if (rc)
 		goto out_hwpt;
 	iommufd_object_finalize(ucmd->ictx, &hwpt->obj);
-	goto out_put_ioas;
+	goto out_free_data;
 
 out_hwpt:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &hwpt->obj);
-out_put_ioas:
-	iommufd_put_object(&ioas->obj);
+out_free_data:
+	kfree(data);
+out_put_pt:
+	iommufd_put_object(pt_obj);
 out_put_idev:
 	iommufd_put_object(&idev->obj);
 	return rc;
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index f079c0bda46b..7ab1e2c638a1 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -295,7 +295,7 @@ struct iommufd_ioctl_op {
 static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct iommu_destroy, id),
 	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
-		 __reserved),
+		 data_uptr),
 	IOCTL_OP(IOMMU_DEVICE_GET_HW_INFO, iommufd_device_get_hw_info,
 		 struct iommu_hw_info, __reserved),
 	IOCTL_OP(IOMMU_IOAS_ALLOC, iommufd_ioas_alloc_ioctl,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 4ac525897b82..48781ff40a37 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -347,6 +347,14 @@ struct iommu_vfio_ioas {
 };
 #define IOMMU_VFIO_IOAS _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VFIO_IOAS)
 
+/**
+ * enum iommu_hwpt_type - IOMMU HWPT Type
+ * @IOMMU_HWPT_TYPE_DEFAULT: default
+ */
+enum iommu_hwpt_type {
+	IOMMU_HWPT_TYPE_DEFAULT,
+};
+
 /**
  * struct iommu_hwpt_alloc - ioctl(IOMMU_HWPT_ALLOC)
  * @size: sizeof(struct iommu_hwpt_alloc)
@@ -355,12 +363,31 @@ struct iommu_vfio_ioas {
  * @pt_id: The IOAS to connect this HWPT to
  * @out_hwpt_id: The ID of the new HWPT
  * @__reserved: Must be 0
+ * @data_type: One of enum iommu_hwpt_type
+ * @data_len: Length of the type specific data
+ * @data_uptr: User pointer to the type specific data
  *
  * Explicitly allocate a hardware page table object. This is the same object
  * type that is returned by iommufd_device_attach() and represents the
  * underlying iommu driver's iommu_domain kernel object.
  *
  * A normal HWPT will be created with the mappings from the given IOAS.
+ * The @data_type for its allocation can be set to IOMMU_HWPT_TYPE_DEFAULT, or
+ * another type (being listed below) to specialize a kernel-managed HWPT.
+ *
+ * A user-managed HWPT will be created from a given parent HWPT via @pt_id, in
+ * which the parent HWPT must be allocated previously via the same ioctl from a
+ * given IOAS. The @data_type must not be set to IOMMU_HWPT_TYPE_DEFAULT but a
+ * pre-defined type corresponding to the underlying IOMMU hardware.
+ *
+ * If the @data_type is set to IOMMU_HWPT_TYPE_DEFAULT, both the @data_len and
+ * the @data_uptr will be ignored. Otherwise, both of them must be given.
+ *
+ * +==============================+=====================================+===========+
+ * | @data_type                   |    Data structure in @data_uptr     |   @pt_id  |
+ * +------------------------------+-------------------------------------+-----------+
+ * | IOMMU_HWPT_TYPE_DEFAULT      |               N/A                   |    IOAS   |
+ * +------------------------------+-------------------------------------+-----------+
  */
 struct iommu_hwpt_alloc {
 	__u32 size;
@@ -369,6 +396,9 @@ struct iommu_hwpt_alloc {
 	__u32 pt_id;
 	__u32 out_hwpt_id;
 	__u32 __reserved;
+	__u32 data_type;
+	__u32 data_len;
+	__aligned_u64 data_uptr;
 };
 #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)
 
-- 
2.34.1

