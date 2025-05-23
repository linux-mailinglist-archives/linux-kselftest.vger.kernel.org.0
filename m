Return-Path: <linux-kselftest+bounces-33684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2474AC2B6B
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3520B1B67A74
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 21:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94AA1DE3AD;
	Fri, 23 May 2025 21:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BxSNE5Vd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245422DCBE6;
	Fri, 23 May 2025 21:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748036096; cv=fail; b=X6xY31F4YgJKzXy9kX5JjYKm8oamo9yEXcc+NCJZtw67v6+FmxPgpjHONQKguXzW6XlKQba2XFPJVLGzfeCiA+w5dbGcCsuNmB554zsBEJw7ahkGYFbEwJmrwgP2YyjXAd7+eyGpF9EGji6vgaz0iLLsXyDqy1XHCtYLeX7C0tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748036096; c=relaxed/simple;
	bh=W3SHZobSnutncyBsWrqKKGA8CuszXzm907LdvfLsp8U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYWFyCbonQEzZPyl8Togs1KbvcVLdbd/l/5Bark4A+WNhiEtz7CwuOBkhk8IqWAAHi2saw28pVQOJI0mQIx8gLc/wBY90PNYEUocZFfxCpy8sI9zayqGGnoP7DvssCsF4PcMgl7q5w5COShlyozrgCHfTSe7VfwzFv9+TGQj3q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BxSNE5Vd; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrZtCLLHbWZrAue2nc5pPUfU4VFrsQ0IrMHa1Gcfseh2bYMkxKYf3JPzeMtRmaAKMpGUz35P6Dd8xk0WNpUtapdJjMjQb6VCJeUaMagV8h9Gg3A7GCjIU83TO/iOYtY8ezcV4L9qOzbpOIlEMIiMBriB10w6nSdH9ukSQoV6MqkcPAFteETCvCp6YxiSeQdWKYP7gV9pBB8e14o022BEe58K7DUtm8U5fkFmZ4Jy9nfdzEqlpxvSMbMfWBWsBbpj1+MshI958vbno0/TFbPpW/Nou+1FK0Zke6XPkn3XnCyI94mXtyScdUVpZP/jOwH3F8DDdgJ5nGTx4ko6KTUTTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DWDWDcVF2560TmyAYWXCQ/SpUfWy1W8M7tW8xsL2ow=;
 b=CVXbXJoz07kCOfElnMPQV/lg4iFDOACF7A61oZStHc5PtOGeun2zSWf9qDJgsMHQmfbt4ZIOp0SGMmYeuDb4cb8ABEHUAyM8NXeBbKL6p+db4iDnQGiT3gBjI8mE30Of/Is5K099VPyQuO61oMcgYslGcGMPWhdPB6Z3zoyDyT136qgt7kuOO01aDBf0eTSC6M6EmuVdOabzxr4zbGNhfTtkaWRhVk/ajs5p8t+FYTfvw4h6BGj9+HeIdDGP6tf67tjegFt2oVPz7udgUshn/BJyPJ4Q6kJr0kA1V+nwP47JrE6XZFkXLRUBdXMeItJ9uX2Y/6YzCUSIyVbRB/XH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DWDWDcVF2560TmyAYWXCQ/SpUfWy1W8M7tW8xsL2ow=;
 b=BxSNE5VdYzZ+7YHHPunjFQB8Lge6UkoVEEZb7O/ceQGuUF84SkTXshHU2SKzlIyTYzcGQK1h6X/u6iw9hOGUztAVlnHf1N7IPZWrt7sFtDtZ+gCZjteKxtf3GUY9vp1N9Lrk2gjxoSkHcUhXb7PlCWyjgloVw+0BLkuwe57GaYFkcWMzogzQ3/XDg1pmilwTo3/PLvpZecIk4Dr8k5Msd3/kITqO6KqPJj+cXz5DdpxzmV8Byz2VOo6+FXODd47X3A5zmgdyDlRQIujAYU/oPaKA6ZRhT9OKdJT+CfplV7Q0UN6Uib7fPdlPakCTdiAHXXyf2QOhpVoMjhkpJg6mmg==
Received: from BN9P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::23)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Fri, 23 May
 2025 21:34:49 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:10a:cafe::51) by BN9P221CA0024.outlook.office365.com
 (2603:10b6:408:10a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Fri,
 23 May 2025 21:34:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Fri, 23 May 2025 21:34:49 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 May
 2025 14:34:42 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 23 May 2025 14:34:42 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 23 May 2025 14:34:41 -0700
Date: Fri, 23 May 2025 14:34:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "bagasdotme@gmail.com"
	<bagasdotme@gmail.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>, "praan@google.com"
	<praan@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 03/29] iommu: Apply the new iommufd_object_alloc_ucmd
 helper
Message-ID: <aDDp74yHGkhxHHJb@Asurada-Nvidia>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <c01f145f9fd9a803a3154c3e7221dd76b4f8adfd.1747537752.git.nicolinc@nvidia.com>
 <BN9PR11MB527605018977CA291C0D8E018C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527605018977CA291C0D8E018C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|PH8PR12MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: f9afa845-b7b3-46aa-0b80-08dd9a41a53b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZFG7abmtwJLsbwu01X3AKV4ydnQ4nCDe1zlrs5YOImoXawokrILInIPBa07z?=
 =?us-ascii?Q?K9Pb2sP2eX+t8Upbc3WSFLwPFVgp4J4WBFx2WjHnTw2nAFyzWTMKrat9PckH?=
 =?us-ascii?Q?KRHHJKT3DQ8PPrlQLY0DA/NOF4GDCryEwxkPGTFfW+X990AwGH59dPxg4ple?=
 =?us-ascii?Q?Dx67JFI4tp5bJhswnvUj2L2NxRvXud0sYrMsQGXKjmxp677LbfdPLT+2Tmo8?=
 =?us-ascii?Q?U07X2mXeJyn25k+y3bQWG181F0X49+75kAiZJ7I8K60dLN8n+YJYEsA8XfDa?=
 =?us-ascii?Q?O8h7+W0hImnx9mQRSPmGjl4J56OiPB318J334xCb+pfQbKRB/H7Qiw82tuzG?=
 =?us-ascii?Q?y+VSJw0EvtHrPdXNP2n1zY8058K+H66WNe2OvOL9orPi7zRE7PW8EPTngjp9?=
 =?us-ascii?Q?Lsd9oT/L8VLkHHdbSLCrXl7rN0snZTSpvWwx8hthXwWWuegxN0CLNF38nbl3?=
 =?us-ascii?Q?E0cNz5dK1ybx8xl8GHujMAYmGVC6AJfNhWvaqd+CluI9nCVGwzgVDcbP9J1z?=
 =?us-ascii?Q?CwU+8Vcx2oupC6NIGmxyXI2T63IrqvOH1XA9lT9tDnAEwbPDA86CQGsUqgEL?=
 =?us-ascii?Q?HlLgYfpLIbaqHU1+0pHcX2uaLk1scj6DgklIXW0wZWyi5BHFurB39JC+zRyh?=
 =?us-ascii?Q?ouMHoUK7G66vMVhDOJjc/wluij1XAFJZ9kforae0auK63plrhAitY2WeEdoK?=
 =?us-ascii?Q?2K9DID8DK+4ZbzSabt4sbb8+/r157Z7gQhB53I/DDqHtUv/7CTWztr4igaC7?=
 =?us-ascii?Q?rF0YGOy24x/0cDUpT89hhMdki+bAhJZub589LxgjYQPW+iWR1BNT5K6sAH6R?=
 =?us-ascii?Q?DVu0pth4+fr0c1iGcu2CWw/aR6SQ2PPfPcT7aSgzhmGs3k/elQIJjRV3gBBQ?=
 =?us-ascii?Q?LJbjWTUozrFz7X+/UKkr2DgzB31yhxfOvjpT8qSjh+kJU0U2JA3LhYYNBy8U?=
 =?us-ascii?Q?JmCj2zQrZjSjt7Y3dfW4pLO0XRlKr7ejjkVgTGy3lHN8+IMcYvuyPKPmMw0f?=
 =?us-ascii?Q?7odOp5+KDiX5jKrqHel1OJk9w7JQNvi9S1ikUGHauNRRBnBAVl2nxrHTblBD?=
 =?us-ascii?Q?wXDnXENaArJ6/bshmPSMyGGLn84fUWk0Q/LCuG+Jtf774ZzNResz3JZM8LNu?=
 =?us-ascii?Q?H8PvLhA8EGJE8/mEw3knbyjPM4QTY9UE/AM7+fKT4QCG/abQGO1UMP7baJvE?=
 =?us-ascii?Q?8BSLAQTbJ1KBbS/ED5pc6sOe1xaqbq6k06j/iZqYXqwEUOQI5PsAbLPfqQA8?=
 =?us-ascii?Q?45x0QGk0ENi1NG6gRvgGy0jv4plNmE5TjWCbrR8jxJGPmYLjcsJriDLTAH22?=
 =?us-ascii?Q?CxOL+E6vi/0+yhJSDPVVuJrxNImMJY0tRN91K9P7lbo5g9dWfB7zC0wJfMOz?=
 =?us-ascii?Q?36EDpQAiNWkpoXTnuedwbgT03xUrRXeEqAdvf/Dc5Xzn+1cAsNRAg+mBvsW3?=
 =?us-ascii?Q?EWH2ogKbRE85b/3QhiILXJKG5gBWtPvoevBxtrya3lfs43hRDFT6dR9VsYDj?=
 =?us-ascii?Q?amm0i2Z+N/lNPRRyiP1mvn4Cz+LW3BnDFNIs?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 21:34:49.0159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9afa845-b7b3-46aa-0b80-08dd9a41a53b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255

On Fri, May 23, 2025 at 07:49:40AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Sunday, May 18, 2025 11:21 AM
> > 
> > Now the new ucmd-based object allocator eases the finalize/abort routine,
> > apply this to all existing allocators that aren't protected by any lock.
> > 
> > Upgrade the for-driver vIOMMU alloctor too, and pass down to all existing
> > viommu_alloc op accordingly.
> > 
> > Note that __iommufd_object_alloc_ucmd() builds in some static tests that
> > cover both static_asserts in the iommufd_viommu_alloc(). Thus drop them.
> 
> I may overlook something, but at a quick glance the following check
> Is not covered?
> 
> -		static_assert(__same_type(struct iommufd_viommu,               \
> -					  ((drv_struct *)NULL)->member));      \

The container_of() inside __iommufd_object_alloc_ucmd() covers that:

#define container_of(ptr, type, member) ({				\
	void *__mptr = (void *)(ptr);					\
	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\ <<== here
		      __same_type(*(ptr), void),			\
		      "pointer type mismatch in container_of()");	\
	((type *)(__mptr - offsetof(type, member))); })

> Btw this patch doesn't convert all object allocations to the new helper,
> e.g. ioas. What is the criteria for when to use the old helpers vs. the
> new helpers?

Criteria is "that aren't protected by any lock" mentioned in the
line 2. The ioas has an ioas_creation_lock around finalize() :(

Thanks
Nic

