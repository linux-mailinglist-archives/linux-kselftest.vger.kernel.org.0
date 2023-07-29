Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C678A767D2B
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 10:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjG2IhQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 04:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjG2IhP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 04:37:15 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC024448C;
        Sat, 29 Jul 2023 01:37:12 -0700 (PDT)
X-QQ-mid: bizesmtp89t1690619826twz40flc
Received: from linux-lab-host.localdomain ( [61.141.77.223])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 29 Jul 2023 16:37:05 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: 7jw2iSiCazqolBIhWt24FBma3w+K9hGHrQ0OiB2xYCRhXIQJOTBM+a4BD748W
        yd60+kLUB0zt97rfL/MkiT6bppW4a/kk4uV3EDKtmKXyPRJyEK537qEsvsvg8rWUEMNKAIc
        T0aEqzWI+25Hd0j08eJiyuRpRT7Zlf/GJ3Xl67CY2rI8AE8ofjnjXzhzZofRjTvHLqj0cbA
        AWB8TB1SfBMjMdvkRlcjV3LcMfN+/z+UHU7sFDbuSizCzYTRFITyTn/Bg1FttTUssRfaiH3
        r8q60kZjC6RBXQvfp/pWXvF/IzSfgYW4Trb0g8Y4luXHbN9d/WicttJYOyBzvtyegKFRySM
        iEPfd0rD6+Tf7n9wm7DIV/CoQmqI8+hauRiKbE3cOW+D0cNFrXsV+P+cs6eUg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16116782978551066501
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org
Subject: Re: [PATCH 1/2] tools/nolibc: add pipe() support
Date:   Sat, 29 Jul 2023 16:37:00 +0800
Message-Id: <20230729083700.7554-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728191717.GA32165@1wt.eu>
References: <20230728191717.GA32165@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> Hi Zhangjin, hi Yuan,
> 
> On Fri, Jul 28, 2023 at 11:50:31PM +0800, Zhangjin Wu wrote:
> > Hi, Yuan
> > 
> > > pipe is crucial for shell.
> > >
> > 
> > As the syscall manpage[1] shows, pipe() is just one of the exceptions how
> > may require two return registers in some platforms, e.g.:
> > arch/mips/kernel/syscall.c
> > 
> >     * For historic reasons the pipe(2) syscall on MIPS has an unusual calling
> >      * convention.  It returns results in registers $v0 / $v1 which means there
> >      * is no need for it to do verify the validity of a userspace pointer
> >      * argument.  Historically that used to be expensive in Linux.  These days
> >      * the performance advantage is negligible.
> >      */
> (...)
> 
> Ah indeed! I vaguely remembered that I had left that one aside for some
> time but did not remember why. Now I remember that I couldn't handle the
> MIPS implementation by then while it used to be my primary target.
>

Seems pipe() is the **only** one some architectures (except Alpha)
return two values, and now we have pipe2(), so, it is ok for us to
simply use pipe2() instead ;-)

> > Since we are able to use pipe2() for pipe() (introduced from early Linux
> > 2.6.27, glibc 2.9) and use getpid+getppid for getxpid, getuid+geteuid
> > for getxuid and getgid+getegit for getxgid.
> > 
> > So, it is possible provide such pipe() as a wraper of pipe2() and
> 
> Indeed.
> 
> > getxpid, getxuid and getxgid as wrappers of their corresponding syscall
> > pairs,
> 
> I doubt anyone needs these ones, I didn't know them and do not even
> have their man page. Let's keep the focus on what developers really use.
>

Yeah.

> > then, no need to provide a second return value for all of the
> > existing architectures, for example:
> 
> 
> > 
> >     #ifndef pipe
> >     int pipe(int pipefd[2])
> >     {
> >         pipe2(pipefd, 0);
> >     }
> >     #endif
> > 
> > And for mips:
> > 
> >     // may be in tools/include/nolibc/types.h ?
> >     struct fd_pair {
> >            long fd[2];
> >     };
> > 
> >     // tools/include/nolibc/arch-mips.h
> >     struct fd_pair pipe(void)
> >     {
[...]
> >     
> >             pipe2(pipefds, 0);
[...]
> >     }
> 
> This one does not have the correct prototype for the function exposed
> to the user, pipe really is "int pipe(int pipefd[2])". Maybe you were
> thinking about sys_pipe() instead ? But since MIPS also has pipe2() now,
> there's no reason to make an exception.
>

Yes, pipe2() should be a better choice, but I have seen this sentence in
syscall manpage [1]:

       /* On Alpha, IA-64, MIPS, SuperH, and SPARC/SPARC64, pipe() has the
          following prototype; see NOTES */

       #include <unistd.h>

       struct fd_pair {
           long fd[2];
       };
       struct fd_pair pipe(void);

If it is about syscall, then we are ok to align all of the architectures
together to use "int pipe(int pipefd[2])", otherwise, it will be
required to define them in their own arch-<ARCH>.h, just like some
defined for arch-s390.h.

[1]: https://www.man7.org/linux/man-pages/man2/pipe.2.html

> > To use such method, the test case should be changed too, perhaps an
> > easier method is even only provide pipe2() for all and let users define
> > their own pipe() if really required, we also need to change the test
> > case.
> 
> No, we need to provide users with what they need to compile standard
> code. If we rely on pipe2() to deliver pipe(), that's fine. We can even
> do it per-arch if there are constraints but it seems to me that pipe2()
> is OK.
>

Ok.

Thanks,
Zhangjin

> Thanks,
> Willy
