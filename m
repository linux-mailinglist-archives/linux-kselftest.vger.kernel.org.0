Return-Path: <linux-kselftest+bounces-774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8037FC94D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72F8282EBC
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1377481D4;
	Tue, 28 Nov 2023 22:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uh/m+P2L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B946DA;
	Tue, 28 Nov 2023 14:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701209850; x=1732745850;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EwUxIlsNl0aC0OC4AKU7eP4vOMl6L/msFSHCtPyBJm0=;
  b=Uh/m+P2LaqWzChSN58OVtIqs/Nv558iuZcdV1sv/0xvLSYawXiR+vQha
   I7tpGeZE/5uSAQcJM3h6ImmkgUoobq/dXUHhkXqggWv89TFIZjkGHUCI6
   ARUaf7IckPFAaD1HB3BUAGq8q3Oxzumd+OH9qvh3bz4WRngH3XQvZWGAA
   HPmZ5SoW7gMcCcfX8LbQeYp0im4EUAKFTrjzagzjaJ7v1KIOYGdXpobci
   d0ghoe+1Ic8lD0GkkccvtqdoxnwOtpLjXJB70Mu/KEkSIJhy9VOT6t9MS
   FTDX1l0Mn7zyOdoMjhF24WKOU2trKxxoMSNjLtNy9KJWF3h/Xj4AB4SBt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="11739940"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="11739940"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:17:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="803081834"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="803081834"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 14:17:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:17:21 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 14:17:21 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 14:17:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1II57yvhGgbk8OMRl69gp8MMvT6nzlK4V/4Nr0NGBgYTJdiyvcL2oho/q+1AqBpbt3snMF2uMRxlHdJAXAI1hBCQBvy9noc4vh2WRJzw2LJmsr2+RQn5RKMXOaL+bJbtS6YnZcLpXS5oi9Xf75BffIrE4tLxCkKHdaoBhhFPotNU9MgLpSfUv9hUU4tO3Yq7Izflf1O6i1ntVR9ebfknjcs8+EFq1aHaFGErKC1IfVn/TLtS/4brgqV9IxtP5ZLfFgLZ0DxmHtPZG7oVnk+oypz3f3Poyr+VE8t16EkNfqeHbqqbA+D2X1uFlQ9BjzGPBX2hueUub6VTymVjkAcKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0k/mHTwklq41/RxexQezWi/tW/dcM30/KRnd5dHe+rs=;
 b=IPNs8pRRCemvpYtO0BSkQ89fbmsEABkKQDv3jS4XfrqkCLglLuqcfPm+ImFWw7tKvzvpf/j4mx+RfDq0P5ABJPPorydJBhN5QOIasVxkYs88d+E3ZZ4KRHwo1k/O0eDILM0mZ5O2B9BRKeN1rsoDiOJxeCApO+R4N9Kjc//E7YVdaNVEfw3b6gnochfiXG8cL7og4o87m+HAm2gwqt4xdxJhqrhJM4vxpki/zy3uEhGV26dmHbvb2I04rByIvMaY97knITpBWbtq5imCbbSn22sMfIC2l53N0n7P/OVW1xURi/+gWIeRJZkyL5X/TpyTpG+uceiem+Mx7b0WgvJZQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7419.namprd11.prod.outlook.com (2603:10b6:806:34d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 22:17:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:17:18 +0000
Message-ID: <03e9c565-ddc3-4f2d-beda-5095d3f3aa37@intel.com>
Date: Tue, 28 Nov 2023 14:17:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/26] selftests/resctrl: Read in less obvious order to
 defeat prefetch optimizations
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-19-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231120111340.7805-19-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0192.namprd04.prod.outlook.com
 (2603:10b6:303:86::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bbb7fae-214e-4df1-b739-08dbf05fc8ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EprthEbOe+Ovv4LU5yKEHuc96X9w6h3Kr00LYLBBhDl8Gm5vXxSJ4V5v2aNQL/YYy1gnEvmvJ4kkqO8v59FCyEcZjsJBRgygNGvCA2tybUc1nEJIaI0IjYgLEm5eJ1vAttE3pLQv/3Qed38lfAZuUaSeMgpXoJCiNwahygdupfgzs5GmDrW/klReiIK+nYlar3o4VvTk2c4KkIcZ2tIsDHqO30On6b+nudMXfSxJvtAwK9FzPlHv8Jvxoab4qMjTl2AvdYSkTbrCanNKY7+rfslP9f1FzBqWz3iLrqYRtvqT63lZRAADI9LAVLzMlp9i+ivjJZyTl62N7PM/g61+gEtpqhXr+0InoxBBSWf9O2DdRuN3BaUXP3UqujW0nccb4Rs8ZodAwWOU6BKPZaJTh4ejgEYeZiMVAcI+bgeHu4HkkrGYCk/t/6uMVDfQbUlM6t2ZZpK3D3jnB2Tdq201ZlCKrwq03XCMOOuOKvsWzMhOdkGB4JkbaaCkrvT8/u3W2NRcynTzQbaHJFZ2JCHuRuaHt1sfjKl7YfRbmwnvUZdoIUO5lkvTKoM269tKJV8ks+DoJ+Usf7QoR26UUAM3lXEczBpnousMgrsfhHzJDm6Uh6gHsD+3R0oJqpWWlomUeZwRyiGnE7iNLdlnPsvqiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(5660300002)(2906002)(31696002)(86362001)(45080400002)(26005)(316002)(6636002)(66946007)(8936002)(66556008)(4326008)(8676002)(2616005)(6512007)(6486002)(66476007)(110136005)(966005)(478600001)(6506007)(66574015)(38100700002)(82960400001)(36756003)(83380400001)(53546011)(44832011)(31686004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzgzcEx3RlhtRXRJbXdITmdUWUU1T3YrTllLcm9zSnhFNlVyZm10Wm56TzY4?=
 =?utf-8?B?M1FFcU5DSG1NVEZ2NHBZK2Y2M3NtbWY5UDR2ZDZwQTdSTTk3dmZNdFdUUDk3?=
 =?utf-8?B?STVQYzJYSkNaR01TQ3FKZW1FeDFDOWFMWmp1Vk5QQkpjelFyZDNlSS9rc3lL?=
 =?utf-8?B?NW1VNU9kbzVXQmxHUCtSWnp3TDFodHlQZmYxSUJOanQvdDB6eEg2cUR0dWdn?=
 =?utf-8?B?YnBEbzNIZlpEVThoc2FxaHc1OUlLL0xRSW1rOTVKZ2x6T3JmbkVwaHU2aVB2?=
 =?utf-8?B?MXl5VW1oTkxtUERDYVh6OGJwRmdWckx0RnJnaW0xdFlGUGl6NXRUaHVheHpi?=
 =?utf-8?B?L3UrVTROL0ROSHZSa0psK3JnQm5McjhBS3dLaVdWdFJVZmFpME5iL3NuV1JT?=
 =?utf-8?B?R1gvd3hrRHFmMm5YQkl3WTlBbE14bUM2WUUvVm1VaXZwckt2eG93WWJVa1U4?=
 =?utf-8?B?M28xT3ozN1RQc0RIZHBNeVA1SHRjem1OQkhoMlM2S2lIL3FZWlQ3cURpVjZO?=
 =?utf-8?B?NXY1cU1pSkkyOUI4OXVYRHRUS3dHd2RkVlBDRFBWai9pK1A1N2NuQWVTcHh2?=
 =?utf-8?B?N0tBSHVFQytwZEZ6MXpZdW42bUU4Y1YzRGpZQ1BSQkJFNHR2c0lTQyt4b1dY?=
 =?utf-8?B?a3hJZ1FFSm5MQnhtZWhPR0hGUlJhZHN0U0tiSkJldFFBNVR3ejM2d3hrT1NE?=
 =?utf-8?B?blc4YlBCNU1oZEZEZTJ4SDhOcCtoN2FPOE1aTVdFd1NxUE1TMGNVdEVObjJo?=
 =?utf-8?B?MldBcjFqODdrdVRIYm5HaG1YLzM0ZVVoM2hpbmVwMS9Hb0RZUHhlTHpyVVRy?=
 =?utf-8?B?ZzR4Tjg2RGlIRnBVZTgxdVFvdkFSL2Z5M1JMU05uVzFnNW9mWENnRXVINWRk?=
 =?utf-8?B?cjBJS3NIeFl3SDVPNjVnS1JocUY2Z1loQ3NjamZkayt1QWpwdWFwTWk2SXly?=
 =?utf-8?B?cnJtM1Q2OW9MTFBVWU5XeTN3ZStrK0xSOWNyUmpMaUtTbzhFUUdPS3dtRDZW?=
 =?utf-8?B?WHoyd01xMTRKZEVreUlDOG1UMVhEUytrN2hIY1BTMVRnVEozWWh6b1ErTmRZ?=
 =?utf-8?B?VXlZSGxyaDVlSFE2SjE0ODl1SGlJbnN5VnJPVzVkbnhYcHZVZm81d1JsYlJj?=
 =?utf-8?B?Zlp3eWpkZC92Q2s2UUF3WVJWZVhiMWlYcDZ0bVpSSGs5M0ZGdGlidTZFRWtw?=
 =?utf-8?B?WnlGdENuODlGQVNkYWQ2aURVbVplTDdPV2ZJTUpzd3VoSEVyR3R4RnJnU3FI?=
 =?utf-8?B?L3QzNTdBWWRSbmVodkNhV0FQRFhrR1RuTEdNMDA0dmg4aUlTNjZ1VzZrTDA0?=
 =?utf-8?B?TyttdTkrWVoyK3dOWlRWZnRKSjZ2bmk4aFcydXZwc3MzeTlwYnYwVHppbjh5?=
 =?utf-8?B?M1NlRmNhdUdwcEVsOVBrZmM4aGdvc3g4S2d6ZjBTRzNRVGF6eU1PSW9heWZz?=
 =?utf-8?B?amFRMzRwSEVwUEhMT0VjWGVUZXlRMmVnTHZaMlpwSGFKdGFZckRUaUR6THR1?=
 =?utf-8?B?czJJSzFpMmlCU002RitldzNyUGhMWTNITDFvZmp4VXZZeHRxV2d6NXFSWnEw?=
 =?utf-8?B?d21lZ0dTK2FQNlo0c2phTEJTQzNRTldGTFRidm9KV2FDVXhEcGtQbGQyZ3NM?=
 =?utf-8?B?V3BHZ1ZlMlMrNmdObThKcnFoWkFFaUlZQTBMYUc3VXNvaHJva2dkdEFjbmVK?=
 =?utf-8?B?WE84bFozajZQaGt3RWhEbkt6Z2thZUNKVDc4a2ZBQWR3bnhqR2QyMnh1V3BX?=
 =?utf-8?B?OTY3Qm5WeUNJU2x1czdaOWhRY1pWclluc2N4bDMxUE5mc0M1Yjl1VFpoQnFN?=
 =?utf-8?B?UmVSYWNKclQ0MWdFaXFKTVVCNlhhSlBISXhXeXN6ZEJCaTB1dWpKUHQ2OFpM?=
 =?utf-8?B?RXVVRjk0TER2enF0NjYxajZJbExBOXRtd0pVZGpMWFVWcVRRQnVzWWxiUVEx?=
 =?utf-8?B?STV1NmJMMzFSMlpPbHBXSjRrei9sZ1JoeW5uVmV1MUFOdVRibzI0cCtyZ0p0?=
 =?utf-8?B?U1pmUXFXV2g1ZWorMEIwcjJVK0JsaFd6NWgxRU1vR2p6enlnczNIUVNVNFY0?=
 =?utf-8?B?dUFkMTVLSWRxRXMwTHg2YTUzN2NMb3FYSFlvOEZ5bEFYVEhSSlVzcWE0ZVBY?=
 =?utf-8?B?dE9ISUpHUkJUcFA2T0tQUHk3eFFtSHhjaXFUZ1Y0NnBUUmExU2VuUlVHdnZr?=
 =?utf-8?B?bGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbb7fae-214e-4df1-b739-08dbf05fc8ee
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:17:18.8965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbUOs4pFip4+5wV6n37E6bgAZARf01Z9Cpq+PDiiLakDw1b3pAeozKuCHUUwrsYsE/7l5z0EEr0rSbcoX5rEiSe76UHqDkW/TbXQkNCJc9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7419
X-OriginatorOrg: intel.com

Hi Ilpo,

On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> When reading memory in order, HW prefetching optimizations will
> interfere with measuring how caches and memory are being accessed. This
> adds noise into the results.
> 
> Change the fill_buf reading loop to not use an obvious in-order access
> using multiply by a prime and modulo.
> 
> Using a prime multiplier with modulo ensures the entire buffer is
> eventually read. 23 is small enough that the reads are spread out but
> wrapping does not occur very frequently (wrapping too often can trigger
> L2 hits more frequently which causes noise to the test because getting
> the data from LLC is not required).
> 
> It was discovered that not all primes work equally well and some can
> cause wildly unstable results (e.g., in an earlier version of this
> patch, the reads were done in reversed order and 59 was used as the
> prime resulting in unacceptably high and unstable results in MBA and
> MBM test on some architectures).
> 
> Link: https://lore.kernel.org/linux-kselftest/TYAPR01MB6330025B5E6537F94DA49ACB8B499@TYAPR01MB6330.jpnprd01.prod.outlook.com/
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

I am not very comfortable with all the uncertainty involved in this
patch. A consolation is that this is surely an improvement.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

