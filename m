Return-Path: <linux-kselftest+bounces-41748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBD9B81592
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 20:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5921C24073
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 18:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37E52FDC21;
	Wed, 17 Sep 2025 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgRLClf+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4C520E328;
	Wed, 17 Sep 2025 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758134035; cv=fail; b=LljNclevjBLpS3li+jRoymE6DTQuq1cB5xE9pWVmje6s84p6/4SkpwQHR2gvxjBHE1TJGC6kNKeWWfZZNBVpEKqdFXvmzdWb+Lo9GGFYJh02JvKeHn2GeCkJnNlOFQpDMTXLOKwoXu/hZUXyPvaS21P4vStdfciifO3Ss9lX0Os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758134035; c=relaxed/simple;
	bh=GI3REmzLG3Ti5f4YqMwKtxTzN5wjbUB3RqiqdaVxFUk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LF9gi11iei804n2uF29yZh39saDIES1n9Ldy9ZxbDDTCo6JoyCESoccRhOA68dWPXNeHHe3zn0H+1JygXdrVYkFJe8Uj0DxtxC5yyq29WZeA1V0vVtuV7vKxXJWiDfhne+NLXK/b9ikjCRx4TH/2vkAIdVW0y1erLNBKYovUjP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgRLClf+; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758134033; x=1789670033;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GI3REmzLG3Ti5f4YqMwKtxTzN5wjbUB3RqiqdaVxFUk=;
  b=hgRLClf+9cIx7QA+6lEI+MfjBr2Kmrvxi6xpFqOLfN+QUsGPwUEkX7cS
   fuCbIKl+D20TwslUOeD/7TJ9JIDp5mmsucOSfMTfNBR44j5j/0W2fGJYX
   c+CqS9X4zb3lQEibTehojC3WueGRhMg9r/NxmCDF4a0lKfnhUrLRDYNdg
   e4wpOIuPEa+Wp5/XS+kj+u6xX8J7sA5L+d+cM5OhjdaBfbMmzJTVspLZO
   WdyKLjGo2kNa42a3WGLuxeDWo0Wf57KlAMA2PyCfmtHsOZNo0/1xPnMv5
   Rt8no3KS7ijaQNSld2wd/sFmOF8rgriJ8i/TWUpLguHBtqs21ygDyoWxF
   w==;
X-CSE-ConnectionGUID: 4qbkjaa6SYyRTxB0l6gCiw==
X-CSE-MsgGUID: 2quAijQZQNuyzttKvKFnNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60369324"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60369324"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 11:33:53 -0700
X-CSE-ConnectionGUID: YTY6tBDWR5WwmPsnejK9iQ==
X-CSE-MsgGUID: jSNPqXPWS2mf2m6K9Wf0DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="174597723"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 11:33:52 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 11:33:51 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 17 Sep 2025 11:33:51 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.41) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 11:33:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFTAByabeWgTFUNcbeyOBC6B7H3ZcZDOZImPw51JkEw0fdhvTXS2FWJ9WH0yzVU/euwJwnoDiXhLRe786xw9GpHhIL+IkoGywoJXGKrODziUOjqnyDPUnqfY2M5/2bN06zyOO33yXiuHfHSTcGm1UhUl0ngwK+LgOSR1Zn3PhvNxXC3NzgS0QcL+AYv+5VG/cESZChAgeb6R0tEl1UjLB2hDcpZ151eok5+BqAFhGJ0kKqdO5Tv5gk1Tv0SwKVOXlLvmyMgbVuHBkrojUcTF/D+P5OMKGUSd1duD0PS2RoGOrfDNQykxzkG3w5nvry7Ll6cbnFwOGcOgeZjcMhGEzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stGCjeZKEZDAQESTCNgLTLgc0YJ9/L1SA5fcU/HMMWk=;
 b=WollW6QwiX/Ik74xdY/oPwToZ8ppV+yHw31cyXWIGVUvtGmX0P1wTCHuhEnEeLttks+q0Jy033mhccYY14pvt1sS9M3BcKtP7mi68020nMyWUV3cWA/5ayLJoQz7IhMEc3foxi+p7YBoz3oNWqM/Wh5i6WQbGzYjvR0b2avXNSNOc8mt+hlRh+J+hq0QKCnEmehVieNMeb0UrSv0gW02TemlHYmk+aMOecAceb/Jq1wjAPwvzCmfALO5QkixNUc/1fupNqaYjBm7vtxsv4yr0d36CrlTQmI1YKmHHiE0NevaHWFAhxYNbV/3IjPSu9FqBi7muiXTpUs1T7IKq7xRAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM4PR11MB6043.namprd11.prod.outlook.com (2603:10b6:8:62::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.13; Wed, 17 Sep 2025 18:33:49 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 18:33:48 +0000
Date: Wed, 17 Sep 2025 20:33:32 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
CC: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Magnus Karlsson
	<magnus.karlsson@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
	"KP Singh" <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao
 Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko
	<mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexis Lothore <alexis.lothore@bootlin.com>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 03/14] selftests/bpf: test_xsk: Fix memory
 leaks
Message-ID: <aMr+/NDFQsGChdI4@boxer>
References: <20250904-xsk-v3-0-ce382e331485@bootlin.com>
 <20250904-xsk-v3-3-ce382e331485@bootlin.com>
 <aMmlNc1z5ULnOjJY@boxer>
 <6ac21f07-45ef-4e80-bedf-c0470df47bc7@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6ac21f07-45ef-4e80-bedf-c0470df47bc7@bootlin.com>
X-ClientProxiedBy: TL2P290CA0027.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::11) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM4PR11MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: c60cecda-c753-4c07-977e-08ddf618be1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7BfbLDDpac7hekAdfQNVEBmZBuUp1q+M9lHBVd3lqntmOwWHegZ8f/Rpqxsy?=
 =?us-ascii?Q?b2yx0jgvvmvwV3+4VUceSUZ6bkAb0l1zq5nRuVfTvU0TQEfNF0UnYJa/FXNS?=
 =?us-ascii?Q?VEtV1Wq5gbladwSWTCcW9Z122YZW2WHeaj0lCo8XiBALWbTXEOiLbE4O1dP7?=
 =?us-ascii?Q?kaQY2HltxV+zouR6/GycIq2y4DN4qgmDQdsDqE6fi51e78BeXq0TJEcO6YrR?=
 =?us-ascii?Q?2qwvkGyedweRVWmwX967bT2O4D7cvG2oifoH1Rh4qjyaTGu8GR11AELEM/Gw?=
 =?us-ascii?Q?X9MA/1d5r3KzPJsrtf688zyz/LzQn0BQpcpBExWnC4sN6XtthZfVyDqnuH3r?=
 =?us-ascii?Q?cXKtCWO6KnwM8VP+/R9toZ1j7lzxw0YiwpHVrM0iY7KhYXMgnpKuP5/AMDtY?=
 =?us-ascii?Q?KtMxhl5ojEigybif5CbnPfUV6sS1vYXkAsVIK4mbXEVHbmPW9OIRGBKArvWN?=
 =?us-ascii?Q?P2lv0t16mUH2Vl9D6TFlnvDIMbf8EddnEcAZxmQm/qmyrMa+YrfAibAjNyBs?=
 =?us-ascii?Q?Czja8BI0/DxKGa/aArspy2PlQ99jN2C+5CFYksxxRANdl2rTI4DSvdfN+wR5?=
 =?us-ascii?Q?gLlhrmfRxSW6xi0IXbcFIGgMlYcLmjMwVGlPsbwel7J2mJEH4B4zjE4ZEzQT?=
 =?us-ascii?Q?k3idvMF3lpwOOzi51sD7A/F6c+uEIXPG2P/UFJeCG8YXRnpIUFJTAr2tFUqt?=
 =?us-ascii?Q?3ksw4b+n6Z1ls9myafecGNnj1ippxpLf6gw7uINHVW5+/r4sWsbEtn10rXkx?=
 =?us-ascii?Q?B/PGgPlaVhcdw/7dJYnEB9RLAZatLSojwRArj98aCQu3gdVud4sfTds9DAN1?=
 =?us-ascii?Q?MwqMO1KJF44GVGtGR4o3fGmfgsxL1fozdFZyduL0xMBoFo6QDpsxc/jTWPb+?=
 =?us-ascii?Q?5gN0OEnyEh8VgHLCb4a7cUH3YqQiA+zG4OapqEZ1So3SXMFzYQx7W22QRnco?=
 =?us-ascii?Q?Nc1EHg7GzEHqESybQnygqdtWzbfEzJQv10vtekp2nImWmhFSLOYMt889qKeE?=
 =?us-ascii?Q?in5qi8R/kGqYbzMKli452FXWxfatcGQN7DmzLmep4LJywShAbPTlfPX64+yD?=
 =?us-ascii?Q?IZmnDxAAq76jI/zfDM0tPzQU3ggkOdnZDui7NuHh/Yrai6aLERxPlZjpYWbM?=
 =?us-ascii?Q?7xAleuMStgMs0oK25Ga3m/nd8vU3IkCZzVolQkxTlTzHgv6aWPur3RuNScGJ?=
 =?us-ascii?Q?27mFlN60WmrtxOZ2JtN5FO6H6D+/g0K+6ltRVimsjn32YTL5G+t7X/vHMjLv?=
 =?us-ascii?Q?HzeKlvqtD58widAVz12FTiFJmxIWCgtNOdULnv3XK5FhzfheTjplmfNBCjbU?=
 =?us-ascii?Q?EhVflDvDgi3OQ5RTqyj5XG07UPdOfRnSrIuye3QKOJq+sboKo5Vpn/IEh9Eo?=
 =?us-ascii?Q?8LgtYHA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JJDWzmTDdT5aQ2jgE1wFGGftppWMXnHc7235da8ygOcr9gdzQdpZZZtl9Pzq?=
 =?us-ascii?Q?FJIdv1SS6QZdH/KdgFgYwebE/rU3mK3Xuw5CYYASbi4M8+8c6pnO0rqd1IIt?=
 =?us-ascii?Q?utyhEU3G3AZh1xURLoFPJlNiPv5HUmHneb+9mV7nccK7CzBgALkBW1P0kVcf?=
 =?us-ascii?Q?nTXQM0lfG7TPYnNKrfG7Qec7ngxsDzAvcF7ZWDm/b7OCpD5prD+FDyTCLY+M?=
 =?us-ascii?Q?mYOYqU8mwYXjFrgMnvzbQyMKfcmPVM3KmahlwuhTHO6JJpyND/EH9s7jvXWc?=
 =?us-ascii?Q?bi0y65CTZF16hbzNAEwMATG6JClrEWpuEOpihOcRlORc8bngfO/kjEO36knE?=
 =?us-ascii?Q?mKUIEbADrJwoqx99BjVv0z3GO3IAndnVQzF9RUQ8PjDbfYflZQunG8CsLfJa?=
 =?us-ascii?Q?RMOOs96D8fYvEC6sZXJBrQI30CJByLWP8YutK1hr9+tc+U5ovjZf98VYy36R?=
 =?us-ascii?Q?oDSqRAuj4z4SW3rSGQB/7oyGIfZvQrfhHL61PSMZt9G8TmZl9+5zLNSMdER1?=
 =?us-ascii?Q?t3tquEpq5KVtlslhqDVO6zStkkHdp6NpHPhnuNz1IShu+R6s09Zfx6FeB5jY?=
 =?us-ascii?Q?5CZrgabYQnHNHbEuFtINcJkm4nuWQkJBIiGkyIfi3nKbrFPgLjQHRfucFKWl?=
 =?us-ascii?Q?KqjLHSq+/Yx02rheU0aBQkbPkIgH+4XpMyaQT7nadfqNBkii38zATlVs8zz6?=
 =?us-ascii?Q?2DlDHpNr8Ox3Ao+JSHCVfUzFeIVDvAdHavH489Q5WFn42Uvv6CngxCFEdFUQ?=
 =?us-ascii?Q?lx56SxVO01mPHtnvE5/qlNy2wlli53tEO2ZH3aMdEghok3LJgR+wpZV41jKe?=
 =?us-ascii?Q?67V7cqaDOuqTX+vFEbn0e+90PSy8oNT5dpWicO7AKD3vOaFhiNlNYFVLgb6z?=
 =?us-ascii?Q?G7Yhq+zPfGttRXUplY+/yLwwEECEFC/aJbgg+KrjcJXNZg2AFIfRIha92Tak?=
 =?us-ascii?Q?vjPafrIlFVbu5ciSGZ14O8qVpMy8AsP2zfir7LdMU0vy0ibyNaW3QGFfC+9r?=
 =?us-ascii?Q?PBZdnZKH9MSfAX1/3tA3zHOIwj/+sm8Yz2H9qsz/xWqSAyZX1eSvpRyPEpBj?=
 =?us-ascii?Q?6xAnJbqBvrg+wznXmW0Z1Ij5RPERMSp23Yl6Qqi/NpViM5KC42PiSU/6IJb7?=
 =?us-ascii?Q?ApJQ9TaCdYdOFkmxPdze+WsPiMjoQ2sfvMfK6kUlrf4knI79ie7xL3izHLmY?=
 =?us-ascii?Q?csePSe+NWHQj/438NjLkhmaW3ekOfln0l94ljTvA+r9U07Wmt4+ZNUxUkP+Q?=
 =?us-ascii?Q?fHmiRTUk3a8JU+F7hygfjuypU3M777SbFvs1s2ih6KXoleaWZMvSiuCy+/SP?=
 =?us-ascii?Q?CXVed8NiDRsarrw3NNSlIIb0FiAi/I6/WqX5GCkWezL31VXtWA/vTTcobGBA?=
 =?us-ascii?Q?yNoQI9uTQvQLXiSCKAityCzZ3jS8ZhPyAyHS6sr0g0jP0VrzqSvW4INlSoIo?=
 =?us-ascii?Q?lfNz2VSIpDHC6tLE1mdKRcbyk7qDDdQV8C1pJVVFwP6iHd8aM4Js2V7yKfgd?=
 =?us-ascii?Q?v3ByJEAG7hnJWC+aVvPbx1b6XSmI7vzlSc9Bh6RXfUrNNhTg/06e06DEjjxT?=
 =?us-ascii?Q?CpFm0WtUitUis/xMToO71H5bih6efJRYvHW3IXDhH7z3Tk+Ile7o14lDfEoS?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c60cecda-c753-4c07-977e-08ddf618be1b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 18:33:48.8394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgE5K8FcTFynIUbHcceBj7ADtrQFunQrz22hePNUgbW/qrqgsqPnMrzbihPEonx9Gs9NRLRyuJ62QSQI1EovsrjI+af9HHm/q2Q5sm9iUPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6043
X-OriginatorOrg: intel.com

On Wed, Sep 17, 2025 at 05:32:55PM +0200, Bastien Curutchet wrote:
> Hi Maciej
> 
> On 9/16/25 7:58 PM, Maciej Fijalkowski wrote:
> > On Thu, Sep 04, 2025 at 12:10:18PM +0200, Bastien Curutchet (eBPF Foundation) wrote:
> > > Some tests introduce memory leaks by not freeing all the pkt_stream
> > > objects they're creating.
> > > 
> > > Fix these memory leaks.
> > 
> > I would appreciate being more explicit here as I've been scratching my
> > head here.
> > 
> 
> Indeed it lacks details sorry. IIRC I spotted these with valgrind, maybe I
> can add valgrind's output to the commit log in next iteration.
> 
> >  From what I see the problem is with testapp_stats_rx_dropped() as it's the
> > one case that uses replace and receive half of pkt streams, both of which
> > overwrite the default pkt stream. So we lose a pointer to one of pkt
> > streams and leak it eventually.
> > 
> 
> Exactly, we lose pointers in some cases when xsk->pkt_stream gets replaced
> by a new stream. testapp_stats_rx_dropped() is the most convoluted of these
> cases.

pkt_stream_restore_default() is supposed to delete overwritten pkt_stream
and set ::pkt_stream to default one, explicit pkt_stream_delete() in bunch
of tests is redundant IMHO.

Per my understanding testapp_stats_rx_dropped() and
testapp_xdp_shared_umem() need fixing. First generate pkt_stream twice and
second generates pkt_stream on each xsk from xsk_arr, where normally
xsk_arr[0] gets pkt_streams and xsk_arr[1] have them NULLed.

> 
> Best regards,
> -- 
> Bastien Curutchet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

