Return-Path: <linux-kselftest+bounces-33203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B206ABA1E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 19:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2959B1C001AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 17:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66683219E93;
	Fri, 16 May 2025 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dcuvTcpT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29C0635;
	Fri, 16 May 2025 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747416904; cv=fail; b=CvQJvDfwSo4YiXsVK1a1kD99kqQ3P7y9zl3F6YCLftagpFKPBFLhqvV/vhUAFtXuw72V8h+xdeShC6XCv4LYKQZ9xlo2EnMW8itYUgXpUSVtBA6RAhDQrt1Foc695RnzZX1cDKWu9MN89QfKQmDDotOS80e/mbM6w1VL0yPUGtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747416904; c=relaxed/simple;
	bh=k5nEt89pInPY1nn76506tJkhHV1PuDZGGZIydqAUsiA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BByFiIp+YutbdX3ioc6HbAyVU+9zOrysER9yIxKN2vOpXRj1xXpjETrp2bnCPT50Ue2k8V+Xe0roDz96/7pFg0WlI2pC4lDviYpmT6wORCAXMWtUM74X4kK9e9dZheyDhXhVqtSHleRlYPyivRoD5ZrIgnPYdjoCrBfc8EWROuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dcuvTcpT; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcRyNyxFET+HsU1ZR2/QsqQ8V+lP7uA7ykhsssssLt3bkkdxBz5QCZTTiVpBeWuXmFyuo77eJFe0o0WWq4blRYXdj2E/5zOJwfS0JN9+KK0xxumKnd+9g2/IOk1DxiJsxjEAEFJrXl9AKf8MNAgFzwY9box/dvKJ0YBfc95R4W8y9EJXjGgHDr36w3HME00YDLCdEgOfFODOAMpMG7JU6Cktl0VAlO5sRb16HKpUn0hCFQk1ctEOTs3wyn7VtSfBwO9V/S4Uba2cnIOiRFiocf6uEXUgTD+r/yzmfHKoTs74ycIVQutM0A+eBWqXcG6Q4cD6+GRwWh3zhzcGFES+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcYP69tQWBQxH07b3fB93ZiVkSHdSTu1vAfSlopTEYs=;
 b=yWOE/T7JPH4M+gYYDTkrfVWVgAj2f94hnI2XkbUtvXqDG8iPyvC0q/SWO7pwWC8ECZWgLCsDHlKKyHuV3kbIDcHEU8Dpt/u3cB9+qmCETIpJ1DiNJ+52BftMhYMnbRVgJtoo9qd6VBpt8cYsL8NLnMMM23ETwtPV5bKSnyaVpEDQSnoK4IMddrNIueUDStD8RoBFL0zbQndp2oQgYX5EPFPT8jidsdkH+BMf2TtU+0hL8t8/Qi3Or9Dk+CphmUhRemplhX1g2mdcM4LSDnVr32+C7Kssti1i3tONigq94jmDscB9QzwggiEyEyOAgoYb71czAmspbSg4JZ1OFTElSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcYP69tQWBQxH07b3fB93ZiVkSHdSTu1vAfSlopTEYs=;
 b=dcuvTcpTkAAWY0gBe1cmJW0fDQJwoUAa5iO1ylkzBQtiNzKnq382/C7Pt5xbbFiXhVIhnT/dXFM4XrdYwHaY0nQr9O59tm9t3mQQv6X5pp3pbgqIqfYd8DJ6xQ+o6JlxNWyzxD+uY3QyY1qtEMHZfSc+IMa4/5+LNXyE04HZqxCe0yAxedsAneHphGWcjviY44LoOYxwIyZ500oGZvIY1Nfg/79TlRx1vzHLpsfEFoCPKurGKWNIZuO89O1tYjtculpS2WUXPMUOPdjONPO02d5kQlZTqFtVxv21Elb9eLXH72wUg22kqk3j7RVvqjuU4eNaxvHAmQ8kdRC+MTesDw==
Received: from BN0PR04CA0185.namprd04.prod.outlook.com (2603:10b6:408:e9::10)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 17:34:57 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:408:e9:cafe::ce) by BN0PR04CA0185.outlook.office365.com
 (2603:10b6:408:e9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.16 via Frontend Transport; Fri,
 16 May 2025 17:34:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Fri, 16 May 2025 17:34:56 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 16 May
 2025 10:34:42 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 16 May
 2025 10:34:42 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 16 May 2025 10:34:41 -0700
Date: Fri, 16 May 2025 10:34:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v4 18/23] iommu/arm-smmu-v3-iommufd: Support
 implementation-defined hw_info
Message-ID: <aCd3L5h6/D4bgY1z@Asurada-Nvidia>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <f70cdcc21df7cf07ae1da02aba8a5aa932718a25.1746757630.git.nicolinc@nvidia.com>
 <20250515171706.GN382960@nvidia.com>
 <aCY31VOs62/OAaca@Asurada-Nvidia>
 <20250515185629.GS382960@nvidia.com>
 <aCY+rXsygxjHYRhK@Asurada-Nvidia>
 <20250515192329.GA613512@nvidia.com>
 <aCZL6+vsOri+WqXa@Asurada-Nvidia>
 <20250516132257.GE613512@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250516132257.GE613512@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|PH7PR12MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f306826-c617-4985-fb02-08dd949ff9b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VR90i8wyj7MeNoh5OYZ/vDeBVum8Eq5TyuTQQ4Ma0pn3TsGFldJA6al8jhlH?=
 =?us-ascii?Q?3RjXJv/kCJAWQjVfSiQ/XedaiJEbBlEymM6R/ftNEV3Y6sGkulwF0R2fXDiI?=
 =?us-ascii?Q?MKLl8AgsxSWJQrukxBmdCmITcjdK85kVIkswik+xK8BaLx4le3CeEsxdyqNS?=
 =?us-ascii?Q?lrDclGNy+6B1aUzVQgB1Lpt+BFicYo07zRkljDpoTxbIV4nx22Ul8abny2HI?=
 =?us-ascii?Q?TFJ9kUu3NxK4i/hx+IlCAtp8/zHxw6zB0ry4SwmVCmKgcSaIECtZao0GGHxV?=
 =?us-ascii?Q?BjiWBiJ53Zgf/vsLaB7FMf7OjBV5a1FOcI1BD+7S2xiXi3sx8X0H2AtbMPQ1?=
 =?us-ascii?Q?ydgoNzek6T3qMIOtTF8RvpCyQSSO5cqU+OfKuU9TanV6w54mtE8R2TnWVfBY?=
 =?us-ascii?Q?D1kfAL847uIxZlaqGjc/ZGlaFt/wKh19+tG04/LmrY3JUnW9LkSUcLhYBdfg?=
 =?us-ascii?Q?P6sD55BO6AKaB0gJw/1+3gQVfECd+qxu6fChq8VtYHMiSNGkbrWi9hsCL8kW?=
 =?us-ascii?Q?q6G17zj/hFAZFQO1Bgd+aKmowhPPKQ5F8xUCPEynLVo92jDtaN7UqeHzUdoL?=
 =?us-ascii?Q?TL/OTLMt3ptY88L3lSMiq93XA3sMhCrDaH5YzUhbsoV7yPwoE93QmTkAMdan?=
 =?us-ascii?Q?cPuF9Z/cA47HRuxdHk6cbBForuoQOVrTsVRrqhjtx4WMcj0Mx6ysVJHGfigu?=
 =?us-ascii?Q?PqnClKTR09Tm7XPMQ7b55OqvhVd7BF5w9oV7BbCTsOhv944a6YbdvV2yYVcH?=
 =?us-ascii?Q?kaPQ2KRqblAGxtCnUrs+yIEOfbY2i5f2du3rQ10c+WARSdJuGZQC9EJEXlOQ?=
 =?us-ascii?Q?HRto1WwGcOjtJvnNyZANqNalmcSFjYAfDLJsdEwv9VJ+jpXuL0hNycgv1DJU?=
 =?us-ascii?Q?fl/C1c0Obz69wFuTin/nsruaS5TGNZx/v2Zig15HEnpbJcfVmnx+tDt1qzaa?=
 =?us-ascii?Q?UI+FJl4soY36e5+1As73FG8sAIga5kLJmhtQ/RHXmPX0RoOIZOL86gAkYRIs?=
 =?us-ascii?Q?mBAjWewqidk+sXkzh3UfOCeKhtJoklB0jjrr7AwyW55jRI2VEy+Zu/31rNCh?=
 =?us-ascii?Q?prsjGH+f6WPgZW+zZIbcahehb9VLm3O6npUb0BYLNYDRKM/5a3Qwj1g0t2Ew?=
 =?us-ascii?Q?7IqX35giyyf8ZglQho3okQzL9EuUOZ9dk+b6BQoSgCIyO2G9CuW+W+7LqBUV?=
 =?us-ascii?Q?fpMvvqQplR/G+HQqjKMlHpQQ1XEEth1Wa/3iPfVj5DmZc5OWcYdqvBKvSd1f?=
 =?us-ascii?Q?rOtxIf/WqW9zjol5QCWmzRhPIhpWX2SDEtiOFByhFq8e6qck4qT4me9ke0nz?=
 =?us-ascii?Q?f9JaGVhziiNH4scftSK4T0ERdih1VFtGK7TR9mK9y2N9/BgYQT97ZEZdNhN7?=
 =?us-ascii?Q?fddZxmRvKZDRDZizp73tyNA3yApZXt1qHhn7+LBPAU+i5oNwV5sQugkZtbDi?=
 =?us-ascii?Q?nk+TZp2EGtRZra93Hew7V0Gp3jpT+51v7OD/aLaapFj8W6k1tFT5/qesYIPY?=
 =?us-ascii?Q?8+lSMk5vR/zCI3Wa/oj5Tb7SsVFVMGrkduG5?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 17:34:56.4885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f306826-c617-4985-fb02-08dd949ff9b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997

On Fri, May 16, 2025 at 10:22:57AM -0300, Jason Gunthorpe wrote:
> On Thu, May 15, 2025 at 01:17:47PM -0700, Nicolin Chen wrote:
> > > I think the former is simpler to code, you can just add the req_type
> > > to the signatures and if the driver comes back with a type != req_type
> > > the core code will return EOPNOTSUPP
> > 
> > OK.
> > 
> > Maybe just turn the out_data_type to be bidirectional?
> 
> You can do that, bu you need to add a flag to turn it on.  We didn't
> validate that it was 0 on input before so we can't start now.

Sure. I feel adding a flag would have less footprints throughout
the call down to the driver. Will try doing that.

Thanks
Nicolin

