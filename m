Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1ACB69FD59
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Feb 2023 22:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjBVVCy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Feb 2023 16:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjBVVCv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Feb 2023 16:02:51 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485B191
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Feb 2023 13:02:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0IeOTCBDegFU8SM1DWgLu5KfpqKbKXr36uJ2YzrJnB9U3bDzvlsicQ9OV+QT0VRgAKmvUnYeMOHdnqacCmFwGxo6pQO59jn8hs1jUYNty+KyfYo3etAvObjJz7kyVUdF1gsr0JuI1ynLUwv+m4Y34xz4yNFKQKeM/9bsegBuzTLw58VXbVu0Fp22H84Wd9iHXiE93VfQgdatynECGFJ9LqMvy/XK31o3242Lqcm16T/Dyii3d8ecm/KQRTRVU/2xZHPS3q7DBG86p5qzoVPAjtW3RdEtcINDfxKsAzttvGVegCWdd0GY/Wam0b3yb8LBnAfKERaltUbhzCMKtM6IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+vy6QB169xpVh0cvhlxe3tTYvCoCop2P2aKhq7vKaA=;
 b=lrPrHY/SARTAItpnqpXKtEqZV8jE0Wzpnmij9SxJs1QycNf/k1dY5kinjIA1vaSTJe9y/yriFJfeSwWpycMRpI0Lu48qJu2dSVgLMVRWN8TKpm7NVK6IxF6P1ND/u5HI3vx/UF/FE51P4EmT51i7+J4FeQs0fHiOjuZNzAcXjwWSHc9zx1NcVTtxDP6NJnhcNRwCaLNOJARZAfiaue7iYooC60QsugthfnTiexp3u7prqXdegrHfl9gRnEl1DYuIQayvxest5R3aHsJ78BZpR30m5bjXdLD2shDCqkUiSNP8EI2KNhgKNIPOuUTwkrHoIyeFsRquZuyXpyWQ5nOEsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+vy6QB169xpVh0cvhlxe3tTYvCoCop2P2aKhq7vKaA=;
 b=AGzWa6Y3toW1iYzQ+Cx8F+Zncu2IAkK2X71JeJ2kkEjGkVNnuOF00HgatZIOtmW5iWisVSciKMoYgYi0GGG8GVmaiWIh4YTcek0BDAF75/iogguvSyvKPoqmiDqhNc8AI+rGGDLZeSW8Rb+VlFvOWZkxVOP8CNvWRYoyF9K5myDZ4MYWD16CsLhpn4FGnvBQnUROjlhv7j+InG2/CI8nKhxeu377OhnbrRFp+OB8S3K1uEARKWuGHOLT6/NYuxKpwaHDZx2aI74eUQZNl9MGKng9yE0KH3NFzVJ8NGqNIP7fQ0jaLWPhLYad8twS5Tx9xr0RjtasjkwOkMN898qT5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 21:02:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 21:02:43 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 4/7] iommufd: Move iommufd_device to iommufd_private.h
Date:   Wed, 22 Feb 2023 17:02:37 -0400
Message-Id: <4-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <0-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0009.namprd12.prod.outlook.com
 (2603:10b6:208:a8::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: 38deba6d-6b4a-4c05-bcb4-08db1518236a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Y8OVRL0/8nPlQXv27x3gQECbGfgnZu+jeFrmuJ8oRcUU0NzCSkpP3jajnvZAxSmzu69ZCcEv7uoAROSTaTwpxj/wTus65JvhBBCAq7h/HzXtfEDS6qgCSj14cKd/GghtoaTtF2n9K8+mRr0IC4p/imBPaJlYDPXL96KXomzmdIKmmXF6We99kYT/IOq06M9Nrrt6MGswgHd78U+YcV1xo8eAv0G7o8Dq6S2s1xqcxI7Q4Sb1CVR1H+JL39ANVFD67xWlAhB6r+U0XwMHqWvNiWns/jUnPtN6pLyJkERbraQxFJyIg4+DRXmnHDTzxPXUfO3K4kHT3N5a5kQvllWaGavvkeNnCay31O7eVLLprSUGyg0o/iP+Ju8EezCaZhJ8lioa3NejATEeUTKk0JOa7LnWjWqEMrnix8BHStEddaNTh081NR+WGT1Cc0qnRXiv8I1GBtx2Dcbl7pgiA3m74UM+zxERZLbsCQ0ahwOs1wrCArKYAuExZTfTGjUbP4/hlfL1YT9jLbZqGDf1zW7azd9VFoZFC2w5XVRwWnW3RN178/YpBuKfn5bgQemOKbeRCemZXPvUFZU+ZBithNfQWiOyGfCfRJRjPmwbzlRHOHzBFa56V0xwuQ3uBj1fDA5JPhsoXCyRVkNRaf9tTlE5xPYKdfCeqgZuSjzLBEt35Uguj5JXAZpxqE2pGd5qpX3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199018)(86362001)(316002)(5660300002)(36756003)(66556008)(8676002)(6512007)(66476007)(26005)(186003)(4326008)(8936002)(2616005)(41300700001)(54906003)(66946007)(478600001)(6666004)(6506007)(110136005)(38100700002)(83380400001)(2906002)(6486002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XdZdVH3+o4AvYIkqI8keoR6tlIk4ROXcXyDrFxFCwzDzvi8hwDrWofRyFAZ6?=
 =?us-ascii?Q?PQqAPTmoDdz6tQySEgZOnW6qwh76nA0v0tw702UGyCs52UBP6v4QMYf0rXzb?=
 =?us-ascii?Q?7IwCBI0PG/UlyNHuMJo0SppXFxMmJhZXLAcyxUKd8DsuS2mT4N5PQXgh01QR?=
 =?us-ascii?Q?+fp5ot6p67wqnBT+BR2iAuPGf+NVVQSZcw5dR5plfpFomk+29Llx3r/QE1PY?=
 =?us-ascii?Q?7iNMSiyF1CPx/AT1oR6SB7idqpQXbL6kUGzC03zB0xBh6/dfzA090DeD/Lst?=
 =?us-ascii?Q?AG5LNgA79+aUc28gg8Uz1BJQb+4/zZCW8O3gzURQqOLFSG5t9SSpPuUnytRy?=
 =?us-ascii?Q?NETewo6AwO7hZB7RUQN1v1szlsrviMpc9fYXSa7Mygox3zHh7oYTl33wbkSM?=
 =?us-ascii?Q?AVDzFjerVDYanVzdi7Q+95XU6lAGMLkmWTnnAmXGL8mu128vXKR16cKw0fuG?=
 =?us-ascii?Q?qVhVLJYZnpAG2fE9MXAstseiGmLHRIArTNSUa9AjbRHz46mcoYR+IYgFY8pH?=
 =?us-ascii?Q?G2VQM32zlh50jZ8/JNrSdLHn3JWZl8E2IZCkTe84fnYOBrTJ37fKPGkkmNnH?=
 =?us-ascii?Q?OMZuBV17nCjR9MeuIKyeMq6B4+3YHVTRWR6CPu13oNd4u5/UmNXjBhhQuJMn?=
 =?us-ascii?Q?Vv94keQnHCeBMtNE00TwuvfqK2AG6H8qNkRLRWN8IumUfeMD0hxwukQob04V?=
 =?us-ascii?Q?ICzkRpLniv+5Yktp7b6ud1nX6y69j2BPvjk3p/Xz1ATwkVxG5Z7aOzUTmnLn?=
 =?us-ascii?Q?YAVY8NTDTdgUpW698Gl/OUgNxeNdOVxcKsww+jZQ2M4W6IvfHkORDsHSB3fU?=
 =?us-ascii?Q?v4JdqLcqk1cM40Asgte13tGCG3PZgfHGNaRvGYlqX91YRmrH5pnegpu7fNqE?=
 =?us-ascii?Q?gOnTT3yVVUzLB6DRIrLiJKsQPRn47ZVLgUhoQaDcQjnk731ezxy4jq3rHoKp?=
 =?us-ascii?Q?bBUdFE3RF1DNP51x9PxI4XdFjvULnQGhctP7qLDinBRyGlGSFc3iF3BwJIs3?=
 =?us-ascii?Q?OJnPJupbMEequ/6B0fan12oJBh+CleoGLc+7vbUUM/34LMOTCo/Gl4hDBmVf?=
 =?us-ascii?Q?LE9Npo7gV/0ORzpNPh+1XhnMmgGR3h4F+42/XCSQu7Ofzwjl3Q2UfwRboTNR?=
 =?us-ascii?Q?hERrViEADaEoMQRCI7YIRoYHjlULZREiLVhhgb68T3p9P0Sx7ZoZYviP9XW+?=
 =?us-ascii?Q?eZPlKpqdWay/r4GUJlnNAlZIIy6kWt9ZNM5NEtCx0HHwRZ47GhuhSPALrf+t?=
 =?us-ascii?Q?uns7oon813vg6Q2AEImT7oovsQR7zJ8NrxR5TC4Iv+ACORgOEQJOhWET0I5H?=
 =?us-ascii?Q?gmuKA8vDZBFV/UUaApCKIY6O8ZwZ394QVWS571+2Ci7D771LivAVk10SbtBQ?=
 =?us-ascii?Q?n3j74w8YLHoLvJvHg8kpoGAOmxzayjVeFnKrl1VTWEVvaDhyaqX7Y7yIfI0O?=
 =?us-ascii?Q?/SQR3cF8BtKLgOGhkAW4LTOqark+CZNQPu8DvHwjwKiuDI/Rcg4IuJ/7H2Gg?=
 =?us-ascii?Q?G9lKc0nq06Bes0awwLEru86q0U2WXx1Z/9/xgN4ZLfEhVr2wa8FQhCiLlCE+?=
 =?us-ascii?Q?vNo0AkwwEs1eXLP2mJoLZWJXL4FEabOV7w1fw5w3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38deba6d-6b4a-4c05-bcb4-08db1518236a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 21:02:42.3621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b7mWRPVBNrdPQvLguTVX2VbZ3hYjWJS2oyyreDr4BlKgmTMTcTWybIaXQNhd5fuf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

hw_pagetable.c will need this in the next patches.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 17 -----------------
 drivers/iommu/iommufd/iommufd_private.h | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 6787a0d8d6e9f0..4483c06e0ec38b 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -15,23 +15,6 @@ MODULE_PARM_DESC(
 	"Allow IOMMUFD to bind to devices even if the platform cannot isolate "
 	"the MSI interrupt window. Enabling this is a security weakness.");
 
-/*
- * A iommufd_device object represents the binding relationship between a
- * consuming driver and the iommufd. These objects are created/destroyed by
- * external drivers, not by userspace.
- */
-struct iommufd_device {
-	struct iommufd_object obj;
-	struct iommufd_ctx *ictx;
-	struct iommufd_hw_pagetable *hwpt;
-	/* Head at iommufd_hw_pagetable::devices */
-	struct list_head devices_item;
-	/* always the physical device */
-	struct device *dev;
-	struct iommu_group *group;
-	bool enforce_cache_coherency;
-};
-
 void iommufd_device_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_device *idev =
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 9d7f71510ca1bc..84fe19a195466b 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -12,6 +12,7 @@
 struct iommu_domain;
 struct iommu_group;
 struct iommu_option;
+struct iommufd_device;
 
 struct iommufd_ctx {
 	struct file *file;
@@ -257,6 +258,23 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			   struct device *dev);
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 
+/*
+ * A iommufd_device object represents the binding relationship between a
+ * consuming driver and the iommufd. These objects are created/destroyed by
+ * external drivers, not by userspace.
+ */
+struct iommufd_device {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct iommufd_hw_pagetable *hwpt;
+	/* Head at iommufd_hw_pagetable::devices */
+	struct list_head devices_item;
+	/* always the physical device */
+	struct device *dev;
+	struct iommu_group *group;
+	bool enforce_cache_coherency;
+};
+
 void iommufd_device_destroy(struct iommufd_object *obj);
 
 struct iommufd_access {
-- 
2.39.1

