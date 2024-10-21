Return-Path: <linux-kselftest+bounces-20294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEEA9A7233
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 20:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B185CB21C98
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 18:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC761F1307;
	Mon, 21 Oct 2024 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sJpyo5zk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74D8194AF6;
	Mon, 21 Oct 2024 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729534903; cv=fail; b=u6QxYTndX6P9iIN0RARdlU6OY5+yjuX2F+H7560epJji1uExkL68XMsGXiPtKxvVFoDeB5D5gxlkyXzBDX5MJKQZMuHdVjIwykQTxRDAOEgYXx7BqLM0pk8P2La224AnRM6LSv9/69f0eRnV+T6RMRlnDtdT1iqMxy8q2lMF97o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729534903; c=relaxed/simple;
	bh=Ax8oRzbvL6wx/Py3yXAs8IgpRTK4NwvLxLYHOhrHglQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4mzHQH0eQSBjbeEvnvn90V01PBD6UpiYVwKS3EzdzV5XgnroH+kAsOFRpOUXMqpasSl/AfZ3X+WZnAowpytUmk6sPOKoIu7GNhvPRyFSlzhMlsSRYUbH6SzrbL6DdCxNoKEjEdIomclcnp+UyC6QQqhAykxte6tThI0KW0GjL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sJpyo5zk; arc=fail smtp.client-ip=40.107.212.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWDgfq1Pk5jXZBaAvEmL3ASgXok+6L1h/S5DJewuVkciV6PZhGiofVQgGFyXqqfc9X8QiFKb4RgI8WmknFS+thylb1pVYglcjBQx9YZjGLgOoV87pMMrNjn5jofLBSL5WJ56rzQZ2sidHnRZr0RIlkpw3qmucGgF9Int+5H13DQ7F5446j8Lj1gtTny+tnopABWzvcDRoQHHOML3Se9hOci2hHexiSTZT/C+FGo6SZP2X5/nG589sctPUtpwNQgCMVSeshrXNYJR18QFB6mcI2ynLzhE0Z3Kd+PAX5EC9WbjhVJlxRQbm912i8eWuI/rPAy09eCqx4UQBj5mg/XhPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hwGpcslCzp3Ko8IDqz7DUZCh65HadM1eUm5bwt/ai8=;
 b=zEEvbZUxYGb0hFITn5ZnEtDDgNcAcTSrugQ1afwSsbWhqeLd2/GFzIg//Aa8fDfM+lFXEc2zTkpbU3tX7aZEZE5k4Her+ZOjRILCoYH/6qlr/ezoqeTrTRIDgfAjvaQBimFVyZV1kzebI+6MNzbB40CNGYngAdck85aMBzja7dRCAgvOPkkuKjwdkmzcWvZP+tYU4aZZ+126VVlIz3bVUKgmurWJJ++6x+x2hYlK+FE8UL6LVMBR8SOSBtx+g/00hPw3dedF0AxRl1kuTS0du6m0IL8klgPXOcAksLzd9dz7BT/bMnlPZoo2vVACqWvElRjkZUlblDuSROq9kK0jdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hwGpcslCzp3Ko8IDqz7DUZCh65HadM1eUm5bwt/ai8=;
 b=sJpyo5zk2dOlIgUe2oI4W2aUy6po9uuObL0Zar6quQB1ViHvGRlHLMFy/fE2idh+WxBkc2+nNh/ST6rtjaDU7Oe5H4Sq1cRzDbiST4CJPvS/7mKzhFffxD52A4VDZCmnrVy3EmqTR9BMvs419q3MKxytzAMMYwKcRKLUSMTyvc+WbNmBDOOWlCvMfVGGchWpdtZqM87yzTj2Sy1YERakltWPQivbaTEqV+kkMKiKn2qvz+nfPPAYVL44X07VgJt4zF2D85jbV7u4xdYchxT9E+BQQN1zep5isq/DoO+wrS5JROebOslkz/eCCOXro3SbL8jKK+J46QMIzMQAGtYs7Q==
Received: from CH0PR04CA0004.namprd04.prod.outlook.com (2603:10b6:610:76::9)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 18:21:37 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::93) by CH0PR04CA0004.outlook.office365.com
 (2603:10b6:610:76::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Mon, 21 Oct 2024 18:21:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 18:21:36 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 11:21:18 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 11:21:18 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 11:21:17 -0700
Date: Mon, 21 Oct 2024 11:21:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<will@kernel.org>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v3 02/11] iommufd: Rename _iommufd_object_alloc to
 iommufd_object_alloc_elm
Message-ID: <ZxabmyAYDeCFXHzO@Asurada-Nvidia>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <dbfc718cd3200071765007c7ca0a2ba242181d05.1728491453.git.nicolinc@nvidia.com>
 <20241017141416.GZ3559746@nvidia.com>
 <20241017153749.GA3559746@nvidia.com>
 <7c5fc87d-0025-4770-86f6-8b48ebfd817e@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7c5fc87d-0025-4770-86f6-8b48ebfd817e@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|DM6PR12MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: cb531dab-0dd7-45b4-5b20-08dcf1fd3354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?76Y5EmuUWFwOOW5qAWG9c6lcl8YNAI1v31ztrfolTAC38FY0nkzfUmyORI7a?=
 =?us-ascii?Q?w7Wfd5zZy4gdSdxPrCR9KJw74LWToMWE87S7a2z+bLU4YIPX+F8VR7sjHkkX?=
 =?us-ascii?Q?hEVo+kFTJd0Y8ukXB5baSjt6OLQQ14Azh38mTbtgzG4vluMu3CfbHPUOaiFx?=
 =?us-ascii?Q?q99/oTxxTzrUUPPQ0jTqTJ5UTuitPq3C3rE7AowqhHBR5zD1bRM430Hq5PVR?=
 =?us-ascii?Q?egm6u0oWuxADkrX9X7q4VK05/bLFjrpmeZKSwrrxayjiVS6JJktYzUM5ME5g?=
 =?us-ascii?Q?JMe+SWVUZE5SFVNK6xcXOj4zGyOfWE2b+uclT/cuA1OYrp7FTr69aWB1Y0L5?=
 =?us-ascii?Q?hXioU5bWMhms5jvg7pntPFy8bvEdXIpwSmURLfOwGQcC8C17oYquW5oW/UsN?=
 =?us-ascii?Q?ZLeLDeK/uBn7OcuByW3dkgXmyvupM6vU0Xx5+VMV9Ogi59Yszl3FxmYzwAdl?=
 =?us-ascii?Q?LVplCOpCPNIlDGjPIFiy0k5AeT9W+6ZbuW7qNB1c5EFkAQVpxvczjxNX3ylU?=
 =?us-ascii?Q?khfn65nM75hB9a3EROVHg+IslwheA6xXcmSsORbZ+X0zXD2jg6AEp035WJTd?=
 =?us-ascii?Q?RYlR+dgolZd/Xe6zYRFFcfx8FfAOUu/Mqa5ZgdD/HUsNSnjsPL6+rKV6wpBc?=
 =?us-ascii?Q?JqRhiMfEMoMSGqJlMrB7yZfLtt2ebG6f8BRHea7VB4ozVkm7D/phOCDZYfOE?=
 =?us-ascii?Q?jYvv68zbpUakFOWvXjLzolBYf5zbGWchC1uk1DKnVvkeV1cM424dNM7o2MxO?=
 =?us-ascii?Q?NJ5bCp8lkcKnPcio96EDUNCVTD0V9S2kv4AYvZOIX4C7q2VmPQUyOoLQnmRK?=
 =?us-ascii?Q?5boPkVqld5o3NkRBNlPYrRlhCSjdId7mSl8B/CaWXqCQbd0uozbB6OsAD61q?=
 =?us-ascii?Q?Waqdgum6UzJWeClDuS4x/p990akzzNUjlCvJSGzyF7mJhs5UcQOwOHxW8dyf?=
 =?us-ascii?Q?4CzuAyr9rjo6Lqwgvel5IAKY/sjr1YO20jLRtIQY00PZCz/FsYn7R0+Ma/Tm?=
 =?us-ascii?Q?/RRuPabCQ7xBY/YkGPPJMYwqcx3EKqLvGNVtIwkSSaUndk17cowFfUbXF8Af?=
 =?us-ascii?Q?vH/cuJEYawWcvGPaiIEIivyP3EUN0p1SyTfIkrGismVLI8oAZvHa+4vB2qX+?=
 =?us-ascii?Q?D6wFAS2u5wlzKIgr0Dmv6IRPBegxYoNnJb+HC4jc3KGo+sPnThH18/gczj2D?=
 =?us-ascii?Q?tuZeOMN2wJF+tXrGD3mDDYOz1fVqeQnKvOZWmRmV1nf931LAmCL+4LNsCR3P?=
 =?us-ascii?Q?Ng2LUlJrHPiyxBUrvIw/1CmikSEqvydVwSMoKm8S3rSGKzmrtNEwnPJhGZp5?=
 =?us-ascii?Q?IrhGujdGQsvc6s0bGc0O+RAT4PmuUQY0qLivkcjduAPGFOBEgiLyw10fEYfK?=
 =?us-ascii?Q?rmEGNaVUeAmvH2uR1/OliqdJaY+YuinfiYdnrk+FA73TfoLp/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 18:21:36.8391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb531dab-0dd7-45b4-5b20-08dcf1fd3354
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483

On Mon, Oct 21, 2024 at 12:26:54PM +1100, Alexey Kardashevskiy wrote:
> On 18/10/24 02:37, Jason Gunthorpe wrote:
> > On Thu, Oct 17, 2024 at 11:14:16AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Oct 09, 2024 at 09:38:02AM -0700, Nicolin Chen wrote:
> > > 
> > > > @@ -217,12 +217,12 @@ iommufd_object_put_and_try_destroy(struct iommufd_ctx *ictx,
> > > >     iommufd_object_remove(ictx, obj, obj->id, 0);
> > > >   }
> > > > 
> > > > -struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
> > > > -                                        size_t size,
> > > > -                                        enum iommufd_object_type type);
> > > > +struct iommufd_object *iommufd_object_alloc_elm(struct iommufd_ctx *ictx,
> > > > +                                           size_t size,
> > > > +                                           enum iommufd_object_type type);
> > > 
> > > Maybe call it raw instead of elm? elm suggests it is an item in an
> > > array or likewise
> > 
> > Or keep this as the __ and rename
> > 
> > #define __iommufd_object_alloc(ictx, ptr, type, obj)                           \
> > 
> > That one to _elm like this:
> > 
> > #define iommufd_object_alloc_elm(ictx, ptr, type, elm)                           \
> >       container_of(_iommufd_object_alloc(                                    \
> >                            ictx,                                             \
> >                            sizeof(*(ptr)) + BUILD_BUG_ON_ZERO(               \
> >                                                     offsetof(typeof(*(ptr)), \
> >                                                              obj) != 0),     \
> >                            type),                                            \
> >                    typeof(*(ptr)), elm)
> > 
> > #define iommufd_object_alloc(ictx, ptr, type) \
> >       iommufd_object_alloc_elm(ictx, ptr, type, obj)
> 
> 
> Bikeshedding, yay :)
> 
> After starring at it for 10min - honestly - ditch
> iommufd_object_alloc_elm() and just pass "obj" (or "common.obj" in that
> single other occasion) to iommufd_object_alloc().
> 
> __iommufd_object_alloc() - a function - will the actual alloc,
> iommufd_object_alloc() - a macro - will do the types + call the __
> variant, simple and no naming issues.

All three-level helpers have callers. So that would be a bigger
patch than I expected to include in this series. Maybe I should
just drop this patch, since it's not functionally necessary. If
we want to clean the whole thing, can do with a separate series.

> And it would be real nice if it was "iobj" not this "obj" which is way
> too generic. Thanks,

Again, the renaming would be across the whole folder, not only
here. So, I think it could be a separate cleanup series later.

Thanks
Nicolin

