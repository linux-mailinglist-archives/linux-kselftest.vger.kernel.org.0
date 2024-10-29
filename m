Return-Path: <linux-kselftest+bounces-20983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3089B4ED5
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 17:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03AFD1F23B66
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 16:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDA819882F;
	Tue, 29 Oct 2024 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y4PEYs/P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B836194AD1;
	Tue, 29 Oct 2024 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217861; cv=fail; b=JWZmmZAs72IPKZWUq4+GoT4r3I2yPCqL7VfLVTq2kMY+8nn7w7cmEddkjhNAsLCqRDSmXKHL4ss/QryoYt++KL7P1V54/qfGx9uad2jGSQjEXF54JiiYiynYYEfhHBL5KAYRtBR8AotnXbNaoxR9K8duUBmKW8Yfh1XAI73VRdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217861; c=relaxed/simple;
	bh=qyTHyKkWDAZaYxhnWK92AyB0ptwo1gbqQIP5IguAARQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9JbegfTu1GR90MwU8p0fzGC9ndOAfL4sThH0h2Fd6PQ+WjVcuaM0yRUYJHO30yebEQHS4wmBtOrJfsySPr3kU3d/fzwQU3yYZkYIu+hzmup51Fvvqhze8rphQyKtPOY0VpZbcfDEUhM5u20RlvhcvDRS1WQoyGhJXsySNNFRjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y4PEYs/P; arc=fail smtp.client-ip=40.107.101.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSpolpjUahd4Y5/skEokFvanYzZYDt0viy4/8+rmupHAKBI0CpsDxirdtWdf6LHGlEeuv6XTG/qmUsxg5NT5FOewjHECUyzjhLeJzE45gDQS1WOle463DSdN0CD9VdE82MLZApRag7j4do2yGU8f3LdA9PXLMm1JX/LYLxg5D8Ar8/xq6+hFP82biRSzIovv1uxpg/Gc/W+5aIdphC/owCWB4n2MEyJpF7xxOlY9kyySSp2jxxhIz/wYeiILVrkbyC4f24SbgOWneUyEQuLEBdC/rexDqMGy40mAouEWGWz8NYTxcrkLuquNFP/vflfn31cwjky7u5J3VtrqNfeKeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQeKk5m09i17DgGFRbKITL564FcI603gR1YVrBPlRc0=;
 b=vPeglma5Usk7FtIS1DXvqQajwOKwweE12b2c8dekqjqcfPuoLZhacFk/Fy8dlcaPO3DZWKFcj18j0NtRH7akmJioGtLq94XYBYW3tTfmZagVaSTtqleUl4TMl6eI8sr0ho+siNQY2Br+Oonhc+c7NJ2vOXj0fU+HLQhiU9twfeO2IZwwG3VkpRLP3OFZCVQU9o8hORWnw2xwzFMTH4ISY7rPjWbyR1/AIYZcVGPd/KOBG+lIRSg71Y9YJmK27YsCH++gJTQnUg05RDRLbY1ytGhJ9gczg0c72pUehZXcm348HZhzAuOV3EuXqGdh5hjrOjmXhNYr0KWEQ3zUSp7jcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQeKk5m09i17DgGFRbKITL564FcI603gR1YVrBPlRc0=;
 b=Y4PEYs/PcxE5m7tgNgXMMTvMKZuIn0vmjECL9+VK7i2plcEOP7t9crI0dpPQaYdhJuFwF1C7qKIFsErruCNrhs9bDFvNASPupbz7lA+kHVjVWqAIIg0kGIk5/oTMFiXvpU6655KcF8/j3JpMscFMFKHEQJfuOFAzvcpikDp2a79bSscX3SO74ytIU/BBfRmXkkscHb+gat9cPIk7a2rL+QZ9xsApr5iroIR2z1uzuzF06vkD9mA3ISy9/lt5NLOoDkkSEvjLLOfr28F8gB7KP7a0cN2TsRof1xmy7r9brAFsrDRNZTy5w9kwobvcoWlagfyKZ6tOMTOJvlFNNnWMdw==
Received: from DM6PR07CA0099.namprd07.prod.outlook.com (2603:10b6:5:337::32)
 by MW3PR12MB4457.namprd12.prod.outlook.com (2603:10b6:303:2e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 16:04:12 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::a5) by DM6PR07CA0099.outlook.office365.com
 (2603:10b6:5:337::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 16:04:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 16:04:12 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Oct
 2024 09:03:52 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Oct
 2024 09:03:52 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 29 Oct 2024 09:03:50 -0700
Date: Tue, 29 Oct 2024 09:03:49 -0700
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
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v5 04/13] iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <ZyEHZVgWbsYPDPZp@Asurada-Nvidia>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <f24628d774181da6df6e62bfa3376fbcacef8906.1729897352.git.nicolinc@nvidia.com>
 <20241029145436.GC209124@nvidia.com>
 <20241029153624.GA210796@nvidia.com>
 <ZyEDYFxHZ3XkwTfh@Asurada-Nvidia>
 <20241029155935.GV6956@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241029155935.GV6956@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|MW3PR12MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e5401e-68b6-4eec-fb10-08dcf833546e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?djX9PyrN7pR2fNiJavsVslneH7LgAnPR6tWjSyKzIxMk06YrIbuo/0Pu69Oi?=
 =?us-ascii?Q?eAsLN61W4Lr2FC1UPBD/XHMlACL3nZC7p7jr+3iYY1f+Z3LzKzaSiS5HLe5k?=
 =?us-ascii?Q?wmv8n0EiviJMAylKgFW+y86JPytEiXm9JyGRTT3UfeyogSV2TYxBr570dTkX?=
 =?us-ascii?Q?QXYvvSQjJWaEh7gn3QoA6e0cpXM+VRuJVLGC0kFdZ+EVJw1efhtkcTpk+8g2?=
 =?us-ascii?Q?Hq8D1N8r6XTJ01pMMe6hXAKxKGn6y6ibAFny5wLKCbodZweF826bwlynCcdX?=
 =?us-ascii?Q?sStsOzzf/EU1a34Mk8CGY76tnr1B5wc3p7jcYrZPf8iI2ly8QOTs0X1l6Pg9?=
 =?us-ascii?Q?5LAKcH5fKSasALZhNlYQgzuUMAndfVfNLLhegxMq+0Iv3CdgOQ/wTpdqcd7i?=
 =?us-ascii?Q?m4XWM49zAXz1eqPsp4xxFxNaFknyL9GT/m0foxh7z4KWB/j8tNTW10EvG6/w?=
 =?us-ascii?Q?db7nrsmS0C0ErK69MeXh/pNjFus3j/XDnG8jr/IbXew7HkGEpO331IqrF28F?=
 =?us-ascii?Q?GdXV0s8OXFD+yxhrHlCM98NR3pP7HgmKZOzhZIPPl53yFi7aC/sOwjvnBeZI?=
 =?us-ascii?Q?aOqDzE0a8iPSlj4e9Bo5gimiHpOjEs4ONQouMgIMyI6tU5gCuzOcc8ELzDas?=
 =?us-ascii?Q?XDEsPsZaP3Hkztq7z5gW/nQ9o8pYFzn8pkuXNB50W9OVqeJLhXZpg4Un8l/l?=
 =?us-ascii?Q?OWhTjMK/qxd+F2a0DbI/t3LgpZdoqcjEanOzGJnhnofXTyht/h9oOnzw4p0Y?=
 =?us-ascii?Q?JAk4hqY3dfeReQtoFspUyjIjf+ORbKrFQ0Y+cC3Sht7laIMyXAGBQJmz4FrP?=
 =?us-ascii?Q?mbPLDvFZne/3K4ClXMDJPWO2lXq8Vs4XHRCnaY/soYwG9SaNYWPsd8GbLiOP?=
 =?us-ascii?Q?mLkJwXyXTWUbEOZCZJLGG6OKQ4OQVVTVbFdSCLjgACO8G29xutDRQlhjINIC?=
 =?us-ascii?Q?ji2023H4XLJh0aVbR2hP5+VxWr09Uz904LHxw+vamBf6k7xS8eXbIdjsbDxD?=
 =?us-ascii?Q?iwSYFsBJqp3U4J27VkUHEYQP2t1ukavIjLNCD4BmCrPO3KcjAXiqmiRb+1rC?=
 =?us-ascii?Q?s45/xPsraXwec/FpOKOrhRoZNNcwfi5mHTvrQEOhq93PaaJvT3FYkQpaw5bt?=
 =?us-ascii?Q?oegfSgTAX/znOvuuUv6RjU2w3wMvICE8//18uD6IJCSgsRnTCwnKojLWPdFV?=
 =?us-ascii?Q?Y7WMXNx8UZJRdXe64iKQSqT9s/SucJt0xtkcprqckCSDoZQA1Q2+TaiQOzXl?=
 =?us-ascii?Q?gLAYbJzdZPMvFzesIdWeozc1comX/MMqEOEA9ImsXegfypN4reMHGHhZ9V2O?=
 =?us-ascii?Q?x9mp6oIQu+z5Y+HH9jJfQAbNlFfPKxccrQtx9kDAx/oISHbH+H96whihw5su?=
 =?us-ascii?Q?QbKFcI8HXxYCINUYr9ktBRRUBOFOn/3M2NBHAL1kmwYWcrr0Rw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:04:12.1785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e5401e-68b6-4eec-fb10-08dcf833546e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4457

On Tue, Oct 29, 2024 at 12:59:35PM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 29, 2024 at 08:46:40AM -0700, Nicolin Chen wrote:
> > On Tue, Oct 29, 2024 at 12:36:24PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Oct 29, 2024 at 11:54:36AM -0300, Jason Gunthorpe wrote:
> > > > On Fri, Oct 25, 2024 at 04:49:44PM -0700, Nicolin Chen wrote:
> > > > > +void iommufd_viommu_destroy(struct iommufd_object *obj)
> > > > > +{
> > > > > +	struct iommufd_viommu *viommu =
> > > > > +		container_of(obj, struct iommufd_viommu, obj);
> > > > > +
> > > > > +	if (viommu->ops && viommu->ops->free)
> > > > > +		viommu->ops->free(viommu);
> > > > 
> > > > Ops can't be null and free can't be null, that would mean there is a
> > > > memory leak.
> > > 
> > > Actually, it is just named wrong, it should be called destroy like
> > > this op, it doesn't free any memory..
> > 
> > Well, it frees if driver allocated something in its top structure.
> > Yet, "destroy" does sound less confusing. Let's rename it, assuming
> > it can still remain to be optional as we have here.
> 
> Yes, optional is right, I was confused by the name. The core code uses
> destroy so I'd stick with that.

Ack.

Nicolin

