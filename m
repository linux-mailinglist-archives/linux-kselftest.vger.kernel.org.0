Return-Path: <linux-kselftest+bounces-21075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B382D9B5A99
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 05:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E6DBB2361F
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 04:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C1D197A8E;
	Wed, 30 Oct 2024 04:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cion+yf4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99A119342D;
	Wed, 30 Oct 2024 04:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730261321; cv=fail; b=FIx7PAy7m0Hs+9oOLGAXaNVyQ7aULtuROFwKX6dUhQgD5G542/bsMMzrWMl0NrLVUc58cJt/G/ClaikRNINItpd7oYJuB9UJgP7bFJp0ERzl9IBhLCAn9cwq82+lL7S9J6ejE9YPAwziCN4QRWXC0QDvOTHztfCxbz4vnLQyAog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730261321; c=relaxed/simple;
	bh=GxcF19lh75+Prf+R34XrVOiTwS93+5mMriTeETI1GOw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVUhzLkSv6wbZ2fgEJpwSCm37r4JgHvdDE5uxk0jdP4IO8NaQvZcloK2dETEvU61A1DRNgbIvCf6z/e+7Syfv3yOr8NDdCqoO2ielHMPElOZkKwiA4myGLiNKgxCTWXwI8hkDr5aGSpelz+l69a4wVcUyPmYSdVb/Bb30r6uQlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cion+yf4; arc=fail smtp.client-ip=40.107.100.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dar8nzGohmpUqS0/fMPN+81HbdDyXdFZKfnItKTpbLtoxDre02UtLyTwBVIPhD7W8kb6RmQhonb2CdoNYCH+axdZBd7Prs7by0e35iGwIojS6qES4SJqYOhh6+DLQNw7A3zuk9EwlmlfZrny1+9SVeHPJU3j9rQwySUKC1iL3qz5LvFWwN2HcknZqnqZyk3evypgDond6VMwXn6mS+49a2oAwAniA7OZj+YJ4SDZUZH9PROFY2CWlQuWmlK8PGL0QDs3y/izZCHMfPidtjACPm5hkHbS93qyy/uih+vckmDYeXw3nB/MznQKPRsAvsXNQOVPGRcUttRkE1dDpDho3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsVyI1VUpqBk+pGl3kmQOl+bBeTI0C/Yl62jkn772wo=;
 b=nllHGFsjLQ45VJS5hjbOEKL/lW7jz23pAUjdk9iJFvjcsEsMvGCyTX7C7r60KKx0wQ4UQHpkfKofpceceXgWCTB4RrgkuEqRtETKSlZF2q14a+wPgI5GCw4BCZMRJwYeeAbZcjNIQWnFkBAXPCJrbyRoBz6yLV40MEbJSj/fwOJs5OkZPPKCjpr7wOwJuIvVKBZYpR/fUyXzaf3RX2a+/3brI4Ujt1ljqv6jnorLuFpQYv9N74jYSp6+vpsks/Llk/Q8xzBrxO3XZzIK9iymfuhKuQMsbYP5Jn4Xp3pYAhwzsjA/oRbCzuwZ3UAcTVzFGz5LaqdAKoreAdsNDwp5eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsVyI1VUpqBk+pGl3kmQOl+bBeTI0C/Yl62jkn772wo=;
 b=cion+yf4XLFRbmOSeD9l5vDU4e1Ik7T4yrSooBQ+cYp4p6yfGQIMFtePC3TQ2Et7yeR1gRCjfu4DTBdW1TlFDoVEGKabpI8YlahzYbePCG2gfBoIPMnM8SS5FEXnb4CTjxUG4fts7ZaMUBas1vHlP+PPswZzmIZwGzpMoKVd+YNVjK60UaeDoJMQRIxiP9ns68hB7MQVyz4+DO7GL1ojMMdy+k+J+ZyXJ3xC7GEWPBlN4IrFlr2GWS/jQf8kqjcxanyneL5ZDBn6+ufPQVXUz3t3yC4VdyFLUOr+z+J5d/cn3PQYZNRRJrxXRlTBQubWAOPFT7aozBgseJZ0N4YVSg==
Received: from DS7P220CA0043.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::8) by
 CY8PR12MB8410.namprd12.prod.outlook.com (2603:10b6:930:6d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.32; Wed, 30 Oct 2024 04:08:32 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:8:224:cafe::f2) by DS7P220CA0043.outlook.office365.com
 (2603:10b6:8:224::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Wed, 30 Oct 2024 04:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 04:08:32 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Oct
 2024 21:08:18 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Oct
 2024 21:08:17 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 29 Oct 2024 21:08:16 -0700
Date: Tue, 29 Oct 2024 21:08:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "aik@amd.com"
	<aik@amd.com>, "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v5 06/13] iommu: Add
 iommu_copy_struct_from_full_user_array helper
Message-ID: <ZyGxLusNj3kDYAxt@Asurada-Nvidia>
References: <cover.1729897278.git.nicolinc@nvidia.com>
 <d22517338a5c2bbd4c1bd5569f4409412206e100.1729897278.git.nicolinc@nvidia.com>
 <BN9PR11MB5276B02140C9F5021622CB388C4B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276B02140C9F5021622CB388C4B2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|CY8PR12MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3775fe-a618-4ce2-c427-08dcf89884cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UOak1QH5eecSXgkJecRzeA8JAg/J1gYjOFiuTbTpzTSUYT/DfKRxuNjksvha?=
 =?us-ascii?Q?quZVLrd2Jq7RKFejplbDfvdjCaH+OrObfuZL3T1StDt8ZuSjgHSYRDBDsVLZ?=
 =?us-ascii?Q?plFZKGQOi3kBs7Jr05AFEdxvwOhHVkQzU99L9AclvOFe5ltyvLDxiuPZXZ6r?=
 =?us-ascii?Q?2jSFjUkSuLzomB2LGPqZ4cN6mmoXdRIFAWzWGKJIEKJfCVCG4NM6w6R7xqW+?=
 =?us-ascii?Q?AVwQwmUS21ax7OG615h75iiMyHF1oLq/42MnTjv1eFmFH2OrxsC0wXAoJm0x?=
 =?us-ascii?Q?2s2zSqAEvxyMAVepWuDKXYsS3V4nj7vTYi7usIdpBjeTUYqU9P+NonxSgvwf?=
 =?us-ascii?Q?ExopoXPF0CVFcqwZe4EE0/SVoj5a96J30oYYJ3Cd70bWHG3TlOrU1wUc1hlZ?=
 =?us-ascii?Q?yRGay/QE3QDLGCtdeplKCl20N5OQ8C7uRLUM/E01T7MLOWLa624frart7DMd?=
 =?us-ascii?Q?pl7nsXBiEB2eCX3ScZpEPPB2vpRK7fgLoWPt7OyhYU7AOjcl2PcouhplKiG+?=
 =?us-ascii?Q?pOODVK+51QKjdEnMO3/B/znHGcEmTEo3+D6WaEyjSfIGQOBPdK+NRWI1iqoW?=
 =?us-ascii?Q?ckLDp0JY+GlV6LaZqOVFbb0XQkWHPXK2h8qe1q/X3u3eoM3/H0JsXdRRHGlo?=
 =?us-ascii?Q?ezDNzRpOZtB68rGXzwkADXqik1CEpIWSr6qrzykL8YhxbMn1Lgodl5Xtx58v?=
 =?us-ascii?Q?u2GJe8fEUAiTmF4tiuVELUZjBEEivrgaDZAeDhNDiOqJbHt5vF289Ab8wC3S?=
 =?us-ascii?Q?XE054k3vqOtGWPPQq+U+6CH9k7fYq88ewImPz0P+Rmy2kqHf3SztNmbVFbAX?=
 =?us-ascii?Q?lpvEp2hgaTZVSnvzSqb1sUKG35vlEcUUT18rWC3UERylNz0XP/qYgcCh7Agk?=
 =?us-ascii?Q?Hmtqs5Au05dO8a1UdDfDZ8reqUDqUFLP1fC6Sj63xOJMCHR++15KqlCZom+n?=
 =?us-ascii?Q?r7r3FeUMRia+KSw1vrkDvTUEIPGgfN4tXQ/0MgftVhly/PtnnItef22iujF5?=
 =?us-ascii?Q?exHFbjGUAL4nD6s7c7vqtXlPw5r5dZNV11JppaOpnxKFlPqq7Mx00EbOZmlv?=
 =?us-ascii?Q?dczQdzvAz/3tjufMWAwqD0suYpdyfitlbXwgxw3bquDgqkD3EkDEV+yFMwkw?=
 =?us-ascii?Q?B90EP1eDFpMoXPjb7fqE8R42bHIeTC1ev3j4l1GCM/11/8fr6wQOvqnmdedB?=
 =?us-ascii?Q?XJJCXKbvUThcbvnN7aM6efdfehnSvzpfeXYl6AY3z+bGpfS+q3orLfZjXKBt?=
 =?us-ascii?Q?iyVqezP2PwyeLZqjnThLhLYqr2mZ0GTPNHXjxjeEs5MelCoRxDf1a3Ik4zcV?=
 =?us-ascii?Q?P0vOq/GaUabGstVRHT1/jfsdsal7i7Ol1T+JZOMKISaxhNw/0749k+x/62Yx?=
 =?us-ascii?Q?9ap1AnwVBHLfaTWezifYjlvHgrjzDzgKtS82aukF7khBkydf3w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 04:08:32.5131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3775fe-a618-4ce2-c427-08dcf89884cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8410

On Tue, Oct 29, 2024 at 08:24:52AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, October 26, 2024 7:51 AM
> >
> > From: Jason Gunthorpe <jgg@nvidia.com>
> >
> > The iommu_copy_struct_from_user_array helper can be used to copy a
> > single
> > entry from a user array which might not be efficient if the array is big.
> >
> > Add a new iommu_copy_struct_from_full_user_array to copy the entire user
> > array at once. Update the existing iommu_copy_struct_from_user_array
> > kdoc
> > accordingly.
> 
> what about:
> 
> iommu_copy_struct_from_user_array_single()
> iommu_copy_struct_from_user_array_full()

I am okay with that, yet might prefer that in a separate patch? As
I am trying to reduce the number of changes in the series since we
are likely merging three series at once :)

Thanks
Nicolin

> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

