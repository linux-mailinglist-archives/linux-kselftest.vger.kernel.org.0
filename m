Return-Path: <linux-kselftest+bounces-781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37097FC96B
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80533B21330
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FB750243;
	Tue, 28 Nov 2023 22:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DhFlPWB8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002101710;
	Tue, 28 Nov 2023 14:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701210178; x=1732746178;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CipIQDjLq4T+hS7NNWaI/AczTkp6p3JuH6Ink9PmL7w=;
  b=DhFlPWB8BWOc5BugsZQ8VhTnC5gPhdFugpqbeW+vT0pLZ6vbn4WDfQvL
   66jAuRQ5uakvg+xrXhc6yBt/lUCbR9yEUJ32tDYubsY2bL34a6XP1+pLU
   EAA0Q/FNjTQ70geTgo3cuLUrt+YMyODIobG5e4vFPnTnReRN6cfOcnNKY
   /yG7a0X7v6HJjDTyt3HWw8criY0rN4ze1KWSUDqwq4w73zjysEVTfHELR
   RIakvuC+QOYe7+4Qq9VY9W5eavD6mulk3iPLY5uLCU9XINnz4X4CZaIvU
   xqwN8YKBjRqGw+hT7Q9poOi8/6TJMC5Pg5hFTvBwM6KdTJF7gpdYAXk/X
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="6250508"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="6250508"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:22:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="1016057362"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="1016057362"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 14:22:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:22:57 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 14:22:56 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 14:22:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKL2MFwOnB/cbBCBN8PKYlLnAV8sl+9Ba0UHtv6IG4U5qnooxPpiqv61y8ByuKUAD3Gdey/HtH3jp/TNgroTDtcM+ecQFPhiW6wfoOa0qMo7W7ohhDphlnj0rrkdPX9YoaJAB57C7l/CgWbqmKT8DalvykwpIYL2+65Ldz/pNdte6BTNYLCGoGjzI75vWDnWdxe6OLwRaigUJbXE6I3xSIPvFbpbGyxPRGtFdj7+PvBpSPWHp4FsRhp54hrr3ybUIIE32B7tsYhOX+hY8gNu283Q97daVkKyi403TzUtAN2pzuT/R6CrHmKfudKOT53zibQPkzt8yp6rJM0s/+Fy9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBU53ZhM8gFC5/QY3ohXWKXLDL7MrrUHzyrKJOX9M8E=;
 b=hy9kKuzoVhanvO5oakj17o4vwzqjlO9D8eD9ZFjsYPywwZ4Vvk4qhgAUsAJpbC6kYI0pTUAyMeoNbl4G59kpQjDCIsaynRGqIANh0xUoa+nJo1Wf+MoVm2NFYeeaicOdK6CQJXjmgsyI/Ax7tU/y65oQpoWp2sIxpxk5xt04BcYgJXAt8zwgldFYITiypkwN3wM6EOtPkVdrZ3hHn0rPTU6r+A2VANsVSc8ejs1BKJsm5/tt5bnVszFNyMpPM/HOiHFZcg/ihc5vs6Z0uuzo4QjhIDyyvODJdFQRkcSfp0B2SNMcHzckPXD0twjQ1MZWZNcGVPsA1w7t/TinDz7KhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV3PR11MB8744.namprd11.prod.outlook.com (2603:10b6:408:215::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 22:22:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:22:54 +0000
Message-ID: <2787018d-9661-4169-9571-a4016691cfa6@intel.com>
Date: Tue, 28 Nov 2023 14:22:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/26] selftests/resctrl: Add test groups and name L3
 CAT test L3_CAT
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-27-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231120111340.7805-27-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0310.namprd03.prod.outlook.com
 (2603:10b6:303:dd::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV3PR11MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a94fb6-117d-481a-802e-08dbf060910c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/t6YJPSkr4fJqCDnBgH2wXc15izetKi0TuUpKdSDWxD3vhNAAuKbrjMd9jZWScFTdAaAmsNlMXl7Y7yewZakioJBBZ6vseLc2wiBnmq2jqzhPiUIFBrWAvpXKTj9zoO4cCCOEqW+Ru9ezljg3bcrj+avdmRJIP5+BOAzB/1taVDPd9vCNOKVQUFApB/1IXnNrCVwnO8wZCrswz/UVIt37h7susb/Vivvpo11kk/AnBIm04J7czI/oAtRuYz+903DNIJJUJR6iu40oZt5HJDdCPFHXEiiWsQtdMNdt4iFEHwpaV7R6oZf3zwYcKDcOjtHSELOIp68qVIcWvTIhJYULHUwKEflQktyau/YI2tScvWbMjX96b7QxP0xjI/d4o1Xzcyd0R0DrKsZqyiVgpGgX0A5YfK8PzETxlHje4ST2phQ+c4QtxzrxI1t00JplfCC1VPiVkTPQv5gpbw5fDzoxZGBaeSF88R2ZrUVNYLSvkme/t+OFWQpPK32cavPThdEFW6fqQVPltkHi4NFemSgmc+LAZ6xthqo7MGV+apw8/o0wAjdPjCiyGLMv5838iLJHbIb0XBy6vKpjWtYcT9EizFCOa0cLIMwWUjlb5B+XCPkDsCweH57nksIbKy1dPQeYm+11Nwd9SLd8iH6NAkeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2616005)(38100700002)(41300700001)(36756003)(31686004)(4744005)(86362001)(5660300002)(82960400001)(26005)(2906002)(44832011)(6512007)(6506007)(53546011)(8676002)(8936002)(4326008)(31696002)(478600001)(6486002)(110136005)(66946007)(316002)(66476007)(66556008)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXFUS2FpQlBjUTlJWkhEZHF6Sk5Xc05aMGkvZVMxTFNmQk9wYmpxWFk3cGkx?=
 =?utf-8?B?dzRmZ1RTTm9kdnc0cUgxN1A5WXRaUVRYamcvRExZQXVZRVZSSlkyaTRGVFVi?=
 =?utf-8?B?R2RITUdMQWEvY01IQTl4TkJDZlJXRCtRZnB3M3FlcHFqTEpCSGl1cm5PL1V2?=
 =?utf-8?B?MjRzZC9EQW9GelB1cVhjTFY1R2ZPR2orVTZ5NEZjdlZ0dDFtYnkrMUNVbDhk?=
 =?utf-8?B?OWdnWUVvcWI3QVJVV3owNWgzVDFhTWRxdi8wMTJWQUpQRnE0aHMzdHRoTHUz?=
 =?utf-8?B?NWF4cXhibDNOVHBiZ2RMV1JrNVVUSElabVY1L3lidmcxZEorTkk5ZGJzcXV4?=
 =?utf-8?B?eElrRE5GZ1pWaDFYVUN1VjBuaFN5TEJrV1o4TlUzcjd1RTJuRnhCWGRXMGtT?=
 =?utf-8?B?eUVKM29NQ0pPbll1cGJ5dkQ4UXVsR240UkdMbFg3Z1VoYkZFUi9jaEc1V0NU?=
 =?utf-8?B?c0U4eU1oMU9XL2tVd2l0L1d0SVZrU1B0VFhkNlhrQ2htUEhrZ3orc1A1WklS?=
 =?utf-8?B?ZEhCeCswWFB1cE1QR3UxQjloSWpSVXEvaUVMRFA0N3NvT1piTmRRbE1Kbklj?=
 =?utf-8?B?MDJWcGZqRUhkeXVlQ2pVTXBBWjFkVTEwWEJwV0ZNOEZMYmVKaVhTczBlekY4?=
 =?utf-8?B?ZUZ6bHk2dHZVM211WlpwS25pYU9XMmJPZVE4cG5BZktFdmthV3lkc3JXdnFJ?=
 =?utf-8?B?UlNzd3RjWUErV0RiZWFaQnFCQjA5ZGZYeWNhbEg1OWJNcFlEZlJtQVNMZ0lJ?=
 =?utf-8?B?TUszdXg3SGpaaE4rQ1EyMlRldzdGN3FZZzZMWGx2L05qcnB3T1A5am1GT3p2?=
 =?utf-8?B?RUd4eDV4a3VINHJ0RmUrRklHcSthUFJSVjJLV0QzajZHcVpzbS9nMElmcDNr?=
 =?utf-8?B?Z3kwblo1NkNocUxDbHdHNGlSZ3Zhd2M5bGJDdi9GaWZBckN4ZVY5RGhpUHo3?=
 =?utf-8?B?RFV5di92RTh2OVFmZFpjd0k2Z2ZiMnp3M2UzUGpNYmphbGRuR3FBRHFYcHFY?=
 =?utf-8?B?NlN2d1BicFhjdWd3N05UaTVuQnVzV2xUdm9mNWdmb09UcFpraDZWcFJWREFy?=
 =?utf-8?B?bDNKUXpPZm8vc3JPWlBUZk9qWDJMS21odmVBSThVcmt3REx2aGNIdkk4OFEz?=
 =?utf-8?B?MUJScEpLaU41b1A4bnVvalY5V0JzVWh5dmRqS0MweTdPdzhGZnBBT2xzem9q?=
 =?utf-8?B?REgrRFBtTXJYU1JGeUxlVm1DT2drUVZoV3FBSTZUOTY3bUx3VHRtVUVGTmFz?=
 =?utf-8?B?dDVZb0xIN25qWDIzaU5hUW0wRkxsWEdCTlFqWUYzTThQaFlZKy9mU0s3T3A0?=
 =?utf-8?B?RUQ4bDFoSjQ3Yi9IWlA0M0R3RWhsRDY3dHlrbi9MWnJkQkpBUTNlakdQcjNn?=
 =?utf-8?B?UkVFZ24vczl5NmRWaUJpb2FDeG5TMVBwTmZIekRmYTV1WG9Nd3NZQmp6dGpv?=
 =?utf-8?B?UldqL0NleVVWNzhLcGlYK1hzUEgvbHhwOEtpTUZibjRYOTJCbCtEVXVQVkdH?=
 =?utf-8?B?K0kzS1FOdElGbkF4eUswNjhrSFhoTmU5dFVuditKM3RFR0oyN3hrTUppMmN1?=
 =?utf-8?B?U1ZGZ1VJQjRTSU81M1FhTWxrc0lOcW13dzBPOWNEZFQ1NSs0WHNUcFN3NTZz?=
 =?utf-8?B?RVd2dGZFTExoZWgvR0pnNWE2dm9ycTgzRGhQd3ZjNWpDVjEyZ0crY2J6NGlW?=
 =?utf-8?B?eVJqMkxMQmxsWmI5VHNzNEJtMEIxa0pkQ085VlRrWkEwNDRUOWpJTGwxcnBB?=
 =?utf-8?B?NERqbVMzeWU3TTd0bytrYVNYUFg3TmZsZHU1WnFnK1RTR3lOZlYvenlLZ0VW?=
 =?utf-8?B?bHdFZXBUTkw5Vlo1U3R4YkJzUkxFZTFHdVdvUWQ0NkNWaTJQelQzcFdmaGtD?=
 =?utf-8?B?UWVWMFpNOG1JNHh2YXowOXZyZy9YSXFjdTIyUExkVEw3MHNRZWdxZUV4ZkI5?=
 =?utf-8?B?eTB5Y3VxWlpJd1A2SzFjMlJXNDRWcU1DQ3Qxd1gvRXJkTWlDd1NvMUFyUXdZ?=
 =?utf-8?B?a2xzWExUUVA5T1ErRStoeVVCNzIxREJld2ZUUFlaMXpLYjVJQXVVQ2prbE9P?=
 =?utf-8?B?ZHJ4aGhkRWo1RTlDeFR2OTUzaVhibVdSZWd5VE9pMkxwczZIZ2Q0emlsZkta?=
 =?utf-8?B?TWsxc1R3Q3hIVDNBWUhhSHRuY2owWVhkSTRWdmZ1WVJ0VmxwTDg4U003YUhJ?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a94fb6-117d-481a-802e-08dbf060910c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:22:54.5261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTzEZs9FfdcafpB0/Siqd2GhtdszFAugb2EPESMmOOWGpnGY5x0+c6+XMSdMdwOcqMCyoMYIyxWv4ZzevHX9EcmeGXsbWMKURQupvJ5wxQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8744
X-OriginatorOrg: intel.com

Hi Ilpo,

On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> To select test to run -t parameter can be used. However, -t cat
> currently maps to L3 CAT test which is confusing after more CAT related
> tests are added.
> 
> Allow selecting tests as groups and call L3 CAT test "L3_CAT", "CAT"
> group will enable all CAT related tests.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Could you please defer this patch to accompany the series that
introduces other CAT related tests?

Reinette

