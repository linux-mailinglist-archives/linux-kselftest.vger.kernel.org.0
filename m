Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FCF768B88
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 08:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjGaGHx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 02:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGaGHw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 02:07:52 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90555125;
        Sun, 30 Jul 2023 23:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1690783665; bh=1nomeP1d9ikYEOkL1+aGr38oYfkTSthNlpvoN0QtBd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KbgfJVeiaXReoQ/ZakEwOW07+K2iNobv2eFdQl4mm1tHeoST8umilwHxO6gtXJZZJ
         94ah6d3/RyJtgel6+X/fJCtKZQ/kYeg0ISroCmBW+1jYAD4WVQy/Brs2vk3HPtszav
         GnHdP2ZgC89WRii++KcyS4fQ2EbK6or9mLiakXxA=
Date:   Mon, 31 Jul 2023 08:07:44 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Yuan Tan <tanyuan@tinylab.org>
Cc:     w@1wt.eu, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tools/nolibc: add pipe() and pipe2() support
Message-ID: <f5bcb0b3-7165-4e06-a5a5-9535d5ce3c4e@t-8ch.de>
References: <cover.1690733545.git.tanyuan@tinylab.org>
 <23019c9ad3a63d7026a60df8bc41934c3e74e564.1690733545.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23019c9ad3a63d7026a60df8bc41934c3e74e564.1690733545.git.tanyuan@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-31 13:50:45+0800, Yuan Tan wrote:
> According to manual page [1], posix spec [2] and source code like
> arch/mips/kernel/syscall.c, for historic reasons, the sys_pipe() syscall
> on some architectures has an unusual calling convention.  It returns
> results in two registers which means there is no need for it to do
> verify the validity of a userspace pointer argument.  Historically that
> used to be expensive in Linux.  These days the performance advantage is
> negligible.
> 
> Nolibc doesn't support the unusual calling convention above, luckily
> Linux provides a generic sys_pipe2() with an additional flags argument
> from 2.6.27. If flags is 0, then pipe2() is the same as pipe(). So here
> we use sys_pipe2() to implement the pipe().
> 
> pipe2() is also provided to allow users to use flags argument on demand.
> 
> [1]: https://man7.org/linux/man-pages/man2/pipe.2.html
> [2]: https://pubs.opengroup.org/onlinepubs/9699919799/functions/pipe.html
> 
> Suggested-by: Zhangjin Wu <falcon@tinylab.org>
> Link: https://lore.kernel.org/all/20230729100401.GA4577@1wt.eu/
> Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
> ---
>  tools/include/nolibc/sys.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> index 8bfe7db20b80..9fec09c22dbe 100644
> --- a/tools/include/nolibc/sys.h
> +++ b/tools/include/nolibc/sys.h
> @@ -752,6 +752,30 @@ int open(const char *path, int flags, ...)
>  }
>  
>  
> +/*
> + * int pipe2(int pipefd[2], int flags);
> + * int pipe(int pipefd[2]);
> + */
> +
> +static __attribute__((unused))
> +int sys_pipe2(int pipefd[2], int flags)
> +{
> +	return my_syscall2(__NR_pipe, pipefd, flags);
> +}

Should be __NR_pipe2.

> +static __attribute__((unused))
> +int pipe2(int pipefd[2], int flags)
> +{
> +	return __sysret(sys_pipe2(pipefd, flags));
> +}
> +
> +static __attribute__((unused))
> +int pipe(int pipefd[2])
> +{
> +	pipe2(pipefd, 0);
> +}
> +
> +
>  /*
>   * int prctl(int option, unsigned long arg2, unsigned long arg3,
>   *                       unsigned long arg4, unsigned long arg5);
> -- 
> 2.34.1
> 
