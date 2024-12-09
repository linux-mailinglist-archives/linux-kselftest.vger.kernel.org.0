Return-Path: <linux-kselftest+bounces-23093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DC29E9F50
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 20:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624801659E8
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 19:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC88E19343B;
	Mon,  9 Dec 2024 19:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="molubafU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D41F1850AF;
	Mon,  9 Dec 2024 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733771979; cv=fail; b=PqQys6pIyjGI0Dk9U7Pnlbh8Eov8om3094KHBovHkc9SMJGAMIm18+Wh8UNSKGB1kGe5p4Q/9LF0m1vCkfcb/PqRn0OC40YptSkyCxEFcrkRg3tdZBECYTOjpzZ8VSUJCfRNktSMF0gBA8/Sm/SPD0Laj1rF+0ASnWPR0NuYlEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733771979; c=relaxed/simple;
	bh=gWqFDuoCFRxULKDHAF/inYjBZZhOit/sg2N2dBgC9XE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f1oKVrIkkQJGJsjO/X2R+3Kg3vdRg+5DVlCiHkybEeJznwH/ZQrOcaRV4TsQq0C57CGg/5bxmETGqCt0OJQ7BVX0TMrk0EIQi+xNskkgdhTS4sCm3vkpnDc775D5EJyHhtS5qhFFphmVcNbuun180fH0cTETzXTaBdxzQxkI8hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=molubafU; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733771978; x=1765307978;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gWqFDuoCFRxULKDHAF/inYjBZZhOit/sg2N2dBgC9XE=;
  b=molubafUsYz90LXaIUwlX+3hz11XCOfKgRTy+a4BkKNMA41rTi2FTpMn
   oKu8umycfztc0QFHGBCDB+vW1JRMjudw4jVpqFYWEvW8h4umGxnVPx6bu
   6E9cM7tjB/q+WE3vg7vv+oiwaKH3PRF7ZRaAdQS4ZFWUm+V/qGhI7c5is
   rpJBAqN9/jlwhTG964QvpLTt4OIBQ97gM03ODbS62/5SdybE2ArygGo6s
   +IJqucwurNrdtqxfnEmyZxFYV0TSoFykas9tpzG1hb+q9xvpUTVpSbP9t
   xMhim8gsqmmNacy0TUbb9lQAXnqLNslCLrFyiTgOjqEYLqo5hNz0toNwT
   A==;
X-CSE-ConnectionGUID: bkganWU7QtS9fWbEC5oaWw==
X-CSE-MsgGUID: xZvOirSWSWGex9K0Uc+hVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="44556909"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="44556909"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 11:19:38 -0800
X-CSE-ConnectionGUID: pQsdVHukQ02Ia9chHkwJ3A==
X-CSE-MsgGUID: Rc8qwFTlQH6D+9rK5Dux8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="95365971"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Dec 2024 11:19:37 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Dec 2024 11:19:36 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 11:19:36 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 11:19:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPdPcDMgB8W9nTM+VbmFECnuQShyM8tHa1SoPBAn1RvkV9zJ6qYJJgiEKdMlPmQiCdFpxKHWZHO6bjtF/SAVycyjJ1rTCA4E3jSFNVIvGo9nocpojOhlMbshX37ZBsWysN3+tO12eDS+Z5by5RjHV8ATslUofvBqZNqtQrihDLLe9JUPF3TjVlh8+pJK/ZhHzYcIfcM9ILbIKjjUyhoJOtf4D9YZLc/HvhNt/8zyeLMF/QQPgfEEIGY40BDB26KqEFdkCojY2Ty8cA3zrXODu8bNF5lUq+rGMmwO2/7yo3Ue4d2gEiLWgF/syrryBrq/nX+qUALGJ4zttHmkzfHIYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqTIOQjzTfsZtMZ6Z3pkVaRbNIKV7C4UpTSEpNpYIsU=;
 b=ob0YW0VDkLLRsN87EZKDZ7jpKVPYXaUCrTrwr7vJwhhpcPzMBSDbbGxG/ZmYUou+KAGWWgze2aGunDNby58hjFMPLUQL0axpkMcgeuACb6cdX/DAu9ZPvKjQvIkxo+beevdoOtPxl8DYuRVtZeP+V4XmfGLEr57a72aZneA50iWHaPvDdkmyzZXi7YOEckeU+KeaiWXzMMvfohiJtTjkowPn16dVYrVFdLcPsUQLHDmI0v+QKZl1izKMSqQRNPnrJ1zQpyA89V36hITi8bQi6X4v9BoApuVI8gj3bmDjgg2JZ1Lqrq6DKmn1rBH/163w+8zHaCEJeX30814KeCJdmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6464.namprd11.prod.outlook.com (2603:10b6:930:30::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 19:19:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 19:19:33 +0000
Message-ID: <ca2b665a-79da-40b6-93e1-533fe1c46cda@intel.com>
Date: Mon, 9 Dec 2024 11:19:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] selftests/resctrl: SNC kernel support discovery
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<shuah@kernel.org>, <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
References: <cover.1733741950.git.maciej.wieczor-retman@intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <cover.1733741950.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:303:16d::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: 58b6c33f-954f-4c7a-0484-08dd188669ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3FWRHNRK2tuUTAvMGRGbWRsUFgybDEvR1ZOMDhhQWFPU09vOEx4bE1qSGQ2?=
 =?utf-8?B?d0l5aVJFKy85Z1Z2OEYvbFdSUUo1eHFrWVpmazZyNk1sSTNidXFNQ1M4RWY5?=
 =?utf-8?B?UlRmbElzRE9ocm1VQWtubU9Ob09GWjlrSHd4TDhITWM2OE9kdnNBR1F1YWx3?=
 =?utf-8?B?ZGl3U0R2cmZFS0tMaHZ2Z0R3RlZyR0pYN1Ztd3pDbkd2WHF4cmQyWDlOMmdZ?=
 =?utf-8?B?MGlob2lkRWo0Sk9MZFY4ZFFvYnFQK2trTHZ2YThiaXBBOVhDODVzdWo2cmlZ?=
 =?utf-8?B?blovaFF3aGdFQjdzU0Fkc1R2R2pYdUxzWHFXYWtJV0M2VUMxMDAxeWdqa3Ax?=
 =?utf-8?B?U2JySzluaDFMTHkwZ203VnZQaEFYY21ad2Z1K25zdUluQXlmV1dtT3NZZUtH?=
 =?utf-8?B?N09BcElOejBTM1YzcGk4NXFlM2krdjdaTGxXdUJwUWdpd3ZDd1RhbFVzUndT?=
 =?utf-8?B?SHd0aktvVXpaVkFCcUJrUGFyNldjdUErVmlYcThrei9Wc0lHdURkOXhPcFBL?=
 =?utf-8?B?a0xjM0lNa25IcmNSRE1rci9MaXRieFhQQTNKcjU1WWFZaUdmLzVhN0w1R1JF?=
 =?utf-8?B?OHIycmVVRG5ra2R1L285TmtKczc5K2JiOVUwVlQvN3FsaDV4alBmdkx5dmhG?=
 =?utf-8?B?ZGtjbitoZTBZTG9IeS9SRHM3UENkb2NPZVFwWUZ2b2hCeVdPM01EdWtRVDNO?=
 =?utf-8?B?UlpObVV6TERmMWhjZlEzb09IenA4WFJNY1o4MC9lL21kcUdmcTV4V1FNQTky?=
 =?utf-8?B?ZnNtcU9jZDBCcENmOS9HMlFxdXowOS9WRTRadFhvS01wNGVTbXVlcVdQQ0tm?=
 =?utf-8?B?MDRCWU5DUSswQnRtVmJYYmRYM3loa3BVeTlWSWQ4VGlSd2RSWWpZVlIzT3hB?=
 =?utf-8?B?eWFiRTRDaW1qbERPbGZVRXc3ZDkzOU9YWS9TUTVLc1FBWVVlT0ZwdlFRUVZF?=
 =?utf-8?B?SzZQNm83bVNlWDhMbnVNQ1JxWjdLMHBMSzc2MTBGcHdjMWFjKzZnWDNrY1Y3?=
 =?utf-8?B?amUzSE5MWG4xSnV2bHJBR24rSkMyWFpsSlJxMzBKa1liaXhuekxZVklHbm5l?=
 =?utf-8?B?NDVrNERXQXJCYjJadE9qY1lnMVJINEZwNWpOaktBSmNHa3FOQ3B1emNXMTBu?=
 =?utf-8?B?QmZiQ3oyZURzYlRYQ3p0bHpQQjhmQ0I1RFBDOExVRHRjOU51eFZiaDBlODh0?=
 =?utf-8?B?bXdVZ0VScnQ1ZHZPTVk1Vk5aUk9IOU40dWxmRllzN3JBRVlKUklkQXA1ancr?=
 =?utf-8?B?RUJsSHlHQVlqTFdjQ29jZVFCZ3lXNFZCSjdMQjBrWUw4OUlCS0toYnlTcStY?=
 =?utf-8?B?VHJLS3NuNEV3aWJuYUlCQzVrSHNEbG9COHZ1NTdaa1J4dlRUYTBYQzQzUDVX?=
 =?utf-8?B?MlNuaEZsSFhUK2p2bVo2a2xhOVpabmdqelAyVFJnUEtGZlExYThLeEVBNmpn?=
 =?utf-8?B?VGZLeHBsT2d2Nk15SSt6NEdENHR1VGhvZlFtWWE2K3FPN3dkM2hjWHZ3aDh2?=
 =?utf-8?B?bnZwQVdNUnVFUkxDVytYbFVvRGlWOHhVUGdtaHNEeWNFY0JpN1JmaVVDSVVK?=
 =?utf-8?B?L3oyZTUvK3M4a0dJY21FTU9JT2pYVWQyKzQ4YTBudlBqTlFveEdXNUM4QUYx?=
 =?utf-8?B?YzdpWnJyQkZYZ285TWZtdVc0Rkd2cjd0NHc2SVE0R0RhczM3ZHU4aUhSMzdR?=
 =?utf-8?B?ckFxSHROREZuaURxbGVNYUh0YTVyNjUzM1ZsbGg4ZTFNcTlNKy9BK1dxNmlK?=
 =?utf-8?B?a1hkcGdpcHdyYVVkWFJESGN5bmtsSXN4SmVJR1F3QjJ0ZWJPdmZ1SkxFV3dh?=
 =?utf-8?B?K0VZdDQ4aGsrdDMzQ1lHUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUpOS0hPVzJpM3lVN0J2Qk9vWTh5THBvU2o5RHBqV0laTGJkSGF2eGt1c1M1?=
 =?utf-8?B?d2ZWcjNjbnc0czk2bmdRWEE2V2cySXlOOE52NUYxT2ZMb2R0dkNCeVJ6QTNp?=
 =?utf-8?B?R3pyNk5PTk1tY1JZV1daVDFBOXpUeWRtQTVGNWxlYlgyV2ZuYUpNc0E5T3Fu?=
 =?utf-8?B?NkNXRm1qSmRSL202RC9hZFN4OWFzazN0UlJ6U05qSU1rQjJkV0Z5czZkVEhs?=
 =?utf-8?B?bGh6ZHdqOVdGVFUvUEI5ZjNWVWJUL09OQUxJbkNiblFVYW83YkxjNUdHRW1j?=
 =?utf-8?B?QnJoSmx4My9yYkp3WVdRTDFidUE1ZzRvejhIL2twdXZGbk1CenZWMm1neXVF?=
 =?utf-8?B?R0dUNTZKeTFOL3QzdlRMSXR0RFdoMEdKQ1dCaFBoZXFKMm9lblBPdnpLVUpM?=
 =?utf-8?B?czh2bDVqSlFaUEdnd1NyRHd2UTFKVjVaVjI2SDh2eTJFTFQrOXdMNkdjNS91?=
 =?utf-8?B?UmY2L09TdzFtbjBwNUJTb3IwcTBOTmM2Q0pHMWdqT2o5Nk1sQ1F2NWZ0ZFZq?=
 =?utf-8?B?S2FGVU9GRk9XNVRnbUZWRStkNzBmQkpYandTQW93L3VaLzBTMkFCVXcwaDda?=
 =?utf-8?B?RVBIRUV0bWJoN0ZWWnl0dG9CK2N5NDNvNmNvOGt3a2tlb1NESm1iTGg2c240?=
 =?utf-8?B?QVdGOTRHWFBzZVpkckhmRVFYL2lXUzF4SWk2clA2Nlo2dkRZbG81V3dVRjNS?=
 =?utf-8?B?ZXArVzVwbHoxMlJtbjk4OXBsTjR1d0RJRjg2cjRYWGlBVGRaZnkzeC9IOHJi?=
 =?utf-8?B?TXpxUTU3N3RsQzVvT1hZWWhIbmg3dmxINFpPWi9Ca3B4MnlTYkZhU3liaVRU?=
 =?utf-8?B?YThFdlVYMjlhOGFKdGNqQ2dWdzhUZkFVMEMyQXYrejNkMmZOdnpoRmRQS0dM?=
 =?utf-8?B?QTNWeGpGdlZqYnFmUG1wVUdrNzkvejg3UGhrZWgxTFZRSSs1aDUzL1hGTFcy?=
 =?utf-8?B?aHNlaUovMjFtOHF5TE5uN3h6dnJablhuSTB4djZLYndDU01zQ0tBdC9qUjVj?=
 =?utf-8?B?Q1dmaEg0NmcyRldXbUdqam9vSStYc05MNXJLQnRoOGl6eThENU9QSTYxN3lu?=
 =?utf-8?B?TEhIZmxHSkt1bXpIUFlPdVdIQXlaVUw4SkdTVWlWZS9VUHdUdXJpVldJT3JU?=
 =?utf-8?B?dTlBZmM4ZmExZmdWSVBwSjExdDBXMVJPV1BWYjIxZUlYckQ4Skh3dGpHTHF1?=
 =?utf-8?B?Q2swdmYwNHJvazUycExLcEt1T1FOZElkQjh5amdkWnBSNG5rZSt6M1JUNXJX?=
 =?utf-8?B?Unp2VzNoMEQ1YWVkbWpJa1FHWVFxY0JFOThINVErZVg2WDRyQTltR3p3OU8x?=
 =?utf-8?B?TXR1OExSYm1wc0sramlkOXlLMEEwQUtBY1kydTlqS0xERW9FaFozM3NWbVdC?=
 =?utf-8?B?UVBOeGZ3aWJDUVJqWGNGZmNqQUVBTHdVR25ycXdxSmFscUkzZWVmeFN5WDlG?=
 =?utf-8?B?K0xnMFk5Q3hyM2xCUk05em93NFJPUmpuRTNjZ0dpa3NrcW5lR1JNbTQ3eHZC?=
 =?utf-8?B?cjhsa3lQek5GOHVsRnBmUTNmNmdnVGRRT3hCcThDRU1ZdjhmOEh6Qk9vQ2l0?=
 =?utf-8?B?OWhkOFFLQTZWM2UzU0NEL0x4YVovaTE2UTNaWEs0YW9PdHRJd05BOHBoWlRo?=
 =?utf-8?B?c1IySU1QeURPcTllczAxR2NiVkZLazZrY3ZRbkx5Ymx3Wmg2NTFvaVBuVzZ0?=
 =?utf-8?B?TEZrQm1Od2RFVDhGYmo3RlBlSVJkaHFOZENyYkxEYmtJR2RSdjBmNlAweFl6?=
 =?utf-8?B?MDFmbDU3djlhNDJHSE5pekgxWlF5RGpkRjhzdHhuNDFDcGE0dmFvdTY2c0sy?=
 =?utf-8?B?c2N0RlNUb0VEd3V1OXVZNm96V243b0cyZW5EZmJaaHlBSy8wL3dtTjhLV1Zn?=
 =?utf-8?B?WlZiR2Iwa21xTGVwcStZTmZmQXdpYnpQa3pncVA5OUxISjZNWEtHYXhxR0RH?=
 =?utf-8?B?K0w3N2lhL0ZEWlFKaDVZT2NpZjNXcGpwcDZKM1NidkZLQ3o2aExkdVYwMXl2?=
 =?utf-8?B?b2trMW1pMWc5U2J4dUhFU2hHQlEzSlJHaXhtRVNHK3UrQmsrWkxZdFphSWNT?=
 =?utf-8?B?MnpnUVVMYmJnY2Mrb0pXY2VTSk0wUzdXbWtRVW5kYmh4bWZ6OEM4Ymp5Vnk0?=
 =?utf-8?B?YmtldzdvanEzQ1htd0VVUjVLZXU2R0Z0aVZIRjBMWU5HSGtkUkt2VG5rRU9i?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b6c33f-954f-4c7a-0484-08dd188669ba
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 19:19:33.7217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRIBPmS9+7n07OlcP1cloFw5umw+s85h70HUmXDuhT0D71lEqgIN4o2UNsdHjL09tFoSqkA/aFgCdELrFQbt+AMN8fI9n1lRlpsCmJ4HDR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6464
X-OriginatorOrg: intel.com

Hi Maciej,

On 12/9/24 3:09 AM, Maciej Wieczor-Retman wrote:
> 
> Sub-Numa Clustering (SNC) allows splitting CPU cores, caches and memory
> into multiple NUMA nodes. When enabled, NUMA-aware applications can
> achieve better performance on bigger server platforms.
> 
> SNC support in the kernel was merged into x86/cache [1]. With SNC enabled

Please note that this work has since been merged and can be found in
kernels starting with v6.11.

Reinette

