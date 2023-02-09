Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B9B68FE61
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 05:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBIEUR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 23:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjBIEUO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 23:20:14 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86A0125AE;
        Wed,  8 Feb 2023 20:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675916360; x=1707452360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zg75NlnzG6bl+FEokzV5mm4wJdtzxfEPl+1gdcoX9v4=;
  b=WZXVMdplkhYeXlnDg6B7TelrovySZiy+APS08/1iBteCNqI41nyFzYKj
   dyCTzInlDBZbK4qr2Lp3z6kdObpT+tu6tkEiOMiQwhbmv7F3MHsmNmfnt
   88mcbJLZR2PGR/8TULYEBJ91K9vDLXf5sVzdxjZfl0RXrx5ZEEihRK2l+
   eFN4AgREXOvJ2XdQCzrW1JkzkKZf10RZJu6nELnrRjlk8xdbh4Tr0b2y/
   y5fl0b4ANRE09JTp41uHjLjOTlji493IiGx99hyCJOCj1Vcfxi2OXcAC5
   CLq78y2smkZdwACzfk9DcxZF2w0meBYnXIBTWNx+NiLkVcP10nGhwfuk0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="394600728"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="394600728"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:16:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="912982101"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="912982101"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga006.fm.intel.com with ESMTP; 08 Feb 2023 20:16:49 -0800
From:   Yi Liu <yi.l.liu@intel.com>
To:     joro@8bytes.org, alex.williamson@redhat.com, jgg@nvidia.com,
        kevin.tian@intel.com, robin.murphy@arm.com
Cc:     cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        baolu.lu@linux.intel.com
Subject: [PATCH 3/6] iommufd: Add IOMMU_DEVICE_GET_INFO
Date:   Wed,  8 Feb 2023 20:16:39 -0800
Message-Id: <20230209041642.9346-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209041642.9346-1-yi.l.liu@intel.com>
References: <20230209041642.9346-1-yi.l.liu@intel.com>
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

Under nested IOMMU translation, userspace owns the stage-1 translation
structure (e.g. the stage-1 page table of Intel VT-d or the context table
of ARM SMMUv3, and etc.). Such stage-1 translation structures are vendor
specific, and needs to be compatiable with the underlying IOMMU hardware.
Hence, userspace should know the IOMMU hardware capability before creating
and configuring the stage-1 translation structure to kernel.

This adds ioctl: IOMMU_DEVICE_GET_INFO to query the IOMMU hardware
capability for a given device. The returned data is vendor specific,
userspace can tell it by the @out_device_type field.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 72 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/main.c            |  3 ++
 include/uapi/linux/iommufd.h            | 36 +++++++++++++
 4 files changed, 112 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 8a9834fc129a..3b64aef24807 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -134,6 +134,78 @@ void iommufd_device_unbind(struct iommufd_device *idev)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, IOMMUFD);
 
+static int iommufd_zero_fill_user(u64 ptr, int bytes)
+{
+	int index = 0;
+
+	for (; index < bytes; index++) {
+		if (put_user(0, (uint8_t __user *)(ptr + index)))
+			return -EFAULT;
+	}
+	return 0;
+}
+
+int iommufd_device_get_info(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_device_info *cmd = ucmd->cmd;
+	struct iommufd_object *dev_obj;
+	struct device *dev;
+	const struct iommu_ops *ops;
+	void *data;
+	unsigned int length, data_len;
+	int rc;
+
+	if (cmd->flags || cmd->__reserved || !cmd->data_len)
+		return -EOPNOTSUPP;
+
+	dev_obj = iommufd_get_object(ucmd->ictx, cmd->dev_id,
+				     IOMMUFD_OBJ_DEVICE);
+	if (IS_ERR(dev_obj))
+		return PTR_ERR(dev_obj);
+
+	dev = container_of(dev_obj, struct iommufd_device, obj)->dev;
+
+	ops = dev_iommu_ops(dev);
+	if (!ops || !ops->hw_info) {
+		rc = -EOPNOTSUPP;
+		goto out_put;
+	}
+
+	data = ops->hw_info(dev, &data_len);
+	if (IS_ERR(data)) {
+		rc = PTR_ERR(data);
+		goto out_put;
+	}
+
+	length = min(cmd->data_len, data_len);
+	if (copy_to_user(u64_to_user_ptr(cmd->data_ptr), data, length)) {
+		rc = -EFAULT;
+		goto out_free_data;
+	}
+
+	/*
+	 * Zero the trailing bytes for userspace if the buffer is bigger
+	 * than the data size kernel actually has.
+	 */
+	if (length < cmd->data_len) {
+		rc = iommufd_zero_fill_user(cmd->data_ptr + length,
+					    cmd->data_len - length);
+		if (rc)
+			goto out_free_data;
+	}
+
+	cmd->out_device_type = ops->driver_type;
+	cmd->data_len = data_len;
+
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+
+out_free_data:
+	kfree(data);
+out_put:
+	iommufd_put_object(dev_obj);
+	return rc;
+}
+
 static int iommufd_device_setup_msi(struct iommufd_device *idev,
 				    struct iommufd_hw_pagetable *hwpt,
 				    phys_addr_t sw_msi_start)
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 200c783800ad..4a0a1a7fdae1 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -258,6 +258,7 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 
 void iommufd_device_destroy(struct iommufd_object *obj);
+int iommufd_device_get_info(struct iommufd_ucmd *ucmd);
 
 struct iommufd_access {
 	struct iommufd_object obj;
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 3fbe636c3d8a..59aa30ad1090 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -250,6 +250,7 @@ static int iommufd_option(struct iommufd_ucmd *ucmd)
 
 union ucmd_buffer {
 	struct iommu_destroy destroy;
+	struct iommu_device_info info;
 	struct iommu_ioas_alloc alloc;
 	struct iommu_ioas_allow_iovas allow_iovas;
 	struct iommu_ioas_copy ioas_copy;
@@ -281,6 +282,8 @@ struct iommufd_ioctl_op {
 	}
 static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct iommu_destroy, id),
+	IOCTL_OP(IOMMU_DEVICE_GET_INFO, iommufd_device_get_info, struct iommu_device_info,
+		 __reserved),
 	IOCTL_OP(IOMMU_IOAS_ALLOC, iommufd_ioas_alloc_ioctl,
 		 struct iommu_ioas_alloc, out_ioas_id),
 	IOCTL_OP(IOMMU_IOAS_ALLOW_IOVAS, iommufd_ioas_allow_iovas,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index fda75c8450ee..6cfe102f26f3 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -45,6 +45,7 @@ enum {
 	IOMMUFD_CMD_IOAS_UNMAP,
 	IOMMUFD_CMD_OPTION,
 	IOMMUFD_CMD_VFIO_IOAS,
+	IOMMUFD_CMD_DEVICE_GET_INFO,
 };
 
 /**
@@ -371,4 +372,39 @@ struct iommu_device_info_vtd {
 	__aligned_u64 cap_reg;
 	__aligned_u64 ecap_reg;
 };
+
+/**
+ * struct iommu_device_info - ioctl(IOMMU_DEVICE_GET_INFO)
+ * @size: sizeof(struct iommu_device_info)
+ * @flags: Must be 0
+ * @dev_id: The device being attached to the IOMMU
+ * @data_len: Input the type specific data buffer length in bytes
+ * @data_ptr: Pointer to the type specific structure (e.g.
+ *	      struct iommu_device_info_vtd)
+ * @out_device_type: Output the underlying iommu hardware type, it is
+ *		   one of enum iommu_device_data_type.
+ * @__reserved: Must be 0
+ *
+ * Query the hardware iommu capability for given device which has been
+ * bound to iommufd. @data_len is set to be the size of the buffer to
+ * type specific data and the data will be filled. Trailing bytes are
+ * zeroed if the user buffer is larger than the data kernel has.
+ *
+ * The type specific data would be used to sync capability between the
+ * vIOMMU and the hardware IOMMU, also for the availabillity checking of
+ * iommu hardware features like dirty page tracking in I/O page table.
+ *
+ * The @out_device_type will be filled if the ioctl succeeds. It would
+ * be used to decode the data filled in the buffer pointed by @data_ptr.
+ */
+struct iommu_device_info {
+	__u32 size;
+	__u32 flags;
+	__u32 dev_id;
+	__u32 data_len;
+	__aligned_u64 data_ptr;
+	__u32 out_device_type;
+	__u32 __reserved;
+};
+#define IOMMU_DEVICE_GET_INFO _IO(IOMMUFD_TYPE, IOMMUFD_CMD_DEVICE_GET_INFO)
 #endif
-- 
2.34.1

