Return-Path: <linux-kselftest+bounces-21007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD79E9B52E7
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 20:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F4481F23A36
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 19:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0F7200BAA;
	Tue, 29 Oct 2024 19:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G5SH8D/R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FC1199947;
	Tue, 29 Oct 2024 19:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730231124; cv=fail; b=PQpjKNjHrJWdOyfPzkRdkZqlyv4B5AQXkR52Dgfwt2Bx6isMkSsN5HZurLU8KDfSHm6QX5llJsBz2bCFM6DEUmoPMh3/z8lM5gTb4L0JLFyJioBOkMTDNWSbKES3k3twS/XSMK2e7r/D/tmccHOOkJzgmcGIagsSwTDWB5JiALk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730231124; c=relaxed/simple;
	bh=uh8pGbMM9rwjwe03xWhhpzpqOYs+UmZ635Lnl7I7ffc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/lur8aEHsoQ1TV+XTHyidhVrWHNy00MjKPuXOtdVH2l3l5aXPGkqwMKn+5Zmrq/6mOHpgKHIOuyasbG+dFvjas/mfgrVgLEa77Ar/w2RpMGwYyaTZUHfh3yN5pddtwEtwIc3XwhAmG2YQ/82QwgSyNSO5M2zTfHcE6AE9anYZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G5SH8D/R; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbnNNbjHP8q/8xqIj9YN/QPmdFKJxj93hu0yxb1EdRI+18J5SAzwYD0TBh9Vk7jWRTSUM54KrSyogZQerADqYgJOS579VLfb2MwyDeFFAjUWoG7L4IRVFX6G0lu509Wscic5M9ha/H7yd3XOy5JKGke2niEBS808FkaYMkGUSnk4ZEODiucccCU6R1Cvk43n6MpwC92uoEygHQfzavR21C//pf7LCol95BKefSJb/I++SwpmArr4TdCZItjkdM+uGv+m0GkjjF9vsi097DnUfWsmpW5TFxFlNUroZWLQPYDoUFu1j5KJjzDh9vYp9mpJlYhErzR8l6BkSOsqgHQsGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTNfiLPPcdrO+70VKB6ARFDh1FK4P0rcLaNpBMXz0rI=;
 b=SqaGZOptr1f+lLxndWMItwuj0IoBz6Nrsl2RlCvfiDVpSOMajeoK8wHN1XhV3/+8yazaHtsENBm4ZRwvc1LHdpxJQoB7s1MGDmvkHfsYHii6rtKapJYpgjxcs3PyH1P6CSOqE5oMuViVme9lp/RNZqTk2uwrryMsx5jqzJmyigCsqxrQkH6nJqWJLhpiR5ddOBxYb0ahVwLAtgtKVbeuqlzdPBiwgWZpngmdQSxCcfu0wY5k0py0Mht51jl/6AaVHgBJK99TMQ45g3kS9PDtYiD83hcFHSEpbuUm2YIGv3BXHSXRDCHQO3rMSKF7aMIntgJ7Jf9dBPsV9i8jAMtyxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTNfiLPPcdrO+70VKB6ARFDh1FK4P0rcLaNpBMXz0rI=;
 b=G5SH8D/RQfig/reyK1CealhAK6Xm917yA6xmSWYaeo7WwAeG1Vp+yUraFbPiFkzRUHFy6taaP/3I78t9cxrwFmGdWvxjseojUDXjny1o7w118pAgm751jFZpe4UpxVj5waT0jQ+EMIt1b5CAnbK9AoAenI8QgUmVyfXzRZD+GEgt+fh8oQonePxymxTKTy+WFe1iExE3vhVdIrTAlrMG3fKQ4TE8RTomx2IZQ3TerWJPKVDMDV0ZbipKpCyuPLTYtuEd9+JGuXE/Yy9GVas3y3jsjXjWS3E+VUhk0JzJS/mBnY9k7PnbCr7Vdexsh6HLdSi1i4iVplToXTMkzNv1lw==
Received: from CH5P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::12)
 by PH7PR12MB6443.namprd12.prod.outlook.com (2603:10b6:510:1f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Tue, 29 Oct
 2024 19:45:17 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::4d) by CH5P223CA0022.outlook.office365.com
 (2603:10b6:610:1f3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Tue, 29 Oct 2024 19:45:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 19:45:16 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Oct
 2024 12:45:04 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 29 Oct 2024 12:45:03 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 29 Oct 2024 12:45:02 -0700
Date: Tue, 29 Oct 2024 12:45:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v5 05/13] iommufd: Allow hwpt_id to carry viommu_id for
 IOMMU_HWPT_INVALIDATE
Message-ID: <ZyE7PUFGfnMOfMVe@Asurada-Nvidia>
References: <cover.1729897278.git.nicolinc@nvidia.com>
 <6b8bb8f2319bf26ead928321f609105e4e5eecf4.1729897278.git.nicolinc@nvidia.com>
 <20241029190941.GN209124@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241029190941.GN209124@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|PH7PR12MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab79341-3fb3-462f-0da4-08dcf85236df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xY8BZvy7+sy6MD0J1Rut+tUkY92+ovjS5HMbIcEkgjp37AxKGnN1phPKn7Pg?=
 =?us-ascii?Q?ErpEF2KK/wn1vC1g9t5WFadWntTWQhqzwdpWZCS/CoGT+ZZFj2NnMs9A84fS?=
 =?us-ascii?Q?STKsXyjOFEG6iYLwIo5cXUGe2F2OQYcbi4u3HO11hxKfqLdx/lqroByrmbSV?=
 =?us-ascii?Q?xiRXbR5MHUQpVLQRW2dbBDwIrF7Bn0F/EuvtrmUmRSmsPZ11AwhR9lrKXrYP?=
 =?us-ascii?Q?5UlQxxstiQXXOH0hyCsyooP1tkAjw80oNj9P42kvyGBPm53np/ZtLOe3/gu4?=
 =?us-ascii?Q?7+9jP1lG49GLLjr7IrTIVu4EHycYH77KXSCEv/VU1OHOlVrN4Mcj9Yb5m1JG?=
 =?us-ascii?Q?Foys4wVWpV1dSgHQ6AlkrV98Y/ke9wH99vS6aRp5VredmIpTLBoIigrsjKz2?=
 =?us-ascii?Q?zxh/rNGMpqif8rG6HtupufYgVtLqgEdU0drnEsTsKKlPeq3ThhZg8dNov1uw?=
 =?us-ascii?Q?G5k3djL2r6piPw5h42Gphzemey8tavNQaN5B0o7URSCiwH84Yol8dVgjZQFW?=
 =?us-ascii?Q?mV4wjZYAfoh3X72hkSpifPDjEADW3an+/1ONQRWzD9zvatEMPJzlKNAk8/cq?=
 =?us-ascii?Q?XMvXyHLONv66UxeHACfy8nHV15IY2ZFa/rUjiAiEZWcSrYyk9z0GS2BZ0F4h?=
 =?us-ascii?Q?TXcH8WDYX4Iy1Xpt4Qx0LUf6dvr8aKSbtCPIAaSaW+hBAK6/FRxc40qpvWan?=
 =?us-ascii?Q?LtnECzBQtxLCAl69Wh6diEWd5Xf1muK4NHcT/su7MY3mu1mFGkyXgWFJTHFd?=
 =?us-ascii?Q?aoJYtqsQ6ZWEiA34I572co8HNQDsBfJlrN/uF9hnWnro81Nqrmwbzqa+venR?=
 =?us-ascii?Q?TG3YUU7p0KbyXHQRFgmss1JyiIf4QfQDZH0QXmqaS0aideYwhBPMtAL5+sX8?=
 =?us-ascii?Q?MXumUF5ppXYagf08/PX558F2TjwUvhjN4yNYTs1wWrSfYvAPbtr4A8A9dDGq?=
 =?us-ascii?Q?PRzBW7tMtlj2dLMXKhqFLtuiYaNanpCXkp64qNLg+VWdw2dhHx05uv3PY/hi?=
 =?us-ascii?Q?MBSPNuRfHvgcuNsPvey+WyDFvmNY+kMSSzGpHwvQ9jwMhsUp/5PL2n8L71y/?=
 =?us-ascii?Q?4USYkT598zTiiTjIp8rSOEf3cSVmKgNNAhwo2hcxDuuWVUazdeevg7/hX/bP?=
 =?us-ascii?Q?woIrmZGwWaruxo3vBhuZYpkdb7LcsJENnBXdDpL+qrq6zo2GA5dGSRzHjHVc?=
 =?us-ascii?Q?AEoXSoLYeE9B0LN/yUNSaTSIdv9LrbFeRM237eyZ0OLubiPxr5QjIyCU1Tk5?=
 =?us-ascii?Q?UPN61NvRLTAjSi+6w/bcoR45wfYcjcbPOxY2geokyK0WuXkuh1tXf+T9G2q0?=
 =?us-ascii?Q?P6EVtfrx35FgAnx2EQ5EFEjGnR9W73eHhuLGlihsNtA+iePcRBh0kGEhUfWD?=
 =?us-ascii?Q?q3dg+ktImeW5cmx3UR7dGKrUQXzpBbhLwmYqjZBbFpBA47CRrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 19:45:16.9955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab79341-3fb3-462f-0da4-08dcf85236df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6443

On Tue, Oct 29, 2024 at 04:09:41PM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 25, 2024 at 04:50:34PM -0700, Nicolin Chen wrote:
> > @@ -497,17 +497,35 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
> >  		goto out;
> >  	}
> >  
> > -	hwpt = iommufd_get_hwpt_nested(ucmd, cmd->hwpt_id);
> > -	if (IS_ERR(hwpt)) {
> > -		rc = PTR_ERR(hwpt);
> > +	pt_obj = iommufd_get_object(ucmd->ictx, cmd->hwpt_id, IOMMUFD_OBJ_ANY);
> > +	if (IS_ERR(pt_obj)) {
> > +		rc = PTR_ERR(pt_obj);
> >  		goto out;
> >  	}
> > +	if (pt_obj->type == IOMMUFD_OBJ_HWPT_NESTED) {
> > +		struct iommufd_hw_pagetable *hwpt =
> > +			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
> > +
> > +		rc = hwpt->domain->ops->cache_invalidate_user(hwpt->domain,
> > +							      &data_array);
> > +	} else if (pt_obj->type == IOMMUFD_OBJ_VIOMMU) {
> > +		struct iommufd_viommu *viommu =
> > +			container_of(pt_obj, struct iommufd_viommu, obj);
> > +
> > +		if (!viommu->ops || !viommu->ops->cache_invalidate) {
> > +			rc = -EOPNOTSUPP;
> > +			goto out_put_pt;
> > +		}
> > +		rc = viommu->ops->cache_invalidate(viommu, &data_array);
> > +	} else {
> > +		rc = -EINVAL;
> > +		goto out_put_pt;
> > +	}
> 
> Given the test in iommufd_viommu_alloc_hwpt_nested() is:
> 
> 	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED ||
> 			 (!viommu->ops->cache_invalidate &&
> 			  !hwpt->domain->ops->cache_invalidate_user)))
> 			  {
> 
> We will crash if the user passes a viommu allocated domain as
> IOMMUFD_OBJ_HWPT_NESTED since the above doesn't check it.

Ah, that was missed.

> I suggest we put the required if (ops..) -EOPNOTSUPP above and remove
> the ops->cache_invalidate checks from both WARN_ONs.

Ack. I will add hwpt->domain->ops check:
---------------------------------------------------------------------
	if (pt_obj->type == IOMMUFD_OBJ_HWPT_NESTED) {
		struct iommufd_hw_pagetable *hwpt =
			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
	
		if (!hwpt->domain->ops ||
		    !hwpt->domain->ops->cache_invalidate_user) {
			rc = -EOPNOTSUPP;
			goto out_put_pt;
		}
		rc = hwpt->domain->ops->cache_invalidate_user(hwpt->domain,
							      &data_array);
	} else if (pt_obj->type == IOMMUFD_OBJ_VIOMMU) {
		struct iommufd_viommu *viommu =
			container_of(pt_obj, struct iommufd_viommu, obj);
	
		if (!viommu->ops || !viommu->ops->cache_invalidate) {
			rc = -EOPNOTSUPP;
			goto out_put_pt;
		}
		rc = viommu->ops->cache_invalidate(viommu, &data_array);
	} else {
---------------------------------------------------------------------

Thanks
Nicolin

