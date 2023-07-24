Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D925A75F412
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 13:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjGXLAO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 07:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjGXLAI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 07:00:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA4E10DF;
        Mon, 24 Jul 2023 03:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196393; x=1721732393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xYkMSW5qD0YHa2R7bbKOsw7d8LA6llKISx1RD7rwZpI=;
  b=mdu2ucBrATUz6QPGjh0QU3dy7jKF/D31UoNmoOifBK3+EtkjMGrsjcAU
   INdwXaye/Dk46NytdrG+cKL2qlN4r6X/ZGUvsQUUH/2zuXkdC4M7nqHQi
   N0Ok0MiI+XOBKiywyEiB/OYvgPcx/3T1yfQa2UwPbv8O5vME8cdDtw4Qh
   pGD48LbHPg4yR5esnJnZbxyJaDQAntUznAD19uLtZvpDOPB3LG3pqLymY
   79g76AwO2txkQKm+FtsjhBiCpx6KVNZDs2wNH7PijF8sm1K2A/80Eryhg
   NT7MNI5/o6FGNtJq+tS4JafAXGZQObFPce1nN8zjJcqcb9DGsbEwYEoI9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347012274"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347012274"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 03:59:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="839409094"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="839409094"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2023 03:59:43 -0700
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
Subject: [PATCH v4 3/4] iommufd: Add IOMMU_GET_HW_INFO
Date:   Mon, 24 Jul 2023 03:59:35 -0700
Message-Id: <20230724105936.107042-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724105936.107042-1-yi.l.liu@intel.com>
References: <20230724105936.107042-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Under nested IOMMU translation, userspace owns the stage-1 translation
table (e.g. the stage-1 page table of Intel VT-d or the context table
of ARM SMMUv3, and etc.). Stage-1 translation tables are vendor specific,
and need to be compatiable with the underlying IOMMU hardware. Hence,
userspace should know the IOMMU hardware capability before creating and
configuring the stage-1 translation table to kernel.

This adds IOMMU_GET_HW_INFO ioctl to query the IOMMU hardware information
for a given device. The returned data is vendor specific, userspace needs
to decode it with the structure mapped by the @out_data_type field.

As only physical devices have IOMMU hardware, so this will return error
if the given device is not a physical device.

Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/main.c | 76 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/iommufd.h | 36 +++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 94c498b8fdf6..bd3efc1d8509 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -17,6 +17,7 @@
 #include <linux/bug.h>
 #include <uapi/linux/iommufd.h>
 #include <linux/iommufd.h>
+#include "../iommu-priv.h"
 
 #include "io_pagetable.h"
 #include "iommufd_private.h"
@@ -177,6 +178,78 @@ static int iommufd_destroy(struct iommufd_ucmd *ucmd)
 	return 0;
 }
 
+static int iommufd_zero_fill_user(u64 ptr, int bytes)
+{
+	int index = 0;
+
+	for (; index < bytes; index++) {
+		if (put_user(0, (uint8_t __user *)u64_to_user_ptr(ptr + index)))
+			return -EFAULT;
+	}
+	return 0;
+}
+
+static int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_hw_info *cmd = ucmd->cmd;
+	unsigned int length = 0, data_len;
+	struct iommufd_device *idev;
+	const struct iommu_ops *ops;
+	void *data = NULL;
+	int rc = 0;
+
+	if (cmd->flags || cmd->__reserved || !cmd->data_len)
+		return -EOPNOTSUPP;
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	ops = dev_iommu_ops(idev->dev);
+	if (!ops->hw_info)
+		goto done;
+
+	/* driver has hw_info callback should have a unique hw_info_type */
+	if (WARN_ON_ONCE(ops->hw_info_type == IOMMU_HW_INFO_TYPE_NONE)) {
+		pr_warn_ratelimited("iommu driver set an invalid type\n");
+		rc = -ENODEV;
+		goto out_err;
+	}
+
+	data = ops->hw_info(idev->dev, &data_len);
+	if (IS_ERR(data)) {
+		rc = PTR_ERR(data);
+		goto out_err;
+	}
+
+	length = min(cmd->data_len, data_len);
+	if (copy_to_user(u64_to_user_ptr(cmd->data_ptr), data, length)) {
+		rc = -EFAULT;
+		goto out_err;
+	}
+
+done:
+	/*
+	 * Zero the trailing bytes if the user buffer is bigger than the
+	 * data size kernel actually has.
+	 */
+	if (length < cmd->data_len) {
+		rc = iommufd_zero_fill_user(cmd->data_ptr + length,
+					    cmd->data_len - length);
+		if (rc)
+			goto out_err;
+	}
+
+	cmd->data_len = length;
+	cmd->out_data_type = ops->hw_info_type;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+
+out_err:
+	kfree(data);
+	iommufd_put_object(&idev->obj);
+	return rc;
+}
+
 static int iommufd_fops_open(struct inode *inode, struct file *filp)
 {
 	struct iommufd_ctx *ictx;
@@ -265,6 +338,7 @@ static int iommufd_option(struct iommufd_ucmd *ucmd)
 
 union ucmd_buffer {
 	struct iommu_destroy destroy;
+	struct iommu_hw_info info;
 	struct iommu_hwpt_alloc hwpt;
 	struct iommu_ioas_alloc alloc;
 	struct iommu_ioas_allow_iovas allow_iovas;
@@ -297,6 +371,8 @@ struct iommufd_ioctl_op {
 	}
 static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct iommu_destroy, id),
+	IOCTL_OP(IOMMU_GET_HW_INFO, iommufd_get_hw_info, struct iommu_hw_info,
+		 __reserved),
 	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
 		 __reserved),
 	IOCTL_OP(IOMMU_IOAS_ALLOC, iommufd_ioas_alloc_ioctl,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 1f616b0f8ae0..4295362e7b44 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -46,6 +46,7 @@ enum {
 	IOMMUFD_CMD_OPTION,
 	IOMMUFD_CMD_VFIO_IOAS,
 	IOMMUFD_CMD_HWPT_ALLOC,
+	IOMMUFD_CMD_GET_HW_INFO,
 };
 
 /**
@@ -378,4 +379,39 @@ struct iommu_hwpt_alloc {
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

