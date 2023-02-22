Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED6969FD5B
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Feb 2023 22:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjBVVCz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Feb 2023 16:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjBVVCx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Feb 2023 16:02:53 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC982D70
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Feb 2023 13:02:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOkINtIWdZrxKIj3+YabFdxn8+ymqOha3hx/ggf1eeiMVoGW3NVAeu6RjoFmCgogi849jmL9b9A0Hs+zrESRdrB1A11ZfGh7MaLnUAOL4l+WzmzxtVICPVbf8cI5f7eyEavoJmft0xcdDvUhrEMnAihQQF2seEWIe8UnQgfKhPy03kEtVKijl9afcWSTztnTjdPb3nx45EBL0qwgLQimdclS4xSu9gVm6MW5uxtlBobD/JsjPtPuYVQU2/uq/OmT9L42vA9KMX8t4ZyGZ2DDYt4IzmaZy2tyZnshaMgJJ7fC+ieAiJ81FqPROsbIiO1gYJu3vEUg/YM7psfwGtjmLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENMQXKEwZgh9Wzw4r/GXv6usySs+YiwlE90pmMNvfRk=;
 b=fTbMEqzQjZhmVxgstGGMjw65pj1ly00YZZ5ZCrWMIYEBEgqTEO597hyfC5Al7C8E4B2//9hkSFGH2NTcDyGcvua7I1tRA+1vQ/R7tlzPVRoIetUNqjivRUVNPXbPMYdqpc1xyZOpywZiUoVs+UqUvulbuLe4OpcyXtcy6elEQXrkBDH8TEpcFQ/nyLNQYP0qlNlajruKOZwzmTJq02kXhgI0DSVBRMVNtF7MytTTO2lgjAuilxAkyu6A14/TtY8deGUnVHpBfBMkjAVOW3m63wM0gV2O1Q3cGarHSU4FdBEBIE2P2XfMk+c+WDJaFzi5an7IIS04bpIh+rof7W/jug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENMQXKEwZgh9Wzw4r/GXv6usySs+YiwlE90pmMNvfRk=;
 b=RMoN8cH7vnE2RovQl5MiF7WdP1SvrDnDm51/z3UUwX01dflTvRixG1WAHEKtvru6Af9mKf7oZsL3v8M7Rh69ZvxZiplHAFkFjjZJk7TIlqrcpcCr9KRjOvnnGCGOVjd1Az/gKjS4qN28eKS5hKJ7iPfInWIcVNSh6x378bKpU+MQ91SVCVeY3lEGhdXJKplrFLFCrG+0GqKYoTK48OxD58nfO5aX3NnlefMl12rmrLLQ/LfOJG2mJcOj/ChxAhTJi9RwY+WgjGwOZwb3NOrZhJJwG1/bgHcaGlkbWfi3nzrkwusY64JpjfSakqDfH51DMy2d9me4kmHQ0uu+9Ytu9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 21:02:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 21:02:44 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 3/7] iommufd: Move ioas related HWPT destruction into iommufd_hw_pagetable_destroy()
Date:   Wed, 22 Feb 2023 17:02:36 -0400
Message-Id: <3-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <0-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0012.namprd20.prod.outlook.com
 (2603:10b6:208:e8::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: ab801a12-20b9-433b-3fe4-08db151823b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JQkAZ9U4YukQkWEwU4ZR1wuFRINXuE9C5jCYR52WEVE8zdvM5HMyOy0rVgYZxD47xvJknAxJds//qKXuOpspBiHD6LdFHex9NobaE+zCdvRYywg3AzHPRfKoDNNBO8kkpeiWAnsi8b+yvCbl29mHZNuW6PrULv7zwsq1ZDwcYxOtRTPqTNerfTmnltHA7thUZzw9TEPv+/+8ubNcodeaVCH+bAdT122NnaB9AgCRX4LKBJvEh2s5k5CUg6P+sQp9PTy5pj8xCF/+z8mmthSGo46yOCmBW09mUvLlzPff+99FAxEQEIgjjHxe0xtNOmp1TKO2QHQ6D3ZcYcpDsPZ6n0gVQVzz2e3aELA6yeF3bPyg7i1OoH5PVkkQnpIT5qeanDQjH1Rb0CXpXTrRSywkoEG0OT3G+6AN7VwjfbzqGmQXtfe8W/Lp/LmSd/s7WW6v7IIf9vuFKm0FspdbGr7nimiAgdUoz88nEHIvVrB+kGBZsClaTCVMQJExGKlqXdoZ4HG89jWaIFlan39mqRoIFAf4zoo6uLXbeS+tT/v81hHNPD39vx3uP3BP4+9iD/MBDozObnYredw2TenEbgSdsjPUU13gzw6yoftVIm9oYPX+0CxCXY3f9JkGbffJbRc0ZtD/8lecggaiSCnAxJSmx3JKKSpk8ek4MN5E4LyRShtQFKqxxdw0Ptnsn7XKNA0b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199018)(86362001)(316002)(5660300002)(36756003)(66556008)(8676002)(6512007)(66476007)(26005)(186003)(4326008)(8936002)(2616005)(41300700001)(54906003)(66946007)(478600001)(6666004)(6506007)(110136005)(38100700002)(83380400001)(2906002)(6486002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LjBfX5kLtQRH2vgjeUfoGJv+rarQL63MWWH1+Wgq7PErPmeuvCAaK0DIGFhy?=
 =?us-ascii?Q?chCWdPanvkgaEFVHBd4fuGTK3CsFNEGYsqrfjHuT85t+qUb9u2NgoAVskZPk?=
 =?us-ascii?Q?r6JStuyD5O7CyNIMSg6ticyqXe7d3C3tff5v9HwWlXuOlKJvnQdIr94o7tnD?=
 =?us-ascii?Q?u2//CuyBOp5qCUhKlawgiqEYosZMRVuGQvL2vcboHOPlJGVKRIrQshvVzaOc?=
 =?us-ascii?Q?zITUjCzY61jPJDXZCTgBmFwC4qUqzxeH7MCBh5xvLf44RxRgx3N7HgzTLha4?=
 =?us-ascii?Q?HReHdG8Gzw4tRAYoIlxpXU+DiFRhaK3gp4JOIKQWMOuV1/dl8/uaP5WoaxWb?=
 =?us-ascii?Q?fY9vnC8zyax2Pk/jG3GRVdtqCi5oaWrgwOXyk1W58y4jjQEH5+q9vyGPVOyz?=
 =?us-ascii?Q?coynMhbW2EQ5WsyDFtRBGzyRcbGvRulvtt8KRTJAVKz0+PV6wzqWT1e0+Vau?=
 =?us-ascii?Q?8W6kPeJ7J7Bb3HuMdCm4Qn213hPjejEmBAu0qlzNUQ1QTLD89tR7YLqj/mtU?=
 =?us-ascii?Q?t96w1ViFOOZljKRHWwIaZ5iW8L5smVD3bDuiT9HsDJBrsQBNTJBowYkkuf9F?=
 =?us-ascii?Q?3n9ogmKTjtncNGHV0RAjtw3mYu6X8rvjJ8zDo9A3GzWepcXQvN/oCBLVON73?=
 =?us-ascii?Q?+fWHNd/J8UO9T8QLF8/E/Nn2Z68gNdGnOB/Kh7O7fIQ1Vd8n5OJK7Ra89qao?=
 =?us-ascii?Q?zX0BAM2IaHaw4TW5jzuK41XUF+8jSQbYJUHei4zc2glSJxBOo8AfsjyvMd53?=
 =?us-ascii?Q?N6DgPf28MXZPXtS30jpTZ/qY1i8XFDSjR6l6ckuPQQmaNb+oY8RpTyUZeyF3?=
 =?us-ascii?Q?yNu4IcmzEFr7rLi1lI0ZKNv4+mGxQqAX/uPRmwqIhVKzW4qupj+LWiRbXHcq?=
 =?us-ascii?Q?de3mRQhaFrLsJgx/c29CR72tCa3asILt0L5kyzYy0eMUVlckaG7ZjLWAyEg0?=
 =?us-ascii?Q?i88jopbcGmseo6GOUaeLRBwIC3yRStFqs07xKMPWJtha0sGX8YTTx5lYoq57?=
 =?us-ascii?Q?3u+cNuZ3K56QXfNjAUNz3G98ga2hQxoM0fH1nJmnMHrYhZOL2hNAgHChb+1A?=
 =?us-ascii?Q?EzRLn11JTsbMJ00HL5UDXzT24ixMl+egWeoNJ4oCP4ZXIEjq+zEXyWLIM42j?=
 =?us-ascii?Q?nMccu87u6v3cuvk+VwjqxeuDCQ9EeVuslfDRwDtZmCXpFTo5RfG0Z4TMlpC2?=
 =?us-ascii?Q?bf885yLfT06gOz5l2X4tRmEaxup9+uPpVsjb/sIUz+KDdTbKAFzL1IN65tdI?=
 =?us-ascii?Q?g+tUJ3H8nibv1MzzdrYeNYDlPgb1speL4uWezrUSqB4lT/17R39WCavfRmy7?=
 =?us-ascii?Q?KpdLXkLv4K6FehBpDJ2skcuhJqalboRrX2dRJObXRFlA4oHXwpaTX9C41xo4?=
 =?us-ascii?Q?K3ajirDyJBmRWNq0PU9xL+yTwkBiiJf7lvnE1xjIWluzUgsmhQppKy08MORT?=
 =?us-ascii?Q?Y1Di/LKPhVZYedZL5UotpVCBINI1nhmFOyXjSGt/XhLGdxZwpg3Z8PuMeM5d?=
 =?us-ascii?Q?YubRBrGLczo0+mKXe1MAjcDyban5mTLZb2khW5Yzq58rk5PzgQWH0hahYBYC?=
 =?us-ascii?Q?yFjN9Xm+JTxBcKLegL9qy93UV37YBPATJMVVmIwv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab801a12-20b9-433b-3fe4-08db151823b2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 21:02:42.7214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9MLnsSRMO9GYUNovWsAlMAYyRGzddTuomyLyX9iPku6X6CE0gP2/89CLYgbVBD1j
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

A HWPT is permanently associated with an IOAS when it is created, remove
the strange situation where a refcount != 0 HWPT can have been
disconnected from the IOAS by putting all the IOAS related destruction in
the object destroy function.

Initializing a HWPT is two stages, we have to allocate it, attach it to a
device and then populate the domain. Once the domain is populated it is
fully linked to the IOAS.

Arrange things so that all the error unwinds flow through the
iommufd_hw_pagetable_destroy() and allow it to handle all cases.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c       | 20 +++++++-------------
 drivers/iommu/iommufd/hw_pagetable.c | 27 +++++++++++++++++++--------
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 0a80ff7b2e0d79..6787a0d8d6e9f0 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -243,6 +243,7 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 						   hwpt->domain);
 			if (rc)
 				goto out_detach;
+			list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
 		}
 	}
 
@@ -307,7 +308,6 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	rc = iommufd_device_do_attach(idev, hwpt);
 	if (rc)
 		goto out_abort;
-	list_add_tail(&hwpt->hwpt_item, &ioas->hwpt_list);
 
 	mutex_unlock(&ioas->mutex);
 	iommufd_object_finalize(idev->ictx, &hwpt->obj);
@@ -386,28 +386,19 @@ void iommufd_device_detach(struct iommufd_device *idev)
 {
 	struct iommufd_hw_pagetable *hwpt = idev->hwpt;
 
-	mutex_lock(&hwpt->ioas->mutex);
 	mutex_lock(&hwpt->devices_lock);
 	list_del(&idev->devices_item);
-	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
-		if (list_empty(&hwpt->devices)) {
-			iopt_table_remove_domain(&hwpt->ioas->iopt,
-						 hwpt->domain);
-			list_del(&hwpt->hwpt_item);
-		}
+	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group))
 		iommu_detach_group(hwpt->domain, idev->group);
-	}
 	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+	idev->hwpt = NULL;
 	mutex_unlock(&hwpt->devices_lock);
-	mutex_unlock(&hwpt->ioas->mutex);
 
 	if (hwpt->auto_domain)
 		iommufd_object_destroy_user(idev->ictx, &hwpt->obj);
 	else
 		refcount_dec(&hwpt->obj.users);
 
-	idev->hwpt = NULL;
-
 	refcount_dec(&idev->obj.users);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_detach, IOMMUFD);
@@ -753,6 +744,10 @@ iommufd_device_selftest_attach(struct iommufd_ctx *ictx,
 	if (rc)
 		goto out_hwpt;
 
+	mutex_lock(&ioas->mutex);
+	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
+	mutex_unlock(&ioas->mutex);
+
 	refcount_inc(&hwpt->obj.users);
 	iommufd_object_finalize(ictx, &hwpt->obj);
 	return hwpt;
@@ -765,7 +760,6 @@ iommufd_device_selftest_attach(struct iommufd_ctx *ictx,
 void iommufd_device_selftest_detach(struct iommufd_ctx *ictx,
 				    struct iommufd_hw_pagetable *hwpt)
 {
-	iopt_table_remove_domain(&hwpt->ioas->iopt, hwpt->domain);
 	refcount_dec(&hwpt->obj.users);
 }
 #endif
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 43d473989a0667..10db1359c067c1 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -13,7 +13,17 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 
 	WARN_ON(!list_empty(&hwpt->devices));
 
-	iommu_domain_free(hwpt->domain);
+	if (!list_empty(&hwpt->hwpt_item)) {
+		mutex_lock(&hwpt->ioas->mutex);
+		list_del(&hwpt->hwpt_item);
+		mutex_unlock(&hwpt->ioas->mutex);
+
+		iopt_table_remove_domain(&hwpt->ioas->iopt, hwpt->domain);
+	}
+
+	if (hwpt->domain)
+		iommu_domain_free(hwpt->domain);
+
 	refcount_dec(&hwpt->ioas->obj.users);
 	mutex_destroy(&hwpt->devices_lock);
 }
@@ -37,21 +47,22 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	if (IS_ERR(hwpt))
 		return hwpt;
 
-	hwpt->domain = iommu_domain_alloc(dev->bus);
-	if (!hwpt->domain) {
-		rc = -ENOMEM;
-		goto out_abort;
-	}
-
 	INIT_LIST_HEAD(&hwpt->devices);
 	INIT_LIST_HEAD(&hwpt->hwpt_item);
 	mutex_init(&hwpt->devices_lock);
 	/* Pairs with iommufd_hw_pagetable_destroy() */
 	refcount_inc(&ioas->obj.users);
 	hwpt->ioas = ioas;
+
+	hwpt->domain = iommu_domain_alloc(dev->bus);
+	if (!hwpt->domain) {
+		rc = -ENOMEM;
+		goto out_abort;
+	}
+
 	return hwpt;
 
 out_abort:
-	iommufd_object_abort(ictx, &hwpt->obj);
+	iommufd_object_abort_and_destroy(ictx, &hwpt->obj);
 	return ERR_PTR(rc);
 }
-- 
2.39.1

