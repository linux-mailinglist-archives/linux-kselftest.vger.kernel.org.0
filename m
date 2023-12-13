Return-Path: <linux-kselftest+bounces-1874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6BC812117
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 22:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE6C1F218C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 21:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D44D7FBC5;
	Wed, 13 Dec 2023 21:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="he1FV3xk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB77E4;
	Wed, 13 Dec 2023 13:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702504787; x=1734040787;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bxB5ANbzzq5s4hbsTRO0PHGA9B7kg4b2CdNMTusJFok=;
  b=he1FV3xkDQsMtgrzP4RjTZPjHOUT72lRMDtgPikiKBJTbAf5Vbx2nju3
   1BYyWwS3yym30paIyXWMYr0+I0+Po6KT2HtmWxsT9pu0Dyamr6h88ILKN
   PWNBKBQaGgB8NtwCavkH1CvsNliOOew+n+JGA1Puox96GHuFHDGo6V799
   9s7Chyijbp5b5jpE3RKqf2w8ewqk6Uf7siPuLHe6QeOFmhrZtQy4dApsM
   C91W0DD6S0Bc+IMFcYRXftPoklaknbpQnyYvmWZlyNwhFmjNDUTAGYffr
   niELl1a3aBvBCCMb75cpUxblwi7pxgq23yGoxGkPgp+qc2e1tI/uylJQB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="374538208"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="374538208"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 13:59:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="774096677"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="774096677"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 13:59:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 13:59:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 13:59:46 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 13:59:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Li7ULUyzhvOEdF+zrMQQWi3QFGzFzYtuKg5oH8IGejYnlI8Dqgo32us9diPzB+uqfMpS2lS1JBy8ce4PeIPrWqapxFxElN2IZ39JxXwEzYMwlDJBOhEnib8DOzDE+hkFA1Up1FXHO9mTdZY9eJ+flwuKD6Rq4yKiMcBFRaRnONo/a4uFy/uzFt0bv3ODDHEVOGZSVYubD8NPvH6LOCDHGLgPYmbEkIOoWNq9WFRkUA1Hsb0RdPX+sOF0/b/rmporvTWazJq4RRDKNR8KhRh4An1pyQvbyKDtKWDC6GJ9HLJBrN9zHj3W1CtLFfNgyuCOYu+FNivcUwvwpomCT+tL0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHYPKvN/YVCC49ztEYfmY3KE9e9IzEYN5v/mHGw6/eg=;
 b=Wo4/m9YkIlWkIbiV/RWGPic9m+PDuvcuo9r/EKeLWBI2LM1GROp7SHgKX5ycCuu/ytwvezGcsYHVHEYdFFKWAn8NIjZiHSDC1ZYvdumxTDvol4xMbh750zbGy/PN4cF5tof5RmKR0LWtib3NhS+2fJlN4iblwar4I0zW5PI3EUbPIdLI+JeJDEftqRbp4uhjaTAlxkRHRivhbtlbRCJuQxy7y9fRHtk0I7/nyn0NnTKqjzXJvjAF9oxtBST2B5NQ6RZTJKmlow58J1rN4J5hSnvKdDZJ2lDbfPRq4ZdW/J4bf80CDNIUfdIBKkEzbnJNsbAH7kPMyAK61K5qyQ3ugg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7663.namprd11.prod.outlook.com (2603:10b6:510:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 21:59:43 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Wed, 13 Dec 2023
 21:59:43 +0000
Message-ID: <c0a05ec9-f572-487d-b4f2-e8e2ce4dba7e@intel.com>
Date: Wed, 13 Dec 2023 13:59:42 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/29] selftests/resctrl: Create struct for input
 parameters
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
 <20231211121826.14392-25-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231211121826.14392-25-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0259.namprd04.prod.outlook.com
 (2603:10b6:303:88::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a8be93c-46eb-4100-fb16-08dbfc26d02f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BixwgTcwBnifDpThLTLHjXHcLk6vNUHToL4r1emsKK1VSUrZIBkCRUvyI2qZ1EdTP8WoV1qlPgRCc32rXBvTsn0I8HNcB8H8ivJtciZb1rUuxxUxxHI85q3+/xXsCJTLz2BXJKrP/IZRPTKmeDw0wmv9S8xR7b/BgOuuyIgs8+66hAEonCpp2b5qWEcP7vSk0iGE2MdE4Kb00kqPWjjOt4AdmxpnsL5rXvoN4SWeJlSNelknrXeuX/bvOBrH8GCn+r8/r/fqo93vPyRXRLtfe4H+FiJQR4gQXZe3GBj5fMHsPYq2up+pdenDfPvAOy84Bb4YuYeeLpq7faY3KVQ7z5c0MVk9ggsLx9bk8nHhF9CfD5PZ0gBQLs5LW23N+LC8GLUmU+XrNN2e7BMN0xNOGoYmpkdEiBVyC/+VmV0aIxHwkE6Av/KlRd64ETg4EnfiZrHXcSGQgIFS95Bo1Ge7ztxqbY15GaD0G+XJsj/ogKDHsK2rOGP3eLqpIiVz4uVnq57sIvekb+kdB1yd6wcmujznilYQkIlcldTijgaWuZgBBb4nTmjd1y/lm4ehPXs0pQ34lAEcO78MJUf7ri0ujmFAI5VcVY1Z5HhEc5zXwt0revRfMskidTp5ST3qflHdrTBJEmp0OkKbsd2FQvZmOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(31686004)(2616005)(53546011)(31696002)(86362001)(82960400001)(36756003)(38100700002)(4326008)(5660300002)(6512007)(6506007)(316002)(6636002)(478600001)(66946007)(66556008)(66476007)(110136005)(41300700001)(44832011)(8936002)(8676002)(6486002)(2906002)(26005)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm9xY3E3N1JXMWdTcm04R25lSFgwcGFhbjgzUWp2cEhkV2UzNitNWURaOW5h?=
 =?utf-8?B?RkJua1A2MGNLZzdwaFRkVG9zNENOSVdkZXRiMFpCaHpSYlVHNmtQdisvUEN3?=
 =?utf-8?B?WXF2L1pEUzJlS3FwblpQcTVLcnd5c2pnR0dtVWZNV2hjaCtFSDVodllyU0pz?=
 =?utf-8?B?VHNpTit2K05TSkxOOEpYTWhVdXFzMUpxbnl3RnhTcFMrQWN4NnBKb0NRSHVk?=
 =?utf-8?B?OTcvaHFyVEdzMXdqVWRMUjRzU0RtWlBXZ2Z6R09YKzFCRnJoWjZFWDcwcU5I?=
 =?utf-8?B?cDdoMHB5MlhuWFF5dHhwS0JLYUhCMWlVWFB4SEZyUjExR1BqSnk1S1RDNkUz?=
 =?utf-8?B?MmZYbGJ1UjdKLzFyZmVoNTAvNGh1UGpmZC95SkhyaXhGMndOQjhUd1NtZUdT?=
 =?utf-8?B?eS9LVzJic3M5SDdhRzY2YU9hZXZkdStKV3lTYkJVVkUzczVWeVBQN2dIR0k3?=
 =?utf-8?B?MVg5amppcTNDUktUSDNzSEI3dnh6NUlJdXZyd09HVjUrcytmVEhqZEwwcGMr?=
 =?utf-8?B?Wklabml4Vjh2ZmhNeUZmd050dENkRFZHZ0J4WHhjRkhkTGRjbGFJOXdOS2tT?=
 =?utf-8?B?dkVwZXhQWHJRWThmWDNkYjFsOVdXRklKVnE5K2swWHNQR1RTd0JtRmRWVTdZ?=
 =?utf-8?B?SmRzcTRrM2s1MmFlNjdPaG9ZNElHanBXRGVlbUlBZUlBVlZhU2VCY0tnZGRr?=
 =?utf-8?B?V3A3UnFLRjc3ZFJtNWR2d09zendyYjJnOWtidkM2SlJjL0RqQk1tM3I5UlV6?=
 =?utf-8?B?cS9wZ3FTQzdxZVd3RXllUkhVckk5YTVFNWI5TjhwMzhVdTJKK1NOSjVBejFZ?=
 =?utf-8?B?NGRoTVc0Qm8zekdnVTJQUVRZTDh1YmpVMDZZQzJEdUdiZWw2YzlEaXhTQmgz?=
 =?utf-8?B?a05hcDRucXQvekpFQTFzc1d5WGhJN2VQWTlLaHNZeWtlNGNCTVpXZ04vc0xV?=
 =?utf-8?B?ZHFjM2tlQTI1MlVoeEU0SWs5d3NkS3BCbGh6VFROTGJSSlhYblFsYTdDSDVk?=
 =?utf-8?B?YlJkTlovUUZ4a0h2cnhHWUNiM0VBZmpSTDh1ZE5vMENRY28xb2swZmsxeEF5?=
 =?utf-8?B?T01IdUNDcjV3WHRuTTZpeXowVTQwVmNWcDRGSkh5Y1lSbDRoRHZQTFR6VXVm?=
 =?utf-8?B?aTVIbWNqbXIrQUtHVElKenlkelJ1VVlXc0hHQTE2Z0dLWkpsbEc4aXNzT01W?=
 =?utf-8?B?MTRSTWRkVmFVcFhxMjg0NWU5RGtLcUJ0c1l1VjVRMkNnWEF0Q0dHbGZ4UDdD?=
 =?utf-8?B?d3ZRb0VEOHp4YW9nM0pjQXA4NWFpSHU0VDRMNFF6Z2RXYmtXaFVzc25XdmFt?=
 =?utf-8?B?QmdHNmtFK0RteEpoL29PODdrTW1ORXVTZE5EbzJyVkJPenppKzlSeGtpZ1pp?=
 =?utf-8?B?Zm9BZ2tYYzNyU0ZBejd4RkZEV0Z3NWdrMnJ4aTB4TlZZVXh5OGJ6eDU5VW1m?=
 =?utf-8?B?Tjk2K1ZYVHRmUzExSkNBRG1EemhGeTBPV05tUjJEdmF1YjFsTmxOcW5hVmR2?=
 =?utf-8?B?aGlsc1B1SGp1V3ErVjBlZzVEWVV0c1N0aUpUN3FXdjV6UXJrV1RWM1orTUtw?=
 =?utf-8?B?T3RUellQMy9NSXVyVkp4aVRLUzhTd3RzMWV4eGp3UENxNHVhenUxK0pSbnZP?=
 =?utf-8?B?dWt2bStLTVVTR1k1RG1WY3dHTDE5a0taazRRbmdjM3RjMU4wZ0VrdHRnd3Ux?=
 =?utf-8?B?cjVmOUQ0YXJDd1ZRb0RHVUp0cUs4R1hMLzZNS0NjaXFPbCtialNjVEJObGp0?=
 =?utf-8?B?RmMrK3VtZ3MvTEUvNUVZb3NTeXNuQ1RvaVFnZTk5STdqUUVjYVUyVWo3Z3p3?=
 =?utf-8?B?bUVFVzRvVWRjK3hLVjVnODJLcWR2Rk1mK2w4VkNXM3ZVMmN2Yy9qZHE2Y21k?=
 =?utf-8?B?ZWcwK2wyRUJCbktibytFcVlSbE5rM1dnMzBjVnVjb1pqQlBnVVMvL1c3K1FW?=
 =?utf-8?B?YVMyNGpTT2U1Sis2YXRNUEhpdkpTOXdSL3h0NmtPSHpOMEtJc3FRVXdkWHlw?=
 =?utf-8?B?VlB6RXlKa0FWR2sxUmRzRXZDaDBsSGV0SFVYTXg1NU9leVhXN040TWloYmw5?=
 =?utf-8?B?MlRHb1VEazBHQWljcFdlK2d5MTAzT0NiZE04QTIvZkJsKzZkWGxhaXN3V0ZJ?=
 =?utf-8?B?YkN0MC9GZFhSeTYzZWdxUjYweWRRd3gxSnhEc25pVDk1dHBtNjRkTVhzNnpu?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8be93c-46eb-4100-fb16-08dbfc26d02f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 21:59:43.6310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mPGgkQ1dLk8ZOF+ADuAihje4i7CHtBZg9alBY6mp7YIItdLreXe1RWja5k7U8RPgj/xGwuBC1eBPkLtmsElgDanL4LvR9R/7gsbaSrJ2/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7663
X-OriginatorOrg: intel.com

Hi Ilpo,

On 12/11/2023 4:18 AM, Ilpo Järvinen wrote:
> resctrl_tests reads a set of parameters and passes them individually
> for each tests which causes variations in the call signature between
> the tests.
> 
> Add struct input_params to hold all input parameters. It can be easily
> passed to every test without varying the call signature.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

