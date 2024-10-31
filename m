Return-Path: <linux-kselftest+bounces-21247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F08059B82D0
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 19:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756851F229CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 18:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA7A146580;
	Thu, 31 Oct 2024 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dBZN2DlG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B6D1386C9;
	Thu, 31 Oct 2024 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730400414; cv=fail; b=GZL+mNQi3JGzBWKMlz9IIMYkXpwtM7HHtimr0No/KgXnvHNiTwttXCA6DvpwfMl+d1iKb/UoY7bPRtfUdkBitnScaKS4Qa7TqrHGd983IWot0OhEvvbRdmHRMsMuapDHsb7CEXFTRBlLgcSsvk/fE/oJn7T/YkqsRPb8qE7TjMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730400414; c=relaxed/simple;
	bh=mzi7hc8Rzq4K/ymIX8ujDz8E1hxJ5gDthDwyAmmT17A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vALOCTRE3SuhGDVk2W7fPwoiIUZetmL8Ac9Zl77j6t1iY2zB5WzGP16H0GznXWkAsdmhXOoFO2o+TojLO7hmrFSn1obURz97pMHFLAU+lfBXudwkuTZtQS1eg8YRit1DS+3mCI6xE+ci8svvysAUFWPzM3cVjvoaizpx5I7D2Rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dBZN2DlG; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odPRWT7+T/4QR75Crcd5lxbuwZhri8mEPy6CZHZM39ORJVlpWHGcVWqMDiBiKu81sJ3CYkb0KX3lUx5Zm+pkL57DhpuXrx65GzxRr+/DA/lz3z2BbNJ9oeLcBqM3nt+zvuZqnvNy9Axt2mJVZbDq0XDJBYUl6u6+LgbJ3oZrg3Vc28XI6bzT/XQBePFgwHCk+VnIZMeEf3D/OTb1b8IIHbGvi875AV3hQ/jrNbRqpS76AkOuA4rk0ATlbnjWJc2zAQ+ISmI7irT9leSiMzRc1sXMECQ2it/ZpzM+57kj4RtNyCPRIBdYbjlO8ERyE4ylcOpyu4e2YG6fZnszFjFhxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/S+/8u+WetCcfsd5nbj6p9sHaenJtcdeSP3oR7ZRs/I=;
 b=AiVS5+53vksncpdVPwMPwe/6YYYg1E4Sqm3/eSgfs1scm/U+AtgzamD4CaBSyaQhj/Q+mtq0qqfjFufarhf+utqGo1GQiYSpVBj/R3EsxhOZEYVb32Q0jZjV8yTHBGcWkOeb5Pb9aeFFb8mtVKo1J1S4s5stmsVQoBva4sW3JAjy8ce/qWJUgTjFF9XpNibUzlS8Wx192/k+VIpifHs8fBSjkwVzVs+5WppqgzN4gMkTcP+l6bPOjBOq9/US/FOG5cFpsub8RVV9FS5QOnU0hUP02r7Oe8c5J9tAY56gmhp/4cS6ile7xqcCqilVMLW/X2s0z07AuctInXtPmSr6jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/S+/8u+WetCcfsd5nbj6p9sHaenJtcdeSP3oR7ZRs/I=;
 b=dBZN2DlG2S6bp8O7uTq9I0d8J3PGeBotXYUIkCreLjABhJAPC8BGyzuZCptx3klNTG1RipX4iLTkSufoolYtANkAuZrcqSHmOk6POvzwT3Isv7BVO2XE00pyeoXeFHLRwKMW/TpecPzo3v0cNmQY0sKQ47OXWwc1Z+eCFOgDn+RVTFQmStcRBmekV1CZa5svapQPGLJJq1m0jjeAxdGF1EuiSOWvS6iJNAM1RxrAFc59RKN/Wj8uPb6qvbuFjy36r8fEb9qomT9hWZ5NgGRz5TebZ4m0cQYZBShfxQE3g95pO5yYfZWEDwqVmh38fy3jE6c9q62cx+lhlLwOP7KwgQ==
Received: from DS7P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::12) by
 DM4PR12MB6447.namprd12.prod.outlook.com (2603:10b6:8:bf::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.25; Thu, 31 Oct 2024 18:46:49 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::1f) by DS7P222CA0019.outlook.office365.com
 (2603:10b6:8:2e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Thu, 31 Oct 2024 18:46:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 18:46:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 31 Oct
 2024 11:46:33 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 31 Oct
 2024 11:46:33 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 31 Oct 2024 11:46:31 -0700
Date: Thu, 31 Oct 2024 11:46:30 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <shuah@kernel.org>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v6 01/10] iommufd/viommu: Add IOMMUFD_OBJ_VDEVICE and
 IOMMU_VDEVICE_ALLOC ioctl
Message-ID: <ZyPQhn+DlT4Zy3Qq@Asurada-Nvidia>
References: <cover.1730313494.git.nicolinc@nvidia.com>
 <19e20e54d41a0c1ab7403264e1016c4b19293135.1730313494.git.nicolinc@nvidia.com>
 <20241031132941.GL10193@nvidia.com>
 <ZyO2xfe95Y1TCaqG@Asurada-Nvidia>
 <20241031170446.GQ10193@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241031170446.GQ10193@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|DM4PR12MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: 79045e1b-f3a0-4855-ea23-08dcf9dc60d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1yyWaIv466aDIbajOy635k+din/Jp33ZyyO8cQ92u1b94gkUMRNcP+HUJUTr?=
 =?us-ascii?Q?D1mqufRRVfJw7ty6Yz/cUzskeu2Z1FRVwrUzdqeJrQTf3wIjtSYUPrVUGCo4?=
 =?us-ascii?Q?q3FtoGdziIVGW8+ZzxEHKYjUS4QE3WtIhaPiCcqgAsJ0kfx3NBVViN+gwEYH?=
 =?us-ascii?Q?nHBBQNVclcHghK8viGdTDTqo+qnF7CedIhLOmoLQsT4FDEYVDtklNIAUNYIc?=
 =?us-ascii?Q?uHlMEIgJCq/NKiSWLtxmOhNibJ70dxpGztF1TJjXZT/JW2XF7SjDkbgEgQu+?=
 =?us-ascii?Q?hwFc2QDsT920R15l40867V67UatN50mohlXA9v+gB4Rjs7d1Fdroqd5TJKdU?=
 =?us-ascii?Q?TtSvZgx/zgWD4sTCAd1ovaPbgAnZbNNrLCi1PnYaS861p4GHO6HCNGSLHF/2?=
 =?us-ascii?Q?i2AyBmvBFeg5rd0k2SuPDVNC4tBx1EeEr4wTOFlyASJyVlcDXLVE6jMq3izg?=
 =?us-ascii?Q?EjlycUUFWFbLXgckC/qwzuPYiwf+ogutCrLI353HKswmXD+gvar/FzloFcjf?=
 =?us-ascii?Q?kcXM+CnStCz4xtXHK3T2catgOWmW7dLNHqc6S2K0lBjIncxA0gXsIt02ePh6?=
 =?us-ascii?Q?TvIO+Qh3uTx7A9x9rJe1uocaYwCNfR336HwhMImVMKDTAXK4cGoPnhXX9E5T?=
 =?us-ascii?Q?OAHQTo6SEoZpjo0n44eXPlXOOyzM1KJ6vwDWoevQzqHIwRl6EGu9qzd2Vn6M?=
 =?us-ascii?Q?g2rKAbUxIJvaBw5pbfWCGjtHgr4TWgaXuDGwGdwAhl7fk5o6r5sPrFH1pWus?=
 =?us-ascii?Q?6SLhJ+hbQN0dA0gQMdwza9jA4bMZrsW9Kjkqz6LTotzttzE6HPegKik9NmMk?=
 =?us-ascii?Q?MJ9dnessrp4LtV1ZzQ4GwS/Y5DOU5ypGlV+d83sO5Q+td0TWJaKBvfBcTaNK?=
 =?us-ascii?Q?MowFe9tQGgmzycQkkPunnnBW5x1J5Sgx7N1tmaE/5jag2iFk06ZqCKSYKDa7?=
 =?us-ascii?Q?rr/gqPiOHUjKMh7VusbPUMpweC6b4tEeiZriteRw1l71okL3Pjq8ljMYOvLK?=
 =?us-ascii?Q?/NDRxEio1Adp+C9VO4U5UBsl8ltzJANpSZonooKQP5yd5pFs13HYKaud0g9Q?=
 =?us-ascii?Q?91goZCbSa7vnQrp0Yps8XCPIhnsAvJyY/TbjwsUgFdCy/whSk1izz5305QLP?=
 =?us-ascii?Q?zil84SWDGHuNydHAYIgzeQT9MZ/P8VBgmI0icGHkjYYl4z8zMOPYQDpBfgu9?=
 =?us-ascii?Q?zaaL8JMbg3RsAqncJCTOxmadAYI40zegbGaeSK3jOWvxuZPHJbrO8p9xOnGv?=
 =?us-ascii?Q?O3Y0XGLcNx63Y5ImfGk3BFAFfB0rDHi03nJ+A5st/okZxwzdxlAvngGYZPxN?=
 =?us-ascii?Q?ANV0lJ9rEBYEOns2Di8VSqInzpR6iPjEjhZXkT5vHHTRh3C/YMKC0syRQA7K?=
 =?us-ascii?Q?mdqZxUF7U6t0ExKRJh9h8YnvkVp5Lh/JCPV0CDz9B3f7WbMhdQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 18:46:49.1296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79045e1b-f3a0-4855-ea23-08dcf9dc60d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6447

On Thu, Oct 31, 2024 at 02:04:46PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 31, 2024 at 09:56:37AM -0700, Nicolin Chen wrote:
> > On Thu, Oct 31, 2024 at 10:29:41AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Oct 30, 2024 at 02:35:27PM -0700, Nicolin Chen wrote:
> > > > +void iommufd_vdevice_destroy(struct iommufd_object *obj)
> > > > +{
> > > > +	struct iommufd_vdevice *vdev =
> > > > +		container_of(obj, struct iommufd_vdevice, obj);
> > > > +	struct iommufd_viommu *viommu = vdev->viommu;
> > > > +
> > > > +	/* xa_cmpxchg is okay to fail if alloc returned -EEXIST previously */
> > > > +	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
> > > 
> > > There are crazy races that would cause this not to work. Another
> > > thread could have successfully destroyed whatever caused EEXIST and
> > > the successfully registered this same vdev to the same id. Then this
> > > will wrongly erase the other threads entry.
> > >
> > > It would be better to skip the erase directly if the EEXIST unwind is
> > > being taken.
> >
> > Hmm, is the "another thread" an alloc() or a destroy()? 
> 
> I was thinking both
> 
> > It doesn't seem to me that there could be another destroy() on the
> > same object since this current destroy() is the abort to an
> > unfinalized object.  And it doesn't seem that another alloc() will
> > get the same vdev ptr since every vdev allocation in the alloc()
> > will be different?
> 
> Ah so you are saying that since the vdev 'old' is local to this thread
> it can't possibly by aliased by another?
> 
> I was worried the id could be aliased, but yes, that seems right that
> the vdev cmpxchg would reject that.
> 
> So lets leave it

Ack. I'll still update this since xa_cmpxchg can give other errno:
+	/* xa_cmpxchg is okay to fail if alloc returned -EEXIST previously */
-	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */

Thanks
Nicolin

