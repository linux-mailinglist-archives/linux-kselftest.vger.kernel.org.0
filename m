Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59307D0B93
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 11:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376671AbjJTJYf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 05:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376656AbjJTJYe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 05:24:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FD0106;
        Fri, 20 Oct 2023 02:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697793872; x=1729329872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2PM7o5xYDJmlHz5TKehP6+0yc9LVqHG0PRNTYo4xOBg=;
  b=fq/1VI6XpsOhLLNmLf5+YnjRcUCYmRoFWDAlr5xfaHprjM3de/ybrSHp
   2uWsqEWXHrFptgZj4xejTFq69hC7WJDrtQdl6kODYC33lonxRtg4QRCIl
   WxjbpDavMinwmzUo1Vz2f1wzmcr1LRnhrqIuOX+EZabwqdfB3ZrHz0PnD
   EDAzy3wdsEF8/fNMQhTguB6K8Ur1cgsAwo7BrjWhHos7ezJH486d4INrx
   xIKDPNMFJ4voOoot3AqjW3zUFbK6OLGJlQQKjeZm7bpg5IaVmSXn7ieQp
   lIv5BwefLL4KdaT9V3+H/BaW8UZaWzGRQWvF/gFELEfohp6T3hjaDCXPx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="472685474"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="472685474"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:24:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="750859673"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="750859673"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga007.jf.intel.com with ESMTP; 20 Oct 2023 02:24:29 -0700
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
Subject: [PATCH v5 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Date:   Fri, 20 Oct 2023 02:24:22 -0700
Message-Id: <20231020092426.13907-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020092426.13907-1-yi.l.liu@intel.com>
References: <20231020092426.13907-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Check cache_invalidate_user op in the iommufd_hw_pagetable_alloc_nested,
since all nested domains need that.

Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c    | 35 ++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  9 +++++++
 drivers/iommu/iommufd/main.c            |  3 +++
 include/uapi/linux/iommufd.h            | 36 +++++++++++++++++++++++++
 4 files changed, 83 insertions(+)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 362c694aac9b..6090d59c4982 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -238,6 +238,11 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 		rc = -EINVAL;
 		goto out_abort;
 	}
+	/* Driver is buggy by missing cache_invalidate_user in domain_ops */
+	if (WARN_ON_ONCE(!hwpt->domain->ops->cache_invalidate_user)) {
+		rc = -EINVAL;
+		goto out_abort;
+	}
 	return hwpt_nested;
 
 out_abort:
@@ -323,3 +328,33 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(&idev->obj);
 	return rc;
 }
+
+int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_hwpt_invalidate *cmd = ucmd->cmd;
+	struct iommu_user_data_array data_array = {
+		.type = cmd->req_type,
+		.uptr = u64_to_user_ptr(cmd->reqs_uptr),
+		.entry_len = cmd->req_len,
+		.entry_num = cmd->req_num,
+	};
+	struct iommufd_hw_pagetable *hwpt;
+	int rc = 0;
+
+	if (cmd->req_type == IOMMU_HWPT_DATA_NONE)
+		return -EINVAL;
+	if (!cmd->reqs_uptr || !cmd->req_len || !cmd->req_num)
+		return -EINVAL;
+
+	hwpt = iommufd_hw_pagetable_get_nested(ucmd, cmd->hwpt_id);
+	if (IS_ERR(hwpt))
+		return PTR_ERR(hwpt);
+
+	rc = hwpt->domain->ops->cache_invalidate_user(hwpt->domain, &data_array,
+						      &cmd->out_driver_error_code);
+	cmd->req_num = data_array.entry_num;
+	if (iommufd_ucmd_respond(ucmd, sizeof(*cmd)))
+		return -EFAULT;
+	iommufd_put_object(&hwpt->obj);
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index a829458fe762..7ec629599844 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -279,6 +279,7 @@ void iommufd_hwpt_paging_abort(struct iommufd_object *obj);
 void iommufd_hwpt_nested_destroy(struct iommufd_object *obj);
 void iommufd_hwpt_nested_abort(struct iommufd_object *obj);
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd);
+int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd);
 
 static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
 					    struct iommufd_hw_pagetable *hwpt)
@@ -300,6 +301,14 @@ static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
 	refcount_dec(&hwpt->obj.users);
 }
 
+static inline struct iommufd_hw_pagetable *
+iommufd_hw_pagetable_get_nested(struct iommufd_ucmd *ucmd, u32 id)
+{
+	return container_of(iommufd_get_object(ucmd->ictx, id,
+					       IOMMUFD_OBJ_HWPT_NESTED),
+			    struct iommufd_hw_pagetable, obj);
+}
+
 struct iommufd_group {
 	struct kref ref;
 	struct mutex lock;
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index f94c14f20918..1f2d2d262e12 100644
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
index d82bc663c5cd..fc305a48ab81 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -47,6 +47,7 @@ enum {
 	IOMMUFD_CMD_VFIO_IOAS,
 	IOMMUFD_CMD_HWPT_ALLOC,
 	IOMMUFD_CMD_GET_HW_INFO,
+	IOMMUFD_CMD_HWPT_INVALIDATE,
 };
 
 /**
@@ -477,4 +478,39 @@ struct iommu_hw_info {
 	__u32 __reserved;
 };
 #define IOMMU_GET_HW_INFO _IO(IOMMUFD_TYPE, IOMMUFD_CMD_GET_HW_INFO)
+
+/**
+ * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
+ * @size: sizeof(struct iommu_hwpt_invalidate)
+ * @hwpt_id: HWPT ID of a nested HWPT for cache invalidation
+ * @reqs_uptr: User pointer to an array having @req_num of cache invalidation
+ *             requests. The request entries in the array are of fixed width
+ *             @req_len, and contain a user data structure for invalidation
+ *             request specific to the given hardware page table.
+ * @req_type: One of enum iommu_hwpt_data_type, defining the data type of all
+ *            the entries in the invalidation request array. It should suit
+ *            with the data_type passed per the allocation of the hwpt pointed
+ *            by @hwpt_id.
+ * @req_len: Length (in bytes) of a request entry in the request array
+ * @req_num: Input the number of cache invalidation requests in the array.
+ *           Output the number of requests successfully handled by kernel.
+ * @out_driver_error_code: Report a driver speicifc error code upon failure.
+ *                         It's optional, driver has a choice to fill it or
+ *                         not.
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
+	__u32 req_type;
+	__u32 req_len;
+	__u32 req_num;
+	__u32 out_driver_error_code;
+};
+#define IOMMU_HWPT_INVALIDATE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_INVALIDATE)
 #endif
-- 
2.34.1

