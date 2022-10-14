Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940D85FE6D9
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Oct 2022 04:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiJNCMq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Oct 2022 22:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJNCMp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Oct 2022 22:12:45 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3ACE4C34
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 19:12:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjMXBhd9+tDr8/aILeqWLfxpY2RPXW8GVXYiiZ5IuuIpkLYez++QosxHucwZqiaTEPvq/CNinOpeN+BkaKuWyjh/7OnJURQiOVBVvM9AITm+0omd2L7ZfirBWovhlfyOMvC4KlCMHMb/zkxwPAgJGd4LWvl8gAWzJdWptJQh7icaWqreEJxj+I5/y1MEdS9zu2dqFN6id9qr4Pjba3tEXWqniP+os2c8JbT5/hatCB6majEf7vL4+wvSdOHkBZJQeqNPagZYizRO/Inton6q9fjy/gi2fTIhVFuLhpO0aZWapMA57uVnBsGwDzYfgmqVD9ZnwEOvUVhBDVh+8xM7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5Od8sHqJ1QoPbbnjKVV1nNFXjmW9vpjpFxqY5CeMgQ=;
 b=XN0S8mFOzcm6lajstQCFtG6IwH4F+Je6c80+shwXXokKh0ifvkPwKchK3nk9XWnDZLNoQgj7BlxYRfcmMjOYNW/4bUd3qyRHDLXxr6B1OonLXj1brKImpApJ8ffrylGOoVbyR6wODzdZkMrwxv5G65daME/RU6TWqBZk+Ueu0VEb1NKgY1AIZslPMw5iC2zXZICWgyBVdPN8Dq0mdVln9be3XLo373e42qP65L4L0U6ZC99dq4wd65dT4aeJL+E+naDp/mXus52CMaPVE7XB158F1PKG875ae6cAf73phsLR1wXeIc1mRQscwSq4UAlH8nqBxxAJbdR6lhKQVAoR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5Od8sHqJ1QoPbbnjKVV1nNFXjmW9vpjpFxqY5CeMgQ=;
 b=btf0VNLFLyiNZ3W3ce/myfDkfgjA0Fes6WaVDirUVim0HxuLVC9BEEgi1VqXd9VDA8VkoOtCG4EF1ewMg0onLVG9dClRCYk/gUNYjSe09k/5EKM2F++Sh8cXgqjvj+/rjIqs0CGhMCrEMlUwSL8Hlh7F6cFMrPscKcZ91bRHVx0S6xA/vaFOmzNR5G9CqIGbcTHVqY3NGUfpy7gHngzpuFPaPJUvcoSSmMOTyCZRIFlvKlX4SaOJCq/2QYGvfS42rCiGWKktPaX4rgb3zNdpVHKI3Nl7K9kP94J/37m9tk/Csbg4lU/xsnmH52qS128OwU0xl4So2U8GkHojvCiC0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SA1PR12MB7271.namprd12.prod.outlook.com (2603:10b6:806:2b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Fri, 14 Oct
 2022 02:12:39 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4064:6c13:72e5:a936]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4064:6c13:72e5:a936%5]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 02:12:39 +0000
References: <26017fe3-5ad7-6946-57db-e5ec48063ceb@suse.cz>
 <7e2e6679-3205-3540-f522-9eaed2940559@redhat.com>
 <44fcecda-31a4-7288-1848-63003dfe0a7d@linuxfoundation.org>
 <04114304-7b35-d42f-0155-087e3b6237c6@suse.cz>
 <0e02ace6-2fad-47d2-03b9-d8a46f256097@suse.cz>
 <ecebc355-eff8-0046-3749-8738ed1954de@redhat.com>
 <a7b3cf86-4578-c23d-7326-4ddf7dcda043@linuxfoundation.org>
 <2d4b8d64-f17f-90ad-7328-b5ca7537d08a@suse.cz>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Jerome Glisse <jglisse@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: hmm_test issues with latest mainline
Date:   Fri, 14 Oct 2022 12:45:30 +1100
In-reply-to: <2d4b8d64-f17f-90ad-7328-b5ca7537d08a@suse.cz>
Message-ID: <87fsfrjgq6.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SY3PR01CA0124.ausprd01.prod.outlook.com
 (2603:10c6:0:1a::33) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|SA1PR12MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fdf113e-257d-42d6-c240-08daad8991b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cpT/0Xp762oUB5U5uhIdi9x9kLKZcWfRqWO1UFRlI7CPOsffZMJ2/dd53oOtIq1ZV4llc9P05xQxdtEhsWDpluOU3TEbbPpY5Hm4pd3A1iX5+t1FQdBqspSl9P5tAW4uIgKvKS0jmTiNkPvHELwhxQ3Kaz24r2WwqMuwZfVcTUDK6o4zVUakkRBaLdhOUHtQFMls5IssEmAlqjv2DO9od9I9qIPK+p8SYy4f/3CO/0XE2vAG3wDgDbdZvu0oFanhFnNgRlJMRbToIl7A5FpX+MCJ4lAN6sSxtomMy9OiNFCnmpRqhmTHE0LwRc0v730Isi/BRnF9jkLY8WQ6W8ysOLQxnZPDczV15AAgQ2Dk/plkHacYQuQM4lBda1Yz4qpBf3ZBr6XeTXlN4J6gokaDfFQb0R2wmEyfETqj1B/wJZmLPWd+AFDYBM1/+lkvoy02l5U0NDpiehumjCtQ509RZKdVCi6vx/6gYFzNRz2SerfPlU540Pvm+2NUzctwG2vgQ7MWE+TyaZkaufoo6Q9U0wHyUOC5daP97kXn47RucWZwg/piQX4WkPwSMXWDbfho6zPCsonnFJZJb6rjsr0XIiTvUHdMwaVKBafMHF2cFfwPciU/IYe7JDF3We5x52CbDs3Pwxmh/L/O1GAuB+YlLOTlSvCotLGT4PRkMNm/yovpgOe0YSYegT6CU5IRnO6S++F43H3jpTFt/pw485S4Jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199015)(36756003)(86362001)(38100700002)(4326008)(8936002)(7416002)(5660300002)(41300700001)(66946007)(316002)(66476007)(66556008)(8676002)(6916009)(54906003)(6512007)(478600001)(6506007)(6486002)(6666004)(83380400001)(2906002)(53546011)(26005)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iYAJYVIsebR0ePn5OZYSdUDrwUE8aiRvEVZWQ15rI7B7E04ZozK9TvL26vLM?=
 =?us-ascii?Q?Sc2a39Tv+8W/STUL0fU9VCXnKJFpVp8sUVEPr0l6lk+fp8MAPAYNMCunUkJs?=
 =?us-ascii?Q?7nmzAxy4pPisQkAr/PyKkHddcOthPGUNsp3WENcxXLCPSk5NSAuk9Ef91R8H?=
 =?us-ascii?Q?OVz/MmLuLEhcNOM032Eq3GzdJjqKB3ZxzJvVMEXgyxPXrhOL0RyDT1q78dxF?=
 =?us-ascii?Q?Jo4ym2BmoByvCO8dGtjFW9+ooYCl9tfyiYzy1UO3BlhBYYb5Agz2USI9Wr1s?=
 =?us-ascii?Q?hZAEn224TjhPUmCCTSnTZ43Q83uhlWDPm4pUH6XZ6yLyNXYbKia1+EWLfDw4?=
 =?us-ascii?Q?hxrZ1rmHE+CcbpepNA2qzSR2aDFWuky7vEooGlUeSkPWtYFiG2NCiCPzU/+X?=
 =?us-ascii?Q?QgINDZmqIZ7JY471XxteF8jtKYHQN3NtyTex7yZw+gP9zQFMfB9hw2cWqwiQ?=
 =?us-ascii?Q?ZDjFrk4ZTXTz1J07Mdcofb2WaI2sMZWnwCmsMxYJqvigHs5j49zO/6rtvz8Y?=
 =?us-ascii?Q?PczDLXdobTTAHXX0zuD363mDdE3+rGX99wxGcKDA1T/cn6D4GLOQvB3vchbc?=
 =?us-ascii?Q?dAFDKBMgjYnVi0mxuwbvTiubPQJ9P5v1rT60vc0wrB8PBkO7A8TPS6y5S5RP?=
 =?us-ascii?Q?1RamNcoL2dxzh/huu+5vWs7LKowsFy47MCc/soJ90G7ixGrNv1NmliJAg7Mw?=
 =?us-ascii?Q?EGai7C+7F6NZhuc9G9iJduShjZ1yvv0xabIS8DWnQa2HXJbBxOOrNJhmhseT?=
 =?us-ascii?Q?YNQSV6T9pKLq1vI7RusrRkzkCXxEftVD+bOinLuYFn8d7C+S3FjcbQw6Ov4M?=
 =?us-ascii?Q?FjDKJwNzHpgqgDoH0PK9AJH3kxIIFz4FxesxxXaQCYEpQjQVLP3mt1+4OHGF?=
 =?us-ascii?Q?AnalbJTORVlGmmDR8Co+S1nu7MOmAkLjh+QHYrclNvtiqhxHQgEvdF6y0pHl?=
 =?us-ascii?Q?NsWYDNLEm+KxVsUMoBQpJls8F7953/c+aXqxpf0wzQ8WQjXLwrNOKkGpAC+5?=
 =?us-ascii?Q?RQHRggZwMokDlgV94aWB6tqmJd8+S3hFxHlPlMPei/VcyD43gT2jCxmYMjs4?=
 =?us-ascii?Q?j6w22UhpAwlAY6msULZc+umkWnLjMAI1stRVOwKYXAvR0FaRc/CSyvlT6tI8?=
 =?us-ascii?Q?TpGOIi0VkFCBSyCMWFYGNAMByZQ/aNrsGopjQiXc0QChbsuteACOkDv8tHSI?=
 =?us-ascii?Q?t4ew66hSZtgWrcsFsN7Iy2euMcnu/Kh+VSLUp9MtuIX4UKNNOL6NUa9eMi0d?=
 =?us-ascii?Q?rXP7PU5696z70RFiDzvHpB1g0FkZQb+Wlh2DBnLYo3YomISS5r4ypYapzs1L?=
 =?us-ascii?Q?eFLcep4vJlt0FR419j21xaowtJ1oYCUZe82OWqdW0fa2NLp07teUf3GGYe1N?=
 =?us-ascii?Q?pRhEkEe0Pt75piTpNzS0jIaXAIpzXXXpD8dYUa5KQgHIdgzYoguBKE4HTccV?=
 =?us-ascii?Q?VQarjlhjGtxGzL/PgbvB5rNdpJVrWXlAmBbWBoteNvp2bTEZH96vRYjACM5m?=
 =?us-ascii?Q?EQtseKzOoYYb4r41zaPHSfIshSLpObcnIgr9f8Ul/1ck9Q7D/9fc/piH0aDb?=
 =?us-ascii?Q?tVvqcWUpD4K9z6TU4UGhHIM9V8P3l77jBs2fZGca?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fdf113e-257d-42d6-c240-08daad8991b8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 02:12:39.6088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gd1VgkS1X47qTAWb+shSklkMHrHqXGZEYvWZCHi8QKE1fslRBc+sGgcnKJ8MvODrUyIQf8eDGaZwoPI69djcKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7271
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Vlastimil Babka <vbabka@suse.cz> writes:

> On 10/13/2022 9:38 PM, Shuah Khan wrote:
>> On 10/13/22 12:00, David Hildenbrand wrote:
>>>>>>> When did that test start failing? Was it still ok for 6.0?
>>>>>
>>>>> Didn't test yet, will try, in case it's my system/config specific thing.
>>>>
>>>> So it's actually all the same with v6.0 for me. The infinite loops, the test
>>>> failures, the misreported SKIPs.
>>>>
>>
>> I am not seeing infinite loops and seeing 25 failures which could
>> be skips.
>>
>>>
>>> Is the kernel compiled with support. I have the feeling that we might simply miss kernel support and it's not handled gracefully ...
>>>
>>
>> Here is my config
>> CONFIG_HMM_MIRROR=y
>> # CONFIG_TEST_HMM is not set
>>
>> Okay here is what is going on - hmm_tests are supposed to be run
>> from test_hmm.sh script. When I run this I see a message that tells
>> me what to do.
>>
>> sudo ./test_hmm.sh
>> ./test_hmm.sh: You must have the following enabled in your kernel:
>> CONFIG_TEST_HMM=m
>>
>> Running ./hmm_tests gives me all the failures. So it appears running
>> hmm_tests executable won't work. This is expected as test_hmm.sh does
>> the right setup before running the test. We have several tests that do
>> that.
>>
>> Vlastimil, can you try this and let me know what you see. I will compile
>> with CONFIG_TEST_HMM=m and let you know what I see on my system.
>
> Right, I didn't mention it, sorry. I did have CONFIG_TEST_HMM=m and was running
> "test_hmm.sh smoke"

FWIW I tend not to use that script on my development machine, mainly
because I either have the module built in or otherwise don't have
modules installed in a place modprobe knows about.

Anyway I am not seeing test failures running hmm-tests directly. However
I do observe both the issue of SKIP in FIXTURE_SETUP() being reported as
a pass in the summary, and the infinite loop on ASSERT failure in
FIXTURE_TEARDOWN.

There does seem to be some framework issues here which are causing this
behaviour. Consider the following representitive snippet:

#include "../kselftest_harness.h"

#include <stdio.h>

FIXTURE(test) {};

FIXTURE_SETUP(test)
{
	SKIP(return, "skip");
}

FIXTURE_TEARDOWN(test)
{
	ASSERT_TRUE(0);
}

TEST_F(test, test)
{
	printf("Running test\n");
}

TEST_HARNESS_MAIN

In this case the test will still be run even though SKIP() was called in
FIXTURE_SETUP. The ASSERT_TRUE() during FIXTURE_TEARDOWN results in the
infinite loop. So it looks to me like calling SKIP from FIXTURE_SETUP
isn't supported, and calling ASSERT_*() in FIXTURE_TEARDOWN is also not
allowed/supported by the kselftest framework.

Unlike hmm-tests though the above snippet reports correct pass/skip
statistics with the teardown assertion removed. This is because there is
also a bug in hmm-tests. Currently we have:

   SKIP(exit(0), "DEVICE_COHERENT not available");

Which should really be:

   SKIP(return, "DEVICE_COHERENT not available");

Of course that results in an infinite loop due to the associated
assertion failure during teardown which is still called despite the SKIP
in setup. Not sure if this is why it was originally coded this way.

 - Alistair

>> thanks,
>> -- Shuah
>>
>>
>>
