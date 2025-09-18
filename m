Return-Path: <linux-kselftest+bounces-41805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B01B83183
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 08:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DE94A438F
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 06:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B17C2BE7A3;
	Thu, 18 Sep 2025 06:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tdhdzwRR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8942D6E7D
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 06:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758175835; cv=fail; b=GOACGDsnnl2LniQN+MoQyx1PC1z+OmVeXRHiYnapJwWt6e7koamRz3XEzsJcl+fLZ5gbi31pe1cYZA2dges5HfMkZoG0Vhuz8oFQ6W2sZa+mNYsIwEFO2hQZfylcfEtZ8RGj3INl/A8GWTo/c6UgdMyf6K94AofRsBwraVqYphQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758175835; c=relaxed/simple;
	bh=sBZNjTyOJaSj7Jz/Ro6Adu33rzeFz+Pc2zXy/FJDTXo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJDz5p4fY7I6DWff9d2Grl1QAzJ77wdfLdYNUEpu6GKmNur1sXWPAJoT9UmibaZozWvs5tbbINkwSjeA6Xt2AId9itcNFayykIRshAwXONuqSizAcPj3LOoY2LZutzZCA3Elwe1oAyLz/Tl8YvvOBrSroEmIPVm9XZay9le4IS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tdhdzwRR; arc=fail smtp.client-ip=52.101.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERqFMsQ1BqW0otxIAODdBZraqIILPU4mYTBnUwH65q8uxja3X0R2pRY+MFUQKLqVpzzeMVwjeNllH/2X4VueW3yYAkezLBmUinWsRfqmMq5czqhPoOvUROKlgPUn/Ojk32BQ++75xBLkyN92F0HXNBu9c3d61yQb/mjQWwMcR5VsB3Kwg8hbmLRFaiI8NJbFqqxKkL4EHzoy3ZCfD7vULKJC+xal1jzbOHpr5WsmvsiMcx98wxv7Ua4YspHYyJWpp3CxqRYyJpqoID/ofadmof6AhgYPCq2KUYAJMlsk8PD1vaMG//khJ+xXWA5ySKAPYfX1/jWDYv0oqi5CIWNhlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96F0rE8i16s/HS/NXYMXPaInIgO0k/HQMDQ+yfPxAAk=;
 b=gEFyoqZycZAnV7Daz2wroAT1gjSCXOuNWv3AVAFxPzMl4bjH/L5NafqhzRNV0SarPNwesZ3TEgSwujedTO95bg6E/SEd0M0dlb5n2W1cZFFTiF+aippmKzUd/6oiHDG18STi1IVSnPxRGgjrMJTWUSM4Jee7yo9wnB+nqieYHz+Y0PtlbBLvDlvFesecSUcEewOQcTvxjJGP8t2JjoJSbv9LAtxCCuPZ3W42qbySqdoO1O2Z8TgwxJmfUT16tH/X77REtr6YOlhSbLo0WJiKJJxi8jL1cgzB2KT+WWa/RfKcgsTOrtOPiCniGMQ1pexkz2o4a/1WygwzNXGGLuGFuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96F0rE8i16s/HS/NXYMXPaInIgO0k/HQMDQ+yfPxAAk=;
 b=tdhdzwRRPA2ETXjXsvBLyFZ2TONVuxmpcPVfmrbwowgIc4C9nKDZDb+hwlh7jhMIVQq2ohllhfHU/Ei/lAfmHQduZL6bvv9v0ld3WgDQMvFhLXD2yo6ruUuohMsNXP4XRsnubjZ3um4YTwOCixDQO/tJVpnPNTzXjW3As7luwGlrgc4cbYUHin65IoEyJQ9DCj9mEbC/+4IjYe/RCE+AMH9aNF+rPI1EBmX44fJ91JX9airKTgAwjazaQcNxVP9fRjIiVHToReVNcZ6lrZRzY08VxuJQyQtd8USHTgC/xf8T3xGJvPmpjfPiklVtJdN3z2C1VNwrI4KY9wVIiCl2qw==
Received: from DM6PR18CA0031.namprd18.prod.outlook.com (2603:10b6:5:15b::44)
 by BN7PPF8FCE094C0.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Thu, 18 Sep
 2025 06:10:30 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::88) by DM6PR18CA0031.outlook.office365.com
 (2603:10b6:5:15b::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 06:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 06:10:30 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 17 Sep
 2025 23:10:17 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 17 Sep 2025 23:10:17 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 17 Sep 2025 23:10:16 -0700
Date: Wed, 17 Sep 2025 23:10:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Kevin Tian
	<kevin.tian@intel.com>, <linux-kselftest@vger.kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, Will Deacon
	<will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	<patches@lists.linux.dev>,
	<syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com>
Subject: Re: [PATCH 2/3] iommufd: WARN if an object is aborted with an
 elevated refcount
Message-ID: <aMuiR791LkEybdAa@Asurada-Nvidia>
References: <0-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
 <2-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|BN7PPF8FCE094C0:EE_
X-MS-Office365-Filtering-Correlation-Id: 862713cb-a507-4aec-6b3c-08ddf67a11ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w0PKTH9tmDxim1bZHgRb2ge2j9qjGONlSMW4miARWMnjzBtw/OsP2AXAyoAn?=
 =?us-ascii?Q?A80nhJnY4LAT/ZxZB9JZqX9T1LTGEKGm1yGjxiR7qgTEinWSyRwfoREcd8sn?=
 =?us-ascii?Q?j48GrycjtcmQlnuhLgiRlwVe3uuRi84z9BxqV9FfYpNaqR+YFv/3c9zrRx7r?=
 =?us-ascii?Q?GQdJHJQCUTT9puJXd/bCs3E4AEE4QhAoJ5IQlx5CW/A27ZYsc134+eTwZCtM?=
 =?us-ascii?Q?uq33fEFwrq5N9pkwIbll9HAFOtEEgbKn488igF8TSe2dYagangV1FMvkULVS?=
 =?us-ascii?Q?6HHtzcF99TDw4gf3fRVVJ6yevQNTox9hHnYpAN1pXV3qpLNwXTi0n58WcKT6?=
 =?us-ascii?Q?Erv/CYLNdZwPxb8s8s13soGotbSYu+X7hPNB7dXpuVAqpRzi38rJFiqjFO3W?=
 =?us-ascii?Q?hs2FPYOn2nwi7/2NEbh6WJAjOSwM0eq1gayRsKZpcRoO8xnucmp8KGvvk4Iw?=
 =?us-ascii?Q?ok+9GQtwTqGqfV1rFLTFTmSc0BWPcCtMiM9J6ZnPIqs57iNqMybh/5fygx6J?=
 =?us-ascii?Q?gmsHfNASliZNinmQx83ZimywQUadWf56ArARdqeOY6x20+tnVVlcsz1sqwbC?=
 =?us-ascii?Q?Op1T6PvrIxSaq07qegosFN9IudaORx5ClYTLe7ANpXI+w5hKAG7DgJzSUtEF?=
 =?us-ascii?Q?IgnPAVxAcgkx1vL/+5A5Ta3ERdO6kdCGaKIaVTHQJ/r0TEzRhVsM77y57rI2?=
 =?us-ascii?Q?yF0ma2fqdasK7p54ZhqHL9MkNhkgmhqGRssHK/W4NxdWyO4dBtJddRToK33X?=
 =?us-ascii?Q?EwErQ0Ctp3Q8Lev3VRcfDy0JVsNPznoC4TCtO5b1jxFZs4AFwhLz0mAXPsdl?=
 =?us-ascii?Q?FxwB5xJzr+rOCBcSaRUnVNRfaSaeyxmVmqhO+Fdss8oXt7L4u/ZP31YCGUNJ?=
 =?us-ascii?Q?8Z71ycEvqrtBBRHV5g/+lWQTGcKO8ayGsSOKDnSDsem/WGxtwIppR8DvdLi/?=
 =?us-ascii?Q?mShpcR1VLeXK1X38X2hXpZI3fkoM8hrlGrg0YhdRQhuyUgaBz736JHRW8bNj?=
 =?us-ascii?Q?w3trU09TvY127+mM2e3FdWDyVcwj88YOgDpIUy8k1uwiH9ZkUOC/tELVrRjx?=
 =?us-ascii?Q?O3IGxat3bd32PHyCGllJZ8B8MrpFYwwzYEg0M22V8rl0rFMgTC4E9soTAsic?=
 =?us-ascii?Q?OojFfRrrM9bTHI6rMnR/TXJuvEMjiNmTUpvL0WmSYiKE7QoZxFw+xPQwWPJ6?=
 =?us-ascii?Q?5p45OV421o05Rv9+w52N+RUWGCbJkNiEBcSegzJF1W4ZgkgSicEE9YvkAIU9?=
 =?us-ascii?Q?JmRre9utl1rrGlMtqjhPCxw5MnlmJRhl/cX8ve/RxlA2CLT8CIusXVWUcBqs?=
 =?us-ascii?Q?lsMZZ62s5uOqdZ9/yOe6ASiqN+4OtZ/GKQtYn6XrIOGMi9brZ6VN5/w3/cAr?=
 =?us-ascii?Q?KjTLLryTRjU3MRfaKtXCnbYNjU5ZpItQsOkam8qruuI/JBKW6XVQvdtzVA2h?=
 =?us-ascii?Q?bpnDT+lsEXRwAOSFkhJDD86iSDRK2Bm6OmIpkte0h27gK41wLyrTxQFoN0Xd?=
 =?us-ascii?Q?yEFlyrxA061YiG316hILrQdWHKLsfbY3fbXF?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 06:10:30.0114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 862713cb-a507-4aec-6b3c-08ddf67a11ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF8FCE094C0

On Wed, Sep 17, 2025 at 05:01:48PM -0300, Jason Gunthorpe wrote:
> If something holds a refcount then it is at risk of UAFing. For abort
> paths we expect the caller to never share the object with a parallel
> thread and to clean up any refcounts it obtained on its own.
> 
> Add the missing dec inside iommufd_hwpt_paging_alloc()during error unwind

Space between "()" and "during"

And I don't see this patch touch iommufd_hwpt_paging_alloc(). Is
that the iommufd_object_abort() part with the WARN_ON?

> by making iommufd_hw_pagetable_attach/detach() proper pairs.
----

> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 0da2a81eedfa8b..627f9b78483a0e 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -454,9 +454,8 @@ static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
>  	if (hwpt->obj.type == IOMMUFD_OBJ_HWPT_PAGING) {
>  		struct iommufd_hwpt_paging *hwpt_paging = to_hwpt_paging(hwpt);
>  
> -		lockdep_assert_not_held(&hwpt_paging->ioas->mutex);
> -
>  		if (hwpt_paging->auto_domain) {
> +			lockdep_assert_not_held(&hwpt_paging->ioas->mutex);
>  			iommufd_object_put_and_try_destroy(ictx, &hwpt->obj);
>  			return;
>  		}

Hmm, this patch doesn't change the scope of ioas-mutex?

And it seems that both callers of iommufd_hw_pagetable_put() don't
hold the ioas->mutex?

Thanks
Nicolin

