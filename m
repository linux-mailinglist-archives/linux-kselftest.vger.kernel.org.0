Return-Path: <linux-kselftest+bounces-43354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D19BE5919
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 23:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BFB73B7BE9
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 21:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E07A2DE6F4;
	Thu, 16 Oct 2025 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ny5z38IZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3048641C71;
	Thu, 16 Oct 2025 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760649966; cv=fail; b=HO/tHa7bZGo3F6Nrx79+/bbisMC/bYJ2bEeinki7zntw/GSwbwh1nu+wGkRgJpKxkfl3th9H+3tUCj6i0xknRHv5RTl5OLXsnEzwNJfz/r2jeSVoHoTuh0Wz5PoAflxxLyY6PVcrxn5Wb8TbtgPWwfbmhtJJ41jJsm5cXRsn8MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760649966; c=relaxed/simple;
	bh=lkC4IL63z506BpsgCqybOutIFMZIa2jV8FfGUgDEJY0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WtDursT0Wntf1ubgYA9u8OIe+uksprkmVVeyewclgdgoa6meg97jkSh1dgzvM64sYXg0SH79i/uvpCZmVCGSp2fO0ZjzQ4geFms6gEzoZZQ2+zJp281SSexyxu6IAyHP5nd3u2M7RW/+Mb4sE4PyHQQIGu4gHUsroaO4ouwY6gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ny5z38IZ; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760649965; x=1792185965;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lkC4IL63z506BpsgCqybOutIFMZIa2jV8FfGUgDEJY0=;
  b=ny5z38IZc8vGq4RDliayTB26chAaJ4bJPSkiFIx8MqklnomFJ5R385WM
   dFFiCDUcRg1UOR3IbW9lQPFOqizlpghK0a7PGJ1ZZb60V43V+oC4K7VlL
   PYHpHmeK2P1krF3EoKR6pn4OAR7kAjHtlUcfeQVtRf7vRjpIPg/GGPimq
   Q8nyJQKnrOlVxhU27a3hh7pJjc0OCVWMx4RW4VGaU1qxTeqkmynzh8dBi
   bSjObFYkfNijp4HnDffdhJogoz1nV4a7FwHJhHjqF1Ug5W78LPRryJ1aW
   DKAYN3Ema8rs+ZLKJ7TM20yPhiHaCgDGusT6dkp4HS9sm3UC9XwYWc0bF
   w==;
X-CSE-ConnectionGUID: sGYptaZ1S6ufC9ktqDr1Jw==
X-CSE-MsgGUID: 3bOTkTRPQv+QTZTkat8FKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="61887865"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="61887865"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 14:26:03 -0700
X-CSE-ConnectionGUID: OL88yyq2SZiXwxdvvFgxOw==
X-CSE-MsgGUID: NLuvp8HoSQKzH1JLwaXcIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="206262661"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 14:26:03 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 14:26:03 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 14:26:03 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.17) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 14:26:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNSEnjM81YYgRwTNtJq4TVLkJ5fd9z+f2qvDKJ4H3qRidoIWgy0M5LdSRcMwgn6jE5zD1JbHYStbFg8arcwdogXCVg4QWx2FaiPccnM9sY3rHha3rfN0oeOGt0wt8FAMAsNVipYqtB8VjjXMkElwb9nRG9AXXVK+2ERVGCgjlvKk6Z13G4PTzcLt1bhWf2ybFn+HTJExqibW4ULAbOm26o1vchFcFqSulf3c1y0TjmJFE/X9LAOBBD2CAOclS8G6Fh2mfChM0C5jVzz1pecJA8VpoXZzOP/SWtGFLuVhBhW5vF81WhvKcDu7lk5k3DvBFGu3A2C3J+AkkA0rgRBagg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVPetM7DZr7UQlB746ZL4LE0VDTOvQ33WgRTkJOfg/c=;
 b=h46akbAmASs5MHk7Pzv+6//mzmGiDyeVJtGjpQKE49g/TeF6018ihR5380eDrld5YixzDFdjok4E09IE469iG5ZopdrfOZZ1Ob4F4BK2Ed/Sjtkp4mtA50tdtPj7wiVWHDy7NWNEXAvxh3o+rMl7ZjR1Z3V0RYouQJOUJmcS4RAncn+0PCENWGOcsEq/1X2dTqkQGgi4rAV0TAfkFz+7GvYARMqDLUzBy4MlQTjIXsLIddZnCW9hzx/BkgI8ExPEp82ylz0wdPLAN468R2CFGJyS2GyLq2mwb7dDDvOF3fYSE51UrroZRIebXQAkYEcWnpmYv8GxXbW+15PDK/R/Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA4PR11MB9082.namprd11.prod.outlook.com (2603:10b6:208:56a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 21:25:58 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 21:25:58 +0000
Date: Thu, 16 Oct 2025 14:25:57 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Jonathan Perry <yonch@yonch.com>
CC: Reinette Chatre <reinette.chatre@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, James Morse
	<james.morse@arm.com>, Roman Storozhenko <romeusmeister@gmail.com>
Subject: Re: [PATCH 0/8] resctrl: Add perf PMU for resctrl monitoring
Message-ID: <aPFi5eQt1CmYXg_X@agluck-desk3>
References: <20251016144656.74928-1-yonch@yonch.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251016144656.74928-1-yonch@yonch.com>
X-ClientProxiedBy: BY5PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:a03:180::22) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|IA4PR11MB9082:EE_
X-MS-Office365-Filtering-Correlation-Id: 5971c59c-5b9e-4ae4-6b5f-08de0cfa9948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EuYj2eM6c1mub//ejisgCPZtc3eksCzgKANA1V9SvykcQo2/qWt0h1431eS0?=
 =?us-ascii?Q?f8k/admw0sunr1oFNHucU73vYbW2Zvffagk6m6Npksw91am9ZDml62pMtb72?=
 =?us-ascii?Q?KSGTBtDAuablqlJLLas591KkeRA0xx7PKRoR3KDp2/MdFy0lDjyGRbfT/yfE?=
 =?us-ascii?Q?U+MHeenlaULec2qC6ryYObKzixudIHj2MdaoPYRQ5ARvw77Xh3rIuHFFBBFL?=
 =?us-ascii?Q?0NJXY7SwXzwNTqPMeBIgfvcrNIttHGGMC9rCByDR4h52/Uwg5A5P1txxMYVq?=
 =?us-ascii?Q?PgjU29vd3aFlrVCOmUQBuO8Fl6AfKOMCimV9ySd8NHaAFbGFoG1Ypp5ZirCy?=
 =?us-ascii?Q?Opmr+FNmneaSKsiYqTMNxzJHuqm/WvIUcDW06muEuxumZOTyz1jjcwIew2ab?=
 =?us-ascii?Q?adMBivmS+gTdt818of5XYl1uYRLGCLHNVAPdkyYiuHmdj9/P61PJS5zug+NC?=
 =?us-ascii?Q?F/WOQij8iph+a/YxFYzeHYBzGg0NCwPUlKSLaSPYemD9cNSRH0LTTJvhScUs?=
 =?us-ascii?Q?KAFjvtOv/vKR63gZ8JowVAUGg7bzpFegr6X+ILdriehVWnrtjJq3OYveFFdZ?=
 =?us-ascii?Q?jPJF8bsZ8H8BhiByHapCcVYUJ1hgWl8uBr6OtFtx3d4aaOWhEVTVVB1nqsdJ?=
 =?us-ascii?Q?p5P1TS0YaTsIcnT0T8aqhSlVd2L5a4n7PiSWgUdugC2W/LRPag6yX9mv2eai?=
 =?us-ascii?Q?PQGafTnZvsDLM/d4qjtvdoU0xO/TuOI8xmY1gRAbTVU2JJalUd9cI99fX1Xe?=
 =?us-ascii?Q?WsSdXK5oA3hZAH5V/73XddckLamYjD2/NTgydyeRqGzFE5j2bol+2C4Tq5CT?=
 =?us-ascii?Q?DVwtJuTgleFzJTntBXL4SR75t4+ht/moQAsO75812Sty6WCjQjb7AN/766/R?=
 =?us-ascii?Q?p3yI69ENGK/WH3uiSpqgP9TIHZ6Zd9VnSPmpICcvILXrCjDYaqRASJq5tbyV?=
 =?us-ascii?Q?Yw6rPDEcR6jG3C9W2Vl18M88iS9KgLEFwYgOPXiSHTj6scQOQF/8ZXW8wSBQ?=
 =?us-ascii?Q?AsydEG4CYtul9KK0VtVTSydZDFT77DvJLRqxMofkPk8xpho8CFYOQZuiIMzj?=
 =?us-ascii?Q?X7XQuA6dLJ8cYD81ikcnvpOVT5n+TVl9VVPB/k4AbnMJN9TNQ1MdUZOJS+xp?=
 =?us-ascii?Q?Okf7RP9yrXPTQR/wPpA+Wpf3Kw7LA2zL2II98brzRxGynMdBanIwhZsibNSp?=
 =?us-ascii?Q?W/H1sxt1Lp7eqq7ezK16v2bjy9jB4O6/Rth8hhnSQmmV2zIGtXNC72qjk2Je?=
 =?us-ascii?Q?FydXcsz7vorwqS442EtbSWkKtK2W80H5i+X1T0NVyPJbwJkqDSUbJ4GKb1iW?=
 =?us-ascii?Q?FNslB2a2O8NcCB0vWSA21pBTS+67AU70cf4EqwPppNB7ysbdU9JP/ltj7OTZ?=
 =?us-ascii?Q?+yR/AwHuAMVPsSsk0elOMSNTmmpU+C2F3I1gIhms6CTCmPB65d7pTYGcTvqX?=
 =?us-ascii?Q?Y/bjQyIEaavzjCEsckpM9Eg/28Dzvdis?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6n+8d1RdfeQdIJQG3i8I86sga1QeYgVZbz1SkA6KEZKO4bcgtXj2vUYDeLIb?=
 =?us-ascii?Q?xVqtENQThqQx1Jxd7sIALOZDfxPZ8AYZdf5UmD78rAULQ2txIdAXctTcQQvF?=
 =?us-ascii?Q?kkJ43qQBmrO1BgR/NuLqVNbeadhs20cFrUQubARIL4T5BwPJMI/fj8VemeAo?=
 =?us-ascii?Q?jgC67TY/1odQqMn+cEek/02hI0kssw8Sb0UJ1mUx0xKDS7xjA7CSIxw494wH?=
 =?us-ascii?Q?MPRw3dfDTL88BybsavSVqrtQZJ1QVsvhozeadOSB8/EyaUQ5c/oOmRFJG40N?=
 =?us-ascii?Q?gNrdNXnR6tapC9SepBFJYxi1WrLDaC/sq02kWjbUHX7tCF+A3g2ePtK99UaP?=
 =?us-ascii?Q?4IJLBQmgzh5KR3yHoP7sG9tHgGzHsZ4DpQZvjboX58PMFtfEqrf6tTs/A5F7?=
 =?us-ascii?Q?EY+N/YwbnldItJFijDvIcWmaw4kU8cLES7zcFq6k2kcqxRG59feYzyaVp/mm?=
 =?us-ascii?Q?o7AUVo4wCzOPTG59AiDXLsP3jBcV4KCuUkKLUodnMKIeIsX/pXvwCzPcCcdR?=
 =?us-ascii?Q?P2Hz7GixRSuPDlJPvFqox8oRA9MJMGBPTjMszdx9+dy5CaNi++/X7Jy6U3oN?=
 =?us-ascii?Q?l8RPQMiE1yU9hFMH95fGrOb8pprparXUYfykxVQWk71pjIXO3L7WQUJwC3Ee?=
 =?us-ascii?Q?bmujD7g8hPBfB32Twf6Jv75i1dhZhCg/Y7Ooh6GOJLAIdhKHLX1/MFhoKi6g?=
 =?us-ascii?Q?Hz3fP54xOhZiLnWHQAgcy1lBknxYzoKGHck7jfOa6dmeAajFX15THcN5oBfc?=
 =?us-ascii?Q?0wT8Dqn9nUirBfd6RFbtpcdeZexbgI8iPDWel2ocBs/UTewxB6Qgi9De/lSs?=
 =?us-ascii?Q?k2Rup7tUNnFt6UxVPr+VhuZn/qAZRJ6/dhc/HKRUSD/8kZdEv00euZhEgwKO?=
 =?us-ascii?Q?tPhRtuj/0PzPoFrLE1iFOlvZVnYSjqkA7MVLeD84+oo7TFAXrjqfrz6rh5nz?=
 =?us-ascii?Q?9K0fnqVVgrsFkjzmXJ6Djp8TZFtTtvySPcpHgFVXT/ghBkM6Tqy9l+k2PbAz?=
 =?us-ascii?Q?l175ssFrsRxUZZbHSXVWBDRam3XVnEgDSXu9mebdLh7gQFm116afCYfQ32jx?=
 =?us-ascii?Q?42OW6tR8J3fGXKDMjqXn98uz63A2r32oHkKFfpZVwhmBIldot2RkEia0NxBL?=
 =?us-ascii?Q?Cfgzgj+1Mw8LaRzf21HWBHYFEtinn6bU/uPnM+MqoItKsWWus/Ko4bcaQ4P6?=
 =?us-ascii?Q?xb28uY8uVKWrUhZ52v81myDhH1TXZtDpebpeLlRc/hhSJH0GAYYUdhVtB7GE?=
 =?us-ascii?Q?3sCQ0tbnWbIOqrofv+8qyao1pZFP6WsDyFgarNooRSwvgXm8eZ2bpri50VQm?=
 =?us-ascii?Q?0Hng0TegbXTv+XcCLJO+/eeF7EqLF+BhnPdxBvQhSL5D+zcbTaNAyqkqjDMT?=
 =?us-ascii?Q?sSb7WRQPJ4i4k6xRdOm4U1U8Cun6gLkJiZ+DgUgbqclBjwOrwRXpRoeM4y5H?=
 =?us-ascii?Q?8gmY0JOpWQKO5DyQsbNP2hmrIqDPn+hw0ifBnTgGGLWQqjp82yr9cc9MsNXR?=
 =?us-ascii?Q?/1d5IqEheidvp2uqHjHl9WN6AOYYHYVafV3q4VRNZCVyacpl6W3P9eRZnWC1?=
 =?us-ascii?Q?fkYZCDyTuPopfUvy0PPRnO5EDA1l7MkAUm7dK8Ys?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5971c59c-5b9e-4ae4-6b5f-08de0cfa9948
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 21:25:58.8163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ll0u94U7jHFsHUu/tljJLS08k905c4gBA3LiJe5dFV7zxcA+Qfho//JL1cb5ERLDIXoqsrB0jrckilWMwpxEbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9082
X-OriginatorOrg: intel.com

On Thu, Oct 16, 2025 at 09:46:48AM -0500, Jonathan Perry wrote:
> Motivation: perf support enables measuring cache occupancy and memory 
> bandwidth metrics on hrtimer (high resolution timer) interrupts via eBPF.
> Compared with polling from userspace, hrtimer-based reads remove 
> scheduling jitter and context switch overhead. Further, PMU reads can be 
> parallel, since the PMU read path need not lock resctrl's rdtgroup_mutex.
> Parallelization and reduced jitter enable more accurate snapshots of
> cache occupancy and memory bandwidth. [1] has more details on the 
> motivation and design.

This parallel read without rdtgroup_mutex looks worrying.

The h/w counters have limited width (24-bits on older Intel CPUs,
32-bits on AMD and Intel >= Icelake). So resctrl takes the raw
value and in get_corrected_val() figures the increment since the
previous read of the MSR to figure out how much to add to the
running per-RMID count of "chunks".

That's all inherently full of races. If perf does this at the
same time that resctrl does, then things will be corrupted
sooner or later.

You might fix it with a per-RMID spinlock in "struct arch_mbm_state"?

-Tony

