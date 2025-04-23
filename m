Return-Path: <linux-kselftest+bounces-31399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2381FA98AA4
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9AD1887A83
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 13:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7312014B965;
	Wed, 23 Apr 2025 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UO98R19W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45B2134AC;
	Wed, 23 Apr 2025 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745414188; cv=fail; b=FCMbvohga01c+8EQAsVQAWrMgO9BFz6HM97wR+qwagb6OE3ZiyHtxNYIhxycmbN5694QZDotOXTTC/VqqiVX5c1cNUu09LOuWrGtk46eIU1FUTNp2HQKnPn68igmicNtxbGd2iGiYKa88KyiJ879SjzW4RhuoCFYDwgBTTwj0qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745414188; c=relaxed/simple;
	bh=iUWb0nbfWZOeUnX8omSJOZdyPceQuKz0I2pxuj7JRHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RJ36KIJo9ViBd8a+ujLDviY3+ieOqp/xvndkURpMyntHhGBudo87vsvrCSnDTmtWsxLTCn+LWpL2/EcJK4uXli1tfM+OrnJaa206OUQfkooH4toBWQPVuxhpG/MsafbQB+KKw1gJMsyz7Yhlh+spL1TLOkmYUCcvki2O1MgMKsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UO98R19W; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxsxR500xCvtispEuXd6eo1/HKWYJ2anXucaWkaI5KpFCMlghJlHNpOVsW260x6RZjGrNYljp7cXQUYI+rnwIHY0Wa6c1QQDe0GoUF8Wo4fbkr1rwyh+SEgs/iAGgbDtueVuMUiM4cut/zs1EW/Ns6b9Nnv40jElxrUr57nIBzfM8MbYK0QFeJyeCYRloGYL5hjYk+0fSso863mWda9oCPI70Q+MdxPzKNxiexBeEr8r5Ir9ZLHFfg5VTlfTJQQCpsB3vWEa8Nke3CKRg64mtkcwTliJ3ZU55am+GiEzm3FvnGv36ZZ/UP+ilNzm+nYKOCzpjx83xKGhVr+rJzqC6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Y2fSQcVYLdj+7T1ONy8x8RJbGIKm9Bspk2XynkDN60=;
 b=V6ceAOZsphP9xcYhTFJ9jQsaSk8tpiOOY7DSfpwo657FAkohcBPu1eahDPRG4k5KDL9CdXi/YEU6k0S25OP1wqPHjNGrhEIbNqDOnJS0GZsCxOjd/VP4YUd1Vhm8bazOywvM9tFkuGjWokiQ4qUkrjcE11fbjEC25QRR09Q+stECStXTDgI3gbfmu2J1dTCBl2fyWgvY0Hb85x5521dc3qUM2z3f+MW7YdQCeYi87hCZ2R7Ao+HHwFmoUdl+DkXtyDdTgsDAsPrnC3yj/lGMkbf3c4Bz6w3VAPw0hAKDjBbQUJgUMGeB8mj4yY3r8iWpYD2Xjob2REswqd0ViZTMaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Y2fSQcVYLdj+7T1ONy8x8RJbGIKm9Bspk2XynkDN60=;
 b=UO98R19WKegRaekNJ3p4L0zS1sLFibsYJGeDpAh4B4nVWfDt99ruH3Jb1oMv+4Iy5mopOlX6VkhadSd6Tpo26wi4ubqSKm4z9jWzzyvi2xchaKcmZWK/OQXTaXc55blHmE9PFRM5GKZDUmRNiEeCwaB0DJhvRCNevwJX/a1Sb2hEgiecqb8pfZ3srIAHyNo5W7ICH9U7EpR6CvO3AyYXKIpu3HQQ1OT8ys7ayHU9rBhHpqFmfAceNT6DMfJB38CLGDMZsQqnJGe46zMvtyA5hyBTqTtDEkfxqb6mlUGZ5X0NQeXyFRcsXEzF+qvefHm+hUfR7xiawVMnHrrA7vqYJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN6PR12MB8513.namprd12.prod.outlook.com (2603:10b6:208:472::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Wed, 23 Apr
 2025 13:16:24 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8632.030; Wed, 23 Apr 2025
 13:16:24 +0000
Date: Wed, 23 Apr 2025 10:16:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	praan@google.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, jsnitsel@redhat.com, mshavit@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 01/16] iommu: Pass in a driver-level user data
 structure to viommu_alloc op
Message-ID: <20250423131622.GF1648741@nvidia.com>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <4613641ff3f67b73eaf1074d5bf9b066014a7813.1744353300.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4613641ff3f67b73eaf1074d5bf9b066014a7813.1744353300.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0329.namprd03.prod.outlook.com
 (2603:10b6:408:112::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN6PR12MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 94cdbfae-26d3-45f8-221e-08dd82690bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YWBdddBCkVX6jX31V3D6lNrxDatIH9J5Meqr9d0JdX/0VC8R0T6qCs6jHJ0X?=
 =?us-ascii?Q?J2hjLrwPiqn8gwwDrQc10U0z/KdOZj7EvWGWaYjw/lLf3V1KmneFl9kIOEvq?=
 =?us-ascii?Q?MnA4q+pCOX2qJ8M0eTQxJoHxXcBQk0B5PH7vIdEUh6kg164aK6kK7t0mdiXk?=
 =?us-ascii?Q?0HzHGqtPcN5sY1Ya3uHT+htJbwppIZKqD0rLifYDWyc09Yk+ZH2fmoUAJVuu?=
 =?us-ascii?Q?iZpDeHhQAHNMo2HbNrwwYdBBiTZeagemCunnXAYLbrB5unOn5nrEUpiQW1o7?=
 =?us-ascii?Q?p77jWwVC/yh3u361bMZZF9iPBwUXaRyGYS4+vVZstm/DWICIrJOcl3m/bQ43?=
 =?us-ascii?Q?ekTBEM4XZhPDcF1MCNZIHe6YcED2HxsW9LE6qeWlDsxLg9eoGy7EnaUuVGLc?=
 =?us-ascii?Q?9XndRpnGQOLDNtX/9/6RR2E8iagKf6woNNtHXjky/14KyMxEai5WBeOYIWh2?=
 =?us-ascii?Q?5uUmXYHzzMkus7K783I+b3yVcwQE0rDCMbSU3HoDJPcRgMt0bSY6Bz9W1W8H?=
 =?us-ascii?Q?ZTrCrBdF6AmX+bvXlAS2I6ab81dDV7u55qXT+1hK+I0dgoL+iN+Q8KE7kU0Y?=
 =?us-ascii?Q?Pqr3OPnY1Tbycw2skWNHe9d6K5RBXwuKOKacaG9khfDVaApilW4PFOX/DU3W?=
 =?us-ascii?Q?CKVQWnqFnG/OivpOEYzVF5yDTZA/IVk6hmyXaDheLxEFlcrFIrcwEGwaZb7S?=
 =?us-ascii?Q?NxnzQmyeb/1QRV1Nmr6tqKKvYG2AXNqrKd+rQc3dBjS/Uqd4BRad1kIzBd8x?=
 =?us-ascii?Q?d2KVxjL0oVwcEIArs1ELmMzownip6ZCOQIoIf99QttRy4eSdsoJonmqdLpDx?=
 =?us-ascii?Q?IoG91HAM68xtCAEEychLYycTql3nCfrc5RCMbPjs6xKrSOBMgjM+5ReUYyEG?=
 =?us-ascii?Q?6ylxNX/GKbe7MJoI68kMk69C2oYE2LxLvm4rhFp5EcjGCMMcIZ4S13/ZvZMc?=
 =?us-ascii?Q?B6v/HGrHQ7onI9XxfQDTS/swKEW5hqp0YbaqiRY/hUuehkEKggpNgZKLhqRl?=
 =?us-ascii?Q?585dnF7Dk2r0YZ2jyE2xXxHZwynRlFXR/x3V0/lCMPsqBgn+4ArVUqeo+rR7?=
 =?us-ascii?Q?bI50W1u5yARSa5tf2ENTvH5rCRdtzLnj9X72ndXzdoIyTbuHb+SInb7Qmqns?=
 =?us-ascii?Q?H6tdd8ZBNS/F4IK7ZgYSFS3DMv8OzIfTcCfbGw/A/7rxSni2GZTuoA4/JNoy?=
 =?us-ascii?Q?QwQ1y0KX0eFRUb4wuzQ+mP5ewEsh1S8tRZtshvttL0meI/cMiju5UiSpdbV3?=
 =?us-ascii?Q?upqMpt8sVRBti34YzWxJcuIDFqS5D3ZeDWp0Su0Pb3ELWp8IkWJICYgro72n?=
 =?us-ascii?Q?sXoTT++9vtwHXUo7PkIprJwFMXfGszPRaoGHPNNEJlHNyfukF2Y4R34ELbs9?=
 =?us-ascii?Q?ARTkax/jxAkwVNhAQU7DRvsT6isO/LzOW47Xu5ADd7nK3ptZ8U2Ln6Nb4HBs?=
 =?us-ascii?Q?TG/zqgT5glw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cwpyBc4pFHmQFTL4+EN7C76nR32UzG4ykKclyydILNV7ZNPye58SOaUaLvec?=
 =?us-ascii?Q?fdoc97uVThIU+OxbctGOWcxFqvFh8xPSSMQAi7dj/gRGZk1ADtXSLC3AmCYN?=
 =?us-ascii?Q?erfJYajirfUVqnU5CKTLj2ZgF0JIjFUBN+aDJbl/d/o8e7JAmcK51TDf8Ncq?=
 =?us-ascii?Q?blUxM32sQTHzL4xetMhwYeJQycs53CzDVIf/EFGkmJaFKug8l/Hp29jS0xjv?=
 =?us-ascii?Q?5CAC7KaWbw0/5CX/F+3SqZrYhmUaZ+CxPothw/x6/Lp2rmEJjcdN0w7vQ+L0?=
 =?us-ascii?Q?xlqYkFgdXRmHZpKUqlw/lc3Xs1QlkCxHwyJeMSKRdva+UafCu2TxwPsOcI1r?=
 =?us-ascii?Q?FABP1KNZ4kSld5mmDcb2V4KKlRaHBdhjK5RWVfC3kTaOcxYLYzRwlDSE8kpp?=
 =?us-ascii?Q?stulsyXf7+HiD1x0lVKb0YOIM2zddIxYYoy6o7XAH+Phkl/BwXukVqrVHpjr?=
 =?us-ascii?Q?O7W/2mTbC24wk8X1XHsBicXP/5jM4mBGG3ecWYSW7T5BYJG1BNScmwWPzQiH?=
 =?us-ascii?Q?r3zxFFCgkrXb6fVcYFOv+ykIAYMp9gp9h8q8IyVfQVdCujMx3r//QSEIdG82?=
 =?us-ascii?Q?qD0Ot+toaRhSRhT8yJcA+7pKVKom4CNMzGqFRnsjhxIDrQqkYQbR7qAveSe9?=
 =?us-ascii?Q?2icVfIVlNzPWa4ll4BzRAlqATkRTaIZXF2sZBqyo0VI2pU/+nkfmQUlCfFXn?=
 =?us-ascii?Q?ifHy34nX6Vc55raq53oXs8e3iOXsgIwxUHAyfPQFPeUtUNSosnSLqHQaZ/aA?=
 =?us-ascii?Q?FnnGyimRXV+P/Bvi35K7TV4zn9KuI+FlZHxdwj8sAIPDG91+nJQ7zK8rW5bm?=
 =?us-ascii?Q?3l30pvl1ydtgIhsh6Mw1lmx7HYdNbKiqpCOaIzzLEJWMDA8pq3O3aXdaIxaz?=
 =?us-ascii?Q?OSmmqDBbOKrUruhVDPti5dwPFM3XeYwz+kjVeGJGcLAgJVbjh290HhuvGXVG?=
 =?us-ascii?Q?e/+RP2DGEUo0MUt1JoL3PETFVzWQkwzS32PQzCNwTs/f2PAxzTa+YPXNyVQk?=
 =?us-ascii?Q?RGAINw5lq6plY098nInM5cNjTjVyz0V1SOHcTnp3NbqBeYlwweAEgC8RGZ+r?=
 =?us-ascii?Q?Hvmhe3SOiOtEyUkfLKnpLJ/8e2FtmwqbSW2gUYLAro/obL0KK7d10Qb31p3k?=
 =?us-ascii?Q?giQjcMOOjcZ42FBKrE7WomRgYRBWsAuuiH6S5I2Ee3ehrljBiiaqjSNKw4fd?=
 =?us-ascii?Q?qnbRiDT+bUqPi0OuxwD+Su1mz+tkSaNN6v7pzqjGsWS7gmsKdMEuUC7hetQe?=
 =?us-ascii?Q?m6npUZ7vq128fdlDSXpmAm1nP+DXGlxrYrDVjidOAEvkbW5EFmB73KXPOaUT?=
 =?us-ascii?Q?+c7kuuuANjD7NOsEwY07wi7ywE3vkyxB3EIq3cFUuw3XR78eQh9De2bb/RQg?=
 =?us-ascii?Q?1zi1cmln4MzNzJ3OlPySZnw4VavhqtRRQCeS1g0IFbYIglSW3OfHfBoZ4Rn7?=
 =?us-ascii?Q?dB+LNj3y62bjtiw4j4TVSybYhsNV0hEUgJbgOCoil9V0bZNeYMShjSB8Qv87?=
 =?us-ascii?Q?ccDoxqSfH9EIRp3+Wvzz0h13x/gOkEPVjaRo5AHxrzd5ujfwEb9wwhCLF7Uz?=
 =?us-ascii?Q?1oejgb9MNpEMVxGsqlXW6lDnrQfvfztPYi6nKHat?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94cdbfae-26d3-45f8-221e-08dd82690bf6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 13:16:24.2900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQSEwWxJ2f5f+na5MyyqkExaGzET4/aVDsCHQjhd+km22IkmJLfFHUcQel2PvaDa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8513

On Thu, Apr 10, 2025 at 11:37:40PM -0700, Nicolin Chen wrote:
> The new type of vIOMMU for tegra241-cmdqv needs to pass in a driver-level
> data structure from user space via iommufd, so add a user_data to the op.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 3 ++-
>  include/linux/iommu.h                               | 3 ++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 3 ++-
>  drivers/iommu/iommufd/selftest.c                    | 8 ++++----
>  drivers/iommu/iommufd/viommu.c                      | 2 +-
>  5 files changed, 11 insertions(+), 8 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

