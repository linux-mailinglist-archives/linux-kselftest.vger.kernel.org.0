Return-Path: <linux-kselftest+bounces-21877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 391889C5C35
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 16:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB501F22E2E
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 15:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F34202622;
	Tue, 12 Nov 2024 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ISu8rXWG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5482003D1;
	Tue, 12 Nov 2024 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426367; cv=fail; b=V9qjnaRHH3JU4h27ATiIvsKBgLrTe8sKRAWClPVVcWeAsENULiG8lMg0O0yY/5UQ7OtGflNoKgdZXo73j8z5XcDDFYRNUM0Az9pSp/uwxPm0xbKh3DX2VWxLHcoAdf32eOFRznm64vUNAukf2gO7Qp+dY8zLlHsKjyakWCw8QWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426367; c=relaxed/simple;
	bh=o5HiOfm88phVx0Qz8JS95rEKdf0pu8SN7tD1BxiB68U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kLiCKwrdddVi0JCBZEf/FgeSEX9idg6esukmjH71th1fanJCEEp4pHLaKT3zweImuDyR6H1FH7wCdRf/F1et91Up0Oqh2Q/6NAcpsc/3KHIHCDBy7dH5x8a44N5l28z+2aUwcx1gXjs+kuvTg2C4DJUKHcmy591ZJHnhOXs8PP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ISu8rXWG; arc=fail smtp.client-ip=40.107.100.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFRawjATwbt8v4TkwynINihlItIf3ZI7U8xgaUxA1MwPv45x8OJidcpkrj0k6Rn2LfvcHTB7Ihi6HDg1OkScYwbx+kiu+BNAGIE+lWgR9qJMJIvF+Ae6s6u2nhwgEjmU1KOrmWA2DOYYsWzxe9YGLMIakXPmtCK0qkzaNFndf5eLxRpKAvDyZdWtbIyeJWrsTPgodH8vzHd7HjYBMCBKz1D4plzYAjUdDClVmWFv/VrC694yPacf7E5kCHtNGY+T3EMhlHhwTpLNzX0An8Cq7nplVBeVR2uJzTq68F8z9unhGhrgrEtWcDCkH0di0A0hxx92+6JOaCEVoVRDOiZOYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaPGy7f7qwAkFHdXRZDR1TWf1Lu4RCFWWeJfEYpR3hc=;
 b=sBZON5y2eJxVxUTui0Yq0htiw6SN7GLEpWTfELu120jovMfnLx3MpwajkQdNyNxLHBvFtIXoMrNoTEKX8NRjlm1tiP5vVZyNr44xc60hrlnz7QCA9QsUv0zJ7HnT5QMwX+09pzl+qrisr8jHEQQEsqvE/nZGUbYrCkQuOGnW+TRJtK70U9iVkUj33fb+U+Fg5zTwdRNBCItkZX93azb3ETZtHr8kGM1mA3LHYJQlMG73/Y53VCJVPhzNFKBRIgnZQQh+hFe4WdzSiLDvPW/23qlvIxMVuKriz+rwW8BSAG12PKJqiUKvs7chXhCPOrBHk/S8QI/Md0jFW3x1MyEOvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaPGy7f7qwAkFHdXRZDR1TWf1Lu4RCFWWeJfEYpR3hc=;
 b=ISu8rXWGIebSJADOmml3UzKTFn2Y4f1DsmgibrsELqtAwUmfYSG3YDh/yVjJcjSLM5W1MtgnocqoNF70KP9kpQ57WFD8A4f6LgQ3CYqRGyNFh0Oc6lGwsbKD6oHpR5asjAWMK8QOkxTXuqq/PnAivJrBYtr1DvzidIr7Fkf/qTm9bPtEciZ2JDjhdbE0KsZowzQ8yiztwjdKvbO2wMeEr1p7OLmUCIYav9cO4cfpoQTX9zcFgFsvl8OqcWriBc9lsSQJzCrG9YOJ4WIfI45ggkGp+drHlYgWZBierBqdrGdGlJr2xKRVsHgulR9L8JnNgUTjLYagl+n+HnY/MgWv7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CYYPR12MB8891.namprd12.prod.outlook.com (2603:10b6:930:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Tue, 12 Nov
 2024 15:45:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 15:45:52 +0000
Date: Tue, 12 Nov 2024 11:45:51 -0400
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
Subject: Re: [PATCH v7 02/13] iommufd: Move _iommufd_object_alloc helper to a
 sharable file
Message-ID: <20241112154551.GA50895@nvidia.com>
References: <cover.1730836219.git.nicolinc@nvidia.com>
 <2f4f6e116dc49ffb67ff6c5e8a7a8e789ab9e98e.1730836219.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f4f6e116dc49ffb67ff6c5e8a7a8e789ab9e98e.1730836219.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:208:32b::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CYYPR12MB8891:EE_
X-MS-Office365-Filtering-Correlation-Id: d85ae96e-3b16-4e03-d040-08dd033116a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qkIw4VvTrRWV03h9nf6xNNHWrswKYguDxxDvOULcjWu4FxQ4rUS2YpFhkPOG?=
 =?us-ascii?Q?QCJJ/FTwwYbqQ7RbvSkYaB+COrDxiZGacQenzbuZzwGL/D69FOFUGJzyChb2?=
 =?us-ascii?Q?F6QpPkc1QGIVUry23wlwxM8RXKCmW9KltRCAUVwxJk2DG/YfJHIqWEW5guw8?=
 =?us-ascii?Q?lV0iLAOH2YZzUfuWFn16u3jvx4qx2KO3DlfZFIf6fzNT9im6X8Wh23FVPGgO?=
 =?us-ascii?Q?Dxnxvcdq28qgAaQLllv2L24oTdmJyWDus94sQqYpQqFsVYLwKfUY2CLEuQqd?=
 =?us-ascii?Q?qsDyg2RBk02p/lS8cVsu56GCTaipRsLEj5GWVcYArumfhjBNY7JTfvqxY8Gz?=
 =?us-ascii?Q?85fADo37r1o5yxhvP7EOgr7YPW8P4Y1yh86uHBymQJJ4lkXxRW/TA0FNUM8H?=
 =?us-ascii?Q?jz75RJW4Zp442ck1XBJ2xXstu//d4PvAFg7Go8eK3MdiAZxBaZqxOO7+vr3D?=
 =?us-ascii?Q?oBLosyETHxm2dik4XqECbb/0IdjsddIzY7DVBCBkY14O0PnbUvJrmjF/LekR?=
 =?us-ascii?Q?ZNdfUh2hgbkepmAiViTUPVErhsKhuT7mB7rbARXhh5sx9xCxnPFsW77ySPJU?=
 =?us-ascii?Q?nyO+E3DYxF8FSJ7lDzS3vj68k/Iu1Lfz5AeFlOvBuCtpMjWGA9IkeojCYSA5?=
 =?us-ascii?Q?eZmgKsVAnNHWpXasPud36psdOBxk8MF8Vp34Z/gpLMuA8+Qr6H9Ybbmd5mP/?=
 =?us-ascii?Q?qi+vr3Z/HhSFxO8kLtAQGKmzmfqMNB+mEBFqcgn4KhGwl+/oKk0wjF1Bg8IH?=
 =?us-ascii?Q?cdmSEMZ/lzSHJfIT6UCgHKc6D3QleIbCYHCWvexPWyWaoGU9N5gDYqIxWpm/?=
 =?us-ascii?Q?+ogHRAh9cckrjcqGfsUGcWN7B9/HryuplzXHU1dvdeiIVhAyVo2CYi8JvBlT?=
 =?us-ascii?Q?7l12Sjw6svSFxmXzaIGaPUxmsM5j6j3YE47Cz3jZRGzhWsh17cLa+rfCz0Na?=
 =?us-ascii?Q?ec7ZtHvkfkupnGY6lxaat9FAlkwx+Sb3ybhJclvppqxxNH4Q3oIJJVj0rXpi?=
 =?us-ascii?Q?6eaBgEIfue87wUCVUnW4GQIJhRye87uEED7RCwHxS+jOlby68K/2Ft+zrZvA?=
 =?us-ascii?Q?r5qJjcZxMDY4qi+y89AUkdb5Qu2unepi+aTO7zr+q51xOatdmnWtsOQo2Z4v?=
 =?us-ascii?Q?xZ8Nz5ywVPMNW3Jmfhn8EchVJxu53xWTgU4dG0p5X7H6af2msqfXCEC0XnKd?=
 =?us-ascii?Q?kJSlYFDBAP3tIKgVflu04WG/RqqP6jf+01He7OZD87Ki3JApv4cfogtPUXve?=
 =?us-ascii?Q?Qi1IuZPGY5ryyjz09cgBemUiFyX9oCy7L0CaiblGaH7OQLaj+UlchqrL2+35?=
 =?us-ascii?Q?8wiJZ//K2P2rEtLjbHWsrxE2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yN4AIhOuXxeAXDoeE81wAjbRLZ/9TKpb93BCFswNP9isWdSy+O2NUndYQZ9J?=
 =?us-ascii?Q?1GAvs7lRwQysapL5FomSTUzrr/wzVXVKFuMUIrtamOCEj0TNCtWxcarAaPZ2?=
 =?us-ascii?Q?Ifb5iNiqNPexSDlft8Qz+nE6QihjpfSabWwxXRRQP33ERBzAhwfi+UEfOneY?=
 =?us-ascii?Q?ku/kE3lao8IITtNMJHd3MOJw/Cxsdvx00aDAmJA0R46zwHo/GzfjfQVe2MGJ?=
 =?us-ascii?Q?Kk/4h0nW1nwtkw/Ku9Uhtew1sh/1ng2+DX01eDwNjA4a90Hq1avuGoj2hPxi?=
 =?us-ascii?Q?E4dDUFyDPVjWdW42QbZZRj9GeC0u8iivzqlLCKGUwliQ4Cu9SoqBr5RM7vv1?=
 =?us-ascii?Q?eh8YKedlJGA5G4Hggd+6UhbsiQ9C/ZSWDZqstCXXTSNEkehs/Eon/f5OyvV+?=
 =?us-ascii?Q?Dk5pYLVyvFf2ozXHrt8LW3OxwjpK+KTe6XQgY/2PziMW/0Mi0UNrs+u4Hr7h?=
 =?us-ascii?Q?qLHKh4Jua4d4i0R6MBC4GSnFOmKX0wnfmTgTWByJyf2NPfiG2XFcUzE+M7p4?=
 =?us-ascii?Q?WmzltLN+UlIZz8uhYl+S6gBLR7/dTtDi3NIPfiNtRJ2Q/UtXpfyY/77AwJhc?=
 =?us-ascii?Q?JBZdfhWVLlj8DgNGngmttdqnnULhJfXU2+1wx0hsEji/hiZEE6D0RiGph12d?=
 =?us-ascii?Q?bAiez5dMzr/EPzKy+WrCPrzUgu4Ag3IACQ8fUeFs3J0A2zUH8VZWkOGQre/s?=
 =?us-ascii?Q?7+RWIPG5cYgCCqmokVKxGePfqdwKsyzQSlJ8baYTPr+RvBh4nYu9mQEyooGf?=
 =?us-ascii?Q?Z0FSiEsnKZfgQMFe62vsntp1i3XQhZzs5XIlgktHC8MihhgVu59cWjd+YpQf?=
 =?us-ascii?Q?zB8kTCQF55jf44mTxgbIuLfddEFYfy2w46Nl16hDP2Rv2Snke0bDeRCL8SFj?=
 =?us-ascii?Q?o1xCk4fIEI7zXJLNad3yJ1nC6CG8mWEYQxN828GscxNxSb9MXBz3/QvdOmov?=
 =?us-ascii?Q?Ya6gLMgRY4NMNx+Vnnx+Pry6cmlIKjCbCIYpoeqTueGX0Ivotfz43oAdh0yv?=
 =?us-ascii?Q?ynGw50qQo7nfd5chEY2w1cK8GjcumUhfbrR03WysWr+veL/atTcpwbWDPpBF?=
 =?us-ascii?Q?DxAeo3E/mzy9lQ7r7DR14hDncCfjnYNGf5ZqfpY3pam2gymuxnfHvkjL4lzE?=
 =?us-ascii?Q?wYgjJMNloCuPAb1kPikl/ZAHM2dBEFL4N9LOyEX48xqdpyN0RBS6t28TsFJ6?=
 =?us-ascii?Q?F2DXSSKu74pgSl26cmvj452f556G7ih7nkkVkTVxWPzcNxKxrtAF//Nl7uj0?=
 =?us-ascii?Q?2exNTKxDZMQqwrEhX7tnNmxfPr4GCLFzwnyQLfbf7kkvsbfO3RPkksNqkhUv?=
 =?us-ascii?Q?3+qh/6Xy0R8XixAttp5b4x/Vz3T4OmRfGUUlss+0e7WceOA3imFL2unTO36w?=
 =?us-ascii?Q?aVRkM4iT2BGbMECvfiDMd1VjDonaQ/bfYP1x1UJzsqUrn1ylJtAN+UFZxuGR?=
 =?us-ascii?Q?4lRVPnrkMDf7A2BOi54cBXOwFsOoMTZIbagIObUjnMcpTBnAVjkQsThfBJaL?=
 =?us-ascii?Q?wZCknnTOdkrvk7mW+AtWhfrAWWukv0NAzvhDmdVVWPhwfC7nimNFp7ftqeIF?=
 =?us-ascii?Q?62eHTcqvuAY81tFnFKc59jLgcolPjlkkauNzCFEh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85ae96e-3b16-4e03-d040-08dd033116a5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 15:45:52.7006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2lnAs15rRVIe/faQCGQEAaqXVGWUFegDk5zHz2ynWRIaJADWNB8EtIkOMhD0oKgE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8891

On Tue, Nov 05, 2024 at 12:04:18PM -0800, Nicolin Chen wrote:

> --- a/drivers/iommu/iommufd/Makefile
> +++ b/drivers/iommu/iommufd/Makefile
> @@ -13,3 +13,4 @@ iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
>  
>  obj-$(CONFIG_IOMMUFD) += iommufd.o
>  obj-$(CONFIG_IOMMUFD_DRIVER) += iova_bitmap.o
> +obj-$(CONFIG_IOMMUFD_DRIVER_CORE) += driver.o

This gives a wonky module name of "driver.ko", I'm going to adjust it
to this:

-obj-$(CONFIG_IOMMUFD_DRIVER_CORE) += driver.o
+
+iommufd_driver-y := driver.o
+obj-$(CONFIG_IOMMUFD_DRIVER_CORE) += iommufd_driver.o

Thanks,
Jason

