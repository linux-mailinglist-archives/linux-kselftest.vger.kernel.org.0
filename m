Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F9220BBBA
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jun 2020 23:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgFZVkf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Jun 2020 17:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFZVke (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Jun 2020 17:40:34 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A92C03E97B
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jun 2020 14:40:34 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e9so5487687pgo.9
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jun 2020 14:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DBFCiCNbMQQSLufDN5X7qKcgik0Nhri90g4nsd8aM2E=;
        b=bX8dVRpG37euUl3qpbP17LA9iIFyjt3MI488CsWBsbJPJshDtVyG6lLlTanKQREUSr
         clyKuc8OuVr3VkT+sNlOIgeqSE/iU/y7pAbYvCm4QiVcDKwZoj5s3xOt6RZRLX5sK+bF
         3nuMQ6NX+qGwzqG6bzmX4AH222xRUaj1pgKf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DBFCiCNbMQQSLufDN5X7qKcgik0Nhri90g4nsd8aM2E=;
        b=I3wVGpP7gWgcpJLfGHJebYMZ0te5PLtsQswtNqi3UglGdYhl+5pdjm0sy4CM4DSi8b
         OWo7l3MdfM5S3lG02bPpDezt0yfxrxgqcC/tGrUGcdaxVz8VYk1mtsF2lc8uPZOA751u
         DOMnf2SEAhur1oI98IHBti9DYRWdKqs3wEsclGOZX1hEygfmULRoC/8JeWN/l1amI16v
         H7pW32eQhLgIQ7WWYSRDqcXQdZg857U7PnWlEUlCBxZ9u08BhZH1QG6VN9u+/uZ0y5PN
         hVp4P+9HIgwrai7GXBvZNlY7LxsiFdrNgn+2flIPRLLfR5CTfa7m1PMMgEz4rda4RBWh
         CCgQ==
X-Gm-Message-State: AOAM5306jfzq2QV9s0hi7t4PGbDn7wE0wHmFEviaZHXT64f6Ifw8UJSo
        2/MqgYNllUHPQ1U5URPdCXbcWw==
X-Google-Smtp-Source: ABdhPJwsdIbHCnkHW98F5dFAh0C5o3xzHXeXSXzfKXDvmHf7nYqFOW0Q7J//8p36fZg/xNJuCfrMWw==
X-Received: by 2002:a62:a20e:: with SMTP id m14mr4374407pff.249.1593207634245;
        Fri, 26 Jun 2020 14:40:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m16sm8751736pfd.101.2020.06.26.14.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:40:33 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:40:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, skhan@linuxfoundation.org, alan.maguire@oracle.com,
        yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org,
        rppt@linux.ibm.com, frowand.list@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, monstr@monstr.eu,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        chris@zankel.net, jcmvbkbc@gmail.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, logang@deltatee.com, mcgrof@kernel.org,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v5 10/12] kunit: Add 'kunit_shutdown' option
Message-ID: <202006261436.DEF4906A5@keescook>
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-11-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626210917.358969-11-brendanhiggins@google.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 26, 2020 at 02:09:15PM -0700, Brendan Higgins wrote:
> From: David Gow <davidgow@google.com>
> 
> Add a new kernel command-line option, 'kunit_shutdown', which allows the
> user to specify that the kernel poweroff, halt, or reboot after
> completing all KUnit tests; this is very handy for running KUnit tests
> on UML or a VM so that the UML/VM process exits cleanly immediately
> after running all tests without needing a special initramfs.
> 
> Signed-off-by: David Gow <davidgow@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  lib/kunit/executor.c                | 20 ++++++++++++++++++++
>  tools/testing/kunit/kunit_kernel.py |  2 +-
>  tools/testing/kunit/kunit_parser.py |  2 +-
>  3 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index a95742a4ece73..38061d456afb2 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> +#include <linux/reboot.h>
>  #include <kunit/test.h>
>  
>  /*
> @@ -11,6 +12,23 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
>  
>  #if IS_BUILTIN(CONFIG_KUNIT)
>  
> +static char *kunit_shutdown;
> +core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
> +
> +static void kunit_handle_shutdown(void)
> +{
> +	if (!kunit_shutdown)
> +		return;
> +
> +	if (!strcmp(kunit_shutdown, "poweroff"))
> +		kernel_power_off();
> +	else if (!strcmp(kunit_shutdown, "halt"))
> +		kernel_halt();
> +	else if (!strcmp(kunit_shutdown, "reboot"))
> +		kernel_restart(NULL);
> +
> +}

If you have patches that do something just before the initrd, and then
you add more patches to shut down immediately after an initrd, people
may ask you to just use an initrd instead of filling the kernel with
these changes...

I mean, I get it, but it's not hard to make an initrd that poke a sysctl
to start the tests...

In fact, you don't even need a initrd to poke sysctls these days.

-- 
Kees Cook
