Return-Path: <linux-kselftest+bounces-44881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 985A1C39A4C
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 09:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 613DD4E75D1
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 08:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E73305044;
	Thu,  6 Nov 2025 08:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K+V99N6n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8130523717F
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 08:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419022; cv=fail; b=WvxEk9W97CC0aGLtO6SnFRbbKCYIYVDGFeQj7KRUUGJrvGKdhkqvaAtY4BDNfXsH3E9ByRs5pLjauP3Lf15VPVl3SsVMk1uegHG6H0eSUxhdauerB5tj3cbL4loS9hO+EOL5VzgEGP9Acp5UPUGMeAysal8qoH4mowEv3KsxkPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419022; c=relaxed/simple;
	bh=AEnceojq/5wRw5wPgndwV18wnAkT8aCxJ/vAFa0XLyE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VrhSXgkbZl/30JzxQNk5nSaazUykOKseQX6qNGsP7T9ooYmhE5sKY5eg0pwo0MX2r1W+1SsVoHQDIvSp0Du9SF2xoNaAVSTekv4oiEpkS/Qm/e8/8QrQJciuAgUHbnnhgr5sLd2HbZ3VmcqPpqWhtx2+nh47A8nLnDgme+CG25g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K+V99N6n; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762419021; x=1793955021;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=AEnceojq/5wRw5wPgndwV18wnAkT8aCxJ/vAFa0XLyE=;
  b=K+V99N6nvmFWQCp3sKYidIuIdrBiSDdwJjc+uCP9nMldkbpG6/91YbV/
   P8mtb4ImpdauoADn2EKXlg9XmNOvXMT/InQywoDJaMPferM3ymtumJfFc
   rxKfEFSHm350R7DHQ05RwL46nq63w+9AdeI6p8X62ZtVG++Oe6e0jA5/X
   /Zz+Q5oRSGat/hBmdgbX42N9IwRECSKf40u4q2iind0M6FXmZhkqTbuyf
   jayRVhTqTWfq4CiDoj1JIylZjRtgz0UoB1TiWAzo5KsxmcwWknMSD+Quz
   8IhyXC49JMYLHn/4IXlbo8xW/M4YDDCwOX+00sPOI68b1rb2iD95+O6cE
   w==;
X-CSE-ConnectionGUID: oGhrumxCSGe3wgLVhpJBoA==
X-CSE-MsgGUID: oq1VO4DdQiaKLK4LqkLvNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64700812"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="64700812"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 00:50:21 -0800
X-CSE-ConnectionGUID: 6xgpq1zTRYubHfV0UqhTeg==
X-CSE-MsgGUID: k+MsWjalRju5hmgZMc6Ghw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="192874907"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 00:50:20 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 00:50:19 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 00:50:19 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.25) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 00:50:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mofho0f3R5LNwrEtj43X0lDYvpi0qlKi1vj/uQBqfquvd5b+0OEc6opSU1LeOtzm+IMsadECJf151ykfjihSqaujduVZtSxViuruNP8LY6B3XLU3bf8HFy3ZRgvTZDhgOIIwkyXHHpea4L/goSrpG851AR4zRcmOSy+R5It/JbRLkQ7ar+4QM4vPmN71y7gexXlSc3K3H2v3suBQEfqGjW+jD+J1dWqlS5PMcRjftsCEO6Fh/opOgjEwNfx/5CkeYMWP7fTj1ckUMLzdhZw95n6quMQyr+U8dO85mjPeJ96kSCD+TZRJDYImvkSAtAq6FuUbQZLsZaydduLk1J/mLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dz/yEiHFNV5HCvWGuTVsVCh1a0xRUIP1xU/iXcbmQMw=;
 b=kNOjs70nvKm9umOPw9yt4J1CAGVCFuYjf5sYAiv+iepMw4pw1BF3X59a8VsV2COLoAk/D7EtDKMSmICQ6Gn/p3BOdSp8rDPjCAqXgTW4LLPUMUlXWYzpKjt/E1Q5WldPPENwQeWIysqGyZaXYXLpfaQ5MXHOZsM1BCkdEYakUTZIgV73LE25dSRkXMf10FkhU6xax+Ly7S7p9tV+y9WJ5Ql5bPBdpMl+l17TemdEYeUVidlzf8hmTUJu6LO3865WMItyGJb0pu/Loeg0XN3/mmNf9TsRnHEA767qN7gSDPNyWX30M37qanjHNHULF2F7e6iwfGprxpd6AExIqi0SQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB5996.namprd11.prod.outlook.com (2603:10b6:8:5f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 08:50:16 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 08:50:16 +0000
Date: Thu, 6 Nov 2025 16:50:06 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Kuniyuki
 Iwashima" <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2] selftests: harness: Support KCOV.
Message-ID: <202511061615.3c5824f3-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251028024339.2028774-1-kuniyu@google.com>
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c54a0a-c06c-4bf1-27c3-08de1d11802f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dCq1BFXCJY5J4fK5PRE2ysESy9Y8hLD6Ys3anLV/+C69piSNN2i3tuv5pdj6?=
 =?us-ascii?Q?Fqga41YVZOOFDM7tidEl8PVA/+0AlYbRoIwRTGBwYprPEbUGOHKF9AzE4vuP?=
 =?us-ascii?Q?LY+epolMwpkdFBeWxVQxqOMrFkNRbSZziM2hfu1kNrE6zdwOQe4YqG6K4nsQ?=
 =?us-ascii?Q?8TG3nOWFuyH4L4uGCZhx69N7UrCCzqysY7+r2EOMb+qelpwgog3zYRkBxq/g?=
 =?us-ascii?Q?raeSTr/rSqNtRtqN4QabMF6c13F0P3PfuxmsN23ohxkoelaeW/0Mxp0Y0mIx?=
 =?us-ascii?Q?oiTitOJ2wVSC7xxAaHylolUhpwsG9TW6NMIcO8Ug8bBlP3Y6gzOzqWJR4Vmp?=
 =?us-ascii?Q?L1gmGGwRjsTc1sABdmUhjqMZXCxG/N811suDBU2mc9EBa5UeZYCZfTI6MoIn?=
 =?us-ascii?Q?21x/47OKnlEf70P8gtlBVF+KLUVxx3GTwSw3pLMBDxoydbG26dnAThmyAHVk?=
 =?us-ascii?Q?gpLnHaU1hZFKOKuJNSqbGcT60RGYKfoTKQmPs3tGt84k08gTqQner2E4dioY?=
 =?us-ascii?Q?IXbLd4t78q/GLZwvYCZySXBDW1QqjqYCGRvfnvh7DCHWOFG26tJ1u00CiG6J?=
 =?us-ascii?Q?7w/brQqYp0nQM57OxCcaLh6QiLU3GomTAoeHlsbJh5vc9P4y8QDsPMPu6B7i?=
 =?us-ascii?Q?ANzkVhjrlMi1D4xvPnkgdpHqehD4vG0zti7x5mLLLRGuKwJa1q83z88lCrgo?=
 =?us-ascii?Q?0nkF8EPNRmRFzdoJ0gjM+zRcq2re5Y7K3B0haiZcdsCq5X0hDdhzL2fB2nYE?=
 =?us-ascii?Q?R+qwAoYny6QhtxrDQs40McN0eg1Mlrh76RTiTTyUkwW4TEShoY0VqT3B6vBh?=
 =?us-ascii?Q?hUzA3F2/MtYSww6AsvCHslx30SwYrbI0XCGeXcN0TnholcNIyQxqd41MTHnh?=
 =?us-ascii?Q?icDQVhiNSh49LnJEbmz1yqYC1U6XPY4vUlg9Y0+nQcXEV0Ae/0fywj220diR?=
 =?us-ascii?Q?j8xnwkdE+rDbow4Ezy3kqM3QpPva4qogLzikO13BxVtrPT5kmW2yNEp0vlTj?=
 =?us-ascii?Q?7AWZO+PNywbTXOWBnNMbiV6KbXcO2yyWFfnYjwiloHoP5LaYenrny7Pj9cL5?=
 =?us-ascii?Q?LvhFlP9DjuiA26wY0Drl02YfQTkjw6cnwo8p1P61M5W2l6LzKmB/RBr0KOpB?=
 =?us-ascii?Q?qNE6mCJfNmJnMaj81jkCFtL2zl9KAyazFdCCQHnA87LckeD9/jfFEkjDTD6R?=
 =?us-ascii?Q?BQs+W1COKpoH3q8NOmhRwYrjZ1Dp2HJk53JFS33b8DhdexC2H+Khg1LhOHxQ?=
 =?us-ascii?Q?/8uLIJd1MeMPKOxJhcfnomLMcMkWOoAm0vbTSwq1Kht004Dfj2aWCWwfQwLV?=
 =?us-ascii?Q?0Qwc7ECs46beD2sq0vnlcOqvvjRTjDYBpth6H6lVi4kgJhO7yYYjFdLpD27K?=
 =?us-ascii?Q?6z/aEJsClHZ3OKSQHAqwlf2zcncZ6CA941BktrmXNBLCy/VyA8C0WntoYy4o?=
 =?us-ascii?Q?IGvoYlujfykw8Icn2a9eI25wYjMzRV23PzqXrEpLuCeT1QQvOJ1bcA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XIR/vxB2ydZKFHsdSrdMLKhf+d4mrKXPP8bLyMlSapQ2kTEmFgn5/SsQ97Xp?=
 =?us-ascii?Q?a+Lfg+5sXSwB7wxlqucCpz/+dQk4XDDI9dUdPMrMTzJvNYotWYL5kH2MmWvs?=
 =?us-ascii?Q?3Q7OY7+7C4Ib0T07PmjNhQPbqwYlkkV0Cu4r573k1+bnuMQC0mr/vkAgfi9g?=
 =?us-ascii?Q?Ia0d9rwdtWQPZRr+wsS381O1oYo9b8gMSuuKCiF22/GhdzFK6YvreiMsx6Cr?=
 =?us-ascii?Q?2cFXPjy80eoh2KYb0CoIK+DCss+E/RB1NwFP8m2TrY51KVx6necoT4IPgUQk?=
 =?us-ascii?Q?v7+qrfcz4gcFhByxn51RK0L7qSzIeu9ShOSzYvtHjRKd5hqb6gfSRhIrMi5z?=
 =?us-ascii?Q?B49sLizIBSonXi0lWgnGZyQKxNV8CQ6bHhJRKMdva9pYb0H3ePqvqBe3jtnl?=
 =?us-ascii?Q?1VG6wvCQmo53s5fuhYltgWDVZi7srl3wCEem808rkpC0ZuhHD5xUK3EddDcS?=
 =?us-ascii?Q?50cAXl/x8RXm8zzpFiWdU0yKv/rtnkxLbo6fwkod2Q7XkB50bHP2F8BETwj5?=
 =?us-ascii?Q?4eUGIkmX+N0uloRa9WZONrh24jwPhb1kpKSDKL3I3JzgONO2V+IeE8nnbslm?=
 =?us-ascii?Q?RGILsNre9y2xNA+sM/Q5HFk9kDSbAUmLShym32THZCr85Wxp0QSnq2G9cXXo?=
 =?us-ascii?Q?Jss1AoSgMo2KbP1dy1OgOak7IhKKdEdZ7Ou7urDi0xooh7ACaiZ4dWlmtK1y?=
 =?us-ascii?Q?xgaHeRP9Eqepiipf+PiXvOuhD+71k45QKUshJeHPSLTf0jrl4tt/YjVGJVy/?=
 =?us-ascii?Q?FNWKpH0RJ2Q+srsz9pNspnlb7vRpl5kvu6IW368Z472L2U/B1gQ2QQimM2Kd?=
 =?us-ascii?Q?73n2YgZ0Zh9P9/L0eoTniCkokciQrkLLdncOc4y81jvhcvqMdFkNvJBL7wDU?=
 =?us-ascii?Q?/ewctIxSiCcVBX7fCmBcPZxrHAwaCt36o3JjCHx/oPeqkyXBDIBI8GUb1hnh?=
 =?us-ascii?Q?sdHjlUSjIw+UErKdueE9tTg8yw45Iw86jMv0Q81i5klJOzLnVB0qTLRTNSiI?=
 =?us-ascii?Q?3hdQUEzpYlhy2Zhxdt0KADj8prQ97JuWhCCnGnepRI+MgUiA0pyzAEso5L/9?=
 =?us-ascii?Q?zQBvsl9kG/WclR3Edno2SqClgJssj2CZ69WFxkVdmun4/8raYfFaY+SFl948?=
 =?us-ascii?Q?MLAwd2q89HJNMrU/t5pas2MxxSe6VMUHuasg9eAk0DRW0JPStAKtvmc+pfg5?=
 =?us-ascii?Q?bH1HMkl/dmTNGrRrsOXBGaI9DbKtsD6gFr4pIgYt16fRZxgElxO1Vb1onjF3?=
 =?us-ascii?Q?eHzVNfrN41Sol7nFwY17TeqAVyduebTGq/wKdL4UGTcqp3VYXnwOnK7RzC2P?=
 =?us-ascii?Q?Nl/jFVmT9faalfP+gHE7ylS7O7BersbFfrHrnix0E2/iq4S1OlShOa4nlDya?=
 =?us-ascii?Q?b1R41dMlXnT/9eLiOlCKT6aQkUHAleKJ7313p4RLZUSwTSyCoBzBzLDeDJ/k?=
 =?us-ascii?Q?bWV3iNgk5p2cqtalfWzjs44hICbxQtec91n19lgDqVyxeDN47zXzh3o1HjEM?=
 =?us-ascii?Q?yNgD29eIDaCIAxfDWpoS9WgvElknqcvAh3YfbjgpkzIwkVcGQCAaxob+hXdD?=
 =?us-ascii?Q?lV93x7iVn00dNVZffJOkShtIeSp1gcoo4s7aPyRKHwwErpmRUoWx+xWs0xAz?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c54a0a-c06c-4bf1-27c3-08de1d11802f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 08:50:16.4792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dY86FO9KjaBiJO1MgnAagCp+duda4mmj8gXGkVy0gp5pUbcglaBjQydloBrRaEUdLnKzrqHg2xzSRQunSdkxjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5996
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "segfault_at_ip_sp_error" on:

commit: c849d8e404a7b145b33c184042234e903ce72c7c ("[PATCH v2] selftests: harness: Support KCOV.")
url: https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/selftests-harness-Support-KCOV/20251028-104538
base: https://git.kernel.org/cgit/linux/kernel/git/shuah/linux-kselftest.git next
patch link: https://lore.kernel.org/all/20251028024339.2028774-1-kuniyu@google.com/
patch subject: [PATCH v2] selftests: harness: Support KCOV.

in testcase: kernel-selftests
version: kernel-selftests-x86_64-8bb886cb8f3a-1_20251104
with following parameters:

	group: syscall_user_dispatch



config: x86_64-rhel-9.4-kselftests
compiler: gcc-14
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511061615.3c5824f3-lkp@intel.com




kern  :info  : [   72.507647] [   T2520] sud_test[2520]: segfault at 0 ip 0000558da6f1242c sp 00007fffd6f2faf0 error 4 in sud_test[342c,558da6f11000+5000] likely on CPU 23 (core 8, socket 0)
kern  :info  : [   72.508965] [   T2520] Code: 48 89 e5 48 83 ec 70 48 89 7d 98 48 89 75 90 48 8b 45 98 8b 40 70 83 f8 ff 0f 84 36 02 00 00 48 8b 45 98 48 8b 80 80 00 00 00 <48> 8b 00 89 45 f4 48 8b 45 98 8b 40 74 83 e8 01 39 45 f4 75 1d 48
All code
========
   0:	48 89 e5             	mov    %rsp,%rbp
   3:	48 83 ec 70          	sub    $0x70,%rsp
   7:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
   b:	48 89 75 90          	mov    %rsi,-0x70(%rbp)
   f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  13:	8b 40 70             	mov    0x70(%rax),%eax
  16:	83 f8 ff             	cmp    $0xffffffff,%eax
  19:	0f 84 36 02 00 00    	je     0x255
  1f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  23:	48 8b 80 80 00 00 00 	mov    0x80(%rax),%rax
  2a:*	48 8b 00             	mov    (%rax),%rax		<-- trapping instruction
  2d:	89 45 f4             	mov    %eax,-0xc(%rbp)
  30:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  34:	8b 40 74             	mov    0x74(%rax),%eax
  37:	83 e8 01             	sub    $0x1,%eax
  3a:	39 45 f4             	cmp    %eax,-0xc(%rbp)
  3d:	75 1d                	jne    0x5c
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 8b 00             	mov    (%rax),%rax
   3:	89 45 f4             	mov    %eax,-0xc(%rbp)
   6:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   a:	8b 40 74             	mov    0x74(%rax),%eax
   d:	83 e8 01             	sub    $0x1,%eax
  10:	39 45 f4             	cmp    %eax,-0xc(%rbp)
  13:	75 1d                	jne    0x32
  15:	48                   	rex.W
kern  :info  : [   72.511780] [   T2521] sud_test[2521]: segfault at 0 ip 0000558da6f1242c sp 00007fffd6f2faf0 error 4 in sud_test[342c,558da6f11000+5000] likely on CPU 23 (core 8, socket 0)
kern  :info  : [   72.513080] [   T2521] Code: 48 89 e5 48 83 ec 70 48 89 7d 98 48 89 75 90 48 8b 45 98 8b 40 70 83 f8 ff 0f 84 36 02 00 00 48 8b 45 98 48 8b 80 80 00 00 00 <48> 8b 00 89 45 f4 48 8b 45 98 8b 40 74 83 e8 01 39 45 f4 75 1d 48
All code
========
   0:	48 89 e5             	mov    %rsp,%rbp
   3:	48 83 ec 70          	sub    $0x70,%rsp
   7:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
   b:	48 89 75 90          	mov    %rsi,-0x70(%rbp)
   f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  13:	8b 40 70             	mov    0x70(%rax),%eax
  16:	83 f8 ff             	cmp    $0xffffffff,%eax
  19:	0f 84 36 02 00 00    	je     0x255
  1f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  23:	48 8b 80 80 00 00 00 	mov    0x80(%rax),%rax
  2a:*	48 8b 00             	mov    (%rax),%rax		<-- trapping instruction
  2d:	89 45 f4             	mov    %eax,-0xc(%rbp)
  30:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  34:	8b 40 74             	mov    0x74(%rax),%eax
  37:	83 e8 01             	sub    $0x1,%eax
  3a:	39 45 f4             	cmp    %eax,-0xc(%rbp)
  3d:	75 1d                	jne    0x5c
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 8b 00             	mov    (%rax),%rax
   3:	89 45 f4             	mov    %eax,-0xc(%rbp)
   6:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   a:	8b 40 74             	mov    0x74(%rax),%eax
   d:	83 e8 01             	sub    $0x1,%eax
  10:	39 45 f4             	cmp    %eax,-0xc(%rbp)
  13:	75 1d                	jne    0x32
  15:	48                   	rex.W
user  :notice: [   72.516773] [    T622] update-alternatives: warning: skip creation of /usr/share/man/man1/traceroute6.1.gz because associated file /usr/share/man/man1/traceroute6.db.1.gz (of link group traceroute6) doesn't exist

kern  :info  : [   72.517057] [   T2523] sud_test[2523]: segfault at 0 ip 0000558da6f1242c sp 00007fffd6f2faf0 error 4 in sud_test[342c,558da6f11000+5000] likely on CPU 27 (core 16, socket 0)
kern  :info  : [   72.519874] [   T2523] Code: 48 89 e5 48 83 ec 70 48 89 7d 98 48 89 75 90 48 8b 45 98 8b 40 70 83 f8 ff 0f 84 36 02 00 00 48 8b 45 98 48 8b 80 80 00 00 00 <48> 8b 00 89 45 f4 48 8b 45 98 8b 40 74 83 e8 01 39 45 f4 75 1d 48
All code
========
   0:	48 89 e5             	mov    %rsp,%rbp
   3:	48 83 ec 70          	sub    $0x70,%rsp
   7:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
   b:	48 89 75 90          	mov    %rsi,-0x70(%rbp)
   f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  13:	8b 40 70             	mov    0x70(%rax),%eax
  16:	83 f8 ff             	cmp    $0xffffffff,%eax
  19:	0f 84 36 02 00 00    	je     0x255
  1f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  23:	48 8b 80 80 00 00 00 	mov    0x80(%rax),%rax
  2a:*	48 8b 00             	mov    (%rax),%rax		<-- trapping instruction
  2d:	89 45 f4             	mov    %eax,-0xc(%rbp)
  30:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  34:	8b 40 74             	mov    0x74(%rax),%eax
  37:	83 e8 01             	sub    $0x1,%eax
  3a:	39 45 f4             	cmp    %eax,-0xc(%rbp)
  3d:	75 1d                	jne    0x5c
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 8b 00             	mov    (%rax),%rax
   3:	89 45 f4             	mov    %eax,-0xc(%rbp)
   6:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   a:	8b 40 74             	mov    0x74(%rax),%eax
   d:	83 e8 01             	sub    $0x1,%eax
  10:	39 45 f4             	cmp    %eax,-0xc(%rbp)
  13:	75 1d                	jne    0x32
  15:	48                   	rex.W
user  :notice: [   72.521352] [    T622] update-alternatives: warning: skip creation of /usr/share/man/man1/lft.1.gz because associated file /usr/share/man/man1/lft.db.1.gz (of link group lft) doesn't exist

kern  :info  : [   72.522679] [   T2524] sud_test[2524]: segfault at 0 ip 0000558da6f1242c sp 00007fffd6f2faf0 error 4 in sud_test[342c,558da6f11000+5000] likely on CPU 23 (core 8, socket 0)
kern  :info  : [   72.524467] [   T2524] Code: 48 89 e5 48 83 ec 70 48 89 7d 98 48 89 75 90 48 8b 45 98 8b 40 70 83 f8 ff 0f 84 36 02 00 00 48 8b 45 98 48 8b 80 80 00 00 00 <48> 8b 00 89 45 f4 48 8b 45 98 8b 40 74 83 e8 01 39 45 f4 75 1d 48
All code
========
   0:	48 89 e5             	mov    %rsp,%rbp
   3:	48 83 ec 70          	sub    $0x70,%rsp
   7:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
   b:	48 89 75 90          	mov    %rsi,-0x70(%rbp)
   f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  13:	8b 40 70             	mov    0x70(%rax),%eax
  16:	83 f8 ff             	cmp    $0xffffffff,%eax
  19:	0f 84 36 02 00 00    	je     0x255
  1f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  23:	48 8b 80 80 00 00 00 	mov    0x80(%rax),%rax
  2a:*	48 8b 00             	mov    (%rax),%rax		<-- trapping instruction
  2d:	89 45 f4             	mov    %eax,-0xc(%rbp)
  30:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  34:	8b 40 74             	mov    0x74(%rax),%eax
  37:	83 e8 01             	sub    $0x1,%eax
  3a:	39 45 f4             	cmp    %eax,-0xc(%rbp)
  3d:	75 1d                	jne    0x5c
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 8b 00             	mov    (%rax),%rax
   3:	89 45 f4             	mov    %eax,-0xc(%rbp)
   6:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   a:	8b 40 74             	mov    0x74(%rax),%eax
   d:	83 e8 01             	sub    $0x1,%eax
  10:	39 45 f4             	cmp    %eax,-0xc(%rbp)
  13:	75 1d                	jne    0x32
  15:	48                   	rex.W
user  :notice: [   72.526246] [    T622] update-alternatives: warning: skip creation of /usr/share/man/man1/traceproto.1.gz because associated file /usr/share/man/man1/traceproto.db.1.gz (of link group traceproto) doesn't exist

kern  :info  : [   72.529475] [   T2525] sud_test[2525]: segfault at 0 ip 0000558da6f1242c sp 00007fffd6f2faf0 error 4 in sud_test[342c,558da6f11000+5000] likely on CPU 16 (core 26, socket 0)
kern  :info  : [   72.530789] [   T2525] Code: 48 89 e5 48 83 ec 70 48 89 7d 98 48 89 75 90 48 8b 45 98 8b 40 70 83 f8 ff 0f 84 36 02 00 00 48 8b 45 98 48 8b 80 80 00 00 00 <48> 8b 00 89 45 f4 48 8b 45 98 8b 40 74 83 e8 01 39 45 f4 75 1d 48
All code
========
   0:	48 89 e5             	mov    %rsp,%rbp
   3:	48 83 ec 70          	sub    $0x70,%rsp
   7:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
   b:	48 89 75 90          	mov    %rsi,-0x70(%rbp)
   f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  13:	8b 40 70             	mov    0x70(%rax),%eax
  16:	83 f8 ff             	cmp    $0xffffffff,%eax
  19:	0f 84 36 02 00 00    	je     0x255
  1f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  23:	48 8b 80 80 00 00 00 	mov    0x80(%rax),%rax
  2a:*	48 8b 00             	mov    (%rax),%rax		<-- trapping instruction
  2d:	89 45 f4             	mov    %eax,-0xc(%rbp)
  30:	48 8b 45 98          	mov    -0x68(%rbp),%rax
  34:	8b 40 74             	mov    0x74(%rax),%eax
  37:	83 e8 01             	sub    $0x1,%eax
  3a:	39 45 f4             	cmp    %eax,-0xc(%rbp)
  3d:	75 1d                	jne    0x5c
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 8b 00             	mov    (%rax),%rax
   3:	89 45 f4             	mov    %eax,-0xc(%rbp)
   6:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   a:	8b 40 74             	mov    0x74(%rax),%eax
   d:	83 e8 01             	sub    $0x1,%eax
  10:	39 45 f4             	cmp    %eax,-0xc(%rbp)
  13:	75 1d                	jne    0x32
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251106/202511061615.3c5824f3-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


