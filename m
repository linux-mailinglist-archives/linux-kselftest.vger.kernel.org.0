Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8E27A5121
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 19:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjIRRlK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 13:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjIRRlJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 13:41:09 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA4CFA;
        Mon, 18 Sep 2023 10:41:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdU5Co+oWYZm5F76sPgqSf+rrbf4T3RMgngPWm7QnXapHuyfzpDu/hBHQOpz99VeB4JecgVW9op2aeimt4jFQOntdlzHXr142DxEilWWDTZOfKEdDEEdHalDuX4dZW7SS6mN93LI0mcaGHK4QG+FWMx6hH+DWo1FVOju5i6qIFJhhF6d0WI0KG08Hp1VBK17KUnLJKF8LOnaWwZVWu+2B4Clvj4AQQ48ru6tmvkGrF8jXAJoGQI3fz28kqucJPiM8hPVnhds2im7+OlwaydUOtV4QkkXrzDMgjkbGd9hHpHKRt5Y2uZHhhA4A1325WnicCPylHeMmTc/zvhtS/Ol9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUSotfAZMYicWvsx6MjkMm/YAeC72le42oVNHidISGE=;
 b=gLNPzlflf7niwc+1m2srQU4MD7HSnUrtxyzS7QZ6jDBK2WozFXRVOQ0WK2Zb0bC1OAqVRwiZE5BpXqWEkAURCcdX46qicwh2vL5ZkAiOU7oDzLd8/8Iw8V5mEB0m/OMU2OjH8i31ASXU772P8sAOxtI3teHZrooN4IXzPM+jfGkdHqzZD26xw85l1Xo6Eo9v1rWBWKkTw+/uKVVIWP+oFPyCpwMk89XRykHHpNF+1H06hgMf6phW/1UaITrJhBHp8avEKcNalSbrPwa7Xvu/zsfF3luAClmvbxuZp0xsmwZuLPiq5ZYKi6Rgdm31mbYqZNPP7yGXIjTF078tRhFIhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUSotfAZMYicWvsx6MjkMm/YAeC72le42oVNHidISGE=;
 b=MjIP2tWb2Gg30g0/sIHs2Kv9/fVis6pA/lzhoB4aAtwfmCPKdDKSqcG2hcBHPwmf75uoYYwPBM+ALZ6zjsKv5MwJo1MR1jI5q+H9sbf1DT221HZmJB0FnkuHh3wKkLGZL8kK0zy41Ly36jlUUjxdfibxijG/axsRDFeZuwkewn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.27; Mon, 18 Sep 2023 17:40:59 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae%7]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 17:40:59 +0000
Message-ID: <8010edd3-6eac-4f14-a4ed-ef69cca63906@amd.com>
Date:   Mon, 18 Sep 2023 12:40:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 0/7] amd-pstate preferred core
Content-Language: en-US
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
References: <20230918081407.756858-1-li.meng@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230918081407.756858-1-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::8) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|DM6PR12MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: 186684e9-e98d-472f-1b85-08dbb86e6bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i0t5jLALP2bz957tnJ+Rx86c4X/+zzitg5AluTTGSwNE5mm5bCALqQOMMbI1EAfwRpyWabbaEQkBD7JEc0k0wmVzQcKz6/KZMzbI1Q2BcbgdogAE8x9trp61JEYiRlZF1vw/GqdGf1boDXr0DrXuCTD+ufkdXgkHjtZWrmWJkATvu2TLbQvmgD7MombYQj8DDyz8D9tox/x6o4++AYgak+AKM9CwKBVAFFr//i8g1QuMk8IeSots2v8DhwobwaE0kXeFYVWS+nAivlewzfhEeT2i7ayWC6RC/5wqCPv8NAb3tP0q/fZBsYCoSFkG/Jg7EFHz3eYA52SQQWXXNakPgFOntbSWRWaOnwrLaPvo0ptMv2jrn7RielZ8FTYyhdakUec5kHO4OmOS7n05bLgmd5o3HiKyFxjwCWP3JVy1l44AvXW4x1ssMdu/Scnar4sBuXLqpttrsdJha+kNxnpa3+v1O5Lefe5VH1tItuFptfrWCBrHd+eSMY9+qWWhJbnAKgBY6Yy2MBSAdW39F+FoHW4r06oFEWwPK1Vv9qxGkgL2gVkW9EBDtI0qFoAHHN8IyErWDQaK1rt1MAZCqnCMLA8VygT5WY/gnOmD8HuYVXlhEEAv96lxbrDFixsCdOEIsjuivd494N21XVzdGPNlZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(136003)(376002)(1800799009)(451199024)(186009)(8936002)(2906002)(8676002)(4326008)(316002)(41300700001)(6636002)(26005)(31686004)(478600001)(66946007)(66476007)(66556008)(110136005)(54906003)(44832011)(5660300002)(6486002)(53546011)(6512007)(6506007)(36756003)(2616005)(83380400001)(6666004)(38100700002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjdFY2FNNFF0QW9xaEFoZmxmS1JqN2pxWVhDS284eTVqVHh6UVJBdGkzdjZH?=
 =?utf-8?B?bDdGcEgzR0RveDFrYk53bnNDYytlL0k2dlpLTFVWdVNub0R3NlI5bU5GQnIx?=
 =?utf-8?B?aWlvSEdZOE5lbW5scTNBK2Rtd0V1dk95S2xjZlJmcnlXQVJMOXRjS2s0b2Ey?=
 =?utf-8?B?VVFSdUYrYUlrajJKTjBjamlsN1pjb0ZNNlkwVmZSeWY4QWNzSlZzb1QxekR6?=
 =?utf-8?B?TVljNjM2czNValBKLzZjbGFJSld1ZXpCWnEvN3AvWkV2YkxYclY4MTBqcWdi?=
 =?utf-8?B?Z1E2UTIrTFBEMFd2VjROZEhWNkJhb2YyYzVnUkpkV1R3c1g5NTdtd3FWVVpU?=
 =?utf-8?B?NTlCRHNMVG1qZmNLcVhjRGI0Tnc5MExHQUpJa3NUVUljbzArUThYK1JvM3dH?=
 =?utf-8?B?eGRTQ2FLbHBjcGQrTHlWVEpNdEVEWGJhUFplTlVrZXIwQ3J0ZnpXeVFReFBw?=
 =?utf-8?B?OEJ4dUxpTFZnVkUvUEZyWm1LWEEycGVMRFdpVUcrdEpTVVJSSTcrS2lRaFBo?=
 =?utf-8?B?d3VWbi9oamN1YnBmZ20xczNtVTRWSlZJTmhzWXJQMVY2T0wra2d2MGVKUmV6?=
 =?utf-8?B?OW5xOVM3aEpteUxBMiszWnNvNE9KVjF6aXVrcFEzQXF4K2c5WjMvR2pFRGRI?=
 =?utf-8?B?NWJXNkxBZ0x3QzlhYzJsb1BkZCsxTnI1STBMM3JKNWh6bDd1eS9qa0V6aExw?=
 =?utf-8?B?TTdNQlA0bGtsNWNMS2lOUDBoV1R5aFpqdFg3UERNd1Y5Zmk5YkY0cUtwcXpS?=
 =?utf-8?B?bGdJZTZ5K05McVorNW8yUXZqM1RHQkVwUnZ2MmlyNnpzdCtCdE9xa3hJajRP?=
 =?utf-8?B?T3MyaUpQbTZyRUM1UnJRZ3pEbEpDL1htL2l3UXJPSEswZktXSFZreVJkVDhy?=
 =?utf-8?B?cCtrUWZ0RWtvV1dQU1hra0F5WDk5VElXS20zSXFuMGRsdjN4ODF2bFAyR0hE?=
 =?utf-8?B?ZVVjZElta0F2ZXlSNW5VcjNmMGljZExSS0NPQnF0b2Q1WmZtTW5uem9hYWov?=
 =?utf-8?B?VjRRUGZBS3k4YmZCM2ZNMFBEdEw3SjhPODFsR2F3YnZwS2Rqc3ArVzFqdXdK?=
 =?utf-8?B?N2hRWEoyNVRvUnhYZkZrNG95MitqV0NUM0N6RnRnTzVPTzlibnJndmlXbDRN?=
 =?utf-8?B?dmJJZkdXcGlTY3A1RCtIS0VTMm9ic1h1MkplNENTMWFqM0VlT1V4bFhaS1d2?=
 =?utf-8?B?djRXK2pXRDNBTHE5ZGNWSVBjODdlTlBkemJ1MnAwQlJRK1I1M09sTmpKcTF0?=
 =?utf-8?B?dFdEeEQ1aEhrS0JHS3U4eWpYZ0paSjBrRC95Q3VvYnE2SlBWYXJjZ0NMVmlo?=
 =?utf-8?B?QWlDY0R5OFlBb3cvNzY1cUR1dTdpL2FaanZ5Yk9ia1NHaXVNTzRvK1NyUTBV?=
 =?utf-8?B?VG1WU2hoVndKWlNjMUtvelZVNFhRSFBZeEtzVTY4eE1xYUlFMVdFek5UUGVW?=
 =?utf-8?B?NndPRURaazd6VWNTNHk2ZWF4N2ZYMmF5Q0Q5YlhaZzFYb2JDc1p6a3Q1NFhJ?=
 =?utf-8?B?Q3FVRVBrOXhVaVQvbzhTcHU2OXVFd01URC9kWlBEZ0RHaXdnK2xTT3B2dXFK?=
 =?utf-8?B?Q2RndGNBbTZJV3BCd0U0M1A1ODF0alBxNUE3bkFobDhEQWVkYUl0UnNIa2Fh?=
 =?utf-8?B?djJ6TEI4VE5yRDhaRGoxWmFJQUlXTThhM05VdTdpbHdaanl5bXRGbi9CUkNJ?=
 =?utf-8?B?d2R3ZldEZFpwVWUzVG4xUzZMbGx1UVdRdC93MFNsZlEwakdQRVd1aTJVc0p3?=
 =?utf-8?B?OVc0eERwd2Q0QlRRYklQSlJxSUszY0ZqYnM5cUcwV2xXQTBTR1dZNUhhcFNl?=
 =?utf-8?B?eE1RRVQyUURmeEdNMEZUOGY5ZkpjQWdJRUw0ODY4ckd1Umx2TlV1SXVLcDNh?=
 =?utf-8?B?TnJOcHR3QmsrWE5vZDc0TFBuMk5ONEw5UFAwS2FKZGtLd3JvMHl1NzB1ZUpQ?=
 =?utf-8?B?c1JncjJITzJ4M2VpSUowWEpQTm5YdUVBYStBdVRWSjk1NHNPNXphL1gzSDZi?=
 =?utf-8?B?cHJycUdLcVI1eE5iME00eWI4ZzdnclVCQkd3TVh3akdNRjl5NG1PLzVyQ1Zp?=
 =?utf-8?B?T3BOa0FEVTZYWjFhTVFNN1FncGIwSGdZQ3hzYW1LeXFnS1hHZ0RwU2daMDdy?=
 =?utf-8?Q?nddRzklrmPa6FD0fcji7G4HB1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186684e9-e98d-472f-1b85-08dbb86e6bbe
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 17:40:59.8593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hw2amCWIvo1dMZk7Ea6aVAFJHsN5vqs/zMDeAT5seTwqPvALPNfL0MeyhAGVTeSodqu5+dPQDZ+5MUY7CM1x+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/18/2023 03:14, Meng Li wrote:
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
> Earlier implementations of amd-pstate preferred core only support a static
> core ranking and targeted performance. Now it has the ability to dynamically
> change the preferred core based on the workload and platform conditions and
> accounting for thermals and aging.
> 
> Amd-pstate driver utilizes the functions and data structures provided by
> the ITMT architecture to enable the scheduler to favor scheduling on cores
> which can be get a higher frequency with lower voltage.
> We call it amd-pstate preferred core.
> 
> Here sched_set_itmt_core_prio() is called to set priorities and
> sched_set_itmt_support() is called to enable ITMT feature.
> Amd-pstate driver uses the highest performance value to indicate
> the priority of CPU. The higher value has a higher priority.
> 
> Amd-pstate driver will provide an initial core ordering at boot time.
> It relies on the CPPC interface to communicate the core ranking to the
> operating system and scheduler to make sure that OS is choosing the cores
> with highest performance firstly for scheduling the process. When amd-pstate
> driver receives a message with the highest performance change, it will
> update the core ranking.
> 

For the remaining patches missing my tag:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> Changes form V6->V7:
> - x86:
> - - Modify kconfig about X86_AMD_PSTATE.
> - cpufreq: amd-pstate:
> - - modify incorrect comments about scheduler_work().
> - - convert highest_perf data type.
> - - modify preferred core init when cpu init and online.
> - acpi: cppc:
> - - modify link of CPPC highest performance.
> - cpufreq:
> - - modify link of CPPC highest performance changed.
> 
> Changes form V5->V6:
> - cpufreq: amd-pstate:
> - - modify the wrong tag order.
> - - modify warning about hw_prefcore sysfs attribute.
> - - delete duplicate comments.
> - - modify the variable name cppc_highest_perf to prefcore_ranking.
> - - modify judgment conditions for setting highest_perf.
> - - modify sysfs attribute for CPPC highest perf to pr_debug message.
> - Documentation: amd-pstate:
> - - modify warning: title underline too short.
> 
> Changes form V4->V5:
> - cpufreq: amd-pstate:
> - - modify sysfs attribute for CPPC highest perf.
> - - modify warning about comments
> - - rebase linux-next
> - cpufreq:
> - - Moidfy warning about function declarations.
> - Documentation: amd-pstate:
> - - align with ``amd-pstat``
> 
> Changes form V3->V4:
> - Documentation: amd-pstate:
> - - Modify inappropriate descriptions.
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
> - - Use a single variable to represent the status of preferred core.
> - Documentation:
> - - Default enabled preferred core.
> - Documentation: amd-pstate:
> - - Modify inappropriate descriptions.
> - - Default enabled preferred core.
> - - Use a single variable to represent the status of preferred core.
> 
> Meng Li (7):
>    x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion.
>    acpi: cppc: Add get the highest performance cppc control
>    cpufreq: amd-pstate: Enable amd-pstate preferred core supporting.
>    cpufreq: Add a notification message that the highest perf has changed
>    cpufreq: amd-pstate: Update amd-pstate preferred core ranking
>      dynamically
>    Documentation: amd-pstate: introduce amd-pstate preferred core
>    Documentation: introduce amd-pstate preferrd core mode kernel command
>      line options
> 
>   .../admin-guide/kernel-parameters.txt         |   5 +
>   Documentation/admin-guide/pm/amd-pstate.rst   |  58 +++++-
>   arch/x86/Kconfig                              |   5 +-
>   drivers/acpi/cppc_acpi.c                      |  13 ++
>   drivers/acpi/processor_driver.c               |   6 +
>   drivers/cpufreq/amd-pstate.c                  | 197 ++++++++++++++++--
>   drivers/cpufreq/cpufreq.c                     |  13 ++
>   include/acpi/cppc_acpi.h                      |   5 +
>   include/linux/amd-pstate.h                    |   6 +
>   include/linux/cpufreq.h                       |   5 +
>   10 files changed, 291 insertions(+), 22 deletions(-)
> 

