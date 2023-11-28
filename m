Return-Path: <linux-kselftest+bounces-768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC897FC93E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3BE1C20ADD
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0C4481CC;
	Tue, 28 Nov 2023 22:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TlyHTDOg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9011BE;
	Tue, 28 Nov 2023 14:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701209723; x=1732745723;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tMacmSBu2jFWlswn39zintiYY6vUj2Rux6dd0vEu98o=;
  b=TlyHTDOgIApTLCLoJ13v8JPp8oPSt62Jvqyk+s2nZlMocRlz/+93WivF
   LIb4rhS1CER3m0pz+ilEuTRqt5+5V15pky4srB7wXtvSfCdmjOtMcPd8F
   sbpCwtsKn3Tiw6ZvZ81XpIiAHbrEdd1a6BRKdEgteQ4NTSGasveO7VJzG
   NMECbqj7zyCszD7WpUE+JNlHxCeyjDwIWLvonDH4i2K3VQU0AxL9UQxmd
   dMKmqPRbHCzNw3kuSIqMBmqFz+tqeCTESBe1zZPMUxep+giwZVlLkkc6Q
   UCa8bLXPLQZB5wQUf5mv7Y3lh0mQ7RUtX2R70wMb2jinYxWLUbghDtgSJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="479234732"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="479234732"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:15:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="16770072"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 14:15:22 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:15:21 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 14:15:21 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 14:15:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HreJJTeXydJKw6erzeXaYaJgnjXsueXJgs97cEb9vc2dSGIJTtFZuJTvOE/rqQ/PlKln+qjRPpK30UafB8xnfCU++0OGNi1TEJaxvfmqTEWMwx2P/pgXzPHmxKyhZUkx4krQJUbZnxv4ibsunFnlHyuig9bf+vi9DtnXCCBpFdypM7jIv+NVcnAuhr2ack6IbDLxfP2NRALtdcihj0cj3+RXtD59HfVOmd4tjmecXC04B0Z7HP2amYjkopXLE1C+pC6uy1vli1NdPIIHBIGsw1OMMkQCO/5z1L+JmHyXTYinVTeZzLLv1X7iAVmIJsMeQ31sD/wBklLftxNos2o65g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTj5ZLJtJrAXbCdu5UWpzRZe4+hD4UBAHaECWWZ+PII=;
 b=e6YfOVCDu/gYc4DjXxBywl+aS4bkCYK9Su3S9Ix8HzK+uP2oZ0a9dh3YDtPcu/82M9P08hA/Im6jqLH+6ubXVD02m9aqIEoponFVL88GcbK71J1nGhHB1hbISq/VYbci55xi8Pg7LR44LOd/CHzCDtf3yJPClELv35YckQocBOu6/Awqw9ioH5Ph0m+10dATBpvgLeRXq0GD6v9vD+vPEb1LjQ2jHd8mw+SZgsQvTP9pfeP2ef2AKjJ1Dw7C0YfbLDj/9Xkx7pTDuG6h2pgnraixf9T2ZVfTxSlCMoSWqNgiVsnC52/BTy/HvqifTJ8+m1HKHdxstdiLohBfPH4atg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8024.namprd11.prod.outlook.com (2603:10b6:806:300::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 22:15:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:15:19 +0000
Message-ID: <374da220-80d1-4d65-ab29-c92258d977af@intel.com>
Date: Tue, 28 Nov 2023 14:15:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/26] selftests/resctrl: Consolidate naming of perf
 event related things
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-13-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231120111340.7805-13-ilpo.jarvinen@linux.intel.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: d83c6bde-af65-4104-91de-08dbf05f819a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5kbywzPWtvqqKljvFcpHPjk/BzJPp6hU8hP3vFBrxXODJXIh16n3TmOCql7GHL7m1fJ6QfpOeUqW7pwej1C+1l/VCL+54+jrqn6hx6K37AxlISkCoPWG5/cxfr/7S3PsEBtjHaTz9CLQntqD1O7IXtmsZC06Npzgjxc32Dz7MjgX05LteYJgFuvy/y9iIX6Tsq5mfUk1MFcwpR9pHxQV+jr1e3H2Az5KXcskutEF/J7bEjO4Ds15avC/iRCy+STf81w7HjAMpfllWwjLXVmwjaOG2r+qHkVW75TfQYbzCt2HjYjxGwQx6Jsh+TC0ixdVuSbQEpaQ/P11S2cLCVgMORseYhbagNUXm79KHZsjwCQZeEfGSmTvyK22uMqSR+Rgk72eXWX1u/2/Y5S4zsh+1L/jaY1jtfqw5wW12IRu+kCM/bzN0KwlIziml/AvsLLQZJrpS4NwB65PE8wkaVKEPY9yE7AHFSzvlsW6bxnqdq6d10evvaBKsVjG48g0m9t3bViXW4pc02coniX6bTSY3crSovsDJwEhn+aHDKd0PEIW5POj8xBT4NI19BCtzxC8PUlDCreyfU7dGz8TMJ01r/N8IUE7OjMra5dTkqieV+KCJUs+aJAerx3eliiJbwLVvvw+aT8KkktD3+cJL19/Tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(41300700001)(36756003)(31686004)(4744005)(83380400001)(5660300002)(82960400001)(26005)(86362001)(2616005)(2906002)(44832011)(6512007)(6506007)(53546011)(8936002)(4326008)(31696002)(8676002)(6486002)(478600001)(316002)(66476007)(66556008)(66946007)(110136005)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3VRNnJSLzBBR1dzc1l6dm1QZ2k2bVVpT3RwYUpwRjBGV0V3R0RtWGpFeldj?=
 =?utf-8?B?YTlnMGszaEJsc0g5dFdlaVpIc1A2azlDbnFZRTlvTmpZNkxPTHlBbmVwT21N?=
 =?utf-8?B?R1NKY2NQREZ2YVJBUGlPZVhJdGF2NmtMZzlVZ2R2QnkzZGQ2bFZzZCtOZWx4?=
 =?utf-8?B?dDlXcFcrUWFJS251enpYb3AzUUl6bmx4MGFXUmFxV2NzWFpLUFU5YU50ZW9E?=
 =?utf-8?B?bkRiMDkrZFJLbDMvSkNuZ3NHVXhFNjdYVmwwWTZ4bzlvbk5FRmp4Z3JIUTZB?=
 =?utf-8?B?aStYVnlkZmpLY2svUGFEeFQxVEd3ZXBUZkJabHlsMUNIamJmekE0RGZiNDhW?=
 =?utf-8?B?ckZNcGpneVdtMnRpbVNnWFVWeDhYTHVpeU5MeFp5bXJJYjRBVjdwRHFmcCs5?=
 =?utf-8?B?VE1rOGQybkNvZU9qSldQTE92MDV6SG5iZ3Z1aHQ1WkNmc2pIdjlwZkhWYnJr?=
 =?utf-8?B?RzFZdFEveVo3M3BrdHBCK0I4MUVFUVpUYitsL2dmM2M4WHVyODVmZjBsWFR2?=
 =?utf-8?B?WlRSNCtqQWRxeDJxU0hZWTFGTHNIUXQrT1A2dmFPS1pwbHVYM3U5UStJR0FX?=
 =?utf-8?B?SG5VSWxWNHg1S09WZmYzYVNsVDd1VXZLclRPR2MvenJ3V0Z2UmVvLzcrRjha?=
 =?utf-8?B?bkZLMFl6Uk4vbitzQkMvb0tkSTlHVm1KYnk5eVRYME1EREdxblhQZG84VXVk?=
 =?utf-8?B?NVpBUDdZMkJ2blZDQndwTUJ2NEo5eEtxWVA3SjZoWTFWa3RBeFFOMlZ2L3JC?=
 =?utf-8?B?MG96TUJPMlZnM0xmVS9WM25nbzVWR29XN0ZBaFJQR3h6N2RtSmRrK3EyVEQw?=
 =?utf-8?B?K0NkNVdRZHZXWG82WFRlYmxHNGhBczBzd3RoOHRlRkoxbW5KK3UrWFdkUWF6?=
 =?utf-8?B?OTgySXZweFl3MC8xNjNRY1JrSlpHcktMcytYM0ZtK1R1cTJzRWRiNW9neHBD?=
 =?utf-8?B?eTRvQ0k2cEZZOWRJT3A5RG1mczE4V1I5NWhTWnpicE5jWGJOQ1ZXQVpObE9B?=
 =?utf-8?B?TjV5R0I4NlBiVmhSWjZxQndRUU54NmpsTUNDZFcwYzBTamhkd3hObDZPa0c3?=
 =?utf-8?B?YlRqTDNHa2ZsWTFTZnFKWElHRjFlN25hK0Y5Sm85UlFvUEJWNG45QXdaZEN2?=
 =?utf-8?B?a0YzdmZXZGxaTUc4RVpLSit1RCtvNFU0eTBZbXIwVUdKK251RjBYclQzR2R4?=
 =?utf-8?B?UXRuamhsQkpsb0s0NmFOQWdpRHh1YVpqK1ZBa0ZOWVBHczlnS0pyaGFCcHp6?=
 =?utf-8?B?cjZacHA2b2M4QUt1SDZMUzFCOHRaU216eWRVNFhvaExSb0V5VjRDcFNFY2hs?=
 =?utf-8?B?Ly9xZCtwVGhUTFplTkxBMDlsd0tENzZ0VVM3Umk0b2QvYnB4aU5CTlpodHhR?=
 =?utf-8?B?UFA3ckU2cmwvUkZWWlRMZTF4L1kxSktwNk41RHY5aktvWWFpdmgyQVlhSDFj?=
 =?utf-8?B?cEFkV3gyakdRRXBUTUJXUFlQQnRFaXlFWlE2a0I1WTJlUFU0TU90eHg1Q0F4?=
 =?utf-8?B?M3h4M3hUTmE1Wkx6NjhxMVp5KzZydVZPZGxiMVZuTVpkRk5nbDJEbnJGRGxj?=
 =?utf-8?B?YVRBeWw0b0hiUU9zOVVrYmlJWE5QQkVLZkErT1NtZkdvQzY1VmJ3bVVLaXVK?=
 =?utf-8?B?bmliNUdOcFE0dWdBd2pEaGNsei82YTdoblNld1RZcXNoZ2NyZVRFMDMvQU1O?=
 =?utf-8?B?SDZxSEtCa3J6TlhXSmRteHhFMXJuWmlvTWp0eitIVnE5UlpWTE9vRWwxQzdj?=
 =?utf-8?B?Um5xSTNua0p3YnpSL0JzWWxJNFdSRmdYTzV3dnVaVkhBNDFBanBwZXVKUjB6?=
 =?utf-8?B?VncxMXdQbnZMWFhOOWFSYXpCZy9sejlpTU01QmVrZXBWa2QzYTZEUHdoK1lj?=
 =?utf-8?B?Q1Q4bmlVcWhiWi95YmRxdkFzRksrSkF4czEyRUhhRlV5cnVqRHpITmo2T3h5?=
 =?utf-8?B?WFVON2FYclZsVVZhNGJaVUNwV1VHUk5vZDBJVDF2Ymswb3VUbUFpYS9kZHVs?=
 =?utf-8?B?S2VIdklaLzV5dXZLS3BxS0F1VE1DWTkxbklPeU0wdGRFVGY2a0Nmd0VyOHBJ?=
 =?utf-8?B?QlN6OWswVktWSWJFY1FQSmVFUldKYzljSnVkbzBCWW1SeFZVVnNTcjAvSmhr?=
 =?utf-8?B?ZVNVa3hNNG5KQ0dZWG9XeEZPY1J1ejFPbWpaQkJnTy9UeHNwN1poajFmdERk?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d83c6bde-af65-4104-91de-08dbf05f819a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:15:19.1228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tMgeU8jqK2IeEFsJYDDjP3b9Dl4kU49CCxf7TsKqjYieixn1KezDxgzOG/Viyebzzw2WDVCwZWKYC91HpZwiizZUnZb/ka/Z/rrUDLgCWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8024
X-OriginatorOrg: intel.com

Hi Ilpo,

On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> Naming for perf event related functions, types, and variables is
> currently inconsistent.

(nitpick ... instead if "currently inconsistent" this can just
be "inconsistent")

> 
> Make struct read_format and all functions related to perf events start
> with "perf_". Adjust variable names towards the same direction but use
> shorter names for variables where appropriate (pe prefix).
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

