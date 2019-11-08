Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0F7F3D63
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2019 02:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfKHBYe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Nov 2019 20:24:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39720 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfKHBYd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Nov 2019 20:24:33 -0500
Received: by mail-pf1-f194.google.com with SMTP id x28so3613008pfo.6
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Nov 2019 17:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fARBDWwNTT6jT5EhjTe8Lj8RdP+sxXD4YhlXUehOu+w=;
        b=u6NiituZ4gJAngALm2Ceb+veH0GCGvTP3iMM0TWVojT6zqDvkU3+nSyLxF5Bh3CjI9
         kveET2xCthvDfHV8PF/U6yEoC6B9JNRoRugHviJu/aQBZ4T2Ed34Mt6yBHnRbbCL90Bi
         SxEMw+hfd2ExQ/KHIqDXZZHFAtlNJI8wdx3YT3nOOyDjFgGZZdKeROd640GdnImC91iu
         eAOQksB8hI256CzeLfcZMm5OAjHM2wZ9yJBNNMaKUVflwqacV03AwXqKzDRwgI6354Jv
         bsh9+Br3tK69PxyYO13EyBn/oIYOSuxRr17cREL4OVgowia9K3HnLY7CVRwBgztI5WR/
         fx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fARBDWwNTT6jT5EhjTe8Lj8RdP+sxXD4YhlXUehOu+w=;
        b=kuXtr/U24wakS3VU3KucOju6Ctg3LwUOvxwuGfviIBhxVldr6L+RE0U6l/8kfgDQKT
         3HBBZqM8dVbtPY/Zd+f/TgEBRLUShW4M9PFQL3d1BQzvwdhtYVhIsztDiE5A8U7OnEeJ
         BlI5bII8F5XftWw+WqiyddZKL6RPJeRTfzQ9MvU136tt0NZLV6dPEhS1T1zVEXmHxRMA
         FoVDSd0eJ/Mb7I4ANa24bMTRny0YgOIt9hcVqKVxQHZ19p7Pz1QAR023itfzUGkQmU2g
         K4uYCEXGkjkSVhiRlqJk/gSLoAFo2qE0Mk7h1tu5r+ECWXSnVYE9w/QQ5sWZw1iGc7GY
         +pkA==
X-Gm-Message-State: APjAAAVqYYbp3TwyZGfwEDee9dvh+vJkxc8yt/Ytl/woLCeIkfQHO6za
        tOarOdBbi1sElRahqOJN/CW0Ru+mIJPA75nTnSHJrA==
X-Google-Smtp-Source: APXvYqzGujOAvUTcF0qo1Y8Zaf9OqgTljDoiGnRaCMwuBJj2U1UfGVK7ai9s/7BkaMWvUrVSBPiiM19eE9AJ+dBTQLM=
X-Received: by 2002:a63:234c:: with SMTP id u12mr8210833pgm.384.1573176272237;
 Thu, 07 Nov 2019 17:24:32 -0800 (PST)
MIME-Version: 1.0
References: <1571335639-21675-1-git-send-email-alan.maguire@oracle.com> <1571335639-21675-4-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1571335639-21675-4-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 7 Nov 2019 17:24:21 -0800
Message-ID: <CAFd5g46s=zgJXKRKj8iw5Bng=a06wb-PmDs_7-c7c-MiryrnAg@mail.gmail.com>
Subject: Re: [PATCH v3 linux-kselftest-test 3/6] kunit: add
 kunit_find_symbol() function for symbol lookup
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 17, 2019 at 11:08 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> In preparation for module support for kunit and kunit tests,
> we need a way of retrieving non-exported symbols from the
> core kernel and modules.  kunit_find_symbol() supports this.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Knut Omang <knut.omang@oracle.com>

I think you suggested on another thread that splitting this patch out
of this patchset might be a good idea. I agree with that. Can you send
this patch separately?

> ---
>  include/kunit/test.h  |  8 ++++++++
>  lib/kunit/test-test.c | 19 +++++++++++++++++++
>  lib/kunit/test.c      | 36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 63 insertions(+)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index dba4830..c645d18 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -339,6 +339,14 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
>
>  void kunit_cleanup(struct kunit *test);
>
> +/**
> + * kunit_find_symbol() - lookup un-exported symbol in kernel or modules.
> + * @sym: symbol name.
> + *
> + * Returns symbol or ERR_PTR value on error.

Can you document which ERR_PTRs it returns?

> + */
> +void *kunit_find_symbol(const char *sym);
> +
>  #define kunit_printk(lvl, test, fmt, ...) \
>         printk(lvl "\t# %s: " fmt, (test)->name, ##__VA_ARGS__)
>
> diff --git a/lib/kunit/test-test.c b/lib/kunit/test-test.c
> index c4162a9..7f09dd0 100644
> --- a/lib/kunit/test-test.c
> +++ b/lib/kunit/test-test.c
> @@ -330,3 +330,22 @@ static void kunit_resource_test_exit(struct kunit *test)
>         .test_cases = kunit_resource_test_cases,
>  };
>  kunit_test_suite(kunit_resource_test_suite);
> +
> +/*
> + * Find non-exported kernel symbol; we use the modules list as a safe
> + * choice that should always be present.
> + */
> +static void kunit_find_symbol_kernel(struct kunit *test)
> +{
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, kunit_find_symbol("modules"));

I think this should be a KUNIT_EXPECT_... here since nothing in this
test case depends on this check passing.

> +}
> +
> +static struct kunit_case kunit_find_symbol_test_cases[] = {
> +       KUNIT_CASE(kunit_find_symbol_kernel),
> +};
> +
> +static struct kunit_suite kunit_find_symbol_test_suite = {
> +       .name = "kunit-find-symbol",
> +       .test_cases = kunit_find_symbol_test_cases,
> +};
> +kunit_test_suite(kunit_find_symbol_test_suite);
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 49ac5fe..a2b1b46 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -8,6 +8,7 @@
>
>  #include <kunit/test.h>
>  #include <kunit/try-catch.h>
> +#include <linux/kallsyms.h>
>  #include <linux/kernel.h>
>  #include <linux/sched/debug.h>
>  #include "string-stream-impl.h"
> @@ -478,3 +479,38 @@ void kunit_cleanup(struct kunit *test)
>                 kunit_resource_free(test, resource);
>         }
>  }
> +
> +/*
> + * Support for looking up kernel/module internal symbols to enable testing.
> + */
> +void *kunit_find_symbol(const char *sym)
> +{
> +       unsigned long (*modlookup)(const char *name);
> +       unsigned long addr = 0;
> +
> +       if (!sym || strlen(sym) > KSYM_NAME_LEN)
> +               return ERR_PTR(-EINVAL);
> +
> +       /*
> +        * Try for kernel-internal symbol first; fall back to modules
> +        * if that fails.
> +        */
> +       addr = kallsyms_lookup_name(sym);
> +       if (addr)
> +               return (void *)addr;

nit: please add a newline here.

> +       modlookup = (void *)kallsyms_lookup_name("module_kallsyms_lookup_name");

Can you add a comment here explaining what module_kallsyms_lookup_name
is and why you need to look it up this way?

> +       if (modlookup)
> +               addr = modlookup(sym);
> +       if (addr)
> +               return (void *)addr;
> +
> +#ifndef CONFIG_KALLSYMS_ALL
> +       WARN_ONCE(true,
> +                 "CONFIG_KALLSYMS_ALL is not set, so unexported symbols like '%s' are not available\n",
> +                 sym);
> +       return ERR_PTR(-ENOTSUPP);
> +#else
> +       WARN_ONCE(true, "symbol '%s' is not available\n", sym);
> +#endif
> +       return ERR_PTR(-ENOENT);
> +}
> --
> 1.8.3.1
>
