Return-Path: <linux-kselftest+bounces-2089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B95814F2D
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 18:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D981C24666
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 17:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72EA3FB33;
	Fri, 15 Dec 2023 17:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XBKOoPM7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F5E67212;
	Fri, 15 Dec 2023 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702662335; x=1734198335;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uV44txbjy3PPcg41NMY5C6yhycA/rODQXkLeRpZwKqM=;
  b=XBKOoPM7X8oKGSblmFz58Uf6dmW4vYOlwT43E2erUnAixNLatrzqVJZy
   gMbqK8wtS2rIKt2fwLMpmVlrkt1qrdi/ahsS7+roRKMwPN8d2buwR7jJH
   eSvCSM4ZzJJ7Z5rWGhRhKfff6uaxQRersFxrpWsK0A1KsVfPAy7h+IZ6j
   0Ar8mOOx/og6wnekbqlKgcgdBOjnjBCkSDI1LF1kfBFcxNI5gqWHICNrk
   qyMuJrMBFhAYn/VUqancarSc1mYYfUjzG/7/BircI5nEAHPDd305dmMiS
   jGCZAaQ0D+wXseKVpJSoOmnHq5cJVUX+kmvDr+gz7Xjct/qRgLi86+nm/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="2128942"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="2128942"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 09:45:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="918511791"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="918511791"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 09:45:26 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 09:45:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 09:45:25 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 09:45:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvewCdFn6MQTCI5rhwtLZQVOM5fHovJpt7sdQ9LEH6a3Pk7Wi0dC2/SW0f+k7s4msZ3B9DDCREVpsFGM1m+YLcrGsOPh8M99XqZISyzQtaKgLceZ+zdJ7e+yWdorQdum/l8s9rTTgVx/fLg6SQ/MfYRXw/8wtgOWzfWMYRWJ/HkpZsCOGaYnnKC9q/nO1jtO4AOujv+t8nLm08lxF3XfOD9z5XDgb/U8pcKJQi1qwIXz0gjkeHh6/IUeHKWk1pY90EESRTB2p8Fjenwjt7Nc9LlaL8IcA5g9E1jU93jCFZiAq9BNrOkopEdWJXVq5e7M9wgQLgOEsXKJpTxUTBi4Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pcgJXDVsa3B0UYEE4WcsbdIg4jIHsv+4jLsF0Ao/Ug=;
 b=fiZOh+z2MPtwZau1RnRu1oWwciY4/z38OElg/iebgJX9Y4N5tptY5JKyFquGeQh555Wm/lMUONKC6lxyPvBpojgPhlXKGIPZMn1L0gfNiPVx/C0aGu0C1dPih1oR/SAw3Jz4GlhdV1DlioG45ly75B8BqVlpbRx5Cy/g3q6MPQaq/QiGzWczIyFCp09gc/at9wQTotA5rvdmF+IKPnrDJDyRfCKnxrFvddhg5GdfAXXuwenNyrRSRrUhkSAPtgvWWyAjwM2rxzp/BMFa4eZGwN9ivsPGAvKYsbHQ23rHfQWTSundzKpAqDaRHcXIOp/Ch5TJ/Le3sMZUGPZDuYxVqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5791.namprd11.prod.outlook.com (2603:10b6:a03:423::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 17:45:23 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 17:45:23 +0000
Message-ID: <056a2d2b-3b09-4a70-92b0-8634a24464b9@intel.com>
Date: Fri, 15 Dec 2023 09:45:21 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/29] selftests/resctrl: CAT test improvements &
 generalized test framework
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231215150515.36983-1-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231215150515.36983-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0227.namprd03.prod.outlook.com
 (2603:10b6:303:b9::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: a3b78b0a-536e-42ce-f50f-08dbfd959d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gArScPikijcGIz4QgyPr48cZsEizzfkPfFMcD0paK0PidjWNAoIyZAdn31I6fcE09K511EVNmxlQarpSL9fedDdm5qejwsXJ652G6rVGAlw/63IYOOq9eGp0+bEPaVmCgAhp8j0QnlXbMCI3tXdbimIF+XMyzOPySb2+zR7OVzcHOw4RiD4cOqbXtl9R3DYrZYq3+02KmI2ctmBahDvOKwIqkqDBumer7CFcNwgNybxN8pybAU7CeLYsGMa8oZr1YVBwDJbRSb3SAQWjNqimyvDzjkY1YxdBIFM7e27Ehsyyxy78uDwZ5jn6kUuk1Ht+MYGK+7SATj88mJkmJEEAulYTVynmRSI7dNKw8vcz4R04467qXKbvssAgknzm87hrAuiPMQf88RsOrNmXO+wrhJ3mQ6AooSio4rHcC7VwmdJUJEeHQMkr5FhI0VvHRaSqi9RtsQCwsW3hCVA4uqurzGP3zHoYOJ8Vliuc68ZY/hHL+lKBfcB8Q+iUsUkO7qUWqX2dsIIHI1L2w4i65m3VyfvtX3OXg9I/NEv4LsWtkBrxkW7P3s8fgSLgwDt769x9bG6MtsJOnTGH2v6MWtvwkzG54VacUiT5dMqIkIldpQ8ejaZaSyDIswpROM21xcrLYhDmSn++Tm9aJGUrjWhkeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(346002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82960400001)(66574015)(31696002)(2906002)(26005)(2616005)(38100700002)(86362001)(41300700001)(316002)(66476007)(4326008)(6636002)(66946007)(110136005)(66556008)(83380400001)(36756003)(44832011)(8676002)(8936002)(5660300002)(6506007)(31686004)(53546011)(478600001)(6486002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enFKd09lb1FyRURURWV5TEJ2SVRnUCtscU42UE9pbDdxMnYvQzV3VnIvaFN0?=
 =?utf-8?B?ZjhoemNLTHplczVNMjQyVnlMWkdJc25hZXRVRm81dFo5ZTFqT3ZTY0s5WUhE?=
 =?utf-8?B?cVdKQWhLZjZONGIyaTYvYmNWMUNyQ2hiK0xaT1lrbU4zRWcreHpqd0E2Unpv?=
 =?utf-8?B?cDJVcGRLYlpGQ0c0YkY1d2dhZVhsUklXWSttanZXcGtwZDRDbkxpVnJXcGRu?=
 =?utf-8?B?V3hiWUpRMDRtSm5UWERPcmZ0clliMFdlWnZTbENmaUVHYlJNOVZmU254M2lh?=
 =?utf-8?B?N3ZDdHF6U0FMSThWdGxzVFVDYUl2eFh1eXRkbDdsdmRrNkVNV2NndWQ5VS9o?=
 =?utf-8?B?eERzclZXV0d5R3k2b0FXS2dEQUxjZW5yMStoOWZ6YlhOQ2QreCtyaWhTa0NI?=
 =?utf-8?B?SXVrRWcwNmJvYkFZNUc4Nkk1Y1daWVFaMEFTZy9mZ25jQzZyS0VINkVZc2cy?=
 =?utf-8?B?WnIxbm4ybGNqSTdJVlJoNzEzLzY1WERrbnNOVyt6aGpibmxGTE1Fb2ZYY20x?=
 =?utf-8?B?MlQ4MlkwV2dnZmlzNUlxTlZOamRGZmhCbmpQOGhSU216b1NPckRiNW9mMjJy?=
 =?utf-8?B?d3diSXhWUnEwRGY4VlBOaFBKM1dObUFEeGtJQTAzMzVCdnNEZHk0cVJzSG42?=
 =?utf-8?B?YUlWSGRydjJDNFl5WTdZS0RaVFZ3YUxVTmpMazF2SUlERmtyemkrb25WTXE1?=
 =?utf-8?B?MTB4ajZCN3cxRmE5MVc5K0VxdkFOaVFwSFBFNGo3WU43eEYxMnMyQkVjbDlz?=
 =?utf-8?B?MFhNazd0R2pVcERqNjNtbzZwaGxJMGxaNk4xWEZ4d3RpS1dweHRQNkY3SjJJ?=
 =?utf-8?B?SUV6TEY4S1M2U2VHOG9NVERELzBWMFB5ZytHZ0M3dUZGQjdkVjYyd0FGbmsw?=
 =?utf-8?B?UVNvT1c2Uk5obSs5YTNQR3dXVFBRNHJkS1loM3I3dm8ybjd6bWd0OE05eDEz?=
 =?utf-8?B?dWxlYjNSQnlaSXFmc0R5S1ByQnNtaDdPTCsyWmtJTjZXcUlaKzBqaUJSdzhi?=
 =?utf-8?B?b0tlcnQ1bmg1OGt6SDBhZVZSWTVuRlBWNjFEMFdKaitla3M0WE1kUjFZNUpK?=
 =?utf-8?B?Z2E5d1NzZ3pZUEdSSXBZRmY0aGpUenBDMnM1d1kwUEVETWRJQXdDTjZUblgy?=
 =?utf-8?B?c3BHR25tVFgzUXpwL3o5V1NkeHIrQ3ZKSGEycEY4Wm4yWVdFVHkvaFRqSkhk?=
 =?utf-8?B?YkFaTVRRSFFKSDE0bTJqSkgrZ3kzbTg3aG5PM3VYb21CbWNrdWRYTkVpcThz?=
 =?utf-8?B?UVF2aEpsV25rdXVnS0JWV1NqcEFhaGlqTkZXejNrSnA5bHc0bkVjMG5MWjhT?=
 =?utf-8?B?cmNLc0VKWXFpbzRXZ01tR25obTA2K0JDNElKUzBrS1ljWERmTkJORTU2QUFT?=
 =?utf-8?B?NDhtMHFKUFVlWXBMWCswOUh5QUlZVCthajk0Y0RqWkkwRWFMMFJsWXBMaWox?=
 =?utf-8?B?YkZLVitnbkVXcFdVcUE0UVEyYnFpbWVYV1hvb3VlMHRBcGw4TkpaNTZWVmFo?=
 =?utf-8?B?cEUyY0xROGExR2tsTnFJV0FlS2tpc0FrR2ZkeHpSVi9zK3c1dkRvQUhCcUJM?=
 =?utf-8?B?WXEzWXVSbGM2MHRlZCttTEEvdFlLaGczVStyMlYzMVErK2tpSmZTUDhHTmls?=
 =?utf-8?B?S1JmdGVEVzBZS1BDUmZ6MU0wMlcrYnFWQ1JvQTZyeDZ2ZFNodS9MU2JVS0tC?=
 =?utf-8?B?QzRnQ3kvRyt5NGU5NFNObzc2azdvMGtTK3VtODVnVzNOZTF3RzhFeEg1RVpK?=
 =?utf-8?B?aHVkeHJYZXkwWnlTNXRqSXdlY3hGWlFwMERVVHY0OWlORGR2aVo5RDlRRTZC?=
 =?utf-8?B?L0l4TDNPVUd3ZlFPZVVQaVF4RXlxeldRcDBLVFIrclg3ZnNxWHpnbUN0SEpG?=
 =?utf-8?B?NWQyN2QzTCtmdnR5N0dzSmk0U0NQTlRsSFlrc0huQlhUTFhoYTJmSExXRy8w?=
 =?utf-8?B?RlRsdWpiTjdrZ1dqSVRBQTR2bG9maUZFb0dBdWIxWGFIQ1VESzFaZi93eWFZ?=
 =?utf-8?B?anhPZ0VVc0IzNFhqRk9peGRDcEdLSE1HbEN1NGhjWmMwTzRhcGtRU1BDUzJP?=
 =?utf-8?B?alMrMXBkUGdiN3NYOEtockQ4NWZ5dWZSYVY0YWhVR3NnbGJ6ZWN2ZDVEWXAw?=
 =?utf-8?B?U0lxNE42VzRKRVpBSFNYN0E0SHJFd0xja05lVHhYYmpOcWxXSDJleDJqQ1RY?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b78b0a-536e-42ce-f50f-08dbfd959d1e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 17:45:23.2496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqFcS+MKilnmTbqXc0ekGz0LuNWruYQcDocbtvMX6c1AAyTM/W51JUwLp7O7+Xr8UZMPZPNCPjkMFFJdn5juDzGs08RSOLKBJOF+/sgW8Gw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5791
X-OriginatorOrg: intel.com

Hi Ilpo and Shuah,

On 12/15/2023 7:04 AM, Ilpo Järvinen wrote:
> Here's v4 series to improve resctrl selftests with generalized test
> framework and rewritten CAT test.
> 
> The series contains following improvements:
> 
> - Excludes shareable bits from CAT test allocation to avoid interference
> - Replaces file "sink" with a volatile variable
> - Alters read pattern to defeat HW prefetcher optimizations
> - Rewrites CAT test to make the CAT test reliable and truly measure
>   if CAT is working or not
> - Introduces generalized test framework making easier to add new tests
> - Lots of other cleanups & refactoring
> 
> This series has been tested across a large number of systems from
> different generations.

Ilpo, thank you very much for this great cleanup and a creating a
reliable CAT test. This work is focused on kernel health and greatly
appreciated.

All patches in this series should have my reviewed-by tag. For
confirmation, for this whole series:
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Shuah, could you please consider this series for inclusion at
your convenience?

Thank you very much.

Reinette

