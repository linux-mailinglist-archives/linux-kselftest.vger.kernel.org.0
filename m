Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A698756B87
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 20:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjGQSOA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 14:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjGQSN7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 14:13:59 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5B210F9;
        Mon, 17 Jul 2023 11:13:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUyRLLZnR8qXYYu0O+HO0tl4IxBZ0wUgyj++6mjQGDp4hGOuA/qAiOB84ehE/hDUr3VbKA2cEMnrO8fz+5Jj1CmLS403+S3S3disXnLtMn9FuSN1DFgLuuil9Uu6OrZBT0q0C2bVPfC2NfdVhKxcZ4Fhzk42aTvAorzV4Ux6rViSrBcGE3E751Lg5ISVg7StyksFtAn5t3Qo4b6Jg9IfLOX7B9vMZdtC7zVBE5LP0cOuRvgk5tdueuOJL0o+yfpq9dBQ50b8eEfyn3oPAQWDsHLpQ17J3XYmK/HiEEZiiy9C2PlApaffU2teoksBBqSz7EBWzG1lAxwluQ6iUFY5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGMWvL49rAP1m8yoMj0d6B9rpdSmPX8SPYhFnppCdmw=;
 b=l7DwiM7z8Dcl2/Dzc69bwFwR230mHnF23VuujXGtNVD17Up2ZfuVQiLlkQocBvK9a2I2hZgMsWJ/w06JAKRoZaDAscIyKcfoAhosA7yu7M+nNWjEu/Q3c5mCrrKDvfWy1p1v7htuYdMQvpG/gLQ+ua8KzwUiEOiY7bmX1LledrrVKhKmrNPGgWGAbqYgBo15tGfLtT0SK74rMejQuLoSwYQKaYfvC3OFz9bW07/r4jH9S0MyuBRwuJgRxAzZDqZvSZAKRBxGdf3gbIVswk6s5GGoSmeoIyHzGsqQ8UslVh5Jt8dONBaYrY+weySEZqDC+k71DG1cm7GTiXxreXOV9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGMWvL49rAP1m8yoMj0d6B9rpdSmPX8SPYhFnppCdmw=;
 b=n8Y39oyll6vpyuQTIq4z6p9RqPGZEdMwrqnnXXLnSi0YD9UtF03zbJPiyQgTA0MjFQ6LFrdi8i6c+hHy8V5gk/uChUwrAPE2cEpz8CjDmJFg6syDvIY5/c5TU3MXppjsHwT726ZOjaLKK+JZz7VRFj9GRRR6de2AVtMyDh911OzUTxpjTvYjvFipby/EkknMH8ydEQLlZ6gPp7XehfxuMg/QyOGY0fb5odt3F1ZXfkctxTlreZKVoetaAvtMYJ1jeD/OJ1p2Zzu1cJSF/jTHbbvPIAIFj0FPuU3fIIXe1mz9JSP+7pBSUyWphJTY1aAdfCPwa9Dw6XmYyr7V92VO1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9137.namprd12.prod.outlook.com (2603:10b6:a03:562::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 18:12:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 18:12:24 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v8 17/19] iommufd: Add IOMMU_HWPT_ALLOC
Date:   Mon, 17 Jul 2023 15:12:13 -0300
Message-ID: <17-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0061.namprd08.prod.outlook.com
 (2603:10b6:a03:117::38) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9137:EE_
X-MS-Office365-Filtering-Correlation-Id: 071ec32e-c68a-4659-3e98-08db86f15c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qKMLVLoZwS2KlOMQf1zELLKQZtWXL56/5hy8/A6HPFOIeKH0fDt6+yov6KsxVc4nKwtBF6SHtLmLjYaNU/5ZcRdMzR8CUewqKLtdY4/8bPmeJzrWqAfUHsRwoxdSFEdndWxuaXEbvDZ6rTgre/Nvm+zo0gbyhYZ0LXaANBvTfegCoC0dgjVRa0rf66+O49vn+lbo0F/DhHNYhsSR6hJEkeDtDC4HxYtLllB4tyBIDJgimwH4fmTwecFCwj+MLE4zkNtYJWvVbVSgVkZ/6dNYRgb61J7dPCbQruWURawbg2rJWF6uBs89a1h1k6HOdZ+6ppvRVVnJbGE0BP5GiNpb6xUdtC8HBsNhrY+PAt66kNByQRNK11QXxmVKIe4OPSMKB8+9m132+FwDyqmy8hpsNFHvt4xKRUs1HtlgwcQmhxmGgUVsVxcPMu4QwuJWvr+boFEn6RdobXXRsClZ+b0qFTqSSHn+PgWMGvUAhcWhOZX2Ls6yPd+OnjVxSGqauCOnjCifFokAig9z1UPObv6NYr/xrqf0sANMn0/LcwrSthmXFXPudB6qTsziAWwRGERa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(86362001)(2906002)(36756003)(6512007)(186003)(83380400001)(6506007)(26005)(38100700002)(6666004)(6486002)(54906003)(316002)(5660300002)(66476007)(66946007)(66556008)(2616005)(4326008)(478600001)(41300700001)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?INoIm2OX2ZM0Ad/1gWn+A+rmA5zAsl+FjYz8jGqQRbVfEZVSrgHh2Y9lTRZj?=
 =?us-ascii?Q?gyxyxzR0hfFnosbrmBBsGVxaI+JTb4WrBYacECzY1Jh93RT1Sd0Yp/Q0rXyC?=
 =?us-ascii?Q?/+btgP2IB0gLIr3A09IsgLmUOjWG4FALu9i56j/6+CDYZa7fVJ84aBEKCgD9?=
 =?us-ascii?Q?ZE10BvTMjaV0BaVt8sRWTHdslFTGCrtjbJw4/CNA8jU6OBJXSEO4Nm+kMTbY?=
 =?us-ascii?Q?jYSgNaCxyyMc2XLRCt/QaiOSyY6NAil7Vq+H6ogdTyBfaR5h3JF5UBQBTvhG?=
 =?us-ascii?Q?okrcI1tT+oh/y00EDmvVX3LFR4wOeLVe8O/6TLrUbswn37WNy/ZrlBralWDk?=
 =?us-ascii?Q?E86+NM+gBdaWrKJlODNO7iI0eGVR5gPS4s1XiQ5b2X+9GHQvcKP1w7p6jT3U?=
 =?us-ascii?Q?6104x1obUE8oZwmTb5WbWYA/KjjPkAQ9vrgDyp3fMrRIsS1JzNLQkt+uoqf7?=
 =?us-ascii?Q?f2iELuB3Ycq54NU/S7Z7QSSwVEnbFcFwqvsOhJBilIFPwOaDr8t+MJ9PwGt+?=
 =?us-ascii?Q?qvcTEqSUoRrwSvcov4XqmE3wNa9dto0f+AeSPc24P8U3nRvfBm9YwsYkiyWA?=
 =?us-ascii?Q?4rSU1eOdvt3vaRHyrqp51eUCUvna92erIbgw+yf5xO2e62nuZ5NDg2oNehh0?=
 =?us-ascii?Q?sbRAWXBvCNkkGCDdI4VCHiTCVC7ZNr4CQWZuRvUXWG49XwBcGR5XdQ6hjZPo?=
 =?us-ascii?Q?jR01xGRsVUQxl/SNvKy4tUHebpbZ7rYB/+XldzvmQm0UMHIMYBD0Dq2S7ANK?=
 =?us-ascii?Q?FtmPWbMBYos7zW+QnWPkjqraRSj36bpa/XVVK4OcCLssHQwIU9R+XwLXJpEM?=
 =?us-ascii?Q?dkKjboBbhl0oaYEF/l5uXAdTKly0zIuXq3dkWixgTRdTdB49tX+bwqIEozG/?=
 =?us-ascii?Q?6Au1e6Yq3GMXUwDkWG+UTsja9JmhfOhbIFZS/5/n7H6/56M58ixa7zOFocjx?=
 =?us-ascii?Q?RbYpMnQkoX1ivl/UFTf/qXqTTr1afhWktPVF0LpXUcBS8sCeLzpR+99qV8r9?=
 =?us-ascii?Q?ps78d+gqo5XKcOtU0Tlg6xznSP+o4vDhP8MyYNo/S3k6tbHYMdM43vfV+HVX?=
 =?us-ascii?Q?zBLGPt/VfCi5Dcq8Jwe8WmEpOSB2nq/uxjN3S6eAhWyZ8smmbGgWvE9fuc6O?=
 =?us-ascii?Q?vi/WUWArc1nXuFsWXN5BjuuMmIfnvsX9xv7OdQjiaOjQA70VOb/dUIgj672E?=
 =?us-ascii?Q?C4cXVMIA3tW9C3Ib/ygV3Sqvocz0Jc3J5Knqupy2qQh8irSfryFdsCdM9ifg?=
 =?us-ascii?Q?13Mp0bhK0h84LlHVICFrkTR37xphcU4JjnbgFfhNTVUUcOJFG+7xENucFexb?=
 =?us-ascii?Q?2DuBK2RJ3rZP0AIDqpCozyUmEq/4iPvtYXnLrhzO9+2UkgicB4cvIuxYjsYV?=
 =?us-ascii?Q?hiKO0Nv4GLNQCpApdxU442Ue2BErxlrtFwzKRwIrEbcn7ojf4doYefqneuLS?=
 =?us-ascii?Q?1+MCii16/fZfip9pzZrIGZ2iXqF+DQpShdbEKV2PNue4HS9haiWanDlcIYyW?=
 =?us-ascii?Q?1ixh5a7uu7v/uzZjwNCfBvSfGaE0qbe51iWF5zAxWrnGE/9IF/RnzDdsBTJk?=
 =?us-ascii?Q?RiGdREjsjBVqVded4uzOXLMqj5tJyR8bK4OuZqBk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071ec32e-c68a-4659-3e98-08db86f15c0e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 18:12:19.3833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ezgz4pGHUB/ZUbPhvssbFlaYHoJstbXetc8bzB4QBoPvtw6mklI6VTNKPlZ5Sw9x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9137
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/hw_pagetable.c    | 46 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  9 +++++
 drivers/iommu/iommufd/main.c            |  3 ++
 include/uapi/linux/iommufd.h            | 26 ++++++++++++++
 4 files changed, 84 insertions(+)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 2087b51d9807ad..cf2c1504e20d84 100644
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
+	ioas = iommufd_get_ioas(ucmd->ictx, cmd->pt_id);
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
index 79942934a4d69a..54916fcf8d2a3c 100644
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
2.41.0

