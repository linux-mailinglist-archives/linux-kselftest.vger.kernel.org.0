Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A12370A86B
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 May 2023 16:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjETOA7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 May 2023 10:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjETOA7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 May 2023 10:00:59 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E953610D;
        Sat, 20 May 2023 07:00:57 -0700 (PDT)
Date:   Sat, 20 May 2023 16:00:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1684591255; bh=bXMjVqB9nRoE86p70C9dZpjseXjyz/ZkIjJNB6mOM3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cVHP5QlU260QyhP5WjPUg167LeHeLM82v7lHbbCybhve/DfIjWmq274mDzJS7U5Wd
         mumW1PUfTVx7Ab7Y+sC5dmpusqhKoQgDajIy/eKip6KBqcWLduQN7MvBb+9gaulNU3
         qy9lAKk7rx/NQAKxY8v1hjqOsOPG/F9ptBJ0DBrw=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, shuah@kernel.org,
        w@1wt.eu
Subject: Re: [PATCH] selftests/nolibc: Fix up compile error for rv32
Message-ID: <958f09b4-8cd7-46b3-aa54-4d981fd8f1bc@t-8ch.de>
References: <20230520-nolibc-stackprotector-riscv-v1-1-d8912012a034@weissschuh.net>
 <20230520120254.66315-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230520120254.66315-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Willy, Zhangjin,

On 2023-05-20 20:02:53+0800, Zhangjin Wu wrote:
> When compile nolibc-test.c for rv32, we got such error:
> 
>     tools/testing/selftests/nolibc/nolibc-test.c:599:57: error: ‘__NR_fstat’ undeclared (first use in this function)
>       599 |   CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_fstat, 0, NULL), -1, EFAULT); break;
> 
> The generic include/uapi/asm-generic/unistd.h used by rv32 doesn't
> support __NR_fstat, using the common __NR_read functions as expected.
> 
>     Running test 'syscall'
>     69 syscall_noargs = 1                                            [OK]
>     70 syscall_args = -1 EBADF                                       [OK]
> 
> Btw, the latest riscv libc6-dev package is required, otherwise, we would
> also get such error:
> 
>     In file included from /usr/riscv64-linux-gnu/include/sys/cdefs.h:452,
>                      from /usr/riscv64-linux-gnu/include/features.h:461,
>                      from /usr/riscv64-linux-gnu/include/bits/libc-header-start.h:33,
>                      from /usr/riscv64-linux-gnu/include/limits.h:26,
>                      from /usr/lib/gcc-cross/riscv64-linux-gnu/9/include/limits.h:194,
>                      from /usr/lib/gcc-cross/riscv64-linux-gnu/9/include/syslimits.h:7,
>                      from /usr/lib/gcc-cross/riscv64-linux-gnu/9/include/limits.h:34,
>                      from /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/nolibc-test.c:6:
>     /usr/riscv64-linux-gnu/include/bits/wordsize.h:28:3: error: #error "rv32i-based targets are not supported"
>        28 | # error "rv32i-based targets are not supported"
> 
> The glibc commit 5b6113d62efa ("RISC-V: Support the 32-bit ABI
> implementation") fixed up above error, so, glibc >= 2.33 (who includes
> this commit) is required.
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 063f9959ac44..d8b59c8f6c03 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -596,7 +596,7 @@ int run_syscall(int min, int max)
>  		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1), -1, EBADF); break;
>  		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
>  		CASE_TEST(syscall_noargs);    EXPECT_SYSEQ(1, syscall(__NR_getpid), getpid()); break;
> -		CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_fstat, 0, NULL), -1, EFAULT); break;
> +		CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_read, -1, &tmp, 1), -1, EBADF); break;

The goal of this second test was to make sure that arguments are passed
in the correct order. For this I tried to have a syscall were the
checked error is generated from a non-first argument.
(The NULL generating the EFAULT).

So the new check does not fullfil this goal anymore.

Maybe we can find a new syscall to test with?

The code should have had a comment I guess.

>  		case __LINE__:
>  			return ret; /* must be last */
>  		/* note: do not set any defaults so as to permit holes above */
> -- 
> 2.25.1
> 
