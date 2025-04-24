Return-Path: <linux-kselftest+bounces-31525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6307A9A591
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 10:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB551B83426
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 08:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1FD205AB8;
	Thu, 24 Apr 2025 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eaGJ3siy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA7B1EFF88;
	Thu, 24 Apr 2025 08:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482560; cv=fail; b=XaFfSq2wQt9o9b5kR9vqQYO5YGSKlatrTZU2qBi5R6CjpxCEmjKWFmgfN5SAdP9b/Gxjxnjt2quSjixGQxJlOrM9CmNafMePq8ab8PkEp/nshuFZKACcVH/rrewUXz1X3IChxUumeA2r8Hicta0ZRvOAktxeLEHK5Qg2b8z5abk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482560; c=relaxed/simple;
	bh=ltjblWd4f43GK/sxvJSJg+GgEPw6Gu7Z3G9EkP0LarA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LPT4a7RSG9L9stA7INtZriZPvbk87bIV0gSfGIwiYnr8Kv7LjyLUUB8OYnFS//5U946gAxjG7UtPQ25HZpgc5gCq64vEhE6Um0tmqXzXfyNHkNMT2TPJyidBauHzNU2jaDGgt2uGrGPYtdCrRdwyLoM8quaJlM4ZEDiyk0frils=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eaGJ3siy; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745482559; x=1777018559;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=ltjblWd4f43GK/sxvJSJg+GgEPw6Gu7Z3G9EkP0LarA=;
  b=eaGJ3siywHjJ5kfppQ/2wFweTeMlA6/emjsVBdoi8BQp72CavD0hhjRU
   NtdGU94RHrGnQg+qsJ7u0FGu/N38OchgfQzyjUNLvn68qCF9xDoU1q54D
   zQMrO3J8M2JpvLcBSlyD/4AiYpIKb48IQEmXo2k3TdhTuZ20vxGlqgITS
   u3U5gPDwCcvig08KZ7slYdxtvobISZyyPCw4lPHatusCkvrW3OC1bw0yn
   +fBJ65PogerZHmiYIjnZAXTYiPWhM6HplzxUZ58mDq4svZjZS/acrMXZA
   IkeH712WFpGd0q9cEwR1/lMRS5VeEH/kg3fwfIV19gqHh8lpZjQH4aWhp
   w==;
X-CSE-ConnectionGUID: P8KyJplVRiWP7L8yX6t3zg==
X-CSE-MsgGUID: A9u+IdJBQlaX3akTGF1qDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="47013687"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="47013687"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 01:15:49 -0700
X-CSE-ConnectionGUID: DqSG8NsNQ5+ZJ40yEPkU8Q==
X-CSE-MsgGUID: zAUhEzZfRaWOP0qOa1pFEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="132433337"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 01:15:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 01:15:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 01:15:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 01:15:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbCzdLG/ve0QPzJDfmyqWf5GfG+x+es/+y2AgAQ6HZJqfcEs1q1hWORhuG5MGPTM+NFBMsb7B3B2iZXs80Uw939Fv1Kx7BX7+2YR69EoTlvVJVWa8DPOg0Tw0/DbnyZY9HR7emBzJGzOaNFZoLTRos3N8ka9Ifuyuc8B5VutDrcamVT84vrJByEWlcfEA4FQvQx9XHsU/QR6TiK65BjXYquP+9WNtCKAceAZPXIVYNiKTdMZGXAMpd8pIHw2vQOeoZeLzIBP5j3y48N0Ublm/tm960Q2alV9PZU7LXVnrNYMngCNsy9/hXoGLQyCRVsLC4uZsFeszZa9Ej8wqpDAFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcSKCipI5MW3H59AqWRf4+QFXBiaC+xSuQgNq+0bies=;
 b=lvFveJq8niygIWKpTphMCeYlL7BifS1H97HNLPGeWLYpERtzmJowEIMfDYPyYgYkoZmNufwEHhi1VeqinS4VvGHUTVmpT5xI6yLrPcDWiXPwMERf+eMTXA0u4c/tU2pxUuxsErfBHek30BkPCa3fKURbfL0z/sciJqZ1bQQW9dlABFa8inb+APqHHp+afZh9H4+v97lwsDCS/sNDdeMJoqve9T3cuxuAydFeudSkgTX3QL6d6AC+b9/cEnF2NbDl4148/ZBflmKcT9OnPskE09mEQMB11fKQ55zpsN7dSZ0m6RD4T9pL1P/ZrnuPVdMqpvm0r+ss5/7J5V/RnszgzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 DS7PR11MB7859.namprd11.prod.outlook.com (2603:10b6:8:da::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.23; Thu, 24 Apr 2025 08:15:40 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 08:15:40 +0000
Date: Thu, 24 Apr 2025 16:13:40 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Chenyi Qiang <chenyi.qiang@intel.com>
CC: Ackerley Tng <ackerleytng@google.com>, <tabba@google.com>,
	<quic_eberman@quicinc.com>, <roypat@amazon.co.uk>, <jgg@nvidia.com>,
	<peterx@redhat.com>, <david@redhat.com>, <rientjes@google.com>,
	<fvdl@google.com>, <jthoughton@google.com>, <seanjc@google.com>,
	<pbonzini@redhat.com>, <zhiquan1.li@intel.com>, <fan.du@intel.com>,
	<jun.miao@intel.com>, <isaku.yamahata@intel.com>, <muchun.song@linux.dev>,
	<erdemaktas@google.com>, <vannapurve@google.com>, <qperret@google.com>,
	<jhubbard@nvidia.com>, <willy@infradead.org>, <shuah@kernel.org>,
	<brauner@kernel.org>, <bfoster@redhat.com>, <kent.overstreet@linux.dev>,
	<pvorel@suse.cz>, <rppt@kernel.org>, <richard.weiyang@gmail.com>,
	<anup@brainfault.org>, <haibo1.xu@intel.com>, <ajones@ventanamicro.com>,
	<vkuznets@redhat.com>, <maciej.wieczor-retman@intel.com>,
	<pgonda@google.com>, <oliver.upton@linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH 39/39] KVM: guest_memfd: Dynamically
 split/reconstruct HugeTLB page
Message-ID: <aAnytM/E6sIdvKNq@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1726009989.git.ackerleytng@google.com>
 <38723c5d5e9b530e52f28b9f9f4a6d862ed69bcd.1726009989.git.ackerleytng@google.com>
 <Z+6AGxEvBRFkN5mN@yzhao56-desk.sh.intel.com>
 <diqzh62ezgdh.fsf@ackerleytng-ctop.c.googlers.com>
 <aAmPQssuN9Zba//b@yzhao56-desk.sh.intel.com>
 <aAm9OHGt6Ag7ztqs@yzhao56-desk.sh.intel.com>
 <c4dae65f-b5e6-44fa-b5ab-8614f1d47cb5@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c4dae65f-b5e6-44fa-b5ab-8614f1d47cb5@intel.com>
X-ClientProxiedBy: SG2PR01CA0175.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::31) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|DS7PR11MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 575a5f65-cbd8-4e60-1201-08dd8308335f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kz9UvTi+xhCH60lueSaqr4qm2Jxnr/qMysjXobvGTjnZJhHgjdN0sFyTeYxd?=
 =?us-ascii?Q?cVqyOOFiKGap6uyAejFM4X/sLFj7VZ+m2LwFHYnCX2w6dv+wWHCAxHlI2j23?=
 =?us-ascii?Q?dfSKQno0WaQFuj0CUlrePZUESsqevPCwUYTPQ7NTSdleXYUt3GLQDPg0CrVB?=
 =?us-ascii?Q?c86b0wQwaWwt96PgDFzHA+zFWuMpttjnVxvjd4mrcL+3yxO9gbCfgPFViVuG?=
 =?us-ascii?Q?e9aHx/rTPibqGMRXy1PerT+ax9XT+OE1IAgkIW2qqo6qeQSCJXKdou3Tn9AI?=
 =?us-ascii?Q?BEa4RxAHSz0DpJoNPPXtRBmPpnmZHunWtxKRZKPQOgE9HQBhyaKuzxyzP2vS?=
 =?us-ascii?Q?GyXOqzl5CeZuO8fbpLukla+oE46DCON9Y5FqodRfGNygsJeCBNlJ37x50ABF?=
 =?us-ascii?Q?QPYfJzJpmI+uDx8+Qt003WGsQW92CnRAxh5rLJGGNw1NYuaU5udnRZFEPiCd?=
 =?us-ascii?Q?tVzom3FSnO4P//0id0VdBZIdyAC1fV/lOaNhFS0kx5gu2rd38YOtAQHIbCN6?=
 =?us-ascii?Q?elGtJ/dlCJmxxrQn3f8SI6dIovD46UEO5UGybN5Y+TIg36wSTXk6iN96d2/J?=
 =?us-ascii?Q?XbRkVxDJtVThCje7xoQZjxWNAUcr79NXeWmnCoblOlNkw3zHj/u72aRCHmmB?=
 =?us-ascii?Q?DIs+OXfIGsBKuReXgBy7AR9Ylh4EblB5iRYV31BREsLWdmjYl6JYUW+49cWA?=
 =?us-ascii?Q?Zb8HLh6AjIoZf/GvK/kCCog3H297+L7wgB7ddQd8uhge+DLkLlwBIZCEW8yV?=
 =?us-ascii?Q?0pQaJurBuZQAd1a9up0DwISYC0ukKg5fWG+cqz5dX09aLAobe7oplpBlKL8I?=
 =?us-ascii?Q?69shNd2cwszrKkFZYgvA51b1Lq/ZZmRB1xKxnYDgjKzHFHWwt+qdJ3vHoNbq?=
 =?us-ascii?Q?vlh1a3lU08sGUu+YFGBbqkWkvRwCpX8HGXKgXbYXAlcxcZNgEi8XqmaWEeKa?=
 =?us-ascii?Q?/nzddk2yseHn78n8hjxLfyPG8qP/rU8pTB4/GfnBKkab6Y1S9Nzx1atdOYze?=
 =?us-ascii?Q?l09yfrYzOSHqyWAyElgrjgy5X7y/AT3m7hp8NbyHzMk/YR6f5ZmQl5Fv6wNf?=
 =?us-ascii?Q?sNk7n1QlaoaTztFAE1JN0OF6L7Zf+RqNkA2S1q7Bevp9Tk4f2VBKIBju/n2K?=
 =?us-ascii?Q?MG46NcU3urglbYUq0qf//fu6fFUcUi5nosVPMVf3SXKrhfTS8uoxms6kuPha?=
 =?us-ascii?Q?ithHahBfXefl/hico56a3qRtO34eR5VWyJPXmwh2wW/T6xhrVkGJz26AT1tO?=
 =?us-ascii?Q?6Ug4dfdeSx79KMqyXtfYvORVX9bbdRnPCBl5SqxccxFsyBC9fTaEw4kTkNB5?=
 =?us-ascii?Q?dlIWh6pZYi/KkoBhq2pOm3PJOU1sz3ozlcDg0CSgsnBlzrN+5foyfpNLrSjA?=
 =?us-ascii?Q?kpJu97QhgymO/ZKfq7nqvj192cRmFmEH+UnYiD0+W4oKxCELdoWbXuPeP1iG?=
 =?us-ascii?Q?FzcrIvSETgE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KcR3QxpAe7W9Z3ylz7yw+LshTDkSx8akkfhy938Gpbtulk5/OyfESjrfxmda?=
 =?us-ascii?Q?VggQsuBcYcj+d8hKiPL4B9kgDZkL8hEXgtJVG4fmZNTnZHcRE/xoHPHX8RsK?=
 =?us-ascii?Q?Wp9Q08B/1zkTavXVyHGG4iFtgEcRy/iqhOMr3XC0UGs47CKbtZdhR4rv/con?=
 =?us-ascii?Q?TWk+pnpL7QvJMiJvW1ipBTQQIYzONr5gP0DN11hEgBXq+TOkORE4UUlJqXtn?=
 =?us-ascii?Q?unj4YalkJCTdMlNc/nNoSTKhPa+/FYEmgc65fXLiaCxbdWZ6pjU+PWfnxCad?=
 =?us-ascii?Q?UYqa+ub+msf+KGgVHcUok4gDqeqoJhEMUJ8X4J7NHBYYnwFM68dtzq2RCWjw?=
 =?us-ascii?Q?O1WfyJx/HXMktIQNUM0h1kMr1M68xQo1NiKaSRhO9kdiewfjbUrykRgaeu7e?=
 =?us-ascii?Q?oCgySbn+nkJL0N+Vz7j/ZqrkcOqIGtjVqOMObVPM7rUUYo4/vk8No5RZtZBV?=
 =?us-ascii?Q?V7QIhNmuH0OWUrqdZxHr6IGbp+NKGiOMsAQF2l+xFyxXpaxuN9aLF7tg4Y4S?=
 =?us-ascii?Q?iB7YXrNnyg2UVTqA7N7QrvBpUVA/OaUX7p/7EogXaKUt4m8GdRgNO+/duIZ/?=
 =?us-ascii?Q?UpMmgIW/5M643NUiY88rJKvZL3Zfu5tkUkgtiG+XFTxn/qrM/5Q9itkqZpWY?=
 =?us-ascii?Q?srWXeq5BCRDmrNVP/yCts6L9TANlDE6NWqyZ2NOgE2Wufk7bEDuH4AcK+JG0?=
 =?us-ascii?Q?fnpNuSpNqIEOkjiCpDmwWLvDPg2MFwTZ6xEeIKINsUnTnVfk+JrsJY2BcEte?=
 =?us-ascii?Q?j4pesRqZw56pmbtusOsXPQpR51QjLgIbGzGLhjdxYAEqF/SUQewlLrX/cO9s?=
 =?us-ascii?Q?liYRg4kDbqoQzjea2MRJFSbo0+mG/4M/FZRtnv8Js/avGoFlDBX+mVfNH7iT?=
 =?us-ascii?Q?ioyVLzQHzNqcpbBXLBXTrhEwzS4/8CujZ6BzWSxFiKUdVg/F2/ttPqvy42+p?=
 =?us-ascii?Q?MHIuhAE7lgYoKe2VU8UIF5QdQBGVjpntFWSQFJFHrITb1OTqu+9se8umBcXS?=
 =?us-ascii?Q?hCxNzuq4/NcXZAYHFiF1eIi4GS4omnPZnFkWuXp3RZUOwk0gEB2pIpympkkI?=
 =?us-ascii?Q?hZlRIq1xUywYh0KgsQCST/pzNEm9rfI6u+YEOtwmILKnqSghXHTnjKbHv6xS?=
 =?us-ascii?Q?e02Bs0iA9BrcopVtjV7Ss3oGgfUT9F69y5HctNMrzUHpo0vMzoXzsEBHCB1f?=
 =?us-ascii?Q?eomMm6jtXLXpne1iLx5AiF21oLD2TI57Pom1EuuK/H0ncPbVIPRtOVd5MlwX?=
 =?us-ascii?Q?hBZCU52QJvWhzBWuH8FL8FJZSpgo4Fb7Qr9cuT/0U0xauqhvmGOfxOTwRvf3?=
 =?us-ascii?Q?MbKvlF0kY2YZ/mro7eWAk04mtvr9VpkCyxFHZeDfmLLz2USS3VtHqSKqSG9g?=
 =?us-ascii?Q?TbWsfoZA2ZrxXV0WA/KFGon8wkERb8PDROy00PZrknlpaaWp9jFyWkbBW/Mm?=
 =?us-ascii?Q?Xe7UzGg5HkKcQKuUfPChTlJ2FLBl5TskQQsZMlzA2pe5BtE7L25JlXPKTUug?=
 =?us-ascii?Q?gn460Xjk4SqfCRR1oDcZG2/KAmXQSMnYjcBL0IEjwMiRSVlegFUSRZjxNmLE?=
 =?us-ascii?Q?5ThPI54QLO3D68Py26yjMlAS3OfbhRY+jtky7W+v?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 575a5f65-cbd8-4e60-1201-08dd8308335f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 08:15:40.2742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDBr9pmb7dow5JGv2sw/etmJt85J7/4s9xqs6ftPkkbrm/VTwUkCliQwJvpCfvrOv2xmbVfNx8eEGRsRmct63g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7859
X-OriginatorOrg: intel.com

On Thu, Apr 24, 2025 at 01:55:51PM +0800, Chenyi Qiang wrote:
> 
> 
> On 4/24/2025 12:25 PM, Yan Zhao wrote:
> > On Thu, Apr 24, 2025 at 09:09:22AM +0800, Yan Zhao wrote:
> >> On Wed, Apr 23, 2025 at 03:02:02PM -0700, Ackerley Tng wrote:
> >>> Yan Zhao <yan.y.zhao@intel.com> writes:
> >>>
> >>>> On Tue, Sep 10, 2024 at 11:44:10PM +0000, Ackerley Tng wrote:
> >>>>> +/*
> >>>>> + * Allocates and then caches a folio in the filemap. Returns a folio with
> >>>>> + * refcount of 2: 1 after allocation, and 1 taken by the filemap.
> >>>>> + */
> >>>>> +static struct folio *kvm_gmem_hugetlb_alloc_and_cache_folio(struct inode *inode,
> >>>>> +							    pgoff_t index)
> >>>>> +{
> >>>>> +	struct kvm_gmem_hugetlb *hgmem;
> >>>>> +	pgoff_t aligned_index;
> >>>>> +	struct folio *folio;
> >>>>> +	int nr_pages;
> >>>>> +	int ret;
> >>>>> +
> >>>>> +	hgmem = kvm_gmem_hgmem(inode);
> >>>>> +	folio = kvm_gmem_hugetlb_alloc_folio(hgmem->h, hgmem->spool);
> >>>>> +	if (IS_ERR(folio))
> >>>>> +		return folio;
> >>>>> +
> >>>>> +	nr_pages = 1UL << huge_page_order(hgmem->h);
> >>>>> +	aligned_index = round_down(index, nr_pages);
> >>>> Maybe a gap here.
> >>>>
> >>>> When a guest_memfd is bound to a slot where slot->base_gfn is not aligned to
> >>>> 2M/1G and slot->gmem.pgoff is 0, even if an index is 2M/1G aligned, the
> >>>> corresponding GFN is not 2M/1G aligned.
> >>>
> >>> Thanks for looking into this.
> >>>
> >>> In 1G page support for guest_memfd, the offset and size are always
> >>> hugepage aligned to the hugepage size requested at guest_memfd creation
> >>> time, and it is true that when binding to a memslot, slot->base_gfn and
> >>> slot->npages may not be hugepage aligned.
> >>>
> >>>>
> >>>> However, TDX requires that private huge pages be 2M aligned in GFN.
> >>>>
> >>>
> >>> IIUC other factors also contribute to determining the mapping level in
> >>> the guest page tables, like lpage_info and .private_max_mapping_level()
> >>> in kvm_x86_ops.
> >>>
> >>> If slot->base_gfn and slot->npages are not hugepage aligned, lpage_info
> >>> will track that and not allow faulting into guest page tables at higher
> >>> granularity.
> >>  
> >> lpage_info only checks the alignments of slot->base_gfn and
> >> slot->base_gfn + npages. e.g.,
> >>
> >> if slot->base_gfn is 8K, npages is 8M, then for this slot,
> >> lpage_info[2M][0].disallow_lpage = 1, which is for GFN [4K, 2M+8K);
> >> lpage_info[2M][1].disallow_lpage = 0, which is for GFN [2M+8K, 4M+8K);
> >> lpage_info[2M][2].disallow_lpage = 0, which is for GFN [4M+8K, 6M+8K);
> >> lpage_info[2M][3].disallow_lpage = 1, which is for GFN [6M+8K, 8M+8K);
> 
> Should it be?
> lpage_info[2M][0].disallow_lpage = 1, which is for GFN [8K, 2M);
> lpage_info[2M][1].disallow_lpage = 0, which is for GFN [2M, 4M);
> lpage_info[2M][2].disallow_lpage = 0, which is for GFN [4M, 6M);
> lpage_info[2M][3].disallow_lpage = 0, which is for GFN [6M, 8M);
> lpage_info[2M][4].disallow_lpage = 1, which is for GFN [8M, 8M+8K);
Right. Good catch. Thanks!

Let me update the example as below:
slot->base_gfn is 2 (for GPA 8KB), npages 2000 (for a 8MB range)

lpage_info[2M][0].disallow_lpage = 1, which is for GPA [8KB, 2MB);
lpage_info[2M][1].disallow_lpage = 0, which is for GPA [2MB, 4MB);
lpage_info[2M][2].disallow_lpage = 0, which is for GPA [4MB, 6MB);
lpage_info[2M][3].disallow_lpage = 0, which is for GPA [6MB, 8MB);
lpage_info[2M][4].disallow_lpage = 1, which is for GPA [8MB, 8MB+8KB);

lpage_info indicates that a 2MB mapping is alllowed to cover GPA 4MB and GPA
4MB+16KB. However, their aligned_index values lead guest_memfd to allocate two
2MB folios, whose physical addresses may not be contiguous.

Additionally, if the guest accesses two GPAs, e.g., GPA 2MB+8KB and GPA 4MB,
KVM could create two 2MB mappings to cover GPA ranges [2MB, 4MB), [4MB, 6MB).
However, guest_memfd just allocates the same 2MB folio for both faults.


> 
> >>
> >>   ---------------------------------------------------------
> >>   |          |  |          |  |          |  |          |  |
> >>   8K        2M 2M+8K      4M  4M+8K     6M  6M+8K     8M  8M+8K
> >>
> >> For GFN 6M and GFN 6M+4K, as they both belong to lpage_info[2M][2], huge
> >> page is allowed. Also, they have the same aligned_index 2 in guest_memfd.
> >> So, guest_memfd allocates the same huge folio of 2M order for them.
> > Sorry, sent too fast this morning. The example is not right. The correct
> > one is:
> > 
> > For GFN 4M and GFN 4M+16K, lpage_info indicates that 2M is allowed. So,
> > KVM will create a 2M mapping for them.
> > 
> > However, in guest_memfd, GFN 4M and GFN 4M+16K do not correspond to the
> > same 2M folio and physical addresses may not be contiguous.
> > 
> > 
> >> However, for TDX, GFN 6M and GFN 6M+4K should not belong to the same folio.
> >> It's also weird for a 2M mapping in KVM to stride across 2 huge folios.
> >>
> >>> Hence I think it is okay to leave it to KVM to fault pages into the
> >>> guest correctly. For guest_memfd will just maintain the invariant that
> >>> offset and size are hugepage aligned, but not require that
> >>> slot->base_gfn and slot->npages are hugepage aligned. This behavior will
> >>> be consistent with other backing memory for guests like regular shmem or
> >>> HugeTLB.
> >>>
> >>>>> +	ret = kvm_gmem_hugetlb_filemap_add_folio(inode->i_mapping, folio,
> >>>>> +						 aligned_index,
> >>>>> +						 htlb_alloc_mask(hgmem->h));
> >>>>> +	WARN_ON(ret);
> >>>>> +
> >>>>>  	spin_lock(&inode->i_lock);
> >>>>>  	inode->i_blocks += blocks_per_huge_page(hgmem->h);
> >>>>>  	spin_unlock(&inode->i_lock);
> >>>>>  
> >>>>> -	return page_folio(requested_page);
> >>>>> +	return folio;
> >>>>> +}
> > 
> 

