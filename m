Return-Path: <linux-kselftest+bounces-21226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F39079B7EA1
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 16:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA6828135E
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 15:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3521A4F09;
	Thu, 31 Oct 2024 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JyDAtXPm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6818013342F;
	Thu, 31 Oct 2024 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388984; cv=fail; b=X7D6jKSyQ7ut2ZkpqBbwVSU5YN6nui9l1jRStFcbRdgXCckVyxxOYcV4fsRilK196op2u2k6jm5FVU9pOUjoDpl5JdR2hjFqglvg+KJbQ3ZS6hHWBZizDDPd5BYWhUY8PRLS8/I0/kOsfFjTy4JBR1k7cphyTXz2bqFmawcF3BY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388984; c=relaxed/simple;
	bh=be/zyVVh7z+WapJlYvgvyiv0piF1lNoTKKw/4N9xHmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CDiSnDW+Mtr18gg5MnVlrb64kqlX7l3FXvsX0JZkWhqO04SWUjpis/DT/8d93GyKUmLxIZX6E5YSsBx2l0NEJqFlP4IMBiyjWgRIuer8VnmHcwyV6LlueHPRBR2lyHrLq+aBu53JI+IfrfCVYvnwdMF9RGzcKmHXNskM7bcX2Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JyDAtXPm; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSGA23L8WV0gR4N9BOQ4rb7tJIOR4v46Sh7R8RovZ/1YtSctEbjVuK18TSHv2Gb1jlrwzToE0r5tmJOszYJJLAhVPBS/VXFC6DYOHsVHEI4te9FG/4APxzNxwoQd3GP1lK4T6GZ8gFt2yuebwGNzR60OyBnxP+JIDhzGBCPJ4M1Zxzk5wMEyDgPFyxm4ShNAxyP+szrCqxzQEmujMk2xtNzSEB8EQilrD+Bd/d5+TN5X/6CtTWnTktS9DQaNg2W0kN/TRH4laE73tdVimcnKMoZLPMX4DgfiB693FnqI7B6P/GE7Wm0rIdAmHiyZHwgjslZBybGvlUZjuKCV6Z03IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bammT1znfA4CbFkG3dyL4W/1CYiUEJ09qxWKSODiU00=;
 b=HyuObp7k4KmW9EftAqXIrPwoe+/plZ4s1907/5ZJwGLy9Y4YT4UZ/v4CVrfuERekxelaifsYO5AS1o4f75slLipJxRQrPnKlFVj4fdiA6z1PS3jFa75L+CgSGnz1Nj5rohu0lVZagdYRHw//Uu3VLD6R6DNu9azbeUpTgfmVPX1fMlZxTdboZ6UNUenBiAS1wkBBF8lkJtk7UzlxOfHpErYAO2eJJJAJ8x+4BNxgpHgwAMO3rNp4ngWP9qx0ejnU1Tet5sPHQ5AvHVJ2uWhrWxHK87+ekSB8LeDMb6FFeFqrtqt6fybEIDAdF8Y5Ny65g2OvpKT4rJ+wVa7QrLjFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bammT1znfA4CbFkG3dyL4W/1CYiUEJ09qxWKSODiU00=;
 b=JyDAtXPmVIfASWL7ypMnFKkc9PetcPG0dlSlW1iGug40UpBCc6dyc5wgyGdb8fx4GKKzCdquSSXwiYWnOqkBOFzGfHAS0F6TIW9u4cHEAazQhI3f/Q7Shx6YaAN7KyRG//fulkzoA+koMLit7YlVd69a8WiSau3Uj1DhqvxNPjHdj9B00bXHdguFk+fcyahafDP8vuBPJnJZgGsFE1+T8R4HUNrhjudXiIWieVTfu0L21UJ4kvXVofwZoluUag+4qt0Vv2PNRVnDNEptnAef5zHv4rlvW+7kaUkgM1wpliOY8hBM9HMSa8tWvSs6foUdVERnkxTmnFKxpgOmq86Luw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 15:36:12 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Thu, 31 Oct 2024
 15:36:11 +0000
Date: Thu, 31 Oct 2024 12:36:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, dwmw2@infradead.org, shuah@kernel.org,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	baolu.lu@linux.intel.com, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v6 09/10] iommufd/selftest: Add vIOMMU coverage for
 IOMMU_HWPT_INVALIDATE ioctl
Message-ID: <20241031153610.GP10193@nvidia.com>
References: <cover.1730313494.git.nicolinc@nvidia.com>
 <45cf527206b368988f23afc045716406578c449a.1730313494.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45cf527206b368988f23afc045716406578c449a.1730313494.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN0PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:208:52f::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV8PR12MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: b364bf66-bbd2-4a1e-aaca-08dcf9c1bf83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N0VZiFQV5Iiz5JBircsvoLShRtSEJCAVUiVnwXloUdFwfLSZbluEzXIVe38P?=
 =?us-ascii?Q?MqLMkTeStnqAJWlY5WevmOMzOFMnFvThqApBF3WWD1qFq9SKu+gTC7rPXguN?=
 =?us-ascii?Q?IXtQxY3rIRcWfNSQZPWVNpen7qCFSRtvWxWkFN2J3YdYZN9Nqwwf+ApvZnFB?=
 =?us-ascii?Q?BERlo1UUpXrt5S5FIDup+JgSrgxVluyrG41dHwxCvVToPGhBGodSm3pzgXrS?=
 =?us-ascii?Q?ilr5DL/l0P2jdkOEF1IadHKAy9dcsIW0bfLi6kYoVkCAk2tn8i5eKH2oW9hk?=
 =?us-ascii?Q?xEj6HWbs7UIFdomD3qNUx+A8+kYkrOshJM339OMMz0fDRjSNY0D2v9ik1D0c?=
 =?us-ascii?Q?2Zs+wBi0DsppVd2YkJX0RdjK59T3WsmfJuNgsAkmFkTAvOFSsc4b9AT61IMg?=
 =?us-ascii?Q?6h1LfhxkdelcAwONZ9Xx5UkmtiHA0kHg8VUFQTPH4x6bKIJsSAkTC1yT3Ae+?=
 =?us-ascii?Q?leaSUGpeswBjxzx8kKtIS9AKcb2CXgC9P26G54XMircwrgUfbbgm/XKoHlRI?=
 =?us-ascii?Q?ayuSvceE3ETpaApvcF15H+htQTDpd5qAnaqJUZNniMUbBhQFGllhHtWiwfcj?=
 =?us-ascii?Q?2cy071Mj8dACuODCJJ07qrqbWI8gCowET/fGIBFQ7/fOmuNiAonZeHlzv0op?=
 =?us-ascii?Q?eR/WW5KNgj/7ISwKTYeEeEZkai5oEBe+MLrQAiUJeGHgAFbgRiXqK5m1Y+4S?=
 =?us-ascii?Q?A0/o6U2hyoJSGyQr2Pou9UyWW3qLUYseav0g8B05N5TBLRbO5ToI36/Oxptb?=
 =?us-ascii?Q?mAu7lQfsHMap3BV2CukeMcK9Yy22MXpSeF2mqgD+ymNqGeiWcbLTuRRyhe1L?=
 =?us-ascii?Q?v7SX78zq3ZE+Ju0uJg9qxUgOf3fg09huEWWVpqRjOuk4NuSg8xw8EkATyxpX?=
 =?us-ascii?Q?mn/2dg/Ipseq3a2B6fQr8p9H/4sfepyeQv8Kmgdbad8J93cpo2BktmVuWcMy?=
 =?us-ascii?Q?Z9GzxX+roImaDkGwUpGGC0kk2bijab6E232Ju4I43iwLdyI1Zc8x5CWM1H7Z?=
 =?us-ascii?Q?xsGtS19asXsGtSbwf5XyBnPmolQVYqTqRroAbxvPb1aF2bekJWlr1xKcelHd?=
 =?us-ascii?Q?TJW2qqPgwK1ik0ill4nY8gJ3shRh744me9/ir83OvWz8dD+wH5pXdHKkUnFY?=
 =?us-ascii?Q?Sg6l259gu2yjfi0CkV5oThxTmN0EAszb9yBzJ30K80u13FefylkXKnmoWZKX?=
 =?us-ascii?Q?ULqZ8UhHLYA4EKoZMAdk1qzM1TN8za06xbpen6f1hxWl2tbgFT2gcjEzsCpM?=
 =?us-ascii?Q?pRzn+rezQpCboxfiEfHvadncQMpP9DsKq2Ktjw1w2dEQ4UQOP1/4c/WeBrde?=
 =?us-ascii?Q?gVg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z+sZTDZfjZzAg7TQ+RE8gHvaZeT1Kie7tfB8uMetlRtadoBepIJmqMbGalMw?=
 =?us-ascii?Q?TawaN0QR6jrWH/9Be9Zh2v9wFdl23tKwy6d7XZ7vO+KBgm7D9r1fMWpt/J+v?=
 =?us-ascii?Q?R7euNQqLJ5WstdDT7hHinhV/n273s/hS3OHaKxD/FGksLoOAjdLkHNE0JRev?=
 =?us-ascii?Q?RyFD1MDlBgddhaLtwiaSv/pUgKE4LPHZc4zZsWH+Pi9eRbNSJpBL1psMnVwX?=
 =?us-ascii?Q?6U6fLCtz7qj4o1AfVxIyvxBnm1fEQCFNkmLY+5Xj+ConDdeHHbW3OtvFOV+8?=
 =?us-ascii?Q?BkfHCqga8mjHg2Y+dV5I2O5Cw1Xdhbwz4G4diapioHgndd9p20SABpWFCpdG?=
 =?us-ascii?Q?Gz45Li/7hm/Yw6QIjMUAlPGjxBeVkkeCqz/JJpiNxVv6fGkux4bga7kW2uqL?=
 =?us-ascii?Q?d5B3Z3G/ANbqss5WPjoZ1heDsbf6dqWqouuUV8ZPrcpm55OHdLU262u1wYs+?=
 =?us-ascii?Q?40zniiLw8iHNQisPHgVtmJVCceR2MnOrcgeI/z0ROU0m0eEV/3crEM9xh/DR?=
 =?us-ascii?Q?xJ2XXw5B7qxA5/+kvMcfvCaiCS+k7N2Sm0thim3s7hxOYRm7brpQRTipuEls?=
 =?us-ascii?Q?wqKFIivls1nSpLFewKUsW2ZFoSeC+R2I0NeGasPmSR6TuVqDg5MX+b8cjn2g?=
 =?us-ascii?Q?VtRYR9mrEBhsol9rXFwcJ5Pm1RVunVOmSRfmZzx0drmiKEIb7tbTxNVAuMTo?=
 =?us-ascii?Q?bvKFn8km7pgAvYy4TdlW+BB4UPGYmp9i+gbx2cV+1+i55QDNO0/PJ9wnI2Cs?=
 =?us-ascii?Q?HusyW93BMSnpFuaOLSDaNCvO2rVgElLBYNVpE6ZMdBvao0OIptZVl2vqife2?=
 =?us-ascii?Q?DxGKsLgrMYKA9F8sPo11thQjtvX9OEs2zzB0XblNT2h3n3RbPYYMhViC7XX0?=
 =?us-ascii?Q?oNtm4/Y2kKNWU/8RbjJPsBbZo/YsMk2wO2zCj1bEudK1ZlD1jMcPTPAo/Eqz?=
 =?us-ascii?Q?dIyigpG+uO484EhqFfrNEOyE96Oswp5PudtSSsvdaheJ+FK7KEfFkQBOO0vu?=
 =?us-ascii?Q?W331qnlqEKgWPM2Dz0HK41Kag2qYoRJ7c4wSyFK+7F6RjYKNPnt3MzJNjvbz?=
 =?us-ascii?Q?1PGqI1qmpOTLNKX1KF5UoyKwLSwVrg6dAbjMdPUnZ90pMmaEPoDVzHati8qF?=
 =?us-ascii?Q?hBig7j8VdSh/uBwCS6rHIo4U3cR0s8PcT3meTDqIsvMv2cUMS3nxvC2poo8l?=
 =?us-ascii?Q?Tgeaj6sGuSsGAJm8XKoVhlZAI3lXQ1WhqrghlXavLuicLzF3Ju+eAz5KMSFm?=
 =?us-ascii?Q?1lf7Mh0KgPvgTwZqZbCWr+k6RS3H0w0CaKWRk0C3hYvtLMCixI0hXW1SqswL?=
 =?us-ascii?Q?MndqK7BmDlaUU5cBwNejbDtmYQ3bieCPzlIttOWu+VzeKoWil1dtR26PdvAU?=
 =?us-ascii?Q?LPPWU+lpBekxwTl00X/s4SUPG6/5OHSEHG6KMbatyAT4PDgjdLqIZmNe5e2j?=
 =?us-ascii?Q?7IcSRC66Um7jVjTYfXeScsLeVwyUhFAdMZIkujdgrzg4CV/3Ig3hQtYH9tQC?=
 =?us-ascii?Q?sQtRrcJOEnwNAu//s1tY/C4kjMfwnBrAsMHXrL+7LGbCfJhczWBoypZ6+GpN?=
 =?us-ascii?Q?l5k9hwNBWYRt7kRuPok=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b364bf66-bbd2-4a1e-aaca-08dcf9c1bf83
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 15:36:11.8614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A9Ab9SnG9dGZv6cS79sexdg2gcZFwh/bNR13uFkefB88T9fO7D5R4BNUvTV9uzoi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084

On Wed, Oct 30, 2024 at 02:35:35PM -0700, Nicolin Chen wrote:
> Add a viommu_cache test function to cover vIOMMU invalidations using the
> updated IOMMU_HWPT_INVALIDATE ioctl, which now allows passing in a vIOMMU
> via its hwpt_id field.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  tools/testing/selftests/iommu/iommufd_utils.h |  32 ++++
>  tools/testing/selftests/iommu/iommufd.c       | 173 ++++++++++++++++++
>  2 files changed, 205 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

