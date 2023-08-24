Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45FF78654E
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 04:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239424AbjHXCYW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Aug 2023 22:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239420AbjHXCXv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Aug 2023 22:23:51 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDDF1AD;
        Wed, 23 Aug 2023 19:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsdxzDQq7mjqMI50A1j+ePv1iZWL8m57XvUM+zoGlrYk1afxK+OVBRIlizvtT6X9n4ZACCZ3poDekhdFnueEgOhVc5wpDwDdYuMQw3fkwDUMyB+qUUGenrT9kvGAKEV0AePvZN0e7ph9LMVPxTlzzhKjmEelo9I//P0TUaDU3dtWOttvqfXrJhK00NhkttoeAdAEUnh4DnB+BMClyuH8fcSzuwPQLdhOikScLP3TvtU/1ySdu87Jk0m9ZKs1VU1hedpxkLk6B/nxzgPnivYsfAGHG1FY5taKMxO/PeldLlxgg50iz6dEDDJtelRzvdu4GNsyBfCB2L20YvzN+Ft1zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wm8IH78cJyU/+2IUEryq2x1tfiVjOrnWMNwoLx+w/oo=;
 b=XHH/LpslX41D78qJ/xCNFTr4p5smQ7EGjPNFCz1jb9SPqZ+6nwbGDj8kbxnzftjXAZiVgHZ7cLbFQ38NZ3lvalPLdT0+FT+xj349CaKZQCN0zeBt+OvTtkxLN8o/YoT6EYAWz7Svg2yns6Kop0lY6nJvNEZdR7WllpxuCxiTCAbDMFSWCzOMZJRMJPqtiD2k2axohQnOkYqUXeRzSAr5E2/mBxopTLYSEkglf644pMAGCEvdxZYU/p1V035MXkp8q70MRiga9cOXd9gIkw8sN1Qx7tmWzklbo0oali4LD7wbOoFtEoL5DtFDPRHPBKJ/W9YWXekr9wGbC8uTxNGWGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm8IH78cJyU/+2IUEryq2x1tfiVjOrnWMNwoLx+w/oo=;
 b=kxueWNTtY6R9jU+6u+3JLhQQpw7DVcqcysj7+8r+MP0ncNCiPC1WN3rnvKnB7CKgaIaDaVFx7Qb/XnW8cy/hwRoxm9b8rmHRzff1wn01/+Yl81BQMh153Gfd/hzmNr8FVaDW4EHmYE0KTfeNNJeRh3j33FxAm0DhbRJ+obLFHio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4497.namprd12.prod.outlook.com (2603:10b6:5:2a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 02:23:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6699.022; Thu, 24 Aug 2023
 02:23:43 +0000
Message-ID: <597bea76-b638-4ed2-9238-9b0518d379b2@amd.com>
Date:   Wed, 23 Aug 2023 21:23:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/7] AMD Pstate Preferred Core
To:     Meng Li <li.meng@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-acpi@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>
References: <20230824021249.271946-1-li.meng@amd.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230824021249.271946-1-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0047.namprd04.prod.outlook.com
 (2603:10b6:806:120::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4497:EE_
X-MS-Office365-Filtering-Correlation-Id: 91cd6f5c-beba-4bac-c423-08dba4492307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g+2DUK0tFAYIXvCb6DLo4Ouco+QKI1/BYL26W9pJBczkE4XKkw+8S03hatoCZkDfK9pZV5LmRo2yuS1IIpfaArBlaJHANw9h5RkvHZfFksC7o8t0gaD4WaWv3513uwMNb0VEmMzAJsX1uW4ISjMla0G33dQAgAlfyOYXsyvbEjk+OLLvjsmty4Yzx52TPWe7VwmEP0doQOapcB+zMcg/rh+Qy7oUB/cYEVVy+XrI+Yych9dhRGWRv3edB7zyKul4oSRQV+mha/mGZyzVA8aADP4Hs3PGlmXonzI3qh9u7S5bkPuOW2BXX+7fsIraVb2Zt9qUlCXvsKB2zYHRWDfwohi9v4fvb4Tx66sf4OH0ZmOr6X14tVI4Daja1wxC/CU7F3t2i3UxkIbE9H5H2JQ8Hb8maGkadZSoQQehTrI/9+hUQGgWaC3KtQh5VMXjbw5td8E7ts2v9nShyHLFiqfMBg4xP8sFDSpfPXyWJ6PEpO2KXjcu/0oM+c8u+7Q37tr5YF6l9DaZ5Rn2nTdnk15Q/4wvkXWJHU/fqDsa8UN4RiS2Dsr8MtkBJmR6yiwDkOMy+aT2qRNHSZ8HL7UCz14t+/tYtU6SEwkhiY0DmZ8hhn3NKZdkTFWTTeGR4bzFMaBCHwfpAQwb+GRRyM1wBznf8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(366004)(136003)(186009)(1800799009)(451199024)(2616005)(5660300002)(4326008)(8676002)(8936002)(36756003)(83380400001)(44832011)(26005)(6666004)(38100700002)(66946007)(66556008)(66476007)(54906003)(6636002)(316002)(110136005)(478600001)(31686004)(41300700001)(6512007)(2906002)(6506007)(86362001)(53546011)(31696002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzNBNGhZWS9FeU5sOThnQ0hUYUpPV0xBckRBYlJNcnloNVlOZ3orQ0ZLRDVU?=
 =?utf-8?B?Z2F6UEdnZ0Y2cTNBYmp0dHRqOU4yNCtzQTRST2hzd29NMjBvN1NTek5hL1NS?=
 =?utf-8?B?VE9LWitrMUp5REEyZlY4eENsRjB1eXVmR0RYVWRJZEhvT1kyNE51NGg5YUZv?=
 =?utf-8?B?Y09BRExlSGZuMnpBZ1grNUJTMjFHTTVsV0JRYTdTUEFUNjlQbXZPT3hqSy9a?=
 =?utf-8?B?b1REMWdYakJhWmxnS0swTHY2Vnk1VG9tdEcvVFBnU1k2RS9VS3R2dVNjRmpi?=
 =?utf-8?B?VzBlTElkWEtxc25USWV6Z2t3Z1JDbU9aL2J1VkZYaFJnOVQ0SHA0Y2hIeG55?=
 =?utf-8?B?czJvYUMzY0JGVU81dGZNUzM5d2NiVFFJTEthNEhYNlB5bU9KVkpBYWMrTnIz?=
 =?utf-8?B?ZEpIVjB0YkU4R243Y1dyWjdUVDJYeXlJT0ZDWms0YzkvMi9zeTlBMS8zQ2hj?=
 =?utf-8?B?M3doSHNKYk1sWmVMZlFQbW1ZZXBScW1pTFJ2YnhiNStWaUVtaVFlYXNwTExz?=
 =?utf-8?B?bWFqV3JVSkt6K0JyMlMzQW83NUZhWE5LZWVDWEc4MVFHeGE2MlB3bnArSEtN?=
 =?utf-8?B?dzhSQ1lTR1N3OVVabXYzUm4xNHRzM0ptcS81d1ZkNnJRV0pYNGNvUUh0M05Q?=
 =?utf-8?B?SUhRK2FOZTBsd0ZYa2JpM29Xcmp3OWxvcnBBZ3NtSURoU2x4NXFVZVBjL1JN?=
 =?utf-8?B?UTFsY0pqd0VsL0xycCtvK09wN0xzMTFpYVl1eFkrVDJkeGppTkNmTTE4MWN1?=
 =?utf-8?B?Nmp0UDI4c0lncElNRnhwTDJEb25GdnRTRTJmM1VuenRRV21mQzIwZTlvNWF0?=
 =?utf-8?B?Zlc1bW9oL1VVYXo3S2wxMis3SldxOGRIeUg4WmZtL2lydkNOSVBLb3ZheE4z?=
 =?utf-8?B?ZFVNWDZmYUM5QlJiUS8rOE1NV2ZBOEZjWWIxWFZndkZPdHdNeDV1dEhaSUZ2?=
 =?utf-8?B?NnRRbFNBcTF0Yno3bjZEdzVRUDk3cTNYcXpjeWw4bCs1UER1aEM5cEpXdXFj?=
 =?utf-8?B?WEc2Sk0vZ2p4MldtcWhLajBuRHR3TEsybU9iaXRCdk8xVEpnUFpDbjdHSTh2?=
 =?utf-8?B?R2FaU0RseEZNbHplQ1lxNUg0VGNCUmtXRnBUajkxelg4eENtZ1NaYXRxOFh2?=
 =?utf-8?B?QmZDcHJQOUJIYlJ4WGErMndSVitxYW5CQmdBdW9vdFlmczRWNmRUTU9pcTZX?=
 =?utf-8?B?UlJsR1NUWStjZUJZK2RQTytPNmFNWmRWUi8rRnk5dDBTL3F0blZCblJLL3gy?=
 =?utf-8?B?MVRWUy9KZnlJanB5R3grZlRQWUQ2L2tublh1YVlvUkJtWjdiKytqT0lCOERk?=
 =?utf-8?B?UFNwQnRBWW1tUmJJRnZoZ3c1UEhFSDB3Y1NJNS8vTndVVXI1bHpKV1BwaStV?=
 =?utf-8?B?cHRNdG0rREZCWTIzV0MvdzFpWnp0aTBrZmVoakRuR2grRStHZDArMXhpUnU2?=
 =?utf-8?B?QjV5SjlyNSt4MVJKRVdLb3NhbXdDZVV6akNGOWpQQVgzai95RXlhNVRQS0R6?=
 =?utf-8?B?T3QyUWd0am94WVpRSzRqM292WHZtOXhHSnFOd3JRMGRjV3pIckRiTWRtV2JD?=
 =?utf-8?B?c2VDeklaeW1VM2I2TWUydHJTZkJidytPR01TTEJiZEZxWG90MW9JSy94VVFn?=
 =?utf-8?B?dHgvSHJObjhDenNNbDR0NEYyb2d2K3JVSm5GRlFvWmVJdXBQQmNLeDlPQXJa?=
 =?utf-8?B?ejJHR3BPRElvVWZwV25ncmdETEtIVUw0b2ZMTW8wSEIveUlJaWtLRWYzNEkx?=
 =?utf-8?B?c1FzTXBNM1JyMFFFY1grOGdLVFVJaksrdEtkRUJ3YWxUbWxlTHBrQTdyMHhM?=
 =?utf-8?B?OHFoK201Mzg0T2R4Sys0NzBzSGhhcWxDZXdHd2NNdHBzRVgyTWlhL2VQMU12?=
 =?utf-8?B?eVFSN1owdzVYS2pnNFFrRlE0UmJETUM0YnVJc3VqWDhvMWVvUFdUT01ObHM4?=
 =?utf-8?B?am5TckgxTGV0VldGeXJrNUxnYk9RNCtJeVpHeWorRW9nNlJ5V0J1N3pTSnJt?=
 =?utf-8?B?QXVvRlBmcnlDWDlVY3Y4cDFjeG4wWWhHay9Vbk5VbHMvYU0vUzVCRTlzS2wv?=
 =?utf-8?B?eDZzTjg5NUoxNW9YZmpaRWpzNUU1STNydVMrZHdFaExYU1h4U1lrUzVoNmwy?=
 =?utf-8?Q?XiUsDP3KN38ScOh+g8hPTj0Rq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91cd6f5c-beba-4bac-c423-08dba4492307
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 02:23:43.2140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqI1fAZnbNZ42JpEOtgJyLk8D2TmK7ethMGzXe7yAFVgO/2yHrIYFVceWdUXK8+3/en947LvhiMxYjftwd4mBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4497
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/23/2023 21:12, Meng Li wrote:
> Hi all:
> 
> The core frequency is subjected to the process variation in semiconductors.
> Not all cores are able to reach the maximum frequency respecting the
> infrastructure limits. Consequently, AMD has redefined the concept of
> maximum frequency of a part. This means that a fraction of cores can reach
> maximum frequency. To find the best process scheduling policy for a given
> scenario, OS needs to know the core ordering informed by the platform through
> highest performance capability register of the CPPC interface.
> 
> Earlier implementations of AMD Pstate Preferred Core only support a static
> core ranking and targeted performance. Now it has the ability to dynamically
> change the preferred core based on the workload and platform conditions and
> accounting for thermals and aging.
> 
> AMD Pstate driver utilizes the functions and data structures provided by
> the ITMT architecture to enable the scheduler to favor scheduling on cores
> which can be get a higher frequency with lower voltage.
> We call it AMD Pstate Preferrred Core.
> 
> Here sched_set_itmt_core_prio() is called to set priorities and
> sched_set_itmt_support() is called to enable ITMT feature.
> AMD Pstate driver uses the highest performance value to indicate
> the priority of CPU. The higher value has a higher priority.
> 
> AMD Pstate driver will provide an initial core ordering at boot time.
> It relies on the CPPC interface to communicate the core ranking to the
> operating system and scheduler to make sure that OS is choosing the cores
> with highest performance firstly for scheduling the process. When AMD Pstate
> driver receives a message with the highest performance change, it will
> update the core ranking.
> 
> Changes form V2->V3:
> - x86:
> - - Modify kconfig and description.
> - cpufreq: amd-pstate:
> - - Add Co-developed-by tag in commit message.
> - cpufreq:
> - - Modify commit message.
> - Documentation: amd-pstate:
> - - Modify inappropriate descriptions.
> 
> Changes form V1->V2:
> - acpi: cppc:
> - - Add reference link.
> - cpufreq:
> - - Moidfy link error.
> - cpufreq: amd-pstate:
> - - Init the priorities of all online CPUs
> - - Use a single variable to represent the status of Preferred Core.
> - Documentation:
> - - Default enabled preferred core.
> - Documentation: amd-pstate:
> - - Modify inappropriate descriptions.
> - - Default enabled preferred core.
> - - Use a single variable to represent the status of Preferred Core.
> 
> Meng Li (7):
>    x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion.
>    acpi: cppc: Add get the highest performance cppc control
>    cpufreq: amd-pstate: Enable AMD Pstate Preferred Core Supporting.
>    cpufreq: Add a notification message that the highest perf has changed
>    cpufreq: amd-pstate: Update AMD Pstate Preferred Core ranking
>      dynamically
>    Documentation: amd-pstate: introduce AMD Pstate Preferred Core
>    Documentation: introduce AMD Pstate Preferrd Core mode kernel command
>      line options
> 
>   .../admin-guide/kernel-parameters.txt         |   5 +
>   Documentation/admin-guide/pm/amd-pstate.rst   |  53 ++++++
>   arch/x86/Kconfig                              |   5 +-
>   drivers/acpi/cppc_acpi.c                      |  13 ++
>   drivers/acpi/processor_driver.c               |   6 +
>   drivers/cpufreq/amd-pstate.c                  | 152 ++++++++++++++++--
>   drivers/cpufreq/cpufreq.c                     |  13 ++
>   include/acpi/cppc_acpi.h                      |   5 +
>   include/linux/amd-pstate.h                    |   1 +
>   include/linux/cpufreq.h                       |   4 +
>   10 files changed, 239 insertions(+), 18 deletions(-)
> 
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
