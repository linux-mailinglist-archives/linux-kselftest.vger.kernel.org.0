Return-Path: <linux-kselftest+bounces-24397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A79A0C111
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 20:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2243A859B
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 19:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21E61C5D49;
	Mon, 13 Jan 2025 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="olg3CZ2X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603DD1C3C15;
	Mon, 13 Jan 2025 19:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736795550; cv=fail; b=hC7fs+B6+rFYlxTwVXwrbDn7RUFV8vn7hdDWK32OKUEhmVp/ftqh3kDCOFggjfPZWHaGHpJxJfc6v2Q+sKpXC0Yht+s8WP2GjHNgPHhby1L2DjGt5IR36lyC4WaVUPHge6VdWfKhrCM5z3vxwFD6Y5Tuma/Qp+MBaH+Hh+pOBWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736795550; c=relaxed/simple;
	bh=dNUdKx2Pm1gV1wzUpPEQfly//DqMVFXfdLjWc9hkdQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZqF0GHy7zPPNHY3jaTnKhPuE0lcMKmoN6Za3ilLuhV0277mWxozDrMAfRdjCYoIQgEFy2YHXHk0KIhFsf8kSdg6oRcK3Txnlhrxk3iALHDUHW4dV6xZ512ipX/UZPLnQ6AOSlY0oW201ND4CeKSU2Pay/YZupHoBXiy4b6BfPZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=olg3CZ2X; arc=fail smtp.client-ip=40.107.95.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jea8qleGf7h/7q/AVqiCdC6AVUOVExTSi/yaoOPjlEExK9N3J2nRxBZs2PxCcuqFV/rLd0MYPirRN25uYxMnCvt0Lh0CGYIHs/JD59ovAcp9qk+tERS6FepSJz6fvnYq7SzCKkNhILTrXMawh6r30zJJhegY5QhTBG0pEq9ImPPBIbubLz/4AV3CWCpZ7pKmXWPbi4cgBwzHOdeMjgGpiXPArav7l8AHmsGoGjM6Rrq1OU0gdXo8dCXRsRf8QdKlybsP5M8ims3EENsymR2uuThd74Y83sFTzPCtryJmocOGXcz95c5EdZOHcD+BqdoZrWkOHJDXd+kCJL2Zb4ZCSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXxDiIbW6M8hQgRYugectx6veyNav4KIcKwN6VjYPiw=;
 b=VA7AG0ulZg42UJi/YW3QANQ4D3iuoOAxtBKeBdwkIs6eH6wXIOIaX7L7H3hxayoLPU87H19vh39T9lu57qSJaLHzDKN3bLwvflQz9ZwcD/AksS9Su5HfiGhgo2hfgnhcrEYWy7J/P3MAWhxE1aHnEcWO7PpmvZt5BpTjG87HoAv/ZAvHc5sha/gLB/dWCRWD1JHNrhYCEUz7AmBOpaP7m4egbdGKXZg3C8L0sjl7lmT7DN6SOKw0sREZvENEyJiwjJWrrA/S6K0n9VDjkdrmwQI7I+rTrI84XsM+VA3LRdlcTq6I/pS+78JCT+QHxPxrxD7uXhmKI11latWV8aTlVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXxDiIbW6M8hQgRYugectx6veyNav4KIcKwN6VjYPiw=;
 b=olg3CZ2X5aYjMx8Ikk/3YwJbLlvjJE0mZYCOCzYPqCSUR1k3vkw9ipD6S7IZNfv20aKr5eSvM43+Wh+5Tvj1gF6UeptQy2u8wRuG/cfy13a8EvRJbYs6qAaUrh94RgcNO6xTzDnVKo0kIqPxfmOCDdtofMuNxvpqMTJT7lQtyqwrbyNwsmn8sTzzjYnBvOqKjaPSPEeJhnK30WhP29qeWOJTlp9nVsUZe3gJfusTOzQW4CLK+iblxS0CL9N21O8yj+e2XdaH0ZNZ3Fo3kG1PMmzXgbIzX3GB4Dyzi+iSgreUcZZvVyR2l4dO7TJQVCJbnhVVQCxR/sYmD05/W6Ce0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB7898.namprd12.prod.outlook.com (2603:10b6:8:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.16; Mon, 13 Jan
 2025 19:12:26 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8314.022; Mon, 13 Jan 2025
 19:12:26 +0000
Date: Mon, 13 Jan 2025 15:12:25 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v5 06/14] iommufd: Add IOMMUFD_OBJ_VEVENTQ and
 IOMMUFD_CMD_VEVENTQ_ALLOC
Message-ID: <20250113191225.GS5556@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <86e78625c48d0c8fb815496dbc57708b98a46ec7.1736237481.git.nicolinc@nvidia.com>
 <20250110174842.GI396083@nvidia.com>
 <Z4F0uZBg05J7Nuhl@Asurada-Nvidia>
 <20250110194950.GI5556@nvidia.com>
 <Z4GX/R6lRwuhlBJQ@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4GX/R6lRwuhlBJQ@Asurada-Nvidia>
X-ClientProxiedBy: BN1PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:408:e0::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: fc4b5bba-370f-44e4-0870-08dd340637af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VQGTCXzePAZ2cxkW8jjAfYr32WmuvA2tp6dwhJr0ykNJuSDhjtFio6DZbR0G?=
 =?us-ascii?Q?Tv5LVI4kdyNE3LWi96dBdWE+eV/e5Ilc0Snby95iqzLIf0V0EVPxdkFQyj9I?=
 =?us-ascii?Q?I1Mbbc5tZg3w3FMMKwgwvrVRK+epdC6t7ZLFGHBYrSgz+GYfEXcfnEgb5yXE?=
 =?us-ascii?Q?+kW3yKWL4QjoPhsXHa1frcUjLXEoKcC7UbRh3wERwJzHREYXaxGZHAdAhl6V?=
 =?us-ascii?Q?AAdyvrUvRTUeLDKvyPJ/0lrENlCTeL3piZ2tf1ZbRyfYICtDWdOYhwZYwbph?=
 =?us-ascii?Q?a11jaNwCnVjahpV/PKCppzHM5fpt/AlRSgoDiFkPQOwqVmCGeJr5gvM3YfXt?=
 =?us-ascii?Q?CNwkliw/UfsGmYu+VTY8aWFW7YymKheYxLdjjPdSRGd6d9YQ0y+tCDC8t3iC?=
 =?us-ascii?Q?Qwi58hlsyaW8RRZNaQBQ1ufAr1wqaUHRGNw03B3akRts5akB6zBMePUtL8Kj?=
 =?us-ascii?Q?GYBc7mgvw6jib/k6DZEBiFKb0beoq5gKB8tvYjfHco7SVST7RG4aa8Qlmauu?=
 =?us-ascii?Q?dITtpoILEGUjOMR622ISuEKRoUi7nS5DNz3Tp7obMbv17hu6yw6pl6liz2NY?=
 =?us-ascii?Q?Z7KPKPrhOm/yYE8ABaQZSBEvdQi3CySNCE3ozdlN2az9lGcc9c0TUgdECf2j?=
 =?us-ascii?Q?hwVPgY5qVD1+Pl08xMWi6E06As+Fb/n17hPm0uOBgNpvSUTzdpIqR1wCBmbP?=
 =?us-ascii?Q?RHnZ5LrlPUCsLIvtctYxs3AAezHeQRyHZxshTjndRdg1cDxRmdHJvDTgkp/u?=
 =?us-ascii?Q?uBUaNEQjE6ksLTBS7QXp9iwviMAcX1yA3Pk86m+NAfhFtyVr0YKb//WE9LE5?=
 =?us-ascii?Q?zmtM93JMRayn9sjGdy4UwXZcSRiKYp/so6r5z+M6YY9nOj/S6aafCuiXZKnf?=
 =?us-ascii?Q?vrsoXjNKLFRMmCq8WnhDImvmg8JvXXVM3mdQf2U4j1bi5nGf07FNTTogK1w5?=
 =?us-ascii?Q?p6LT6BT/PIa3N+pmDg05s0GU+VuDK6IQk08O8c27LN/BfW2DNZk8YrjXIzgr?=
 =?us-ascii?Q?AFj8Rfjh0C1yugAnqkCnwgWc84RlNyj5Hds6RP4WRUZikdAzk5DNGgFay+d0?=
 =?us-ascii?Q?K9evvBvMI3RVG9oCt2Km2m+kcpCIaj07aqDbTxM4E0GC9HCF4U1qkR7e47s3?=
 =?us-ascii?Q?495OgS8rrl5e/rFB14bSNLWqUerGXn5powS7uNQkqDGyE2Iz6zH4KFVD013w?=
 =?us-ascii?Q?1uDAJOqAK25l6Nyj3mvAz3Oe+o4m2UGqCpeVS1OJx+1bu7RW8/sOpGQ5Y/0s?=
 =?us-ascii?Q?xsCFuciq0lpCu+ypiXz9vRcvhRdkXYWl6IfrOr8JbZ/0srCad0EdB8rWo+PJ?=
 =?us-ascii?Q?ry6xzzXC2g9jad5BBr5Nw3nygZ16QZtVhVXHgBLSKg8yqlldY5BfkrZm73jm?=
 =?us-ascii?Q?tumIlGQkExZTQVBtf8kycLKZNfID?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dT5yF47AfdnpZANx2fIfsapPA17O1PUZCIeu2FPyJUV/4aQ4AEWa/TKMI3eo?=
 =?us-ascii?Q?MXIMnbMHjJwF8YqFUirQ7JmLEFbHlmri7647arOg9huYVXXc8q/BDXy1xswF?=
 =?us-ascii?Q?alGXAM3R8mx+z04O3LfUEP+N0lqw19RhUxoSliCch2UMzKTZQF6IOHyy9zz+?=
 =?us-ascii?Q?ECA/dNzZmOCrw7AC+ufjWOsXqE6gu7sZmFaCqr8ZHma5u4pj6h3bu0dO7jkP?=
 =?us-ascii?Q?IdbztjohpbudCD8FaHTj8YKcbW2p4es7PqZTyVRdmX1HCDU7U/pJrPdSMtpR?=
 =?us-ascii?Q?GeudAKEOorsNlBa+FVtBYoTtC8Sr7Ay5UBtDYZlJvr3wgtG4/PBDohJOiBDD?=
 =?us-ascii?Q?JHp+3CUhc23+Uj/KK+tFRyKgvxLnHofz97RMUyKZJKI6Vn4egTMeKphSxC1+?=
 =?us-ascii?Q?TNRyYImCDrFnSNPAy+lPSY5Zc+wc9SFIYXRu4A9Y0VuTuMnz4lyVqFKCz697?=
 =?us-ascii?Q?cArm8R6Zqsk7+MNjFC7ftYacu6ZHEjCoWFwN78UMjOiUdebjVJDGj/+X1Vmw?=
 =?us-ascii?Q?mwrtrerudRfYdQfQi3M0HFoIF1506KY7VjA+V2Z7eHIZ9mujbkQ4rfJEEkmC?=
 =?us-ascii?Q?CxbPoj2MbJnUy4mVpphKVRn3KFQYTOtBW4YozjBXJ2iP6WFghl143+svCuMt?=
 =?us-ascii?Q?Z1mt4jO2LKq+YM342jzpknwTlVztallXq7opJBbrbH+ODdjDHrw5qhSEWExD?=
 =?us-ascii?Q?EpyObMo6uBOQy41bYDxrLNToH2jj7qw3mcbeAfDT6xdYnJA24aFcrL66XnrK?=
 =?us-ascii?Q?Ry3xRamer7Gybpd+dobCX26puSZLbTRyYYU1OhybUWCqJ7hxJYJ7Km5QsENZ?=
 =?us-ascii?Q?PLCYrZSNQihauQf/0f9Suol36M5T1OgchHLvZoip5jV0cibdM7aqBuuMZVJ6?=
 =?us-ascii?Q?cuyM5sW83txqZI+Gn2njtuRkmtY9FzPV6MDr0K/xn2cxsKGDv9TPHM8JXi6w?=
 =?us-ascii?Q?uNyiOjBSGQ82+QRgXEJLHPDdFR8YBESHc9Dg9cz2ThcYYytgrELxZVNZg++R?=
 =?us-ascii?Q?YQk+NMXIRu0brC3WiQmcZo4w3iGM9jty9agasvYyNuenibseDuSPFVgfsGMD?=
 =?us-ascii?Q?N68F0PS+GA5St0ejoqbBKyAbhdT4m2QhGqEas6xiDfwajroS8xyqHot0D/Sw?=
 =?us-ascii?Q?5/cuNpFpeCBl5z0W/lUvSoclVDkPQK5r7zMiJ1V5BFIayMaJuSW704x2YnL/?=
 =?us-ascii?Q?6C1dKKouWpzcCwP9tX5W3TXKDgHPjq7QY+JEJuIddIqLAv+yfy3J5cJrudo3?=
 =?us-ascii?Q?ErWsPK0xf1WOAA6qME+Rfsvfu1ptAlp14sFTHUNMYy1iac2P1AU1otDZGnzI?=
 =?us-ascii?Q?v/3q7MrMYgN7cy1H/Tq1ppKG+RqoOHnIt+7h5RxVqIHIX11JIJ5wtRWX1TCH?=
 =?us-ascii?Q?ldAfgSDVu+XWu+mXPnlEusfx/j5holCuhUWCXVjH9VzzU1KUv3EEp8AAcswl?=
 =?us-ascii?Q?mzobJBZUG+tN3jttZPoyQok/z92sOasp6tsTe1UUboQK+bdEZwjnMD9V5K49?=
 =?us-ascii?Q?XHJy0+WBOfnrvlgpkc4BjaSXMraZL6PMDEquRQ9YVFipWinQyJ3yz+1zMBER?=
 =?us-ascii?Q?9ZyoimyT4V3SrwaeGw1KlhkmJa+z2bKPrVhegqFa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4b5bba-370f-44e4-0870-08dd340637af
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 19:12:26.6979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1CCK4m9wz2EPFfeD7itJooDoWwFqSYwh1TQP2Yenhk78Y/NkTxXe2zmELj1gga6D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898

On Fri, Jan 10, 2025 at 01:58:21PM -0800, Nicolin Chen wrote:
> Hmm, it seems that I haven't got your first narrative straight..
> 
> Would you mind elaborate "copy_to_user() can block while waiting
> on a page fault"? When would this happen?

copy_to_user() is a sleeping function that sleeps if the user memory
is non-present. So userspace can cause copy_to_user to copy to
anything, including memory that is non-present and will take along
time to page fault in. Eg perhaps by abusing userfaultfd.

We should not allow userspace to globally DOS the iommu driver this
way.

So do not hold locks that are also held by the HW event path across
copy_to_user().

Jason

