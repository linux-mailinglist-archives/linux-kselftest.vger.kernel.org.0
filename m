Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC72C75798B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 12:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjGRKtT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 06:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjGRKtR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 06:49:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35CDE94;
        Tue, 18 Jul 2023 03:49:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 239432F4;
        Tue, 18 Jul 2023 03:49:59 -0700 (PDT)
Received: from [10.1.34.52] (C02Z41KALVDN.cambridge.arm.com [10.1.34.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24BCD3F6C4;
        Tue, 18 Jul 2023 03:49:14 -0700 (PDT)
Message-ID: <2e5baba4-c8ef-9da4-a2d6-3cf383ed05bd@arm.com>
Date:   Tue, 18 Jul 2023 11:49:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 6/8] selftests/mm: Make migration test robust to
 failure
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20230717103152.202078-1-ryan.roberts@arm.com>
 <20230717103152.202078-7-ryan.roberts@arm.com>
 <20501a7c-19f6-4154-aebc-49df04c9b043@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20501a7c-19f6-4154-aebc-49df04c9b043@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17/07/2023 18:40, David Hildenbrand wrote:
> On 17.07.23 12:31, Ryan Roberts wrote:
>> The `migration` test currently has a number of robustness problems that
>> cause it to hang and leak resources.
>>
>> Timeout: There are 3 tests, which each previously ran for 60 seconds.
>> However, the timeout in mm/settings for a single test binary was set to
>> 45 seconds. So when run using run_kselftest.sh, the top level timeout
>> would trigger before the test binary was finished. Solve this by meeting
>> in the middle; each of the 3 tests now runs for 20 seconds (for a total
>> of 60), and the top level timeout is set to 90 seconds.
>>
>> Leaking child processes: the `shared_anon` test fork()s some children
>> but then an ASSERT() fires before the test kills those children. The
>> assert causes immediate exit of the parent and leaking of the children.
>> Furthermore, if run using the run_kselftest.sh wrapper, the wrapper
>> would get stuck waiting for those children to exit, which never happens.
>> Solve this by deferring any asserts until after the children are killed.
>> The same pattern is used for the threaded tests for uniformity.
>>
>> With these changes, the test binary now runs to completion on arm64,
>> with 2 tests passing and the `shared_anon` test failing.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   tools/testing/selftests/mm/migration.c | 14 ++++++++++----
>>   tools/testing/selftests/mm/settings    |  2 +-
>>   2 files changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/migration.c
>> b/tools/testing/selftests/mm/migration.c
>> index 379581567f27..189d7d9070e8 100644
>> --- a/tools/testing/selftests/mm/migration.c
>> +++ b/tools/testing/selftests/mm/migration.c
>> @@ -15,7 +15,7 @@
>>   #include <time.h>
>>     #define TWOMEG (2<<20)
>> -#define RUNTIME (60)
>> +#define RUNTIME (20)
>>     #define ALIGN(x, a) (((x) + (a - 1)) & (~((a) - 1)))
>>   @@ -118,6 +118,7 @@ TEST_F_TIMEOUT(migration, private_anon, 2*RUNTIME)
>>   {
>>       uint64_t *ptr;
>>       int i;
>> +    int ret;
>>         if (self->nthreads < 2 || self->n1 < 0 || self->n2 < 0)
>>           SKIP(return, "Not enough threads or NUMA nodes available");
>> @@ -131,9 +132,10 @@ TEST_F_TIMEOUT(migration, private_anon, 2*RUNTIME)
>>           if (pthread_create(&self->threads[i], NULL, access_mem, ptr))
>>               perror("Couldn't create thread");
>>   -    ASSERT_EQ(migrate(ptr, self->n1, self->n2), 0);
>> +    ret = migrate(ptr, self->n1, self->n2);
>>       for (i = 0; i < self->nthreads - 1; i++)
>>           ASSERT_EQ(pthread_cancel(self->threads[i]), 0);
>> +    ASSERT_EQ(ret, 0);
> 
> Why is that required? This does not involve fork.

It's not required. I was just trying to keep everything aligned to the same pattern.

> 
>>   }
>>     /*
>> @@ -144,6 +146,7 @@ TEST_F_TIMEOUT(migration, shared_anon, 2*RUNTIME)
>>       pid_t pid;
>>       uint64_t *ptr;
>>       int i;
>> +    int ret;
>>         if (self->nthreads < 2 || self->n1 < 0 || self->n2 < 0)
>>           SKIP(return, "Not enough threads or NUMA nodes available");
>> @@ -161,9 +164,10 @@ TEST_F_TIMEOUT(migration, shared_anon, 2*RUNTIME)
>>               self->pids[i] = pid;
>>       }
>>   -    ASSERT_EQ(migrate(ptr, self->n1, self->n2), 0);
>> +    ret = migrate(ptr, self->n1, self->n2);
>>       for (i = 0; i < self->nthreads - 1; i++)
>>           ASSERT_EQ(kill(self->pids[i], SIGTERM), 0);
>> +    ASSERT_EQ(ret, 0);
> 
> 
> Might be cleaner to also:

Or instead of? I agree this is neater, so will undo the moving of the ASSERT()
and rely on this prctl.

> 
> diff --git a/tools/testing/selftests/mm/migration.c
> b/tools/testing/selftests/mm/migration.c
> index 379581567f27..b3f12b9847ec 100644
> --- a/tools/testing/selftests/mm/migration.c
> +++ b/tools/testing/selftests/mm/migration.c
> @@ -11,6 +11,7 @@
>  #include <numaif.h>
>  #include <sys/mman.h>
>  #include <sys/types.h>
> +#include <sys/prctl.h>
>  #include <signal.h>
>  #include <time.h>
> 
> @@ -155,10 +156,12 @@ TEST_F_TIMEOUT(migration, shared_anon, 2*RUNTIME)
>         memset(ptr, 0xde, TWOMEG);
>         for (i = 0; i < self->nthreads - 1; i++) {
>                 pid = fork();
> -               if (!pid)
> +               if (!pid) {
> +                       prctl(PR_SET_PDEATHSIG, SIGHUP);
>                         access_mem(ptr);
> -               else
> +               } else {
>                         self->pids[i] = pid;
> +               }
>         }
> 
>         ASSERT_EQ(migrate(ptr, self->n1, self->n2), 0);
> 
> 
> Then, whenever the parent dies, all child processes get zapped.
> 
> 

