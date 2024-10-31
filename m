Return-Path: <linux-kselftest+bounces-21229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7919B8043
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 17:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0181C21989
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 16:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A321BBBE5;
	Thu, 31 Oct 2024 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WX0+xgn7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98478CA6B;
	Thu, 31 Oct 2024 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392657; cv=fail; b=LbO5Y2WfwbX/YpqUFtE8+vc7ymw1+tWDH7mk3XlRjy6m/F7QTnsMP863k7ytE/Vb+di566ccIv9ArRtSN8D44d0DC6k1TEOaa6vCrQH2PL+7qWfVIjkMMp/AbGSQspLLgsq4l1etBrof3cEcUU/4Ze2sn6jCIH/nrqrYRZKzrP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392657; c=relaxed/simple;
	bh=ZnXmCRCWsGt9lGeGrxS5liSTJx2d5kMsXomTY2wFe2o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdkRDEB0lbpkNxW9lrDqbj5gc2qTLWAR9QRf6sl+fgop5xn1beRFXbck2Rfxlj+SqhcQudsg/iIfEPkosZypCGJfsRFf2f6djoSD/bHjPAE08vVafXtX0krrt7r26XkvC043BotlZ72It7WBZCXgzgr05esG+lcCf93+nLz1riI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WX0+xgn7; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgG2HvtxtQzn0tfSy6Ek4w0OZsHxDUsUGWID/PBTGr5viMSB1wI7+ioZKIm0NgbILJrxXiuM7Z0KHrgwZfN9+fsIAbSira1/ygs4pGBf3PZyzc2TfkE+5FHM5GaafMtbaTSH5xaDSx+xGWrR5VgiW9Rr/uY7JPVjTk0RtrmwepFbOb1bW7/dfXBOpRy6bCPFeEG28TKg5pEgL6ftJJbpTUUqqXmCgr79Tyy3jhPCc2wydil3X0/GAGdOpm1cmmCWqoJDvNNV8s2j3MN/uY5XEsEQulHXTx8Tl8xZgFTSjum9onlvKV67sAMmpZWcURVbEbzQlJ5d25TxjOlu4RMgJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MY9uJeoS6ZScrCeIeyAl9S/r/1W4Ih3VuFy6hs4CYo=;
 b=uxXBCNpXsgN4bR8tlUA/NFFP8D2i4Spx955YrAVs2oek9J8kEOb2GaTBDB0R/Pum6MP5aSvWSG/XQAViYKoBnACOeRNUdqmcAN3XM5+I3aRoIw2rfdgRcgducaWIm1od4RkIydvvwaNeSXzraafNtksPG9XVFknRvhRKW7MqfP8/sZC/qp6/g3t0A2rnUclBjR3dgehfQzCXKMHyTP5KGqEYFDZOM1eo9fF0Ga+gZVcpdB8Go+ZnBkOrCfem/RTiUEIvsd1KvhkPbK2kEEOVt8FP5O9m39Ypuq7zC6Xah/4s9b3xy/9xwWZDfpumHzxQkv5y2215u+N86Ebm7NbRcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MY9uJeoS6ZScrCeIeyAl9S/r/1W4Ih3VuFy6hs4CYo=;
 b=WX0+xgn7UOQy4QKQJcxRPgKDvMgsOazGiSUUJPxrbW7KvH2YmbUTq1Sj+ghzAbyPsI0eOOOiZQhYkNR+6l75WjUN//5qQB7SdCY0yIO1YcyiLmI7f2lrJNMU/Hf3VzMBR5LUGhj6UpmP7+zEQkpmdPFNqT/eCXpBd5+hDzxbzjd/M3V0V6nb4x6NdU0G6+KbbzYPx5cVsyvb9C9QR8LpCK/ZawNemWYzNTVNLc134CsmnNeozKMnB1dQVSywhTuWXfNy+X17+0J+3LFpce6bGe88R3QloKFQy6O2OM9oS4gCCmeUBX0hNdlxDn5pgmh7mALzM/0CY62iXjNkEOL4hA==
Received: from MN2PR15CA0040.namprd15.prod.outlook.com (2603:10b6:208:237::9)
 by BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 16:37:30 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:208:237:cafe::f5) by MN2PR15CA0040.outlook.office365.com
 (2603:10b6:208:237::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 16:37:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 16:37:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 31 Oct
 2024 09:37:22 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 31 Oct 2024 09:37:21 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 31 Oct 2024 09:37:20 -0700
Date: Thu, 31 Oct 2024 09:37:19 -0700
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
Subject: Re: [PATCH v6 07/13] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
Message-ID: <ZyOyP7M2wuhgPGaF@Asurada-Nvidia>
References: <cover.1730313237.git.nicolinc@nvidia.com>
 <41800674501340c4503cc3ad79affd19449a9ee1.1730313237.git.nicolinc@nvidia.com>
 <20241031131459.GJ10193@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241031131459.GJ10193@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 816bd103-ec6b-4d12-93d3-08dcf9ca503c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O0jeiXCuFo6gOa7SeV0G/poQKTT4opWbLlGKTIr2Ws7D0N6h2hzQrEc44XvM?=
 =?us-ascii?Q?vZcNib3oSvPJPJMHeJ3xvaXnT8Qtusyx9jwsErSl7vMexXR4adthlDftDry3?=
 =?us-ascii?Q?shEx8FfQmpmfzohwTyKYO2Gg9fQMjFC2GGR92pJEbZsRWs6DfcHkhJ5sVaGh?=
 =?us-ascii?Q?TckF4WbJHDitE4JEfCIrJO9/OiLBHH0m4R1HRnXBq+SEfyxDR7FUcW7U7iQU?=
 =?us-ascii?Q?hH804QOE71HX7ZM58Kf6omLyAEuBNCd7c5j+mjPyAamTJUJUos3VavojEBX0?=
 =?us-ascii?Q?QwRF76Wd++MuXFw6qxhqBl+cwRH6ZhZpT6ddUO+63Xxgm3t6dGZj9Y2g8lcV?=
 =?us-ascii?Q?4LJKOw+Ex2l8ep6MBX5UJVLhs8I8pTgWQRjN8juUOOEAzsQrzucW8rEwdz5d?=
 =?us-ascii?Q?lPyAb0xSU7KqhXh8F8C19vDgtS5mLPPdQeU5kSFpkkmOk1452e450tOuj9pE?=
 =?us-ascii?Q?B/B0sF8VCMfhsjlSNE9uDWa9k+LrIy4zJfqjLXpcEiiRmiAd0T8h6CrDCVWR?=
 =?us-ascii?Q?Rz1xLCfQjFKLJzhiFritQ/SsjImJ9GxyHicU0NT/sS38oOK+gjH2e8HZJt8J?=
 =?us-ascii?Q?Anm/n82d17AIvvpLj0daNE/BTS2KXUGZQcaVNGV0P7Uy/aGTz1idxfX07eJB?=
 =?us-ascii?Q?YywmMKBeWhR+2UmC4ngwY/tshSR/wChs+FqHQH4xTk+McVJEEto+m6GII1Sn?=
 =?us-ascii?Q?4V3lwnHLuhjJEgdpAZqh/rSJ27b77bYYwc9dw8v600zX0inHLQUi+c1LZv+u?=
 =?us-ascii?Q?VGOM5/PRVuN8BgDK/+iNNheR/c03WFZtMpgh5ClJO/zL+NFCSKR5mF3o9ZxB?=
 =?us-ascii?Q?SZoA8SL0f8mLCqIaOHvpmodN6rDjym5R/T0Qhy2y6HL6wu5sUsPQW1MyuvEP?=
 =?us-ascii?Q?3J5ogNo6+0BkIdcRSwyPZFe+Mr1Kb9xtTIZqgzMRERepASTVpVFegOxjsQyg?=
 =?us-ascii?Q?gFPMKLnXWSZ97Qajf2heqZYMFah+iu9jhThIKuuJzXzPLPVJa2zFD1cGp/zX?=
 =?us-ascii?Q?bFGNOOBpVSYWvO0clWvzxxVrg1Mzbfr8eq9TjOY1OONE9Wgz88Ud90Hjq0/q?=
 =?us-ascii?Q?sBNOy9zxAAGcJbW/tVFNS9NGDjM5k7FFMyE40AViEMBuZEo24/dYYC5JrUGh?=
 =?us-ascii?Q?gMWThzY5D9XSxOjDZDb6Gbxiu2FItqRAsuAqgtq+gD+XCUpcIExHNHrK8C4W?=
 =?us-ascii?Q?b0kSyXb4jbLFClHUL8ga51uU1YlEXPZuhfFi6Juvoj8P8SkFcTzMtt/Xkew0?=
 =?us-ascii?Q?OpUKoTqa1V0QskGBnZOMIBH0I0lw8SyUEb+nFyOqEbIlQqRksKG5H1HzGSpw?=
 =?us-ascii?Q?TwT6/vN7fDdTr9Xe+V5Mkvr5TX+nzOmcnTFvpM/djUyTf4VFeb0wJIy28u/W?=
 =?us-ascii?Q?fsShOCXoyMqiPhKINj7boJXPu6pkHsgV07exydQOhQT5DARupQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 16:37:30.2593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 816bd103-ec6b-4d12-93d3-08dcf9ca503c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706

On Thu, Oct 31, 2024 at 10:14:59AM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 30, 2024 at 02:34:33PM -0700, Nicolin Chen wrote:
> > +static struct iommufd_hwpt_nested *
> > +iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
> > +				 const struct iommu_user_data *user_data)
> > +{
> > +	struct iommufd_hwpt_nested *hwpt_nested;
> > +	struct iommufd_hw_pagetable *hwpt;
> > +	int rc;
> > +
> > +	if ((flags & ~IOMMU_HWPT_FAULT_ID_VALID) || !user_data->len)
> > +		return ERR_PTR(-EOPNOTSUPP);
> 
> Now that flags exists we are expecting the driver to validate it, so
> this check on flags should be dropped?
> 
> Or we go back to hiding FAULT_ID_VALID from the driver (and keep the flags)?

If we plan to fix the HWPT-based side, I think we should just drop
this check on flags here.

Thanks
Nicolin

