Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDBA79C241
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 04:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbjILCIE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 22:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244253AbjILCHM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 22:07:12 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73E8CC35C;
        Mon, 11 Sep 2023 18:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1694482733;
        bh=e/MtnjLVSuAmechzlzx02wdSV0OA7qKD1FjdUlt9PcI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ECBUe5vjPPUgZ50JQeZl3PSxn/F2jWFEcsxaq9mfjSu0rMiU1jOK+UViwsd/soWE3
         +g9hRTwnA6nCpkawy2NiUaGv5JirKBU3ONshMvi/hU7umoWKI92+98RijMAUg7vQjl
         S7nY6Klq2314F458vSisQKTHiYpcumy2N4tzU5WjQt0AxojLeCtK8ql0Nf2SKZnn4O
         5NIz2NxzbfE+X/8FK+Px/Ew+I2LROeINhACxJV8QSNAoms+ScV4Luj8UeuuFBgR33e
         yPQWhXA+up+ntvi/riW6Xd8V1uTwNwV7ot0cs5DNNZ7x3kfDiHMOnR0ViUtCuWrcif
         rvroZw0ZVfwCw==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Rl5pN6zdwz1PQV;
        Mon, 11 Sep 2023 21:38:52 -0400 (EDT)
Message-ID: <60a9eee6-1f9c-f9c1-33bb-007e22437087@efficios.com>
Date:   Mon, 11 Sep 2023 21:40:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RFC] selftests/rseq: fix kselftest Clang build warnings
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
References: <20230908-kselftest-param_test-c-v1-1-e35bd9052d61@google.com>
 <1fae4a2f-eaf1-c54c-9ec5-040b2714709e@efficios.com>
 <CAFhGd8rHmQrThrCVHmVAp7fDFRidOAPR9Z6JFBpqAswX8dLGgw@mail.gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAFhGd8rHmQrThrCVHmVAp7fDFRidOAPR9Z6JFBpqAswX8dLGgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/11/23 12:53, Justin Stitt wrote:
> On Sat, Sep 9, 2023 at 5:37 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> On 9/8/23 19:03, Justin Stitt wrote:
>>> Hi,
>>>
>>> I am experiencing many warnings when trying to build tools/testing/selftests.
>>>
>>> Here's one such example from rseq tree:
>>> |  param_test.c:1234:10: error: address argument to atomic operation must be a pointer to _Atomic type ('intptr_t *' (aka 'long *') invalid)
>>> |   1234 |         while (!atomic_load(&args->percpu_list_ptr)) {}
>>> |        |                 ^           ~~~~~~~~~~~~~~~~~~~~~~
>>> |  /usr/local/google/home/justinstitt/repos/tc-build/build/llvm/final/lib/clang/18/include/stdatomic.h:140:29: note: expanded from macro 'atomic_load'
>>> |    140 | #define atomic_load(object) __c11_atomic_load(object, __ATOMIC_SEQ_CST)
>>> |        |                             ^                 ~~~~~~
>>>
>>> I added the _Atomic type in various locations to silence _all_ (10) of these
>>> warnings. I'm wondering, though, perhaps the absence of these _Atomic
>>> types in the first place is on purpose? Am I on the right track to fix
>>> these warnings without damaging the legitimacy of the tests at hand?
>>>
>>> I'd like some feedback about where to go from here and if others are
>>> experiencing the same issues. Thanks!
>>>
>>> FWIW here's my specific build incantation on Clang-18 (49d41de57896e935cd5726719c5208bce22694ae):
>>> $ make LLVM=1 -j128 ARCH=x86_64 mrproper headers defconfig kselftest-merge
>>> $ make LLVM=1 ARCH=x86_64 -C tools/testing/selftests
>>
>> I should have used the __atomic_load_n() compiler builtin rather than
>> atomic_load(), mainly because it does not require the _Atomic annotation
>> to each type it touches.
> 
> Would you like me to send a patch in with this change?

Yes, please, although I suspect we'd want to turn atomic_store() into 
builtins as well.

And use a release MO for stores, and acquire for loads. This should make 
validators like TSAN happier.

Thanks,

Mathieu

> 
>>
>> Thanks,
>>
>> Mathieu
>>
>>
>>>
>>> Link: https://github.com/ClangBuiltLinux/linux/issues/1698
>>> Link: https://github.com/ClangBuiltLinux/continuous-integration2/issues/61
>>> Signed-off-by: Justin Stitt <justinstitt@google.com>
>>> ---
>>>    tools/testing/selftests/rseq/param_test.c | 8 ++++----
>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
>>> index bf951a490bb4..94802aeed2c6 100644
>>> --- a/tools/testing/selftests/rseq/param_test.c
>>> +++ b/tools/testing/selftests/rseq/param_test.c
>>> @@ -356,7 +356,7 @@ struct inc_thread_test_data {
>>>    };
>>>
>>>    struct percpu_list_node {
>>> -     intptr_t data;
>>> +     _Atomic intptr_t data;
>>>        struct percpu_list_node *next;
>>>    };
>>>
>>> @@ -1212,8 +1212,8 @@ static int set_signal_handler(void)
>>>    /* Test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU membarrier command. */
>>>    #ifdef TEST_MEMBARRIER
>>>    struct test_membarrier_thread_args {
>>> -     int stop;
>>> -     intptr_t percpu_list_ptr;
>>> +     _Atomic int stop;
>>> +     _Atomic intptr_t percpu_list_ptr;
>>>    };
>>>
>>>    /* Worker threads modify data in their "active" percpu lists. */
>>> @@ -1240,7 +1240,7 @@ void *test_membarrier_worker_thread(void *arg)
>>>                        int cpu = get_current_cpu_id();
>>>
>>>                        ret = rseq_offset_deref_addv(RSEQ_MO_RELAXED, RSEQ_PERCPU,
>>> -                             &args->percpu_list_ptr,
>>> +                             (intptr_t*)&args->percpu_list_ptr,
>>>                                sizeof(struct percpu_list_entry) * cpu, 1, cpu);
>>>                } while (rseq_unlikely(ret));
>>>        }
>>>
>>> ---
>>> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
>>> change-id: 20230908-kselftest-param_test-c-1763b62e762f
>>>
>>> Best regards,
>>> --
>>> Justin Stitt <justinstitt@google.com>
>>>
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com
>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

