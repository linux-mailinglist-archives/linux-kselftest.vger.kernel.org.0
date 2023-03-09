Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CE66B1D67
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 09:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjCIIJs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 03:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCIIJk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 03:09:40 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B28888AC;
        Thu,  9 Mar 2023 00:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678349379; x=1709885379;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z7V/YOwn030poZpCpEChyw8MC+7YqADB7tm3JIqLGIM=;
  b=gB//xKSLLn5/juX7z0zPe9bJIFF8HtlM0FR/zPGydo8JxtnLppIdxJbI
   dNOw8twirYUQg5m27vHPFgF1+HZiwWEW0wVUNq4oqGfWZsZ5mRyFlHbrg
   KtSlk1srLc1KvotH/tIISpzB1WF9NMn4i8QgHhHLuLO6MZHuOTqngIyvC
   ZaOPGsqFQBF83xVAs2FFPC3cKmx3mwTgf2IULEShAoAiDCG+3091olMul
   qVTAvW6UGT85nQGnYEkxSM37JmITK2hj5x5pLbwxTphyRRJtoOpv+wmVG
   Wjo42jF1RAh9zUlpjWCMXAefxaf2ud6LBp9OqVLVnwBBnEn8YpCDxlUdg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364023131"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364023131"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787471396"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787471396"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2023 00:09:31 -0800
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
Subject: [PATCH 08/12] iommufd/device: Report supported hwpt_types
Date:   Thu,  9 Mar 2023 00:09:06 -0800
Message-Id: <20230309080910.607396-9-yi.l.liu@intel.com>
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

This provides a way for userspace to probe the supported hwpt data
types by kernel. Currently, kernel only supports IOMMU_HWPT_TYPE_DEFAULT,
new types would be added per vendor drivers' extension.

Userspace that wants to allocate hw_pagetable with user data should check
this. While for the allocation without user data, no need for it. It is
supported by default.

Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          |  1 +
 drivers/iommu/iommufd/hw_pagetable.c    | 18 +++++++++++++++---
 drivers/iommu/iommufd/iommufd_private.h |  2 ++
 drivers/iommu/iommufd/main.c            |  2 +-
 include/uapi/linux/iommufd.h            |  8 ++++++++
 5 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 19cd6df46c6a..0328071dcac1 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -322,6 +322,7 @@ int iommufd_device_get_hw_info(struct iommufd_ucmd *ucmd)
 
 	cmd->out_data_type = ops->driver_type;
 	cmd->data_len = length;
+	cmd->out_hwpt_type_bitmap = iommufd_hwpt_type_bitmaps[ops->driver_type];
 
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 67facca98de1..160712256c64 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -173,6 +173,14 @@ static const size_t iommufd_hwpt_alloc_data_size[] = {
 	[IOMMU_HWPT_TYPE_DEFAULT] = 0,
 };
 
+/*
+ * bitmaps of supported hwpt types of by underlying iommu, indexed
+ * by ops->driver_type which is one of enum iommu_hw_info_type.
+ */
+const u64 iommufd_hwpt_type_bitmaps[] =  {
+	[IOMMU_HW_INFO_TYPE_DEFAULT] = BIT_ULL(IOMMU_HWPT_TYPE_DEFAULT),
+};
+
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
@@ -182,7 +190,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	struct iommufd_ioas *ioas;
 	const struct iommu_ops *ops;
 	void *data = NULL;
-	u32 klen;
+	u32 driver_type, klen;
 	int rc;
 
 	if (cmd->__reserved || cmd->flags)
@@ -198,8 +206,12 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		goto out_put_idev;
 	}
 
-	/* Only support IOMMU_HWPT_TYPE_DEFAULT for now */
-	if (cmd->data_type != IOMMU_HWPT_TYPE_DEFAULT) {
+	driver_type = ops->driver_type;
+
+	/* data_type should be a supported type by the driver */
+	if (WARN_ON(driver_type >= ARRAY_SIZE(iommufd_hwpt_type_bitmaps)) ||
+	    !((1 << cmd->data_type) &
+			iommufd_hwpt_type_bitmaps[driver_type])) {
 		rc = -EINVAL;
 		goto out_put_idev;
 	}
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index d879264d1acf..164ccfc2e6e0 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -321,6 +321,8 @@ iommufd_get_device(struct iommufd_ucmd *ucmd, u32 id)
 void iommufd_device_destroy(struct iommufd_object *obj);
 int iommufd_device_get_hw_info(struct iommufd_ucmd *ucmd);
 
+extern const u64 iommufd_hwpt_type_bitmaps[];
+
 struct iommufd_access {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 2cf45f65b637..7ec3ceac01b3 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -298,7 +298,7 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
 		 data_uptr),
 	IOCTL_OP(IOMMU_DEVICE_GET_HW_INFO, iommufd_device_get_hw_info,
-		 struct iommu_hw_info, __reserved),
+		 struct iommu_hw_info, out_hwpt_type_bitmap),
 	IOCTL_OP(IOMMU_HWPT_INVALIDATE, iommufd_hwpt_invalidate,
 		 struct iommu_hwpt_invalidate, data_uptr),
 	IOCTL_OP(IOMMU_IOAS_ALLOC, iommufd_ioas_alloc_ioctl,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index d0962c41f8d6..e2eff9c56ab3 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -421,6 +421,8 @@ enum iommu_hw_info_type {
  * @out_data_type: Output the iommu hardware info type, it is one of
  *                 enum iommu_hw_info_type.
  * @__reserved: Must be 0
+ * @out_hwpt_type_bitmap: Output the supported page table type. Each
+ *                        bit is defined in enum iommu_hwpt_type.
  *
  * Query the hardware iommu information for given device which has been
  * bound to iommufd. @data_len is the size of the buffer which captures
@@ -435,6 +437,11 @@ enum iommu_hw_info_type {
  * The @out_data_type will be filled if the ioctl succeeds. It would
  * be used to decode the data filled in the buffer pointed by @data_ptr.
  *
+ * @out_hwpt_type_bitmap reports the supported hwpt types. This differs
+ * per the @out_data_type. Userspace should check it before allocating a
+ * user-managed hw_pagetable with user data, unless it allocates a default
+ * hw_pagetable that does not need user data.
+ *
  * This is only available for the physical devices bound to iommufd as
  * only physical devices can have hardware IOMMU.
  */
@@ -446,6 +453,7 @@ struct iommu_hw_info {
 	__aligned_u64 data_ptr;
 	__u32 out_data_type;
 	__u32 __reserved;
+	__aligned_u64 out_hwpt_type_bitmap;
 };
 #define IOMMU_DEVICE_GET_HW_INFO _IO(IOMMUFD_TYPE, IOMMUFD_CMD_DEVICE_GET_HW_INFO)
 
-- 
2.34.1

