Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6ABD70A865
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 May 2023 15:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjETNys (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 May 2023 09:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjETNyr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 May 2023 09:54:47 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB40CF
        for <linux-kselftest@vger.kernel.org>; Sat, 20 May 2023 06:54:44 -0700 (PDT)
X-QQ-mid: bizesmtp71t1684590757tcu24nop
Received: from linux-lab-host.localdomain ( [116.30.125.36])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 20 May 2023 21:52:35 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: QityeSR92A2S4S0toYHNZ9kxF6KhrODuWRDpcYlZsLA6FTiLIzTqeNbNYwqBi
        4LgpDjJ/BkUadz2VbzLCSAxLIKD10ZsJjTSEkFZsPAhV0QOX6gsKA1+R7yAK78cjXp8JvEp
        eX7tK6VB3fPugsNHx3Qa6Nu2DknKxhn6oS1wT1gM/2TYY8OlK37/nm66Wd+c7JOSkelfaaI
        Ouk4YdlUKOD6TiKiuibBc39dTYHytZ3A05GoQ/rJlBY9r6+5xAozlVW1UJS2tEozzuBG1Dw
        PvavOPVwubgBFKRx/PZ21md/0jDNi12yozVNFT5RL5ErLaVrFvx5UVhlPaW81BEfPIvbfeK
        DEaJ5JyHH9JY+evvbbVcRJgkPQxFAN0uETBdwlL+xU5F3TRKxO/X25hkL5yvj0CeT+1rA0H
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18117569003285790249
From:   Zhangjin Wu <falcon@tinylab.org>
To:     linux@weissschuh.net, w@1wt.eu
Cc:     aou@eecs.berkeley.edu, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, shuah@kernel.org
Subject: Re: [PATCH] selftests/nolibc: Fix up compile error for rv32
Date:   Sat, 20 May 2023 21:52:35 +0800
Message-Id: <20230520135235.68155-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230520-nolibc-stackprotector-riscv-v1-1-d8912012a034@weissschuh.net>
References: <20230520-nolibc-stackprotector-riscv-v1-1-d8912012a034@weissschuh.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Willy, Thomas,

Resend more info about this patch (added but lost after a new format-patch):

This patch is based on the nolibc/20230520-nolibc-rv32+stkp branch of
[1] + the STKP patch for riscv [2], it is a testing 'side-effect' of the
STKP on rv32.

The nolibc rv32 port is not yet functional, we did this compile test by
adding -D__ARCH_WANT_TIME32_SYSCALLS to gcc (only for compile, see [3]).

We did get this info for rv32:

    !!Stack smashing detected!!

Just to mention, -DNOLIBC_STACKPROTECTOR -fstack-protector-all is used to
enable STKP, for -mstack-protector-guard=global is not available for riscv64
gcc 9.3:

    riscv64-linux-gnu-gcc: error: unrecognized command line option '-mstack-protector-guard=global'; did you mean '-fstack-protector-all'

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git
[2]: https://lore.kernel.org/linux-riscv/20230520-nolibc-stackprotector-riscv-v1-1-d8912012a034@weissschuh.net/T/#
[3]: https://lore.kernel.org/linux-riscv/20230520084610.GA27206@1wt.eu/T/#mf0e54ee19bd3f94dadbb4420ed9dffa316d1719d

Best regards,
Zhangjin Wu

> When compile nolibc-test.c for rv32, we got such error:
>
>     tools/testing/selftests/nolibc/nolibc-test.c:599:57: error: '__NR_fstat' undeclared (first use in this function)
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
>  		case __LINE__:
>  			return ret; /* must be last */
>  		/* note: do not set any defaults so as to permit holes above */
