Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCEC7DF92C
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 18:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbjKBRtx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 13:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbjKBRtw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 13:49:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1BB1A4;
        Thu,  2 Nov 2023 10:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698947377; x=1730483377;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JJIHGNodwk5uhYavh1SaLxeRr5MCoS4CFZsvvLgZPfI=;
  b=AAfgFlVtmwNyjJc73Ee0/j0kWkrV0eL77HDOW18BBzKrOrZsJ0jugRop
   oZW1GroaZn88fHBBxL+AU5af9sFwDomaROHqei5/QwHhLNtBa5x9UBcXb
   iIIEmyH1LKHTIo9q3vmeHMK/5N9ANUVF2vDPTEeGQ5a7wO34CEj2cj/Yu
   d4EORkto0d5K5w+rG4NP/XCvBc6JLJQ4nwDcvZ9Bu5qTXRrPimrxZd0OA
   vsU0CJDAWquq88vUEmTx2T7n/h7oQbA1QPO/UjIMrrZYMkGsGwh6Lb+Co
   G+f5f5qUwoT809Au9jVrmvrjGol5QNT/lXaBwNsBPjLWpBFfJ/1lpgHis
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1650337"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="1650337"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 10:49:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="878337302"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="878337302"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 10:49:36 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 10:49:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 10:49:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 10:49:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 10:49:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQQAx8D1XuBMW9X+oBr4Xu6zbokrLPUYNHOsjSpNFYzo9WuHKd/7wMGGvVRe3MI3P3c5esRApUlpbAVZAYneFrRwzzBXfYdyVKrUzwgRIwg0bF/qt8/fTxixFunISydb6t+KW1c5sUwuIUFZCMC6pansZffC4UXU48ze8WOfgsEvekDPercjnOLgBY+MNjXYN3EG9cf9fcB0pQCsMWxXaz8lcvkMckpvZ73u3NryVyq/mdhflHMB2qjZeDaPoMHzABKiodgf3I4tYdCM7TkGsoNmpRu/vYD4BONjfl7M50E7SbShY4hNzmzvEcaiihq413YkvbmYEelwakCAY+At6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGuquBCWMPXaKfCVj9EW+uyk1OMN4v9QQPLSCzAoM9s=;
 b=JPfAIPgREqcdZRG9GT1qLfn4xHQ3W/0g0b4CZx54JIQDBum0yCyfF9347dz7BAygyabS7oX87NLq8Pm4xdHuUUTFbxYmXSUQQ6zGkcrTsa5EIFay67t6vNuHj+RQSk+0q7NMVW+CDFU7pGhfnMHoUjQx2ObFTBFzB0fHjxgL6OBvU8D1xOkfEm+llFjKRwpQz7X0lnJPGE4Mx51dwoqaSJtcDardd/PeOMrGBrIQZIhegVRhtDc4m4yPzsrell4cMbftT9K7VKpBO+eG6+dy56TMRGpko4eeI1Cs830DzR4kOBkcBf+5DIiyPoVJash7UtvHE4rbRrVHZn5Ki037Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB7250.namprd11.prod.outlook.com (2603:10b6:610:149::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 17:49:28 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 17:49:28 +0000
Message-ID: <93113f94-9663-4cbb-962f-c415bc975f12@intel.com>
Date:   Thu, 2 Nov 2023 10:49:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] selftests/resctrl: Remove nested calls in perf
 event handling
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-11-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231024092634.7122-11-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0314.namprd04.prod.outlook.com
 (2603:10b6:303:82::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 129f7573-5bcc-4c44-6a8a-08dbdbcc0f30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aK+XcwOQs6RhiFz2xMcJ/sWDJ7x13keAswWPWiXVnvueX9A0SbhyRTAVdL9CNJ6FyaRnGhFR3i+vzVIuYmRzZ+IEOGVhK/emkzvKCqgotmH1NRMiorTOwlE1MYjr1kqLt5tWjmAqz18z9zI4q1KlBg8Qgt1smqBzTmWsglRmN0S0kEi4P/ApKy8myRBwQHjiNNHc/+9r+zorjU1Uv0F6G4/a2LC4KZ/dfr1s2sHOdMY1g0QMF4uid0X/41cZP+QVGyNMYuAI560Vbc2i8iy/oCJKBUZd9FLzK0r3GOEhNrocPI/Hlrq7rTr976TfwjJ98GVArtuwsICKE1mjjsVAWhgSFJw/wqVs8Jd14sAZvVW51nVLyYn8qteMlw3c6F12R7TfuSy8rcmvTe0/0H7ePhpIWrk8OC6N/hOUuUP/7R5VQNOYvj+Dr9pxe+Aguz094RsBnmrVcEAFzToV+miMNITuKM7ltD8grFvwZHiPQOnD6IGTomkTSspF6VX7CatHpFQ53mWW4/gUTMzTBi8pTeOfe7v2YvvF/V6iZAxhl56BRCMQCBu4uVyoRgQah61z2Zw5Mb3VNsmTlHSEjCnV/qQIb2rTDuDGYlMyG9uvNj8DjFkos0zY+e6hU+5p0AX4j5LUYNUbt0wEoNkZ9S6WxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(346002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6512007)(2616005)(66574015)(82960400001)(26005)(6486002)(44832011)(8676002)(36756003)(4326008)(5660300002)(8936002)(31696002)(2906002)(86362001)(41300700001)(66946007)(66556008)(6636002)(66476007)(316002)(110136005)(53546011)(6506007)(478600001)(38100700002)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnIyckdpaTA0cW1XTnJ3MUU2QlhSMzhlWCtzYWNKaWhmYzE1MVRWM2psYjVT?=
 =?utf-8?B?WVFqT2pOcjFtOWNUdVl6U2JUaW0zanN6dUYreXNhcmswVXlFeUFocFBNL0Mw?=
 =?utf-8?B?d1gveFRYaUV1Y0s4cEZpWm81dXVpd21DdklKYW1LZWlhSkRTRU9YT0tXZnBR?=
 =?utf-8?B?YlUwTEUwSGZpNTdKdHJYWlpROG40VmwyT2NGcy9BOXZaRlhTRGdKUkNGcEpi?=
 =?utf-8?B?Z00xUlM2WnFlWnBxZHo3bHY5ek1LbjZ4TjU3OEV1bmdPZDNreEFFQ0RUeExl?=
 =?utf-8?B?OFp0TmlVaHZ3dm1BTjFPMFE5R2U5NFF0WXVpcVlVZ0pVRnNqQVdhS005dEhz?=
 =?utf-8?B?OXBCQkNhYjVWWGpqZUJ5cTFFWU9HcjR6UEhHRFNZVW9QUDNYSzEyc1psNXZW?=
 =?utf-8?B?R1hPemZKWWg0UVNLV3pvUDdWRWE3WnBhWVFEeFBjZU9Wd05Xc0V0bXhVM0ZF?=
 =?utf-8?B?ZmNOakVnUk5aYkVWbVR1L1dBaWdxdnRYWlRzM0FFRlV5U0Y1cE1Nd215OHZU?=
 =?utf-8?B?TFJ1YzI2MC9tcHZtbTV4SmZvN3lUQjYvemo2WmxjSDRmYXBqRy9YcUhrTzhO?=
 =?utf-8?B?RkFxSVM1bnJpT2tFOHdxUVVSaWlzcXIvNnZDUnVYZFRrSGZNVVZLUW9FdGNK?=
 =?utf-8?B?N3NxNHg2eGhxOGp5MTlqMkFCQi9RU0M3ZDJ2WEJ0L1YvckFVRGovNmN5aFpS?=
 =?utf-8?B?WXo5eCtFMmo4cjFxd21LZE5tZlhrQ21xTndCM2FsUVdncFNXcS9HWllnRmps?=
 =?utf-8?B?dTVUeUttZE8wN21LTllJUGROWVVxWWFWNWozRmt6TnNTcExjOEJkSFhUWEpT?=
 =?utf-8?B?aUt1N3EzSmZ3aEdEVElodk5DVGltUU5CcENrL2Y5UE1DQmdvL3cyNE41TEs2?=
 =?utf-8?B?dHJUcnRxQysyMnd1OU9NME1HSEIwMStxMGN3Nnk5c01vOXRCNmJSbzBwa3Na?=
 =?utf-8?B?R1ltVmRKQ2VBVkYyNmlkVHpwOExVVTM3L0RWV29sN1ZSRUdCdENmbWJpcFVh?=
 =?utf-8?B?cW1DdXUvYmt3MlVPQ2xoNkxTanBpd0taTVdWWjlqNElQK0JUZ2pzWW5rMTZP?=
 =?utf-8?B?Y1g0eVVsMlNzR0dUWXJtTi9RWnl3V0w2VEN1MFdTK3Fhb0tScFcxckhYSnFr?=
 =?utf-8?B?UXhBQit6WTN0UVVpQWVNNFF1WGlYaHZnUmtvVUVaZnhiV2VMZmlUYmhMS2NP?=
 =?utf-8?B?ekFZanFwbFdXNTUyaXM1a0FCOC9BblVWKytDbnJ4V3FWbHYxUldoNVdyczdM?=
 =?utf-8?B?Wjg0U3VoaEp0eVFIMWM5ZElUdnRwSU1jWjhZZ3pIL3pHSGhycnd0aVo5Mmk1?=
 =?utf-8?B?YWhSMmcvTm5EZC9qV2RqWE1MVVN6UUJ1VkdaS3NzNEc0S3lNWmdidExpS1pu?=
 =?utf-8?B?U2QvamkvRGZzbmRiYWNOWlRNZ2x2UDd4bTJvb3dQT1hSdGVhOTdGSm9aU3Z1?=
 =?utf-8?B?ZUg4Y0JuL25QQkE1NWJsa25GSktXNmVXekR1UTE3aFJZeERyWjE1clV4Ty90?=
 =?utf-8?B?K2N1WE45UDRaWXA0YUZ0ekNDVXZZdldITEdXOUV3MDJ4VDQ1RjBaNmFESWxF?=
 =?utf-8?B?RVd2c2s0dlkwb0NLVExaUmNzSkNtWElkR3QzYTIxaElkRXhlVlRhUGR6Kzdm?=
 =?utf-8?B?VU1NdlUxcXBqc0FRTElQVXV1bUhHUzJyKzhCMjNjWWRTSzdrWlVZZ1B5ZmZY?=
 =?utf-8?B?blovZEhOc28yNnY1NlIraUw2K05ySG1HQmV1SzZpaVdsVy9vWG1FM2Q5c3VT?=
 =?utf-8?B?bXRVRnlVV0xYei8xUFUxQ3c2OHZTdEJpL0Y0U05DZHRmZ2Vhd3Ixc2s3MHlw?=
 =?utf-8?B?RW5RZ3dqci9rUzRHazhoUFFkckxpN3BkSHVsSEEzWDl6emJHa0VQV25CTXRU?=
 =?utf-8?B?cnRXSlh6eHo3MWt0bDc0SU1MSDJRSW90S0lMMjRTdVJhNmZ6Sll4WEtSWHk1?=
 =?utf-8?B?K1FnTUZOTHFFZ3NyQThCRG01RVQ4R2FlUU0reCtLWkdYQ244VDREYjRHNDBm?=
 =?utf-8?B?RVVrOGZGVjJXWnpqS3NVdXRlN016bjRKOGJ3WGU0NkRjWEF1T1hoeWVQUDFM?=
 =?utf-8?B?Y0gvSXZITFpVYlRHNmFkYi9EdHBMalFscTFMV25nYzhRS2pqVW5MUnNiUWlS?=
 =?utf-8?B?N1h5RE1IVnVmcG1aUTFKeU1oV3dNWHBQRmhvV3EyVUJUSVZhNUNWNVBRbWtn?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 129f7573-5bcc-4c44-6a8a-08dbdbcc0f30
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 17:49:27.9170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BX6gpBVMhQvh2OLnO+WpIMIeMBupuAWNiJJA39rTR2GcMm6xyGZ9yaBrNil6QqZeCrHjiUADy7DV0aj4CSGBWZRwmH/iZiG7CTVjqAisN1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7250
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:
> Perf event handling has functions that are the sole caller of another
> perf event handling related function:
>   - reset_enable_llc_perf() calls perf_event_open_llc_miss()
>   - reset_enable_llc_perf() calls ioctl_perf_event_ioc_reset_enable()
>   - measure_llc_perf() calls get_llc_perf()
> 
> Remove the extra layer of calls to make the code easier to follow by
> moving the code into the calling function.
> 
> In addition, converts print_results_cache() unsigned long parameter to
> __u64 that matches the type coming from perf.

Is this referring to work from previous patch?

> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/cache.c | 86 +++++++------------------
>  1 file changed, 25 insertions(+), 61 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
> index d39ef4eebc37..208af1ecae28 100644
> --- a/tools/testing/selftests/resctrl/cache.c
> +++ b/tools/testing/selftests/resctrl/cache.c
> @@ -29,25 +29,6 @@ static void initialize_perf_event_attr(void)
>  	pea_llc_miss.disabled = 1;
>  }
>  
> -static void ioctl_perf_event_ioc_reset_enable(void)
> -{
> -	ioctl(fd_lm, PERF_EVENT_IOC_RESET, 0);
> -	ioctl(fd_lm, PERF_EVENT_IOC_ENABLE, 0);
> -}
> -
> -static int perf_event_open_llc_miss(pid_t pid, int cpu_no)
> -{
> -	fd_lm = perf_event_open(&pea_llc_miss, pid, cpu_no, -1,
> -				PERF_FLAG_FD_CLOEXEC);
> -	if (fd_lm == -1) {
> -		perror("Error opening leader");
> -		ctrlc_handler(0, NULL, NULL);
> -		return -1;
> -	}
> -
> -	return 0;
> -}
> -
>  static void initialize_llc_perf(void)
>  {
>  	memset(&pea_llc_miss, 0, sizeof(struct perf_event_attr));
> @@ -63,42 +44,16 @@ static void initialize_llc_perf(void)
>  
>  static int reset_enable_llc_perf(pid_t pid, int cpu_no)
>  {
> -	int ret = 0;
> -
> -	ret = perf_event_open_llc_miss(pid, cpu_no);
> -	if (ret < 0)
> -		return ret;
> -
> -	/* Start counters to log values */
> -	ioctl_perf_event_ioc_reset_enable();
> -
> -	return 0;
> -}
> -
> -/*
> - * get_llc_perf:	llc cache miss through perf events
> - * @llc_perf_miss:	LLC miss counter that is filled on success
> - *
> - * Perf events like HW_CACHE_MISSES could be used to validate number of
> - * cache lines allocated.
> - *
> - * Return: =0 on success.  <0 on failure.
> - */
> -static int get_llc_perf(__u64 *llc_perf_miss)
> -{
> -	int ret;
> -
> -	/* Stop counters after one span to get miss rate */
> -
> -	ioctl(fd_lm, PERF_EVENT_IOC_DISABLE, 0);
> -
> -	ret = read(fd_lm, &rf_cqm, sizeof(struct read_format));
> -	if (ret == -1) {
> -		perror("Could not get llc misses through perf");
> +	fd_lm = perf_event_open(&pea_llc_miss, pid, cpu_no, -1, PERF_FLAG_FD_CLOEXEC);
> +	if (fd_lm == -1) {
> +		perror("Error opening leader");
> +		ctrlc_handler(0, NULL, NULL);

I understand you just copied the code here ... but it is not clear to me
why this particular error handling deserves a ctrlc_handler().

>  		return -1;
>  	}
>  
> -	*llc_perf_miss = rf_cqm.values[0].value;
> +	/* Start counters to log values */
> +	ioctl(fd_lm, PERF_EVENT_IOC_RESET, 0);
> +	ioctl(fd_lm, PERF_EVENT_IOC_ENABLE, 0);
>  
>  	return 0;
>  }
> @@ -166,20 +121,29 @@ static int print_results_cache(char *filename, int bm_pid, __u64 llc_value)
>  	return 0;
>  }
>  
> +/*
> + * measure_llc_perf:	measure perf events
> + * @bm_pid:	child pid that runs benchmark

I expected "bm_pid" to reflect a "benchmark pid" that
is not unique to the child. Are both parent and child
not running the benchmark?

Missing doc of a parameter here.

> + *
> + * Measure things like cache misses from perf events.

"things like cache misses" is vague. The function's name 
still contains "llc" which makes me think it is not quite
generic yet.



> + *
> + * Return: =0 on success.  <0 on failure.
> + */
>  static int measure_llc_perf(struct resctrl_val_param *param, int bm_pid)
>  {
> -	__u64 llc_perf_miss = 0;
>  	int ret;
>  
> -	/*
> -	 * Measure cache miss from perf.
> -	 */
> -	ret = get_llc_perf(&llc_perf_miss);
> -	if (ret < 0)
> -		return ret;
> +	/* Stop counters after one span to get miss rate */
> +	ioctl(fd_lm, PERF_EVENT_IOC_DISABLE, 0);
>  
> -	ret = print_results_cache(param->filename, bm_pid, llc_perf_miss);
> -	return ret;
> +	ret = read(fd_lm, &rf_cqm, sizeof(struct read_format));
> +	close(fd_lm);

I am not able to tell where this close() moved from.

> +	if (ret == -1) {
> +		perror("Could not get perf value");
> +		return -1;
> +	}
> +
> +	return print_results_cache(param->filename, bm_pid, rf_cqm.values[0].value);
>  }
>  
>  int measure_llc_resctrl(struct resctrl_val_param *param, int bm_pid)

Reinette
