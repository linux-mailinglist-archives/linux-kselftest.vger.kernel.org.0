Return-Path: <linux-kselftest+bounces-771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C2F7FC946
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6BABB20E7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6082B481CF;
	Tue, 28 Nov 2023 22:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SaxfEUl9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2071FC6;
	Tue, 28 Nov 2023 14:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701209764; x=1732745764;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gz1z/hyh35pj+B7e8KSAZPWafueXUK5O6ZYiVQz5VkA=;
  b=SaxfEUl9fEF9l5gg4uWcEmiDwDyeblNj2EEk+lFCUglBebY/ZG0ZiZqb
   GuJWTlCcX2Wn4eQlIiRPHNBciksSmwcLQqRE2uiPfqhpleLUHZXI2fQ9J
   10xdnqfO+9Ar0taFKFnkdVSliIpa9j9cMFpyMmli735As/5dMBmJNkvxe
   SP6Q9qcP/cF7pQKlzbbiPZDYuRKTMfswNzgZBgRIuaozUKs8IMqnYK9px
   gHOPecSwcgbh9UP24MPCrUadhJtfj8/1gkqVOPLHiPNYxL1kusTZ64mOX
   Z5yzw2u7HlF36PBTYB9haD5lco5lMIxP5ep7D9yOdgplGZfTjPPhkbhJ6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="392791483"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="392791483"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:16:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="762077644"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="762077644"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 14:16:03 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:16:03 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:16:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 14:16:02 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 14:16:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f71Pv0qA5Dn3T9NwgZhx5NlCX7XmvqpJ2BGMbDjWjRbdcfK+5+aaRQidRF6FQ8CY776wewvfn9itE9nWnOUlHN3m5wGUNQY6M2EWoDCBQoV4QztQK/WFXvdpsIrc8DVaPeLG14mXRNseKRUNY/MczAFf+bANf9tZx80PhKHXwZS8wdsQ5iALijKGxOY0OVdg+pZ8N4KiBZLLr3TRyQbVABq5KRiRh+Kxi3I/T1FayVW1ygft4c0C+a5KnJjkZ+RVSgSTZIj7MHZ57T0mb51Hq3pYgGN4Du2IDuO36qlC6Wmr92hMgL73u6aG6WNz0xg5WlLlB1aCxD/VkeV7V5NUlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReZVd58h0JtCGj7PQqUsLVFTZROhZKJ1scGl+JfTKG0=;
 b=cgb50nNNdlYKk4Ql4n925Z+qOjiHPg44G2RyStDonzIdkrvNfXQveHnLJVeD7QV2Sa4j8YV2KV/rSBf9nnb5B6lED7bYY3gHKR0aUONxtVDQlVt8BI0p75zF+mio/SwiXc10GiDJH4rTWvbrPzY8fT52xV+RIvlpmWeo3+OjYB+a23bB/Zu9K2Swl7E/qnL9+Af6PqABu3aDPeuoDQ1r7lk/i1/2Cn+MXxFEijCGETzrgIPZuBY3A7uUtNag8CShtBpsAQ7TNDK6BNOfOfSGaX7LeJgwei2Dqbs3AkGABjv1wiMpmQ4TomuFvRUKhFb6/EAQRi/OvFLd1oPbKlguig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7419.namprd11.prod.outlook.com (2603:10b6:806:34d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 22:15:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:15:59 +0000
Message-ID: <65cc680c-e990-4f2c-aa2d-3f3f96fa7f2a@intel.com>
Date: Tue, 28 Nov 2023 14:15:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/26] selftests/resctrl: Move cat_val() to cat_test.c
 and rename to cat_test()
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-16-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231120111340.7805-16-ilpo.jarvinen@linux.intel.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d30c7b-a61d-497f-05ad-08dbf05f997e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xI1ENUpR8nJDG+RY/Dg/xb4pzymbONg/8uokRRMZMM3q/WyPZfuMw+VB+v/sMh51bGQSSFuVptqOgQwX0HJnr521q4gtTQ0z6YXhzGxx+hgLuWrzFzEhE8YObQgodVndR2PsrDo4zUEypZu6aQLfPL6KJ1wC6VT/Aju0Ny00sti5zBkRUGuMSDajdrCehJGijWviSx5AFj2BjS6Ufj2RgQZa5NXfZrW2Yd1VdE13zm1poFZxIFli+ZMDQHfs9tkLROQMJUe3gkQyiLfRJUoVw9yGvozdmhawTfzQOYcsGwO1YUo9hV+tocT8af5b9zs/eN+DWg+oDb08ucmpxLxj3qPaX1gGpJo4sCxPqxZmXsJspoI3kXE6vQpmNbBtCQwYB2gs7tpZ9DttN67sd9DG/Fr9mhWSd/VBmJV7/7pDMqLFjAcNnRLjhPGVpzfQYP2ssdncvit3T5cpeo1N896AM9FYnV/qu1eG3RRnO4FMlpz93P035JmhWLQF9Ono6t1TJ7wG5fUVkmkAPN/6a1wx+wG8dYI+qcaOMXLjaB64d4uFX5uXVWr7tZmvdvj9DSz95LqHxOljn7AH+FrvSZs5RikPVWN6FPhp3A2bwKG5s2TrSgGG90lsytexune6t2XhuMAc6V6GOcTdP+utgpTtbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(5660300002)(2906002)(31696002)(86362001)(4744005)(26005)(316002)(6636002)(66946007)(8936002)(66556008)(4326008)(8676002)(2616005)(6512007)(6486002)(66476007)(110136005)(478600001)(6506007)(38100700002)(82960400001)(36756003)(53546011)(44832011)(31686004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGxOcDVnZHhKY0pOS1BjdmhPclZmYUJjcjlKTWQxWXluTEl3TUp0bEhLRDli?=
 =?utf-8?B?RnQ2M0N1WWQyTnpaYkJlckFRSnRLZHdqL09QT0JMczd1SXpnSUZJYytwUFpG?=
 =?utf-8?B?NTFJUEVHaVVxdUpYZklrandlMUFDcHhISFEvdkEzQXhWYmZzZHJNUzRiOFRt?=
 =?utf-8?B?TExreDRwUGNKdWYrejdsR08zWXA1L2dibjBCSkdUMjZXY3dkTjhCZ25KS2gy?=
 =?utf-8?B?My82Mjg1VmQvNG9CbVBLaEtxRDVGRmp5aUw1cDFCWHZVWVlybU5BemVSRENy?=
 =?utf-8?B?U3VvbDNDR3BnelVpNDZQL3R2eEw5eDJnci8xTjhhWjJNUGo1c2k1YXdFbGVP?=
 =?utf-8?B?b052SEJ0MUhHQ2tiakx6TTdMN3BaLzVyWk1vTG9Rb0JNMzEyY0xhTDZIU01Y?=
 =?utf-8?B?UUwxcm9icEI1cU9XeEpONHVmeDdqa09BQ0U5dFdlMXFFUmNWcFRuMVZsaEJL?=
 =?utf-8?B?WmlKbVFTRnV2ZmptTVpLOS95dWNRZmpBRHN2T3ZqTWt3MUsydnJjOXVVWXdw?=
 =?utf-8?B?b3JkNHM2b2F2TnpHeXRvSlBqSEc0ZGFYYTBXNXJTSkt4VC8zUzNJZWdTQXBa?=
 =?utf-8?B?OXdNODZoL0tvc2lxTno0K3Z2bmxyN2RUMVRkN0FXTVVNVzJGZWVNQ1hiZlVR?=
 =?utf-8?B?aXhyNDZsdEFKeW1Tdk5QdU1DbkJIbm5qTEd3NWxYS2RlOVJoWkg2cG5LeE9u?=
 =?utf-8?B?QU5Pb2RWV0xXeitaWHFtclh3UUFXejI0ZVlQejBscXI3U0N5NXhXbFM2QlhG?=
 =?utf-8?B?Ulp1cXY2LzIvQUR1aFFKVUt1dmlWaUNvOHFua3B3THhsQXFYa3RFNk51R2JQ?=
 =?utf-8?B?K0dxWXlBZ1RIVzB4NXdxU08rOXJvQ0NVV2pLR3JxK1dCMW1mS21KbGVSYWtr?=
 =?utf-8?B?TGdPeFRQd2VyTC9CYVFyQ1M5S1dtSExrZ0lvbjQzaDgyVGtadnZsY0ZEQ0VJ?=
 =?utf-8?B?eWp1SkduWUtIVG9iV0NWZWJHMER1Tld2ZU5CMmVMVmdSMjVYSU5JeXYzUGJR?=
 =?utf-8?B?d1A0RmlPOW1BRFBuL1VBZ0NmOXFBYTNObTUzOHBIb2tPZm9ZcXVtMzRXcE5v?=
 =?utf-8?B?UFB3T3k2K21hRVlBUnJ1SENNeTFtRUZMbFI1YThSa0ZxVktWd2thUWZUYlUy?=
 =?utf-8?B?eXFNNDJXdnpHd0Zkd1RwSTlERlpXclMvLzZCVzZJcTkzTkh2b3g1akNTc1dL?=
 =?utf-8?B?M3J4dUdMcEkwZFN3RGJURjM5djRZTk0vZnMwWmlIWCtwbTZ5NEN4Tk1DQW1k?=
 =?utf-8?B?UkVTd3hIcTFHcFRtTnZieVlrUkVkcXRZTG55MXpVNVNwbkF0Q21JVmF2emx3?=
 =?utf-8?B?d1lWKzhkMUY3dzdoMXlpLy9weTZzbE5iTGRvWnk1bk5wUis0STFMQVRuZVds?=
 =?utf-8?B?N3dJdG5NSE8yNnRLVUNyNk5lc21rOGlPR2U0b1p2TnRXa0M3ZlpvUjNJSm5s?=
 =?utf-8?B?bmNEc0FiQlVZNXlYc3BXeDBZMTZwcGtYTlh0RFgxSHFSL3VxQ1NuMG5XREhO?=
 =?utf-8?B?TDlQcUNkYmRoNUR6Mmc0bjhkZW5OQWlMWGw3aExjY3g4RHB2WVlvc2lqK29Q?=
 =?utf-8?B?dzhNQURDTzBFTFhRRXFJRTNzOWoxV2ZsR3FaeGZKSlBFbVJVOENWTFVKUmlI?=
 =?utf-8?B?aVArNGJDSWFOVy9jdXRVQXV6RHVwT3VhTG9BM2N0ZjZwU3Nia3BJejBXT1hr?=
 =?utf-8?B?REJRYTZUMCsvVGZBZEJHMUpGcmRnM2FjeU9nTWpMeXBQWFRqRHViTWgva0RJ?=
 =?utf-8?B?Q0c1a205TmhtTmxXaDZJcHltbWtXRGZ4cTNWWTNWMVF3OUpUQjJYRUFVTTYv?=
 =?utf-8?B?aityQ1VaR3U4MDcrSDFiR3ZtRjFCYlFJS1hlSkdweEtrNzUweGhPY3ZPeEdF?=
 =?utf-8?B?U2xIWi9hTks1T2hURzh5MUZJWnppNHhXYWtBM2FCZjAxNXlDbUFyRmphRko0?=
 =?utf-8?B?VGxNZXA5S2swMW1JOTRVM09wSXNIVHFIczlMOTVxamVtaXd2c2oxeUlvMEpr?=
 =?utf-8?B?ZTFFZmxPWTlXR25CaFZ4c0JETEtPMzdQUzk0Y25BMkhNTlg4ZjR6UGg3Z1Zn?=
 =?utf-8?B?SEJicHBRUTNRa1pFeXZSMGlSMGdjOVpvSzhJdlNuRjFtMlA1ZnNBR3dtY1Qy?=
 =?utf-8?B?a01MUTVOZUpGNFo1NnkrRlFoOWVzUUVId0lmUmxudllNWERQYU54MnVvd2Vm?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d30c7b-a61d-497f-05ad-08dbf05f997e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:15:59.2635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jb//iHGoFNsfgeEOHislQOu5oEO9aiqYeY9Mr5kkUmt10b8AtD1jTCTdzgLpVy37iwXN2nPLmSnqX4M4IcGCye+5vX/wNVmJ+w5l2CQ+Zf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7419
X-OriginatorOrg: intel.com

Hi Ilpo,

On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> The main CAT test function is called cat_val() and resides in cache.c
> which is illogical.
> 
> Rename the function to cat_test() and move it into cat_test.c.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

