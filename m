Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B6D71061F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 May 2023 09:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjEYHUQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 May 2023 03:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjEYHUP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 May 2023 03:20:15 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E1AA9;
        Thu, 25 May 2023 00:20:13 -0700 (PDT)
X-QQ-mid: bizesmtp77t1684999208te24henb
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 May 2023 15:20:06 +0800 (CST)
X-QQ-SSF: 00200000000000D0V000000A0000000
X-QQ-FEAT: Q40xx9djesR71y0DVBMSVqb0OB8JvjMOQvnH/KC7DVtwDqMquhU67lAmpEDDm
        hbAf1eZ+0xinoQqUjGbKuiN2C8Df2P279pX7plJZfUj5i0uR3laz/qvsRZW49i1gTd823Qe
        Pu+6f1es9OrUPzbE9i+0Ojj0Va73paf9p0Z9g2LnvRwwSXcN9RN1vHhfzLLZnc0c5KbGYlG
        7OXDeJb1Nb3YVpQHlA2ImiJfRehTLMB6/KGxOPc0uHF5Q4RgFYIPEoYvtLaYpI42pzBeCTA
        eV/51v6GyHOmnwef1j5VyqTWcrTSusTIOZWIbGTkRDLOpH3sriihuVhci9KjweWWG6SQ0ux
        uZinBD86WNqojgeRc2Domv3Nq3Zj1mmhPxNRC1BKWVIKvu3fPpmJc1pq37FHgowjBIKREX0
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3158394778450214080
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, w@1wt.eu
Subject: Re: [PATCH 04/13] selftests/nolibc: syscall_args: use __NR_statx for rv32
Date:   Thu, 25 May 2023 15:20:01 +0800
Message-Id: <20230525072001.77353-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <09d60dc2-e298-4c22-8e2f-8375861bd9be@t-8ch.de>
References: <09d60dc2-e298-4c22-8e2f-8375861bd9be@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas

> On 2023-05-25 01:48:11+0800, Zhangjin Wu wrote:
> > When compile nolibc-test.c for rv32, we got such error:
> > 
> >     tools/testing/selftests/nolibc/nolibc-test.c:599:57: error: ‘__NR_fstat’ undeclared (first use in this function)
> >       599 |   CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_fstat, 0, NULL), -1, EFAULT); break;
> > 
> > The generic include/uapi/asm-generic/unistd.h used by rv32 doesn't
> > support __NR_fstat, use __NR_statx instead:
> > 
> >     Running test 'syscall'
> >     69 syscall_noargs = 1                                            [OK]
> >     70 syscall_args = -1 EFAULT                                      [OK]
> > 
> > As tools/include/nolibc/sys.h shows, __NR_statx is either not supported
> > by all platforms, so, both __NR_fstat and __NR_statx are required.
> > 
> > Btw, the latest riscv libc6-dev package is required, otherwise, we would
> > also get such error:
> > 
> >     In file included from /usr/riscv64-linux-gnu/include/sys/cdefs.h:452,
> >                      from /usr/riscv64-linux-gnu/include/features.h:461,
> >                      from /usr/riscv64-linux-gnu/include/bits/libc-header-start.h:33,
> >                      from /usr/riscv64-linux-gnu/include/limits.h:26,
> >                      from /usr/lib/gcc-cross/riscv64-linux-gnu/9/include/limits.h:194,
> >                      from /usr/lib/gcc-cross/riscv64-linux-gnu/9/include/syslimits.h:7,
> >                      from /usr/lib/gcc-cross/riscv64-linux-gnu/9/include/limits.h:34,
> >                      from /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/nolibc-test.c:6:
> >     /usr/riscv64-linux-gnu/include/bits/wordsize.h:28:3: error: #error "rv32i-based targets are not supported"
> >        28 | # error "rv32i-based targets are not supported"
> > 
> > The glibc commit 5b6113d62efa ("RISC-V: Support the 32-bit ABI
> > implementation") fixed up above error, so, glibc >= 2.33 (who includes
> > this commit) is required.
> 
> It seems weird to require limits.h from the system libc at all.
>
> The only thing used from there are INT_MAX and INT_MIN.
> Instead we could define our own versions of INT_MAX and INT_MIN in
> stdint.h.
> 
> #ifndef INT_MAX
> #define INT_MAX __INT_MAX__
> #endif
> 
> #ifndef INT_MIN
> #define INT_MIN (- __INT_MAX__ - 1)
> #endif
>

Just verified and prepared a patch, it did work perfectly, thanks.

The above commit message exactly the error info will be cleaned up in
v2.

Best regards,
Zhangjin

> Thomas
