Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD56C7787EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 09:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjHKHPT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 03:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjHKHPS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 03:15:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED75E2D62;
        Fri, 11 Aug 2023 00:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691738114; x=1723274114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gCJktmK5o0cydziEmxh2sPqTHYC5v83xLEcNI/dUrtw=;
  b=Pw68uaC2OQ6m5A18hBhRdQmIYXERuXksxYwHhW+SJGoE2DKUUnzMYsET
   6DfoK0M2GgQ1wo1N0FffeyIDNO3UFXcedIJX40wwMvYCGPJRyf1jsIOtt
   XLePt3qjs3mUL5UeLYzVmHcH3RNQdaxv32zBBVVw81CmT71OzakiMP/YW
   RsC/rYFDI49XNX03wA9IVGgvruTMEwNyZVTJPjN1+vg/nB7eTNwmfdoN3
   vy/LQlnNv5882BOvxN7iPJBiE6RV2fs4RC8247+D7ujVIspS5If6Q514J
   CsbCyBSNKmMwku1ul8eskEcowi3CE9bgX7shYISJNZL1OYyU1iciWtWBX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="351937694"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="351937694"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 00:15:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="979142007"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="979142007"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga006.fm.intel.com with ESMTP; 11 Aug 2023 00:15:06 -0700
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
Subject: [PATCH v7 3/4] iommufd: Add IOMMU_GET_HW_INFO
Date:   Fri, 11 Aug 2023 00:15:00 -0700
Message-Id: <20230811071501.4126-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811071501.4126-1-yi.l.liu@intel.com>
References: <20230811071501.4126-1-yi.l.liu@intel.com>
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

Under nested IOMMU translation, userspace owns the stage-1 translation
table (e.g. the stage-1 page table of Intel VT-d or the context table
of ARM SMMUv3, and etc.). Stage-1 translation tables are vendor specific,
and need to be compatible with the underlying IOMMU hardware. Hence,
userspace should know the IOMMU hardware capability before creating and
configuring the stage-1 translation table to kernel.

This adds IOMMU_GET_HW_INFO ioctl to query the IOMMU hardware information
(a.k.a capability) for a given device. The returned data is vendor specific,
userspace needs to decode it with the structure mapped by the @out_data_type
field.

As only physical devices have IOMMU hardware, so this will return error
if the given device is not a physical device.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/main.c | 85 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/iommufd.h | 36 +++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 94c498b8fdf6..d459811c5381 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -17,6 +17,7 @@
 #include <linux/bug.h>
 #include <uapi/linux/iommufd.h>
 #include <linux/iommufd.h>
+#include "../iommu-priv.h"
 
 #include "io_pagetable.h"
 #include "iommufd_private.h"
@@ -177,6 +178,87 @@ static int iommufd_destroy(struct iommufd_ucmd *ucmd)
 	return 0;
 }
 
+static int iommufd_fill_hw_info(struct device *dev, void __user *user_ptr,
+				unsigned int *length, u32 *type)
+{
+	const struct iommu_ops *ops;
+	unsigned int data_len;
+	void *data;
+	int rc = 0;
+
+	ops = dev_iommu_ops(dev);
+	if (!ops->hw_info) {
+		*length = 0;
+		*type = IOMMU_HW_INFO_TYPE_NONE;
+		return 0;
+	}
+
+	data = ops->hw_info(dev, &data_len, type);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	/*
+	 * drivers that have hw_info callback should have a unique
+	 * iommu_hw_info_type.
+	 */
+	if (WARN_ON_ONCE(*type == IOMMU_HW_INFO_TYPE_NONE)) {
+		rc = -ENODEV;
+		goto err_free;
+	}
+
+	*length = min(*length, data_len);
+	if (copy_to_user(user_ptr, data, *length)) {
+		rc = -EFAULT;
+		goto err_free;
+	}
+
+err_free:
+	kfree(data);
+	return rc;
+}
+
+static int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_hw_info *cmd = ucmd->cmd;
+	unsigned int length = cmd->data_len;
+	struct iommufd_device *idev;
+	void __user *user_ptr;
+	u32 hw_info_type;
+	int rc = 0;
+
+	if (cmd->flags || cmd->__reserved || !cmd->data_len)
+		return -EOPNOTSUPP;
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	user_ptr = u64_to_user_ptr(cmd->data_ptr);
+
+	rc = iommufd_fill_hw_info(idev->dev, user_ptr,
+				  &length, &hw_info_type);
+	if (rc)
+		goto err_put;
+
+	/*
+	 * Zero the trailing bytes if the user buffer is bigger than the
+	 * data size kernel actually has.
+	 */
+	if (length < cmd->data_len) {
+		rc = clear_user(user_ptr + length, cmd->data_len - length);
+		if (rc)
+			goto err_put;
+	}
+
+	cmd->data_len = length;
+	cmd->out_data_type = hw_info_type;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+
+err_put:
+	iommufd_put_object(&idev->obj);
+	return rc;
+}
+
 static int iommufd_fops_open(struct inode *inode, struct file *filp)
 {
 	struct iommufd_ctx *ictx;
@@ -265,6 +347,7 @@ static int iommufd_option(struct iommufd_ucmd *ucmd)
 
 union ucmd_buffer {
 	struct iommu_destroy destroy;
+	struct iommu_hw_info info;
 	struct iommu_hwpt_alloc hwpt;
 	struct iommu_ioas_alloc alloc;
 	struct iommu_ioas_allow_iovas allow_iovas;
@@ -297,6 +380,8 @@ struct iommufd_ioctl_op {
 	}
 static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct iommu_destroy, id),
+	IOCTL_OP(IOMMU_GET_HW_INFO, iommufd_get_hw_info, struct iommu_hw_info,
+		 __reserved),
 	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
 		 __reserved),
 	IOCTL_OP(IOMMU_IOAS_ALLOC, iommufd_ioas_alloc_ioctl,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index ac11ace21edb..4a00f8fb2d54 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -46,6 +46,7 @@ enum {
 	IOMMUFD_CMD_OPTION,
 	IOMMUFD_CMD_VFIO_IOAS,
 	IOMMUFD_CMD_HWPT_ALLOC,
+	IOMMUFD_CMD_GET_HW_INFO,
 };
 
 /**
@@ -379,4 +380,39 @@ struct iommu_hwpt_alloc {
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_NONE,
 };
+
+/**
+ * struct iommu_hw_info - ioctl(IOMMU_GET_HW_INFO)
+ * @size: sizeof(struct iommu_hw_info)
+ * @flags: Must be 0
+ * @dev_id: The device bound to the iommufd
+ * @data_len: Input the length of the user buffer in bytes. Output the length
+ *            of data filled in the user buffer.
+ * @data_ptr: Pointer to the user buffer
+ * @out_data_type: Output the iommu hardware info type as defined in the enum
+ *                 iommu_hw_info_type.
+ * @__reserved: Must be 0
+ *
+ * Query the hardware information from an iommu behind a given device that has
+ * been bound to iommufd. @data_len is the size of the buffer, which captures an
+ * iommu type specific input data and a filled output data. Trailing bytes will
+ * be zeroed if the user buffer is larger than the data kernel has.
+ *
+ * The type specific data would be used to sync capabilities between the virtual
+ * IOMMU and the hardware IOMMU, e.g. a nested translation setup needs to check
+ * the hardware information, so the guest stage-1 page table will be compatible.
+ *
+ * The @out_data_type will be filled if the ioctl succeeds. It would be used to
+ * decode the data filled in the buffer pointed by @data_ptr.
+ */
+struct iommu_hw_info {
+	__u32 size;
+	__u32 flags;
+	__u32 dev_id;
+	__u32 data_len;
+	__aligned_u64 data_ptr;
+	__u32 out_data_type;
+	__u32 __reserved;
+};
+#define IOMMU_GET_HW_INFO _IO(IOMMUFD_TYPE, IOMMUFD_CMD_GET_HW_INFO)
 #endif
-- 
2.34.1

