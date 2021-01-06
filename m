Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374022EB8C9
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Jan 2021 05:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbhAFEFn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Jan 2021 23:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbhAFEFn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Jan 2021 23:05:43 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A9FC06134C
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Jan 2021 20:05:03 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b8so922665plx.0
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Jan 2021 20:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u86KDpsNaohcaACgpBjAUocSKD2jENjUeZphyXcHzq0=;
        b=s55iGzaqNh31q8py96tJHHm5lP6qUnW006FVV0gmUjOq39sDHbZiVsMfVqlXum7g6z
         GQPv/djPTsif9NUGE/3hoaTLg2kk+m9770tP56XZlRok0TwDbzwanZIk132VPgLmhqI5
         pxTf+qh0v2XtRSIlhWqI7nlG2lREBQZF3MHj4ZK+uaGt+432rlM60WJQN2vJZLjKNHfp
         lAAmogeho+oLuTxNOzr4io0IM1P6/SO+6Dn2DTs7eSpiFI5UM9kv/yuzLJEVbad47qxv
         WTuJm2z3FjhcItwUF8FNlYcBJN4bfjHXGu6hPIJ9x28HyPnmACZOYeYQq3AuzKToouGJ
         XO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u86KDpsNaohcaACgpBjAUocSKD2jENjUeZphyXcHzq0=;
        b=UmDr6d1HYJ4QS5hsF6r2x/0CQrj1NDARowjctV4t9m0G6YSZiSvjo5CwRhj/w9YKsZ
         9Js/kIEhH5ga2oiYxXP6ltK7Q9L706tEhzidj9pUdCcb+ikMw8AgBJiYlurQGRjD3tFS
         QRM2A61Oqj0umswg+9RstAAJ/yUSsEhCY9d3ZPInvjZ4i4TcLOy3CIkoZR68WruipANn
         mEwYq568sMbqwZaMaozs3ucesiaHyjxZGM4S/NDuiO7761rPx1i9M0RaKT7RWWaNLnTf
         aD8WHkZ6Hl5F7Iq3sPH3KTX2MWljRGY53c8qCYmw5u9YqKKw9vTCHGoEhU6bndWUNNv+
         DE5A==
X-Gm-Message-State: AOAM530AE0Z0v0ww9JjkaR8kGjbewlw4Dnl26kPAu8zVNcM2ByiIXZC8
        e8B2GAbbX0WSvjthp8WziSY=
X-Google-Smtp-Source: ABdhPJz6JjwW+EqqhiLzFHmkNJm56ty9/uuHPUgERO+2BSOkycjsaaZYu91TPg9g6W6HxlY5Qb6RTw==
X-Received: by 2002:a17:90a:db0b:: with SMTP id g11mr2328324pjv.168.1609905902752;
        Tue, 05 Jan 2021 20:05:02 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id gb9sm600728pjb.40.2021.01.05.20.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 20:05:01 -0800 (PST)
Date:   Wed, 6 Jan 2021 13:04:57 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-um <linux-um@lists.infradead.org>
Subject: Re: kunit stopped working
Message-ID: <X/U26cwfHTMYJTtU@jagdpanzerIV.localdomain>
References: <20201221144302.GR4077@smile.fi.intel.com>
 <20201221144510.GS4077@smile.fi.intel.com>
 <2d4b8148-48ca-290f-1d66-33e302e7571d@linuxfoundation.org>
 <20201221192757.GZ4077@smile.fi.intel.com>
 <20201221194008.GA4077@smile.fi.intel.com>
 <20201221200332.GB4077@smile.fi.intel.com>
 <CABVgOS=tz-611qhrn-pcgokyJeS_NStfxPRBnT60KpPhBVPGpA@mail.gmail.com>
 <X/SRA1P8t+ONZFKb@alley>
 <X/SYhBZyudfnKY1u@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/SYhBZyudfnKY1u@alley>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On (21/01/05 17:49), Petr Mladek wrote:
> The following change solved the problem for me as well. It causes
> that ttynull is initialized after stdiocons console.
> 
> diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
> index eced70ec54e1..602af4d30bd4 100644
> --- a/drivers/tty/ttynull.c
> +++ b/drivers/tty/ttynull.c
> @@ -121,7 +121,6 @@ static void __exit ttynull_exit(void)
>  	tty_port_destroy(&ttynull_port);
>  }
>  
> -module_init(ttynull_init);
> -module_exit(ttynull_exit);
> +late_initcall_sync(ttynull_init);
>  
>  MODULE_LICENSE("GPL v2");
> 
> But I am not completely sure that it is the right solution.

Wow, hmm, puzzled. Why does it help?

> It is strange. Console should get registered only when
> it was added by add_preferred_console(). It means that
> ttynull_init() should not register by default.
[..]
> Some clue might be in stderr_console. It has
> to be explicitly unregistered to avoid staying as
> the default console, see unregister_stderr() in
> arch/um/drivers/stderr_console.c

Hmm... Some random thoughts:

Looking at arch/um/drivers/stderr_console.c - it doesn't have tty
driver and it doesn't register one. So as far as console_device()
concerned we still don't have a workable console - it will return
NULL to tty_lookup_driver(), which will eventually return an error
to filp_open("/dev/console"); hence we'd call register_ttynull_console()
from console_on_rootfs(). So now we register ttynull as preferred
console; hence when another console attempts to register itself we
don't set CON_CONSDEV on it, because of `has_preferred_console`.

But I still don't understand why the initcall patch helped.
Can you shed some light on it?

	-ss
