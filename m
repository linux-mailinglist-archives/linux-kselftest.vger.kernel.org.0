Return-Path: <linux-kselftest+bounces-759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFFA7FC922
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CA7AB2116A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95926481B8;
	Tue, 28 Nov 2023 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akfOu6KS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEE31AE;
	Tue, 28 Nov 2023 14:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701209469; x=1732745469;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Uj/UxnZK8WKa5RjbSCA/NzlBBrnWfJkNbXrR0rrf7os=;
  b=akfOu6KStELN81fA5Sup/Sksg+R6xjfK48VMKwYZmAEBHYdNtWD3FjR8
   qfeT8e/cV0jQ8R65LbTcpWN3ILyba46zavVfQb8+Im59ebfWN6irWvP+7
   KetQOq9T86Tm8Ryk1v0I+ih9kW/729D4j1+zK6MXLlA+VZ7mcN/ajip5K
   8LS593r/kQ2RqYXYk/XMz/Nw5/fp18mFiHRwZIVeZg2QCZbkeUAMx+EPp
   g/BCt1EPF/Gk9BZIOhyfZu6N6t9Rd1lDccpuquZ7COFHfQe7Rmy+fx+ZJ
   tmv3y1/VtjnrcXO6pdNvRAYeI1AR4FbguZGwz+RERi9DKqLdaDnSm9c/I
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="479233970"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="479233970"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:11:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="16768956"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 14:11:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:11:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 14:11:08 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 14:11:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNa+r9AuXiv2vTDEsBUHM5mQU2QEBjkE9E6PB3WjdNJ1rNozwm/h9eJ+gFkPBZrW4olLsUsmxW7kR61IqVHvDKJBkr0C04bAfCqm9sC/mVWO5e4advKXJlViRDbvYJsfAR9WeHf6LsWY8n/qYxr+5HlLY50VliH1n0UoSfBOF2JEPUCXYGZjp/AzghzUf9tsb11CNUlrHKodFdQs5m1ekvM99aH0INyyZFDXl3eK+uQ2ByELkUDyYx/3s6ueuismcbDPMofbtf5T0PGTc0YDRIj9S27F4VzNES9yIiXSl8QlwnbIKsVnjH2iS2uX4o7Z8Wu7jyU9asM/sCa9aOQ/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZVtrYbRYl9vUgZ9iiM1gW7sGFwEgGH6SXCNF3/aEgk=;
 b=SvZoVDEkXccGZan+UKztUaDxafB2I8K7EzHAHEk0xK4evDTkvA9O9Y9QGMCRQ4S7Eb4q0Cr9ja5RppgOrfE1vOHoABxmTM7KWC5Y31n7tfusCqLtYeIpy/odYGDyOVhRuCVLtggBbKaoBCIi+qOZ5+aMtogymVa5DHw7yNSGnV8fUDSBO3RuDUf2V9CicBNUYxGci6Xiax+yTaNeZCO0LHBRiR2VwpUNaGBBMOQLHKnu3yhwBoF5gRJleZ6RZNFJn7NSuNtv674QE7mcBMz2i64+OCXJ2xaxJO0o4ak/cmeOg2CjjYdw6zBbuKQ6A2hCc7j7c5UCyPzoiMwuhmcNRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB6328.namprd11.prod.outlook.com (2603:10b6:8:cc::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.29; Tue, 28 Nov 2023 22:11:06 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:11:06 +0000
Message-ID: <90607b60-b5b0-4dba-b51b-0cd32367d8b2@intel.com>
Date: Tue, 28 Nov 2023 14:11:05 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/26] selftests/resctrl: Refactor get_cbm_mask() and
 rename to get_full_cbm()
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-5-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231120111340.7805-5-ilpo.jarvinen@linux.intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 021147d0-20ce-4b22-17d6-08dbf05eeae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 273lzERBEtWIB9aJ3DtVQWsoFwlKD9aPOpaKIKfrA4+KMsIfFi4UxjuNRUn6luYeZSsJn4oqkSe6dE7ETe+zh+Ldrv88GBM+0oozm96olVwCY4V06Hr2TSIxutxGBuQ8pq35256d1A7jYQvZkJexEbo5+47QOk46BVKvN5NtvPz3u8t1OKFj0Rc2B1T/uMKM8ASsqRJTK3GZy6qGoApRqKrfQp1+4wRNno5Lvbjna3f/pc+IVtqmtj9rPnYlsWfY//Ml878cW06Z1IyuNGLP5mt/Px8JfxFcuRvegx0R20KcyAQxYsJVoGH6uwNKr5lGd6W94lbkrr1Ua0Ir2UsG+L+C1nOrzVDM3wRf/iXuBCfTmbGZNlfScIC90wc3qvTXbPxH/YDAYCKEfbThwfeRXC6E0H+HKY1Be1RAESmnlYfYwk2NYQmDAA5M7yazPV+/6M8xXi+yteG8jzwfp041FxrWCTOHaKn4tOP28ACgUK+ZHi38sw9a/BpVby2RM2JHHp896gWeAuTs8f4bpHaxv1M8I7WNUPTTEdFMeGQ7AF2WetzXaCyW4XM9UJSd1fIEgXD47zhjoBcmZI8KhaGXUjFj/RVZsFusRbPqgvIR4GtubduiDk5ny+RS3SnYRoQPCS6BfEZx0JxA8NRsCuy7Ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(5660300002)(44832011)(41300700001)(8936002)(4326008)(8676002)(31686004)(2906002)(110136005)(6636002)(316002)(66556008)(66946007)(66476007)(2616005)(6486002)(478600001)(36756003)(53546011)(6512007)(66574015)(26005)(6506007)(86362001)(83380400001)(38100700002)(82960400001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkQwNTNOVHd3Q3F3aVNTVUVjWTRIalFpcE5RT014L1AyRWtoblE5N0JlcUVJ?=
 =?utf-8?B?S1g0MnBaOXR2TU4rQURVdDZHMC9DZzlJS0pmTUVLTFpVYnFsM0hkWlMvYjly?=
 =?utf-8?B?QWJTV1pyVzdWVkoyWjRtK1FTWnVQdWRSR29MUDRxRTJNaGdYUm9STDVoZ3hv?=
 =?utf-8?B?RE4vSW9LUXU2RWpVbnA2WUdhQkZvODFrNjFDZGd3N2RLYkZqcm1IL1hvUE1S?=
 =?utf-8?B?UEtCdmpqcnQ2RkVtdWdLWnhzRFdLRk8zbWt5ZENrb2ZGYXJHenZBcHhVaUdS?=
 =?utf-8?B?L25rVGVxdmdwNUFHNXErQ01TcVppdVFMNkVhajFwcVd3YjJCOURuSldqSThq?=
 =?utf-8?B?aU9aL1hZanNCaHU5djdmaWdDTlQ4SUtYQW5IRnFla3lDSURmclR5TTRSaFBm?=
 =?utf-8?B?N0pBM2I1WXZMVjErbWl2SjQwejFteXkwUTduNGxRVXJYc2ExS0c4MXEvOTBN?=
 =?utf-8?B?anpEV3dOUXRTb0VhTTZRWnhSN3hUL3BiVEhpNWp4a3pKaitjVzl4UmdXRUFV?=
 =?utf-8?B?ZFBXM3crL0c1cGJDN3BVNUo5cjlHU01YVVB0SW5wQWJOSGo1ZlpXWFlZY0lm?=
 =?utf-8?B?a2I5NlJzQW1tQVYzQmZteXRzUCtXSUw4Qk9TOHJYbzZWQlNEUHlzOUovZE1J?=
 =?utf-8?B?bWF5MCtxdVFCbFRmd1d0MjV1SVVDYldCbEZuZ0N0dElkTEE3SlZITlB1UHNO?=
 =?utf-8?B?Tmx4NEZPeUU4Y0d3bk02NmVWbWxUVjNScE1aZnY3eDdkaWdLdm9BV3RDVTRp?=
 =?utf-8?B?ekQvOGZmaDZoTXJCYkozdlZtKzVxbGRoWGJHYVJOVEJzNnRObFVIc2JzNmRX?=
 =?utf-8?B?T2pya2thaVo0YWR6OTZkN003YngxRjhQdW0zclFrVWhsSGpMVFpZdHhNSFFn?=
 =?utf-8?B?MEt3Vm5VQit4d3R0TzM3V3o2MWRqRDVqZHl3Q1VlbGxkKy9YcTh6M2crWmtz?=
 =?utf-8?B?QkxLdXJvTGRwa09VMmY0czNKSkJIeVQrY2IreVBEUDFLUVJscWNGWlk2WlMv?=
 =?utf-8?B?eE1vQ2FMdEk5UFMvQ0o4OWVpb3lLY2FpdUpYbER2WVVNcXAyODZGTnZGc24y?=
 =?utf-8?B?aDJkWGhXWHJGVngrWmpzcUk1N1A4Qm51ZGUzam1vY3B4Zzg3K2xqdnJESDA0?=
 =?utf-8?B?S3VhU3p6ZXBueTIrempGNGRmNFpqdjkvL1d6eWhiZ1Rrdis3L1BFVVg5K1dZ?=
 =?utf-8?B?WTdjaGVhQTUyclRjVkZIbWVVQVkzM1FSUTEzSEhKcnJVczFNNDhzZkJHVlQ3?=
 =?utf-8?B?N3E5aWt6WFRHNmxjeWtOcjJ2bjFGcnBBWVc0a3ZQNndFQ3ZQL0pKL0hNMENF?=
 =?utf-8?B?YXlGcEkyc3hscjE3UDQ0dnBYMjRhY1FLaFhuRGtjRGtRWjJwQUJtYkY4RVlS?=
 =?utf-8?B?c05ranRaR29LUmVNa0hPb2xWZ29VdTBYU1FJcDRhVEVpTDR3VFlENXVUd0g0?=
 =?utf-8?B?OHZhblJ0YjRUQ29lYmpPbzZSZ240RTFuNVB6a1pXQ3J4YUEzVmUxZjUrd3Bv?=
 =?utf-8?B?Ukw2V0tRanhBdDJWWWE4d21YclhVVEQ1b2tNTS9idXJLWUw5QnhORkZhOThz?=
 =?utf-8?B?MVRLSmxyNzU5QjFvR3d6ZWhETG5yeFBlaCtzZzBabElGRmJsdjU3bUQ2TjJC?=
 =?utf-8?B?cnlyc291WWVXMVJ6cTFSQWVYZ1BLUkRNdU9YdkFkZzh4bGxYZUk5MTVla1ZC?=
 =?utf-8?B?RDA0aWlRRjNHNlZzTnNLNktvdGhIWDNBc1lrVXMwb2o1SlJmSGZzb0tTVVZi?=
 =?utf-8?B?TzNadWxPYkJNWGJOK0hSanlySW83bGNTRHZ6UEJxRElJTkNLUUhtMmtFMUdo?=
 =?utf-8?B?VXNjU3lGS2d2ajQ5K1k5RE42NnFzSEpUaTQrdkdMdXBXK3BseFo4YlVJZ3VV?=
 =?utf-8?B?cjlLL0s3WjkwOUg0eTl5YzliRVM0cXEvY3EyMkFvMG5xWkJwejVvSUNMQTNa?=
 =?utf-8?B?M042RzBJOU1qaW1xbUVFY1BuRnEyVmtGVUxybHZKQnlDUlpTR3Q4QnpNVkhn?=
 =?utf-8?B?T3RLSDhwVVJVcmMxTllxbndBc3FPa3pETHF0YkEwOEMzVlV1bnMrc3Z4ejh2?=
 =?utf-8?B?OHJXQ1FHM3lkVU5ueG12eGtlK0E4aXp4NllkYzNQVHhDQS9VTkRpVGRVVDJE?=
 =?utf-8?B?UVR3eHVYSUVyVEViV2kzcTVRS25pM1pYREtObzVlaVpMZUxPc29Qd1B3UDZK?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 021147d0-20ce-4b22-17d6-08dbf05eeae2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:11:06.2458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1hi8bscVKcuu+XMr1tLYECivzCzX9inX8ZgBSkx8/SA899mjbkmKrSeDIvaYtWSYvyYtLyBEAyGnY5XB/TewOmf6HNnUD4hfm5rToTVPjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6328
X-OriginatorOrg: intel.com

Hi Ilpo,

On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> Callers of get_cbm_mask() are required to pass a string into which the
> capacity bitmask (CBM) is read. Neither CAT nor CMT tests need the
> bitmask as string but just convert it into an unsigned long value.
> 
> Another limitation is that the bit mask reader can only read
> .../cbm_mask files.
> 
> Generalize the bit mask reading function into get_bit_mask() such that
> it can be used to handle other files besides the .../cbm_mask and
> handles the unsigned long conversion within get_bit_mask() using
> fscanf(). Change get_cbm_mask() to use get_bit_mask() and rename it to
> get_full_cbm() to better indicates what the function does.

"to better indicates" -> "to better indicate"

> 
> Also mark cache_type const while at it and remove useless comments that
> are related to processing of CBM bits.
> 
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

...

> @@ -229,6 +228,32 @@ int get_cbm_mask(char *cache_type, char *cbm_mask)
>  	return 0;
>  }
>  
> +/*
> + * get_full_cbm - Get full Cache Bit Mask (CBM)
> + * @cache_type:	Cache type as "L2" or "L3"
> + * @mask:	Full cache bit mask representing the maximal portion of cache
> + *		available for allocation, returned as unsigned long.
> + *
> + * Return: = 0 on success, < 0 on failure.
> + */
> +int get_full_cbm(const char *cache_type, unsigned long *mask)
> +{
> +	char cbm_path[PATH_MAX];
> +	int ret;
> +
> +	if (!cache_type)
> +		return -1;
> +
> +	snprintf(cbm_path, sizeof(cbm_path), "%s/%s/cbm_mask",
> +		 INFO_PATH, cache_type);
> +
> +	ret = get_bit_mask(cbm_path, mask);
> +	if (ret)
> +		return -1;
> +
> +	return 0;

Can this just be "return get_bit_mask()" ? But actually, I would
like to propose that this also returns a failure if the returned
mask is zero. This would make the code more robust, especially looking
ahead at utility like cache_portion_size() that divides by this full
mask.

Reinette


