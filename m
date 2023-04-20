Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0972A6E9BFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 20:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjDTSvv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 14:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjDTSvs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 14:51:48 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC75346B0;
        Thu, 20 Apr 2023 11:51:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqTP4r/1y6IhfH1KF1H5b7GGtjHREVZXhQMxLOPStHZtiAI9TEDqAX8PFN+Ad2FtPI0vnS1rkaSFZyE8UOk0Eipfy6ITz2Z3c+Xs5u7oQWRd81YqqpHg4N3SYphyCL4rdBuxuv3Azopx9GQ5skYUT6olmL62ESHmuUJElxOmKKeGp1IqSsASgw09nJHp9jxAklsq/cfmjp7RohDHoWm0p5FGM9Z1sQoppjkILK4LR6vGFCBe7EaQAcVuOkHlexU2W624L4aMPyNv+FetnJw8O7qsaOGyhct6FsZavKqAM6xFcz37geAx3acRdpZR5k57kEDu3E3sN66ETsPREkaKSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nZEjWqCAUjxSEZpEfp2tV/0q2Ftz/hRVhWNkh9mIr0=;
 b=dtL6WR8yx+9GhDgx9BF27PwBmVkDUy6RH6B8c+DCaAgu/Tg22d9mQEZClgR8U5U/7QKSuzUhPfMK4vODJr6pc/SU01/RSOLwVtoEg7O7jbNCv12phFkUeCHfp50qpchF2VNrM5Kj4sAIIGEZaNmqd6ZXtC2YvgSmq8qV79uZQ5W1T9nOeH0aoTzIklauEJJguQLQlEV8WdiI/X7pFUXjawMHQBUNpSgWZOpKnQGifulRWYiWCoKvLl8AmQNDWW3DzrS0spV2EusvuQ9ExxZTxODpvyf9NumZvIP0DSjHO7UMTYdiRBOxZEXf/1wh5JmjSyX45+MRgDGFS+J5Z/6iCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nZEjWqCAUjxSEZpEfp2tV/0q2Ftz/hRVhWNkh9mIr0=;
 b=EtnJrkyO1c0hZTz+SiSiwT0YEY7ENU9hSa8RIUI5OUnccgDEKvT3A5Qdlqgr2l6IqlYmZyXHp71WlTdErB/qdAYrfJPAImmQ1uOPggrOzJTmzn4/yumfXWbzhO02MZ3D0ysFEYZ2pRta8bgsvtb1stfdan38MOHr7/RoIkNVnhGpO3Mxs5jcV5XfUpg0y/VnybbDmRdGA0cc7tJU+9ZvrRLscPmBaqJy7pky8tFpUHA/3EdIjEMdCS5lWl3Iefl9JwQE8DyDA9Rzib25A36EoRACfQoyWZcgewkopxS254XQ6msv1pice4syt0EmFqcF63uqVAQAq5/fIZ87PN2bFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 18:51:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 18:51:42 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v6 06/19] iommufd: Use the iommufd_group to avoid duplicate MSI setup
Date:   Thu, 20 Apr 2023 15:51:21 -0300
Message-Id: <6-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR14CA0003.namprd14.prod.outlook.com
 (2603:10b6:208:23e::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: d03c29ce-0e77-4ad6-da8d-08db41d044fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d6uyil+3EFbmp4Hy0NY/QeIt/wn7mBuL9b+65eOeoXW44UUrGnXfeu2T0B5wnxhRKjhkJGXeSY1IHddemFdFoSdiWHACTbQDTdOro7AEFqy8qvDySO+SAe/l0hLss6dJ65kO7lyN7L3vfNA9AgpDMTXOJkcjhn8sXUVpn8alUVrcQ0T4ilKucFaEqFY8LM+DolC/I/xvtVX1d7F1iep/iShZIlP8H7uqeZwixwo66yrHzUNSm2IftdtdX7SIn2nXbogc5C8dKm+EAznrSA6uouseQh+EZ5FHxB67IxXC07Hw0ZvknzP7YJL7XKhedarLteJ5pPmJ8WzSp/KUgUoVYLkAMIuckhWHWKYRxniDISYsBz/UaXC1Nw4he5C09czCbdtGHf0ZhHoF1n2WpRYd8t54WetZswmUW3kW+k3HD/Frk3wsILlF97rysZEdWDj+b0m9Jrnp63jyYAmiTM/tupEt5JMUsqfCzumullZUVhy6QDOOfY4I3gvX3aYqSQKUDyA2YaPipPP/OQwQFbUDq8X6z+/yCtkScHSUXVcrWa6a1wy9L8Id7IaZkO9C+bXtQjRPVysdfpXVaQl/wK4zLLRlh9RDrCFjZVD+vpe/rN4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(54906003)(4326008)(316002)(66946007)(66556008)(66476007)(478600001)(6666004)(6486002)(5660300002)(8936002)(41300700001)(8676002)(2906002)(86362001)(36756003)(38100700002)(2616005)(6512007)(186003)(6506007)(26005)(83380400001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iYgC9yJq9N/dxrsxg5EzepuDYdnxHA1wyznjvB8bPGt171b4TMVtdIyDyEwB?=
 =?us-ascii?Q?yuJfjYmPqnREQTJLcF/NbT2tJB/OpljSG6F350nEYm4+IiL9t7sbbApW9dTA?=
 =?us-ascii?Q?tUKydE4k0j/g8DAscP6NSNUf9e1fP4TiOk5w5FGoGbBx2AZMF50+welOssWV?=
 =?us-ascii?Q?HGFsZVbljD8OxGHPabIZZH6bgHxTCgOLVY+ZnP6Z99IYvDXJA/HQD3cSpBCA?=
 =?us-ascii?Q?cuWIcOc8b1PtqEh/9NNgJ+p/N+NfvQFvECAmPhXotwtTIvijXMxhwWnvXwkT?=
 =?us-ascii?Q?YNGu1F6SB61Yr4K8GjCiZS40UmBFeIGunitudpxcPD+t/WMNhYzejjSazVH4?=
 =?us-ascii?Q?jPyXnlrh+kKs2CNPjmLYqTwKHlFWQSoV25JYMIWwrTVChp8FfrvYa8UTHZ+k?=
 =?us-ascii?Q?aCoUzIVSFf2oRRtc6Y15QAvt2qygxmw0/m0j9m8LzTEokUp9qMZbVjYUEuP5?=
 =?us-ascii?Q?x2km3ZRONrHaoIleRveLvPDwjJQMaSaOSzIP3oeL5+3ND/GUUoET4dI1kTdS?=
 =?us-ascii?Q?YwtfS7NofTvPZfkn7nKSxnordYbbJ7lkCY5gTbQWvVjKXw1GRTzXqnm0bQHd?=
 =?us-ascii?Q?KgzuEHEsYt4UFQk8Abix7zBHjjU8In9XX/XDqEnejupuXscpZzFGZPKKTB2A?=
 =?us-ascii?Q?lF8QotU7Bho2A7bAJEtEFu0PocvFKMC0l06Idd5FIMejmY2tslJzK6xRkH24?=
 =?us-ascii?Q?pe03U5yZVEB/JLJTmV0A8QRE/dG22u5XUn9y6f7ep25n96IqT6EZFZZLx91x?=
 =?us-ascii?Q?yrVFYCDId6PZvV+vkjuKUQ5e05xM55hMS4ie8cq31NDWnnJWJ2PKzUogOAth?=
 =?us-ascii?Q?C6JYlC9PJ2X5k4j8KCIwEw3ssieRNQkmYeVbYAEk7Q2UIEUcr+zMUbL2JWo1?=
 =?us-ascii?Q?Z+rKLiuGCVudPGtqudGI2MIaBJqnd52j4fozqVhKatqj6NQUvpVXmHACNWVi?=
 =?us-ascii?Q?vL7NAxZHdoSyVdB0w23OLWGvj9WNtBlGe5fsWUOWi7+PAOcsGK6GXrG1bTq+?=
 =?us-ascii?Q?oAO2QfUflKWxPAw56Vce3Htvf4x8DAzQfUabN4R0hc++rPnhbIwlCDlbF1H/?=
 =?us-ascii?Q?VyOSFa9SAO9of4iOcqDPTP6CTj4TBfZj6VSTFw7xsDZgnmiAEJMFe8qDE+0f?=
 =?us-ascii?Q?UnWXY/IATVldNsCf7uqjuhwk6R2yveq7qwH2SVEgJVBxJJpIUouPs2wG1rIA?=
 =?us-ascii?Q?FHjw85rRLkLQu3acxFzo1G7ypSF7ZGSmJy/enmSXFc6xbpJ/i9WBi3N3Eafg?=
 =?us-ascii?Q?kwo+/jXXQASX5YY96GhKY5t/FfH5kd+E7qb+3nSzOcMXXnDkAY9Z23CeLkGP?=
 =?us-ascii?Q?EOsMum8tkLbFKwJPBTHVUWwwCwxJRVSWtpdZl51RYP8HuM3Xw5j3Qdr1jQGp?=
 =?us-ascii?Q?H4O2W6wIcdyJ0sL264AeOGvKXTUgKU8HBWoqeSKRvSFYKzEI+2e+KnSUMyJf?=
 =?us-ascii?Q?2emYWqPs/hbCGSV2rcV4SD0IOseuLPsHoC/pXUcqz/7QHzLMB1p3ZHqwP3UT?=
 =?us-ascii?Q?52ZB7P7ss0gBv9izOz1w5jI3Z9tsfZyAXY92LDC6L6lBw8KDVDHdpZosfQ4s?=
 =?us-ascii?Q?KcnaGp/kKwXnHUpZKPsGpg4MxNkZCYm1+JJnySPI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d03c29ce-0e77-4ad6-da8d-08db41d044fe
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 18:51:37.1127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZEjQICn8uuzfhBYgBQmym7BXs2qvP+u/u5ew4roamxA4rF258Q/LMDaMT/Bfxvu
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

This only needs to be done once per group, not once per device. The once
per device was a way to make the device list work. Since we are abandoning
this we can optimize things a bit.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 6836089e62eea4..c0bea7c1760e67 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -318,10 +318,6 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	if (rc)
 		goto err_unlock;
 
-	rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start);
-	if (rc)
-		goto err_unresv;
-
 	/*
 	 * Only attach to the group once for the first device that is in the
 	 * group. All the other devices will follow this attachment. The user
@@ -330,6 +326,10 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * attachment.
 	 */
 	if (list_empty(&idev->igroup->device_list)) {
+		rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start);
+		if (rc)
+			goto err_unresv;
+
 		rc = iommu_attach_group(hwpt->domain, idev->igroup->group);
 		if (rc)
 			goto err_unresv;
-- 
2.40.0

