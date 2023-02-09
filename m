Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E9568FF5B
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 05:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjBIEfo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 23:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBIEeG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 23:34:06 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF784FC3E;
        Wed,  8 Feb 2023 20:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675917176; x=1707453176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JfD/fokoPRshO4wFNzn7zhXsFRoESmD1kCTxkSknqtU=;
  b=fAdUUidGxUAYHPRwIpGf4c7UkUBbcTrAh6G9aN78HLuzdVCbDQl4abWx
   q7TczBqbeZHV73VRfR+LMzIZu7ZmRQAjEHzq/gbvm0XpwlXuZhw71l0lk
   bsYrezU8gHJUTo9jgt1VQh9PM997O8FaMfJn1Iwx+SKGVXZtlUvhm6L1U
   RdLh/AZvJ0PJpWOlZYFb2ZnvpmX3hn80+Cb4ETuAW1gofn/LNEk+Iq3dv
   SOHOWBq3Xi/2YP42WMAkoLCggRWcx/5wIZZxNHplBQdxeyfNXGYX146Kp
   5ji9Gx1Mv8UrpWswt2JqrC5VcYV7VgbA2XQsQInnN4sEzbp6zrM4wJICB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331298836"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="331298836"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:32:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669447592"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="669447592"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2023 20:32:21 -0800
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
Subject: [PATCH 13/17] iommufd/device: Report supported stage-1 page table types
Date:   Wed,  8 Feb 2023 20:31:49 -0800
Message-Id: <20230209043153.14964-14-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209043153.14964-1-yi.l.liu@intel.com>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
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

This provides a way for userspace to probe supported stage-1 page table
types on hardware IOMMU. This is helpful when the user-managed page table
is used by hardware IOMMU. e.g. nested translation.

This commit reports the supported types for IOMMU_DEVICE_DATA_INTEL_VTD.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c | 7 +++++++
 drivers/iommu/iommufd/main.c   | 2 +-
 include/uapi/linux/iommufd.h   | 7 +++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index c19e2f54a44f..826441c6005d 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -224,6 +224,13 @@ int iommufd_device_get_info(struct iommufd_ucmd *ucmd)
 	cmd->out_device_type = ops->driver_type;
 	cmd->data_len = data_len;
 
+	if (ops->driver_type != IOMMU_DEVICE_DATA_SELFTEST)
+		cmd->out_pgtbl_type_bitmap = iommufd_supported_pgtbl_types[ops->driver_type];
+#ifdef CONFIG_IOMMUFD_TEST
+	else
+		cmd->out_pgtbl_type_bitmap = 0;
+#endif
+
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 
 out_free_data:
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 6e2d8805daf3..d8bac1303b33 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -290,7 +290,7 @@ struct iommufd_ioctl_op {
 static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct iommu_destroy, id),
 	IOCTL_OP(IOMMU_DEVICE_GET_INFO, iommufd_device_get_info, struct iommu_device_info,
-		 __reserved),
+		 out_pgtbl_type_bitmap),
 	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
 		 __reserved),
 	IOCTL_OP(IOMMU_HWPT_INVALIDATE, iommufd_hwpt_invalidate,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index cb6a9ee215f4..2c7533d843bc 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -396,6 +396,8 @@ enum iommu_pgtbl_data_type {
  * @out_device_type: Output the underlying iommu hardware type, it is
  *		   one of enum iommu_device_data_type.
  * @__reserved: Must be 0
+ * @out_pgtbl_type_bitmap: Output the supported page table type. Each
+ *			   bit is defined in enum iommu_pgtbl_data_type.
  *
  * Query the hardware iommu capability for given device which has been
  * bound to iommufd. @data_len is set to be the size of the buffer to
@@ -408,6 +410,10 @@ enum iommu_pgtbl_data_type {
  *
  * The @out_device_type will be filled if the ioctl succeeds. It would
  * be used to decode the data filled in the buffer pointed by @data_ptr.
+ *
+ * @out_pgtbl_type_bitmap tells the userspace the supported page tables.
+ * This differs per @out_device_type. Userspace should check it before
+ * allocating hw_pagetable in userspace.
  */
 struct iommu_device_info {
 	__u32 size;
@@ -417,6 +423,7 @@ struct iommu_device_info {
 	__aligned_u64 data_ptr;
 	__u32 out_device_type;
 	__u32 __reserved;
+	__aligned_u64 out_pgtbl_type_bitmap;
 };
 #define IOMMU_DEVICE_GET_INFO _IO(IOMMUFD_TYPE, IOMMUFD_CMD_DEVICE_GET_INFO)
 
-- 
2.34.1

