Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715EB7D7BA8
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 06:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343865AbjJZEkM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 00:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343804AbjJZEjz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 00:39:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5A3195;
        Wed, 25 Oct 2023 21:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698295191; x=1729831191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VUPfZ5dXhUGwzfaD6k+Hj8hDIV9h1cI9r4aIIm0Cw00=;
  b=Kt+v/v85AdgkmctblZ9zDCW7lvFd+ZqDx0dtCTGHacr2QTNQbzlq+wCt
   HyhcJag5DqrmbbbHBKs4/XjQoX5N+HscPl5GlkwxILoRz14jpYNK02wsF
   g/CgsE2aIv/vx/+XfX18g2qGoTe4UaePJelGf3DH4j4b53GiA6mERjEe+
   cmmyZM+B64+J1BDJCGi6yutXQYCct4jM83IQDT0RSPr9HQ+gt/FZpIlAY
   r37HwXbqSLAJcaEx6J4hWVn/xni6uc16EUgKjPFBGDk0GzRrOFl0IUB6h
   Vh5J6zkoGuA/v5+X/IZcXn6e6mHCK7qNoJV9avmxI0MXTIGaPM/LMPN20
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="9014520"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="9014520"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 21:39:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="708931330"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="708931330"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2023 21:39:45 -0700
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
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
        xin.zeng@intel.com
Subject: [PATCH v7 07/10] iommufd: Add a nested HW pagetable object
Date:   Wed, 25 Oct 2023 21:39:35 -0700
Message-Id: <20231026043938.63898-8-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026043938.63898-1-yi.l.liu@intel.com>
References: <20231026043938.63898-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Nicolin Chen <nicolinc@nvidia.com>

IOMMU_HWPT_ALLOC already supports iommu_domain allocation for usersapce.
But it can only allocate a hw_pagetable that associates to a given IOAS,
i.e. only a kernel-managed hw_pagetable of IOMMUFD_OBJ_HWPT_PAGING type.

IOMMU drivers can now support user-managed hw_pagetables, for two-stage
translation use cases that require user data input from the user space.

Add a new IOMMUFD_OBJ_HWPT_NESTED type with its abort/destroy(). Pair it
with a new iommufd_hwpt_nested structure and its to_hwpt_nested() helper.
Update the to_hwpt_paging() helper, so a NESTED-type hw_pagetable can be
handled in the callers, for example iommufd_hw_pagetable_enforce_rr().

Screen the inputs including the parent PAGING-type hw_pagetable that has
a need of a new nest_parent flag in the iommufd_hwpt_paging structure.

Extend the IOMMU_HWPT_ALLOC ioctl to accept an IOMMU driver specific data
input which is tagged by the enum iommu_hwpt_data_type. Also, update the
@pt_id to accept hwpt_id too besides an ioas_id. Then, use them to allocate
a hw_pagetable of IOMMUFD_OBJ_HWPT_NESTED type using the
iommufd_hw_pagetable_alloc_nested() allocator.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          |   3 +-
 drivers/iommu/iommufd/hw_pagetable.c    | 109 ++++++++++++++++++++++--
 drivers/iommu/iommufd/iommufd_private.h |  28 ++++--
 drivers/iommu/iommufd/main.c            |   4 +
 include/uapi/linux/iommufd.h            |  31 ++++++-
 5 files changed, 159 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index a99ce4547353..59d3a07300d9 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -588,7 +588,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	}
 
 	hwpt_paging = iommufd_hwpt_paging_alloc(idev->ictx, ioas, idev, 0,
-						immediate_attach);
+						immediate_attach, NULL);
 	if (IS_ERR(hwpt_paging)) {
 		destroy_hwpt = ERR_CAST(hwpt_paging);
 		goto out_unlock;
@@ -628,6 +628,7 @@ static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
 		return PTR_ERR(pt_obj);
 
 	switch (pt_obj->type) {
+	case IOMMUFD_OBJ_HWPT_NESTED:
 	case IOMMUFD_OBJ_HWPT_PAGING: {
 		struct iommufd_hw_pagetable *hwpt =
 			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 198ecbd536f7..2abbeafdbd22 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -44,6 +44,22 @@ void iommufd_hwpt_paging_abort(struct iommufd_object *obj)
 	iommufd_hwpt_paging_destroy(obj);
 }
 
+void iommufd_hwpt_nested_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_hwpt_nested *hwpt_nested =
+		container_of(obj, struct iommufd_hwpt_nested, common.obj);
+
+	if (hwpt_nested->common.domain)
+		iommu_domain_free(hwpt_nested->common.domain);
+
+	refcount_dec(&hwpt_nested->parent->common.obj.users);
+}
+
+void iommufd_hwpt_nested_abort(struct iommufd_object *obj)
+{
+	iommufd_hwpt_nested_destroy(obj);
+}
+
 static int
 iommufd_hwpt_paging_enforce_cc(struct iommufd_hwpt_paging *hwpt_paging)
 {
@@ -68,6 +84,8 @@ iommufd_hwpt_paging_enforce_cc(struct iommufd_hwpt_paging *hwpt_paging)
  * @idev: Device to get an iommu_domain for
  * @flags: Flags from userspace
  * @immediate_attach: True if idev should be attached to the hwpt
+ * @user_data: The user provided driver specific data describing the domain to
+ *             create
  *
  * Allocate a new iommu_domain and return it as a hw_pagetable. The HWPT
  * will be linked to the given ioas and upon return the underlying iommu_domain
@@ -80,7 +98,8 @@ iommufd_hwpt_paging_enforce_cc(struct iommufd_hwpt_paging *hwpt_paging)
 struct iommufd_hwpt_paging *
 iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			  struct iommufd_device *idev, u32 flags,
-			  bool immediate_attach)
+			  bool immediate_attach,
+			  const struct iommu_user_data *user_data)
 {
 	const u32 valid_flags = IOMMU_HWPT_ALLOC_NEST_PARENT |
 				IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
@@ -91,7 +110,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 
 	lockdep_assert_held(&ioas->mutex);
 
-	if (flags && !ops->domain_alloc_user)
+	if ((flags || user_data) && !ops->domain_alloc_user)
 		return ERR_PTR(-EOPNOTSUPP);
 	if (flags & ~valid_flags)
 		return ERR_PTR(-EOPNOTSUPP);
@@ -106,10 +125,11 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	/* Pairs with iommufd_hw_pagetable_destroy() */
 	refcount_inc(&ioas->obj.users);
 	hwpt_paging->ioas = ioas;
+	hwpt_paging->nest_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
 
 	if (ops->domain_alloc_user) {
-		hwpt->domain =
-			ops->domain_alloc_user(idev->dev, flags, NULL, NULL);
+		hwpt->domain = ops->domain_alloc_user(idev->dev, flags, NULL,
+						      user_data);
 		if (IS_ERR(hwpt->domain)) {
 			rc = PTR_ERR(hwpt->domain);
 			hwpt->domain = NULL;
@@ -169,9 +189,70 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	return ERR_PTR(rc);
 }
 
+/**
+ * iommufd_hwpt_nested_alloc() - Get a NESTED iommu_domain for a device
+ * @ictx: iommufd context
+ * @parent: Parent PAGING-type hwpt to associate the domain with
+ * @idev: Device to get an iommu_domain for
+ * @flags: Flags from userspace
+ * @user_data: user_data pointer. Must be valid
+ *
+ * Allocate a new iommu_domain (must be IOMMU_DOMAIN_NESTED) and return it as
+ * a NESTED hw_pagetable. The given parent PAGING-type hwpt must be capable of
+ * being a parent.
+ */
+static struct iommufd_hwpt_nested *
+iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
+			  struct iommufd_hwpt_paging *parent,
+			  struct iommufd_device *idev, u32 flags,
+			  const struct iommu_user_data *user_data)
+{
+	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
+	struct iommufd_hwpt_nested *hwpt_nested;
+	struct iommufd_hw_pagetable *hwpt;
+	int rc;
+
+	if (flags || !user_data->len || !ops->domain_alloc_user)
+		return ERR_PTR(-EOPNOTSUPP);
+	if (parent->auto_domain || !parent->nest_parent)
+		return ERR_PTR(-EINVAL);
+
+	hwpt_nested = __iommufd_object_alloc(
+		ictx, hwpt_nested, IOMMUFD_OBJ_HWPT_NESTED, common.obj);
+	if (IS_ERR(hwpt_nested))
+		return ERR_CAST(hwpt_nested);
+	hwpt = &hwpt_nested->common;
+
+	refcount_inc(&parent->common.obj.users);
+	hwpt_nested->parent = parent;
+
+	hwpt->domain = ops->domain_alloc_user(idev->dev, flags,
+					      parent->common.domain, user_data);
+	if (IS_ERR(hwpt->domain)) {
+		rc = PTR_ERR(hwpt->domain);
+		hwpt->domain = NULL;
+		goto out_abort;
+	}
+
+	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
+		rc = -EINVAL;
+		goto out_abort;
+	}
+	return hwpt_nested;
+
+out_abort:
+	iommufd_object_abort_and_destroy(ictx, &hwpt->obj);
+	return ERR_PTR(rc);
+}
+
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
+	const struct iommu_user_data user_data = {
+		.type = cmd->data_type,
+		.uptr = u64_to_user_ptr(cmd->data_uptr),
+		.len = cmd->data_len,
+	};
 	struct iommufd_hw_pagetable *hwpt;
 	struct iommufd_ioas *ioas = NULL;
 	struct iommufd_object *pt_obj;
@@ -180,6 +261,8 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 
 	if (cmd->__reserved)
 		return -EOPNOTSUPP;
+	if (cmd->data_type == IOMMU_HWPT_DATA_NONE && cmd->data_len)
+		return -EINVAL;
 
 	idev = iommufd_get_device(ucmd, cmd->dev_id);
 	if (IS_ERR(idev))
@@ -196,13 +279,27 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 
 		ioas = container_of(pt_obj, struct iommufd_ioas, obj);
 		mutex_lock(&ioas->mutex);
-		hwpt_paging = iommufd_hwpt_paging_alloc(ucmd->ictx, ioas, idev,
-							cmd->flags, false);
+		hwpt_paging = iommufd_hwpt_paging_alloc(
+			ucmd->ictx, ioas, idev, cmd->flags, false,
+			user_data.len ? &user_data : NULL);
 		if (IS_ERR(hwpt_paging)) {
 			rc = PTR_ERR(hwpt_paging);
 			goto out_unlock;
 		}
 		hwpt = &hwpt_paging->common;
+	} else if (pt_obj->type == IOMMUFD_OBJ_HWPT_PAGING) {
+		struct iommufd_hwpt_nested *hwpt_nested;
+
+		hwpt_nested = iommufd_hwpt_nested_alloc(
+			ucmd->ictx,
+			container_of(pt_obj, struct iommufd_hwpt_paging,
+				     common.obj),
+			idev, cmd->flags, &user_data);
+		if (IS_ERR(hwpt_nested)) {
+			rc = PTR_ERR(hwpt_nested);
+			goto out_unlock;
+		}
+		hwpt = &hwpt_nested->common;
 	} else {
 		rc = -EINVAL;
 		goto out_put_pt;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index cd8da289ed0b..a74cfefffbc6 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -124,6 +124,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_ANY = IOMMUFD_OBJ_NONE,
 	IOMMUFD_OBJ_DEVICE,
 	IOMMUFD_OBJ_HWPT_PAGING,
+	IOMMUFD_OBJ_HWPT_NESTED,
 	IOMMUFD_OBJ_IOAS,
 	IOMMUFD_OBJ_ACCESS,
 #ifdef CONFIG_IOMMUFD_TEST
@@ -255,10 +256,16 @@ struct iommufd_hwpt_paging {
 	bool auto_domain : 1;
 	bool enforce_cache_coherency : 1;
 	bool msi_cookie : 1;
+	bool nest_parent : 1;
 	/* Head at iommufd_ioas::hwpt_list */
 	struct list_head hwpt_item;
 };
 
+struct iommufd_hwpt_nested {
+	struct iommufd_hw_pagetable common;
+	struct iommufd_hwpt_paging *parent;
+};
+
 static inline bool hwpt_is_paging(struct iommufd_hw_pagetable *hwpt)
 {
 	return hwpt->obj.type == IOMMUFD_OBJ_HWPT_PAGING;
@@ -283,25 +290,32 @@ int iommufd_hwpt_get_dirty_bitmap(struct iommufd_ucmd *ucmd);
 struct iommufd_hwpt_paging *
 iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			  struct iommufd_device *idev, u32 flags,
-			  bool immediate_attach);
+			  bool immediate_attach,
+			  const struct iommu_user_data *user_data);
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev);
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_detach(struct iommufd_device *idev);
 void iommufd_hwpt_paging_destroy(struct iommufd_object *obj);
 void iommufd_hwpt_paging_abort(struct iommufd_object *obj);
+void iommufd_hwpt_nested_destroy(struct iommufd_object *obj);
+void iommufd_hwpt_nested_abort(struct iommufd_object *obj);
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd);
 
 static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
 					    struct iommufd_hw_pagetable *hwpt)
 {
-	struct iommufd_hwpt_paging *hwpt_paging = to_hwpt_paging(hwpt);
+	if (hwpt->obj.type == IOMMUFD_OBJ_HWPT_PAGING) {
+		struct iommufd_hwpt_paging *hwpt_paging = to_hwpt_paging(hwpt);
 
-	lockdep_assert_not_held(&hwpt_paging->ioas->mutex);
-	if (hwpt_paging->auto_domain)
-		iommufd_object_deref_user(ictx, &hwpt->obj);
-	else
-		refcount_dec(&hwpt->obj.users);
+		lockdep_assert_not_held(&hwpt_paging->ioas->mutex);
+
+		if (hwpt_paging->auto_domain) {
+			iommufd_object_deref_user(ictx, &hwpt->obj);
+			return;
+		}
+	}
+	refcount_dec(&hwpt->obj.users);
 }
 
 struct iommufd_group {
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index ab6675a7f6b4..45b9d40773b1 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -492,6 +492,10 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 		.destroy = iommufd_hwpt_paging_destroy,
 		.abort = iommufd_hwpt_paging_abort,
 	},
+	[IOMMUFD_OBJ_HWPT_NESTED] = {
+		.destroy = iommufd_hwpt_nested_destroy,
+		.abort = iommufd_hwpt_nested_abort,
+	},
 #ifdef CONFIG_IOMMUFD_TEST
 	[IOMMUFD_OBJ_SELFTEST] = {
 		.destroy = iommufd_selftest_destroy,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index c44eecf5d318..d816deac906f 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -361,20 +361,44 @@ enum iommufd_hwpt_alloc_flags {
 	IOMMU_HWPT_ALLOC_DIRTY_TRACKING = 1 << 1,
 };
 
+/**
+ * enum iommu_hwpt_data_type - IOMMU HWPT Data Type
+ * @IOMMU_HWPT_DATA_NONE: no data
+ */
+enum iommu_hwpt_data_type {
+	IOMMU_HWPT_DATA_NONE,
+};
+
 /**
  * struct iommu_hwpt_alloc - ioctl(IOMMU_HWPT_ALLOC)
  * @size: sizeof(struct iommu_hwpt_alloc)
  * @flags: Combination of enum iommufd_hwpt_alloc_flags
  * @dev_id: The device to allocate this HWPT for
- * @pt_id: The IOAS to connect this HWPT to
+ * @pt_id: The IOAS or HWPT to connect this HWPT to
  * @out_hwpt_id: The ID of the new HWPT
  * @__reserved: Must be 0
+ * @data_type: One of enum iommu_hwpt_data_type
+ * @data_len: Length of the type specific data
+ * @data_uptr: User pointer to the type specific data
  *
  * Explicitly allocate a hardware page table object. This is the same object
  * type that is returned by iommufd_device_attach() and represents the
  * underlying iommu driver's iommu_domain kernel object.
  *
- * A HWPT will be created with the IOVA mappings from the given IOAS.
+ * A kernel-managed HWPT will be created with the mappings from the given
+ * IOAS via the @pt_id. The @data_type for this allocation must be set to
+ * IOMMU_HWPT_DATA_NONE. The HWPT can be allocated as a parent HWPT for a
+ * nesting configuration by passing IOMMU_HWPT_ALLOC_NEST_PARENT via @flags.
+ *
+ * A user-managed nested HWPT will be created from a given parent HWPT via
+ * @pt_id, in which the parent HWPT must be allocated previously via the
+ * same ioctl from a given IOAS (@pt_id). In this case, the @data_type
+ * must be set to a pre-defined type corresponding to an I/O page table
+ * type supported by the underlying IOMMU hardware.
+ *
+ * If the @data_type is set to IOMMU_HWPT_DATA_NONE, @data_len and
+ * @data_uptr should be zero. Otherwise, both @data_len and @data_uptr
+ * must be given.
  */
 struct iommu_hwpt_alloc {
 	__u32 size;
@@ -383,6 +407,9 @@ struct iommu_hwpt_alloc {
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

