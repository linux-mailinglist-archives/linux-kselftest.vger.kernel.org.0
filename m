Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2631D767629
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 21:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjG1TR1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 15:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjG1TR0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 15:17:26 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5672B19BA;
        Fri, 28 Jul 2023 12:17:25 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36SJHILA032228;
        Fri, 28 Jul 2023 21:17:18 +0200
Date:   Fri, 28 Jul 2023 21:17:18 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     tanyuan@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/nolibc: add pipe() support
Message-ID: <20230728191717.GA32165@1wt.eu>
References: <d01fc60c6a85cc4af87f6f88eb5017b83c181f4d.1690307717.git.tanyuan@tinylab.org>
 <20230728155031.35125-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728155031.35125-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin, hi Yuan,

On Fri, Jul 28, 2023 at 11:50:31PM +0800, Zhangjin Wu wrote:
> Hi, Yuan
> 
> > pipe is crucial for shell.
> >
> 
> As the syscall manpage[1] shows, pipe() is just one of the exceptions how
> may require two return registers in some platforms, e.g.:
> arch/mips/kernel/syscall.c
> 
>     * For historic reasons the pipe(2) syscall on MIPS has an unusual calling
>      * convention.  It returns results in registers $v0 / $v1 which means there
>      * is no need for it to do verify the validity of a userspace pointer
>      * argument.  Historically that used to be expensive in Linux.  These days
>      * the performance advantage is negligible.
>      */
(...)

Ah indeed! I vaguely remembered that I had left that one aside for some
time but did not remember why. Now I remember that I couldn't handle the
MIPS implementation by then while it used to be my primary target.

> Since we are able to use pipe2() for pipe() (introduced from early Linux
> 2.6.27, glibc 2.9) and use getpid+getppid for getxpid, getuid+geteuid
> for getxuid and getgid+getegit for getxgid.
> 
> So, it is possible provide such pipe() as a wraper of pipe2() and

Indeed.

> getxpid, getxuid and getxgid as wrappers of their corresponding syscall
> pairs,

I doubt anyone needs these ones, I didn't know them and do not even
have their man page. Let's keep the focus on what developers really use.

> then, no need to provide a second return value for all of the
> existing architectures, for example:


> 
>     #ifndef pipe
>     int pipe(int pipefd[2])
>     {
>         pipe2(pipefd, 0);
>     }
>     #endif
> 
> And for mips:
> 
>     // may be in tools/include/nolibc/types.h ?
>     struct fd_pair {
>            long fd[2];
>     };
> 
>     // tools/include/nolibc/arch-mips.h
>     struct fd_pair pipe(void)
>     {
>             struct fd_pair fds;
>             int pipefds[2];
>     
>             pipe2(pipefds, 0);
>     
>             fds.fd[0] = pipefds[0];
>             fds.fd[1] = pipefds[1];
>     
>             return fds;
>     }

This one does not have the correct prototype for the function exposed
to the user, pipe really is "int pipe(int pipefd[2])". Maybe you were
thinking about sys_pipe() instead ? But since MIPS also has pipe2() now,
there's no reason to make an exception.

> To use such method, the test case should be changed too, perhaps an
> easier method is even only provide pipe2() for all and let users define
> their own pipe() if really required, we also need to change the test
> case.

No, we need to provide users with what they need to compile standard
code. If we rely on pipe2() to deliver pipe(), that's fine. We can even
do it per-arch if there are constraints but it seems to me that pipe2()
is OK.

Thanks,
Willy
