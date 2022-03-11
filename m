Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D15C4D6A9E
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Mar 2022 00:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiCKXNd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 18:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiCKXNb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 18:13:31 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D5FDD94F;
        Fri, 11 Mar 2022 15:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647040347; x=1678576347;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9JOOwkJUvNPPY/HZRHX3CCdsj898wOO3lw5ekwhsVAo=;
  b=CUSXCMKhAT2JkNVuRkXjlRqjZuW+/bkPJvddF4hhiWfLIsITifvpXDAA
   mwJB6YzzcWd5BeBIpDrYSYsiSJ4OcnRq01DPkOe3e5MQhJP18rc5Cp2NX
   QX9HyqOXXg2TxLuHeN7CMJKpt7t7YbKkkba2FbmHG8R9AFB6XRXZs9A2W
   qkEVC0Tck7g9rojUWq1aTC8AjeBPMI4RyMRds5WeyodnReoeWdzv7WfT0
   q5omtxWbfEbFTN0bMB0ZATDv17XpToyMMHz9L9UYV5gNBnLhgUFMEeADa
   epRKus01UivBFEESbqbJABGxF97kxd32SnQMqw2S1XuXz0V2K3kcaS8pH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="237842035"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="237842035"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 15:12:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="579445727"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga001.jf.intel.com with ESMTP; 11 Mar 2022 15:12:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 15:12:26 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 11 Mar 2022 15:12:26 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 11 Mar 2022 15:12:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0DDbk83CoS4mJUqD1PMuIGy+zW5S47abzl9cgylNF4j7dVGdOU2PQImMtKqjcEh0+hjdHGXWGh1hcQrg84Tf7c6DVOA1QPich3YxGwiEpgdKe1FaCbFEHwTXttWUBACCTMQI9RyrJwCRUQ0leDAjfnzoc7PL02OQN3BPR8Hd2/2e0GCXd77UuqWRy5reo1m9BN1B+lTye1PWf7L2k5nhzgi/nb2GWW0WpOq2DC2MjKfcYerAnh26uFytbYPDpeHa5K2a8lJvaBO5NJv+mG1y/NEWdKh1UV8XSAAn6tMuSJsxYs3T60RL0TUtmP3v5cY8ABq1ao5UNu6cBNdxhndjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oOvB59BwZBt+6gIVgs2xX1qfqDXCEnPhTQL44C3HbI=;
 b=bOX/PBZEy3cJ/XJB2LJYz6r82GzP23LfV/RRW2VS5gFSfOnrMLVuL3yvuByoSoM3ZN7XO4ofbGIwMaNG421cR0sf3c0jEyZAg1tizHBxeWKWrSI40bBx2soltLQex2fgtU62KC9hN+50bdyw3NeEF2b9KTKz5hKZ4fMKq+m0Zei5RIHkR8mOaJFxY6vSHkf1dbU01PfbO02wkY05Lx6lWWeAmk5EfPMKHT/mNkRx6qhbwaDnBQrl6myKGbL4sajpYarSgzJW+zNAAzuszqA9pSfArrdS7acSdJBdjx0nr8lv8dZ4Aj6sSwadfFmfWhcFH5hQoDR/ZDVjbBYgCJx4Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB5740.namprd11.prod.outlook.com (2603:10b6:610:101::7)
 by CO1PR11MB4945.namprd11.prod.outlook.com (2603:10b6:303:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.29; Fri, 11 Mar
 2022 23:12:25 +0000
Received: from CH0PR11MB5740.namprd11.prod.outlook.com
 ([fe80::b432:16ba:2819:d702]) by CH0PR11MB5740.namprd11.prod.outlook.com
 ([fe80::b432:16ba:2819:d702%5]) with mapi id 15.20.5061.025; Fri, 11 Mar 2022
 23:12:24 +0000
Message-ID: <73ad2b2f-a07c-d78b-cf1f-002e6a983c6d@intel.com>
Date:   Fri, 11 Mar 2022 15:12:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH v5 1/6] selftests/resctrl: Kill child process before
 parent process terminates if SIGTERM is received
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        "Shuah Khan" <skhan@linuxfoundation.org>
References: <20220311072147.3301525-1-tan.shaopeng@jp.fujitsu.com>
 <20220311072147.3301525-2-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220311072147.3301525-2-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR19CA0085.namprd19.prod.outlook.com
 (2603:10b6:320:1f::23) To CH0PR11MB5740.namprd11.prod.outlook.com
 (2603:10b6:610:101::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d9be124-206d-4f66-cd62-08da03b499a7
X-MS-TrafficTypeDiagnostic: CO1PR11MB4945:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CO1PR11MB49459D05BDD01CF9C14B8477F80C9@CO1PR11MB4945.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PIo0THm8ov4YUohrfQ79dN6+qQ9qDoEvxERShDR7BZvLHYcTk++CSauUUvnEKK9fCuAL5QUgAxodaCIV3CcewYtMEKYAKAkAbFlpggkmPnmmiPo9AWroflJhZVPyDi4LldP7OO3T9UndUpYRCPmAqQ/6fbJisebhTdkQkRosFIp4qSmSCNDlAAukKShh1xJaIWACqrtNScXQeDY+qzuZ4EHRYaKDcI59v9Kiej95N3JFFM5WNS+kXOIt1nU8bsPfPIIaHPPRwCh+BGC/Yks9csElK+ONt7j3u+1cSTu01nufrqBBRmp1TtasfMaCgXbiBysPN4/Rx++yoKDv4pp+wN6kI2F/LxYId38paltemctnUqKNRpEkkcMMD9NVh1EcH/GKt2N5fN7rInpdi0kEXc3FVuJ/uvd1eVLpbHdOqWJ45LI+ucLAI6TwPWVNW4j/Y14ChlK2+Ca9AmlpvCNgwMuKCWQp51dmL0CpUss3uHRwiVKzm6w0GMDL/g0Q5OXwBnEI+iwFgyle8AkCoXJ1X467GVDIRaxuNVqKQxd37UutnM7CxpmboKE4G9/F0rJJ3oF7g1kP2QdyE5Ev40J5padB9UQ7PTSGTCOb9H8tOsDtxRxQ2t+Gho1cUBHLoTuVBvIxmeFbUrrG6Jneiq2aF2C3Pp/w4l3O+b3jfh4acnIfpyrIpiq3QCRD0rm/19SqArBq4l8vsHWWVKyjEQo4BTildPvDLtwtNcvcxBLylAEpB+FF4iRbg9uNids5GjKM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5740.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(26005)(186003)(8936002)(5660300002)(44832011)(6512007)(2616005)(8676002)(66476007)(66556008)(4326008)(53546011)(6506007)(508600001)(6486002)(82960400001)(38100700002)(31686004)(36756003)(110136005)(86362001)(31696002)(316002)(6666004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkswUHlYM0Zaek11UktWRXVOaFhLZkdpdUhHdmZLV2pVWktIMlAvN3c3MThE?=
 =?utf-8?B?eFdkbm50UnlwenRKcjlJeXVFVDhqbURvSnBQbC9vQ2RtNWdkMVhZSkRjQk04?=
 =?utf-8?B?NDcyK2xUMzFmMGxseTVYNW82S1MvaFdOaklTMmF5K3p0SStyK1NMOFVCckZZ?=
 =?utf-8?B?M0ZGZytuSjJEUkttL29UejcrZjMvTW94ZG84b09EUVd2aFNwUW1RZEFSMktV?=
 =?utf-8?B?NjM5LytuYjVlQUxYTEI1dVVMdGJrQTdzQk1CU0dhbmdmT2NqQXMrQnNhQnNq?=
 =?utf-8?B?VHJjbU01cjV1Wmo2TkRqTWl2N1Q0dDRtMmo5d0ZOb2EwZ2E1VGt3VzZhOUJS?=
 =?utf-8?B?UnZja3ZKV3VEYTdpb3lBZ2NyWHR1NC90TjNlN1JCRWJzektQK2FJUHdsTmpX?=
 =?utf-8?B?ejdnSmJJTU1pWkhIYWJnUXpHMUk1V0NWcmpZS1NDV1RTYmNENXNZeEhhdXBk?=
 =?utf-8?B?dzR6ZTJ1YUxpODdyUjVab2JCa1ZmUHU0Z2hnWWhMOGxaQlVQQXVDeFI2TlZl?=
 =?utf-8?B?cFB0TXduYU4yN0xtOXdZeWRHQnRQdmhzZ2U5Y0E5NEtZRkQ4TDAxK0svMXY0?=
 =?utf-8?B?VW1DZHI4YU41UnBjaFlvdW1mQ3VPR2RobDgzWEQzeDJYUy93ZGdOSEdBNW5B?=
 =?utf-8?B?Z3c4TTloSEpBbkczZHU0bDFtTGM4cFZhdTB2a0pqQWFRanZkV3Foc2hGbUpJ?=
 =?utf-8?B?dVhNNlFyZnJlTlNHanVzUk1hQUg4U0hIR1VKOUw3Rm5vNEdJOUprcUxLUGE3?=
 =?utf-8?B?aWZacjdUOEE0QURsZjlFWkE0QnNRcU1GazZqRDVJTDcrM0psWlRybFZRaUd5?=
 =?utf-8?B?cEhIWHpGbysrMzlScEJ4eU5YamxmY3VIbEl4eFlGVkNpRkpmczJndlVRdnZX?=
 =?utf-8?B?VVkySHVpbVBMVHQwamZoOEpxUWcyS2lwVUQwSzd3RzNCSlhUd213UEk2MUJB?=
 =?utf-8?B?am5wN0FadUNOblhPZ2pEZDRPZlZ4ZEhHVWdMU1pPQkVNSkM1ZVBOVEdHWE1H?=
 =?utf-8?B?RWhwQVRuNFFDMnZMeC9sYmkxTVhGVEI5L00rV0RQOE9WaE9SVUR0ek9DdUVP?=
 =?utf-8?B?MjhGRm5wZmloaGlaL3E5RE84Z2haYTRPY3lwQ3hoUkJoRTYzZzEzY0hPbm5B?=
 =?utf-8?B?OS9ESklUeWxlNURlOE1aWmI5NDRuTXVFOWY3Vlp2TDYzMklFOVcyRklZQmYy?=
 =?utf-8?B?aW9BMXg1OEJ6WGZ2eGM4Ty9oZ3R1L1VTWnRINmtYZmQ2aWRMTWUyQUY1aW05?=
 =?utf-8?B?amxZZTk5VXV0R05jMkFiZWdkM0VEdW5OZ2lOUzc5eFF4d0tjdWI5ZW8yV3o5?=
 =?utf-8?B?b0JLejJzdzBiUzZteWppL2E1aHNtM01RYkJZZ2crZVJxOVlNR29YU3NlNGJX?=
 =?utf-8?B?UFFHOEhPTVRQSUxjYXQrcXhTRVhyOUlBamEwSHdXKzlaRmhPSkx4cUlTelNm?=
 =?utf-8?B?Vm5VejZJellBOWxtNU8rT2wrcmdTV3NDNkthYkFlbGxuZWVZckg0dXVYWHZl?=
 =?utf-8?B?UjdKZnZWUDVxL3U4d202TUlOYTF1R3JFdHNtbTZjWkpkTm5ERjR2bWlMaHZN?=
 =?utf-8?B?ZnY0aFNXbkZrN012ZmhqQ29IUDBIODFCd1JVVEdsZTdaOVNleDJZTS9EcW1K?=
 =?utf-8?B?MjhjbjhkZTF4NjUzRysyeDBzWmxmRlZmUFgxYkEvN0ZWaVdHSzNOUmkzRG1S?=
 =?utf-8?B?bnRPVjlMV09MSTlqQUY2UGN2V3VQYTZrYys5bGMyTnZmK0tKdWM1Rm9KMExD?=
 =?utf-8?B?UlgzZEgvNUxjamY4RnBqaXFTT3kyeEZYU1NydmxxS1pNdVJxWlR4WmJUeTdu?=
 =?utf-8?B?M24vdkR3OUNqcUV5Q01zQ3FTRlBnZXNGdzBRQ1dzY2crNVYxeHh5cWZDSGtw?=
 =?utf-8?B?V0RzWktsZUFVUXNQZG1lZk0zWnFRdFIwRG50aTMxazBHT3FockxMalNzTmV1?=
 =?utf-8?B?K0hMVlpFRUd4VVRWdXpQMXV3TG5qSlNuSGFPdGR0cWNlSDhSMzc5b3QyM3FF?=
 =?utf-8?B?M0tUUWF3azc1SVhNQ0xrak50blNVbEJNa1ZWYkJEcHE0WUppdEVadXpoaFFK?=
 =?utf-8?B?Z1ViNFpFWFRGRTJXOFRPcWdxcmhuSUhlc3h4bnJFeXVmOXljZTFiU0p3K3lJ?=
 =?utf-8?B?Y2F1SnRYcW9Fc1d1Q2dqODBIUnN1RHcwRmFxVmVJZFVueVBYaXRDamZ4Zzk2?=
 =?utf-8?B?MGJLMUhVR20zVWNiYjlCR1BYRjJGTWFVWHJVajV1S2daUjcyYnVSVTROYWFr?=
 =?utf-8?Q?WwuIXKAoCyW+UsixNJvZMtIi9v9GrRCs46ky1WBKQE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9be124-206d-4f66-cd62-08da03b499a7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5740.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 23:12:24.7640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ze9S2KlvRNmBOnWOZNEnFDUUt/Bh9JY2rrlO9IhAywqYYXyASvTMJxSaYFJ02IjyXOWaQngRVpq5LajJdWHKigQDTtnkl/Op6dL2hh/iv64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4945
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng Tan,

On 3/10/2022 11:21 PM, Shaopeng Tan wrote:
> In kselftest framework, a sub test is run using the timeout utility
> and it will send SIGTERM to the test upon timeout.
> 
> In resctrl_tests, a child process is created by fork() to
> run benchmark but SIGTERM is not set in sigaction().
> If SIGTERM signal is received, the parent process will be killed,
> but the child process still exists.
> 
> kill child process before parent process terminates
> if SIGTERM signal is received.
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/resctrl_val.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 95224345c78e..b32b96356ec7 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -678,6 +678,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
>  	sigemptyset(&sigact.sa_mask);
>  	sigact.sa_flags = SA_SIGINFO;
>  	if (sigaction(SIGINT, &sigact, NULL) ||
> +	    sigaction(SIGTERM, &sigact, NULL) ||
>  	    sigaction(SIGHUP, &sigact, NULL)) {
>  		perror("# sigaction");
>  		ret = errno;

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
