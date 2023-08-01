Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9867776AA1D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 09:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjHAHi2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 03:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjHAHi1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 03:38:27 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A321E4;
        Tue,  1 Aug 2023 00:38:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RFRmZ1mw7z4f3lDL;
        Tue,  1 Aug 2023 15:38:22 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgCHeuhqtshkCk_uPA--.58937S2;
        Tue, 01 Aug 2023 15:38:21 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH -next v2] selftests/bpf: replace fall through comment by
 fallthrough pseudo-keyword
To:     Ruan Jinjie <ruanjinjie@huawei.com>, bpf@vger.kernel.org
Cc:     Ast@kernel.org, Daniel@iogearbox.net, Andrii@kernel.org,
        Mykolal@fb.com, Martin.lau@linux.dev, Song@kernel.org,
        Yonghong.song@linux.dev, John.fastabend@gmail.com,
        Kpsingh@kernel.org, Sdf@google.com, Haoluo@google.com,
        Jolsa@kernel.org, Shuah@kernel.org, Benjamin.tissoires@redhat.com,
        Asavkov@redhat.com, Iii@linux.ibm.com, Memxor@gmail.com,
        Colin.i.king@gmail.com, Rdunlap@infradead.org, Awkrail01@gmail.com,
        Joannelkoong@gmail.com, linux-kselftest@vger.kernel.org
References: <20230801065447.3609130-1-ruanjinjie@huawei.com>
Message-ID: <11895d11-9f2c-249b-abd3-f5226a5be3f5@huaweicloud.com>
Date:   Tue, 1 Aug 2023 15:38:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230801065447.3609130-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgCHeuhqtshkCk_uPA--.58937S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZryfKF4DGw13Kw1xZFy8AFb_yoWrCr43pa
        y8uw1qkFySkF1xWr1xCF4UWFWrtr4kX348Kr48tFy7ArnxJryIqrWIgF1jgFnxXrZYvrs3
        Zw1IqFy5Zr18ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UdxhLUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 8/1/2023 2:54 PM, Ruan Jinjie wrote:
> Replace the existing /* fall through */ comments with the
> new pseudo-keyword macro fallthrough[1].
>
> [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
>
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
> v2:
> - Update the subject and commit message.

According to the section "How do I indicate which tree (bpf vs.
bpf-next) my patch should be applied to" in
Documentation/bpf/bpf_devel_QA.rst, the subject prefix should be [PATCH
bpf-next].
> ---
>  tools/testing/selftests/bpf/prog_tests/kfunc_call.c          | 4 ++--
>  tools/testing/selftests/bpf/progs/test_cls_redirect.c        | 2 +-
>  tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c | 2 +-
>  tools/testing/selftests/bpf/test_verifier.c                  | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
> index a543742cd7bd..0fd08172965a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
> @@ -101,7 +101,7 @@ static void verify_success(struct kfunc_test_params *param)
>  	case syscall_test:
>  		topts.ctx_in = &args;
>  		topts.ctx_size_in = sizeof(args);
> -		/* fallthrough */
> +		fallthrough;
>  	case syscall_null_ctx_test:
>  		break;
>  	case tc_test:
> @@ -167,7 +167,7 @@ static void verify_fail(struct kfunc_test_params *param)
>  	case syscall_test:
>  		topts.ctx_in = &args;
>  		topts.ctx_size_in = sizeof(args);
> -		/* fallthrough */
> +		fallthrough;
>  	case syscall_null_ctx_test:
>  		break;
>  	case tc_test:
> diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.c b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
> index 66b304982245..f97960759558 100644
> --- a/tools/testing/selftests/bpf/progs/test_cls_redirect.c
> +++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
> @@ -300,7 +300,7 @@ bool pkt_skip_ipv6_extension_headers(buf_t *pkt,
>  		case IPPROTO_FRAGMENT:
>  			*is_fragment = true;
>  			/* NB: We don't check that hdrlen == 0 as per spec. */
> -			/* fallthrough; */
> +			fallthrough;

The build of test_progs failed as shown below. Have you tested your
patch locally ?

progs/test_cls_redirect.c:292:4: In file included from
progs/test_cls_redirect_subprogs.cerror: :2:
use of undeclared identifier 'fallthrough'
progs/test_cls_redirect.c:292:4: error: use of undeclared identifier
'fallthrough'
                        fallthrough;
                        ^
                        fallthrough;
                        ^


>  
>  		case IPPROTO_HOPOPTS:
>  		case IPPROTO_ROUTING:
> diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
> index f41c81212ee9..54dbf307c692 100644
> --- a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
> +++ b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
> @@ -204,7 +204,7 @@ static bool pkt_skip_ipv6_extension_headers(struct bpf_dynptr *dynptr, __u64 *of
>  		case IPPROTO_FRAGMENT:
>  			*is_fragment = true;
>  			/* NB: We don't check that hdrlen == 0 as per spec. */
> -			/* fallthrough; */
> +			fallthrough;
>  
>  		case IPPROTO_HOPOPTS:
>  		case IPPROTO_ROUTING:
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> index 31f1c935cd07..5621a4e0a1be 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -1289,7 +1289,7 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
>  				printf("Did not run the program (no permission) ");
>  				return 0;
>  			}
> -			/* fallthrough; */
> +			fallthrough;
>  		default:
>  			printf("FAIL: Unexpected bpf_prog_test_run error (%s) ",
>  				strerror(saved_errno));

