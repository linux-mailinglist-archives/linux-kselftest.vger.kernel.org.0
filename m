Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EB47AF3AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 21:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjIZTCx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 15:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbjIZTCw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 15:02:52 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA39EB;
        Tue, 26 Sep 2023 12:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1695754962;
        bh=HmIGoIS7tEFftF5m3jSoExUboCzt4yAlxx+T1aE5+RM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=B2DoCl7Yc4mTL+EnsQD9Hl16Abru79+HrJ5+747ajtudnzxY9f4c6AqHhVK18Ki+T
         r3FCJZZOmZSttkkTyvLHFO0XvbKvIUJQZcSAio7NKA7vHdrwSsYlZQoegbz74h9uCf
         rEOmT8tngH479OIPvLCImbHWTxO3A7Q6aHivp0ZBSNpStevbAgnxTb8O2jMmT47XhZ
         vzlrIexCY4vB5rt+mYKaD0QbVxNNY01SY30LoXCQt710QFOYmLJEPRdn3yobfiDdzz
         9bJHxFk5/BZ9uIiAuf8PlJOQdp65zCd4gKG8JPRK4I/5d4Zn8cSKrRKRHQF2QfKbUU
         p5SQ70EpQmc6w==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Rw8JL2gVWz1R9L;
        Tue, 26 Sep 2023 15:02:42 -0400 (EDT)
Message-ID: <eabe9db0-c934-af2d-e5a9-9d644593851c@efficios.com>
Date:   Tue, 26 Sep 2023 15:02:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] selftests/rseq: fix kselftest Clang build warnings
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev
References: <20230912-kselftest-param_test-c-v1-1-80a6cffc7374@google.com>
 <CAFhGd8on9_DJUZqT5uKgPzOtJNn99sY3TprcPzD5pm3GmYx8oQ@mail.gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAFhGd8on9_DJUZqT5uKgPzOtJNn99sY3TprcPzD5pm3GmYx8oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/26/23 08:20, Justin Stitt wrote:
> Ping.
> 
> Looking to get this patch and [1] slated for 6.7 which fixes some
> kselftest builds on older kernels.
> 
> On Wed, Sep 13, 2023 at 6:03 AM Justin Stitt <justinstitt@google.com> wrote:
>>
>> When building with Clang, I am getting many warnings from the selftests/rseq tree.
>>
>> Here's one such example from rseq tree:
>> |  param_test.c:1234:10: error: address argument to atomic operation must be a pointer to _Atomic type ('intptr_t *' (aka 'long *') invalid)
>> |   1234 |         while (!atomic_load(&args->percpu_list_ptr)) {}
>> |        |                 ^           ~~~~~~~~~~~~~~~~~~~~~~
>> |  /usr/local/google/home/justinstitt/repos/tc-build/build/llvm/final/lib/clang/18/include/stdatomic.h:140:29: note: expanded from macro 'atomic_load'
>> |    140 | #define atomic_load(object) __c11_atomic_load(object, __ATOMIC_SEQ_CST)
>> |        |                             ^                 ~~~~~~
>>
>> Use compiler builtins `__atomic_load_n()` and `__atomic_store_n()` with
>> accompanying __ATOMIC_ACQUIRE and __ATOMIC_RELEASE, respectively. This
>> will fix the warnings because the compiler builtins do not expect their
>> arguments to have _Atomic type. This should also make TSAN happier.
>>
>> Link: https://github.com/ClangBuiltLinux/linux/issues/1698
>> Link: https://github.com/ClangBuiltLinux/continuous-integration2/issues/61
>> Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Peter, should this go through tip ?

Shuah, should to go through selftests ?

Thanks,

Mathieu

>> ---
>> Note: Previous RFC https://lore.kernel.org/r/20230908-kselftest-param_test-c-v1-1-e35bd9052d61@google.com
>> ---
>>   tools/testing/selftests/rseq/param_test.c | 20 ++++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
>> index bf951a490bb4..20403d58345c 100644
>> --- a/tools/testing/selftests/rseq/param_test.c
>> +++ b/tools/testing/selftests/rseq/param_test.c
>> @@ -1231,7 +1231,7 @@ void *test_membarrier_worker_thread(void *arg)
>>          }
>>
>>          /* Wait for initialization. */
>> -       while (!atomic_load(&args->percpu_list_ptr)) {}
>> +       while (!__atomic_load_n(&args->percpu_list_ptr, __ATOMIC_ACQUIRE)) {}
>>
>>          for (i = 0; i < iters; ++i) {
>>                  int ret;
>> @@ -1299,22 +1299,22 @@ void *test_membarrier_manager_thread(void *arg)
>>          test_membarrier_init_percpu_list(&list_a);
>>          test_membarrier_init_percpu_list(&list_b);
>>
>> -       atomic_store(&args->percpu_list_ptr, (intptr_t)&list_a);
>> +       __atomic_store_n(&args->percpu_list_ptr, (intptr_t)&list_a, __ATOMIC_RELEASE);
>>
>> -       while (!atomic_load(&args->stop)) {
>> +       while (!__atomic_load_n(&args->stop, __ATOMIC_ACQUIRE)) {
>>                  /* list_a is "active". */
>>                  cpu_a = rand() % CPU_SETSIZE;
>>                  /*
>>                   * As list_b is "inactive", we should never see changes
>>                   * to list_b.
>>                   */
>> -               if (expect_b != atomic_load(&list_b.c[cpu_b].head->data)) {
>> +               if (expect_b != __atomic_load_n(&list_b.c[cpu_b].head->data, __ATOMIC_ACQUIRE)) {
>>                          fprintf(stderr, "Membarrier test failed\n");
>>                          abort();
>>                  }
>>
>>                  /* Make list_b "active". */
>> -               atomic_store(&args->percpu_list_ptr, (intptr_t)&list_b);
>> +               __atomic_store_n(&args->percpu_list_ptr, (intptr_t)&list_b, __ATOMIC_RELEASE);
>>                  if (rseq_membarrier_expedited(cpu_a) &&
>>                                  errno != ENXIO /* missing CPU */) {
>>                          perror("sys_membarrier");
>> @@ -1324,27 +1324,27 @@ void *test_membarrier_manager_thread(void *arg)
>>                   * Cpu A should now only modify list_b, so the values
>>                   * in list_a should be stable.
>>                   */
>> -               expect_a = atomic_load(&list_a.c[cpu_a].head->data);
>> +               expect_a = __atomic_load_n(&list_a.c[cpu_a].head->data, __ATOMIC_ACQUIRE);
>>
>>                  cpu_b = rand() % CPU_SETSIZE;
>>                  /*
>>                   * As list_a is "inactive", we should never see changes
>>                   * to list_a.
>>                   */
>> -               if (expect_a != atomic_load(&list_a.c[cpu_a].head->data)) {
>> +               if (expect_a != __atomic_load_n(&list_a.c[cpu_a].head->data, __ATOMIC_ACQUIRE)) {
>>                          fprintf(stderr, "Membarrier test failed\n");
>>                          abort();
>>                  }
>>
>>                  /* Make list_a "active". */
>> -               atomic_store(&args->percpu_list_ptr, (intptr_t)&list_a);
>> +               __atomic_store_n(&args->percpu_list_ptr, (intptr_t)&list_a, __ATOMIC_RELEASE);
>>                  if (rseq_membarrier_expedited(cpu_b) &&
>>                                  errno != ENXIO /* missing CPU*/) {
>>                          perror("sys_membarrier");
>>                          abort();
>>                  }
>>                  /* Remember a value from list_b. */
>> -               expect_b = atomic_load(&list_b.c[cpu_b].head->data);
>> +               expect_b = __atomic_load_n(&list_b.c[cpu_b].head->data, __ATOMIC_ACQUIRE);
>>          }
>>
>>          test_membarrier_free_percpu_list(&list_a);
>> @@ -1401,7 +1401,7 @@ void test_membarrier(void)
>>                  }
>>          }
>>
>> -       atomic_store(&thread_args.stop, 1);
>> +       __atomic_store_n(&thread_args.stop, 1, __ATOMIC_RELEASE);
>>          ret = pthread_join(manager_thread, NULL);
>>          if (ret) {
>>                  errno = ret;
>>
>> ---
>> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
>> change-id: 20230908-kselftest-param_test-c-1763b62e762f
>>
>> Best regards,
>> --
>> Justin Stitt <justinstitt@google.com>
>>
> 
> [1]: https://lore.kernel.org/all/20230908-kselftest-09-08-v2-0-0def978a4c1b@google.com/
> 
> Thanks
> Justin

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

