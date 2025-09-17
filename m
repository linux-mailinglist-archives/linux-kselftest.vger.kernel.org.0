Return-Path: <linux-kselftest+bounces-41759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6679FB81B50
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 22:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B063A9053
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 20:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6F4237165;
	Wed, 17 Sep 2025 20:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NFNFeGIo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6659238D5A
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139316; cv=fail; b=pmA3NHenYvfqKNqztf9B/r7NofFk80zdkrIKH+4mdIslhghbp966THSBKk7hZ7pBQboG700s3sdZV/YaVxI8eHcIu2GjjyaXt9a8t2+/adUCc21imc0CyhQ4Zts/Mn2gFjHXp7dl9Slhj3f0DSlWsXIhuf6uGKZrYiSRLSdkywY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139316; c=relaxed/simple;
	bh=teZpIWrQVtLbakbhqEUC2l+WTt9hfNhhx/lciMHmlys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fiRF6NGH05nml1S7L4ASY92bU4yFTKrXbCP7fBZ7lvHdvg4n7e++pLsa5HyPg2ajjADyUv7nVetxWkK7HdPwdtqm+X9Ix0Y1F0y5xSSrucKjEPNZi412lrqluXB+OuNODZmbkSpmXjT2eVWhKpAv2dMaO2N56UpylpCN0hu+gyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NFNFeGIo; arc=fail smtp.client-ip=52.101.52.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8QOah9U2yFyc6BJjxD2amqtCm5zHXXbxco4Mwg9vc/4oMDQHuutB5vxxKDEq3no2HCepcQKXYYV/8tl/UzFJiaWu3D/k8+M3OzLrb36YrO5gqdV8KzdyFOdqeQnPNkcXlWCFlxwGkxo+bJrNyYYbd/QahajiFkq7AZR9ar7jEdTz+zZGUUl72zr05qZYEZo6RHEKz9hto68BAu4vKUO52X+TDWPa4/c0PVIcMgEkoX571yPE5tWqKN6tbrdzCL9XGfPsMjQtvhG5KNmq+WskMZ7rbkSBRWBr3n5XVVs2M10XwaVKuNlIUahh0rrACTz+qakxnosnY2O5dQpLqriBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnN5iApERWNuxcL2IyApMvJgmX6cddhQoSS7aHurdb4=;
 b=zHVjAODP8lGhxlF08nSPG/yIk3ZyDLoYL+GrXNFTlfn1fqm9yaixjDE57OR1L+yv+kbGXQh8W/XyHMaZF1TMqcXweJwwbYuiBG51AoX0lBVPd77VjxQMia29BDdK22O/ZrykCNh9HrHtDd9rJWuJ1AiHEfTFGMxUBUL037kAtoRVnEX6vNQkywDNlSv12cXtpQwU+iPD/v/r2E48r4jsv6kkbAEtQQyvL24UUziOUZClQz/SSoGFoHEwsDOUIu1NP8Q0E459mRimBAQUch3xdHxDx+Jgw3i8kVgHXuXOKRaTfVHIfZ96BC8qmrPyWzmZsGNu7YdIBwWSOQLyj+B7EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnN5iApERWNuxcL2IyApMvJgmX6cddhQoSS7aHurdb4=;
 b=NFNFeGIo7dO/1w7gojYjmX/gC7evCm7bvyiPsCbjxxDEXLSFayD5uJ+ZJkj6K50qDCVx4AeSbFK7CKPPcljHY95QbYwTtYY0QJo9PUABN2QOarBhrBgLZgveAoeAIVfaZ4kcpt1LTw0W5xMvgcV/8S4yNZsKUFjsP1Whj1+bQl0J7Ww1Lv+hWb51zOsKqaCVs5LOEF1ExGVu127xSQFJCjlGk4zrI8oyH/eI5cwfvWrBCZBFoL1uoK7inUqMPd4/NHsIV6xySuTrZAz77mQmknkGkxwCWr3XjdSxNa3JjO6tigamWHyqzQRix/9iMjiJ2k1KpB5ahwhatEJo+O6+FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SA3PR12MB9105.namprd12.prod.outlook.com (2603:10b6:806:382::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 20:01:51 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 20:01:51 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-kselftest@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	patches@lists.linux.dev,
	syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com
Subject: [PATCH 2/3] iommufd: WARN if an object is aborted with an elevated refcount
Date: Wed, 17 Sep 2025 17:01:48 -0300
Message-ID: <2-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
In-Reply-To: <0-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0068.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::14) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SA3PR12MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c9e57e1-463a-45b4-f668-08ddf6250ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kVNRzcQIqxUgE9vqVyEEuBi7kWTMmroViWE2tgr4zRC9B9yy8rerWUfrf4vJ?=
 =?us-ascii?Q?EChbsI6KWP1ZeWZl6JU3xKd5UKRtbwOhLyBIYFbqb8uXBlJ5XY4cbfViz5j+?=
 =?us-ascii?Q?XjyY5voGoZ4IigbnPamxFF7E/bGlLTLTdNw94C97bW6xY8kl8gx2OnXfRPwb?=
 =?us-ascii?Q?/1C16r6itBeiLRng1v7nxSnPexjZuy4zqrGafEGPdqynK1qxPc3PgxG45JEu?=
 =?us-ascii?Q?amSS1sf+UScKBXC02lNuq5PeNb1jf/bah7ODoaOgXjCqq7Pi4p5U7qdxqfPV?=
 =?us-ascii?Q?K2Qusi4wcEepgMj6AWWWkzIB5NGILulrnjWYGNAEHQXJvBdQ4sb/qpCTjT8U?=
 =?us-ascii?Q?ONTDCnb5X+mYawCQe1qn9CTE/UbEhGT1chd5HpwemP/gEwx2zgNnS+fn4I5p?=
 =?us-ascii?Q?OhXbKpdSLGlpkQfruwHXFMenkBLMaKtAz8MC9L1Oxi3D+uaORxThOlD0eFdd?=
 =?us-ascii?Q?0e3DDGxmtGo9Luu1FIg4r3VV+81rwqVzpI6rLZDamznQa3vjIUiyZ6Lea2MU?=
 =?us-ascii?Q?O9RoeZL/r5YdvYRdF2TTzjU1neH+vxLUG542TbLgt/OH+jT1QU0OurJOVbrp?=
 =?us-ascii?Q?M+8HYURTUNas1WT15pGJAf2rKbKZxtPdpCKTzKMic1I2xyla4bGhwB5/ZVMe?=
 =?us-ascii?Q?v2bu19JFOAqgShf+3dTDwJ2tRMm5R6uWJM6r95CQmApyski0MOJWKUsfH1g9?=
 =?us-ascii?Q?hAGJQ2y6qWTXZ83J9kx5OZBm4MxLxrR2imVQy6KhjwyM86XZkjfv12NmX4Qu?=
 =?us-ascii?Q?65cMurYxTJgG2DoZPF3Ukuo+jnED9HK8J4cc7meO8T/zESYyMGyAZ83gOfPC?=
 =?us-ascii?Q?VC3DU+akszzlrQIUUL63s0imPyU6NTnDj33ByweRGZkv65jph58KkWPSTNnx?=
 =?us-ascii?Q?qlQ0Dzrp5Vi7CvbzoCCC/ir6u2rvVutlsW92nuF/nJojzqCRAIH4UrHpDUCe?=
 =?us-ascii?Q?tsSZoTVQMpUy9EjZac2YjRGwxQ0oTkX/GFOV8f5//qufsGyBDuV97MGMDWxo?=
 =?us-ascii?Q?Cd76KiUOy66F9jAmQMRScj9Gl6qxIbPfLT+rOr4FQloeSGvIFgbByqhKMAfY?=
 =?us-ascii?Q?Am10oVkwpMDdyNAn4kF4szO7kcEoweXXUCH4nmmSvWpr2e+qXa5UbweEITTZ?=
 =?us-ascii?Q?/WzKdtpDcmh/J9E2y5m2FCN6NVpmJyOJIbR/236CxHHep0REgo3NL6G1A962?=
 =?us-ascii?Q?pfH6/TM/25D5V75nJNG+TTFXz/Y4GkZBQav3ltAbvlMGuu82udYTLiqlsa8c?=
 =?us-ascii?Q?hsMV5Mv2aGrDvmmXaTFPkK2Nfsg6vhVLwmj7gFPeY2VRWQDPe9Fb/5AnwdI6?=
 =?us-ascii?Q?4/Us0rEao0s2Gd497nB6BAGUTfiVgBJfvsqSmD2Hwy5YZ1Y0AjyOY0/6rJhD?=
 =?us-ascii?Q?1gc2EK+FiVL7xn3Gpzs5eTx8JZYcm9uNlo1Uy4RsoxDBD9NVyTh1Nbg8YveR?=
 =?us-ascii?Q?KPlto7a2vxA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KmhEPdcfd7E393AP1N1qCjv/JLbRK+15GkxAXR4464TABBsq6qLmCzJCugWG?=
 =?us-ascii?Q?GBAKISTSlilTVPeBITma76LNkVZF+DfCheGE8spjz/aJ4jGdPjmPI+w5ha0u?=
 =?us-ascii?Q?brTjQRfoq1pnK6B9DTfwfkMKyW2rjPVDWuwdTKqTt7WSh8iS+eq1euZtTV7l?=
 =?us-ascii?Q?oWmLLzGzKCMupbnRPvVTMYui6HOTJb0nVxMjGfI/QYBptTiiVXMxhB1PrqbU?=
 =?us-ascii?Q?4E9tmhzMBDF+Q4OvweqpQC7FBDNQxarXmshaT7pFBukoFZ9qfVySa4g7tKH7?=
 =?us-ascii?Q?I2CeyUsajsjaVOSyZzEfp7TulgXYywWhrek34gjy9WFcnJiYVu+zoQPhp1T3?=
 =?us-ascii?Q?Q9hIHLVSJgN512Jx21gZk28CPIexysXBPrLG16lrxYDg1skjJxU3CQvgH5tM?=
 =?us-ascii?Q?76wQ/JZt2HCwcLOYWJWipP/N9K+PP0lc6rtQy6Mg3Q8wFjoinj+SpwHrof30?=
 =?us-ascii?Q?nU4RSQmBi7my/LcTMsWzDD9YV8udm5kh7W1V3sGdFj45UMb73n9KR0lrlJyx?=
 =?us-ascii?Q?9/eu2N1PWFwS1Yg7elTvB6Sbl1nV7g4LI7yqlBAFhLHlXlfjeODZaWvLCihO?=
 =?us-ascii?Q?GnbyQNq4aGG7BQwOxpqQek8lIUMC1b41CF976JL/XQbr0XUfQiV7HXXDOhUv?=
 =?us-ascii?Q?8MnF3jJxay9ZgEYBGcSnqLDJ0htff6ymXg52htzZGpiXrrwqTNlk3Wzs8jxM?=
 =?us-ascii?Q?wOV5kIq0fjP5DR9ZO5NAINu8Jn2zvpnQOZyfxiNTorb5O1LRLqf6kiqVkgKK?=
 =?us-ascii?Q?U/4hzTe8wTiKfmgHP3SgMIgOXgyhbsJ17mim9Pg1y3VcAU+TqaS3JR9N+nMk?=
 =?us-ascii?Q?6w7bYyPJ5WV98E4fGaW/QPqcSK1knqqkqAcd6FychTXQueupfQC3mKnZJSJj?=
 =?us-ascii?Q?cprHGluKxoQfFw6QOjZjHivoaOeSYNbVx9g9ZVwcn48mNujGDYYA+qeqBYvM?=
 =?us-ascii?Q?0KGHZ6SwPtl3I9nFLsSy+tFIAXsLDquhwC7I6i1x2Z4QV2yHZAt7xniEA5W6?=
 =?us-ascii?Q?LM0rmNr9EE5Cj6DY9t50T7DyaHR9wt8fbfaTLSUprYek3TDDfPMitxV35HjB?=
 =?us-ascii?Q?eqA5ig4DCgDaAAd9iMBrwS056PqXLY9SGFrxlmRqGh2aoRPcYWeZjYAhL4W+?=
 =?us-ascii?Q?B85ItKba5w84IQkApJeIKntIfux/arSX6/Vlr+WE9D68jkA7U3mfgP0LMz2P?=
 =?us-ascii?Q?sfbuH7XE0ZF32G5inMaGD/kkEE4m/hhhrMX7CddvYLjMO4cFQy/1A5R4mBFo?=
 =?us-ascii?Q?lW2LHLG9MpNqlj0lvxPYQgCsiKupJZUE06mqwNkBRavPgsjzbkp0RnRKl6t3?=
 =?us-ascii?Q?FmPf7jAH6c/I1+emneDLMrwh7bObS8OkmFmoHZdbm24TARnLrEghTSj4YaDw?=
 =?us-ascii?Q?9MRLYAyCRoIx4ImBlAIPz2doJnGRCReTRTxpDtuRlSkyW4vcAu4zRivjspIT?=
 =?us-ascii?Q?J73U19J5wsFGd3Zq6Xsq11/vFKzowAz2HEbB3/RCMYyqdyx5ZkwgV/KRQDbH?=
 =?us-ascii?Q?oJ9lM15MeeU74QDU4HV2o2qI87NRJhIcX2gtbnuKXs7MdHjqVOWZ+eNW3mLD?=
 =?us-ascii?Q?ZknrWKDL5GvyA/BlJo4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9e57e1-463a-45b4-f668-08ddf6250ab0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 20:01:51.1715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKNOK5YqOUP8VoiF3XnSFe7STd6vKLsXuUAU9/EvGUJhurw0vcVKikWzB8lLJHxn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9105

If something holds a refcount then it is at risk of UAFing. For abort
paths we expect the caller to never share the object with a parallel
thread and to clean up any refcounts it obtained on its own.

Add the missing dec inside iommufd_hwpt_paging_alloc()during error unwind
by making iommufd_hw_pagetable_attach/detach() proper pairs.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 3 ++-
 drivers/iommu/iommufd/iommufd_private.h | 3 +--
 drivers/iommu/iommufd/main.c            | 4 ++++
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 65fbd098f9e98f..4c842368289f08 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -711,6 +711,8 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, idev->dev);
 	mutex_unlock(&igroup->lock);
 
+	iommufd_hw_pagetable_put(idev->ictx, hwpt);
+
 	/* Caller must destroy hwpt */
 	return hwpt;
 }
@@ -1057,7 +1059,6 @@ void iommufd_device_detach(struct iommufd_device *idev, ioasid_t pasid)
 	hwpt = iommufd_hw_pagetable_detach(idev, pasid);
 	if (!hwpt)
 		return;
-	iommufd_hw_pagetable_put(idev->ictx, hwpt);
 	refcount_dec(&idev->obj.users);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_detach, "IOMMUFD");
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 0da2a81eedfa8b..627f9b78483a0e 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -454,9 +454,8 @@ static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
 	if (hwpt->obj.type == IOMMUFD_OBJ_HWPT_PAGING) {
 		struct iommufd_hwpt_paging *hwpt_paging = to_hwpt_paging(hwpt);
 
-		lockdep_assert_not_held(&hwpt_paging->ioas->mutex);
-
 		if (hwpt_paging->auto_domain) {
+			lockdep_assert_not_held(&hwpt_paging->ioas->mutex);
 			iommufd_object_put_and_try_destroy(ictx, &hwpt->obj);
 			return;
 		}
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index b8475194279a9a..3454b49cc58dcf 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -122,6 +122,10 @@ void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj)
 	old = xas_store(&xas, NULL);
 	xa_unlock(&ictx->objects);
 	WARN_ON(old != XA_ZERO_ENTRY);
+
+	if (WARN_ON(!refcount_dec_and_test(&obj->users)))
+		return;
+
 	kfree(obj);
 }
 
-- 
2.43.0


