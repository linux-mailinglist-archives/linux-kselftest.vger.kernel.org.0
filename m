Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDF06CAD3F
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 20:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjC0Sj2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 14:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjC0Sj1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 14:39:27 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B41A3C0A;
        Mon, 27 Mar 2023 11:39:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAiBgDY2rItLbNkVgn374syUOeC9oz/nLU1nkpjKgfZYKUO231CWI9SlM4PYy0vrM/r6hpD/iuOLqfujLSESL46Wfu4Uzm12NOEHwTtVnLBZfW021Ku9XmA5aYPHBDWiNpCX+bQO+1HPtngOVrZOaatv8vk+i2Kd7u6DXAAZfaci4OlrzOGzMa9N6wKE3SrLCuvgiUcoJ2mjdIFdpP4ebLNryApAIaCa5M4J9LQtXw7WWO3X8W3WkgDxiddkiiM2djh8VNuhyGge2IurygOuAjbNtM1hQs1KJI8kNU/LLVQd3mh/ct93KtkEXc2+F7MxQ7745DQgqQvGW8/FKWfxEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6of8m/zmUIqjFvL5V0aE+oT9tA72MyKN4SFV097iUw=;
 b=ir3gbmjXB8PPDclxiR8twkHbOem8/ucY4D6RjZwFQicPzEYrMAg+lAKL27bigXx0GB/pAtM1ztzj33RKmPD9uFAnkNQMqG9V9ObW9oZUd4nxl8jwcNSbcHyjgeZflnrqiOnXizrZl18VviQ+oqhpyMPY7xe5ls5REVlcFgaV+sgk6hAGSGrVGkKeSo5407mb0eQofy1d2s8Thkr4ear6LZIjZxvLBn2RY0PkSBfVjvevJqMjlgAta0g+Fynp6I5DKbpXEx9W/1wbVkfQ8rFnXRg/BrGE9xyVXWwCKE4WUaPDJgLiEPepOoQlcOe9BKJpHijnZgodfbGqKgUkFW+vHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6of8m/zmUIqjFvL5V0aE+oT9tA72MyKN4SFV097iUw=;
 b=L/NWUpVtwpChiDe0GSyQz3Gs7PfIXyfIWVHQEpQErdMR7DnUFEHsGzDbrJSUNWC96K0DWpP0zmzZ/feXFPVvJ7x1RVhOKJvg/3j0ALCbR/A+LVouOv/kQOmeyDv2N+yifKIOGiTiNBP6U3BGDn88CW/ZpTNr8vQ3FKSBc2ytUCHyuS9a3JRn1maLUuodfGhUaQUdzorMyd0gGlF3jtBSL7uziipAVpQk1Dv+vrUffehNDKB0FVSNp+b01ArkP9gdOzsNP7O9NNeO0Nlcxxo5SA5asrwhojLCJj8/sJt4Qa+Je2myEIfknGQbdJB9q1PhqF6mzcWQAIJ049B6mYLg8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 18:38:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 27 Mar 2023
 18:38:18 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v4 15/17] iommufd: Add IOMMU_HWPT_ALLOC
Date:   Mon, 27 Mar 2023 15:38:09 -0300
Message-Id: <15-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0470.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: ce00a320-7eae-4982-742b-08db2ef26bf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9XswjEXKB1kNyHqvM4jQHwT3Sevg15kxxvbksqyiNsDKX3xCqBk+5ff6Uif5UOde0A8CtvMl3mEYgNzRjyWMu6nozFZQ9cMhAwBAMUDxnEPPyr0sDFmfUhukBUCK4Q9sxny6VYQ2mxV+re4BkyYtkpUWuY6BCMeSnjbodC8SjmWyqcPJlsIspDvcYvXM2Cvw7yNCwFH7AXWFGQSoFi7END+jHLsbFwrxyJ6WAqx0wqnJcguc9OLOuTpga0E2/S/B2ywN0goh13Pwia0r1wUn+sJ0DfVEcQmihTFSpEoB/hst4xRwLH+xgmAJijDtStpSgMlbaqk+vRKaXOCgxAeKhWdJ8CDR7aZV4qQIc/eH28Ci4zBQ4u76+ZGG8yB2Af3+OZRcF/Cl8tG/Nn4MEGTsG35unTny2+dMp2TVAOYIqd3o7NIiYSE9ZwysAccUUaztPbtgTwhLTZsuoswDT06M3gtDB+C9VroiN5Vab9y+LnevnoGjyCiT0bhNwd5PRJX3644sCCobxIlr/62uKsrJPD+3nl+bd/Zj5Hx2ooLcEsxaytI+bbJLRSPz1a6X5OB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(6512007)(6506007)(26005)(54906003)(6486002)(316002)(6666004)(4326008)(186003)(66476007)(66556008)(66946007)(8676002)(478600001)(41300700001)(86362001)(5660300002)(38100700002)(2906002)(83380400001)(36756003)(2616005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C3CLQpbqGHOhrx+xSIZre0RDH6YCS05XIuDFsFe8wapiqCwSlxh26F795J3n?=
 =?us-ascii?Q?t4qWKyV1NMx/m32QQNNKMY1odA3vqkdC8TND6EclSYtpBpOIyVahyN+26zsf?=
 =?us-ascii?Q?TWlGYN2+9mzPnd2KKvyxUJBc0RoCHLiyKou6rLeFnhiNu4TFasAiXjrU7TJ+?=
 =?us-ascii?Q?MGkiZYXpvsqQzqX/x7cBoCZgrtY+cJmnSfT6AQPDv4bnNfYCJvTIru2BWXS7?=
 =?us-ascii?Q?NPrp0RHskQ2oyA8x4N8NmE95oA1KzD1hLblxu5BGABPpQZEsjK7oE/icFFHX?=
 =?us-ascii?Q?AO7dm/IE9DQfs2m82q47Ptch/ruw3WsxgyJV0VrJoJEDH3MvCW0kj2FYF/2H?=
 =?us-ascii?Q?00vCIFvBWEbMA/I5T6hBmAB6b+6qhCaWS5vmxWPUeYTIz7qaBrb84szWNzhg?=
 =?us-ascii?Q?fwS5p2/I3KT0BhbwqROplvZPbS3SBDLVFdqKMMh3TA0jaV8VjIXL+2xENO5Z?=
 =?us-ascii?Q?GNzAM8GDzerVrQBxz1+aZOxsim01p9TQxvgRZhW9pDkZBvYOHxa24T7WXBVk?=
 =?us-ascii?Q?dOb6YpOIl6/OACpcKwaV2lrSMTUvhbyby+T4zHJts6zy+s6fzkFeZRQ0+7FS?=
 =?us-ascii?Q?3uIocIweKLAIFpHsby6g4gBE3yQAOmWNm4ApdV/Xur1/tSe83D5sp+25TqxO?=
 =?us-ascii?Q?6iafrQiltSudnDKiHiwH8oKun6nYtUkCRqy/93BOlUGjkOsXVIvjtb0o/UP2?=
 =?us-ascii?Q?nMNVGaXdMthFboZne9ahivdiNj1sOTOQE3VJKaUXnYqmk6VpMS/xRNAWa0hi?=
 =?us-ascii?Q?kgxHgQ82ybQnvbW+q8OhKWRo4eTxVD86kR/zbWsUsBDg0gaOIIBbPueiycxL?=
 =?us-ascii?Q?lNNmqKSBC7aPBO+D8OGLHNJiDmzqVPXP+b4+8TojmD+tGtvhR9H3sB+MLwm1?=
 =?us-ascii?Q?9K4Azr+Pd6JWcr7oGwX6nTKWlu3rYXF/QLXvVkbwwQzxulI1dLyFnW4ZpqV+?=
 =?us-ascii?Q?qjRQ9IICfyP/deGMcxPVMPUaG86FoGg4WF9rFluFLC1cNWvABJu8Kin8TKiR?=
 =?us-ascii?Q?YiYZruQBFtZUjWXALOwRHSI4nfMc9fJtzrH/cNveZ1zhyoPUdR+0Mr5oV+EQ?=
 =?us-ascii?Q?ZmWTbYc8g3Q/gDacuqX8/mRqxACaEROpykE9L1O5P3P0I1jGsiXw8w7ELfD3?=
 =?us-ascii?Q?5RCQ2/hWiz9+Op2f8jlgiNoP9CXnDOK/k5dxjoFd3QrCT4tACBybetoOWCKO?=
 =?us-ascii?Q?ZWxMVFjU1ZkubgFwnhHt0bpRa3JJWnpcwZkq5c0nhoBFMdZwyUxGi6g0PMq2?=
 =?us-ascii?Q?p72nxBY3YA5I8lUsuM2KTB3FAKxRqscwD1wRWvG/YRIZ9ZPs5WtLVOqFSXlc?=
 =?us-ascii?Q?vPkffizS6oAir6ZBARcEV4HJfv8wWprrUdiwLnlvm/Kvj1Y/7ZMNrfafN7eS?=
 =?us-ascii?Q?i87MoLuOeL6bSzx1Sos3RNuRlIEj2qy9LajNArDxYGYxKRixN5bjh4Ie6hM8?=
 =?us-ascii?Q?728QULM/F4XeCaxFU1n8RX1tuNmkuTe6NRkq+URarQjtJh2gUT0LbrXrN8jM?=
 =?us-ascii?Q?/zAlpd0ZK6LLtbfagGioSxucVq0xhDJiJZFdh8mp/kfVVpsTd3vft3HxASDv?=
 =?us-ascii?Q?j+kwoxO46mv+xIrBg/spw+dLEhdETIebBHm/zf5B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce00a320-7eae-4982-742b-08db2ef26bf8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:38:13.4902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xd8I3iwRu+Z7ibMMmbAYJo2xloA65CzoYxs2/4gTMmVpqmzXi9SH7VaGOz1KFLKs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This allows userspace to manually create HWPTs on IOAS's and then use
those HWPTs as inputs to iommufd_device_attach/replace().

Following series will extend this to allow creating iommu_domains with
driver specific parameters.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/hw_pagetable.c    | 46 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  9 +++++
 drivers/iommu/iommufd/main.c            |  3 ++
 include/uapi/linux/iommufd.h            | 26 ++++++++++++++
 4 files changed, 84 insertions(+)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index c5c0ef9912a13e..8aa9ac130b5960 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
  */
 #include <linux/iommu.h>
+#include <uapi/linux/iommufd.h>
 
 #include "iommufd_private.h"
 
@@ -115,3 +116,48 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	iommufd_object_abort_and_destroy(ictx, &hwpt->obj);
 	return ERR_PTR(rc);
 }
+
+int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
+	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_device *idev;
+	struct iommufd_ioas *ioas;
+	int rc;
+
+	if (cmd->flags || cmd->__reserved)
+		return -EOPNOTSUPP;
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	ioas = iommufd_get_ioas(ucmd, cmd->pt_id);
+	if (IS_ERR(ioas)) {
+		rc = PTR_ERR(ioas);
+		goto out_put_idev;
+	}
+
+	mutex_lock(&ioas->mutex);
+	hwpt = iommufd_hw_pagetable_alloc(ucmd->ictx, ioas, idev, false);
+	mutex_unlock(&ioas->mutex);
+	if (IS_ERR(hwpt)) {
+		rc = PTR_ERR(hwpt);
+		goto out_put_ioas;
+	}
+
+	cmd->out_hwpt_id = hwpt->obj.id;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_hwpt;
+	iommufd_object_finalize(ucmd->ictx, &hwpt->obj);
+	goto out_put_ioas;
+
+out_hwpt:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &hwpt->obj);
+out_put_ioas:
+	iommufd_put_object(&ioas->obj);
+out_put_idev:
+	iommufd_put_object(&idev->obj);
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index f80b012e1bc200..cb693190bf51c5 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -261,6 +261,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_detach(struct iommufd_device *idev);
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
+int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd);
 
 static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
 					    struct iommufd_hw_pagetable *hwpt)
@@ -297,6 +298,14 @@ struct iommufd_device {
 	bool enforce_cache_coherency;
 };
 
+static inline struct iommufd_device *
+iommufd_get_device(struct iommufd_ucmd *ucmd, u32 id)
+{
+	return container_of(iommufd_get_object(ucmd->ictx, id,
+					       IOMMUFD_OBJ_DEVICE),
+			    struct iommufd_device, obj);
+}
+
 void iommufd_device_destroy(struct iommufd_object *obj);
 
 struct iommufd_access {
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 9cba592d0482e7..694da191e4b155 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -261,6 +261,7 @@ static int iommufd_option(struct iommufd_ucmd *ucmd)
 
 union ucmd_buffer {
 	struct iommu_destroy destroy;
+	struct iommu_hwpt_alloc hwpt;
 	struct iommu_ioas_alloc alloc;
 	struct iommu_ioas_allow_iovas allow_iovas;
 	struct iommu_ioas_copy ioas_copy;
@@ -292,6 +293,8 @@ struct iommufd_ioctl_op {
 	}
 static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct iommu_destroy, id),
+	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
+		 __reserved),
 	IOCTL_OP(IOMMU_IOAS_ALLOC, iommufd_ioas_alloc_ioctl,
 		 struct iommu_ioas_alloc, out_ioas_id),
 	IOCTL_OP(IOMMU_IOAS_ALLOW_IOVAS, iommufd_ioas_allow_iovas,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 98ebba80cfa1fc..8245c01adca673 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -45,6 +45,7 @@ enum {
 	IOMMUFD_CMD_IOAS_UNMAP,
 	IOMMUFD_CMD_OPTION,
 	IOMMUFD_CMD_VFIO_IOAS,
+	IOMMUFD_CMD_HWPT_ALLOC,
 };
 
 /**
@@ -344,4 +345,29 @@ struct iommu_vfio_ioas {
 	__u16 __reserved;
 };
 #define IOMMU_VFIO_IOAS _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VFIO_IOAS)
+
+/**
+ * struct iommu_hwpt_alloc - ioctl(IOMMU_HWPT_ALLOC)
+ * @size: sizeof(struct iommu_hwpt_alloc)
+ * @flags: Must be 0
+ * @dev_id: The device to allocate this HWPT for
+ * @pt_id: The IOAS to connect this HWPT to
+ * @out_hwpt_id: The ID of the new HWPT
+ * @__reserved: Must be 0
+ *
+ * Explicitly allocate a hardware page table object. This is the same object
+ * type that is returned by iommufd_device_attach() and represents the
+ * underlying iommu driver's iommu_domain kernel object.
+ *
+ * A HWPT will be created with the IOVA mappings from the given IOAS.
+ */
+struct iommu_hwpt_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 dev_id;
+	__u32 pt_id;
+	__u32 out_hwpt_id;
+	__u32 __reserved;
+};
+#define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)
 #endif
-- 
2.40.0

