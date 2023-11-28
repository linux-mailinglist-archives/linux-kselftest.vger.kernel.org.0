Return-Path: <linux-kselftest+bounces-756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3AF7FC917
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04BDAB2116A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18281481B3;
	Tue, 28 Nov 2023 22:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ise6EhZV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA3719A;
	Tue, 28 Nov 2023 14:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701209403; x=1732745403;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wHwD/3MPSClSmT4Sdvee3on/wvJjjoGSJdKU6N5rEIY=;
  b=Ise6EhZVOAcBSHw8AfR2qlym92hulZNnYw4RRBCsuE3krjTytgc7hbRu
   4Atss2nMgTlflGLQ/oFdN9+57v1H142Z0TZj4FZJdHD+3SOpxYyI+HYfs
   meDTEhbM4edTf0A6cetTgkiQwhL0cpO4lTQvc5BQrRuMuWSp27WMhAI6A
   5wRdnokxiUyLGUv6tZgv0FWfGcMN2PeD10COVqrXHEA9G4wDXleqjC/Pq
   VIp6zokrGPsNVeHVtJJHr9/PGH39EzBG1pBS+ghCc6ASgK2U2bkSvGuVA
   yHryA6AFaE/9RFecSFfI9WiWZQnu3wxJXsYErq6EXBbX607sjkEVmYwAp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="457374126"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="457374126"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:09:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="718536166"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="718536166"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 14:09:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:09:53 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 14:09:53 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 14:09:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnKRB6T08bma0S3yT4jUmwofs+kM5n+t9n7H272iDvzvwXIML5nHqb2O5gtGY+cYevlsLSbUvN/5R0izBk5a9Voebn17CPPlsElq50gpQXmavju5+vppMIWCn93qOIQkORrxjPXxNseCvqZbOmYQ5bOkm4qvjksWkJ1gem2fsBMKK/bXtGTSQy811SOY3srfQbZJsWow0irLF7iwjibZmLW20XOfkc6K7ANRlFxGNjGcruFlcvfEBs+injK6umq/qEoPifbvkdLVOHSZ4sR/W3jvYK91q9IdKs2OmeIc/dMCj/5WS8zZNWyEpzalEl1Bc+hgme5aTFPR/1+Qu9H2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Oxx76B163MpB6sdsHBdqVlFRJTGAOiTnZCA5m8FJcc=;
 b=euMhLeKfOUWwXClxNqb9elYMuvyLPsZSpTXh1lFPp8mc4BcmjbQWP4S8CpJhvl7Ckqp9silXdQ+HtmLn3pJmlvLorOZtB6UUfEBkay/8jLMzPX3i9dEs7PvV9QbUHYGvluBibNhJHTbMMs93Yd+pUbJXL2l84jKwuD5O6WLR9ByKwhuSQ9Z6oQcb+JRKMxUDPpVwxXZkfSsMhY0ZlH3zeJL786dZbCGc/OmOExlnvQ7OSprsM+L5bma/gywDg0JCjX1X+DcHemNwiZxb8mjw+oAM3Q/4ToydoiLF5GfsmdG9sWZif0xgMGdSyRoFRVQ8bPD6vEV77YqW4D8UqsCgVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB6328.namprd11.prod.outlook.com (2603:10b6:8:cc::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.29; Tue, 28 Nov 2023 22:09:41 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:09:41 +0000
Message-ID: <1b538450-3a36-40ac-9520-04d6015f3d20@intel.com>
Date: Tue, 28 Nov 2023 14:09:39 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/26] selftests/resctrl: Don't use ctrlc_handler()
 outside signal handling
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-2-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231120111340.7805-2-ilpo.jarvinen@linux.intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: a2d61e08-0d47-425f-7b95-08dbf05eb866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x9TbIX+qs7Lzz4vlJRAoz2sbEc6jNY/ktmng8W7aHhXWuq+oa2pDEf1uEhVPLpP4ZBfzkjngw01vezIbBmawZBmeowvysWcCsfa4nd3PE5qnYg5RNXlW8vySnHDFc32PJ7hKjapVmeL6N+rRfHjaJ+yCinlIkAt+XCQsR8Ij8ULYktmPEAFTIqYuYB7YUu7RZN2l5kPUBKFvKTQ2B34xATmcq0Ysu0nnOJt8gVQKs/YOZ074CJ8+bRv+9QsZjJALrmuV4xjkJyKkn112ay2yFPkCI8mhF5Bj7PShJ9m9juNvcIsrMJZtmWgsUYlAb22TagVfvGxG/acLAOoArmZK39UJq+GcIB3yqxWJ8xOO4wLKvivPWKcJRbsnLCAA9FPLIyIhCgpkMtxCWQizAF2c6R1XWXj13zDix+50gG8/nZfSo0tYKE5iPVZ+cVOfBOZF446iwwjhMB6KiZ0nW1od6+1JyYEty7XED24/9cX+NqhqrWBlLA2JmOLBbUZmLhwoSDanKA79aMvYWwuQnZFA/jtlPhVHIk0Oevo5e/z9Lz2bdQbaMnfd5cqyEXM2saAKFbXZzB08HAqjWRxwKfCHkJ2k5mJooL6E+DLkjwVqB33Utbxp3Ozhng0TMJehe5+ll3hCSUALekPo6llVXAxeAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(5660300002)(4744005)(44832011)(41300700001)(8936002)(4326008)(8676002)(31686004)(2906002)(110136005)(6636002)(316002)(66556008)(66946007)(66476007)(2616005)(6486002)(478600001)(36756003)(53546011)(6512007)(26005)(6506007)(86362001)(38100700002)(82960400001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0czbDBxc01WUFNHYU9HZXljdHNZKzBKQ2RqNHNGNDVEVFJ6ZHFNMjVPU0ZH?=
 =?utf-8?B?NWR1dENpUm1PZ1I0SVJaaFdUZGNYRG9TVGthMzRjc0QzWFkwU3E5Zm8zS0VW?=
 =?utf-8?B?SWxkclA0emdJUnJTWVlCMGVST3BqQXc0MjRVc0hMdFhXdnVhaCtNbGpEdWZj?=
 =?utf-8?B?NmRpSmhrN3B5WFB1RlFsamNsbU5PaVl5NWg1VmhkWXg0Qy9DVU9QZ0FEU0tt?=
 =?utf-8?B?WStvQ1ZORDcxc280NTNXcktnZjMzL1FBNDlzeEpybm9DYVBHcnFrV21qbEU2?=
 =?utf-8?B?MkJ6ODV6bXUxYS9hRlYySm5MTXNLRW9sMzZMVk9OVitNelJlWGNXeHdqemFD?=
 =?utf-8?B?Q0tHcEU4Q0QycTg2emtSZk1sV0xwVnpXb09KRU9iRVZuTVVhOGoxSW10OE1z?=
 =?utf-8?B?ckdIL3ZWRXB2dmpMRlZvbUtmaUFXVnFLb1JPVXF4RzZpMktGS0syaGZHZE9O?=
 =?utf-8?B?ckdJaTBFV0NDUThkRENwblhkeWRiZ0xOTUpIa2hHalp1ckMzcHBxeE5ZckxJ?=
 =?utf-8?B?RHFYOENYdDRYNUpDaVp3L1RxRUJTVUwydFJudGFSeVlnbjEvMWZyZmFLRkhL?=
 =?utf-8?B?RzVsOHJteVFzUDZpMjl5N3VlQmpOQjNIUys1VmVOc3VEZld4em5sc1ErZjNX?=
 =?utf-8?B?U0NGUUE3am5BV0ppRC9vY0RmazNob1ZKT0U4MWlaamhKU3EybGkvMHBPUlR4?=
 =?utf-8?B?Y0VJWW1Zb05kT2J2UVY1WlE3YWZXYVU2WStONkU1d3lLenRzMzE2K3hYUjk2?=
 =?utf-8?B?VUtZSzdMd0VUSkxWdEFWUEI0L2pKSWxnRksyN3krK1NiWGNNMGxxNzI5ajZW?=
 =?utf-8?B?bVpjcTJnK3REM1VJTCtlaUxTZHlyMUx0R3p6MjVmYnptc2FRYlo1eDlVVnV2?=
 =?utf-8?B?QXdYZWZYaXNMazVCWDlrblVLMmsrQWIvVXF0d3Z6cVZNUnBDUjJTM1lnWVcr?=
 =?utf-8?B?QVJ2Z0FHbGl2MUJOalp1UVBHY2hpTjJrcXdBV1pMSWxoazVCcnpjblN1NVlE?=
 =?utf-8?B?RWdNbDdlaHBIZXhMZ1orQ1RmZGpKb2orVlFvbXJDMTRjanE0ckF3NnhTTVVP?=
 =?utf-8?B?YndRb2locWo1ZWwwb0pWTDhSVzlaTUQ1N29LVS9lUThPWVBocythdjNrUHpo?=
 =?utf-8?B?NGIvNmNpcnpRVy9oK0JFMWFCbHdLRjFDZGNYOGU3bXU4QmIrTDBzMjFFOE54?=
 =?utf-8?B?blpSY0dQSzc5VVhRckN2K2xOVFNYNXZzVDhkcEhjbHBKaFgyMTdyVEhnbXhJ?=
 =?utf-8?B?NFBMcWNIanZNVC90Ujd6d2l1dkkzblVPaTZ4dWpGTUdzcjh2RE53NjJwWUlS?=
 =?utf-8?B?NWtURlhhR2RZRlFkeU9QUThFMTVJWGpzb0FsckVJeU9PSWtaYUNwYm05RW56?=
 =?utf-8?B?Tm1Ic05jMWM1VUR4Q0hZYXBxL0JuUWo2b2FFaDBFUnIxbmV1TTdYeDBCL2xF?=
 =?utf-8?B?WHRZK2NvUkZwalpaN2tpR21IQm0rdkpiMkwxZEhlbE1yWGVURFlWQlRyWU9o?=
 =?utf-8?B?MXhhWjZETUVhSDdCYTJvcTM3QmRXcTBJT25KT2EvaU5RTmd1ODdnejBNYXph?=
 =?utf-8?B?MEJ2aXNWSFM5eVN3cE8wR2MwbnNKUnVCUGJCUUY1ckRISXhReGVUNUI4bjlL?=
 =?utf-8?B?NEJiMG1rMDUxTWZtdWFhRWE1cExwYXpIdmI4dElyRUhMeHQydlZML1NkdnhR?=
 =?utf-8?B?K0VrbER1TTc3d1htdEJTOTBiTGU1SzdXaWdQZ2dBZ0RnMW5nM3N5YTVzaWVm?=
 =?utf-8?B?MzZxKzhMaVQxZFpvc2l4cm9hc1gzM3k4ZVFsVjM2SFdmNDlWenMrRC9sSW8w?=
 =?utf-8?B?QVUvMFpVN3VjY0w3OEdJMEQ3OTkrMWF4a0J2RDJ4bmJrbkZrc0FHYytuaGxD?=
 =?utf-8?B?NXQ3cG1yVHh5WnNYM21KYkZXRjhxNTh6QTNTVFBTb0dTcFcwODFVUXVOeHQ0?=
 =?utf-8?B?cjhCSEZFKzZlOW53cVRhVmVXdWpmcm9jUWI0TlNZKzZrME9NTEViTkI2dG40?=
 =?utf-8?B?eGdwRk52RmlmWHdHcTJLa3J5Sml0ekpjVGVGdVFZNjJ0VjVHVm5vZEJvWHk3?=
 =?utf-8?B?MTJQQVhjMHFwOXgrZm1HMjllQ3gwWWVzakJ0c0xuMG1JV3B2Nnp4TFkvVDVC?=
 =?utf-8?B?eG11ckJ1V2RwOWJ5MnJ4dkZpbFZZVGpZTG1MZWJKb3N6L1kvZ1ZtcFdYamgz?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d61e08-0d47-425f-7b95-08dbf05eb866
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:09:41.5888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWB5Ya3X0cpSDJ7/9DOl+Sr0YHWmQDsbTgwQ1rBtdMLVo8igF3M4DoL8JrMsmXJTOnxjpz+Mu1zhG90e5wjrAzb1i5jK5L7qNEAHF7eujbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6328
X-OriginatorOrg: intel.com

Hi Ilpo,

On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> perf_event_open_llc_miss() calls ctrlc_handler() to cleanup if
> perf_event_open() returns an error. Those cleanups, however, are not
> the responsability of perf_event_open_llc_miss() and it thus interferes

responsibility

> unnecessarily with the usual cleanup pattern. Worse yet,
> ctrlc_handler() calls exit() in the end preventing the ordinary cleanup
> done in the calling function from executing.
> 
> ctrlc_handler() should only be used as a signal handler, not during
> normal error handling.
> 
> Remove call to ctrlc_handler() from perf_event_open_llc_miss(). As
> unmounting resctrlfs and test cleanup are already handled properly
> by error rollbacks in the calling functions, no other changes are
> necessary.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

