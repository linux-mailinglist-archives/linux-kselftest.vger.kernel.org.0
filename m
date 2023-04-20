Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A0A6E9C19
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 20:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjDTSw5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 14:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjDTSwm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 14:52:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D3244BA;
        Thu, 20 Apr 2023 11:52:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQa9c+OY1jJHMf3qRpoUkegQAJuUhkHNqrBI0pFyudkcQUcli12DyW9Yr717riwsKnmK46fAhJQuwokZfRUW28qxWah3DlbePPkaBZ7bwDBXe9w+clF5aZT/Fo+AbcVuemWfStyE4iLbQZf+d8Noacy4MPCJlMDcMvY5mRKRR9Pht49IN8CfMkuduaY6cUe/gR3Y1kZOmo6X5JbVtS+/cVcFIafnv6JickDvH3rAE+4kGdTcvdYYxtqrNar/eFMvdCHMKDLiGwlYx9v9iJ3wUgFTaLuWuU5cphGTIkKy6KzKxtuNUfjNk2F+qjDhlkKIyQmR5iJPo9DpyYmgh5HngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3blGAHefJ4aP70tNrJtt6rGHVG5EmtnNNBaQcgWD0rI=;
 b=HftrH7S+VAVOKLIlNQUSU3CyFP8OTnydiJHBxPGzP3SqMYNcupC7yeabLQWa8P4nJNox+2xPjOrCktItRwuqrdMZY6nTiAR4KxPaf/R3n1rSeQWmdzjGZ18K8IMJ81w0XYg56vTeGhM0BDIfKgzp7ijPIhtLYZtr6jbHmKppAeOIgMAwLOoKPkGtuBM+gtaxcfV9gtMWeq/Zw6+claJIEuPqw5zBNHt7hrC3t1R5DRci1TUEjo1ysGowdO7poA32uqRXVnYONJ2J7X9wxvyMSoQMDiO4XhmfSrJMwRehSjfPmzDNMRtCtvTKwokxW7nH+OLGn+YR2sozVXM4yoZNbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3blGAHefJ4aP70tNrJtt6rGHVG5EmtnNNBaQcgWD0rI=;
 b=BAY3YUFVT33oOZ47Bn49fiHEdhUWf5BNG/P1k0+ihKtPBEk5FxfF41LF6iBgyRsNtW/oos/Ex7daXxUfJmmqdggEa3jEEMbFjZZBQ1F1PS0F+cSzWK1F68by0Wt+alZJBmbi4FsSIxB5aGo7VRM1q8cLdCR0lvX3+BznJkNnvMyzzmQBc4b9rW1ENsbae/NNzPap96bhh13CxNX+KduV6dFLz1OXO9fpadY75BA7yCyEPb9KuFOYhWWiTrjM50/+iv065Aa3K5TIQUj2DplrynbsUO/mJardhXkYRNwD2RHXbFljVPvlyg9oIfaW6c1hDqChzZXuGBsNfN8ELwdkXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 18:51:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 18:51:50 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v6 01/19] iommufd: Move isolated msi enforcement to iommufd_device_bind()
Date:   Thu, 20 Apr 2023 15:51:16 -0300
Message-Id: <1-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:208:2d::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be85793-1341-4cdb-90f0-08db41d04738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8znuAU2rc5bnucutZqWqoEvHStBSWRmEb5KDLypr0rsjVwHSJoekGUqtv3SVbqEK1S/kv/Eoq2E3RLypdJ8cs3egi3fcJtfeofHN28OuLZ8dv8yqlG51HEqXWYWL33udbTCHrp1Tk683qYAjlDKWu/ktWo+nkt3rZ6OmboQ7sXEsX2b/iGNuJ74mWwTowqvulUJ/zQv8IXhfkrgRpOXMZjvCytcJET3vH968JVUvhqnjlHSSOBcs0859LAetEBuUzh9NhsLtXkstNw/6rdmFyOP21Wx7AkUhd+FlsOZ1FvfsgQKXcSM5rKjfzrHsLcki0i4RKiQtzikrEISKJkMwte+m5px8pl5sdDCQKmvXPJjayESpUW1a1+F2lTCvBeyLVAuogpNfMhg9OKDLQLwwCy9hPtk2a/FhYwC1RTp+RZDpVCgbUdQYNFnMejPWwLZY597yZ5tFcjJOpA9fYL1y8mEN7zZpHjm2m3s7KtXjvQAHywU/+XE7aRix1qvuHXInaNAVJv2pCoWWzQ9wuHgo+RO0DHRoVu/JPWn+keSKN527VvxI9l1BC5WYhIvnOh2xR2dYf4bmkkL2ULbE5qw3UH8FsiyJtKB4bYeRezFntVI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(54906003)(4326008)(316002)(66946007)(66556008)(66476007)(478600001)(6666004)(6486002)(5660300002)(8936002)(41300700001)(8676002)(2906002)(86362001)(36756003)(38100700002)(2616005)(6512007)(186003)(6506007)(26005)(83380400001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f6SyglhUzw/YpbAEJKQgALHl+Xls1XI3RuPCgAw1bXFqUQ5lnx6PkTidQXo9?=
 =?us-ascii?Q?U4YYsbzBfFaL6vayNm4UIz0TLjRhsdeH8NnJOcf/ikLbfb/aU/apa/oNve+M?=
 =?us-ascii?Q?2k2uy9S0SGIxtR9Gh0xF44p77j04Wp4JB7bZE4nYSuQS17qMXbqT/+IOUVls?=
 =?us-ascii?Q?dXQf23+IkIZ4ljJQEXuHsQ5wWzDR5+3794W+rbUx5AZeh0O1918n1TDiUjuh?=
 =?us-ascii?Q?2+SDOPAQy3fTvPIhRzyC20muQ0S+6fLaygIHbdMXp6PCJ/yOBTXW76uXsSfL?=
 =?us-ascii?Q?wVjlzd+vd1Uq2B42O3nwLD3Gu+t1WMuAOpjEEq3w89YBJcgiiOvGyRdDqv/q?=
 =?us-ascii?Q?LCSxfoYITsVTMzEPcFPHTn+EEA5gEoy3NrptO8BY/RGbohYN04iHs2RH97Cj?=
 =?us-ascii?Q?lk/y23ouygt54lBQDEfesCc4Y+HQTwtTR0hQGEauPGg/7aN4IfywMKANk4lv?=
 =?us-ascii?Q?5aIK5j3r+z8woanNHHJzd57D2lGmCaZhN12ZgxavOyhu13nnqchitdLH+qtk?=
 =?us-ascii?Q?vpeSYipBz3ZnAtMBHDSyLeDJwZlucEDtj2bmiiCKsgXVRI1BI1TJzk2KyCzy?=
 =?us-ascii?Q?bYmr/OUesCZubs0ET//nIBFVjkSzxcFQHIasYEpGmB/coudRDKcZpuI2z9uG?=
 =?us-ascii?Q?j11FQh7YJSu7rNwiCVdiHfRYWht1RVwsfe+BlDVh0o75R6h4gY1vQeMeHJUE?=
 =?us-ascii?Q?YFDkiBFLVBYxKqIRnWhMuPFQHFSgH/R0TeEe8H9EsYc/wtmqJMuIe/5x/XcE?=
 =?us-ascii?Q?OGzfFliecHEs43J9T4O4ldlzkhAckBTb5fCLU0SRTK7keaNlhkA7kLcOPWg4?=
 =?us-ascii?Q?9oX7vHbgxqkv1E5q8RfRULqv/mPdNHnq5LMF2k0LSdIsjL1VwzqC4jK6OZSI?=
 =?us-ascii?Q?bPuk9pEd8U5AeCQV6tWwAG6541gIGnVUILJomQFZdIYCYF3B+nxPoqB1n/tE?=
 =?us-ascii?Q?waHhcGVRmgNP+14KGYVlNB5fHxBpZ/3wJU9r76N4EF44WC+WYzo/ffPAlGjQ?=
 =?us-ascii?Q?BdSKSFNrYAZjhUvGO02AmRfa75C5hBQMPLVW6tGuq9MSac8ODtfpUhufqsZe?=
 =?us-ascii?Q?ry4iqwrGPLRpHcxpTLMrJW3NCoyxqccOWYSis1iRdNLrQuAeAH/CIwMxdRhW?=
 =?us-ascii?Q?/vRZNjpW6AvQoy2jsFVTg9mrEEsL0i8fLo4jVICE+4vevKhOPpNRCRVv37TP?=
 =?us-ascii?Q?2xpfhEVL+76CBRdlofR+FXWiDd+5nUMk21qpDIwPafVcjUKztWqolX22cXHn?=
 =?us-ascii?Q?U4urnnEqyObVAoBKDvvB81go1n/7Jrh2B0tzid+CPplPbw6Sc3bBQLiULYJW?=
 =?us-ascii?Q?aZjmUVOH9Z6lVBLz3zJJFMhoQtl/2CEmgLYU3Mu3WLEkbgGMSDYITkUSU8xs?=
 =?us-ascii?Q?q2pdfKkOj34tJC8WnHZsw/1ZrqaYG32GqsyE6Q27ZMkAwhvaF9404FVqLh1k?=
 =?us-ascii?Q?DE8UOdi51ZTdQ59fgptzk9cV1yrvXWRnNGR14IVR+d4SBMzGMxaBBHFFLokj?=
 =?us-ascii?Q?/vCRUOtM4iJwwu1Tho1ygAGzhTGX2diUnxzm6Pe7Xz4NXnTp4oN42yCGHckF?=
 =?us-ascii?Q?t3CUITcz79/ZA6zJRSrlg0BRJ+UOyzoQso8/X35g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be85793-1341-4cdb-90f0-08db41d04738
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 18:51:41.4215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vivszOU8MAxWsM/17eN2qB+HOGDMujFh111hLLakT/gngLE+EcUmnISdHEyMH9Tq
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

With the recent rework this no longer needs to be done at domain
attachment time, we know if the device is usable by iommufd when we bind
it.

The value of msi_device_has_isolated_msi() is not allowed to change while
a driver is bound.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 38 ++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index c6f4852a8a0c08..e66303c17c894c 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -60,6 +60,26 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	if (!group)
 		return ERR_PTR(-ENODEV);
 
+	/*
+	 * For historical compat with VFIO the insecure interrupt path is
+	 * allowed if the module parameter is set. Secure/Isolated means that a
+	 * MemWr operation from the device (eg a simple DMA) cannot trigger an
+	 * interrupt outside this iommufd context.
+	 */
+	if (!iommufd_selftest_is_mock_dev(dev) &&
+	    !iommu_group_has_isolated_msi(group)) {
+		if (!allow_unsafe_interrupts) {
+			rc = -EPERM;
+			goto out_group_put;
+		}
+
+		dev_warn(
+			dev,
+			"MSI interrupts are not secure, they cannot be isolated by the platform. "
+			"Check that platform features like interrupt remapping are enabled. "
+			"Use the \"allow_unsafe_interrupts\" module parameter to override\n");
+	}
+
 	rc = iommu_device_claim_dma_owner(dev, ictx);
 	if (rc)
 		goto out_group_put;
@@ -146,24 +166,6 @@ static int iommufd_device_setup_msi(struct iommufd_device *idev,
 		 */
 		hwpt->msi_cookie = true;
 	}
-
-	/*
-	 * For historical compat with VFIO the insecure interrupt path is
-	 * allowed if the module parameter is set. Insecure means that a MemWr
-	 * operation from the device (eg a simple DMA) cannot trigger an
-	 * interrupt outside this iommufd context.
-	 */
-	if (!iommufd_selftest_is_mock_dev(idev->dev) &&
-	    !iommu_group_has_isolated_msi(idev->group)) {
-		if (!allow_unsafe_interrupts)
-			return -EPERM;
-
-		dev_warn(
-			idev->dev,
-			"MSI interrupts are not secure, they cannot be isolated by the platform. "
-			"Check that platform features like interrupt remapping are enabled. "
-			"Use the \"allow_unsafe_interrupts\" module parameter to override\n");
-	}
 	return 0;
 }
 
-- 
2.40.0

