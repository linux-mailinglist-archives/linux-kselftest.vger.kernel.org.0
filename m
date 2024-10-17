Return-Path: <linux-kselftest+bounces-19993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A63B59A29A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 18:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EBC91F22371
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 16:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CB61DF27D;
	Thu, 17 Oct 2024 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MDMoVcMk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB861DE4E2;
	Thu, 17 Oct 2024 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183921; cv=fail; b=Ab3thYgCr8HDhfD1bTsnXK2DTSg6KW/6L/nBoHwEXSMWE/Va3hbzsxJ7cJ3g2OB3Byb+y8Uxq95SQWaZLjknbB1KsrXBgwwJAUU4sY68eEj10NBVf0FfbDPiFuOFOv3NYiy0shyZX886gFjU2HJopkWmh7hkfB+bhgd7V/T7WxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183921; c=relaxed/simple;
	bh=+xCLhq2sF0h7VjlWyxTATP1F7uMAaW9qDhU6AZf2QGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZkaoJnQs5wjmoHKijFNUmjNZ2tLBSZOurmYiI/XPRz3Ljq3jPEnUwxDq70yIcllT8EEiK6ezjKOnQmTLJr8QYYXTnvj03vU98Ja9yPnD26cTlsX539/E+T5o7/e/NeNSxiRERRDRsDsU9a0kdPG2dgEkPIEksuGaF+u54T2ouhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MDMoVcMk; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/FAKVQKM3kSYyiPDPLATuIkKuHGsW2R6owYMlYglT9bgER6YAacR2haUwgOHyr67zbU6Dc7081ZKqmwWPEgtoNIWFVRt8E7YQrlXSE8LF6Ov/rT17j/KK4PsdRO6XVo0x20wzH9o36WryOlsve0lfRQE5LoFMJ17ZVzxhgOjn5bUUDevjn30awW5v9pjXHB0ld0Ulr7S3esJWvavPSk5chDuBYfKkIMBF9zEnGrlaK5ME9CXopoQUZxB+Xpcyi5KhzfVbV8jUnGtqZOhf60CdlMjPvQEYciRoVVOaeBcRkplbaVg4Cd9Hub+6UKar7me5BzAvMJWCAC8/leMaElFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AiW5RHvMTaF0Pfrw5QWhAW1psiT/spB7BU7whMzeos=;
 b=jIJ8a5nfUCEZdbHyqeEX5Z4MTNHb3vs+eS2yw5AWwbWLBL1Tq2dgkEe4fmzhXpTma/eNE67sDwy/RJSEi5CRJi1FGF1P5F79Sq6g8csSZXep44L5x9QCitNJpYI2nYx1KSdR6wAIJrW+50qswSyVrTZDMDTxPWqSR27mSs7xvKtrI7mZxIId5IjC5fYwyBzNnoiRYK6aH1n3z5AoyFLhunJ0t54VFDN02EiNqPleURwHRR05uAHF3l2eSIQGla4xmrD3vJkowf2dmsEQTOyVLCggq93FvO3BA3r02JKUYkmKDDBnZk/aAZceW4mFzzGYCgAzVvKKKp+fNC2bE0EuUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AiW5RHvMTaF0Pfrw5QWhAW1psiT/spB7BU7whMzeos=;
 b=MDMoVcMkxmPonPmSOmhChU7LNwTBmSmc11I5p9kbi728WR1AyH17Tk8VYqj4a2/+c0fqQ+q2y45lU8ZIjQIhzpXn+Edf1D99Jzv02UZk4kuJaUI1XhVMPzG/wWIkANN68eMQ+sa26eVyatecK8TD69vyDtz569iQX2QFBHdih0Y86VjicPA6WtN+TCt21FfBfRhIWCunI7UYmpQjaPYx5rU798FqkyRfvLGo0p3KFXMnGNKMxGYFEFQ+Vv1ALY3uzyAZQ+qGpzdvCv4PY1YTL/H4Yr9xKZdpZKKPoC62VUnDugSwHqrFQ5HZ8symS4EZT77sPQ3e/0rLnSDTaXyXDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Thu, 17 Oct
 2024 16:51:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:51:52 +0000
Date: Thu, 17 Oct 2024 13:51:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, patches@lists.linux.dev
Subject: Re: [PATCH v3 05/11] iommu: Pass in a viommu pointer to
 domain_alloc_user op
Message-ID: <20241017165151.GH3559746@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <781b5bddb195bffa2ba80e5a04cb10336db74c03.1728491453.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <781b5bddb195bffa2ba80e5a04cb10336db74c03.1728491453.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN0PR02CA0048.namprd02.prod.outlook.com
 (2603:10b6:408:e5::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 954dc4c2-e52f-4e68-7389-08dceecbfff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JzRBceKDTiup5gWnUdz/bd/SocFExL1rS1+zIKjSFvRV2FcdDDhoJFWussK2?=
 =?us-ascii?Q?Xp3zkowfCuuftAy0K74MD17bPQGmOMbQdP14JqXL4bPzFasyoZZeQGWrqb+l?=
 =?us-ascii?Q?Tm9u8D2RkE7FEDl4cy1H3bOYZp5ZrAXh7wI+ovjz/eQh8KtpRNGDyqUGgC3i?=
 =?us-ascii?Q?dmuYxzfA5oyjI8t2oFWbYbVC1/tyxEmakGqrXJ2nJnWqYQKzHQG6g/e/JJeb?=
 =?us-ascii?Q?njzL87oJNiIZzE4VLdCZE1t0OU2WaJ6gwtFJ+t81rtNAtoq6DuLnSBU9itsx?=
 =?us-ascii?Q?FCCplHGM4Ros969mSj25TAG9gSV3I4HkrGxBD+msPdAnjBDPXfIHE+usGeut?=
 =?us-ascii?Q?iyEo7YXShUB6461aT0fthuJP74S9N6VI2Q+3t2SW+CY7LbbSKcmURogDOZQW?=
 =?us-ascii?Q?t1LhCb1NpMFLZsBRCyPO+l6j6S2eYldjhwsgcs+he1r7EI/KgA08glknAf6M?=
 =?us-ascii?Q?DZKC+gL1KVQuhr56+6mrwketg7eygroN2eYESTGDT4PkCDH/KcbTomqLTtS6?=
 =?us-ascii?Q?abAvr9Z/d1oLfn5W2VM3N0EjkGXGuox44C1tsqh2Db9JWwhRMmEDcEUBGejS?=
 =?us-ascii?Q?4wuaMyMD8e+KZqdjOS3gl4Kyl6JnY2oNhq9Mnf2hyodMUQmyVxprcoVlQ7Ay?=
 =?us-ascii?Q?QEsKp+3+R39uuhxoNmxFtBX6yKDLJN1iAHbxB82mhE6UmLbDsSdWAzWk4m68?=
 =?us-ascii?Q?YseCLgCez7MUVJnsYiyNa2NkZ74q2EOju1QUlJ5nR8n+CVA/6FwxAcLOoBkz?=
 =?us-ascii?Q?ApVAgZDhug6XGHA2S50bkkkfTp9nxFR/kTppPRsR+CiPEVPnchmzLG2jTn9H?=
 =?us-ascii?Q?dJ776EAs8jEJzf73HxAZGPVHluTfkYHPulOVhVJapBKuy8eVcPjyWhamDXkh?=
 =?us-ascii?Q?AbWDgAbJDJKq82lW72V+xWSzVTkk4ImlFh6XhMiDCIcDg7tbpHeU9Kwy5k+u?=
 =?us-ascii?Q?ZPQ0dUkxlEBSAE3FHWSH2+cRBtT/2BooOmDWYeQkV8CJpArNvWT5cdOm3Bzo?=
 =?us-ascii?Q?UDMwGryZS9AgUW1+dsbgYvphQhYf0yRsyqgbTOzjt0P1DlAVR41LMJpeZQql?=
 =?us-ascii?Q?w2QM77i9WB2/PXGFLd/C4Af5TIggJHOhsZwgSE42kBJ62DeaIDoXcYhGKdZ2?=
 =?us-ascii?Q?5HkzeAonG9i9AQpcjXLYGwutlen2EN5AOPOgop+PCYYJrxQL3p0J7tMOWcOF?=
 =?us-ascii?Q?KlSCShijCbVHSFXJY5vOAArSnSKul7KydtJ511nQ2sOFLneVytDPbYCt3wRy?=
 =?us-ascii?Q?UuqMb9Sazi1qaNb4zcvRwRl6axIX5MSXHRsOy0CNcIbA+Pm++vP64Lq/vzkk?=
 =?us-ascii?Q?IjWPF0cI3/tn+MDyHQf8ONhu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TuHUTDyQTXiJguVzTwy4vxQ+48g/biKbgjBG8L8QERf00wS273FPOnfNghCE?=
 =?us-ascii?Q?8wBxBO5xsFm1MVfDAo3cS4OVkd2hU1BrkgRjBvY/z6O8wkTrXQ0sNUbBdY3R?=
 =?us-ascii?Q?dQwzN3rjH4mD81HTFli9XxSKHvSzxnH2eisjWODPGqVzt2KIvpZtmhNrJomK?=
 =?us-ascii?Q?svxNoECbnoZqGhMIsUVyrtwqJH+y+43y3BW0xQlcoc3yihx4fwLj3SRodgeP?=
 =?us-ascii?Q?kdluID88VILqqY3grZxkWGnTMojxKb3pGbfWjWOTDa5m2l9akjsOCmrtWXRQ?=
 =?us-ascii?Q?jvK9tPN1Lydkiwsvt5li51viHRAU+mnCIcxmgf1nGAq8cZOVQ0CJdxRTbAx2?=
 =?us-ascii?Q?eksW8EzKxn1UxTCiL635DBOOAo48+6+t8GwxbBEg731zj/+AYKL+a8f8pT7Z?=
 =?us-ascii?Q?84g/dqBs/0tGmD12RbwqzMCWKU+tXQf0AAdxoklkfZzq0I5iNFjrDsFQaMao?=
 =?us-ascii?Q?rpfEtkHdf2V5qsG8jdCMC1l9ANbz+00sqr4NY8iOUEp2MmU3vQ2vqm1KV53N?=
 =?us-ascii?Q?8Ko5jy+pjtEHFpC3r2ml33qXFaHCyAK7leWI1JYH0xOSwspGNgdroQkR3yFk?=
 =?us-ascii?Q?rzSfOMJXW7kPyxI7w/iLtfbUVHHCdL2xlemwt9rRgbbZMM7S7hZpv+aieSJU?=
 =?us-ascii?Q?RzBE2YUGBPwK22D8wq2pxLeOnOi3/PlLgIVkSt26HXdMDDwnYhRKzBQZSI+P?=
 =?us-ascii?Q?Uro99fSfzKbBmUJLAkUQD2yPq16rSRyKb5HdcqDfLo37QmA4raoLwp+hXJik?=
 =?us-ascii?Q?8EJAlSsG6Oq3g1K/LyVFEFzdUjRbEh/Hvz68FCb7HhP8KbFZD7odIiZYCJC6?=
 =?us-ascii?Q?U7ibJh+7Fi1vBasExwePTwo8Q/YBh0od7Sz5615MrU275oLPQBfX8MY7DwxE?=
 =?us-ascii?Q?4WzkXTV1Pk/WO+D47VN4sPT8fbS03/aAWoS5DlBjtgqocChwIYFbQZwmKQCH?=
 =?us-ascii?Q?YQBozop+qpBritw1UNbuG9wKlLqmPHnFnSspWHXRLhnJtrk9/cZ51WE+H7JJ?=
 =?us-ascii?Q?weJ/jEBosEItQ83513U3t2sgkARqaPySJ7Y8V+Yzvo7Fasje5FQagdwOtybf?=
 =?us-ascii?Q?+ZusVbthJvKHvlI2Vo6Ug2ebQ/6Ie1Los/L37w7SxJGajVDknJ3T8sqU4LET?=
 =?us-ascii?Q?Kef9pFZQ90913dHFTl51DfgSPEsJ0LslI71c+n9xpLMfj53iV/+f/nAA+DDR?=
 =?us-ascii?Q?VcQ2Dp5k9qpl0p89udDM3zrleGBuXnFlL5tMuyKPnodLyLANVN3MwDvtEj5n?=
 =?us-ascii?Q?sRlHM2zvfZKcOoYeVygieQnYpWicHhBPhLFGOJDa73Xl8TIMAEk74hm/3ZB9?=
 =?us-ascii?Q?97qwNo6AicsfWcvh3er7edQtMicfNk0bROYuKqpEYu1Z2ryJGdx9P9Hv5mIt?=
 =?us-ascii?Q?5Od/4m8kVt+eML8t6DYkpZC0UghQXLfJz/itksdospPk4PO6hELd5vEd6Bro?=
 =?us-ascii?Q?TAfqiCEl6RCZzHll8EqtZxUf1zSWKAJ/Mtg5a7O6VK6B5WoxHkZquky53Dau?=
 =?us-ascii?Q?svo2kcbT+GHyECyDw14z5io8Gd5D1P2ZJOKM18apiQJJXh4uoPEI6sZfVbiv?=
 =?us-ascii?Q?X/0K7eP9+NORKjREgpI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954dc4c2-e52f-4e68-7389-08dceecbfff3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:51:52.1161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ss2yeSsvU9B/IW34qDWTfVKipLDIHR7R5HZM4E2mwHj+x58eF+icGbudkpvKEvYP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7795

On Wed, Oct 09, 2024 at 09:38:05AM -0700, Nicolin Chen wrote:
> With a viommu object wrapping a potentially shareable S2 domain, a nested
> domain should be allocated by associating to a viommu instead.
> 
> For drivers without a viommu support, keep the parent domain input, which
> should be just viommu->hwpt->common.domain otherwise.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommu.h                       | 1 +
>  drivers/iommu/amd/iommu.c                   | 1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
>  drivers/iommu/intel/iommu.c                 | 1 +
>  drivers/iommu/iommufd/hw_pagetable.c        | 5 +++--
>  drivers/iommu/iommufd/selftest.c            | 1 +
>  6 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 3a50f57b0861..9105478bdbcd 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -573,6 +573,7 @@ struct iommu_ops {
>  	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
>  	struct iommu_domain *(*domain_alloc_user)(
>  		struct device *dev, u32 flags, struct iommu_domain *parent,
> +		struct iommufd_viommu *viommu,
>  		const struct iommu_user_data *user_data);

This re-enforces my feeling we should have made a
domain_alloc_nested()..

>  	struct iommu_domain *(*domain_alloc_paging)(struct device *dev);
>  	struct iommu_domain *(*domain_alloc_sva)(struct device *dev,
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 8364cd6fa47d..3100ddcaf62e 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2394,6 +2394,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned int type)
>  static struct iommu_domain *
>  amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
>  			    struct iommu_domain *parent,
> +			    struct iommufd_viommu *viommu,
>  			    const struct iommu_user_data *user_data)
>  
>  {

Do these all need to check for NULL viommu now too? Something is
needed at least, only valid viommus should be accepted here. Like you
can't pass an ARM viommu to AMD or something silly.

Should drivers accept the default viommu?

Jason

