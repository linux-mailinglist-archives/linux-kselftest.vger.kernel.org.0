Return-Path: <linux-kselftest+bounces-41189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC604B51E9D
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 19:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4BA1C879BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 17:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22F82D46C6;
	Wed, 10 Sep 2025 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mdVs3V+j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D312D1911;
	Wed, 10 Sep 2025 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757524102; cv=fail; b=dyBe03WEii5elnFj3bcztIl6HnovcdWtN93wIeYfj4Ax6c4cEstXO6vFLbnzR2PBeMBDDnrt8H7tPUzzslZSh6Gr/D0bzTs6BoqFUY4y1oFuI4RY9+4IQSf7tLnLXgCXpLr3CleV+BHnb1IUuD/NYOKtieuUvzhF98Ex6yTUlJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757524102; c=relaxed/simple;
	bh=c3G3pMrUEoJWqNb3EKpdnfemUk2mScwI3iElRXbCe5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PbNtEaT0jK8dbMtXkDp7YDs4zr8V7+hnztpRdxzgbAn0NzzlRypS3i0nYD0akEDYR418k6/ZhHG1YzhSCSj3CMvFZUJkC+I1Rpn4mL7+Q7DushNHRCzfo0R7BnVgSZ21V7j1xgT+l2tWkWLAyLN+hc8KU33yR9YtKuaZsPHZx/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mdVs3V+j; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyOq7nTA34LxObgHtrDdfihVkjWaVW5xMua/5UWBuaISXXbFdrJf09MrQdAF3SjW1Ot9e8QcY+qg/ywTZurKKGXTeSmvq9Izs1ueDGmxauSztezZZ3KYJ/NkT48FNLiMkkY99fOVa2myJ8Pweq12kSWWw4XlhNNnm0LfATWHJec8RdUlKtJMuNwp1YivHV6OQoXjiPNxCsq2muG7hVMTdHCus6Xk0wFnjyuXrJL3d4xVrZSSOhgtOikHMuwqxwsx6Js0Aw8MTZU1+XQmyCznNtunVZQvqc8jhICc1e8/ZeAwvKqFH0QfXUrlRJhfZykvWjD8L0pHEbMgarel/cSoLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mtcxsgase/cRNDAF31vKgV0Lrbj1G8DX6E22RblYGsw=;
 b=jXD7S/mD7G6whJe6H6HrAGN9bhdaNH7Fy6UttgA6hNDKCWotj789YzrRnr622rvfnR5HJVNV7rRRkNs85fMDRAIymV14B/2q994eYU1WQOM8QPZ9dn6lmLM8MCsqPLTQGeUR5kGn1ggX4zh8EMW3L6U9O9UlevtDckqXelhs2yMorXPY/10v/efeh57zGRxZWC1RZ4w3MXTyT1cWCDmApdwzPISJxYrLe62afrNQJknTcsqrfD39FKo7RJ+7g7th+cwOlAJH2oYEVfEG3pnsR3qv2yrlULeRYctZfl/43eLu32fAN1Wzq/cvzv/EXjND/r0lOUP+3J0JL+n87+xl8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mtcxsgase/cRNDAF31vKgV0Lrbj1G8DX6E22RblYGsw=;
 b=mdVs3V+jvxeQKCy4sVLUBFQaXBGdColxnaYr3fsvfttonkcvQJcJMuxhZZUzQy14ow226aUhle9Hd/bAxno2CavQmW5UI53dYx6wMpQGQviEZ1iKxRh8OJamx+iIZXeSzHDQo/waBWHnhkNbqzUbHQZLNlfV3XQzJNgs8hJuVBECYov0b/VwWiIqtH+F+bHzQA6AIpC7k8TBIJObLWfBzuHn9LN/hni2UT++L1Wd2wG5MN6yowshOfYwAsJd5JJYbc2r3OuGxZFfK6/7lx+maCUYmF/0KyxDlwwSR1iLLRwwiPNPw9GPxA+1hwDhsOdlfpVGh9wViw5d/wwtCcdpsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB9245.namprd12.prod.outlook.com (2603:10b6:806:3a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 17:08:15 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%7]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 17:08:15 +0000
Date: Wed, 10 Sep 2025 20:08:03 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] net: add a common function to compute
 features from lowers devices
Message-ID: <aMGwcyKTvmz5StN1@shredder>
References: <20250829095430.443891-1-liuhangbin@gmail.com>
 <20250829095430.443891-2-liuhangbin@gmail.com>
 <aLRr1W3jKRDYsRSq@shredder>
 <aMGLTzACsKLRIsVb@krikkit>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMGLTzACsKLRIsVb@krikkit>
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB9245:EE_
X-MS-Office365-Filtering-Correlation-Id: 87567ad7-1115-4715-e1ba-08ddf08ca149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QorcTVeH/lpCuWV35grY8j+VDOTCoilmIyEJVQy80yUFwWbVWwdagnHABuJS?=
 =?us-ascii?Q?A4pyNSTOHqmH/0sdpboosOphazTBZYmPQFLSmslun2U4/Hxw1bc3QYnt3aY1?=
 =?us-ascii?Q?VW9OHf+jq6WueWbJ16P3YKXmNTIb0GfAP0B10KB0dqNd3cpofawWY8aYxBa7?=
 =?us-ascii?Q?QYFUTg3MOdQoyCVj1aRMN0MXniW4Yj/Rg/Jd5ivrHQOXYYPrq+4Kc1c/Gnap?=
 =?us-ascii?Q?ponxDe1fNRKw8kV6JDrOlq83WH/7ASlYGtmur0BRULypfF7xYZWMwPlecuan?=
 =?us-ascii?Q?pR3sHjPSluzwE5V7VF5UEe8bnjFFAofi/CiSB1e1yAGEX7hJWFWwkH18/9Q+?=
 =?us-ascii?Q?ZUjcH733gMSWiv1sL0TZlPyDVdAyETkq99wt/AF8NwVQ6YKlxzE2WgsbFd/B?=
 =?us-ascii?Q?yqvJIgBuIfXj2gLUkmz7epcwWHZEzXavp40PoQ71ckNrD8SuIxHmSDCM5474?=
 =?us-ascii?Q?y4CCBj4VXaKdrENwuauDLb1xQmPjw2WUnQ1Dj2LxRz132peJlGdfr1nUEel+?=
 =?us-ascii?Q?EK83LtagOUpbxnNF8Amxc6oq+tYoa9KPeC5AbXYEBAjQKio5gMWsRFTjooTj?=
 =?us-ascii?Q?VULdtLdgmfxph5Ux3jw/UcpEPN4oI1GzHuUrqqWueEC4KE5BxV/FDTXLaRo5?=
 =?us-ascii?Q?qkiN0INiRKQIhUItlx373PdLSsdsV72HCKNAOMV8X2UD8LWfoBl9jQjpYMxN?=
 =?us-ascii?Q?X6WPuCzHec5zg5IE4V2npn56qGOavFNpOAK8U9vfzj9ts2aQlBvR0BJ6eJH4?=
 =?us-ascii?Q?H38tAi3j4zkTWO250HQCL4qm9/QDelvLJLAwpbmXGBqmDTl6QD/+3c565rxg?=
 =?us-ascii?Q?krZcrSOhVgmXRXjIJ2em9hRt0NHw86pkthxxZd87smtsM1WFCMJhHLaq9arY?=
 =?us-ascii?Q?+m8jD8lvK3OO08clCl73WsYV+16c1dhLC96XVlY4ZTdwGB0jMovgg0bIugtc?=
 =?us-ascii?Q?OQ8hDgCgNhaQfI32kdfZRIimIP6FKO003dItu1aLEp1a9j/lod5BhmSPif0p?=
 =?us-ascii?Q?Dwj1gR81bs/bLDO6ixWybZgiP2evfv1diUjA3LpPlLZe3Q1gFR7T0H5aI+EP?=
 =?us-ascii?Q?KH3e4LrzPY8OAPsRvPPTpeANTcYVciOIKX4YC/3w17TvJmNyttpzxyB3Wj4B?=
 =?us-ascii?Q?vSU7X0k6dEQE5VDQft0Qo4BGVNFZVYYhqLus7JBpX8CPu2fxfSmLg3/tHOMT?=
 =?us-ascii?Q?I2STAcWKRu4O1Fm67QFbl7Tp+DLXXARWhcvJHHdImN8IzOSpFFFm8891AdnU?=
 =?us-ascii?Q?WpVqyWOc7rabDYaMNdfKik0sl/dJJrbwYdupkbHZ+jbjmzBAENativ7TbUEQ?=
 =?us-ascii?Q?PI5uzJTXWQxb3kHkcGq94UHzffCgJqTI+qtpVPPBzX5q8RcKgmW6G0G11nav?=
 =?us-ascii?Q?UjyESk+ty7R8zwYqnFY/uFoVUNoTo87mU6koJmwbgTV8u9JB0mWWwKo7GT+F?=
 =?us-ascii?Q?nbQf5wjX5FU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6kWfT10sB7DuWZBJdxoG9B+NDKmEvRxh7qboPaAQhUayNhKY0KmvZLQ/2xzG?=
 =?us-ascii?Q?NrvtBxV6IHf7LaZEGmCji1OchHkzr5WcO3+Fh4NsplhQ96mLUiiq3kmU2CjK?=
 =?us-ascii?Q?c6WCO6nAHZMs+n7jX6g9dUpPhO7VJcMWdICFS5ynJPKlULX3Jz98geQ3o1m8?=
 =?us-ascii?Q?jCKX0hMDXk7QE/C9mEmgTkgTxxHhrVz4612BAlJ287Q7Cnh42OKvBzUj+Fkd?=
 =?us-ascii?Q?hXSPLvPb4+Gf3x2hDz0h/YzK6CXoi0qYfPGz5HoXy4yMoUXvInHb/BC5psC9?=
 =?us-ascii?Q?vkymrcokVhyC7RMgIFA4zferMH/h+HZfTyBesIE5jWMP7amETGDnqTMhmqFZ?=
 =?us-ascii?Q?1zSCOmRlpXZgffieIDu+oE5pZxm6TrQPAys/A3uILJdlJQG7UkYKmw60A0lQ?=
 =?us-ascii?Q?0/TDsyuGOteuxCit/4TMlqcdlnNwQzNa5WzvNu57bWNb199LfQCdkwkAuG15?=
 =?us-ascii?Q?IoMq5XyauK26FwbyXOIPkYwgE+2feC5fEl2AuzE5VpjZzr42d18IaZUj2MV4?=
 =?us-ascii?Q?kOiv98HwTga4psmRU94f6fMrfMJ6u7mSnkBvHov1spbof+z5D3TemI34UCYs?=
 =?us-ascii?Q?4DT7oW79NLhCp/bZBriS0vllPSBSEATy4hs52v3/HmHiT5ScH8XrGpIQB3Dy?=
 =?us-ascii?Q?nJV3+EcCWm8wbhwH+9+p7c1nY6KpDGv4jMQWQ1lPOfUkq7eWa5PvpP32nchU?=
 =?us-ascii?Q?OmiU2Dpy9VCApVghFYjlsYSfTU6htpyjr9gtLGW6HA3Hcbu7ZIcb+ZFdF1G6?=
 =?us-ascii?Q?g3pGodVai8pEHYc/1u0zy+Pcu83rPEK3932aUTS47tBhZqAmVmWIvFnGO0yR?=
 =?us-ascii?Q?NH1fjBjmI94vZ2a3nQcrWc83grB3kjvT4N/5WFh6WiKAIA5eUiWhAITDJET6?=
 =?us-ascii?Q?Rp6nODvzc8Uyj0JlyB/kDqtM18Lpz6yrcuxpJ+I675klJy9ua5oy1KnTArht?=
 =?us-ascii?Q?rJJt0VlfOv6IKV8ksm+hmLB9gUqlMbxshPUi479BDgQN+R0IdVaH+2t8ejEG?=
 =?us-ascii?Q?w48HAg6Pk0mR6/xEYWJBUifhl/hxiS10YzNmRLoFAu/8E7WSZgpUTG8cYQJy?=
 =?us-ascii?Q?kqS5gkXD8SrX7ZwFsEWUYXn//0wKLZ3Zi/RXmBco78vAvBKWm1yf2fBfks7p?=
 =?us-ascii?Q?QpduHWew7eg1+knud8t+DDr8F1rN6qFl/TCMcRa0T6OTzqYw/wPL9+ccoALw?=
 =?us-ascii?Q?GXSms5Nce50ZqT7DKEw79TMq1FMumNsiWGyjBvCCyCrg6wMb9z675VOCapWW?=
 =?us-ascii?Q?3wjJedzds9nygsgSVHY4EsGOZSJXwt5WPmwG3UpcKZ9RCFI4O1ylrTIhx3Ok?=
 =?us-ascii?Q?VuzQV2Wrz02Py5399qV+1dyG0CpRz2yisbosy9dvgqb9Y43Si9UgEgORgrx+?=
 =?us-ascii?Q?7xQgaS0/QCC7OC6cfIkV6pKNHnFjOEoAXckyyH12ed7Fa/4N6vpvUBaxtkqT?=
 =?us-ascii?Q?ffN2gBXfUWjEfEND9Oq3wk3qRhvIiiDujtV69K+f/H/rZRIPG8tJWUv8Hh+6?=
 =?us-ascii?Q?oW3p2Qnp657P4QudFAUcVeJ6aOVAgOYUD8IbKhZ7d9IGehv5ynwuUXwtfy64?=
 =?us-ascii?Q?zu+b8yKYwDpgIK6q/ngjXqmGbDbNQXpyrb8KX58p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87567ad7-1115-4715-e1ba-08ddf08ca149
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 17:08:15.0615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +q8vSLh/Q4bxjlgmO6Qpshkf8BdGs7jtH3ZC6paBLmKYY/SZ/3HeTtMurqCaHC4MdyUKidQejVJUEBTS6zPY7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9245

On Wed, Sep 10, 2025 at 04:29:35PM +0200, Sabrina Dubroca wrote:
> 2025-08-31, 18:35:49 +0300, Ido Schimmel wrote:
> > On Fri, Aug 29, 2025 at 09:54:26AM +0000, Hangbin Liu wrote:
> > > Some high level virtual drivers need to compute features from lower
> > > devices. But each has their own implementations and may lost some
> > > feature compute. Let's use one common function to compute features
> > > for kinds of these devices.
> > > 
> > > The new helper uses the current bond implementation as the reference
> > > one, as the latter already handles all the relevant aspects: netdev
> > > features, TSO limits and dst retention.
> > > 
> > > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > > ---
> > >  include/linux/netdevice.h | 19 ++++++++++
> > >  net/core/dev.c            | 79 +++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 98 insertions(+)
> > > 
> > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > index f3a3b761abfb..42742a47f2c6 100644
> > > --- a/include/linux/netdevice.h
> > > +++ b/include/linux/netdevice.h
> > > @@ -5279,6 +5279,25 @@ int __netdev_update_features(struct net_device *dev);
> > >  void netdev_update_features(struct net_device *dev);
> > >  void netdev_change_features(struct net_device *dev);
> > >  
> > > +/* netdevice features */
> > > +#define VIRTUAL_DEV_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> > > +					 NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
> > > +					 NETIF_F_GSO_ENCAP_ALL | \
> > > +					 NETIF_F_HIGHDMA | NETIF_F_LRO)
> > > +
> > > +#define VIRTUAL_DEV_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> > > +					 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE | \
> > > +					 NETIF_F_GSO_PARTIAL)
> > > +
> > > +#define VIRTUAL_DEV_MPLS_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> > > +					 NETIF_F_GSO_SOFTWARE)
> > > +
> > > +#define VIRTUAL_DEV_XFRM_FEATURES	(NETIF_F_HW_ESP | NETIF_F_HW_ESP_TX_CSUM | \
> > > +					 NETIF_F_GSO_ESP)
> > > +
> > > +#define VIRTUAL_DEV_GSO_PARTIAL_FEATURES (NETIF_F_GSO_ESP)
> > > +void netdev_compute_features_from_lowers(struct net_device *dev);
> > > +
> > >  void netif_stacked_transfer_operstate(const struct net_device *rootdev,
> > >  					struct net_device *dev);
> > >  
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 1d1650d9ecff..fcad2a9f6b65 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -12577,6 +12577,85 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
> > >  }
> > >  EXPORT_SYMBOL(netdev_increment_features);
> > >  
> > > +/**
> > > + *	netdev_compute_features_from_lowers - compute feature from lowers
> > > + *	@dev: the upper device
> > > + *
> > > + *	Recompute the upper device's feature based on all lower devices.
> > > + */
> > > +void netdev_compute_features_from_lowers(struct net_device *dev)
> > > +{
> > > +	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
> > > +	netdev_features_t gso_partial_features = VIRTUAL_DEV_GSO_PARTIAL_FEATURES;
> > > +#ifdef CONFIG_XFRM_OFFLOAD
> > > +	netdev_features_t xfrm_features  = VIRTUAL_DEV_XFRM_FEATURES;
> >                                        ^ double space (in other places as well)
> > 
> > > +#endif
> > > +	netdev_features_t mpls_features  = VIRTUAL_DEV_MPLS_FEATURES;
> > > +	netdev_features_t vlan_features = VIRTUAL_DEV_VLAN_FEATURES;
> > > +	netdev_features_t enc_features  = VIRTUAL_DEV_ENC_FEATURES;
> > > +	unsigned short max_hard_header_len = ETH_HLEN;
> 
> Going back to this discussion about hard_header_len:
> 
> > hard_header_len is not really a feature, so does not sound like it
> > belongs here. I'm pretty sure it's not needed at all.
> > 
> > It was added to the bond driver in 2006 by commit 54ef31371407 ("[PATCH]
> > bonding: Handle large hard_header_len") citing panics with gianfar on
> > xmit. In 2009 commit 93c1285c5d92 ("gianfar: reallocate skb when
> > headroom is not enough for fcb") fixed the gianfar driver to stop
> > assuming that it has enough room to push its custom header. Further,
> > commit bee9e58c9e98 ("gianfar:don't add FCB length to hard_header_len")
> > from 2012 fixed this driver to use needed_headroom instead of
> > hard_header_len.
> > 
> > The team driver is also adjusting hard_header_len according to the lower
> > devices, but it most likely copied it from the bond driver. On the other
> > hand, the bridge driver does not mess with hard_header_len and no
> > problems were reported there (that I know of).
> > 
> > Might be a good idea to remove this hard_header_len logic from bond and
> > team and instead set their needed_headroom according to the lower device
> > with the highest needed_headroom. Paolo added similar logic in bridge
> > and ovs but the use case is a bit different there.
> 
> I'm not convinced removing adapting hard_header_len on bond/team is
> correct, even with old and broken drivers getting fixed years
> ago. hard_header_len will be used on the TX path (for some devices
> like bridge/macvlan via dev_forward_skb() and similar helpers, for IP
> tunnels setting their MTU, and via LL_RESERVED_SPACE).
> 
> So I think we should keep setting hard_header_len to the largest of
> all lowers.

It is not clear to me why we are setting hard_header_len to the largest
of all lowers and not needed_headroom. While bond/team allow
non-Ethernet lowers (unlike bridge, which is also adjusted to use this
helper), they do verify that all the lower devices are of the same type.
Shouldn't devices of the same type have the same hardware header length?
On the other hand, needed_headroom can and does vary between devices of
the same type.

