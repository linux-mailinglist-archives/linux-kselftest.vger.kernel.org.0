Return-Path: <linux-kselftest+bounces-46337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE70C7DAA7
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 02:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7B3813517FC
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 01:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95AE1C7012;
	Sun, 23 Nov 2025 01:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ST4jWuBc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EA11A9F90;
	Sun, 23 Nov 2025 01:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763863157; cv=fail; b=tDSg/ZZZ+/7WaxKKZl2MVJpaRNLoNlsCVpzC3C8vo3u57mh1H01yS4hf0tPcdUv2YoEIKHHCHkIxACcM+bQV6uWoRATIMgDsQWsMZLdmIUG3c1ky47MygqBjpX7sg+7X3lNo3O0dVSEc5AvEBzRmrMiwC4P1pePV6F1HcXJudTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763863157; c=relaxed/simple;
	bh=ctyp8v+cRd0KiGjpgjQ1K7vuUVAqVs6dOX/Vjdfj/N8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FWnBSA6Afnj6ImPqJ305G5KQxIyT9zGUwQ5J5Bm9y4qopqJlQMI0UgODxGPYYucqbyS7DVKElu2z/2NfU/6WFs3FycV0uqd6pqmRUrxPoQxh96+rOpE101Z8SygNvBNpKMsBtpAdjWkvkddzHDT76X6V1lupAuEDlJXwKOMTH/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ST4jWuBc; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763863156; x=1795399156;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=ctyp8v+cRd0KiGjpgjQ1K7vuUVAqVs6dOX/Vjdfj/N8=;
  b=ST4jWuBc1HxfmagBfajly53cRGsEi33IA1FoC5jAZaFTUJUrh75QpY9a
   eDIwbYy3N16yz3UcmgPxTvwTR2tlgIguguUbZj49gzy8vNawOkwBisNN8
   RAyc6iYgMW6oA9TonYpkGmDBJJTFc9zZk7H86jdziZ8JqasT9jDG+FROg
   W2Un9u0NUKHeEhlfuBIVvvKMVC8RIUwDhra6aE6W+YHA3up/Igg6GnTqL
   HwwxN2sLQYRRc7CXuvvTIKlzrXsLXkhUzybGwvzBiT8d0VdsMP4fUiUA3
   YBuZU5Hu6nS3UyHurPokLjPyVI7WPtKfUwkwfuf1Ba2nPc07eqMw29oGA
   w==;
X-CSE-ConnectionGUID: 1H9IUmUqRmqz9OzdtwlEQQ==
X-CSE-MsgGUID: 5er/YwiqQEu/H5sP5NCceQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11621"; a="77272551"
X-IronPort-AV: E=Sophos;i="6.20,219,1758610800"; 
   d="scan'208";a="77272551"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2025 17:59:16 -0800
X-CSE-ConnectionGUID: 9uMosf5lQzq/7FkUSLwadg==
X-CSE-MsgGUID: orhwSbk0TQ2LLxqGAEyCnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,219,1758610800"; 
   d="scan'208";a="192123020"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2025 17:59:15 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 22 Nov 2025 17:59:14 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sat, 22 Nov 2025 17:59:14 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.27) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 22 Nov 2025 17:59:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WB3+8tDkdQqQxSleIbWGkMACgNWmSwq8NORY36ziQRUDNkCy/QZDlsogckVnffyHo6ZkU5euI+5ALWozFFehhzd8+K1jDBJppsrzQPKk1oSNTRp3ZlggR2id/JP7H4GrhbMrFeLp5vPWVltpYzTR+flqQwKGrodN3pdz+ddJ8d6m0rqUMd31nWDOpvlacQChskKW0uOHSQhwH+sbsPQJ6xZV3znb8mjwYWiPy6gJ3ioeAJmySis1fxjAyvsGa0ocWWNRRlzQAlnm4lnLxdZOzgEUefERodPC92RUbL64zMYkb1a4j83UkB1GyzxNcSxj9GNiz1gTbmHVhZXcp6XIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0UEyr4A+rSU9xEjcQxLCpu1scZjFBR2mw74/5UxMDk=;
 b=EAASWUgeOueaszaW/P021Ysc0GRYRbbc2G5ZWKexdIXWIIlySdrMgl9RlOSmyd2RwNr8nhshqDSO5TRBGq00wr2ZjDvafvlTM7Bbce2m3LK0NENpehjjXU3NtBJji7J8Bb+fFTcEuB9aLyeXkA9/dS8hzGMlkTe/cpirRlEl1g42tCa0gPhRWznAPSuvrsLCwV9p4YZjblo7kolvrPW++AB+VLj9kc5oMe9q1z2KNuoJfdtSqhgDNEahWYEPXZAP1zdTKQUFm9PQWY/hxX5WFBUJBUBQV1jhaDhYvw4FsWTiQwuw6MDXFV0T0DXPwzVGrM6WHVA+ixnIrccRLdB6fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH0PR11MB5111.namprd11.prod.outlook.com (2603:10b6:510:3c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Sun, 23 Nov
 2025 01:59:12 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9343.011; Sun, 23 Nov 2025
 01:59:11 +0000
Date: Sun, 23 Nov 2025 09:59:00 +0800
From: kernel test robot <lkp@intel.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
CC: <oe-kbuild-all@lists.linux.dev>, Alex Mastro <amastro@fb.com>, "David
 Matlack" <dmatlack@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke
	<jrhilke@google.com>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Raghavendra Rao Ananta
	<rananta@google.com>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v3 11/18] vfio: selftests: Move IOMMU library code into
 iommu.c
Message-ID: <aSJqZHkMSS5mvmgR@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251121181429.1421717-12-dmatlack@google.com>
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB5963:EE_|PH0PR11MB5111:EE_
X-MS-Office365-Filtering-Correlation-Id: d3866464-bf94-4b6a-b38a-08de2a33e586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GcVl9Wdpnm1hHSmivU/o1L0VBnJB4xgQlbEIs8JketK9gReaAylKXkxT71SI?=
 =?us-ascii?Q?buELLNnUVc/1ECAi2PJNwMS52i9Rcr+9N1dV8m4ru/GPw/TcQduJrBMYLZWu?=
 =?us-ascii?Q?nnGBn4QGv6ybXJo6v1MaM/U/fdhnf54+ldOyPFN5yFz+GhobYsJFRz6SKFBu?=
 =?us-ascii?Q?OKSuLWUjqzSC2A/sgShaTc79b+eWk7UG6W57iueztZO2BnGpGsVtnfMG6SUU?=
 =?us-ascii?Q?v6O+X0nmxTo4xrR4IZM2hy5uvtr1ag23sjrlz+G9PDJZVReXSpKzA1IthaDN?=
 =?us-ascii?Q?Z2wNfdINhn0UabqTM/71YXxW/VmsHqGBjIxP+I9/VTDgfRUzp3LTdv1JOd3y?=
 =?us-ascii?Q?ZCZm0SdqDW9hGf/d2OIdVZ+nBphLw3SOwpp4zGSUBa1dok2BBoSoBukABsY9?=
 =?us-ascii?Q?dBic6BHoBMTO13lWvOZM6NQ7r80sTqnHY9HiCX/SoMfL+zUXhqAFq+IhBisP?=
 =?us-ascii?Q?gNBTeyP+SD7uWDyVNwSbzEbFvo1hkIT96FD+A64KjuFW3lA5GRhIFrNesIHU?=
 =?us-ascii?Q?KFbvzi8AI110YC1puTzBrVDiyAKjRPbqLPIZbQnmytJYFJzFfSpC//f/WUZO?=
 =?us-ascii?Q?uXECeQJZNTgC/v3eU2b7NxZMsNbW9mXiQxjMD2lIIQ/LCR9kEooGy1+T7Br4?=
 =?us-ascii?Q?5lovqtjYBf2o5AnS5yJ9CeOMy74O5NRfppygN9Tanryt+E3FshY6qTm0kw6V?=
 =?us-ascii?Q?WzrwSYCqxbaHLhDO8f2Jxrlgo5JIlrZqyZ0PakYb12ezjD5uvJL7OQUuZjaJ?=
 =?us-ascii?Q?UY/Qklv9w2RCS7p7H6L1XpGZaUyEXIQO1XOvIZkhuGrWZKA2zCgU7C4QyDPl?=
 =?us-ascii?Q?sYBcJgwljOh1L9aNDAq1ZYB4xq9prchzcrjyqnh8XBJjCLxekz6tMosLAOYB?=
 =?us-ascii?Q?c1iATy3tZjeV1S8y0Vcz3qhmtY7PUYK6iVnzppJ5uVfDGXhX1iJjlPghrp7f?=
 =?us-ascii?Q?OMyeLlqJ6CaeoIMd86j0oZ3tG+p0QpoO41/gOMMSfnXrKmuhwTjnv1Sik7lT?=
 =?us-ascii?Q?MstYB/BAK+ZJbcK2se/ajK8qu5ovNsqLOuca7qjdKpN2cVZvlhUM+vG14Eup?=
 =?us-ascii?Q?TMlTHx3w5JMmQZS952Opdf+AlSVwhzM0SBeDLg+u6ItNto9eG67e8OoQGW4A?=
 =?us-ascii?Q?I+5lPFg1LcMC3l7mMvUwrqBO7xaR2o9U9/abGSMpBgBCAXSt7wbPuGTzSLtj?=
 =?us-ascii?Q?gFBl8mPljOm6Ed9v/XPlzRqQt/+kWcWRIxuKQwQnyPDNdMrlHrYX2H89C7+x?=
 =?us-ascii?Q?Dq0EIub8plZ4CpxVkeS+V7hb4ZC+9NPhwfqbhb9V8oG1RnjgwkNBGIAanHcQ?=
 =?us-ascii?Q?DhNmGU8I5ZoKrx+LKrCfJnXkcBEJlRIAOaln7YcQzgp+H1g5goo8jD56drZe?=
 =?us-ascii?Q?WqU35OsCmj7qCgBoFYBuc+rZHKuG+xsz8r5e0iBQ/Kj13LAc5Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7piTE66CgqvfeIC5sp+5dluEQdyJ38YQm60f73pgbPyigvZKQ49tP4aphe40?=
 =?us-ascii?Q?pBsSSMyLHo/raUteQ801cgXxqLIf9eXBrKfSFLcgDrVUtx2jZ3eUuakOSTbu?=
 =?us-ascii?Q?VtfG5Lvm2qojZPXqkOu+iEVUOc4aacv3jqigro38KQ8GPn69rULX7hZcsHkx?=
 =?us-ascii?Q?EFlsmee1vPlgG6uTeDtlq7goTjg31W1NPUEd4oX4zke2GJxkav/ttIa8Vveu?=
 =?us-ascii?Q?CJQ1AyTfEav2/vfv+KKjR+LAKcK4lclbPMPn9ykTM9t6nenQz0ZZTDkw4746?=
 =?us-ascii?Q?j9xdYYJQo5nS8iKIAuTqclA6T1gFGW9VoZLkAnp9BQkyi8tBzRDjw1k3dWsE?=
 =?us-ascii?Q?4Ac0L8X74wGL8kKhNqZB221mt6MkKyJoqBBj4rrL3BweYO7rjlC0gypbQE3l?=
 =?us-ascii?Q?wEnGvok/gSGKzGbTahN/ATAaT3fjD1LsvPJ9kZyMDGICMq5aCsTwtleLM58M?=
 =?us-ascii?Q?D1c1+9SiF2l3a+nef/Ae6rytmPxG9yNAtcmE80DE9pjr0BaNOizasMZUjmkh?=
 =?us-ascii?Q?4LyeFA4zqf7ajy8vieKf+7O6ts9ALkMO3+EcgcbQwsZIf4bOyvZ2B0yPLCOt?=
 =?us-ascii?Q?aRCeyX8wVNkvqyAcOEVfwARJ0XrvV9NfrPBPbjMtiShNcTYqZdPMHrq6CxSg?=
 =?us-ascii?Q?PXlImSOoTAy9I4at6H30DYVRH5Or7jfGsRIR8lym9uI1CQdk31ykdu16uHmN?=
 =?us-ascii?Q?Wp4wigzbVwRhn7e5fqdh2upGkpoMU3gk2PjQHLsGw7TsJR9kn7LjNjawkI4w?=
 =?us-ascii?Q?cW8gNdNdO2xZzTWQRO1Bgon8OIfTOCdlN9XR5DG3iNSUlk3GCKH7O01qqz59?=
 =?us-ascii?Q?RkqxWyp09QkLm7yGXsmJU6a5DKl4OePmCLjdWhhFsfJdK6gHHPnZpqmPpoKa?=
 =?us-ascii?Q?Py7Pr1Z2JObsRJtgtbur5DmhsAhTkF6FoldIVmvYeS0ZhJkdik7HYvznhoTj?=
 =?us-ascii?Q?3mfRJYyKEzXZt7uN/pG+gt29Fyes69GwHjaE+ly4nUQc3xWeaSmqlAX8zBLD?=
 =?us-ascii?Q?gVLRKMaUh8WRIxXpQR9GJZMvoIidGY9cruJF9ySzDn5nO7gnwS66Rm1nTKGu?=
 =?us-ascii?Q?sGtUYGtX8221QY0v85VMTPsmQjkea8V+bSQ61UNKy94973DAOQcV7yga+094?=
 =?us-ascii?Q?pG6NLfBzlSsLV7BDLyZYu7rO4l3ScRZD/Fyh1ulYAK7MHDkqEH4Rf85wdRxf?=
 =?us-ascii?Q?h1+8b1CrtZIgvsNImIYBfRdXO0pghAtbTbHcENgdf1U5E6W6BiBLdvG2pDMU?=
 =?us-ascii?Q?jUb66GnWDRbq2YrMQ1vjLhyjj1aF8aG1Xxj1ExBrA3DmwgPL762XViGfRI6K?=
 =?us-ascii?Q?18W15EKcy4nnN4NbSUbCVS83BNaaqAKuayqx1i5Kd9qUb1Oibxo/6ovGAoAo?=
 =?us-ascii?Q?21uv63B6lXu+gNIn8qpLbIYUAjAcP3NV6MukSBHd0ZXs3h5ybfBI/TtAkKcz?=
 =?us-ascii?Q?1iucbc2BrWJeQoMJm7e4xYhDnJWAAaaydC061ndAAsx3MkCQcHzGKP+Ar+Fn?=
 =?us-ascii?Q?6ffyG2tkXCOd/R3iyoN9es3s8y8YBDQCs7JgaEj7O0vEqvfKl91kXtLEooE/?=
 =?us-ascii?Q?KB2NV26qZU1t9TKjdGcZcpldLu0xoIMf47x/WSVXNQuVHcB7e6gO/La2JCtf?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3866464-bf94-4b6a-b38a-08de2a33e586
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 01:59:11.8785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 62FGAPRQHv6SC+xXwQU/7xjlgxsnW09sgqGvEtve4ZP/qZV+2rFQrQ8eJKQOik9qxi/6G01vBuOezSLmSbvdYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5111
X-OriginatorOrg: intel.com

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on fa804aa4ac1b091ef2ec2981f08a1c28aaeba8e7]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Matlack/vfio-selftests-Move-run-sh-into-scripts-directory/20251122-022109
base:   fa804aa4ac1b091ef2ec2981f08a1c28aaeba8e7
patch link:    https://lore.kernel.org/r/20251121181429.1421717-12-dmatlack%40google.com
patch subject: [PATCH v3 11/18] vfio: selftests: Move IOMMU library code into iommu.c
config: riscv-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20251123/202511230037.0t3o9ByZ-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251123/202511230037.0t3o9ByZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202511230037.0t3o9ByZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> tools/testing/selftests/vfio/lib/iommu.c:2:10: fatal error: dirent.h: No such file or directory
       2 | #include <dirent.h>
         |          ^~~~~~~~~~
   compilation terminated.


vim +2 tools/testing/selftests/vfio/lib/iommu.c

4391647129942c David Matlack 2025-11-21 @2  #include <dirent.h>
4391647129942c David Matlack 2025-11-21  3  #include <fcntl.h>
4391647129942c David Matlack 2025-11-21  4  #include <libgen.h>
4391647129942c David Matlack 2025-11-21  5  #include <stdint.h>
4391647129942c David Matlack 2025-11-21  6  #include <stdlib.h>
4391647129942c David Matlack 2025-11-21  7  #include <string.h>
4391647129942c David Matlack 2025-11-21  8  #include <unistd.h>
4391647129942c David Matlack 2025-11-21  9  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


