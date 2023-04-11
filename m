Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CA56DE14F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 18:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjDKQoc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 12:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjDKQo1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 12:44:27 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7238159CA;
        Tue, 11 Apr 2023 09:44:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ecoat5a7SogbwScP/aWowjCs6j3TtGfVRxUX9VH5o95JRfvCPrbxMhSjrsu3Ol6o89ENL1kexCuPuDwNdUbneoaosnH3O3xxB29lPXpNDyyv9ZYxk91/SICzPWHme1Yc3d7QgeOj7gUFxV+1Y7ZwtTfkNYJ0kyXWquEPgTGwwfqykSlStSoiPk/eG0jgrcMY8ELrIM4KyeRZ4HjIG/5ZgkyMj9KwySR7FZNW427YELDDgzERBFFCEUrAgMz5Lm6VKrduj9n0n/OZ5szTRranhULoMGBvf3583ONK6ol9e7LudX5Xz+EOUlSwqhuHEhn4N2xCQtQ+rYUFh0kgSDyH5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/Ec/lkq3YkLGz7aon4IaNs52pGelXfT9OgoLQGpR9Y=;
 b=ZwmKXMRY4Bpw9x+uwopRk8LbrM9PXdPTXubF5aJxatRhuHS8mb92ROycM3b4fHp/l5CUbUXNNBJ1rKptvLVKcWTAtsK6KaGMevNhbyytkyFX0g3vjZsHG5jSr/ltZ0eHArulCIRgDruT7GJ2dKIQNPSjRf4ehue2oaSnSxvuOGhp68f3c/7EUg18LwVg44p7J51dFQYh+LUge7TxXEhRrvObT9crYQvGfWAYXJ8rprU+bkxDlIyDSBgJ5Bnvoxk14dRZi4EvSUoL++j/rtmnnkTuZ63vHDZfWbntm88FK1PNkj47Cr+uzXVCiKPnrGx4UaKR8Raa5qUTC6TmPpnDhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/Ec/lkq3YkLGz7aon4IaNs52pGelXfT9OgoLQGpR9Y=;
 b=LJiD5W7FEWWyClaOZpUQLUeffu16+6AKCkUB1yrnRMpXXFfl9SmVWG8gPdt59N4qEaMYgotRifmBb4XqGQ2Wvh4eaxmFiZaVHa8JQilMW6kcyqQJgOHUxyhK0Aetv7LCNavGLQVSJS0/CB8K36Vnm/ow8lFHqCreeOxxLo7TpiHb7R65FUz26kfTAM+bRCodZZPz9TNiifuSQXg5Trugfiu9s1EP5RrNMcUXH8XpwnaniYvFlgyUECsLEyjNTns13qg3skIOdsUPwaSq22gCZvjFYqAg9CyNLT0Dt/Cn/SfASUCpr3B5GWUKm+Py33hLcjLTeXEu0HcZVCNfsHpz2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 16:43:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 16:43:25 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v5 09/17] iommufd: Add enforced_cache_coherency to iommufd_hw_pagetable_alloc()
Date:   Tue, 11 Apr 2023 13:43:10 -0300
Message-Id: <9-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0070.namprd07.prod.outlook.com
 (2603:10b6:a03:60::47) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: 37194508-d5b2-4ad1-540e-08db3aabde57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qHjtc7LUiBby8np6lq/XiP9tFPfNa+IPXM3Fwy0sZO5UUaQQSBYW3RfsYZLc+AXQgcLi9g1wqBtvYBvArP346XqRIb14odgWJpYk2UnZEJ36+P/8k9b1hEumOF5UEXfCkAPw7bxacXeO2fLsF4OYovhVqg6So1og4X1Gy0J6XRsR9XBAjd+iNKF4fiaIVs4KWhTK+Y5E3dM4siGIlmbS0BunOyahG4aUCXHQiSSwFQb4eK8U7tZLc9oqiEx3FltRTKDPLxbBe4hIqT2nbDPxhghs+oi/j+q2leTDTxn+jn7/2+KuDBhvX4McIczHQbcwU83dQh6vzo9aw0jY9DJnBKoWNw72gzm15z/fXxeLWE5KAVwA919zhdLjrexqTNV9nMGp9NaIg7ziDaTxBkRVabn1Y9YgoRJj+lElla/XwNfDeH05RYzz4FlT/wzZcOZK1albvNVD9nodvzqanS9GhAo7qfg4WAmx+WFdE4YM53I8Y28mG3JFDX3rwRFtpxp2USaNHzLW7VEjiNb/RAHE3qVmI9vbOv6Bm44j9sPypIJU9zPrix10nbHLCRJBI1gg9J+nKu7i+IGZqX49b/OwS9l2d67dVaiXRBwelW46C2A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(2906002)(86362001)(36756003)(6486002)(6666004)(2616005)(83380400001)(186003)(6506007)(26005)(6512007)(478600001)(66556008)(66476007)(66946007)(4326008)(316002)(8936002)(41300700001)(38100700002)(8676002)(5660300002)(54906003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+EEkImLw+dOVo4mLp173emcjXBAwu3+/ebjPNaFYxErB/KQXOMOOb+9l/0hl?=
 =?us-ascii?Q?TChD9nWGizHKIUH/Vm3TftGjRNmjWrp5na/FEZsL23TcTiMbR3iFEKprj2We?=
 =?us-ascii?Q?GrdL86fkC0ztmDKxTkaQM+aDgqoE0Wr9bKCTekBahdCl3tdba1aAtsnmtGec?=
 =?us-ascii?Q?0Z9EVxysHwEOPJWprGGMmh4iX5QpURYHFm6BOCvRgZ88bo5AJHj1F81+6jmw?=
 =?us-ascii?Q?MuXAvgrgRfWenAYWSYgL98LKO9fRc6pGNZhCw2mM7yfhmVFs0K+GZbp7Q7+o?=
 =?us-ascii?Q?YDWM7z9Ce2lVYnWul0SJPurFk7SzGH/twLvtOGaPHAO+Peh19INBK3qb1W0M?=
 =?us-ascii?Q?+FJk1p5b5G41GDIi2LD9OWTLv9KC4jA0azjUDi2DwNP3rAqD74DKUfTHUYo+?=
 =?us-ascii?Q?9ezONiBz8FvnNeA3i17wS+4ntYJgO0D90kcyM9GKgoDYc2zT/DTiag5fR5Nc?=
 =?us-ascii?Q?2Sm5gsFSd/N7A1moVzHYPVeNQKCgc4UODUXQaL7BhfgUfhgkncjjzAbcZjOW?=
 =?us-ascii?Q?h1Y7smR9Ssyh2GtwAWjU+C2b5+IWKGde0bhy/4QMwGfrr6esAJ2K5v6ujBZ+?=
 =?us-ascii?Q?FpbPzukNKSevvLVIVxVE32NBpA5IXgIBntP2Lu6DHfunmcFvV+Xsy7lgCRv7?=
 =?us-ascii?Q?u2WryRz/7U4JS1XE3yCuXqvaIkbxxe+uEbhSWtGqQ4tVKSSj2Fpph8Nazw5N?=
 =?us-ascii?Q?1aO6j7UdTKQsk3YAwxurxbGdreUZTjw5gLf439mnkzz4K3sUOWs2KzbAWTun?=
 =?us-ascii?Q?g83ljvzMBMNhznTKSpvq+P1Kr2noDfY6eme6OB8BfKe+fLF04gKdTQ6oWTOW?=
 =?us-ascii?Q?Y/jbn7FTcJliMI45Fvs0FIjyfiCezBkCUOd75gvdxj9mPIS9emM/GwOHwQX3?=
 =?us-ascii?Q?+XLLHyzg/+f4R2jT3/OxvKGA+lrqX2uN7D7Q/qTuEki2F3cTrTf7ObUXjsG2?=
 =?us-ascii?Q?YfYSLx+gt/CUQb1sK/Sgu0Ie2CmXuzAIYs1JX9P1R8oebIxgmCPEj9TvgY9m?=
 =?us-ascii?Q?B5ZVGMHuEqi9OVhRgazcROc6bcM1Z19dCAG1q6mQMdxQjPF0Qk9KwrNXkFgh?=
 =?us-ascii?Q?QaSd2nByE/HC4DTYnZh/66mOIt3ao4+oKp9VUvMFVIrAgVVkXKFGJY65YbLn?=
 =?us-ascii?Q?nvhqDdT95MTtojZ1p+duVMcoyofI89sN7zBTXM2Z/4nFRn4Vdx600gXUZPaY?=
 =?us-ascii?Q?iLm8ClUKDf71SOGG9QFDy2xXrqTgM07/hbzO5bF3ms9FLyikMZn+EcWSNkDM?=
 =?us-ascii?Q?DS+7MCFqI7YD4mGOD5tN/hlw5lEvnGk2IHGt3zXjnRpAmt/GmME58dNfvPfA?=
 =?us-ascii?Q?YmxlD9NUfENh7/aEXPEtULc7V438/cA7f2bA2r5T6lK0rV06/e8BjnDQpMdj?=
 =?us-ascii?Q?inUE1s2dfqay5spF+tR+6hJWWA2FqgAZZwK/RpA/cjBNnNATOcUxrxx5IjGC?=
 =?us-ascii?Q?5HzrCxCld9KYhTGQL3X71mDU3s8ru5qltRDdJtkNmc4UzE743Bc/V72kO3sc?=
 =?us-ascii?Q?Js5wwX37W+IXG5EW0MlX58if6CbKQcx8npJqmpsth2fmYDmwb0x8zVof6Ikt?=
 =?us-ascii?Q?LF/oI2NfjFFGm23nrXhZr40y8pWOzQBdeLD3nhyI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37194508-d5b2-4ad1-540e-08db3aabde57
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 16:43:24.9079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdKbNsL2xr3lfCKxFwXA3oxY6E8JLkhKFj9CTK3+mzeyEJlmD3jbN/mJyaOoQeqT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Logically the HWPT should have the coherency set properly for the device
that it is being created for when it is created.

This was happening implicitly if the immediate_attach was set because
iommufd_hw_pagetable_attach() does it as the first thing.

Do it unconditionally so !immediate_attach works properly.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 20 +++++-------------
 drivers/iommu/iommufd/hw_pagetable.c    | 27 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 3 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 2ef20fcddbdd62..8f72a528325f04 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -293,21 +293,11 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	if (idev->igroup->hwpt != NULL && idev->igroup->hwpt != hwpt)
 		return -EINVAL;
 
-	/*
-	 * Try to upgrade the domain we have, it is an iommu driver bug to
-	 * report IOMMU_CAP_ENFORCE_CACHE_COHERENCY but fail
-	 * enforce_cache_coherency when there are no devices attached to the
-	 * domain.
-	 */
-	if (idev->enforce_cache_coherency && !hwpt->enforce_cache_coherency) {
-		if (hwpt->domain->ops->enforce_cache_coherency)
-			hwpt->enforce_cache_coherency =
-				hwpt->domain->ops->enforce_cache_coherency(
-					hwpt->domain);
-		if (!hwpt->enforce_cache_coherency) {
-			WARN_ON(list_empty(&idev->igroup->device_list));
-			return -EINVAL;
-		}
+	/* Try to upgrade the domain we have */
+	if (idev->enforce_cache_coherency) {
+		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
+		if (rc)
+			return rc;
 	}
 
 	rc = iopt_table_enforce_dev_resv_regions(&hwpt->ioas->iopt, idev->dev,
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 566eba0cd9b917..2584f9038b29a2 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -25,6 +25,20 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 	refcount_dec(&hwpt->ioas->obj.users);
 }
 
+int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
+{
+	if (hwpt->enforce_cache_coherency)
+		return 0;
+
+	if (hwpt->domain->ops->enforce_cache_coherency)
+		hwpt->enforce_cache_coherency =
+			hwpt->domain->ops->enforce_cache_coherency(
+				hwpt->domain);
+	if (!hwpt->enforce_cache_coherency)
+		return -EINVAL;
+	return 0;
+}
+
 /**
  * iommufd_hw_pagetable_alloc() - Get an iommu_domain for a device
  * @ictx: iommufd context
@@ -60,6 +74,19 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 		goto out_abort;
 	}
 
+	/*
+	 * Set the coherency mode before we do iopt_table_add_domain() as some
+	 * iommus have a per-PTE bit that controls it and need to decide before
+	 * doing any maps. It is an iommu driver bug to report
+	 * IOMMU_CAP_ENFORCE_CACHE_COHERENCY but fail enforce_cache_coherency on
+	 * a new domain.
+	 */
+	if (idev->enforce_cache_coherency) {
+		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
+		if (WARN_ON(rc))
+			goto out_abort;
+	}
+
 	mutex_lock(&idev->igroup->lock);
 
 	/*
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 8bf053f4d4a9ce..471a3fdff1e0b6 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -254,6 +254,7 @@ struct iommufd_hw_pagetable {
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			   struct iommufd_device *idev, bool immediate_attach);
+int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt);
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev);
 struct iommufd_hw_pagetable *
-- 
2.40.0

