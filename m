Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA1E7B133A
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 08:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjI1Gn2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 02:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1Gn1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 02:43:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A57D9C;
        Wed, 27 Sep 2023 23:43:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55545C433C8;
        Thu, 28 Sep 2023 06:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695883404;
        bh=DSvDae1aDnAGK6cZ1bq0OV0fku1272PZ2tdvrFmrup4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xm1YqDrbd47/RaAXYtFbyDPcMfa81W/h3Bqbh5qK1av3hDzGKhVxeBgQbahJzJt3p
         Lc5jIl5zrlw64Ebf55Aez44e13cTU1VioTZXZXPpDq+IoHPMiaYb5/R06abeYxxGFf
         3xopreGCGy0F88x4Lu3Bv4vxn4QlBBdcunhiZ3Xs=
Date:   Thu, 28 Sep 2023 08:43:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yuanhe Shu <xiangzao@linux.alibaba.com>
Cc:     jirislaby@kernel.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Xingrui Yi <yixingrui@linux.alibaba.com>
Subject: Re: [PATCH 1/5] pstore: add tty frontend
Message-ID: <2023092804-backslid-ninth-3afe@gregkh>
References: <20230928024244.257687-1-xiangzao@linux.alibaba.com>
 <20230928024244.257687-2-xiangzao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928024244.257687-2-xiangzao@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 28, 2023 at 10:42:40AM +0800, Yuanhe Shu wrote:
> Provide a pstore frontend which can log all messages that are send
> to tty drivers when there are some problems with drivers or there
> is no access to serial ports.
> 
> Using pmsg requires us to redirect the output of the user state.
> When we need to globally view the serial output of various processes,
> it is tedious to redirect the output of each process. We think pmsg is
> more suitable for targeted viewing of certain processes' output, and
> we also need a tool that can quickly do a global view so that we can
> get user-state printed data if the tty driver is working abnormally or
> if we don't have serial access.
> 
> Furthermore, by enabling tty frontend and console/dmesg frontend in
> dump capture kernel, one can collect kernel and user messages to
> discover why kdump service works abnormal.
> 
> Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
> Signed-off-by: Xingrui Yi <yixingrui@linux.alibaba.com>
> ---
>  drivers/tty/n_tty.c         |  1 +
>  fs/pstore/Kconfig           | 23 +++++++++++++++++
>  fs/pstore/Makefile          |  2 ++
>  fs/pstore/blk.c             | 10 ++++++++
>  fs/pstore/internal.h        |  8 ++++++
>  fs/pstore/platform.c        |  5 ++++
>  fs/pstore/ram.c             | 40 +++++++++++++++++++++++++++--
>  fs/pstore/tty.c             | 50 +++++++++++++++++++++++++++++++++++++
>  fs/pstore/zone.c            | 42 ++++++++++++++++++++++++++++++-
>  include/linux/pstore.h      |  2 ++
>  include/linux/pstore_blk.h  |  3 +++
>  include/linux/pstore_ram.h  |  1 +
>  include/linux/pstore_zone.h |  2 ++
>  include/linux/tty.h         | 14 +++++++++++
>  14 files changed, 200 insertions(+), 3 deletions(-)
>  create mode 100644 fs/pstore/tty.c
> 
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index 552e8a741562..55ca40605e4c 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -582,6 +582,7 @@ static ssize_t process_output_block(struct tty_struct *tty,
>  		}
>  	}
>  break_out:
> +	tty_pstore_hook(buf, i);

"hook"?  That does not help explain what this is doing here at all.  A
better name would be best, but why is this part of n_tty at all?  Why
isn't it a console driver just for this, you are sitting in the middle
of the fast-path of the tty layer sucking in data all the time, what is
the performance impact of this extra jump?

> --- a/fs/pstore/blk.c
> +++ b/fs/pstore/blk.c
> @@ -52,6 +52,14 @@ static long ftrace_size = -1;
>  module_param(ftrace_size, long, 0400);
>  MODULE_PARM_DESC(ftrace_size, "ftrace size in kbytes");
>  
> +#if IS_ENABLED(CONFIG_PSTORE_TTY)
> +static long tty_size = CONFIG_PSTORE_BLK_TTY_SIZE;
> +#else
> +static long tty_size = -1;
> +#endif
> +module_param(tty_size, long, 0400);
> +MODULE_PARM_DESC(tty_size, "tty_size size in kbytes");

Do we really need more module parameters that are undocumented?

> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 2f625e1fa8d8..f59712bc51d3 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -44,6 +44,10 @@ static ulong ramoops_pmsg_size = MIN_MEM_SIZE;
>  module_param_named(pmsg_size, ramoops_pmsg_size, ulong, 0400);
>  MODULE_PARM_DESC(pmsg_size, "size of user space message log");
>  
> +static ulong ramoops_tty_size = MIN_MEM_SIZE;
> +module_param_named(tty_size, ramoops_tty_size, ulong, 0400);
> +MODULE_PARM_DESC(tty_size, "size of tty message log");

Again, why a module parameter?

> --- /dev/null
> +++ b/fs/pstore/tty.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Provide a pstore frontend which can log all messages that are send
> + * to tty drivers when there are some problems with drivers or there
> + * is no access to serial ports.
> + */

No copyright line?  Are you sure your company is ok with that?

> +
> +#include <linux/kernel.h>
> +#include <linux/tty.h>
> +#include <linux/tty_driver.h>
> +#include "internal.h"
> +
> +DEFINE_STATIC_KEY_FALSE(tty_key);
> +
> +#define TTY_NAME "tty"
> +#undef pr_fmt
> +#define pr_fmt(fmt) TTY_NAME ": " fmt
> +
> +static void do_write_ttymsg(const unsigned char *buf, int count,
> +							struct pstore_info *psinfo)

Odd formatting :(


> +{
> +	struct pstore_record record, newline;
> +
> +	pstore_record_init(&record, psinfo);
> +	record.type = PSTORE_TYPE_TTY;
> +	record.size = count;
> +	record.buf = (char *)buf;

Why the casting?  Why isn't the buffer a u8 * here?

> +	psinfo->write(&record);
> +
> +	pstore_record_init(&newline, psinfo);
> +	newline.type = PSTORE_TYPE_TTY;
> +	newline.size = strlen("\n");
> +	newline.buf = "\n";
> +	psinfo->write(&newline);

Why have 2 structures and not just one?  And why the new line all the
time, you are not guaranteed that your buffer must have a new line here,
it could be in the middle of a hunk of data that is longer than the
normal buffer size.  Why not rely on the tty data to handle the new line
stuff for you in the proper location?

thanks,

greg k-h
