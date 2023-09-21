Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101DF7A9B10
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 20:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjIUSxr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 14:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjIUSxU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 14:53:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF9C515BD;
        Thu, 21 Sep 2023 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318595; x=1726854595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r/iiqZNASYdDaSFvw490mVbipdDkiEm+mbdVppSrYxQ=;
  b=AyrL3tWeN8whBrM0LcpKO1oQ5t38MZxs47DABxe3UK52cy1W3+GU0IC0
   5X0imG++8ThY2Alrye0Cw5KY+YPY9i73+yYMkWliGDl1ePELeUdD0etK9
   Y6ryJf0I+R321GoqQWsv5il+4hqNgMQWWoP/2Gi+SzefDMEYYtgp32bct
   xrsvVxk86qPoOtxwgPaI+84DzHZqxniXwsP7bv4ph1+SsYAVqLQX/zD2K
   +dEFvKS8cNmsf2Lg2cRjllOmxBmmBW+3AHWlybbqhyDJTBlpSPfuZtURx
   Y0v/+K23HcvPrzG6JEgL4vd4YgbYm2eNWi8Y7fRVRud+6WjbEIcSqsiC6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359832910"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="359832910"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:52:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723649564"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="723649564"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2023 00:52:15 -0700
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
Subject: [PATCH v4 10/17] iommufd: Support IOMMU_HWPT_ALLOC allocation with user data
Date:   Thu, 21 Sep 2023 00:51:31 -0700
Message-Id: <20230921075138.124099-11-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921075138.124099-1-yi.l.liu@intel.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
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

IOMMU_HWPT_ALLOC already supports iommu_domain allocation for usersapce.
But it can only allocate a hw_pagetable that associates to a given IOAS,
i.e. only a kernel-managed hw_pagetable of IOMMU_HWPT_TYPE_DEFAULT type.

IOMMU drivers can now support user-managed hw_pagetables, for two-stage
translation use cases, that require user data input from the user space.

Extend the IOMMU_HWPT_ALLOC ioctl to accept non-default hwpt_type with a
type specified user data. Also, update the @pt_id to accept hwpt_id too
besides an ioas_id. Then, pass them to the downstream alloc_fn().

Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 19 ++++++++++++++++++-
 include/uapi/linux/iommufd.h         | 23 +++++++++++++++++++++--
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 90fd65859e28..ab25de149ae6 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -300,6 +300,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 					bool flag);
 	struct iommufd_hw_pagetable *hwpt, *parent;
 	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
+	struct iommu_user_data *data = NULL;
 	struct iommufd_object *pt_obj;
 	struct iommufd_device *idev;
 	struct iommufd_ioas *ioas;
@@ -308,6 +309,11 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 
 	if (cmd->flags & ~IOMMU_HWPT_ALLOC_NEST_PARENT || cmd->__reserved)
 		return -EOPNOTSUPP;
+	if (!cmd->data_len && cmd->hwpt_type != IOMMU_HWPT_TYPE_DEFAULT)
+		return -EINVAL;
+	if (cmd->flags & IOMMU_HWPT_ALLOC_NEST_PARENT &&
+	    cmd->hwpt_type != IOMMU_HWPT_TYPE_DEFAULT)
+		return -EINVAL;
 
 	idev = iommufd_get_device(ucmd, cmd->dev_id);
 	if (IS_ERR(idev))
@@ -340,9 +346,19 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		goto out_put_pt;
 	}
 
+	if (cmd->data_len) {
+		data = kzalloc(sizeof(*data), GFP_KERNEL);
+		if (!data) {
+			rc = -ENOMEM;
+			goto out_put_pt;
+		}
+		data->uptr = u64_to_user_ptr(cmd->data_uptr);
+		data->len = cmd->data_len;
+	}
+
 	mutex_lock(mutex);
 	hwpt = alloc_fn(ucmd->ictx, pt_obj, idev, cmd->flags,
-			IOMMU_HWPT_TYPE_DEFAULT, NULL, false);
+			cmd->hwpt_type, data, false);
 	if (IS_ERR(hwpt)) {
 		rc = PTR_ERR(hwpt);
 		goto out_unlock;
@@ -359,6 +375,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	iommufd_object_abort_and_destroy(ucmd->ictx, &hwpt->obj);
 out_unlock:
 	mutex_unlock(mutex);
+	kfree(data);
 out_put_pt:
 	iommufd_put_object(pt_obj);
 out_put_idev:
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 3c8660fe9bb1..c46b1f772f20 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -370,15 +370,31 @@ enum iommu_hwpt_type {
  * @size: sizeof(struct iommu_hwpt_alloc)
  * @flags: Combination of enum iommufd_hwpt_alloc_flags
  * @dev_id: The device to allocate this HWPT for
- * @pt_id: The IOAS to connect this HWPT to
+ * @pt_id: The IOAS or HWPT to connect this HWPT to
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
+ * If the @hwpt_type is set to IOMMU_HWPT_TYPE_DEFAULT, @data_len and
+ * @data_uptr should be zero. Otherwise, both @data_len and @data_uptr
+ * must be given.
  */
 struct iommu_hwpt_alloc {
 	__u32 size;
@@ -387,6 +403,9 @@ struct iommu_hwpt_alloc {
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

