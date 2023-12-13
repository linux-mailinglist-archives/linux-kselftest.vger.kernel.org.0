Return-Path: <linux-kselftest+bounces-1877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDCA812123
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 23:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DA5FB20CC8
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 22:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272477FBC7;
	Wed, 13 Dec 2023 22:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nVeTjmAe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8942310C;
	Wed, 13 Dec 2023 14:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702504872; x=1734040872;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f9aqXLMWmGRnEqZ6p5+Cw3nqYkWukDShP4ARgORT1vg=;
  b=nVeTjmAeYRNC79FAuJcNZPShmrB6isX9V4P3MNEsG1e+5OE/+9wurJl7
   GeqpCqRdi/IkxE7TnjJQE8KuP2D9+UTMPm8At69wahxKkmCZfjPs7nDdS
   09MguqFUY9db2IE6C5joC3yb8UnNlN95yVJGNEiER8Ax8beLYF/gbfjKF
   x9rDPkQgyW6txWhHeRAjK6hEjunK2wIoP3WckWX9pMtJ+8w43hMn/nUIr
   KFCP6KTjQhxx7nXc3NicB57cjdFXOCI7LPcLFmzsa+rbndjQXHSKpkOAH
   6mHSgMe6W/L2pbAVvj7Bykh/reJzce9XWcf2sawElm5y9GPo3dXwkPo6J
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="375186978"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="375186978"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 14:01:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="864772021"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="864772021"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 14:01:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 14:01:11 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 14:01:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 14:01:11 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 14:01:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kec1ciQkXmisPlTK38IDjipciYCAj6XyYNZmQDhITrkIMDV4B9b8ZGm99fIpJIZBuedKzAIPIX02TLkWMkJIK3YcexV5tnlcilfjv0vfGZkavM/hhxjqZsnNSBi/nsgfGi/R24Zru8H3q8Z22yESftziAWuRO8yreZEzdVynTRtQMz78Jb8dSqSYDz02M1oQ3W1e5xBVxZcDS4OtOumP87d0KuzdmThff1ZRZjfYrlCdkf3tZE1jqsQ/c2qd6H0lxFDHhypO4Gz2daLLVAOY4Rxq3wY3NjepyfEs5bn8JxrHEoYMGi0oxiBO5mS8MseK0YMhbuVQAnUebDNrQnmhZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gETcteoGiqsBcsPJuoai+2NZDLnJf97y1nD8O4y+3+k=;
 b=R/4nI9XoWTDZa0YzlXjTAKn26YGW/o2BEPGC8aDGmQUOodNoitMYVdiZc7/6xjqUR/a6x1oBZeOaPS9mro4S7U9uZbRfkQLuRH/0d3qhZ/KKFfA6jsGVVDN7j9XEWr1ROHmkwTprQXjlgNhJlFfGKVje1HKKctLdsTFyxMyo7LxvDXE/0xWZzSDrZkxBGEhm0ykuJcmcGB6mSV+RVioi45PWObJqQPtoIo1Z2DxUwn12EiXi4J9oft6C7P2jkJOrWymAYBtOICFLTbjC0AHrfrybwg/QUVMLWK7DieAd9jyPvWUWckPbTqQINK9HrIh7Z8BSVS2vXOcdPbe0QCkymw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ1PR11MB6131.namprd11.prod.outlook.com (2603:10b6:a03:45e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 22:01:05 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Wed, 13 Dec 2023
 22:01:05 +0000
Message-ID: <602a8a04-3829-45a8-a6c0-489388b6eb55@intel.com>
Date: Wed, 13 Dec 2023 14:01:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 28/29] selftests/resctrl: Rename resource ID to domain
 ID
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
 <20231211121826.14392-29-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231211121826.14392-29-ilpo.jarvinen@linux.intel.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ1PR11MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: 286004d0-2921-4a14-6337-08dbfc2700e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: igmGcWQjumJCub0rXxDAE/FbjpjgymZyk/FaRprUaym//SuGE3ilWlzulcHuRZqHUXjXYXDOSTpf9yNNh1iA7+VZVc4kk0UGjimlJSmMbHlsEZN7RzgVXDvJGxY/vypSUFlgmdPi6p0h279GdWbl9a3nxbkVdWJypWP8/v7MXO5m3S1ZlBUEePZU2wP0mfN2lPYV43O+36H9KZH9w+AYTB875m8W1xWGjxTvEUxLEFol8BZJxDsAY54U0n/Ad9gblqIHlh7+sOvDk6j/JdIx2QYkqhuB7GkK8tDBUgKNfqfn5K/vj5QOBDI217vwdp2UJyDl3B/uSJgAPaR73OJ3JOmn03p2mdi/BXok83LsylUqRuhnyEoYTexPDY6Xq/s3M5TXbud0N66pl3mw4ixKJN6ofruFYW6273YsrlSa9MV9YjykNLn7cuwTyyi4xjGuE4B7GpNCNeeDTX6i418Moy1TgO23wNjzP/OEVIa18x9wSm1dhjPksMi1Jj6GeWdu8opPT/8EKqll6jjdixKR32U4iPBGYUJraq/gTwiuP66GLg35fjt5QWqDtrHcLyELUS6Pdl4S4rr9OZRinAI4lV7V9q0mZuhOfVwN++xPTBQhVBe60BMJ80o3hm+wERYqbPqMvx8Mrw1cGpmq2GLEBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(26005)(2616005)(82960400001)(38100700002)(36756003)(31696002)(86362001)(44832011)(4326008)(5660300002)(6512007)(53546011)(110136005)(6486002)(8936002)(66476007)(316002)(66556008)(66946007)(6636002)(41300700001)(2906002)(4744005)(478600001)(8676002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Si9CVUQ1bFZBRXovM2lXY2dDa1FCSHhGQURZVXJleEx2N0JXZlkvRHNla1Zp?=
 =?utf-8?B?TzNEYUp2aVNjeGMxd1o3dHQ5Y2R2TEREU2VpdEVrcVlPNHk4bitBQng5MWlC?=
 =?utf-8?B?ZThsSDFiUWgxVGlhVU1tRXZsL2hsSXVhbW94SlVTeElGbDhqckMxUWJkVlR6?=
 =?utf-8?B?cXVkTnRjdC9XNDdCSk5aSWxDZVZ0QzNRaHBvUndFcVE3cmdYRUdCbmxhdUxZ?=
 =?utf-8?B?cnUxd3FoL1ZWcEN4aUc3SFVwa3I2dkp2MzVQTFdmWmt4U3UrTFhGTGFKcEEv?=
 =?utf-8?B?Sm5zMVRTaTBSaXR1T2ZpcE5zSTRrRlF6SkhMRTdOcnJmenB4ZUF5NWViNEJo?=
 =?utf-8?B?S2VpVEJJbVN1NzZ0bEZHUkRGNmwvQ05iNTNzSVh6RGpFTU9yMno3UDlRQ25j?=
 =?utf-8?B?ZTRyUno4Zm1Qc3Qyd3NucVhYQXlUZjNkT1FEVlJ4TCsvSytqdnc1NlJlQVFR?=
 =?utf-8?B?QTV5NHViZzJheHFaQk85S1pYSDQzZ0NZd0RrVFBiV0Z0enNGNFAya1UxelJU?=
 =?utf-8?B?d3ZCQnRrd3VHT1AzbnZneXZCazViVjAyamtHNGdQNVpLaEhwQlhaMTE0aHlD?=
 =?utf-8?B?Yjk3OGMzNzdvY1MxazBuOUgyZVdKOWFlNlArZyt1QW5veFB1WFRvL0dheEN1?=
 =?utf-8?B?N0VISjdzclFYWW1EYXMxcVcrcUFqRVR6OUJ5UTNhMnZFUDZpQkZ5OUpuNzgr?=
 =?utf-8?B?QVpIZVZvTUIrL0JRT1RGMnhIbDY3Wm10K2lTMUc0eEh1UFFrUi9lODVYaCtO?=
 =?utf-8?B?VWJjQWJ1b2J2VmRNcDQ4aUtldFEwVzlUejVteUFMbC9YVmlHKzB5aGJBcW5o?=
 =?utf-8?B?NDR0NkpXckRpbW54OHpiSmJyNTgxdlRxdDR3bFNrTDloSWxZV0MwZDdJMFNi?=
 =?utf-8?B?RzdVRUR3R1IxUldxajZCRElrSVovM0tab0V3L3Z2UGdPdVhPcEI4Uko0Uysr?=
 =?utf-8?B?UXN6d3RLRjZUNzVTWDFWYTJwMmxteGFDRTZLbHJwSUNaVWZENzlDTUxIaHVS?=
 =?utf-8?B?WnlQM21jZ0I5R251aFZuallHM21YU2pMYTFrNERnaysrSnRNYjBWYTlFS3hx?=
 =?utf-8?B?RjdOQkZSMVloazBERGNkL1VvbHBqNmFzMWJOYnVJc2hkS0V6b2EvOW5FRUFV?=
 =?utf-8?B?SW1nUFRvNllXRFZPNm1neFJ1LzZtREtRWHhNcDZtMDVzc0xmVnZXcW5mNk0w?=
 =?utf-8?B?dHlTemtUdTJFL1h5UG1VU0tmU1djY1F1NDJLMmdnTGRDM3VoanhDQVM5VXZR?=
 =?utf-8?B?V3NRWVdQaFY1RCtSeGZWRFlkUk96aVc4alhEaWxIM0VFN1hqSXZTOHRtejdz?=
 =?utf-8?B?TGhpcy9la1NWaExDa2lROEQrTGpJNngva2dyY1FvakNNbDZJVU5qb2RLbldD?=
 =?utf-8?B?RFd6Vm5XcWIzWWhWeVBMYkpJdTA0eVdaQzYyWTltVTV0V0I0NURjNk1KN1Bq?=
 =?utf-8?B?cWlRSFRxbE9XZk5NQmkvUTc5WTUrdjdsMEZFZk5xR095aS85eVNxdy9PVU1F?=
 =?utf-8?B?L1VsRlpudWRNa1krZkVQazNjT3dXRzFDYi9vMVBtbW5rckkzYm1jOW53ZTk5?=
 =?utf-8?B?NkxJaDdOQmpxYUd1TExZVVk1UldNZGJ0NlpqTHArZHEzVnNndmdmaXdVZWZn?=
 =?utf-8?B?L1RycHN5cE1qUU9vRjVBNGtxdGNZdjA4MFQ5bW02RVZGbGd0NzJTSG5PNG9r?=
 =?utf-8?B?TDdzajcyeUkxMDdaVVo1VHN3ZHAyVHJESjVzUWt1bGNHanFPcEY0WUxHcGZo?=
 =?utf-8?B?aXdDenM0Q0J1aWNPYzlxd2Z5bFpudkJ0YlFqZTlnL0FhR2lBeDc5TUk1NXVx?=
 =?utf-8?B?Z3FKdEpuVWRONWwxUWpPUHo0VWgvQ3kvUGdzUG9rTzErbk1YKzQ5bi9UWnha?=
 =?utf-8?B?UFAveGw1S3BOTWplVTFUVi8zVTVIdVlsZC8rQWlnUUVIZkM1TEVEUnFYeXdK?=
 =?utf-8?B?OGttSFVWUHMxTU02TG1GTTV0MUpySktCZ2kvZVJYdFV2QXJpeW1QRWtmZmJY?=
 =?utf-8?B?SHNVZ3hLVEpUNXhxZmxWQmxWb09KekNpTnIvbC9KQjlCbXpFWUZOTDRUMklr?=
 =?utf-8?B?QVdmMjg4V2M1NGZhcmxQV1Q5R0xia2hpNm1rZVpIcHlnQmdSZjl5ZkZJVVpI?=
 =?utf-8?B?WEI3a00rUzBwemZSQWNKZkVmZ0Q3ZWVRcUhpbDRqQzl5WDBnOFlEc29jOGF4?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 286004d0-2921-4a14-6337-08dbfc2700e5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 22:01:05.3726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +yqash34PHLsgMjDS8kewyYfzjeMVLywmzzeU3RpV66Fxe4XOcfSmYvQCZOm2Qt2Id0vYSwPnxQxrcb+4q7ZBp2qbXt+3iufiNNWRLkBQmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6131
X-OriginatorOrg: intel.com

Hi Ilpo,

On 12/11/2023 4:18 AM, Ilpo Järvinen wrote:
> Kernel-side calls the instances of a resource domains.
> 
> Change the resource_id naming in the selftest code to domain_id to
> match the kernel side better.
> 
> Suggested-by: Maciej Wieczór-Retman <maciej.wieczor-retman@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

