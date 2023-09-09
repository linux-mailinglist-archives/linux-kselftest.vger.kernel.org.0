Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8602D79980A
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Sep 2023 14:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240574AbjIIMiX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 9 Sep 2023 08:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbjIIMiX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 9 Sep 2023 08:38:23 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFB91717;
        Sat,  9 Sep 2023 05:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1694263072;
        bh=csz18VraFRi13HIr9tA4FquSiE/zkwn2nKkegmwzvbU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KWzO3Xi6yIVu5yWa4rifqlul/0Mb4sXTtL8USUWHCEzFw0xkcbwXZCeq96S5nA87a
         ilfQvjNAdMlKiZqZq3y0uLcOZvbTL1TlGEDqAv13SuNrhdDlmwNyIrbpXlykT0Ashx
         M2p5vdNYRildyCbAM5OI3gYVpOhn7vgfld5a7952XAjsIoeNZec72oQPFYMGPHBYu/
         Ibkzi9FCL6ZEwYXXxyhtVbcKtqHRbNGynVY+R9BkV9TB90Ff6mKtr0IQ5FD2oFW9g2
         O7LLehn7losMyTzYBzxyjEguSOnhV0+lGnIg5Mo3D62lTGqdkeKqoekhhQUpvwSyhg
         e/fGf6xP6Tg9w==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RjXZ85b17z1PGv;
        Sat,  9 Sep 2023 08:37:52 -0400 (EDT)
Message-ID: <1fae4a2f-eaf1-c54c-9ec5-040b2714709e@efficios.com>
Date:   Sat, 9 Sep 2023 08:39:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RFC] selftests/rseq: fix kselftest Clang build warnings
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
References: <20230908-kselftest-param_test-c-v1-1-e35bd9052d61@google.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230908-kselftest-param_test-c-v1-1-e35bd9052d61@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/8/23 19:03, Justin Stitt wrote:
> Hi,
> 
> I am experiencing many warnings when trying to build tools/testing/selftests.
> 
> Here's one such example from rseq tree:
> |  param_test.c:1234:10: error: address argument to atomic operation must be a pointer to _Atomic type ('intptr_t *' (aka 'long *') invalid)
> |   1234 |         while (!atomic_load(&args->percpu_list_ptr)) {}
> |        |                 ^           ~~~~~~~~~~~~~~~~~~~~~~
> |  /usr/local/google/home/justinstitt/repos/tc-build/build/llvm/final/lib/clang/18/include/stdatomic.h:140:29: note: expanded from macro 'atomic_load'
> |    140 | #define atomic_load(object) __c11_atomic_load(object, __ATOMIC_SEQ_CST)
> |        |                             ^                 ~~~~~~
> 
> I added the _Atomic type in various locations to silence _all_ (10) of these
> warnings. I'm wondering, though, perhaps the absence of these _Atomic
> types in the first place is on purpose? Am I on the right track to fix
> these warnings without damaging the legitimacy of the tests at hand?
> 
> I'd like some feedback about where to go from here and if others are
> experiencing the same issues. Thanks!
> 
> FWIW here's my specific build incantation on Clang-18 (49d41de57896e935cd5726719c5208bce22694ae):
> $ make LLVM=1 -j128 ARCH=x86_64 mrproper headers defconfig kselftest-merge
> $ make LLVM=1 ARCH=x86_64 -C tools/testing/selftests

I should have used the __atomic_load_n() compiler builtin rather than 
atomic_load(), mainly because it does not require the _Atomic annotation 
to each type it touches.

Thanks,

Mathieu


> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1698
> Link: https://github.com/ClangBuiltLinux/continuous-integration2/issues/61
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>   tools/testing/selftests/rseq/param_test.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
> index bf951a490bb4..94802aeed2c6 100644
> --- a/tools/testing/selftests/rseq/param_test.c
> +++ b/tools/testing/selftests/rseq/param_test.c
> @@ -356,7 +356,7 @@ struct inc_thread_test_data {
>   };
>   
>   struct percpu_list_node {
> -	intptr_t data;
> +	_Atomic intptr_t data;
>   	struct percpu_list_node *next;
>   };
>   
> @@ -1212,8 +1212,8 @@ static int set_signal_handler(void)
>   /* Test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU membarrier command. */
>   #ifdef TEST_MEMBARRIER
>   struct test_membarrier_thread_args {
> -	int stop;
> -	intptr_t percpu_list_ptr;
> +	_Atomic int stop;
> +	_Atomic intptr_t percpu_list_ptr;
>   };
>   
>   /* Worker threads modify data in their "active" percpu lists. */
> @@ -1240,7 +1240,7 @@ void *test_membarrier_worker_thread(void *arg)
>   			int cpu = get_current_cpu_id();
>   
>   			ret = rseq_offset_deref_addv(RSEQ_MO_RELAXED, RSEQ_PERCPU,
> -				&args->percpu_list_ptr,
> +				(intptr_t*)&args->percpu_list_ptr,
>   				sizeof(struct percpu_list_entry) * cpu, 1, cpu);
>   		} while (rseq_unlikely(ret));
>   	}
> 
> ---
> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> change-id: 20230908-kselftest-param_test-c-1763b62e762f
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

