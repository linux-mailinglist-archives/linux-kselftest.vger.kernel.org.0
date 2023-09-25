Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715E67ADDAF
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 19:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjIYROq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 13:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjIYROp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 13:14:45 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2047.outbound.protection.outlook.com [40.92.90.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F5FBC;
        Mon, 25 Sep 2023 10:14:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObkH35DAh8r0vUHaBT1Ag+XuRneVGdxCagXE+NWL+12K4RMyI21zVjKw58wuVui4MWVicm6uI9CVfIUHg7DzFENPaTvJt2UTLjIVVkomQhq/xQ1F3UGmcioGPU+CprPoBlAe7Rvr7d7a0RmA2HZfgHc8yrYYpmERIIshWQTMpijSRPcW186bYqJf5ZiiugtSpO4JUiRlvSs9fGUhjVzqJqu7qiUcFeaWlD0z3mbeY57HzfDHVncK3bajNxiUZ6yjDkqB+yEYIoVR4yLDgjiYKK8ZJeReAZIHu3oLnSN08hI0Y5rmLLtzVPpMKSWYSMHQJjkjUjNmyssUFFqlL8yNoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muC41VwC1IEBiRN6V4wRzkmLwcxs7TILOqNT131HOjo=;
 b=BKqL1vQPRJaLXGGM5all/A7RJ7B2x1tVgzGh4969T1AR40z5FgNMPbIBHIuoArTUYvo3aShMQJb3qlju38R0DnUn6ve4Z3e0tIyRXh63I/OmXGzbAqMvLjG605OwOBVKwlx+km9W+ORnjeDPMHyMP6JMMJ4yZqHIqeLOFrgG6YohrLDADq2sZFZrJm6x1OkV07tab5mkXLPHSUaNkf4TyslnT49qD2z3bhO4hC8S56kdhzH9xriU3ucZavCGlZUoygqMpQZLBUR9cWaHHeCA4LZYZo3f6h0tIMfbKABJ5dS/dO3GHRDRG7RrluqJbrmJ34OSwQsSGcU7yqPxcp1v8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muC41VwC1IEBiRN6V4wRzkmLwcxs7TILOqNT131HOjo=;
 b=mpZsRW98Ol/w16c4N8BD/WZdh+wxwILR4cSbcgM0zbRsCfnk/SlL+XGDgf1dxp3M9xwGXeIHKu+KQSZ0lndrf5gagf/vIIZxgC71nOEDHLpsdl2B0uH/9R0S+0sHWcUfxh/GvodOS4AEfECH3ERbluKgsaZSvyve25A55Ft+POE7upVlKpYXYY173MKt59F/J73iS5wEh6W/iyNgFR5Hwis5d1qDo5iQTTxZJzwPND5E2Rds44MRL3aqrfrmla+nf3RvKjRGwlpQgmJ/eV29oP2M2LALugkM8TOAw8gqXcnxomdEgG4oNtBHyeHB4RQU/C6cBl5/tCjHYFLdQUiqtQ==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by PR3P193MB0797.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 25 Sep
 2023 17:14:36 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::3164:ae5c:78f7:23ad]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::3164:ae5c:78f7:23ad%4]) with mapi id 15.20.6813.024; Mon, 25 Sep 2023
 17:14:36 +0000
Message-ID: <VI1P193MB0752AFB471120D2CD458967E99FCA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
Date:   Tue, 26 Sep 2023 01:14:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] selftests: Add dependencies information for kselftest
To:     "Ricardo B. Marliere" <ricardo@marliere.net>
Cc:     shuah@kernel.org,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
References: <VI1P193MB0752C18200A14B449C863B1899FCA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <z6mgbk3rho5xh37ufwxu5tkblvk3kw44fg6pr2qcalwcsx6hz4@ehd3k5sr5ixy>
From:   Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <z6mgbk3rho5xh37ufwxu5tkblvk3kw44fg6pr2qcalwcsx6hz4@ehd3k5sr5ixy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [5yqEZRhAJZrgCtIJoogMNqRJ7u4Hmkar]
X-ClientProxiedBy: AS4P190CA0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::12) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <54e44c7a-95c7-464d-bd52-1cbea3355723@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|PR3P193MB0797:EE_
X-MS-Office365-Filtering-Correlation-Id: a452170b-a905-4896-e70c-08dbbdeae4c9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3EGFwyfMYuVGLqkVT7QF5HnOgAu7WhS9LOsqD7STP1isxtG7iOuDB/B0VoTWp7ZWBDkNtgBq5fRiKgy+IhsT1CiIhCV3TCMJrZKC/dJOScZ7FC69Yz4quWmmldTF5pRXNTQHPdgbNf5J+UAEs2huy4MPwc76v+jRScwEQ+E3wyjolgAbG00uQqa+e/RwdSGgfLutcChN5T+VWPPw3kFJ77ZDACk/CYht5RCnMamGijOn+dbsNyOur3uokWXXrPM+n6LSbbOpL0HM0TfSB0bM7LK1I8ZNDLY3ndwNM1/qJtuymC3Vog8cjNPBtlj9ErkDMKmCa9YMEtQAc0cpmvpnNgWr+AFgjaw8IIp1biClDDOw/NPC29TTlBPtL+SygEeFXEvET+n+Ac3mTnER0vQHhcDYCwyUcfT9/+SzkoSSaNtScsmKamOm2k6fDbq+3HCJT21TT/8V7jWNFBIPYDn24R6+wCrYG1ooM0Fn5TjYi7E+2OS9NsykLxHqF4SXyvnmvnUtjS2uxQrQwKRQOYTb+V1ZSkxhVVeqIzHjKp/WxnujTQiSHtjNizaM6K+2tSqN
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0wzNkwrNURpV0JrcVQ5di9OODZVZkNtU3djcVo5Nzk1eW9pWmlMK1dMek94?=
 =?utf-8?B?Q3VGSzlGK0Z3aEJWV251dW4wS3gwRlBsZldLdXN2MktpVThBNkIyUUxUNGxl?=
 =?utf-8?B?QjVSb1RVSUxHSDEzNEo5UlZBK0tBL0Q5N29paHBjQjA5anJkLzFCbkRxZWRT?=
 =?utf-8?B?aHZWTjlKWFYyY3hPWWZwMDZPMUEzTU1HeWN5cnduWGNjQlR0YjJLVXFpekI4?=
 =?utf-8?B?NExVanZReTJpRzNwVHc3eGo4NXhSMENEek1RYmhDeklqTlZVSUsrK0E0elBQ?=
 =?utf-8?B?MU5MQ0kxcnpTV2p2VytSVFYyS2xTOE9TV3VEZEswUE1ENU0wT0ZsL1lWdWcz?=
 =?utf-8?B?Z2hUeHhSTDhJcis4TjUyWjJXbkJ4aG54bXRKNWtkb2FLSTN4a1NNOTJMM3Zl?=
 =?utf-8?B?TUw4OUw3S0pGRWhvZXk4U3k5UUJWWHUxb1NRWHVncEpZWFRtRFdKNkR0OXlV?=
 =?utf-8?B?eDc3eXgxeTdXc3l6WjZYdFk4cnNZQTRXK0VnSVBIaitvV2xaQkVySU9BdUNp?=
 =?utf-8?B?RHN1TjIyQ1dkVU9xNkVmc25kcElzemlnWndsWEZEYnpnMmsySTVmanZ5V3RC?=
 =?utf-8?B?c0orRTFFL2MzOEc5NWhYMnA2b2ZNd3lKYWdEWnVYeW0wNlowQktTZHJHNWhh?=
 =?utf-8?B?cGlCRTNXcVphekJFcjZhRmp5NUZXM0NzTjM2WlZMeHFiSm5TQ0hnWE51WjNh?=
 =?utf-8?B?SEswb3JyeGxTdURBaFFDVUtYbk96MmphS1kyMXQ5bXc1ZkRTNUUyT0FQWjhj?=
 =?utf-8?B?b0szRE9XTi9Tb3A0UjdDbEdWZkd4cklkS2tOZlkvajZLNU42RUliZmNuSmZW?=
 =?utf-8?B?RlNOWGl4T09hVkpnb1hwZWd3M0JzOERNOWRwZkJqQlVZbnlRWFF0alg5NjRK?=
 =?utf-8?B?bFlhZm9DeWVvUEw4Mzkwdk9ia3V1NnJwUmVYVFVhSU1ja2hRbmFYRFdTbHdB?=
 =?utf-8?B?bG9kWlJOVzhzWkhQUGhJZ21XY2ZtbnVvdW5uTFE0SWFjcXNjbE0xQnEzS2t6?=
 =?utf-8?B?ZWorMWMvTTlEb2dUaG1xTVdVZ3ZRUWlQcnhBay9kelNYVkc4LzQrZlRXVitr?=
 =?utf-8?B?bnl1RzRXdjFPa2IyNmh6ZXdtOFhYR3dhcDNWRFdJSFNMdmg4dTRiNDhYUnRL?=
 =?utf-8?B?d2NycFhxVGwxR1RiRVlqNERMZGR3Q1dYWFptOXVDeEx0c0xJZS9kMk92T05o?=
 =?utf-8?B?VzIyb0ZJbzVNRFk2UmRoQUtYdUhXR051alFSSzRDanM1cHhibXNiNUFvY3FN?=
 =?utf-8?B?dC9YLzNkczB0T1dZWDhmbHFoVVJtWXRLQ2ptZzFtbEgrbXZxdm1zd2N1VmRu?=
 =?utf-8?B?U1pvUHVqZ0NjY3FsZ00rSmNWd3BqM1dyM2xENGFyZSs0M1pCU0d5ZnFSMFRl?=
 =?utf-8?B?N3JQSk50eVJwWmlicS9wWVNSMGg4NnRyMHg1RW5ydktoeXAyUGVWazhaQ05H?=
 =?utf-8?B?SVgzSittenlvd1ZTQjdNOFFCZ3VxaytaWXM1OWo4NGxwamNoRHJFeU5SaE5I?=
 =?utf-8?B?YkZOQ0FpTkNUM2dJcnZOUlV0VUVSdmF1L2YyRVJoT0FuZFEwN08zYVJnMTFQ?=
 =?utf-8?B?YmZYcTlaaWxwQlgxVlN5RHA1K1JVZXFEZEJmREV4cjJlRmcyZy8yai9LK25v?=
 =?utf-8?Q?ZSj18Eh2Q7tEv0VChBN8y7WB0zoqGH7lycoUimGYZjJo=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a452170b-a905-4896-e70c-08dbbdeae4c9
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 17:14:36.4273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0797
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/9/25 19:24, Ricardo B. Marliere wrote:
> On 23/09/25 06:25PM, Juntong Deng wrote:
>> Most of the tests in kselftest rely on external tools and libraries
>> to run, which means that in order to run the tests effectively we need
>> to have all the dependencies installed first.
>>
>> But unfortunately, there is currently no way to know in advance what
>> tools and libraries the tests in kselftest depend on, and can only be
>> known when a test run fails.
> 
> Hello Juntong,
> 
> did you check if tools/testing/selftests/kselftest_deps.sh does what
> you're after? It won't tell you what packages are missing because it's
> distro-independent, but it tells you what libs your system is missing.
> 
> e.g.
> 
> (...)
> Targets failed build dependency check on system: alsa bpf cachestat
> capabilities clone3 filesystems fpu futex hid intel_pstate kvm landlock
> membarrier memfd mm mqueue net netfilter powerpc ptp rseq rtc safesetid
> sched seccomp timens timers user_events vDSO
> -------------------------------------------------------- Missing
> libraries system -lasound -lcap -lcap-ng -lcrypto -ldl -lelf -lfuse
> -lgcc_s -lm -lmnl -lnuma -lpopt -lpthread -lrt -lz -pthread
> 
> 
> 
> Regards,
> -	Ricardo

Hi Ricardo, thanks for your reply.

I checked kselftest_deps.sh and it does find all missing
library dependencies.

But kselftest_deps.sh cannot find missing tool dependencies,
such as ndisc6.

I think we still need to find a way to solve this problem.

Best wishes.

Juntong Deng
