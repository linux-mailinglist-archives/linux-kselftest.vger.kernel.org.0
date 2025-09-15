Return-Path: <linux-kselftest+bounces-41510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C31B58143
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 17:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22A13BB780
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 15:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC5F22A4E5;
	Mon, 15 Sep 2025 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Knejod/C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013015.outbound.protection.outlook.com [40.107.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6582264DB;
	Mon, 15 Sep 2025 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951521; cv=fail; b=C+j8EyKOu+jju/KWS/Cl036GuEaQxT/4Yh0UJwaMn9//xRE78TG7O+bJywjPzcy2nhQiiy94tBiumxoGoOw4pMDnJZiyTdvYD5JFRJfEFnCR3+v6Bm5i67ChESsspufaFN3Ip5hUWWnf06NwGU9PIMG0R5vfCGmGjnwbkrvQvYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951521; c=relaxed/simple;
	bh=N6EaDKmQ42BeYtto7HVwyo7/KzeMR2WbRtUzJjKA1hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N8RzRxYa1+Z6ceLaVPhHzCbnCEc8mH2Y0RYhMprOx8E9lEZyyr4Zk5E9+Bl2bsXDQsZpnVHlE7le3PgUI3Y518l6oLaaK/kjMvtBR4kWq15apILwmQTJhhn1l++9CojrRAJjEdS6idsw2FjMGrwlbUKhY4+73NSybRuUpXQbvhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Knejod/C; arc=fail smtp.client-ip=40.107.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaxOr1Jn2+6ctof+b/KS/SKcHnYx2xr77NVuKSVOEaxYIelwN1bCYEBOjK7tOU99KkiyE8tIS4T40pff59q5lSTasCr/i5Tn8L+gTthh2K91fbZHgiUPdzh7bpJKOXqIf6mVrPmM3LOEkgGhcoOEC2XD19zxR1KGcYLaCONaZQr4PF4jtz9TaA7k8L1ELKswInKRopxRp5b7u1tTNWXru+cxZgPAxnY8FTK+U4Z1pUbevELecB43n52nQxIUGtHem5rkllcaVWRfjlsGlIHuXRXkkAQMhy+lf+Llg+FJLYXyoVIx7+YHc2XtXfUTAt4IpyOx+8zjIf9McJcl3p8UmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBN8Sw3Vr80Vtq87gJC1Txzeu6R3sjV8QJrd32yXBdY=;
 b=rpptp7Mgn+ipVBi5iwMpzU2viPUltl1kmxxAIaS2DoZ2EjxG7gMm34Xe0VGFV18lnPdfSkRiAaQCepMEyL0mbt+uG6546pKi4pAz+whY1zXEHz1pICGB8Y7WA6/j2gQBMIgSENYz8yhxIobzz3V1cxrNdrJ+Y0Uh47UrMIrmF5bb0w6nr392wWRrJUj31aPx42n2KM4nSLkGO0ZZ2WoBOekSVvZs98rWHI6ib0CaO3yuKmgVTcznDsPJ3w3kQN5NyAn+z3/4wGs5c0n9voNEBZksdwb47duT90HfMhHc8HzelT+JXftHiEihaFSgLlaK1utp84EZ17bjf0L7PWOIlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBN8Sw3Vr80Vtq87gJC1Txzeu6R3sjV8QJrd32yXBdY=;
 b=Knejod/CDxc1bjqkB66rRzskvryxiOu0C93xVngrHwpsMlUS9GpGZxcgitIPwK/lPwj9UqRDfAK5I3h6V5v9Rfyaha2k9FQcE53B2jbKik+FwVzaufoqEGu82OsOCLiAY7G4lVI1d5qo0WtgDRFxwO2iOze92Z2PLauZ6ZZxX+NuaYzzgGCoDeMAvUcfasb73OJM3YDC4uF9KztfNjrizOMg+PV5F9scNYrDGHAWwDeGQL71fx7tkkjWxKGaBzqwyd9h1V0GjyslQ/smEd9gj3+nzr1EbmnxwYMYGmbVRoOYb+lFCahByOfFzTLUekQDBpNhhhPxmwX+Vslh8bR10g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SA1PR12MB6946.namprd12.prod.outlook.com (2603:10b6:806:24d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.33; Mon, 15 Sep
 2025 15:51:55 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 15:51:55 +0000
Date: Mon, 15 Sep 2025 12:51:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [PATCH v5 01/15] genpt: Generic Page Table base API
Message-ID: <20250915155152.GC1057776@nvidia.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <1-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <aMDzLC9nV47Xvud9@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMDzLC9nV47Xvud9@nvidia.com>
X-ClientProxiedBy: BN9P222CA0020.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::25) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SA1PR12MB6946:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9c967d-fc9d-4f74-faa2-08ddf46fcb82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ughF5GZb/XWwQ/DZryHWY82qKhqzAlL4EpCjX36PoSK6W/uhcnKXfnewCbrG?=
 =?us-ascii?Q?mpADKikumgNqnk2wZquqAqmu6yISpSzEB+On7Iuu/dO/ftcKbqzdc9QCIfAN?=
 =?us-ascii?Q?rwZ/HLSNbp9MlrZp+i9Rne2UCD3Fqt1FH5vkf6PeENyB5l7usCdpumMuNkDM?=
 =?us-ascii?Q?aMQUTcSrZvgf1DSDB5hNilRysg9DYFvLOGiM7gKAXTdVQINnenq+BBLjOGdw?=
 =?us-ascii?Q?j0mUrpLzdFZO5GD46THU8ZsYRpq5m4/dthCyy4bgJoKDKeEH0FFOjSQ1sf5T?=
 =?us-ascii?Q?z7o854FqMwXAGk0bjfIbyNKG+1OChju2BZXa8S911kdfP45D7eVpPr/n3ZRK?=
 =?us-ascii?Q?Rzsjy06zZkW5QYksRCu1J3V1nDvkb+G7LKGpr+v6u7sJsng3vy5tOtxYilBK?=
 =?us-ascii?Q?QQrWuJuoRJ01pKP2MlgqxkLgdIvNdlhXel/gVujjuov+domKMxRZQ9k+cN7j?=
 =?us-ascii?Q?a/+If3lhizPfMaqvHQsIA6333rMvazWTbyBBneURM+HaaRa2qzyH+CfF82cH?=
 =?us-ascii?Q?qXNcinKHr4OZ/KPcBlVaGOTHyVrfFIfEPprygyI1rAF1LLaPuwySni2HLkMl?=
 =?us-ascii?Q?fuC3aSw4yfUgceYEHvxHMKaQbgvXvNEg3Qt1o2SN1cZwSrdQbfuoDTE5iVgr?=
 =?us-ascii?Q?AIBp/+oasXeEgnqykG+pAAOk5W+7PCMhdV6syL+FSMpMqVhCD/lqZna40vA5?=
 =?us-ascii?Q?1yb5ML2tG4ZE/GCAn3OXtIUaq6p9BcuhCQhB8JQB90X/+wq71iMJdahVhL9H?=
 =?us-ascii?Q?3tzY8TsIAf+Z0+F/I7WT73aMmQgmuhD69jGUIhzdgKAGTV9ajOSg6rnSjUdR?=
 =?us-ascii?Q?ppt4BFzF0G6VBaTvX2tdQp2AGo4sZYy8jiKAUeFQNplbFViNkK1BXmw0lK1D?=
 =?us-ascii?Q?iyfx0Z6ZCxbZwHe84FRE4yfxM3kXj2KSUFoNV+/cm4y1dlYJxsBtbYGvBnVs?=
 =?us-ascii?Q?uTI5DcD5ncs0lfy8VQAR1ySUVri/BZLsr2XehWejen+7o2LZI5jHXJ7f82bD?=
 =?us-ascii?Q?Btthg3KByZVcW9xjeRJERY0cZlcBhMzKNsoZwUT8TYH45gpjpGWtYIJZsfDT?=
 =?us-ascii?Q?pp/AFFTeObMGpfwToRptFGs6NnDfWXjeZ5FJ3AD1frb/3NWRZBXpNPXOPz29?=
 =?us-ascii?Q?0LneLDWZrNIMrd7qv89hj5XJl3ZQ8B3dqOv4w3XkO7PrfWzIp60Mm1bch884?=
 =?us-ascii?Q?uiQVqz9yIWAwzdRBwCGCOH8ZeX8a7e0Pt904AyOeUy5KxTfAcDOJZUUjG25N?=
 =?us-ascii?Q?5I0ipdVqvBQ83bzuvkBabP3Rg2he7wI0c0ZHcKauA79XmqILNIqsw5xw8/UP?=
 =?us-ascii?Q?F1VcvqenBa3rxk3rFtHZlgXlRePhvFuPfc4IZUDiVSLHS5I7AgSslEl1TzGm?=
 =?us-ascii?Q?A4mLo0NZ/lonJKIzxwSmZkwOLRbAt6mgEqiKq6XQHomHohqRaWH9hIcm7Qwu?=
 =?us-ascii?Q?EGPKsMJHDW4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GIFRk5LRtqaiI2J/Ymo+xBpTreYhbLvBjNvEjjEWiu5vCRl9vwPM7cvRvJ0f?=
 =?us-ascii?Q?LFG5rGwzs/J+0xbM+gfv+RtZcDK9bfue3Q4mX8YtyH2PaRQIe1eVtZiMZuoL?=
 =?us-ascii?Q?Xrlq3A/owDa5imt34c95cncCnM1ThNnYrh7J8jPEbO9ayjYOiO++I9jTk8jT?=
 =?us-ascii?Q?bvnECG+EIB67DmCKSXAwxwfuw3c3N1Te+widPl48grgfBCJTrFtBBv0l6iTM?=
 =?us-ascii?Q?td4LV1txqA40CTIHt6wLFV4X7H9VjxKBLJBE6KvB3iITyuUodZNf6P5haM7o?=
 =?us-ascii?Q?65y7XrH32dTmnKOzFSo1WCfP4u3vqIK2q5se4WyNGTNWUHBdGeJcKepIHnMH?=
 =?us-ascii?Q?Hk1aMf+d8Qy/I/hETpV1PU6P5IOQxBeIk+8T8KIrPkpcZjLyZYem7AJzB7Hv?=
 =?us-ascii?Q?11/ysKBXBFJdV67o4vrhcJ6EpoQf+YtDrTleaDuE0IAi+PvT0kJpK5QW8ChE?=
 =?us-ascii?Q?tozuw/SWVuFnmjFaxBKGiyDlBCwtlZj5NUyKyQuwwtqvAnEcj1qkiQGcYMDm?=
 =?us-ascii?Q?5aFfpnMd/I9oXiurCcrONvg1jq6AgVLFl15A6KorzsBiAO3nsPeTl5U63AbN?=
 =?us-ascii?Q?9OvyCJGa2/mmxe38dBSNkM8X4oQYi6iwJvbiLiu1Eqb0sj9do0Us9wKZ654R?=
 =?us-ascii?Q?D8jJvi7NaT6HL/LhNYt/27CzcZJqO+52tFVATaYgesutoyuE6AWhuMXJMuui?=
 =?us-ascii?Q?GDloIUo7n6+EbwnynQnsoBiyOhQ+v/45/yCxF8Oy1BFJdgfXl1hmkRLW8squ?=
 =?us-ascii?Q?3hTs1eWTt9Q9w8e0gSFpgadg3V0Vn+Qca1CHzQIutdfMuRdHetdpYYXsZWM2?=
 =?us-ascii?Q?WojJayah6+usZybYJmFY3BzgFKQJGqh08301+fA5olgQqiFh039w6DelmEpg?=
 =?us-ascii?Q?ma7kd/X1D1PKhj7Qgdc5BnEVfeOWT9UfhHwU/tN74YAqgTFeQPYznc0n8hWa?=
 =?us-ascii?Q?5oJLJmKZl+vgIcdJ88bnJfnXByLDawB1HdCD3u7vWEJC8kKFzXka+pFftLgr?=
 =?us-ascii?Q?ya3AyQDRdwy61AtHQe+61qfxiC0hGDl8GOR2aMl2Ilb6L0TVaTWz1S0gU2IQ?=
 =?us-ascii?Q?/LKwmL9M8szNCTbc2xaRLEFbvO4NSFG/c7EvorG0hLd48XFkZDb/F6A6Uema?=
 =?us-ascii?Q?a8IPIzmqu3RrWxf36cdEJ/oqHH7oecTXt/BOhDiw8gpQbeTMoV8qXkswo0mO?=
 =?us-ascii?Q?3G5xH6BaSkhSDwD1R9mjHc5IL8Q2AoLmg49Q4jMuvuaicwdhJvu+n4zVLDmP?=
 =?us-ascii?Q?XcmW1hQSRsJ1rYJ52Mj1VILzh4EFI32F/xfn9S8gHbeYQupSByqTOpkyrd8F?=
 =?us-ascii?Q?4EUjFvTpvDy2iMm1AlY9S7Dsfy9O+WKbOp4OmWtLes8035jB56nIMHsXuZG2?=
 =?us-ascii?Q?FtwF7lkg54efZk/rU4uTMK3kYpQZ/bWTJHqgMTh7dVUUP/J73Ol0YkxnKAyM?=
 =?us-ascii?Q?6eO78MVIYHXw0hc1gRcBUiqm7CSGTxaM5GrSKyFDLd3+JblI5NgLzcAnRoOY?=
 =?us-ascii?Q?xu5YokZlJ/5ajedj/dEFReKvs7JK0E3e+/CPuUzZzQjV2J1boLH531NJljRJ?=
 =?us-ascii?Q?64AOQniteMwiBqN/IRiBz6kQ0Ewc3oITbShel18A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9c967d-fc9d-4f74-faa2-08ddf46fcb82
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 15:51:55.1065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cp+gwOdwQUP2xIf1pBdJy+JlPhio9U6W6zg1aXdzRejylJsdfBVnKgbRtXEvgp2T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6946

On Tue, Sep 09, 2025 at 08:40:28PM -0700, Nicolin Chen wrote:
> > + *  level
> > + *     The number of table hops from the lowest leaf. Level 0
> > + *     is always a table of only leaves of the least significant VA bits. The
> 
> Hmm, I am a bit confused here. I thought "leaf" was meant to be a
> "leaf" table? But here "a table of only leaves" makes it feel like
> a "leaf" table entry?

How aboutL:

 *  level
 *     Level 0 is always a table of only leaves with no futher table pointers.
 *     Increasing levels increase the size of the table items. The least
 *     significant VA bits used to index page tables are used to index the Level
 *     0 table. The various labels for table levels used by HW descriptions are
 *     not used.


> > + *  table
> > + *     A linear array of entries representing the translation items for that
> > + *     level.
> > + *  index
> > + *     The position in a table of an element: item = table[index]
> > + *  item
> > + *     A single position in a table
> > + *  entry
> > + *     A single logical element in a table. If contiguous pages are not
> > + *     supported then item and entry are the same thing, otherwise entry refers
> > + *     to the all the items that comprise a single contiguous translation.
> 
> So, an "entry" is a group of "items" if contiguous pages (huge
> page?) are supported. 

Yes

> Then, the "entry" sounds like a physical (v.s. "logical") table
> entry, e.g. a PTE that we usually say?

I choose entry because it is related to PTE and in most cases you want
to work on the entries. The replication of entry to item is somewhat
hidden.

From a HW perspective the TLB should be loading entries.

> > +#if !IS_ENABLED(CONFIG_GENERIC_ATOMIC64)
> > +static inline bool pt_table_install64(struct pt_state *pts, u64 table_entry)
> > +{
> > +	u64 *entryp = pt_cur_table(pts, u64) + pts->index;
> > +	u64 old_entry = pts->entry;
> > +	bool ret;
> > +
> > +	/*
> > +	 * Ensure the zero'd table content itself is visible before its PTE can
> > +	 * be. release is a NOP on !SMP, but the HW is still doing an acquire.
> > +	 */
> > +	if (!IS_ENABLED(CONFIG_SMP))
> > +		dma_wmb();
> 
> Mind elaborating why SMP doesn't need this?

The command says the "relase is a NOP" it means this:

	ret = try_cmpxchg64_release(entryp, &old_entry, table_entry);

On SMP release does an actual release, on UP it doesn't have a
barrier.

> Otherwise, these validations wouldn't be effective?
> 
> drivers/iommu/generic_pt/pt_iter.h:388: if (PT_WARN_ON(!pts->table_lower))
> drivers/iommu/generic_pt/pt_iter.h-389-         return -EINVAL;

Right, when PT_WARN_ON is disabled it does nothing and never evaluates
its expression. All the branches like the above are removed.

Jason

