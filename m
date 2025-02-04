Return-Path: <linux-kselftest+bounces-25683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAFCA27417
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 15:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9233188B4C9
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 14:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6CE20D4FB;
	Tue,  4 Feb 2025 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XnjFIhZb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A287F206F3A;
	Tue,  4 Feb 2025 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738677840; cv=fail; b=U80IHqcccF0l76tSZKQ68zXpGJztDvEE8emdoD2SvhXDqTiXduvp+TNnHspPQTuR9emI5qdheW46RdoJuPupeq1580Ql5dOX46HAacGpRVD5sp/xIP+5DESVLiaOZVEAKikbPNVrozxxhs6wwFpdkd70YnEqHrJRhVVFgm0PhRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738677840; c=relaxed/simple;
	bh=7cxfUyRd2++Z4KtJiBXqATNiX9g0tcvt8Cof2YuUchE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fg9Kf7zEC8RKPg1ZTWKsIMStN7hebwjBlOyNg9GWtWaBvloeloChK+xWKJ+HmIJ4dM3sXalvcraVdj7TBoTdiNbaFBLtvK8wKnW5hJ2uxQl3NYA9ETt73L/leCfhkL3f06Liy3sTs/rUa6sBqBGzCaCyG6zZxyfbxGMvoIE/GWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XnjFIhZb; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738677838; x=1770213838;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7cxfUyRd2++Z4KtJiBXqATNiX9g0tcvt8Cof2YuUchE=;
  b=XnjFIhZbM+W5ztXhWA0eog2wuKM5ivKecbg/uhwhEGcai6IbePZbaFMV
   MG3Il7E5PGHbxQEO/P3mLNGpLbCXkN1eSrh/3Eg6F6EzV0mAO8xbpvwvN
   uTW7WkhSzzgDxPdfU+LlICJ80qKG5GxRlI9iSooJOT8nISEPNGr9x7ybz
   fwR8rCUpC8wYMnLQTrouvyPtuUvbF6r+IyexVqz/Y/Z4c4pz+uCaVYjVh
   GYBnC3b0XAvfE7zrI3bOhTBWk9iuLAmgKfrAt0Mx8CY6LBQYg7YZS/NeP
   +ZgoqDHcjtr2L2yElJl0QLs5gwa1hNsJTg2DoEZ4GTLT02XBTrFtqH2a0
   Q==;
X-CSE-ConnectionGUID: WXIGq9BRQ5uBSU6lUBZZOQ==
X-CSE-MsgGUID: c4ikQp1dTiGDI+mDXIAwUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39235260"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="39235260"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 06:03:57 -0800
X-CSE-ConnectionGUID: 2j5q7cb2QhezUUX0IhmV0A==
X-CSE-MsgGUID: d2O54sa+QICx25Y8eXn/7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147802026"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 06:03:57 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 06:03:55 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 06:03:55 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 06:03:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1UnriUO9Sz49gs9hAphqQAapN5ufLnAnGxYvmf7GiWXwYMGWYqMXQe952u3R52KgmLGYBVaab/DkoK4KZfYbxNGbDP5xwopfbE/sTn5Kj0pov6WFM/SgInVrxrdbT/pF3nHT9DNsDeMNWfDKRbeumZ10W5EGyEM8sntUlZv6G0UdhVr9g+UuSg8ZMkGPeZlR1kBZ+9u+7sGNYSrsXgOriCgaNWJNDMkABPCdKBBbMrtAsJwiRAtBHVwJMl56Y3NnkbUeajNWw0Ae5hdQAo6B3P5utusmdIsGBKXiRc1Tn4YdTSdGk45JAvukCilMSl3CR4nma0GMeO1IfvbOJCokA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixraOP2CZGF6Hce6Wh+PAxz2D1jMBFdRfdyFzSXiik0=;
 b=j3X3fEvOtzJnQJcF+koPq588SCyhnCDy2yyXozDgnEzwEYc3wZ55imzQhXmFLXgtjRRYqymc+E0HFoftpHJVnKjO03m4cbnfRil8OpwGt/CnkQ9oP7dE3yHb4zyldC16gfPECi4ubdr29UVDAzoIwA8PF+sFKPzS7uhVCGF/tjHSNYuFFr8fHkhPe3mFL5TMnGZkJL6vPUJUXgp0x86QwOwj1BKKz5jlubhbEqIrrNiSfIPvHWXgDeUm3n/0LWShD2R0lIIxYM9dR/osQkoJB5fgFqeWQ2lSs9GkGyjK+uGWEO0GaiBgUNV8a1L07+/23iKa1f0iaYF3xmxRSE1Umg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM4PR11MB6041.namprd11.prod.outlook.com (2603:10b6:8:60::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.24; Tue, 4 Feb 2025 14:03:51 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 14:03:51 +0000
Date: Tue, 4 Feb 2025 15:03:34 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Willem de Bruijn
	<willemb@google.com>, "Bezdeka, Florian" <florian.bezdeka@siemens.com>,
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Bjorn Topel <bjorn@kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Damato, Joe"
	<jdamato@fastly.com>, Stanislav Fomichev <sdf@fomichev.me>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Mina Almasry <almasrymina@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>, Andrii Nakryiko <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, "Jose
 Abreu" <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Faizal Rahim
	<faizal.abdul.rahim@linux.intel.com>, Choong Yong Liang
	<yong.liang.choong@linux.intel.com>, "Bouska, Zdenek"
	<zdenek.bouska@siemens.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "xdp-hints@xdp-project.net"
	<xdp-hints@xdp-project.net>
Subject: Re: [xdp-hints] [PATCH bpf-next v7 5/5] igc: Add launch time support
 to XDP ZC
Message-ID: <Z6IeNumqP1aNAphU@boxer>
References: <20250204004907.789330-1-yoong.siang.song@intel.com>
 <20250204004907.789330-6-yoong.siang.song@intel.com>
 <Z6HnaMQvgW+indqm@boxer>
 <PH0PR11MB5830422207B7D3BCB27DA04FD8F42@PH0PR11MB5830.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5830422207B7D3BCB27DA04FD8F42@PH0PR11MB5830.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0342.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::26) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM4PR11MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f5e6d28-a662-44d3-3a8b-08dd4524c0af
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CpR7BIJ46wI9W1eMz28Sjl7OmFKK788wNFc6DnjrY/89LMCUnECJbJxK4+1r?=
 =?us-ascii?Q?V/fVvVX03dfFQaWnFyNDczvrpWPkTdMV6YUGv5nALszGFRk/9V0V2yU/CRwY?=
 =?us-ascii?Q?nXRDtA3EZXprZIthu0DSY0IGvvboEnZu5JPHaWiCPtBiikXlphM4b8oX/Y8I?=
 =?us-ascii?Q?Qmt/UNSIvrmuTnsuCh+eXmKIgtyMitC99P3VyAYkbs2rdagpIpPmOgX1ID2Y?=
 =?us-ascii?Q?LmF4l1t9r6ZqA7OvI1VmT6B4zVWT1H0S27F0FKIA4FLawCirm9dmweFud5gZ?=
 =?us-ascii?Q?2j+KkfbEGlUKt/D8YKcpLtY8YOgNPmxxobq59BMpRGbsOynDuJFM/7qho56x?=
 =?us-ascii?Q?iJ3w52M7IHRfSmGNtzv561nI3AAnMYF2SE+XhGfKdijqCKaEWr/Rz62C84Fe?=
 =?us-ascii?Q?Rc1viPkOxK8OBt5yynkDPpAEf08g2Uj5iZcb4+pmdaMkXK2F4V8OKTZdKoNm?=
 =?us-ascii?Q?nVv/st29YQiLMvkFfoe9dgnlEQNmmODfY7aLOzKiLjPmC05eNiPpfl36l1yn?=
 =?us-ascii?Q?hBsxC9tRGtfGKbz4WVhtLMGnhPNRaXmwlWQnqSJCvcIia8rg8cQiocPVVE8Y?=
 =?us-ascii?Q?7Di4ZFx8XdakXbhDtPiOx0CooEKvj0G0v/gxY/NXjEfaN9Zuh3dTT3Up0iQz?=
 =?us-ascii?Q?JHEO7bpLH4K9/vB7lL0icJ7DMJmWZjF+SwvZcgFAayTRhV946ggv94Nyhqe4?=
 =?us-ascii?Q?Ms9V3dZfIcA0IjWBiunABvPahsSqqP3NFB2G5DkxO2oacWJAGt+m9mpje4LY?=
 =?us-ascii?Q?7DyKI0+Pvqk4/gbXgYuSJvp8fo9+v37Hzs76bq3xeD37ySQ35xNTMgJZDaYt?=
 =?us-ascii?Q?CIXcq8p3bn7wxe0S1g7n3L/xn0JrWI3tXx03AV6JMk1rvk76JcXXvZPhGg/0?=
 =?us-ascii?Q?9/eyRc4wkb5yxME5+akoAu8N86jSDquBVz+WAfsXDLwRqWfN2nEiCwU3RpyM?=
 =?us-ascii?Q?Yx6POOQc40lJCQOl7fdEgvJCCq4bMpwfFv6TfdXOc+QZi49p8T3d5m5mvEyU?=
 =?us-ascii?Q?gIUylFU/sI2pkOfO6jMLvOc8ZHux6JcxWp0Q3bM7UhuH3e+nTn1gmwCoWAL9?=
 =?us-ascii?Q?YoQoBTnIbm573gMV2edDJGbXspMuzEr/OMIp80ZTJaulOh4+zyazhTCRwjMO?=
 =?us-ascii?Q?3mJyvdMe2qOzDBj0SkAlhvP+uxL69mKx5AlCTiPYlk6IvVVqxtLMZFdjdFez?=
 =?us-ascii?Q?xiZ24tZd2GYga6yBksL+YZFR6GaoHHG4xuvfetIzReaHaglf3EIPhtnB8XIn?=
 =?us-ascii?Q?xdF5/YAigz5o0i9lWUchr6QZ47fDUEktR+XxFCKudax0ucdS5ZgrxE3mfg3m?=
 =?us-ascii?Q?YKvnMOojElAahMeb0Layl33QxOsBkiKpsrzRSJB8yN7ff1L9aoDx/uYPZy06?=
 =?us-ascii?Q?T4Qz7GeV8huvT039dcctY0zLzMAr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fNGImWBFu8Y+stzpCNKmA2sMKfn8GQE926zdWR+3/mA3CWfc7E989Nc4HulV?=
 =?us-ascii?Q?dSl4dbRqlSsNaZNQ383bgWTUo+vg2zblJQeEjJtJbbuM6zSlhCJkjfZFnGiJ?=
 =?us-ascii?Q?S50fvdM+/UoiR9kQ0Av1VIHfMvL8cun39wZTXzvJ05HqHU26O0pkseb6il4O?=
 =?us-ascii?Q?R92jgPapK8HBARVmRhpaYRrbLDOCr3cBpInbB+wKE9QBTUjnPCuItUYsyhUd?=
 =?us-ascii?Q?c0ApZMmROfTYoldwyeUReJVtP2wDkT155VR97YgrmyLmn2qxoCWsyW6K7zpk?=
 =?us-ascii?Q?5zQN9l1dXoHKhNU0HCMnXPTfppqwkkFgunPtRGNqmz93jL4eeF4m7VCQxPet?=
 =?us-ascii?Q?5eCc8E3aXG/mBhe4t50rgcsuFcClrIlCdx2bpQ8sRu8DAwN4ZVbvpsbwnWG+?=
 =?us-ascii?Q?TqJuWy0AGOrno92L+KzYNclLlPJhMoNhkU77e9r4ZmMa/G6RLGadhQWJLTb3?=
 =?us-ascii?Q?SirQpk4yxP1smiqWlp8G8B5oCuw9GrxkUKK6O7D1sTSsmXCu/yHrEJ7nZQyW?=
 =?us-ascii?Q?dvM/QJPImPzo6qY5/r9svDI96nue/kbZ689lg4sBZ9ohgj6SOJqGcVQbGzSz?=
 =?us-ascii?Q?QWM1bBrGnmOrf3kbZ6mWyRF2BTB4ZwonMKrFTM+xYDqRKr1x27btuvtOJkfi?=
 =?us-ascii?Q?qsMVgG3k5G7C8Sk4HA+VzUYHRyj5Fa0iHWkXBcVZcPxJZBwxDLHMzZv0AEO4?=
 =?us-ascii?Q?w+N9/WF0+fnv/030lb5PUUWNE3TeCazcbSCIzpbW+WK0j9z6AIKugjsAGBaZ?=
 =?us-ascii?Q?+lwTtk0IKyDQq8XXquHN5lW8IPeXYi6Lt1ptCJDNnVDYMmmpxbEAhcCJfegl?=
 =?us-ascii?Q?STGv5B+KGxEdDs8av9N8IWFxdD1UunPI1Lz8QB50UgkiK+SDrsUodYBeQ/9f?=
 =?us-ascii?Q?w/NYCd5HSasdSeLw/ceblNwDNtfZ6LbhfZmwEqX5s8Ty+e4kL8mHC+7dg/bq?=
 =?us-ascii?Q?HjRF/W+WufgBm81eCsy80Ki4YZvwI3XIEaUqNa/R2yeQO5r7GGcNrovdXVgY?=
 =?us-ascii?Q?WNNfTO2AODuBoBtbSTRedCwrS5LIQuO6cNn/ehbrF45OU57VeW2c1wwzx78p?=
 =?us-ascii?Q?vWCgdGVDKsew1cy4LehQReOY/vvKA3W8eheqEfDqfZas9b5iAUaX9Gd6tPo6?=
 =?us-ascii?Q?MnSStMmRVBmbE5C6U+8ZnzaA4psF/i/2rNOOidEXJK5L5SCeIuBlcrBEEW0i?=
 =?us-ascii?Q?hWv5PnFdDVun7Hdqb5AtEV5k+prDKzvPDYn84kUpv5s3DwTYOe/OWGRrZ/1S?=
 =?us-ascii?Q?+ZUSyo4EwULPWifzbaunONkwXL9J5dsKMbxCMj7IanR35HH1Zs8Pi67m5ZAt?=
 =?us-ascii?Q?fLN+3Rg90mMnrNsmlUuz5m7sWEMy/SAvP0xt1Md9RLlALX05B7E78IDr+7au?=
 =?us-ascii?Q?KkD2ZUITWi5cjkNYAFkhK5DQM3mnnzruHUusEuSpWAo0jsQE37EI0kQKw0cV?=
 =?us-ascii?Q?WIuG4hjFo/sOD29XORI4y/Zbc2n6/8aCmAm7ZDPI5xwivtufHCnPeX1Se03J?=
 =?us-ascii?Q?jF3fnHZ4FutvGLRTt1g6UkYDNfHqUAu34E1QoBiyEPtm4J2fGfKJc49KCszV?=
 =?us-ascii?Q?lGjscsFzrTPd774dGo++rYhbnXvoUS2brlckh6KnE4YFuIGGYjPCXj1vUdfI?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5e6d28-a662-44d3-3a8b-08dd4524c0af
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 14:03:51.3008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqDGmDayFWCrmPLsuHMkWolXmJgCLhBMf+z3Ic4UYKI5BEnEn8Xir4ma+cUsy37MS7R1qUllDnp4cljUoNmyWcA+cqFC2Me7nU8P50oQNFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6041
X-OriginatorOrg: intel.com

On Tue, Feb 04, 2025 at 02:14:00PM +0100, Song, Yoong Siang wrote:
> On Tuesday, February 4, 2025 6:10 PM, Fijalkowski, Maciej <maciej.fijalkowski@intel.com> wrote:
> >On Tue, Feb 04, 2025 at 08:49:07AM +0800, Song Yoong Siang wrote:
> >
> >> Enable Launch Time Control (LTC) support for XDP zero copy via XDP Tx
> >> metadata framework.
> >>
> >> This patch has been tested with tools/testing/selftests/bpf/xdp_hw_metadata
> >> on Intel I225-LM Ethernet controller. Below are the test steps and result.
> >>
> >> Test 1: Send a single packet with the launch time set to 1 s in the future.
> >>
> >> Test steps:
> >> 1. On the DUT, start the xdp_hw_metadata selftest application:
> >>    $ sudo ./xdp_hw_metadata enp2s0 -l 1000000000 -L 1
> >>
> >> 2. On the Link Partner, send a UDP packet with VLAN priority 1 to port 9091
> >>    of the DUT.
> >>
> >> Result:
> >> When the launch time is set to 1 s in the future, the delta between the
> >> launch time and the transmit hardware timestamp is 0.016 us, as shown in
> >> printout of the xdp_hw_metadata application below.
> >>   0x562ff5dc8880: rx_desc[4]->addr=84110 addr=84110 comp_addr=84110 EoP
> >>   rx_hash: 0xE343384 with RSS type:0x1
> >>   HW RX-time:   1734578015467548904 (sec:1734578015.4675)
> >>                 delta to User RX-time sec:0.0002 (183.103 usec)
> >>   XDP RX-time:   1734578015467651698 (sec:1734578015.4677)
> >>                  delta to User RX-time sec:0.0001 (80.309 usec)
> >>   No rx_vlan_tci or rx_vlan_proto, err=-95
> >>   0x562ff5dc8880: ping-pong with csum=561c (want c7dd)
> >>                   csum_start=34 csum_offset=6
> >>   HW RX-time:   1734578015467548904 (sec:1734578015.4675)
> >>                 delta to HW Launch-time sec:1.0000 (1000000.000 usec)
> >>   0x562ff5dc8880: complete tx idx=4 addr=4018
> >>   HW Launch-time:   1734578016467548904 (sec:1734578016.4675)
> >>                     delta to HW TX-complete-time sec:0.0000 (0.016 usec)
> >>   HW TX-complete-time:   1734578016467548920 (sec:1734578016.4675)
> >>                          delta to User TX-complete-time sec:0.0000
> >>                          (32.546 usec)
> >>   XDP RX-time:   1734578015467651698 (sec:1734578015.4677)
> >>                  delta to User TX-complete-time sec:0.9999
> >>                  (999929.768 usec)
> >>   HW RX-time:   1734578015467548904 (sec:1734578015.4675)
> >>                 delta to HW TX-complete-time sec:1.0000 (1000000.016 usec)
> >>   0x562ff5dc8880: complete rx idx=132 addr=84110
> >>
> >> Test 2: Send 1000 packets with a 10 ms interval and the launch time set to
> >>         500 us in the future.
> >>
> >> Test steps:
> >> 1. On the DUT, start the xdp_hw_metadata selftest application:
> >>    $ sudo chrt -f 99 ./xdp_hw_metadata enp2s0 -l 500000 -L 1 > \
> >>      /dev/shm/result.log
> >>
> >> 2. On the Link Partner, send 1000 UDP packets with a 10 ms interval and
> >>    VLAN priority 1 to port 9091 of the DUT.
> >>
> >> Result:
> >> When the launch time is set to 500 us in the future, the average delta
> >> between the launch time and the transmit hardware timestamp is 0.016 us,
> >> as shown in the analysis of /dev/shm/result.log below. The XDP launch time
> >> works correctly in sending 1000 packets continuously.
> >>   Min delta: 0.005 us
> >>   Avr delta: 0.016 us
> >>   Max delta: 0.031 us
> >>   Total packets forwarded: 1000
> >>
> >> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> >> ---
> >>  drivers/net/ethernet/intel/igc/igc_main.c | 42 +++++++++++++++++++++--
> >>  1 file changed, 40 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> >b/drivers/net/ethernet/intel/igc/igc_main.c
> >> index c3edd8bcf633..535d340c71c9 100644
> >> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> >> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> >> @@ -2951,9 +2951,33 @@ static u64 igc_xsk_fill_timestamp(void *_priv)
> >>  	return *(u64 *)_priv;
> >>  }
> >>
> >> +static void igc_xsk_request_launch_time(u64 launch_time, void *_priv)
> >> +{
> >> +	struct igc_metadata_request *meta_req = _priv;
> >> +	struct igc_ring *tx_ring = meta_req->tx_ring;
> >> +	__le32 launch_time_offset;
> >> +	bool insert_empty = false;
> >> +	bool first_flag = false;
> >> +
> >> +	if (!tx_ring->launchtime_enable)
> >> +		return;
> >> +
> >> +	launch_time_offset = igc_tx_launchtime(tx_ring,
> >> +					       ns_to_ktime(launch_time),
> >> +					       &first_flag, &insert_empty);
> >> +	if (insert_empty) {
> >> +		igc_insert_empty_packet(tx_ring);
> >> +		meta_req->tx_buffer =
> >> +			&tx_ring->tx_buffer_info[tx_ring->next_to_use];
> >
> >in this case I think you currently are leaking the skbs and dma mappings
> >that igc_init_empty_frame() did. you're going to mix
> >IGC_TX_BUFFER_TYPE_XSK with IGC_TX_BUFFER_TYPE_SKB and the latter is not
> >explicitly initialized. Even though IGC_TX_BUFFER_TYPE_SKB happens to be
> >equal to 0, igc_tx_buffer::type is never cleared in the tx clean desc
> >routine.
> >
> 
> Hi Fijalkowski Maciej,
> 
> Thanks for your inputs.
> 
> Yes, you are right, IGC_TX_BUFFER_TYPE_SKB is mixed together with
> IGC_TX_BUFFER_TYPE_XSK. Regarding the skb and dma map, 
> following code in igc_clean_tx_irq() will free the skb and unmap the dma,
> Do these answer your concern on leaking?
> 
> igc_main.c:3133:                case IGC_TX_BUFFER_TYPE_SKB:
> igc_main.c-3134-                        napi_consume_skb(tx_buffer->skb, napi_budget);
> igc_main.c-3135-                        igc_unmap_tx_buffer(tx_ring->dev, tx_buffer);
> igc_main.c-3136-                        break;
> 
> Regarding the igc_tx_buffer::type never cleared, I think the
> important thing is making the igc_tx_buffer::next_to_watch NULL
> to indicate no remaining packet. Since transmit function will
> always set the igc_tx_buffer::type to a proper type,

igc_init_tx_empty_descriptor() does not set ::type, that was my point. So
these empty descs might be treated as IGC_TX_BUFFER_TYPE_XSK, which is
wrong and your qouted code above will never get called. You will then leak
skb and dma map plus you will confuse XSK code due to xsk_frames miscount.

> I think it is optional for us to clear it.
> Is that make sense to you?
> 
> >> +	}
> >> +
> >> +	igc_tx_ctxtdesc(tx_ring, launch_time_offset, first_flag, 0, 0, 0);
> >> +}
> >> +
> >>  const struct xsk_tx_metadata_ops igc_xsk_tx_metadata_ops = {
> >>  	.tmo_request_timestamp		= igc_xsk_request_timestamp,
> >>  	.tmo_fill_timestamp		= igc_xsk_fill_timestamp,
> >> +	.tmo_request_launch_time	= igc_xsk_request_launch_time,
> >>  };
> >>
> >>  static void igc_xdp_xmit_zc(struct igc_ring *ring)
> >> @@ -2976,7 +3000,13 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
> >>  	ntu = ring->next_to_use;
> >>  	budget = igc_desc_unused(ring);
> >>
> >> -	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
> >> +	/* Packets with launch time require one data descriptor and one context
> >> +	 * descriptor. When the launch time falls into the next Qbv cycle, we
> >> +	 * may need to insert an empty packet, which requires two more
> >> +	 * descriptors. Therefore, to be safe, we always ensure we have at least
> >> +	 * 4 descriptors available.
> >> +	 */
> >> +	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget >= 4) {
> >>  		struct igc_metadata_request meta_req;
> >>  		struct xsk_tx_metadata *meta = NULL;
> >>  		struct igc_tx_buffer *bi;
> >> @@ -3000,6 +3030,12 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
> >>  		xsk_tx_metadata_request(meta, &igc_xsk_tx_metadata_ops,
> >>  					&meta_req);
> >>
> >> +		/* xsk_tx_metadata_request() may have updated next_to_use */
> >> +		ntu = ring->next_to_use;
> >> +
> >> +		/* xsk_tx_metadata_request() may have updated Tx buffer info */
> >> +		bi = meta_req.tx_buffer;
> >> +
> >>  		tx_desc = IGC_TX_DESC(ring, ntu);
> >>  		tx_desc->read.cmd_type_len = cpu_to_le32(meta_req.cmd_type);
> >>  		tx_desc->read.olinfo_status = cpu_to_le32(olinfo_status);
> >> @@ -3017,9 +3053,11 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
> >>  		ntu++;
> >>  		if (ntu == ring->count)
> >>  			ntu = 0;
> >> +
> >> +		ring->next_to_use = ntu;
> >> +		budget = igc_desc_unused(ring);
> >
> >why count the remaining space in loop? couldn't you decrement it
> >accordingly to the count of descriptors you have produced? writing ntu
> >back and forth between local var and ring struct performance-wise does not
> >look fine.
> >
> 
> Yes, I can check the number of used descriptor in xsk_tx_metadata_request()
> by introducing a new field named used_desc in struct igc_metadata_request,
> and then decreases the budget with it.
> 
> Do this way looked good to you?

Yes this makes sense to me, thanks!

>  
> Thanks & Regards
> Siang
> 
> >>  	}
> >>
> >> -	ring->next_to_use = ntu;
> >>  	if (tx_desc) {
> >>  		igc_flush_tx_descriptors(ring);
> >>  		xsk_tx_release(pool);
> >> --
> >> 2.34.1
> >>

