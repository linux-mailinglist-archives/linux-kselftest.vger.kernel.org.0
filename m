Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160376DE138
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 18:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjDKQng (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 12:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjDKQnd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 12:43:33 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3604ECE;
        Tue, 11 Apr 2023 09:43:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sf2fgey8WuTqshz7/2pre1a7TbKEkt2T66mCgQB+U/Yf1zqAcbUROUzoJ+natXPa9v2oaMtYgtsvVmifE5tfosdH+hduMoJyqOpQ+ESoej+AereiZASoeLs0sxfW+tAQv8DLdnfHlAXvoZCqp1sFwcNpllymsqHD9WN8LfHt6I8wj/gIgVhklgCVv6Xj6525EyDEDBCDhA0lVIk84IzAHf8jQBWnPdOPQrmEuhhJ1dE361a6yC2Tcvf7/PjOw5maUHyXPbNy8azowHoar7vTS1gf3JxmKrYFGYZc3+h227o8zY6yFibra7xW/obxnYLp/M8Kh9dC/CdIii+T8ZA9Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGJkRPbIexIVH+xwRqYapeKZ3Zts1p7lbEGw4jgPNJw=;
 b=YMKaXVxP00mXV5a75bZddTg5YzBQ2Y4R0PLiIzrbIWQDWu0+iDAucNT6w8THsN9zz1z0kNSOoUbHRdNh6IKcx/v/OvgoCN3P4gZrT5zPj8juvT4j5DtHAT356b/dQbkxmaeKPFrZRPfwp34DEaIwtbNeEfS/8Wg0enXm5Qd1tF5tWJ9zTmsiXj9DbsRk1YQQlPjYKVh+mmx5b6ofICxlNiRJOygP7oHdHQNfFPwMtApYPao12vANWuTFP1pTwl/3jnqsoukC9g5VKMdmMV7qhvD6LRnZEZNociCKzcXDsCw87yodK2f151+24V3jmJaEbxEwNqRHLhkGHbe3i8Vi2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGJkRPbIexIVH+xwRqYapeKZ3Zts1p7lbEGw4jgPNJw=;
 b=RnOsueGARIDuMSm0i1sWJb/iQphery+T2Sm3n7rBUbIGJ8TZDDTTQQAT2VvCE6BULEJ4wcv5jfjsbCUXQnah1NiFmtE7SGt535gAANSkWvikYDJQWC/uZqmUYxIMpguXNo2IHXuLx7ieDzJ6Uc2PvuhZPCcH3FGZy14G2tZhN4XWYWDse2Nch1NAFhKz21cI6icVBifTfDnSvPaD0YUARS9kKUVuSFP45+qMZ+WD2uuDmhfLKlTFbwAcsiig23ezsFNTbz+0jCZxWme9Xf0FkwAtqpZdirhbPuh+6+bE2AQej1fDjcT3qyIffkQv2av8C+JYxJXHf01XbenaCZLW1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 16:43:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 16:43:22 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v5 08/17] iommufd: Move putting a hwpt to a helper function
Date:   Tue, 11 Apr 2023 13:43:09 -0300
Message-Id: <8-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0050.namprd07.prod.outlook.com
 (2603:10b6:a03:60::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d2cd564-ab7c-477e-44fb-08db3aabdc92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JgEGMnhwtwTLGABf8lLvgBqdW+jy3r76Ads2ythOxqsPRqOYpj8XkZUFCBLtVG+MQ9jhIfhvWFwdSpfpDB/RvZnFa8fhyUx4ddxEf7lef5lHq040FJ9GuTFtrS4Zus95B+lVh+pc+DQu85HXATQ2XV0xxUvhCLe1YG+A7ax7vGnEKbSRtVT4V8W3lvXK5G0FnjxkudyHh0wG+Gd/tqVkxuZoYiNUvzTwYJxDBLEz+dvhY7GcwiB7rZDCJAQXG5YmVDhsB6wRYER63BWqp6deoVZuWQnhT5DOE+7tpfnp8hTnOcbi3uqxL64LIJ6pPtUkGI1RaSSL29KIrGEFk3o7t+rVdujJwiF7vW/8vea4GXf1pdomHCBuC52JOl+Bat3Y1KUhxO+I90YfPQ/rMAYTqdbxXgRypet0FZZyniLrArV80MxtvIHMcdZ5r9Nw289FQSggk8upf91xINobwZZ1lHdTLGXlhqINK7pWHHctwXKZKH51vwF2/Fyejd7YNLnvKtaMFPrQdRRsJM4CBLGpAv8Hx5Fl83rDNMebMjZi4H5OWUr5PX06wshyNQNkOCCgKvuowaBUMG8uvY4Zl5uXewYHb4M5WW5D3QxNBr3cROA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(2906002)(86362001)(36756003)(6486002)(6666004)(2616005)(83380400001)(186003)(6506007)(26005)(6512007)(478600001)(66556008)(66476007)(66946007)(4326008)(316002)(8936002)(41300700001)(38100700002)(8676002)(5660300002)(54906003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZsRXv22N++39zszLfgU4sxcgwQJDmRkkfUyZqh93fcHmm7AqVJG5gPclwfyY?=
 =?us-ascii?Q?iBJ5E80ODVe7EQ2SDe5uHbDGEJ7IW3cGd4bDkWejDwIfng9VOsnIlxXvKYzw?=
 =?us-ascii?Q?Bgm43uGXafuNR/+dgF+D+o+5DjAV5dGXHzT9cp3sN+XyD9ZGmObL2Ig1Kpms?=
 =?us-ascii?Q?SvEwK/oyRrMoJOSa9MhAE4b6ZQ12+iJf9EGKjX2GTJkxNdY7EdymtMG4jBIJ?=
 =?us-ascii?Q?KrMxASEJ1aDKhGAfXcTOcar49YbK6cTIpkY0NBz8GQSQ1W19ZIi16AOXD1e7?=
 =?us-ascii?Q?KPP20jq9Mj7KCvrYl6wMFHEA0wyk7GZxmBhs1O9LDC7z2mIZrDAyVMR4COLl?=
 =?us-ascii?Q?TJ+QocVofipCg+U98D9rL2OK/BGJve3L7l1xf017Hsj9eOsezz9GPPyq7XnW?=
 =?us-ascii?Q?wQ+g+wcmnT4S2olbcZMBLytQfCFIw9PLGfY1OZ0euzSunnxft/SahZ/qLy0r?=
 =?us-ascii?Q?WID8GBVY5sud/JDG2UxIRneZtKs++r32TOfxYTNAbciCyFFKpzGR1RNSH12q?=
 =?us-ascii?Q?CQfdVmjcyCj80J86/INukDt4GxBmVo2M0pzHpB+F8lFwlyFUtpar4x4WNLs3?=
 =?us-ascii?Q?VmMUxuloWL5otE91RO73uIP/4Hj1iM5+32PNOk6ZExfsE5kQgn2ib5CkIYt5?=
 =?us-ascii?Q?erxP63JDuZqZeLN33GdLYGiFn9k1bRkXZAOGFV6TsOy7P3EaSUx8761Fssaf?=
 =?us-ascii?Q?RYoWnms4C5sQtK9Ebqyrnn9gQQFtx5JgS7OU2QTUPhbQA8KEm16qLqzutTc7?=
 =?us-ascii?Q?GDbMHGSTpXr0Jjf2oNUbePVa3WPfFs7QnC8+7+WS9TElP3EiTVL6/Hkml23a?=
 =?us-ascii?Q?MCTHoJO/lnYsTp7Dk2uIVeAQHWkKQhyh6J/Ueac8F83TETOBFQOduI+c28Kl?=
 =?us-ascii?Q?0z1QMWoMzh126vvSTAJYGa4d4cnzf1trP8QAmsqfL45B9OZLOhbPN1kllU3N?=
 =?us-ascii?Q?ViNkwD+AI6+eQcG8e5oaRlFbABAv4oOdxq5VIM5oqqXWinxQpcQsxXqgKWPy?=
 =?us-ascii?Q?Tm/9kVYiDiuJ7Jtq3wa8LM+f0r0qnzlkoKybixtFVIPD9tqrCkdQpY3xNmnw?=
 =?us-ascii?Q?OYm2wV4U5HsVThmlYodgBLVBuqP437mz836jjg0lIIxYOgjTjz1bKEx3bJ+Y?=
 =?us-ascii?Q?SoozxYVVZBQaGfG6MrkUX698jo8TXtcHZ94480vTbSzxp1EyREZ1kD04onrv?=
 =?us-ascii?Q?A3Vz9PLyoWrAdQoujzQjthyK/1pd+uat5kNJ5q2L26YDsT6aQiuXGSygaWWM?=
 =?us-ascii?Q?BIYwuWEafwHfVXQ7k2GMZjqGA9HGBaawpW7prNhPdiwJ7lqS99b2+DD7b8Yh?=
 =?us-ascii?Q?cotZqr1EvgPYi5fS+oAL34mHoBOizI71f07WjutxDZTBaqa78ri+9tBLZcf1?=
 =?us-ascii?Q?gti31+IKn8/6TJmDallvl1u9tb20tDc+9uDoa2utD3pwl0nWSU8+VuqTX3a+?=
 =?us-ascii?Q?QtbbIrr/MjagWk+Rk0KJyt4Ok0WGVZblXzH7M+GB/t5x8kmGL79ruL6ETMgc?=
 =?us-ascii?Q?ctTMAeQRvFdu473QDnt3UeGCkORJ9Oa3oEMNonLxSDiFGPpYYm8vftRCsoVz?=
 =?us-ascii?Q?LX7YXCdHHYGFX+Na7iBfRdfRxHC4iLqu+BIyqiRc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2cd564-ab7c-477e-44fb-08db3aabdc92
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 16:43:21.8934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hg6bh9WCfli5xDV2K3rZVnFSHCZUVu3vqqgCOZfQhVOedA8/dzj/Nngou8KNU9xz
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

Next patch will need to call this from two places.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          |  6 +-----
 drivers/iommu/iommufd/iommufd_private.h | 10 ++++++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index b828683f4d45a1..2ef20fcddbdd62 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -490,11 +490,7 @@ void iommufd_device_detach(struct iommufd_device *idev)
 	hwpt = iommufd_hw_pagetable_detach(idev);
 	mutex_unlock(&idev->igroup->lock);
 
-	if (hwpt->auto_domain)
-		iommufd_object_destroy_user(idev->ictx, &hwpt->obj);
-	else
-		refcount_dec(&hwpt->obj.users);
-
+	iommufd_hw_pagetable_put(idev->ictx, hwpt);
 	refcount_dec(&idev->obj.users);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_detach, IOMMUFD);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 7f4936cf537be4..8bf053f4d4a9ce 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -260,6 +260,16 @@ struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_detach(struct iommufd_device *idev);
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 
+static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
+					    struct iommufd_hw_pagetable *hwpt)
+{
+	lockdep_assert_not_held(&hwpt->ioas->mutex);
+	if (hwpt->auto_domain)
+		iommufd_object_destroy_user(ictx, &hwpt->obj);
+	else
+		refcount_dec(&hwpt->obj.users);
+}
+
 struct iommufd_group {
 	struct kref ref;
 	struct mutex lock;
-- 
2.40.0

