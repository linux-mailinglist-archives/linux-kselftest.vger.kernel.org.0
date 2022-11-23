Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DD7636792
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Nov 2022 18:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbiKWRsc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Nov 2022 12:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238924AbiKWRs1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Nov 2022 12:48:27 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFB39C287;
        Wed, 23 Nov 2022 09:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669225704; x=1700761704;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qNmtaajdX+kJCGC6gxLY77xCgDJWZg574eLj0Vs9OkM=;
  b=Ld2Yn2ba4CkOmd08WxIF2X/daRmiZJ7Q+RgvMXP59EKUOiZj5QPQIEIC
   UqVPyEVA40zerII0/B/lRs9zJ/6Aa/6ZIys2rL/1aabtF60BZ5xeE65vr
   iX1QEmjG3OWsA0g+0wVOEvGpF4qLpmrYp6mF8cRsPHw78bBQleKXYML6k
   Y9xxvrXH5WVk207fyw2k8lhk2XCWYMNyjMfCK8B3MwU/FfJhrUzzWL1X/
   x2mPCFrePY1+3Hr0V2oQch50Qw3FVVYNLP0shaVv1KYi8RWzsJFjEvNjm
   vuQPUSFwCW8TRAOYW57jP0iy5AY0CgY1eUW+AM95rG8OqHOT2F1GD1jag
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="315276440"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="315276440"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 09:48:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="635993696"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="635993696"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 23 Nov 2022 09:48:24 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 09:48:23 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 09:48:23 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 09:48:23 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 09:48:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfKx+dM5KfKm9u/DpnVCpbICs3Ra1yaRGriDIgZW/GOalO5+n2SvqaLR1pv1S52z/a0DdpCoz0g2tpdKOTMMxX42r90jnrXK5Z24+twNeY71ChW/7ADLenpA3zee0t4LSlV4/CAAnoGIpufSaHw9P7EY0Scmoz3wHIiB5/8PNOCOv/cv9hvyU2h59c5uEufwQwrlwBh68B95WYrUIjPbd1CON0lwuwhOKsLQhyEQ0yy0DLv/cOaEyXf6gfirh0fyAwN9kOGVAOYKNlF65ekKBvcX0IBQkgr2Eto/sxauXFkT00F5/4dRP5i9PzP8aqUTxWG+a2UBkqrmoM6PJxwVsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOYQHabZwzRdFDzi2oPgl2NT9PQT0MyXdSDwqeNxsLE=;
 b=G7SKtSu8gjX0K1Y0XKPt9DT9tRslyV1fnPd4+5uzoeVDs6NiE2HjdTM/IFd7W1Qvnbd/6hRHeuvMkGRmZr/ygbf3rhlTPDQftiNW8nu+S8HetQUvQ+MnJVrgQP8KuLCawveLEmkNYqoK9TMS4AKW6Hqzc6g2iN9B9oaaFaJHKZy/8meRCnRaUHScrs7JcSqKMLdetZdevGcYng4LG/vmiwMQrfl9+lA1UOFXRNbqZXhaQzAu4HHybpMTz05kryi1kaxCH7PzUP3QfZD0bi9PQN5dxB6d+28Cma7RoZWpWBmpFI1M1W9RtjgMeEqFnO+ZEaLmwo1sFR1y7Jwk0hI4vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BN9PR11MB5513.namprd11.prod.outlook.com (2603:10b6:408:102::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Wed, 23 Nov
 2022 17:48:21 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a%12]) with mapi id 15.20.5834.015; Wed, 23 Nov
 2022 17:48:21 +0000
Message-ID: <af1b4e59-2b4b-ddbb-2218-0e2808b718a3@intel.com>
Date:   Wed, 23 Nov 2022 09:48:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v4 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        "Shuah Khan" <skhan@linuxfoundation.org>
References: <20221117010541.1014481-1-tan.shaopeng@jp.fujitsu.com>
 <20221117010541.1014481-5-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221117010541.1014481-5-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:a03:338::16) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|BN9PR11MB5513:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a543398-d41e-46c4-14ab-08dacd7ae6a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0n2ylL1IJr0YT0jLpfbqjcB5XNJl/dgqxWn+FUeGRQAb4Qct/PhIvrZA1LKUqvhLxXVYI+Vdj06W9OS6qsTYAPiwKlravHIoZHcWWvvpy1XnMgLETPQDuFBOiMCAhnqYVvMkAbDZDQP1OP8IdxE/wwayXNFLc/BoQmo6h49XzPeAwPvAgneNU6z5RqTbF0iRwKUHuknDgjkil62bFBtgB/zTnNF3Q/jkKbCaBRaJsQXehXoVcTyzMk1NTlnW/b9YOzK7gLKJJJdWeqsz+PzvvQw2qAboyj29/kdJmDgWt+YUEqCpC0AYcFo7027qwQh3KC+rEaEuvPmUPalS92cyYfMgA9DcQo4frKarKTWqbI56otfPxYZnPProvS7iGIniLMnXKZfUFA3JOu06wpMK+p6sOODnTBrtAzCWLxpxt8ZqfjIIFPAmrw4tYM9Sfr4Aq06D42+MMERCl649GRtxsMaN4alIDs8i8A2KImUumapKy4wXXwn5tSoyZY0vN5e0dNtsUvbLwXryvykpW1k9A4hBHSWg35qcMS2fm75FXJGpQveWaZ8vcczQi2sgWshl5GWZ17V78NkhCnwovqLigRxutKo/HAADUhYUcaQTZHgleulI7N1nAcXAQH0cNpp6/9BUxGLxU3ErEh5BL5eEi+4bksEvX1Z40DuyAo5RAiqvemZKIYGyHRNv3Haf1/rUnag3hk1rblEkEAC7grHTwYL1RsNuLqfRw68ea8W125M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199015)(31686004)(36756003)(478600001)(86362001)(31696002)(5660300002)(44832011)(2906002)(38100700002)(83380400001)(110136005)(316002)(2616005)(186003)(6666004)(82960400001)(6486002)(8676002)(8936002)(66556008)(4326008)(66476007)(41300700001)(6512007)(66946007)(6506007)(26005)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlJYQUpIeVU5SkdPQlcyTDFndXh6R1hVdERmUENMSityUXZlQlNZRjY1UnBi?=
 =?utf-8?B?TjdSMmNjTWZCaG5xZFl4akFXS1FnSTF6ZVNqT3U5T2tvNTJiTHpvM0VRV2Fo?=
 =?utf-8?B?eWF1ckliaVMrblR6eXUyZUJPWFlUVmxKeG0wZVI1UEZSc3ZUOHczaVFrdEtW?=
 =?utf-8?B?TFhmbkd5Sm5hdmVQYms3RjZNS3JKbmV4SUdJSHJKVlU0UThIaE9yUFNnOVE3?=
 =?utf-8?B?NVlncy9pWXJqa2FZVGw5NmFxL3IramErZERXYUh5MFhmNFVFTXVKMUJ2RGhs?=
 =?utf-8?B?TXJvQUU5SjNqVE5xV3Z5ZHJKTjdoc04rb3pqWGQveFRJTVUzcW1xOWpGZ3FT?=
 =?utf-8?B?Q0t4c2FVWThuekNJWW5KVXh2U3BkT3h5UkRqQzRyWE44Tkp1Uy9ZM2c2ZzBR?=
 =?utf-8?B?NzZNeHdzOXZOVjcxamJlU3RJcjVyQkFENVQxaHVTZXpzak1BN0pMdDN0dEZV?=
 =?utf-8?B?a1RXOXgrRDVnWDAzV0lHSG5pSVM0eklkYU1LczE0N0ExcTZHdWNEMVE4VUVS?=
 =?utf-8?B?a1YwOUNCTUNGNk8xSUdTeWdIemhISVh4ZU5PdWp5YkFkUkxaSGJDY09uSGJ4?=
 =?utf-8?B?R082TTZlblFJbXVKcjk0WkkyWGwxRVRVallvbklhZ3pPNkl4L1o1YnhkV3Ba?=
 =?utf-8?B?RFRwOFVHeUFoN3dPQXpibFlGTCtYTk1YbXBtK3AwZkF5clhBR1lRUllqb0pW?=
 =?utf-8?B?L25UMjAxeTZGM3g5WmUxaDdjYkU3aC82cTZES3hIVzkwN04yTVc3NG01c214?=
 =?utf-8?B?UkI3YXZzbytEZHZiWTNITjZWL0JWNHdWZVg5V2wrMXNzWm1PVWlJemRYSFU4?=
 =?utf-8?B?R21HdkRmRWxKR1F6MENXRWIwZFdIVzN6U2t5MnYwQ055WEJHcUZlUFFURHhE?=
 =?utf-8?B?VGdsVS9tMjlIK3pnaE5EdlZwQk5vTzRPRUJQKzJmckVOUmIySFNIbERmbnZo?=
 =?utf-8?B?dDcvZjByUVdJdHl2cFgrTWdGUkQ1cUdMVTE0Z3hNMklITHQvMXNuNEhUc3Uw?=
 =?utf-8?B?ZlZrQ1V5ckEraHduY0gxV1dEdldvaUlQMDNlS3VCeU81WU1GYTJVSTU0b0h2?=
 =?utf-8?B?NVkvZEtuSEN2Mjh1NW85YjVQT3JvN2hvTGUzT0tlays3ZnFKc0xWWTVFcFVL?=
 =?utf-8?B?eklsQzdPZ29pNkFabzdZdk5lZ1JVNFlCR3VwWkZWU3dvUWZqZEtMQXp3OWMv?=
 =?utf-8?B?V1BvTm54N1VYRkIxNEFWWGk2VHpwSW5VMUpibG16ZTVXK0dROG1lV3EzQVRY?=
 =?utf-8?B?bVdpZ29iS1NLNlU2UWQ0c1NBVVYvNldCeG1yZkJBcWZFN1l4QVhlenl0b3Fm?=
 =?utf-8?B?VTNYaXRUYkRxMUxRM1Y1S1hNWUh1U0JteWw4WTFpVlBHLzJSZVUzMjZ4NVI2?=
 =?utf-8?B?cnJHSlI2SFQ3TG1DVmJJZ21JVTBhS0UyUW94MWpKbDdGNjBDaGVFRUpBUkp5?=
 =?utf-8?B?b0MveHpqaTdOYmFQbU81VHpPZkhMeXpFaWFsR0ZtckNMT1g2RzZsYU12QjhP?=
 =?utf-8?B?SmRjVkpac1pXNUlHNkdhTThJSUdGQnV2RTliYlR5cnkyUW9COTVyOVc0S3cx?=
 =?utf-8?B?OVFGWExWUjBvUDZwYmZEbHVhazhPYitTS0VWeUJnT0t6NGtpRHlQSm8vbG56?=
 =?utf-8?B?YUVicWNJeDRyVXkydzU5RnJoZ3hxWDFzQ3UxSkczTDk0ZHRHa0Nodms2QnBN?=
 =?utf-8?B?a2dyVUFzbWEvaDZnL3JCYjFqOXhnNjUzQjBBOGtMVGh5cTBiUjVjNjVGSjdE?=
 =?utf-8?B?OVpLUDFXRDhMVldQcWw2SDZ2M3JlY24yYWZLMENqaVBVK0JYMStibEVLV0oy?=
 =?utf-8?B?eW1QbW5HWlF6bmRYSzkyaS9QZlZLRG5sTVpQL0ozbDI5aTVHNm1QekN1aW82?=
 =?utf-8?B?UEJiMk0wVG14VDVGTkdrVUFNUElhVkxOSlVsNjlQUGV1OXpsMTJqQmFJK2pV?=
 =?utf-8?B?aUo4eW82K1JuOVRpSTg5YWJLUzNpWkdSVFR0dytlSDh6OHpIVDlkd1BES0hp?=
 =?utf-8?B?K3VYeGx5MFQ3ZHBrNzREZzR6bS9yVTByc2UxQ0lUZm9WUERTRWFpWFNDemto?=
 =?utf-8?B?T3lxQjNkQ1hxRWFLTGRWQzBPQzUreUFjbG5DWFVaUVh0S29vZjltMzVTZHJN?=
 =?utf-8?B?VjNwQzkwRTUyUEMyanlNL3hjSTBieU5uWkltN1lORGVZVC9GWVlEVnVvV0dF?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a543398-d41e-46c4-14ab-08dacd7ae6a7
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 17:48:21.0756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3A9i+cm/OYfWA7e4m55CvvcgKv+OS05A37XCHLj+1k7iKTnXiIJEU0H1Mh//l1wTDHE9oKqrqKkNV8AaKHnNYnlqzac35AsFlHXxE4uyTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5513
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng,

On 11/16/2022 5:05 PM, Shaopeng Tan wrote:
> After creating a child process with fork() in CAT test, if there is
> an error occurs or such as a SIGINT signal is received, the parent
> process will be terminated immediately, but the child process will not
> be killed and also umount_resctrlfs() will not be called.
> 
> Add a signal handler like other tests to kill child process, umount
> resctrlfs, cleanup result files, etc. if an error occurs in parent
> process. To use ctrlc_handler() of other tests to kill child
> process(bm_pid), using global bm_pid instead of local bm_pid.
> 
> Wait for child process to be killed if an error occurs in child process.
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/cat_test.c | 30 ++++++++++++++--------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 6a8306b0a109..1f8f5cf94e95 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -100,10 +100,10 @@ void cat_test_cleanup(void)
>  
>  int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  {
> +	struct sigaction sigact;
>  	unsigned long l_mask, l_mask_1;
>  	int ret, pipefd[2], sibling_cpu_no;
>  	char pipe_message;
> -	pid_t bm_pid;
>  
>  	cache_size = 0;
>  
> @@ -181,17 +181,25 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  		strcpy(param.filename, RESULT_FILE_NAME1);
>  		param.num_of_runs = 0;
>  		param.cpu_no = sibling_cpu_no;
> +	} else {
> +		/*
> +		 * Register CTRL-C handler for parent, as it has to kill
> +		 * child process before exiting
> +		 */
> +		sigact.sa_sigaction = ctrlc_handler;
> +		sigemptyset(&sigact.sa_mask);
> +		sigact.sa_flags = SA_SIGINFO;
> +		if (sigaction(SIGINT, &sigact, NULL) ||
> +		    sigaction(SIGTERM, &sigact, NULL) ||
> +		    sigaction(SIGHUP, &sigact, NULL))
> +			perror("# sigaction");

Why keep going at this point?

I tried this change but I was not able to trigger ctrlc_handler(). It
seems that the handler is changed soon after (see cat_val()->run_fill_buf())
and ctrl_handler() (note the subtle name difference) is run instead when
a SIGINT is received. The value of ctrl_handler() is not clear to me though,
and it could even be argued that it is broken because it starts with
free(startptr) and startptr would likely already be free'd at this point
without resetting its value to NULL.

From what I understand ctrl_handler() and its installation from
run_fill_buf() could be removed so that it does not override what is being
done with this change. Otherwise, from what I can tell, this new handler
will never run.

Reinette
