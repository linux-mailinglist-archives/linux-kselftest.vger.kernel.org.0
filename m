Return-Path: <linux-kselftest+bounces-42908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C91DBC6EE8
	for <lists+linux-kselftest@lfdr.de>; Thu, 09 Oct 2025 01:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AEA9134CFEC
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 23:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547BD2D12E7;
	Wed,  8 Oct 2025 23:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTAjJ8LQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3F734BA39;
	Wed,  8 Oct 2025 23:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759966568; cv=fail; b=SHTu1rgQIIBOgXD3/Uowa2PkKAUymx9uICADQH5tWsylSlkAC5qhzT0w36sjH3pVdAPTvF1OZQAIuP68y91fTVz+jPUIPB2zEnc2WQFIBrJtKNVWYwI3PYHms2+n5tQmDow30qQSIyn2a70+HGrWBh4tMiCHoky1JUra9e0HQuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759966568; c=relaxed/simple;
	bh=fST7iZqO9d1+cyu43JlqfRUp3tSFPfpehYLB0dDdR6A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VQh/2+a6s5Xde2Pf4lDY5IPXmv/q5BgyQnjhmrWCiiy+v7PGw7HrioEtBngwvDJL5CjQS3pKYy94nA4IyAp1GAn2K9o/BzFx+w6AERKXLYwWqcYfsrLvm706pXa6Div0fnbNgFRfoKQOx4LTBJGe6ON43Gj2G1e0tHLlH1qO/nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTAjJ8LQ; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759966566; x=1791502566;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=fST7iZqO9d1+cyu43JlqfRUp3tSFPfpehYLB0dDdR6A=;
  b=lTAjJ8LQSMnTl7x3EYWkX1QnM7XxYKyX6gPoO3aUmzsuwjUgNUEZ8pCW
   rBHzBR1G3ZUbbCXMocnI+hfavsIIZdjzMc5cZ4fDj0YuVFgXFSES7QQct
   N6f4sk05P4A7oRx34EN7MUyFmDPa8Zfnj7fMjSVT9zHorXbot5WDwDwVh
   EbAosKEpz23waSHdVWOiREyIFF6J7zC9tK4KoF/+D7NCoWCMnYEB7SjQ8
   OPawmFCPejLgd8fTB8rMDgitE7gfMnogiDuNVQ3TbUBdoJ5lmKqN1ugO/
   UiXMTkaDyrtpEz4jv/FoyQaNHgTI++bHLMCPlCZoInnsrPtLzMvFuqSeq
   w==;
X-CSE-ConnectionGUID: 9HOwBnPbSpSyfNwVjOlTcw==
X-CSE-MsgGUID: veGYRDUMTrmb0arpgKcAOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="73598496"
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="asc'?scan'208";a="73598496"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 16:36:05 -0700
X-CSE-ConnectionGUID: NoEDSdcKQHCvl+cbXo9hsA==
X-CSE-MsgGUID: QSXiEYKhSqK18MJMJQIN/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="asc'?scan'208";a="184944091"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 16:36:04 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 16:36:04 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 16:36:04 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.70) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 16:36:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CC9T2arfZ+euOw5BqoPyGGUAWSlkOterZumYk8uyeBJZ0qjphU9xZqORAG1V53pKhiLCVhYOJpDcbT7Nvq5zLjXtVfQNEvBv+uzFFb6RfyfilKlEKVapNPwCMq1BQ9Grz0IRF9IaZ0oOTEqi19cd+KKEzZ9pC5JcjfBEdcZTANSjfBycULGwcHmAFPGIP4yziQYOBpJ9kFv7KfYKv//+IQ5ZCZwQ0tcqSXdCM3QrbQYMZwG4bF3nheBg/LSmdqX7jb9Edbbik+jBoCVwyaFETrTG/L1MFK/Zs6HzmYAREocfjJ91E/ZAqWgJ/nm3DYv4v4zS0Rayib4KPgKoZu0YaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zI0qqNnZ4tjY0N5NlLiMWAkqWaNToDV1YV7htePy7v4=;
 b=mKLk9FIhPgza+nhwNymmm/wHqPOmnb8lPjtb5EQBsNz/aPGsc/DN7UCuxz913hg6FpzsAQZQhllQGcM2xBKs6NpctOlWl/A8ppiZ5s/YKHrSk6SXHhSzz8hk4ID9HX8waaUtE83BtvSnCGUajRZ/gwHoDd2qr+qIvJDwhNXWGgqCo0t22CBs4+kJF5IX3GFW9cagrEoA9MsQcC4Cwwr9+ko4e4m51s7lEREiMfoLkyL9n/pqcluox56dob4nRvNi6SNVmDy86p1XCRBN1ZnxJZA/ZkPEgzmXMY2+UkjUJpJ6GkKyDhkxvXtutbZcxqWHKwzgV4bpuk7tr/PTb1J3ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by MN0PR11MB6060.namprd11.prod.outlook.com (2603:10b6:208:378::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 23:35:57 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%7]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 23:35:57 +0000
Message-ID: <be63e911-490f-4fd2-aa69-d81a306d0710@intel.com>
Date: Wed, 8 Oct 2025 16:35:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 9/9] selftests: drv-net: pp_alloc_fail: add
 necessary optoins to config
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <bpf@vger.kernel.org>,
	<shuah@kernel.org>, <joe@dama.to>, <willemb@google.com>, <sdf@fomichev.me>,
	<almasrymina@google.com>, <linux-kselftest@vger.kernel.org>
References: <20251007232653.2099376-1-kuba@kernel.org>
 <20251007232653.2099376-10-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251007232653.2099376-10-kuba@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------GTwDAi0EXmseK7VqMgoREwdF"
X-ClientProxiedBy: MW4PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:303:b4::21) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|MN0PR11MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: 406c7650-ed58-4d1f-3dd6-08de06c36e68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3pZZTdXRkt0dit1T1lSdk1DejBnVndUSlIwMWZWSzlEMWMwUE1rOURwbEZq?=
 =?utf-8?B?TlVJUko5SDMyVWVVblVzcjJoWWR1TTJGM09WOHZpak1ydXdvK0dubjdGSlpz?=
 =?utf-8?B?YlJGSVE3aDVjYk94dC8rVnMxYlRvMVNLNXJoVXNEbkFXRyt4aXBsdDN3NVhS?=
 =?utf-8?B?TFVUbk0yU0N3UEk4T0lCemt4RTZiZ3c5amdJUm5qSk4xN1Y3T3J2VGZiQTJY?=
 =?utf-8?B?TnpnNmJzNDFCWklYT1lQb2U5VENnQ1BBZ3Y2TmJqZjZFTXhlM3NqK01WbDZT?=
 =?utf-8?B?dm16V1h5RU9TMWhLSERaV1FLUkNqNUZjRXMrWGRmRGh6ZnYxdTdLTnNLZXBo?=
 =?utf-8?B?L0ZIVmhSeGNvUHFZOHFpdmMyMGdUWTdZc0xEUG5KMXNUSzAyWTlscWJiaFF4?=
 =?utf-8?B?ZFp3dTgyVGt4Wm5PWnIxNWVYSEtXUnVtbEE5Nkx3VExtb1N1WHlaa3dGV1pV?=
 =?utf-8?B?TDNBWkFuVnA5QjRlOW5pZ1NML1gvZ21FSUhoSTgxTzMxVFhJZk1NTlNDdy8x?=
 =?utf-8?B?V1NreXhPd01hd1VHVk5yc2ZMUk96NEhVMUpVQ0k0ZnRWVkxPWDNKTXZxVXRv?=
 =?utf-8?B?djZhdW8wYkhMMkJoWVhmQ2V5SmtBcmpsTnRFMEpDWFBpZkZCcEdRUnhtYjNK?=
 =?utf-8?B?NzAxQSs5VTlBclFaRUZLL3J2NzMrcG5TWU9ua01mc2hnalJoWHdHVzFpR0Fh?=
 =?utf-8?B?YlJxZzEwMVlmQ2VvNDlNeXRCVmMxb3RxOVpuZkh4elQ5ME5sblBIaEVsQ3Bq?=
 =?utf-8?B?ZjdYaDB3cVloWnl5NklJQ2dOaUJwKzNmTGN1WEQ2V1hDME5aMDRxbGdoWnpK?=
 =?utf-8?B?Yk5RUDhvN1B1V3RlVkIrbUtvRlhqbFJCOUNHdGFNaEdmOGFlWDRDcSt1WStk?=
 =?utf-8?B?aXMyN3pJcmI1Y2E2dzFqd1VOK256blYzK3pmTThkRnhzRmdNckxaMjV0WE1u?=
 =?utf-8?B?T25uQjR3cG82L0dmMC9kRitvd3l4eGd3L0cxaCtRNkNXa0lPcEx4ZmlEZGNw?=
 =?utf-8?B?OVp1UXRNYlMwM0RRR3M3UGpEbTZ2L2dIUGN1WGVta0d2NDFFWkxmakRhdk1a?=
 =?utf-8?B?NWFxNFlRSzAzTGU4U0t1eUFWa0o4MGFTZ2lOR2tWWVlVcFlLUDFlMkQxSi9H?=
 =?utf-8?B?N0pBZ3BlRXI1MllCdFpqWmZCMVFzVmp4OGVrdFlvT2RkRVk0NG1lWDdSUGs2?=
 =?utf-8?B?a0xqM2tETisybzE4a0ptbXM0TWt5Z1VQN0xsQWxLcGhxdUIzNGZ0dTNZbTE4?=
 =?utf-8?B?MDZuVUM3KzBHdDRaTm1peENMa3c1cjJTMUY5MSt0N0dMc0hJMWFtVG1hTVNE?=
 =?utf-8?B?RnlwUndRSHNMci90QmlEWGo2NnRjY2hDN0NyVXF3WFVSZnVWekl2eFB1MjU4?=
 =?utf-8?B?RFFmVGlxbmUyMlhmVjhXYmNFYUc1YjFCOFBYQksvUEd1dHBRV2EwcnVrYWR1?=
 =?utf-8?B?OU5KUlMwTHJBb2dzenRBelRURlowTDY5d3dFczVyMkgrc1BrbTBOYjh2V3B5?=
 =?utf-8?B?dVRUY2JuamwvMmZaWG9Yczh2Vjd1ank5SFdTTUgrTXdlMmliYjJWSU1QUkt0?=
 =?utf-8?B?UDVQWmtucjJ6YjZ2NGk5Vm9uMEdnb3pKa3VreGR3ZzBIMWNjenJWMi8zZ3Bv?=
 =?utf-8?B?ekR4dlZVa3dNcDYydEdnK1lkajd2b1pSK1UyRG5FdDAyL1NZUTZsYzhvRk85?=
 =?utf-8?B?QURiM3crdDBaWXVZU3VKS1NoRk94R3hjckVjRUJ5RUpRTStOSmV6MllHa01m?=
 =?utf-8?B?YnNNZUNvQ05YV0dCemhpejY1QzlWeEEyc3gxTXdIVHU4dzF6MEdrZElBTytI?=
 =?utf-8?B?SXhaSkxVRHBvZnI2VWY3RWhVcmg5NzEvc2RHOUtpT1htL2puWEUzZkxRQnJs?=
 =?utf-8?B?d0ZLQ1FQdDNLaVV3VGVrVFIxSE1RNmYrQnREbERaUVBnWEtwdnpDblkzU214?=
 =?utf-8?Q?2JOw/Fq85QqUxpMjtlie+igmIHRuuv+h?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFRzMTR1SWZXRUJKMHM4bTNXVXJiQUtkbHVqVTQybk5UU0dIWUczbmFOQXh2?=
 =?utf-8?B?RDBoR2U2UTFXMmU1VExSTjJZUTVTQmpXLzdJYkdrZHdGanFZb1ZrWmxsVFVW?=
 =?utf-8?B?eFR6R0srMFkyaWVNbzVyQlhBek81eVkvODhyWjhQeFF3VG9jU3lXQnBvYmg5?=
 =?utf-8?B?Q29qeXVTTStJTmNXQzlTenlvZkhKSDljZ2xjQTJmK1U4UGhmYlU1dnFLN3ZL?=
 =?utf-8?B?WllBdUdPeVVNOTNzazVKYWkxZGJ0SndqWEQvOWlocDlPVUpXclRmK2x2VkpC?=
 =?utf-8?B?RjYyaGdnV1RBbVhzNGg5K1ZVbmVrWUUwOFBKT1hyekU0clVZcW0zNlExcDN5?=
 =?utf-8?B?RWxtQkNPNkpyMTN6aGpZbVdPcVByTjJIbnJtSWtSZFF6WVNITDExMktUQjBh?=
 =?utf-8?B?V3NHc2RoY0xodTd5WHpBV3dqRklPMG5JL2RyZVBLR1p3elFwTjF0ZzBrNHVM?=
 =?utf-8?B?Z2x0Z1ZLbHR3QkNDWUVHZ0tabHk0TEhqV3FIbkxJckVpYXVockJCc3QvMlN6?=
 =?utf-8?B?cGFGNGpPZ04xQUlYbzhidk8vb3ZtR1ZLY0k2UlI1ZTNRcG4rVVRScXA2ZG9a?=
 =?utf-8?B?allCMjZSOUMyWVhiaFExZjc0ZVpkWm1icmJra2hvbjNCck1WOWdzM3R0MGdH?=
 =?utf-8?B?YmFTcnlMOGRrRXBvZExqSStaTTRhbGdCT0dGbkp3UGJxaDdDSGxnM3JKdEpW?=
 =?utf-8?B?d3ZOZXlpNW9zQVUyVXI1QkJIY3pyWjZxbkFqUzhZcnhlYi8rTys0UnlOcGw5?=
 =?utf-8?B?NU13ektaWE5ISHVKTmhBYzNsVW1wRzBienQ2Z3Fua0NaSVJHZ0RFLy90NEx5?=
 =?utf-8?B?QUwvNEJyQnlETkRZRzN4UjBYVUc2QUhjT24wUzluZXpocVpTUkpyNkJvWUlx?=
 =?utf-8?B?VlFSY2JwRXdoNnNLaHlRcTk5RFZUc3lNTGlxamRpM2tzTFVEa203MTZwWm5P?=
 =?utf-8?B?MkZaS1VCcmkwWXcwVkhHUTFsanlFZjY1L0NheHJYZVJZaDQ0Z0NUT1MxaVRN?=
 =?utf-8?B?SlRSVzI0aFdsc251Tk4yR1JoaVZDcENHbjNyZkNXRDhxYXdTc3dFdVJsMG56?=
 =?utf-8?B?cStGckhJMnF3MGtyaG1DVEFpOUFCLzFoZ2d4TlhGdVhBaUpZMTBKckpEdDlL?=
 =?utf-8?B?QkdLdjBLcWZSUHpzUktHN3M0VDFSYU02blo4ZGNCUTVjWWVNOEFka1hta2RK?=
 =?utf-8?B?ZUlkV2FDMkJNZ1NmRmo1cGJvN0d0L09MbjRpR2c1NFFKYXNuUEhISC9hSDVM?=
 =?utf-8?B?eU44NWR4YnlVS2dYNHVUcWFUbXBvZ3k0Qnk1N0QvenpDVHU0cDNlSTRnSU9m?=
 =?utf-8?B?TXhWc0tHcWxLMkRBcmg1T0Z4WkhYRVJNSnY1ZXlhQzJKYTJMSlZRNHJYTWpE?=
 =?utf-8?B?RzNMeEtZNlZzUzlzK0xJUzc2cEFQWUllNDZMaUsxdjFFWFVEMnZubVdIaXdx?=
 =?utf-8?B?Ykdwb3NkR1JGdjNOMVBqSXpPTkZxZmZvN1lxOWJ0MkI3NG1VZkpuUkN5VEE4?=
 =?utf-8?B?S3RNeXl2VE90ZzJQVEk1akVTeFlLcHFRZ0tJQXUyQy9uaEFhUVBtU1Q4WTRC?=
 =?utf-8?B?VlVJWENQdUtPSm1RYlZnbE84QW5FajcreU5iYlNsZ1VBTFZ0RGZrL0JEUmJk?=
 =?utf-8?B?b21IYWNoMGhONTY2cDAxUG9qVUVlb1RLZG9zZWxLV1NlMWRzaEJCR0gwcXQ1?=
 =?utf-8?B?S2ludStLaFc0U3UweXBURXd1UWdabjV2eHp3dGx2TnJmQU4ydnBQZ29rcWRk?=
 =?utf-8?B?em9pT2tEYndLek1JSHVqcm0rQjNnRE9NSTl3eitla1hrQWZ0VzlNQUNqS3Jm?=
 =?utf-8?B?QVk4TXlzcXM2MWR5a01KVVRRS3huOEYzY0lwbkxlMlkyRmQxYXZSeFNTckRN?=
 =?utf-8?B?akU5MG53dHN6ZEthYVZKZE1iSzZmM25tNFk4NUovZlRKWmM3NVFCVjVWSmZy?=
 =?utf-8?B?QlQvbnJjaTZ6Qjg2dlpsUWZBbXJWaHZuU2lyRWtkblR6dlAwQWdjMzZVeCt3?=
 =?utf-8?B?a1ZHK2xxV2wzV2J1OWV6RFZ4elIyZ3FFSGlmOThzRHVyd1JrNlI1S1daVUt5?=
 =?utf-8?B?YkVtQUlQRkw5N3o2WkJtREtBSzFleUkzZWdTSWVaN0xHcVpBczArY0VjZ2Yx?=
 =?utf-8?B?SkxPNzY0ek5aNHUxV3JiWVVKcytrNkg2NHZIM3plYVU5WDBFaEYySUl6YW4z?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 406c7650-ed58-4d1f-3dd6-08de06c36e68
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 23:35:57.5911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Nnoohtrg2VSmOFB8JW6f+At3WPvhhNBh6gmQDHaWT5KBDjN9SN8CanpJVrUD7KhMh67tnrc+gCguv1Wb4Glu+Zr/avd5eH7uRQQvd5Qntw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6060
X-OriginatorOrg: intel.com

--------------GTwDAi0EXmseK7VqMgoREwdF
Content-Type: multipart/mixed; boundary="------------hC5JBzS20YMe1Xet0aAtPm6O";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, bpf@vger.kernel.org,
 shuah@kernel.org, joe@dama.to, willemb@google.com, sdf@fomichev.me,
 almasrymina@google.com, linux-kselftest@vger.kernel.org
Message-ID: <be63e911-490f-4fd2-aa69-d81a306d0710@intel.com>
Subject: Re: [PATCH net v2 9/9] selftests: drv-net: pp_alloc_fail: add
 necessary optoins to config
References: <20251007232653.2099376-1-kuba@kernel.org>
 <20251007232653.2099376-10-kuba@kernel.org>
In-Reply-To: <20251007232653.2099376-10-kuba@kernel.org>

--------------hC5JBzS20YMe1Xet0aAtPm6O
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/7/2025 4:26 PM, Jakub Kicinski wrote:
> Add kernel config for error injection as needed by pp_alloc_fail.py
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
> Fixes: 9da271f825e4 ("selftests: drv-net-hw: add test for memory alloca=
tion failures with page pool")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: joe@dama.to
> CC: willemb@google.com
> CC: sdf@fomichev.me
> CC: almasrymina@google.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/drivers/net/hw/config | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/test=
ing/selftests/drivers/net/hw/config
> index e8a06aa1471c..2307aa001be1 100644
> --- a/tools/testing/selftests/drivers/net/hw/config
> +++ b/tools/testing/selftests/drivers/net/hw/config
> @@ -1,3 +1,7 @@
> +CONFIG_FAIL_FUNCTION=3Dy
> +CONFIG_FAULT_INJECTION=3Dy
> +CONFIG_FAULT_INJECTION_DEBUG_FS=3Dy
> +CONFIG_FUNCTION_ERROR_INJECTION=3Dy
>  CONFIG_IO_URING=3Dy
>  CONFIG_IPV6=3Dy
>  CONFIG_IPV6_GRE=3Dy

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------hC5JBzS20YMe1Xet0aAtPm6O--

--------------GTwDAi0EXmseK7VqMgoREwdF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaOb1WwUDAAAAAAAKCRBqll0+bw8o6OUg
AP98kbMu8sphP3JnSdtkXKzZgwzqbXqt2ZJollqp/7fltQEA+N7AmKaAKTrmWVkJGZK7KwLP8wEF
0WzorwGWHR87AgU=
=DuMH
-----END PGP SIGNATURE-----

--------------GTwDAi0EXmseK7VqMgoREwdF--

