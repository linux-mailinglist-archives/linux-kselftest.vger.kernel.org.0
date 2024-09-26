Return-Path: <linux-kselftest+bounces-18423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2D79879A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 21:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799552836C6
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 19:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B8C1714C9;
	Thu, 26 Sep 2024 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GA4Nqrtf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDE617799F;
	Thu, 26 Sep 2024 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727379372; cv=fail; b=hqRjHocpmBzAT8ngD9UJr5NYflBpP9uRaDaLEqoWBFu4/v1+0FR4t7IO5T3kNkGVuGWriT1042jp4zq4tJ6D/mSR6G59QuWcbGr5wXZSu31mm8X02xMYhOZJtWgWcBLZmEDRZyhi44+TMa+ZEiUEer9MwY8ZI8vgMfNxwlNd2Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727379372; c=relaxed/simple;
	bh=qRH4SgrXHFJHIEk79H6Am2n6+Zce+66KUhbadcTlWE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V8yp7efXcgK59jrFa96rhaNZqyc1C6/B+7fjDMaQ77Pi6lb2xomNe1DRZPHd/keVAh2/SqjXldlQbY6C6xTU3/WHggePy3FpqMNTeNeiWs3lVgKQKLG80ofjRCWAHpGQMkuAk2DdSw47HfcwQbTXgQLZUc52L2No0/A2SJB8XSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GA4Nqrtf; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzMvtmrFUvVlJbsD7D49tDpzbzrOsiCTeUBaWNt3Jo9NQ7wQYvM7neSnVW/iwE9eQOzTp1FLTSpzNoNEs7Y2+wQMbbOfaN2hqAP0Ic5+r7NVG6D21/2LzUK+M/XNC69Da9NUDK50ylUGqO2g5VfLfEqvtE9gjNHbKKw/0dqp8ZKpBVaThtXuF4RirJzeW2b3dIR52me0+SSnMiJJg+9hcH6HEDpx1UmlUZO0u9Kz1HwVge5oWaJq7LYakJi7XRGBH/aDA7cTaH5lr7hGln9jwe17jeEmRH2tBAtJ1l1zqVLxijaqHV8dLB6pA1Y7qluW7hnVe4H9kpdVEim+HUgjYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8VG/UCLgC/ysU9by2WJT86PvkAg7yIgnA3XfPV23YE=;
 b=UNv5CRN2xmTumo1ewFK1Q8zIcS4S+PAHm9dGk64F2Svhs8LRenDLdM29tGh0Hp3AJsbx7LFe7/Yj6DJfjaDvBzlIxZCSfkzxEe7VRbj5tyRbMEWPr0u6AOMmmvAg6/DZ/R23ZW+pJjnjtixEA8IAqGLX1NnNKaSgsfidkLF3NgbLcYMTOT2lbz/fZAlRuakzQwPRhfGWuNFowITgF33tJf1EVJqd44TcN1MX9ER5tGFcGKlAxI7/fNdkV59q9ZagppgLF/OWGqpITP10MJ4aVwyHHBDP6EPUAeUXa7hqcIiF31HHOEETigKh0Rs+mlFZJ82DLlnFJ7aCNpIFBQxyEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8VG/UCLgC/ysU9by2WJT86PvkAg7yIgnA3XfPV23YE=;
 b=GA4Nqrtf6JWoNjGAreIsrZYf/ih7a7B6E6V18AAesVyJXq8qiEN7cDuViBRfFBsXgMy98TjiixrLMwweo3Yb7jKFC5+uwHfz2T6jA66+bdAEJPO+EOzC8xu1SUMOG46WrT48HLz+MJRqJfOdA44tRasFsSDMGtKde26prqucio/BNqS/XkTtZqggCG72SfBShpkDEZ/oWo7OmFliLVZN6eDTCaC/pMOthdRyz88OZpKoHUKgE6HuhgsmyGmaSVxNvMMozn32T/7vU1p4YJFplhKPWn82SBC4fw/CXP/4CBpXOYNWv0QBCsuDj6FHpRMJTsbMigVeeSpklqpbYzM00Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL3PR12MB6379.namprd12.prod.outlook.com (2603:10b6:208:3b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Thu, 26 Sep
 2024 19:36:06 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 19:36:06 +0000
Date: Thu, 26 Sep 2024 16:35:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	alex.williamson@redhat.com, eric.auger@redhat.com,
	nicolinc@nvidia.com, kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
	zhenzhong.duan@intel.com, linux-kselftest@vger.kernel.org,
	vasant.hegde@amd.com
Subject: Re: [PATCH v3 4/4] iommufd: Extend IOMMU_GET_HW_INFO to report PASID
 capability
Message-ID: <20240926193559.GN9417@nvidia.com>
References: <20240912131729.14951-1-yi.l.liu@intel.com>
 <20240912131729.14951-5-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912131729.14951-5-yi.l.liu@intel.com>
X-ClientProxiedBy: LO4P123CA0692.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL3PR12MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f278def-4c89-41ae-99cb-08dcde6276d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4e+1+f4RPJpaKHkJrOsZ6pDN4aOlqduSxTbRAQAmSIO6HLLx0XYXsFSymj1Z?=
 =?us-ascii?Q?gFF879YJQoXSoFvjZyzC4tDMI8E4L2dxdF31VQWKaADaiJsCFEQa4CCS5yU+?=
 =?us-ascii?Q?seJeEAcmry5YjkAm6YRQcsbqyj8kCYoA1cSemK/qC+3Y4pC5ZLXupijOQFRl?=
 =?us-ascii?Q?k7h9CfLkE3reEYWR1IoNO9MSkQnK87Mnd/coFUsG6jRqC51jqYpbb0Kd/lQZ?=
 =?us-ascii?Q?K6oiiSOVKFSHzULoNFEevhLegaHXtdK/yJ6F4ThMa34Vv3GOLTUrqxXrkDcG?=
 =?us-ascii?Q?TcfG/bq2UyZmqGMpJEoZfg2EFg6oTqlGnzX78WWoF94WZUYrumtaML2+P6Yc?=
 =?us-ascii?Q?TG1/ttvwLlU6I/L6lVVnAdGcRXqe772bvMyDw25uPgtBQAgoX1UrBxRB7Quf?=
 =?us-ascii?Q?lmm3O2ZXQYWFCS1aSHjlyeTnK2/JjMsI56tHyvHHdVKikGlzGdYJqMW9LphR?=
 =?us-ascii?Q?oHpPA5oEaQlZ8xJVmr0Wd5zBNVPuNbi8ACwgTzh7BVFrUC36C08Pmd9pFGWN?=
 =?us-ascii?Q?RrC7ogXMa9H0eUPFyHP8dfrKCSf5Kfk/lRoVJYd6d3uMj/fvYPS63SjBjdti?=
 =?us-ascii?Q?XViAeXGJFG+FOHlEoffK5hyX1jWG0xRsJap/fTw2gYVGkWrXcjpta7ctCt5g?=
 =?us-ascii?Q?YbRb181Qu+65xv1WMQcJoK2Ms5fpTne6sJzaM1Ucx7yyvcxmJKX8ahZcdAT9?=
 =?us-ascii?Q?b8BrMmy0qjkZfv5J+1NBGLdM9NOmEcEb6hg+xAcmHM17NJUzpdkjkrafJLAA?=
 =?us-ascii?Q?xrAVjhLSm7YblWXcwZ7W7Nv4sL0tA5KDftIJsW7ePv7sogLdXPCM2U7J6O6k?=
 =?us-ascii?Q?07hLzMkIuxyMyeuHpOa7Yd1ZIjJOn2xVdoDRxny4HKfVwLKixGy04okdTydO?=
 =?us-ascii?Q?OM8talLzUYYvuoCEadGmHXVkJ3oA5RV/A0NgX1iZzuWyy63KyRkUHMtSUpP3?=
 =?us-ascii?Q?pj4XMj5+6m8a8YKIU2lBSKkq5WQdMae9aMpnrksVLnf1X+jvMvNP3Rk5WYte?=
 =?us-ascii?Q?ojYMM2CM1fMbZqzrB4dqwrfj9L8b2UvgFNpLk55OKVYH6RZpJ4BiP/vwWzyK?=
 =?us-ascii?Q?6spJC89GeRzz8EFpWwpS4YTxr+09A9VBPO+2OGDwhWzYrVZsBrTxo3z++IFE?=
 =?us-ascii?Q?BmdoEbXZlpoJwgeYaRHXJVabpqM2kwiJFC8cmnDKElkQ6zsU6mUyDXhD1w/P?=
 =?us-ascii?Q?Zk2iMlruiR7clsLooA6BmoNhraRmSmEujHV5+khwOfyZdlh67d2IKNLLBvfK?=
 =?us-ascii?Q?WVwHqb0oOneW7QPqpxgthqIxnXvYp68Dyq2KLQiTXxHjr4t/pDpQtbIjd06z?=
 =?us-ascii?Q?aHJylblcdVWIESTc2tbmTrDyQjngyJAe7uAH0ZMBMnXLqg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ouh/4XzWM8Z1iwKZ0heqy0kxoPUWo/FuG6eTLtAmKfbqLm7O2Eqm0pJiOlx1?=
 =?us-ascii?Q?vMcVSOXAIziW8Rh0viUsk0U1P6HpKGKeu1bYIRM6Z3140USc80O9kHE4jnO0?=
 =?us-ascii?Q?rGfaphQvJIra09Dj7uMoV2Zfw1ejyRVfLW1K2XBOe9kTC89R2NFJU6eFYq6m?=
 =?us-ascii?Q?7Lt/kJBE8W67QqApI7MuscvMDELduDPEs3ySXC4u9vrrSWufq9uJvEp7EEkJ?=
 =?us-ascii?Q?P6ewzHljF8hthWviETWmf6Vzhl+oL/ia1daTvMqDH3psN02JeMIkfPNLBCq/?=
 =?us-ascii?Q?lUKa+xSnM/8GswtXo3+IcJsH2hcYg6tU9RzOaG67O44mzjzGQafUGkS6kqiv?=
 =?us-ascii?Q?bnoJB2ZWWakmB/43X0+vHIR3Nvv5JcNPUvlDP00I7/Dh2by4bSpS+GaYo9gu?=
 =?us-ascii?Q?Gu2py79Lk9WZ6VsCB9B9PRs30hW3F3n8F5NA1Z1k6vKl1Pfm/Q+ZlkGcF53G?=
 =?us-ascii?Q?OCmOscgM1aao59Sm4pIhueQE50zT5IOB5z7Uy25k3rdQd4m4fnTLlwehfr2b?=
 =?us-ascii?Q?d0wcaHNkB4iSaLdBBxp0P4H7ZmCX0t2SeYNY0Kmx893yP5eTZBI9L/XxrpRH?=
 =?us-ascii?Q?xl2ETTU55kl1wESdWErcp7zbqAHj9IO9kYD3rJUGQYJzNhhBP/ayg6kt/Pjv?=
 =?us-ascii?Q?ezw6IPanhOXEcCuiDm+H5A27R07S2pBJ0lbWMMFygx9Cm5TotmxNnvZbuEkE?=
 =?us-ascii?Q?ps73Tzm2lA8WFwDK1WtCvf4Qa1NccsRcdt82UBWadHeR8a6Uquj15haTYgnu?=
 =?us-ascii?Q?SFOfs494cgePLiJpz6TrhSCDDuw7nHXWJmQQO08dLlo6xOkoRo1Fyv/Ls8Xh?=
 =?us-ascii?Q?x+s7DGcCT3GR7Hmh2XNDdly8MV679Hpumh71NC5dEgNqnt1eqAJca/NAXHY8?=
 =?us-ascii?Q?EDaTBamQt8l31ZcaO30kkskEKuXnVlZPtaogNanOF/FushpmRjknhgMFh6/U?=
 =?us-ascii?Q?woj9V3DPwtU1s6T7bcWsf4bcPZLbKQlL6khV7zmdKY/T6gShmNC7F2kbjerV?=
 =?us-ascii?Q?KxJI7ilpeMlsGms4TGA8c9iM3l0wGzn6tUHFcLzi8Yhp8lXbW9PvpbK0OY/M?=
 =?us-ascii?Q?bil4ra1ph1VsvWJlYEKqipeZAo+HPq9iyLHABi7WSIZ1alYMI55JdXcjCKo/?=
 =?us-ascii?Q?ohJT5q1Z4hloTT4oTFCuoVNapzeg5jDhTNVVyK9xZmlyPfV09Pu9ZV7E7ccY?=
 =?us-ascii?Q?emEXqe8jvGZ2Lj7WAMp8z3dShIVLeXiBpCXY9KOJF5cQrL3sHwT9sbh43CG/?=
 =?us-ascii?Q?S2EUTGR5L/SDtYqpdjYYvO+j6tKfOOLmVjK8lrtem9HXSHmfVgPN+gJj/Dsu?=
 =?us-ascii?Q?B28QvUykcfyUF/+T1oZUC3hZ2SuoMdtb1p8M2OL74keYqdF4dKx5h0l0dPpM?=
 =?us-ascii?Q?zaye1JRQnTxm080mgYTaChSr8NXJobTul2UsDTqt8xpL8bN/TkOWw1xw0bzY?=
 =?us-ascii?Q?U9gUa3zayK/C+pWwRGvlsLdxSypmZV0CObhN5Jvi7x8OvZRBJqsABEaWqEH7?=
 =?us-ascii?Q?5YPO9Z+mdZWpV1+WMik8DHezt/9Xd72YkDbyjT3XajQihw+yijyio+ZVmDqf?=
 =?us-ascii?Q?+R2C4504s8KAq4sO3v9zhwUlAP88J8jwBCyogJHq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f278def-4c89-41ae-99cb-08dcde6276d5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 19:36:06.3085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +yg9aohfjdwv3QxKl8xVcFnPseF30A25vhBqpZ+bma13e9VTtb9AEmt7YtCxtssL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6379

On Thu, Sep 12, 2024 at 06:17:29AM -0700, Yi Liu wrote:
> @@ -1242,6 +1245,28 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
>  	if (device_iommu_capable(idev->dev, IOMMU_CAP_DIRTY_TRACKING))
>  		cmd->out_capabilities |= IOMMU_HW_CAP_DIRTY_TRACKING;
>  
> +	cmd->out_max_pasid_log2 = 0;
> +
> +	if (dev_is_pci(idev->dev)) {
> +		struct pci_dev *pdev = to_pci_dev(idev->dev);
> +		int ctrl;
> +
> +		if (pdev->is_virtfn)
> +			pdev = pci_physfn(pdev);

Don't we do this twice now?

Let's just keep it in the pci core?

It looks Ok otherwise

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

