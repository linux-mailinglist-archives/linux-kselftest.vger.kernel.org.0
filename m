Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAAF77E13F
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 14:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245013AbjHPMPI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 08:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245020AbjHPMOo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 08:14:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A12A26B1;
        Wed, 16 Aug 2023 05:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692188073; x=1723724073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ye1SulAoG6uMzFmXmoR4+YCAfg2x1k0MDBtRACWA40M=;
  b=MrTc2Z+MeElggWysdg9rkxsJK+/ep1Pxaffw5OPNesTDYHerxdnQeEYl
   IhiguDNHnaq6JIR4LKxtoi1lSRGD7Xq1u0XNK4vvJYXhyHUjrsBdzWaKc
   LsnxZ10xsEG3xf5ekrgAgL/0Tt+aGw/ygaUK+7+uj2KO5Z8B0AkK93eZ5
   b3GZ6MZBWvCxmLdysONOcRwoo92AWFQeNaYwFlgWebS0s18Td3BNtu71L
   ik3uRwW0/0t7h6W9fCfolZN9Wl2pKgU/ybdkYTfdq5HEMr5YyW5bJ6lKp
   dtOjVDAM4c90+DLdWeQoR1DeaXtb3M5oJpDkmcNltT4PJWzzRzIrWZVP0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436411658"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="436411658"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 05:14:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="727730772"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="727730772"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga007.jf.intel.com with ESMTP; 16 Aug 2023 05:14:10 -0700
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
Subject: [PATCH v8 3/5] iommufd: Add IOMMU_GET_HW_INFO
Date:   Wed, 16 Aug 2023 05:13:47 -0700
Message-Id: <20230816121349.104436-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816121349.104436-1-yi.l.liu@intel.com>
References: <20230816121349.104436-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Under nested IOMMU translation, userspace owns the stage-1 translation
table (e.g. the stage-1 page table of Intel VT-d or the context table of
ARM SMMUv3, and etc.). Stage-1 translation tables are vendor specific, and
need to be compatible with the underlying IOMMU hardware. Hence, userspace
should know the IOMMU hardware capability before creating and configuring
the stage-1 translation table to kernel.

This adds IOMMU_GET_HW_INFO ioctl to query the IOMMU hardware information
(a.k.a capability) for a given device. The returned data is vendor
specific, userspace needs to decode it with the structure by the output
@out_data_type field.

As only physical devices have IOMMU hardware, so this will return error if
the given device is not a physical device.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 73 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/main.c            |  3 +
 include/uapi/linux/iommufd.h            | 42 ++++++++++++++
 4 files changed, 119 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 90f88c295ce0..36dff7ca3ae4 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -4,6 +4,7 @@
 #include <linux/iommufd.h>
 #include <linux/slab.h>
 #include <linux/iommu.h>
+#include <uapi/linux/iommufd.h>
 #include "../iommu-priv.h"
 
 #include "io_pagetable.h"
@@ -1119,3 +1120,75 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_rw, IOMMUFD);
+
+int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_hw_info *cmd = ucmd->cmd;
+	void __user *user_ptr = u64_to_user_ptr(cmd->data_uptr);
+	const struct iommu_ops *ops;
+	struct iommufd_device *idev;
+	unsigned int data_len;
+	unsigned int copy_len;
+	void *data = NULL;
+	int rc;
+
+	if (cmd->flags || cmd->__reserved)
+		return -EOPNOTSUPP;
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	ops = dev_iommu_ops(idev->dev);
+	if (ops->hw_info) {
+		data = ops->hw_info(idev->dev, &data_len, &cmd->out_data_type);
+		if (IS_ERR(data)) {
+			rc = PTR_ERR(data);
+			goto err_put;
+		}
+
+		/*
+		 * drivers that have hw_info callback should have a unique
+		 * iommu_hw_info_type.
+		 */
+		if (WARN_ON_ONCE(cmd->out_data_type ==
+				 IOMMU_HW_INFO_TYPE_NONE)) {
+			rc = -ENODEV;
+			goto out;
+		}
+	} else {
+		cmd->out_data_type = IOMMU_HW_INFO_TYPE_NONE;
+		data_len = 0;
+		data = NULL;
+	}
+
+	copy_len = min(cmd->data_len, data_len);
+	if (copy_to_user(user_ptr, data, copy_len)) {
+		rc = -EFAULT;
+		goto out;
+	}
+
+	/*
+	 * Zero the trailing bytes if the user buffer is bigger than the
+	 * data size kernel actually has.
+	 */
+	if (copy_len < cmd->data_len) {
+		if (clear_user(user_ptr + copy_len, cmd->data_len - copy_len)) {
+			rc = -EFAULT;
+			goto out;
+		}
+	}
+
+	/*
+	 * We return the length the kernel supports so userspace may know what
+	 * the kernel capability is. It could be larger than the input buffer.
+	 */
+	cmd->data_len = data_len;
+
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+out:
+	kfree(data);
+err_put:
+	iommufd_put_object(&idev->obj);
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 5a45b8ba2e26..2c58670011fe 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -296,6 +296,7 @@ iommufd_get_device(struct iommufd_ucmd *ucmd, u32 id)
 }
 
 void iommufd_device_destroy(struct iommufd_object *obj);
+int iommufd_get_hw_info(struct iommufd_ucmd *ucmd);
 
 struct iommufd_access {
 	struct iommufd_object obj;
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 5f7e9fa45502..e71523cbd0de 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -305,6 +305,7 @@ static int iommufd_option(struct iommufd_ucmd *ucmd)
 
 union ucmd_buffer {
 	struct iommu_destroy destroy;
+	struct iommu_hw_info info;
 	struct iommu_hwpt_alloc hwpt;
 	struct iommu_ioas_alloc alloc;
 	struct iommu_ioas_allow_iovas allow_iovas;
@@ -337,6 +338,8 @@ struct iommufd_ioctl_op {
 	}
 static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct iommu_destroy, id),
+	IOCTL_OP(IOMMU_GET_HW_INFO, iommufd_get_hw_info, struct iommu_hw_info,
+		 __reserved),
 	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
 		 __reserved),
 	IOCTL_OP(IOMMU_IOAS_ALLOC, iommufd_ioas_alloc_ioctl,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index ac11ace21edb..09d5e9cff7b3 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -46,6 +46,7 @@ enum {
 	IOMMUFD_CMD_OPTION,
 	IOMMUFD_CMD_VFIO_IOAS,
 	IOMMUFD_CMD_HWPT_ALLOC,
+	IOMMUFD_CMD_GET_HW_INFO,
 };
 
 /**
@@ -379,4 +380,45 @@ struct iommu_hwpt_alloc {
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_NONE,
 };
+
+/**
+ * struct iommu_hw_info - ioctl(IOMMU_GET_HW_INFO)
+ * @size: sizeof(struct iommu_hw_info)
+ * @flags: Must be 0
+ * @dev_id: The device bound to the iommufd
+ * @data_len: Input the length of a user buffer in bytes. Output the length of
+ *            data that kernel supports
+ * @data_uptr: User pointer to a user-space buffer used by the kernel to fill
+ *             the iommu type specific hardware information data
+ * @out_data_type: Output the iommu hardware info type as defined in the enum
+ *                 iommu_hw_info_type.
+ * @__reserved: Must be 0
+ *
+ * Query an iommu type specific hardware information data from an iommu behind
+ * a given device that has been bound to iommufd. This hardware info data will
+ * be used to sync capabilities between the virtual iommu and the physical
+ * iommu, e.g. a nested translation setup needs to check the hardware info, so
+ * a guest stage-1 page table can be compatible with the physical iommu.
+ *
+ * To capture an iommu type specific hardware information data, @data_uptr and
+ * its length @data_len must be provided. Trailing bytes will be zeroed if the
+ * user buffer is larger than the data that kernel has. Otherwise, kernel only
+ * fills the buffer using the given length in @data_len. If the ioctl succeeds,
+ * @data_len will be updated to the length that kernel actually supports,
+ * @out_data_type will be filled to decode the data filled in the buffer
+ * pointed by @data_uptr. Input @data_len == zero is allowed, no information
+ * data will be filled to user, but user space could get the iommu_hw_info_type
+ * filled in @out_data_type and the iommu hardware information data length
+ * supported by kernel filled in @data_len.
+ */
+struct iommu_hw_info {
+	__u32 size;
+	__u32 flags;
+	__u32 dev_id;
+	__u32 data_len;
+	__aligned_u64 data_uptr;
+	__u32 out_data_type;
+	__u32 __reserved;
+};
+#define IOMMU_GET_HW_INFO _IO(IOMMUFD_TYPE, IOMMUFD_CMD_GET_HW_INFO)
 #endif
-- 
2.34.1

