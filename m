Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5526E9C07
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 20:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjDTSwX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 14:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjDTSvx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 14:51:53 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3602F35B5;
        Thu, 20 Apr 2023 11:51:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFgP3N9UBgvdKGAdfWvK+igH/3sv+EMSvWneJaiyzQCRTetgp73IPNSSuNLHqB6cokQypofpMCeAopPyaYYUoVtbjSqmw/4lTi5xKLSTy8UIEohDnOhg5d91Idk2AEmPjSYrVD0M9CBlzCY5Kzaj6siTXY15dQdKNfTosjc2lw/OyWLJy/QGDQGFuF2vmqgOpdkV4KTNx5GEW0Zu95Gsj+16svY1VkgXNpAWBY4ilv1Xrag3RugGqKlxzmitD/QKixngulg39+qcs2SwRJf5yjymnYTA06nHC8mCPvEH1aP3bVi/TyZE3BjkuPpr9VmCWd/1f7mufBndZKIOVHcLlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LrdpKynyvC2fkflYtlVdZXliUnXP3yg4qYyvtVteIY=;
 b=TGrBN40+fIZ97unBvQ+c3ZtvwHZwXQ+7GTeSnAA5uEVq3AZYnGwhJI+Yn/Y7D0sKSa9XiqbNjFbHSZ5lOSjne0F9k5FUxAkMvocXLI2nHJBoQjlxiXcSduRQyiPuJ6B9e3P1DQ8oXef8fhewNHKHjPP58JfPgnJeFyTIrC9Ao2uXX68N8GoynZruqUeyFM7HJ8+BL4BRhxMb9CPPpWt88W27l7sp2khaqkFBD2IzY2Q0RuGfTIYTu5Xk9xnVPF/quCazWc+VrpyZglve4wvScxh/XY4p5Krs6nJTNaAduVFHmYSbzgc86Sq7k/PKuPOqeM5kJWQVWnCt8kPcHa42KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LrdpKynyvC2fkflYtlVdZXliUnXP3yg4qYyvtVteIY=;
 b=foLRGjHUfEG7DLAUSt+7piEigep7qnRiSu7Xfgr9xwKfZ0S4URErCpi83mYZPL6lirl8bR8c5WgEfQyOyMhc8q2HURwp3x9wW1rTiqIBKLoVmTy1CmVPiaF8Ogl7FVE+mZ2gSF+9FJSV/ruOgqdhoL9QCB0QWmkUTCQKT6fTk5QyhWN6ODtedHLWK383ZavxmEY+pR7r+OhZT5vEGoN9rSLR7uv5xkFgOdnv7BCvFILZcWfjiV2pPOh/K9jwvMGrNNb3nPX65/xjqFf3YHocdqArB2IduthZXYYyCbAN6tDdVFInvm06ypMc+lOYpRH6OwhYTyj0QWVez7onf6ntBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 18:51:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 18:51:45 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v6 09/19] iommufd: Add enforced_cache_coherency to iommufd_hw_pagetable_alloc()
Date:   Thu, 20 Apr 2023 15:51:24 -0300
Message-Id: <9-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:208:32a::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ac0831-d738-49eb-906b-08db41d0459e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xr1eA1sZpgMQJjt50uF+FRlMapAO7G/cXdL6GeFz+eQH8w8r6TwiaRhPrmHQtel8x6nc58LfmhfVVheWjWazOtQYu0Y7oATxG1poYTxaxOm07AFY5q9aa7EQ8napm5p6YL7hPepvpIJto1eJgsXDUNL8uzb7Ni6Sm1l2ma0pUFLNIyAQvTxlSYqio4wdBZB9GuaRO9r23z2Xw36KbidEhcZjrdh0uW/nUC24kqwKVh04nurTV//rkCg+ff3VREj1X2KBM1bg5U9UqGDM+eCwxUyKM67g5wde8uUmRJd24AgZQUdKWtnVemZ/H1uicFj4e/uSpS6oqTJvLbuvxOHEvTaT7TVGSdhO4BBON5U3JU89mHiaRsyzrb+QCIQCJ9HHpBOlkfweLR+HV6OfQDyowkGVIh5zPmTmj99Bnzvcfz+e0e3cCOQvziq6vxlBKdyPcWbv1YXmbVK/FJbCygQmFs/aTg8HplvBbGyExjq7XFSHU0I375s7cXxpE9LXt9zUJhI9/e7FxuAdAY1+FqnMsLetBUsW5AV7UJGTw4Zr5Q4ZPKPUJfbFpS2mD3MgMJUnWiZ8q3o2cotATxKUhS5SXhL1Bk7l4PoguU7US/D5hFo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(54906003)(4326008)(316002)(66946007)(66556008)(66476007)(478600001)(6666004)(6486002)(5660300002)(8936002)(41300700001)(8676002)(2906002)(86362001)(36756003)(38100700002)(2616005)(6512007)(186003)(6506007)(26005)(83380400001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ulUdkm1QcbOq0Bz2yNnqoE3YZ/K04uodB86Wg1GlNQmXEQ/lUBd+DGUmEll?=
 =?us-ascii?Q?G1IvqO/1z9UI9rp8K5h+HzVxzy/4S+EOlzMDRRftmnLp5IggWTVKKMvIbkLi?=
 =?us-ascii?Q?9KBh7IyzFO755h31uiM7yCacslWTPlMuCgDTCOT51f1MSkRbbV6fH72yukUA?=
 =?us-ascii?Q?0ZUbWlMp5SCkU4V6G9+2TerTSr4sjYVs8NEE3iD4iP8y4oHeZtB4J/ukrmIh?=
 =?us-ascii?Q?WKBQ1JvF5hKPnCP1X6/IPvrUJBKN3uwa7hr5r2F3gZExIXOTyIsyUDhrkbhw?=
 =?us-ascii?Q?YgQyqxvCGvz2o3dXu5CW+N4iLlIhkH5xX7vtML6oMk8qB9mpAi0mm6aPh/ad?=
 =?us-ascii?Q?DSZNORTt7ej/aLTRTHeJWHNo/YsxYLZYPUSJxrBY96B5YMLsiU12Cu7b0XuP?=
 =?us-ascii?Q?ttVf3aDabzrzX1gQ0WjBP2Fe1n+Azo8tSirUtrdoiP1Wdg30C0XDvjN1qnxD?=
 =?us-ascii?Q?/pD0DkwxRcjq1RnDC2e5PebwYeXCcniR2FqHlRW6B6elPcHVFV6NUPgqlbhw?=
 =?us-ascii?Q?FmbZzNQzlcxyo/fhp/j8J3ZtbqkGqt5EeLfswvXg6Bt+ygofkwDPnyhkYEIv?=
 =?us-ascii?Q?6UUIoekvlF8PADUb1Zytb59oomtn9aTvVaRX7+FtY4lbwNu0HOjP3iQNKdF7?=
 =?us-ascii?Q?hSfh5tRGQhoyHcjFCoJufMtjUqWUGfLmKZ303PxYOeHgRkC91bB5GICMcJ8i?=
 =?us-ascii?Q?DjArieeOuleogSfnXkIEoEZL8O0t7gemr+YRrFKg9DRezmI5MbCP9SlowS0l?=
 =?us-ascii?Q?uyBggEs7T0jw1yDKri7tQtY6S7qRnoLhd7GPOKRPbKAKITD7Ou516KTnU+gr?=
 =?us-ascii?Q?KF4mqO8zVeasYU5GGbOwxCPtGnrp59Ookn17BYI1KYgX2GjWt4iezLyszZle?=
 =?us-ascii?Q?c/CDpwzzi8yyXQaLDNSvC2KvipYRYfK2urXpEkxVzkj6u47KSmjN3CwFPh/0?=
 =?us-ascii?Q?jFZhOTpkLRfW5s51QSuLZFhUkGA0fMLbBxdINaQkLivCMFOTcyvCm/FPSnZ9?=
 =?us-ascii?Q?byINkIrqAOYbaBM/XwxCHW9aYQjOhp0P6mMu4z50xbNA0lpgKPQfPeI0wif3?=
 =?us-ascii?Q?bNVt0D8WkVy1RGDN9Xhhbw1NtI/RFuuVTPyew4YLkvxtISwHlgR4tFwE5ipc?=
 =?us-ascii?Q?rlAZTQXF9b2Fl9RJpqFkWDCcwIiDMY1dPgXxHwPLlT3TUJn+Lxf63gx3Ui9O?=
 =?us-ascii?Q?nwbtSZgOAzWrfSI1VIt54TE7B7Zn0s9+dOqTaPplfpuMdeCHNOEi7MM1rhzZ?=
 =?us-ascii?Q?A9VTugHZhrfA4vxHo5x9PeXugGehUa1UCZgEDIApC/AO1AfuT+Umx7eciz2E?=
 =?us-ascii?Q?HiXkf2aVCe8BQnIv7EjRAHfd24nNYra8QjygWMkoZvnKM5v26X7QYbbKGTRY?=
 =?us-ascii?Q?JPx9TL8fncS86XX44T02MRIfVbYMFpNz+upSEOGZyqFKccmG8d27js4yCuvD?=
 =?us-ascii?Q?RftRMejlSNQD0ZqFtL3z8HX8VxbeaX7zr1bQBqPFAHlSRmhgibhWHGpNV3Zc?=
 =?us-ascii?Q?Nw6kIgjG1Jn+mGFNAdKrw0cputFsYGrefBIFx5ajJc2Z/ZRqVcmIj2X7CPrh?=
 =?us-ascii?Q?S5o5QKK9sUMzM960qi9Fe5Xr48rqjJefA5i7HrSH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ac0831-d738-49eb-906b-08db41d0459e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 18:51:38.1663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQb241LLnLDUc1IG7oDO3V0GA8tYLRHzDJGiG609XbxpACVaEmEXLaOvPdlQNd0S
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

Logically the HWPT should have the coherency set properly for the device
that it is being created for when it is created.

This was happening implicitly if the immediate_attach was set because
iommufd_hw_pagetable_attach() does it as the first thing.

Do it unconditionally so !immediate_attach works properly.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 19 ++++-------------
 drivers/iommu/iommufd/hw_pagetable.c    | 27 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index ca9776432c56e8..782b4fd76f31eb 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -295,22 +295,11 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		goto err_unlock;
 	}
 
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
-			rc = -EINVAL;
+	/* Try to upgrade the domain we have */
+	if (idev->enforce_cache_coherency) {
+		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
+		if (rc)
 			goto err_unlock;
-		}
 	}
 
 	rc = iopt_table_enforce_dev_resv_regions(&hwpt->ioas->iopt, idev->dev,
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index bdb76cdb1dc347..e0699d7f4c64af 100644
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
 	/*
 	 * immediate_attach exists only to accommodate iommu drivers that cannot
 	 * directly allocate a domain. These drivers do not finish creating the
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

