Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052A66FF468
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 16:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238583AbjEKOcV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 10:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238490AbjEKObZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 10:31:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9CD11577;
        Thu, 11 May 2023 07:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683815453; x=1715351453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RL/gFeFVo8864ppAdprslg9XDSPQ0Ngd+kRHVSRHTog=;
  b=LX0hhKLEztkBNCyvtIyuXBZfi04gjOVGEJtef6ZqSU9cIZKgGdqO3qTh
   Bfob9Dv/aOGVDUomIAKty68rAffSCUlQlG0aUOvgBrnZTHp4d2ORdvn6f
   /exOv9E8lruDyaNW0eFV+p+SyTWBPGP1YSukwD9Oe7S8sgteUp9F1RP1r
   xQzy9IlzIJAjj/tWT6THiblKeyT5SgA0Y0PDyf2d6rC3cEJsQVOQjkXPm
   nxeubo3k6JwIjmXcrhgnU32LIBx7fsqd3+lI34QU1EbpmhuoMq6h901VE
   6pdK92IOVrAmeb58sNXL3BCR86R0H9g66i4C8hEg3IEXG/5e+/Ytm1dMH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="378639890"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="378639890"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 07:30:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="874004445"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="874004445"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga005.jf.intel.com with ESMTP; 11 May 2023 07:30:31 -0700
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
Subject: [PATCH v3 3/4] iommufd: Add IOMMU_DEVICE_GET_HW_INFO
Date:   Thu, 11 May 2023 07:30:23 -0700
Message-Id: <20230511143024.19542-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511143024.19542-1-yi.l.liu@intel.com>
References: <20230511143024.19542-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Under nested IOMMU translation, userspace owns the stage-1 translation
table (e.g. the stage-1 page table of Intel VT-d or the context table
of ARM SMMUv3, and etc.). Stage-1 translation tables are vendor specific,
and needs to be compatiable with the underlying IOMMU hardware. Hence,
userspace should know the IOMMU hardware capability before creating and
configuring the stage-1 translation table to kernel.

This adds IOMMU_DEVICE_GET_HW_INFO to query the IOMMU hardware information
for a given device. The returned data is vendor specific, userspace needs
to decode it with the structure mapped by the @out_data_type field.

As only physical devices have IOMMU hardware, so this will return error
if the given device is not a physical device.

Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 72 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/main.c            |  3 ++
 include/uapi/linux/iommufd.h            | 37 +++++++++++++
 4 files changed, 113 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 051bd8e99858..bc99d092de8f 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -263,6 +263,78 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, IOMMUFD);
 
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
+int iommufd_device_get_hw_info(struct iommufd_ucmd *ucmd)
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
+	if (ops->hw_info_type == IOMMU_HW_INFO_TYPE_NONE) {
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
+done:
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
 static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 				   struct iommufd_hw_pagetable *hwpt)
 {
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index dba730129b8c..69d6bb61d387 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -308,6 +308,7 @@ iommufd_get_device(struct iommufd_ucmd *ucmd, u32 id)
 }
 
 void iommufd_device_destroy(struct iommufd_object *obj);
+int iommufd_device_get_hw_info(struct iommufd_ucmd *ucmd);
 
 struct iommufd_access {
 	struct iommufd_object obj;
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 3932fe26522b..5c24e8971f09 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -269,6 +269,7 @@ static int iommufd_option(struct iommufd_ucmd *ucmd)
 union ucmd_buffer {
 	struct iommu_destroy destroy;
 	struct iommu_hwpt_alloc hwpt;
+	struct iommu_hw_info info;
 	struct iommu_ioas_alloc alloc;
 	struct iommu_ioas_allow_iovas allow_iovas;
 	struct iommu_ioas_copy ioas_copy;
@@ -302,6 +303,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct iommu_destroy, id),
 	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
 		 __reserved),
+	IOCTL_OP(IOMMU_DEVICE_GET_HW_INFO, iommufd_device_get_hw_info,
+		 struct iommu_hw_info, __reserved),
 	IOCTL_OP(IOMMU_IOAS_ALLOC, iommufd_ioas_alloc_ioctl,
 		 struct iommu_ioas_alloc, out_ioas_id),
 	IOCTL_OP(IOMMU_IOAS_ALLOW_IOVAS, iommufd_ioas_allow_iovas,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 99bf0715f545..e9d42838dcbd 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -46,6 +46,7 @@ enum {
 	IOMMUFD_CMD_OPTION,
 	IOMMUFD_CMD_VFIO_IOAS,
 	IOMMUFD_CMD_HWPT_ALLOC,
+	IOMMUFD_CMD_DEVICE_GET_HW_INFO,
 };
 
 /**
@@ -377,4 +378,40 @@ struct iommu_hwpt_alloc {
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_NONE,
 };
+
+/**
+ * struct iommu_hw_info - ioctl(IOMMU_DEVICE_GET_HW_INFO)
+ * @size: sizeof(struct iommu_hw_info)
+ * @flags: Must be 0
+ * @dev_id: The device bound to the iommufd
+ * @data_len: Input the length of the user buffer in bytes. Output the
+ *            length of data filled in the user buffer.
+ * @data_ptr: Pointer to the user buffer
+ * @out_data_type: Output the iommu hardware info type as defined by
+ *                 enum iommu_hw_info_type.
+ * @__reserved: Must be 0
+ *
+ * Query the hardware iommu information for given device which has been
+ * bound to iommufd. @data_len is the size of the buffer which captures
+ * iommu type specific data and the data will be filled. Trailing bytes
+ * are zeroed if the user buffer is larger than the data kernel has.
+ *
+ * The type specific data would be used to sync capability between the
+ * virtual IOMMU and the hardware IOMMU. e.g. nested translation requires
+ * to check the hardware IOMMU capability so guest stage-1 page table
+ * uses a format compatible to the hardware IOMMU.
+ *
+ * The @out_data_type will be filled if the ioctl succeeds. It would
+ * be used to decode the data filled in the buffer pointed by @data_ptr.
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
+#define IOMMU_DEVICE_GET_HW_INFO _IO(IOMMUFD_TYPE, IOMMUFD_CMD_DEVICE_GET_HW_INFO)
 #endif
-- 
2.34.1

