Return-Path: <linux-kselftest+bounces-764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F32557FC936
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56CB0B213E0
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489E6481C9;
	Tue, 28 Nov 2023 22:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qg+SqOr+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6A8D42;
	Tue, 28 Nov 2023 14:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701209603; x=1732745603;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LcY+I1QkyQM1j895zhH2eB52nkuKTbhCohg6/KyHnbU=;
  b=Qg+SqOr+AXMnJfetQir3z9iZ52fE3xZsjDTwsTDGIts77MFwZchrZWM2
   U4BfRTK2JnNFaOj8Q+qgnnF6dVNf2iqrBIY3WIRTfX6KrIEcFTVJI0dyz
   8gtfARPr2DqjN44PSi7UKgL4peM/Lmh+ppIgbfkDdvYXnWVgG7SVkmzi5
   TKQKHiMLWzLfvDLPu8GGwSk4eJ3Z5OBtu5tKwxPhFeREXB6c5YGainEAD
   ERRCwL0PUolz0CRTy9AHAlhq858VvZoot/RiXULkuIjEIQZhUGJXWS0u0
   M0HEF8wXZ35VR77jk1oigF3r9Dq6PTa74z85PMaZPSKe8efgBkAkC4Hu0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="392791004"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="392791004"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:13:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="834791652"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="834791652"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 14:13:22 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:13:22 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:13:21 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 14:13:21 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 14:13:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjtjstPj3i2eQtQLXxJSFnDUWPPbX5811OXk5L2zwMy3VCr0MII6k6X8KHBWfnvH/QwnWm/pCnb4UwwwRx7rcyVqL04Qz5EK5Pxg3YxqFQTn5iqXSsRa7l29Drd0CoC/rMmeVhgrzAYqvdIKBw0W16eUwzvMrUh9pgz5qqoUzYLHJ/7Djft0PENYEfJmL0qjQh5hXDnlfNEPESU5cj0UB7Hsk38gBr63EdXetfGaRr2FhpVIGMsTks4oipHZddK/dI81I/+f2XjH44bUEihj+XhYWG8U/Z81rPdASlg0517ruiQ55X3W1qdWexRPp1hxmAB7Lsr4RybFqC+yDLVoLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYftzq2+PWB1SQ8SmphpkOm9iPPO19V+DviUoC/JQM4=;
 b=PC6nPoEsYMjPyrA8555t2N6w7/1jN5DouYJrNGg04ZmggrSS8UrW4kQXC3dvub3jgn4Ye4lsnHFselptBiX/FwKIaeAyLykXy8DdPDsGhmxTH6fMFcc0+YiYNrG1i8xKFbO8NOPL0Jr31vkvnwA1Vz8IEn+7WfkIJX2P0hPusGf5h+9vv58pEaB9XkbTeMeqA96H4uKoEmLGdVVEA6l+IysyiJAMHUbI+voHiT0+4VNr2Foh2vfEc5nubk/HPydwwzJmGLUA0Ij57+WAviue0uLFtnd4jXVcdai8kICN61YVZ16XjIkVmYD/OTSauoHRcQElmaMkHGePdsonYQTNdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB8284.namprd11.prod.outlook.com (2603:10b6:806:268::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 22:13:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:13:19 +0000
Message-ID: <c303ba1b-d7bd-47cf-9e81-8ea0c60b973c@intel.com>
Date: Tue, 28 Nov 2023 14:13:19 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/26] selftests/resctrl: Split measure_cache_vals()
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-9-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231120111340.7805-9-ilpo.jarvinen@linux.intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4d44a806-d66a-44c2-1896-08dbf05f3a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F4NEX0blB2VhbQmcn9LHo1LlYAxHbUxKTy5Hl1+2rOLPFtLWSBGzN5nbC5NJpTWL7Dnug7bha8lPzjzwjexsvqMOUo+3JAhPGQocIf3ygylsRpqmf8qwuMpTJzGOdASOLb4WG0Hoe5Ns7nyYajDqvqwMaHMMnlDIdRPxqCaA+X+PKfW6z+RQAf6hRLlsFEp4d1BQDLQ9UyUhFeC6aUGSnwrWk/RIO0tWpfrFGdzOIMpRYQLE6wNyVQVBdLE3BtRVNQqx0XXZkU1sUQanrZej43dBHur00A7H/elxtImjapkAbi+pFLFmJA4p+XvqX3wGXe/5MMcypKMAOEYPGoLYibGh2HyQD1LeGc8zCpBE6jWSCUl+6HMkxtKRZ4tB8HIdLQsjD3LJZKT0/DNPxaHRZvPfZHoDnK+qVvbpcEtsn5kToZK0IjjhA0LJhSWd4CLIuiATXTvDYBXsaWCYgqqLvSuRdBl4j8T6j+q1ux2xl432l5bqL+zro5ACfX0xhb4k9IvwqPkd7tdhVMApCQdGFjwEw7nuJHImBww379fHG8io/qHsL0wu79nMJdy+xrLF0PR6uIlbGTAV+QXOvt6dYUAu6gAB/bb5sdlidLiDG/ukM618U2FqBh1abJfdMxfRLB6JLkxC9SGwn1UR/QfEYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(83380400001)(38100700002)(31686004)(31696002)(82960400001)(8936002)(8676002)(66574015)(110136005)(66556008)(316002)(6636002)(66476007)(66946007)(53546011)(44832011)(6486002)(86362001)(4326008)(478600001)(41300700001)(36756003)(2906002)(6512007)(6506007)(2616005)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUpib3NZK3NuMTdwWGdOTWFTNXIxN3hvcExIQkZ4OUJvRGc4L3JGQ0NHWnRC?=
 =?utf-8?B?Nm9UeFlRN2ZBVmY1bWN3RDl4WmJmcnp6MTVtajhZcUtEVGlPa0xNbzRna0U5?=
 =?utf-8?B?ZXZndW1zNHV4MVEyVUhjTVNSWklYWmozZkFxZTQ3Y2pjUDE1enltVlQzTVhh?=
 =?utf-8?B?ZDdZQXVCdHFodnV1UWRmME9zSmZobXpMTktmNm5BakxYWTBOOVJVMFhBVDFv?=
 =?utf-8?B?bExhdFh6b2NpSUZSZDdJWkI4bWowcW1pOEpBVkFpZFJTSGpFV1RXck9UY2Fi?=
 =?utf-8?B?NjdlQldwNExTbTJoOFZYWTJJUitlc3A4TUJMWTRLYXlDRnFRcFZOYmdtWGRW?=
 =?utf-8?B?ek5pV25yeGFNVkU1L0xMdmxRczkxRUwzaXBSRzlSNS9VdHVpYldKUnUvd24y?=
 =?utf-8?B?STQ2bVdaaURWWHhQQmlkdzRYeUZzaVRnOG8zcUQ5TU5ZMDhXVUZZaSthZUtR?=
 =?utf-8?B?RG51NW5tSU9BTXZ4eFR1Q09Bek9nL21YZkxSQitWZ3FqYlc0SDBFTkx1alQ5?=
 =?utf-8?B?cmQ0UGNzRXpWSTRuTEV2R01sc2RZOWtTVmE0OGJyNFh5am9KTTNQcGJKeFNl?=
 =?utf-8?B?QXE0ak9EQW50NFBCK2tOcTRQREhpZTVJSVQzMDJ6Sk9GR0VucFNxWmVIVW5p?=
 =?utf-8?B?aGVOT1NpVElDdmpFUWFkazJYT09jbXZHejRZaUIxbXhSNmg0Y3owSHdETnlj?=
 =?utf-8?B?bHZhNUE1dE96OW9lYmVjM0RFbVBlVFVVUDgyaU53WGk3ZmU2cCtLY2MrcUYv?=
 =?utf-8?B?ejh6WHdNTk5YM1Nzbm9YYU9tWkFJakRIY21MTTdpelU0WnFZNnNFSm81WThn?=
 =?utf-8?B?Ym10QlFlOHNIV0puQW9TenZTMVJFRWQwN01kSSs2eENiK05wejB6cFN3TWlk?=
 =?utf-8?B?NXd4RVF5cmRNM05HVWIwU21rT3ZLVWxtU09YYUhCOTAyZFM5SHdzRHRHTHlk?=
 =?utf-8?B?YzNJd2xPMG9vNkNORHordVc3RjR1UllIKzY1cDZVMlJncmRrZGxCUmVhSkRT?=
 =?utf-8?B?TXhKY0dTL1BxU2pUYW5uU2JmSmNKcGdKNXozSHI2L3hlMWxZbzBRMWxVcC9Y?=
 =?utf-8?B?dENHUVpFcFdlMnU2T1lHSllZK2tON1NaV0hZK05mY0QrT1YyRVJEM2xLdXRl?=
 =?utf-8?B?UU9HemJkcU8ydnZ4aDR2UGdCcHdMbFFWNVF1c1A2cHNPS0pLalNiSU1mdDgz?=
 =?utf-8?B?S0lRNmJuTUxXdHQ3bnhkaStISDQxREREYlNNVjBOa3NSMjJETGtUalpCcUhT?=
 =?utf-8?B?YXUwRDZMWDlkUlFBVlZXUExSajRXeW5nRXBUWHdZK1pHN3dZRmZIOGR3TWRl?=
 =?utf-8?B?d0tzY1Q5SFBsdU1raWFvRDZMdTY0ZVFrbE5wZVNZS1NwdlJxTzcvb1BPSzFP?=
 =?utf-8?B?MVNwdkJVa3NpcE0vYWp3VkFEVlo0YUh1WXAzV21SYlg4REhMc2kvV2xCMlEy?=
 =?utf-8?B?d0RDSk1UWVZjbldobFZJdHYzczViNzAvQ0lLUC9xNG4wdWpNczh0ZlJ5TE9Q?=
 =?utf-8?B?RUNnYmhqM2RRR3hvZk1rYkZzQzVTWlowQWV3cmNHZnZGNFF2TUFHK3EveGwz?=
 =?utf-8?B?NEp4UG5yUG1haDdqVW1ZNW1kR2hRSTRUYk53Wk5GdzlTeHp0d2JldTI5YzRu?=
 =?utf-8?B?RUVtaUx2NkJzUnY1ckxiNjluRDQzMlVnTytTVU0zb1p5cHN3OThtZnJHOERN?=
 =?utf-8?B?ME1XaitYaXJrOThVVWllWDg0NUdWUXZCNVVtT3psNkVTb0gxdXlPbUZ1UmdN?=
 =?utf-8?B?UnZaUk1EVjRjUThKZUt1WFlXWkUrTldIZks1ZVhRTDhnazNOcXc0L09HTkJD?=
 =?utf-8?B?Yy9OcHQyQ0JkMW9jcGlPRmRLWWpudjJBRG1leFFONC9aRXl3MXpVYW1ONE5w?=
 =?utf-8?B?RloyK3pVTlpHdGxnc0xuc3BsWXJVamtKbTRlQngydi85Vm1tY0hmSXFEZzly?=
 =?utf-8?B?cVU3U0dVN2R3akw4M3duQkE3MjY4dHJ4cGZUa25nM1VsYjAzSzNQdTJMZTRI?=
 =?utf-8?B?MHg0TVlISG9VZDZNRU14WWwxZnhJOW5IMzhzSFZFUzUzYXRjSHZvK3RiMWN0?=
 =?utf-8?B?OEQ4ODQzNHpqRkh2b1RsTFlseldQWFdDdWtPRWM2SXd5bE1WbDFDS0NseUNK?=
 =?utf-8?B?WjlWbnlnSTgwRkxyazRpWlVEQ0o5b0txdURFTWFPV0V4TFVsTUdaaGpneUlO?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d44a806-d66a-44c2-1896-08dbf05f3a5b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:13:19.5938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYPmI184zW3gVv39CaqeYRb58ji4Wa54QxzBEvjzxSgG+wO2ZkhziFTCjyPLp0wFD9kOGH3rWUHRVp1IzqUzQ0uDquYlBsaFIS95KMG+R64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8284
X-OriginatorOrg: intel.com

Hi Ilpo,

On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> measure_cache_vals() does a different thing depending on the test case
> that called it:
>   - For CAT, it measures LLC misses through perf.
>   - For CMT, it measures LLC occupancy through resctrl.
> 
> Split these two functionalities into own functions the CAT and CMT
> tests can call directly. Replace passing the struct resctrl_val_param
> parameter with the filename because it's more generic and all those
> functions need out of resctrl_val.
> 
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/cache.c       | 66 ++++++++++++-------
>  tools/testing/selftests/resctrl/resctrl.h     |  2 +-
>  tools/testing/selftests/resctrl/resctrl_val.c |  2 +-
>  3 files changed, 43 insertions(+), 27 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
> index 8aa6d67db978..129d1c293518 100644
> --- a/tools/testing/selftests/resctrl/cache.c
> +++ b/tools/testing/selftests/resctrl/cache.c
> @@ -147,7 +147,7 @@ static int get_llc_occu_resctrl(unsigned long *llc_occupancy)
>   *
>   * Return:		0 on success. non-zero on failure.
>   */
> -static int print_results_cache(char *filename, int bm_pid,
> +static int print_results_cache(const char *filename, int bm_pid,
>  			       unsigned long llc_value)
>  {
>  	FILE *fp;
> @@ -169,35 +169,51 @@ static int print_results_cache(char *filename, int bm_pid,
>  	return 0;
>  }
>  
> -int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
> +/*
> + * perf_event_measure - Measure perf events
> + * @filename:	Filename for writing the results
> + * @bm_pid:	PID that runs the benchmark
> + *
> + * Measures perf events (e.g., cache misses) and writes the results into
> + * @filename. @bm_pid is written to the results file along with the measured
> + * value.
> + *
> + * Return: =0 on success. <0 on failure.

I do not think this is accurate. It looks like this function returns
the return value of print_results_cache() which returns errno on failure.
If this is the case then I think this proves that returning a
positive integer on failure should be avoided since it just creates
traps.

> + */
> +static int perf_event_measure(const char *filename, int bm_pid)
>  {
> -	unsigned long llc_perf_miss = 0, llc_occu_resc = 0, llc_value = 0;
> +	unsigned long llc_perf_miss = 0;
>  	int ret;
>  
> -	/*
> -	 * Measure cache miss from perf.
> -	 */
> -	if (!strncmp(param->resctrl_val, CAT_STR, sizeof(CAT_STR))) {
> -		ret = get_llc_perf(&llc_perf_miss);
> -		if (ret < 0)
> -			return ret;
> -		llc_value = llc_perf_miss;
> -	}
> +	ret = get_llc_perf(&llc_perf_miss);
> +	if (ret < 0)
> +		return ret;
>  
> -	/*
> -	 * Measure llc occupancy from resctrl.
> -	 */
> -	if (!strncmp(param->resctrl_val, CMT_STR, sizeof(CMT_STR))) {
> -		ret = get_llc_occu_resctrl(&llc_occu_resc);
> -		if (ret < 0)
> -			return ret;
> -		llc_value = llc_occu_resc;
> -	}
> -	ret = print_results_cache(param->filename, bm_pid, llc_value);
> -	if (ret)
> +	ret = print_results_cache(filename, bm_pid, llc_perf_miss);
> +	return ret;
> +}

Perhaps print_results_cache() can be made to return negative error
and this just be "return print_results_cache(...)" and the function
comment be accurate?

> +
> +/*
> + * measure_llc_resctrl - Measure resctrl llc value from resctrl

llc -> LLC

> + * @filename:	Filename for writing the results
> + * @bm_pid:	PID that runs the benchmark
> + *
> + * Measures llc occupancy from resctrl and writes the results into @filename.

llc -> LLC

> + * @bm_pid is written to the results file along with the measured value.
> + *
> + * Return: =0 on success. <0 on failure.

same issue ?


Reinette

