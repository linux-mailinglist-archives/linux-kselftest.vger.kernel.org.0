Return-Path: <linux-kselftest+bounces-761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291287FC928
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68207282DD9
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C706481D1;
	Tue, 28 Nov 2023 22:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OtmVOS1c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D0ED5B;
	Tue, 28 Nov 2023 14:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701209496; x=1732745496;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0NpxLx8FzS10yWkrZRqsHAV1YAWnp6GQoxxIFSfECtU=;
  b=OtmVOS1cxXu7XY/7gynFJNlCSiy5Vpf1ReV7m5oOvfrFsB15Gsml0Q9/
   SykOamh5coULU4PXSML3NGHhJg9zWdq1lnnefqst5u0vyf0rDgkstMrbE
   WaOolW4fnQH24eqB7u5W6GOMxlZNhOohfpg9V/7ZLAkH53L3yr5egDtai
   IKpxXzK8OLU1fzureIlz+1PuZWejBSbBTxo40kZ5zyxrp83cZsPkl8RUB
   o2dOucJZk42f7l3PgrZYx4h531aZyj/QPWLiRPxjwe0baxCB7MG3Yd0xP
   uR+cz1JXQqKTDqchgHPGsD6IiZW7M9BNKMcxU92/I63YKmxnDXvYErg8t
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="457374752"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="457374752"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:11:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="718537616"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="718537616"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 14:11:35 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:11:35 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:11:35 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 14:11:35 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 14:11:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2OqvM1VX40PeItdlObwdDYAcvi/pG1ngNi1IEm+gSb7a+Uo99nrCNEcBR5Sq0GrMPaiL3obWYO8gycIyfoPbnTElFWsA4nhwVUt2RBz7g3WiPjmrKfF89OQfg5JHC9UaNX/JEKfzgKXO0JVKSoblT9ZpZKJlY8092Mf+MFYyFEhiulGCYGyD6h5gS17lwQOQCOx7w4SCVXQ3u7EgmR2EAKPhq1LBUjc5Fkjpna108vrfvKhRe66gD4MgnMCKbgvBCCInSYH0oBn1TAw5gyhedr4Ewxl5GW+dNhf4OwumJSPnK4OOTlwzg+FO+cW88j7uLSdahsIYYI803s7+3Rz0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5gY0pQHyF8dBG7CNlULvLpu7h3RVYe+mAx2yVI4S8Q=;
 b=gPvzkltaETpoyAK6tkSpTJ0wZS8iGbTg/eRhzvxjRq0GDdOhKeA36JY9KYCSVnvI7ZaBaEACA1PLOxD4sXnF7KpRFU/EiMR9TwR3yzfMnMqjiG2DdozvV5UYvk+bdRdavL/fs+P0Hphx0Kzqvb69dSesUWiBIlIE1h+7msnv8fHnrpn1HQEUhFMDfKfQkSnP9eGFoH59OJqfA+5E1PE0y4glsjfsMqfhj/Ps/gW+ZDZlfQPdcTqmj5ScRly2cxk7Ct3JaTbkJVhPHxElhaZ+rJ/B8Qccwa3PgUHOUupKA4PvTZY2Et5FGVBzuvdGclu7F/kPPJgRGBoq8c5VIoJv4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB6328.namprd11.prod.outlook.com (2603:10b6:8:cc::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.29; Tue, 28 Nov 2023 22:11:30 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:11:30 +0000
Message-ID: <e5cbd11a-cd06-4f22-9141-aa04f6eaf969@intel.com>
Date: Tue, 28 Nov 2023 14:11:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/26] selftests/resctrl: Create cache_portion_size()
 helper
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-7-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231120111340.7805-7-ilpo.jarvinen@linux.intel.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: c76782e8-29a4-4993-bd0e-08dbf05ef924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PanVf+yeCaDNAu+hYLK2DsPCcqrfwcNaZJWY9lSm4zlaffTxFHgBdqcQ27XPFVw5Hn/R9BAw/lTw28CR1QELIMZIblKWeZeO79Y1W6v+OugaSCypB6xDJCcx6MfUM2VAJwQy1kWYirCHBU+Vk+ExGsEFHFw/UWbeGT/t/Vn6blWJV7dmaJvWJe/8GtgeelvbF8rQxA+JKCfh0V+voUcXNdI0Qgq1h/e1gmtYmuXUS3amXPAQvZ2ENiOBXTyFJGoIFYMcbUDav+Lc6RF3/LiXeMatIohDuqsriTZy9QAaV5H+tIWmgRPUJucdCPRVzKt2BtyWQn6tXNxaiNgeL3q1E6eyAhZxXR3qWR5DxWrj5Ms4f5xA1FqXECZhtzxxmG9kWniot2zkFAIlIPqvJlD5mAedvt9FlvZHZH62vWrMHYS3c1lvrXCBgIKGo58OjWSszswE+HmhpDWMAR9DJL3L6jGtgy+rpQ6SHAnoPp6kR1Y/GeJ9T56cO22zBUtTA8w4vFSLcR2ZguVChi27vsCt3k6gAKTAYNL3jzxflA/C0lcL0793XJSp21BIpkukwW115WeSCszWq2n+0oTyQYn4CNMN+0AzpV8c39SPJIX7mqruGb9QwqByBRzlYRMjRJXaN3JcnhYsO53LODkvPOGOvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(5660300002)(4744005)(44832011)(41300700001)(8936002)(4326008)(8676002)(31686004)(2906002)(110136005)(6636002)(316002)(66556008)(66946007)(66476007)(2616005)(6486002)(478600001)(36756003)(53546011)(6512007)(26005)(6506007)(86362001)(38100700002)(82960400001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anNJRjZZanlqSDVSV0FDeXJOMGpxKzlIT0h0ZjBnU09WM2JXQmwzNFlza01q?=
 =?utf-8?B?bUZZM094Z2Ziam5IN1JvdmpnTGl4WnJKd1FIUU5CZ2tqdm45NFR1WENxNGR4?=
 =?utf-8?B?eGc2b1p6ZHFpUzFKS0M4NG9DUW9BVWZxUWhqdUtvSDRzZzNRbTlaYldYVE9I?=
 =?utf-8?B?eXdwdVVsbjg5NnhsN0tRQm56V0lza3BBRHhZclQ0VENiY0YyaFNzb3lLUGsr?=
 =?utf-8?B?WWlpQkRCWlVjMTlReFhuMk1YTnpZRlA2b2lFV0Z3azZGTmRmSDFndVB3UmZG?=
 =?utf-8?B?cG1CQmkwTVFrdGJvUFQ0VlM5NlY0cWFnUFBLMkl4c3R5OGZSK1dHSUF3c2Y1?=
 =?utf-8?B?bW1Zd29WOThXdEk5R0RsWEllK3VscmI0RkgrYWl2MXZJMW9RUGxPVG40YkJM?=
 =?utf-8?B?UzViM2tSRzlrWGtOcTRTMFdQbGsrblloeVg5dFVkOUZzbjF0LzI4eEFkN3hq?=
 =?utf-8?B?bkhJNGJTOUtYWjl1eVU0eTFUaTZCTS81VGFIUHVkOUNOdzNMN0d2WGVacGxG?=
 =?utf-8?B?U0pNQlJ3VS8vUTU3b2I3ZGV2SjM2YW1MMHdLUUkwcFlGUmpjOWhGSWgvMWdJ?=
 =?utf-8?B?cTZaeWVZTkh2NVFGNlh0aGVuMEUxK1I0cklBRUQvZDFNSHFOUkRqWDg4QmVT?=
 =?utf-8?B?cEFRQmVWckhoazVCTTY5MExKZWpmL01WdTFnS01wUmxIS3lHY29uTG9TcVZ4?=
 =?utf-8?B?M3M0azlaK055dUNZZjAyUk5YR0VmQTUwQ21LT2dHSUVSZzNKeGI3dy84V3pm?=
 =?utf-8?B?QzloR1kxYkFZclgwbm5ZQ2htOCswTi9wMFR6RkRsTjlFTENtbGZkeGx5VGFI?=
 =?utf-8?B?ZzU2RVBQUHkwUzR1bDFrMWRCdWErS1BPRUZESHQ2YTQ3WEdSN29veXkrNmdk?=
 =?utf-8?B?b01jUTZ6WVh3aFNZUHNpbmFMcVdSSjVRMWt6Znl3S0k4eGZadmVZZUZSUzZ0?=
 =?utf-8?B?V0JMRHYzWCsxNlpOT3BoWUtZUG1OSHhjMUhCQVNjVVJsYjJJM0VnUGJGdHRm?=
 =?utf-8?B?d2FzMDVVSGR3UHRJZ1luMm4yY3NKMUw5QWU5cUFZdktZRUJzNE9lcUtoeERm?=
 =?utf-8?B?dmViY2Jzc2kyOFJtdHlheVRzUENhdTZjZ3orNWo1ek83WFVLay9RSlgwRFc5?=
 =?utf-8?B?OXczNGRsaE1LUHEybGV4YkkraTlYK3pkQ3BndkVqT3FybFdEZjhUN0JUb2lF?=
 =?utf-8?B?dHJVM1ZvTGcrWndvSjJOMU00NEp2aCt0b3l6MitaYjJDbFArWXBuU0p1NHM0?=
 =?utf-8?B?UzJLaEdKbFg1UVFhV1lNZFo4bGJNVy8rOGFnazR6Uk9WMXM4S3UxUUVNcmJY?=
 =?utf-8?B?WHhCY0hyM3M0OTN3OWRDaVFYdk5SakUwY1prcmJmcUNRckpWNk5oNU03K1Jn?=
 =?utf-8?B?NGJkN0FxWTVMWnF0Qy9vbWNOK1ZnbU1JMW41Njk4Rm9abWJoWlprNlRZUmpG?=
 =?utf-8?B?WUY0b3dKQk1kSzdzaThZbkoyTlNaVTZlUWVUbUhScUJXNUhhT1JTSEVyWEk5?=
 =?utf-8?B?bUpDUjZ1SVIrR1EybDhvcTE5R1RLeHl4Nzd1NHdzbGpna0ZTZURBOWU4WENB?=
 =?utf-8?B?dDhqSWY2YTRFVE80Q3Nldjl3N0pnMTc4a1Q1ZlZLdE9WcGt2VzVHSEEzczNh?=
 =?utf-8?B?K2pLRWw0cXo3YTdmZE1MUTN5SCt5NzQ4aUd2SWZrSndUY05aRjRoYjBJZVNP?=
 =?utf-8?B?NnpCbHQrVlI2a1lsck8wY2t5TGtRTU5QUzdqczkvZHJtc2NrQTg5MjMyWVlr?=
 =?utf-8?B?UnJUd0hyUkJhVi9hei80dmg5VXJSNVZ2TlVUOFZnWGNaRWM5Z3dBTEhNZVM0?=
 =?utf-8?B?VTk5ZUd6K1VWNU5ucUdlb0I5NmhZTDRGRzM3NWxvTmhFM1VpZXRYYzFtZFdU?=
 =?utf-8?B?NHdHZ1JsSHBUbUVHVXhaQkEvUnJEVHlGNHU3V3FOcHd1UE9OOE9ES2hDR3Vm?=
 =?utf-8?B?OEF6c3hHa04wSWQwZFZIdld2cjRCb3BCUkc4a0ZDK0o1dU9NOUZpVlVtWERu?=
 =?utf-8?B?QkovM2piMzZwLzNORjRpTHJZTWZMTEdEYlBmYnhsVlU4R3IyMjVRQmVYQkxj?=
 =?utf-8?B?VWkvRVlIS09Wa3BzbkhFcDhxNDF3dlg5eUcwRzFnN0Q0RjBtZFhrQzZDam81?=
 =?utf-8?B?SFY0ZEpQUE9lSHlHdnpBS21Jc0JGS1Q3L1N2d3Q4bkRRaGZlZTc2YTR4ZDFw?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c76782e8-29a4-4993-bd0e-08dbf05ef924
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:11:30.1885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5T9przbQpdvMI9xDymwAYRcTxQRZ7agIhQVroOAdArh/DqbAd3gcSBOYDvL5W0ev+KaINHReEapVNPWKnYEBNZbnofnH7NkMjF7CQsH2+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6328
X-OriginatorOrg: intel.com

Hi Ilpo,

On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> CAT and CMT tests calculate size of the cache portion for the n-bits
> cache allocation on their own.
> 
> Add cache_portion_size() helper that calculates size of the cache
> portion for the given number of bits and use it to replace the existing
> span calculations. This also prepares for the new CAT test that will
> need to determine the size of the cache portion also during results
> processing.
> 
> Rename also 'cache_size' local variables to 'cache_total_size' to
> prevent misinterpretations.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

