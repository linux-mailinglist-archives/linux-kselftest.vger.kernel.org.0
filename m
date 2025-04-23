Return-Path: <linux-kselftest+bounces-31400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8628A98AA6
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66235A0328
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 13:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E27514B965;
	Wed, 23 Apr 2025 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cXZd1Dz8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852FA2940B;
	Wed, 23 Apr 2025 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745414201; cv=fail; b=TgIA5NjWHFEpS+9H38DYA1TDFQ2qUZMiAj2O/reJzOuyIlHoOzf59pLYR89qjyGzIdoSbcD8Tk0DCCbFVzo8p+4cIqv0HwxgZnxgRXaJDY6Iz0tNQ1gHhGWI88ASNJed9QetzbbkXU8TicXkH3NwuYbk22+xixMGpolFzwlZ9LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745414201; c=relaxed/simple;
	bh=cOf09rZwnlH4g+qyNn7JSUnHlzzNtquVKZ+yWL1eNZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bKcVVPfT3g+n2jpMDTwV28/Y4rUyuH2IAJhaq7kLa2eJK8nyVuFV7pmhUJyegAul5ZKZgnQP6GSQZPuydBx7naqEGw6YjULGkYzFJwVJyYRHIWYqvcBEqnpQ0vPTGflgj+a8guO6LKHrIkzEm2SdGniGXioUzclIbuzoAZXHZkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cXZd1Dz8; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyTrVcc9zRf5t6JInNQvbJwvdatoPNIIk9D05w7LCl4C7EQ8qtTHtMxLTGf6zZoygnBv6KCaWrk2yEv0hVX7+quO5NHK5xM8PVgoYXoTBGAdGBxOWVekg88194G7JgPeYwlcoSJyQL7mzRbGsB2eC6ExbuDLzKWbCYeBneD7rM+P3FC29+603nGDhP8/CjIehuxpZM40nTB38P63YkPAy3r8DufF9ysrt0bXy6fpsSv4f8a2IrSN/B4OCci1rQjGabGcM8SyQhE7IdC+L0Rr+zCHVXvaGtqK7nFlT8LtfZldnax6p9Quyk8/EwVaoRj4nXg83KTOsLZaOzX34qmbHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfcPmHtz5DFfv6biGCVchkLGE9sqHRUl+QkXnFZG3z4=;
 b=HWNwEO+U6+XoLbh1uU8gHvVTFhKlO1NvHnUK9DCJNk61f2/UJDBhIXB2e6enoTRNiNsMvsZBjTiAttL9R6/+DFJs0aWVjeYoQcKosG86ABcQ4PTUOIVYlKViPv4OWvJlgJ+NPjKfFIoJcff7NHvOkEbIlWW3ULm2eqQdMZKsFg812TJRoUuL9Qfqm+FR7vGMWlS/AktcwercGCHDBleg1EL6qqCjTjxlQ77hMRX1i33WLq9KlSbAe/ajgQbei6g9Qc/6ggtJU1gbAkvlxr75okx7/RII4f92+ohQNDiTX+oF297JBiRZidsM//mHFGOeXF6km8dOtEzd5ZLe6wDmgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfcPmHtz5DFfv6biGCVchkLGE9sqHRUl+QkXnFZG3z4=;
 b=cXZd1Dz8KPMAGH54QVQSPiDEB0KMHy3rDx6haxQaEtqwqSBuI31MoFZbobuRpL6Z2/FDP4X/DNzl8TmtKYZNrCvTajbkF4/J65ESIxLVDUcSzEyoEKywcF3cNiJVai4yovgfQfGCW8KPDRx7oezkT1DnlaUUpBLX043+lznJlnV8C7L4BAAZcU8Vlqg3+S7ZoqJQQTxqr4ck+8UKXNyY8PdMoWDW58SNfEP5u/MtL4x3BOAMgFxYp59/F73/cehTnMvXdC2FKQT3CQQx9AQ3Bpd0RQENreicPOhIwAQmRrfGueBNM9JDrvTXg2Ig/27nV/WoWLNaVyT9WOqQhDQFVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN6PR12MB8513.namprd12.prod.outlook.com (2603:10b6:208:472::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Wed, 23 Apr
 2025 13:16:34 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8632.030; Wed, 23 Apr 2025
 13:16:34 +0000
Date: Wed, 23 Apr 2025 10:16:33 -0300
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
Subject: Re: [PATCH v1 02/16] iommufd/viommu: Allow driver-specific user data
 for a vIOMMU object
Message-ID: <20250423131633.GG1648741@nvidia.com>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <d357a5d8ec08f5be0182506533f32a500fa3f0dd.1744353300.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d357a5d8ec08f5be0182506533f32a500fa3f0dd.1744353300.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN6PR12MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: f0567dd8-ab3f-49c9-38ea-08dd826911da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MRfgXQsTqfQk+ztsMFV9vQGeLJhoJVkyV+VSmi32kllzpZupqUtXfaOekNA0?=
 =?us-ascii?Q?KWomLlbakCPgZ3XTiBEYsfcRKsJ3Wexw4bdR/YNZXfpLvicWqJvlAUdeGgmi?=
 =?us-ascii?Q?uJ8m2IgbMWJi3uK6M+8aKVZBYjkq2Lv6OwFTXYZ/vzp9fsNIe/ib4m/F8cif?=
 =?us-ascii?Q?TYpCRF1ya/hcNPKLK7cYu5smiDdpst4qqK0DO45yr6QnWpugZRlBNMQlKGrI?=
 =?us-ascii?Q?Bvg4Rhn7L90CmhA+Tck/KBd5s1eSugsJrgs0RxJVWOmitTveV3K7Fh0dwqVI?=
 =?us-ascii?Q?DkMpDviTwFS1v+vz8kKyBqjbskOa1aUInHErsffVLF/48G3balAdtk9XVgHE?=
 =?us-ascii?Q?rrBny72zTfRus9rAehJdC7L5xV8Pvq8WGdU7ap/S4xmc0fpSfdOewUspRysl?=
 =?us-ascii?Q?dOKpI5vECOd8TOU8TTN98wHx+TB/HU7lKRiH3LqnTQUpjOF5R61v+c72LRA+?=
 =?us-ascii?Q?Pd0xfhVNkDC1KveZ1eAqkW0W8HXTbmybTLPhn8FHOax1HxfHSjPabOaOEP7e?=
 =?us-ascii?Q?KAn/TW2OkmAFqeGhg5x4l2eQpcJ2qVZ4n+MzkCovpUpzCFb77/I31A3dVuVr?=
 =?us-ascii?Q?lkBFVzJHrX2tljfbKRfuKJJ2bGYnMh2lU7N9ZTHKJyJFfJ571zEjgAxuqBGt?=
 =?us-ascii?Q?I12XFlRyER8zU3WJ9M8KWLuyKAc8lRfpU6tQE2coZZ9OVU57Og12JB13sYjD?=
 =?us-ascii?Q?O0ppvajbHOYx7A1hxmutmpdBIzCFxcVLj/NsB2h4CyLa2OgldDYUe2Y9qrHD?=
 =?us-ascii?Q?NzK/MgIjrcFlDDhyXhvaOFyGZkAWIO54UH2GrE76ZDGBAGWFDTvywHn8J+YP?=
 =?us-ascii?Q?xTaNd8MzeJYOCzulsFJHw5r/MezXIeYu3XyT7QEhwKa/hxynPRBa+kUoGAcV?=
 =?us-ascii?Q?5UrNOcD2plLn3N1C3W8TmtHkHJ2wZ7Qh5OIJGOGuvcFYn2EwDsFAlUPvCPk5?=
 =?us-ascii?Q?bDlAwHfzurg4cB74x62yFGxpihqTtQeVMNaN+tDcm32SaVpbGFGqOuHDw9Pw?=
 =?us-ascii?Q?8EKDIrSwripvAUH+Y6Vc2ukGKZ1HV1gnpuZDSWWq0SRXczX95UhmVSodL4sK?=
 =?us-ascii?Q?nMaMlzk5QKDwhByUbULMmc5zNQTW3NKRywg3owIn7p0DlwGqW8ys7Njvd1J/?=
 =?us-ascii?Q?MwHtdU76CUA/npn3LAZoLMfqjHfYyAV3aj46fmc2AgmlaougoxaVliyxag1e?=
 =?us-ascii?Q?11uZ4GxGrybok9TMhAtjw7B4wBO74mMTz/B3lC/eOuij2paDuUZp2HJpHgrk?=
 =?us-ascii?Q?XACPVb9KjgTjl5lBT0Y3Ch64ufp4yElxPDJPoEAWYYE9lD9s8mii2nXZZOjl?=
 =?us-ascii?Q?VRTMXUw8zA/aaIImjLSzgPW1yjnY4vuWEtvQRbruaJmrOtWzKb4zh8d+QYQp?=
 =?us-ascii?Q?eaFylrIzpc4BTfyD1rItV5OGGsU2bzhknYdX0lc+VxdpVjjbZ8WGFQwZvSvN?=
 =?us-ascii?Q?12SBntdQPiU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2sF1SpuuzJB5oECuruMbmWRe7BuzWI+BmD6hq7P30thWVrdQFCXNSo0CI/fq?=
 =?us-ascii?Q?jNEygFMb7hkFSatptFg4T+e353+4MAgOjzVePyDSwu7+xMf59dvNfFEHb8w3?=
 =?us-ascii?Q?1HiwzTrWEpGPOgcmTJNupoCUzV+37oKaGh7lUeZDmIGiRHdskNBntWGGNUVs?=
 =?us-ascii?Q?ozfTqQy28fluQ307jbBeDbp+zGWid12XXcsffkQyux09pF0FyBuWDgWId1Mb?=
 =?us-ascii?Q?6APmC/vQu49om2BhiZApA1iO+r78DcvT/MHhGtsRXQ3xwUB+JwzswbAC06lm?=
 =?us-ascii?Q?xF7xXvhT7OtqXa8/z7J06HNuZNPWdQRCqxefieiuiKg7l+yHOYOpaA0/E5Mw?=
 =?us-ascii?Q?2fDqVkGp7OWa85RqvjkZCjt9MeNjo8S3UKIcQpo8Ji2VdkuAXNWmCW81LR7v?=
 =?us-ascii?Q?f683aE0gEcQ12s6I5A5IWIxzMj8Dw+fk5U7DzH9JJmfGJK2V6cOI9Zs/bvZ2?=
 =?us-ascii?Q?fzWMfp0OKeE5oAR+pTTKZBsuBXZu0W6MMY6L3SnS7TGhRVs9pbtUIYFS0MBz?=
 =?us-ascii?Q?dV7Brz85XVFiUzLEdvhd+nzAdY7qV7se10TbSJWrqAKDHkd9cWFhuxLxwz+6?=
 =?us-ascii?Q?ID4NN6I2mPwEcjW6L5tA8zQdx8mGDaKX+uB+MRzl6Fn3LF13qSX4LfAT0DI4?=
 =?us-ascii?Q?6jrZDYMWTTE2c553vJd+/5xUI0nLjN3rRj+GuDtNPVDEH5KxNlX4SupiNY7b?=
 =?us-ascii?Q?KjLw6NHidUH40l5pCXec8zgi/cCK2K+DV7z7kk8eSVDbeNV1J/AGBQele/ke?=
 =?us-ascii?Q?a8xRBL/ysHMVZBcewhn03Csf38ZqYnD8lQkXDYiAunCym+PeUgvZwPhV5iOM?=
 =?us-ascii?Q?/JNEF+7+cVtoRoasRO62IYai8HOiWXTprSbxceu8ZwD5NNe+Tph6yyGdRdre?=
 =?us-ascii?Q?VZkMdd1M9NkXtyJhVWFErHZ4JMIwH74W8p1sZaNfwTAjBYBCoK6zl+/QBor8?=
 =?us-ascii?Q?gW2qlwngkRmILQItpBQKjCwUC5cqAfO+YAmnkOnNeRCXb658i7ETQ7TgBrbQ?=
 =?us-ascii?Q?BZH7chkElYv5cPR247zTPtAEYWj6/POvjcs1r1egkg+5GZwswJYDGmCXg1lm?=
 =?us-ascii?Q?dMtA1qckw07WSfwXY9QXyWz91cc/hV8COl+oy8MgtvCtIluGD/yp5y9Nx3sW?=
 =?us-ascii?Q?/1cl+vS/CQH3UcBiGZCYNKelG3V7nLSmBOsYfxAK3FwZSjCp1P37fyYpFgfH?=
 =?us-ascii?Q?T5OtkLk4bb87voRzTmHQCMja+rgOBRvcgZmZaspZ159NL+lccN/xkswotGE/?=
 =?us-ascii?Q?cLSvpfByNuL5d9H02qvW2d8C2fBxvVyKpb6YQ+ndi1oFj4DT9sPn2PP7vdQz?=
 =?us-ascii?Q?/3xh3Znrb0e/gg3fwifagNBFqnO/oEHxIX55TKDRODxuqNd2Qkc7iQe8qGzQ?=
 =?us-ascii?Q?NkKm7rnzGvjE90iBH5jTSm1ZFQ+usco9BlwBOHbbJWOki6KSPS/tlC5msOgD?=
 =?us-ascii?Q?hw0c6SltK8te/rRuiH+YjVyPMxaQoCCaemwbUa1tLMbXj8l6yej7eJ0gfFfq?=
 =?us-ascii?Q?3vWcB3faMOFX1iS+/XD341GEVjTQhBdroWkCUj06Km5QOl0sjrAxXP5pWH85?=
 =?us-ascii?Q?xVMaJO6ZQtpwdcVr2r0M5JFjXnPZkdZ4WJLxvKd7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0567dd8-ab3f-49c9-38ea-08dd826911da
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 13:16:34.1368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6gBoQCDoUxgXQbIbZTPOhhKmEvJ9SlOJUd3Rx6soQWDjoEHgActew0pt+WbxJUi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8513

On Thu, Apr 10, 2025 at 11:37:41PM -0700, Nicolin Chen wrote:
> The new type of vIOMMU for tegra241-cmdqv driver needs a driver-specific
> user data. So, add data_len/uptr to the iommu_viommu_alloc uAPI and pass
> it in via the viommu_alloc iommu op.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/uapi/linux/iommufd.h   | 6 ++++++
>  drivers/iommu/iommufd/viommu.c | 8 +++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

