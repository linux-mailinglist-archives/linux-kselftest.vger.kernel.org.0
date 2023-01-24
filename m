Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89DD67A000
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 18:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbjAXRTr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 12:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbjAXRTq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 12:19:46 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496514AA65;
        Tue, 24 Jan 2023 09:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674580785; x=1706116785;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IiamjGptsB29ciLhgQg2Vo1nDpMgGtiAAjg+zKoS6Qc=;
  b=Ovkdb/AM9PW+rGmFutqexchkAWQ6fk6JP9NFmCBrldBxToTUbChjm0mQ
   sAVO/LSK+CZ3j1uWlagaDieltJgOWvRPwiJdHsmu7VodSSkWUfDRv+Hbs
   hG8X2j0ox1Tn4LQOk6q8fK0N3mf3QnEMky1ArqQkcvEEiU69hvG6fTdy0
   Xsggc6t8J0Snfn3UW2V1/AaAcCwP+wdFz4YaO5cjVrYDddDLG+IrCQKUH
   2VM1P1fAFd8LglkW2bQEbmO9WDCIXZnN1UCUlpYiWkak/Z8bxq2hUlbBH
   fzs7WYTDF1L/m8zYQ9AJjbA+UIdIRUPX9aSwfZjsJ+oCDxsSAixgoOMmP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="328436635"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="328436635"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 09:19:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="804678887"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="804678887"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jan 2023 09:19:41 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 09:19:40 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 24 Jan 2023 09:19:40 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 24 Jan 2023 09:19:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7mcs67MyeYu9OzwNcboryAM3tfMBdPDs65QShE2TUr7qtI1SYdaUj3ujGYhL9L/xd+za27FrQfC4c/bNegN0FMLYaDaqQOV0FGHnDTqs5adsTGjnrd+KZQaBy6elqpv+UTfxFyGP3yVoIrQkPeU2JDZKhVYhRN6eLpyhcdLDZfm0CfccTzryqzOvgk7CJ14nedvQBQV/jl/8ueZ4/owtBfJf7DMwaamlTlkBB+wXxhmg51qV6Zwr9V1Tow5cX4GNKadEOJtaILfrT+W0u0ob6zbtqFUBPejJBC8RwOY4EcAezm4X+ayfciyvDZnURXLB6cLFcIshS4fmOhAkRfMtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1f9AWWFDRhA4wmTgccuygZrCsy53fY14uJ5L+kpgP3M=;
 b=PyjF4m94W9yK9NPjcvWtzxmEZxp3Fry/wXclsLAe1mucrO4JrTOx0314iZGdiiPZany7DEMevBjwy7GWHycBVlLyhHHbOjilFlHgRuP70yQVv4bOFNXgMhv5XQHZTwXvtCb5n7maUPX3TBGFxH1ReTtXHs+dm3kqjomWXTxvZObQ2tJQVE+x2+08bkBvLRZkrg6El+onBrfzaqvFbA9K932NOeyarMFMZlfBhwp7bcZ/2WfbeX2xr5GcIPuOhgET2qfd6LOiAIYVKtpBgT239Yzfy/GybWQ17+e6JtLwnJDof3r8enTcH0iPHSiN3qxywXR9zll3+Ur+6C41DxnqzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH0PR11MB4870.namprd11.prod.outlook.com (2603:10b6:510:34::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 17:19:38 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 17:19:38 +0000
Message-ID: <d1e0c7b7-4555-1afb-b33a-4390857395c6@intel.com>
Date:   Tue, 24 Jan 2023 09:19:35 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v5 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Content-Language: en-US
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20230111075802.3556803-1-tan.shaopeng@jp.fujitsu.com>
 <20230111075802.3556803-5-tan.shaopeng@jp.fujitsu.com>
 <3201c461-2f46-f354-6019-94ce8978fb46@intel.com>
 <TYAPR01MB6330B2248A693BD3170CC76B8BC89@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <25ca1de3-5673-6332-a1d5-59920c191739@intel.com>
 <TYAPR01MB6330317EADA62C45EAD8B0608BC99@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <TYAPR01MB6330317EADA62C45EAD8B0608BC99@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0057.namprd02.prod.outlook.com
 (2603:10b6:a03:54::34) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH0PR11MB4870:EE_
X-MS-Office365-Filtering-Correlation-Id: 9acdd34e-f1e2-43c8-9e18-08dafe2f2bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nMwYcpQn+qd3IZQNJB66iIIfjRs6/qROgHzfs5Bp9IGoSPLjU2DWbyi1IjMMTsgUlmtl5Si5AJGmsslqYiKkci/VQF5elSMbj42l0dE39AfESU8ZVG0IN2cne6/2B5EGqHJtJaPGThnzMMNEE1pyIkk44isf5uvJWa7Isd6B/jhzm2E0gCav0Gj0TzWqTZUNwEF1FHNLHDtkJ4EAYiuXv2RwzUqK2tgZwRJHXmOKNpvwYYMJYwNA9O8bue3nsoZlDQnyHnLfpfd96P9nB6i1wmQ6rlT5gAQHPMvHuq+HSWQz19GnIgBhyTLLOL2p2yo0fDQHrTmeN2nfyebZkv4tQ5f5uXmfIjQPwr0Uj2wLpw1+LU/W4D2QIoC4vPZhoKrdNRxGzgKEUzfSRR+1m+oQpJFmqbTXLuzCyapL5ar8n/HAbYjkCR4gAB7dEo8K11/NYT9LWHFeg7V/wT8rK7vKDnM5Wpxn2ZrtVUiOmhHMQ5JIswd6RsBDeTBfPtOujDYbQsAFN3II1hI+Z8miThnJ3F4ZoRDBYBjouVZCAXDnEDrYoXRv6WpZUKm0g8TJXphLxwOU1KzDy6Odf+ONdKm4tZwMjMCCmuTFWDvImXsDFPSjHy/VtAeGzY2vArzOmkS3aEmtK9kLjNAIpmbUl0jyHnYwLrqcTCe+7SP1PF0vZi8GVzGvi5LjAznlH1shVguPbVyJBPfju8hd/eUp7SmXkU6eU15acq6n+nes0eDyifI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199015)(38100700002)(82960400001)(36756003)(31696002)(86362001)(110136005)(316002)(478600001)(54906003)(83380400001)(66476007)(6486002)(66946007)(4326008)(66556008)(8676002)(2616005)(31686004)(2906002)(44832011)(26005)(6506007)(53546011)(6666004)(6512007)(5660300002)(186003)(8936002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkliRUhGVzJ4SFFaY25zRjk2WHhiZjd6L2hyeWh0cytPYkdKZFBJMlcwV1RM?=
 =?utf-8?B?eHhuelBjZjJIcmFSdVlmVW9SVXcwNkxkeWIveG1qVjVwQkI0ZXZYQlpMdndU?=
 =?utf-8?B?enlLQm5YSUtuV3lUMS9GOEtKdGNWTW5QUDM3NVNsUENtUTYyRU41cG1oajBQ?=
 =?utf-8?B?L2UwcCtoT2tmN3dZNWNjNDBYUExhbHFueUtaZW0xMFBhQVFORFpROE4wTG84?=
 =?utf-8?B?TzU0VjIycXRpcitSK21lTHlsbUFrcDBvVUt6VnN5KzVDdXVMczUvMmh6R2tZ?=
 =?utf-8?B?ODRMYTNkNjNIZG9YYjdYR2REbFpaVTdiTk1tNHRpc3lGa21TS081ZURHTmtF?=
 =?utf-8?B?ckZETXh6MGgvdURsSFc0V2lIOC95bDk3QnRaSU5CbVd5YjVCejVxMW54dm9l?=
 =?utf-8?B?aitheHlsRGtqY1gvOTBnM3BaUmsrS3FxaHFFcng4VlFIamQyTXZMTFdpVURZ?=
 =?utf-8?B?OVhNWVBNRWpEK2UyVVlzZ2VsRTJKUHRKK0Z0dGxQOTFKMEpGbkphZWM5di9P?=
 =?utf-8?B?Z2p5c1EzSU01azJUbjloMGg1UFc1Y012SG5nUDFZWlNYVzhJVWpGRXF3TU1a?=
 =?utf-8?B?UWZmcldBR0tVQVhUaUo5YjRmY2dLVlZxeU41UlhOME1BV0F5dUhBZUR1NU5w?=
 =?utf-8?B?RE40dmx0T2k1SWliQmd0WHJxWWlqYVJKV1FFek5zbTJ2cGJFbk13aWUxNGFU?=
 =?utf-8?B?TjJDM1FRZmU3ZkZPM1ZVV05PQm5VSE5HenN6ZWx5QU03VlhreWI0S1VoY3k1?=
 =?utf-8?B?YkRwT0tqelpKTXZ3MVU4WHk0SEl6VDhjUW5QUnJBeVV3a1VrZTBEWmVPcVZi?=
 =?utf-8?B?NlBiQzdKZzRnTlM4TTBmeWxvODJEOTMrQTNMMDBXZ2JrdXllbERGSW8xd1Nn?=
 =?utf-8?B?eDlmNTRyeXdCUVNVMzdoYXBsT0tiY3g4YUgxbERMYUpvZTN6b2Y2RGppWGdR?=
 =?utf-8?B?eWhOQVlkYy9iWWJiRHRtK0t4SGlpOTlaS2thZXkvY2xlTU56ekh6czQ5S1hJ?=
 =?utf-8?B?bUFIUVByZVEyY0pZZnNaRjlVNElVVCtsNUZPYmx6N1NBRUUxb0llNnF6T1Qr?=
 =?utf-8?B?SXRYVU4ydTFuNWtQTEhTRS9LaitidGIxKzYreHlJSzB5L3BYWU9SSzZVU1E3?=
 =?utf-8?B?NDNFa3l6U0RsaFdhb2ZmeVBBenNuQ1NPdjRaeXpHbllUeEQ1cllvOFZ6YW1W?=
 =?utf-8?B?Z0dMV0xZOVRZMjZJQU9JK2NMUkM0bXlNNFZPQUROd1d0b3JFY1IxWTl5azl5?=
 =?utf-8?B?Rm1SakZWTmJISXpEUi82OXE2b3Y5VW9oa29mS25mVlpGclRxYTBLaWVndmRH?=
 =?utf-8?B?TFd2Vlp4YTdlOEZwWmhPNVZjYyttNWUxNUhlLzRUYjB4UWdLbzdQV0ZKeHNO?=
 =?utf-8?B?RERIRnRuamZJc0pJK0tOM05IaC9GWTVodjIvdCtqb0hydHo1aE00WmtMMzd6?=
 =?utf-8?B?MXovK1d2UmFtcHFYcUhuam1kWXRWUlJGRHVmbzliSnYzM3VQMFI1M3pENDdm?=
 =?utf-8?B?Sm1sNXRpR3VicEdUMGpTTThPRDJZNk9ZUkxBNW80NkQ1KzhxUDJUWk5ieEtu?=
 =?utf-8?B?b2tMQlc3K01BMzE1NDJGZThuYnIyMEsrZ0ZXTlpwU0dpS1gwZWYzaGJWYUkz?=
 =?utf-8?B?THZMckt2cUtudWU4RGNtcERaeUU3MWxtNnY4YWlyb1RMdlNMUjd0MzZHN09z?=
 =?utf-8?B?U0tvaHBkNEJoSWEyQXAvM1haRC83RFplWXRZY3V2VC9qVUhScnZBc3ZRN3pW?=
 =?utf-8?B?Qzl6dUE0R0NlakNuOGRUMEp2QkZjME55NlBWV1BSRjhUaHFtUUJLemJsamcr?=
 =?utf-8?B?aU9QeUN5TFovZE5xN0xGQTJqVFdvUUNJRUdIOXkvUytXcFdIODNSNWNkdnRt?=
 =?utf-8?B?dlBtRjhOYS9VZzdkYW1ieEJrYmNMRWJQcW1BVTBuVTRIYmdVN0xiY3BCKzdy?=
 =?utf-8?B?R2dRdnc0MWhaRjVvckxtWng0L0Q5OTdleXUwOVdGM1RBMUh2M3RwU1RNTTB1?=
 =?utf-8?B?bWZraWMxM0hDQ0ZibWs1V2htRWRjRUdGMU01STBzSHFJMVJKOFJoYkdRS0sw?=
 =?utf-8?B?VzBLVzRwSmtidlFrWUNiVXBKVkpUNElLcS9oelZGakFZRm40L3Y0a1pjNWtv?=
 =?utf-8?B?WnNtNEdqT2syRWk5ZGVkZEdaNSs2dEhaQldiQ2V1QWZMVThySG1qRldIT0hX?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9acdd34e-f1e2-43c8-9e18-08dafe2f2bbc
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 17:19:37.9389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 473bafsKft84BS+mFo6/zR1Lq+lTOqqhLk5xT+2cc2gDMGX/l05I2Q/FZiwvoLMGSbLo1mUO4YK0PRakamyZLq3VQ5gyTMkmgkpt3BKBOO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4870
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

On 1/23/2023 6:16 PM, Shaopeng Tan (Fujitsu) wrote:
>> On 1/22/2023 8:22 PM, Shaopeng Tan (Fujitsu) wrote:
>>>> On 1/10/2023 11:58 PM, Shaopeng Tan wrote:
>>>>> diff --git a/tools/testing/selftests/resctrl/cat_test.c
>>>>> b/tools/testing/selftests/resctrl/cat_test.c
>>>>> index 6a8306b0a109..87302b882929 100644
>>>>> --- a/tools/testing/selftests/resctrl/cat_test.c
>>>>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>>>>> @@ -103,7 +103,6 @@ int cat_perf_miss_val(int cpu_no, int n, char
>>>> *cache_type)
>>>>>  	unsigned long l_mask, l_mask_1;
>>>>>  	int ret, pipefd[2], sibling_cpu_no;
>>>>>  	char pipe_message;
>>>>> -	pid_t bm_pid;
>>>>>
>>>>>  	cache_size = 0;
>>>>>
>>>>> @@ -181,28 +180,29 @@ int cat_perf_miss_val(int cpu_no, int n, char
>>>> *cache_type)
>>>>>  		strcpy(param.filename, RESULT_FILE_NAME1);
>>>>>  		param.num_of_runs = 0;
>>>>>  		param.cpu_no = sibling_cpu_no;
>>>>> +	} else {
>>>>> +		ret = signal_handler_register();
>>>>> +		if (ret)
>>>>> +			goto out;
>>>>
>>>> The "goto" will unregister the signal handler. Is that necessary if
>>>> the registration failed?
>>>>
>>>> Also, if signal_handler_register() fails then the child will keep
>>>> running and run its test ... would child not then run forever?
>>>
>>> A signal handler is needed here, but it is rarely used.
>>> Also, the registration rarely fails.
>>> Therefore, if registration failed,
>>> just print a warning/info message as follow.
>>> how about this idea?
>>>
>>> ksft_print_msg("Failed to register signal handler, signals
>>> SIGINT/SIGTERM/SIGHUP will not be handled as expected");
>>>
>>
>> I do not think this is necessary considering that signal_handler_register()
>> already prints an error on failure.
>>
>> Adding an error message does not address the two issues I raised.
> 
> The previous idea was just to print a message instead of "goto".
> How about the idea to keep the parent&child process running forever even if the signal handler registration fails.
> 
> +	} else {
> +		signal_handler_register();
> +	}
> 
> I don't think the test need stop when the signal handler registration fails,
> since this signal handler is rarely used and registration of signal handlers rarely fails.

Please always handle errors properly. If the registration fails the test should be
stopped and proper cleanup should be done. 

Reinette
