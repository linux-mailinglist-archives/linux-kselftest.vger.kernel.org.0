Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37805752D3C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 00:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjGMWwl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 18:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjGMWwk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 18:52:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFB02D46;
        Thu, 13 Jul 2023 15:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689288759; x=1720824759;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ZD4HScorAXqf2+OWaw23bEWT78EzGmELACTo5XioEW4=;
  b=NOGBIySMaha8L43rztK4HUkWPtm8NAqrpAvGKyg1z6RZ0BwLZcbsnuI8
   dYrIu3nGe/ZlJjFuvGjJpUth9kXGhh1W0eIomSgNgLglGfoTkDfcvidQa
   1dpZIyyXB6W2RZFfKWmwjwZkgGBcvtO4ObXG2bKkzXcc1CEGXIEcCqg9E
   Xc/tRqC2oyX/EtPxadyiJtzcDYMGiBFv2ES+sWf8w4pOzFOEWGf7Z1OPZ
   d4vXfJm7NXiLNE6co0y2dWKNM+84qBHGFmkvKHsOWjJP2dwPHzuMk0xFI
   SBMoKPzVRDlxRqiLsiVZoWs7wDFRdOo6sQDRwouwBep2/kyU8nbTAQKy8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="344929948"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="344929948"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 15:52:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="716130718"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="716130718"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 13 Jul 2023 15:52:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 15:52:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 15:52:37 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 15:52:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeTJmyxfh0yN3ecJmzDHg6/k2FLxAfeqUWVVnQxbDwm35F7imI5AXCXU690u6pNx56a3HnW241Z+WjAJe+Jt/HMDvt/l1NoDE43UwYBSKDuUlT4Y30AAJYyiXs569B/Ztcjv/58Ftx5VWyU+mfuYU6SL05hJwWD+rHxI2dpOT/6izsvw39UPYQB+ohossN/lObb1eegkSCj3n4cWl3179WWikpAgz6YFykChfmzVRlDIkEDb9TqhYx2QkLiYQBUgxog2yuXQnhCncM+bXi4qk3tZbjFiBZEzutE7A/zlohMIvq57lD3irDG3mrQzMWFmXJ9b3KpWpNjFTMSdkGAiIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxXjIxj5u7EId9lhsprYS7ie6DfFRGtshNEOGpkuSiQ=;
 b=EVjfG7XC1CpNExOBaKCKd12m7IpJ12wjyD9fzGJYSRsLGR/25k7danrErVyyyveA1s0I9SruzDUhMsZWXQQzA3ntlG/vQGclIn/xZ3nBZrKb3IgLafWOk7XvqbeLgyH4G37wnSS15iJxDWnO56DLEfaXw0kAovLew1GlfraMQcKZIritANZY0lsL2TaD8SvdDZtAZpcaA8XGArgEF1XIflkF7JJlKD+zWmhGAfK0KLNGD5K+HyosPkI8ULScc7PTGAX75fdJ8G/6zh7WM274WRvCGcDKRIxAiFPBtiOJ48SjH0qTryNu6X5dMUo5pxIBRECySD4mdpHNquHRZiNMdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4689.namprd11.prod.outlook.com (2603:10b6:5:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.26; Thu, 13 Jul
 2023 22:52:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 22:52:36 +0000
Message-ID: <a4fa6303-4637-815a-e0fa-57f33babfb10@intel.com>
Date:   Thu, 13 Jul 2023 15:52:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 04/19] selftests/resctrl: Close perf value read fd on
 errors
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        Babu Moger <babu.moger@amd.com>, <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-5-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230713131932.133258-5-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0345.namprd04.prod.outlook.com
 (2603:10b6:303:8a::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4689:EE_
X-MS-Office365-Filtering-Correlation-Id: c1421416-4875-46e8-264f-08db83f3d9d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJh/+wCL6C0YRJ6uCDLiIpj3j3LHc7PHR073P9M3mHpIyi0eXWSQszmW3FJe+Vutzq9/mVXDKIKcdgsCOPPME/aNAlyUVp6r2W8xSjlcfxxBFC6zT6fJXxm4d9Y1Pq86U4VWjq3nWUFjEdEtZcpG1fpKRKjsHUFIESczzQz4jsu6dzV13Q4/QHPytJk5DZCzeoK1DojlYRnAfwIq4KQ0+OKK8XwHRCBIvcL2tr6vjN43ppBtCwlsqCELEBl4w0z5dtEhJ2GvqBcKFC4PYg/0bpzv8NCVU5D+fLALBr8e2k9lcvOuMYjjWn3HcTz6sPgG2CZjJcnQF5zzqWNAd1oEF3mz8h1XI0MyRJtEIEU608MfzdhfvMvGoXnySbGA3obqQuPmlYuKKsWJMlvUocuVI/S7CToIbmWgC8yX+Qd+5c768u9GmXpCwo01K9OyRkMoqzY69uUWJOyJxEmggBqfZhbBq68bdY7AyQNQUrlJmeTC29gB9Qbd/BltYkAL9f84TvDxEaKaGuz/8YGiHh60sFvTgWkj3RJ3TWtFaigoMZC3ssP2YJKKMexAOXjxZhNasYz8KSOpTYdKmGTlkt8Axr801QYJHeTkMj5nIp8ZiXuoWdMsF5YhENytLH+ojO/7vfK9dVykp9SD8OzCGUM2Tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(53546011)(186003)(41300700001)(26005)(6506007)(478600001)(110136005)(31686004)(316002)(66556008)(66946007)(66476007)(8936002)(5660300002)(8676002)(44832011)(6666004)(6512007)(6486002)(66574015)(2616005)(2906002)(83380400001)(38100700002)(82960400001)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU0yWENLUERBais2Rk5hajZPUG1XdDJybHdDdkM0ZlNTYU9kcVBGN05pbjJn?=
 =?utf-8?B?bm9wNE1YUlFoMFdkRUpTeVFnWEwwUU4zdFY4aHVCOHU2czJBM2owMTVXQnpF?=
 =?utf-8?B?T3FyTkZxekc5YzdYUGxQVjlSbGhoTWRrTDdSbmQyUFhBdU1haXZSSGgvVWhJ?=
 =?utf-8?B?VnFKclFTbTBnZzB0U2NnRnAxWDd0anZvTEdjL1NQdGp5dEx2MFc5TGdrc3l0?=
 =?utf-8?B?b0JWL1ZVeEtHT1krVVp5RlF1M096WEx2TEo5OHhKcUdjck5RU3owZXBDQjVE?=
 =?utf-8?B?YkpMTWNDN0NnWHptQ1E3TnNqQUZ5cWFpV1pMN2pGSUxCd2JGbUErb2g4T0Ez?=
 =?utf-8?B?LzhNWVhqS1c2OGlVRVpidUY1NHFDSDBLWlplMDJlbWhBcUYyQWZ1L2Y2dDhR?=
 =?utf-8?B?YlZSN3FlNE5FRkIwTDhNck4xczhrOEd1TjVlZGxLSE8rbTJWd2VvamFvbWh3?=
 =?utf-8?B?ZEgwdDZ4SldDdGFPU2FiNnBvTjlNRkFrYmo1R0M3Yk5Ub1UrSWNQUnJjUThU?=
 =?utf-8?B?WWVObS9pMzl2cXhyN0VyUFhBdkNjVnhIU0VLdnA5V3J3RGZZSHhsUlNWa0hX?=
 =?utf-8?B?V1JpVkpCUWNPWFZCM1l6UERNSExiWm5Udi9OWWdUdnJtTy9ZQzBCY0FiVGlW?=
 =?utf-8?B?RFFYc3grcG5uSEJ3S1JObkFvUHUxKzlya2tsSndGUFlQSnVaNmJXbVRPUUxN?=
 =?utf-8?B?d0YzMlFpaE92ZWk2bENnL213S3ZyQmNGTWJzV202ZXR3UnlRdGFONFd0NzUy?=
 =?utf-8?B?czNCUE5ReGQveDhJWlYvWmNPUkRTbnUvRDlPUDNOemR2ZFY4eWdyREJneGxN?=
 =?utf-8?B?RmpGbnk2YTZhOUpjeUxTSXpGbnRrNVhYSXBXOVgyVUloNStxZjhZV3VhQ3Nn?=
 =?utf-8?B?SnBJVXRDdDNWemp4RUZoZElidElmTksyZlpyZVZSUitrVEV2UlpBSFVHbzhp?=
 =?utf-8?B?YitJdVN4cGdXMmFtVWVCcm5UZWVTcWpkc00yait0UW52azk5dmVhMmpFcklO?=
 =?utf-8?B?ci9KblM4VExLUHVaNUt6NDFoaDBYZzJOSlBjMkxjaXVGV1JkTTJ0LzBNcnJI?=
 =?utf-8?B?ZVlSTnB4cTY2ZmpMV1JNN3VCWlZVYVhzTlhSLzc5a3VDaWlaMk9LK0d3Yjlq?=
 =?utf-8?B?R1hReVJMOUx4azdEMVE2eTMvamVTeDR5WklRMDluV2N6dGhvcnhVclVCaWJ5?=
 =?utf-8?B?RnlTSWZ1TDI3KzZGcmJhWlBYUFFSVmFKRjNQV3FPdlNEU1JiUVNIWUZEMFZv?=
 =?utf-8?B?ZXdnUDlEdTQ2KzFPT1AzUWZBeUVMbmVVT1E5cnlOUlRodWhReGFuRFZ4Q3Bl?=
 =?utf-8?B?N1pHUUUwbFpISU44V1VYVUQ1ckRFdW1nZ3VabFBTTnV2ZzZYUjEveURPRGVH?=
 =?utf-8?B?YTlSLzBVQXFETkxjYTA4WUYzWkJ2cUJybm0wandOSGFjbGxRNjEvNTNDVjRE?=
 =?utf-8?B?bllkc1JYK1BRU1NmWXBuU0VlN1FKeVg3NXlnTnlsdnMxYWxoZjVscGZlR2pa?=
 =?utf-8?B?VmZTV2k2ODdsYWZmWi82VXYyVlRVcG5IWHBjdDN5ZlpaWEdUUjN4alBpQm0r?=
 =?utf-8?B?bDlMS1BrWnNFbk13cVR5YlVkU3JoM0VBaEYvL2tNdGlMVnhHeVcyOXFiOTI2?=
 =?utf-8?B?YjNUNEpEa1MxYTRMOG5WZ3V3RWw4NnVQajVpazcrVm5aZWNiMWdHbmd6VGJJ?=
 =?utf-8?B?Ry9jNzhXc2ZKVHo2blROWk82UURNZmp3TitwUnFQU3FmMkMrd1hNdmUwVENn?=
 =?utf-8?B?SnRQSWlKV1RxT0dzTGUyRzhXN2s5dktlMDhJTDF6RVUvTG50aTFNOFR0RXR5?=
 =?utf-8?B?STRkTEJxMGVvTGhrZXZCUWttdTk3WTYwcmtjU3BiRkJxVUdrc3BpZnhTVmV1?=
 =?utf-8?B?YU1qd3M1MWtsbE1kbVBTbE1iekRpYnNES25HVzFVZituT3lCOHJwczF2a0NR?=
 =?utf-8?B?YURvZDJaK2tkSGdPU1BCOW4reGt3a3ZJNFpPYVA4c2dqNWx6UjFzMERBbDRS?=
 =?utf-8?B?R3FZdUNpeWpOZUZSV2VQdTMvYlNYY1NOUU5ZaUpOZk04Z1dyaDJrZDVyTGhB?=
 =?utf-8?B?YlNMd0JweldkR2tkd0ZsdDFmQ2M1OGRkcnZabGE1S2IrMFAyZ2oxZHBabXFO?=
 =?utf-8?B?bnlXQVRTaHgyVTVjWUlwRHJpVHl2bXU0TDVYT3RraTEySC92RnpVWGdkVlJN?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1421416-4875-46e8-264f-08db83f3d9d9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 22:52:35.9912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7BPOpa7oFugaRR88IX68xlMXzrAAHKLeHuaHU3jDVkbcPgcgqXGJM8rZzDc9oZJLGBC9DSK6EvvIAu+y0CFKNEyEm0QqR8FmA3E3eXAAd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4689
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
> Perf event fd (fd_lm) is not closed on some error paths.
> 
> Always close fd_lm in get_llc_perf() and add close into an error
> handling block in cat_val().
> 
> Fixes: 790bf585b0ee ("selftests/resctrl: Add Cache Allocation Technology (CAT) selftest")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/cache.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
> index 8a4fe8693be6..ced47b445d1e 100644
> --- a/tools/testing/selftests/resctrl/cache.c
> +++ b/tools/testing/selftests/resctrl/cache.c
> @@ -87,21 +87,20 @@ static int reset_enable_llc_perf(pid_t pid, int cpu_no)
>  static int get_llc_perf(unsigned long *llc_perf_miss)
>  {
>  	__u64 total_misses;
> +	int ret;
>  
>  	/* Stop counters after one span to get miss rate */
>  
>  	ioctl(fd_lm, PERF_EVENT_IOC_DISABLE, 0);
>  
> -	if (read(fd_lm, &rf_cqm, sizeof(struct read_format)) == -1) {
> +	ret = read(fd_lm, &rf_cqm, sizeof(struct read_format));
> +	close(fd_lm);
> +	if (ret == -1) {
>  		perror("Could not get llc misses through perf");
> -
>  		return -1;
>  	}
>  
>  	total_misses = rf_cqm.values[0].value;
> -
> -	close(fd_lm);
> -
>  	*llc_perf_miss = total_misses;
>  
>  	return 0;
> @@ -253,6 +252,7 @@ int cat_val(struct resctrl_val_param *param)
>  					 memflush, operation, resctrl_val)) {
>  				fprintf(stderr, "Error-running fill buffer\n");
>  				ret = -1;
> +				close(fd_lm);
>  				break;
>  			}
>  

Instead of fixing these existing patterns I think it would make the code
easier to understand and maintain if it is made symmetrical.
Having the perf event fd opened in one place but its close()
scattered elsewhere has the potential for confusion and making later
mistakes easy to miss.

What if perf event fd is closed in a new "disable_llc_perf()" that
is matched with "reset_enable_llc_perf()" and called
from cat_val()?

I think this raises another issue with the test trickery where
measure_cache_vals() has some assumptions about state based on the
test name.

Reinette
