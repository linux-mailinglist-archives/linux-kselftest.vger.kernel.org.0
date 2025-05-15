Return-Path: <linux-kselftest+bounces-33101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F839AB8DB4
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 19:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0B101BC5113
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 17:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2136258CDD;
	Thu, 15 May 2025 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rIvGvF3w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266CB1487ED;
	Thu, 15 May 2025 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747330035; cv=fail; b=eIlTMjgV1S1PiEFugkIhXBcusuGB8IfjLWz7gBE1w2PrZZRYj8oPEHEpocorXQ0wDQMa+Rr6HH/+mcZtjfc3C/ODedIohCtrQwcGflllEZMJk7uKTS5eva0r8R4K2GFCc0IrbFwB6OJYCireljT8ygPH6DQkn3Spp3EjYUd1NAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747330035; c=relaxed/simple;
	bh=wWZn0Sy+HnwoYn/ZQIhtiKECdbCdAJMzc49WBWU7vzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qXY3JZoW3x+qGgFB7rGCMCKrwsLkMpqi5Ra50HxufJuqSHrTAB7y/2Ty1kLbSoC/yjwYLg0U0JY+VPVlLb3n19X5gpjnsV/w0EaD0CgBOfp+Xoc3QIuC9DidkFTGDzvnsyRJw1x+Ky9o0UQz6D61svUNm8n7aG7nWhkg2+nHwOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rIvGvF3w; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDhEctfQhNA1mjbuihdaDoX/VyfvYeCtRmEePQpCnmLJr5FDUGUKemF+EWZnhqZ0vn7weS9g586MGXkJO7tjgfBeqpn004drlcqCrq099tNIGQ/SNT94QkJ4cEsn2HMAUu+OYyxPVN9QrSc4FPUmQ2bT09rjYPX5r+uALVsMTekHiwIDXjO7tQCONDMA/I7MoYGlMSaAb2Y5A6M8Zsybrk7ASnhjH5Kf+bTPPXUpM69+dVhnRYA7/0FDv+zXWiDEK7NNLy0bjpUI9GBI32J1xOheXpJvsI6KAPwkqsu2PHf6rPdMSE9A2A+MJeiQrPTUphELpuUYiNK6yc1mEYFzaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5vidOQ5j2sPkYODhvidI01yrgD5U7uBd91KxXSvIf4=;
 b=nEt9MfbEL0GcpxFGNvo1OwDwxJtm4pzPcsDSo4205fTjlmCk+8w9uaT0W1/2I/6TWNymZWyFMGAV+OJKRHuc/tP+ldVYIBY1bToKapXthQ46kgM1qHPvvNBoRu36rl32mMEhOExHQ/4cLTAhXhMr3dO02R6eI9LotSwxzrSGlh1u2afn7Ui8IsJ1iyQAV7VZ4VHEYgTH2JDH8ZEZqA0TT1TkTaVa3RBXF8soBljpsLtH6cDrH8yTNglbh8MIrWsJmXuxyU8Rz0SeXImD9RoAjtnwf0Kj1yDk19Te+5SLPqY3ObD1wsZpzIGBAwWO/Ee0EMeoAPFXAE8yJgylM4rfZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5vidOQ5j2sPkYODhvidI01yrgD5U7uBd91KxXSvIf4=;
 b=rIvGvF3wgMKVVa8hi6/dIYMoEhwPaGLhkDjW0EUjwI6/+suoR3SZLpPZtT0wUL7B5B1jWcuAnEpzLJOW5db2mwZhjSy74ecZXEoIKCRw0b4oQGsJFkztYPM7LAFQ6apzkzxpvGQV7o3gp55kmv3z9L2UwgjbjNxJu7zO9vVbm5DF6J/UHp11bMppsbXymBNmI4gqGZgwds+QkprkNJulsqXTJwBkW10xo/Lg0J6D5UkuSIeWsgZAd3Fqc0wPINJVziu6D/c1999fH2BnnqLumkrD95aFgeny+42bbN15v0gSAzkscKUxd6+AjSvA3ZfeTYeYWToUIKEu/iIn+Clh0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6086.namprd12.prod.outlook.com (2603:10b6:8:b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 17:27:10 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 17:27:10 +0000
Date: Thu, 15 May 2025 14:27:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v4 20/23] iommu/tegra241-cmdqv: Simplify deinit flow in
 tegra241_cmdqv_remove_vintf()
Message-ID: <20250515172708.GQ382960@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <9d4d85724f872033157ceb576bbfe92102261248.1746757630.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d4d85724f872033157ceb576bbfe92102261248.1746757630.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YQBP288CA0036.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: dae93bc0-9221-4fa3-a5f9-08dd93d5b8ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U1xCVI8Z8kVZeySLaygh9gW89VQifIANgeQbXpdO2ojzguspzq2eYJ46TVnh?=
 =?us-ascii?Q?3Wa2WqeQK6Y/IuCLDbzTTUi9iGgNx8L8t2a2m8GLgBO42WG9uYbJ/ONNjPVg?=
 =?us-ascii?Q?OCQMI7tcqnzP5iE0seX6iF1/S+GexORGA8G1fO9gWeJ4Bdhxc80Y+EAWlW/9?=
 =?us-ascii?Q?ZsSgku95iYIo2FKxPeB3cOcP+U57XEecuZ7j+DgD7tMCrwECYZdo7rrhclcv?=
 =?us-ascii?Q?1wMEUQHqwhSI+3ARCDfg4X9W2lGKPBNSgeZsdA6xjBzMbQtCg1wStPG4knJk?=
 =?us-ascii?Q?jKC8KHVB+OoDIJb/zf59AG4fQCiO9GNFnP9q2bessG4tUwe8IUxYX3ZNn47q?=
 =?us-ascii?Q?c7T24FFe/jS2RA65Y7zQgyzBXSoCpOokFu1TShPgjZTCadUhbE7tgjtgMwZj?=
 =?us-ascii?Q?GBc55apO8UgmRfffWcV6HmWwf0WKNID/iXtJxInKZb8xPo+gJfBRJApHLog8?=
 =?us-ascii?Q?4FVsg9d9AuGxRFYnXBvcoA8d2AEyr/h47L+MsRtdz4VKrTef1+EqUp0pb8Zo?=
 =?us-ascii?Q?bL60NVesdtH8W1WkqV6mJw4HY+rKvavth84Ew0IS6t/XdU778znjXD5x2+p3?=
 =?us-ascii?Q?Vhv5Twp2Whi6AgOubfF7buGm4b52yHsEPhjw/MvpI1FZVTaAzcbqWpcdsNeR?=
 =?us-ascii?Q?TN+Kr5rQu+yT7uk5PJto8D65qpDZIJ81x7bicR4alsp63JPRhqXLnOWVv38j?=
 =?us-ascii?Q?gTqeF/rJNJWr3w7p41jJjcrRlRxuORgUtP0wm7Bd40UTF8i3jbsjYLN2pobQ?=
 =?us-ascii?Q?KT080F2zBhgsf/wnLrfmOfzS8UO17ubjnUid8q/1FJk0h96g7LB21yLxeCq3?=
 =?us-ascii?Q?9CS9o4imcWBLqhNFYgE19+0Ih7goeqLQbgNHD5uUMNrc+VejQXOvQLcjBunK?=
 =?us-ascii?Q?PWmwFeMmNEXTIjSg0lFzHJY2c3ZA4H4hRAhB3ctFxlDzMLN1Y7O4zCR04zhy?=
 =?us-ascii?Q?Az5IJFm2iwAkzCpVHsbQ2w3yo/p0vRiThuTPscE8xGOqDMaM94miA1AqhjVV?=
 =?us-ascii?Q?XkBxxggoE4Opt/2mzLi+48mNwIrGT011zJLleSJG73eZy2i8oDSp2M8bQnJ4?=
 =?us-ascii?Q?QW7jSIXhrK4xFQBXCdPjvrhq8BGa9mQVlnJDTGuy+2aIgEtWpX/E/MPHUpB/?=
 =?us-ascii?Q?OCh/Up4RfyQ5pHTad1B8X8UBHcck3ssTWqJywPLd/PzvZ51zGClC6dkIKVzx?=
 =?us-ascii?Q?t5oXzAiPG3pt4zFvAvZnynevLNapHPylr6L2bmDB11CG4RoLuAdLP1Y9F0Sz?=
 =?us-ascii?Q?AtBLiaSmS5mE0q8M+VyFcU6UAdliFS1sGkTTnCawLYbVO3gJqkTRdOC0qXPx?=
 =?us-ascii?Q?GJYr+fCfijpcwYOaUjBl47BLEtTT2QjJyp694eY/4TyIY12SJ/wacnNKtOlY?=
 =?us-ascii?Q?Z94hqpG4ulKQNHhp/loNPjZTV9WmrhhUl/ILxUNquyCErbgiQ7reJmH57qCV?=
 =?us-ascii?Q?rYK5nZZvQi8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9xMvNEW/38JInXZDvEaxs7o3Cqd7Xdttam0v21VuSlhXvvL8ewZw0ME2P7dP?=
 =?us-ascii?Q?vKJJyKF/FoMIbCcNnUvPT3MogLS0loq4PUP0pLzpFIQGGDqiPvCWQj8zVLFi?=
 =?us-ascii?Q?CJj7JcA5199sCYrjCeubhD87WPZQRsbCvnTiJ34II2fi4Z9t1gobisJDNJ3B?=
 =?us-ascii?Q?XHEjcIPEH8LgRQ2eOb0qsmV258VW79CZt8pOpBAHLmu++EqqkG18zce8yeAE?=
 =?us-ascii?Q?NNxOm3XmPrUO6n37tCzZ+NPy9nUmVZwb8ULG6Q6UEjal3ZbBGgjET3SircHN?=
 =?us-ascii?Q?aRGPG1GvbZej0xnKaaU1T3uOvdUlPFbWficiv1RNUGL1bOx9NF1HdN/RoZaH?=
 =?us-ascii?Q?K+cMu8A9XQw/ELUHHcT6bYja6hUIsbQCaMlSYnCBM3pSSvorYxtc74gXDnII?=
 =?us-ascii?Q?YJg9aeUTfo8cigJ6ML+u539YFQInF7PlLs1HX10dFpY3yOIuSdWyPwEfS1OS?=
 =?us-ascii?Q?K/p7hR5sowGWkXSuCAXJ9845Diuid1kb00XFjpWf7zG2S0K0a5PqQJAuBgRp?=
 =?us-ascii?Q?5Rx/Zoeo6zzSztS97HKB85DNiupB6JOnhohMoGdi0/730pXKVJDufl/Wbtk6?=
 =?us-ascii?Q?tkyePvPNgdydwGgFek5g5T+mMOfG5Vadqn0S73F4chtEN3qBqQOhmpwnI6vC?=
 =?us-ascii?Q?SzwbDutFI/JVNeBuRnsHUAOTH9TIvCn2IPyH+70C1VhCyzMsYitcx2Mqoiqh?=
 =?us-ascii?Q?TSpD49hPRzxp01+FUT9l0oUQooktogZPD9bCtHKHSEkRPZeM7CM3ve1SPAFp?=
 =?us-ascii?Q?Uu9bjMQb7EevfsJryXLIMcZyVnrOTVB9q68gfnCDWvXOXX3nEJXpXztb3Dl2?=
 =?us-ascii?Q?Z19MyQiS6u9vYwTm0B2+VTeVHAfT8aoEueNsQ4Qh1wKOpgWpX6bT8UkGOqJL?=
 =?us-ascii?Q?CDFyRx5W6acYFJSObNEoWpDl6+Zq/aBpmv5fzvqXmzfJuzHDOeEu8U+X2YFp?=
 =?us-ascii?Q?0KrsI3kPb12Um1SYVZnFRICLDaPJFc5Kd/jbWR1WjyPyyV+MAGP2gvynCVao?=
 =?us-ascii?Q?zt49+A9ep3c+4U0EZmEQuXebs3eiH3I+rgeJhiIkKvhbK3Bo3Yj1EMO9momY?=
 =?us-ascii?Q?IWOw8sOJ2QhTm2qzD+gppZi4nU+trKZPFTfI7d0gyeWBwFEc+5k93Hk3LnVK?=
 =?us-ascii?Q?d27MKGwU6RX4epq0sXNvDE6xaqjUEy5c/srh+PbDmTuIkP3f5AE043w0z2jr?=
 =?us-ascii?Q?juYLK4WGigCM2jq4MvFQqB+QM/EcBF0QBLhtw0+ZNH/F0zWk0VE148TJT56d?=
 =?us-ascii?Q?RC8gaKd46dP9xAbrif4vP1L/bNP+YV1/xHt5RI2DhbQsZV6nq6ZL1wkXG57d?=
 =?us-ascii?Q?SMqflWJrUAYkLOSwSuT+wYTIMMSMRBpmQYG0Lvaovs8w+5/3BmkRp9usKrLE?=
 =?us-ascii?Q?RiFf/aSTCv1tqGpGDPZc3escfiOJxhyiwD/dCmqDfkg2IcUKNvz20jgYZoTK?=
 =?us-ascii?Q?iFCGyrZgIcvE/yEpoBt0C2p+zRQhF1waj1oasySMu4s/Nq4euwaJ8ASiRmsy?=
 =?us-ascii?Q?6IMJXnah7GaFVNCzbB8q1vsD+sovBUKnwx/+Cb7lH6wf/4HeLAK5OfvL1NNI?=
 =?us-ascii?Q?Pd8Udxc4/DbXGKsCId0CAQwamHzSX4v0YoWOtudk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae93bc0-9221-4fa3-a5f9-08dd93d5b8ff
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 17:27:09.9225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ewakjb53BrL/T8hI8+M9NcrEH/6w88KEc4W8y4bfMpMoMlJfi7bVohYGQgEbts5D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6086

On Thu, May 08, 2025 at 08:02:41PM -0700, Nicolin Chen wrote:
> The current flow of tegra241_cmdqv_remove_vintf() is:
>  1. For each LVCMDQ, tegra241_vintf_remove_lvcmdq():
>     a. Disable the LVCMDQ HW
>     b. Release the LVCMDQ SW resource
>  2. For current VINTF, tegra241_vintf_hw_deinit():
>     c. Disable all LVCMDQ HWs
>     d. Disable VINTF HW
> 
> Obviously, the step 1.a and the step 2.c are redundant.
> 
> Since tegra241_vintf_hw_deinit() disables all of its LVCMDQ HWs, it could
> simplify the flow in tegra241_cmdqv_remove_vintf() by calling that first:
>  1. For current VINTF, tegra241_vintf_hw_deinit():
>     a. Disable all LVCMDQ HWs
>     b. Disable VINTF HW
>  2. Release all LVCMDQ SW resources
> 
> Drop tegra241_vintf_remove_lvcmdq(), and move tegra241_vintf_free_lvcmdq()
> as the new step 2.
> 
> Acked-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

