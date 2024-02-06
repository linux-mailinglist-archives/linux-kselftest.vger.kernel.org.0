Return-Path: <linux-kselftest+bounces-4178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942E584AD61
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 05:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3A0285CF8
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 04:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380AB74E02;
	Tue,  6 Feb 2024 04:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lvo0QL4E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2222745C5;
	Tue,  6 Feb 2024 04:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707193098; cv=fail; b=lvNfmFaQrBYXvIJXWn77+FbdLplWfPDPfiwUz6aHGdNVqrpnHmRspmbrOXAytwptKAtIb3QB0TlJ60lPzvFeTjRI0cFSWaE7gIogHxV/dkzsrqACm3tZN0sNnPJItkgGRVX1gPt1TBX+mp/q9FRNniTmAqsDnPobs9VELnH5fvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707193098; c=relaxed/simple;
	bh=iWYVUVCMd9OybgLBPMP2uRSRJSpiid/pw/GNYY/16VY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L8VgrD8+hHG47BNGz1ozO/oq6+YRuRYIcqiV/fBcOvW3xmktv8px/dxUhwL+5nQje/PiY20rzY1zcLDHP6Ef0FU2Ksgu5DFQl4iaSQkCwTFMRps/ah2qgAL4jBFqYTp2mCIHjnst7KV2EoE9LiadLW35Qg6GTIv8dPKrJEOwr/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lvo0QL4E; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707193096; x=1738729096;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iWYVUVCMd9OybgLBPMP2uRSRJSpiid/pw/GNYY/16VY=;
  b=Lvo0QL4Ezq3mPaO0DUHtm+3GJ9rhH/qsC1dYrVtVIammP9WgvY6zdVTa
   J+vxGYK+ADmCw3cJx9kX0SB50Q4bhfPAhte1Q+x/AiwDdDW2N8myw6gkY
   dUBsUlLthqQI2ikSw0OY4hZoBMfqU/KCzx48bpyMiiiD1FBkj4c+lbzRp
   htxr3k/sSJ8KZiR4I+aQHF6xD5E4fWppV47lIS5dN5sB74joBqOZSHpZ5
   k4cBhEShMNw84mOl1qOtfnU91LxG6KSawEdjMwvM0CWiY6sFl1zt8pLwu
   A+Oj0HWhL0Erpq2YHu0b534WvNmTBoZLpNfn8/DAfeqGVIU4mq3xK8M8s
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="563660"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="563660"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 20:18:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="1189270"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 20:18:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 20:18:15 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 20:18:15 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 20:17:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNmNO021nGoiFpDw8XsCoUK9pI3/Vcw1WkEWQV1H/6LbZjJcGEZ5mmQXn7pruvyV4f78gOe1JJXyvcWY2W/nCyjqPCNk0vTQmh+0Hq3p5nh8nJAyETuSLevEWURYk/pBCwneJaHFdSLSPDxn9ZrGJ+beLiVda/kIVVXPxYlV6Khl45YTlypcPuWZtVDPMhUgnAigYTbjZsHV5Zqb6DTjSuwX5iung1Lt47x/jvHSeRCK/2pmmgEKA/nKLbkt11bk+j7K5EkwfUBmkfCUa9Xalts8ESCLBNVEcFS2Q+ElP26qc52FbkO4vvMSWj2aWwjO0cDnMFXOmGruurncXbfppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Li78cPN6xd0E65ibyUQpDGhRBvOlSvx4cUh9x9PEB5Q=;
 b=lc1E/WHSVwBJ8tgyk0f0B/PVYlHYjTAXskUJXRG2HmUlYzIkQtgtCoRT3un8ZkL/uTTIYuHjFLb2Hr3jnyg3ptXmb4nI4LV6KfKN7YaYwLspXunYe5bzVNDQb+MgOJrukPKjLTnQ7yRN0tkNwRo82Ip1tD/j/akW+MbDles8WVC0Ocv6Y3kFOz7D8FOsY++SpyQM/snewlJC14Nx9xjL/1m8qLex8TocyXOT/CmfsvYvn1vY3aCQUjpyeo7u+vw9qeWm7hNI5Vz/VN+3TqLUD4//sRkiU9NerhnO4BObYRM+SwWUyMLQjXfxwniXhPdS9gr440mHRcmOztUDA4q6hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7956.namprd11.prod.outlook.com (2603:10b6:208:40b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 04:17:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7249.032; Tue, 6 Feb 2024
 04:17:57 +0000
Message-ID: <77f12a58-5604-4247-a34b-ea965f58e5d5@intel.com>
Date: Mon, 5 Feb 2024 20:17:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] selftests/resctrl: Add non-contiguous CBMs CAT
 test
Content-Language: en-US
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<fenghua.yu@intel.com>, <shuah@kernel.org>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
References: <cover.1707130307.git.maciej.wieczor-retman@intel.com>
 <b341ecc8d1143932307708aff44ab90db3a91564.1707130307.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <b341ecc8d1143932307708aff44ab90db3a91564.1707130307.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:303:8f::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: e5981ee1-ba31-4baf-ec75-08dc26ca9956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OoTbNRaHI9KewZdrqigso3s1g/vvnafHGOIrto02TXKoryBGrh/Z0P7MXqJUiGq9Whs6654a1TCCu/wBzbhJQZjjreyK3KMS/PppM1pKkGXkUa5Y6NJN885CUpBlSpudCFNbbMHDpTNtGWGinZ0A8RrmLdUgMQ+mdDiYzOzSVnbitc2Z93joNObg9cG1eu2MHLSzIsI6GjzXbj+C0rJ/WXpBR6s0bFv95ntZFpJdQBycqdZebaT9VlXLMqEO0X/CA+jAOV6VTUAyvw7F/UvZ48CQIMjykS7Lzefs+WdmxquiMS5kLpzOJmHc/VFUstfqTVRhA5r5Z67CDpeCNRwRuiaDYkOUn0VLKV/OnfVJjJ4+uMRpk8MO+3qHypQZbbLDW054WLCveOgSQyqScIecBkXVIl867Ca0x6C5BCaSgvm2PWBJbQJEBgxoNlN76VcHpousXvsJoMPTrDZUzgxYpyU9xTlspp9Ea/+TiAUKgtl0tbxkc1hxlPg8Nbrv5pNAqxGPFKSIEYOLZ+3hQiXYbzW+KlBRFnn/3cZgjvliYaZXktj+6/vTu6wBSpwtPABz1FhDJ3IaKKuxQOfePp/l/3yDECMOAprRlqAsy3bP6OexDr9SK9f0wA7v+6Dmhl+Jh97pLZAr0li4TUhTxeF60A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(53546011)(6506007)(6486002)(478600001)(26005)(83380400001)(6512007)(2616005)(5660300002)(44832011)(4744005)(2906002)(66946007)(66476007)(66556008)(316002)(38100700002)(4326008)(8936002)(8676002)(82960400001)(31686004)(36756003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmV4RktQdEJOUjRPY0UwRG8zalFoOWVwbVBiTGphTDUwc0dWUnkvK3lNRWNy?=
 =?utf-8?B?ZStKaE1LTk96bVNhazFJMFd1NWJ5TmF6dFZocWM1ajFJZjdzaDh2UTNMaHd4?=
 =?utf-8?B?N3c0NWh6NTNLdit2QW9RaFJEcEVHTDI0VzdZR28zU05BanRGbVpCbWE0OW1E?=
 =?utf-8?B?VFNFVVRFeFgzd3VOeVg0QjljWExFVTljMklXMmh6eXRUZVhFLzdlSFhwTGp4?=
 =?utf-8?B?bmh1RStmeDJwVzhUYXdDdnNqTmppZ0MzN3JXWmlKNW5kNWVPRWNFZTJoVFRu?=
 =?utf-8?B?VnZCSmhSVFZKc2k0VmJRYUFFOTRia1dVRTNrTXdIZEQ1VUVjL2JNQ2VJd0xH?=
 =?utf-8?B?U25yM3Axa1pmT20yeUpzWHlqSWxPanFHa3NVbHMrL1cxZUt6d1BUQ0U2WnF5?=
 =?utf-8?B?SWNqUlBnRy9tWnE3S21hOVNjcTk0Y2JOZW10ckZuaUlMV1dXZFZ3UWpNWUd2?=
 =?utf-8?B?MzduMU13Y3kydTc2TEUvZTBsZktXQTN1SXkwYUUyTDBlelhqMXJQNTAyNUV1?=
 =?utf-8?B?K3cydm04N3dFNU5iYk9wdTI0Vlk0b2gwMDdnYlI1SndhR2ZpSFVIaUJleTla?=
 =?utf-8?B?UktZeGhPUVhBcFFSd2RzVTUwSE00NTFMc2U5MVVIZGNUQzY3Y1AxODlqa1hp?=
 =?utf-8?B?ekhnTEVaUGFVWW93TDhKK04yTlkzRXFRQ3JsN2w3UW9NeC93c2djb2p5dExo?=
 =?utf-8?B?MHd1dlRub1ExR3JxV1JIQ0JnZVpab01PaGZNYUxHekNwZDBxQTQ0c3h4Ky80?=
 =?utf-8?B?bHcveGVzb1NVbDM3YlYzM0VnN0lvWWlXMWtMSnNsL3dxc3VUT0xVNVFGMmdR?=
 =?utf-8?B?THphSFplMDZ5YXJyYjd2cjV5QWx3YUI3NjZFUG5KWkV6TXJaWUMvWUk5MDM0?=
 =?utf-8?B?enBHUHc4M2F4WVNrejBHY1F4TFFzczZCWmhNeDZhS3MzelV2Y0RHTTAxWllp?=
 =?utf-8?B?UXRlYTdEbHF0RmdXRmRsWWk0VFZSYlczU0pubGRWcHN2NUxDU3I0YlF1dDhH?=
 =?utf-8?B?TjBYZ3NGdWVRKzltMDk5RmR6aHNXMk1yOWx0UHllNkhva3F3SXJFVk8wdlBM?=
 =?utf-8?B?ZXJLdk9PaXlQOERnb0tEMFFobFpnQ3dabDJwLzNCcXFGSnJyZjJJYWxWUUVp?=
 =?utf-8?B?VU9nWTJjZkFQMlRrMDJyNVpYb3U4aGgzbm1nMzM3ek82ak1ZRW5WSG43dHdx?=
 =?utf-8?B?QmxGME1Ma2NGOGh1NjRTR2xpZ1lVcytPalJ3UDJ0d3B1OTZYN3BsbTN3YVds?=
 =?utf-8?B?WUpkNUV4WDBmNzA3ZUNRMytxWGNzUjNXOUtlWW1EOXRKQ3luTkdXdk5NaEZC?=
 =?utf-8?B?Wm9YNTB5RTZTUTAvU0w2eWRUaVkxTGZJbStIaS9oYlZmT0tZZUNYZWt4WVEz?=
 =?utf-8?B?S0RkZEV2Q2pyb01HQXRabkFHczBpU0l3RE04Unp2SDI0NVFZalJHOUdoaEJx?=
 =?utf-8?B?azlPS2tnbndab2ZFZDMwSHd0YTQ2MWFWaDVKY0FLTnRyT3dzbVpod0NPSldE?=
 =?utf-8?B?Sm9LN3JVbm1kZXNxVTJnUzVGbnNsZWxsZGdld3lhQVlXNmhzVzRwZTdpeExL?=
 =?utf-8?B?M2hwTi9xZ0N0cVArcDdZL3FTZW5UNlFySVZKVTVzOVFDc2dkc2lPL0MvdzhK?=
 =?utf-8?B?QzJxd3dkYTlsdlRuMzVKUjVKd3pxeXk0RFBUcE5uTEl5SlRId3EwWEdObFJm?=
 =?utf-8?B?OEc5MXMrQlZwUGZxaGo2RkRRTW5leXo1RXh2U1RFVVlINVF6Q2E5TGlaeXpH?=
 =?utf-8?B?OTZLQ1BtZnEyVzV5RHdwd3BlUVAxWFQ2V3dyL1RPRTZhUm85aTc2Um84aThv?=
 =?utf-8?B?ZzU2YmJUY1F3dlJVWDdCc1NnTitFSHVDMjRuQjB0RW1MaVBoUVlaeHhWWVZ4?=
 =?utf-8?B?bUtzcnRPdC9PTTNKZkNMU2R5b2dVUVdUOVVteFhqcVJocVZoRDlJRVZjT2V0?=
 =?utf-8?B?MFg4bExKUlZuZ1JXNWd5OUNrMWNESHY3eHovWUduQldpcUxVU2JNNkFoN09i?=
 =?utf-8?B?YVNZTHE4TmpDeThPTWtFUE4wNUcyellBRUlrekE2RDFDL0dPbFR6V05CZXBP?=
 =?utf-8?B?ZUZZYzBVL09BaDBEN29iT2l2dGZQd2NxRVJaYWhPZlpsdzZBM1lzWDBUK1JI?=
 =?utf-8?B?bGl2ZzRxbHgvd0VtOXRkMEVCVDliQnQwVFhSMmdYVitIUy9Cdi9udWhWd0Iw?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5981ee1-ba31-4baf-ec75-08dc26ca9956
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 04:17:57.9173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DI3qI5vKN0DU3qiRCxpJR+0loYdi9CbTr1huHJvYGdRkaDAWudJrGIwr9ro6JMce26M+ptCIrPpyALOE1GTXkSSYzXE8x2uq/EiAYdRHXBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7956
X-OriginatorOrg: intel.com

Hi Maciej,

On 2/5/2024 4:08 AM, Maciej Wieczor-Retman wrote:
> Add tests for both L2 and L3 CAT to verify the return values
> generated by writing non-contiguous CBMs don't contradict the
> reported non-contiguous support information.
> 
> Use a logical XOR to confirm return value of write_schemata() and
> non-contiguous CBMs support information match.
> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---

Thank you very much.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

