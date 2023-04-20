Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31A46E9C15
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 20:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjDTSwz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 14:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjDTSwZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 14:52:25 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F0E30E9;
        Thu, 20 Apr 2023 11:52:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLMyrM+tZ7ihN2tYloe+LGe1P8dA6HeaMUFJgcufuevhT2ZebTPaGJNWrSO2Fds8c9nHXdRB+PQ49x/EZybv5Lp/GgJRACg+X5bFvR0Vq5PTIMgPWOyKNsXnt3KqJ03pb3r2CmkC5VsSQNsIBAV3hF8x2ApgwZKSOzWB2VL+ymJTf8ufu4KZuJThtWeWwbk4xDBeGWo3FwPw34vkCBnrWJ5I8wMZoaEAemYsUcNyCqIEf1oVM7UkIvV6ztAPZmoRB2zO78sJL1Cuw7gwXReN9BFeJDJYIhg8UYqrkk3QTTSuKNCP5JMmMeMuXmoBH5EZwsAbIy2wGkmNEr4Xb+HRGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qT6Ol1cSHqGxkMV0k4Tx2HBgEXoB/o2/tqIjtPeU2W4=;
 b=jxldoCBMKX3iqiPG7XsKgbws4WLQ93+IbsVHHyJ5lOaT9SiG8LsKUkwnWY4pp8Nc+NUkbPs8gH5VzPA0Ybz1BEtrGX5Dlc2QHNMnaM5qtiNt6WLwZ6w+3UpEu1W8rCbd9d8O7gxnG1xwgioLUAu0vz/T9xlLdI0FixctRkEYzonbsLv8Grri/xstIQGKu5bwXZb2ota15GPqBUEEzN42lgHYsLRGUARc7jvtgwmpEz3NqQszhxjfm969YBUDz63aEgA6u/mtwQt/I3WB33pnmh8vHomOETMWxko3xqiWIjbALMkSNAwJ6m7MFRLyLdzWfAITfdDj0OREKdzC8wEWwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qT6Ol1cSHqGxkMV0k4Tx2HBgEXoB/o2/tqIjtPeU2W4=;
 b=unOE5394iMAV/M0DVv2Eta2lSbAZM3qtBeS2NVunp1/UGORWYMsqbCx1Q482gUqONxaq81g+104U2hgCW0wTn9NXO1q28GtuzsjrqRMLs3KCiLkto4K5CgomlEmlLXcb0iXXhqKkGEhRqH2RNvoDLyuEZ7uDXegBOf3xMTx7k4kSONOp7ZtpPRPxQfcAu+woPYiEpQ1FpbWvPxA6z2lqUtwY9ihFJGWBWZ7sjx/KA6jE0j1l0Qsv2U/6Egnz7z9S165MuNKS/qkRvIQcHZOfU+3/n8Yv5ePrqLmblGW4BIA6jYSnLaRe8Cck1vq5LAxTF6JVx0tWAhLfUMej8u/vEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 18:51:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 18:51:49 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v6 17/19] iommufd: Add IOMMU_HWPT_ALLOC
Date:   Thu, 20 Apr 2023 15:51:32 -0300
Message-Id: <17-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:208:2d::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ed84e0-88c9-40f3-6cd5-08db41d04645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MIvHEZMzSyC1NYsyaMr/n8h0nMBXeVczMLftDiNUF/cRRGy1/47In75x2xhrBVKHlXN7jVsv49NYqXwK8Vlb7ceiaF8ohLqWYXEI8ckUUf8naQalQqqtHr2MleoU60lu6qtqBKJGJE9mRLGfeZ416kJN0W3HZFWo8Ah6kqbC2g7T0xTxPRyz86QZelwDC5Mvco4dLMPCaenaYHLObvQ/6dpkzMRexpfC57KL1DzfYWx2CDo76FqoX8At6ldmqXHX6MKvXgmpZtwttDsljk/hVN5uGRSFdUb0+2M6eWQqW7VN2UYdPLZw2/ifIM5r9Xj+lGgl1nLfwRs0WR707YnA65lISzRnPBnUg+pd8V3lJbQshssBmX4BCM8kZHvp6mNWt8Qac3k85WpsOhg9ao2QOyJKGgjqKSdpfnJD7I+VnZNrhY1mAU7hVsQ18V7G1YHzL7ksy6Qs5M0pdz4wZqSrO4rTN37cVON0SlNnXR4TGmEi5hQpmrysexaAPTTV+6b1Xl/kILYfYvP09UNSD5ItoVC+fXYXjDrOSjnVKqcQzvUO4X1kQAVTh7iY+ugtMspw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(54906003)(4326008)(316002)(66946007)(66556008)(66476007)(478600001)(6666004)(6486002)(5660300002)(8936002)(41300700001)(8676002)(2906002)(86362001)(36756003)(38100700002)(2616005)(6512007)(186003)(6506007)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3oncfhnFj/yAPca7NiAMsHuW8xqNL0kRBLcdYV0xDw/pIxuLj7JKQ031xGCz?=
 =?us-ascii?Q?8S6RfnTq9quq1cvQZzFq5A/1MTC1IBq+UFI+FBI4fgEdxwEYUp+sG19vptgx?=
 =?us-ascii?Q?M/VHp0nUpSlws44WHSzVkHArVnVQhXPQz/sqw71Ui9ifOrQMUtdRRlvFGZf4?=
 =?us-ascii?Q?8CDbaBKCKGg5VThODrIUqBgFK1hYGzeDyqaJ0GNGGQtW7oYxRp5nx/aDzCci?=
 =?us-ascii?Q?H0DZEoB3iadai83LoXcWM/nhGARiOn5sHuiFqHDWhS7MFeaUY4xDYnThOsHl?=
 =?us-ascii?Q?KWe3b62wMsaYloRaeyAhSS0b+ylkqynNPx9FyUDyYh4o++70HU/UxYIdMbcz?=
 =?us-ascii?Q?f37jEKDMbtAlOmHrwyfGOVd4vwla4IEz081CRtt3h10lhKGbSo1oR94jSt2x?=
 =?us-ascii?Q?oQQCQVWW2nut4LmdFM1m9filt6BQCR3EYo6mF0jDA/2JQnlb25pqJU3/lXUO?=
 =?us-ascii?Q?Mkuln6VFCqHPykIHpvJ2VMBQ3hYrgBIlOWRtmg+8xuZVULjmKh59WW7B39WU?=
 =?us-ascii?Q?gaNvOlFhjUQ/smsMUPIebkPCrgCPIJ80lREsiylCGcyxIUGWA4bWByAjpSbp?=
 =?us-ascii?Q?JrBpNQHOU7O9SRziEKVxQgbL471WNhtdo1Utk2eXEEME+Re+2G6BGii3/QbL?=
 =?us-ascii?Q?KiCukCACT3pt7oPJA/UbZ2sPGswDPqNRHywLZe7LchVua8Y5inchVVGdtsdr?=
 =?us-ascii?Q?gQR3gYZU3Elpi4FjlAsFJrWtfLG7HNsLm+kNg/lkXXcyxDTJaK5YdEn5GzZj?=
 =?us-ascii?Q?jDZ1uFjJrZilEX3os88DLhdoZ+v5Cg16YdHOHbnL6CDWvXP6wRYSXjqcPf/A?=
 =?us-ascii?Q?NuDSz42ffxJ0zadIgd0qJBZsc/GR6cMfsnzh09xQmFQESnwIHHcW7IOQYxbI?=
 =?us-ascii?Q?FyGdUyK+DrYtJK/DUWgIBVSjrAJVD/gnW2wmfoQrZhv6AHppJRSYc7/G0kB7?=
 =?us-ascii?Q?dFVBbOmLVHtEh3Zj5COodNh+5VyidV3EJcyP6i7+bdQKOu4oW6EqdTpVe7Ag?=
 =?us-ascii?Q?Y9nO4v9fCdDm+J8N3vWF232366ocTGQKKkwGHM7Tp/XTC5Q3pCWIEDVjSseg?=
 =?us-ascii?Q?SQso3PQy63tPEFxM+myuk8Gxzcm7a/8zeIZI62++O9XWgy2xhKEn3ipWfy94?=
 =?us-ascii?Q?WiyfAnPUBcYMsASYCwFBBs6p6j9QMWaBz+ae3yUBBCGQbXNEmyZSwg4KzRrB?=
 =?us-ascii?Q?0CWz7O15/u6jI3BS9jCIoEmm4jHa5JrgohGKYa4zNpwUw4pCbxY/mMLNmAAU?=
 =?us-ascii?Q?F/okqLWkqiUi9PDwVIV0yA2srj9JP3Cv3g2wk9qdTf5P5sp32BBG/yr8iwSq?=
 =?us-ascii?Q?Bz/q2GVczORBy27YdJyfXaCkK8ctD3wo/OmtLSxvAfYMJTa4YymBEj4OHRss?=
 =?us-ascii?Q?H+dnAU4qH+p6v5ts6xpZWcQGIARCJuWODA0bXknuuIiDU0X9oYkS6bLO8y/0?=
 =?us-ascii?Q?oFZLnsEOD+isE/l6kxY4S8aghELGmo/hYtXKZF43Xj2o/tffjWnggrFd2LVO?=
 =?us-ascii?Q?hVBJYfYnOC5u2kSq7XzL28wgIajAgBRzlXP7Dj2s1qflO2hhs4FjFBoFB78A?=
 =?us-ascii?Q?yNe/SUslztUMa+ghKfYh9wO3A/nY5eEpX75tj09E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ed84e0-88c9-40f3-6cd5-08db41d04645
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 18:51:39.2903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8c2EfnGRbc5ZnlQZsZADijPiMUT6ji0qCkCQSM8d3I0XxKNGuH9xYOsFCaU14XMg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4553
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index 2087b51d9807ad..655ed32144f62e 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
  */
 #include <linux/iommu.h>
+#include <uapi/linux/iommufd.h>
 
 #include "iommufd_private.h"
 
@@ -131,3 +132,48 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
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
+	if (IS_ERR(hwpt)) {
+		rc = PTR_ERR(hwpt);
+		goto out_unlock;
+	}
+
+	cmd->out_hwpt_id = hwpt->obj.id;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_hwpt;
+	iommufd_object_finalize(ucmd->ictx, &hwpt->obj);
+	goto out_unlock;
+
+out_hwpt:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &hwpt->obj);
+out_unlock:
+	mutex_unlock(&ioas->mutex);
+	iommufd_put_object(&ioas->obj);
+out_put_idev:
+	iommufd_put_object(&idev->obj);
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index d97bac38b7a41d..ba50eb4661e217 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -262,6 +262,7 @@ struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_detach(struct iommufd_device *idev);
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 void iommufd_hw_pagetable_abort(struct iommufd_object *obj);
+int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd);
 
 static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
 					    struct iommufd_hw_pagetable *hwpt)
@@ -298,6 +299,14 @@ struct iommufd_device {
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
index f219e47d882525..73a91e96896252 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -265,6 +265,7 @@ static int iommufd_option(struct iommufd_ucmd *ucmd)
 
 union ucmd_buffer {
 	struct iommu_destroy destroy;
+	struct iommu_hwpt_alloc hwpt;
 	struct iommu_ioas_alloc alloc;
 	struct iommu_ioas_allow_iovas allow_iovas;
 	struct iommu_ioas_copy ioas_copy;
@@ -296,6 +297,8 @@ struct iommufd_ioctl_op {
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

