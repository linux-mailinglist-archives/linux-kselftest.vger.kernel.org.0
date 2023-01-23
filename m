Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171F3678364
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jan 2023 18:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjAWRhY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 12:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjAWRhX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 12:37:23 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3B12FCF0;
        Mon, 23 Jan 2023 09:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674495424; x=1706031424;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AX7mEcdujf3FhT7M9XIcs4JeNlE3pdw2F/bZ9KkQ4ZA=;
  b=dA8NrJ+jX1tPLcf+GX++vNTyd9S9P8IorSQGtMQb/CY1JkI09tCNdNpp
   MwkfWg63ecCG55DCToNbyCPtg3BCgpIMwEvb8PT+1uzy5qx5v5N+24bQV
   8AL7qDnnx+JxTz+zzD/XOIvRs8Ayt2Ve9Iy1vXuAWF8f2iFmkxuBoQC81
   6gAj+zWgiE41oCEZH5Mt/mttYZoEI/vRPerAbFFFdCIzG3bnJHz3336mX
   vdrV4HmjqUvy0WBUvQq2Le2vBAchiDpwvwlRcYzTzQ8EN0G8b+nlA6IqA
   guTCQGeq9bKB4KBVnEEStVyR3L/FJ9FJL6Ul8mlwlVOT7EfMLcSNVUZh9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="326135613"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="326135613"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 09:36:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="663751185"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="663751185"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jan 2023 09:36:19 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 09:36:19 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 23 Jan 2023 09:36:19 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 23 Jan 2023 09:36:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bl9uWmSVHtXgY3xX2rkNdrkmCAQSfH+gQEvbpJDQjq2cuP/Pn1zE/+n4NWbnfSd3KZfXQikU2cqjJHC45ADb4evWjRFkfB/6ylB+ghdoava+G2w9fHfUrg27EBs77+Ia0/1jG2cnW3AP14txIvmyFtNVByHTVFcbdsVE7WrKxjcaIKbeOXoiLmjsOArciw4c79daESqkcLgZyzwLOxjVCViq7CVxUF+/WyqDGQeOAvNYP8Kz3j4WciZL1dGaHZH4/1LAm0hWWAxhvMNt28gDOluvOgsQ8kSSB63uI2g6J8TJBqWdjvKhuM6I4LyEOZXhIawlK3nUl4Mo705rZcsmNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SFU+2HmCXLWfHbloFqxZuCGRGVfYnkMtX1EiHtz5aw=;
 b=lEgzkZ305cGSMQAkotPdlvagfIlg4NKAoHTyPSbfi29nYYPUwe9Pl7YgV/n82DjNBCzNbekGQjUKPahvJN2TPJNI+CZUQ4z/+jNLnNdddFlzhufUihdAqiibp3s4Ca23hfN6GUq3bQUQux3+hPWwlyoZAC8h7DeFop/gVNYdVmOgVEfM3cwkJI1KpfMcmkKCm6h8dCfaZL6goWp8OAEictZ3aYwHsey6SECqkOU/ch/n1k839NEPPFzn+KLE7qPxVn4TlJ0mz2EchIsHUMr8BY3GU68AaK6mn3EcLfVqa/Zy8j6Srs8+djCj9Kmi+rX8wvgyDUbjS4L3+T+c/rU8CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH0PR11MB4773.namprd11.prod.outlook.com (2603:10b6:510:33::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 17:36:16 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 17:36:16 +0000
Message-ID: <25ca1de3-5673-6332-a1d5-59920c191739@intel.com>
Date:   Mon, 23 Jan 2023 09:36:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v5 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20230111075802.3556803-1-tan.shaopeng@jp.fujitsu.com>
 <20230111075802.3556803-5-tan.shaopeng@jp.fujitsu.com>
 <3201c461-2f46-f354-6019-94ce8978fb46@intel.com>
 <TYAPR01MB6330B2248A693BD3170CC76B8BC89@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <TYAPR01MB6330B2248A693BD3170CC76B8BC89@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::42) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH0PR11MB4773:EE_
X-MS-Office365-Filtering-Correlation-Id: d00d0198-fb81-48bb-2ec0-08dafd6854ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Aoo3xf+FcbM9lvllXSGlo6ACsc2gfzAC/ereZOVrLYaMnLc6J8SulEPfa2V4cm7j+vQkxxDW+aoQwonHsueZ/m7wZs+XHIKCh85HWpjhTc7rAGn/xi7mlSEob3wTsBDG6ehFJtzYW4mEl458Yi8pxlBQoIEScxb9FH24swM+voiCh3qAH3niPI9kfKW4VmntVluTkzyIqCPB6j6k6hfbmB+7qU95anClM6GzR563xtrTb9QUd1iirr0fonkiuz2vTOOQg57hDBk7JoBTifWRR7TbZkJ/s0Yuz9f3nhE/wN9GNoeW2zHOM/7DBHbQipOGRZf25lKp1a+/KV9QwXQdvka6OJc+o3nDflEM/ozKBey/g7iUuSSm/UskXF24WFQSFjTw8so9reEGwtkqrXrQ5SXN3sOrulzw0wGjqkIIo1AwPX/Aly4iVErmSf+FiFi1WcNmOF4GFyQSm2UflHBUeG8bm9yhS67BaqVGQR50gPPHg3BpuJI4qpB42d+ZLLWB+gkFbyyaQ4Tn42bw+VA0THsiIQ0YjQVjrH86i18t1q3VGqSTvoPvgQ75G6gaOBJiOGJqPwXG2GWOuZRVTWHzMiwKNJv8e5tfBGXXgxLoScq1DrcigakBKb+WxD3EzcikNUFAvo/flFgqdjcKyMjTGPYV0AX8SQoeJnLeta+as/z+qz4bns7rjiPm63a9xTOCSZwau3jtSiwQ49qwShV7KclhTOvIZIMqj7aIGVVbsQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(38100700002)(82960400001)(36756003)(31696002)(86362001)(6666004)(110136005)(54906003)(186003)(26005)(83380400001)(6506007)(4326008)(8676002)(316002)(66556008)(66476007)(66946007)(6486002)(478600001)(6512007)(2616005)(31686004)(2906002)(44832011)(5660300002)(41300700001)(53546011)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVpoRHNNMjduMnBDSGZTYk84U09IZHZ1MVJIZUN1anRhVmt0Y29iekY0Y0dW?=
 =?utf-8?B?UWFZRXQ1d1NhWFZhN2dtOWxGTWlVOXFYQzAwYjRhRzNVNzBkRUpXanpjVHVp?=
 =?utf-8?B?UElRS0syRWxaVnN4VXFYb081UzFSYmo5RTFLUThWMThGMUpyVVFzUEh6U243?=
 =?utf-8?B?eFMzRE82dkZGVFNXSDNreStDckFvSTBZV1lvY3prMUFxdGFGRllNVHZOb2Zm?=
 =?utf-8?B?Y01xb0FTaHdaMHkzVERsUHNJcHJFK1h1M2cvazJxR1VWWUVkUGxNbElkZGlX?=
 =?utf-8?B?NVNnVjdscnpJSGdKTEZoRzV1YmJQbTBQTFBNazllR3Rra25Qc3R3cDRKRkUy?=
 =?utf-8?B?dFhRazVZZ1JQQVltNk9KVGdLN09HMXA3RThWbURaZWlwQWZpQ1F2Smx5UEFw?=
 =?utf-8?B?c042TzhuZjNsUXhLOFR4VWJITi9DTmd4TFdBemIxQ1NRK3R5M0pEK0hVSEtK?=
 =?utf-8?B?bXdWOVJFMmVZR2JHbDVvZWQ2Z2s4cGhmK3RkSzZMTlhXUFg5Z3l6Uko1bWY3?=
 =?utf-8?B?TzZDYjEwTExnaHZpK2Y3WFhXQXdTQ2NnMGpzTVFFdWdQQ3FVMlJYOXVCSHpq?=
 =?utf-8?B?QUJlOFFlR0NOR0dUdGtlUURHay9GaHYxbDdxS3BLV2ZzRE4yTWJLUWgzcy9u?=
 =?utf-8?B?cWYrdjNmeXBGRWJ1VHZCbHdNK0Rmak40NlRQUkxIczlNZkh3c3JyVW01WFE2?=
 =?utf-8?B?YUQwVEVJeGtQSXRqdlRvN3pINzJGWitkdWN0WjJuUk5nbS9iQUhBdTF3b2dC?=
 =?utf-8?B?dGJnQUdCdGpnWkFnNlRVcjdteFFZaU4wVVpjaFIxZXBYay9POFBhTitiVjdi?=
 =?utf-8?B?cVRiaGx0eE9sZHkvdEwxTm9iUE4vS3JZUlRTY2hsZWhYSVVMU05ISGFVS2Fp?=
 =?utf-8?B?OWV6WHY3SnlUYlJUQUFXNTJZZXI2ZDdXek1SRGJrU2g1U0RWZUFvSDdWaHli?=
 =?utf-8?B?QVZIWjRpZzdPMkpVdlAzSm1Ta1VBTDJrZ0t2SUZ6dHNMeXZjRnY4NjlCbmRj?=
 =?utf-8?B?Mko5R3IvTklPaFE2VWtobEJVUklnbzJCSTdnZHd6SWVzVHZ6c2lDMndrenZ5?=
 =?utf-8?B?WEV6eE1NWmdEc2tjYXQ3NEdGWlBxMHV6WVpPVmhmYW5UKzJFOUE0SGl4OVhB?=
 =?utf-8?B?cVQvbDZFNXdKVEZkMG9Dc2k5blNxUFBiSmdJK0RDZWEzUm9lMERJRXB4OHBk?=
 =?utf-8?B?ZGxlWUp6b01tK056VnhJNVB1bUIyUThzUElINGZKcTdxSG1HVFZlVVJIQXRp?=
 =?utf-8?B?WlpXdnA2aTZtYkZ6S3JycG1xR0V0Z0xmUUtXdk90WlZEbGUrVFdiaUQrRzFW?=
 =?utf-8?B?OHZodzBFRDRtRTM4UEFEZS96dC9RYk81ZVZqZEF2Q3JaeHgvTjBMYWYxdHBG?=
 =?utf-8?B?NkFweG1GOHNvc2ZqaTVMTmd6Q1pISnlmdkJXOVVQaHk5VmxEck9MdU1hY3RW?=
 =?utf-8?B?VlJkbkViTnYrR2lReEQzZ1hCWGMxM1J0L2hLU0xkM3o2TXlBL0lHRHdJVGRz?=
 =?utf-8?B?VDF5OGwrK090TWxwOVpyNzBVNGhaKzdKQndZSHd3RERHczYzSEN6VHp6Mmpm?=
 =?utf-8?B?SVIwN1R5MnFsbGRrbTArYkd4dDBvL2FSelZzejgwNDMrdm1OM245V2h2bTlS?=
 =?utf-8?B?YkNhVWxhTENMVmVjQmVnSjNwTzE2RC9GN3lsWnFtZzlETzRsZUlEUGFQQlV1?=
 =?utf-8?B?K0VBWEk0SFUxQkhRYkpRYVpkMW5uMHVvRGN0bk4yUUFuSGtlTm9sc3BXTUtl?=
 =?utf-8?B?L1l2OUl5U0lkeHRjbDM0a3k4SWtENVpJMFhhdGt3U3NMUjlGa2pJNTdnZ3ZJ?=
 =?utf-8?B?aEo0eThxWTJ1NGUrMmVxQ0lCQUZ5TlpGTlNCcFN5VHdNNnJDU2oxM1d1TXRZ?=
 =?utf-8?B?WTVRWXZOSVFCczJCUDdLbHp4SWFLeDZuSTU0bHFpVjM0QXNqU0piVUY1a3Ir?=
 =?utf-8?B?VDRTL0JFTWNkNDlVYmpwWERVNXNHUnVkanVLb1ZxcjdkUm05TndXMHQvQVFN?=
 =?utf-8?B?aG5iL0xtQ3pKSzZkMDZqU29zK20rQmYwRUZYRkxobEE5MS96OTRNOHB1Vmow?=
 =?utf-8?B?QnBOZC9iWnN4THp4MDZ0eWxTS285aG1FMWZLejM1R3JMRjJvTGpQdlVPQkNJ?=
 =?utf-8?B?R0JwVzVINVY3NUJRb2xseDVuUmh0ZDZjZ1pQMlRJeTdkQW9qbDd2V0pjVWhZ?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d00d0198-fb81-48bb-2ec0-08dafd6854ab
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 17:36:16.7464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFoW5NwfBq/+JurDtRnMJGWL9ZlweNKvlnEGvlnNAUjy9aR4pQ2u3qWj2Mb7ThsEhWv7ICTQzXM98MKBRCv+31f6VG2TEg2U1U2kYfRvlfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4773
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng,

On 1/22/2023 8:22 PM, Shaopeng Tan (Fujitsu) wrote:
>> On 1/10/2023 11:58 PM, Shaopeng Tan wrote:

...

>>> diff --git a/tools/testing/selftests/resctrl/cat_test.c
>>> b/tools/testing/selftests/resctrl/cat_test.c
>>> index 6a8306b0a109..87302b882929 100644
>>> --- a/tools/testing/selftests/resctrl/cat_test.c
>>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>>> @@ -103,7 +103,6 @@ int cat_perf_miss_val(int cpu_no, int n, char
>> *cache_type)
>>>  	unsigned long l_mask, l_mask_1;
>>>  	int ret, pipefd[2], sibling_cpu_no;
>>>  	char pipe_message;
>>> -	pid_t bm_pid;
>>>
>>>  	cache_size = 0;
>>>
>>> @@ -181,28 +180,29 @@ int cat_perf_miss_val(int cpu_no, int n, char
>> *cache_type)
>>>  		strcpy(param.filename, RESULT_FILE_NAME1);
>>>  		param.num_of_runs = 0;
>>>  		param.cpu_no = sibling_cpu_no;
>>> +	} else {
>>> +		ret = signal_handler_register();
>>> +		if (ret)
>>> +			goto out;
>>
>> The "goto" will unregister the signal handler. Is that necessary if the registration
>> failed?
>>
>> Also, if signal_handler_register() fails then the child will keep running and run
>> its test ... would child not then run forever?
> 
> A signal handler is needed here, but it is rarely used.
> Also, the registration rarely fails.
> Therefore, if registration failed, 
> just print a warning/info message as follow.
> how about this idea?
> 
> ksft_print_msg("Failed to register signal handler, signals SIGINT/SIGTERM/SIGHUP will not be handled as expected");
> 

I do not think this is necessary considering that signal_handler_register()
already prints an error on failure. 

Adding an error message does not address the two issues I raised.

Reinette

