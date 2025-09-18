Return-Path: <linux-kselftest+bounces-41893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DF2B86BBC
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 21:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6ED63BB78B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 19:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521D12E1EE6;
	Thu, 18 Sep 2025 19:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IqRqQn+V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010049.outbound.protection.outlook.com [52.101.85.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE78C2E1EF8;
	Thu, 18 Sep 2025 19:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224621; cv=fail; b=paoYe7BB9BKH0U4Q8LjDbi1XROGQgTzfSGcgBD3jfg9/6NvBXlBSlWw/yz314RLdDAnY/UHcBMi3TBamMYKAERfpE4sgAWkIO6EC07O+1crX48f3qMUgStNdDVUg7uVJ4NmytruR4hdspwknrsVJ/oIz9ewAPOZkdoUVhQgKXq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224621; c=relaxed/simple;
	bh=CsbhLUCO5oEQAPPVycQmhmX34TICrqN9JwC82teJy7k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFiPVDwvMKS1noaRwpbJ9DKfpBdLjC9mzEvbnvMp8liMf1DeCisOfQmju/MiPWlYJr3dWYSv0j6sdFV3t+RuLUq1v4v9sa6NwbdS1uV91M1RVWLuMO39IZ1p9/2S9b6ps03bEgTUmnP+ril5DdOnt0dxP6/CLc3WzvT7f/4a2KI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IqRqQn+V; arc=fail smtp.client-ip=52.101.85.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmSZZcxzDKnjt986oHPkLh6IuVO85rKtRha7IlonFjhajcBeAY3w7a4HgONUtBgRS3bGDfB+/eU5WdWj5ohkPIbXlJfnQZ1r4dnQsyqJ12SOO0NvI+VTmZojdkZFjpM4AfDXCm1vX5nwHrUb/BUPt+WNXrZba1Z2kzbV+g0y1LFkBEghvmj1OcF5vlmqvsROYxd1eP4qYCKO7gsW6rPtJi80HWP9ydhwg6j2ifydA9Az0J57KchmoMgUOnau4ke8RmwE5E8rjysemKTvLT76BhcOTQZMvUavsksiNo0t6FJQyGXxAf7Cgl3AqXQefkRCtpDE2FsHQl776CgJ+kKFfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HN8DhfP0wIT5lNR3f0xCrbMTuIOqEphYAvskRmP+HCk=;
 b=pHPR+Ejy3l7oJi4w/d2YbBuInbuOdJUneVWIrbcgdB60V4r99I370YXEd1wp0+eCMcTzPIaDuujEGSDQ2zgzWpyXsxj18s8ojjWgcivu/gdMuzB+EMNv63cWHQt4s4BH4cWK1PkQoUx6w/2oDT4I3ISiLvMJaBhWlLmHeMpadzS5DvSi0YkCIHTvdM8Hr1BPxwxTmjUqjZYAXY+qjYG2zkMvXh9xZWLFkWQdIgLEUvluHQQGC11k98BVNRNguw4nfbOuMcRO5ZM4YYI8fD9Lrq04sxCkJDEhgzD9I3xwktJnLJc9GRxMZ0POGZyLePnoqP+LStjg/RVpOxWYrRKmxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HN8DhfP0wIT5lNR3f0xCrbMTuIOqEphYAvskRmP+HCk=;
 b=IqRqQn+VDMYczu33PMOeQYc2wkFrZb3gEMXbyFhFxm2VV+G1zt2rDBINZIlhCNXIsjL6EU+ADptdwpdyd+Fk0Ui07IV5Y1BJ9akadYQ3pNkjB9IjcI23/QB+Au2V/gSMCJ+G10WV8SiTiqUYAFN1OPWuGWAL9UFESMj+1yTaiSvdBHaQm3mQirjC7xNmFxJDuKQg78FSS5JGbuG7P14FTao07oGTgwOIp1RPW50OThiG3GFSVQrwEP3KC4MwTOx/tl5Wshj7DVhFdJgICOLuSfcO8cvVbu6nQ5+Cr8+mh5cV+csk5fus5X0NKfPdgDdXKaj8dqTwzGDB+jWvj2VG0A==
Received: from BY5PR04CA0004.namprd04.prod.outlook.com (2603:10b6:a03:1d0::14)
 by PH7PR12MB7453.namprd12.prod.outlook.com (2603:10b6:510:20a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 19:43:35 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::e7) by BY5PR04CA0004.outlook.office365.com
 (2603:10b6:a03:1d0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 19:43:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 19:43:34 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 12:43:15 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 18 Sep 2025 12:43:15 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 18 Sep 2025 12:43:14 -0700
Date: Thu, 18 Sep 2025 12:43:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Jonathan Corbet <corbet@lwn.net>, <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, Justin Stitt <justinstitt@google.com>, Kevin Tian
	<kevin.tian@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <llvm@lists.linux.dev>, Bill Wendling
	<morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Will Deacon
	<will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, James Gowans <jgowans@amazon.com>, "Michael
 Roth" <michael.roth@amd.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v5 01/15] genpt: Generic Page Table base API
Message-ID: <aMxg0bulOYF8HBJo@Asurada-Nvidia>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <1-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <aMDzLC9nV47Xvud9@nvidia.com>
 <20250915155152.GC1057776@nvidia.com>
 <aMuxUzvxQLvouG3c@Asurada-Nvidia>
 <20250918144943.GP1391379@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250918144943.GP1391379@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|PH7PR12MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 162e5e26-c93c-4e95-c0a1-08ddf6eba7df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ieFqYqReNECdSp8mKXBuqxv4RfVNkBKTwwD5QCbKw1BKmypih6S0FK2ImcZy?=
 =?us-ascii?Q?MrVrxslJH9Q2w4raFtkNkcWUzJD3CTF768nS+e+4nEgnbJVWc2H1ZJk0fCZo?=
 =?us-ascii?Q?QQXPplvesoZNtSRPitvQoN0vIkoebUqZSSnr1nIIXGz3I5xqdL6rwqnbegsO?=
 =?us-ascii?Q?BLlN0XLelHLoniVsH3iqgvwhybXJX8yHAHyXwx2GuArjsqTsIc2UO+iysywT?=
 =?us-ascii?Q?gjnxYk0FSD4EJ6zkSTs87TG88d3U5lvJKvI8herD3C+fcI62y8yROZTXKafl?=
 =?us-ascii?Q?LQGLANa8EUGer0HwccWCnfCWNwB0SMluSaW/qkXWAAQ3YEhE5IvSJ6KiNorh?=
 =?us-ascii?Q?fyonUqD70ZGWDufPeWyj3PhDEYqQ+f2vVA29ehxsWajv3AhxI5JtKBGQGipg?=
 =?us-ascii?Q?8tJDoYiuS7epoBbmqe+mSWC2sR3efo6YUkP6gifA1K/RoAEt3N5duorpiroD?=
 =?us-ascii?Q?sM8y+KIBUzjuUatPGMcssufa9MQqp9KID1WHpl8TYw5W2mOnofHWDSODhRiC?=
 =?us-ascii?Q?j4fWsvSGdw3M4DASOP4GiZtNmKgBnevg9nh5XeSyWkpF1+8YrvfT9bg0x4ll?=
 =?us-ascii?Q?EsZjqwl7XVuloJiwNt4LFG7SHtVSV5rhi7MpVORVb/ieDtn3LXKhzB0Q4CKm?=
 =?us-ascii?Q?j23roJTIG4bpltsRVxpfCl2Ec3BLsoSTv0tX1bb0GxvHpshkM5+mPUosH8Jw?=
 =?us-ascii?Q?ZVio0+3O40orJ7AXl/Yl2TC+YCyFpdKCn2JsDJQLVF31xSycEYTaneKa0c1N?=
 =?us-ascii?Q?xZndoFlinRoLJkBLZleTnJ/V//21mabemvsyLGjHwU7eH6MXxSDttt7Sedxi?=
 =?us-ascii?Q?FXYU8owrv8M0Rjjzmf/4+BHHNsAcfANWCEww72aCrT1v1WQJ9NN5JttxO7i4?=
 =?us-ascii?Q?Vap+Tb+O3JlxeTPLGW2/ejyexQZkJOJ3CzRJEnqXLcNR/tOpvi3PIMgaSmc/?=
 =?us-ascii?Q?r3zHBxIYfp/Vfz1qm4gVpMEoMJLCIVpJ7sisPbQnWbzfsxZQ6FSqH4X3vd7K?=
 =?us-ascii?Q?HjVZJ6FCMjcLyINwc69J2/XC/kv7T6WJ9Hp3detffM/mw/b4xB0vd9kW8syB?=
 =?us-ascii?Q?GcgSYy2d28zYK1GERl6i9U3oxg4Xs41rW6rro6QFuqKdIRPHnjwLncIzdPrr?=
 =?us-ascii?Q?qk+dDymdmrwIX2wORXUVNPtywf04jn+1i/4B04WC3kuoJ2qp2SuM/LHEJqGO?=
 =?us-ascii?Q?ZW9w+Z7QGe5j35zhEAzsGaCHCNs3Xe+5BAOR1tNVUT/8eZ92OoLv5yPqvxhf?=
 =?us-ascii?Q?e6vMBZPkYRRMJ1swiDpqM94/f0TqyP+aSshzzpXrPvnepCvjW/ap27kWwUx4?=
 =?us-ascii?Q?cvdgGTsA8Xyoc3DpEW8oW5MLIcLl4oUOAiKqP+OAHRMNN9JDDe1gmC7gKjgQ?=
 =?us-ascii?Q?DPv7kmno9jrzaFdoKMNcUJs4huYKFbGzdD/3zXiCu56YTfT5Ow4JOcRofm9v?=
 =?us-ascii?Q?XvrnqUE8I54i+zatJGp0G/BmzLWhk19gxu2VqOjLj1QTj50kv0kGL3BhGMFv?=
 =?us-ascii?Q?YnKnszwlf2Ev1CseM+s+g5lhpRevUuu69Ddt?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 19:43:34.9748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 162e5e26-c93c-4e95-c0a1-08ddf6eba7df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7453

On Thu, Sep 18, 2025 at 11:49:43AM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 18, 2025 at 12:14:27AM -0700, Nicolin Chen wrote:
> > > > Then, the "entry" sounds like a physical (v.s. "logical") table
> > > > entry, e.g. a PTE that we usually say?
> > > 
> > > I choose entry because it is related to PTE and in most cases you want
> > > to work on the entries. The replication of entry to item is somewhat
> > > hidden.
> > > 
> > > From a HW perspective the TLB should be loading entries.
> > 
> > In that case, "entry" should be a single "physical" element v.s.
> > "logical", right? Because that's what HW/TLB physically loads.
> 
> I would say HW/TLB loads logical entries when it supports
> contiguity. It read a single table item and expand it to the larger
> TLB "entry".

Oh, I got wrong. Thanks for elaborating.

"item" is a PTE and "entry" is a group of items/PTEs that set the
CONTIG bit. TLB loads all those items/PTEs and combines them into
a single TLB "entry".

It seems difficult to define which one is physical or logical, as
both "item" and "entry" physically exist in page table and in TLB
respectively.

Nicolin

