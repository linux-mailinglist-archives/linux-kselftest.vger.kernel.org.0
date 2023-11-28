Return-Path: <linux-kselftest+bounces-765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65877FC937
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19BF11C20A63
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD2A481C6;
	Tue, 28 Nov 2023 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G859RO6t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F599D42;
	Tue, 28 Nov 2023 14:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701209614; x=1732745614;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YuetQPbnVC7lqMFYtJvQHZRMnsfsufOu0iemQTYMvMc=;
  b=G859RO6t8z3JF7168tXFj+hgcZn5i36I0FOW0N0mLr8RibmzfW+4fJAJ
   xBkcYVwaLDUTTcaLKuilIufXWbCpojyH5O4aslV+AZlPUIphzL77uIeVr
   /gM2Zc4oPELiZvED9veeHBv4qLHTKnpNYyxDWs6U4XzlQjjx4cJRyeEPx
   +jAYlqiFyfMTkyjZZ8RDkZ2ZnJxIFYftzY1PgVb/DslJVW1PJRG+BuOlc
   rsF2xQbgGe/a8jUhAyQMOMxvg82oMBS8fIVc9uiWGY6J63M42JJw73T/j
   ZN14qrtmLoPQ1HH8SKkh/E6SZOzX48vf6eMpNiCAztWDBd5vMb0eA6gKq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="395858082"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="395858082"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:13:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="803079892"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="803079892"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 14:13:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:13:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:13:32 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 14:13:32 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 14:13:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8m8IZqRrCtd+FS2HYzk1ngxnIG60YyCYNwCwWjFd9uGPcRv9+MdtJYTTqh0vcNRpILe31/1X2ZpK1hRFsYtQ+kXsx0RQJyykKQNbMwwBeRVC9sSlPO61d4ohzqvQ9duUJ8+DMrWmIkgN8ar8wdeY/NRyU6G+6Ibk2GqLW1UrvNfjd1JXIPeqDIQCHKyWiyuqjKRC3BzTYa70UK4+eMqrt3lknEhnRxq9YcRW8N1r1GzJA5iJQcqEOgxV+WYM282JD/WOE7q+AAUPFMFABu02ZgZB80XwXFLthAtx/Fe+oHCaEigGA1v+ObL9Xew9TXFqvbBA6hFKRJSAMyQ+5HXHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3kKx3W1F9PIq6nwylhVdeLmwL3ASiYHJh1MFzeJr98=;
 b=gmol+4xE6xOeIHPAUbVZqT3dm+/iJ6vac+hM/d7uoVVnZigsFITt4Frs0+5IC3fksdzNRUlK5KR71eSQ+EZwkVyv1QTdSLzY04obq7lAZUE9VW9cRhjYoDUXYVQ6Tgxo4J3vU+vnuehPjhS2ZNGpLbliMPsfS26n6ax3HKz//3GVrho5Lkw7zqoGw1QqvOpSTGQBRFmasSk8Xf7mI7xjrwRC1pAUYUOm/cOu6kBJlxKl/xXrKl3qe2OTUxp7AsGBFG6VLhNj1S+uqOeKY2sZNMlLi0e/HxMf4Y1nVw9xYnYeVPPJc2HLJ4GD34ioK/gXf4nktaU8V0WRWveWHz28cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB8284.namprd11.prod.outlook.com (2603:10b6:806:268::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 22:13:30 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:13:29 +0000
Message-ID: <9a12bc46-ed13-4386-be75-8075f8f1ca12@intel.com>
Date: Tue, 28 Nov 2023 14:13:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/26] selftests/resctrl: Split show_cache_info() to
 test specific and generic parts
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-10-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231120111340.7805-10-ilpo.jarvinen@linux.intel.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a393da5-8b42-456f-aec8-08dbf05f4089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dh2SNQqiYADkBigEqahEV1JDca7on1CdHQfanEkRhzE1UgQPoSjFIxxNttfW/WZ+Bpo0StgmhB3fWOeJNOkzzHqG0fuG/9C4Hv+RdOSyNrw6l/7BqvpqSxw0fo8OhKZGRkShBDFB7zY3ga44SDlfDPENbyCy6CG5VpJkelmgRz1RIVbvFvpnkY6shZ9O+4JCQiNzA/h69Awo19q7sso+3RqzxpGjwCtIWxJhWH30dYVVK3sNgtLhjoQcsAwKT2RCCmGWCfZPQO6YhB/ujyc2t7B2kk7fS1h501okrLH/hZzTxg2KaK//vlEIW68YeOMdWOIQ/LlmdAximCohZ0OcvbCvtAskpie89rA9MTrKyeqtiKOYPZmlTYwWalqqRS3BJRlSLrdxC+9zHyhdaqg8uuKmexFwOH/sMutRYTN5b6F3ddFNhWq4rujjefZm/dM4iP8WrRh31tYZNIiLwNsSWZ5wHOq+Q+ffKD05yO5XyNSnDY6UMm2HYgmVnTrSMg6A6R7+PTNdtDNnU1Ui7ruKKNI8d1GY3426kQq37QoXbPm3+t36zTMZWxwIv/SFaPU9ixp8nX3Epfjg13ZoPWAvQwgh5ITSBdUFTKYwiUum9x+aSkvgYvCtQEK7lxZqRdwgHH/ZzrQuTP7O2cRQa/MyCAIqZorcIP+hHJydalRiMUk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(38100700002)(31686004)(31696002)(82960400001)(8936002)(8676002)(110136005)(66556008)(316002)(6636002)(66476007)(66946007)(53546011)(44832011)(6486002)(86362001)(4326008)(478600001)(4744005)(41300700001)(36756003)(2906002)(6512007)(6506007)(2616005)(26005)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHZvY01WNzdxZHpBSkFnV2lncjN5WWl0aUdKbjY2a2xrOXJYWVU5STkvb1ZI?=
 =?utf-8?B?dkpGWjlaTkNVWDZEbVArSzUrejgzOXBsTXJyQzl1dWI5SjBpZnA3ZFRaMitH?=
 =?utf-8?B?ckpRNVd0SjJrRld5dUx4cE02UkNWbmpPUXduSXRybDZZalpTemFzbVg3WVVG?=
 =?utf-8?B?aGxCQWE5cmdVTnJTd0tnQWVOYmNCRkt0dFBLUmxxeXNMMkZSeGoxbThiMzZM?=
 =?utf-8?B?a0pKSVNCQWVHZjFGWnVoWGlNbU9MaFNDNlVjZ0tMRmtXNGE5TytXQmxhaENQ?=
 =?utf-8?B?VzVXaVRNZ2pHTnh4aHNrelc3TkhKNlZlSEtTbWN4K2g2RXBNR1lTbEg3Uzdy?=
 =?utf-8?B?YnVXSHF1MHBrcjVKeW9xM1BtL1pod0hRUUlENE0rYWlEejdZL20ya0xXZG9M?=
 =?utf-8?B?SW4zSjE4YW5kcG9NZlJ5UFJFcjQvVSt3R1AydGhhekpBUllFZGMyQkwySUZG?=
 =?utf-8?B?aFV0TDFKVlQ2RTdtZjJjYWJNS0xTTWg0bFVWZVdySmtUUENtUkd5amIySnBJ?=
 =?utf-8?B?S1ZMZ0R0Q0E2UXBSajBERjhaSE0wOVE5ZFBwcXV0ekxldTNQSDQvNnl5Y1Z0?=
 =?utf-8?B?TWk0Y2ZDNFhxUjVGd1FGSTIvMWdld0pYcEp5RFlDZzljbElPeGN5cGJoVjM5?=
 =?utf-8?B?RkVxYWtTZ2VucjExdXk1VnJ3RWFWZkhHR1QzbjdRT0RDTG9CWGM2Mk1jQ25k?=
 =?utf-8?B?dXRUVnA4aWtnZ25ja2F0Y2JFT3VhUVZjekpmVGZrYm5Qa3k5VS9FRGYwYmFv?=
 =?utf-8?B?VWFSdWVsSXhZWUxkdllzd3BMVGNJZU9mZTlpczNaQ3FPT0dGS0RrZ1FmWGk3?=
 =?utf-8?B?Y1h1RDB5L2xPdlBJOEo1VUw0Z1pnNGdMTlJsajJKd0t3eTNodDdaRzBWNndX?=
 =?utf-8?B?OTFpdXE4Q0VCQlFJTEZudGcwTVJRb3dLQm91bzJUZlZGWk5icjh2OFBvQlVK?=
 =?utf-8?B?dm85Ni9xQkFYU2syZTBWL0E2VHpVZG1lblVrWDRzSUhXa2FjQ1NFbUpEZVIr?=
 =?utf-8?B?cExIckJmUjFLNFZQYnZNR3lBd3YrOXVRUzRDeWM2VjFYdXNlR0d3ZXdQK1JG?=
 =?utf-8?B?aWo3aUJ6WVN6eThKL2pTZWJoeW14V1kybFExd1Q4TjE2NGdIUFcyOEFlWk9k?=
 =?utf-8?B?bXNlcVdvYk9tTWhXVHBCWldBU0NKMVJUNGRpV1RKcjdVRGJEWGRZQk9Rc3Za?=
 =?utf-8?B?aGI4d1VUWGRNaVg4NXRlcXNCSitsUVhXcUVBaWhJbm91dHJFM2FXK2VaVCtT?=
 =?utf-8?B?b0MvbjJwdTBUTlNlWnlWb09Uemg1a2ZZa29BNlc1RUJtNmdsY3dhYS9oVk9O?=
 =?utf-8?B?YkZZVXFyOTJxNUI0SDV4OFNrMks3b1NuQnNsUnBTZlI3bElOUlZkdnhxYXMw?=
 =?utf-8?B?UDYzK2hOY3YzVkxnNEJKWHcrY3FpSml3WFBZTVlEdjhuZjNLVWFZYVA4dzdx?=
 =?utf-8?B?RzRVMW9SNVVZVE1GVEk0d2xuOEh1a2RqRTFKQlp6U1RoOTlUY0tZNmhtSmVp?=
 =?utf-8?B?cGsra2JFZjVwRkpUVUVVeXdxS2UyYTBFS2NwOUV4S0VNRzNHOGlQQ1Z3Y0Js?=
 =?utf-8?B?UlpOZUk1SWd1ZDM2MWdydzJLMkptMmw2UE5DaFozcTdUN3RXOE5oUDBCTmhM?=
 =?utf-8?B?SEtvUWpnTDArVUkyRjhrS281eXdpWFNrbklBbTVPWk1rQ1l1RFZMYXdKUHg5?=
 =?utf-8?B?K2xMZkRReVUycGswMUJUWlhhdGVJbDNFczg2VVp4ejJnMWxBNTZPRm91QUhj?=
 =?utf-8?B?cGN2TGJmTmJvWkJTcDVnRWNuQ0ZvZlh2dlYwSEZtbzZsQkJlSEpXZ3BlMU9O?=
 =?utf-8?B?QnUwSmt5TW96ek9BcUgyczZpNHYxdkNsV0pLVld3WnNtdkhhSEltbm42MjFh?=
 =?utf-8?B?Y0VLV3REbGViU3RSOGtDbFVGWWcyUVEyUUpmSWV6UG1mWFF5VUJCaldtZDk1?=
 =?utf-8?B?YmY1MUZMNG5WZU9GYUFpbnRDaUFjaVhFMjZTYjhCVHVtQ0tGTUZjOXdmQUxQ?=
 =?utf-8?B?d3dqTkdzTEU1WTZUNE1EQTNBNVpSU1lDWTV3L1Q1Vnlha0FwWFBMY041eFJY?=
 =?utf-8?B?a2laeFFKM1pQcS9ZWkpnSnMvU2VTdHdQVVRrNXNaK0JVcmt2Mmt2T1l2M2Vr?=
 =?utf-8?B?eXpGTmZnZUt5NzF6QzFmbisvMDJnV2dXMGlHU1J5anZrWkRSejNIRENYSEtw?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a393da5-8b42-456f-aec8-08dbf05f4089
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:13:29.9357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5U8+enFi3S8PBioxFjZO5kHOjNKa7hxY4D9cON/XkatHcTQq0g4877P/nyOa88HqbJ5gDYaKcwtvTwyP1CHtsqfl5IPFnbKlN5fQes/mxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8284
X-OriginatorOrg: intel.com

Hi Ilpo,

On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> show_cache_info() calculates results and provides generic cache
> information. This makes it hard to alter pass/fail conditions.
> 
> Separate the test specific checks into CAT and CMT test files and
> leave only the generic information part into show_cache_info().
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

