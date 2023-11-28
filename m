Return-Path: <linux-kselftest+bounces-762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CBA7FC929
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E1D282EEA
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACE8481D2;
	Tue, 28 Nov 2023 22:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+PkHz/x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B301B4;
	Tue, 28 Nov 2023 14:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701209498; x=1732745498;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Zv4itfY+lHbvRla+5CaMfLcddKPhgqEhSoIgqB+6+qA=;
  b=I+PkHz/x6z7xlP98/4WKibHsINJiKxCE3X3N0U1CJwzaRBJ+lw988HSz
   oyf9R3NLsY2jJfOwF5BJ/EajDGy0I6q78zppYk7mKDqtfzNvqwASX8GGg
   UsoCQMCziYHKLanNWF2aRRCVeIwazN5oH4/t4VuInCR6h8V3VmxJq6JY8
   DfjQ8gMgWY7BEjpaIBZpBJdhihd5+1wxHUxFy9IcqHhOHTvHEq2rYKGoB
   723UaaET6Xvx0xvbQNLKVgai9ei8d/3+UVBevHK+XotE4QZ+xeTqRqRDb
   pawQFwMVjUvllhq1JmomRVc3eE7mp/YOxsMKTR3wlPOTSLE/anNxfhBOs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="459542917"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="459542917"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:11:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="768680655"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="768680655"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 14:11:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:11:20 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 14:11:20 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 14:11:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTnDt3768cwnAgV8HvnLgiEJU2+eS5WXhDbn7IAIk9DWcJRNis0ChsD9lzZOOULoj8qadU5af86Bqz2p3qk/uWmWw0gMl8FoWs6Ik6LWaTUZf9TjnA0w/xFXwhLttfnYLC5EM6Ob0XpLI5YH0dknXOzBqk2caQ+04npOkAZQTSuDhw/wYmCnj1wqKPNqHUEGjF7oGb24xXgpCph6fpmNqZnbVBvwkoZlXb7FWNknLSOvTakMyRA4GigmnL5XxogZ4o0oskEsMQNBge0jBqHfTLO1xQmy/FnoT7pW2zR5Ny1CHjoBoTE9wCnUIbNB4BysLQ+alM+OZn9RB3AAidobgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTLOkHxS9Gd9GJIVCV2mkIXa4x11pmYX/3+Teczov/0=;
 b=m+mH7RXZubyzmvC/8s8GagzEKLcgHV0C8ODXfJKj9sm2fq27qeRPMoO+JwsH9Oy1rhkWj5rrF4Ef6eOMmMPUFm2byY9R0Ec+lI++FSKiSP0hHSzHDcAvu0dK2DSOdmq8/gMn1cVTtVsc6tv2L0z5SetnqsKT1cj+LrE03vcjxJCZFP91quYwVdU81PHp8zGl7xkyoyrnID28c2gPESiNMDgp8/LeDTE94+jAtHeDzBTDdBOEc3Jlrx4Je+MWaMJ1WKeHjaeV8+dtg3/2e8FGjVC77WRdLgPwaStTnhYuLntjuMFiMNAiwG4l2uR46zwo7lAGmZu2Y/fkKH25t9BMug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB6328.namprd11.prod.outlook.com (2603:10b6:8:cc::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.29; Tue, 28 Nov 2023 22:11:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:11:19 +0000
Message-ID: <8436206b-b9a8-4ef9-9f9e-8fd5272e2ecd@intel.com>
Date: Tue, 28 Nov 2023 14:11:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/26] selftests/resctrl: Mark get_cache_size()
 cache_type const
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-6-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231120111340.7805-6-ilpo.jarvinen@linux.intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: f003d29a-2105-4076-7832-08dbf05ef26b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qt7WBZ/X5mmtaGMDAmSG3Eha5XL4rpnkBYrwboPSe0w/YD/fhXLE3vCUDhqU+TI38B0Pg574GWV8K9+l7bjEJ9zY2miRTPoiFANeQP7QBiO5bkFG8wXvQEhgqz9e9ImE3mBJuFkeHFpBLEt2ZzuwZef2QTD3/rszCuObxJbWqjvR/InbrkRQ5QRFi+1SBzOOl6Yl+TQeK6wHhOwqIYLoP3mdFhWeJgzlwi36huay6elKFfNwBW/z92MOu37qAu8TUAFmfpU3YaucUhwKmckstSosUXLcHRLeAqq7Nuqsi3hpnZyxQnLfZmLt+Gf4J40FdieDrF0QDCsGg0Qgvib0fFhpxH810lP7C9Ir8Vt0jMioltDxsWOLF0lq0/hOTGcOUWosp+G3lyONoSFJC6biKwkKS+GNTK51dOfPezinrHttm6LIk0GQNYRjaBfiAiWMtZoCXduur8RcnJmhsEJ98Q/yJbqvbFLuq4iYUxd159ASwlhnzzy7ybHfruSlHp6Beaol32wP2cHL/cLXpX77k3/3VArrA+j1CGcY4Rf2lt+FYRAl10tiKhMx7XXssIr9E74NQKhBDh7/2bOk964q8J9s92F3+hjuZu+6tABXoeJFJTkjkA/WHZGwQqhgX0WG4nAJ8ihos9vfl7EMPaJa6V/2K5KA9q1/fUnU31LDrLho7+6b8s/Yxn0Ci9NeGr1+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(230922051799003)(230273577357003)(230173577357003)(186009)(1800799012)(64100799003)(451199024)(5660300002)(4744005)(44832011)(41300700001)(8936002)(4326008)(8676002)(31686004)(2906002)(110136005)(6636002)(316002)(66556008)(66946007)(66476007)(2616005)(6486002)(478600001)(36756003)(53546011)(6512007)(26005)(6506007)(86362001)(83380400001)(38100700002)(82960400001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDRjbURCR3l1THBnWWs4b1hJcFpDcHllMUxEQ1l4M0lWTzFCVmdYNnhYbWQ0?=
 =?utf-8?B?blZSR0NPRWF4Mm95aUhUY3lha2YyaW5ES1o0WW5MOGl0Sjc4eG5zU0ZQYXlt?=
 =?utf-8?B?bngxUFFFQXB0eko2TGF3aHZzZlkvMS9XMEUvaUMwcS9EZWVwOXl5Q2NBZ1NS?=
 =?utf-8?B?MTlVNDZQNGZtWG1hTWNtMHQ5cm0vdWpZWHFTeTJncHZQWmd3NHUwRkY4V2xV?=
 =?utf-8?B?cHlnanJuVytGMkhXV3pBVlN0U0U2dlJZalVnaDNWa3pZV3hpR0JlTTQzaDM3?=
 =?utf-8?B?a1MyekhVdzJJaXVNcUpzWWlEUGt0NHNvTDVOejNiOVU2eWI5SVhNcTFqeVN1?=
 =?utf-8?B?VlVncnVCekRQRVRxTzNDbnZ4YlpIaXR3RktHZlV0SjlJRExyblMvbXY5SFFw?=
 =?utf-8?B?a0lwS0J6NXlrVWNMZmZxSEtNU1NFdEt5cVpheldDOVAySlZ0YzdjblpDZDdL?=
 =?utf-8?B?N3lHNGhIQW43bGlWZ1ZZdUtrbkdKMmJlSEhpYnZaN1NkT1R6TVlPY21xeXlh?=
 =?utf-8?B?UlN2cGRwRjNaQ29NaHNBTUpyN2pkd2pNdisxcmtNZHhYMVQ5VXA3cWk4emFt?=
 =?utf-8?B?NGVQd0ZHdE4zOGZzbHRMNUxSMFFrREJXcUpubTNueFhRd2VBUzEySkNhdFNM?=
 =?utf-8?B?eWtYTXFzaE9Oek5tNnRGNzBRYzZDUjFBazRxM0o5NGZhYWRkTklYZGwvb2xI?=
 =?utf-8?B?ckhmTDk4WDVDQml3ay83QU9Td3dWNTlKK0VoTXBSNFlpL0RQamoySzJPZXZw?=
 =?utf-8?B?UTF2dzFDT296UDlPMU80ZE1DYlZBbXRFeE9tUHpibEVqUTFaRkRBS0M5N1N4?=
 =?utf-8?B?eFNKT1o2OUU2RWxhTEtGYlJaQjBvOVFHWCtvMnZXZkhIR1dLYWZaZnQzTEVq?=
 =?utf-8?B?OEJSZGVsVTJ3R3hCRDc3N3EvK2RRQWt1T0svRExXb0pPRitNL0ZyaGZjUks3?=
 =?utf-8?B?WEJUMTdobjJqa2hSRVB3UTgxYXRObngzRjM5V21KejZtSXJaTlhqRUdoa0JJ?=
 =?utf-8?B?cjFGUFBidTRqTUR6RXQxVHpUY1MweWxUd3dyNllKaE1idTBuSk1TS0VSdFR3?=
 =?utf-8?B?VjFtUVN5VWdyK3Z4cWp1anE3bjA1cW1WdGJTbzYvS3BkOFF6NTRqS1NTQ1Az?=
 =?utf-8?B?TW5TZzRwZVNKRGdUb1ZZa2llTVZmMlIwYlU1WElkcTI2THJrKzl2SnA2Y3NK?=
 =?utf-8?B?SEhRcXFXNDllTGJBTW5HY3B4QW5odEVJdmZ3SmlXN0V6NjhnNTd1Q2hUMXZq?=
 =?utf-8?B?Vi9TaWU3K1hGUnNwODRvRE1rcFh0T1ZFaXFQMEc3RU4wUEVhVFFnVDRhNXZQ?=
 =?utf-8?B?eVdpOUdxVDUzdWpRZ1hxbEZ1THdmTUwyQUlEdklWd3gwb2FoSWs4ZDFlTWtE?=
 =?utf-8?B?TWdpcmh5RVVxRXNLalpIYW5tWGM4ZkZXMWUyM041d3F5SVNYRGVLNWZiM0VY?=
 =?utf-8?B?RkkzZEhQQ2wyVkFTamloeUdsOFM2U05nOWQyUWpwMlFUNkh0VGZkYnRYdFEz?=
 =?utf-8?B?cGc0L3NpTXFKblNuZnY4aGZwdEdQbm9WRHFFU1RpcGY0OXY5WjlLem5MOWhv?=
 =?utf-8?B?aERDek5wRkJUWHRvMHo5U3Q5TkNaTkpqSzdBd2RJOUpYN2JpblE4QVkxRFhK?=
 =?utf-8?B?dzRyNjQ2YWV1OEZ1WnA2SkxBTVgybVBpbmJvMVFaRXBwSVZqQnpDeXUzdzBv?=
 =?utf-8?B?d2xGMWJOUU5Cd3hXSEdCaDlZYnZlUmNwQ3FCVUFOaW1QZmJ0MXRMaDZFVXpJ?=
 =?utf-8?B?bnNOTXNHdlVHd09OUCtiaUZQN1drZjY5d0Iya3NjS3BaMGdUbGR2cHlUZUd1?=
 =?utf-8?B?QS9HbWhsRkhKTjFDRHB4M2d5YmhUbmtVVmxzazlOdjJSb200cDBSeUdhZThY?=
 =?utf-8?B?cmNVUFNub1YxdnEydFpOb0l5T2NVWnVFME9vWFRqMHFRRmQ3R3dhL1ladStI?=
 =?utf-8?B?WDR2YlNxK1FxcllLSXVueFZxUzNUT0grYWYraUpBV3Zqc3c4UmpyTUFhNnFE?=
 =?utf-8?B?bkY0UllqNkVIMmVFVXp5U0NjL1g2R1VURkFETGw4UEd3NEd5VWIzSnpKZGZR?=
 =?utf-8?B?Ly8yZGo0dnRySzd1ZzJ1TjgwWXBZdHFISkc2NXZlNzc5NmVsKytURUQzeVIw?=
 =?utf-8?B?dUtHdUlIQXoyNnVIcmxXQWd2YmJKUGlDRnNYZ3BzZWswcGVySUZEOGlrYUI3?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f003d29a-2105-4076-7832-08dbf05ef26b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:11:19.0557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mp0xgZ1sy7T6yUY9t+hCKZkF1UnicocAtmBLlQ/MLSi15/O+cNE8J2fLyv4QKxeE/secSUJz8bl6cESr1kRlMoIbONTrXw2MZ5y61qQKal8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6328
X-OriginatorOrg: intel.com

Hi Ilpo,

On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> get_cache_size() does not modify cache_type so it could be const.
> 
> Mark cache_type const so that const char * can be passed to it. This
> prevents warnings once many of the test parameters are marked const.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

