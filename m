Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B057A9B12
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 20:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjIUSxs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 14:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjIUSxU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 14:53:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C08D5A570;
        Thu, 21 Sep 2023 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318595; x=1726854595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0niPGgzDS5WOc3zBdtsMEXEK+XIRPu7hBRklIJBX47o=;
  b=nFPIOUZD3opzP3QBxSx9ioQyj6ZZDjZQrrdzVxU4qMtA+1Up55XDCTTN
   adiP96LnG/KXVZNqllXDJYsXnxAh7wp2xECAkNOEZmWg5k7uBIL9H2zrx
   F9lCrO6C9ATTyRUTkNjd1n56wg7S2/RB/6w53BNUhnnl8SeaftG6wVHPq
   cGU76fFa64qmlqs/tAfnXJtFIxxGnys0NIQbG+juoddULggTTkY3+tr22
   QGM6UO1d5VxoOwkZC9kt+TAOkou58mO5wqrnwG17+8LdkcYIvCqj+tMnF
   ykdtCm93nDkQeiA6X2JHmbImUwrCc4xbcplq2u3d3Es27voA+nGwNIo5q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359832922"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="359832922"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:52:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723649568"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="723649568"
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
Subject: [PATCH v4 11/17] iommufd: Add IOMMU_HWPT_INVALIDATE
Date:   Thu, 21 Sep 2023 00:51:32 -0700
Message-Id: <20230921075138.124099-12-yi.l.liu@intel.com>
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

In nested translation, the stage-1 page table is user-managed but cached
by the IOMMU hardware, so an update on present page table entries in the
stage-1 page table should be followed with a cache invalidation.

Add an IOMMU_HWPT_INVALIDATE ioctl to support such a cache invalidation.
It takes hwpt_id to specify the iommu_domain, and a multi-entry array to
support multiple invalidation requests in one ioctl.

Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c    | 33 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  9 +++++++
 drivers/iommu/iommufd/main.c            |  3 +++
 include/uapi/linux/iommufd.h            | 29 ++++++++++++++++++++++
 4 files changed, 74 insertions(+)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index ab25de149ae6..72c46de1396b 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -382,3 +382,36 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(&idev->obj);
 	return rc;
 }
+
+int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_hwpt_invalidate *cmd = ucmd->cmd;
+	struct iommu_user_data_array data_array = {
+		.uptr = u64_to_user_ptr(cmd->reqs_uptr),
+		.entry_len = cmd->req_len,
+		.entry_num = cmd->req_num,
+	};
+	struct iommufd_hw_pagetable *hwpt;
+	int rc = 0;
+
+	if (!cmd->req_len || !cmd->req_num)
+		return -EOPNOTSUPP;
+
+	hwpt = iommufd_get_hwpt(ucmd, cmd->hwpt_id);
+	if (IS_ERR(hwpt))
+		return PTR_ERR(hwpt);
+
+	if (!hwpt->user_managed) {
+		rc = -EINVAL;
+		goto out_put_hwpt;
+	}
+
+	rc = hwpt->domain->ops->cache_invalidate_user(hwpt->domain, &data_array,
+						      &cmd->out_driver_error_code);
+	cmd->req_num = data_array.entry_num;
+	if (iommufd_ucmd_respond(ucmd, sizeof(*cmd)))
+		return -EFAULT;
+out_put_hwpt:
+	iommufd_put_object(&hwpt->obj);
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index b14f23d3f42e..bdbc8dac2fd8 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -270,6 +270,7 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev);
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 void iommufd_hw_pagetable_abort(struct iommufd_object *obj);
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd);
+int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd);
 
 static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
 					    struct iommufd_hw_pagetable *hwpt)
@@ -281,6 +282,14 @@ static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
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
 static inline bool
 iommufd_hw_pagetable_compare_ioas(struct iommufd_hw_pagetable *old_hwpt,
 				  struct iommufd_hw_pagetable *new_hwpt)
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index e71523cbd0de..d9d82a413105 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -307,6 +307,7 @@ union ucmd_buffer {
 	struct iommu_destroy destroy;
 	struct iommu_hw_info info;
 	struct iommu_hwpt_alloc hwpt;
+	struct iommu_hwpt_invalidate cache;
 	struct iommu_ioas_alloc alloc;
 	struct iommu_ioas_allow_iovas allow_iovas;
 	struct iommu_ioas_copy ioas_copy;
@@ -342,6 +343,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
 		 __reserved),
+	IOCTL_OP(IOMMU_HWPT_INVALIDATE, iommufd_hwpt_invalidate,
+		 struct iommu_hwpt_invalidate, out_driver_error_code),
 	IOCTL_OP(IOMMU_IOAS_ALLOC, iommufd_ioas_alloc_ioctl,
 		 struct iommu_ioas_alloc, out_ioas_id),
 	IOCTL_OP(IOMMU_IOAS_ALLOW_IOVAS, iommufd_ioas_allow_iovas,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index c46b1f772f20..2083a0309a9b 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -47,6 +47,7 @@ enum {
 	IOMMUFD_CMD_VFIO_IOAS,
 	IOMMUFD_CMD_HWPT_ALLOC,
 	IOMMUFD_CMD_GET_HW_INFO,
+	IOMMUFD_CMD_HWPT_INVALIDATE,
 };
 
 /**
@@ -478,4 +479,32 @@ struct iommu_hw_info {
 	__u32 __reserved;
 };
 #define IOMMU_GET_HW_INFO _IO(IOMMUFD_TYPE, IOMMUFD_CMD_GET_HW_INFO)
+
+/**
+ * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
+ * @size: sizeof(struct iommu_hwpt_invalidate)
+ * @hwpt_id: HWPT ID of target hardware page table for cache invalidation
+ * @reqs_uptr: User pointer to an array having @req_num of cache invalidation
+ *             requests. The request entries in the array are of fixed width
+ *             @req_len, and contain a user data structure for invalidation
+ *             request specific to the given hardware page table.
+ * @req_len: Length (in bytes) of a request entry in the request array
+ * @req_num: Input the number of cache invalidation requests in the array.
+ *           Output the number of requests successfully handled by kernel.
+ * @out_driver_error_code: Report a driver speicifc error code upon failure
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
+	__u32 req_len;
+	__u32 req_num;
+	__u32 out_driver_error_code;
+};
+#define IOMMU_HWPT_INVALIDATE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_INVALIDATE)
 #endif
-- 
2.34.1

