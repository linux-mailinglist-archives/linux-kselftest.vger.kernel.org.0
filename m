Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C04F75F44B
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 13:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjGXLEr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 07:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjGXLEg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 07:04:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3927A124;
        Mon, 24 Jul 2023 04:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196666; x=1721732666;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9g6bhAIb+d+E1XevtMPLGEYTgSwXzpUWm9YZpFWGFC0=;
  b=ljU6luiudRpQ0piCeoc1ahYaXmg/bcq2u7rQPKxIdnYS94HSqCdp2Dnv
   Ree4s1eIe0gDConHzV2YHvtcvwX1O3dbM6pjXPAvjTlADQe1HAojPNbW/
   dHBTZN+sTeui/8LJXcydrXGBvOrei1eOZPUylI5r1VgS59QO1DXn1bzlv
   THwHH224v7SlKAd6NFDJzsmLNItZ8fGOBVw+T0G0cswalTcoYv8KH7bUs
   2EDS4jtd70ScWjz+EvEIUD0jGbgGnL+gNAdD6y+U6yBcMrOTb4Bsmp7GU
   3nn5MIsh38WcNMOWPMCHbVivQ5aIUnvU8ubrJOnBktanFnNPiEQkrKFv/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347013296"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347013296"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:04:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="815775811"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815775811"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 04:04:17 -0700
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
Subject: [PATCH v3 07/17] iommufd: Add IOMMU_RESV_IOVA_RANGES
Date:   Mon, 24 Jul 2023 04:03:56 -0700
Message-Id: <20230724110406.107212-8-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724110406.107212-1-yi.l.liu@intel.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
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

This reports device's reserved IOVA regions to userspace. This is needed
in the nested translation as userspace owns stage-1 HWPT, and userspace
needs to exclude the reserved IOVA regions in the stage-1 HWPT hence exclude
them in the device's DMA address space.

This can also be used to figure out allowed IOVAs of an IOAS.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/main.c | 54 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/iommufd.h | 46 ++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index bd3efc1d8509..510db114fc61 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -250,6 +250,57 @@ static int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 	return rc;
 }
 
+static int iommufd_resv_iova_ranges(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_resv_iova_ranges *cmd = ucmd->cmd;
+	struct iommu_resv_iova_range __user *ranges;
+	struct iommu_resv_region *resv;
+	struct iommufd_device *idev;
+	LIST_HEAD(resv_regions);
+	u32 max_iovas;
+	int rc;
+
+	if (cmd->__reserved)
+		return -EOPNOTSUPP;
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	max_iovas = cmd->num_iovas;
+	ranges = u64_to_user_ptr(cmd->resv_iovas);
+	cmd->num_iovas = 0;
+
+	iommu_get_resv_regions(idev->dev, &resv_regions);
+
+	list_for_each_entry(resv, &resv_regions, list) {
+		if (resv->type == IOMMU_RESV_DIRECT_RELAXABLE)
+			continue;
+		if (cmd->num_iovas < max_iovas) {
+			struct iommu_resv_iova_range elm = {
+				.start = resv->start,
+				.last = resv->length - 1 + resv->start,
+			};
+
+			if (copy_to_user(&ranges[cmd->num_iovas], &elm,
+					 sizeof(elm))) {
+				rc = -EFAULT;
+				goto out_put;
+			}
+		}
+		cmd->num_iovas++;
+	}
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_put;
+	if (cmd->num_iovas > max_iovas)
+		rc = -EMSGSIZE;
+out_put:
+	iommu_put_resv_regions(idev->dev, &resv_regions);
+	iommufd_put_object(&idev->obj);
+	return rc;
+}
+
 static int iommufd_fops_open(struct inode *inode, struct file *filp)
 {
 	struct iommufd_ctx *ictx;
@@ -347,6 +398,7 @@ union ucmd_buffer {
 	struct iommu_ioas_map map;
 	struct iommu_ioas_unmap unmap;
 	struct iommu_option option;
+	struct iommu_resv_iova_ranges resv_ranges;
 	struct iommu_vfio_ioas vfio_ioas;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
@@ -389,6 +441,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 length),
 	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct iommu_option,
 		 val64),
+	IOCTL_OP(IOMMU_RESV_IOVA_RANGES, iommufd_resv_iova_ranges,
+		 struct iommu_resv_iova_ranges, resv_iovas),
 	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct iommu_vfio_ioas,
 		 __reserved),
 #ifdef CONFIG_IOMMUFD_TEST
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index d38bc54fd5f2..f2026cde2d64 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -47,6 +47,7 @@ enum {
 	IOMMUFD_CMD_VFIO_IOAS,
 	IOMMUFD_CMD_HWPT_ALLOC,
 	IOMMUFD_CMD_GET_HW_INFO,
+	IOMMUFD_CMD_RESV_IOVA_RANGES,
 };
 
 /**
@@ -422,4 +423,49 @@ struct iommu_hw_info {
 	__u32 __reserved;
 };
 #define IOMMU_GET_HW_INFO _IO(IOMMUFD_TYPE, IOMMUFD_CMD_GET_HW_INFO)
+
+/**
+ * struct iommu_resv_iova_range - ioctl(IOMMU_RESV_IOVA_RANGE)
+ * @start: First IOVA
+ * @last: Inclusive last IOVA
+ *
+ * An interval in IOVA space.
+ */
+struct iommu_resv_iova_range {
+	__aligned_u64 start;
+	__aligned_u64 last;
+};
+
+/**
+ * struct iommu_resv_iova_ranges - ioctl(IOMMU_RESV_IOVA_RANGES)
+ * @size: sizeof(struct iommu_resv_iova_ranges)
+ * @dev_id: device to read resv iova ranges for
+ * @num_iovas: Input/Output total number of resv ranges for the device
+ * @__reserved: Must be 0
+ * @resv_iovas: Pointer to the output array of struct iommu_resv_iova_range
+ *
+ * Query a device for ranges of reserved IOVAs. num_iovas will be set to the
+ * total number of iovas and the resv_iovas[] will be filled in as space
+ * permits.
+ *
+ * On input num_iovas is the length of the resv_iovas array. On output it is
+ * the total number of iovas filled in. The ioctl will return -EMSGSIZE and
+ * set num_iovas to the required value if num_iovas is too small. In this
+ * case the caller should allocate a larger output array and re-issue the
+ * ioctl.
+ *
+ * Under nested translation, userspace should query the reserved IOVAs for a
+ * given device, and report it to the stage-1 I/O page table owner to exclude
+ * the reserved IOVAs. The reserved IOVAs can also be used to figure out the
+ * allowed IOVA ranges for the IOAS that the device is attached to. For detail
+ * see ioctl IOMMU_IOAS_IOVA_RANGES.
+ */
+struct iommu_resv_iova_ranges {
+	__u32 size;
+	__u32 dev_id;
+	__u32 num_iovas;
+	__u32 __reserved;
+	__aligned_u64 resv_iovas;
+};
+#define IOMMU_RESV_IOVA_RANGES _IO(IOMMUFD_TYPE, IOMMUFD_CMD_RESV_IOVA_RANGES)
 #endif
-- 
2.34.1

