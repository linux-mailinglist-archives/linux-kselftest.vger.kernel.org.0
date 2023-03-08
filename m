Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DBE6AFB38
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 01:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjCHAgO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 19:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjCHAgH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 19:36:07 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D4D9E318;
        Tue,  7 Mar 2023 16:36:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imcsO8yXRpRlYqs7lIvokjubogR3DOWAXAGIVXtngG+g7z1D9H20Ua//YEnBIwdROb3Yl92Cr2wrn4ykWZkIbFlCfeTFygx/zsxX0h4lYBb+DrUvJPnuvtwwTr5rWXqlhnloYyDZkQvYAtsyFX4iLIXW++1ScDjwkT1hkWtimY1Fk1ahYQknB+y7i+DAAkCvqu6yWVpCl6Mg5Mtb34PdJonBWVWEogi709lPmgKMd9J0W0clISnnrs6w80WcTdTvm88ozH2aXjbPq74NDrsqSh8dotE8YpkBh66G5Qee9lHWi1fvYXGHYLcU8GXdnq8A/6eigL/z1ePhM3KJUgrpeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmHNNba0KPlAptRRIeLUOw4J3NHbvj/B35ZYFxCwzVE=;
 b=N+fPzlZUmkah8oeCqs9woj9C1mTa2J4wEXRlDpB/RWaSsAi/2cYJQ33j6/qryKKSP+qNEdTLwPYv2U+DhIsMPfSi8suO5yHZfqQOHRfhQYx3IiCMyawXqC1GuCyBj3Riw+dmjKgOiBVl3OAMrNX08IdTXcahNJ/Cb7DAatNe4kedPj/8okcSfZaU3Ld7bAbr98xg2ksd7S3ju5K7BEydz0Nk4h40/gzNWfOQ1o7+bUVX3FLP49NcXMU4nFAU91IL9FuaDRKwqbxuAHh0NNe2YhmoUDclCxw6YvXFwvU2ySuo3duQ+hYRycgYCpjPCSFpr0XQOiLsNpE4eZt/9sVCMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmHNNba0KPlAptRRIeLUOw4J3NHbvj/B35ZYFxCwzVE=;
 b=PmyiiLGfP3AbwiDYgievMb7oFch5R1eSNORp7hBTGFaVB2lXxo9sTq0jtSYMpuX0bEMynhpn8lmftfI3u+mnlezm1ExwbE9u5vzM5665dLUmHfUl686o8sWwsJkj01bN8kl46Bw0BRm0e9VDQZCq5s1lEGYGHDYgXQcijpr+Y4ePJrXBq2YdmAz78FEPcs6ho7E7V4hT5sKd9ajg97xrd8299IwUthuqoyj89XOf8xZFFr8CH6dsLAgSUPfS1aI2J9ZnNuOidIClZytJ1ILPv23RHcVGu0mxS8/tnxKelOR+sKreDUkQ4OyH3AXPkLULASszq5aMGmaVCa1a6HsbZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 00:35:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 00:35:59 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 07/17] iommufd: Make sw_msi_start a group global
Date:   Tue,  7 Mar 2023 20:35:46 -0400
Message-Id: <7-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0308.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 96291453-4006-4a5f-ed6a-08db1f6d15c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ek5/lJ3Wk27GXBvjyYZLBfW2zWGA7o0jbR34NCuJuRDAObKbaF88DptnvqTjH6IoHJuFUtv+UkGOutQB8EwXMbVnC4GHVeXItQ5TZKzOhEKn/oW9zrkzYcGrTRE+mCZAjJvH/rUp3dEZ6uYPpKTcVF0d6vbPkgZ+tJytMvFsTLhpgIrNIgWX5pHnFn5o3HQFQEVa4MtU4yPHI9Ov3MDiFkC//eD+yVkhx0uXBX7rSeBIpqUroc15tc+7tGhKKTWH+dztbRrF57rz4lf1MCgiTxjQH41FjvhjNJVT5IMkBVqLgcBzgu8Vduy0BcMHW8gZJZfAJLevip7tdhkRKLzgwtTnb1ZC+e+DORVc6J26M9q07lrJ04DbMPiR2x58aNtS/BEAP4+OrhAt6LthhyseJnWIFzHXDoogGvaz11EmI6tAFB4t+A6SRjjdr6lp0amOsGD0niWa65ZJ6IU2yb8QtU6jXD1D3LFiagthUgFz/+LS/78aOGGktWpCyIcjCqfzTAw0cK3EBjUa5v12gQ17CH7neMAvYd5dLeoLxLaH2GuZQfAjYBRbEVDiw8mhA/e4M+jDM2cZN/rx15QWZmEO5w7csfDOYb9GI8wtWvN9CYkwafv6qdrwmNiJxLqMuizmQpVjK3+9qEjFSX5d1uhlXZt8K8nNnhUm+JQ/iWxR6qaODDA6n2vLXyTovUzTf+Ss
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199018)(36756003)(41300700001)(66556008)(4326008)(8936002)(8676002)(2906002)(5660300002)(66946007)(86362001)(66476007)(38100700002)(6666004)(478600001)(54906003)(6486002)(316002)(6512007)(83380400001)(6506007)(2616005)(186003)(26005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eH/MIN9m2G7eCm4Z1zQdBlEWpxItcf450HaGuNyRjYvrs3ZBN5GQiqyNL2Ru?=
 =?us-ascii?Q?lq60BxLXrpblr9ZEfKjypKq08h+evpk0NwzRRyD5jl9dIyTDT5jFkz/oT78X?=
 =?us-ascii?Q?fFPxpRpDQa9gmUixIZft20Rbu5OI3EujPNZPcuyUSa3IGHFiKiZgs21aWpTx?=
 =?us-ascii?Q?OLr/UkJ+Ei15SEKty6ouSn21w/NWOrqve5q+sFdw9yNVemcP6YH3LrTa+JNu?=
 =?us-ascii?Q?73zPu7S8t1UM9ekN8wySIxiVEJg37/DKkSGKgFKgWyLNFyBJtIcdMfGXveQL?=
 =?us-ascii?Q?qMvcJvGkggFE0hqZW8MfXHSnMutJdnEP5wS5Be9daz8liPqsVriAk2cGpLSZ?=
 =?us-ascii?Q?MmuRjd3+oPLWaAdlWF1RE0Nq5HuPxIXhRZTA9Y/x1GhSivB2qc22TgjG6DTV?=
 =?us-ascii?Q?6hxCv/Z9c+3sFct9m9qAiu6qj8UwGvGgKbty+RIQ68Lgg/q1Ets31QgxPFCq?=
 =?us-ascii?Q?Mhar+Ko/1dfFYMoFjlSV7LIEeU3XZjnl+pJKDeQB+JvqJw+Mf7GMI6u95LS8?=
 =?us-ascii?Q?mJZk6dzXUyjiC9F5SSYJsGqRksyJSzMjNQJvXNQwWwNXMBpDFCXhGgtsDjvt?=
 =?us-ascii?Q?LMNVbf2vyIxMPp3NCikCjKtwOP1O4/LnBo3KIsN2lSeXkmZR7uqys/1WCAWG?=
 =?us-ascii?Q?vtrXSvAapAXsyrCNTHPljKZvX2T9/7P5R8ueLM0/cTxAvxlNI2ihzT0aEdZI?=
 =?us-ascii?Q?gBakmUcPq0gi5UA8j5XDG9v5eZ7hGvHKtqi1ryb4ChBbWBNEZ9xp/iXyL5hh?=
 =?us-ascii?Q?5Nc7gU73mAgcyzSJrkdhX6vVEVcJY5O1Zh7uA0UUJ2krXnrD4dNjN5AUYsAo?=
 =?us-ascii?Q?9xN1wDPLKKfhoke6AP55FTw0PseXvorlE9aXBP0YyBNqfEqgUWDljH2fVJYn?=
 =?us-ascii?Q?aApiVk1rapwiCHO+HYXwE/ajnY/fz59e8zP2SrcKzU7TCkDtEZBtKKnF+btw?=
 =?us-ascii?Q?11gr/HzM+rJofZtON6MkTEMLr0uRjR4PRy3fxaaxHmRRP7In8ixPHYWBfkzd?=
 =?us-ascii?Q?qZzatFzZVtMRfM3/k2Oh5iQEzyEAAP8BCk0it25AGwuq51WvP+u06kFAYlbU?=
 =?us-ascii?Q?H8ccvfapWvW6kughJm/m+vehNj6lGDfw2F/xKzOxaJQrGXBvxm3pOnnmqSmA?=
 =?us-ascii?Q?iza5fkavbZoM/dYWVsYLHG3ATZRB6p9+2YrflhBjaeU16zAqrGn9jhEGxp66?=
 =?us-ascii?Q?eiD4bUG19y2Eo1kGdBt5CLLIAwFd59v2FgL6+N8zWDha0TPSl8mRBLVzcKvg?=
 =?us-ascii?Q?ASjPfqJPBfTuBb+tXqZQL48XPFmvLCX2sen8Y2lB5H+/aopy3CIZ56aJPQ91?=
 =?us-ascii?Q?klzcLs8gC79pVHgYlPV+g23n/lJsBZAbkDnfsyy/vWLArSfrAKPv+BlFxE7U?=
 =?us-ascii?Q?kh28f88HUJn+57p9Lavcvl02GE0+Y+N8VPBGXKzBM9gouxRwgmwMpoLRV9BE?=
 =?us-ascii?Q?Q9EQ4D5Qrr0XAKsL/ZbQRnXR5V9vwjqthZun3zt9DDyFBuXrR89LVhkTvMSn?=
 =?us-ascii?Q?B3zyzBSIatGkAamLmf6Veq7MJRf8t1ZKTaa8HFWvlS5hs3SAhx0WxK+IpbwT?=
 =?us-ascii?Q?etjy+WrXNn3pNMrQr6UvnKmCPIcEefC1Z5ghWZtl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96291453-4006-4a5f-ed6a-08db1f6d15c1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 00:35:58.2170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oj1szcx9V7BUgTaU2uoaVhe52+3VLtJsYlLhKC8P2okU1GNLuwOrdSzouW4y7tom
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

The sw_msi_start is only set by the ARM drivers and it is always constant.
Due to the way vfio/iommufd allow domains to be re-used between
devices we have a built in assumption that there is only one value
for sw_msi_start and it is global to the system.

To make replace simpler where we may not reparse the
iommu_get_resv_regions() move the sw_msi_start to the iommufd_group so it
is always available once any HWPT has been attached.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 14 +++++++-------
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 4331c7a4e6831f..ba84d314127ba6 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -88,6 +88,7 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
 	kref_init(&new_igroup->ref);
 	mutex_init(&new_igroup->lock);
 	INIT_LIST_HEAD(&new_igroup->device_list);
+	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
 	/* group reference moves into new_igroup */
 	new_igroup->group = group;
 
@@ -249,10 +250,10 @@ void iommufd_device_unbind(struct iommufd_device *idev)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, IOMMUFD);
 
-static int iommufd_device_setup_msi(struct iommufd_device *idev,
-				    struct iommufd_hw_pagetable *hwpt,
-				    phys_addr_t sw_msi_start)
+static int iommufd_group_setup_msi(struct iommufd_group *igroup,
+				   struct iommufd_hw_pagetable *hwpt)
 {
+	phys_addr_t sw_msi_start = igroup->sw_msi_start;
 	int rc;
 
 	/*
@@ -285,7 +286,6 @@ static int iommufd_device_setup_msi(struct iommufd_device *idev,
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev)
 {
-	phys_addr_t sw_msi_start = PHYS_ADDR_MAX;
 	int rc;
 
 	lockdep_assert_held(&idev->igroup->lock);
@@ -310,8 +310,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		}
 	}
 
-	rc = iopt_table_enforce_dev_resv_regions(
-		&hwpt->ioas->iopt, idev->dev, &sw_msi_start);
+	rc = iopt_table_enforce_dev_resv_regions(&hwpt->ioas->iopt, idev->dev,
+						 &idev->igroup->sw_msi_start);
 	if (rc)
 		return rc;
 
@@ -321,7 +321,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * The user can attach every device individually as well.
 	 */
 	if (list_empty(&idev->igroup->device_list)) {
-		rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start);
+		rc = iommufd_group_setup_msi(idev->igroup, hwpt);
 		if (rc)
 			goto err_unresv;
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 22863759c3bfb0..7f4936cf537be4 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -267,6 +267,7 @@ struct iommufd_group {
 	struct iommu_group *group;
 	struct iommufd_hw_pagetable *hwpt;
 	struct list_head device_list;
+	phys_addr_t sw_msi_start;
 };
 
 /*
-- 
2.39.2

