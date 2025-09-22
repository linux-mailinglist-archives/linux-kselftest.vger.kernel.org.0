Return-Path: <linux-kselftest+bounces-42086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6C8B93800
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 00:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07BBA188BD6F
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 22:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2BF2FB98D;
	Mon, 22 Sep 2025 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SYWqZpHM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41B74A0C;
	Mon, 22 Sep 2025 22:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758580997; cv=fail; b=BDGMVwH3UillA9KoSEeVacUZsQ0tF0qz26QbAXqvuOYjYEonGAhKDcDtAOBHpxM47/RXfHeVD+2mcP1AAikWeIdVJfQgCC6PQUro0TDzpVBbvjvWDsEVvAT9/V/6D/dAFl9WzKqhJtQGaQJU5SdXE4L2F1U3smWGQTNupJ7nGnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758580997; c=relaxed/simple;
	bh=XOK7/TKZGqDjudAjntMETEXwsgZl7ItMyT+htGHO5nc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=WlJEUGSP8tpRl3S+B3162q0UwbOjXP5twQkPdDW6oSmyWTYsxvKc2RMyiXBemSxLxzwMxA1ECrrH6MOmInRnhCCfeUw26E3Ok704qSAe88pJE9jfgymyE/BkkuGCkNP50nt9OBrMdK4eO55CeBkfn4HeGkDmzAhCA9sVxbtO62c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SYWqZpHM; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758580996; x=1790116996;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=XOK7/TKZGqDjudAjntMETEXwsgZl7ItMyT+htGHO5nc=;
  b=SYWqZpHM2Tl1KKAGT2aKbAWB5wFTOL00kBcfMz+1H7F9eHePtWZU+ENX
   5B5sR8qBKL+5UGVimGyWcIvqiIxeG7LULsopiF3S6UlSFM/9eMQ/W5oJ4
   +zJQJexLb84Tg4FX70LgA+cAJ9WHVHfvuAtpEqCRdIXDaGiuO11RtIY35
   DA3WhqOEzjFtFChXAQEBa7rG/5jFM9lx/akdHpP9dRp6tcKc7X8YQP0H/
   M2fMUwAOUAcdAKQ0vvddsHqQ4GjSwyKsZK1gqIIZrVUQ+enfCWBV9TRlc
   uXgddJ8T3iiYEUDEw1M4awfIQX4V/5m7ohFyc+GTgK7twzWCx2MmbmrPE
   g==;
X-CSE-ConnectionGUID: GZa8aYJ0TY+TRGKe5Hy2QQ==
X-CSE-MsgGUID: rAOAeOiKS4isIi7eH3FCKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="72277895"
X-IronPort-AV: E=Sophos;i="6.18,286,1751266800"; 
   d="scan'208";a="72277895"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 15:43:15 -0700
X-CSE-ConnectionGUID: xlapRg6MSF+9234QuDz+Og==
X-CSE-MsgGUID: RwQTgOckT0mTZhv3IDFztQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,286,1751266800"; 
   d="scan'208";a="176521943"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 15:43:15 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 15:43:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 22 Sep 2025 15:43:14 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.51) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 15:43:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWxUfXlRtNUuPO/pCPrjh8qdOwshFX+kyVC0imXS85luwBexRFYh3kXHMdYbW3xwP6x/PT1U6DIEYq1YAtW+QW8zmdR2sCOHETZklTt5VCZ6BbZKvLMyjIABu30a56obj6KRyh5CvaKwxiCJF94ETzPPCk5YSuvg0DJARIG2nK9ic32E81an2HEyEDvtNezQvHzF2XO5vokkANyQq9SUdJoHB+jymwWomYiDtP5jt/L/V3zcv/9uK0j/R1tsdZ4sciCOtjeLgJHM0QC04b9+L3KaiiXA0i972rQVBiSi/jYs4+F4xr1/DbvAC2hNBUcd8McztBvjtkveHhKEKgMm0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaqLhpE3P9+RkmLW3BsxTqcqlbPdGAf+h6TfU3qURdc=;
 b=qSv48VEq/7sz7GC490rzcYTYhRLMY0ttCVju5yoc3vh1guBeL0kAVAnEDQjnAY6v2Ttv6looVOfmFJd31YD9Tfbv4CrTthnRKjyjHKEnNOXCPBsx1wYI+cHgmcuPVijEBCzGnZciwOm3Nm3GSfYmnt1lp3yK8Mae0Xlg/b1Kb7NbEedPi1Ig9t0IUsthWf9DLSbBZuOq30ZJpBB1pNd3/gBCHQjO9RnJUjKgIjaxNe9LaMT2axPHVcUhY36s0kuluDGbQRNkduGw60/Lz/aROcTu1OPL3SEbCQJiBy7Cq3hZ5wQFDKrq9bjsf8k6NpjORO/o+kNfnvGyOLLrV6MhCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL3PR11MB6483.namprd11.prod.outlook.com (2603:10b6:208:3be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 22:43:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 22:43:10 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 22 Sep 2025 15:43:08 -0700
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Danilo Krummrich
	<dakr@kernel.org>
CC: Bartosz Golaszewski <brgl@bgdev.pl>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Tzung-Bi Shih <tzungbi@kernel.org>, "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>, Krzysztof Kozlowski
	<krzk@kernel.org>, Benson Leung <bleung@chromium.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<shuah@kernel.org>, Dawid Niedzwiecki <dawidn@google.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chrome-platform@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
	"Wolfram Sang" <wsa+renesas@sang-engineering.com>, Dan Williams
	<dan.j.williams@intel.com>
Message-ID: <68d1d0fc5ef09_1c79100e@dwillia2-mobl4.notmuch>
In-Reply-To: <20250913161717.GE4842@pendragon.ideasonboard.com>
References: <20250912132656.GC31682@pendragon.ideasonboard.com>
 <2025091209-curfew-safari-f6e0@gregkh>
 <CAMRc=MfdoB50o=3Q2p94o+f7S2Bzr=TAtWWQcDrC5Wf3Q5nqAA@mail.gmail.com>
 <20250912135916.GF31682@pendragon.ideasonboard.com>
 <2025091220-private-verse-d979@gregkh>
 <20250912142646.GI31682@pendragon.ideasonboard.com>
 <2025091237-cortex-carnage-5c34@gregkh>
 <CAMRc=Mf76m51VKktGc2K1uT4eacDqhsroRxG2RgtRyhQrhx0WA@mail.gmail.com>
 <20250912145416.GL31682@pendragon.ideasonboard.com>
 <1dc06657-e136-45c2-8012-9199194bfc9b@kernel.org>
 <20250913161717.GE4842@pendragon.ideasonboard.com>
Subject: Re: [PATCH v3 0/5] platform/chrome: Fix a possible UAF via revocable
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY3PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:217::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL3PR11MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e6f985-03d2-47df-f23e-08ddfa2967f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVBneXU3V3AzdndmU3VMZjBqbW5iTEorWUt4aHY0SmY4a2RYQmwwM2pBeXdB?=
 =?utf-8?B?Vmkvd3F6T3JhbCtjRzFtTSs0d3Zwd1B5NlV2ZmJldUgvWnQ5dXhvYk12YWpU?=
 =?utf-8?B?dUpxcU5DSlpWQVk4YXNNNE9DTTh0VGhZd3ZzMm4rQTFvdkxpVHFVRXQ2NFNq?=
 =?utf-8?B?NEhHQ3hSYWNpRjRFMWlNaXdPWWxCSHNiUWhIcEEvWE9LajU3S002U3VyWlIw?=
 =?utf-8?B?eFphTHFJNGxPTTk0TnNJakRXQ3JhSStDeFd5aTBjR1U2cEdKWWFtdnYwU0la?=
 =?utf-8?B?RWNCWk5iM0RUSXNSbVUrRVQwOVREN3pHZFFZYVRTL0dlNmVaZ094bm0xby80?=
 =?utf-8?B?UHJaeFlhMjltbWNtUHV2bzZpOXN3SUIzZVFwSGJEdHd0T0RlK29BUVRpWGRC?=
 =?utf-8?B?ZkpWajJlVkwwZzE4MkNXeWM4aXBxT3lQQXF3aHIvNFJjdlBSNktnREJNS1VW?=
 =?utf-8?B?bXZHc04xKzNVZHRqWk1JSjltZXYzU3ZadWc0V2ROVmlkeGRmNms5eVFIeFpX?=
 =?utf-8?B?d2lVS2hKNTJHUUdMRER5NTQ3VHdaRnhmb2lmMVl1Y09UbmNDZXRHNjJIOEI4?=
 =?utf-8?B?QnIzVDdrQkZMaFdScVNJMVhBeFpaeDFicVB2TW9kRmttVk02R0U0Z0dJMUph?=
 =?utf-8?B?RWM2QUtPU0VnWmdia2QvT1FpdEM1SHZ6SWhEZVhueng1RDdTT3Boa0dlSk9y?=
 =?utf-8?B?TW55N2dVd1FyU2k5WWpvVSsrZUhveGtRdW0wc3BXcWJvSTFsVktjNnVHM24w?=
 =?utf-8?B?Mi8xZ1FKekE4bHcxZW5YTWNIZDhzcDNPc2Y4aVUzUGFMelcwbFNneHFoVWt6?=
 =?utf-8?B?QzJGT0w5eGlSUXAwTjJpcVlycHk2S3k4VW9ZaWJHWkhqNlc0QWNqT1Z4N3Z1?=
 =?utf-8?B?Vkx2TWl0UldyNU1hVkxiL2FKS3RDdWxDanlYcm5ZQllyTUtGalZJOUZTZThk?=
 =?utf-8?B?M3I1Rkx3MDZBbFp4cEZVcEU4bmlDdSt2by9sQkxrc1lzd0IwdEFKaUs3cll3?=
 =?utf-8?B?Ny9tUzBBWlpPVm9iUnpidjJpcW0zQ1FoWVRCbllvUXpoOHlLbHRrUUhPZVh2?=
 =?utf-8?B?dnE5MGNrdDVYZzRITXFGNE9OaEZyMnJuUDF5OXJERzZwbUdjTFZQdTBqUTRi?=
 =?utf-8?B?REhqR1FCa0o2VXNGRXUyelRxQ2VTM211YU9peFJnMll6VGN3b2JEM2ZLakhB?=
 =?utf-8?B?TmFYdCtlcXhubDlJa1YyOXRyNUtHQnd4U1IrcjJQNzBGd0IybGVzcjNUcWg4?=
 =?utf-8?B?THVieGZFbGpWMWNtdnNWZ2JENzE2TlZtNFNra08rNnI4VDAvMElhN2VWOFFQ?=
 =?utf-8?B?YzcrYmxMejRwYjNMN0Q1K3hrTm4yU1Fjc3hJcmVXVVhhU1RIc29wazA1eWV5?=
 =?utf-8?B?MGlvM1grMjNMTG41U0t4ZGlWMGJyV0tsTjUzOFZnMGFyWE5SN0tIYXA0WCt0?=
 =?utf-8?B?NHhEMk1BTHNrRGZzeHQvOEcxVWVGMWVYRDFBZnJRREJodVpKaWxLVVVEeWll?=
 =?utf-8?B?RGk3aHEzbVA3OGJhbTRIem9qQWNuQzd1RS9wSlhnMWVVV3psRStwaitOR3pX?=
 =?utf-8?B?ZlZ3bkEzcTY1VnFFSUp6TkM1VzFrTmQ4dnBaRGMwTC85OTNqK0ZSdWJKOEoz?=
 =?utf-8?B?Y3JYTHhzMzUyS0JsdE92bWs1YzhMclV5QUY4ZWFVUzRxdkNEU0tPMGs3K1pC?=
 =?utf-8?B?SE9Ib3ZSOGRMT3d1bUxScXRmMmhpY3IrVU1MMzBSUmJPUmtRV3MrOXVndk9o?=
 =?utf-8?B?N1VXUDFKWjZid0N0d2REMzVJVldHeGpyTUxaN2pvWW42T2RkZlVkUVhnRGw4?=
 =?utf-8?B?YjZRR2p1NHRaZk11NkdOWFJnWnRLajlydzROby9kaTJhWGY5NHRONCtDK1p1?=
 =?utf-8?Q?+4sAaFBo3aOYp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1pyMlByZVFjSEUzM1F0UjZseFJtT28xZmhWZjZQby9NUWFqZjc2TENtaFBQ?=
 =?utf-8?B?T2NzcUVVMjNFNnR1N2llRDBhV1k0cFVCYlc4dnhpN0Q2ZG8weDBUUU1qUU02?=
 =?utf-8?B?aDdIWjBkSUJDSnNrSDdGSDVtUDRnWFhaY0liYmI5WlRmcDJJSlZaUjQ2Si9W?=
 =?utf-8?B?WGs3RlFESWRrelF3Nlp3Y2ZYRk0wSGx2TXhYcmJlK3A3VDVJSFRJUEltREZK?=
 =?utf-8?B?MU05ekx6VkJycjl6OTZxWkYyeWVqRzVXZE1kbzVtNTRpQXozN1hYdTdyaEVt?=
 =?utf-8?B?cmxqOXlRd3ZXaVJFQWVYWmJHUWY5VDZWV3g0anJPK3lrOER2ZXV4U1BDOU5K?=
 =?utf-8?B?REl5S0U4bVBPOHJDcXltenZxZFM0ZnlYZWlOcHZWbzVjOXN3WlhWU0Z5V3JT?=
 =?utf-8?B?WjlqU2htdkYwbWhMdHV6QjlNNG1RYXI5VGE5S3RTS1ZIMmZEOEdka1krdVVV?=
 =?utf-8?B?K2d3ZUFmOENaQzhKTjh4dGx2QUZLcWxmb3BPZnlIRHNaWEt0S0R2NUNqTHFa?=
 =?utf-8?B?c2xLRzRDb2JSdVZ0UG9TSEZ3eXZkTHo2WWZSR2pCRXg3c1QvcTl6cGUwNklv?=
 =?utf-8?B?RktqYnljTlJWVEYwMVZzNWgrazRBaFNLc1ovSHRUbE9USGJ4SUdIVjZ4ak9C?=
 =?utf-8?B?SnRCZmRySDN4OXZ3eFhJeCsybnJiK21DRnRnTzUzSGxvVGZoeHR4NVgvRWRl?=
 =?utf-8?B?eUViaW5rU3UxMDkyRDdNM3R5VkMyU0N6djdzVFUvOEt0MjVKd3QyZGxteS8y?=
 =?utf-8?B?cytZMmM0dkhkbEgxcHJwUWFuYThpSWw5QjV2dGo1dXliOFNWLzNVQzFjejBF?=
 =?utf-8?B?cVJtTG9FNURGQ3VxVVlGcmxCQitVbDk4dkp4QlQ2d1BvaDh3eitqNjl2UEdq?=
 =?utf-8?B?aHBzR1dKdVNJNzJjNTRzTzdPNHYwWUxsaWFJRTFRcitETGM2SVNOZzh1TDNV?=
 =?utf-8?B?YTh2NVFTaWhMRjJuek8yK1Z5eHJaemdGQ1BHZDFCdzRKb1NFdk1Tamw4S0tU?=
 =?utf-8?B?ZXB6dlduQzBEWUwzMkhkSlJOM2RtV051RCtHVEIyay9rM01GQis4ZnNPN2d3?=
 =?utf-8?B?VktpOGQwVTlkcUpEeDQ4QkIza1FlZEdqSUI1WUNBSGdNcDlzaXRlYWNlSW1Q?=
 =?utf-8?B?b0NFMFU0ejh5VWhUNVBzU0NrZktxUEtzdXZuMTVCeDJvN1FTZFMvc3lxQWY4?=
 =?utf-8?B?NnRraEVDbUVNeEVvK0FWWDlSMm85aFM0bW9SRlNvNjBkK1BIWWtDeGtWYUVM?=
 =?utf-8?B?WXA0NEYrb0dmT0tYVGJUR2NqUUl2RXAxejJ6aFZ5dUxRS3Vtb052Q2JVT1VJ?=
 =?utf-8?B?dWNrb3VjNzNUVEI0d3RlYUZocmRqSHdxN2pGMnUySmRWYnhWOGt3dVh2d2dN?=
 =?utf-8?B?NHI4VUlWY2xJdFdiSW1xSkdCVm1Lcm9TSlJ5Q0xvTW11N2VBekxMcW5OMS94?=
 =?utf-8?B?VWNma1NZM3Uvb1dEcS82SXkrdnZNMkdaRkxUTStONXhuc2VaQlRhMkhJQXZl?=
 =?utf-8?B?Y0FoenpSbGR3REZ5QWFsNHp3ZlBzVnpvQytuSUxEV1RGeVRxdUFTSTgyaTR5?=
 =?utf-8?B?QnUyTGFmMmJZdWlyMWpjc25lYlN2Y2VVdXhUUDJ5cGc2U2pmeGZFWjVKRk5B?=
 =?utf-8?B?dEJXV0x3RVBESkhlUWNVdlJwVEtYVWpPYjJybWc5Ri9JN2dydFhVOFdZZ2ZL?=
 =?utf-8?B?aWhCWGl3Q3FlQkFNQXJvd2UydWRtd0o1V2xoOHpkU3g1S1NuUGFxL0hDSHJu?=
 =?utf-8?B?K3FTTzFRL1VyYVRHOU9LVm5WQkhPTDNaODJWZENIZ0F2cGZITE0xV1k0Zm9L?=
 =?utf-8?B?UUNEenNLbmJKRklzUlZTdVg1aGZTQkc0cXlmaE82U3lqSXU3V2JYNkE2T0lU?=
 =?utf-8?B?M3NsR0NycytsdDU5dy9QZlcxVEVKbmlwZkt4UzBXTzdCME9BZ0lZWHduSWZL?=
 =?utf-8?B?cXB4eWc5WmdZYWtRazdWdzdybHpmNVU2SnZPNUpzdTQrem92Wld6MXBKNE5W?=
 =?utf-8?B?SEsrWUkxYnpCS1ZYelVBWkgvTFJKcnRaNmlJemU5SldNWlRsTm1mNS9Bc2V5?=
 =?utf-8?B?dFAxblZCRWJPdnNmYWxuTzB2NkFGUU1UdUNxenFEMzVWZjgvRHRXL1NkajNk?=
 =?utf-8?B?WFNTLzFNWTZQZ0F3QzBKZHQxaW9ERml5dHlwaGRRbmNpK3VSdmV1T1RGQ2NX?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e6f985-03d2-47df-f23e-08ddfa2967f9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 22:43:10.3742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lz35rwg9tn/TiDbLrVqIzqb1c66i57mAHr+BSSTEN7dleegZg/O+njLqZ73i0cXMbLk7YuPlEUaHRFgYXVLDi25/XLzLJOXWC9EYWV+55GQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6483
X-OriginatorOrg: intel.com

Laurent Pinchart wrote:
> On Fri, Sep 12, 2025 at 06:22:48PM +0200, Danilo Krummrich wrote:
> > On 9/12/25 4:54 PM, Laurent Pinchart wrote:
> > > On Fri, Sep 12, 2025 at 04:44:56PM +0200, Bartosz Golaszewski wrote:
> > >> On Fri, Sep 12, 2025 at 4:40=E2=80=AFPM Greg Kroah-Hartman wrote:
> > >>> Either way, I think this patch series stands on its own, it doesn't
> > >>> require cdev to implement it, drivers can use it to wrap a cdev if =
they
> > >>> want to.  We have other structures that want to do this type of thi=
ng
> > >>> today as is proof with the rust implementation for the devm api.
> > >>
> > >> Yeah, I'm not against this going upstream. If more development is
> > >> needed for this to be usable in other parts of the kernel, that can =
be
> > >> done gradually. Literally no subsystem ever was perfect on day 1.
> > >=20
> > > To be clear, I'm not against the API being merged for the use cases t=
hat
> > > would benefit from it, but I don't want to see drivers using it to
> > > protect from the cdev/unregistration race.
> >=20
> > I mean, revocable is really a synchronization primitive in the end that
> > "revokes" access to some resource in a race free way.
> >=20
> > So, technically, it probably belongs into lib/.
> >=20
> > I think the reason it ended up in drivers/base/ is that one common use =
case is
> > to revoke a device resource from a driver when the device is unbound fr=
om this
> > driver; or in other words devres is an obvious user.
> >=20
> > So, I think that any other API (cdev, devres, etc.) should  be built on=
 top of it.
>=20
> No issue with that. I'm sure there are people who have better knowledge
> than me when it comes to implementing the low-level primitive in the
> most efficient way. What I have lots of experience with is the impact of
> API design on drivers, and the API misuse (including through cargo-cult
> programming) this can generate. Let's design the API towards drivers
> correctly.

Note that I dropped the "managed_fops" [1] effort, targeted for use for
CXL, in favor of simply this in the CXL ioctl device shutdown path:

        cdev_device_del(&cxlmd->cdev, &cxlmd->dev);
        scoped_guard(rwsem_write, &cxl_memdev_rwsem)
		cxlmd->cxlds =3D NULL;
        put_device(&cxlmd->dev);

Pair that with:

        guard(rwsem_read)(&cxl_memdev_rwsem);
        cxlds =3D cxlmd->cxlds;
        if (cxlds)
                return __cxl_memdev_ioctl(cxlmd, cmd, arg);
	return -ENXIO;

...on the ioctl invocation side.

This "revocable" mechanism looks useful for other inter-driver resource
sharing, but not for the well known issues with cdev. For cdev and the
design pattern of "shutdown the ioctl path on a core-subsystem device
object that is also a chardev", just use cdev_device_add() with an
rwsem.

[1]: http://lore.kernel.org/all/CAPcyv4h74NjqcuUjv4zFKHAxio_bV0bngLoxP=3DAC=
w=3DJvMfq-UA@mail.gmail.com=

