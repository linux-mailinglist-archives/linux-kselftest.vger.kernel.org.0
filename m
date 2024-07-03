Return-Path: <linux-kselftest+bounces-13128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E399254E1
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 09:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6721F262A8
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 07:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2996137911;
	Wed,  3 Jul 2024 07:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SLqSmSy6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1F42C879;
	Wed,  3 Jul 2024 07:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719992624; cv=fail; b=jUNPryH1oVgma4DC9pVxztAKZy813sYZy8RU3Y0enZav/5qTKDNAnc+/+/oBNkAUM0crnLNnnh2XQyTZUTyFLOevn6a6j4vcNrKIDRW2Xx+jM+6Kqo64RyD3hIq0hOo4KYK8Oe0P728JTF7mLxNs3F/fS/rrGtqa5H/HohiUj5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719992624; c=relaxed/simple;
	bh=aB68j+CbWSHPq1DGw1v91r+gZhGLZtYtBeD7ZR0iOPI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DzP0W3KPFeNyvnNUwTVKjNJZhYC6ZgbwICu3oilEK/X1e3G+tuCfQQ8gLKPunvuKbK6k6Vb6geevKtbfc+alOQCZURxK+Ajtm9mH5/PcY1xWH44E1+dUDy7NaKNJKjPZ6hy7huipzyWupVvOnoyJXFp2l8piEhPP20lf0M29xQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SLqSmSy6; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719992623; x=1751528623;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aB68j+CbWSHPq1DGw1v91r+gZhGLZtYtBeD7ZR0iOPI=;
  b=SLqSmSy6c1Tp4kP2/VT/djEz00zj1Rhli8dEgcDuaNP7SaFEc0C9pUZQ
   aTTUoS8gwmoNXoY3RHez7EIc41DofHTtpu1Nj/zPOB2aBVPDIz779cVqC
   SqfzheMPCfohUim0XAhe2njAH6mcyGJb9WU8TW/MlR/0+ADHir+Mg4bl2
   QNulfv+TGemwD8UuhFEvxLOYKRLwc2h1oln2oIVT3xc1Buus5qEXZGTyl
   Pb7IV7KtOJ/gq/eZPzWfAjsmaaEnYugiEcKCh07tmAq0k11NBsm78qV2s
   Umcz9deGiAeXtR5oz4rLNV7YLyDiaj2h78FJkiKwPQSEB8ESChK5wLkjV
   g==;
X-CSE-ConnectionGUID: Y8K6+p+fTpGLL0SyHYZYmw==
X-CSE-MsgGUID: gS6dOs5QT1u0A5zOPdBXJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17045480"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="17045480"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 00:43:22 -0700
X-CSE-ConnectionGUID: l/a+38srThWkSaPxuDSLmg==
X-CSE-MsgGUID: pH+E8M5PTGyPzLTE2xuOfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="46074618"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 00:43:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 00:43:21 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 00:43:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 00:43:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 00:43:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eL1Vsl9dks27+VBNABWIL1cHs0ZZbDAaTjwmPC2FkDbzfUd92e71bgbXP50p0/v7OXW/w0ugcHn0picG7aLg+OW4BzcOLrwmEvgSIfpyay42uX03CW80Qh05+05RFqXLn5rAmFfP/ed2YLV8YR0PDEA5+bAfEAUURU5WMQL0Lj1Uj7yXri19F7fdSo2kpcPVlDmgSXR6soq9WQSOZTwL/wv3LSbqJUhn+2qXtXuf8+KB6qF0G4gm18bIX1tfy00zslIFX3qqwaBg0wCqFSeJSEmXTmjV5tOG9xdQeBjM+yR1Y0BVZKw1HndsE89FqHmtwEPAw8diN/pAX4zNq1vIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhTeMiO2C5cZhFeGHGGkTqSBZI/uA5jAOwqSCMeUQ5w=;
 b=a1bM+/XB8gO3hVSmJDA20huKm39mikvceNjov5uySTXNB++iY26ItML+O9A0QLkCTZMbv1kataEak6wNvo52qmFPQwwGFRstf0hY4EschDr5Z1bEteV6cIFYMl8XLHYAm5T3PLjRXlO2zcDWc0YlD9cakeFOJxCIscqeWOjD1koYh9wdoIEeHMs7iW5oY6O9STxEqnI5Ae4Q63tuzkZdUHcGgTYRpJJeiCpADKwO82k6f66zxn8KwVaQtjh+muKVBdNV3sO+/AEI4GDQG4WAYHeLSs6rdTYLAlK71Qs5gExed0iG48WHxUYu0CTHom7UdcNpajV9HLzVreGsEuZw+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by IA1PR11MB6265.namprd11.prod.outlook.com (2603:10b6:208:3e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.36; Wed, 3 Jul
 2024 07:43:12 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%3]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 07:43:12 +0000
Message-ID: <0b9210d3-2e47-4ff3-ac06-f6347627b0d3@intel.com>
Date: Wed, 3 Jul 2024 09:43:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] selftests/resctrl: Adjust SNC support messages
To: Reinette Chatre <reinette.chatre@intel.com>, <shuah@kernel.org>,
	<fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
References: <cover.1719842207.git.maciej.wieczor-retman@intel.com>
 <484aef5f10e2a13a7c4f575f4a0b3eb726271277.1719842207.git.maciej.wieczor-retman@intel.com>
 <c1ec4e04-20cd-4717-83ed-da6a55c91889@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
In-Reply-To: <c1ec4e04-20cd-4717-83ed-da6a55c91889@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR04CA0033.eurprd04.prod.outlook.com
 (2603:10a6:20b:312::8) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|IA1PR11MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e3167e-8483-479f-40dd-08dc9b33ca87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEJpdnY4T0EvVTNRc2dIV3JvdUcxWUwraWg2S0ZHYVRWQnV6akQ5S1IyRGho?=
 =?utf-8?B?MWRXMmJNRmhQWUhDU2kwTTRyRjEyYWdTWjFBWTdNRHFFSmNyV3BQbTJ2NXc5?=
 =?utf-8?B?UWU0MUp4akdqbVZHT1cvUzRVT2x1bzdsTEhseWs1Q0c5cXVjZy9KUW9WL1FX?=
 =?utf-8?B?cmx2UVpLMVhFUXFCN01rYVhsUk9adXE5RzhvRld6WFhtcjlra2ExU0FCY3Ey?=
 =?utf-8?B?Q1o4UzV6S0VVWGZUbHl5K0ZpV24zUkhIVC9IZDkvZzEvUWt5UFZ4MTN4L3N4?=
 =?utf-8?B?TlhkcWNZT3FuM0tRcG9sWjlJU0NtcHpHWEIzZGlUV2lMckJlWW1hRFdTZmZY?=
 =?utf-8?B?Rjdqbzl4K2pLbkdqUEp2emJWU0dlR1E1S1BOS2hYRDFYK1djUmtlVzhsV0xV?=
 =?utf-8?B?cVlIdWJwL3pxV3JkNk5SYXpLM25NUTNyRE5PRTJ5Q3pyd1FaQ2ozYmpwT3k0?=
 =?utf-8?B?QitPT2lBZWV4N1JoWGx4aGU5Z3Q3NE12SWdmb1lmUHMwL1RZTm82YnhGSGVV?=
 =?utf-8?B?WXlXekVDbnlGSTlHb2RUTmpnWlZOV3YzVnQxbU4xV21lU2hPMVYxOC9hTDhh?=
 =?utf-8?B?bXdaSklja0xFUS85RHNScWZlSlNOTEM4V1Y1ZkZycml1VjhvMU1LOUxJNUpk?=
 =?utf-8?B?cmZlRXhBZTNrSUpRZVNPSVJydElKRXhtaDAybXFjU3VuZ2VydjljQjhlT2NM?=
 =?utf-8?B?czViZ0ZsUkRqL0lGN3N5cFpCZXcxbk1YMG1vbU5hU1lOcngxamVZMlBDWXpY?=
 =?utf-8?B?a0JUUGdOb1VFbG03VWpranU1NC9nbS9xQjBJNG5GWUptRGFzNFgyOWdNemsx?=
 =?utf-8?B?R3A5Y3lOeGdtaTlFeGc5R0xCNWNHUFAwRk52aVl4WUZVMWtYRVB0UUtLczN3?=
 =?utf-8?B?T0hETzNUVXp5WGNoMzJjczFPNzAzeTV5anFtVTNXUkV3QXRKUEJUdXg5UnJ4?=
 =?utf-8?B?MDQrd1BRY3JqVVVyOUJjdWtBanUzcW9lUTMwekZ5Y3pEdThoRTcvWkdJZ0tp?=
 =?utf-8?B?VU0xMG42b3dKcnJBbjRucnpUcGNodzUxNW4ySXR0NUtTOE5GV0pYamRmd092?=
 =?utf-8?B?Sit0U2hRWmx2RUk0cCt6YnB5VlNWbnZhTlY3ZlhzVXZQQmw1b2pCRXBUUzNR?=
 =?utf-8?B?ZmpXV0c3OW5EeHc4WTBJTElYeDlvd2xBbk83UGh0VHN2VTNaWkFraHU4MGU0?=
 =?utf-8?B?MEkrcVl0c1FPdFhvRGpBdlpDczVrL1VaSjZKOFVEWWcyQmJQM0wvRS83WFk0?=
 =?utf-8?B?cTRScDdCenEzRVR6cEtldFBsRWJ0Vlc2OElpYzkreFo2ODQvVDgzQ29xOUZL?=
 =?utf-8?B?aDRUdDVmYjlzWW5KTVlmQkQvdkRuUERzVjJhdFJRODJhNVFlMXV4YWg5UEcv?=
 =?utf-8?B?eEtDSUVFcEU0Yk5oK0hYWm1RQjR4ODJpdlBvai9iMUZHMXJvakZxdk10V0dV?=
 =?utf-8?B?RHpNUU9JSmlOWEtGbVdYU2JsUUNZNlQwUWVSeVJ1TWU3QUdXckI2Qm90R0xW?=
 =?utf-8?B?RFNtb2IxZmRtRTcvczlnRnVkM0syNVA2M1FXZGJncktsSk5SVUxNR2x0WkhH?=
 =?utf-8?B?Um5MbWowLzFkMVNKUUs1ODFkTDJLMUNpQXpWanN4aXpkVzBMVTBKWnJLSjU0?=
 =?utf-8?B?azhaYWYydHN4UDhKeXlPSiszYnBLZ1pDbkg1ZnVabmZWZGJFdDV4cWRLUUpV?=
 =?utf-8?B?Y2pZSml5R2x3YzkwMmtLMnBLK2gzcXBSUkY2ZHcrVng2VU5ZT1FOc2Q1Z0ZH?=
 =?utf-8?B?RlB5ajlQMStaczFSb2dwYUhhZTZubzhzSGkvUW9mVjFPY2l2ZXRSYWZzWC84?=
 =?utf-8?B?aENlSnp2M3ZWNkI0eTluQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHNTK296WithVFdsSHA5YnJlQ3FJblAwL2xHSFcydFFPK09jL0NtREYwODE0?=
 =?utf-8?B?SFRTTWdKVG40UmJBTE9Pb3NyVVMwQWg3ODVGRVBZNEhRSWplNjgyUlBWTSs0?=
 =?utf-8?B?OTFTMnBGandjMWFpZ2tEVnlOTU5rNGFvQlJ2ZUdjT3JPdUYyVWg0YUowalRO?=
 =?utf-8?B?d3lQWDdPTjE5bloyM2dSQjRWYkh6ZmVoaGkxYzNHOFMzUUxoWGNUN05TVGpZ?=
 =?utf-8?B?RTZ1amFEVCt1bzBHUkNUZ3lwSTYxZm54VzhOZnBGK1A2eCs2bkJZb2JtZ1ZR?=
 =?utf-8?B?WklmejVidEc3VWtMLzd2eUNPbG9OVkxJa0NYclJQaHV2WFUrWGlxZkdkYTgx?=
 =?utf-8?B?ZHVtcnZsUFBtWXpRZEg2RjdUMnA1QlQ5dXBKcGg4YTgreUJvKzB0cC9xc2E4?=
 =?utf-8?B?aWtCVGlWTVRsN0dheXovUm5yMnFueGJaSGdGOXV4eS9SKzlkbUZDY2pEbWZy?=
 =?utf-8?B?MUM4cnNmY01vSGNoNHFqdzE3eTBYSzRVMGM2c0lZTEE4QjRsZ2NCYXprV1hI?=
 =?utf-8?B?VmpPYUlCamNNeDl5MTNWWUUyNDY1K2NBZjFvZE80Nzg4MVBUSTl2L1oxVGJ6?=
 =?utf-8?B?QTd1cmFKdndzSWl2SzZoa00wV0wvS0wrUE9EOW52d2duRG9kKzJ0TTl1YUc1?=
 =?utf-8?B?d0RMdGVwRXM3ckV4dW80WnRCRTlFVno0QkcxL2kvSzNENDFuVmJIZ2FFWXFR?=
 =?utf-8?B?Q3VJbzZuSzc5NjJpMitrTUFnRGFrOG1TeUF6dWlqNU1pa1hxVkFNcVI3NDl1?=
 =?utf-8?B?WUI0Umd6enQxekRtY2NMTHZJazJKY0JjdXFraWZyS3pTc1N0ZlZCalF6aTZN?=
 =?utf-8?B?aTNWOXRCTjU0dnJHYnZZckVzZjRIZ2hEdUo0WE95bjBZK3I1QnhDbmhLWkJU?=
 =?utf-8?B?WVNkZkRGaFg1MzNaUHVlQXZkVkxTRzIxSlFQVDlDanVjSFZ3cTROaTN5Y2wy?=
 =?utf-8?B?cDQrWDgyMkJYSWRIVlJBSSs3UmpwNGNQVlhENGxzUVVpKzhtMmFHUUo1Uk5l?=
 =?utf-8?B?dXFZNkpkOEo5UTlHVmdEWkNsZU03OHAvN2J1RnhnMG5oOGtZVWZuVkVMajc1?=
 =?utf-8?B?U3paUTZKeU5CQWgvM0NWYkhLUlZzTytpcXVPL3h2cEh2SktkV0hKcitqTHE2?=
 =?utf-8?B?NllCaG15OUQyczFkeTdPRVVaQUdMZFZ5eWp6Z25LWXJtcHA5bEJHNzVNV1hs?=
 =?utf-8?B?MndrV0tqMkVOMzNQQytPU1hYaGE4MStxZWIvalNQZ2ErRVlITlFUdHR3dTRM?=
 =?utf-8?B?Vk5yYVJYaWZNeHdtRWRJYkhXZyttUlZXZE40UHZ1MXc1V2xhTjlja2pXb09a?=
 =?utf-8?B?b1Q4RmpuVjlIcDNnRFp1cGhVMVBwcDNUMUdzOUxpOWFSY09YcHE0SVZVVFpZ?=
 =?utf-8?B?VytQb1VsbUFYald4ZS9yZVFyV08rSnhXRWpvUW1yd0NQbm53RXV0elZtSG13?=
 =?utf-8?B?K3RWdVFaTXR0Q0tsQ2VvVGdZTzBjMlFscnhrTmZvRnpSUm9EWjFMRitqcGht?=
 =?utf-8?B?YnM2SHpjRlMreTFmL3RybFVLQTVlOVJsTUdlSFE0N3ZtZjZ2NG8zeVBTOEs0?=
 =?utf-8?B?ektzaTJKR0lDMGxoUWxVdldrdFkxZmJQSWp5c1JNbzRjZi9kcUFWejlJcnIx?=
 =?utf-8?B?SU9vd3pzK3ZKWEVKM2tVcUNkc0JseXBpREo3R25vNEZ4ay92WTBUSHRxREZv?=
 =?utf-8?B?MVUvYkJsYkFiYmpRQ1FOcXhVd0MyYnFXNmZ2MlRpK0xEbnl4aHNzVkljSVZs?=
 =?utf-8?B?eG0ybFFieFdVM1pPdm1TNHJBN0lzY282TDgwQy92VTFLNzBLc0lNS3JiYnZy?=
 =?utf-8?B?dG4vRjExa3ZkcDNWN2pnSStaYTdYRnlmY2lVSEdRVHR4ZU8wcGlzQlFGdXls?=
 =?utf-8?B?OU43MFlibGV4TUtmQVIyZGxOOXRPYjJwOUZzTWdaVXZrNWdWNFBQVHYyYTcy?=
 =?utf-8?B?cUNUK1JsQVZSaGlJMTdwZ3I5ZUZLT0gvNGJGem5iaWpLWHNqZGZwQWFrUHh2?=
 =?utf-8?B?b0F4ZEUrVVVBbmVuWjUxL2xTanJadTFSczFHWkkzbHFiZURWdUt2RzFFK2R2?=
 =?utf-8?B?TzBFeHBQa0JuQ0tWRFBVa3ErYWg3WmZ6WC9ZL0k5VnJuWUQ2VW9iVUw4ajV2?=
 =?utf-8?B?WkZ6aHZuajRBbFFTdGp3VXFyZ3ZjZ3BoWmhRRlc0NUduTEFlZjViRkdtUFRw?=
 =?utf-8?Q?hRL9ReEbUp5+kwXXk5wvHH8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e3167e-8483-479f-40dd-08dc9b33ca87
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 07:43:12.5310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IeFiYXOuCxXQ5LZq1PU1T4Vvyem6EGZPTRCSa6mRZCND0IiRqknAaNTZ0ZicLNWck6fXT6rbIE60KAnnIN3phSKfL81pbhBka0Y+rUg8WWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6265
X-OriginatorOrg: intel.com

Hi, and thanks for the review,

On 3.07.2024 00:21, Reinette Chatre wrote:
> Hi Maciej,
> 
> On 7/1/24 7:18 AM, Maciej Wieczor-Retman wrote:
>> Resctrl selftest prints a message on test failure that Sub-Numa
>> Clustering (SNC) could be enabled and points the user to check theirs BIOS
> 
> theirs BIOS -> their BIOS?

Right, thanks.

> 
>> settings. No actual check is performed before printing that message so
>> it is not very accurate in pinpointing a problem.
>>
>> Figuring out if SNC is enabled is only one part of the problem, the
>> others being whether the detected SNC mode is reliable and whether the
>> kernel supports SNC in resctrl.
>>
>> When there is SNC support for kernel's resctrl subsystem and SNC is
>> enabled then sub node files are created for each node in the resctrlfs.
>> The sub node files exist in each regular node's L3 monitoring directory.
>> The reliable path to check for existence of sub node files is
>> /sys/fs/resctrl/mon_data/mon_L3_00/mon_sub_L3_00.
>>
>> To check if SNC detection is reliable one can check the
>> /sys/devices/system/cpu/offline file. If it's empty, it means all cores
>> are operational and the ratio should be calculated correctly. If it has
>> any contents, it means the detected SNC mode can't be trusted and should
>> be disabled.
>>
>> Add helpers for detecting SNC mode and checking its reliability.
>>
>> Detect SNC mode once and let other tests inherit that information.
>>
>> Add messages to alert the user when SNC detection could return incorrect
>> results.
>>
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>> Changelog v3:
>> - Change snc_ways() to snc_nodes_per_l3_cache(). (Reinette)
>> - Add printing the discovered SNC mode. (Reinette)
>> - Change method of kernel support discovery from cache sizes to
>>    existance of sub node files.
>> - Check if SNC detection is unreliable.
>> - Move SNC detection to only the first run_single_test() instead on
>>    error at the end of test runs.
>> - Add global value to remind user at the end of relevant tests if SNC
>>    detection was found to be unreliable.
>> - Redo the patch message after the changes.
>>
>> Changelog v2:
>> - Move snc_ways() checks from individual tests into
>>    snc_kernel_support().
>> - Write better comment for snc_kernel_support().
>>
>>   tools/testing/selftests/resctrl/cache.c       |  3 +
>>   tools/testing/selftests/resctrl/cmt_test.c    |  4 +-
>>   tools/testing/selftests/resctrl/mba_test.c    |  4 ++
>>   tools/testing/selftests/resctrl/mbm_test.c    |  6 +-
>>   tools/testing/selftests/resctrl/resctrl.h     |  4 ++
>>   .../testing/selftests/resctrl/resctrl_tests.c |  7 ++
>>   tools/testing/selftests/resctrl/resctrlfs.c   | 70 ++++++++++++++++++-
>>   7 files changed, 93 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
>> index 1ff1104e6575..9885d64b8a21 100644
>> --- a/tools/testing/selftests/resctrl/cache.c
>> +++ b/tools/testing/selftests/resctrl/cache.c
>> @@ -186,4 +186,7 @@ void show_cache_info(int no_of_bits, __u64 avg_llc_val, size_t cache_span, bool
>>       ksft_print_msg("Average LLC val: %llu\n", avg_llc_val);
>>       ksft_print_msg("Cache span (%s): %zu\n", lines ? "lines" : "bytes",
>>                  cache_span);
>> +    if (snc_unreliable)
>> +        ksft_print_msg("SNC detection unreliable due to offline CPUs!\n");
> 
> The message abour SNC detection being unreliable is already printed at beginning of every
> test so I do not think it is necessary to print it again at this point.
> 

The "SNC detection was unreliable" only gets printed on the first execution of run_single_test().
That's what the global snc_mode was for mostly, it starts initialized to 0, and then on the first
run of run_single_test() it is set so other tests don't call get_snc_mode(). And then the local static
variable inside get_snc_mode() prevents the detection from running more than once when other places
call get_snc_mode() (like when the cache size is adjusted).

And as we discussed last time it's beneficial to put error messages at the end of the test in case the
user misses the initial warning at the very beginning.

>> +
>>   }
>> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
>> index 0c045080d808..588543ae2654 100644
>> --- a/tools/testing/selftests/resctrl/cmt_test.c
>> +++ b/tools/testing/selftests/resctrl/cmt_test.c
>> @@ -175,8 +175,8 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
>>           goto out;
>>         ret = check_results(&param, span, n);
>> -    if (ret && (get_vendor() == ARCH_INTEL))
>> -        ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
> 
> This message does seem to still be applicable if snc_unreliable == 1.

I was going for this one error message to specifically catch the kernel
not having snc support for resctrl while snc is enabled. While the
above message could be true when snc_unreliable == 1, it doesn't have to.
SNC might not be enabled at all so there would be no reason to send the user
to check their BIOS - instead they can learn they have offline CPUs and they can
work on fixing that. In my opinion it could be beneficial to have more specialized
messages in the selftests to help users diagnose problems quicker.

Having only this one message wihtout the "if snc unreliable" messages would
mean nothing would get printed at the end on success with unreliable SNC detection.

> 
>> +    if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
>> +        ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled. Check BIOS configuration.\n");
>>     out:
>>       free(span_str);
>> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
>> index ab8496a4925b..c91e85f11285 100644
>> --- a/tools/testing/selftests/resctrl/mba_test.c
>> +++ b/tools/testing/selftests/resctrl/mba_test.c
>> @@ -108,6 +108,8 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
>>           ksft_print_msg("avg_diff_per: %d%%\n", avg_diff_per);
>>           ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
>>           ksft_print_msg("avg_bw_resc: %lu\n", avg_bw_resc);
>> +        if (snc_unreliable)
>> +            ksft_print_msg("SNC detection unreliable due to offline CPUs!\n");
> 
> (here I also think this is unnecessary)

Same as above.

> 
>>           if (avg_diff_per > MAX_DIFF_PERCENT)
>>               ret = true;
>>       }
>> @@ -179,6 +181,8 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
>>           return ret;
>>         ret = check_results();
>> +    if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
>> +        ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled. Check BIOS configuration.\n");
>>         return ret;
>>   }
>> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
>> index 6b5a3b52d861..562b02118270 100644
>> --- a/tools/testing/selftests/resctrl/mbm_test.c
>> +++ b/tools/testing/selftests/resctrl/mbm_test.c
>> @@ -43,6 +43,8 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
>>       ksft_print_msg("Span (MB): %zu\n", span / MB);
>>       ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
>>       ksft_print_msg("avg_bw_resc: %lu\n", avg_bw_resc);
>> +    if (snc_unreliable)
>> +        ksft_print_msg("SNC detection unreliable due to offline CPUs!\n");
>>         return ret;
>>   }
>> @@ -147,8 +149,8 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
>>           return ret;
>>         ret = check_results(DEFAULT_SPAN);
>> -    if (ret && (get_vendor() == ARCH_INTEL))
>> -        ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
> 
> This message does seem to still be applicable if snc_unreliable == 1.

Same as above.

> 
>> +    if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
>> +        ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled. Check BIOS configuration.\n");
>>         return ret;
>>   }
>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
>> index 851b37c9c38a..fa44e1cde21b 100644
>> --- a/tools/testing/selftests/resctrl/resctrl.h
>> +++ b/tools/testing/selftests/resctrl/resctrl.h
>> @@ -121,10 +121,13 @@ struct perf_event_read {
>>    */
>>   extern volatile int *value_sink;
>>   +extern int snc_unreliable;
>> +
>>   extern char llc_occup_path[1024];
>>     int snc_nodes_per_l3_cache(void);
>>   int get_vendor(void);
>> +int get_snc_mode(void);
>>   bool check_resctrlfs_support(void);
>>   int filter_dmesg(void);
>>   int get_domain_id(const char *resource, int cpu_no, int *domain_id);
>> @@ -167,6 +170,7 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
>>   int signal_handler_register(const struct resctrl_test *test);
>>   void signal_handler_unregister(void);
>>   unsigned int count_bits(unsigned long n);
>> +int snc_kernel_support(void);
>>     void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config);
>>   void perf_event_initialize_read_format(struct perf_event_read *pe_read);
>> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
>> index ecbb7605a981..b17560bbaf5c 100644
>> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
>> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
>> @@ -12,6 +12,7 @@
>>     /* Volatile memory sink to prevent compiler optimizations */
>>   static volatile int sink_target;
>> +static int snc_mode;
> 
> This global seems unnecessary (more later) and also potentially confusing since
> the get_snc_mode() has a function local static variable of same name.
> 
>>   volatile int *value_sink = &sink_target;
>>     static struct resctrl_test *resctrl_tests[] = {
>> @@ -123,6 +124,12 @@ static void run_single_test(const struct resctrl_test *test, const struct user_p
>>       if (test->disabled)
>>           return;
>>   +    if (!snc_mode) {
>> +        snc_mode = get_snc_mode();
>> +        if (snc_mode > 1)
> 
> 
> From what I can tell this is the only place the global is used and this can just be:
>         if (get_snc_mode() > 1)

I wanted to print the message below only on the first call to run_single_test() and then
print relevant warnings at the very end of each test. I thought that was your intention
when we discussed what messages are supposed to be printed and when in v2 of this series.

Do you think it would be better to just print this message at the start of each test?

Or should I make "snc_mode" into local static inside run_single_test()? Or maybe add
a second local static variable into get_snc_mode() that would control whether or not
the message should be printed?

> 
>> +            ksft_print_msg("SNC-%d mode discovered!\n", snc_mode);
>> +    }
>> +
>>       if (!test_vendor_specific_check(test)) {
>>           ksft_test_result_skip("Hardware does not support %s\n", test->name);
>>           return;
>> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
>> index 18a31a2ba7b3..004fb6649789 100644
>> --- a/tools/testing/selftests/resctrl/resctrlfs.c
>> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
>> @@ -13,6 +13,8 @@
>>     #include "resctrl.h"
>>   +int snc_unreliable;
>> +
>>   static int find_resctrl_mount(char *buffer)
>>   {
>>       FILE *mounts;
>> @@ -280,7 +282,7 @@ int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size
>>        * with a fully populated L3 mask in the schemata file.
>>        */
>>       if (cache_num == 3)
>> -        *cache_size /= snc_nodes_per_l3_cache();
>> +        *cache_size /= get_snc_mode();
> 
> hmmm ... it is not ideal to use second patch to change something from first patch.
> Just having a single snc_nodes_per_l3_cache() will eliminate this change (more below).
> 
>>       return 0;
>>   }
>>   @@ -939,3 +941,69 @@ unsigned int count_bits(unsigned long n)
>>         return count;
>>   }
>> +
>> +static bool cpus_offline_empty(void)
>> +{
>> +    char offline_cpus_str[64];
>> +    FILE *fp;
>> +
>> +    fp = fopen("/sys/devices/system/cpu/offline", "r");
>> +    if (fscanf(fp, "%s", offline_cpus_str) < 0) {
>> +        if (!errno) {
>> +            fclose(fp);
>> +            return 1;
>> +        }
>> +        ksft_perror("Could not read offline CPUs file!");
>> +    }
>> +
>> +    fclose(fp);
>> +
>> +    return 0;
>> +}
>> +
>> +int get_snc_mode(void)
>> +{
>> +    static int snc_mode;
>> +
>> +    if (!snc_mode) {
>> +        snc_mode = snc_nodes_per_l3_cache();
>> +        if (!cpus_offline_empty()) {
>> +            ksft_print_msg("Runtime SNC detection unreliable due to offline CPUs!\n");
>> +            ksft_print_msg("Setting SNC mode to disabled.\n");
>> +            snc_mode = 1;
>> +            snc_unreliable = 1;
>> +        }
>> +    }
>> +
>> +    return snc_mode;
>> +}
> 
> I think the SNC detection will be easier to understand if it is done in a single
> place. Can the static local variable and checks using the offline file instead be included in
> existing snc_nodes_per_l3_cache()?

Sure, that sounds good.

> 
>> +
>> +/**
>> + * snc_kernel_support - Compare system reported cache size and resctrl
>> + * reported cache size to get an idea if SNC is supported on the kernel side.
> 
> This comment does not seem to match what the function does.

Oops, sorry, will fix it.

> 
>> + *
>> + * Return: 0 if not supported, 1 if SNC is disabled or SNC is both enabled and
>> + * supported, < 0 on failure.
>> + */
>> +int snc_kernel_support(void)
>> +{
>> +    char node_path[PATH_MAX];
>> +    struct stat statbuf;
>> +    int ret;
>> +
>> +    ret = get_snc_mode();
>> +    /*
>> +     * If SNC is disabled then its kernel support isn't important. If value
>> +     * is smaller than 1 an error happened.
> 
> How can a value smaller than 1 be returned?

I think I left it here by accident because I was experimenting with other ways
of detecting the snc mode and then it could return errors. Will remove it. 

> 
>> +     */
>> +    if (ret <= 1)
>> +        return ret;
>> +
>> +    snprintf(node_path, sizeof(node_path), "%s/%s/%s", RESCTRL_PATH, "mon_data",
>> +         "mon_L3_00/mon_sub_L3_00");
>> +
>> +    if (!stat(node_path, &statbuf))
>> +        return 1;
>> +
>> +    return 0;
>> +}
> 
> 
> Reinette

--
Kind regards
Maciej Wieczór-Retman

