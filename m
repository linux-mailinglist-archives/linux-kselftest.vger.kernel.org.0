Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8713970FEB8
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 21:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbjEXTtY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 15:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjEXTtW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 15:49:22 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F874139;
        Wed, 24 May 2023 12:49:18 -0700 (PDT)
Date:   Wed, 24 May 2023 21:49:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1684957756; bh=ZaelfMuK9nEHZvEYR6H9kLGszov8JzRnhm0N2fM3xgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V5YQaFPevn8tMPELIZ3rL/vARmEGIWBtjWcHmaPhYF+yDj//no8UtMhib8t1RCkgD
         2Qx7BcHZAYGtIOSIglBrEkhtnKk7vUQ+wwzP5FZ4tpjHk02fB++Qe+2p0hXbCVEoF0
         7NG4Qy6bNq2lDmpXMc3SwckumYi786BO2HxEJScI=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 04/13] selftests/nolibc: syscall_args: use __NR_statx for
 rv32
Message-ID: <09d60dc2-e298-4c22-8e2f-8375861bd9be@t-8ch.de>
References: <cover.1684949267.git.falcon@tinylab.org>
 <b306ae7b53d67acad6d1e2f63d43505d79f81241.1684949267.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b306ae7b53d67acad6d1e2f63d43505d79f81241.1684949267.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-05-25 01:48:11+0800, Zhangjin Wu wrote:
> When compile nolibc-test.c for rv32, we got such error:
> 
>     tools/testing/selftests/nolibc/nolibc-test.c:599:57: error: ‘__NR_fstat’ undeclared (first use in this function)
>       599 |   CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_fstat, 0, NULL), -1, EFAULT); break;
> 
> The generic include/uapi/asm-generic/unistd.h used by rv32 doesn't
> support __NR_fstat, use __NR_statx instead:
> 
>     Running test 'syscall'
>     69 syscall_noargs = 1                                            [OK]
>     70 syscall_args = -1 EFAULT                                      [OK]
> 
> As tools/include/nolibc/sys.h shows, __NR_statx is either not supported
> by all platforms, so, both __NR_fstat and __NR_statx are required.
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

It seems weird to require limits.h from the system libc at all.

The only thing used from there are INT_MAX and INT_MIN.
Instead we could define our own versions of INT_MAX and INT_MIN in
stdint.h.

#ifndef INT_MAX
#define INT_MAX __INT_MAX__
#endif

#ifndef INT_MIN
#define INT_MIN (- __INT_MAX__ - 1)
#endif

Thomas
