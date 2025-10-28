Return-Path: <linux-kselftest+bounces-44168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCDBC129C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 03:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846F45813FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 01:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B692652A4;
	Tue, 28 Oct 2025 01:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="au9vA5YJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CD924169F
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 01:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761616785; cv=fail; b=hzFm6iMf6te/EdGv4s13YzIqosm1rRRHPS5l68I/h1Q+MmMhr9p2IcygyMSgbhEzyQjEVETbmrvXkUJ4Fq8TT6Bi07qmMQl5/hh6cpRLO6a3hVSY18LF9p+6ysZm5Y4hSLMB3F53QLrOt05w9ofDnZiCHIdpJlVTfkQzr8hBveQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761616785; c=relaxed/simple;
	bh=Wz6tBoHotMKlUtHcp6a1sQnIFihIOb/RxwXY2+FZcFg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NyX3vM6RiuX95MYcLaYhjDux37WfXPUQCfwuZKnCYYptxo+ED/6jItblu/32ONGpIVCgccEdlHGB1BenPIGzleoHVCZ4A5Cfqv+zvqGd75T+2A7/3/kAfueKcRvvD4N1UmcNdL1Y9euC9MKCU9kVlsE9dC+r7vhjNxz+fleLVpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=au9vA5YJ; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761616783; x=1793152783;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Wz6tBoHotMKlUtHcp6a1sQnIFihIOb/RxwXY2+FZcFg=;
  b=au9vA5YJZyQRTY1jrND8pI/JEA534bBlMeMpGRB7x+zJnhzJXNkP30Hx
   U/2c8QIRdn64b9YhmApYKJ0dAnEfBI/qbOC7TVWr61N3Djmio3JEWOt9w
   F/ouc8ZAHj6/vnYqWr8jhcRk9hqE7gm56T34Y7rcdhpete7f0hwBafYH6
   YBis1kFZXCPxvpjHXmatolFZmsoguKMyfpH63uLS71FZO0+tTlE9IXb81
   TEAQKUII/horQGjSDgu56Gk+6m6f5CkrULNu0Dn9Zs2Eggw9fX0CT4QlX
   a3410KFeHqjbhWfDnnwgJYGu/KqkKW2zy1NVWZ0/BRcUqDOP8IHHjWyro
   w==;
X-CSE-ConnectionGUID: Dswta7IoRz660OC76VCX5Q==
X-CSE-MsgGUID: lCm1AoSuQdGEX6xT9ME76g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63634904"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63634904"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 18:59:43 -0700
X-CSE-ConnectionGUID: 9fOMfzb8S0aUyfqNYrfLYQ==
X-CSE-MsgGUID: WRoFXTLfRZWmSgLHfUA5Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="189265186"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 18:59:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 18:59:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 18:59:41 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.39) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 18:59:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZNKrLvstuKmxe+ynwnj9SEdFY/GhLydq7bxQG9w4+xro/8v75NtRqt4WSpeJAk5ZU99LcftvOe7v7rpvYbcGUaOBQ5XJ6b1CbIZ99arZy3WG4ALxTPWU7DvCfVVtG9zTru6opf8h9WV+Lbs3X5kZACBXHRuvCecVE8J9aZVwEHbq0WrrntuCxnFPG2aMFmpCywZLKcpKtBa2hrzDdqED6KSTO9IU+P5x6ovW42GpNgeTU/LFkA9asyT2GcqJ5EZmp7b2DZ4h7M7SGZ8EHVBUJxwLxRiaoCnFPUzqRspF79Bfwniy5mb8Ow0ajRLpRdbERUuJVylOa6nJEjPk/1n4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qd+bgrWOho5PGMdm5ulwvYNI9Sq5lUVnR6I1w3m5qI=;
 b=sC4+r3PSGSnAKkwYpQfKj41lfQu83Ibb+nj3ew6u+E0Mqox3c+FVgjE4tSOgpbd9v2gfB5k+Jp2HAa1IV6u5hTACErPn4Ixq5erQD5Z4wpEP537CG+2B06q2d83zGmjhvF1y2cVASwTToqHQwHfKmIF017MsLYGwXtrky6Ksx76XrLFKOLzaF1urW4XtnovRK0kiOPKIcO1S71qGnp6s3YkUIV6EzpPeNZJxZU5Rj2Oye1n4J44Ar/Ongt6FN+gNWZ6BEjVIdmjSeQRhP/K4VZu/z8XIEeDeR1ik5r/G4A9hwIWzNbXEWpKWwU39Dp8OY8itsd6lACjkwB2Vk8CkEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by PH7PR11MB5864.namprd11.prod.outlook.com (2603:10b6:510:136::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 01:59:39 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9253.011; Tue, 28 Oct 2025
 01:59:39 +0000
Date: Tue, 28 Oct 2025 09:59:29 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, Shuah Khan
	<skhan@linuxfoundation.org>
CC: <oe-kbuild-all@lists.linux.dev>, Kuniyuki Iwashima <kuniyu@google.com>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests: harness: Support KCOV.
Message-ID: <aQAjgRwd8P+YZSa6@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251017084022.3721950-1-kuniyu@google.com>
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|PH7PR11MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f63c08-a2ab-4d7c-e121-08de15c5a609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7LbOjpjLEa+BsJCr7RCBs7G9z2IRR+X42A10xd6zR0C2LoE2zJhaqsSbbYSZ?=
 =?us-ascii?Q?/rcUGzfx6dzPNVGC0HJOPgRDl3QDxSzk4BkuBoGMJ3VIcpAG2qv9/47OgTnh?=
 =?us-ascii?Q?E0E4g7TSN9HSkXNypH1gz9eTHX7giNqmK/Sl26GRmOOA2aYG4dudqEgbK5EP?=
 =?us-ascii?Q?hYMmJXGaewAI4evhbctI2xz5Uq5qaXyUozV5Hh4PhPmj1/H6sfZcJ/cVox0H?=
 =?us-ascii?Q?dnQVBj5C28x/FGsurUv8pd8f+mWLDHaSjtgyomEHCLhcnQaHtL9sMWP0hyae?=
 =?us-ascii?Q?7xHq/MioICCd1jg1gJ/eYEAYwqJbbeoqVOTYc4C9/U2s2bI3CBwlNw2728FB?=
 =?us-ascii?Q?NzyLXe6LxQSd8uQyISHQEklurgAb48aA/SGF67SreGa0VT3A98doX3rOrOSt?=
 =?us-ascii?Q?tmBMOJn/GPKaOaczblbhzYsS5XxHplovi/5m7NwoyKaBYiI7CKRzyHDL+jfl?=
 =?us-ascii?Q?bcwyj6v6fRTe5GXvCMCMMQrWrp+691+ve9/xLGbl+zKUTVk6RkzBauVwFeCl?=
 =?us-ascii?Q?QevQP8pfFa+NzkUYrsec/ioq4cpkVzlz0cNfAeGAhJQz5n51f9sefCvbj3Cx?=
 =?us-ascii?Q?9y7ja+BNuoy1hOGHXQkFRDhuuH9QbDFrItAg2PFpB+gH2FVSW6+Khr8E4nZH?=
 =?us-ascii?Q?GSTTLWYlzenrie0iI/+6a3pYGcONne5QSK2Oyx+Da7ei/Z4taZzzORSJ7R+9?=
 =?us-ascii?Q?fffdmAB8Oou3E24LSaB25mlEmJiRIIplkJiNesUXeuhgdWrOD5zqpkIRWk5c?=
 =?us-ascii?Q?D6+DZK+g3LnRGWAznQ9SCJcUn2lRM8GB/BwdtiHv+5epMuX6dKOAOW8f9RFB?=
 =?us-ascii?Q?cSexn5qRd/T7JdYMUlB8aV6BnV3HHDoQuLq35x94kkXRdKTPva/s6gWEGsJl?=
 =?us-ascii?Q?kQF6Yz2LRcIW9222c7AL4RGYYItitr9Dy8i4sFauQYlascYl1yAbV8tAsVX0?=
 =?us-ascii?Q?Eumzwi4+Y70ZgYgVMHKcr+gHzb6ZZzdI+BvleIJeoLUDRnnYtZQxNVYTjyUU?=
 =?us-ascii?Q?CZBkn5ieomMBxrXr3Cd5c7SO5iaZz21KeDyyNifJIKcvb+ajvyd05LK0Y+06?=
 =?us-ascii?Q?vlp3ZO74Po2fP0nt3bN9ug9mHJD9fBBquxqhqr2dzEOsyxihvJQQo9fqP1W8?=
 =?us-ascii?Q?aCX3thNzgKvh+99E0ZGl2ZZuvLYqTo4WlOxmkDwF2BzRfQ2PKbnQX43IL1up?=
 =?us-ascii?Q?AsJOHYrKJK+L2m3gVIkBI6KDgfdIutaixE2j1LKJ5ATTk0RYNWuSST9l8xF0?=
 =?us-ascii?Q?VN05S9wnwrRtw5uU/H3z2X5nT3t9+iytq2xF+nFbwTnHVw5oW00FX8VBXDHa?=
 =?us-ascii?Q?YjwCuCYZQ+3FGI30yZWF7bBJIvjN5P8MPF1nc2z44F+7Ei716x4klLaKiOtK?=
 =?us-ascii?Q?mGsxv9+f+0jLFV/GKx6mswrlR6mKFO2GwnbuPckjA80g5K9Vxs7O1HF1XxBZ?=
 =?us-ascii?Q?886CV1rA0dE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BuHaaflhnfmJvCAAYzJhHT4rrSP6Ur1dojxoWJa9daHlesvVuwkTiWLALPjX?=
 =?us-ascii?Q?6RyyYSsmRIcrIaK8JTmwtSUF8Ew7vBt2FwWY2cCwWyuCv6BDG9BsItvZcNy9?=
 =?us-ascii?Q?NE/M7Z/jMyvdXuJ8XREkQQm24Yh2gIRRaOlGpn+Sbs9AlxXugAV+In+o/JDH?=
 =?us-ascii?Q?Rn807m1BGihpff4e6QZKbvUF3uWF2LcuVVUEgdYFXdzQbUDgblyb545jA3qd?=
 =?us-ascii?Q?NB2i2IJ33pTqt8I+/P4d+SyrhwBiZXZygWXF8s1+M7Cem7wVMV2rzKDrVIef?=
 =?us-ascii?Q?/dlm2gD+8u8TwFZzjsRK573AM/mj2Lvf6cbNxb0zDs5SeyNKLYyGkQTQL33O?=
 =?us-ascii?Q?352luZzzGmy9Bohjjudw9UnrzanjBC7POXfeCSBgFgT+/oSxz4O2/wi3UJNc?=
 =?us-ascii?Q?kkE+egRcM3bk7C99lg2ShjQiR+SBWVtJ6CjoOY24NMdL2BPbddCBWCM/Cgak?=
 =?us-ascii?Q?BkLvL419YM6mFNkDs8RlTw/JLUnRdkXcTIrMQGMibASGbNvxrkxhs2oj6O93?=
 =?us-ascii?Q?FpbKtAUXCSMtySzDwWvCT/gQ6pdFMc2LdVcf5PgRVZg9HmDXJ3bZcnlbia0W?=
 =?us-ascii?Q?8dVZpFVb5mvbTClvVJFhtmS939l7yJqLe3yOPPK8+a2iYTYIRgN+E10K5sRZ?=
 =?us-ascii?Q?73fbMtRf4dag21hpjhm3RVdNvIaSYMf56alOzPsBRa6lTOk/viIDqage4bos?=
 =?us-ascii?Q?h7sJ57l7gYib3QRacGjoxLfuXc/4ELvIfnsD4I1ZbO5gg3P+ikzqlHsdfhrV?=
 =?us-ascii?Q?LB/nvA8H5hJs+A66z97FOOqZJhMeLdxtwpN09S2nIJ24BGD7rs4uCvnyuVRb?=
 =?us-ascii?Q?3N0B307QIqka2erIcIRHU1xz9jZc7XF0epnSGBwET7S4mOQzW4rWv5rwpgyw?=
 =?us-ascii?Q?v+uVxoSTqbDmj+083nJ6FVBBVDeFGYLoHhS4qgCUEccm44Izv5gT9JhfCgPq?=
 =?us-ascii?Q?TUuiKFb/IPJ7sKASr4zXOolLtm5rTz9by/PdikkIlFkrCwhSdnS2XuSNsld2?=
 =?us-ascii?Q?eCKnSuht+Wj6ij/nR2fvgnduN/+oqGDSNvxyQ2GMcbTXPPucM9V/zzRmbGoX?=
 =?us-ascii?Q?3jEz9tFtXdPoJV58a+LGYJgZRP503w+rHF/1zy3renfvjpwufXqEJ694bCmw?=
 =?us-ascii?Q?b0oEr3lceExlP5XE8rzrBZiIiJFj6UAKAIsO80ttW7d4d79Gbnzo0+tB5bur?=
 =?us-ascii?Q?l5VPW09EexGWwQNCdxrjEUqXLcrZb++MgfFXgHihdacuS28sGUuk9teE4jc7?=
 =?us-ascii?Q?WZxh1aYF3bioF9prdPoxJmB7vrZscaRFcw7J2UpiuA25ozRK74klNEF3t4xQ?=
 =?us-ascii?Q?eNLGaHlslKMy4e6U6okA8hl7FWcT501LTyOyyPG/4FF0x5tUNzc2EaHMqujJ?=
 =?us-ascii?Q?kgh0OFpP+hBJQiZghsVoYX3sW9V35f7er7vZrv7y6IVkrfPTzTDjqkzPbgfC?=
 =?us-ascii?Q?ppP3lqRZZyOkFoXNurJzkpwoyE4uQkz54kJzE2Dwl4hHOJpA6sZU5YLNDy1/?=
 =?us-ascii?Q?3QxJATJU5qXfMCZMN2hhCSa9mxkUvAUXhxi4qVwkGTWFWUPF05AjsD0D+v9+?=
 =?us-ascii?Q?zFLvcksfp1uEt3hZI8ob5TSXqYhLsANXb1qUZK1D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f63c08-a2ab-4d7c-e121-08de15c5a609
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 01:59:39.4021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKTNiffRcOh339Vf9YOYvk2fwYdh7nbYNhkOrP3EMSMxSpOr7HT7rKcNYlkBYyx9VX08zDyCLYkJDJU8YHTpgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5864
X-OriginatorOrg: intel.com

Hi Kuniyuki,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on shuah-kselftest/fixes kees/for-next/seccomp linus/master v6.18-rc2 next-20251024]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/selftests-harness-Support-KCOV/20251017-164507
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20251017084022.3721950-1-kuniyu%40google.com
patch subject: [PATCH] selftests: harness: Support KCOV.
:::::: branch date: 9 days ago
:::::: commit date: 9 days ago
config: x86_64-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20251026/202510262116.jwyrgplV-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251026/202510262116.jwyrgplV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202510262116.jwyrgplV-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from listmount_test.c:14:
   ../../kselftest_harness.h:188:25: error: initialization of 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *, char *)' from incompatible pointer type 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *)' [-Wincompatible-pointer-types]
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   listmount_test.c:23:1: note: in expansion of macro 'TEST'
      23 | TEST(listmount_forward)
         | ^~~~
   ../../kselftest_harness.h:188:25: note: (near initialization for '_listmount_forward_object.fn')
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   listmount_test.c:23:1: note: in expansion of macro 'TEST'
      23 | TEST(listmount_forward)
         | ^~~~
   ../../kselftest_harness.h:188:25: error: initialization of 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *, char *)' from incompatible pointer type 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *)' [-Wincompatible-pointer-types]
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   listmount_test.c:45:1: note: in expansion of macro 'TEST'
      45 | TEST(listmount_backward)
         | ^~~~
   ../../kselftest_harness.h:188:25: note: (near initialization for '_listmount_backward_object.fn')
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   listmount_test.c:45:1: note: in expansion of macro 'TEST'
      45 | TEST(listmount_backward)
         | ^~~~
>> ../../kselftest_harness.h:1251:13: warning: 'disable_kcov' defined but not used [-Wunused-function]
    1251 | static void disable_kcov(struct __test_metadata *t, char *test_name)
         |             ^~~~~~~~~~~~
>> ../../kselftest_harness.h:1204:13: warning: 'enable_kcov' defined but not used [-Wunused-function]
    1204 | static void enable_kcov(struct __test_metadata *t)
         |             ^~~~~~~~~~~
--
   In file included from futex_wait_timeout.c:22:
   ../../kselftest_harness.h:188:25: error: initialization of 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *, char *)' from incompatible pointer type 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *)' [-Wincompatible-pointer-types]
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   futex_wait_timeout.c:82:1: note: in expansion of macro 'TEST'
      82 | TEST(wait_bitset)
         | ^~~~
   ../../kselftest_harness.h:188:25: note: (near initialization for '_wait_bitset_object.fn')
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   futex_wait_timeout.c:82:1: note: in expansion of macro 'TEST'
      82 | TEST(wait_bitset)
         | ^~~~
   ../../kselftest_harness.h:188:25: error: initialization of 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *, char *)' from incompatible pointer type 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *)' [-Wincompatible-pointer-types]
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   futex_wait_timeout.c:108:1: note: in expansion of macro 'TEST'
     108 | TEST(requeue_pi)
         | ^~~~
   ../../kselftest_harness.h:188:25: note: (near initialization for '_requeue_pi_object.fn')
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   futex_wait_timeout.c:108:1: note: in expansion of macro 'TEST'
     108 | TEST(requeue_pi)
         | ^~~~
   ../../kselftest_harness.h:188:25: error: initialization of 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *, char *)' from incompatible pointer type 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *)' [-Wincompatible-pointer-types]
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   futex_wait_timeout.c:128:1: note: in expansion of macro 'TEST'
     128 | TEST(lock_pi)
         | ^~~~
   ../../kselftest_harness.h:188:25: note: (near initialization for '_lock_pi_object.fn')
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   futex_wait_timeout.c:128:1: note: in expansion of macro 'TEST'
     128 | TEST(lock_pi)
         | ^~~~
   ../../kselftest_harness.h:188:25: error: initialization of 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *, char *)' from incompatible pointer type 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *)' [-Wincompatible-pointer-types]
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   futex_wait_timeout.c:162:1: note: in expansion of macro 'TEST'
     162 | TEST(waitv)
         | ^~~~
   ../../kselftest_harness.h:188:25: note: (near initialization for '_waitv_object.fn')
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   futex_wait_timeout.c:162:1: note: in expansion of macro 'TEST'
     162 | TEST(waitv)
         | ^~~~
>> ../../kselftest_harness.h:1251:13: warning: 'disable_kcov' defined but not used [-Wunused-function]
    1251 | static void disable_kcov(struct __test_metadata *t, char *test_name)
         |             ^~~~~~~~~~~~
>> ../../kselftest_harness.h:1204:13: warning: 'enable_kcov' defined but not used [-Wunused-function]
    1204 | static void enable_kcov(struct __test_metadata *t)
         |             ^~~~~~~~~~~
--
   In file included from futex_wait_wouldblock.c:27:
   ../../kselftest_harness.h:188:25: error: initialization of 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *, char *)' from incompatible pointer type 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *)' [-Wincompatible-pointer-types]
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   futex_wait_wouldblock.c:31:1: note: in expansion of macro 'TEST'
      31 | TEST(futex_wait_wouldblock)
         | ^~~~
   ../../kselftest_harness.h:188:25: note: (near initialization for '_futex_wait_wouldblock_object.fn')
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   futex_wait_wouldblock.c:31:1: note: in expansion of macro 'TEST'
      31 | TEST(futex_wait_wouldblock)
         | ^~~~
   ../../kselftest_harness.h:188:25: error: initialization of 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *, char *)' from incompatible pointer type 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *)' [-Wincompatible-pointer-types]
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   futex_wait_wouldblock.c:48:1: note: in expansion of macro 'TEST'
      48 | TEST(futex_waitv_wouldblock)
         | ^~~~
   ../../kselftest_harness.h:188:25: note: (near initialization for '_futex_waitv_wouldblock_object.fn')
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   futex_wait_wouldblock.c:48:1: note: in expansion of macro 'TEST'
      48 | TEST(futex_waitv_wouldblock)
         | ^~~~
>> ../../kselftest_harness.h:1251:13: warning: 'disable_kcov' defined but not used [-Wunused-function]
    1251 | static void disable_kcov(struct __test_metadata *t, char *test_name)
         |             ^~~~~~~~~~~~
>> ../../kselftest_harness.h:1204:13: warning: 'enable_kcov' defined but not used [-Wunused-function]
    1204 | static void enable_kcov(struct __test_metadata *t)
         |             ^~~~~~~~~~~
--
   In file included from futex_requeue_pi_signal_restart.c:30:
   ../../kselftest_harness.h:188:25: error: initialization of 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *, char *)' from incompatible pointer type 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *)' [-Wincompatible-pointer-types]
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   futex_requeue_pi_signal_restart.c:98:1: note: in expansion of macro 'TEST'
      98 | TEST(futex_requeue_pi_signal_restart)
         | ^~~~
   ../../kselftest_harness.h:188:25: note: (near initialization for '_futex_requeue_pi_signal_restart_object.fn')
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   futex_requeue_pi_signal_restart.c:98:1: note: in expansion of macro 'TEST'
      98 | TEST(futex_requeue_pi_signal_restart)
         | ^~~~
>> ../../kselftest_harness.h:1251:13: warning: 'disable_kcov' defined but not used [-Wunused-function]
    1251 | static void disable_kcov(struct __test_metadata *t, char *test_name)
         |             ^~~~~~~~~~~~
>> ../../kselftest_harness.h:1204:13: warning: 'enable_kcov' defined but not used [-Wunused-function]
    1204 | static void enable_kcov(struct __test_metadata *t)
         |             ^~~~~~~~~~~
--
   In file included from futex_requeue_pi_mismatched_ops.c:28:
   ../../kselftest_harness.h:188:25: error: initialization of 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *, char *)' from incompatible pointer type 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *)' [-Wincompatible-pointer-types]
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   futex_requeue_pi_mismatched_ops.c:44:1: note: in expansion of macro 'TEST'
      44 | TEST(requeue_pi_mismatched_ops)
         | ^~~~
   ../../kselftest_harness.h:188:25: note: (near initialization for '_requeue_pi_mismatched_ops_object.fn')
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   futex_requeue_pi_mismatched_ops.c:44:1: note: in expansion of macro 'TEST'
      44 | TEST(requeue_pi_mismatched_ops)
         | ^~~~
>> ../../kselftest_harness.h:1251:13: warning: 'disable_kcov' defined but not used [-Wunused-function]
    1251 | static void disable_kcov(struct __test_metadata *t, char *test_name)
         |             ^~~~~~~~~~~~
>> ../../kselftest_harness.h:1204:13: warning: 'enable_kcov' defined but not used [-Wunused-function]
    1204 | static void enable_kcov(struct __test_metadata *t)
         |             ^~~~~~~~~~~
--
   In file included from futex_wait_uninitialized_heap.c:33:
   ../../kselftest_harness.h:188:25: error: initialization of 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *, char *)' from incompatible pointer type 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *)' [-Wincompatible-pointer-types]
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   futex_wait_uninitialized_heap.c:56:1: note: in expansion of macro 'TEST'
      56 | TEST(futex_wait_uninitialized_heap)
         | ^~~~
   ../../kselftest_harness.h:188:25: note: (near initialization for '_futex_wait_uninitialized_heap_object.fn')
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   futex_wait_uninitialized_heap.c:56:1: note: in expansion of macro 'TEST'
      56 | TEST(futex_wait_uninitialized_heap)
         | ^~~~
>> ../../kselftest_harness.h:1251:13: warning: 'disable_kcov' defined but not used [-Wunused-function]
    1251 | static void disable_kcov(struct __test_metadata *t, char *test_name)
         |             ^~~~~~~~~~~~
>> ../../kselftest_harness.h:1204:13: warning: 'enable_kcov' defined but not used [-Wunused-function]
    1204 | static void enable_kcov(struct __test_metadata *t)
         |             ^~~~~~~~~~~
--
   In file included from futex_wait_private_mapped_file.c:31:
   ../../kselftest_harness.h:188:25: error: initialization of 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *, char *)' from incompatible pointer type 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *)' [-Wincompatible-pointer-types]
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   futex_wait_private_mapped_file.c:59:1: note: in expansion of macro 'TEST'
      59 | TEST(wait_private_mapped_file)
         | ^~~~
   ../../kselftest_harness.h:188:25: note: (near initialization for '_wait_private_mapped_file_object.fn')
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   futex_wait_private_mapped_file.c:59:1: note: in expansion of macro 'TEST'
      59 | TEST(wait_private_mapped_file)
         | ^~~~
>> ../../kselftest_harness.h:1251:13: warning: 'disable_kcov' defined but not used [-Wunused-function]
    1251 | static void disable_kcov(struct __test_metadata *t, char *test_name)
         |             ^~~~~~~~~~~~
>> ../../kselftest_harness.h:1204:13: warning: 'enable_kcov' defined but not used [-Wunused-function]
    1204 | static void enable_kcov(struct __test_metadata *t)
         |             ^~~~~~~~~~~
--
   In file included from futex_wait.c:14:
   ../../kselftest_harness.h:188:25: error: initialization of 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *, char *)' from incompatible pointer type 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *)' [-Wincompatible-pointer-types]
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   futex_wait.c:39:1: note: in expansion of macro 'TEST'
      39 | TEST(private_futex)
         | ^~~~
   ../../kselftest_harness.h:188:25: note: (near initialization for '_private_futex_object.fn')
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   futex_wait.c:39:1: note: in expansion of macro 'TEST'
      39 | TEST(private_futex)
         | ^~~~
   ../../kselftest_harness.h:188:25: error: initialization of 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *, char *)' from incompatible pointer type 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *)' [-Wincompatible-pointer-types]
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   futex_wait.c:65:1: note: in expansion of macro 'TEST'
      65 | TEST(anon_page)
         | ^~~~
   ../../kselftest_harness.h:188:25: note: (near initialization for '_anon_page_object.fn')
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   futex_wait.c:65:1: note: in expansion of macro 'TEST'
      65 | TEST(anon_page)
         | ^~~~
   ../../kselftest_harness.h:188:25: error: initialization of 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *, char *)' from incompatible pointer type 'void (*)(struct __test_metadata *, struct __fixture_variant_metadata *)' [-Wincompatible-pointer-types]
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   futex_wait.c:101:1: note: in expansion of macro 'TEST'
     101 | TEST(file_backed)
         | ^~~~
   ../../kselftest_harness.h:188:25: note: (near initialization for '_file_backed_object.fn')
     188 |                   .fn = &wrapper_##test_name, \
         |                         ^
   ../../kselftest_harness.h:157:25: note: in expansion of macro '__TEST_IMPL'
     157 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
         |                         ^~~~~~~~~~~
   futex_wait.c:101:1: note: in expansion of macro 'TEST'
     101 | TEST(file_backed)
         | ^~~~
>> ../../kselftest_harness.h:1251:13: warning: 'disable_kcov' defined but not used [-Wunused-function]
    1251 | static void disable_kcov(struct __test_metadata *t, char *test_name)
         |             ^~~~~~~~~~~~
>> ../../kselftest_harness.h:1204:13: warning: 'enable_kcov' defined but not used [-Wunused-function]
    1204 | static void enable_kcov(struct __test_metadata *t)
         |             ^~~~~~~~~~~
..

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


