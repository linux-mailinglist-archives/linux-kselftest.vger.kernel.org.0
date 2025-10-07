Return-Path: <linux-kselftest+bounces-42829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63895BC1715
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 15:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3723C1058
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 13:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9688C2DFF19;
	Tue,  7 Oct 2025 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ask35H1x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B78221FA0;
	Tue,  7 Oct 2025 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759842736; cv=fail; b=WDlDbHJENNJfM63Ycdv7soWwA5S4aRZ6YzxGH/1UNOfDR9UZ0JBrG7AcXWY3ajj6TrtZ3o90T5LWUmZAB50gCav9LUG4dmAGgJAcptuXbaBjYoOp6FEr+W7LC3y9+jz117xUjexq3JJyRnoVQ/jz3l7Qh93tRi5NcDr0i+Ra5c8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759842736; c=relaxed/simple;
	bh=WEL/QLIiGHNg1IoBiWSWXKxVrMXbXqimFAlz8Tg0zho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KRgdPUsVIRmg9OJlt7MqSXXZzGyaNBL+CZuJOQaWUa0kysgV//WXtaigJ2helA311mEttE5tpbOTiLfb5QaBuEOvnuQ0K4nLIgb+JdfxYbYSNqgKWPdk/Q0Yq24hgZ4V3y05TGjmXGtd2AOeAMjvNYi/psNmOEfowGtYEvnIOvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ask35H1x; arc=fail smtp.client-ip=52.101.43.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjLwL8bDRg6/Ahfq0+zhpGiPn0qCeYf0K7pw0YpogVamXv5st5sPpTYXqt6YCXkPrfpdJkwUhK9QpyqJWbLe3fXbx4zIKxmL7MAeAUVBAUC+N5QOaD1f6du18jjinFeRCMy4rRBy/W8T61YCjhGOdg5dAHe7jFLNnzhw34Qc2PtYczH/qYZ15Vb32+uG39qdUkIVJh6FwS0+0T+TIaBmSXFeLpPws1DO/MEyep7HXYyUJnHLLNCEIJd9IwnVPUCUvEkGmvZPVy0BVXUaCXDPfaqJH7xBAcQ/0b3jB52rxz/eaVjSfXAmO+obmI6+sT87AUDwbAw3WjFoLMm6s0Apxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Sxr92tZ+LdSpi2+aQ96YXiqKgHUvqsRdrh+UUdMhDc=;
 b=h+6bkWfFMqAAx2Thg7dipj4ws69Hl8UJfoZqzKiFKudai6OyXiHgFBx2CUdHR3C1iXelQcmxR9ZKGPzztsjRWdH/yy10ZpTB5+P+DOU3KyVEMh8uQE7Gl2EwUoDD/gWgBr1HbRvn2rR3Fb6PbZOOWC4DsVeQ7vXoUXvbHPOsT0NYSct07FvJuYn6IXHAITWfuY5ju06+1F8a61+FjpDwYz5TLqy5yxeudAP26eZ5+nAPeFHh6DuJHQCV33aDJ4N6wp0XVrE0CXm2ievJwwVHb9M/rv0PyOYe3CKbLoDGZq8fj0nBOhhwrcpie3wG1yx32w7SiuAzxjD59dUwBbUWnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Sxr92tZ+LdSpi2+aQ96YXiqKgHUvqsRdrh+UUdMhDc=;
 b=ask35H1xWdytIsZegSRkyQzAMFV80Zj0nbzaEAdWRgdmueGeJivhsyYWw7XOzNDFL8rh5xeUf9gtc7Z4wmjwqJod1J2iTHo5ow0dERsgj8XoU92UGifIe4qfTW37mJVFiZ0IbNSSG9U2XQ0Xe1is80NWJVwwE7S+vHKrMihv0znNOthNihJAk68TBHiE7SHFS6V7kLG6eYc7GhlHstc27KgYOrobyvVwvng/ioouRo5Ws//6CTPwktfxwBdHVSeAs+FolpeSEf3xaTTzXFQsP1TYxhkDgcqY0LDikjCeOePVmJIxRB2D1icbRqM2hCfEkf10HW4LjGOOvi8S3FdBBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BL1PR12MB5875.namprd12.prod.outlook.com (2603:10b6:208:397::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 13:12:01 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 13:12:01 +0000
Date: Tue, 7 Oct 2025 10:11:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [PATCH v5 07/15] iommupt: Add map_pages op
Message-ID: <20251007131159.GA3474167@nvidia.com>
References: <7-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <b9b18a03-63a2-4065-a27e-d92dd5c860bc@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9b18a03-63a2-4065-a27e-d92dd5c860bc@amd.com>
X-ClientProxiedBy: BN9PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:408:f8::24) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BL1PR12MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: 818b454d-395e-48e9-2ebb-08de05a31a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q849kdCbOlNqCzMGdAWPt2fCNXuSON6rz9NbaRe9iD+1c5bLvIZ/ibZJuJ4Q?=
 =?us-ascii?Q?LmnHt15VOq9fgB+L1wrDiG0FZznhu/lsWv/iDf26oi9zS9LYfBWfcjqzKGUQ?=
 =?us-ascii?Q?joYenEd4C/pDrmy5obPeLy1P4EX3f2qsMqtkNyNrTCrv7njZEyfCNsjkwi40?=
 =?us-ascii?Q?29tgrxHWNrmbOTRcsEap468BZI1dDwdc32tIhOCo+jOCy8zomEDhf3SZSqRS?=
 =?us-ascii?Q?sWMm+SiwFxQoR8AQNST2+YUtDxKAcivlIar/XO2ZAZFEM7h7RytjRF6nyTaa?=
 =?us-ascii?Q?X2H5xLx2xkQBiLqy9DjrcWESOpeVhMAI8GWN9GGDjhVQmY1gBNg82Xr+QiFB?=
 =?us-ascii?Q?UGfoEmVfid51xp4YdrbyCMAUI0EJs7aXoOTw5pWrcfJ5YM6//OPIJqIseFRg?=
 =?us-ascii?Q?93aNt1/A3VvHrlaKQwxWY4nW4QS9UdwIGTZC1QSmEvrCW3/zcM+8i48yvdVl?=
 =?us-ascii?Q?rWwiFEgO1YT6vlIQTiiz9Jyd5pwev78ld1XF3lfbLRiGGAUcEewawe5qTrxC?=
 =?us-ascii?Q?x+6ijW3qfN21X2c230cVOtAHsB8N9hMK24r8+u8zK9PgVFP+c34khlcAxuiB?=
 =?us-ascii?Q?p2pBpKQgs4esVxOHDF2rVfazDmMoRuhsXUmjX4IBARwQtC7UfVQEVaSgiFnK?=
 =?us-ascii?Q?uCB8D5t3+2hJL1JQmTUBeonIm4HTgHRG3xgA03dILIfDC0SUP7p1LHTk/tpi?=
 =?us-ascii?Q?XqLg9tqcDrqzP+S+2A/x03amW/I4hUbKfsb1+n2/utYSnBxuKgIqF12Q6j1C?=
 =?us-ascii?Q?pxU0QEzhvo1LWUeL2WRdq5SxK4DS5tdg+MpiiRx+HRVyz6VPsvxIfT7MV+UJ?=
 =?us-ascii?Q?LIjDEmPbcqbLNzptvvbe4O4r4lg/o0mAXcNVXQ//JQT4vJGm92odqbiYNMQa?=
 =?us-ascii?Q?i6Ng0rWq7vh33sWMJtJWtX3kOMF2rYUkSA2VFtV0FIsy+X0FjvXp4m8paw2y?=
 =?us-ascii?Q?qG9+Ju3XLpnWmKN6XBr4b9nN+7XGMTKCI5BnLLCwM5e6nkD3a6oAYTEv41qI?=
 =?us-ascii?Q?KyO4VUX0qvhTpSFHDJUzxYC+e0PfYKDqznRDiELmoG83IB7GVqieroVA+lHd?=
 =?us-ascii?Q?M/X+0hDtD9xqDfP0oMUvHEqfWB6VUPaA2wZWs1EYG56RZ444qi38tNFCs7OV?=
 =?us-ascii?Q?1erYR1LKhGwDeL2QVW89+sJmkm+cl6zUE/WP2kB2jh/kIazOsppmcTPJwtkM?=
 =?us-ascii?Q?FphiJ7Fuz0o3tiOFc7ZhvOI9fYfuNFX9dmxLuX1MhKbMdjZ7COCzu3WhIvF8?=
 =?us-ascii?Q?ku4m49mPz05Sq+GXP0k4H3Ml2IpTCGM/3o9d4LqCyhCOGHwhbiRsT9bmnDXh?=
 =?us-ascii?Q?LouGbXhN/ZMbChY3SAnqIMc92PXKwqzVgGB0tyyCWZECDT0FoWhZuqcveOwq?=
 =?us-ascii?Q?5MwfgSqbcyJSm85AcExuqlACTjvnYSyWT94HzO7WAGLcQ2VzUab6i8rtbt6T?=
 =?us-ascii?Q?RTBNYSL8QEhgi7KFwJzITXhffq6xYghM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ssAjosQhKuRYQSFfS/BtmxSbXY7IfEP+LL3IbwI7mmJJ1APO3zni9Dt0aq9i?=
 =?us-ascii?Q?wfhYj4paxXGbWk95VPE99MsmBz4RDiikoYSLNbgFTAX7IifYuhcp1v/hreRl?=
 =?us-ascii?Q?mtVbMR42N9bdWEpNscM4MmmvGDAi1JlYqqL7wOA6IUwVqRWJeDQN6cnZSqg1?=
 =?us-ascii?Q?nk0KqwZA09BTy89FA6I8BuD5zkQrgtlw3LQzfKSWi+UlRaE3BhNgRpZ9IrcK?=
 =?us-ascii?Q?zrMpQGB4Yxx/8C8quvUHJapA5GXtfnEj2pj6ViDwu4wZnwms3lPxug+Pwh7D?=
 =?us-ascii?Q?nKLx662o0Es3/VXv2ky0oe+DyArwPsSa5JqiS4sp1PrVFeJp+vyk8IHqeAwR?=
 =?us-ascii?Q?LjfjMxHm+JeGFegersqNfnbR7iAwBNJni1F4zEQL308Xz7Whghn0DkPY7RzJ?=
 =?us-ascii?Q?CS25vknJhoSVwX1gWGNaWLOIp0o1eRBOCV/G5jzc0aMY04RKaqccixe5m7zm?=
 =?us-ascii?Q?VTzTZSyVOkpfaM09n/c+a+YJ+TdtE0/gJz1U1SlIt+Lsfj2uT4de12j0aP/g?=
 =?us-ascii?Q?Vv2qCyjR7BOO43sOt7sWyH9ysB4YGfT6sysxYxqlXpSJKcYhIAK2ZiyG/6Rx?=
 =?us-ascii?Q?3rElXEWh77oj9Aacf7xvTQUHUxZuOOTGoY0GAdOhWdMs/wQqloJ8qzb/N2AW?=
 =?us-ascii?Q?INo1M1NICzMpOTMMoAXiFSLJ6nGy5A/8ntIUxVogTLFHLofy7aGzWy3UUDw2?=
 =?us-ascii?Q?GvCYnAUB13HmNQHNlAGD+W4kfaXG8ubmH/CZB8YokhIbbwL26BGkr0jgCSp7?=
 =?us-ascii?Q?TdVyMlbb2YD+N40+NnFEA5ASftL3otnKBDU3ys0nTXvLujCRuW/cc+NHORUW?=
 =?us-ascii?Q?MCqxGjiNmQAXl9VncPHvP6F1HOOoVtjdVVAQEUZHe7MBRTC0rDKv4Y1KVeBk?=
 =?us-ascii?Q?VEbaMO9H5VqqZZKeLUxGTN/FXDPs2OpSSW+zBl/Z/3+7gogZQt2YkqsNUetR?=
 =?us-ascii?Q?m8CnzbxwjA4AeHInWvmBapT+qjyKAooJG67oJeDzc6TmDS1Z2vWiyrUqyOUp?=
 =?us-ascii?Q?bLBWE/B0RC889geiM4MqbZU2x6zXq0G0WqkHpMBt9NAX/UtxmvERjKkIPwjc?=
 =?us-ascii?Q?COhmVmid9/g3orr+wzVIidbyRwBcgXBJo0kMuU4w4xIOYWkxu7fCyWjwAXNf?=
 =?us-ascii?Q?vAYtqpmDOkitwfjJyvIoIl/lU4SEG6ua5VlgNrztoJej8rVTyjZ5RdA+3E/8?=
 =?us-ascii?Q?6dsWbzWZYDSCrlQGAkuLoiYCH/LC4DPDO8wN5k7PeOfe+wsu9tRqgr+FkWTn?=
 =?us-ascii?Q?s/iXp5Xf1E7tNKr1P6U3sTxnnSaOtQJJz3kO+MYh8SAFDmKNAD2+WXzcJwJ6?=
 =?us-ascii?Q?ugJOpg2q7L/kbm94un0Ue6t2IRKLmp6xKOVpY8YpVewTidSgZ3cYn8VI6CXQ?=
 =?us-ascii?Q?go/v91XeO15jmxMArvsLj1tdMaDFLTZy4s+NsBY6gGV7hhp5mAOzJbb4cMuQ?=
 =?us-ascii?Q?3/Qne+m3OqF4NjzaAUpb9Lsil72Jv5MBSV3mdoBMFaV96BXm4lg9BcooJWFb?=
 =?us-ascii?Q?yMnIGcv1uKVZ3nlsnrGbXmRZrjqnHxuJsGeTWXbwwzosA4u2pp/MWayXppC6?=
 =?us-ascii?Q?/igs8SKlOqR3ru6PRsQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818b454d-395e-48e9-2ebb-08de05a31a2c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 13:12:01.3276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0sIHIGUJFRQ4eVjo8r1mkkpdOGW6GuOXYmEg7CoGp8giuj8ZlceK82SYZoWRV2I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5875

On Tue, Oct 07, 2025 at 05:38:48PM +0530, Vasant Hegde wrote:
> > +		PT_WARN_ON(compute_best_pgsize(&pts, oa) != leaf_pgsize_lg2);
> 
> 
> If I select CONFIG_DEBUG_GENERIC_PT=y and boot AMD system with V1 (Host page
> table), in some cases we hit this warning. Code path looks ok. may be silence
> these warning?
> 
> [   31.985383] pt_iommu_amdv1_map_pages : oa 0x208b95d000 va 0xfef80000 last_va 0xfef9ffff pgsz_lg 0xc pgsize 0x1000 pgcount 0x20
                                                       ^^^^
> [   31.985384] __map_range_leaf oa 0x208b95e000 va 0xfef80000 last_va 0xfef9ffff pgsize 0xd leaf_pgsize 0xc possible_sz 0x1ff000
                                             ^^^^

oa advanced but va didn't. It's a a little bug in the warning,
since it doesn't recompute the va each iteration.  I'm surprised the
random test didn't find it..

		if (IS_ENABLED(CONFIG_DEBUG_GENERIC_PT)) {
			pt_index_to_va(&pts);
			PT_WARN_ON(compute_best_pgsize(&pts, oa) !=
				   leaf_pgsize_lg2);
		}

Thanks,
Jason

