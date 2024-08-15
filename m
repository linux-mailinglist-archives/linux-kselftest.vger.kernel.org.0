Return-Path: <linux-kselftest+bounces-15443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F30953A27
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 20:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCF42857E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 18:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833236BFC7;
	Thu, 15 Aug 2024 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NLzrFN89"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5DD5A117;
	Thu, 15 Aug 2024 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723746718; cv=fail; b=bwjTEwyqEZ/25fDd/qzI0tMh+l+CQRguqNNIOJfQSREm40x1redhZyCGaKaOYDiNZqW2X6SD1gX/fFfDGYbs+MV+UX9ZUpGREbrJL8DOJpYpbErm7ZKoEMNTGQW1+UuLJujZWy/r90DI2lYgJZeOcXyhJPCBiP4A3NdiLwHE+IM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723746718; c=relaxed/simple;
	bh=M8vasTFjc1GIdbtHib+Wc77VTFTaVE78cdMXgmSZ9JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cXjxbVsEbzxKwfHP6HpftELHWxddBijFm80iZ/qW0dJtEYUmG1m6GoBiiCALP+R+IpTuVpDMENkmrD7grx9daSv8fDKy9aXh921darjb7ZSTcbdViebLYFgFGfophND8Z7Au/GEfkBywIFYpk4pN5mQx+jBkjAnsLohXxQcRwDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NLzrFN89; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0K4ii7pd3h8Xb8ss7wFKgI08a/Crzsu4C5pmrsPXmmcROWWt0zUD/hjj8xdLfiMZIpRC5rO++zhd3BLP0mSskr5hhCk9JG+0zvZLk0CTJ3Z7hm1Amo3M10+ir2Oom24vpqW+WEf9SAeDRzux33aY4fjtvgBxoK7bCxMbB3sQ3p9AQtuiEzD4lolFJTWeWe0q23BxZLhBkCDTymtYgsAnaoh6j8KaXxNpxhrXYQAFU1PCKbnANQN39jr5nus1AXVoYKZqkUbzH0+8TmcUatpZwgstjwQRCQvGV8TUbvjIiWM1wtqU8Gh9CBBTQAM+IYRL4pDELWOYP18e/s0532r6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xqhgqi3iuBTL8GwXBUnJ11iO2SlDRpxlGIj59k5+sNQ=;
 b=AbQqsmLWvQdZ602sE7KPKCb+0kBdvC2tR0epRsYFuaYY/3UWCHMcRZJYsk8rnYHgn4TnDyCX/wNV7jZN+EvQ9Aq6QG8F60BB9dVxCu6Lw9HjtYrsW5UtodeAodVvpfEBW1oXfxVPFInXXtoq86+JfPc+6AdQN/z2BNuSdNyb4ahKHe6MKOjQ1Vqy97DW9esUzp45nj+pPrTAZNfEGzvvBmq8xY9jYVf/3J1b4I35hUC17Ssu2GKhVdxgupr0Y9i82X7hc8+JLQZr9f/3vPtMFRPisa/n4YMlLfzg1iRahG+Gt0S3e1NL7iuO+JPjqbl2ThyI+zKA20e/IodZ/LPTZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xqhgqi3iuBTL8GwXBUnJ11iO2SlDRpxlGIj59k5+sNQ=;
 b=NLzrFN8976JMqMmIC3WONHfg8KADouMItuvCfNENuawXIBWrGNIcEiqIa4/9Cq17YeMDPb4JoxK1KlId38jLqOieYE73HsWeQb+T4db+R1RPGlFdLFJlDh5R28/NJ+Vy7G1UNO/iSV0Cdz0RDCGcAenHUQnDUR6rcVD48vc0S57doqllxf9uDgFVfoKxle1zYffiKrGUXOjdKqJRjXeXdJAoQJBLuwYP3dLA8rxACjgOVymwHNWqgPIr6QLEQXHspZPzhSQNUhGL/8d7/by8R2Piyspbl9fbRGEKZGzWnLTePodGr0PSUtdUaLmUpZy+JtZq1uWEBveH5D9etGs25A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SA1PR12MB6799.namprd12.prod.outlook.com (2603:10b6:806:25b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 18:31:50 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 18:31:48 +0000
Date: Thu, 15 Aug 2024 15:31:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 01/16] iommufd/viommu: Add IOMMUFD_OBJ_VIOMMU and
 IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <20240815183142.GO2032816@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <536c5e908af3847649d1f4b7050af17d77d8b524.1723061378.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <536c5e908af3847649d1f4b7050af17d77d8b524.1723061378.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0422.namprd03.prod.outlook.com
 (2603:10b6:408:113::7) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SA1PR12MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: 952ced04-e89b-493c-180e-08dcbd588380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cz3V8Xu6nvCT5/LV6K5rdzaz51uYxjz+uWjXkoRnPrnEtgW8zW+rUj4bKhXV?=
 =?us-ascii?Q?wxwi+0j9mnSZh454IMmY/3+KTcb0ZBpKauCExjawQGYjTD1juNwyEaf0ZjPM?=
 =?us-ascii?Q?CGPls6YNwUtt7gYFDGlpugric7kSUkkmhCT8caxTsTC6LxpmrBIyBPysbE/m?=
 =?us-ascii?Q?SND/ZC04ZvgBxVra/XScehrvrjSFBzlHM5azBPazpk7nSYf6Nn/UnNecQrv1?=
 =?us-ascii?Q?quvtOolpP5g/pzGKljJ0Sh/Dl52rqfIQfc35X6Keo8s5bBRNIOz1GDtdhv52?=
 =?us-ascii?Q?KxGBhpqHuJsQyoHfxsY7MYZaVXO1yGfWm4rWDH3Pmzkwtxu5rLps6WvfDUu5?=
 =?us-ascii?Q?mPE/4fW+ChqOQ3wjy1TP3yiHneYu+OB1wjRL+HSQprnCGJSMDR21Ji30QbwE?=
 =?us-ascii?Q?zzVWHTyiZu8G4v8nvQHTFNjpK5nwIQ+WGF+IDiQtjyaP5b6lLBenzqXSaAj7?=
 =?us-ascii?Q?6JcH/wFjkYjjKT4gx4EeOIA9Z+LFFPVRE2+7p1yDVa5mTDBD/MmhGEQ5Kr/0?=
 =?us-ascii?Q?Kkj7xj/KoMMXTDaXyDQtMKELXLaQVZFiXFK/H1aq7skEZ+Nv9NUGSLa1nyK4?=
 =?us-ascii?Q?7TplpdjVVpanHKsXfRObhKhLSbzCN3ufOiKkRYBGO6LmxmTuwqc1LJVEBBCZ?=
 =?us-ascii?Q?VZ/srf3ghnU3DI/RakGKHsYAEMGvZqyWaVysmAaX5FUvLDwzrohLm6jnIPZV?=
 =?us-ascii?Q?JP7RzYliKZ/5loAolzHQPRxq2JlulxHwUliMpYFPjo6slj+Ll44vO/XkZwO4?=
 =?us-ascii?Q?oZkXNKJ76fzlzYWPinnAS9LlW4cgNVAJ08snaNt2EZykeqPYHUtwdF+V85JZ?=
 =?us-ascii?Q?e0pbnioTunNE+L+1wFD6lStdrwPWTWP4pZaLxQbsHHWWUqU+/0bYm3DADl7J?=
 =?us-ascii?Q?/TWRjAu1vHakoXzz9BjUpSSBdMsxeGauJeLl0CqFDi6lk1lpxJLj3OV28ZBE?=
 =?us-ascii?Q?g4yXkaXkzyl9V49wW8OwnKI5105tBCqhHMdBub5IhEUslaf4c2bmhU21pYnL?=
 =?us-ascii?Q?f06ppJHMw2+B8IAf1mQ0dU6wPjFTg2WJenwwGqSI2QaouACEGHYCGBVB1CeH?=
 =?us-ascii?Q?ZsBMDvXmMs7qW63ZXFlncoj7b2UTevwKLriHHOAYRrBflNVU3dqmMxh5PcMg?=
 =?us-ascii?Q?DDyLBvj7x75ijqipA8ueuUSCCi3yIi0hM4InXn/GgXUyb3zYNb6FXg7/xri8?=
 =?us-ascii?Q?QnxB86V26d1AC4p/0s5rs/lywuz8VfiiepogAI69K2RDefllQOKDiMGO7T6O?=
 =?us-ascii?Q?dyaZbYq33bqgH0KQLRe0WNfE48d/BgToIaRttvmF0zUlEhzSqCdH3pi3+5bB?=
 =?us-ascii?Q?4A121Rzwh2GohfjcaMSRENOEYwobyFkOQRusVUqDXh0JEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T2ZCmC2mSEWQE7pQa8J1lGO6DvN4MlplijR86x6QA1z5AB621bIM7k2zlt6K?=
 =?us-ascii?Q?L8zK1H9nznQ5WjsrEepLOmnQ7sE2k2TI0Q4OjtQL2sBICIXaxcPaJ5CT2rJM?=
 =?us-ascii?Q?XkZMce3qFDpqt82huuOBighUeDcVhvKJfbGXU3q7Cees7ogqFojUx02QY+JA?=
 =?us-ascii?Q?fTwwikHpQrbdV59WeUgZJQATTeM+dphm39DBfcwtmmbaL9cJBSvXbF3Th3Xu?=
 =?us-ascii?Q?9pGPJa6k2+znHwKe888DETDBsaaqcgJOCDelk6bVT5ex+UqlsXmHPNnlC4mj?=
 =?us-ascii?Q?ZbYVBInHNJdhlPfpXK/O2RiSpB0CEdmKdpD3/+q/Nz0Lb5YDdgwGQpDzg6dy?=
 =?us-ascii?Q?jfTXfnPNxF4P9Vi7Ms4jbAzQ5yq8jIFwIjYH5O3IHBtIxJ7E5z2ktH0JB+Ep?=
 =?us-ascii?Q?ZD8Gj9zuArMxKvxERfRUG+geFa1r6yjHlP46YdeaB+BBqdLa4oVYTVBJ9JI4?=
 =?us-ascii?Q?iYuzKdiJJ/46u5QIzGu3BD+8mjcOVxqI1apX6SuS//zhU5y3rhNC7OD+sxN0?=
 =?us-ascii?Q?7uHoMdTlfsa16kMJSizQJcHHHkxlRs/z0hCMAAW2g7zLqbEvxMxFDaZz7D/L?=
 =?us-ascii?Q?Qww82J/MU2owaaMOUnXoZQtxZy2dFBz4TeTLrxmGILdCeEcBpun1H68N0TNU?=
 =?us-ascii?Q?KNDm0bWCDa2VLirS5B7KE7L4WQw7MzlGQ9DR9sVeMk2AebIOtZKtT3v8CeBk?=
 =?us-ascii?Q?beboSSR6AYkoRRmx1Wz0IN7Afh2UG00dpNcwvxpySqhZGoLMqrR1WG2OBYju?=
 =?us-ascii?Q?4PQjkY8+XDmeNaMEdaSYaa6v4ze66dl3jnHHt5ZQtRszusNdvuTxA4oZJYwj?=
 =?us-ascii?Q?KksH1UfwXo+gkAWcK/unPSMJo70VPqHdlH5zP4G49YUyLRNPwtBDsiDlXMS5?=
 =?us-ascii?Q?brEKp+wnROadItVuhEwjanZ/R85QGSoPMmqh/Xyeag9FzCUbHAOpjJASMkUh?=
 =?us-ascii?Q?uN+Fq2lTmUT3W8MWEepzT0VaNOw8uYVzXUu+ehJNmJfO3jL1MMF0h2wgMWRl?=
 =?us-ascii?Q?4jiipwCt5mwBSIeqiVM900PLPKsOpyP0+D7cYp68ID8RsX0XY1jvXgbV8ZDG?=
 =?us-ascii?Q?spGGhj8b00lOZ19FOx+ldPoyuv/16cl53JnL1XXmbmcmVE8dh4498fVFsRAL?=
 =?us-ascii?Q?/qIJp0dUCw9hRUpQ7Kpt4f6MooLMOMcDwgmd0j3ahUFlBXgoRWqeo3rxNMiA?=
 =?us-ascii?Q?mUPYTEHnOFZKH/xH20BUNEFh3TXEhNmyRCLajwQIg5FCtYempK+BE+pTK2ph?=
 =?us-ascii?Q?E2RpX/K+gkrsyJrPpkPovBMk50d9S+qWI5Rxl/EzAUWZweJeO0dnz4fdiism?=
 =?us-ascii?Q?PSleERaMfbEz+r1juiw4vS5LLy/qbLxDORpB54AqqGIVKTl1qNcdZ2cuWDtz?=
 =?us-ascii?Q?KB4OJUR+Afa+UtqRqOdaM9Q/pWGdc7bHPlzT6e+Dw851YuSE268Vs3GD3gfR?=
 =?us-ascii?Q?oEgvB10g0CiUU7XB7n2qSaOrQqm2l7jJWdGHzivBlFdQax9OSVcjqY+Rpxbz?=
 =?us-ascii?Q?yOJeqON/YVOSCMHZozy69vcFmMxM2ZNdpNTwmPLK3t7HAPLWAMwXPHA6ix0E?=
 =?us-ascii?Q?VAlTljXz9+KMdaTDSws=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952ced04-e89b-493c-180e-08dcbd588380
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 18:31:47.2168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8H9Yce8EGM7AHn2gMxwjv3coZvkjP0BPIRuIUzwFczTZ/fadeYzDutX2boVeGBOe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6799

On Wed, Aug 07, 2024 at 01:10:42PM -0700, Nicolin Chen wrote:
> @@ -876,4 +877,33 @@ struct iommu_fault_alloc {
>  	__u32 out_fault_fd;
>  };
>  #define IOMMU_FAULT_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_FAULT_QUEUE_ALLOC)
> +
> +/**
> + * enum iommu_viommu_type - Virtual IOMMU Type
> + * @IOMMU_VIOMMU_TYPE_DEFAULT: Core-managed VIOMMU type
> + */
> +enum iommu_viommu_type {
> +	IOMMU_VIOMMU_TYPE_DEFAULT,

= 0 here now

Jason

