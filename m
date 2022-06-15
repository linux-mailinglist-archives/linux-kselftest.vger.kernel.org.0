Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A871554C817
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jun 2022 14:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347477AbiFOMFC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Jun 2022 08:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245324AbiFOMFB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Jun 2022 08:05:01 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEF9192AF;
        Wed, 15 Jun 2022 05:04:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9Hb070d+w3xFgfv1MBBjcFo5SQormwm/nhKRfg993lIe/v2Kh7QETYjDWgsI8oTaUPzWrpUOaH2tufcDy2EiqVQom5LsCRbi95LLMyfrr3sDnCe82T/pXGBDqZi+RrSnWNcr7CVXIIhbM75pP+pHJf8X09T/lTZnrnxbNHoXQt0zOeTtNTJgltbxo3o8cG8ifeMKMj8D4rUyQZi9FMjNCnFYqHNeWqqGLpm7vhH1uDh6es6bUedDT+6FSbOpBcz3MGZoEpwHnzc5dnnSUPM5BpcP816yF4RyVa+Afu14wB350hUwBazaX3wS1ksUdVl//N/qs+V1k7FhEl74p/nIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oY6Y9tTRPt1As/37WX9h3tbLhcri9p+W1gqG0hS0LCU=;
 b=LCYHQiSpQu/FwYI8kZ/8wAusI+g3TaZey/ghu79BNay4mr8YjpOK7DLv5tdopxG8SgM/+AXH3CGxbgIv6D67ZptY4UM/wjIyhS6gNMx3aOyGxq9y5wLwYfXFIZlmuKQdFDCIv+/YAg4UyzOBvWDiWVcchFjZXLPkBT9d4ejXBfH5sTWxrNdeVCmhUxQdB76AGlWFcAaGrxwMcH0jMkm/B0llbwlUF/GAPk2Uwd0L2eaZ5DR30JDhmjn5Xi6WDR3zKUBbzO9TsKOPCy1uSAk2/Z7nsQhi4EmZFZDI6pBQDsmUanNHwkAK5UNvO6ZGWVpnQ7qdous3Lr6IsLvHMn57fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oY6Y9tTRPt1As/37WX9h3tbLhcri9p+W1gqG0hS0LCU=;
 b=t+x9XQa6P69u2Cz2v63vBOVO6LUTGcGraRpGrLXorYalr3WAyWgmVvzj0tYCOWNhO9rYlS7OOAAEuzBHUD4vgDyD5fxZ/N3lHDkNrRO9YxN8CpHfnmmyvMtyk01Kb9vI9u5SNlK17klhCB4syi387l3g11b4s2WasR/XwB5vYGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6449.namprd12.prod.outlook.com (2603:10b6:208:3b8::6)
 by DM5PR12MB1865.namprd12.prod.outlook.com (2603:10b6:3:10b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Wed, 15 Jun
 2022 12:04:55 +0000
Received: from BL3PR12MB6449.namprd12.prod.outlook.com
 ([fe80::5552:c915:15f5:cb5b]) by BL3PR12MB6449.namprd12.prod.outlook.com
 ([fe80::5552:c915:15f5:cb5b%9]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 12:04:55 +0000
Message-ID: <442c7cb4-7ec5-bf34-b9d6-ce9480b4b491@amd.com>
Date:   Wed, 15 Jun 2022 17:34:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V2] selftests/vm: Add protection_keys tests to run_vmtests
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>, akpm@linux-foundation.org,
        shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220610090704.296-1-kalpana.shetty@amd.com>
 <8e7fca3a-096c-7d6c-e43b-9292995ab970@linuxfoundation.org>
 <e1703fcf-c5e2-70b1-cae2-30330108ad26@amd.com>
 <2f157493-02ed-4bc8-6624-b7d077c0d5af@linuxfoundation.org>
From:   "Shetty, Kalpana" <kalpana.shetty@amd.com>
In-Reply-To: <2f157493-02ed-4bc8-6624-b7d077c0d5af@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0193.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::22) To BL3PR12MB6449.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e6dc810-7cdc-4766-fd8c-08da4ec742b2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1865:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB186580E967F612B02AFCFC6A8CAD9@DM5PR12MB1865.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iGcpgqsN0PI252sYswAMT6njUlBaKyrP6PUplutwQWv5gnS8cUfLPT67wR7vuQdV/NrN7zHLz87MZFKexj8LWCRqg3e7dOH8sX89o9RQyKyLiaUoZr4J2ptqfT1RILt9wVqW6LQXrdBWNMdfU4kvM18ozNeoj8zxvPsYdYAj7Mti4SQthbojdR/k5NV40N+X4enmcX6BuUj6PASs99o3KN8A0xFCJov56yIOpq0Q3TQk7/CYDz25iyOAF/yTq20d1mIbbQw0bOl2jjoBJjQ3vrvL4ygobrifqOInW/0/3JtVBHBOYaTmjXa+tGiWRnBSvYwnbQ0nuEmWyDVcoeCvqSqQQ/9A3iT/LiMw527Vq+WFDo03evbbflmVLaYYAKPvkyeZkwgrjrKy9DBydJjEUPyBdrjf4Uk7dVnsHhNoU8wP2UH6yY0VRm9kL59ny5z7ea7g6HSLGJTikIuvnNsMRPGL01BedZxNvjU2RNsLNj5+c6iqn/uOx8VpnEMJyGgzuD30aRujipJsm16e/X7VP4amJX7wMn4YQJsUCrrB5cNdfUXoqo6fWarhVWlFLYiDra13fGgPyVe0m7TPVCTn0YOeEtZThZDGTkySTcHdyEAwd9HaU18yUeMZPO+q/cBFRR/FnzU5T0UA9Q/9gNibOxITmytPRrM9B2DBR9649qmS4HLGTiDMAYhmrAAoxn0sfgfs05TqqOAHxx23nF5hca3hIPXYkjYQEN362D9ad9s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6449.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6666004)(2906002)(53546011)(8936002)(6506007)(508600001)(6486002)(5660300002)(26005)(66946007)(6512007)(38100700002)(186003)(31696002)(86362001)(36756003)(66556008)(316002)(66476007)(8676002)(31686004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG9FbFkyb2FGK0drczFtb0syTG00YXUzRk1zV0R0elo0WHBHSE9EZjNwQzFj?=
 =?utf-8?B?eGhIb0lvaElRVEx0VzlWRzFNWmxBa1VEVG9iZXRyeTJyTU5ML2NJRlQvRU4x?=
 =?utf-8?B?N1Q2RFFKSVdPdTVvbnY5NFVzcyt0SXU2T1AxZ1hFYUtxRlhWVXNlM3RiaHhX?=
 =?utf-8?B?VkNMbkttT3h3clRKbG5BcnRONlgva0ZPYVJPTnN6d0U0TU9KL1oyd29aMWJ3?=
 =?utf-8?B?QXAxKzJsVGd4NjB6ZFNXdlFIWEt4R3VrSm1zRGNiTUFUTlhOUktYL2NHaGxG?=
 =?utf-8?B?b2RCZy94cjJ1SXoxZ282SythTzJQelhTZ2NFLzQvR2EzU1puRW8xN2VmUVRu?=
 =?utf-8?B?V0diN3hGelQ5TTM3SzhESzU5dUZlbnhEbjdoZkcweWtrYkZ4VHlTa1NYRDFN?=
 =?utf-8?B?M1BXMTcwcjZQSEFEeXNTOGwvUWVzNmFySXZpRzhVb2ZyT1hvQ3NXTTAwaElk?=
 =?utf-8?B?S2JacEc1ZzNqd1NDKy9lOHNseCs5cFJXUGxYZ2M4TURhQ2ozbFYzd28waGt5?=
 =?utf-8?B?ZlAwYXFaa2ZQREs4Q1R5Yk04Z1hOK21LaXdBQmovVTJ2L3NDdlNtMERwaFR3?=
 =?utf-8?B?OHZkUmtETFcrUjUzbkJ0TzB5S2I0bFV5NzBRR3VaZVQrazVHaGpCQzYwWU1O?=
 =?utf-8?B?TmJ6OU4wU0orSVJRZEljNzJuSnp3QTU1dmRnM0xTMlo0OVFNcG10ZkY0ZkdY?=
 =?utf-8?B?VDBHTFZOWUx0NCtQSGROdzg2aU4yZGx3QzY3TUxDbkhTWjNobnlpVFRwZkQv?=
 =?utf-8?B?d09rYXNtcGZ6ZkplMmlESFhKZTVtSmt2WU02aldWdFB3UUlRM3hPSXJCTTRa?=
 =?utf-8?B?eG8ySmxHVTZ1RXNZcjlUSkpOUFRnQ2JhYjFsc2JTQ3pDWHo0Rjc3dHBMREtT?=
 =?utf-8?B?T2hRRlRsYjhiV2NCb3owNy9laXM3WmZCa2ZUNm9iVVZMeUVoSGNPNmxxQnpk?=
 =?utf-8?B?L2hSazN4RVRud0RrZklUMHQrdFIwR1lKK2VJSjJybE9CU0k4cVlxTHFWemVW?=
 =?utf-8?B?Rk1yNzVVZUhjWEpOTnNvUkdqN1VHUTZQMlFHWXF5QmVZaEtkWlhUdFYyUGxD?=
 =?utf-8?B?d1BNZTM3ZkF2dGYybmZsVmtPMjNhTHNmMTRWdFA5ZHpWY3IyMU43UGcvNGtP?=
 =?utf-8?B?cTVFRkNTWUJrakZLK3VyWVRwUDUzVklkY25kSU1KcXdQUi9QZ29KNUFoRmxt?=
 =?utf-8?B?V3FUYTdiNDhkWjI3YnUwa3FDOUczN0dPMElDdTFVbXBCTHFYdk53a2NUYXN0?=
 =?utf-8?B?Nm0xTU1vcjl3VlVYaS9NK1NhNWVqWWdPQVJXeFJKQ2l3SG5nelR3TDhXRXEv?=
 =?utf-8?B?c3g0Mm1IVEJmMmo5RlRHQXk0UGVHclZiVFUwOXcvekJiUlZGcnJpajErRGFQ?=
 =?utf-8?B?U2NiM21aNlRqemVQSEVFSUZZQ1F0aG93bUtzNzhjS25oYmtJUVlOZ1pGWHJr?=
 =?utf-8?B?UlllR29rbGlEWmRxV3YxUUpFOXM5M0tIUUNmMXR6WldBQkFjbDRtZ1QzT3RN?=
 =?utf-8?B?QTVHVW94QXBseVc3aWJsaTBDYWkxOEFLajdRVU9kVEFPbW9yOTB3Vm1YVXhz?=
 =?utf-8?B?VkVIM2xLbVVrcG5KZlhDNlJIOWMyRHhDdmJXdmFuMCtSSEw4ZmttWGlXL2ZB?=
 =?utf-8?B?cVhIZ3pQd0IyTG5XZDVoQmtIenloOEUwY3pVY1lhZEE4cXhmamoxK1RqeVB6?=
 =?utf-8?B?Y3VSSTYzQ0FpaU9rMFNSVHJicWc0dnZFV2RsRVU3Ni9ERkI0aFI5S3ZXcGZU?=
 =?utf-8?B?Y0RaTzU2S3F1Y1VYbG1oRDJsYWxwRkphVCtkSjBYTzYzTHU4bTNUZXNVb25M?=
 =?utf-8?B?bnVHVjFCRDFyWFkwQW9LMkxKOURUMzRRcnNiWkVDNU9LVFl5K1NjYW92Y2dx?=
 =?utf-8?B?OW05RGhWcXFTTGN6cFdTNlJLaU4yS0VURzZoOVZ0UU9iakpIZFhUcWthaS9O?=
 =?utf-8?B?Qm9wbm8yUHk0QUs3azNGa2l1bjJGZDV2L3NQa1RMWmZmM1FSMGNNdDBUOHNB?=
 =?utf-8?B?WmQ4eGZvQ0E0bk9kb2pEV0ZwK2l2MW42SWw1VVcwS1ZLNnZmZW5QMjhTaFAv?=
 =?utf-8?B?WW0rTDhnWGJZLzNNclFTNzQyamdpcEJrQllRY283ZTZWMDBQRTE2UDVvOEM2?=
 =?utf-8?B?aDNKeUtNckVKQWtqeXpZdTZmMVlzWjA1cmFETms1Y2h3bCtZRFkwc2o1NFl1?=
 =?utf-8?B?TTlLUCtzdCtRQkdmTjlERzBZc1dmSXU2K0dyYnN2NVZhSUl0QUlsWmd0RGRo?=
 =?utf-8?B?dThSUFRwcHE3dzVibXRqR0g2cXovb3owb051cjRrdEJtdmkrNE9RaWFzWG5u?=
 =?utf-8?B?aitYRk1ocUVnK3hkU2lEaXBudVhBMFFCaThtVmhXUk9VSzRZWkZxUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6dc810-7cdc-4766-fd8c-08da4ec742b2
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6449.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 12:04:55.3799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQSFUpAFFjR+TuT8OJj72+SPzLiDfIlqLR4RVyfkEKuzyaYFR+pmL3cUwrJ7SG4+tN+4CrnIlPQgR4v2En96Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1865
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 6/14/2022 10:50 PM, Shuah Khan wrote:
> On 6/14/22 6:15 AM, Shetty, Kalpana wrote:
>>
>> On 6/14/2022 3:14 AM, Shuah Khan wrote:
>>> On 6/10/22 3:07 AM, Kalpana Shetty wrote:
>>>> Adding "protected_keys" tests to "run_vmtests.sh" would help out to 
>>>> run all VM related tests
>>>> from a single shell script.
>>>>
>>>
>>> Makes sense - can you explain why you can't just run
>>> protection_keys_32 without checks? 
>>
>> Yes; we can run protection_keys_32 without check.
>>
>>
>>> Why are you checking for VADDR64? 
>>
>> The check is added to ensure if the system is in 64-bit mode before 
>> executing 64-bit binary.
>>
>>
>
> Okay. protection_keys_32 will only be built on 32-bit system and.
> protection_keys_64 on 64-bit system.

On 64-bit system, we get both 32-bit and 64-bit binary.


>
> Won't it be better to check if binary exists and run either _32 or
> _64 instead of checking for VADDR64?

makes sense;

In this case on 64-bit platform we would run both _32 and _64 and this 
should be fine.


> thanks,
> -- Shuah

Thanks,

Kalpana

