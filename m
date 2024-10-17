Return-Path: <linux-kselftest+bounces-19977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8679A2828
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 18:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9EE284118
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 16:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F3D1DED69;
	Thu, 17 Oct 2024 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="awPXCI6w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1D21DE8AC;
	Thu, 17 Oct 2024 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181542; cv=fail; b=RFZXa1QZxNpLxYSFXX7vSvdV8dDDg5geTb5j4GViLGNDIDtzaJhAWllaFkIiAGOi/im1hrv4Az8RkbiubdE6IV8dM3p2Fk/ei2HBtDFUSlIY88tllnwj7+SCOwH1jmQ7tda+vOX43dlaeYp8K60CsHAdA0pVdov+/XaFVzhWz6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181542; c=relaxed/simple;
	bh=VJe0eBYL/0S4vdckbzXBu2rhAR69BqF+m1+J08SWeOM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkWv7QXs+mnumr8BUxbRX0UKFmScsF/P4NvPamxA/3jgY7jNr0gKqcX97BuNYDgA4COieAdrjWoY05FIizsKRs2y8kEEnH44SdAApj2pq35JVjI/AZdXmSCjiG7yEMa1P7n2mDhGmwmk+B0xUjwN4eT/KS09UOJLHi8w+V+qEvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=awPXCI6w; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JogSJvkSdLR588toTvvV493I1mFSi23nN+Ubf1XZObVhbf7vtDnvge+2Ntxq2ON0DPcE0CGNDVxv2pZHHNCsf/9ODHVxC8YRkbAK7tA+9cTWpnhSCacDm6L4derQEcOzPeVQFp7RnRiE8+fIUZgCd69lLDqQ0c6wPVLG23Uf6Yqk0LWgwlIA5jPFEiCct8UHicXzCXexrsrTN7lblMhsuioLr/qmJ/FfAvWdDjhP3pGDlECmm0XcO/phdsaObdQ1CcSf4jnZAikH84UhcOwXKtsEJE1zFzrLZZp0wnMvaiHZyWC8eAm+fB2RU2sB2i7PcxEUrBFnpgXR9VidIWCHdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYdlOPEC6aFlOBr9MCFTI7Xes2Xa4vdzOSZekxCpq+8=;
 b=aihCSeY3mIgxk4M59gIOUQ/hiUHIHE9Z+4lxHK5j+3MMJTQvZb6JF15oZMLwnov0RA6BQLidIGTNyZyrCBaO7DWnADTSbhd91raVKy+QCaI199SbtTUvsJqP8+94ym2gFAEjzeO4wBThBEVl0o8gf54EpcJMJtuVZNBnhbXwe2etlFKw374OzqwWiAvQI9W024uBeH8oHd7/s9hqQEvBiUJKyA0uyiKsh0C15AgzGFRQLWhARpcjrRams1TYAEwkegxle5opY0Tw4HO4XPTBmTuapduUOjwZKU0LMzALa0IpZlj9ciM+3Q1f1c2mAs0semrvxO1aqoC1mMFb2fRHnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYdlOPEC6aFlOBr9MCFTI7Xes2Xa4vdzOSZekxCpq+8=;
 b=awPXCI6wVCVkn2C6LYCoS9Irm9KtEuRORgwxZSZolHupd02UHBVb56scnQMZueo4Q46styfA9fA1YXQFYPkJtu0//CLCqebPWH4QsMMwAG9Jv4csrFzC7+NF/+xarVWSno9G/H7upSD14zUqtSKpaxmXUMwqHLG9tqrhsYxhUb0wKTMMHm0P+hmBb+7AePD365Hd5MQH4HwPKJN1wN4aGlhx+veeJxgJRIKVy83Y8maV3aUqXaZlgfhq0xOkXgnuu9Rb2PoxsPcSnwzidGbF1Oy2L5P4UREmJChev86wTx1p22+o+5uLK1Ov12AiT5kPAqF245a4BPH3WXMcZ3EghQ==
Received: from MW4P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::16)
 by PH8PR12MB6675.namprd12.prod.outlook.com (2603:10b6:510:1c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 16:12:15 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::c2) by MW4P223CA0011.outlook.office365.com
 (2603:10b6:303:80::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 16:12:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.1 via Frontend Transport; Thu, 17 Oct 2024 16:12:15 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 09:12:06 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 17 Oct 2024 09:12:05 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 17 Oct 2024 09:12:05 -0700
Date: Thu, 17 Oct 2024 09:12:03 -0700
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
	<patches@lists.linux.dev>
Subject: Re: [PATCH v3 02/11] iommufd: Rename _iommufd_object_alloc to
 iommufd_object_alloc_elm
Message-ID: <ZxE3U+9lUXwDEBx5@Asurada-Nvidia>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <dbfc718cd3200071765007c7ca0a2ba242181d05.1728491453.git.nicolinc@nvidia.com>
 <20241017141416.GZ3559746@nvidia.com>
 <20241017153749.GA3559746@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241017153749.GA3559746@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|PH8PR12MB6675:EE_
X-MS-Office365-Filtering-Correlation-Id: f4ca252d-7678-459b-7264-08dceec67758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jTlrGVUdMloRE8acDYBuZUcQi4+e5hj+F/BaOoA2DwDvG9oPj6IuBqR29ZN7?=
 =?us-ascii?Q?Sb3PZ9UpYiKBD+aj+9bcTUalJ6zDsncEoMb81T4Jfeg5vCYA1saYhTT0SQma?=
 =?us-ascii?Q?qsr4vbIqq7846dj5kL6LpBfzBZM1QMYMwwRtPn2aWGHzLmUhfKvVjX6rs6cT?=
 =?us-ascii?Q?UXm5p1Y/wzMYtmuNGZ160Eik7ErsuoC4XWhiy53flmME8hwPClTxUkiH+6Gz?=
 =?us-ascii?Q?PFrqyPqN8SDLHc7BwZuzvEtSuZMexXiVzLBN92znZLV7bIJCzRcaRYBfbX7b?=
 =?us-ascii?Q?UlGntczSQhd0t1zK/lDzbFW4w6gLPQ3Ick+nqkIMolnxF5mASs/PGyhB2CTN?=
 =?us-ascii?Q?wBUyEEugOVrCs2lEv0Pmy9ITsF+yCQlMIKbIVUo5oHNlSBOLTV++0czUS1a0?=
 =?us-ascii?Q?bTbC6x/pYa5soT71+vYDUljSX7cByXAp1+dbxx648UfITUBt0J4g1mo46rtz?=
 =?us-ascii?Q?W9qDaMQL5Npk7dP0JpvfryfswC7IEE+r8oh+Z4GC7k/9Rmu3AA6ta7njc33q?=
 =?us-ascii?Q?wuosHuaDkIQGpYuBPuXhvoloo1rxbFeGW1WixjNG7c0XiMjcSH/JMSvcK1eK?=
 =?us-ascii?Q?LUcmmHaNT/cfAw62p4h8Z7YbK8Ov4EM/EyjFTzVxfjH4cUxGGPFdprpY7yzN?=
 =?us-ascii?Q?nXw+UUDn5iBpUs5z7Ul65v1IIQToVl0TtMCtcZ+gnhcmAMg+Z9AuOxMOOIT5?=
 =?us-ascii?Q?kRWcYjoMiUx+H3Am3mZdAkeT7d2ev617ZfF4AtgiHXrjSWYpN3se8zm7kTEc?=
 =?us-ascii?Q?oMER01k21tsvs0t7LKdFsXglkDlhnNU0ammr2a39TlYseYxoKdtZx5By5f2a?=
 =?us-ascii?Q?WgQ72iKfljndTjgD52O2zZXE5nFEJDszIWIQY97A19sAyTh6VsISsuY7j/E9?=
 =?us-ascii?Q?t5zeDlwUfJDOihP1ZU62GkLxwA6a+68ckT5vDpI3aJy0Dh8/R8xKcuhxlGqJ?=
 =?us-ascii?Q?2BOadYrkv9RgUgLA8pme824kcEtv+PXXp5Lxp1eJHQfsWL7cb3Ivkb+aR1kb?=
 =?us-ascii?Q?Zw9sjUuJLVyYg7QlE+EOzCU9D79N0kJbeCFwzB6CQL/ZObvBIq9pnMeSYxeA?=
 =?us-ascii?Q?xjNS6lc00o8VYNGEY3yg/5IQ1qwqVAXOLiEHEjoLy+E00QVFC9FRvToN9e/J?=
 =?us-ascii?Q?JSuYl0CW43Qqaa3kSA2QlbKE/v2ce+QUej+jQ2XmwpDPGjJg947imUX0dNCE?=
 =?us-ascii?Q?cjs/LK9gaDVX9AfwSZ5bdv2Z2ZxMgIwnTX1HuXBgccMK2+xfc00ZzCfGuo02?=
 =?us-ascii?Q?oCQ4VDFsxaoevSywHTeEyA5/1ksuSNnbqo8Ea9RYjWS2zuNwdcsifxKUKcMj?=
 =?us-ascii?Q?alnLxRc91OPYYUOEPB1XKbdV3cUw99i1b6hIXzjkBgh9G2XsFQ5BkU6uYR9U?=
 =?us-ascii?Q?4CQnkdELGq3T+IXkgrNlk4iaj/Qf44vMBkgvMD7gGLnSt+y3AQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:12:15.2363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ca252d-7678-459b-7264-08dceec67758
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6675

On Thu, Oct 17, 2024 at 12:37:49PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 17, 2024 at 11:14:16AM -0300, Jason Gunthorpe wrote:
> > On Wed, Oct 09, 2024 at 09:38:02AM -0700, Nicolin Chen wrote:
> > 
> > > @@ -217,12 +217,12 @@ iommufd_object_put_and_try_destroy(struct iommufd_ctx *ictx,
> > >  	iommufd_object_remove(ictx, obj, obj->id, 0);
> > >  }
> > >  
> > > -struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
> > > -					     size_t size,
> > > -					     enum iommufd_object_type type);
> > > +struct iommufd_object *iommufd_object_alloc_elm(struct iommufd_ctx *ictx,
> > > +						size_t size,
> > > +						enum iommufd_object_type type);
> > 
> > Maybe call it raw instead of elm? elm suggests it is an item in an
> > array or likewise
> 
> Or keep this as the __ and rename

You mean "_" v.s. "__"?

> #define __iommufd_object_alloc(ictx, ptr, type, obj)                           \
> 
> That one to _elm like this:
> 
> #define iommufd_object_alloc_elm(ictx, ptr, type, elm)                           \
> 	container_of(_iommufd_object_alloc(                                    \
> 			     ictx,                                             \
> 			     sizeof(*(ptr)) + BUILD_BUG_ON_ZERO(               \
> 						      offsetof(typeof(*(ptr)), \
> 							       obj) != 0),     \
> 			     type),                                            \
> 		     typeof(*(ptr)), elm)
> 
> #define iommufd_object_alloc(ictx, ptr, type) \
> 	iommufd_object_alloc_elm(ictx, ptr, type, obj)
> 
> Then you can keep the pattern of _ being the allocation function of
> the macro

If I get it correctly, the change would be
[From]
level-0: iommufd_object_alloc()
level-1:     __iommufd_object_alloc()
level-2:         _iommufd_object_alloc()
[To]
level-0: iommufd_object_alloc()
level-1:     iommufd_object_alloc_elm()
level-2:         _iommufd_object_alloc()

i.e. change the level-1 only.

Thanks
Nicolin

