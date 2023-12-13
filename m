Return-Path: <linux-kselftest+bounces-1872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4980A81210B
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 22:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C477BB20A85
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 21:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18B57FBBC;
	Wed, 13 Dec 2023 21:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ar3Etg0D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74C9E8;
	Wed, 13 Dec 2023 13:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702504630; x=1734040630;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EJVcQvRuU7QBcw6GXl0RnkgaLTR2IF8h7MQULTZSqCM=;
  b=ar3Etg0DIW1GM7T1S9zNA6mPmNGXN+Ou439BI5D6h5I5V1ONJ0W+jQHQ
   DV9afTRf5L8NvEdHLWTi6TfsntqRcwSsFGtFsSyakNAgC7akcfZquSqt1
   BUxHLTLps59Brxw2EvitXAEMcuTQ0hkg0Yw5wiSiGHRiznUcMeK+y8Xe4
   nbwv4W280x/ng+qxTnBvtkRdfh4cnYi2SquRqZwMCZEds52gbS5SBPcfv
   VvaEqqJKdQ0bvLHkAM6AqvxmJ+fu6NzIu948VL+DxfvCnCodaKCYDy/R/
   ktEoqReGaTfnOP4cl4kr0V1O/HdghtVs5NudWcj+gILlVlv+AcQUkYGaE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="375186277"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="375186277"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 13:57:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="840046807"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="840046807"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 13:57:04 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 13:57:04 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 13:57:04 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 13:57:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuqWQaPnNyBD6hU9T+BnaIU+Q3crmXDpY1AWUpjom17WQ/5qpaN2tYB8OyEKtuLZxckBecqDf+Dlw4CfISjpCdx3VTer30lgVO22S7AhqcMoPXKMOksPNxmq4tU+U83GCFj7cN5JVNOag4TsRDEpK/YLx9b1v3HtDTZ3chQORGIt9DxuOHg6HIn1y+YAYBCcOVGmJHgZV/hr+3haCpZRYrn5XEBLD+bZjPEk4+cVf5iXdsXDC2W402ii+g3JkmMZOJRMzaSZRMTDGmk6ToPH3sVV5Y/TS1yI0DRKYMHONI3p0O5WU2CiWRbHJ0zE9XX4xmKcrY81rM+gr/zyomBVsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKWpKStgJ66VwpU11aTmNHZ3GZuVoufnn96HVSQFE74=;
 b=Lro+oNpZ+N0R3v95M8/K6C3wFFTl9b6rrCartiUo1wcexx5qDUJHYu5FY4iIz+aqv2XERbz6vrPD1PKnyvI0jb/tioX5li9ASqdwiB0ribGbKl1Ogyj//YGaXexpm3doupoq5lW3lf/eFYxgMBur2AC+OoFpRA94XNhnoCLvrcyim0kPxTldnw2FEB6AAg4G79TjN2iWpaJtf1VySYe7COzakIt5a3oB8OkrtN6yQucL3LOaWyaLq/rDLbjRVhnHBM/ZndUGfmWEo4NAGsEW83kfD6G400eCwhP+r2dUHmLciREXJmvTFNLxOjzKdgAvotYZY8e3NRz1tpWbAlNN6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7663.namprd11.prod.outlook.com (2603:10b6:510:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 21:56:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Wed, 13 Dec 2023
 21:56:59 +0000
Message-ID: <c8fb2854-6404-4378-967e-7724726e67a8@intel.com>
Date: Wed, 13 Dec 2023 13:56:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/29] selftests/resctrl: Rewrite Cache Allocation
 Technology (CAT) test
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
 <20231211121826.14392-23-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231211121826.14392-23-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:303:8d::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: b07b7012-c280-45ad-5811-08dbfc266e6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aDnN+ebVso8MpTsC78CfZbyLgfsizQ4k+pB5b2DNb3Izx9nkUkMMK3R5kCR1VCNNZDdr4V8Gm4PEensucaOcI4RHKafrbTu3Mia45Q7H4XBoXLKR4kmbfPli40k2AjZJbAQ9KV6pa+KZCTpRV8Qm6e63S2rzXyVCCCbi4N8S0GMZ1nK/YSzX5q/juimvgZ5gphFFUQppUlKg4T2o47TUDi/ydq8Cmc0xnnJgG8vcC2vmgrE/80/nCq3zy6yRaGspmvNLws0Best243l3i1WFt8Lf9ebr5xC5N4qjffNAfp+XKNJlsfaw9pcgvDjGywRcFNtrkYjTyKbML0qPMSlfUD+LYEW3eKae2/lLAF7y+0bXqwUonPGwW1A+IOMO0I2uPlE/9Q9zGVIaGLjE+L3YmfbF7Ub4O5HaIYiA3XjKTa04l9b2WKNUERD/z9nEn0r0EcQjit+bipX+0TANk6GwlvkdRiKRj7sRU9UdDuOHiIzn1DK4yvjp6g7tTWjjXdt1F4/o8EvVNqSrYIHhdQrqbLEgsUfHTdtzf2IToyQPHHWGJeEmjGPfzxYBquz85XnnIVtDC9w69lNZO8mH3zG2XWpJsWRIykGIRs1iRcrHULx48AswjMklBL4nIoEDpvP0mH1JctwDyCcIxKwc6Tj7vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(31686004)(2616005)(66574015)(83380400001)(53546011)(31696002)(86362001)(82960400001)(36756003)(38100700002)(4326008)(5660300002)(6512007)(6506007)(316002)(6636002)(478600001)(66946007)(66556008)(66476007)(110136005)(41300700001)(44832011)(8936002)(8676002)(6486002)(2906002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVNXVVJvcjFNT2ZtOFdhVDl3ZXh0dENSVmRhdUR1Z3RwK0NPczQ3SVhOeUpZ?=
 =?utf-8?B?ci9md2tUR2FQSnByaTZ5WGw5ZTc2bTA0VFBQOHJMODBuWlYwaVJDRzlnUEJN?=
 =?utf-8?B?UDVHZlhCZFVQN3QrT3ZsYXNsdzA1VmpIK2h0eUk4bmZZcXd6TkpCUENNbW5H?=
 =?utf-8?B?cGFxOWtMUFY3Ny91dVE1dDZ3dVJzS0Z0dVlQWG8rTjQzYTdEWEpSMnVFM056?=
 =?utf-8?B?M3Ayc0M2THNGNXFsZEFVRm9oVUc5Y1oxWm5BS2FlWGRjSkVoL2p5UCtwWkdK?=
 =?utf-8?B?clM5ZzZBWUthRG9zclJMYktLY2xJUVNaeW5VRGtvOXYreE1wODcrQWZiK0tL?=
 =?utf-8?B?R3pZWmxVT0FHeWZTK05xM2tHZXQvcCtSL3ZXNVJHQzIzMUl1UEg3aTF2Vitw?=
 =?utf-8?B?d3ZOd1JPNnVRL2VlbUJRSFlnQmFYYWY2SG03UDBpdDJwNG5kWWJuL3hSTU45?=
 =?utf-8?B?VUlTV2UxTTdlaThFditqU2Y5YTlITFU4cHpMRlJ3bytORy9GQmNzZWRpWWo2?=
 =?utf-8?B?OUdZR2ZGWEgyOXBvOGdmaUthbUZLSHp2Vjhsd0pHeWdlWmQ1N1RYeHlHbHFC?=
 =?utf-8?B?S2tFV215cnd3YnB6aldpcWgwYUhTVzlTR3g2QTlCQzk5MHdXckdQb093dUxr?=
 =?utf-8?B?Z3lrcFFFRlNmZWNRbXZOMUpaelA3N2tBR2ZxQlo5V2NZbDlHSXYwR2NGS2lz?=
 =?utf-8?B?M1o2NTdGczEwL0o4dkZkZ0ZzZmpVTnlJQUYwWXk3WTVKSHduQ3hVN3ZPZEE4?=
 =?utf-8?B?bjI1Wnlackg1OHNQNDN5RHFxNmJ0SE14U25Jakg3WmozTlFkSURtTFBZSVE1?=
 =?utf-8?B?U1RzVDFGTVhURDlMNVJhTEp2ZTlTQkhibGdWRDhzOFFnV29hSHMwc0JIQnFE?=
 =?utf-8?B?SmswcGQ5L3A5QTU5R3NSK2lrcFI4c05QM0w5YWdxT1lzaFdrYldtN29qdXpX?=
 =?utf-8?B?TDlVK0p6R01ZRjNBQUtPcTJreWk1cVpLRWlmRzRlVDlxemdKalh2SjdyQjh0?=
 =?utf-8?B?YlNiSWQ4cERGZCttY25lMGxmQ1N0azRqYmlwWGE3MUJnL1Q5Y1ZmL3J0MnlX?=
 =?utf-8?B?MXpDcDMvRmRkRTJzRjVLM0dJdzcxd0piTnVTN2tLU0UwanhKdG1Lbm5KZHJj?=
 =?utf-8?B?a2o3RFRBekRjRkpzRGluclpSak16OGhRQlhuT3RKMUd4QkpoK0hTMEM5TnFI?=
 =?utf-8?B?VlVFUDBGc3JSbXVYczNlRzJZTUlrelpwbEJJNVlTbDc2MVV0UHV5WC92bzFW?=
 =?utf-8?B?OURaTDFCN1E3S0w5V2lKREVpZVdVcFR1ZFM3UGFSbitIS1ArQ3IzOXRZT2pw?=
 =?utf-8?B?ZXBVWVF3VDA0V0ovSnE2a241Qm5IVFdrbkUxNTRjcTZZaDJ5Uk1ua3NUcGlK?=
 =?utf-8?B?UTVhWmxWdHB3dVVIeFdIME9SQjBtOVVCVHRjNEZ1d2NWTlN3cEVvY010TlRo?=
 =?utf-8?B?TlNocytYNnQxbDF6Qk90WFR4dFByWHNsR0EwZGF5QStxOUVRd2dWNmE4QVFY?=
 =?utf-8?B?bVY4QUdZcmQzWEhuRUZid2tibkhsN252cXFPTENVVW1COUQwaXd0T2YxMytp?=
 =?utf-8?B?RTRHZHFSdkp5UTE0aHpHZGRmSEZORTNnQUtuYnVpS2RkN3Rvb0VaZ0dpcVFR?=
 =?utf-8?B?aG5MdWErMHVUdng4OXpneDkxOWZFMHV3WnJvYnBEQzU4djZ2WFNQNGpKT09I?=
 =?utf-8?B?ZjBEaW9YS2VWR2Z5NTFwOElhZVJNS1NNSjN2OE16ankvajVWNUNvamM4Z21m?=
 =?utf-8?B?djQ2Y0dLbDY2aGFqK0ZxTlphLzA5b09uOUF5MGM4OEZCV2ZvOFM1Vnl2WFlS?=
 =?utf-8?B?R3laVFV4Y2JQZTZPRFFQQmJoMWVCZWZsNkE3MklyRlZoNnZJR1BubnR4cUxq?=
 =?utf-8?B?UWl3Rzc1WG5VcEJaaktEaGdGb21TSnFTb1hIK2RnSFA5VWc3U3pUVTBPUzQ5?=
 =?utf-8?B?MzU3d2greS9xYlNFK3hEVkxGbkdXend3YlBiY0lFWHZOM0tHRzNkNXV6b0kx?=
 =?utf-8?B?alNIMzVyTmp4V1A0UlE4ZUU5c1Bvekl0OWxqVkZqYldxQTBoRzJtLzFWRzhG?=
 =?utf-8?B?UHNvNHNvZnE3b05yT0M5SVZ5cUFZQXdvNW1OMnZ1WlFka0JnUFl6K0R3UlpC?=
 =?utf-8?B?SnJPK05pU3l5QXJ0ak9kWTBMTTNXRWlwS0Z0VnF2cWlhelpReVJLYWwzclpR?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b07b7012-c280-45ad-5811-08dbfc266e6f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 21:56:59.6305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMyQMEcZ3n+z+Wdw5tmH0Y3/FtS6q8Mn8d5MzRhTMJ+axFbjbc/QSOOKtuBZjgI/mUkO/6Mr+Jg1XYKmPPiZp7SRvjo3Je82gcIDa9z4y10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7663
X-OriginatorOrg: intel.com

Hi Ilpo,

On 12/11/2023 4:18 AM, Ilpo Järvinen wrote:
> CAT test spawns two processes into two different control groups with
> exclusive schemata. Both the processes alloc a buffer from memory
> matching their allocated LLC block size and flush the entire buffer out
> of caches. Since the processes are reading through the buffer only once
> during the measurement and initially all the buffer was flushed, the
> test isn't testing CAT.
> 
> Rewrite the CAT test to allocate a buffer sized to half of LLC. Then
> perform a sequence of tests with different LLC alloc sizes starting
> from half of the CBM bits down to 1-bit CBM. Flush the buffer before
> each test and read the buffer twice. Observe the LLC misses on the
> second read through the buffer. As the allocated LLC block gets smaller
> and smaller, the LLC misses will become larger and larger giving a
> strong signal on CAT working properly.
> 
> The new CAT test is using only a single process because it relies on
> measured effect against another run of itself rather than another
> process adding noise. The rest of the system is set to use the CBM bits
> not used by the CAT test to keep the test isolated.
> 
> Replace count_bits() with count_contiguous_bits() to get the first bit
> position in order to be able to calculate masks based on it.
> 
> This change has been tested with a number of systems from different
> generations.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Thank you!

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


