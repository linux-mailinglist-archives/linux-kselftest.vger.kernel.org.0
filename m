Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A884F7A4F05
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 18:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjIRQdP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 12:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjIRQc5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 12:32:57 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53B9B55B7;
        Mon, 18 Sep 2023 09:19:50 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 38IGJFHZ028574;
        Mon, 18 Sep 2023 18:19:15 +0200
Date:   Mon, 18 Sep 2023 18:19:15 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/4] tools/nolibc: avoid unused parameter warnings for
 ENOSYS fallbacks
Message-ID: <ZQh4gwcxvqgn/9Nh@1wt.eu>
References: <20230917-nolibc-syscall-nr-v2-0-03863d509b9a@weissschuh.net>
 <20230917-nolibc-syscall-nr-v2-2-03863d509b9a@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230917-nolibc-syscall-nr-v2-2-03863d509b9a@weissschuh.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Thomas,

On Sun, Sep 17, 2023 at 05:36:17PM +0200, Thomas Weiﬂschuh wrote:
> The ENOSYS fallback code does not use its functions parameters.
> This can lead to compiler warnings about unused parameters.
> 
> Explicitly avoid these warnings.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  tools/include/nolibc/sys.h | 44 +++++++++++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> index b478750c9004..8389820e1928 100644
> --- a/tools/include/nolibc/sys.h
> +++ b/tools/include/nolibc/sys.h
> @@ -43,6 +43,16 @@
>  		: __sysret_arg;                         /* return original value */ \
>  })
>  
> +/* Syscall ENOSYS helper: Avoids unused-parameter warnings and provides a
> + * debugging hook.
> + */
> +
> +static __inline__ int __nolibc_enosys(const char *syscall, ...)
> +{
> +	(void)syscall;
> +	return -ENOSYS;
> +}
> +
>  
>  /* Functions in this file only describe syscalls. They're declared static so
>   * that the compiler usually decides to inline them while still being allowed
> @@ -133,7 +143,7 @@ int sys_chmod(const char *path, mode_t mode)
>  #elif defined(__NR_chmod)
>  	return my_syscall2(__NR_chmod, path, mode);
>  #else
> -	return -ENOSYS;
> +	return __nolibc_enosys(__func__, path, mode);
>  #endif
>  }
(...)

It's much cleaner like this.

Acked-by: Willy Tarreau <w@1wt.eu>

Feel free to push the whole series to the next branch.

Thank you!
Willy
