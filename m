Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8688F76B90B
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 17:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjHAPuU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 11:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjHAPuU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 11:50:20 -0400
X-Greylist: delayed 570 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Aug 2023 08:50:16 PDT
Received: from out-65.mta1.migadu.com (out-65.mta1.migadu.com [95.215.58.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A991A1B7
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Aug 2023 08:50:16 -0700 (PDT)
Message-ID: <172c46c3-c1bd-9628-0d20-fd51d79ec727@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690904442; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JBMwQ8KCBjd5slY4JwUkXV2ks/hunh75PmWoZASxVyA=;
        b=pFRK5CUc1dfL3l/SyNCm24X2lzNZLw6NWejlU/Yv1zLa8NbCGDIH1GVKdIR1Aer80lCcFp
        J7OXymHzOOMi3lJgyHmhZXx4gPJ+bwVE6auNEC7w/TkPM97IsySYo5lR6guXF/dk/MJReG
        wDXG/Y3TfsxBQloOPuXSCDF+1klkacI=
Date:   Tue, 1 Aug 2023 08:40:36 -0700
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v3] selftests/bpf: replace fall through comment
 by fallthrough pseudo-keyword
Content-Language: en-US
To:     Ruan Jinjie <ruanjinjie@huawei.com>, Ast@kernel.org,
        Daniel@iogearbox.net, Andrii@kernel.org, Martin.lau@linux.dev,
        Song@kernel.org, John.fastabend@gmail.com, Kpsingh@kernel.org,
        Sdf@google.com, Haoluo@google.com, Jolsa@kernel.org,
        Mykolal@fb.com, Shuah@kernel.org, Benjamin.tissoires@redhat.com,
        Asavkov@redhat.com, Memxor@gmail.com, Iii@linux.ibm.com,
        Colin.i.king@gmail.com, Awkrail01@gmail.com, Rdunlap@infradead.org,
        Joannelkoong@gmail.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20230801094833.4146816-1-ruanjinjie@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230801094833.4146816-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 8/1/23 2:48 AM, Ruan Jinjie wrote:
> Replace the existing /* fall through */ comments with the
> new pseudo-keyword macro fallthrough[1].
> 
> [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
> v3:
> - Update the subject prefix and fix the 'fallthrough' undeclared build error.
> ---
> v2:
> - Update the subject and commit message.
> ---
>   tools/testing/selftests/bpf/prog_tests/kfunc_call.c          | 4 ++--
>   tools/testing/selftests/bpf/progs/test_cls_redirect.c        | 2 +-
>   tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c | 2 +-
>   tools/testing/selftests/bpf/test_verifier.c                  | 3 ++-
>   4 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
> index a543742cd7bd..0fd08172965a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
> @@ -101,7 +101,7 @@ static void verify_success(struct kfunc_test_params *param)
>   	case syscall_test:
>   		topts.ctx_in = &args;
>   		topts.ctx_size_in = sizeof(args);
> -		/* fallthrough */
> +		fallthrough;

This won't work for clang built kernel/selftests:

In file included from progs/test_cls_redirect_subprogs.c:2:
progs/test_cls_redirect.c:303:4: error: use of undeclared identifier 
'fallthrough'
   303 |                         fallthrough;
       |                         ^
   CLNG-BPF [test_maps] netns_cookie_prog.bpf.o
   CLNG-BPF [test_maps] test_skmsg_load_helpers.bpf.o
   CLNG-BPF [test_maps] bpf_iter_setsockopt.bpf.o
   CLNG-BPF [test_maps] timer.bpf.o
progs/test_cls_redirect.c:303:4: error: use of undeclared identifier 
'fallthrough'
   303 |                         fallthrough;
       |                         ^

Try to build the kernel with:
   make -j LLVM=1
   make headers_install

and then build the selftests with
   make -C tools/testing/selftests/bpf -j LLVM=1

[~/work/bpf-next/tools/include (master)]$ egrep -r fallthrough
egrep: warning: egrep is obsolescent; using grep -E
linux/compiler-gcc.h:#if __has_attribute(__fallthrough__)
linux/compiler-gcc.h:# define fallthrough 
__attribute__((__fallthrough__))
linux/compiler-gcc.h:# define fallthrough                    do {} while 
(0)  /* fallthrough */
[~/work/bpf-next/tools/include (master)]$

Looks like 'fallthrough' is not defined for clang build tools/selftests.

>   	case syscall_null_ctx_test:
>   		break;
>   	case tc_test:
> @@ -167,7 +167,7 @@ static void verify_fail(struct kfunc_test_params *param)
>   	case syscall_test:
>   		topts.ctx_in = &args;
>   		topts.ctx_size_in = sizeof(args);
> -		/* fallthrough */
> +		fallthrough;
>   	case syscall_null_ctx_test:
>   		break;
>   	case tc_test:
[...]
