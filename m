Return-Path: <linux-kselftest+bounces-15673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A949957300
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 20:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F502836D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 18:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC46188CC7;
	Mon, 19 Aug 2024 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B2MBhnHc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9777ED531;
	Mon, 19 Aug 2024 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091600; cv=fail; b=eE7IGUU1A4G+slaoqi2D6oT7mDqF6WYNbU5YGwy/teA5YipZ7aw/PuLbZqi5feWKK3OQVEhZPTor3khyZaNkc3oWIk9JItePs88TxEgzpEcwviCLMwrtj+EmIo1T9tichV27ou4GDtCT+eCYuWtaxPaD2DAByXIE0Cn4vGTBLtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091600; c=relaxed/simple;
	bh=l8LImk4gpB879QUCZ+jkqIEfzf3neiw028dC/i0//fk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExAt8qHRpMWAIUqhsy8zhE9zBtCxmkW6FARomal89lot/svGQsUwxhONp1oWtxlKmZ4mrRI6CODuBwDKWfwljNF5oDmpUBaCSkIidAbOAKpgSDgysI88KjBo3ogJVZo4epZrj0nToE0hUipbynnnR72hc7lrSO56p0tnAiIbIN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B2MBhnHc; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v012cR4YWJxV5yRB8McbQ8bYZEkFpYKPnN1XwAKZHrmut+eohkFCZtDl9J5Rq6fi1CI8jTX3Z5JMEbCABUkfJQCpX9610whLJbTd0lYHRH/veoopfZBXG9g8S7k5Mnbf6hYZAon/4KJmwtDBYkxuKrYwKuuHDtGEyCgULJdVCSZiBHm9hTR9Ak8Lv67TlJATOwzN793lzAYuJYWnQC61piMXXj0EYoDbb/PC+dkLBBo41I+QMfcdWu18ALaxetPzCDzOg/B9b/jyvRYnG9Cl9t3/Ojzw5ggGAycPuI2m+y1GOPjJLThIirC9t4z9p9tCy995ukxrdlMIT64nyaI4Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VENk+Zum9TjzXvsUHmy77gFSTkt7uaw9Ku4qQ1w6LYU=;
 b=UK+ZaofQG415c+/TKgrdBrOsb5PoMoANptPKGNhpDmspnb3D69uTAyAAnwommz04C/GQwsyF+D9jyPuYHdsln23K0OXcaB18ZLHBs9Ct7MeHJBNwwGaFE67IFAKyoyoiRYMSsRYlhLA8CVHxzEWn+8dO+AvxeemmXRHiIOM2Xbm3UGUERa+NPLD0nD94klrtRi6LLqI3rsTcha0hvHz8s4wgvHEHV9zXbuiW3VRgNKtgJOvVd7jK1msmtH4epIvqsnv4eGC8NTLuJYNNED6iQHTUnyE1jT2ZBvJi5kis6jT0l+7zSghA4sk3y12bhp9lrY/UVfrcibMziURF7AbIVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VENk+Zum9TjzXvsUHmy77gFSTkt7uaw9Ku4qQ1w6LYU=;
 b=B2MBhnHcuoAsuCghQMdRmwhG02yNGAFVuOzoB7kLZzDBg2Kz87AQ4UEoW0xyZE3NBiqrX47PmlwMb3QwrfxS+adL+MoXY1i9QVb3gTHqgiCJmfo/SywLtScLZGv1tOmjRxWth/eDcHR4uX7o7hr6lrEvYJBMehU5BWEC6Wzrj9F/dOsztVIvYnzCPLyPJYF5eLRjlXYkxTI5N47k07yxcjwUbMltqZKMm9/7R6bGF+Tgidw+ntiwsC27WMYMpNwnaThkCeDOQtBpXb/Kf6tAMS6vsh02TdZtT8UwMmwV8pucxgVoyuthcgg9WJ4A7MrFO4kU/tjfEq31nlqkENhRDw==
Received: from BYAPR07CA0087.namprd07.prod.outlook.com (2603:10b6:a03:12b::28)
 by SJ2PR12MB7989.namprd12.prod.outlook.com (2603:10b6:a03:4c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 18:19:54 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::35) by BYAPR07CA0087.outlook.office365.com
 (2603:10b6:a03:12b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Mon, 19 Aug 2024 18:19:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 18:19:54 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 19 Aug
 2024 11:19:42 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 19 Aug
 2024 11:19:41 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 19 Aug 2024 11:19:40 -0700
Date: Mon, 19 Aug 2024 11:19:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 15/16] iommu/arm-smmu-v3: Add viommu cache
 invalidation support
Message-ID: <ZsOMu3OnMn49cDXf@Asurada-Nvidia>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <729dfd0808f85d88fd3ef8bcea0168cc1d2c0d59.1723061378.git.nicolinc@nvidia.com>
 <20240815233635.GV2032816@nvidia.com>
 <Zr6iPtiZ/afonJ5k@Asurada-Nvidia>
 <20240819173615.GN2032816@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240819173615.GN2032816@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|SJ2PR12MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: c750c4ea-b4e3-4f18-2684-08dcc07b8604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7bOdYutGpEjP0wZdjHFe77CYwRT6OOMXU3pEPRU5wF32OKPscIzIELTCi6U7?=
 =?us-ascii?Q?soTwuSSxFBVpzVE/TJMADu66v6F9qRObLPsxsZiGDzSH/tYnNHLxtIj2TF2s?=
 =?us-ascii?Q?KkDQXP++l4KTyphJifKBH+/0X2uFB17LluUdIXzixmh76skTcyyeq9m8HQTV?=
 =?us-ascii?Q?JRqcDN0ibqZsrJhDpiK8CGaWGfWung9FK4d+IRPAluPNTU1xlJPdRP4Q3xCY?=
 =?us-ascii?Q?WP+4QK/anCY6Q+jqEW5Cz5uLsc8WVuAAiTWpmfZwo56Fg1PyGjNCyPNoJ0yB?=
 =?us-ascii?Q?aYl313PIZjDt8By/LzsyMDX2Yvk5KFsdLhh7rBrH3IQyodun9l95s1NCEp6h?=
 =?us-ascii?Q?2b23VJCTxnb7uB9/hkQ+aVJFoeJ9jA6Wb/mfhfZB9/qi/nxbnFss1jed7Jyz?=
 =?us-ascii?Q?GfCMJds9bmXrHfyAyGlPGkXQf6M0HTU+uVV+owQJj2L0DZjHo352mz3yfYQy?=
 =?us-ascii?Q?FY7BXs5fQ98uZM+Bojv8h6PDvpAbyikG4Qn+8MkYCLKOcW+/b4LFBb0NBSSN?=
 =?us-ascii?Q?+VIFx8N4G19efm8IOfZPQYv3M5V2tBLQ6SPNc/G8yw0ZSiedcC3Zd4IvBMOg?=
 =?us-ascii?Q?ebqwuSBeCUYJvVXGlw6ElRuxiHylNcCVzwnn0O4gfNoSmq7eut9l8Br1TS5f?=
 =?us-ascii?Q?M2GdC/BZdAsz1mYdLghX4oRxnCBVl/i9MUJgOgpJIpvPco6HQaiHMsT2NoJx?=
 =?us-ascii?Q?ypQCqTyrpwiRwTBopDv/3GJnqFmMAufn0QS4tgoPhFrMvkC8M4TMOPh0Y716?=
 =?us-ascii?Q?QsYJGREid8PoiRkxQTMrDCHuASAHngO0ZqtOWmGvu6r5OHDy8Bzkp575u1CX?=
 =?us-ascii?Q?IZY4t2AQiYx4ZGna4lRb7peIaMcwtwDCLKUDj4ysWzlSUEaTHW7qZrkfoQC5?=
 =?us-ascii?Q?9wR697S8NR6on5/0CDUewZYsrSv1ypdixhaVLojv/zkKqa02ctYcMNZhonui?=
 =?us-ascii?Q?NR0jl8cyG+hZMRQIQgCa7r7/9pYa108DJXfZGbeFGycSB2e5vFJ3g+nck2jP?=
 =?us-ascii?Q?Evlu0EHKNGX+pIeOclcH0J5mEFtKrrkSTP3sRqp/3C2I0HjJ2oZVvYf5CsHB?=
 =?us-ascii?Q?uHv1tfMEo1HpmHK/tBHcDAeszl9/ejPgYhrGAvOTO5Wkbxo9tJr1FIAE4e1Z?=
 =?us-ascii?Q?iPOUP8OaoMDTvk3v/FqP6QsGKc21w0rA5ln82FTNzwAruYJS2EnJ8q/m4jyj?=
 =?us-ascii?Q?gBJ3KWD7CW4RMOlC5fjC1pckWoAPpVwiN1OfitvO80QPFJA9OwbgkrXr7BUe?=
 =?us-ascii?Q?d/GGKPyvqLuXh/ol4kwb+3YpBFhrF/Ls7vqSNaZT6AkH4SUZKhCouQfJW4Bb?=
 =?us-ascii?Q?gEvzDIYfv1SPCVFQDPXuzWZD4qEtLr3iy2jLkuFjSYrfKMX3lpg+uhFM/Gfv?=
 =?us-ascii?Q?ytCFFsFrv9YutvgnZ2QCQ2B/s/wxGk/ddeKDvdt27nu1GtnpUKoqjYivSAkK?=
 =?us-ascii?Q?ENjEsMMHJV1YeCEjMgwWKisHQUn6cDLA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 18:19:54.1384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c750c4ea-b4e3-4f18-2684-08dcc07b8604
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7989

On Mon, Aug 19, 2024 at 02:36:15PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 15, 2024 at 05:50:06PM -0700, Nicolin Chen wrote:
> 
> > Though only driver would know whether it would eventually access
> > the vdev_id list, I'd like to keep things in the way of having a
> > core-managed VIOMMU object (IOMMU_VIOMMU_TYPE_DEFAULT), so the
> > viommu invalidation handler could have a lock at its top level to
> > protect any potential access to the vdev_id list.
> 
> It is a bit tortured to keep the xarray hidden. It would be better to
> find a way to expose the right struct to the driver.

Yes. I will try adding set/unset_vdev_id to the default viommu
ops.

> > > > @@ -3249,6 +3266,19 @@ arm_smmu_convert_user_cmd(struct arm_smmu_domain *s2_parent,
> > > >  		cmd->cmd[0] &= ~CMDQ_TLBI_0_VMID;
> > > >  		cmd->cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, vmid);
> > > >  		break;
> > > > +	case CMDQ_OP_ATC_INV:
> > > > +	case CMDQ_OP_CFGI_CD:
> > > > +	case CMDQ_OP_CFGI_CD_ALL:
> > > 
> > > Oh, I didn't catch on that CD was needing this too.. :\
> > 
> > Well, viommu cache has a very wide range :)
> > 
> > > That makes the other op much more useless than I expected. I really
> > > wanted to break these two series apart.
> > 
> > HWPT invalidate and VIOMMU invalidate are somewhat duplicated in
> > both concept and implementation for SMMUv3. It's not a problem to
> > have both but practically I can't think of the reason why VMM not
> > simply stick to the wider VIOMMU invalidate uAPI alone..
> > 
> > > Maybe we need to drop the hwpt invalidation from the other series and
> > 
> > Yea, the hwpt invalidate is just one patch in your series, it's
> > easy to move if we want to.
> 
> > > aim to merge this all together through the iommufd tree.
> > 
> > I have been hoping for that, as you can see those driver patches
> > are included here :)
> 
> Well, this series has to go through iommufd of course
> 
> I was hoping will could take the nesting enablement and we'd do the
> viommu next window.
> 
> But nesting enablment with out viommu is alot less useful than I had
> thought :(

Actually, without viommu, the hwpt cache invalidate alone could
still support non-SVA case?

Though we still have the blocker at the msi mapping... It still
requires a solution, even for viommu series.

Thanks
Nicolin

