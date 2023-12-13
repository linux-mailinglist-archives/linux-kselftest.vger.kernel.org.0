Return-Path: <linux-kselftest+bounces-1876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ADC812122
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 23:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B4C1F2186B
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 22:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A984E7FBD0;
	Wed, 13 Dec 2023 22:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZNfbDE19"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C0AA3;
	Wed, 13 Dec 2023 14:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702504852; x=1734040852;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EwLLilaEpu5fM5dW2XRNGPO6dEZm5lmHjl8H9/lQqyI=;
  b=ZNfbDE19YHc97nNR+WL9LMnHrNj91pudJoGeqG3GSyel1124+IQx3B9y
   rSjapVc83gebD7YpKs11EDCyKEohUFvVYM3GmsrQjyhdLIe7nHMLTbAI6
   qezam5zYRnUdOCMQ1DsMHgXS9iJOYvgtsGgDXKN0zg1rhFZoOcC02mA75
   flhS4e4XjeRb6xxrESp93cntRXOr5OLmezFBlZ4hoh/+G9MCVoYoVWTdi
   t0QTFY0S4avYGbLWU7dj4xr+OLRWY0BvToxxhysZOVFi4DM1EaD8elgKp
   0SdoPFAJ2tpatFClfDcuOcqlSOr/VBt4LNm4n50OFhuJiwMKMHJsHmjCg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="375186874"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="375186874"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 14:00:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="864771827"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="864771827"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 14:00:51 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 14:00:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 14:00:49 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 14:00:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJ11rUm1H/uYAUHj5UZQ9hK6eQS+xp42CLAv2nLDRnVxe6AFzpiJi72qnv5xGvPp8NGi9jhhvSJ7POEI8YFQrpYpuhtb9UqyuWu+2PeNQEFm9aDfT+nkYhoRksA12QiiOooY97uoUICiGBnKQ62cdxFoS4FJiRFlcRrwdvg6YCKjcaooDIrUNMtLa0jcU1PPOsenU2nECSFTFZzk11tNbD/JiVmjKcjHNt3gl/L7KTUnxdk/Eck2SAB1rfGj3gDlDLpvVLTSzHqB9lkw+VCTnJSQmBAArkzUc6rVUxD7h+ItS0MF6pV+da/BdEQSpOxXhefxJiEh0hh8lBzu1joXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6F0Nmzcn3HsDy51/stMPrWcy+X4xDMbWkktr8OThFE=;
 b=blHZXwwT2z6thLz9ioL86gE/JCYgt5cbkRcsfUjoX7mbsVlyJt9wlAfdSzDggQm1Q+zHjwixMvhzaSm8iIMCg3DwM23tHrPLmgEByVL0YNI/UXIuRgKP6AsYHMNo77joxwyVNIhu7GBolb9xa7G8UP0+eeBqpyVn5YDE7TVcOMvHy4V3pBKyRNDNqInlbExsdGu0zPhoc/aGtOHVrcyfbh9KTMVpas6fulFHSRGXZOHJtOlqQY0dvkhcUf0RZeUyX4Mdv5pwMcrSedYR4TC2swipk9IPh/IWr3LhaHp7zwTl54zxrlJ/6/kQSvnggl+7H0JQCPRW6jZ9Ly9w0Cl3Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ1PR11MB6131.namprd11.prod.outlook.com (2603:10b6:a03:45e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 22:00:46 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Wed, 13 Dec 2023
 22:00:46 +0000
Message-ID: <172d13f9-2ce8-43ad-b354-402d137b914b@intel.com>
Date: Wed, 13 Dec 2023 14:00:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 27/29] selftests/resctrl: Add helper to convert L2/3 to
 integer
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
 <20231211121826.14392-28-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231211121826.14392-28-ilpo.jarvinen@linux.intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 76db1cc1-8c09-4603-a8d1-08dbfc26f569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cmd3bNBVO/LQ5MCVNMdaAvke859hoFzfhBdHSwsDZiKBPnyfmJk5xBGQNnFCcABtYzoMnsbFr7wBXuQYB5bjrZCjDj7YQ/aS0Qn3d3+Me0LKnErB5zC79nbcosimwrYIdDp0vNOks0FyXHB734YfCJHlsYSAsjIuRECE/LB4ZbTSgZPZIZSe9m8rU4jJmoQR6o9gRQF4ALAS132Dn/fjNP2A9Pta1qLTTfhOp+P3SCe4aAMtDWDLf6Di89ao55uykHary76iP5hmMlCdFKMV8RAmL3lZ74daxVCqZ/LDQNTuO8E6PwsOGM9ui9pOi26gQnEpKYPqto3zBQXtvLSf2jsmuhViSwbkNpZpFQ4KU6USeA7vmz0pYtFTR5US5QMVhZ/QE53WM6CmfWvfS3f0ui972lQwBTERB403PDLj+29KPRyv890v+OKI+WuPj0hTdASk57IZrqTFWOK8GjnaHVWDidXjusomFcQDUp/qPEifdQHcEl/FWph8GzaESqxlXlA2PTnlQSmRj7XOcqzH93ZPKsJmMcc0eOWWZMMOPRN3hC6aANQNQa0tf1S9Q+wDFGFiYcAzwx6kD8uxObeSjroz6dPwNfCo69YYHgP4ThBQbOlFPoTMIfXFIz+rFnRqnYwQ6Ydboy/pBnjDzP/i5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(26005)(2616005)(82960400001)(38100700002)(36756003)(31696002)(86362001)(44832011)(4326008)(5660300002)(6512007)(53546011)(110136005)(6486002)(8936002)(66476007)(316002)(66556008)(66946007)(6636002)(41300700001)(2906002)(4744005)(478600001)(8676002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVZDOFhjbThOOE1JOHVOUzEyaisvekVXMHpQaUpYN0JtVkdqSksyMExuRHBG?=
 =?utf-8?B?c1I0SllIMDArWGU1Z1U1aDFEbGhhWitYd24zNWowekdVa0k2ZkVaeFZuYkhV?=
 =?utf-8?B?TTRNR3lYZUV2dHV3emdaU0x1U0hHZS8yMHliZkFjemU4UERwU1h0SEFXdzBI?=
 =?utf-8?B?elNoakIwQUI2Q1hiODFxNFgxNlJpRUJkb2ZhYXplTnN4MDN6WjFPekNLZzJr?=
 =?utf-8?B?aHowT0FrL2k0cWI5bW5sSExwbkcvaTVGOHJ0M0R2THlRZytFbklOVHBFVFlE?=
 =?utf-8?B?NmNIZ25DTFNESDR6UlhtYUNocURpN3F4QzBpRVRuMXB4aFhXVllTaFR0UVhO?=
 =?utf-8?B?RFdDZnV2ekp0L0N3aE9mcmRuckMvQzBKWm0vcHZ2czVvOUdpMXJkUHJibjJN?=
 =?utf-8?B?Y3dhS29qTGx1ZlpUM0lnQXVlRnllZ05ob0d5TVFjWkRvalBXZFpqc3huQnVy?=
 =?utf-8?B?WGxJYzM5MWUxaUxoK3REU2Y1TUNvR09iTnRKZVMycExTUmJCd0EzblJiSUFv?=
 =?utf-8?B?dThFWG0wY202RGV3dTNGVll2OFQ1eDhMaHZORjZVTml5aitxTHNvSHZMbXVI?=
 =?utf-8?B?WGkzdFpVYitZVVNsSVhNTFF4aUMwVFhsTUEyaUQwSXc4RFlpd2NiSThKMlV5?=
 =?utf-8?B?WE9PajBtdStCZWlPeHRtMXBuaVpzY0ptYkhyUXZkYVREL1A4aDIvRUo2cHo4?=
 =?utf-8?B?VERWQ3Z0Z3VPMGwxRSsveVZxWnZoNW13QU1kTlI1RURkQjNyb0dkYzZHMDNl?=
 =?utf-8?B?d1Ixa1lKTGZDUDJmNk0vbEl1K3pIbTRkV21PVSt2RXRsMmZBZE9WV1Q3dEhz?=
 =?utf-8?B?UHhIMHBxd1dBWGJuaTR5WnpIQ2pobDJLcDVmSnNWenVTMjlLS1dFMkVQZW4y?=
 =?utf-8?B?cEN4UW94RUlNc0VFbFJVRWxXT2h2cVlUVlhjL1QvSEJXMk5MRmhBWnRtbFdG?=
 =?utf-8?B?dXlGWGhlcGNVakptR3VUbHRMa1J4WHRLZXRScEJVZzQ0WUsrVFY1alkwL0V4?=
 =?utf-8?B?MWt1L21HVU9IVWxFMzE1YVo4TlBDM2trTS83NTc5NU9NbTNZYkc3Snl2eFZT?=
 =?utf-8?B?dThQeDY0TmxDR3RLRnlSZTlzck1zYUxaRHloRXBQakdWSEdjb2ZVQ1pnZnNr?=
 =?utf-8?B?cXlMeHMyeERwUm5ISjFGVU84MUQ5aWg0ZEsyTEpnRGtYN24zVXpkWkhnR1Z4?=
 =?utf-8?B?VzBCWmxoM0ZpL1IycVdnUTVjZ09JQ2lEb3dpOTlMMEx4V1ZZbEJ2UFNPbHUw?=
 =?utf-8?B?UHJEMFBRYXpXNUY3YnA0Ulh5dHJNUFFzZ1BaZXhkZXBQeEQ1Z2NMMkoySzI5?=
 =?utf-8?B?RkpjSEtCa2tNazlvS08yc3QyZVU0NWdpVlQ4Y1hHemRNL3VISC9VTjE5bXRi?=
 =?utf-8?B?cEdwdmtvZ1dWNzFtOVVueEdXdE5BYUtCMXA0Ui9hWHo3UDJwV2JRQzZVZS9y?=
 =?utf-8?B?N0p3MktoQURtc2kyMnhDcExJTFJkRnkwdlpRdDh4QS94andGWEdPb0lNd2dP?=
 =?utf-8?B?bnlvaVNzMWs0eWExNDFyZWE1L3ZMRmhkdnYveEhtTElzMVh3QzhxNnd4SGx6?=
 =?utf-8?B?VEZsWkMzSEhMbGVRTkI2eFpMeW8xRC90K3FIMDNSdVRncHdoZG45NTdMdXdk?=
 =?utf-8?B?QkZGZzAyNUpsVlJzc1pjSGFUNmxacXdwM1RORi9MSStJZ0Y2dTBGemlGaExO?=
 =?utf-8?B?NlB2dStiSVlqalpFZGVyVkJqQkZoQzNSUk1yTGlRNG83TmFzNHVRM0JjSEFn?=
 =?utf-8?B?ZUt0cmZmcU9CWVFqR3hVOHdud2lTb1ExS1JidWRhMTR6alNMTFo0bWZ4OVRF?=
 =?utf-8?B?dHFSOFNwTXFMV3RyME9aSUZIMDlZdlBMTDlSQWJqeWhCdElXMURXK2Z6Vkcx?=
 =?utf-8?B?WWhjdTUzbUZxUjlyYzZjeW4wOWxZdHEzeFVOVXZBZ29RNVkrYWNOVllxSzdE?=
 =?utf-8?B?ZjJDa3RsYzZuMzJCYmo0KzZQMWczK2pnM1JkQWdvb0NvcE1NS0pSZENVbkJw?=
 =?utf-8?B?RUlDV0RaRTBGYlpBcS9nZ2RncVdlVzBXS1JMUXFNWVBtaGh0aHhXQWJQOGZH?=
 =?utf-8?B?aFFyS0RWTmpaeldTUUpraEFmSHkrVVVWcVhENE11Zm44VGVROWZwU09wSzc3?=
 =?utf-8?B?bkNpOEIzakcwbU5hYnpYVHFYb2VNTk9TZFd0eVJBcjlHRHh4STJXejNRWW5E?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76db1cc1-8c09-4603-a8d1-08dbfc26f569
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 22:00:46.3169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hc1PhlBSXvHGJJXpB4DzRS/WSaCDTOgLOOLLt39dDuvyIrUSMyod8kD2BDKxfQZX1ZoK2vae35PjMHlL5NEyalAI/yacth+Gh4yygThH99c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6131
X-OriginatorOrg: intel.com

Hi Ilpo,

On 12/11/2023 4:18 AM, Ilpo Järvinen wrote:
> "L2"/"L3" conversion to integer is embedded into get_cache_size()
> which prevents reuse.
> 
> Create a helper for the cache string to integer conversion to make
> it reusable.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

