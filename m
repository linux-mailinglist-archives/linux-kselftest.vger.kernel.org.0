Return-Path: <linux-kselftest+bounces-20041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2239A2DA1
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 21:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8031C216B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2FD2194B7;
	Thu, 17 Oct 2024 19:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lqiyESfl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E739516C854;
	Thu, 17 Oct 2024 19:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192715; cv=fail; b=STFIEL4uw5zkvcs5lbcmil3Ex6wvykPVeDTtzDFRvrqzOCLsgeSIGxcEIZt8JmIRJ5g4bHswtX4IlJk6l2CK4IDjpWmoBhR/DfV9anSrBNMjBwRj8C/DS4XvbtoYj1uiMyUytlRdDKk5Ob01OUU5dorqdNfmQXflbby6A+FhbVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192715; c=relaxed/simple;
	bh=IWhVXubb4l6oNqqG0CX6LJcl4Lq1MgP8FnPkKlFj0kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TJ0ekdt73SMwCBJ2dQUAQUscgjhX6Q+NXmpotaVxlezk6skK72nJcdkdV92B4UdS9DSgfpxl6ImwAsGIOc9S9TgI8ZL/LgZi/ZmAx65y6mxECQdavYJRbjbqRklhLjwctUNsbPtDvD5lsOE2J0k6H1qrJWKZ5D8vKgZVntIhMMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lqiyESfl; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKPbhBNKe18Yjz84ZJfMotr+IC8BDB2KVTnLDXsm8XQ44pdZTkTdqQIsGWP9y2HyFHBVEFUm/bpeiTl0B1yvaqWP+h650qdhz/ui1qv2wNSCgwrrxdoNCHbz+GxeXFRtDXBE/Bwnxii5oGuWOD4P9Cv3lBP0U5TD+CuizqihpJ8Al3m+xZyaPBn04aXa1JnR4LFDdp+Amdxn3Up9DC3JOI32XUUoa6DcIJYsqUI6v3DpZhMv0e8aHAkzvbr8XEUZOlkBNMqkFC2fYnHKeVDKej/ayKNIR24ZMukrXbRrxmeQxzmubViKwPYzTfwULpwR4XYt3FqdXQlvV8/WliJCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiayYepiVecUoS5az7+ZuYqhFSrVveRu97bxIz39WpQ=;
 b=kMy2/qLaM3CrPPfHvuCrxrB/BQUTE74X2sRJY8W2cElOohmkk0hi3ELmCx1L4bmALcuEUHYxJhFfobRgmMq+33wwbiEIzpcdVTFMJ7shWq+6peTnFXlDEpUWDO7kd9ojUyAW5u6RHfmwFHtcWKOem5/TCT/RVrBMOTklfxcpPuleBG89+tWYLygoFxSaNbt9ivwiHxXxZRV74u9atNSyl8Vthpg3m+jXuxHHMTHhujU7wxQByxHirNByztAChySK8tNybQNIFjoJhtqOVVHEbApiXhG6PzuulqQiSMx+/DEjlaC4v9usyZHsIL7kB6nlpv+mbDcelwuytyMLRfhGTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiayYepiVecUoS5az7+ZuYqhFSrVveRu97bxIz39WpQ=;
 b=lqiyESfljb6cUgJY2AFaUQcmpGqvO/6Hm8lIGZ9W5gvakICROHZCXXvq2k3L870tcTFuTai7Na9gqMJbE1FCoBb0smhNdFp+pMBONjAnITa5tGC6ScpM4B2+G46wYtm7il6F/wRoZop7a2umPrB26BAU7w248GhrRtFiv4CjlBiPuRLGhn4tlOCtgR8TZWvEaMyrslY8H2gCqjbJ568X+FeYF6YjF74Jwt3/KhFA75ho+6I2royNkSKw//zAr74+cZb9o7fT9lUB2Tdi9CTqrCw302SqPO0PBIXtJghD2USevEq55JeAUC56RR4AD0j4b4t+0B1MQfq+ob4eYHix4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB7379.namprd12.prod.outlook.com (2603:10b6:510:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 19:18:30 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 19:18:30 +0000
Date: Thu, 17 Oct 2024 16:18:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>,
	Ackerley Tng <ackerleytng@google.com>, tabba@google.com,
	quic_eberman@quicinc.com, roypat@amazon.co.uk, rientjes@google.com,
	fvdl@google.com, jthoughton@google.com, seanjc@google.com,
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com,
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev,
	erdemaktas@google.com, vannapurve@google.com, qperret@google.com,
	jhubbard@nvidia.com, willy@infradead.org, shuah@kernel.org,
	brauner@kernel.org, bfoster@redhat.com, kent.overstreet@linux.dev,
	pvorel@suse.cz, rppt@kernel.org, richard.weiyang@gmail.com,
	anup@brainfault.org, haibo1.xu@intel.com, ajones@ventanamicro.com,
	vkuznets@redhat.com, maciej.wieczor-retman@intel.com,
	pgonda@google.com, oliver.upton@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 26/39] KVM: guest_memfd: Track faultability within a
 struct kvm_gmem_private
Message-ID: <20241017191829.GA3559746@nvidia.com>
References: <1d243dde-2ddf-4875-890d-e6bb47931e40@redhat.com>
 <ZxAfET87vwVwuUfJ@x1n>
 <20241016225157.GQ3559746@nvidia.com>
 <ZxBRC-v9w7xS0xgk@x1n>
 <20241016235424.GU3559746@nvidia.com>
 <ZxEmFY1FcrRtylJW@x1n>
 <20241017164713.GF3559746@nvidia.com>
 <ZxFD3kYfKY0b-qFz@x1n>
 <20241017171010.GK3559746@nvidia.com>
 <ZxFhTtEs2Mz7Dj-O@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxFhTtEs2Mz7Dj-O@x1n>
X-ClientProxiedBy: BN9PR03CA0784.namprd03.prod.outlook.com
 (2603:10b6:408:13f::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB7379:EE_
X-MS-Office365-Filtering-Correlation-Id: 80947543-5617-496c-2841-08dceee07c08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zkarc2F7Gy8gUcFi6sLFDzoJpqvCh/jSeqjITgRTZjwPoOIiYA/e0V3rMd17?=
 =?us-ascii?Q?b38DCCYxmAYW8ZBrTr7i9r5zK+OHdBGWo1Simmp3xBeqD5MbH1UmOMQMrQTe?=
 =?us-ascii?Q?ebXLIE/1h0XCVIP3xALzBpeI2q+buV3XkklDhcuOY5YaypEygB5u1FL/qizC?=
 =?us-ascii?Q?5eYCJj4blvBIoqh4dDJPbf73bhWsJ7y5d2Y4OZr55vh99I8bIGDgURu6d2i8?=
 =?us-ascii?Q?637XcfW+HfO05NtrzxUtLhZ2hZp1J6VLrMJ9LmGKDX/PnLmUtjy8rUWxcl00?=
 =?us-ascii?Q?7OmWtcI56EFoPuSk1+AY2PeTVCAy+ovghQ0fse0VT9EOWWN1EK1CDYVPOOAI?=
 =?us-ascii?Q?RXaiKYPl1t0UOECk4HgqZDWBLF8CAw7vkO2sUhUCJ00/TrFyVwYfhY8nlbSP?=
 =?us-ascii?Q?w9vQiNX9xk735wZEIbpRNT6xRM82QyYbWu0ogVYQuhwX+kQoBnQmsxejDeP4?=
 =?us-ascii?Q?x5uzim8p6W5uiu1zD9oDGoAnQ3vt6vKmY43tF9RMyTGQaLj97OXImEsoIh2l?=
 =?us-ascii?Q?bl3myYqD60XC5T4v21FhlhoQcM+uIcWGs1HeSd4GbIl+x/aP1Q/IMCaSHCoM?=
 =?us-ascii?Q?6qap2o1x5wGVDVsjM/5Lap7o11D+IaM7Stirf0+tk5tNwWIat7ud1AfOiKjY?=
 =?us-ascii?Q?IvTujXPOAwy9orf6Q2Hw+HaDbaugqnQ+/Ah8IHfhc9IxSPAY9d5kIr0Ebmxc?=
 =?us-ascii?Q?wcuQ5FFaP2uIlx8HsuhNBLErSDjMISGUX5YMYxJ+ZHblbEPeDXFLpWNbFpsG?=
 =?us-ascii?Q?yQ7z0zZI0vcTcksUs4R7UX49oQ7/EwlITkg0VgV6q9UOFr+Kt7YTtewmxn5a?=
 =?us-ascii?Q?03xNgDRll2ppn8yqzNJtYBxrO1mDg/3Vnbu5t90YduP3zVD28eVm1jAPIc0+?=
 =?us-ascii?Q?kc3kUNGdJqZ2Y4J2ojmSF3mBUP+hVqKPp9BYTKsAA81YY7lN0SXh70mMr4WN?=
 =?us-ascii?Q?itbwoWei0o4qnFNHh249tp2cAaDcl+gR6E6PTzYgFuInU4iQZj7HDbXW0zu0?=
 =?us-ascii?Q?pliiJ+OQC8Y9kRBjK/o9hZ02YOdWcgy+v5wJmcwkz+/Xg8ZbRqZgRtjRqnK/?=
 =?us-ascii?Q?MplbAPPvbkT8iQMSAm5QpQ3sZ6IupupdoeArK8Iel/lpNR0hXPnWNdA1MQau?=
 =?us-ascii?Q?JVbnc/0omziYz97HndHwm2DvDBuNK1OYiydYLdRoUgCHbmm0i/FM/hPMb31c?=
 =?us-ascii?Q?i7vLADz7HKtcptOtc+evq4Zr+/Q23GkDSyG/kyQo9ZBB42KkWdLv/fQ6OHs4?=
 =?us-ascii?Q?vWcCXPsfRUX6UFVhJfWoqKFtMC9v5dXz6kmfw5B6mBoM3yyq+6X7a+eqcMtA?=
 =?us-ascii?Q?4ajib78IPdWsFMwHD80i3llT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0lQ6AyVZtZw9sN59NBGBRxd7ge/fm4F9LgsTv41pp8uqPYsnqDwJ1gKPRe3X?=
 =?us-ascii?Q?YalJ7QjKVnFladIgE5oDRoI5KAnFEajjCM5gtlMuFajTi8NkgUVGYW+KUQUK?=
 =?us-ascii?Q?puVjBZk0XCmjav09tdZT3n2JefA8jm26PoUeIWNYWZUbIgP0AXqDYDWaIl3c?=
 =?us-ascii?Q?RVtwRUK1pT9FU4nL09BJGjpUe1VNyt5a5UwExlATHkbWviTPR5+3fYfrkXKt?=
 =?us-ascii?Q?bWILt8cKfycXmuoanuUaFdEGwxGn++pkk3xnxh38rfe7B8FcnWEhNJdlwx3G?=
 =?us-ascii?Q?Jsi+8hNyWHrfo+aJTH1VbhMWpow+oVogywfsf8d7cVLj9DuEr0dgcqwIB3aN?=
 =?us-ascii?Q?wNX452UfwFukjS6PUVJjQi9f+28czIAjC8ggintRYnahoxG11cYiayNXkRhv?=
 =?us-ascii?Q?6L/3w98MRsGD/i8wfliTQ+z8PM/gh+GA75Veq1qUKvJfrSZjNQE2Tf5gMVtL?=
 =?us-ascii?Q?xLamQL2rJo54LpuuoyW0UA9+0FsA8TQSNPALOb10pfVi5eMkFYpL+DOYTluM?=
 =?us-ascii?Q?+xtvBGEhyAZB8sPngwwVaWPkhXTlGDziQnDnYgCYbcA35BcDFJtbiQGbu0yz?=
 =?us-ascii?Q?wJRRkYw07iZhICnuVW4rQuk2L4IT9aDGjmPktiOz+9ENYNA3cQdZn2FEJbXN?=
 =?us-ascii?Q?HaA7aOPTN0eEjim77jCSOos3lYcyMjDQVpbIkkPtNGXl5G/kFNXAj+X9Yzuo?=
 =?us-ascii?Q?9glE8HvEQJg7zXv6mhAxgz5Wawz/UQDwNCAunrAhB0WMACMOZPNf9k6mqgpd?=
 =?us-ascii?Q?q1pNNE+huCYdL14ehIuUppXTdVqXhzAv6Z4xw4iYoaCSPNxrOuWaEn373Kho?=
 =?us-ascii?Q?+EeVDQf+vmB4zozhEC1Xn+WCX5J9+i/V1Aco6/L1TfC57DelGP6UKjqV1Pnm?=
 =?us-ascii?Q?ZKOifFz2EJas3LCCVmW4gPbPtYWR4Pn9V9Aaw2NAJWK8WFj06xxexHs+aWsK?=
 =?us-ascii?Q?Ao2BAXBxgMTFhp/rj8uGze7TrvtqHogF/OnLfm7wq97vTvpngcgDlfPk1mvG?=
 =?us-ascii?Q?MKOuzN5gEYQg4W8E3elulgkzTiZObHi7xOwuaEV5JDVu3iPGPCt7deEqUapW?=
 =?us-ascii?Q?z9VY9/1gFPnKyfvuOFGmxG2l1yp1tMIIA3NbGojWpCGVYzZYgzrzoHHwXAws?=
 =?us-ascii?Q?+vFGNwcAhu5r0xHIdnb8yTHFedT66vOG/FDvKYQuqApAyTf2/rpYSzlFyikL?=
 =?us-ascii?Q?lg6As07WVNkvZVfFog3N3RR+tEJDMRY4blg2Rrevd9Xqol4VVDfpNWnl+KUR?=
 =?us-ascii?Q?A3A2bu4Cy3l4D9D/ehopQ3XCH8BGsIptOU9+VReE+nT/uOgMYOZBu6Z7XDrh?=
 =?us-ascii?Q?5HRev2WRT6/1yi+vxVYgybknlxcwMYRnzgIOQbn/aT3zVKUNQaaUvq7pngmR?=
 =?us-ascii?Q?FSQzSaNaNUvKd9NiZYQvjunexeY2B5V8V+cAD1IsfyovjhvNuDB6JroP48kJ?=
 =?us-ascii?Q?EIaN3ufAvIN13crmrsSGDea0jS2S6ozFAsjbWikKTNSCzZ1WUZ6htOOnBF7f?=
 =?us-ascii?Q?Oyx4a7Qpb2NRbAJTtABE9uufmHaso2hYCrVOczpkrooVoqIl2D+LGBP6GJOg?=
 =?us-ascii?Q?xbzY1MP7ZF83cVyo/FU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80947543-5617-496c-2841-08dceee07c08
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 19:18:30.2512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QgkZHq0MrylMwcAZRHTg6fFcO1yyeQzMCk7HQM2ULpt2nFVCy75R0AH7AW8cF9xU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7379

On Thu, Oct 17, 2024 at 03:11:10PM -0400, Peter Xu wrote:
> On Thu, Oct 17, 2024 at 02:10:10PM -0300, Jason Gunthorpe wrote:
> > > If so, maybe that's a non-issue for non-CoCo, where the VM object /
> > > gmemfd object (when created) can have a flag marking that it's
> > > always shared and can never be converted to private for any page
> > > within.
> > 
> > What is non-CoCo? Does it include the private/shared concept?
> 
> I used that to represent the possible gmemfd use cases outside confidential
> computing.
> 
> So the private/shared things should still be around as fundamental property
> of gmemfd, but it should be always shared and no convertion needed for the
> whole lifecycle of the gmemfd when marked !CoCo.

But what does private mean in this context?

Is it just like a bit of additional hypervisor security that the page
is not mapped anyplace except the KVM stage 2 and the hypervisor can
cause it to become mapped/shared at any time? But the guest has no
idea about this?

Jason

