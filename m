Return-Path: <linux-kselftest+bounces-36226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C85BFAF06BE
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 01:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114AE4A601D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 23:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A0226FDB6;
	Tue,  1 Jul 2025 23:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KDs4DWmK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7473E72621;
	Tue,  1 Jul 2025 23:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751410923; cv=fail; b=UP8pn8rYXHb+z5W1+3BHsUdtq/3M0n0Y3UtDxvV8fTnzMWgMs5tWe5Jmvl9+tGcN3+Z7YmEH0xBJGvOQ480X7+FOethWfJWuCFfoweER9N4b2oaphJyRy1CmHdPLKnfrgMqIkTXzBa5bUm4rABsdIOKvP4jhM1gyUBONiXOc+UA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751410923; c=relaxed/simple;
	bh=XtEtqibupEARR7iX8Bqu31+0rySImWqQyn9Xo+5rVis=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E96xX/9L5uSTIM7Zu6ElK8gi6dUa2LPv/NYdbbw4wtP8+t0KenJ6Xtgzc2BTfAr5Q/PeD6kS7Cg6skmavh1OLmty8kDFksCZQ1rCZGtZ7aZng8p/dnNHPX78F7IRNU7Ia3q4h6+obcZWH/5PRdWYbaLkN6xrB6Kp7HR60/SPPq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KDs4DWmK; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKQgTcJ/6UQYikugnF6BKPhb6wpt4sAdBOSVmWMyuJU2a5NmXp5LXgMkukVnRCggzQttxeNK21NG56nvH0m/oi1WbdIQvNIOug2EL62E0Lj4lPogJP9AbV33GWkkKe4JkNf3HoPF5rkKzPySAFDbEpNdCdnXLuGOKReHHKgchKt1FksnuZlDzTcqjq2q5/ZDc37/eWpV8TY5qORu3EyNbaS+HjCAtC7TPp3C1GcCVDH+M+cBqUrErbweqniLhFJf+2pyeM9nWugO3wX/EeA9U+LZIVTphFux+30DnO1xGDS3yV2eeHj0tAMjS+vPiAYdwY37yCsuXD8MS3c5GxuQvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1eRR6WpuiZIuEwYWtGop6KiGuViJHV4rGrM0vLts+E=;
 b=PvnbSY/lzMW/zzMaG3wItk8iW2n9f7mJLpLu5sVjQ1NI5A3VwEddnofewR+GkEujoSyc+LwiMX7jY/35YB6LGhX7fMo5BCfB5XncK+tdxVZA//bcgpX3/mW4McQkIMMdXPKHc4GN+Nz2MVD93fuvPptgne+aIUdMGEwdaR/PrR6w3DdlNyJXggk41mFiDr4u3E91ZDGWiXDgsEamlKaMel5x65xT3KAyhb24adSFO6JucfEPssuVWrX6WfxQrJFXSeFNKAfUDZibc306ZY2z45qQk/zOu+2JrceeIxCAdn7blG/YkZWE7ud6+xllrHxdbn+7gn0bcMWRXZidDePYrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1eRR6WpuiZIuEwYWtGop6KiGuViJHV4rGrM0vLts+E=;
 b=KDs4DWmK05JWTCIcvfiL7nWJdPg9XCFyBYiZFtloYkq9sMV36ZDSwlRcH/pENHXOy+AwKew3W7qK4Cuhy45o1NHQeaJpmxyKC7izKws4OzjAB4gN4roIPQg5gzfdYKxeGYnZc7jtGplef/6sVuEmt2n2peQ/s+iYyo3s1F8TxSws7h9UP/fWySGdwRh+LtyoiuHErXxpAfXZaHiLmilaT1xvj9T4SqllWA1zGSa6CuK8YQsmBo7tuiw6+9BrUTyHXRRS+yBrfhtqwjqoxhgR4FtQs6S4F/z3VTthR0YlVeFw36pfdjxc/WczQWfJxi5Q8W1iGXgA/M0I0owkyYlhBw==
Received: from BY3PR03CA0028.namprd03.prod.outlook.com (2603:10b6:a03:39a::33)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Tue, 1 Jul
 2025 23:01:54 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:39a:cafe::52) by BY3PR03CA0028.outlook.office365.com
 (2603:10b6:a03:39a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.32 via Frontend Transport; Tue,
 1 Jul 2025 23:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.1 via Frontend Transport; Tue, 1 Jul 2025 23:01:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Jul 2025
 16:01:39 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 1 Jul
 2025 16:01:38 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 1 Jul 2025 16:01:36 -0700
Date: Tue, 1 Jul 2025 16:01:34 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <bagasdotme@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <shuah@kernel.org>, <jsnitsel@redhat.com>,
	<nathan@kernel.org>, <peterz@infradead.org>, <yi.l.liu@intel.com>,
	<mshavit@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v7 27/28] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <aGRozoIDIlgl9H9x@Asurada-Nvidia>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <539ee2ec112162abdba511574e2205a77b425059.1750966133.git.nicolinc@nvidia.com>
 <aGQGm1-i4M75b9Qp@google.com>
 <aGQ6KCI9OZEwHdxS@Asurada-Nvidia>
 <aGQ_F7Qx3scbbA-J@google.com>
 <aGRDtYRXFLoT+PrI@Asurada-Nvidia>
 <aGRIctg4T6cQECx4@google.com>
 <aGRcPSwaJkTeUrMx@Asurada-Nvidia>
 <aGRmaOORg-YDfncY@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aGRmaOORg-YDfncY@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c128dd2-dbf1-4d78-732c-08ddb8f34604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pbLEGcY9Rz8Y8VmabLmRXpbrfzufV9kxCIOK30xZV2BCQ8zKyDrq6B7b0Rfl?=
 =?us-ascii?Q?0PzqQipKU+TC0zaLMXH1sgK2mw0Nq5vavSkTDFQ+FMWdwnwKQ6wt0uEZ3cKh?=
 =?us-ascii?Q?kcaMvwZwEJ914J0ppS64lr6ejr0JsXu9sUn8MnLDZsMZrSRikysGmidnD85k?=
 =?us-ascii?Q?CK2tUW71mzrbLnMInuMn9tOGsKvACKIDvrbRQAwOnHCg0RpzM6v+fn/lwUiB?=
 =?us-ascii?Q?AXA9jv4IDEyrVIQTDLEOyoNG1VX0f0w1hL3JzTw1sdPfO4NeN8T7hg4Yu5AB?=
 =?us-ascii?Q?1C1AwrlCzTJrON9N+0o4ASvF0sB5rHZgL4oZNEBltP3W86N+a8lcWeyvpSBp?=
 =?us-ascii?Q?CiH/LuJOXqNm7QleR2Mp+KkspFQiUn3KBvwSOG9mBCV6EX5RpZHHAvqK95hR?=
 =?us-ascii?Q?3ceAvayqhBfisXwkWRDVGmjt1jW73JUa1JzRb4jZ7W2XQdd6+jiN5xx74MZ5?=
 =?us-ascii?Q?GEq9xP4m+akDWGV06yDYLsNTqQoYeGdIu+fpew244HfyIB1PMSc2Srygbt0b?=
 =?us-ascii?Q?95i6KCHwBgO3BhSTWS+IddvM5XBtUTfoBFP7ZGWKUz5YNop9SdIQfvFzIT14?=
 =?us-ascii?Q?PEdi/n0bUDcykCciBz+Kif8r0oEv+c8D75ULwF+1GO1KNo8s7se/D2eiPz1F?=
 =?us-ascii?Q?y+eZxX03Tw2I65iZDH33YJV3BtA71JPIsLRz2P0f8Gu2Hx76fPDKYqty0X2E?=
 =?us-ascii?Q?iSpHuU0kEXkmWMiivEI5oEwyqPZbeEqsdIhC58r1gUq154oAzF4aOxZshPNd?=
 =?us-ascii?Q?XJD9toD7vTGavDS98R0tXvHBlvTK9rp/LwgLf2mWaeoZNT7VBXo9u63An+Jk?=
 =?us-ascii?Q?GuxGRhSWYRPVZRUkoagIoI0vSrmZKYf6l3pq5gMm+bC6CL4D2xxTVvA05YXU?=
 =?us-ascii?Q?2+QsOyTgdXjP+Xk1QiApX6M4DdQDMD2/TY16+cuiLATBCbbvzBAij1HWKel1?=
 =?us-ascii?Q?131kAv430Uw0daD3qdDZpFfM/oWMBN8HM639zwckjkIeLnM1EhN0n64de834?=
 =?us-ascii?Q?PJeVZd0wGFq+QbpL4gSSwU6Fh6Qy3311UJfsRRmaoicD/lvB5nkj9THxBKkQ?=
 =?us-ascii?Q?dUySlT4rqu/s0E09Vkelht/FDpZekZTiof13msfB5TyR56sbdZHQvG/7bHCl?=
 =?us-ascii?Q?73rhv/pof2htNZsiNkdKZsWohMRQvgcuS7av66vEhQUaYPmn7bEflvYs9TR/?=
 =?us-ascii?Q?lpYFx1l8tWs/twbhRT1RsMt8WoE22+0HJJVo0dKQNnExok57ci2CfAuMyAt8?=
 =?us-ascii?Q?dnegaLsR0Wk+FOD6Pn+OtFRxEEsDwHiAGhGIXlk1FR7Joc6UkI8B2nko1KY0?=
 =?us-ascii?Q?GA2IkUOhMvtd+x9Oh8fOfaZqPLvauuLTPNeIX8/rko0GsnkqJX+CDHMgBku/?=
 =?us-ascii?Q?zeKfKJO5oSVrR5tYgez2RFqij1e0CpyRM8PcE+VK4HrUaEmI2HqdxbYV/0sh?=
 =?us-ascii?Q?2GWDzwcVtb/BJJ2J9m2EC8ScJ1bi2hvAFeXbPSbscX4umocnRgwclISI9Atq?=
 =?us-ascii?Q?Zx53Kg6KOJb5tDm7VFfjBrYk8M/cuJd6lnEWr8jkM3bi8cnG+jIb3VklPg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 23:01:54.6415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c128dd2-dbf1-4d78-732c-08ddb8f34604
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834

On Tue, Jul 01, 2025 at 10:51:20PM +0000, Pranjal Shrivastava wrote:
> On Tue, Jul 01, 2025 at 03:07:57PM -0700, Nicolin Chen wrote:
> > On Tue, Jul 01, 2025 at 08:43:30PM +0000, Pranjal Shrivastava wrote:
> > > On Tue, Jul 01, 2025 at 01:23:17PM -0700, Nicolin Chen wrote:
> > > > Or perhaps calling them "non-accelerated commands" would be nicer.
> > > 
> > > Uhh okay, so there'll be a separate driver in the VM issuing invalidation
> > > commands directly to the CMDQV thus we don't see any of it's part here?
> > 
> > That's how it works. VM must run a guest-level VCMDQ driver that
> > separates accelerated and non-accelerated commands as it already
> > does:
> > 
> >     accelerated commands => VCMDQ (HW)
> > non-accelerated commands => SMMU CMDQ (SW) =iommufd=> SMMU CMDQ (HW)
> > 
> 
> Right exactly what got me confused. I was assuming the same CMDQV driver
> would run in the Guest kernel but seems like there's another driver for
> the Guest that's not in tree yet or maybe is a purely user-space thing?

It's the same tegra241-cmdqv.c in the kernel, which is already
a part of mainline Linux. Both host and guest run the same copy
of software. The host kernel just has the user VINTF part (via
iommufd) additional to what the guest already has.

> And the weird part was that "invalidation" commands are accelerated but
> we use the .cache_invalidate viommu op for `non-invalidation` commands.
> But I guess what you meant there could be non-accelerated invalidation 
> commands (maybe something stage 2 TLBIs?) which would go through the 
> .cache_invalidate op, right?

I am talking about this:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c?h=v6.16-rc4#n305

Those commands returned "false" will be issued to smmu->cmdq in a
guest VM, which will be trapped by VMM as a standard SMMU nesting
and will be further forwarded via iommufd to the host kernel that
will invoke this cache_invalidate op in the arm-smmu-v3 driver.

Those commands returned "true" will be issued to vcmdq->cmdq that
is HW-accelerated queue (setup by VMM via iommufd's hw_queue/mmap).

Nicolin

