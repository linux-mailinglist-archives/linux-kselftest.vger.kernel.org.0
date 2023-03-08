Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD506AFB49
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 01:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjCHAg2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 19:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjCHAgT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 19:36:19 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8899A7680;
        Tue,  7 Mar 2023 16:36:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfoQw4x3kGI5SA+Lka6KGityZSlBFobxDd+ynJm1fitbiPaZC6QwhU5VrFSpeP/KMO4//0pobvO0AQXTvJJR8YPUmwviHCRLSPEid/mONdgWIXIxNdv3LO96bsYaWpRI/GIbYdiJsByPd+48DB/Bs4duD3cmd+st1u5UR/6zCMay5uMtRvkaLaGvjQng4wsYK+6Jk36/BhKnXKtR4SEe8H9A06dxDdRCt2DmKP21SzYOloyHR12Qpktcz1jbz7fA6Ot4dsf0EYfig0eN1SgnfYogEBAnnMhp/AWJZhty/yJfml8eYqICKzZj5PFhBZVQcp8K60DB8rRe9H9Fd4IixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgOTId1p1reb/9qEk6FfJIw48Djw7Ii6fn7uA3GafNY=;
 b=nmE/72dwzkV0Tnmcl+J4KKVU6y155I70b5NUIb5CRB3xHS8Xbc+IKQdy06aCw2G2IuSXU7REkw95u9PuxiDlOWGGUXXV2V2zrVpnCXWbNLiCDep77EDcej/yru5WcoED3ilVK/GeDfGjv+Cq2Jy7Ag9SpBF1PmaYnpMBEEJtYmqACgM3YYBYrQqkTYBkBZxBc1k+FNrruXwULABkci4GdZil64Pqim/TlUkWSiESTDKsXg3Q/ogEtuzWw+pO96ytg4FZzSIwtNps4bkSNsUAyeVz8s09h/ttINp40DiP9WgzvG00V0eglty11MGSYUWdv2KZnG92OwX8VxrPBnfKXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgOTId1p1reb/9qEk6FfJIw48Djw7Ii6fn7uA3GafNY=;
 b=agPK6wAKyGy46o5zim+wCyEOcEfcCgEmfDYadeJt0vh9jFBD7mQIKPTzQJ722TaMLO/WjNYsE7Ul8xUZiP4UNaiYeZ0m2j4H/u8gEiB5jp8t0KKWl37aH6dIqW5whJm5Qt1ttGrFWMSwBdIW4u8FbJv3I86tTfjBPZRPXZg+7pU4BscfvMFnGSgo/gxTaJv/7/EASua1Vfamq1+bgdmFrDfYwTrzbBf+LzdcIDPBWapg5Ka5HHqbVQQwr/4oTlHEYJT1SSkbeNGOvnC5hgF/PW0F4yinfp7xw7do3NKmwytuz4QBiWmVrZxZXH9k3aYPtREKsj42jhj31XfvzYc3YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 00:36:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 00:36:03 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 15/17] iommufd: Add IOMMU_HWPT_ALLOC
Date:   Tue,  7 Mar 2023 20:35:54 -0400
Message-Id: <15-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1P288CA0004.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::17)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: afc13432-32e5-4326-20dd-08db1f6d17d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vu5gstXlLWuGS59tSsQMzS7pnUEEMvfnqZA5Y4YNzY8F/d1Wb/eRRr7Tq0WH4EH+7dDLGND+lF0Gsdc4/8gatvB0rdPzfbM6UK/BWr7wu1GTS9uAMR8LTxCWkap0v1QFizFnTKeChSAZf9qTby4bytZCZ+/0ysZdK9xnQ8PpIGHgaReI80lieuH6TBEgzPMUy11Royx33VBqEf0GuYdJ2WLhbOllhbQIMkTPQgeSsX+u+C6mTf6wJREJAG4JhUyVN6wPlkQD1KxLq05Z9uz13FbZCmn9yq0pBTweSaykFry60wqnhS9qZTrbkTyBW3u9x/omUOkcwMMSMdkGo/cnDaIMaxifPQUG+skpJMAzhfg4hqAl/5M3MkAlBL9+VxYaVEqA+2PxgK/hPvT6DmywDWcti4xjJ5vR3VSQFv4BnHCqo+fxUKa0xuhKKhD5HwOjP53eCQdYVRypVsMGfAyebXbDIk0FPt1OVzZ5khZxFWOKt1FjH7PUL5B6KIxIJqs8nCxct5RSD4x6uEQYxTmVHzt4zpB1G9ZSc3X5BjkFUZFlEe0rurC0/9vNcSm8B36840/DV5cQBonq0vuXJyQVm8lNQL4NAjTgLXrym+tH3PDyuD2TfztEeNw8GPIi4FzlvurVhHPOfI2gcIKh8GC+xA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199018)(36756003)(41300700001)(66556008)(4326008)(8936002)(8676002)(2906002)(5660300002)(66946007)(86362001)(66476007)(38100700002)(6666004)(478600001)(54906003)(6486002)(316002)(6512007)(83380400001)(6506007)(2616005)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hFgWYRrbEfhOYxmpQCQTT7KQaMtuU12zZPvLkZX4nUI/eZnGe9q9KzIOKL3r?=
 =?us-ascii?Q?nU3x47yOFiX8E3dofYcj/qKTUgbNrwBZdtGC7e0RVl9rMPEkKUQs9eHNHKux?=
 =?us-ascii?Q?52YKDhZiNSmsJa3xsVZ+jdW6/AIuDdnoO99Fz748B4kKBdeIzCDFzSWPreTe?=
 =?us-ascii?Q?4pPOU2vhcT+rBAano8sXVDx295Lp1OJQYgnChU6w9B31i3DCgF9p1U2DzcER?=
 =?us-ascii?Q?mCuNcpkXeWDSDb3X3Ob9DY3cgFJJb8mzvhDUMR/DVre8vMRH3e8fKCnpVuvr?=
 =?us-ascii?Q?SrCqKBicOtdlwcEgrmgwCCzb2o8hURpgwUkMIc5G5JZry0lr9ix6yQNzjrOJ?=
 =?us-ascii?Q?YgkgnFUESS07Ng783C1YBAyDlCjCNQlrdOTpKastFgxwbT7UoE/NXktgEXok?=
 =?us-ascii?Q?4GIIPkj+DPjViatjEIUqDU7fqYN/RTubcnQ+NdCUR9Rfw+IbJ/mdNqpdjQRB?=
 =?us-ascii?Q?NOh6Y9ca/X5qEdltCVu+87fwQfeF1bh3PiHrtrNiEw7fct4JnnCs9OVGzxO6?=
 =?us-ascii?Q?dFCUo8giajVfUi8+/Isu4j96oRrXjkloWm7i8n7X3yY96YsJhFV4/RCUkQ5D?=
 =?us-ascii?Q?RV0GsMQVKb2ZKXOhFOymdDXwLUSfNT4ln0hZAlx5YzkCqQVp/C1J7FDcnnlo?=
 =?us-ascii?Q?2XE3TIcBtV1XMilsar71O1Jr4mromDnrpvTqWKm6/+a/dT6kNffj7dMd0AkG?=
 =?us-ascii?Q?sKqeXZuuY/XrVC6Enx+bGLD+G6cFX+dwLVy/VXa6ZHo/rhL1L6+YrDDxBPXs?=
 =?us-ascii?Q?GQ9nomGiIvjZH+tVFkT4Ch4Wv7WMj3Q7055oobkv4eMhAmdPK3bjcehk+j3r?=
 =?us-ascii?Q?JIGRp40msmQM3znFl1//nCKP0DR5b/D0tw7Wba8SwKRmZ0CLtN9qrr0PEVsA?=
 =?us-ascii?Q?kxLUlbn92kmeNk5VmZ4lB8Cp27DB/jxKe1AvMD54VXT0wAxRxJh9CBh10cm2?=
 =?us-ascii?Q?L8nchc2tU/38P4pOGeDl4elKSGjvV1eH8S49hn1dKHU+Oh/GwR6jQnIRIa3L?=
 =?us-ascii?Q?i7mlQPYLDWRU0ZRgg7RTkff0KCQ1hOFp6naVmre8IiEQaWwFPA4vSeKMiSdI?=
 =?us-ascii?Q?5uiJGfhccaeHZstYXez/U6Toj+VFiAf9jNTrdl++iqIOZuFnAJvo1j8/R6Ty?=
 =?us-ascii?Q?1jrGMPgqvrTjJwfzP+2Yrj/mbIq11NLDmMmb4hwrH/D54UzSaWi60Im3qfFK?=
 =?us-ascii?Q?qYXcu8mGgBg4dBITZLzV5NqOr9kVZsGmDku1yExQM3ye8GWGY/TCg5SApXTK?=
 =?us-ascii?Q?Fnnabpiou66jwpMvwtFy8yvNwI+bytR4K4vmXrQ7QTlLJwX7eLMBILm5drip?=
 =?us-ascii?Q?oDNXMOjGDjdqEKQce693dcNkqB37BqukHnYgPwY2wp2E5EyWkWM40rWpZ66h?=
 =?us-ascii?Q?cvfHE87xe0g+hgM//919QvP9/fpMDXmLv91CDdgSLrDrwcCmkAdnbUiGTWDc?=
 =?us-ascii?Q?QiYJsY+fLa7T0FhrOv9sPbTqw/LbLsutl/rLjZjzNXxlFT0vS3bEGxBo1Qap?=
 =?us-ascii?Q?lpAFRQ3E4TwlPHsJjLp6nhMLRXuddwHmaWy2qPsLhiKYTUMpJJWGscGghxbN?=
 =?us-ascii?Q?v6hGqrNWYPjQ+ELLeYDCgHu29VJZ5b/nq2iVpuxf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc13432-32e5-4326-20dd-08db1f6d17d1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 00:36:01.6253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X71+2LUPVn/qL4AAXRLJjK8UGobP9kAoNeRMA3/BcM44kR6G5diMcEny4MILVS+J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
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

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/hw_pagetable.c    | 46 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  9 +++++
 drivers/iommu/iommufd/main.c            |  3 ++
 include/uapi/linux/iommufd.h            | 26 ++++++++++++++
 4 files changed, 84 insertions(+)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 2584f9038b29a2..13bdab4c801bd9 100644
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
+	if (cmd->flags)
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
index 98ebba80cfa1fc..ccd36acad36a3f 100644
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
+ * A normal HWPT will be created with the mappings from the given IOAS.
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
2.39.2

