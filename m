Return-Path: <linux-kselftest+bounces-19998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C06B9A2A5A
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0894288F29
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 17:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195341E0DD9;
	Thu, 17 Oct 2024 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uks3bRT7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5471E0DC3;
	Thu, 17 Oct 2024 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184810; cv=fail; b=MR/ahqTjpew9oni8aMWIog0WBkKeq7t0YZAzW8NQfIa0Gjs5bQww/JzIUVGBtpSDWv9KvX1f67vTiu1w+Pak3K3mFfbXcJ0pgv7W4HbVtHkuEG/WugnuF/ZrTrXweWG4GugAdjWqqO0GYEdAKKFtYvdvX6e5TVBBzDvzmV6XoHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184810; c=relaxed/simple;
	bh=nmuhNUuJ4Le1ySH0WRxXn+yFiLfN2x6YdwiJi5UQLOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hKITj95PPnR0DbCiN1epMSg9l0SLd4RB4dBxOsvaPyY7lVbtQXAcwXhzBXcnd62iru8F+3UYLnppSrKNpXAGCffSMedP7g3iHC6Awm1f5pVJVGuGWerOsX4qpI4WkZYJf9nb07tpKG667WX1EarcF7JZgE/czMF808AYhL28trM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uks3bRT7; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osqaq7JszAqjACrIpmcMsKeZstjooD3roYCHeNfT9XUbjP7lCjl9JlOUPw9ThVK8VT6P7UAjmtFj8tso2PJ7L5PJH5604djwaGd8P1WHyrCA886V70MGEInatSzzWJ4oXZKN3p4YBK+sLd1UroHmL+Dlo8AE+MJYeRR5BLsdZjDV9488sEFe7ys8sjJE01QW/JcLEEhljQaOmyCMUAq4GaoZmYHlrq1QXCJ0RWq/Ur8IS9roN6XucdlV7BMQNzACDKK67mGHjzipHNjrEab7xbCzAFpaCIebsHIWC1A8m0Iz5f16v5pEMeHwripU+MPCrsFNxG9bSjTVLtyCPk6HIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UWO5M+NSqAtqVKai3CluLfR6bcOrQoviMJjawqNd+c=;
 b=t23NpUp9vCnloJwyO9468iYVFrZ+MtmZFIhDqEO0mKSDS+8W4qVNzZCNabrUrSeYv7is0/bn6jk9S15/X0ot/MhhE+tTzEVQsweiupxcYykXip+ObAsAMSWk+KFHxxIKqBu4YF+Cp4cm1aUvwgsAegTqHXsjyFYr3ffYzvE48ltJF84+6CnFOrQlmqOroNZfw32M648BvPwfQx7CHwyC3piRewWysLoZ9c8azIvL9TieLPzvg2HW7GlnBPbWAfhrMT+4o2SEOox9I9u2HGVVK413XjOM0XIhihyL7HfQzb8DPGHbRDH15G1rzvUUMjcP4rfT57DxdMIoH5SK9ZryhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UWO5M+NSqAtqVKai3CluLfR6bcOrQoviMJjawqNd+c=;
 b=uks3bRT7S3VHTWwFq64tviMdwMYf1+Iv0Vp2GO3fCsBdrDQnHge4Dp62ZViM3W1aKtesO5xCKwZxJFa3dkf02gQikfJ61cG09FOIAVY2CkAH8qkPYz5FHmunJJpyUZF6/QfLVadUrjGKpUUyOSNApiO0hgUIZhkTmKT3f20037q95Y9sMXUsrsevGqz4Uj/YWsr4QZM96M6r2kiJlYxWvvTspuAq0glK13JADfy2kFJFJDPOdjDTDzrI/yfwmHXTejdF/JUedDHUsG0ujNWhY9Jot0O6rxdJz0ByjuwP3HRGU+0aJGd5HW+weEmFp1mj7y/EfRGubAslh/9/xM8o4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 17:06:45 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 17:06:45 +0000
Date: Thu, 17 Oct 2024 14:06:43 -0300
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
Subject: Re: [PATCH v3 06/11] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
Message-ID: <20241017170643.GI3559746@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <44578ede3488d7f500a113929d44ca4f34fc2052.1728491453.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44578ede3488d7f500a113929d44ca4f34fc2052.1728491453.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR15CA0032.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::45) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: b399507a-50dd-4425-3e4c-08dceece1437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JbddK6f9p2Yo72B3A2fH/uEhQrMR35HOXm8PtoOZNRQ4MnLryzG4XlnA+D0R?=
 =?us-ascii?Q?Zpl/IZhknxBiHI1G//y5OHbnVcK9r/9dyRJYQ2yNhxCOOgbJASpKWBgJDK+s?=
 =?us-ascii?Q?E/5Rf5X90adho5noEz4wuS3Fh13RWIIs2wxOlLZMxtjmhA0jx+FVCHo/qY7B?=
 =?us-ascii?Q?Bhvean2PxcW+UmwhH0B8+C/luiHup+unKnDqeK22SrBcon4G2vauV3A2YfUe?=
 =?us-ascii?Q?1zGymv8TZMybXMIUC1q3iN3TFIERpKL0MaJ3Ap79oqDr/oF8OB8EsxwtFHTe?=
 =?us-ascii?Q?UMS2skD60esIuR9m2dZMIMSSXf8e7ungxbVqD/6fvPZxNRuHa1qogt75BwL+?=
 =?us-ascii?Q?Y+4IlqAAQqRaCjax9ke/B1J1hjEL/JV+9BiuyAz28KoJ54vcLLBGENMPyQ3T?=
 =?us-ascii?Q?6uiVi8nshNAnhRsjlYseA42PKw51RXjVmSLhPO2qwPk44dH7+3si933bQH59?=
 =?us-ascii?Q?gHMiwgHBfcsqiwoRdRYaZU/5PwoIweo1MSI0KkRbAGpMJmYyo6brl1DQRaWZ?=
 =?us-ascii?Q?C4RdGFmHwIYtqEEazvsLvgA7jM42E4MSj3mT1SSewZH4WuQndRQjjL23oBM9?=
 =?us-ascii?Q?9viu49aU42iE7BBzU13RqOx6oxlcGD+2WRC1PW5q4c8iIET72BvBn+qWw16b?=
 =?us-ascii?Q?EaWN69d+wb5Sx6f0NbfTuNM/dQPHqvXM99+SnNZYhVcDCnEXmaLDK3h8pZXd?=
 =?us-ascii?Q?wgrU54oGGXgfEgjaXp9ZvdJfBec0l7a51Lz9h8eYo8Sbj5BfF6bTZ+HOH5Jv?=
 =?us-ascii?Q?yNwaFJZ1eMLeEAhqWMXCs98sk79qbcrTjadNfcGG6qEq2ssKWLJgm1TxgIAo?=
 =?us-ascii?Q?VawjdcUB/f3/OZgy5kk+oPwDp41YPSifukfZ4h4K8eC8IvfOHPUv1c5mQ3e1?=
 =?us-ascii?Q?aD67Y9BDSGjapjEgdxLVDxm/coi/g1aCruLuex3vVbwft/ZCGIhPD6D+dhbv?=
 =?us-ascii?Q?9KAcW6mBjEDwe65WoQK2w+XGEAJZKfx6qpOrvc6HZdNFiYMuxsuabtscAFKe?=
 =?us-ascii?Q?mbvcKBb4zug/rqwfONyRDqDFqVa945e7ElKagm6mfIiI5tWMcWd4p28ToVTO?=
 =?us-ascii?Q?cUiR5EZx4ursq5PcXqheFF0i/uJndToesWdkA6Jw0HqkEZZP0atBrYv1XxIG?=
 =?us-ascii?Q?cm8a14B9yB88TXsh62rdReaAK33mCEMYq+/lqwx3A/t4yE+LAMY4n//EjiXB?=
 =?us-ascii?Q?a6uC1TNPZe/gfZ2siDpGFDoXH3XHLyFdCCDu5HevrJcryOSTNDBXEAqzCHuy?=
 =?us-ascii?Q?b6beqhQmw0uvGrY+FVE3qyMh23CEY1t9D09YOcxcP4+py45J6cTRBkxNqrnW?=
 =?us-ascii?Q?ExGmxXBF56FFEXMZBqL11b6I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0UOrs0SiiX30zi4txoYj2Kr+KJKkcHSraCmfdBpwK3USOG1ZyZPrQ8DDM0Co?=
 =?us-ascii?Q?WUJvdna1dDUj7m7fZpGt1/YyXOFQWynn0MdrItqJJa67g980+u+ne9L0/vvX?=
 =?us-ascii?Q?djJRCHMSRstYFo6LA3Xpp6trfRIu/Wj9nDeX251GnhVhc2EHuMGWsDvdqey9?=
 =?us-ascii?Q?uXQ5oEjm9AHQ55EWCK4IL3FYVwOm2VgHboX9nZmw4IhhB1d+7hOS10geWIax?=
 =?us-ascii?Q?uAqoaDE3Q8sdoJefsY+bx+AWNSUfUJKLQKOAZKx7UrHgBXr/iNMF31jHS19+?=
 =?us-ascii?Q?77P7+GJpBHkQtd+IlzZDF8uR7uCTIacC0IvR214BIks3WY/PFKnqx10QYDPf?=
 =?us-ascii?Q?1BsOeDY1E9cqKdey1d2Z37I76x93SQcYGOfqO6A3cHHvx5W9OluYM5beQoFj?=
 =?us-ascii?Q?sKsPwmzLzTdMgyMkbvd7zkL3Ow8MyUvydZACkQKiC/WZ6B1KqkVeEBan3dl5?=
 =?us-ascii?Q?i8QvxiVzhkVptWnzdmcwJVFQkjJiqZ602DH2A2VWhfgicaXaw4Y8tjid1894?=
 =?us-ascii?Q?KpVxCAmafonoEfs2D7um4PYGMWJP8WouyNKYPA30GybWAYJ2Slr4aqOxlXNn?=
 =?us-ascii?Q?W6ywVesGYlKeTcgaM4bBG0ENH/tgjV1NvvkdnXWtZodOLS7Ig/Y8UFb4SDKd?=
 =?us-ascii?Q?wSAoFAwohpcnmXQCkGDkilYH2U6tbTsYGlP8hJHY3sSXTt6Qm7rFCk6BpQsF?=
 =?us-ascii?Q?qdPgUc2qYqyWHDEbO4Vykstr55ld+T2HRq43OyDQQimNmx1uw8v5Kyyb6bPJ?=
 =?us-ascii?Q?YffnJroh641hvZZDxh8rKRJNbFKyq1xUFsFmqsK2FaTuSh0qUpt8S4sDyivm?=
 =?us-ascii?Q?ipvnsTI3nqF3jrFgIgSKjlEd7/fiSLtu2wDTe0w+B+exUNaXxJI5nWSEB/3q?=
 =?us-ascii?Q?glsp+O1b83ItwGhERXNMAtK6lUodwo0PRjFPE/RkY0GKrzJqvvz7WIv5DDnQ?=
 =?us-ascii?Q?cKo2XZAgh+V2yy2FgAXDLd/nlpKaZXtSXCH+fWqWzie4wZ3wm1Dmce6JQdHe?=
 =?us-ascii?Q?V3/DiHoDbAGdWcsA7DXDxCSTCRkXCRwVkouENNg5+Euzz40q3hrJxH7CHzLG?=
 =?us-ascii?Q?jC5dqc7qsCAv7yIWlu30ZG+SbQQKVsA3mhnR1le7FjUoYk15uINZsFOtA8qY?=
 =?us-ascii?Q?GbVR+YarX7OkVYYSEA+DXy902G5pg3REw6cpmMyvqQor/jI9o31X6ZLnd8hc?=
 =?us-ascii?Q?gGzEj72Eso6YBkXTvN/0HpCjgo6WQT/zcWtHZJWDUiTtXQ3j9kOOgjq6aMKD?=
 =?us-ascii?Q?BhrietCXOWdI+/IIiKCcf57zBtmJCsvX9NOTxOcW9JheVOVYaF93dG83JeSy?=
 =?us-ascii?Q?z8y6utMFyT1PeEbPtBVYS1LDr96KS6JLAv19ZCcbe/M9seNyjv46OGtBesuZ?=
 =?us-ascii?Q?hygRpk5KCPtOKB2gfWzn8jb/MXyPWvE38SzmWCHkuKwoy7TQkjI9LxmGR407?=
 =?us-ascii?Q?DTst9LokDhFPywSiKtl34g+HSnII1E25Sog3u3hRhewMo1UvfsarykVIJ4rt?=
 =?us-ascii?Q?Npa/UxIdwafOcxugB1alqudB5EFW8el2Vxii6bv0QvvTac+S23ykLYZOts3o?=
 =?us-ascii?Q?OBaYRDZ/0Rqlp+4GyyA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b399507a-50dd-4425-3e4c-08dceece1437
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:06:45.0845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zsmtDlIA87qUnjjy1+nKcNuccVO8UQ9FCh++g8h+KL5cpU4yfafHVyhLB8ylNKAL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015

On Wed, Oct 09, 2024 at 09:38:06AM -0700, Nicolin Chen wrote:
> @@ -317,6 +324,19 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
>  			goto out_unlock;
>  		}
>  		hwpt = &hwpt_nested->common;
> +	} else if (pt_obj->type == IOMMUFD_OBJ_VIOMMU) {
> +		struct iommufd_hwpt_nested *hwpt_nested;
> +		struct iommufd_viommu *viommu;
> +
> +		viommu = container_of(pt_obj, struct iommufd_viommu, obj);

One thought is to continue like we do with the domain and check that
the idev's iommu ops match the viommu's iommu ops (or is null for
default) before allowing the callback.

Jason

