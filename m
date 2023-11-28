Return-Path: <linux-kselftest+bounces-780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6417FC96A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD632B21354
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9203550241;
	Tue, 28 Nov 2023 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T4oE3Hnc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18513E1;
	Tue, 28 Nov 2023 14:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701210172; x=1732746172;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V8Uxmsj5i8AtFKUV0lSLxIhfhkJ/VdWWu1OWLDT9xr4=;
  b=T4oE3HncCGCMU8mu4sQp8HAo4bPEuCux/phBYuF9k8Xq4GUPRvy0p0O4
   +oeoWkOAC+T5y7DUXda+wV7iU98agATv36ynEouphEzJJM5Ja5JVeub5Z
   vEwF4ievT/omwtcoS9skPUFlC8O8lr8duVYcut+bZlnc8Z6UjgNbiaxj1
   /s4AaEVcnLRu8ZsE1giPfEgUs1TLwQ7Izt/6M+NfiAE1/p4f6lLoZ3YY/
   8mVz8DW5DSNkNLeKNwgJfvi82tzrc8vUBO/DOBquadsGcFJF25/WtDF85
   duSvLYUHADgftraQmftU5yZ2mZtto6NKK54iwAN8EU6LFbJ5rNz2+OKKV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="396943932"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="396943932"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:22:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="834794520"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="834794520"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 14:22:49 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:22:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:22:47 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 14:22:47 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 14:22:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGY3sFTFYbuT42965OjkzE2W1DyBrtklq74ShaAYbRCOZjPlsC4id5/kuNKvwHYOR9s3sgBgaTh7fONtw0t0vQhw7MqPEC/vJTtTT0Zs1Mgip7cOj432/wyWP7SLUR/+x2O8atFhYrR8urfg6biL5ivw5OKylOAmcLL7TO61V0wnkSouW+jO+zjagji40MCpUSVBKUrvgzoMgAsZPltrDfHhNJK2jd/99xD3sELkdDbWMgJtlJsRQj0ybm3/7QfjG4llssKR+/xndsvyZwYt2AvxhUjmil8m0cy9GDp/+hzsRZ5D6iR9RVGlu+b/zk++LTeY5qch5AZg/fs4CeMveQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nV/12cWS6GWQjkgO6rf+VPiRIL0zTu1bVol24h0cMF4=;
 b=neUuHEWq4teNTPvNBPzlCP207c4m2FN9fw1M51hkaJb2RsGXXMm7d7AFdS7v5OoX9eyGMjjsXZVgjp1D3KdU60eNoeftuLUCmkwfDdiHxPiv8DPLrQ/f6tas3egV+7XISYYp8WeeSCBSaGvdJKBX5Ff0tBdia6ZwryKtyXtvoybU/AkaEbQ+Cc/nYF4947nQQe+sjaNUC5yEryDloOlEL+nZb8PlxtN5njRDWbUsN8vvutKZPCifJ7PY0+SSlJHf68VjRfly7Jz3shEO6xGocfRWAR6o3szJPUqfMiW1hMpF4APz9aVgJ2EfFl4By9fzB20ZHmwFPnAmuPi1J0rRBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV3PR11MB8744.namprd11.prod.outlook.com (2603:10b6:408:215::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 22:22:41 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:22:41 +0000
Message-ID: <417b5668-e020-46a8-b5d0-80a87fffc634@intel.com>
Date: Tue, 28 Nov 2023 14:22:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/26] selftests/resctrl: Get domain id from cache id
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-26-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231120111340.7805-26-ilpo.jarvinen@linux.intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: fbc05af6-c6a0-4212-d442-08dbf060894d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RaipeSiEprHb1uZfhyqpGo0cxrdLN4MfHni2L+Y7pN7k6fLtj1T9/oiHVYLlQDDyy8DwbEZMp/3BOJpdFVTRcmTpxEDGhhyRgYBkCA3Trm5+y1pwqE3iV/dnOnx/gragXoi8PZ37k3DYKbALvXAHCj5emy5BpDXzvctbNPsqhVBaRPf+gTDydvZJZl8proaE3nEDBopp3AtHK1hKcMFDQvoy4MkmBGuE5WKFhrGtCZho/16JRbM+0pJ+vsBUzuCZo6+EfATaXHTHwOFvGFDHwG3shPDdJv9nCht3M3QoGVIXLr/g9UTDvqLPW+BbekRZ3/fPA1Q63LnRc6gDFMJI1DynEkGJp6aAb724MTbq1V0ncqAmeAvVejqeI90ZyXEFZU4Owpz868FPD6+Q46vk8n0UmU0clcajM9nS+ywIlrr1OLaqagUjMc3QvOyeSLPHCZafUqAWg11yKDQ9pf1Wc4tosVdVaor6/RETCI4mnDZmRwjOz8f/vfIKNLj8VNBGvv0HGDr5EgaBGw9pmKSMeor9lD46/WddhesCKIXSz1CHopUHYhZO6U4oiMJWkrS+sI148MDQJy21mky7jwUN9PNlV63XIkiWSPYf9vhqZBuRQrTCuP+v6+p+qKJYnQXhijNEpBeho2uOny5AsJWDzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2616005)(38100700002)(41300700001)(36756003)(31686004)(86362001)(5660300002)(83380400001)(82960400001)(66574015)(26005)(2906002)(44832011)(6512007)(6506007)(53546011)(8676002)(8936002)(4326008)(31696002)(478600001)(6486002)(110136005)(66946007)(316002)(66476007)(66556008)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnJxR0pMUkc5YzAxMVdHUS9Rejk3bzIzT2Q1dEs1ZkJ0aXc5QTVldkpab0s2?=
 =?utf-8?B?TnYzdFBMelNWZ2xORUJRcnQ5T3VBQklkRUloczVTT2YreVBSbkh3RVd6SlQ0?=
 =?utf-8?B?OE5CZVZaNGNKQXQ1Y3U2NHVLVERSZmFBT01LQUVJcnVhN2Yvc2dnRVI5aWdk?=
 =?utf-8?B?cWt3Y1RTdmsya2ZSYkdIZUVERFhZUE9hbW5NUFVrdExyQUFjMXRZMklpTGgy?=
 =?utf-8?B?S2o3MUNleXhlVXRFNHQvemVSQnUrWU5ielBNT3RHbm91QVJCUXFqYm9XcFpt?=
 =?utf-8?B?OHBtRkprc1VzUGR1eHdMZmVCVDhBc1h0WUc2V0NCVXNGZmg3VE1tdlF4ZFN4?=
 =?utf-8?B?anpkUUhWbURoUkJmZDh2ZE5MdGVUQ3FacGVQYVdHRjdHa2JEd2FMZDJjeXpC?=
 =?utf-8?B?MkZKc0JFWUtKV1ZWSWVtREk5djFyK0lXZThtNWRWNThLRW5hV3NLWktCaFNX?=
 =?utf-8?B?MUplaHRnTmRsYzNsMXBWUWhaV3N4NEN5bERyaThrV2tpQlp3TGIrOVpkK3pJ?=
 =?utf-8?B?S0NUT2JlL25Xd0o1T1EvbVNMblR2cytDVyt3SWxlSkxRVUR2ZTBiYmJ0eTRB?=
 =?utf-8?B?eWt0MVBmVlNha1pPa3A0R3paSWZRM1Z0VHExYUNKa29QalJhSTJaTlVrQ29q?=
 =?utf-8?B?UmNxa280bFpGbzIrT1lGSWdlZ3M4N2puaHhWdHdrYlhVdGVvcEcwZktybndv?=
 =?utf-8?B?NVZZNm1saUR6NXdiVWtjZDF6YW1WSDVYOUtDRTd6c004TmZKaDFkV0pFc1Z0?=
 =?utf-8?B?d0k2Q1dnUjhSV2RnZVRzcG5BZlVGNGhpSC9pMjkyOEE5dERQaURhR3AxdVVG?=
 =?utf-8?B?bXdqOXA4U09SK1RLaGNlZ1NRRG1VeHRGYjJuZ3cvVjZsc08wV1Nycjd5dHVX?=
 =?utf-8?B?T0FWSi9TTVRZNnZsWDlBamxKNnh6TUlhVXRleFRKanhiOUxsNzBVSEl5NlBs?=
 =?utf-8?B?UHFTV0cvU3BlL1plNmI3a0RRbkZCSU05QzBNTW43OFZBaVFkcFJTcVFRV3hu?=
 =?utf-8?B?ZmZwUHd5QW0xVW56cWdONVhjWmdKRWxVaDF5QjNFVDdTQS9xVlFDeG1ta0x3?=
 =?utf-8?B?eWZ1cGNCbzhYSHVEWUZiTDgwbXlzK1l4Mm9VeFFWTFBDczBmRVZ2MVJYSERy?=
 =?utf-8?B?RWIzbitRR2RXVHBKZTc3MVpsV0oxb0xNSVJ2VkVNaDhLZThMQzVwTDllSjBX?=
 =?utf-8?B?UEdhanNtL1FodG9jbUJibElZREpkUkRVOS9nVlF5N0tCMStxTUtWUnhHb2Jw?=
 =?utf-8?B?VlFZdHQ4QUxScWdVRXl5SVF0bmRvNTFkYWVVcHNXZ2tsZTFaMUwvL2o5L09t?=
 =?utf-8?B?elZxYUwzckNUUm9RcmtlTjk2dWgwTExpc05BdGVaV2lwUzg5K0Z5ZmRFK2h0?=
 =?utf-8?B?b1BxUEJEVW13MENuMm82OGN4UmFsQi9LRll4TVFNaFNtdUpOSG5CeXZ6bXRB?=
 =?utf-8?B?WVlPRlJYMTduTHJTaW5VZnRnMldmc1FJTEJIa2lLNzNVQ2xWSkNxTmE5VTRl?=
 =?utf-8?B?MGt1OGh5d3VJZWU5dExXcmhPcGRDam4xcEVLWUZFT3FnZE5NaklmdlVVYi9Z?=
 =?utf-8?B?NUYrQkwxOGowcHRkcnRQb2NPM3I0czAwRHQvTUdHOC9mNDV6V0gyQzcwSWN6?=
 =?utf-8?B?ZVdJWUZLUkFOUGNRaVhXbTlUdXBBK0I5VEI0ckRpZnd1b1B0aFJTdlZndCtq?=
 =?utf-8?B?b3loaFVrYmptSDZrZmdTMkNpQ3hVZDJnNTJGbzAzMVQxM1J4Ly9ZK1p4Z0hL?=
 =?utf-8?B?M2xjL0wrS1ZJblUyS2RPT2VUL0tYblBMVnZxZXBldTloSzBXWVNqMG9TNExM?=
 =?utf-8?B?b29EZXNmV3p0RVg2M1A2ME5PQ1hKQkoyUnJVMHFNQk4wOTRvTjM2ZHhVTnBo?=
 =?utf-8?B?WE1jRnpXRG5qNzFXWlpVQy9jVkhNY1IxVGR2NmJybzh1dHJKcVk4QnJkY1BU?=
 =?utf-8?B?S1lRdVBkMzJMdnZVWFpxWXFta2pQZ3ZaeXVEKzkzdiswKys4R1p2ZTNrVlov?=
 =?utf-8?B?S09DV29WbUhSbE5TbXI3WitEU2UxUkYweWM4cDZQeXBVeG43bFZwK2pEOFhU?=
 =?utf-8?B?RTl1MEVQRFZIYlVMdW01d2V2VzdSeWJVWEU0SDJITkQ3OWdBbi9vMlVOYnZq?=
 =?utf-8?B?eEY2Z0NFb2hieGo2ODcwcmVlVEpvRTBRR1VRSGRiY0ZFNlZQRDYzMVFqbTQv?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc05af6-c6a0-4212-d442-08dbf060894d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:22:41.5202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9lT5yMQOFp51VF3SPiAKZXxBfJads/tNKooNi5kikr5OYRM91uz3uE9wgm67zBf1ew86e4Bi8OcZBYgaMC0bm+th/b8n7x5Zroxza/Sqr20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8744
X-OriginatorOrg: intel.com

Hi Ilpo,

On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> Domain id is acquired differently depending on CPU. AMD tests use id
> from L3 cache, whereas CPUs from other vendors base the id on topology
> package id. In order to support L2 CAT test, this has to be
> generalized.
> 
> The driver side code seems to get the domain ids from cache ids so the
> approach used by the AMD branch seems to match the kernel-side code. It
> will also work with L2 domain IDs as long as the cache level is
> generalized.
> 
> Using the topology id was always fragile due to mismatch with the
> kernel-side way to acquire the domain id. It got incorrect domain id,
> e.g., when Cluster-on-Die (CoD) is enabled for CPU (but CoD is not well
> suited for resctrl in the first place so it has not been a big issue if
> tests don't work correctly with it).
> 
> Taking all the above into account, generalize acquiring the domain id
> by taking it from the cache id and do not hard-code the cache level.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

