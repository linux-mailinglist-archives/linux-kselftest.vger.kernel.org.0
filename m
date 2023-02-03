Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A348868A1EF
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 19:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjBCSYq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 13:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjBCSYp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 13:24:45 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3468BDD3;
        Fri,  3 Feb 2023 10:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675448684; x=1706984684;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1QxfXXvM0vBWFS3neebQ3Xo98UwQ1pYS2IRwFHGIQP8=;
  b=kahkzl/bT6EbMiFahRUDusU7CGOJuGNokQg8sA6baf9/anaVMRa5ykFH
   ewl6NrHPRxOGOQUGD7kd5Vs9fHVcwJtyvFo8qSwk70TXzN5B7O1qmcezO
   QntdEIXi66XyQmJhp8CBedYiQnNGZi19fefnCGOhQFUsZ8CRAlExad8az
   LS/SLcNx+Xwe4thQryGS6eFKRZscbnMqE7qusL2WIeDIEK5Z2biHw0wDa
   E/Psm9N2+GjTSEuw04Hczuz+BLRm9McqsA6qV5npaQL1OUQQMOmO16YVm
   QqAH7imIoC0+ngB8ZvRGdgCgw84WW/oMuDdOk+LQ1iy27RtfEJkTMzLGs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="415029521"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="415029521"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 10:24:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="734440713"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="734440713"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 03 Feb 2023 10:24:43 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 10:24:43 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 3 Feb 2023 10:24:43 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 3 Feb 2023 10:24:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWLxtbrQRlqruYnGgwiYfC3nIjqPYmATX1wguKeKstKm38aW5Q242mJa5IJvRLV9dM4YHwpX4+tbm4kmqdZM5rOLADRHsdXuS/sxTIvgnBOAkmh3axRmxdRAOdbYzP7GX4GumVIha06fP5nRbQbFV5HhjK9QWhPLFceKIZGxBKPjMNbOPxxvBjQkj5BjbmOt70zA02m3bqMUZvhQKL3QpCBF8gvQnjfeEKa+0eKG5oR1j74fTz0k576Gj8Bi7QoUEtI1zwILNfZDaPkvi8dpg287BWgMd7nLU2yX/H9PVbJtDykUBxZe842T8DzUd7DMiT/8Oyrn+ehAGD+a0RYNtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBMZIOP+rMhBYViqBuoHcQexXbxKQqjlhjyCH9upNZA=;
 b=PItJaQ3Wxq0oKGVoQhCoppXxm8Obe3ZbjwIiXn+GdEjtD7xA5CPMOsdfbjxIONRH0LpKq1AzCDKbB69PhTYs6I47r2G4RBRLvtNkSFeB97FhwV4aARcjaQ6AFceiRWQu2I9W3ph4lju9gBbVoD2YicfAUdOEgr+95XNKO+gE+daYj2iwQjFCerEwXNQPDT44Y01vJ3FEAw0VSj6SR1aGiFj8QtcUzctKzTMgrHvs/eSpc1lGc7y8FMctfjr4NuCorAMD0usbi0f3ns+ZjQ2naNKHzmsz9n/MDqHO0xAoJpRFaAj6NMlXRvoB3l/AIN4m3W+BxHM57G2/fSngD0juLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MW4PR11MB7053.namprd11.prod.outlook.com (2603:10b6:303:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 18:24:42 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.6064.025; Fri, 3 Feb 2023
 18:24:41 +0000
Message-ID: <a7c193b7-894a-c891-071c-f405e394421b@intel.com>
Date:   Fri, 3 Feb 2023 10:24:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v6 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20230131054655.396270-1-tan.shaopeng@jp.fujitsu.com>
 <20230131054655.396270-5-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230131054655.396270-5-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:303:6a::33) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MW4PR11MB7053:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb3b3d0-2807-4e36-fd74-08db0613ea96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QTmMxIFzVUCs8bgUiOd2V8lbLLw1+HaPGu0DIMfQ26KrwkNgHSjGXRRCFLlailPvZcyJmmZ0xR3EqqEw7My7D/Bt2Y0LDRmYRPA5WHqWO+TqGwRyIsHSbGjxkfoq0kg/ATlE+rfQCH6J5+y/9Li4j4v76giSm9NATFLnYAaDVGyRHXj+09TJK65NoQmufy1/qGdOzzRSGW9EReCp53SGXt9sWHF3c1MU228zjtvL+FUZ1ID2uW1wjoR5iuc/QJ8oJiJRGaTkChB5POAdx3Uh3se+SvGleMy2cmDm/8YwYNNmFIZzc9G2ON/0GNrEcny1AjWp7Rfx+dYUCaP2DLV3dNbav+0F81xwgY+FrwDPacAeSgIxuy0tC5NlECXqAiBtl781RtTv0tIYX5KQ2hDPevzKhiGLUGBwTE9nTYkJfGGx5BwExdRFLJAzSXwHAqbuoYs7bM8xlmnxmuqF7zBtQqMNDVFwsVLzuhsaAwvNRgm11Wno4lAmAAhAAl7wz7yPZoNaPTcjqZPsSh3esTT73ngpALzYcdnWfVj9hsnZaQP30faPeB8cTrk2a795LR6GqkLTQs4OXSjhKw4ptxikMIfT6hbfNso0Rs63rbF2t+PZHkO4znTq0LA7OOZnsub2cTwayqqgjM2ky41jah2kHJ2BJaxtk3Z7SyjBVbIQXWz5GxNtLCw+EeT/ZekWZYjzD0h3Dtok7aZ50atyhlRJ3UoBZU6s9IUgWivVqapg76o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199018)(31696002)(8676002)(2616005)(6506007)(26005)(6512007)(36756003)(53546011)(186003)(6666004)(83380400001)(66946007)(66556008)(4326008)(2906002)(110136005)(66476007)(41300700001)(316002)(5660300002)(8936002)(478600001)(44832011)(6486002)(82960400001)(38100700002)(31686004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVJOa0pHUFplc0VBTC9DT3VCUXdOS2FzOGJFeDVXK29DSTdHMUlmb3RrL2gy?=
 =?utf-8?B?T0xROVdXSU1saDRXS1h2bHhBdzV6emVxV1hvR25xL2pvZFRURDVSZVk1ZXdP?=
 =?utf-8?B?K1pmU1VBZVluVTdKTUhxQkxqS2VVVjNGSk1QOEw0cGpBQlZnWWVTK2dHQ0hv?=
 =?utf-8?B?Mi9jMXdlaERMNWU0ZkZuajFPTDlpL0J4bFQzdzVyMmZvV1NKa3JKMStMNm5F?=
 =?utf-8?B?VENJQTRlV3ovM202UElUOTZtaEk5TCtvb2tWeVBESXpvRE9PcW9OMmxJOERn?=
 =?utf-8?B?V2pGN3h5VmhxMytFVi84dEpFYVZ2YXRzYmlTTDhEMDFxSEhMMUV0c05VWVdi?=
 =?utf-8?B?aElsNzgyS2VxODU1WVBYQkZ0MVhPZ3NBck5pQWZkdnE4dVNlQ3dNNjZWNmdU?=
 =?utf-8?B?RHdIZG5Denc1NGF6WkFpaFV3K1N6SGthL0p3ZC9ZMWJZNHFSVGRKclJhZmZw?=
 =?utf-8?B?UXp0Rk94MjR4Mnl3eHdXblBzMlVYcW9Kd2pETXhXd0dNUnVzazY1K0RMU2hH?=
 =?utf-8?B?dU5zVnlidVBLT1JWYVZNT1gxaUNpVmhVZzQzMnFBZzlTSGMxN3M4WTdNRkJZ?=
 =?utf-8?B?cUlFTFcrZU0xaWYwWGxYdWt4Nld1V1ZZM0RLTHZ1eXhzUzdhL2h5UDlGRWVt?=
 =?utf-8?B?c2JiSXZZeGR1aC9wSERGUmJzKzJNZDkrZUp2TzhVWW92VGo4WisvbXVFc1pR?=
 =?utf-8?B?NWU1dUI3QXlORnlUWnAybDZxcm05S0JFWGt5VWNnOWdKMVhTaHdEcytSSFBo?=
 =?utf-8?B?R3l5U1FsZ3h4NWt0VDV0U01aekJsMC9rNk56QVBjN1JmWTVpYUtCeVVrV1Bk?=
 =?utf-8?B?aDZ5SXZnRWs3c3Z3SnFLUkhiTkJqSkhMQnZIOE01M25PNHp5aGNIcjl5NGxh?=
 =?utf-8?B?KzBqbUJpZG4rb0o2SThJbGNMTGNkZXVOTjZNNmdkbU4xNE81M20rdDhRMzk2?=
 =?utf-8?B?VnhpWlczN0ljc0UrMW0vYUQzTnZUNU1rc1EzSHgyS3hxK1N5R0JsQytPZjg3?=
 =?utf-8?B?dUdpRmxja3ZSYmQrVkhxS2VLbGdwa3N0ay80QmVpNTQzR2RlUmtoYVJxeUUy?=
 =?utf-8?B?N3NqMkRKU0p3MEZxdEFDOEJJbU9LcTBmK2pRZDlsNy9JMnFPcVRDMVgxTlor?=
 =?utf-8?B?bC9MbSsxSU80SUpvUEIyV1J5WEcrZytaanpEWWVrN3JYT1ZreDNhcVhIWTNS?=
 =?utf-8?B?NDlIdjFWcmZuYU5RVHhNSWhHVHpPV1pQMktwZ2ZmZXc1dzc5dVlUOW4wNTRt?=
 =?utf-8?B?Z3ZtaWNXVXRvOGtnSHI5NW5JdEJiMCtGZE13K3BpLzE4OTRqWjdRRVlQQ0lU?=
 =?utf-8?B?Um1yVTJtbUYvSzZCUHN6RXg2UmQ4NFRQRnRDbHQxRm5uWFRPb1JScXVyZUgx?=
 =?utf-8?B?WW5DYkVTTGozak5aRmlFbHRoN001eS9RWUJDYkFIZE4zakRDYWZaS1FjWGx0?=
 =?utf-8?B?Rnd3cTlEVkVwSTI1eXgwa00wOXBrTWZ3Z2VXamdKMS9EME1GcUJkZlFKY1Nt?=
 =?utf-8?B?c1ZhU05wMWRFRFdZM01TWUE3TjVZaXpMdmJrdnBXNUJwMlJybnZ5QTJrYURr?=
 =?utf-8?B?RXJsZGZKbSt3RVFZRlMxeXZJZURiVVJQM0Z2dCtqR0lMMnNPUzE4a3YxNWJ5?=
 =?utf-8?B?MGZ6ZXNyL1hvTzdSc0lxekYrZ3owekJvSjBHNHJDSWgrUUY5OVRIZUZRMEhU?=
 =?utf-8?B?TTlZakZLWXVBa3dUc25YeFYwcEtIREE2K2xCYzJhTmJMVmFGeUo5VzRSRmRI?=
 =?utf-8?B?enRrWlhRKzVZRGpVZGM0d2V3OHdsSVU1cEtYWFhJSG5BRjA4Q1NCLzFhOGYx?=
 =?utf-8?B?bGQwVVdTRXVncDFzYkN2WjRkY21WaEJ6OWVhbGUxZElGaHJUbmdONU54UEN4?=
 =?utf-8?B?L2NTYnk0a0FLRjhmNE9VWVpia3g2Si9DdFUvdXZXZCtBb3doa1M4MjdEYWdq?=
 =?utf-8?B?c2ZkR2NSQ05RQ25jcjVuME9SS2MxbXdPTTh4WmRkVUVzbUpwRXBlZTFPWmR4?=
 =?utf-8?B?YWVISVVnZ2Y2Vy96NnZqb1RzUEtFZDhQVWk3TEpabmFPNFY5aTRBRS9XZlpU?=
 =?utf-8?B?S1oyNFVrS1RZQS85UlVBMFQzd1J5Qm01S01TYS9hbVRJRURDZ0E1empoS1Nw?=
 =?utf-8?B?UXFOZ3Nxd2lPQjBoamlmY2xnTmRBbHJyeUVtczNmSzF3a0c4NVhsNWxiWi9j?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb3b3d0-2807-4e36-fd74-08db0613ea96
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 18:24:41.5778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLoCgHWdadzuMptVK0SAPIxt5MRe5s86R/mwLbvGVU9sSIQq5UNbTGs0btI3apLAfm60bD8grvcFElUshOhswFK/U9ZDxFuUkFceAQH0zao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7053
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng,

On 1/30/2023 9:46 PM, Shaopeng Tan wrote:
> After creating a child process with fork() in CAT test, if an error
> occurs or a signal such as SIGINT is received, the parent process will
> be terminated immediately, and therefor the child process will not
> be killed and also resctrlfs is not unmounted.
> 
> There is a signal handler registered in CMT/MBM/MBA tests, which kills
> child process, unmount resctrlfs, cleanups result files, etc., if a
> signal such as SIGINT is received.
> 
> Commonize the signal handler registered for CMT/MBM/MBA tests and reuse
> it in CAT too.
> 
> To reuse the signal handler, make the child process in CAT wait to be
> killed by parent process in any case (an error occurred or a signal was
> received), and when killing child process use global bm_pid instead of
> local bm_pid.
> 
> Also, since the MBA/MBA/CMT/CAT are run in order, unregister the signal
> handler at the end of each test so that the signal handler cannot be
> inherited by other tests.
> 

Great changelog.

...

> @@ -181,28 +180,31 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  		strcpy(param.filename, RESULT_FILE_NAME1);
>  		param.num_of_runs = 0;
>  		param.cpu_no = sibling_cpu_no;
> +	} else {
> +		ret = signal_handler_register();
> +		if (ret) {
> +			kill(bm_pid, SIGKILL);
> +			goto out;
> +		}
>  	}
>  
>  	remove(param.filename);
>  
>  	ret = cat_val(&param);
> -	if (ret)
> -		return ret;
> -
> -	ret = check_results(&param);
> -	if (ret)
> -		return ret;
> +	if (ret == 0)
> +		ret = check_results(&param);
>  
>  	if (bm_pid == 0) {
>  		/* Tell parent that child is ready */
>  		close(pipefd[0]);
>  		pipe_message = 1;
>  		if (write(pipefd[1], &pipe_message, sizeof(pipe_message)) <
> -		    sizeof(pipe_message)) {
> -			close(pipefd[1]);
> +		    sizeof(pipe_message))
> +			/*
> +			 * Just print the error message.
> +			 * Let while(1) run and wait for itself to be killed.
> +			 */
>  			perror("# failed signaling parent process");
> -			return errno;
> -		}
>  
>  		close(pipefd[1]);
>  		while (1)
> @@ -222,9 +224,11 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  		kill(bm_pid, SIGKILL);
>  	}
>  
> +	signal_handler_unregister();

I expected the code to be symmetrical but found that the signal
handler is registered by parent, but unregistered by both the parent
and the child.  Could signal_handler_unregister() be moved to the
parent portion of the "if" statement above? 

...

> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -476,6 +476,45 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
>  	exit(EXIT_SUCCESS);
>  }
>  
> +/*
> + * Register CTRL-C handler for parent, as it has to kill
> + * child process before exiting
> + */
> +int signal_handler_register(void)
> +{
> +	struct sigaction sigact;
> +	int ret = 0;
> +
> +	sigact.sa_sigaction = ctrlc_handler;
> +	sigemptyset(&sigact.sa_mask);
> +	sigact.sa_flags = SA_SIGINFO;
> +	if (sigaction(SIGINT, &sigact, NULL) ||
> +	    sigaction(SIGTERM, &sigact, NULL) ||
> +	    sigaction(SIGHUP, &sigact, NULL)) {
> +		perror("# sigaction");
> +		ret = -1;
> +	}
> +	return ret;
> +}
> +
> +/*
> + * Reset signal handler to SIG_DFL.
> + * Non-Vaule return because the caller should keep

Typo in "Non-Vaule"

> + * the error code of other path even if sigaction fails.
> + */
> +void signal_handler_unregister(void)
> +{
> +	struct sigaction sigact;
> +
> +	sigact.sa_handler = SIG_DFL;
> +	sigemptyset(&sigact.sa_mask);
> +	if (sigaction(SIGINT, &sigact, NULL) ||
> +	    sigaction(SIGTERM, &sigact, NULL) ||
> +	    sigaction(SIGHUP, &sigact, NULL)) {
> +		perror("# sigaction");
> +	}
> +}
> +
>  /*
>   * print_results_bw:	the memory bandwidth results are stored in a file
>   * @filename:		file that stores the results
> @@ -671,39 +710,28 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
>  
>  	ksft_print_msg("Benchmark PID: %d\n", bm_pid);
>  
> -	/*
> -	 * Register CTRL-C handler for parent, as it has to kill benchmark
> -	 * before exiting
> -	 */
> -	sigact.sa_sigaction = ctrlc_handler;
> -	sigemptyset(&sigact.sa_mask);
> -	sigact.sa_flags = SA_SIGINFO;
> -	if (sigaction(SIGINT, &sigact, NULL) ||
> -	    sigaction(SIGTERM, &sigact, NULL) ||
> -	    sigaction(SIGHUP, &sigact, NULL)) {
> -		perror("# sigaction");
> -		ret = errno;
> -		goto out;
> -	}
> +	ret = signal_handler_register();
> +	if (ret)
> +		goto out1;

Please do not use generic "out1" and "out2" goto labels. Could
you please change them to reflect what is done at that exit?
You could keep "out" but "out2" could be renamed to "unregister"
or something more appropriate.

...

> @@ -761,7 +789,9 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
>  		}
>  	}
>  
> -out:
> +out2:
> +	signal_handler_unregister();
> +out1:
>  	kill(bm_pid, SIGKILL);
>  	umount_resctrlfs();
>  

Thank you

Reinette
