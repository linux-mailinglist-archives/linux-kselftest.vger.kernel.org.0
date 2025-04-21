Return-Path: <linux-kselftest+bounces-31261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 537D3A95531
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 19:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D911895B86
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 17:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235791E1041;
	Mon, 21 Apr 2025 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lR/YQvsy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B50984039;
	Mon, 21 Apr 2025 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745256251; cv=fail; b=sqFINQ99mXEiI39ObVgM3OCD8+0nsFW4kLfziijNt9b09X8nXYq3YRg3kF8CsQzELaXvo+iOlnQPUOMhJRZMTy2aUm47Ih/fWi8JRJrEv5jV9pG1ZKUUPYo99N14hCCXcGaEfZ3IaKdTuTtDH5RxIEIGUImW/9da5wu6t38X0fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745256251; c=relaxed/simple;
	bh=gwdpVzro4f9uhRpO5LqhcqQUYq/vwTy4xR9nx3U5CHw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPWmKa9w+bQ66RbFMCbnhMEM6uVDDmBTbso8L5WyLt0nThdOhit7DlFIqWoXYGQSykUNwUnb0eTSgP2eDlZXw6jaRBG/X4ytFMRTiZbwjJcXBL9tjS7BrAkp/mmV9PJtH/FPFEzARdKy4l8RLqdog+zfJT+HixqtRzl/DvrONbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lR/YQvsy; arc=fail smtp.client-ip=40.107.95.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bllOGq9mtAH+O4WXAOu8FijF2fXg0MF4if52CnTwy+C9qvgD0mb0rCh+DDf3Cptci9MX7baBdCXy7Vx/zho20ofaZK34xhJci60HRkM+8qwiQmZGgqnkMMlXoZis4XWp7v5G0MWqL9R2D8ZdkPGEIgXBR5E7SlATP7WMEvro38gcPs9UnWIKw4hDz6FH/zXVLTqqh/3NgejJv/ciRUWi2ll2z3HV9A7HVwy3RC1pFvyeMvAIvHlbhcMmw4kis7IlryOhtXpPS5sJBjFKzOwCu8y+JpnmHIhbU3HIgXaoDhB5z1nL803nq6qvPeXg2L3Wn2Gn4ohVkzh+F7igTWRn1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Op9MqUSJ2NT7wXR656liCNBkij73C90uIHfmxS/FYmY=;
 b=np3n0RWuhmSJiuU0fgCEaBs7eljYdlK/H1765d6IoDZdHk+IeakdFc4pkr8JOFr52ygngN3DFQTgBkQWULsR84Fht/ABnpcoiEHR+anROcOOI1+R+NIHIxAhWnrV8qF0voJWPJMMu8twmw+VmAE4ZWXztlZdNo2X2Bqdk+cuV27S1dPmR6aqs13gDeLI26wdh4N+Q9uDC2OI2wDjomou1KUmcvBpsNhe9R1L9iaVqKDVNzvmME4+RdRmQkVZtH6ZSjRSNwaKfhUBwTZZhBxXclM3ejCB51sdKLxQhGSWZNhIncuL+HlCWVISxEEecyiu5k8D1UePrP3E/05ymyr70g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Op9MqUSJ2NT7wXR656liCNBkij73C90uIHfmxS/FYmY=;
 b=lR/YQvsy+P2prhNyTwkBRFomUtxi07WyGaUeKiC7irL+HFGXye9hpd4QQNPmjJn0bnLmsw7Ji5nv5fSXw8AnnmLxvHXLiYx13fTYLvMOHTsipmH8A08WO4HoDZTMWeLYAfp07kiP2QclUmqhVtxWMIQwDAjtL6/+hBzVXMWh5XdAQVavTcUwELsxVtKGEdq/FD857hYySb5QiCjrQOTIngtSo1X0YQDq0uMiH2yy3zNbMghFcG4/mWUNDYD9SpaW3Hl5DqPToakXRm+Bnp3SzbbjS95IAtAPDkYgKZuRAODWo9TKneZasAbagzTP44FPP7GfxxBAnuR4HccscPbkag==
Received: from SJ0PR03CA0175.namprd03.prod.outlook.com (2603:10b6:a03:338::30)
 by DS0PR12MB8444.namprd12.prod.outlook.com (2603:10b6:8:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Mon, 21 Apr
 2025 17:24:06 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::bd) by SJ0PR03CA0175.outlook.office365.com
 (2603:10b6:a03:338::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.33 via Frontend Transport; Mon,
 21 Apr 2025 17:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 21 Apr 2025 17:24:05 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Apr
 2025 10:23:55 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 21 Apr
 2025 10:23:55 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 21 Apr 2025 10:23:53 -0700
Date: Mon, 21 Apr 2025 10:23:51 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "vdumpa@nvidia.com"
	<vdumpa@nvidia.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "praan@google.com" <praan@google.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>, "mshavit@google.com"
	<mshavit@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: Re: [PATCH v1 10/16] iommufd: Add mmap interface
Message-ID: <aAZ/Jx1ST+llBL2Q@Asurada-Nvidia>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <c332a8701959c098f747dd8e8fa083ceda2bf2c3.1744353300.git.nicolinc@nvidia.com>
 <BN9PR11MB527664BDB7933FA0B7981EE68CB82@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527664BDB7933FA0B7981EE68CB82@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|DS0PR12MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: 245e07b8-f2ea-43fd-67ba-08dd80f95154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0IZcIclehyMHc9v2WZ4XoqZ91fSbgZySp5iB/S8gXNJIXrpw/pi2kCDVCi1f?=
 =?us-ascii?Q?+E2E5Kv/nufMVjh5DIVNn7yhESnmxSFKdrAJPatgNTZV8WX3Z9M6El2csrRy?=
 =?us-ascii?Q?X9Gdep0ZCOEk3OWgNCSfRtQLQrxVdcpaPotbG+0bqy3QQAVDRtkxAYrBZ0R8?=
 =?us-ascii?Q?FhT/THWnY+8B5q+LoJxBRrOtJaRobW3AmmgNwA5PVGZjRhrb00KHcO/ULB4v?=
 =?us-ascii?Q?57SiZVDbi/7vneAXOFlUIxde8LWM5cdsMXiBrsw1hJmMQ9jKfVNEFO90dDyv?=
 =?us-ascii?Q?TIUJC/elOrZBZ7OBmn+WwdnNuYmsPZwo75Rxk0ep4KwYgDg+RkMpBJLbgtSa?=
 =?us-ascii?Q?DgOwz1kzZIpZyfwF0+jWIkbkHRh7rx7OGa3ghU/KsAODQ9r9S9zWDGwe051/?=
 =?us-ascii?Q?emH4fPJsOaXxojcicP4ODhyz00OKXunr+1ggsbNpAbQtYROLsZ1BSSbMzmU/?=
 =?us-ascii?Q?q4WbIQygJfbyomD/Cm/jpKFaLGU6ifHnCvivTmWznlVtWUlkOzWELJv/jiUU?=
 =?us-ascii?Q?LxAPfYUTX0b9NC48UqoAdtJGl1totRECJVBjE9FKtiLJLYP1v2slfdS7ppAq?=
 =?us-ascii?Q?wBmebJN+w7Urh/6JQuagru7rjBS0JOkmKZkxQ8UsVynRHPm21iXfNfCmvP/F?=
 =?us-ascii?Q?qhH6SOk24p9IG3t7xW5L8qN9Dlh9OVgw5EjMTrFHkGMeWdDSNUDGAWpLlncl?=
 =?us-ascii?Q?ujzYgUuuTgw7cNEfOpFvR6/6wMcDqorGg2OzuYzoZ+qKtyTGweqfKmdBhvAS?=
 =?us-ascii?Q?yHqmPhsL3++OPE9xhALsd7Zn997qeBIyhoZYRvj081Ueionu2NzyM2mdCFLp?=
 =?us-ascii?Q?26DG9sDWiorCELvbkE34z3Wj2J2XJrlkNHvm4K/ACki1vLmEFKXzlsO3qjIX?=
 =?us-ascii?Q?e9DCb8Y6SC9CA1tAVlt/xGs9stKaxKEArhYobyUrYsWfZlVaAHP/8RqsKDQw?=
 =?us-ascii?Q?ik0Unl3azXv9B7voJEtPVl5SSGWsDZWLcyl7Rghhnds7mHKl6QTXUTddSwSc?=
 =?us-ascii?Q?RJ+ZDubHqjPzyNCgL99vv8zWH/M36osvUPn7eoVIhQoLeuG0/ICAuCX6cyHj?=
 =?us-ascii?Q?aqwiQDZmqvQJNvo/iLWJsedtFDICQoHuHL1oGMvjZ1EigUN2PfsmPw4Sxcqq?=
 =?us-ascii?Q?x6AUQmXlGfGu4d/Ww1pYYbThAvEc1TdXv96GAtPxqvrIlp+RAOxinVVtoIWw?=
 =?us-ascii?Q?6jIm0F6FBQD2MCQv0x1xvgXhjeFuBGfUx8e6Jhhw6SK8z1eJXZkNCb0417Ap?=
 =?us-ascii?Q?YsgcJoI3C+1GU+mmgpwBibgCT4rlZb9HbNaqqgFVwnP9i8+ZBl+QTOfbAAVD?=
 =?us-ascii?Q?T1w/xNw+31gAbUFKpfTEIT8QtluVjWbsRmk/TuRz8VAZcTXcfu8Emgh9baKd?=
 =?us-ascii?Q?EXjk8whHvMEm35zxHRL0bdQJuS8GtAvr/0KeWGn8/OqkHBYGrK9sgs14DR/l?=
 =?us-ascii?Q?2VM+GWvxbbBR/+J+U1x0NNLFXrld+kUYNBpsklRbWY9wwK46FYeR+E8IFUpT?=
 =?us-ascii?Q?W5KGyakZa5nSXSk3Izd9ibThqSmNr0epW8zl?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 17:24:05.6020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 245e07b8-f2ea-43fd-67ba-08dd80f95154
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8444

On Mon, Apr 21, 2025 at 08:16:54AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, April 11, 2025 2:38 PM
> > 
> > For vIOMMU passing through HW resources to user space (VMs), add an
> > mmap
> > infrastructure to map a region of hardware MMIO pages. The addr and size
> > should be given previously via a prior IOMMU_VIOMMU_ALLOC ioctl in some
> > output fields of the structure.
> 
> According to the code the addr must be the immap_id given by previous
> alloc but size can be any as long as it doesn't exceed the physical length.

Yea, though I start to wonder if we should simply close the window
by forcing the full range..

I changed the kdoc of the iommufd_fops_mmap():

+/*
+ * Kernel driver must first do iommufd_ctx_alloc_mmap() to register an mmappable
+ * MMIO region to the iommufd core to receive an "immap_id". Then, driver should
+ * report to user space this immap_id and the size of the registered MMIO region
+ * for @vm_pgoff and @size of an mmap() call, via an IOMMU_VIOMMU_ALLOC ioctl in
+ * the output fields of its driver-type data structure.
+ *
+ * Note the @size is allowed to be smaller than the registered size as a partial
+ * mmap starting from the registered base address.
+ */

> > +/* Entry for iommufd_ctx::mt_mmap */
> > +struct iommufd_mmap {
> > +	unsigned long pfn_start;
> > +	unsigned long pfn_end;
> > +	bool is_io;
> > +};
> 
> what is the point of 'is_io' here? Do you intend to allow userspace to
> mmap anonymous memory via iommufd?
> 
> anyway for now the only user in this series always sets it to true.
> 
> I'd suggest to remove it until there is a real need.

Done.

Thanks
Nicolin

