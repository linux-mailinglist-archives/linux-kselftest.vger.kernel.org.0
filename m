Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BDB702F0D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 16:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbjEOOAv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 10:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239087AbjEOOAu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 10:00:50 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5A31FD7;
        Mon, 15 May 2023 07:00:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R43DJ4Tk0kdNe1a3PLZqlFYDliC0Fwa4wf0CfFEwRMLmcAtApvNb2jSORi5BmtEmHnI2lY5KT2z9N6/4C2UHwD4RgF+6aT9Rf5cKVDge1otlkjyHUd5E17S14wrrlZExylG/vxI+rMrD4Bz74DAIQXY4v4oK9brOoiRaW11GUPX0fxNmQXNY3St4bVyG5M3k0W54lI6CBFz5CJ72POpvSDrWqMDjJvdEMcNPUFH6R3ujQqmYRDp8g1d1mjJU7VSi2Fs6sBioaii4trBUC6pOtFfn8JMs7k4MCbnbYvOlvZNohTGe3YAn5iWZRHgJT+Abqar8nsDx8+F7W8NMUuauBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtRYv4r2IYN3tux4wNw8OdeFvoNFE7mP2gnPbZGZUXg=;
 b=T/5+Zr/0Cx0qYRNDq1ZMcIjh7tTXb7oRx0teEaFkehdYwwhlj1Bg46/3aL6TzPDkGCs/JSXJ4O8t6y4PXNMDvnnvsBkFBYCmyxhg5S6EyD5eSQKsaCErdbIQpEjk2giQRUH+ccMEThZipdcmbCjB6sP8w26rr8wSwlFtceSbADlMdj6A49rEKRnv5mc3//AePKSzoUQndfe6ujMaIlB3FM5DsGRCtSMHJaj1oTFdoxkSLFuyaTQEGN6rwPMbz2xur84YGIQu82pq10aGXIss06kH4ruhVrqjA13ucN2HK8RlfhN77Jon6w8SVFAQKdKm9VUObrqtCXRF95cMgufcVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtRYv4r2IYN3tux4wNw8OdeFvoNFE7mP2gnPbZGZUXg=;
 b=VswrPXpeH3AnmXzwF1FanO+CnkO9e9sbNkyvfistxBkKYlSioBT48BL5tsGiAQJNtR2Y8t11husRd1sUjYwO2ABc8gzPbuEnZUOdXTeTCUE1H/Po6Kyw3upnt32KxsE8UmyyY6BjRi0tZ4TcK9wfx2+wtrKgnvmb688/iLHv255E3CbBueiv6gpAzey55471KTrhcrnuC0I8/GByKwLxXv1n795QuySsWAVZI7Z4JSuNr1VLE6vdIjBMzNvt9kmdk0LqMzi2ZFlsxQFms+rMTd/j6jIuGy/3m4YJyempnJ1ywFPsOVKspWCeSu2u57+sDPq56TCzc1ewWqW/yPnaRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:00:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:00:41 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v7 17/19] iommufd: Add IOMMU_HWPT_ALLOC
Date:   Mon, 15 May 2023 11:00:32 -0300
Message-Id: <17-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0005.namprd17.prod.outlook.com
 (2603:10b6:208:15e::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d38384c-a658-457a-126b-08db554cc1c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UZkr8c5LnelYMzbB5KVnkLAc/8lKC6NuYsBCswvIpj53mtcnsshlMX3TCYYVMWBZhN39qwg/DuNKSy7Qog2z5aVNMHNEh4fBYaOP8U8mT5mhazmNzbgP66jtXYXo/0L8ESXSKu/AiFs8K5wtOhN/eNvt8zl477qartEXs6KHvHpDh2+AAUKoXXLcfCyVBblkY1Xmyvac9dCQhoE7Sydg/NZrVfDi4VeX4z80Z3V3Uel6uJ2gvOU+qWr0G6F5U5mj15x40nqB39FzyOiN56qUeYxvj0/f1tNIh+c8JaUQl0CzApEnYjCrsjdesbgj0zgj1m0JcLVur6GD1Erc8t4ClX9FIniQNy+lmxlI6SULKw4iTP0QfFOaALHtcDVKxQTzTdxk3HFnH87p/yZGg5Cg4cQuBHA/+cw99UpWvYGDPUNa23y5h6PXPrOC9SlIJqHfdPHDVJjLg0Jz523boW/Gqj/4oGFdK5qjzs8a5cbCa9KntcuoxPrg8LxWmRQtY9hL89GEyxF5aQM4kDv7r06ITuzy9nAAHb5vlTBB+Y3augIJGry3GPubjlI3443prtcx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(6486002)(26005)(6506007)(6512007)(478600001)(54906003)(6666004)(186003)(5660300002)(86362001)(8676002)(8936002)(36756003)(2906002)(316002)(4326008)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sgU5/eZxBqbepcB9N3OaBMY/zksQZ1126qL0EbW+yqs/6U6710sU40Ej0oNP?=
 =?us-ascii?Q?9pa4Nwcfx0PDAAUa3v8Cqptip2EuDuuQh8lRyWziLLW9I9i3hPCRIvN/9YZN?=
 =?us-ascii?Q?q19aoLg0BHux2lvHJBjsOkb8U+p3pgW+DfzILoJYewNXmy1v5jiUDl8e5fW9?=
 =?us-ascii?Q?DhDvL+4G2llSDkmc2ukKzSSAIzU837lt5f5mkH2G/ppcLbfs86ypG+cr5UB5?=
 =?us-ascii?Q?GSwQuL8myfW9dGCz4mNqEds//KKjHVPhIWhWkNL/ia2ddDQ4C4r5RQjA936E?=
 =?us-ascii?Q?bk0zLlWokHsbd3c8QQY6HKkeZUb0EW50LceXBVpoqQaZgd1lvzyN5ohP1HO1?=
 =?us-ascii?Q?Wi5NPbzf51u/y6mYRDfEoi1RnOFUk/jgVXFmYbjotYGhSM6iMrqesIrltoz4?=
 =?us-ascii?Q?Ezouzzm1shXF9uMcLgUqqVfI5xiV7LZ6UCYCZfwXLO07owZuh0cWZWvHii/D?=
 =?us-ascii?Q?3PO4bktQEDLYR9WfKIwDFlffmE9wIN0Z0GdGs+HLvLfEtTmzKcTT2I49R5Tf?=
 =?us-ascii?Q?KDAwVBleCpFoxXQIR2PNUgZMZnhPFLAGIOhzR2/NVHuDWNXiDgPtP2L9HyJL?=
 =?us-ascii?Q?AwIg6rVXQ0WCLW+KVCKatsvx4DvRd93rdgK+RSBndizvdP2khOVNFcEXOYho?=
 =?us-ascii?Q?4gOWlRCCZH+XJ9+IqXEGVXXFNH86DcR/KwZxroiNPClwnsHrHtVeq+GJyOrV?=
 =?us-ascii?Q?wUujCFdEh/wqtT0vFgEQ996kYf3oxKgWlfPN19tsRUAgDN0jLZALH24iwyQk?=
 =?us-ascii?Q?BWYvdihyqSsSO6rejG4owrew8hhsLAwuP2C/AE0rGnK9aJLCKsyF4Pc2ZO9H?=
 =?us-ascii?Q?E3KsDBYbInnfxKIc5GNzesvM3ioCrmw+IX4NlhS19mexdHwbYXGl9zKw0Xxd?=
 =?us-ascii?Q?Pk7OOlhqOdq4JKuGuBfvjTaupuzZ0CnpIeoYFGuziAval1vQK+oSHFxEtUSU?=
 =?us-ascii?Q?WiiB+sc4fpqR7e1/Tz+dtUDbcIgBLJXoFEc2jF5Ypu4F3EL58BOCe2Unwc6G?=
 =?us-ascii?Q?ZmnIvNHSdDORyYhN/2aEbJG1onCk5VQSolxpxCj1WRETzijWFCGiRPs8CtZY?=
 =?us-ascii?Q?Q5i74v7IcABxjCj7rOolTCtPXLdVcS/0KCYUHhnMrGgPve7maynp2AVhThO/?=
 =?us-ascii?Q?hiw2DeuUED4+8/5IXXt6DdlODON5j53LjlFG4CLgQxd/siAIZyu9fe0dYLYS?=
 =?us-ascii?Q?JR2nodj6UAr9kJsZlyrRUnU6RvBFvK4ClFSELxIU3dnUGviKKJ7gIiABAgE9?=
 =?us-ascii?Q?+ixo/+Q1/K+yYdKtdCYTTRTdvTpGCJamzsIWuJIr38GAXL9gBqUF+OQe5XHt?=
 =?us-ascii?Q?MejkEOwsKwqvBVmH5UZy8w+XfLcucQ1NegbsljzFHB/lAi9DtsTPFBNbugSJ?=
 =?us-ascii?Q?oXB38sUIr93Z4ejmd9dqT2uN+XVMA7fQNTMyUvvLoMoccgcDNAVQmwWseANT?=
 =?us-ascii?Q?7zU0MHPmcJ5uPNvm6xyxSDBkNEcX5Ym587QIDYo6jf0ZiPDdLsEj1o3UEBQw?=
 =?us-ascii?Q?zHWhAERnDHdrvsULHjXspai8+O04YtJQ9MJk9EJZABIiBz+P+dtBXWjVpwvA?=
 =?us-ascii?Q?cLdHSpLpM4uVENmwOoCeqbeS7tA/TSS0akarW5k3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d38384c-a658-457a-126b-08db554cc1c2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:00:36.2175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XraEYZxEcazls8NI0UYVomPfRuB88qpkmLx2iYxGxvG0bYidu6I3x9Tuq3UKciML
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
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
2.40.1

