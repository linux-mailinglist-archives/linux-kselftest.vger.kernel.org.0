Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBC9AEB78D
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2019 19:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfJaSvB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Oct 2019 14:51:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40215 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbfJaSvA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Oct 2019 14:51:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id r4so4984003pfl.7
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2019 11:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XLz57lIGfqKC3M6vFm45BqnBpRbJgKKmWPNYd03gHyA=;
        b=U2TKDuN0RJmVAnuvG7Px5NI6yW31xNfitR+DvSRcuEo5LiNb1Uc0TjnEQoBYpL89In
         PMO11+PznOEDVzggBnrEOQBNo+Of9EO+hD1mPT70iqm/4Jos47wL6/oQvFtLUA3rGY0v
         ZkbaqfaS9F6hE8KYe0TrXClhTCqM2mdOESFW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XLz57lIGfqKC3M6vFm45BqnBpRbJgKKmWPNYd03gHyA=;
        b=HsdGgYCLb7p5xbUQ4KEWj0utE79jcugbHSY0qTXu3d/TR1quu11WusqFYbtGvnktst
         VSh81nFn2r8+I76KCUzekJtiHrb0ZM/tatAnsod8n7rcACVEb75eun2g2D8Ui1ptCpLh
         2qTTRB+Vm7Rotknfzj2YxzrvNGWG7QDZtTxhwqpuHbGDzPJQraKBAJkdq9qRNncoZqqT
         khLQiMecHfChUzEmYClEo4DixsBjoLUREvKIdhTa4GFfSxD5N3wlqbYCSS4OPDQCtZ+U
         skf5gZY18htjAnRgiBGmMpNIOblSjVVDA0oAkemGQ1nlJbRvX+eAImdNpHZscZ10GEGh
         da/g==
X-Gm-Message-State: APjAAAXdScKQ7C3GKqPpalQvg09VW3yHqLLISKBoeWnXRJRcjspi2Lfn
        mxQ/pCUYbhzhtFD/kIkY0BtIIw==
X-Google-Smtp-Source: APXvYqy6Rf9fLSwdIeGxw8kzB8nNEzmnFTm4ZIojbb8zLzUa2oSwwGyY1z7HPIyiiZQuSZXZ/iUObg==
X-Received: by 2002:a17:90a:b942:: with SMTP id f2mr9189734pjw.83.1572547860187;
        Thu, 31 Oct 2019 11:51:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a6sm5009461pja.30.2019.10.31.11.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 11:50:59 -0700 (PDT)
Date:   Thu, 31 Oct 2019 11:50:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Gow <davidgow@google.com>
Cc:     shuah@kernel.org, brendanhiggins@google.com,
        akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH linux-kselftest/test v6] lib/list-test: add a test for
 the 'list' doubly linked list
Message-ID: <201910311147.FA6A822@keescook>
References: <20191024224631.118656-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024224631.118656-1-davidgow@google.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 24, 2019 at 03:46:31PM -0700, David Gow wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7ef985e01457..f3d0c6e42b97 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9504,6 +9504,13 @@ F:	Documentation/misc-devices/lis3lv02d.rst
>  F:	drivers/misc/lis3lv02d/
>  F:	drivers/platform/x86/hp_accel.c
>  
> +LIST KUNIT TEST
> +M:	David Gow <davidgow@google.com>
> +L:	linux-kselftest@vger.kernel.org
> +L:	kunit-dev@googlegroups.com
> +S:	Maintained
> +F:	lib/list-test.c

Should KUnit be the first name here? Then all KUnit tests appear in the
same location in the MAINTAINERS file, or should it be like it is here,
so that KUnit tests are close to the same-named area?

> +
>  LIVE PATCHING
>  M:	Josh Poimboeuf <jpoimboe@redhat.com>
>  M:	Jiri Kosina <jikos@kernel.org>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index a3017a5dadcd..6c1be6181e38 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1961,6 +1961,24 @@ config SYSCTL_KUNIT_TEST
>  
>  	  If unsure, say N.
>  
> +config LIST_KUNIT_TEST

Similarly for the Kconfig name. (Also aren't KUNIT and TEST redundant?)

config KUNIT_LIST

?

config LIST_KUNIT

> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -292,3 +292,6 @@ obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
>  obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
>  obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
>  obj-$(CONFIG_OBJAGG) += objagg.o
> +
> +# KUnit tests
> +obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o

And again, list-kunit.o? Other things have -test (or more commonly
_test) suffixes. (So maybe list_kunit.o?)

But as I said last time, I'll live with whatever, I'd just like a
documented best-practice with a reasonable rationale. :)

-- 
Kees Cook
