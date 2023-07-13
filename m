Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025DD7518B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 08:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbjGMGXm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 02:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbjGMGXl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 02:23:41 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D3EA2;
        Wed, 12 Jul 2023 23:23:38 -0700 (PDT)
X-QQ-mid: bizesmtp90t1689229407tyeq7sbn
Received: from linux-lab-host.localdomain ( [116.30.126.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 13 Jul 2023 14:23:26 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: rZJGTgY0+YP0Yb2Mhugqzx/9pFfcXDgUR6jtxy/b41GO/9ar8aFi5CVYyh3tk
        HQY3Y41lJYWacFnZ3VrwlFMoTn7Y+CZrfoQyw9vtgD6Tl8bu1tFFficldkKEcseGxnnE+WV
        qZmdFQqA+HgCLXKCbvdmiAmW2mDGqSSQ4QiuERx+8rIZKbQ/2fpdgshw4up4xZfzQOffD0i
        VnswCJMlT4lVTGPJzSXfjkpAQoBcFQBMcHyUVFDbeeSh7rvAS7BIaijf+/L7jl31dDz0gaS
        e0VDhoZGd9Po7wDbu60DJuhnSGwsa2AYE5DtlT0aLlTrlH5BRAsH8t0FQvspq1LtM2NRUyS
        7XO9t7tRS5/IMjQxMbxrhvG85h8EAyCCxWnYNpcEqv7xaKCoqo=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4386575556554638218
From:   Zhangjin Wu <falcon@tinylab.org>
To:     falcon@tinylab.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de, w@1wt.eu
Subject: Re: [PATCH v3 02/11] tools/nolibc: add new crt.h with _start_c
Date:   Thu, 13 Jul 2023 14:23:26 +0800
Message-Id: <20230713062326.52045-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230713061227.43222-1-falcon@tinylab.org>
References: <20230713061227.43222-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas

> > On 2023-07-12 17:17:39+0800, Zhangjin Wu wrote:
> [...]
> > > +static void exit(int);
> > > +
> > > +void _start_c(long *sp)
> > > +{
> > > +	int argc, i;
> > > +	char **argv;
> > > +	char **envp;
> > > +	/* silence potential warning: conflicting types for 'main' */
> > > +	_nolibc_main_fn _nolibc_main __asm__ ("main");
> > 
> > What about the stackprotector initialization?
> > It would really fit great into this series.
> >
> 
> Ok, which gcc version supports stackprotector? seems the test even skip
> on gcc 10, I will find one to verify the code change.
>

Thomas, please ignore this question, I forgot some options in my own script.

Best regards,
Zhangjin

> > > +
> > > +	/*
> > > +	 * sp  :  argc          <-- argument count, required by main()
> > > +	 * argv:  argv[0]       <-- argument vector, required by main()
> > > +	 *        argv[1]
> > > +	 *        ...
> > > +	 *        argv[argc-1]
> > > +	 *        null
> > > +	 * envp:  envp[0]       <-- environment variables, required by main() and getenv()
> > > +	 *        envp[1]
> > > +	 *        ...
> > > +	 *        null
> > > +	 * _auxv: auxv[0]       <-- auxiliary vector, required by getauxval()
> > > +	 *        auxv[1]
> > > +	 *        ...
> > > +	 *        null
> > > +	 */
> > > +
> > > +	/* assign argc and argv */
> > > +	argc = sp[0];
> > > +	argv = (void *)(sp + 1);
> > 
> > Bit of a weird mismatch between array syntax and pointer arithmetic.
> >
