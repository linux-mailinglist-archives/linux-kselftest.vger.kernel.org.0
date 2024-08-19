Return-Path: <linux-kselftest+bounces-15667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8FF95722D
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EAC71F25441
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 17:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6238D186E2A;
	Mon, 19 Aug 2024 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hktbs6RK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5945034CE5;
	Mon, 19 Aug 2024 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724088667; cv=fail; b=Qk1rlUzTx3uDmwddjoy5Ip7C5wWn2YJNEUrjuDyDvPRQXoqkqDSA7RWSAHesSgQCCH73wrBKFX3GcR5UmgBRI5sUQ5BNtd5RJSXX+f34a6KiwRPKna4DQXwNXKOeXkKvbWJH6znZ8hgp1GmgmzXVgoQoyeW7lYDhxvZZXN3nfkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724088667; c=relaxed/simple;
	bh=BoqwqPiZbp7OlSYsvmA25+I/unB7ZtPPC7gox09QMK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fvPL6DVAkEQ3jiaQb1GQXp2D687X5KBS7Yt4WNvi4afB3DH32MoUvHsZY0WTJCS+SGEeLMciOnvt4ZpSZLYdaex1VrUmIZZZGMEQ3XsYMg7/zSk7txrAPv3v/BKnXOJtom7ERlp17/syGMCJXsiCGXC7aWHJRJ5u9w3TwGu2VyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hktbs6RK; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPizdUmLWDLq3BCu4zaj1btnlutpHxCsYxAwUHiB8GqixgtRRKEDyLNsUOttwrx8E33hijXQ01MTccaSmYPThc4ME3p1+8bheX9oOQCWjYjvHtG9C8uLpCepT1SdAXrBT9m6EZ0mNUHCeSFouGzK4cihk7HIWhZ+fLFcxQrB0IB0ew6T0+jP/REG2gN7Nl1RPWi35Ygf20ue9ippC4H6J9lJ09HxIJlC2o8fv4pjyyPHcqtt6wwqQa/78gWtpeGfte1ZlNIZy7Zto30ccz6ep/x7KhzXqAU1r0/4TQ/VsHpVHD514rRH1obgnAF0Fh1LsEWnyJbPDGV5plOAQ1xAVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ILepDaKOlPeVymJJ2CN29KDQrBQUcxBARCZLq4aLtA=;
 b=VYliKMyw3BQ9H3Lp5EUCJKe2QUr1o3gHqKo6Ljlb0qanmNMs1sPfjyhROjt3i2pVyaFqF4qLD3Ov3bZjWxqZHwyS+PQepehTG9Ai18/TKRvWRDM+rz7SCxOCBOzl9oPSb8qWg0/MUmxyHvcBswIOXn7A5r6ZsCCe0f+Ecupchm1mp9rcOLucsd2Iexe8Nm/NMTXZ5FzjmQFGzbpGgRoiFGQkhORcEkosmz4DQnqcHDRnK7u9ThULzfC75bfJAPGklIylNeozSD3J+kLqG5gDy1bUxOGq0/yUv9wHz6RhzmAVetKSZgDXGDCs2EXgCotRt0fcVJ5KMkw76MbvRfBR0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ILepDaKOlPeVymJJ2CN29KDQrBQUcxBARCZLq4aLtA=;
 b=Hktbs6RKlWlpMCMIWlGO9LDQubk3YT2w69DOOSbIQVzeixXcVtP/KGdqWsvrf2IXYBi8DKP5wwHvAkAcI6C/aUgNBC1DRluy3HINPkyWgoNdHxtpyBsKZSOzSQqMjDqfYM5x8422Gvtkdbx2uFYAbD0cLslp6A/VqISoV4BBGjDiZJutr7JerLBRA0eRh7ulnTAVpkN5G+KV5oEkV9voPLbNuYMknlENrp8ZxQwB+XSd8NYbSQTCe/7DsHIuR7gVWlf0ct6s3Yg5GH1hgvpc/tFry77J89U86fCJMj0kEe+eqp+q1f3cBvbiSKH/XAXzz/2PVQ1JX7nRBOpw5uW06w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DM4PR12MB6230.namprd12.prod.outlook.com (2603:10b6:8:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 17:30:58 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 17:30:58 +0000
Date: Mon, 19 Aug 2024 14:30:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 08/16] iommufd/viommu: Add IOMMU_VIOMMU_INVALIDATE
 ioctl
Message-ID: <20240819173056.GL2032816@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <59ad8c075bfa9de7098fd79a30b51d1f53d61a94.1723061378.git.nicolinc@nvidia.com>
 <20240815232405.GU2032816@nvidia.com>
 <Zr6Ui1NBQ8078hRZ@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr6Ui1NBQ8078hRZ@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:208:236::16) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DM4PR12MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: 097b096c-c6ac-458c-3383-08dcc074aff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3eFed6xJFo5BVZin+AG5kUwLNmihm4CSR52ixQmBPMf09fVrXJg4nXfHHN9l?=
 =?us-ascii?Q?5gJRDKRVl2Shx8wX5wCuA8S0Bsf+1UQQFm4Kn1X5ihjv4z/FBkM1aCV20zuG?=
 =?us-ascii?Q?FLUhRO1Ymr577f6/h5jiglc/N2xMzeS/HiRahN253JLG454zNxbu2bJ1HBGw?=
 =?us-ascii?Q?jAqpk2Vo3+7LtC4anYs2FxhBmK1eeOU1zqmzn1dOpGUfsPFMtqxyz2fauCB5?=
 =?us-ascii?Q?oNQoLjGVoFpyuoCJKN83NT2sm56wfI+aaay5qe/5dDoJz5hgURLzN/hAf62k?=
 =?us-ascii?Q?WsBuZboQsM0W8fhDVefjVVTLXkjG9B/hgeaaLQU5wsU3X0XkFuZrf9ugIv05?=
 =?us-ascii?Q?SR3hF2r9k8QzMBWg//3UJfJo7AjVWH3OGdoQH1Ik67uyMoTrxSkxUGECLiQM?=
 =?us-ascii?Q?kQIb29P0Poc9hU0hreocQOZgaXdSKpVG7tm9YfRBZoVlA1vu4h/XfzMd1MsV?=
 =?us-ascii?Q?SPeTCxbnVweAkKdffztKL1X9BKwmLkgHZFJkYCZHfi02Oaa4p7oUzHD52j89?=
 =?us-ascii?Q?VZaE0ZDA8VsxllBWFcrmW/DbXtDQPVKteDe0szMtjpIYkJnuVfUAhQDAyuhC?=
 =?us-ascii?Q?htDagwIljK6o246vezo4VMKnrozSJEC5jf7gfECJhu46aKZOFfWNpMgA142U?=
 =?us-ascii?Q?No5nVFhARCDmIOfclwrku9+fbOI9B6kFt2xxZbIU26sv/SMcMgvGZBX5a7L7?=
 =?us-ascii?Q?9aGxWMVb4lDfLNf+KQeTO1/9wxjsB7PjG84yJv94RLPFk/A6WdCADKWhmspA?=
 =?us-ascii?Q?GmwHB4pH45525zwGJHcOeKm+xPAVzcoaVaP5t5sIiuIdttSbeudVRhHEOf94?=
 =?us-ascii?Q?Hq9VxlbM/ntW/rFOvySXhIZlqjXZECOr0p/OWTUWWfpuY2n6si3wrjT3herd?=
 =?us-ascii?Q?dNcOzCMX6qTOOMuRum4nZv4H+r33uq4D3NDVwfgkoWRnKbpQWrBwdss726Ct?=
 =?us-ascii?Q?i1Iq4MfVkQ7nn4qklc9lLaRWYd333dL2zCEKw+0gdc/A7ih+soExutkGy2Ba?=
 =?us-ascii?Q?DImBxO6r1EePWXYRgkqdrgdbBDvehfjm5ORoDjERnPSIgrPuuKMq3qmHfOEn?=
 =?us-ascii?Q?08r6LGf37f+ahbnQy/9t0cwAkFlfFvzBKQYOPuKB8Li1CsBma9MlB4TBBOGc?=
 =?us-ascii?Q?J14ml1bO3ReylFwbUk5s2+6gzMcrVea+U6p6sUjPNhdcjqybq7a42qj+sR03?=
 =?us-ascii?Q?fhUvyPNqGwOX5O2oNO2s8vUHfHeG8jQsiV+fh30zD18AfOeBpFYJ7Exmwo8s?=
 =?us-ascii?Q?2UCFiKwHsOiGwYseVIR8OJr+P36ZJQ1JSaeQqlcUfmhH6dF8D1EB7oBOo0iE?=
 =?us-ascii?Q?k/GgDoQClELiXvknPFbJyjpNPNges2hnbRvfmdgGeOYsEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8X8iU51HGzJU7xl/RZsEQH57NUZCV1sG+/RBwRwtME+wBZ3k6DExyi13a/zI?=
 =?us-ascii?Q?BNRL1RcokGcwMoZ3D7SjseNDZSfraUrOWAQGhMCT/gfy5B+xX5t0XWa4ECQ1?=
 =?us-ascii?Q?LeM0pWilANuVuSzlUZCk1PllWE7wHBlf0WQ+gNL8xcS6o43/Vz/79GxTJfuS?=
 =?us-ascii?Q?Euz/KU5Xi4aQRWTEXxrKsOskcnk6TzKbLwayJjmf5DdW4lkfovKnBcg2YGwc?=
 =?us-ascii?Q?Vrz2dhZxlMHJFL6Wy+34gvSSovEf386gE4abVfvpMjxyNIgzF8h2rxtn/bNL?=
 =?us-ascii?Q?mkfw1fdNCbOfRLp3brosO9gZZloGfEMnXE5ej9cECcg+T8cztTMeoIMd9Sfz?=
 =?us-ascii?Q?An7FY/gulbsp+BhYrj5v11r+O0oIFhRmy/JiacdUTIqSgRz5K6ELMWK5uiGM?=
 =?us-ascii?Q?msg3Baj6Kji5PfJNP8VqRisq6t23m5ZvuLj2MRw62aD68Nv5Kq7vsH+Ieh1K?=
 =?us-ascii?Q?LgJo/ym4LJe/YuNdypaCg5F93gXclz72JE3/eHLgw3RoPXeBmHRwjU5Iu2DE?=
 =?us-ascii?Q?h1Us0+owN4DMv9T7AAJ99AKTIm9Y2ebtStfKdRLZqyfs3Uotkd6VHMtGF/2o?=
 =?us-ascii?Q?d1gEfbr9oQUG97yoMLf3dXO0k9o7J2WoFDXSV+I7Kb7sYFkY0MUaO1+pzMCe?=
 =?us-ascii?Q?MnbeOTLTAwjIrtF0mNyaoCyjqKXyhzfTwEJYEWW6Sn0W4IFdSUi6stGGMxkp?=
 =?us-ascii?Q?QUvoMQviCUhaAs1WX26MqbtPn6Qi4LrUWVtVzBsthDIQy906NS864NmkGCrR?=
 =?us-ascii?Q?VcjnxCIW71aRAtwGVRYXmPysA4Lb6GcOPimUi+y3+MAYMDCVLul2ww8LhY3M?=
 =?us-ascii?Q?BFRJFEHLz1LVKwuj6ST4ETfJgDg7Uzl9Wjq7/9ttZy0XkDO9VzOKxbTq3nnb?=
 =?us-ascii?Q?rq61rcA6oALt/lxo48gYcouYhNUGB95OYo5SfJfJ+pkLvbmb5sLjQPWPPqfb?=
 =?us-ascii?Q?OgNbWodtLfBh0NLG5nKBrtKwNh7t9p7iq1HTVDjRWU47WLVxAmFUrFA/Qhnm?=
 =?us-ascii?Q?jXWU807JPhil0srcVlHu8zZLcP3JTdqbo7cje6nvSd+eBrfp+WAotL6cNbSy?=
 =?us-ascii?Q?Si/qzlNFG1IjrlEo0m+l9XmsJcqxui0TdWnd246eZ4VDm7yvDG4CO2AgS/so?=
 =?us-ascii?Q?dfPKMTmvgYio22h8wwXfIPc4VuIYYBiJVFeQYlpkhpw1M7TS8iSlvUQIWNJa?=
 =?us-ascii?Q?TL18YV8CFwdybmrb/TE8EzZtZNq89ck7s76WGb08xzm+DyKetl4PKG7MWRR5?=
 =?us-ascii?Q?ySFNP4oq+5FpbnkUPvD7/s8iF8Knaa20Pe931h02oco/Jg+I77juqGG+OkCH?=
 =?us-ascii?Q?s61+1cZnTcLD2EPhAASt2GEV7Lrm/dCE5TutgiwG3glLdqsrhcGedpwJnGhs?=
 =?us-ascii?Q?b9koJyAPl16hcg2ZzxnnPVuTHZDaNFKF+P1jLOJ7mD1PLN8QbfNgb5XL2UQE?=
 =?us-ascii?Q?mx6nhYMOFutJZ+izVowL1Qowy2hyLhN14Cvj1o338aJZMHMb6BaNRWBOzjF3?=
 =?us-ascii?Q?FDws1V7uHWfl1WHXCn61itSuQnHw1+CGd+DWnL+dzqKJPs3NaA67RZMpHYQP?=
 =?us-ascii?Q?C/GhD0CyMZVnGxgBVJm8Nm7K2Nru3h7E1ST7zny/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097b096c-c6ac-458c-3383-08dcc074aff5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 17:30:58.1949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPVKh9yT9xgmjFGgjucK94jy0gr89OWiUZPUS46Y6dp5ilQ1rvsC7Z2f3eM/4Qqp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6230

On Thu, Aug 15, 2024 at 04:51:39PM -0700, Nicolin Chen wrote:
> On Thu, Aug 15, 2024 at 08:24:05PM -0300, Jason Gunthorpe wrote:
> > On Wed, Aug 07, 2024 at 01:10:49PM -0700, Nicolin Chen wrote:
> > > @@ -946,4 +947,40 @@ struct iommu_viommu_unset_vdev_id {
> > >  	__aligned_u64 vdev_id;
> > >  };
> > >  #define IOMMU_VIOMMU_UNSET_VDEV_ID _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_UNSET_VDEV_ID)
> > > +
> > > +/**
> > > + * enum iommu_viommu_invalidate_data_type - VIOMMU Cache Invalidate Data Type
> > > + * @IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3: Invalidation data for ARM SMMUv3
> > > + */
> > > +enum iommu_viommu_invalidate_data_type {
> > > +	IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3,
> > > +};
> > 
> > =1 here I think. Lets try to avoid 0 for the types..
> > 
> > And this shouldn't be in this patch
> > 
> > But also we can probably just use reuse enum iommu_hwpt_invalidate_data_type
> > here?
> 
> Would that force IOMMU drivers to implement both hwpt and viommu
> invalidations? SMMUv3 driver would implement both anyway though..

I wouldn't say force, just that they have to use a consistent
numbering if they do choose to do both.

Jason

