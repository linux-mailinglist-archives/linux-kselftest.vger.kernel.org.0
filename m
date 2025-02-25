Return-Path: <linux-kselftest+bounces-27473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DAEA44544
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE22817F4D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 16:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567AB17B502;
	Tue, 25 Feb 2025 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gPRxgt7u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD68B2FB2;
	Tue, 25 Feb 2025 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499354; cv=fail; b=nnykBCHXgVxYmMI0H1Ae0ii/J8b0kGjByVfrjEqFFemSmK1qrcdO0Wo7KgD+rqsylAfF9svT9goj6MYeXY1h0TGr8Z59dc6A+9qD+JpPr611GmwoArclIdkRy9eTH5TZsCj37WzEHBQHSt4sR6Fgroou2y5qA03VcQvinsKP6Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499354; c=relaxed/simple;
	bh=UMXEncrRz0G/lPpoMWqf8G8Po6JU06tGYdNsievbdlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WMBnZ1ZDgaOLYzN7fP3d+9yEqtZP6qPoDNxFSvd+Z+pIVQZB1njMz1DCQksEBEMVMWBllON/vVMSp2LGBPcDqdiaxu53qc5ozEvGaOS5VB+B51d5s3o53qy4iqeMEKbRtAiQU78SgDUJrRlccTsHsw0kyAT6PQC7+NuZbm/Hd7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gPRxgt7u; arc=fail smtp.client-ip=40.107.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YG2k6BSSqneo+G7tKMPUt4AIlMuimDn/jsvY2NrDoH0YrSFrETKY6aeHU03yZ1k85xm5bowHrNnL+6Me1RCap2mD4ld8Yj8jbT55/4XGTCOf3O4wB8LgJTECgrXrZx3RM5nZdR6NlgdwJjouu/PQvUfMhsZEESpgerqam1mtJPCtTdrnGsAkTPa2BtCeJFxW5lVl66fuFmJ1awyHDo5zPh061p4KhK8Y7lBDuVdH/Z560wv2S7quLS27LRk6XQ2RGHP63ZTXwi79odXifrobUN8XGdA9eH/l/ySkFnnS4SeEy7w4zSN8nimXtVQHqB43F5l1jJthYDepcZzxn0o+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kt0wyMm5mtRkTJIkzmi0YmxumgHO0TnodGz3OdNHh0A=;
 b=DUsohGcyozlRvzU33gihE2iEoftzee1h7WtCdd5S3km4rqscxaLJxuHvAp1M3kaSgzCbavnPwG6OhfNXlwXK1MoNmWhpgiis16sXCZApQIOf1E9+oGAnPBr89P2gkjaNECz2R9TEY/pc5uO5k7eGTOC4WWyJkpwMMcw8zXkqaDO71HC5EgL5m3Q8wDqtMVgUdDxWwd1frP9bgrIR3w+vk1BjNqZ9YvIf81cm+O+qTR0yolt1mg9dI2yOT4ua+QK5jnidg9f/8kFiHtFYc6JK0GdDAtQUjiFl70woIOOd1RXEZ+rBxSZcx1KfLwz3eLBdnLGu4T2TkmDQp4OqvMkABg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kt0wyMm5mtRkTJIkzmi0YmxumgHO0TnodGz3OdNHh0A=;
 b=gPRxgt7uPjlO2UHPM0ygRP/XTODEVwrLF8GsC7XZj1JW7AUb7mreKNcpC0UChG+yV+YSlSZ+Pr6sP/iPghrkbK+TxCRpIEFuw16ui98hNTDC57Za3gAFVVNENwLtKGYxJy/EUYaXK0TGmqUnXfC2p5vKnHiBE1Ufpad9MSRIihk7RJ3N1P7yzSxmwCbi//LbCxEHMsspsMvlyRhab3v5YPr8mb07WImymMHHShQ1VrsLXc4ZKhjpy7kDqmGGXVLyBXr5wMExEm29bpptwfW18O3874aZPs2oxr8DH9QsXDJDUhZuSDpVsWDhEAmjrYotuS3irTCGPQr94zgcl2RExw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB8643.namprd12.prod.outlook.com (2603:10b6:806:387::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 16:02:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 16:02:26 +0000
Date: Tue, 25 Feb 2025 12:02:25 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v7 12/14] iommu/arm-smmu-v3: Introduce struct
 arm_smmu_vmaster
Message-ID: <20250225160225.GA593877@nvidia.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
 <be799951a817557ac093ac3e18d02a631306aa35.1740238876.git.nicolinc@nvidia.com>
 <Z7zYLBLZGKim-5UL@google.com>
 <Z7zlH74/orq9HF7Q@Asurada-Nvidia>
 <Z7zqdrQn7Q8yXfcn@google.com>
 <Z7zxsbJsOFp41Dzd@Asurada-Nvidia>
 <Z70EnQ5CXacc4ysT@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z70EnQ5CXacc4ysT@Asurada-Nvidia>
X-ClientProxiedBy: YQBPR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB8643:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e0985a-09b8-4292-b4ab-08dd55b5cc93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UI4jVIF17AynCVCBN1HWR5hBooiFRHNPDjF2k5xtAa/3EVPaIKdnIE+mzUZU?=
 =?us-ascii?Q?uB8zfeWjZVYFvhG4mlxuXZZlDaVU2mBJuB4uiXYaPhO8qKBbJN9BYNsLxsMO?=
 =?us-ascii?Q?bMXs9jpK2gB4zs6nc8misw39UC9Pgd8DyO86qGypPUR//17lCFkthdkkKzXt?=
 =?us-ascii?Q?nC50k92MSjQx6yHNtwkRpPsgDljRMhXYypec8CSHLmX6ccnjkiyet3RUBJ3W?=
 =?us-ascii?Q?YHIGuDl18fhYP9MYUqLvIkSc6eqEUxQT4b2A+MlSIK4TAaskKILIQCPTJxm9?=
 =?us-ascii?Q?aG/fu308ec1tSbWL1zE/Y8LjuFkK1v5bL4BOYLWr8+jKg0fHwIKy/MyWJQ93?=
 =?us-ascii?Q?TQkwElJL82KDhBD9im5EwKGVyueZFe3XMDOxV8QHPO2OaIi8u/6hfYZYIGch?=
 =?us-ascii?Q?FLfnRjb8xQp7rSkgcKgG+upgI1shUvc1VyYfYXPiyAwNMIjWFQ5DjW0jkv8P?=
 =?us-ascii?Q?o0tQYtOEmUA+3fYSXpzHCN0QlTRvraXvYGktvtsoApGJ+Yg1Eh95AIlw1mDZ?=
 =?us-ascii?Q?EepSI7WwxZsrEyTx5oE+Bv08H7mbEDBUitZXAJtgoE7MTWkuNA8kmCB9QhXL?=
 =?us-ascii?Q?FD2MCFMGwulBR1ouYSdOOLxbbuzd3hM1+TJDISWeWZJbBN6HocR3Zy+A3TRL?=
 =?us-ascii?Q?3lYIbgRlenAyK4F5Z9JRHjmu4XfboYYI/EAzjcz8SZnEQodD5Whc951Muaw+?=
 =?us-ascii?Q?b2/4wN9rtjVQ7c45GlRfAjvAe9y43/iWJeEuMzAwiUVhxp4zHxmgXQdnW/J6?=
 =?us-ascii?Q?b/7GK8y2zo9J2YGB/E8gl8nIz9dMywv1LW3brC2jYegWooLnKAPRz3rSBrqe?=
 =?us-ascii?Q?i31tNhdKGYPX8GNdR4kfbO+57xskyUHQW7/PAXt7pcqbw3fDp4hgq0wu/z+j?=
 =?us-ascii?Q?ynJ6KaA9oyLn8b5XhBeb4nFLPQt+IxpE7UJbJS6XbkQ0N0sEq4jBNdpP58KF?=
 =?us-ascii?Q?ieaN/HxQAVvPB2ZXp22NkI1BTX2ybMMO40VjSToXhRVBARPb9StXGDKnLuwN?=
 =?us-ascii?Q?+R1JXigEpOEellCwAvt91aHzKgJHc0P8LAR8KqTZCZCpBr66qfGpUbLfxtUb?=
 =?us-ascii?Q?3ktHi36Xa9wJ4DD8Dg9sxD9VJ17FLCMGX57Tnp6EP/Kyr7DM2g3SncKg2E4N?=
 =?us-ascii?Q?W+t6t0hCViZy204rwbnJzGnsvXdkWPyjYSRwncN5FCbaA2HyCPWVo8Dq/KKQ?=
 =?us-ascii?Q?WrXlfH0LGyKWI3sOTi3QV6V+QeSJUWVSPH34RW9G71UfFTkBkWHgG7a+cnqJ?=
 =?us-ascii?Q?4RZbJL2NNXadSNf2BPlt0hAtSbns3BBB3jUgfxh4sMsTS3APYyvwyOoZu+yT?=
 =?us-ascii?Q?N1AO202wRsPBYA4qRLzDJ88vjzH8ossSdw17+E18VoUbfoMBacMvr0NAROdg?=
 =?us-ascii?Q?9DC4IIhrg3thX7G5pOKd7U5HbS6C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QkUSKvjoKvonR9gpv2FiQNtuGP5zWnf0+r9K9CPNJfdf+o548SZNs35vsHzu?=
 =?us-ascii?Q?wZeHsfbtkhL4DS3jRNALgW5hEO9g5//V/+u7vg26B/rGnDfj3ske/7UsrQX0?=
 =?us-ascii?Q?OinprwJqEXBdUpCohrXezPKI7dQcFykj2iCWH/A7heQMVSlFCTiVZ3OCVuCH?=
 =?us-ascii?Q?UXtMiNSn9l8fOzCub65hhf9CwXRzJnAoBikHkpgTyidJ1taEga0eNwEFEzJa?=
 =?us-ascii?Q?MrmFLTT1u6ADu2LSrXWKqWu5o0CMmIjlF8Z7SaLFO/K4k7GBrcgQQrkBOXHc?=
 =?us-ascii?Q?LrpoLsoND3EmUK4pfwJxDqFwQfW87DTWKtqxcH6q4T7C40PKZewyLuQ9WYNF?=
 =?us-ascii?Q?ydidahqk2P4/E/yV1btkRWPjCT705FfiHrX1o2+/53ImxTJ8Qx/okRItuwDV?=
 =?us-ascii?Q?zGkohRaQqx5Exy2phIckOG2TnbkRXHAX6+PAmr75GasrTQ2F+bUMG/fvokkD?=
 =?us-ascii?Q?phOfaLlN0Nd+ghDzLNAhVto0+ALEwJIG7T8KUJL1lp6A5UG5KZGS72KLgUBR?=
 =?us-ascii?Q?0R3+zC6JDJpu2vAulX+UmAqSCIlaw/HIODRBuIEBAceYjH3tnldOBAaX3EOf?=
 =?us-ascii?Q?N+0Uq87rG9uh67LubwfQAWx8fC6DtAainF/Y9MKWWdVvRimhTt5Zr4iVFsr9?=
 =?us-ascii?Q?4awAMkONa6KBKjfWASl7oklPHIgj4+gNn6VmuGQoyskLdtuDxRi8QhBTok4D?=
 =?us-ascii?Q?onvxVXEFWyVo32vm26BaRhVYj9K+e/LwsdaEEgjh+z9J56LQ/0Ro88CGUZgB?=
 =?us-ascii?Q?tjoVsMW9bLGKj0LfhhgtucfMiO0FP+WDQhuVknwljxcqGk0J/aXkTQZblBMf?=
 =?us-ascii?Q?1tYgLv+rm/TkZNsDtayotYmNwi/RLNBosgY97AfAcanCODUoTwEXxn1tzb43?=
 =?us-ascii?Q?EXaWRBNGkwCgdC1vPOe00fKKPYdFfiHZ4zd9wK9U23UPwJSX9mkR9k6e1Pvu?=
 =?us-ascii?Q?Q5dMc2JkTsMoZMagBw8ER4ql3pK1vdAt6NyuUsASN7wRTIwFnKuRvA9yBei6?=
 =?us-ascii?Q?kZj75qn7tLKH+wEMcSq9gvAUvVQVjGhyujM7XEl93LJXIyiVUEt8dycNMuig?=
 =?us-ascii?Q?COH7uxnot8zWz5HmEdmHb1SK56htMoO+U/3KzJOz7V5tZsW4KA+a2n0H3T4+?=
 =?us-ascii?Q?YE1VV7WJQQ6T+qZOT5dL95qiM1XncxIMjjDSoWj0QOUZDb4V1ZvocOtnLH/s?=
 =?us-ascii?Q?RwK2ejTH/Km5T+ZfoDKuH/hXbvIto5MJEgyELQK0FbukDE5kYKVMbH+CgaXs?=
 =?us-ascii?Q?oiabGERuMbd2n1jv3rB17El16xFCqd2DzLzZQ0oXcbuxUNIiFKw4r1M7qo1h?=
 =?us-ascii?Q?S2sEdxGXpscoUOE6QDkNVbDFkNGzYZK+vSseNRRd1WmmAAB/6w2ED7sYWZES?=
 =?us-ascii?Q?2ONxhac4t0V6OrzViIMHoyxigQFneKgbHkQ3LBLpY/1IVyAlT+zq349N8lYh?=
 =?us-ascii?Q?mREmEPPyoui1MEI7u6NsGoIi/aJvKRo/k8o8yKJXlqqwxaZydWi+p4XMi0z8?=
 =?us-ascii?Q?feJhkt+y2EfUQEZzUBeLWLI3OxunoASepwRXBf5bhod+XrEK4PJDXqwqapjZ?=
 =?us-ascii?Q?r4ilWBiky+V7vvUEdibwLfkJl7mZSfiV5AtkoP4a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e0985a-09b8-4292-b4ab-08dd55b5cc93
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:02:26.8656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIvS/qmdTJRvjIWKMHqv/cHg7On6DNpf5mfMo9NZh8jOX3Y8vWOJAN1WZg9yg1ln
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8643

On Mon, Feb 24, 2025 at 03:45:33PM -0800, Nicolin Chen wrote:

> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -95,8 +95,6 @@ int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
>  
>  	iommu_group_mutex_assert(state->master->dev);
>  
> -	if (domain->type != IOMMU_DOMAIN_NESTED)
> -		return 0;
>  	nested_domain = to_smmu_nested_domain(domain);
>  
>  	/* Skip invalid vSTE */
> @@ -122,19 +120,9 @@ void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state)
>  {
>  	struct arm_smmu_master *master = state->master;
>  
> -	mutex_lock(&master->smmu->streams_mutex);
> -	if (state->vmaster != master->vmaster) {
> -		kfree(master->vmaster);
> -		master->vmaster = state->vmaster;
> -	}
> -	mutex_unlock(&master->smmu->streams_mutex);
> -}
> -
> -void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
> -{
>  	mutex_lock(&master->smmu->streams_mutex);
>  	kfree(master->vmaster);
> -	master->vmaster = NULL;
> +	master->vmaster = state->vmaster;
>  	mutex_unlock(&master->smmu->streams_mutex);
>  }

I'd leave the clear_vmaster just for clarity. Commit should not be
unpaired with prepare in the other functions.

It looks fine with this on top too

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

