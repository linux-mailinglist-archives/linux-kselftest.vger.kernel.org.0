Return-Path: <linux-kselftest+bounces-31403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E2DA98B4A
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB53B1898830
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 13:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB58019E97B;
	Wed, 23 Apr 2025 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RCh/fp96"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCA861FFE;
	Wed, 23 Apr 2025 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745415409; cv=fail; b=IKl9mHh7Qgj/tb4CASRCY1ziRsLdow9c5c2hkseB831KEXd91bAbsmFkgG/sTNCpG1gdjhyZS6HpVRIwHckFU85Ng4w+tng51xdF2FFS6FA3XVXqWuoIKSNflWzpUzbWvsyiW2D3f1QLT9RNMy84lJguH1vfOhEqR1YwPZGEfnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745415409; c=relaxed/simple;
	bh=dfS6ecJVmaFSvquILfvvyEZ2tpxOUeIr41rMieHbtB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lz1oBNASujvx5sYJ4LS4IuFiiUGhlWSOhQ2AnvhDsl0tbjDEc48dUz49hYLKq2JPBWeHWHHgoGyb8SuyoAaDHx4T1KyBBXm4tLDGDG6ztKGb3wz6+Tet4F1BmvZUyvi+tUlD17NcvTkJlHecA+gNDrt8A4kACywar9oAjbZwoos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RCh/fp96; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H89jFd+7/v0ucFPYlSt5fMfzaAEwqybYIbXEu4Ffrrl+hfQGdwXttI/be/6EmCW+Olir3kQOwCuRGxN8EALu6z6cZSNCielnn7RG3AKLPHdxXSfGVfG1Os61v3VlR+jmbd02Tr9EbUxTz2KB5soNxocj9doA73pT/DQv6WmTy5vfOa4poON5V7sx2Nyk6Fw5YrHk7R0LZOX7XZNZqq33rWpykrJ48ZQ88KqKeEmvXpDXZT8NIQyX6qIcKm9zauO+oQeX0B+p6Ozh1uWHWjx53cdjb5ps5XVU0C+MRJGxoNa6W3KrHo8It7JqfKcL1r6btQLVX7flafQZb+LyrH3ZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LA42w+yHhG/N9SBSFh0xoUTy7kvdQ5E0SlnPprwMjzg=;
 b=bccckObYSdGKvKI3gKRNPU3uO5v991QW5sv8Oe0/0RGemNnL5Xk3oICbbWhOPKb9sgs12BVeDDoW5f1To6yVuxx2gDuLu5XK0Q24BGeJF7NQrwqVsFJitcaPsdISyuzE+3Uj3Wm4IcGw3wpypf0P66tZDaiqKbHqKPRjEvBNHDFeXIO+XsAX2OoVywAwkgGyVvLDZkdQQGQzBTIvRabTuORQzkKzEXe6j24nsnYlR6Uy2icN4s14GP4u5iniMu1J7Td2Wfr1zGstexaaRklMHIV5/DkfBXMtkGvKDo91H9RdB3aQe1GMYPg2iu0VwLBfW1IjiMNvv5kBu+CEO1t7mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LA42w+yHhG/N9SBSFh0xoUTy7kvdQ5E0SlnPprwMjzg=;
 b=RCh/fp96EemOC6Qs+GAi6R8J3D2VpsbEImfUtMkWpnv35JMkLqY6hZLDj4Fg4NirdIm+tS5EP9pGkg9vyUlIJEm0zb2y35NHudU9lMYh54wYfgHXkyBSKNvRR0gjI5h0hq1Os+Mdj5JAo7CbgT6pOAuKpqSMpWqsXneiu8c5bs9mp/wYe0yVsmZ14zMHaSH8mOLjOJpL2TFuRwA+sh0jEj2mVENA/KjRBdqrQ4O7i4X3vkRABpKtIpE5HQ3ptXwCdqHtMPTuoK710If64t5euXJhcourlKzNLPWKrfPzb60f0w/W4fbM/x8ehX6yMVzXTuDzfNIDATWMNGRoExB7/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.32; Wed, 23 Apr
 2025 13:36:44 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8632.030; Wed, 23 Apr 2025
 13:36:44 +0000
Date: Wed, 23 Apr 2025 10:36:42 -0300
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
Subject: Re: [PATCH v1 07/16] iommufd/viommu: Add driver-allocated vDEVICE
 support
Message-ID: <20250423133642.GJ1648741@nvidia.com>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <349fa2c4c291488bb5bae6e4a8bc0dcbd0c51fd4.1744353300.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <349fa2c4c291488bb5bae6e4a8bc0dcbd0c51fd4.1744353300.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR06CA0013.namprd06.prod.outlook.com
 (2603:10b6:208:23d::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: 1daedc14-1981-40bf-837b-08dd826be32b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qzwnfu1pMX5l62VHE4CSD0jg9KRl0dKXR+ounkwNdfzVhNHQnYHS/Ha7ZyJB?=
 =?us-ascii?Q?uSnkUhtZbAeXNUQDjc426RWkVW+pG7dsbAvH0TCrKvmxch3iRg4XLK/vA7TW?=
 =?us-ascii?Q?FalUYESNXZHsMLQFTa8jum6wSWGObXVWeel7iXv7V77klHmNmND32U8L/ule?=
 =?us-ascii?Q?2a7eHcCI+Or5UKUxgVXS2FJTr+BHI9f6hMP/hJlnTxzeQ7PbQQwwlOM06Jij?=
 =?us-ascii?Q?iqGMtdm/zm4eEHSMzRqdUkf+88a3hTbn7sO7hl+6V4y0gkz33Dym5hBHcUl1?=
 =?us-ascii?Q?IBIsVhQCxptFgGhiyd/errLl0D1rVod+hVi7Gvb3MDuRcdg3wVwSN2XCKeAU?=
 =?us-ascii?Q?wW7oqrEs5pctRlXaZBfJaE++Pz0VOzjmvPixBxu2qdDrMPG2va9iz6iUWYxw?=
 =?us-ascii?Q?OZMpok7u1nOgKvXaVtSP3o75/elSdF+ksQ4HJmY7Fa5epVCq+c8pOdrJEP7J?=
 =?us-ascii?Q?ZE330uBvpurISdFCHvLFMXtn/sS7ur3WWBp5G7amdd6g4z9LxBM+UP1xC3Bq?=
 =?us-ascii?Q?2oviji0z1zCB7wiNh+AsOiQ4XiI4yn5qu8UqVddo+y0MPpmxzkH20yw1hH1U?=
 =?us-ascii?Q?nHK+4v1JlxJ+7/G4pEOlL5Amx2dBDHmPG7sqn/DJTjsbfAea9UoAQbJBIbHI?=
 =?us-ascii?Q?CJg+6DyWw5OxGYtLs53yVYbtbtGONc07nJTatPi0LDyla+Lh9ibiX04rfLBc?=
 =?us-ascii?Q?inSogxScSf2XF+oehyqymnZxMmB2TA3XnbsBXIyMY5v2JOrzq2zOcRkVJWAO?=
 =?us-ascii?Q?2UEqpXHNoQ1w4U6pjmGfyVIb5ck8UPMsgbBpJYmKDYIPGduQtpgEsrQ8K9zt?=
 =?us-ascii?Q?PvBLTQYzwzMZXKwlbnqDxYzPXVm4oufd56Snf4nMW2yD1J0mDP2s2bwHPqgi?=
 =?us-ascii?Q?xy4LEqmawBrytGsLIO7v/fNbLwdhdPGG6tXkvNmoWSkk5qXMzUjuZoAlrM1v?=
 =?us-ascii?Q?jXfGr7ijWHaA201XW52NFEpODUh1vj57HvFPi0Vj1OGrPVNo+DHcD7PjWeyT?=
 =?us-ascii?Q?vqkWablyxKTytjo4opHZwTDqeW4PkeeGzYXf/C/Wlm+bFWBK+oEqGdsS1oCe?=
 =?us-ascii?Q?6lUtsf0PsMhknKzYaWuKvCgr6WZlLRgp2QHiTCJ8tKPKRHR/GWwnuu4wzUQZ?=
 =?us-ascii?Q?iQ+GYwZMFGs3+7aj8BxOYHFgT0m47t8ZtoKBexDDhcWtwcPMa3qmxvf3BGUe?=
 =?us-ascii?Q?YVAdOE/+1fgWFUzRtLda3hzT80LSDehKq6+bBWezL4i0OvN+/R5FJgx+C3m3?=
 =?us-ascii?Q?UgxEPR6/jnQL7CCegl8t5yBgoCKpMZnhvKUilg3rawmg1xDGN/qxm43CYMN6?=
 =?us-ascii?Q?3LNOgzusE37QapW04R5R8PWwIL1Bbb4G/7R1buNzYbxZkWLyTlfzxIpdCD6R?=
 =?us-ascii?Q?FvT1Va8ubUsDmGsXPp9mRX6bbWutV23AAfqSAqmL43cbOMEHYziW+u9C67Hk?=
 =?us-ascii?Q?QYFn/wT3emY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bPpouivx86895dS1oXoObRoPX1Kfj0D9n5FZuegsZr+56+ir0sTU6ZurmHZr?=
 =?us-ascii?Q?x9qMrMi09smvgUsNBewhby9FfNqKq5UAI2BXwAs25WJamAaP7JWdJOkJJaJW?=
 =?us-ascii?Q?5iLs2ob5l369mDTcVpzSoSP9SUFUwo9KRhHs8X2V4l2WhcBVpewIzqAfxaUe?=
 =?us-ascii?Q?2mqFAZU5TOXMc7yo2qngc2CkkFTOqCzFumsCSuZ9wKPifTPcNx8qMFighcMd?=
 =?us-ascii?Q?d2T8t0RxqvY0YqblQMnyIAr3NvIgqRhKbw9wBFgxMXlllmVMBvL26mBQqPo0?=
 =?us-ascii?Q?R0KfZIyoQnpUlbZIGchKW2ZCl0DqTq93ME/2rF8IE64Tm3l7QFbLUthmIPho?=
 =?us-ascii?Q?JZNOTlbpG2JalomU0+l+EQn9WqQLf6MhsqwNbmweFaFB7mu3CcfkAu6bNnaT?=
 =?us-ascii?Q?gIDU4jhOEFYvxW1nQ5h1ImJ03HN1cih/Kq+32Zrb7I/1ry3Ejsd5B8Ns1CxC?=
 =?us-ascii?Q?I+7JXq8lPMhAmhAz7CYvSmFgMO7jzYXdD0hvi6WOBntivRBP9Yn+8V62jsKy?=
 =?us-ascii?Q?plc+s6P1/IIW3D24hjoF2KjYVJKUKkz2ATk8IYj4j0yDdz/k+lIo1ZYXmWAC?=
 =?us-ascii?Q?oyGWICFglsRFRBRUkCRGkUnTSVnqOrN051UlBtZlhywBK8KIeCs/MSt5msiA?=
 =?us-ascii?Q?UQXmBV55w6rR7/IbxhqQhY/Z5+qY2nMUXuLNRKk6IxdZ8p5d5uOrZHfOu+gz?=
 =?us-ascii?Q?3cu3PtzVvZZiZmN6arZrxi+Jwm3RbLfbj08lAtbalAGp5M4fjlFUMgaIpJDt?=
 =?us-ascii?Q?zzePWTYcKzknJW7w4C8xwJom5ZnCArHThMkCNP0eNUcmv9SYk/ReMfFP5smY?=
 =?us-ascii?Q?P14faXUO7pnUNNI1cPTBFVZp3l+p3sccPrptTpzsyhHRBCKOqIDrhs4Y/ANj?=
 =?us-ascii?Q?hZW6BQAqxDE3JBFz1EoMjtthBXXOIrTD7tbONLHzSLyCkqVj11CHIXBovSkQ?=
 =?us-ascii?Q?lpw/5qTxAfH5LQCTmhT6zmoNIphnS7cUoTUIJWhQF84UKRKexyvM2xzjJPAp?=
 =?us-ascii?Q?h5hZQdGxIESZOL/A7qfeX+UpKnWMJzPKoWBqgl32x+X18GbSnONKUAbHu1ci?=
 =?us-ascii?Q?MZQ06tmRVp61e6Wnw+TaZcC0mgowIidMxN2JHsj3l1NDAlGpGFa8lZjmewjc?=
 =?us-ascii?Q?T0v9Fjvt9ogCNo2DNugSl0ategTZubnfctW4MhR8reNK/YBBaLG7+qaKLDva?=
 =?us-ascii?Q?BzJwondX8wrs6dXvCaZtyxITSDMMDvOPIGUx/i7iHAsDClDjM+aspgbwcNOt?=
 =?us-ascii?Q?F4XAyN5k/RS6kjEXZvX70bgbnS3ucedgKI1TEkDd8wD6yu604eoecVBtSMq3?=
 =?us-ascii?Q?vrOA91KW01kevTv3ydqiZ38uWS9X7srMrQTBBGx/sw9ATNxkNEBHoUbfCr7y?=
 =?us-ascii?Q?skopzbTk+Q9yjtaXHkDH/JChMxOH0UJvk+fGtOSp6IjYPWMsQybpX766VRa6?=
 =?us-ascii?Q?C8MuZFzv8ydV6Ap4XO5nt6Y0G3YypHbceBiMga3WSMbOIA0U0VDOiEr9RjrV?=
 =?us-ascii?Q?/NGvAHPGs4XPxNqJzGZcDwXrLZoIGvTE6uCjG9QerbtWBwBtvArhocNumLZf?=
 =?us-ascii?Q?Df61mCR17A3Dkm9U9huLXCBYdGvmwNaaU20kdU5t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1daedc14-1981-40bf-837b-08dd826be32b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 13:36:44.3273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rE2pWdula24v0KVPyIZJj/W/di/L+KnwZN3WMgquQ5wyokFosNToEASL0VMUJMKn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5761

On Thu, Apr 10, 2025 at 11:37:46PM -0700, Nicolin Chen wrote:
> To allow IOMMU drivers to allocate own vDEVICE structures, move the struct
> iommufd_vdevice to the public header and provide a pair of viommu ops.
> 
> The iommufd_vdevice_alloc_ioctl will prioritize the callback function from
> the viommu ops, i.e. a driver-allocated vDEVICE.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h |  8 -------
>  include/linux/iommufd.h                 | 32 +++++++++++++++++++++++++
>  drivers/iommu/iommufd/viommu.c          |  9 ++++++-
>  3 files changed, 40 insertions(+), 9 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

