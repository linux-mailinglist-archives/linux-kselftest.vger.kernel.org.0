Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686BA76C23E
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 03:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjHBBbG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 21:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHBBbF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 21:31:05 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55177210D;
        Tue,  1 Aug 2023 18:31:03 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RFvY33JlLz1GDNN;
        Wed,  2 Aug 2023 09:29:59 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 09:31:00 +0800
Message-ID: <2449f628-8265-818d-4090-409ef29d980e@huawei.com>
Date:   Wed, 2 Aug 2023 09:30:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH bpf-next v3] selftests/bpf: replace fall through comment
 by fallthrough pseudo-keyword
Content-Language: en-US
To:     <yonghong.song@linux.dev>, <Ast@kernel.org>,
        <Daniel@iogearbox.net>, <Andrii@kernel.org>,
        <Martin.lau@linux.dev>, <Song@kernel.org>,
        <John.fastabend@gmail.com>, <Kpsingh@kernel.org>, <Sdf@google.com>,
        <Haoluo@google.com>, <Jolsa@kernel.org>, <Mykolal@fb.com>,
        <Shuah@kernel.org>, <Benjamin.tissoires@redhat.com>,
        <Asavkov@redhat.com>, <Memxor@gmail.com>, <Iii@linux.ibm.com>,
        <Colin.i.king@gmail.com>, <Awkrail01@gmail.com>,
        <Rdunlap@infradead.org>, <Joannelkoong@gmail.com>,
        <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20230801094833.4146816-1-ruanjinjie@huawei.com>
 <172c46c3-c1bd-9628-0d20-fd51d79ec727@linux.dev>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <172c46c3-c1bd-9628-0d20-fd51d79ec727@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2023/8/1 23:40, Yonghong Song wrote:
> 
> 
> On 8/1/23 2:48 AM, Ruan Jinjie wrote:
>> Replace the existing /* fall through */ comments with the
>> new pseudo-keyword macro fallthrough[1].
>>
>> [1]
>> https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
>>
>> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
>> ---
>> v3:
>> - Update the subject prefix and fix the 'fallthrough' undeclared build
>> error.
>> ---
>> v2:
>> - Update the subject and commit message.
>> ---
>>   tools/testing/selftests/bpf/prog_tests/kfunc_call.c          | 4 ++--
>>   tools/testing/selftests/bpf/progs/test_cls_redirect.c        | 2 +-
>>   tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c | 2 +-
>>   tools/testing/selftests/bpf/test_verifier.c                  | 3 ++-
>>   4 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
>> b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
>> index a543742cd7bd..0fd08172965a 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
>> @@ -101,7 +101,7 @@ static void verify_success(struct
>> kfunc_test_params *param)
>>       case syscall_test:
>>           topts.ctx_in = &args;
>>           topts.ctx_size_in = sizeof(args);
>> -        /* fallthrough */
>> +        fallthrough;
> 
> This won't work for clang built kernel/selftests:
> 
> In file included from progs/test_cls_redirect_subprogs.c:2:
> progs/test_cls_redirect.c:303:4: error: use of undeclared identifier
> 'fallthrough'
>   303 |                         fallthrough;
>       |                         ^
>   CLNG-BPF [test_maps] netns_cookie_prog.bpf.o
>   CLNG-BPF [test_maps] test_skmsg_load_helpers.bpf.o
>   CLNG-BPF [test_maps] bpf_iter_setsockopt.bpf.o
>   CLNG-BPF [test_maps] timer.bpf.o
> progs/test_cls_redirect.c:303:4: error: use of undeclared identifier
> 'fallthrough'
>   303 |                         fallthrough;
Thank you very much! I'll fix it in v4.

>       |                         ^
> 
> Try to build the kernel with:
>   make -j LLVM=1
>   make headers_install
> 
> and then build the selftests with
>   make -C tools/testing/selftests/bpf -j LLVM=1
> 
> [~/work/bpf-next/tools/include (master)]$ egrep -r fallthrough
> egrep: warning: egrep is obsolescent; using grep -E
> linux/compiler-gcc.h:#if __has_attribute(__fallthrough__)
> linux/compiler-gcc.h:# define fallthrough __attribute__((__fallthrough__))
> linux/compiler-gcc.h:# define fallthrough                    do {} while
> (0)  /* fallthrough */
> [~/work/bpf-next/tools/include (master)]$
> 
> Looks like 'fallthrough' is not defined for clang build tools/selftests.
> 
>>       case syscall_null_ctx_test:
>>           break;
>>       case tc_test:
>> @@ -167,7 +167,7 @@ static void verify_fail(struct kfunc_test_params
>> *param)
>>       case syscall_test:
>>           topts.ctx_in = &args;
>>           topts.ctx_size_in = sizeof(args);
>> -        /* fallthrough */
>> +        fallthrough;
>>       case syscall_null_ctx_test:
>>           break;
>>       case tc_test:
> [...]
