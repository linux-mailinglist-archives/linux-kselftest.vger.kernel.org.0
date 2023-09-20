Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8111E7A89CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 18:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbjITQ4Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 12:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbjITQ4X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 12:56:23 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8C5D7;
        Wed, 20 Sep 2023 09:56:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRxekkOAxp8Zb8H2C50QFt7TL2Ym6AXxgI4iK5dcUfwBhRIH3k79jHHjJx7pDPS4OEXgO+zXXYpqLCwzPL7B2mT+MrwLaaOfpUl8ORgxplG8yd6+knd3nKhFaPyupTXJN+/DmB6TRdQeOmD7d0qMrzqJPEb99yvHsIPDlJzB+7JCwj6g2Cg0tlod+LcJoY3GCpxgOxvGzky1ZPhjq4A3vEugCaP44D7Inekl0HDa2qwzCwv7o8gwRssM0rejiAv5RI2R3wjLpZM6cinUCxQKgxJ8gH4KTaBOx2IPYW0Qsru/ykPU67FFrWjiS9ykJueI9JwLsljjQGYzqMwFsWu/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HvY20Q7yy82YxnON95NQ/szWgHoFK3SiLu+SOShvwE=;
 b=TQ5nPPC7WbM0KIkmcLOcrguH4+YPBRlilnAERK8RYkUkmM526RjeZ1uJ3BFhcvmGRwzd6GItuhS6f6xn7P8vcCFY74VEGETyH1r4yvsgRmdVmoAYPnmrfdrabYrdMaqxNO6DAWyA3qN8QGK6IEUWtMQa5KVRJBi8W7nImUQUVLuDyPZK1KXqeEGfT26Qab49HwVDtcLq77eFn9KMu/vbKIDHQoYnzPBihqS9UgP9vF9bMly5BAkg0FY9hKvSprXBG9hu1IpNlQq0BJ3UMAuINFY8BLbSJZy+EJ+9hM3NkAH4+8v5Zil4HjghAfKnUHCHqydMmitFefS0y2+V3lclyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HvY20Q7yy82YxnON95NQ/szWgHoFK3SiLu+SOShvwE=;
 b=MBfFaa66wHcPnXMJgOUMpZ4vQp0tipAKTYqMy3q4R1/EqtklF3Vg1pba3OGu1bX/aMYUkJ09Y4OthldmynYcsze3CypXuU/JCSzrAF93NsVKoNwirF0VJzdRp/BUnvw7d4Hx45Hy5LCqvvfmL9LB1ycSaoNABzytNs234WRsQcA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV8PR12MB9406.namprd12.prod.outlook.com (2603:10b6:408:20b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 16:56:14 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 16:56:14 +0000
Message-ID: <ce377dda-e1ce-4553-b9b8-125620b8b2d7@amd.com>
Date:   Wed, 20 Sep 2023 11:56:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 0/7] amd-pstate preferred core
Content-Language: en-US
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Huang Rui <ray.huang@amd.com>, Meng Li <li.meng@amd.com>
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
        Borislav Petkov <bp@alien8.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20230918081407.756858-1-li.meng@amd.com>
 <5973628.lOV4Wx5bFT@natalenko.name>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <5973628.lOV4Wx5bFT@natalenko.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:806:d3::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV8PR12MB9406:EE_
X-MS-Office365-Filtering-Correlation-Id: a62ef47e-ddab-4a44-8242-08dbb9fa7fb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zJLyXUIKrgi9geTjgh4uuiccg7oYQScpAcPRvyL6wLaJ8eil/c4l1ka+CK4lzm6ziohbKDQrY4KixN6sUrjMNen3rg53szeqbewApejBkpEjw8+9yV8xm20eHgoRuiuvyOzSrM+IAPUaNyt6/PL/ArNlxirq0dU1182IiUo6/Gj5mInqT/1MYI8j5GblhhAM6VHTBWJOGpArhgJeYPqnFwDGEkmW6Ivzfsqe2WjAYLc7mg9BNcjgTLrJg5xiwvYRCra7zzxiQQTYyMGOwDhfVTfp9W5BOBVT+KkoS+ToaLitx/uKJbE3QeJoIFLBs3UD2GLg0kSl7tLM3xfjYWTqvsQevssNz0qBkMLdG7+chtt7Uhq6nnCOqn0fRO5MHk/PfUCXJEnWa83qWNgm0XvSKB/M+02BD14IuieLCokUo8i1rjg9OV7lryoHSpafRkg6fN9kvPs7gZerU6z8wxgulL5+132q2ag8DsnqhOZAF2m7C9NWk2Bm/+0Blf7e15SAkkE+nhveOXxKSuFYM71hXgDxAVuxGhoOjugLdLXqMuXt51dD3S+aegInDELS+/Taqj1ObUWbRqHcc0BJPHa/SkFg5h2r3LewJZtr0eEPN37xc6s7ALPtIWoGgpUcEdcLVmObQjIwgufqVf5yrzWRsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(396003)(376002)(1800799009)(451199024)(186009)(26005)(36756003)(8676002)(4326008)(8936002)(83380400001)(2616005)(7416002)(2906002)(5660300002)(44832011)(86362001)(31686004)(6512007)(6666004)(6506007)(6486002)(53546011)(31696002)(38100700002)(41300700001)(110136005)(316002)(478600001)(66556008)(6636002)(66476007)(54906003)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0FHd1ovK2ovaDhLT21aMlRibG5hMm9xTmdiSUdnWmhOSm4wRmtmL1JOc2Zr?=
 =?utf-8?B?T0p1bTJKbnpZOHpXZEJEYmkyZWs0L1JsK3Q0V0gxMkZBenVOdFlVZVlTbTFL?=
 =?utf-8?B?T091QTVWSC9KdXNLMllnS0ZHN1hqN2loOU44V0NxcHpVcUhOK1NLdHJtY3hE?=
 =?utf-8?B?T0VMY0ZvS2lPdVFqZ0xEdE9VVUZQNENTT3U0RjJRaXoxSXg0MURJMkxaMGta?=
 =?utf-8?B?S3NXVzJWRkpTcHZ6YmowLy9CSHdVMDZGbkIrYVQ1MEFIb20xWUc1eFFhVDVO?=
 =?utf-8?B?L2UrWWtCQWdvNVF5ejVFK09VS3lzOHBiYnJ3cVM3d2k2Rm03b3VhOWZOemtI?=
 =?utf-8?B?Vk4ranZUNk14NGdWNWJKOXQvSW96Z3h0ZVA5TTVJUW03MkloWERNYWkrQW1E?=
 =?utf-8?B?eGhlbjVCWXRTN0gxWG5Yb0xqMFNOdTRMbkcvS3I0a2huTUoyVWh5VWthNm9U?=
 =?utf-8?B?NXJ1RGhyTUpxN1RXdjhCc28zWGtVOUxVYWQ3UnR4ZHlnWThqRHg2NS9PMWVW?=
 =?utf-8?B?VkFZS0tQbXdMTkJ5SVdTUUpvMllXWHcwSWUvK3ptWnJOMklCSXhxSklMb2xm?=
 =?utf-8?B?WjcyOHltd253Mjh3Q283NThwSUlQSjd0RWZJcm90bEY4TmpqT1RYTnhteWlC?=
 =?utf-8?B?UUVFSzUwMjluMFRhN3dyVnB5bGlEaTVxa1owSTk5S3R2NHU0QzBuODByNjJn?=
 =?utf-8?B?b3pKTnJZa084eUowMXlGQW9tZEUzSEJHa0pZOWFPVWRnKy9iYkhlbWxVeVZw?=
 =?utf-8?B?N0RuSDFpNVNnd3pCL0x0ZWZBaFplbTVWbGhpbXhCUExYOTdlbmdTS0RTNGxL?=
 =?utf-8?B?Yzk2ejNFSjBLd0VLVXhQOGN4VXp6SU1iek5IQ1NNY1lsVzhvNUY0RzFDYllS?=
 =?utf-8?B?bE1lbGFvVW1aTHdYSEFRQmF2QmViWEpKVkE1SFVITWhZTERLTEtOWU45cmhw?=
 =?utf-8?B?dnZVejZEdW1CNDB5OEIzRXM5QkxEVW1nRDIvOTFhNm5CV1RVMS9RSHlQS0lR?=
 =?utf-8?B?bWN0a285WHg5T0pUVVh4UXhweDNJODQ4TEhaaFZaNjZ3aUtZZGJ1RFFIUGtH?=
 =?utf-8?B?QU5FdnN0NEpCN29sMFJIL0htdUFuZldta1RSMUxPNUw0Y0llM2VEaS92amo2?=
 =?utf-8?B?MHdtQ1hKNVJMaEREZWVWU1A1NU5lc28rMnB6SUNkY1haQXRWa2RnYWdoK0Iw?=
 =?utf-8?B?c1ZUWjd1Qk1ydWtKN0Q3bE9GVERMcnluYUVoejdabG8yRmord0RzQkR1Y2c1?=
 =?utf-8?B?NXc5Ri9MYXMzYjc0TEVPRjl0SnZxMUJjWlJYZW14UzhBU2NmTE5JTFRta2JT?=
 =?utf-8?B?elVkTCszWWRXVXlINzlJMjFadkhEMHlvaC9Yb1dndDRlOVRVWitmUEx1cnhv?=
 =?utf-8?B?RXFlQ0F1WlV5WFR5Q3dZOVdPdHIxTzFOcUlVcTQ1bUFxWHFDRDlIN1RUWlg0?=
 =?utf-8?B?enZvRXJXZGpUSVgrWVJPZUxoWFBxeWNwa0RCOW5zSk4zWFcyT1Y4d0tlYXdj?=
 =?utf-8?B?WnpwZjdiRURDOER5T2xYOFlJbE1qRE51N3dTOFZkT21Pc29SaDRlOGc4R2ht?=
 =?utf-8?B?TDlNOHl3TjNrSGFDU2NGTUNoelRFRlFXV3d0WEFIUXp5YTRsOVJOK3FxeEpy?=
 =?utf-8?B?OUJXWFFwd1dWbFoxK2xncDJSQUVQeitOSzF6dURTMXlHQ25uUzI2djBFSHF3?=
 =?utf-8?B?aTJYQ256dXlwa005cWJ1WGdRVWh6YW1XV2tLc0JXWjlwMGt2MERSU2xVbG13?=
 =?utf-8?B?YisyVWs0QUJpZ2hWS09uQzhKWEp5anVSUEhSRnZHNit0YWRpWmNEL0xrMXIv?=
 =?utf-8?B?U3cyWTY5OWdlTmtiZi9ZRVVCNDBseml2My9UR3VYcnVsdkFHL1FYQUdFQjYv?=
 =?utf-8?B?ODJoa0FPOW9BTHNpTFRLSWpmUUZCamZtUWR2WnpZSjFtcG84SHEzWXRIRWdq?=
 =?utf-8?B?aGl2a1RyQW9WTmtpZ3VKWWNzc3kwS210TkwzUVgxOENpdW5IKzZUMmJCMDRP?=
 =?utf-8?B?QnJGS01GL3lKMnFxSWNsL01odDl6ZERsN2JnaWk2L2JwOHE3TUZWazA1TXI3?=
 =?utf-8?B?dDlPQ1hpRWI5TmloUGMvYnUxRkpGUm1HWFZzbElLdkhoeXJQN2tHU0p2L3Q2?=
 =?utf-8?Q?dW5vChsdDvhenMuEQhBPklc1f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62ef47e-ddab-4a44-8242-08dbb9fa7fb5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 16:56:14.1274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CvZyAr+OWN6hhnwf6cD1vqJ6HrZoG+5joONgGO3fTz3Tw2ibpbxH83AXs1bqpFsaoDXoUbTMbI5LI7MM23ZzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9406
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/19/2023 14:01, Oleksandr Natalenko wrote:
>> Meng Li (7):
>>    x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion.
>>    acpi: cppc: Add get the highest performance cppc control
>>    cpufreq: amd-pstate: Enable amd-pstate preferred core supporting.
>>    cpufreq: Add a notification message that the highest perf has changed
>>    cpufreq: amd-pstate: Update amd-pstate preferred core ranking
>>      dynamically
>>    Documentation: amd-pstate: introduce amd-pstate preferred core
>>    Documentation: introduce amd-pstate preferrd core mode kernel command
>>      line options
>>
>>   .../admin-guide/kernel-parameters.txt         |   5 +
>>   Documentation/admin-guide/pm/amd-pstate.rst   |  58 +++++-
>>   arch/x86/Kconfig                              |   5 +-
>>   drivers/acpi/cppc_acpi.c                      |  13 ++
>>   drivers/acpi/processor_driver.c               |   6 +
>>   drivers/cpufreq/amd-pstate.c                  | 197 ++++++++++++++++--
>>   drivers/cpufreq/cpufreq.c                     |  13 ++
>>   include/acpi/cppc_acpi.h                      |   5 +
>>   include/linux/amd-pstate.h                    |   6 +
>>   include/linux/cpufreq.h                       |   5 +
>>   10 files changed, 291 insertions(+), 22 deletions(-)
> 
> When applied on top of v6.5.3 this breaks turbo on my 5950X after suspend/resume cycle. Please see the scenario description below.
> 
> If I boot v6.5.3 + this patchset, then `turbostat` reports ~4.9 GHz on core 0 where `taskset -c 0 dd if=/dev/zero of=/dev/null` is being run.
> 
> After I suspend the machine and then resume it, and run `dd` again, `turbostat` reports the core to be capped to a stock frequency of ~3.4 GHz. Rebooting the machine fixes this, and the CPU can boost again.
> 
> If this patchset is reverted, then the CPU can turbo after suspend/resume cycle just fine.
> 
> I'm using `amd_pstate=guided`.
> 
> Is this behaviour expected?

To help confirm where the issue is, can I ask you to do three 
experiments with the patch series applied:

1) 'amd_pstate=active' on your kernel command line.
2) 'amd_pstate=active amd_prefcore=disable' on your kernel command line.
3) 'amd_pstate=guided amd_prefcore=disable' on your kernel command line.

Looking through the code, I anticipate from your report that it 
reproduces on "1" but not "2" and "3".

Meng,

Can you try to repro?

I think that it's probably a call to amd_pstate_init_prefcore() missing
from amd_pstate_cpu_resume() and also amd_pstate_epp_resume().

