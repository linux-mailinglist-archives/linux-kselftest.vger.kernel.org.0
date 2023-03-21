Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0B26C3A19
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 20:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCUTPS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 15:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjCUTPP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 15:15:15 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C37E2F06C;
        Tue, 21 Mar 2023 12:15:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGPLeo89p3v+BeffVm/OKuOiG/GbF/8fIe9O/Ikx2ASjq8m8pHfa6ol3y4BzxtDYQRNN16wJ8i/4Pe69xw+NNmJRlfsPYIy/M2xwk22f0HL2d+ESoM5n6FL1Oqqv6H/cPSFscy7qu/DpSdc2jZBf82nY7KUse1fcmi0lP+W8L1snmY/Mky+pE6h25bj1/CIp2tEbw3DbNY/ljzdDxBd1Tx9YaI0M+0JWa5bbaRvfP7KSuBPnqwGnCQaY76WlBxJh+9/AcCH12VZkhbKdu8rWuY+qbFg1gZP1kATO1Czrt+R4tof6G5uZ2qOtJbdzp28Yvj6pC1RXkySpL6aCcG0iIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q38POZGa6y3wkXhzKD42r7jtGlc/FyfkNHzejfz919E=;
 b=IicAspTK8WxgHdCm9OWwB3pl/UJOOVfagyh4AL4qyFVLz6gX35kVhTY75B0x6dDRfh+hgPBlCPrx8d4GG8Aa0NwfWQ6TnDvB+YJw0o+NxvWWc/XGLKl7fgJDfxrxYEp+e8PKsmKGMowivzDaYUfRpMZSPCVOYu+DaaIgoVuG312S8FswY+VtUEUoVZ9plZhSendz/B6un7G5bXDOoR0xksm/ny5g2Q6zSAY4VRJv6LpRJO/McH+LO+s+Q50l+vcXAdWfCPFGH+tpU1SnS8bNuNcMDLAOfghmksEIql33RSBAmRquDwCcZUNOiiZV6LtLexnV7EafFnrxtsNvcPxeSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q38POZGa6y3wkXhzKD42r7jtGlc/FyfkNHzejfz919E=;
 b=aEbcTHZMRjHfX52PljO9YRDbIiVkF4r0goS1kmW8YNwIvOa0r0m+jKObQ5uTLy9MBlf6kbPcduErEDAzJhmXRdcI9JVZrfbX5EVWwnDZGES/GFVuzBoAwGppcjtSoPflgZlPGomZRYciMZSRNeQEdazhGkpe32khbmMjPpTzORxiay/2QKPhnfbWI2E+FDb4ZCr9WPkjN5vkSqwZy8M00UjVzUTcnc7x4akjKIshPXbLi2VwbF98uhZ2Agkmobc9VobgVgTeYaIJHLG9E0pAFQ/lEL7asIDEte9q5W8NEZ8d08GADILAEa49nkZMb0pdcrjkHy1JO7g0fMYX5KRO9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:14:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:14:53 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 15/17] iommufd: Add IOMMU_HWPT_ALLOC
Date:   Tue, 21 Mar 2023 16:14:49 -0300
Message-Id: <15-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0022.namprd22.prod.outlook.com
 (2603:10b6:208:238::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b90c7d-a54b-4263-4ea6-08db2a408c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PY9iqmyDLxQuRxh0nkZ9nvAvOJkYPrj7zO6uzOw7Mxqz4xsL7LKDfWxpJpS0Uhr84h4/VE0yTJ4a0isA5g2Qr0Y9HsWz51q+6eguhS1FP4y7h/qIejqll/noPLsu2tLUQ2kDVNq/QnYy26DcXgKlqrkNvHqYgG0X/EEJO6eqH+lgLbOAi5o+CPMxntgAV7+1RJtiqfLaQbLIThnHiEB9DdSRvFCNoQ6C+KyhaiFxWF0gsWO45BBERaEyNiGSR1tDCXwUYNPV/2sXQFJfGBOvrFPnQA0O6DySh2t2FWXkTHO7k7olawpL2ABhHO2SwYBw39dUjuILfbqX/VoJJK4y4dfLK5KqTtZktdt2M5VHR/lO9MlH/zmGKWJhTKoX71UVBFOYNWVH0TlWYBhavFMUO4TRcyXH5BxFHlE4slL2ezA3PSCafB5rAYZbDztQh6lvEQcxBH/VVWXQvR0fXKR6Yd7LJ59BXBstdTvH1GeNJDGFB19bOYlMzW1PsV78PISoE0do/fYkJiY0uhid7GE+UPSwUlIWusEAJR81V1RU/GUbYKXJUTDIKLqRsUhJSnnl0tqwzNH06SYkuowbrDmv+Tm2b4I6JqOrVxQIxV7v4q4851jl0OxEt7I5y5HR+ZiO39JS3U5naPCIWTIV//Cjhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199018)(478600001)(86362001)(83380400001)(26005)(186003)(54906003)(316002)(6486002)(6666004)(6512007)(8676002)(2616005)(6506007)(38100700002)(2906002)(8936002)(66556008)(66476007)(66946007)(5660300002)(4326008)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s6B9342r1u73maDDVb2/PzDCre2ala9UbobDfUCzgnaAv7cmqYMqe+tNGaJc?=
 =?us-ascii?Q?m57fTP6ea9eca9JNeRM0NQ1Vp3QbamXYFeU7tZWTGan8mOXFf+Ci37FTrqHQ?=
 =?us-ascii?Q?4+joUGmwT1QOaE5g12tuzomc19AxKTdTCtJAO21Ka9pdSZGbJS2xZWGmtz3i?=
 =?us-ascii?Q?y98nrYHocP1vTqY+/kxwmHBg73TqMWZvBW6Iv4c00rtCVzuxiHr86VSOBdyt?=
 =?us-ascii?Q?6Kr/twUQSLV+9GU129TfD/yzjkctNzSmL4tMzDXVAgk/5SBwJVvQESQBQ77P?=
 =?us-ascii?Q?92OwfdUhoDGbc0J2ct4OCvJaJdOumau23A4U9Hg+7oBGdFFJt1yB6fTMBdfa?=
 =?us-ascii?Q?3aCK3G3ERBu05rXXZfeCSdg9d7D4uK7Q5Khcz2TlX0O7dCoeQSW4n6LULuR6?=
 =?us-ascii?Q?Ap3E7avy5XhdW4cTWGrR9+L0IGUzXSPR0/jdDPC2w71NA6tPVWGUR1cvkhFB?=
 =?us-ascii?Q?RKoZPtS5oA+SODtndVYwXVb6G8rq/f4YPLYF0lsfj6MElupuElwKXSn0g8QO?=
 =?us-ascii?Q?jQXyu/ouYYyha6sg/dPoIclMMpg0iBeEwC2R8BGypWee9FSuNK+h65+rPIT5?=
 =?us-ascii?Q?Y3QOx3iXgwF1c6KWM8HI3GbPndFOg0jGQDYQDFm8M5RLjO5YCbU9zqE0WTCJ?=
 =?us-ascii?Q?Dq7U0hgCjyiEdo6T9SAMYOxL8Her9lH4L07x0uyfGeUuKKXb4i02Cu+cNnmf?=
 =?us-ascii?Q?f/N1ObBcT53PzYvTx18b/Bp9FOdorcMzubjyP+idOZXYiJgPwUtfUt3leyZ5?=
 =?us-ascii?Q?k9wMULjyQrt39kvhleVLN2xGGhWHX70Ne5NjMdH4wCt4D3rGMQM62oY+5orM?=
 =?us-ascii?Q?gKNDWf9asgBmQ+qyZJIIctzksUTy2aOl6BYT5rM9opI1Fsd1lQ/uSxw7l/Kf?=
 =?us-ascii?Q?MVBoo2pCRcyjbvDAQe/i5Y48mAOoBBG42CpxK+nixkCOnyQfNYDSE1Ue+Q8h?=
 =?us-ascii?Q?DV0g0LItC0vmrltGeHqx6nJIomw7Qx5pkVikOjGHCE03rt23AiiuiFxULqfB?=
 =?us-ascii?Q?gOSsB1f43qzDHrnzK/wdSl04VY0lrziP0pkwG/b1mnx7eXCa19nJzsjLB9Gi?=
 =?us-ascii?Q?+p9RRgXvBC3IHrIkOUQxts4FsKm5RT7wsrT8ENjyMFwiG+FE54ntqdPR4Zc0?=
 =?us-ascii?Q?7d5aXUjPVrfMipF69WxOkZn/7pZcYrrtRxTQ/M5czBebg0TEyBio+N2b0boZ?=
 =?us-ascii?Q?wfRHY2J7u3CvbGr8ujYAcm1yFCLGBBIJFEkl4N65rmC0BnVkivIDpkq2zIur?=
 =?us-ascii?Q?2tbk4Nx8Nfk4s63Kt5spipI6X/B1SFyCdYPGvKI6x8FKzFTsTKP6EF05IpwE?=
 =?us-ascii?Q?ZYuyEpulHLHDFXumT+qXr52/ePvFPfI9ijszuHiJMMIZfTggRFbeAr3fUoOp?=
 =?us-ascii?Q?0AqaQIfXA2rMM+pUPOfvQqeJCQJHXNfzxx7LlSe1aJRtd/33rH8vGvnPlVRd?=
 =?us-ascii?Q?tZRF1GHlTyFTl3CbQuFHLkko5sJrWXH5LFhppllgOtC6eVArvNVzdg5xM4vv?=
 =?us-ascii?Q?XOkDDIQgsvocSqPZAZ2NVaLKgYAkpE4Hf70sqqAbXlux6LPRoPXAPSTPlFbl?=
 =?us-ascii?Q?j6LSQe9Sah2Z3jk76wIj9YXKHTvHPQmYqEZme2AL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b90c7d-a54b-4263-4ea6-08db2a408c86
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:14:52.8817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bY7YUaXvMeDfb4UPn5TkmvHW0hlSxsGwXA3tkem7OQYPFlyLhs9r0sXmomHlcO/I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/hw_pagetable.c    | 46 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  9 +++++
 drivers/iommu/iommufd/main.c            |  3 ++
 include/uapi/linux/iommufd.h            | 26 ++++++++++++++
 4 files changed, 84 insertions(+)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 2584f9038b29a2..30c4c44a99b7a9 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
  */
 #include <linux/iommu.h>
+#include <uapi/linux/iommufd.h>
 
 #include "iommufd_private.h"
 
@@ -121,3 +122,48 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
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

