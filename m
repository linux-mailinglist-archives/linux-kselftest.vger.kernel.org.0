Return-Path: <linux-kselftest+bounces-27001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D6EA3C46F
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 17:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38C637A569E
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 16:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D01D1FC0E7;
	Wed, 19 Feb 2025 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sg05S6WT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A54F1EB195;
	Wed, 19 Feb 2025 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981200; cv=fail; b=kZ4KApySCDAhK0FmMBaObvsNOCg7AeObaeRRFNM2cXSJVZAmgt4Mx9JVj9fI53eAfDPe3arFSzDnoMO8k6YDpJg23oDbw5+EzdFlcXkDnricU7oCkKs6j15QoZOYTL9XG7qEF4vN6y4jb/No6JlLft0UmrGFlpe/tRhrZh0R+Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981200; c=relaxed/simple;
	bh=paXWdCdc91R4P+kztvQPr7ryXllDZjpGkRqONYEqzEw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=le11RVh8uCpM23yCM5hK4ptVPqryONJFx+o7OJujtjbinxE0Dl1G7/lvXXDvVE5D4eiw6oU7McnnwsYle2elxSHwnlFhs/mvQaftVzhbBrCOh1r8sZIxTxT6EUS4Up1wRxVy8V66otfQxdtie0rMGtWQMUaanDSUlcibNR+mLfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sg05S6WT; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fM351ls9+kV3a95ERWpmynnNcG0f1yDAYxVXJKNRvb+NwDTSeiiacLmS+tChEz1iqrPk1Nj1ULQMr/3hD/OE97sXlcWwM/vl9dRALgafRbLjxgp/7SE+++wErL4vZ2JcJ86roYHEjtCPHSMDX/XJU7KZv7PsPlsczxT2dNMWDSdaUV7Y7/xTZT4qhVCNkJ5xO2QBhRhcNve9WZ4OA0quol/vf58WqHt1xX0G7tchbLRpOh3RfguDtie/ss95wF4fmWUvdFYYgPLA+s8ytqIoF1AkMIq+xGILMy6CnN2xDDEuihGDEvHEKjEqW3kSKDGerLzcDtjukBv4roiZ8Lf6Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhG67u2tjTkF5CD791owD87/LFti3YXPTa2JQneJOYg=;
 b=yfIfo1Vr/prsVaVwyaPdz3Sz6RfcK4ogImNm8D0ZrjWY8MMQaf9PqG9bLQ3S4mYBFzsVP4LdEaDdrVKVmpX3QuPMsqQYtEpRNNZZ6X+/Wk6VcaTDeqysbuDzi8mcviVzyRSRCpmSPp75u1KjoxSnB4XmTWiPwS6N+5XW9TkIMjLa802c+JCJpnyUm2SsPAx5OGAzXC1ePkDwqdJHjjlz+tYPbiM/YllmXB5Hy4OxFgY3Nq/PXXKAsWt/nBnAIFc2vAxAjGvHK/kx+IC0Bk4W6hr0zeeSzPB3YGWj2UbSYQbxuLktugULjzOC1bX6t5cjriVrE67xQD6RVdjH9q2NrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhG67u2tjTkF5CD791owD87/LFti3YXPTa2JQneJOYg=;
 b=Sg05S6WTgzBYlnzg10MNtU1C1xA/uMo9hyJFXDb8vrU6QUIWTUNf6VpNag8rSdr9SdzHc9d6PrAb4Gggll5B1lSoAArzAeKVwocrU/AOdnVLGfrBI0yQ2U26XkiirEB+qr+623WpQvxosseOJFgKx/dmWE+7c68vdhNFv7AggsIYif4oJlnsqGO4kLIet5Ny+JvKjacmn2tHMVd+wpgIeGP4sNy9mgXPZo9z4dkimMBfAnQ5r4/usIFBlEy5+QRPmN7eTem2BGII4S2XQ89jun6lXkJQ/PsTWkK2kw5T1PJhLfqmEFfhgTvqZTfimWcYu0fxEFR2PZ66736LiR77Og==
Received: from CH0PR03CA0322.namprd03.prod.outlook.com (2603:10b6:610:118::27)
 by SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 16:06:34 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::f1) by CH0PR03CA0322.outlook.office365.com
 (2603:10b6:610:118::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Wed,
 19 Feb 2025 16:06:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 16:06:33 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 08:06:15 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 08:06:15 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Feb 2025 08:06:14 -0800
Date: Wed, 19 Feb 2025 08:06:13 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <tglx@linutronix.de>, <maz@kernel.org>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
	<yury.norov@gmail.com>, <jacob.pan@linux.microsoft.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v1 00/13] iommu: Add MSI mapping support with nested SMMU
Message-ID: <Z7YBdSgKev6Hv7vi@Asurada-Nvidia>
References: <cover.1739005085.git.nicolinc@nvidia.com>
 <20250219133723.GN4183890@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250219133723.GN4183890@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: 3365fe65-df24-4d0c-efc6-08dd50ff6169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YhSTRkQ257p/3kYedxK24lbm2VdB1tWuzWCLY3p6ktlWn3eZ89B0ksoLSaKG?=
 =?us-ascii?Q?q9tOzfCwUt7eoN9Wo9CqkFbAYQ6oqr3R+4euVBNgUF1LDh6i8KGfskQj2xer?=
 =?us-ascii?Q?7jmFSFyDJ3CbqBuC++g4d/GpJDLv8anCwPlSJLEFRjhWbc7wz+2q1Sn+yUtH?=
 =?us-ascii?Q?bJP09/o86iDUUFCQJdjxiBVpUs+sn5LPKnR5Uu0EbnhEK0k3G/AlJCuZUJaT?=
 =?us-ascii?Q?xi8FdzC1pSHbhItUm6yuLdku8UpnTcO9/lZnLUbVgSFpENzllmgqXApao7VH?=
 =?us-ascii?Q?tWuj1TtmhmW93ZUP6RlzuaAl0gm82+vx67Ya4E8sKJ3o+AoTHzTCC7WMwFDq?=
 =?us-ascii?Q?mqAtcjsK5dnNgPQoTJV3wHohfYKl0aYRaz0cIIouVPvGuVFMp0mbi1/sErol?=
 =?us-ascii?Q?68/BOReY0GcLtwc+ALPpd95NWJ4jsNeh6xWJ3KSkuwK5QW/E4dg41j7q+ov/?=
 =?us-ascii?Q?8TvVTK5rMBuGlEie9Fyfsbip09Kl0lGKrPvJUhAKh0ST74nSFWSPYgmQE22f?=
 =?us-ascii?Q?gcX1HkevUvzN9PEeGRDTb/XReGfTRt3FYiOEb9oyr4gVd0mFMSjnJg1wnCmX?=
 =?us-ascii?Q?W0QkjVqfDRqu27BpJV1ye2jwvjzH3gnWZIguzj39SDWk/CfiINR2tWrmsbci?=
 =?us-ascii?Q?lvR3G/yEBXeJa92o8yG57yEOSjsB+h83wFffPyc75H9xtE4f/kaQHKWLKSE5?=
 =?us-ascii?Q?/ZIObP152o5k8I3GdUAluCMCs5EfDpGk8g2bI+EBsVR3LZZsChcv/73ix0jr?=
 =?us-ascii?Q?k1e6i876ETI+NdaQCwx4v5nX1Hv5Em08LAyUox8jHDmrjnvv61/iSNogu605?=
 =?us-ascii?Q?N+EcrZxogV2NKeKBc5czhUgT+SGjrbMnnpDjPukeNLB/aUe5zApHfOfvw4xK?=
 =?us-ascii?Q?j6O1Oc117F3qiWWH5/3hGY3kgTRDeylLkdqvFMwG9DndEyy6ZdKtnzSDpowj?=
 =?us-ascii?Q?2YxAdLza1uamtX01Ji+YqbuGqu2sBpiE/qnJU+CgWOPGdH/AVVHKoGZUt+IT?=
 =?us-ascii?Q?45xVjTqy1z5n9qKRDbJXBhQ4kRKADARCxXFdC/ezI8y6Nj6qRAp5ncHcoaxp?=
 =?us-ascii?Q?pZPW0p8l0lgwKnDS5E4bI4HNau36kZomNGC8NnuEyrthzGmhJBHm7B5tV/en?=
 =?us-ascii?Q?bLfpOBwdqnCUZF7//7GYHDx/6fObaEd+zBXuQv9pdpjULy/tjCvXl16FyT1M?=
 =?us-ascii?Q?6yxgM6IBjqjQZHD8ik82n/zIj4FGpI8uWYoU1RUvCCUPCqVXE2PFfS8/Nl9l?=
 =?us-ascii?Q?/9wgDBspku6pfp5uxzO/foV77SgHChYi8SioDQrhBlDyEApSGfBDic9wowXA?=
 =?us-ascii?Q?4/He+BIe4Nt0FLlgNQHClc08g+kijTtJI76Jrj6ppqWcVTUlwBU91lAbD6FM?=
 =?us-ascii?Q?mwMvx2xZvmvajkqxeaUi+TWNru55Y0UwYcSyX8k+J7MGkTEYYwcUSUQRALHC?=
 =?us-ascii?Q?T9uko+oWmL95QWApbQQwHhcsUpBFmlC6V4qTx62H2IE02Bmr69D+Xr6jAQSN?=
 =?us-ascii?Q?/LdPzs6WWgBiK5w=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 16:06:33.6131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3365fe65-df24-4d0c-efc6-08dd50ff6169
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961

On Wed, Feb 19, 2025 at 09:37:23AM -0400, Jason Gunthorpe wrote:
> On Sat, Feb 08, 2025 at 01:02:33AM -0800, Nicolin Chen wrote:
> >   iommu: Turn iova_cookie to dma-iommu private pointer
> 
> I suggest you respin this with the updates and stop here at this
> patch, it is enough to get the core infrastructure updated and does
> not bring any uAPI changes. The remainder can be done after we get to
> this merged.

OK. I will split that and send the first 7 patches as Part-1.

Thanks
Nicolin

