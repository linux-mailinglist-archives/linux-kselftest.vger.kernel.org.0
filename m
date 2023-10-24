Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260E27D54D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 17:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjJXPKX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 11:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbjJXPKM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 11:10:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CB010E4;
        Tue, 24 Oct 2023 08:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698160203; x=1729696203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v1H+jmuRGvVjgJE0IxtfQ1xXpnVfRGQz5PBPC8PYfR0=;
  b=JL/06gMjpSEpb5VIFlAbmspz1vpjUMt+06N6p8YJY2JMF3v/kkWk1Y0l
   qRMEX0YWuKjR0UkfwyAE3iGLNGzetjkKrwwSY4xRDG4fMPdGx1+27aviF
   nvHebt/Ua/20duwfsQ9oOsYBYGq7XfDtR/RJASWtjQ4d26Rft/7217abF
   v4U5cWQNuahI7HRGDAdeSeqBFITmYxLv4SLzxFk/KV/wz+yjSFnlW8k+U
   lkTcV7xYlT4VVO9futtRyxzstlK0oorzDQSRNzH3SZKAt6n9xNJFVMpdm
   HLzPq/WCGESzofE7rPR2s9OqkPOvlRzs8q4SIO2ZxlNYOcj9m7a/USo31
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="418203064"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="418203064"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:06:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="6486187"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa001.fm.intel.com with ESMTP; 24 Oct 2023 08:06:22 -0700
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
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: [PATCH v6 07/10] iommufd: Add a nested HW pagetable object
Date:   Tue, 24 Oct 2023 08:06:06 -0700
Message-Id: <20231024150609.46884-8-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024150609.46884-1-yi.l.liu@intel.com>
References: <20231024150609.46884-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
input. Also, update the @pt_id to accept hwpt_id too besides an ioas_id.
Then, use them to allocate a hw_pagetable of IOMMUFD_OBJ_HWPT_NESTED type
using the iommufd_hw_pagetable_alloc_nested() allocator.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          |   1 +
 drivers/iommu/iommufd/hw_pagetable.c    | 105 ++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  29 +++++--
 drivers/iommu/iommufd/main.c            |   4 +
 include/uapi/linux/iommufd.h            |  23 +++++-
 5 files changed, 154 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 902288ca910d..6dbd58a718e4 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -627,6 +627,7 @@ static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
 		return PTR_ERR(pt_obj);
 
 	switch (pt_obj->type) {
+	case IOMMUFD_OBJ_HWPT_NESTED:
 	case IOMMUFD_OBJ_HWPT_PAGING: {
 		struct iommufd_hw_pagetable *hwpt =
 			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index fbe09e2473bc..d41428a0fdc2 100644
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
@@ -107,6 +123,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	/* Pairs with iommufd_hw_pagetable_destroy() */
 	refcount_inc(&ioas->obj.users);
 	hwpt_paging->ioas = ioas;
+	hwpt_paging->nest_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
 
 	if (ops->domain_alloc_user) {
 		hwpt->domain = ops->domain_alloc_user(idev->dev, flags,
@@ -170,6 +187,73 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
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
+	if (flags != 0)
+		return ERR_PTR(-EOPNOTSUPP);
+	if (!user_data)
+		return ERR_PTR(-EINVAL);
+	if (user_data->type == IOMMU_HWPT_DATA_NONE)
+		return ERR_PTR(-EINVAL);
+	if (parent->auto_domain)
+		return ERR_PTR(-EINVAL);
+	if (!parent->nest_parent)
+		return ERR_PTR(-EINVAL);
+
+	if (!ops->domain_alloc_user)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	hwpt_nested = __iommufd_object_alloc(ictx, hwpt_nested,
+					     IOMMUFD_OBJ_HWPT_NESTED,
+					     common.obj);
+	if (IS_ERR(hwpt_nested))
+		return ERR_CAST(hwpt_nested);
+	hwpt = &hwpt_nested->common;
+
+	refcount_inc(&parent->common.obj.users);
+	hwpt_nested->parent = parent;
+
+	hwpt->domain = ops->domain_alloc_user(idev->dev, 0,
+					      parent->common.domain,
+					      user_data);
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
@@ -195,6 +279,10 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	if (pt_obj->type == IOMMUFD_OBJ_IOAS) {
 		struct iommufd_hwpt_paging *hwpt_paging;
 
+		if (cmd->data_type != IOMMU_HWPT_DATA_NONE) {
+			rc = -EINVAL;
+			goto out_put_pt;
+		}
 		ioas = container_of(pt_obj, struct iommufd_ioas, obj);
 		mutex_lock(&ioas->mutex);
 		hwpt_paging = iommufd_hwpt_paging_alloc(ucmd->ictx, ioas, idev,
@@ -204,6 +292,23 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 			goto out_unlock;
 		}
 		hwpt = &hwpt_paging->common;
+	} else if (pt_obj->type == IOMMUFD_OBJ_HWPT_PAGING) {
+		const struct iommu_user_data user_data = {
+			.type = cmd->data_type,
+			.uptr = u64_to_user_ptr(cmd->data_uptr),
+			.len = cmd->data_len,
+		};
+		struct iommufd_hwpt_nested *hwpt_nested;
+		struct iommufd_hwpt_paging *parent;
+
+		parent = container_of(pt_obj, typeof(*parent), common.obj);
+		hwpt_nested = iommufd_hwpt_nested_alloc(ucmd->ictx, parent, idev,
+							cmd->flags, &user_data);
+		if (IS_ERR(hwpt_nested)) {
+			rc = PTR_ERR(hwpt_nested);
+			goto out_unlock;
+		}
+		hwpt = &hwpt_nested->common;
 	} else {
 		rc = -EINVAL;
 		goto out_put_pt;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 6493fcdad1b7..6fdad56893af 100644
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
@@ -290,18 +297,28 @@ struct iommufd_hw_pagetable *
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
+	if (WARN_ON(hwpt->obj.type != IOMMUFD_OBJ_HWPT_PAGING &&
+		    hwpt->obj.type != IOMMUFD_OBJ_HWPT_NESTED))
+		return;
 
-	lockdep_assert_not_held(&hwpt_paging->ioas->mutex);
-	if (hwpt_paging->auto_domain)
-		iommufd_object_deref_user(ictx, &hwpt->obj);
-	else
-		refcount_dec(&hwpt->obj.users);
+	if (hwpt->obj.type == IOMMUFD_OBJ_HWPT_PAGING) {
+		struct iommufd_hwpt_paging *hwpt_paging = to_hwpt_paging(hwpt);
+
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
index fccc6315a520..d816deac906f 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -374,15 +374,31 @@ enum iommu_hwpt_data_type {
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
@@ -391,6 +407,9 @@ struct iommu_hwpt_alloc {
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

