Return-Path: <linux-kselftest+bounces-15679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1722B9573AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 20:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711D3283827
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 18:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FD518E751;
	Mon, 19 Aug 2024 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qbQm36fX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7FB189F47;
	Mon, 19 Aug 2024 18:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092735; cv=fail; b=BX0cd5+uBxxrBMAvkdW0nEJl6LegHzi7VzrE7q4Jerl6RuvLmivFLd0UPT0m9SbjVe9MWYFv2gpWAKX9exJ2+s70Lf/x64kC6MegjdzP9VjgevThYyDMpw45c/PIzgpu1BsR15jTsTv6XAO77yeAcd8GQ6GFkFgvUH+vSR0u3y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092735; c=relaxed/simple;
	bh=zux0VRepxxCg32HD6u/ICLBRHdU1h75/RLbKZQTMxrE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDhDNXtwdF+ULN5bMHOSyem1t3Ht4thv3Cj48Km6zJqIfu8iXz5vVX+6H+i+J2JW0jtCR0Zy5yiZoQP5atfRZj/M2IhGu61a+t465xISpaxWA+X29IwFBNLF7FwWBktzdtf5rE/teH/LtSytfYYYcChDre/vPGanNvoYGs1MKxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qbQm36fX; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPleQNILMtJRw6QV8C5rUiXjFG2wkujm0SHMeN1vJrVgzm3HBTRVxWdmv31FYkhQkhejrcAa8tnc3NcUPzo7fQew5sJRYqm5zF94USAX05jLBQL19xC4mLcivdSmUfKyQAlSpv+e+4A78Tw96D7roAEzHcqNckMFzcjVr8YWoNdJH7a0hGKnYXpfJkXcUZWfQxbzGrtISoPKiXL75bvZ+UotGpDAmly237IQjsVcmJ2vtCn2UBUog9GQV0k0lwQpf6HlEmO9lAr/+V5pW+AXU9gFzy003dOxMu1EWU8bZJgIgarqGDXPnho21BK4LUuhlJYFnvdRbEYC1ByY0wA3vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bz+xMlRg8ADmAKZoH4DFsTkjTKJiDXTqyg7kKfL7exU=;
 b=Kv7m3OaEUjcgb0qDTwTLQ6IvqIYRQhA0auJarcT1CxOsbnuZf9CsUWgyCRtO5ygv4zdusR0H6z8p+M+IFORy3dIJBK1nDJra6kz9zfTd2PqyVhNwtd4dM5Stf9QFxmkLPcZwvSibUZMH8AiApFwyt4U5/yuTwuvzSQkWK8NQNbV0mVnP5doGw55uc94i7cBYLpVYuGaLyrA6dLNmvGy5DZXUC6sJeqkvGDhYmCzkJWSB74tSHXvJs5MKTzkHQF3vlkzhD1K+jrwW+otv7P5CdQCHF2Fd5G/ilV94RHAMseoLSTWmo45WEqMT4kjq2Ihx/xtv+WgRhbeaz86qp5u3FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bz+xMlRg8ADmAKZoH4DFsTkjTKJiDXTqyg7kKfL7exU=;
 b=qbQm36fXeQM7LDVsdX/fgAoP7dgucYIYHqivY/oqWkhY33HBiZbioW0v9Im9hBCZtTXnvXN0WH9r3B9Epat/TwRgcNHhPegaiWqTJEK7J2U32WB8odR+YLVUG+QVSx7J4YALJ4BI5AuEAP7j7q/x6+d6KSmyKGXgHIUcWVbiT2CigkyVjeWpalSY7RUsy901ibj2HE991MFVpZAgJk+Y1kMAa+UXnEVIQaMSeeL1Q6UijW/EcCfuXHqY7ydx47CiFii9etRdcoE5uVIc2E5M2m9aUf5MazwrFXNCCJDlr0PxwlFRVaQ1PtkQxMNJGAqGX2Yjd7L/GiiuHrwT23NFTg==
Received: from BN0PR04CA0154.namprd04.prod.outlook.com (2603:10b6:408:eb::9)
 by SA1PR12MB6751.namprd12.prod.outlook.com (2603:10b6:806:258::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 18:38:47 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:eb:cafe::a0) by BN0PR04CA0154.outlook.office365.com
 (2603:10b6:408:eb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Mon, 19 Aug 2024 18:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 18:38:46 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 19 Aug
 2024 11:38:26 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 19 Aug
 2024 11:38:26 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 19 Aug 2024 11:38:24 -0700
Date: Mon, 19 Aug 2024 11:38:22 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 15/16] iommu/arm-smmu-v3: Add viommu cache
 invalidation support
Message-ID: <ZsORHnIKJsJaTkiF@Asurada-Nvidia>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <729dfd0808f85d88fd3ef8bcea0168cc1d2c0d59.1723061378.git.nicolinc@nvidia.com>
 <20240815233635.GV2032816@nvidia.com>
 <Zr6iPtiZ/afonJ5k@Asurada-Nvidia>
 <20240819173615.GN2032816@nvidia.com>
 <ZsOMu3OnMn49cDXf@Asurada-Nvidia>
 <20240819182811.GR2032816@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240819182811.GR2032816@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|SA1PR12MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c5fd283-dd66-49a1-9014-08dcc07e2931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LuQO6vYKQfaFUDfeuCxfnady+NtkLZkgRVK4XO6N/dxZPKU5c1cJ2rAVtl6n?=
 =?us-ascii?Q?WljW0ETNxeZbah8+xIBELiwyq+1e5yAh8r0fZdjerGTAe5Vkkj1mMNMD1XRG?=
 =?us-ascii?Q?8VuDUV/UBic5VyicDvDmCzMy0TMHCCjlDeCl5ZS73viBm/BiUtboywPTX76i?=
 =?us-ascii?Q?aqhCUmbSvPv+kfx/AEOGiX4BGhrQdoxts126s4oQwM7/tkC4R1oIzOICuSWT?=
 =?us-ascii?Q?WYZeDrVZhSnI9UXYOm9ozlU5VOjMcpWAxbcYwTz4+2avN8ENZbt3Yl+L3sby?=
 =?us-ascii?Q?gTLuRB7VeSK2tBuP+quJppuMGob+kzk9VwQW9xRCMj4rA6iDguualwOKvujt?=
 =?us-ascii?Q?wZlvudpUNC2DGt4dB0AFQBK1bGzdU5HKtd5hshQ0Ic8uwZNNX/O1gNO98/Tt?=
 =?us-ascii?Q?CRp4PJ95rHbJZjRCZ5gd8UpH62uqK2gkT0gFrotVdTP9wUJqzMdzu0+xzEHL?=
 =?us-ascii?Q?faiECvzXBK2KwR25Qy82luTibXVO8NpJxaILxY5tVa/Y1eRAJFsqLkTsOXL/?=
 =?us-ascii?Q?OMN3zcKUUu4aHk1e8LBmtCVp+yXkP6LpNrLku5/1eMdFVyHOAkX+TvFFaY61?=
 =?us-ascii?Q?xj5YQP86A8+bxqEkoQ0ud/BEV0eGD7Kca3uZUs3D+m+59Mv/mujNCkG2y69n?=
 =?us-ascii?Q?rx689+v8Ttqy8FQfN0nkwz//xQeqTAQ9pJkc9/qLnvu60J8QZ5VKheQ6d2A+?=
 =?us-ascii?Q?kQpni0GJXtcHjm1Umyrbvqj9dsjnIFawcZ4NJdA5SsWAvtkiPhdDs2gJI5RK?=
 =?us-ascii?Q?tuUSQf7+KYgwd7YF7zVfHdbRKDxHVJDYUStGNXZba83BI2jqObH/+B8ZoMkz?=
 =?us-ascii?Q?SSijSGAKWYosUgxUXv4cQldklqRTldxo3bw7NX5G8Z9Wxbe7aXGNXUO13ejj?=
 =?us-ascii?Q?2mkPGVhqkrL6upTqLV7vslvW9OlPNp4vGiutZB1+zbx/4BjV4Dvh1v8/2V0X?=
 =?us-ascii?Q?JZYv0EqoCWinxppuHk+w2+7vx3+2sHSMwcIowN0EVacu5o/5Myw6gbtuMlua?=
 =?us-ascii?Q?n/wJt3vMmkcWsEat7Z7WLbdBjpCC3qx4Bf+O2hxBlJelV03V5ta9bmmSBs/9?=
 =?us-ascii?Q?EIsMjaOu2YYyoU9pu80KvVVTFdsuI600QdTX0GkcMxIVxAwzRWeDojo2Poxr?=
 =?us-ascii?Q?nw7kdbq0dbXwg3+iZmQGQ58JkwhPyRqsmt3SxnC67mNW4Rg0pT9HAP3cuDGu?=
 =?us-ascii?Q?pbp1I/4jUSFYrAV/F5fJVBfg0n+EwPHgsSkowythVkP166qft8r1IZDPpXnj?=
 =?us-ascii?Q?fI8EjTbniP+fzsrHwQCJ1pWEOEH5z/q+tmMiX9IV2YboRVGsOGxPLvgRgAUn?=
 =?us-ascii?Q?DkRCDfyUqJG0vu9YIIrBV5ykEIGIPIqXORMpeOidHyVi9INAD4c9pxNbcZdP?=
 =?us-ascii?Q?tbNNDxVAJHxAQLbt8nkttIGrh6ulmxFhfYfL7EzsHATz4ZJitjMPTKyZrXVn?=
 =?us-ascii?Q?Jr+FJI0HrdusJ4vU55r3slLVMnIJPui6?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 18:38:46.7262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5fd283-dd66-49a1-9014-08dcc07e2931
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6751

On Mon, Aug 19, 2024 at 03:28:11PM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 19, 2024 at 11:19:39AM -0700, Nicolin Chen wrote:
> 
> > > But nesting enablment with out viommu is alot less useful than I had
> > > thought :(
> > 
> > Actually, without viommu, the hwpt cache invalidate alone could
> > still support non-SVA case?
> 
> That is what I thought, but doesn't the guest still have to invalidate
> the CD table entry # 0?

I recall it doesn't. The CD cache invalidation is required in the
viommu invalidation for an SVA case where we need a PASID number
to specify CD to the substream. But the CD to the default stream
is only changed during a vSTE setup, and the host knows the PASID
number (=0)?

> > Though we still have the blocker at the msi mapping... It still
> > requires a solution, even for viommu series.
> 
> Yes, small steps. The point of this step was to get the nested paging
> only (without msi, pri, etc, etc)

Ack.

Thanks
Nicolin

