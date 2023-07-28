Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A969076710E
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 17:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbjG1PvC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 11:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237490AbjG1Pu4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 11:50:56 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BC63C25;
        Fri, 28 Jul 2023 08:50:43 -0700 (PDT)
X-QQ-mid: bizesmtp84t1690559436tjoooqrj
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Jul 2023 23:50:35 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: fs34Pe/+C2RuVPoVqyRJppLja7LT/qKbM3opnb9vfa/sjC5kbdoAFd3OxsW4N
        bcUxXJ9qtIaCrahSK+hb/ZuIlxZ/Nq0303fWht9zyPOlDVp45LHLr+lrjtDUF09miohLlCF
        XsudkqAGBpuslu3D78fLo9TpZcDoz4xxiwP6VcQOs87IcsBUS+8Hbw3GhpGIaEjy037raUA
        34acLS35Ky2SAW0TIbrWc3cr1VDDy5asUEcVyGkWRHPVtdM7brelg7Vf3OmobNEYqthDS9p
        mAk31OsNSu7GCHZCLtxXBrQX2WR0W/LVIbQeAEkEUWYOgCtlz7i+HHglw0hL6yz+UBMfrs1
        WBfRMBN9PUKbCZqKQhgdPAxxvshJbssmwmID0FYjujCqB5iVY4=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12645650533255075637
From:   Zhangjin Wu <falcon@tinylab.org>
To:     tanyuan@tinylab.org
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: [PATCH 1/2] tools/nolibc: add pipe() support
Date:   Fri, 28 Jul 2023 23:50:31 +0800
Message-Id: <20230728155031.35125-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d01fc60c6a85cc4af87f6f88eb5017b83c181f4d.1690307717.git.tanyuan@tinylab.org>
References: <d01fc60c6a85cc4af87f6f88eb5017b83c181f4d.1690307717.git.tanyuan@tinylab.org>
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

Hi, Yuan

> pipe is crucial for shell.
>

As the syscall manpage[1] shows, pipe() is just one of the exceptions how
may require two return registers in some platforms, e.g.:
arch/mips/kernel/syscall.c

    * For historic reasons the pipe(2) syscall on MIPS has an unusual calling
     * convention.  It returns results in registers $v0 / $v1 which means there
     * is no need for it to do verify the validity of a userspace pointer
     * argument.  Historically that used to be expensive in Linux.  These days
     * the performance advantage is negligible.
     */
    asmlinkage int sysm_pipe(void)
    {
            int fd[2];
            int error = do_pipe_flags(fd, 0);
            if (error)
                    return error;
            current_pt_regs()->regs[3] = fd[1];
            return fd[0];
    }

The other exceptions are getxpid(2), getxuid(2), and getxgid(2) on
Alpha.

Since we are able to use pipe2() for pipe() (introduced from early Linux
2.6.27, glibc 2.9) and use getpid+getppid for getxpid, getuid+geteuid
for getxuid and getgid+getegit for getxgid.

So, it is possible provide such pipe() as a wraper of pipe2() and
getxpid, getxuid and getxgid as wrappers of their corresponding syscall
pairs, then, no need to provide a second return value for all of the
existing architectures, for example:

    #ifndef pipe
    int pipe(int pipefd[2])
    {
        pipe2(pipefd, 0);
    }
    #endif

And for mips:

    // may be in tools/include/nolibc/types.h ?
    struct fd_pair {
           long fd[2];
    };

    // tools/include/nolibc/arch-mips.h
    struct fd_pair pipe(void)
    {
            struct fd_pair fds;
            int pipefds[2];
    
            pipe2(pipefds, 0);
    
            fds.fd[0] = pipefds[0];
            fds.fd[1] = pipefds[1];
    
            return fds;
    }

To use such method, the test case should be changed too, perhaps an
easier method is even only provide pipe2() for all and let users define
their own pipe() if really required, we also need to change the test
case.

Best regards,
Zhangjin
[1]: https://man7.org/linux/man-pages/man2/syscall.2.html

> Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
> ---
>  tools/include/nolibc/sys.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> index 8bfe7db20b80..09841fc266fe 100644
> --- a/tools/include/nolibc/sys.h
> +++ b/tools/include/nolibc/sys.h
> @@ -752,6 +752,23 @@ int open(const char *path, int flags, ...)
>  }
>  
>  
> +/*
> + * int pipe(int pipefd[2]);
> + */
> +
> +static __attribute__((unused))
> +int sys_pipe(int pipefd[2])
> +{
> +	return my_syscall1(__NR_pipe, pipefd);
> +}
> +
> +static __attribute__((unused))
> +int pipe(int pipefd[2])
> +{
> +	return __sysret(sys_pipe(pipefd));
> +}
> +
> +
>  /*
>   * int prctl(int option, unsigned long arg2, unsigned long arg3,
>   *                       unsigned long arg4, unsigned long arg5);
> -- 
> 2.39.2
