Return-Path: <linux-kselftest+bounces-34067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB94AC93A9
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 18:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B07D9A25C83
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 16:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F781A9B28;
	Fri, 30 May 2025 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VykQZIHa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD30E18D63A;
	Fri, 30 May 2025 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748622832; cv=fail; b=EIMUxKnbZYENXxiXMCl5ZauGwAPGHND/H+22HMBjb+GIZ/Cf5Sk+7/wRNa4MshHF1QpTc7v01gFh7Q+MkcxYyqjELbbXrFCbpGLrZDE8zIHBtPACWXiiMXLdJUKv38XwjLyNGpcjSDww38tfBiaMoYkd3ZoUt9z/qc/OL5Qu+s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748622832; c=relaxed/simple;
	bh=6BLSZb4r7eh5My+5qA3m8ZQXgr0CovolG9MsaCn0w50=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2+82M916BLpPnIdmBJ18FtlUzBof9H3yeRvbdfNk1UwJ/FH6j0v0sMysT2RqawwhUDDmvAtdLxLXQqZS/+NnP8/OaH4bgaM9rMBwC4zIqHbhOlVGVpqnIrlLxZ8HjHM1mpsVT9Tcvqj3AMUrfWVfk8SquYh/4qMWN1QZ7YFJYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VykQZIHa; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=noCdddZNSZnRO8nCQN+L78doZ9TcDGuREJWlwRiuoCuk5PgAKr5eVHCkDBfo2uayyQ6lPnoX9M8L1+eZKvVv1xBtrkp2YVEYzcnhNuuNIKABGYQ7qh/16JrhTqVjtt+MER81orbEfVIsTkQm+Rkz+6oHzZqlQbygYpDs7K1ppRyiIpv+rJ5xDssJA4S8ye1xwDYNCwHqU0L8q6Bq8wSAjarN9c006LKvJwHIXiHx6KQc0P5cHk6s077DbLIfijLhIPac4ttax0Gif5AxF5mgxU/8v+sDsYEUHXT+c99SmZPVJKCxfNJSQeIyIidGI24/W+9DGpKFYQ4bhSVeyJBGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8j+TJA7nXckE6tPDH76Vdkd+W43ikvo5sUh0XoNAUYk=;
 b=p6Ljx3SFj4ULMtQ7R3amxpCw1BUSUTEciR1WCh8oyvSeetWkuWds4FA36mD0sNMdzuKMxvG0CUNVZDQSFKAga1rTBdUWYB+s1H6amTaKKHyNqcuc2lJIm5okHHrx+30UVrQ6QgCG71A7vSUR4HN/KcCbUHN0sRthDSp2dbRd2oRJNFTJB/qxKAMYzUvRwwI6CjkXq2sZrKo6TduFXM/Si0EipgxESmnaBE1qw2syvC390XIUspXbe53go2GdZRMtIQLPj7NkF4TASf41H6kXAQFZ/XJjA34i6efL7Us0+VisPLoNb8hHFNEHF19opajXCAwpvyi+er500ppPbGWqFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8j+TJA7nXckE6tPDH76Vdkd+W43ikvo5sUh0XoNAUYk=;
 b=VykQZIHaDTVKr7YmcTlcxycOBMVu1GXZ5WGyHFVl2uqoTNmBNyXyxMFAqQObxTDtM4CAN3ne2pvV2HtBKtFGDhAMo6/DoEEuU00cw84LfezCWw5F4qJ70DU42idhaEhVGyjiaFyHHhVnkRuFIS0KU3WjFNNf6uCw28lyQUEIOZpFWX2zGgwvqE62QOsLP6uLM1Q+TP5ewZQzOzuqeQy5Yj4PRkGbjdSDsTnCwmZBH3SnZoJi/Wm/yMfgq9Lw0agJFvqPWZLX7J60QyG+xKO2A+x7Ax85j2bnAHgF7qFo32TCtM8bNYIFtBjbn/6oSms+c6tcChea0DYEGfSIAEUXsg==
Received: from BN0PR04CA0169.namprd04.prod.outlook.com (2603:10b6:408:eb::24)
 by DS7PR12MB6213.namprd12.prod.outlook.com (2603:10b6:8:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Fri, 30 May
 2025 16:33:43 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::47) by BN0PR04CA0169.outlook.office365.com
 (2603:10b6:408:eb::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Fri,
 30 May 2025 16:33:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 16:33:43 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 May
 2025 09:33:26 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 30 May
 2025 09:33:26 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 30 May 2025 09:33:24 -0700
Date: Fri, 30 May 2025 09:33:22 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 13/29] iommufd/viommu: Introduce IOMMUFD_OBJ_HW_QUEUE
 and its related struct
Message-ID: <aDnd0i4OViUZ9uIX@Asurada-Nvidia>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <580a36f629402506d232052ddd20ef21ec91d5bc.1747537752.git.nicolinc@nvidia.com>
 <20250530160753.GD233377@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250530160753.GD233377@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|DS7PR12MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 971459bd-305d-4aad-521a-08dd9f97be01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xlx3rYtVjVfKXn5WJ7JReyocbTSMsGg8Q18F9IdgEweMrU4rGiOW/xgmIiBR?=
 =?us-ascii?Q?uDeKb4e0vkx7W9DkH5111U/RfeeahShnbLXBbfzUANJmHAKWKQjRk3t3qdJ/?=
 =?us-ascii?Q?eT2Kuzhi/qgpBCFor23huITxZiPLiLQ8GZDieccU0d3HcIjWXRYsmGZIzbWn?=
 =?us-ascii?Q?bIPT6YiYnkNrEJOWyCpIkM6t4oqPpEjX+bOkO2pQf6SqVK7fziIKkv+P59XZ?=
 =?us-ascii?Q?/0qnOcwNdS2dcs0FbY7hPrxq4gPdwlggtR0P6gLiidrOmM+La7uAduqxDnWE?=
 =?us-ascii?Q?eetLk/jq0ZUX0yhbHPaQu+1F6WRyeB0rI9ftCGPrJ83+Jr94rPfocT0x9uff?=
 =?us-ascii?Q?SdGzsfFATGTKxViTy+CtXFLlXvsOGT1zYvfF68gD4mOMvf8gktXTQoHKMOIZ?=
 =?us-ascii?Q?Ycu0HcSO9GAExFEIKSzbDXqoEyY2M2ilqjxkNGRkGnjRojY9aX/yGNIq9ONq?=
 =?us-ascii?Q?W37BTBYbWrGLVGEeTCHOsR4y/PkQ9ZMLxuHitBjFCroTCCo7KlIOCbIAjXLs?=
 =?us-ascii?Q?przWqbqGXQMoupunF8/2WSxyOlRTBkNgVUgh5+tmRapVR/NYn41T/DDbvnd8?=
 =?us-ascii?Q?eYaaOnnfg38+27dm8ERvolBl/y9mV0ULjX286thOTmnf3mZt+twq5TC3TFr2?=
 =?us-ascii?Q?IJTacg2YSFB6vxLwG+9MfDn5ZT+iXd81oVX58IWiwFPUsjF+NH8kxOo8fU6d?=
 =?us-ascii?Q?CdgMzVJH5xcIRqlvtl1l12dpqzKuGpu9/DNXATCcSA+s/5zgE9Priw25hwPd?=
 =?us-ascii?Q?cBGrarEiR2bE1K8oIyVKQLgfbptBcKYlULNcJP0hW9IipLd/PIM5LIxGbXVf?=
 =?us-ascii?Q?bA/BeJpTFDpGHJXRfJDKwFPkipsdk7eESTzoRM7SUT3i/qGRekoIn9ypgf0P?=
 =?us-ascii?Q?awoiz7di4rm6ALSnPORQ5ADIdZ4gN1yySiOLi5LfVckzudzsyC4kSzADER58?=
 =?us-ascii?Q?CataoVo+15Kuyj+UzSDsll9XIAgV2RtXH5st4xeKCZzMLOg+dg7nXD6e5WrE?=
 =?us-ascii?Q?vj2L2Y2uOwvtzpSpaNLuv3n1OPtyHRSxrCahqolfuPChNo45hr2Z7W0eGAXr?=
 =?us-ascii?Q?HF7U8ZGOpwIMDaZ04+a4ISbPtm72yvAd1f4369K8f7ryrgrUMkBS9Kub1Kw6?=
 =?us-ascii?Q?GyLc6KZUOYmym1O5MbvOa0DKgodlFTaxCKrZ1/96t2VcdSG+O0S5FXnUMnb+?=
 =?us-ascii?Q?x6CMrs16IInL2U4Hzd+vdZQ5yJh+uC5q+y6A8MsQhYHRYvlhysPGgVejSjgw?=
 =?us-ascii?Q?IgVPIlPly86CXBjNSnp7hMpAYFAC/MnIqC+437tniRcWEefWUGIDOmtgDv+T?=
 =?us-ascii?Q?+e1CsHajBxUv/2ZxxE56hpqyEFziZjTSweV5Mdt/gvj186JZGCcLwdN4tSNP?=
 =?us-ascii?Q?xjIC/qvyg5NSwUmP6dvPs1prNTJpz32GmM7pGGgwZgGZbxmyEGjQfIyoYL1n?=
 =?us-ascii?Q?kTHdiTteJfqzCseujNauI3r6ImPPVfIAew8mfXzJ0+MCQFX0CTD/zOOZSoSU?=
 =?us-ascii?Q?HD9euaws04hCQh1laVINtyhPzNiwoabdx+tK?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 16:33:43.1022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 971459bd-305d-4aad-521a-08dd9f97be01
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213

On Fri, May 30, 2025 at 01:07:53PM -0300, Jason Gunthorpe wrote:
> On Sat, May 17, 2025 at 08:21:30PM -0700, Nicolin Chen wrote:
> >  struct iommufd_viommu_ops {
> > +	u32 flags;
> >  	void (*destroy)(struct iommufd_viommu *viommu);
> >  	struct iommu_domain *(*alloc_domain_nested)(
> >  		struct iommufd_viommu *viommu, u32 flags,
> > @@ -171,6 +200,10 @@ struct iommufd_viommu_ops {
> >  						 struct device *dev,
> >  						 u64 virt_id);
> >  	void (*vdevice_destroy)(struct iommufd_vdevice *vdev);
> > +	struct iommufd_hw_queue *(*hw_queue_alloc)(
> > +		struct iommufd_ucmd *ucmd, struct iommufd_viommu *viommu,
> > +		unsigned int type, u32 index, u64 base_addr, size_t length);
> 
> I think it would better to have two function pointers here than the flags:
> 
>  +	struct iommufd_hw_queue *(*hw_queue_alloc)(
>  +		struct iommufd_ucmd *ucmd, struct iommufd_viommu *viommu,
>  +		unsigned int type, u32 index, u64 s2_iova, size_t length);
> 
> 
>  +	struct iommufd_hw_queue *(*hw_queue_alloc_phys)(
>  +		struct iommufd_ucmd *ucmd, struct iommufd_viommu *viommu,
>  +		unsigned int type, u32 index, phys_addr_t phys, size_t length);

OK. I think these two should be exclusive then. Maybe it needs a
WARN_ON in iommufd_viommu_alloc.

Thanks
Nicolin

