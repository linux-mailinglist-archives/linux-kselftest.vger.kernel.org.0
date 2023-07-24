Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E889075F448
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 13:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjGXLEg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 07:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjGXLE1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 07:04:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04778E7E;
        Mon, 24 Jul 2023 04:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196661; x=1721732661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/IpvShswXssQrRx1844//VYqPmGEKT1k2zGzdVCiz9Q=;
  b=YNHVlYJf9N3sEalOsmMTPOb3RDHqPxqIqaSioX9ig8sQQFYicroaVNdi
   4OPWfKCzNjWZ83LQKBFuGX4nE0tbcxQYbU+xZM/AZb9M3gWyWZ5N/WE4o
   pL/sTFJX+fzM4HKsydar92xoqUDsjxDE1V9u/T94RnIM7ONwIZI0oym5K
   lLparR1GE7zm1PTaJgO9TDepXMXs4HPeHlBJqxsN9PGR7wEmBDy5brcGN
   LREQwIn298VL4dt6hLYUMqbx6UT/q+AOsmEZ/F9Q3Czl9db8vvvEdtmR4
   0OivhnOchDP7GwpSfOF41UiScqNs3/o/fdc/WXhr0jejWIKW5tU1Vh+TM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="366301816"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="366301816"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:04:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="815775815"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815775815"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 04:04:18 -0700
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
Subject: [PATCH v3 08/17] iommufd: IOMMU_HWPT_ALLOC allocation with user data
Date:   Mon, 24 Jul 2023 04:03:57 -0700
Message-Id: <20230724110406.107212-9-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724110406.107212-1-yi.l.liu@intel.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
tables) with user data. It also needs to provide a stage-2 hw_pagetable
which is linked to the GPA IOAS.

This extends IOMMU_HWPT_ALLOC to accept user specified parameter and hwpt
ID in @pt_id field. It can be used to allocate user-managed stage-1 hwpt,
which requires a parent hwpt to point to the stage-2 translation.

Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 65 ++++++++++++++++++++++++----
 drivers/iommu/iommufd/main.c         |  2 +-
 include/uapi/linux/iommufd.h         | 20 ++++++++-
 3 files changed, 77 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index c7301cf0e85a..97e4114226de 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -193,29 +193,75 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 {
+	struct iommufd_hw_pagetable *hwpt, *parent = NULL;
+	union iommu_domain_user_data *data = NULL;
 	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
-	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_object *pt_obj;
 	struct iommufd_device *idev;
 	struct iommufd_ioas *ioas;
-	int rc;
+	int rc = 0;
 
 	if (cmd->flags || cmd->__reserved)
 		return -EOPNOTSUPP;
+	if (!cmd->data_len && cmd->hwpt_type != IOMMU_HWPT_TYPE_DEFAULT)
+		return -EINVAL;
 
 	idev = iommufd_get_device(ucmd, cmd->dev_id);
 	if (IS_ERR(idev))
 		return PTR_ERR(idev);
 
-	ioas = iommufd_get_ioas(ucmd->ictx, cmd->pt_id);
-	if (IS_ERR(ioas)) {
-		rc = PTR_ERR(ioas);
+	pt_obj = iommufd_get_object(ucmd->ictx, cmd->pt_id, IOMMUFD_OBJ_ANY);
+	if (IS_ERR(pt_obj)) {
+		rc = -EINVAL;
 		goto out_put_idev;
 	}
 
+	switch (pt_obj->type) {
+	case IOMMUFD_OBJ_IOAS:
+		ioas = container_of(pt_obj, struct iommufd_ioas, obj);
+		break;
+	case IOMMUFD_OBJ_HW_PAGETABLE:
+		/* pt_id points HWPT only when hwpt_type is !IOMMU_HWPT_TYPE_DEFAULT */
+		if (cmd->hwpt_type == IOMMU_HWPT_TYPE_DEFAULT) {
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
+	if (cmd->data_len) {
+		data = kzalloc(sizeof(*data), GFP_KERNEL);
+		if (!data) {
+			rc = -ENOMEM;
+			goto out_put_pt;
+		}
+
+		rc = copy_struct_from_user(data, sizeof(*data),
+					   u64_to_user_ptr(cmd->data_uptr),
+					   cmd->data_len);
+		if (rc)
+			goto out_free_data;
+	}
+
 	mutex_lock(&ioas->mutex);
 	hwpt = iommufd_hw_pagetable_alloc(ucmd->ictx, ioas, idev,
-					  IOMMU_HWPT_TYPE_DEFAULT,
-					  NULL, NULL, false);
+					  cmd->hwpt_type,
+					  parent, data, false);
 	if (IS_ERR(hwpt)) {
 		rc = PTR_ERR(hwpt);
 		goto out_unlock;
@@ -232,7 +278,10 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	iommufd_object_abort_and_destroy(ucmd->ictx, &hwpt->obj);
 out_unlock:
 	mutex_unlock(&ioas->mutex);
-	iommufd_put_object(&ioas->obj);
+out_free_data:
+	kfree(data);
+out_put_pt:
+	iommufd_put_object(pt_obj);
 out_put_idev:
 	iommufd_put_object(&idev->obj);
 	return rc;
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 510db114fc61..5f4420626421 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -426,7 +426,7 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_GET_HW_INFO, iommufd_get_hw_info, struct iommu_hw_info,
 		 __reserved),
 	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
-		 __reserved),
+		 data_uptr),
 	IOCTL_OP(IOMMU_IOAS_ALLOC, iommufd_ioas_alloc_ioctl,
 		 struct iommu_ioas_alloc, out_ioas_id),
 	IOCTL_OP(IOMMU_IOAS_ALLOW_IOVAS, iommufd_ioas_allow_iovas,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index f2026cde2d64..73bf9af91e99 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -364,12 +364,27 @@ enum iommu_hwpt_type {
  * @pt_id: The IOAS to connect this HWPT to
  * @out_hwpt_id: The ID of the new HWPT
  * @__reserved: Must be 0
+ * @hwpt_type: One of enum iommu_hwpt_type
+ * @data_len: Length of the type specific data
+ * @data_uptr: User pointer to the type specific data
  *
  * Explicitly allocate a hardware page table object. This is the same object
  * type that is returned by iommufd_device_attach() and represents the
  * underlying iommu driver's iommu_domain kernel object.
  *
- * A HWPT will be created with the IOVA mappings from the given IOAS.
+ * A kernel-managed HWPT will be created with the mappings from the given
+ * IOAS via the @pt_id. The @hwpt_type for this allocation can be set to
+ * either IOMMU_HWPT_TYPE_DEFAULT or a pre-defined type corresponding to
+ * an I/O page table type supported by the underlying IOMMU hardware.
+ *
+ * A user-managed HWPT will be created from a given parent HWPT via the
+ * @pt_id, in which the parent HWPT must be allocated previously via the
+ * same ioctl from a given IOAS (@pt_id). In this case, the @hwpt_type
+ * must be set to a pre-defined type corresponding to an I/O page table
+ * type supported by the underlying IOMMU hardware.
+ *
+ * If the @hwpt_type is set to IOMMU_HWPT_TYPE_DEFAULT, both the @data_len
+ * and the @data_uptr will be ignored. Otherwise, both must be given.
  */
 struct iommu_hwpt_alloc {
 	__u32 size;
@@ -378,6 +393,9 @@ struct iommu_hwpt_alloc {
 	__u32 pt_id;
 	__u32 out_hwpt_id;
 	__u32 __reserved;
+	__u32 hwpt_type;
+	__u32 data_len;
+	__aligned_u64 data_uptr;
 };
 #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)
 
-- 
2.34.1

