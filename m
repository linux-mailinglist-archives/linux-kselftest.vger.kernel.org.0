Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC53D76A60D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 03:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjHABKX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 21:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjHABKW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 21:10:22 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9704612B;
        Mon, 31 Jul 2023 18:10:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkpEG4izGoFBWAVLfHpMpl4LYTOxWiZLzVUDpmD8akKWsbdEOvDzF+UtBWeB1Ao/DXVUEUZTwUEfuDBeRtnuTpWSDCrOSn0U1oJlWkv9I7QcFjn34IyOOomkqjhdOUHBAONdx2bKVa0nAJ2q7sFdSew0N7ILimdsT+vHuL/DB8eE3g5XNFI3kDwl0UG68bAmuUqnlcTbLG951pHqsZaoEc7l4xmeLROssfM+/uA8Lv9bZt93A8MnkKooQbBJmoWJE5kv45YOcmehAzI7epeXNSBZtJdFelk9mW7E9tE98C4ONxc+c3sS6L8yCvrHqY8G3ndPNWqytjrhBfeWOWxeWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/TgKIQf5WmVowQ0i7FZW6qRcWsrhT6epyd3KQ4Ov7I=;
 b=GkU0W63fQ39QCCHZJs4mPbH07thaGToB4WCkWmD5g3uIXXIeSOQMqTBwWpHC6LJNCaxPa5xhiRJFXQosnTzb4LdhZp3EeA/ZajmEUkVxiCowSmt29nC48nKYuW8+Gt010/EhIRZMqYs4845bNQChVlxwx3oM5oF8NB21Xw0n0dYDIDHIKgdfG3NajHeQyemho8jxGAwsbILRBtCzY4jNdm3IJ+zGbzDaVT70aAbdNW6tSa1qbBzyOuaHU6R+9848C6MLiER2RW3SQKDWzWsvzMjd7TOS6G2mdUOS7sdlpe5TEWzpMsXsU1dePLhTzvn1WRGBbV1rzBntqddnah/Y0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/TgKIQf5WmVowQ0i7FZW6qRcWsrhT6epyd3KQ4Ov7I=;
 b=ZUt1GAiOSkXgAGn71pmEod4GiWLKETssAbtPt077i8boXAS3Tt/mMQlvk1dSCdISclQcTNQf+bCOR8tqypd8GY2SPzUEPwG+9u05Z/26harvvRpy6BXhm+Ewz0GWrpUncM7X1fbEH2FWXJ9yCXwRFriy4P9XPZZEsVQcF0Lvkfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB7029.namprd12.prod.outlook.com (2603:10b6:303:1ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.39; Tue, 1 Aug
 2023 01:10:17 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 01:10:17 +0000
Message-ID: <5b92239a-4255-346d-1dfe-c7953535083d@amd.com>
Date:   Mon, 31 Jul 2023 20:10:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Modify the function to et the highest_perf value
Content-Language: en-US
To:     Meng Li <li.meng@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>, linux-pm@vger.kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
References: <20230801004719.1298415-1-li.meng@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230801004719.1298415-1-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0105.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: fad749ea-3935-4a16-692d-08db922c119a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q5uzomP7O74+n/hNauNIMDoxQ60Hqx9YGmNRpKfnVrFzSwboCXX52yZbGHPlvjgU3GcgaeJ0p4ia8KDuz8Q9i1pyxAr4XXEM1vnraoOYFpfYmJHLkPSreR6jsDKvvWlOQ71g//pH+84WnyevpFwC89I57Miy03U4NtNnnCZC/GUSg2RXMR9+zw4XJotKTmJjhkhNR1/uT/jJy7wPCLImr0qeU02lUmCProHAc4lcrpmho5gtyqMVG/2V5h787Itt1lMxJTwp7yZXmBsEFNh+ikAo+un9kNaAD1rMM5Gws+7OOfc3L2QE5L66Jju1cmidPx/n43sw9nViC9VVVaD+9gFyauccif/tfuRCMRSORCPRmqhXGvmCxfy0cH2ZPFwASR+VPpDAxvrQv9NjnD6BCMSYyN3xEY78qoxJFLcGUffDE1GvkaC6MHFxQsaEj5wyEXzPKq7sQRjmoTtwd2lF412HsX3+uj1IPrE29A8+yyDmNnq4yoVATwzyekFWVmE6f+ZNEpHKS1rh7zXkiRwCRZ45EvifGAIZWKBfyOlLLYFhcGfn+0iPoHNROZndP1QQ3kGRFbAheKSM5b1UEa1y1aaxRllIgb6yudF1dl/miAI/pzH/pnCGKFXOvX8+h0l83Jkg5n0Qeqvcw2Ho6ts8zA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199021)(2906002)(5660300002)(8676002)(8936002)(44832011)(4326008)(316002)(66476007)(41300700001)(66946007)(66556008)(36756003)(2616005)(53546011)(186003)(38100700002)(83380400001)(31686004)(478600001)(110136005)(31696002)(6666004)(6512007)(6486002)(6506007)(54906003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUFVUitVTklJYTJSK2Y2Y0Y0elFuMTBNL1dCRjF3L1RlSGdlTzcrZ2ZQaEUz?=
 =?utf-8?B?Vm0zOWlUamEzMnhUYXV3MVpFWWdHYjRLZEF0VjlXMVlBVVdyVXJHZitReUhq?=
 =?utf-8?B?VVVlbisyaWZTUUl0VXdBRkpQVzA3bFE1d3JYTXNvQmNHcXo5T1UyL2FrTkw2?=
 =?utf-8?B?S1YxWko4VEQ1R1dZN0NtNDNLVGdEYXIvVkhJN0pVd2ZselpXblJySlZkaitq?=
 =?utf-8?B?VnJ5UjNsaGJkVVVKbzhKbjUrYVJFVFJGRjB3ck9iQ0hOMEhhUEtpWTVvYVl1?=
 =?utf-8?B?SXdSUzJNSytGYkN6eTFFSTNadno0RzE5cTdyMitJWHg4K2c5Sm5FZFM3bTN0?=
 =?utf-8?B?TGdlRUsyOHRYdEhFbDVPWmdadUVmTEo2eEMyWWZGWCsxelZYNVhyUzNOczZC?=
 =?utf-8?B?cC9QU0Z3eHBJeXg2bno3aS9wektQaWFEQUQ5WXUxeHJ0eGFlNGZGdDdCSlR4?=
 =?utf-8?B?dmlBbFNWVW1QcjUvTVgzcUNxbjhiQVpDR092OVU5N0libEJwTlRTeXNYY3pU?=
 =?utf-8?B?dDd3YXB3NnlYT1ozK2hoOWp3bEdUL1pRdnNNYkdYQmNtQ2hQcHlyN2t3Tm1C?=
 =?utf-8?B?RWRPNWpEeTZXbzlLVzMwVWVMaXdCZitQODBmcFVxTHVlYUg0MzNGa2pGY1kx?=
 =?utf-8?B?Skduc0xpSEUzUW0wL3o3WGZ0bERqUFk1WlN1K3cza285c04rQk51TjJxaC9i?=
 =?utf-8?B?QUxHdUEwMll1d2NzcEhpSkZjU240d3czWnphaHFUYlRzNjgxeGE1WDNVbFFN?=
 =?utf-8?B?RVJhTW5VZmUyMUg3Q1lTNFNnK2QyMG1LZ1k1dTFETDZ4c3Y0Tm9JTURmTGpH?=
 =?utf-8?B?NElnSVFJKytZRy9YVytuZXV4OSt4VFBndGZFeW9MdTJlRzViTWFRL01INnVl?=
 =?utf-8?B?SE1rQTZpUktKbUd1cEZsSHBNakJlOVBnNnJVWUZNMXhuRlR3YWhKTFhRYVB1?=
 =?utf-8?B?Q29UOXVQc2xlWTlJY1NNekYyU2FCWU82NmphTSt3SnY5OUhySzFOZGhiTFVZ?=
 =?utf-8?B?RUFqeDBqUzAwT3BuZ0pZRUJ2d2loL2s5WjlwZjdBUXpyWHNqeTBNQUxweDEw?=
 =?utf-8?B?dk5IZzNzUFpTR0ZlQzFKYWZ1MXRndUNBT1ExR1VpY1VRejJFV1QvZWZuN3ZI?=
 =?utf-8?B?aUNEZHk1NzVxL2JWd3JKS2Q5WXhYNjBsL3BVc0JDOE5ISGRlYkU3T2J3YmJi?=
 =?utf-8?B?UUI3SnNsenM1R09XNFVIWUN0RVpXV0xEcG9hZktSUGNVRGVmY1lOQ1ViejZq?=
 =?utf-8?B?TTVVV3ZvazFnb3JHR01MTXR5K2QxdEwyUEhIU1NJc2tGZGZDbnJuVS9xZm15?=
 =?utf-8?B?N1I3ckMxWFBhNXhHVTFKZGdNQ2pGaHU1cDRQUWlIK1lDa2liVGFpV3BuNEZE?=
 =?utf-8?B?S3U5VkUzUGoxakNJaklkZTVRRnV6YUQ3cXhXVm5hQjg2U0d0ZGJmejF3VVhV?=
 =?utf-8?B?MHM5bkZWemE1Nk1xckNNbG5nZmhBSlBtV01oUnRlRm9FOEtmMDJqby9vSXZu?=
 =?utf-8?B?V3BsRjNPdDJGUFRNU1pZdlRCNXFqTzhaOFdpZzA5NjFjdStKVGs0WVRNUTdw?=
 =?utf-8?B?TFlYaVlFZlhSTTE4TUpiSCtPVTRra09GaGNielFlUEVKNlE0R0JyUnBnRnQz?=
 =?utf-8?B?TzdReWlhN0Nja0Q0c09maEJ0YjZzdUUwcUtnditCT1ZiMEYvekREWE80SHBu?=
 =?utf-8?B?azk5Q3RTQ29FRDh1OWo3dG5EWmVycU1iN3pQRmRxd3RpUVlER0wyd2ZJeDRs?=
 =?utf-8?B?cmpMdENYTUpSMTRTeUt1azN3T1F6QjhPS0lkWW5XbkpXZGNHSkxPSTZ0alIz?=
 =?utf-8?B?TDkwUDl1NlVBVDh2eVA4QWlUY1AvaVRXOTM4Mi9Bc1FaSmNKRzFzK04wc2Fn?=
 =?utf-8?B?RTBjM0ZRVEJVOHoyNlV2d01wTVpGYWl4VThvaEh6M0RPS2ZlRkswMDBnOFpl?=
 =?utf-8?B?UTlVMlJubVVXQmdCc2tnZHR0OVZSMm9Idnh5RUR1SytaY1RlZSsrV3k2VDM5?=
 =?utf-8?B?ak9uN0FOSXlTSm85L3pIcnZ5aTlncmlpeThoc2dUVk9XVGxiOFZPSzlWb0py?=
 =?utf-8?B?bm1KTHNiMXlCNlo4RFJtS2poOGVVMGtZSEZhd3EzN2RzYnBxOTdvNFBrQU1L?=
 =?utf-8?B?R1NBemc5QmJFUmpaTUxJUk9MVisvSHZMUWpSZW84MnFIMTZiQVFsZmNVbGJD?=
 =?utf-8?B?bEE9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad749ea-3935-4a16-692d-08db922c119a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 01:10:17.7054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBTNFV+nx8e3BZxWm/hhgtvoc1MvaSmqUVyDNHGlo2JFe5K7hPjkMRUSOocoYyVKPWb5y0lXR+2FhvI99No2UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7029
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/31/23 19:47, Meng Li wrote:
> The previous function will be deprecated.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---

This actually has functional impact; doesn't it?  Can you better 
describe the reasoning and expected impact in the commit message?

>   drivers/cpufreq/amd-pstate-ut.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 7f3fe2048981..9c889a4a0177 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -145,8 +145,6 @@ static void amd_pstate_ut_check_perf(u32 index)
>   	struct cpufreq_policy *policy = NULL;
>   	struct amd_cpudata *cpudata = NULL;
>   
> -	highest_perf = amd_get_highest_perf();
> -
>   	for_each_possible_cpu(cpu) {
>   		policy = cpufreq_cpu_get(cpu);
>   		if (!policy)
> @@ -161,6 +159,7 @@ static void amd_pstate_ut_check_perf(u32 index)
>   				return;
>   			}
>   
> +			highest_perf = cppc_perf.highest_perf;
>   			nominal_perf = cppc_perf.nominal_perf;
>   			lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
>   			lowest_perf = cppc_perf.lowest_perf;
> @@ -172,6 +171,7 @@ static void amd_pstate_ut_check_perf(u32 index)
>   				return;
>   			}
>   
> +			highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
>   			nominal_perf = AMD_CPPC_NOMINAL_PERF(cap1);
>   			lowest_nonlinear_perf = AMD_CPPC_LOWNONLIN_PERF(cap1);
>   			lowest_perf = AMD_CPPC_LOWEST_PERF(cap1);

