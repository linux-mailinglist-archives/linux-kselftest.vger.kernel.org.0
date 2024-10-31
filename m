Return-Path: <linux-kselftest+bounces-21232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF569B8068
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 17:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B1E2286FEE
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 16:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDC21BC9F9;
	Thu, 31 Oct 2024 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RkKYAFeG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7367C14BF92;
	Thu, 31 Oct 2024 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730393024; cv=fail; b=oB45aVJvi4OBsGtAD6PsGpvZ9Zofbymkl00iTkFv7LHrSE0qWRaHOD+RmBePW15l89iqsc6hzcSVtpguczv6qmoDu/l2oTx3szGlbSSMwGF2VWhqE02G/+lbk+GmXg8OzBVjNmjPPhCodMl4WkYyPDZe6aXIUiGTsHFccISHMbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730393024; c=relaxed/simple;
	bh=VdM0VTxphDeT7EVJtF6odg13dmn/o11H/7DW75oBVn4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWfcc6bRnUVRDBaj48F6rgKRH3FP2ARhUxjBELfgdqYQ9NF2Ps0XAnxxfnKVQG0/mU5LssxuxX8/b4tDMVFY3v8TfZLMJpIUIoMGddGkfSAI8ZUi5r6X8bKGbR0INaJSRZ+KaBlKzQvbniL37sj4xhMKVEm05WAs/cbTiF2trz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RkKYAFeG; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUAy9RuZULvasatzcu+DtusXRu/VTJBzLNPN/Di90MwzXFMZ51HModCKbotZL2uc6CN++xouSsXYI+YBL6qVuiZnlXWP/csTfyPirRHpAqvWRtcQJhS/fWEetuZ4u5VegocO+y9Zd5gfqs8P/CkJxvoVQawweeesTdnbndsADiabth7NcLYtIXWDZStqGdLAqRfe71NxVTZ+d6A5A0RTcDPKQSP4O8Tnx/YMu9fMpkGrnY9EOZ/NK4L677fNX0cdE5C/Ng5A5gQOfEQBqjAigU1D0gpIhT5yuSxGvu5ewlcglScAabfa8LJ+2cdtluI6HVqJ7ByUZLXx/gn9M/eVIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAaFzpnGF0p+dTgbD0yWuLnPx/ZBY/g0wSMWPTZpIjc=;
 b=gTEXKbg5YSNKylZTF2cCpjIy5Ss1UgOpvrpnCxODFZboDsH0zrtakTbfB2/4bXA4sI+fdhd5BqIzJaP9Dd7fAE00iB+2fVKDA0dWHi8D0U++4xDJ8xK+tR9ScaRGoSmewezbo1/qMBHOQHqo41A/mcSxG8tkBw42dNvDcImoGbzVCejH1JCXTa7m8JZQ+aCEh+Tua719oYRp7qTmudBFKqzdcRESvCurM8pn/P9ZK1egUaKWFa4129xgdvIQrdBSYHQtXk4zSeWhy7DVCO4LcxDfZp08i2zoSuXR1iydAVnxLX/B5Pywa1YWfZbLznTYDaWpKcIJfdAbCaqm1h2R5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAaFzpnGF0p+dTgbD0yWuLnPx/ZBY/g0wSMWPTZpIjc=;
 b=RkKYAFeGaZmBv3IhHeuidi4zdFvxE+8igadDmav1okqUKtTvYkZUnuJJAn8kgb1WRe5fDyyWtBO5r6y9l3sf8evk4YuH1roDr+0B3xIroCHY8p2QLWLDYwn5BDNVWtITtHp8xYHhp+sb8MVOHCwiM5+dLT8fN7fl/9B2ZG2pmczdtc4WvIjAWkjXSfNesrXj3wziRERCAD+jCn85NjaCZY76s+9PoP7oboKAnlIIxwTv3u5ZlFp4ARWrr6YLBBPHVKp5NeIFrLzuNLkZwOlHkCYSW8wDBOWITfomZBp0Hzgqk9Zplqc/aMqlxnk8FcwVafn56fMdyr7MP8XRdFeZGg==
Received: from BYAPR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:40::38)
 by MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 16:43:38 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::f8) by BYAPR04CA0025.outlook.office365.com
 (2603:10b6:a03:40::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Thu, 31 Oct 2024 16:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 16:43:38 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 31 Oct
 2024 09:43:17 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 31 Oct 2024 09:43:16 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 31 Oct 2024 09:43:15 -0700
Date: Thu, 31 Oct 2024 09:43:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Zhangfei Gao <zhangfei.gao@linaro.org>, <kevin.tian@intel.com>,
	<corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<will@kernel.org>, <robin.murphy@arm.com>, <dwmw2@infradead.org>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<yi.l.liu@intel.com>, <aik@amd.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v6 00/10] iommufd: Add vIOMMU infrastructure (Part-2:
 vDEVICE)
Message-ID: <ZyOzolCmEcIZ44e5@Asurada-Nvidia>
References: <cover.1730313494.git.nicolinc@nvidia.com>
 <CABQgh9GYOgBJwRhvsWpPwS4vgDzCvXCAUxc8DQy8ObHAOvpbRQ@mail.gmail.com>
 <20241031115937.GD10193@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241031115937.GD10193@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|MN2PR12MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: b8ffd9f5-bab6-42fb-c385-08dcf9cb2b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NX7LiXtq4bwXNFKBeV3/0Ui+N2rcir2O9EDGHaJK81NXAnW65CRvL+pwoIsY?=
 =?us-ascii?Q?GNNv+ltiNXAvFoj2O/46LNx+9zvx2jVs3mqvKe1Qfxyfn1TYwfNq0PYCdXSL?=
 =?us-ascii?Q?RhK3FZudqjqkPpdZMVeDICasDJxdH3OjA3+ce9SCkkLpLPXJ/O48fZlX8Yx8?=
 =?us-ascii?Q?rLEjGAEUcwSs5L7uRify8f3cI6hVx15hpPHVTVzcFmheNl6zTnf/WFONtgAN?=
 =?us-ascii?Q?ayQl2ImUywfm0v1lf2UXkFNbal0mj0t0Z9XeRN3PAJmlge6GSdvUefljwUZ9?=
 =?us-ascii?Q?s+mXqhWyS5AC7uhIKeGDI/G8kGQj5akpeoHbNUKzV4Fw8I5KSuQ4SKO5BS82?=
 =?us-ascii?Q?f9PQJ87c7YrbUQXjAefDUXLh0bslJMomDu5zgiBxTyH1gLXOtTqIuF/2QbIj?=
 =?us-ascii?Q?u98ul9FeQCGSFeHzZvo7x//gJHMMf94Xk3DlN46bdjkmKDfqG8wcPp1TNR4M?=
 =?us-ascii?Q?u02FhKNyh7E+PkwI8EU4BMduqfZSGW+asM+r98847EYq/S0chCaKfE+aMMpH?=
 =?us-ascii?Q?qzkfcapxrDARkZaPm+P5ZgwLg7sGVlqCSyNJ6tNoDYLO108rxFuHCL/DieHl?=
 =?us-ascii?Q?o2uPym8QdUZat3JEQEsBQj2app4Ce9OhZ4jEfibUR+URCptZWSniMzVr9MKn?=
 =?us-ascii?Q?XOGpfYUD7Q93EANfQCEtgCIYElbBeUzTWhyNmuGxqr0fRU8SqF32swRKVrPz?=
 =?us-ascii?Q?7tTyG2X78YKDBGZwE2bvtNPLVf7KmCSoQqfnzLrVYupfHf/X1tBNjUuUfWtg?=
 =?us-ascii?Q?ePde14N7wewcrFmYkDE/LQWqEZ3gk2PzG5r4SvSJbRibl3PZrxqZTLqQlu/b?=
 =?us-ascii?Q?FpQJPn/Ii9PQRUZFZzrTJykUiIM1Iu+LFQCOM+uKdZcLv0pB0j3IJYOY/cb1?=
 =?us-ascii?Q?NYk3zInaPpi1UDvz+lESJQV4RQDBVa6yYwDQ8DVkzlXjgEGTVurWVNyoUTLi?=
 =?us-ascii?Q?dSfSrM98cbK16r44uS5XZ1Ke3eZgdXu74+R2joxS3moYfHtksgBkRbp3ZAdR?=
 =?us-ascii?Q?RYhN/DLOgwF7xHBZQydX2DtLLgtlYEQKgG5bkTstz+9Pxa6Hh9z/uSOIfFUd?=
 =?us-ascii?Q?rQ++6KS+Qnd/rSYSncqGL0ZHfjFI9xOdVcsmufaTlgwf20lk1dfr/xlY16CT?=
 =?us-ascii?Q?DCBilnu7rBrBR7I/eM6Sa6faFg3U94MMn0oCMoJW3eF4abSqcuUNoamqnZFv?=
 =?us-ascii?Q?LURNJsb4SURhb2zb21IUZK8FVwthn3Bs5+fVR1tc2anJPh/NyUh7SyrqMvvk?=
 =?us-ascii?Q?zeOD4ocihhU56yIBQAxAwPFXMipVanwStjSG2Mteut9q7qg7KCQpR1Hy5WTP?=
 =?us-ascii?Q?7KOivAol4NHEwoEcZqB2WVuBtogJ2xhJEgMF8H9uUcFFkCPn9cMxOoaBkEzu?=
 =?us-ascii?Q?v+9543fLobstqFRtPaAf6kBpuY23GkLgALncBWx6wUeL3CsL0YuZjcfg77ry?=
 =?us-ascii?Q?OMJOK+pUGhA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 16:43:38.2205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ffd9f5-bab6-42fb-c385-08dcf9cb2b74
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285

On Thu, Oct 31, 2024 at 08:59:37AM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 31, 2024 at 02:28:12PM +0800, Zhangfei Gao wrote:
> 
> > > As for the implementation of the series, add driver support in ARM SMMUv3
> > > for a real world use case.
> > >
> > > This series is on Github:
> > > https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p2-v6
> > > (QEMU branch for testing will be provided in Jason's nesting series)
> > 
> > Thanks Nico
> > 
> > I tested on aarch64, functions are OK.
> > 
> > But with some hacks
> > https://github.com/Linaro/linux-kernel-uadk/commit/22f47d6f3a34a0867a187473bd5ba0e0ee3395d4
> 
> Hmm, it seems like we should permit IOMMU_HWPT_FAULT_ID_VALID domain
> creation on ARM?

+1, since we proved PRI could work :)

Thanks
Nicolin

