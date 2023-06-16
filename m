Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC3D7327B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jun 2023 08:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242017AbjFPGfR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Jun 2023 02:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbjFPGfG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Jun 2023 02:35:06 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FCC2713;
        Thu, 15 Jun 2023 23:34:55 -0700 (PDT)
X-QQ-mid: bizesmtp80t1686897289tpepxrqb
Received: from linux-lab-host.localdomain ( [116.30.128.97])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 16 Jun 2023 14:34:48 +0800 (CST)
X-QQ-SSF: 00200000000000D0V000000A0000000
X-QQ-FEAT: 3M0okmaRx3iREJ5lnYaDqqM4+04IMqux9Ah0gOBvfj2Y69UC1s6BhbgKVLLuG
        NPijFSGCVcoH89fMsKVosOAFKdxmoGNY1CYWLLGH5BbPgon+uIGWeXEGKUa3xVONkw6qU/q
        HwJTCzvgKm7mTH4r8ewGpQYUk3VMp0VCMlchCtPo1vT/j5UEr3Syg5TvDCQ92x7FkIjVyOC
        +RULS07OVpQ0M9Ev+hv9zP2kd+hnHJdktYdJUo1FWVSV4anFWrgJPuv8r5lLmZm8D5cLser
        nqOX3qbWrYR0jBjafK+4DlwS6ingv8XFuo1ppSbRO6+xk9VDwcRQ9IBFqQZ+/p2kVUgsQJT
        LXUJkZJ1WfzrBqlWJ4aoyRfRhZQtg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4452696690556417832
From:   Zhangjin Wu <falcon@tinylab.org>
To:     wuyonggang001@208suo.com
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, w@1wt.eu
Subject: [PATCH] selftests/nolibc: Remove unneeded variable
Date:   Fri, 16 Jun 2023 14:34:48 +0800
Message-Id: <20230616063448.14099-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f964d3dbc6362c2cae56bdbdc05befea@208suo.com>
References: <f964d3dbc6362c2cae56bdbdc05befea@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Yonggang

The 'ret' variable is extractly used by the macros to record the
failures, removing it would directly break the compiling.

    $ gcc -o nolibc-test tools/testing/selftests/nolibc/nolibc-test.c
    tools/testing/selftests/nolibc/nolibc-test.c: In function ‘run_syscall’:
    tools/testing/selftests/nolibc/nolibc-test.c:285:57: error: ‘ret’ undeclared (first use in this function)
      285 |  do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_sysne(expr, llen, val); } while (0)

You can re-check all of the used 'ret' like this:

    $ grep "ret += expect" -ur tools/testing/selftests/nolibc/nolibc-test.c

To avoid sending such patches, simple local tests are required, for this patch,
the 'libc-test' or 'nolibc-test' target may help us to find the above compile
error:

    $ cd tools/testing/selftests/nolibc/
    $ make libc-test
    or
    $ make nolibc-test

Thanks,
Zhangjin

> Fix the following coccicheck warning:
> 
> tools/testing/selftests/nolibc/nolibc-test.c:646:5-8: Unneeded variable: 
> "ret". Return "0"
> 
> Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
> ---
>   tools/testing/selftests/nolibc/nolibc-test.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c 
> b/tools/testing/selftests/nolibc/nolibc-test.c
> index 486334981e60..2b723354e085 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -546,7 +546,6 @@ int run_syscall(int min, int max)
>       int proc;
>       int test;
>       int tmp;
> -    int ret = 0;
>       void *p1, *p2;
> 
>       /* <proc> indicates whether or not /proc is mounted */
> @@ -632,18 +631,17 @@ int run_syscall(int min, int max)
>           CASE_TEST(syscall_noargs);    EXPECT_SYSEQ(1, 
> syscall(__NR_getpid), getpid()); break;
>           CASE_TEST(syscall_args);      EXPECT_SYSER(1, 
> syscall(__NR_statx, 0, NULL, 0, 0, NULL), -1, EFAULT); break;
>           case __LINE__:
> -            return ret; /* must be last */
> +            return 0; /* must be last */
>           /* note: do not set any defaults so as to permit holes above */
>           }
>       }
> -    return ret;
> +    return 0;
>   }
> 
>   int run_stdlib(int min, int max)
>   {
>       int test;
>       int tmp;
> -    int ret = 0;
>       void *p1, *p2;
> 
>       for (test = min; test >= 0 && test <= max; test++) {
> @@ -726,11 +724,11 @@ int run_stdlib(int min, int max)
>   # warning "__SIZEOF_LONG__ is undefined"
>   #endif /* __SIZEOF_LONG__ */
>           case __LINE__:
> -            return ret; /* must be last */
> +            return 0; /* must be last */
>           /* note: do not set any defaults so as to permit holes above */
>           }
>       }
> -    return ret;
> +    return 0;
>   }
> 
>   #define EXPECT_VFPRINTF(c, expected, fmt, ...)                \
> @@ -790,7 +788,6 @@ static int run_vfprintf(int min, int max)
>   {
>       int test;
>       int tmp;
> -    int ret = 0;
>       void *p1, *p2;
> 
>       for (test = min; test >= 0 && test <= max; test++) {
> @@ -810,11 +807,11 @@ static int run_vfprintf(int min, int max)
>           CASE_TEST(hex);          EXPECT_VFPRINTF(1, "f", "%x", 0xf); 
> break;
>           CASE_TEST(pointer);      EXPECT_VFPRINTF(3, "0x1", "%p", (void 
> *) 0x1); break;
>           case __LINE__:
> -            return ret; /* must be last */
> +            return 0; /* must be last */
>           /* note: do not set any defaults so as to permit holes above */
>           }
>       }
> -    return ret;
> +    return 0;
>   }
> 
>   static int smash_stack(void)
> 
