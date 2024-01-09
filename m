Return-Path: <linux-kselftest+bounces-2759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9315B828ADF
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 18:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080721F24DD5
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 17:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1788C3A8EC;
	Tue,  9 Jan 2024 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZACIeDS1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815663B194;
	Tue,  9 Jan 2024 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704820681; x=1736356681;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ebPcD2scGBCEbdJ8R5+sXfLi0vsV/Cvrm0QcoGRRMx4=;
  b=ZACIeDS1ijAM88m0gkZKrOBFWVHurr/Fd0ltm0pzlWsY6jXhQXJf4wjm
   ZQIMS0TONoYBn+n5jRvGhImtQQx9F8ntIx/Qvn0xi5mM7MalB7OeIjImZ
   it2wAE7h6087YkQMjjkKsMfXgrNjiTvTHX+tyRHyhUgmakGzsOYZUM5zl
   f/0lnZE8/KWAGR8+QCzjZJuRVWrreqb5LqtmgC7NLUpYncKLkWYU7kaTC
   +boV1a+ICNjh9/OOg7Hc+CQxgJaGelfnUqMZfAhh0Ns+1eoXJ0/cF10fW
   04EHFiGAuphNlOcY0z0sMVu0ROtaohuEkXKoN6ueorSoEZ9JfnMovTni6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="19768364"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="19768364"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 09:17:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="758053939"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="758053939"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2024 09:17:47 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 09:17:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 09:17:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 09:17:46 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 09:17:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfA+oEXqNNp6lJKoWqmvmyB2Nv+H02L7bg8IrDH02mOxz8kAAKICBEbfNNTT923DzjLs3GpXxyzWoRYVySWCW+mpbNeLetGh2asz5NVP3R3C7yO5kqcN0pauXU5IXcm5pv+OHdlS6PmoswKC/IyZ/vpC+lr8parTRiN6alc78A2gM/P/zyUbuYzI+3RZtbcqhRDrVjjgWGCHn9KSU1xsxPJzaRUQy8Rt0eTBBxYJgbpT5a6/Cb8VZV8PcYMwobNoaYNuY291MNfJRBvNh6FI2hQ9nJpaaTIht6p7z6UmkshJaigsQmld8VHXmOCXdOUAtfBWNj6IPNL8LwPUq5JwKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcgWM3jVEAiHeUIt8anpFdeoSDr/Fqmw6pfZ35ABn68=;
 b=RrTmuVGeInXaIWq3d04zHcxNlWl4dY387y+fTzKlBXCdoU+J1MzqN90t0qMisY200FuAW5k0vZofeV/NPc5XJX3yEdFfR+0xFbHcwIxvIfJsmg+nTE2yDnSQKGH7f0iUPC5FOwibod6OznALrWZ2Mi6Sh7BVTjL8QgicPSGbgZxNFRxujR3GyErU3eHwcsYV6LhbP/3i68us7rjdmCiytWGsFJLzMq7KkLw5Fg09SDHmGYgf1UPVK44YENei5ZlcA+ClmQXW05/yAwwR3OOEcZFRhFLTgAFLucMsfEId7kvhSvrPE8BXC5ZsWD7THzDeoz+DdOzW+wmPmXopR2NVzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Tue, 9 Jan
 2024 17:17:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 17:17:44 +0000
Message-ID: <8f8056a0-b5db-459b-a479-39f6967c4e29@intel.com>
Date: Tue, 9 Jan 2024 09:17:42 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] selftests/resctrl: Add non-contiguous CBMs CAT
 test
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Fenghua Yu
	<fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <cover.1702392177.git.maciej.wieczor-retman@intel.com>
 <10c3afd7f62c63db31a3d4af86529144a5d7bbf9.1702392177.git.maciej.wieczor-retman@intel.com>
 <fd6acf6a-2610-406b-b363-220121a45aee@intel.com>
 <33787043-5823-6de4-4e5c-a24a136ba541@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <33787043-5823-6de4-4e5c-a24a136ba541@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0289.namprd03.prod.outlook.com
 (2603:10b6:303:b5::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW5PR11MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f9a0cbd-5300-4140-0293-08dc1136e46e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vyWWCt4fiajQSSvHqyR1J8FZv9pCcDXv6sMl2y6Gq3/wVnXvh/hiUK1fVjC02k/+PBiftIkgTgx+qzPb5xr4kuL8figR1qprBSUD+3x/WeBXX0r4Ar4OgcYOOT5cXfG8/4p7qgBM9dU4RmdXH4R1J7WMbnQumyNnNGf1Yp26DdgOKUfgC2uqf7ePWMIITq2D8KiQUcORhgIc3+ZpDl38vuP9YU45J4JRjca1e97UDRnug6N4nvqtzaIW6d3UoAMxl+dOFJ5lrq3E7XcQ6altdDwciNqwg9+D/WPKAg5pOxLmTUEnmPQKl0I2TDQ3rFU9z73Ra4XOWfED9X6j/JJIJA0UafCvOE5Hn/AneETDbTFocfNRY1aBzmqmWy+4be/avprnzPqJq9pfDLyHwihuCxhY8/euUljNJuJfPnXVatuwaAYsK3TWHnuhVqT/qK/KFR8plzRRUBGhF6wqsvHUWB/lr9IC97sDyX9GXleEALjFiAYzTxcAVO1ck0EF+FPDRE0OCrjxmRivL2qdii7eY6tn60WnLx/nDYGJ87vGI8jm2RbuSTsdXyCS95fmUZZ6AJTZJ1bQ6w8eHWMsYLwaQxN4a9jEo1DrvKvjoMJPiExYWno5dyrnb3XT7QPB42CS29Kv1Z/rOKENrykj4lwF7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(366004)(396003)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(26005)(66574015)(83380400001)(6512007)(53546011)(2616005)(6506007)(5660300002)(44832011)(4326008)(41300700001)(2906002)(6486002)(478600001)(316002)(66476007)(8676002)(8936002)(54906003)(6916009)(66556008)(66946007)(86362001)(36756003)(31696002)(38100700002)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmpLcmR0VTRXZDBaaTlFUklDRE1zSnlncDhKcVZmRzdVQ1JqWEUvTUQwRjdD?=
 =?utf-8?B?WGRJOXU3ZFNPM2R2S0o5M1FESEJOa0F0TmVoNHdXQWhDcEdVL2N3aFRna2RI?=
 =?utf-8?B?S0tXeWpHbGZVNHdCaTFSYXE2MU4xMHZST2w5WnEvdGVqcjRyYzNreXFnTGg3?=
 =?utf-8?B?WXhTTmxvRUxiUERVK2xlT3pEakRHVjVjZ21JZmZObHVQdXplU1l4STMxTEQy?=
 =?utf-8?B?ZTE5UlltU0RJNzc2MnJDMXFtUWRkRXc3MFhNT05qNVlYajVxcExhY1orTWxJ?=
 =?utf-8?B?ci9hQ01PVDUwWlVoZys4eWpaVGprOHp5eDBOc1J0V2ZxTkt4OWpxcUVvTkJ2?=
 =?utf-8?B?MHp1bldWUnFob1dqK2hXa3owQjd2UFRTM1o1b0IrckYrY1NDVC9wbSszWVp5?=
 =?utf-8?B?NExnSzlPZXcrOWhhaHZHZG81ZGtldG9NbC90dHk2MW1GVENLK1BUajYwUGlL?=
 =?utf-8?B?R3FkV2h3cW9NZjhDaWoxb3dFTWZINk5LOHZuU1VFWHplcVh6TFFiSEtRZ01x?=
 =?utf-8?B?R1JqZDU2NXBobnllZDlBNEpaNXk2VW5uOEVIODRKblI5OVBTM0JUNmlRbi9l?=
 =?utf-8?B?bjlHb3NoN1NlS1V5MVJkd2RLdGwwamhaRmhMUkZXYnM3UWdqYzRiWS9nWDg3?=
 =?utf-8?B?RGFiK1luU1d0NTV3V0Q2UTBxQnNrZ3pNSnV6NzVJWUhhR0dpREc5SkI5THRX?=
 =?utf-8?B?MnFpN2ZLUVNacGdCc1owM3hab2ZCcDNqcXlLa0RRb2dKbjBudU81d3pwOSt4?=
 =?utf-8?B?OXlEUFpKeWhvNStnSWhLaEt6a2t2SWdsQWdCOXFzbzUzWmZvMm80MHhscG1J?=
 =?utf-8?B?ZFlhbk9iU1VpT3lMMVM2S0N1QzUrNGt3VWcxRzA3QlV1RGw4LzFKcXhFOWdu?=
 =?utf-8?B?MEZiQ3kvWmNadHhIN3E0eUpYSVBTY0tlYmNOeEp6RFVpSVpPYTFGOHA3VS82?=
 =?utf-8?B?cXlSMVJCSXYreGw0UlZnNXR3amtqTnpPWk13dmdhS1NlQXd0MnlhNDJWM09a?=
 =?utf-8?B?bWZsVWR5ZHAyRjhDamNqRXYxNnpLZjNrN1Q2ZnIxNDR1dmk5NGFBZ3poRkZJ?=
 =?utf-8?B?VTlPdTJKM2JKYlB2RDhtcDc4dzhmVXl5RTUzQnZsU0wwSWRBNlF0ZTQzQlFx?=
 =?utf-8?B?WFl2YWREYVc5REdUalJuQ2NaRkhQSDh4Z2JkTCs2cVhVY2p5R0c2SkhVeW9x?=
 =?utf-8?B?UE95cXQvUjVjSDB2RFFmeGpJQ1BlQUIxckt2MkFtd3pEa2x4MlczZmg2a0to?=
 =?utf-8?B?U2Z6a0NwNTQ3OVFtUnlHZ0Z0VGRkNUlLdlorbXNpdFM3MGJhYmNtazhHMnVv?=
 =?utf-8?B?RnJMNnVqNHJiTFdJMTVlbXNDb0VSa0s5eGJ5QlR2ekwwYTNSWUVWQm50RjJ2?=
 =?utf-8?B?QUM2ejN2Z1lrZmtyY1J4UXlOL1R3aVhzN2ljcUVDb1RJb1VNUkluNE9QRHVv?=
 =?utf-8?B?NWNPR1NadzFDbEs3d0MzMHRkbG9nUE5TODlQQjN4WDhnTFF0emxCQkpHcjls?=
 =?utf-8?B?djNuT2RWcUxxUTVDZm53cUt1dnJ0dlRpaSs4a2hKZjRtd2h4Q3lNbERWUEha?=
 =?utf-8?B?WTBsUnpXMzA0UE5YTmgzbWZKOFp3cW1aMmhsaHZzMGZVajlmcThzd1hlWjBj?=
 =?utf-8?B?QUs5UlRSalJjd0QzOTBKeG5FbVN3T01QTWNIUG43N2o4c0M1V2huNktLVnRp?=
 =?utf-8?B?bHJOTXVVMm0wdHdsclNjTERBcWd4dW1Cd21iY3YyQ0RRU1pmY0VPWTh3d3J0?=
 =?utf-8?B?eHhuZmprRlFTemVDQkZ4cjdBa1dVRE40OVYrOHdFekxXZzFzYS9kU29kL1Ew?=
 =?utf-8?B?eEExaVYzd3pMMnJrUkR0L0FQNFpyUDBpUVhMell1RHljNERXUW1MRjBYTEJs?=
 =?utf-8?B?Z2g4RzRkYXI1Z1Q4a0VVREpEWmlYOU15V3MzemdBZHRJWUFaSFZoQXhXWndv?=
 =?utf-8?B?TXF3bFpucUtNaHRnNXNuSDVQZ29LOGJEeTBVMWZuVTJnV2x1a1ZZNFRlZ1Bv?=
 =?utf-8?B?ZUNqaGUrb29wazJjRURWc2lIOXpPK2hHM1haRFRKcTF4dnpmcXFaSnVVejRR?=
 =?utf-8?B?MjhzU2xsVFQyK0VWbHpDRVVMVzVqNnA2K1FrbEhMaVFjUXhLVW1EbE05K1Ns?=
 =?utf-8?B?a0ZkWi9rZXZ2anAxMUxtejNKSnFDOUxwVnVTc2htV0Nhbk5Jb0Joa3UwbDVt?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9a0cbd-5300-4140-0293-08dc1136e46e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 17:17:44.0118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XuXMU5G8puCCXWmZ1pu6FLn8eBFVZbQdhAoCq8JDW1rB9tU0irxrCyp2NLWyM+zhXT0CMXypgU3OyQcdCzpMyCiN6qshhrEmlA0HqQFDvss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5881
X-OriginatorOrg: intel.com

Hi Ilpo,

On 1/9/2024 1:13 AM, Ilpo Järvinen wrote:
> On Mon, 8 Jan 2024, Reinette Chatre wrote:
> 
>> Hi Maciej,
>>
>> On 12/12/2023 6:52 AM, Maciej Wieczor-Retman wrote:
>>> Add tests for both L2 and L3 CAT to verify the return values
>>> generated by writing non-contiguous CBMs don't contradict the
>>> reported non-contiguous support information.
>>>
>>> Use a logical XOR to confirm return value of write_schemata() and
>>> non-contiguous CBMs support information match.
>>>
>>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>>> ---
>>> Changelog v2:
>>> - Redo the patch message. (Ilpo)
>>> - Tidy up __cpuid_count calls. (Ilpo)
>>> - Remove redundant AND in noncont_mask calculations (Ilpo)
>>> - Fix bit_center offset.
>>> - Add newline before function return. (Ilpo)
>>> - Group non-contiguous tests with CAT tests. (Ilpo)
>>> - Use a helper for reading sparse_masks file. (Ilpo)
>>> - Make get_cache_level() available in other source files. (Ilpo)
>>>
>>>  tools/testing/selftests/resctrl/cat_test.c    | 75 +++++++++++++++++++
>>>  tools/testing/selftests/resctrl/resctrl.h     |  3 +
>>>  .../testing/selftests/resctrl/resctrl_tests.c |  2 +
>>>  tools/testing/selftests/resctrl/resctrlfs.c   |  2 +-
>>>  4 files changed, 81 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>>> index 7dc7206b3b99..ecf553a89aae 100644
>>> --- a/tools/testing/selftests/resctrl/cat_test.c
>>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>>> @@ -292,6 +292,65 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>>>  	return ret;
>>>  }
>>>  
>>> +static int noncont_cat_run_test(const struct resctrl_test *test,
>>> +				const struct user_params *uparams)
>>> +{
>>> +	unsigned long full_cache_mask, cont_mask, noncont_mask;
>>> +	unsigned int eax, ebx, ecx, edx, ret;
>>> +	int level, bit_center, sparse_masks;
>>> +	char schemata[64];
>>> +
>>> +	/* Check to compare sparse_masks content to cpuid output. */
>>
>> "cpuid" -> "CPUID" (to note it is an instruction)
>>
>>> +	sparse_masks = read_info_res_file(test->resource, "sparse_masks");
>>> +	if (sparse_masks < 0)
>>> +		return sparse_masks;
>>> +
>>> +	level = get_cache_level(test->resource);
>>> +	if (level < 0)
>>> +		return -EINVAL;
>>> +	__cpuid_count(0x10, 4 - level, eax, ebx, ecx, edx);
>>
>> Please do not invent relationships. Please replace the "4 - level" with
>> specific index used that depends on particular cache. The cache level
>> may not even be needed, just use the resource to determine the correct
>> index.
> 
> This is actually my fault, I suggested Maciej could use arithmetics there.

No problem. The math works for the current values but there is no such
relationship. If hypothetically a new cache level needs to be supported
then this computation cannot be relied upon to continue to be correct.

>>> +	return !ret == !sparse_masks;
>>
>> Please return negative on error. Ilpo just did a big cleanup to address this.
> 
> Test failure is not same as an error. So tests should return negative for 
> errors which prevent even running test at all, and 0/1 for test 
> success/fail.
> 

Thanks for catching this. I missed this subtlety in the framework.

Reinette

