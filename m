Return-Path: <linux-kselftest+bounces-33166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C90AB955E
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 07:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C843BA04531
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 05:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C6D1FFC77;
	Fri, 16 May 2025 05:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="afY7gQ3M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3217D6136;
	Fri, 16 May 2025 05:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747371779; cv=fail; b=knPn12oWStBeyQ8qNlozkTsk8kD/dYxY42d4AT7cb3MYyWfrFwYJHbrtKty2GKrQZo+9rf7pzF2QOXk8BIqeRqdAxC+CeNKax2IiYYbo03YBhRbqVeSh+ARAR1bheEc54DyFrFl+p9hBM2oUK1Ie77+UXSIVnaAoehNJfwCbfwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747371779; c=relaxed/simple;
	bh=/4y3zP2y84tpSM2BpMC77OGt5aKtKoGTugu4gstjiYk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvHkMQZ88wIW3PXOs0pQEdhqkVeSaBxiMft16TohkhqV3qX7rSVir1VgX9bqtPQNEmNkERBBKGZRm4sPRB9+XRJMevc77NQhO9QQ0uxzLFOrC/TrwAO0qwvcjQpmUhNeIWrhxCPXbmLwcZkwNKjP3gcHhg4i1zjvUQX/eNqh/ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=afY7gQ3M; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jkhbd8mAN+3jm+5lG74E5Hgik5sjJFqhQSQAsymogzhq78pSC+aw8doJJQuAOZltg3/Ej38GmpH7GW3cx0AUhWTHPlZWsBlLDYWu/0RvNjH9JkGRZMXj8b2ovsbp5hs5oy0ApK9E1C95hs97cIPhIWQAnvXPZ4d2dshml2ZiPUi+KAgYR2klQvBn68XP2V2iU/6x3EY4UfR0buiCWq6ww/CGD3Gqsbs2MgB5ovZZc0M9c7xarnP6yljwzMqWq2wUNlY12aKz6CXVN98ViEweCBKgzr7Q7LHdKNg7ithhMIbmKdgseEWpVhMfDE2LWpmNW8tg57j10YfbQA5SCeAVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJZptlc3kZXrcsg6ti8YR4h6ZA+kKFubq/vK1GxtPoc=;
 b=U0SVOfG+/UA7uY0tK+6czig352FbrRBWXPDPq0G3uMim/OxivoZ5Z1mc5Yeu0KdE+oQtWmcXQV1olHB7SiyHv5ZbDojWZ6ogcm73vua5KO4RxsW7TpdubEtDARmJ3E7Cpq0a7NyNlUFWpNhg2X9cDrR/lku6VXENLY1L4SfJDDxtaIKZbB0GHRjS/Qk39o7ghIh6GGfvyfDQn0ZYJohMnLoVuAnx8iCepndovXIIOcq3Y+9tz+0pkXHzSn2GuJS93+3jJIGylCaSea1ID7vjUIoaDBeN3eEoMOo+vovoApuMWQPC6fi7i0sa9Gz6aL956cDGIsa6znITv/2fXuYNDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJZptlc3kZXrcsg6ti8YR4h6ZA+kKFubq/vK1GxtPoc=;
 b=afY7gQ3M24vWSbchn+0tD9626WkbsM2677B/BEiIWppO8lG6H0Tl/+ak1NTSTjwYcx2OrHVNGAL8LDA+0NdsYRa1dtnqNDYl8l4bu9ID6EkCLF9EYzsS9Nbt+8KepjyYcFLJNDnQxpCnqR+Duk3USIDDE/sFmRJHSFGKmkhFpZE=
Received: from BN9PR03CA0947.namprd03.prod.outlook.com (2603:10b6:408:108::22)
 by SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 05:02:53 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:408:108:cafe::99) by BN9PR03CA0947.outlook.office365.com
 (2603:10b6:408:108::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.16 via Frontend Transport; Fri,
 16 May 2025 05:02:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 16 May 2025 05:02:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 May
 2025 00:02:52 -0500
Received: from amd.com (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 16 May 2025 00:02:45 -0500
Date: Fri, 16 May 2025 05:02:10 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Justin Stitt
	<justinstitt@google.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<llvm@lists.linux.dev>, Bill Wendling <morbo@google.com>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Shuah
 Khan" <shuah@kernel.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, "Alexey
 Kardashevskiy" <aik@amd.com>, James Gowans <jgowans@amazon.com>, Michael Roth
	<michael.roth@amd.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v2 03/15] iommupt: Add the basic structure of the iommu
 implementation
Message-ID: <rvrpqwvrrqkledbftjzhgprowwc5sulngs32vkurb3oxk7c2fg@5qnorfs4vzyr>
References: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
 <3-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
 <pntkuh63y26rygrkxegbzncvc3shtplucrnzkkz2dimpkfyn75@uekvyuz5kred>
 <20250514155411.GC382960@nvidia.com>
 <2459f14b-4f4e-47b4-8f79-6af784ef6686@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2459f14b-4f4e-47b4-8f79-6af784ef6686@oracle.com>
Received-SPF: None (SATLEXMB04.amd.com: Ankit.Soni@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b478bb-18d4-4abe-c67b-08dd9436e9e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?duTNEsRAX5Nb4WUlg1vwMDPuVqfdIU6YmXskaKAOnPCrba5PTp7NvjbQ4cr8?=
 =?us-ascii?Q?XjnEvZCv8/rB9qbj4JF7nHEMyk8/NJinNtB1MSmlJWAeAed+qnWmRTuHzfT/?=
 =?us-ascii?Q?znj//MqA5uFj/qbWwSrazCb1AhckwEG7cgJwDtbAoCWTYwxUv3m93j6HAXqw?=
 =?us-ascii?Q?/38ogDyBL+o7xO2YzRX0Li/J/sOkpv5/W4gxweav4Efktd5Aa6WE5uC7/1p+?=
 =?us-ascii?Q?HEAOOsQo0phzXXNbtd6wkX8yRhWAEuD4cWn+vzIK9vLtvXlP1MqnYybnIxby?=
 =?us-ascii?Q?xw2d8kSt+AdS5VDT9wvTe74D1pCqZRvqbsMFW36navaJPo+XK6VX4c9QTzkR?=
 =?us-ascii?Q?q+fdTst02ZGkk+uT+p5GpTR1x9v46JsXKJrsuC00CVfJsLuSZdF+ycnEkRaJ?=
 =?us-ascii?Q?Nhap06liAfii4Yd7tqUE90T1JWlFOFIG7n52cpwaDtAes8830b8Dy31Ooo6X?=
 =?us-ascii?Q?cV6ND7GbkRcTDMZbirYYgFJhwrVQynWYEUdK/lNCvA1E6vQ9mjr0JEg+MuAz?=
 =?us-ascii?Q?Gf+86/NWkZEOdvl3O8/dwyMS6VAWkQSygtSQjj3MJUajbToMrTxhtWE5yOgD?=
 =?us-ascii?Q?+EwmCLFAiE6YyNZ22f599Xjsq8n7S9VPrgqTkGkvN4wlO48bpZuFLvEOJJ8I?=
 =?us-ascii?Q?9bxOYZGZnCmjhBV7mPs93PwFnW9ZMK7DUoHAXAqv2AmSAX95Ai9217VdfWu/?=
 =?us-ascii?Q?M1mGj2eoM9D3B51etyioSrw292Xmxl83AQOBMOdvpkp1BMDDpix93jfdfIrG?=
 =?us-ascii?Q?4+yziKaKvwbyNEJu9aDAEUEXWOAted4LcwMebClFOp6XKiFSAgmWYvFQ9FLY?=
 =?us-ascii?Q?MWe5Pi5PolURrGIcFGeHLAn+OvIX+RoN9ci47EvD5j1sLGjz4Nl2NoAGOriA?=
 =?us-ascii?Q?0tT7XzAAQB6oUiMLRiYH0lXxV1uzK87NYRm6JJTReQ4aEBLhWve6YzyMaljR?=
 =?us-ascii?Q?RZ1C7RIXZma6ZyyJxM12bCIC+BZSwycQ3s1j0jpjC0knNVS0Gqbo/F5MTyOr?=
 =?us-ascii?Q?2p7jwclhJrNdE0vMHL4pppvSO6QDNNu1+ZwQEGM61eSpzHnvRRkEa3bj/ICq?=
 =?us-ascii?Q?FtaSwAynAApr53xyOzG5aWbd3DGmiUaARgOFVOgbN2PbYEYRTIkGJ+d+7d+3?=
 =?us-ascii?Q?lcGVLLBNrVIB4f31mN3Uy/dRSCiBJ3D6hYULcuo3SrLE+sHFRozriN/T4pef?=
 =?us-ascii?Q?qYf0ksMnvvh7HxGiw7WS/wLMuJXM7OnVCiBrCAkshyfhnRO17HWTAjRS9NSY?=
 =?us-ascii?Q?p7UkCxMJJJc15eZMZPlEruanfeWnRvZkHInHp1msI/HMdp+dfPShiMyhE5p4?=
 =?us-ascii?Q?xCxLmL6BWq2GkUAvSNXv+IHQEGuCI4uwCcCCGLFv5Ljzo1+3TRabiYQArP+k?=
 =?us-ascii?Q?eTseJ5AhYZAcIlGZY3Cv1RWH+/ANMEKV0xocKU06bV/Nfmo+lnjdmPV+XfvP?=
 =?us-ascii?Q?2s+KEbu+lXw2mRz7FL49o9CN50ltpwapjW3i2i9D1gyYA4vSqkxSVsp/4dF3?=
 =?us-ascii?Q?0m4jVpOqqxG6n+8x80qlp1h50M8byHiG+qcq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 05:02:52.9396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b478bb-18d4-4abe-c67b-08dd9436e9e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228

On Wed, May 14, 2025 at 04:08:09PM -0400, Alejandro Jimenez wrote:
> 
> 
> On 5/14/25 11:54 AM, Jason Gunthorpe wrote:
> > On Wed, May 14, 2025 at 09:23:49AM +0000, Ankit Soni wrote:
> > > I am experiencing a system hang with a 5-level v2 page table mode, on boot.
> > > The NVMe boot drive is not initializing.
> > > Below are the relevant dmesg logs with some prints i had added:
> > > 
> > > [    6.386439] AMD-Vi v2 domain init
> > > [    6.390132] AMD-Vi v2 pt init
> > > [    6.390133] AMD-Vi aperture end last va ffffffffffffff
> > > ...
> > > [   10.315372] AMD-Vi gen pt MAP PAGES iova ffffffffffffe000 paddr 19351b000
> > > ...
> > > [   72.171930] nvme nvme0: I/O tag 0 (0000) QID 0 timeout, disable controller
> > > [   72.179618] nvme nvme1: I/O tag 24 (0018) QID 0 timeout, disable controller
> > > [   72.197176] nvme nvme0: Identify Controller failed (-4)
> > > [   72.203063] nvme nvme1: Identify Controller failed (-4)
> > > [   72.209237] nvme 0000:05:00.0: probe with driver nvme failed with error -5
> > > [   72.209336] nvme 0000:44:00.0: probe with driver nvme failed with error -5
> > > ...
> > > Timed out waiting for the udev queue to be empty.
> > > 
> > > According to the dmesg logs above, the IOVA for the v2 page table appears
> > > incorrect and is not aligned with domain->geometry.aperture_end. Which
> > > requires domain->geometry.force_aperture = true; to be added at the
> > > appropriate location. Proabably here!
> 
> Thank you for pointing out this issue and its cause. I originally tested on
> a host with SCSI storage, and after your report I tried but couldn't
> reproduce the hang on a Zen4 host with an nvme boot drive. I wanted to see
> if it was a pattern common to NVME, but I suppose it depends on the DMA mask
> chosen by the specific driver.
> 
> Alejandro
> 

Hi,
Can you try with below command line?
"amd_iommu=pgtbl_v2 iommu.forcedac=1"
Indeed it depends on DMA Mask chose by nvme driver. if force_aperture is
not true, iommu driver will use dma_mask in place of end_aperture.

-Ankit


> > 
> > Yes! It got lost, thanks alot!
> > 
> > Jason
> 

