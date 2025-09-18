Return-Path: <linux-kselftest+bounces-41812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DB6B83481
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 09:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FD417E8E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 07:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4532E7BAA;
	Thu, 18 Sep 2025 07:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fzfJ4KOg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011022.outbound.protection.outlook.com [52.101.57.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFD82E8DF3;
	Thu, 18 Sep 2025 07:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758179686; cv=fail; b=Dfy71L+27iPFqx1XAFcOhO64hEQ9aSXNbSqTdUmtpFxF1BKVD1AXHkMMR6jfERBFOiGO+BQlyHIU9NMkNZLrcem8JjpRK2Vnlw1tpI9TTyqr2hXQEI7ROQWvcsMnMq9ciFL68mUQTA3Zf6n1UGe2j3yblzrG4h4pKvcM48rBdGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758179686; c=relaxed/simple;
	bh=/Kj+KEG2b6G8dFIiy3s63r0rb+mNNKXLUxKea6xP1Bk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ihq58yv9wW/zZiS9NN+Z104xcGJW1jqc2FO4R5NzP0f7bCnRnOuvP48EGlOhHnDoxOnxh66GvSkbJvqquxwypnNGIfM6+wXi4WUiqPWRfh+eeRqmrgAu2SuJIYVec44AxXzrM1Akz2MZfgr9pxHxGnDwyjFmq6yOX21i+ON8MdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fzfJ4KOg; arc=fail smtp.client-ip=52.101.57.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZyTdvJl5QNdxYApHhrcvb0FQIx5Qrtt1E/rkJFq+wI0/dM8HQelJnvXx2ywGi5NW3rNKT1z5UCLB4WOkIraIeQpF4QrHKAsfnf2mRUki2xlzSEC6yDkfiGLuUA7QcDUu8BJwT4PiMVdrlvMmXp6sVAKAdgBZ1z2XE2wuoA3wPyP3mylCfYrVBQcEOPkBAoyf0Ou3vOdh4ueX8QngbMLlUTdZhvexvqYWzVrXBTXu8jVDcsvHqA8ais2gq4THdrXRjzH2Hk4X8WBDm6Ln8Y2GknpQXffkITxQv92Rj+0sILpJm+UCaBK6L+S4rU9lwi+3GEducAinXu+syASsoIkQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4MtyDq6dS59ST2okzzqBe5iJiCtvdh54l8lEv0tbP8=;
 b=QXOAt4fwC/y2x62yoo1Z2TbjenriB03IRl+DAu6I6SEWkOokaUeoRd9VrHozn+E5OamrMGVJYzvi0Cf+xOMn4vcFEQBUHNGqttRlgIrGSFN9YMBzCHrViRMAs+z2ad5D4Z+P0C6cSkukb1ZlAY9dCS6gfDiyjPk5WfHKBQrT79zrJ/uUYfofQFpANxYr1zSKp+nHGLvAjg1iFLu+4LgRt9Z+5RB752fahOinvOgHPWxq0zxPKRT5XpQ5mquGRrFaF2IEyzigbyUeKMm8ZceCVGaLvD2D69esHS+9Ld9D5G8vwj8v+d79miz9e2LBWF7+XhujymcSOtMvVqdKXY/SeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4MtyDq6dS59ST2okzzqBe5iJiCtvdh54l8lEv0tbP8=;
 b=fzfJ4KOgdIerObBabkALvvvp9wZgkrJYSrcUvgt2HhaH8X14qVX2sjDb5kiXehSFV7/E1tfYOhiJnnqwCHk4Z2Uj+L5Zhj+iWTUc27IVnr0TOQsaNamuywAqPnMuxSsGvLqHfmWVUABGBQQ6bpM9+oK8XFS//W6HuoRzJv8JLTymKT71HkBaiaJT9yZqCpFjAGDZ8BRiObQf43OGBMKGTZ8bKMSmwxAygC3LbzfXn7kBG1UVdTFkKrw3fIceWjCYiYQuIwdEUPcl3hkDs02GIFHicq7EWcXtvTEad4oKx4LZk75TkB6HFthCtJFI6xH9fwTIpfnQyRi0VWz91hGmnA==
Received: from BYAPR08CA0044.namprd08.prod.outlook.com (2603:10b6:a03:117::21)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 07:14:39 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a03:117:cafe::a3) by BYAPR08CA0044.outlook.office365.com
 (2603:10b6:a03:117::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 07:14:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.0 via Frontend Transport; Thu, 18 Sep 2025 07:14:39 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 00:14:30 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 18 Sep 2025 00:14:30 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Sep 2025 00:14:29 -0700
Date: Thu, 18 Sep 2025 00:14:27 -0700
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
Message-ID: <aMuxUzvxQLvouG3c@Asurada-Nvidia>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <1-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <aMDzLC9nV47Xvud9@nvidia.com>
 <20250915155152.GC1057776@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250915155152.GC1057776@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|BY5PR12MB4051:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c53628a-ab0c-4a7e-5a61-08ddf6830843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vSSWt2suZ1Mj5FkGl3qX6tmZsz5s1RjW8uIP2Zs0FIGW2Yn99kBqcmIyFWNg?=
 =?us-ascii?Q?kEd+5b/JKGjW3S61X22nmIEPxuGb49izocK3mA8NEu7TNMNuSSXw/CUilauK?=
 =?us-ascii?Q?vUwN045Lbgxsv09dXXkVW2wDLTOPeXjyJVC4YcyO6DYec3hd4+x1bhnrhXbs?=
 =?us-ascii?Q?qXM7ra2BCb/QPxOfnNRXdrSsxi0tbpB5S1fihKlG/ibLrd86l1S+pg8WqTuG?=
 =?us-ascii?Q?id15AzokiYmOVjByb0Wc9yTGuU/kgU7ULZAE2Sy/SjvwcE0cbvuCYP9xBgkO?=
 =?us-ascii?Q?XOTbzkNOBTMHRTPxvQPZcK9H7mI6eL7CpCEouW3Sd407+ao+LeviicyPJM3B?=
 =?us-ascii?Q?w0AxatO5NW2yhnvwEgCWnIhiUQk60UlMSFzevWCrka1mXgG8U0Omnav1TIb0?=
 =?us-ascii?Q?SMCfPuhPA/fHpZJQoo7YrKw9AzLgUFKbiwWlHhjtn3/9HUEHJCAIewXNDRH+?=
 =?us-ascii?Q?0zMW/xSl8y36jXogt05Bao7czizOBmnEgNDZTIiwvRnAaInIEjh8T2J/AQqf?=
 =?us-ascii?Q?DgRA0uSALFqX8gTQjdB7f7g/082Tl5RBSY7Q1gm5//YuJIp9ObDUehBJQL8Y?=
 =?us-ascii?Q?5zh8TSGr/bmhpKg5oBcsYOAy1vlXRU3UR6q1uNQpm8oVvp3wlw6YtHhmnQGa?=
 =?us-ascii?Q?rtcc11i3jr9Gx4lcTBSkI/j0AT6Nxor0s+vrvKh1hhrFyvlt7C+8mNpMY5rZ?=
 =?us-ascii?Q?rFxqxJpc8YoJvO+JUOMNt+Cqpp9N5cbqtodRaLYN3sZT9OV+bSu18hgz2Pdp?=
 =?us-ascii?Q?TeduPtYPpFdpeD2bjuEFTzD+kQn02RURnwDi1/aytyEQ7p9WWpvmrPuReIxc?=
 =?us-ascii?Q?TZ6gLm9z5tET3e0q+tPgVPdOMzQh/nr0IZZ6HKr2k/huOsb1ki6hvA6BFoZc?=
 =?us-ascii?Q?7lNvwG7tRhWGgzhx9DiDEZ1kvz5JHgmCvydvAo+xB2NdDR2c3wJbeQ19x88g?=
 =?us-ascii?Q?4kRxkZ/d5zu22zOlMxy3W+yqh/9GXeMV/y++IJbY19JXyOg5RtGJSUTe34is?=
 =?us-ascii?Q?sLpy00V3n8UwGldPTMUl5+LFkMg7wp22mPfrIIKk5D3Lr9iS9m+XjQjqyncE?=
 =?us-ascii?Q?vkQOW6Eo4gRFDMv4kEfJGcuIAa0+xPQRvWJ8zMGdt9HY+bKdS+6uNUgOMvvf?=
 =?us-ascii?Q?moN+Wwus0mj4N3xkOtW0F9qi9ID1yhbjF/BU7J8g+p4gwjEduakHDhApyso8?=
 =?us-ascii?Q?1/StsX0PzXhfX5EcIP8eAcrvMQrRXS03JjblnoPqVnNoUatY8Ej4K97Sin33?=
 =?us-ascii?Q?r3R1olD3s9Jv1SUA8dmWW6jA5Q4uhm7Z3+FcGPgAvyraInEj5UZsmrreicOs?=
 =?us-ascii?Q?Xk6kLVQgDjAvMt1chigHYgb9//RGhl2KWb0ykflMw1koN336YI84VAuhsBg5?=
 =?us-ascii?Q?GYls/HwwE6ipMkYpTpWAVr2O3ptF8wNblahhVEJwB6OyN8BS2HX5HOSafvjA?=
 =?us-ascii?Q?ykQ66ad1sHVE5ppyAFxW3pfuQwiQfam4W1CJHI+S6tx4k39UClLu7sTj481H?=
 =?us-ascii?Q?F2Uf3/nmQoEZbjnx5y9fLWFmGKYYWTSQH9BL?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:14:39.5926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c53628a-ab0c-4a7e-5a61-08ddf6830843
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051

On Mon, Sep 15, 2025 at 12:51:52PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 09, 2025 at 08:40:28PM -0700, Nicolin Chen wrote:
> How aboutL:
> 
>  *  level
>  *     Level 0 is always a table of only leaves with no futher table pointers.
>  *     Increasing levels increase the size of the table items. The least
>  *     significant VA bits used to index page tables are used to index the Level
>  *     0 table.

Yea, this is clearer.

> > > + *  item
> > > + *     A single position in a table
> > > + *  entry
> > > + *     A single logical element in a table. If contiguous pages are not
> > > + *     supported then item and entry are the same thing, otherwise entry refers
> > > + *     to the all the items that comprise a single contiguous translation.
> > 
> > So, an "entry" is a group of "items" if contiguous pages (huge
> > page?) are supported. 
> 
> Yes
> 
> > Then, the "entry" sounds like a physical (v.s. "logical") table
> > entry, e.g. a PTE that we usually say?
> 
> I choose entry because it is related to PTE and in most cases you want
> to work on the entries. The replication of entry to item is somewhat
> hidden.
> 
> From a HW perspective the TLB should be loading entries.

In that case, "entry" should be a single "physical" element v.s.
"logical", right? Because that's what HW/TLB physically loads.

> > > +#if !IS_ENABLED(CONFIG_GENERIC_ATOMIC64)
> > > +static inline bool pt_table_install64(struct pt_state *pts, u64 table_entry)
> > > +{
> > > +	u64 *entryp = pt_cur_table(pts, u64) + pts->index;
> > > +	u64 old_entry = pts->entry;
> > > +	bool ret;
> > > +
> > > +	/*
> > > +	 * Ensure the zero'd table content itself is visible before its PTE can
> > > +	 * be. release is a NOP on !SMP, but the HW is still doing an acquire.
> > > +	 */
> > > +	if (!IS_ENABLED(CONFIG_SMP))
> > > +		dma_wmb();
> > 
> > Mind elaborating why SMP doesn't need this?
> 
> The command says the "relase is a NOP" it means this:
> 
> 	ret = try_cmpxchg64_release(entryp, &old_entry, table_entry);
> 
> On SMP release does an actual release, on UP it doesn't have a
> barrier.

I see. I found that on !SMP, smp_mb() is barrier() v.s. mb(). I
suppose that differs between a compiler one and hardware one.

Thanks
Nicolin

