Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99D73923E6
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 May 2021 02:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhE0AzU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 20:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbhE0AzU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 20:55:20 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B951C061761
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 17:53:47 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id c2so1986832ilo.11
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 17:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ob5N3fCbbDLB0UERbmW+vRDN/1QFz9ChAAVkpFKx6WE=;
        b=PVRxPnxOEA+/JYbCOrw8gof/L0tDYA6KH+myRNCeNYJgvRZnXm7YSDr1t89NTga/hc
         ijECgrQkelx4cpC544ttqJR0QAVvxmRs+dcOJPy4A3W4WMcyX4l+ncMQx6L7QR5uqMzf
         RbQJkAG97zN9XoffEzawuX9uYdxNjc4G2ZQ/pKTdnbhlBMath7DaX7LzRHGFGlfqPEfP
         S3gS1OXtU2IkFHM+Y5AOHGuMkS+L5b6VmksQO5Lw/52GzjtcQOOEXSTUobgsEBn1xZAo
         61bif5xinqeibBnCUHQTjTW1VcBiM6zpvtUTIe+BS1od64d0+I+TSJeeNJ9TeW1+pwDi
         hKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ob5N3fCbbDLB0UERbmW+vRDN/1QFz9ChAAVkpFKx6WE=;
        b=UHBI7C84AOs/hcuLpSUI2SspYPMEcRJOs00PCDi9Fsv+e9FZwBEMsKMFkl9oYtxwUx
         csGxYwlnRTYl2xPj+00TJQb8PEwfFkdb+MYKCABggBfgvDcjfMmJ/5FWQEG05dwMI3rr
         W4sXM3Eia32rkdmlst0egE7pao5ory8m9lu9R0amSKoAbafGzkJh/HGXhk6fUoeXCJHS
         wZvNoucgUjh+yJn0hvA+2QhnP1bTc1SI8WOGjvwsMQlu0rOAOuSn2SK0xsBaqOV2JY+c
         j8DUyAWvRQh+smONJNMQUpxwT7vdoT0+X/Uoo9UIUAByRkzIWtmzrJoC/M94A5pRsXrk
         1nPQ==
X-Gm-Message-State: AOAM533etbwYbj3sAZmiqYUdRDj8oESw5YZ4oqJE1IGSyr3bLn0CbMfT
        RT80BxLzVongJ8VK7Odn/Rq4lnUtpX51XP7iPib+jw==
X-Google-Smtp-Source: ABdhPJxS7nyUKrCQsDFuq4gpM9vG/4EXxxA61T+RkbgzfkVzdV5dCEzm0jA8Ai9X5nEB9uLsd5RLiJZXX8rsLCkVBp4=
X-Received: by 2002:a05:6e02:2188:: with SMTP id j8mr871603ila.194.1622076826115;
 Wed, 26 May 2021 17:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210526212407.2753879-1-brendanhiggins@google.com> <20210526212407.2753879-2-brendanhiggins@google.com>
In-Reply-To: <20210526212407.2753879-2-brendanhiggins@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 26 May 2021 17:53:34 -0700
Message-ID: <CAGS_qxqZsG8oqQx0hY5VjMNkX643Hb_uPKp_oxUcC34F230dgA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] kunit: Add 'kunit_shutdown' option
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     shuah <shuah@kernel.org>, David Gow <davidgow@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 26, 2021 at 2:24 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
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
> Tested-By: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Looks good, one optional nit below.

Also, I tested this again on top of 5.13-r4 (7ac3a1c1ae51 ("Merge tag
'mtd/fixes-for-5.13-rc4' of
git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux"))

$ echo -e "\nCONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y\nCONFIG_GCOV=y"
>> .kunit/.kunitconfig
$ run_kunit --make_options=CC=/usr/bin/gcc-6
$ <run coverage generation steps>
Overall coverage rate:
  lines......: 13.8% (17286 of 125320 lines)
  functions..: 15.8% (1790 of 11336 functions)

So coverage still seems to be fixed, no need to comment out the
uml_abort() anymore and this sidesteps whatever weird issue I started
running into these past few weeks.
So that's very exciting.

> ---
>  lib/kunit/executor.c                | 20 ++++++++++++++++++++
>  tools/testing/kunit/kunit_kernel.py |  2 +-
>  tools/testing/kunit/kunit_parser.py |  2 +-
>  3 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 15832ed446685..7db619624437c 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> +#include <linux/reboot.h>
>  #include <kunit/test.h>
>  #include <linux/glob.h>
>  #include <linux/moduleparam.h>
> @@ -18,6 +19,9 @@ module_param(filter_glob, charp, 0);
>  MODULE_PARM_DESC(filter_glob,
>                 "Filter which KUnit test suites run at boot-time, e.g. list*");
>
> +static char *kunit_shutdown;
> +core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
> +
>  static struct kunit_suite * const *
>  kunit_filter_subsuite(struct kunit_suite * const * const subsuite)
>  {
> @@ -82,6 +86,20 @@ static struct suite_set kunit_filter_suites(void)
>         return filtered;
>  }
>
> +static void kunit_handle_shutdown(void)
> +{
> +       if (!kunit_shutdown)
> +               return;
> +
> +       if (!strcmp(kunit_shutdown, "poweroff"))
> +               kernel_power_off();
> +       else if (!strcmp(kunit_shutdown, "halt"))
> +               kernel_halt();
> +       else if (!strcmp(kunit_shutdown, "reboot"))
> +               kernel_restart(NULL);

nit: should we complain about an unknown option here?

> +
> +}
> +
>  static void kunit_print_tap_header(struct suite_set *suite_set)
>  {
>         struct kunit_suite * const * const *suites, * const *subsuite;
> @@ -112,6 +130,8 @@ int kunit_run_all_tests(void)
>                 kfree(suite_set.start);
>         }
>
> +       kunit_handle_shutdown();
> +
>         return 0;
>  }
>
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 89a7d4024e878..dbbceaee12305 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -208,7 +208,7 @@ class LinuxSourceTree(object):
>         def run_kernel(self, args=None, build_dir='', filter_glob='', timeout=None) -> Iterator[str]:
>                 if not args:
>                         args = []
> -               args.extend(['mem=1G', 'console=tty'])
> +               args.extend(['mem=1G', 'console=tty', 'kunit_shutdown=halt'])
>                 if filter_glob:
>                         args.append('kunit.filter_glob='+filter_glob)
>                 self._ops.linux_bin(args, timeout, build_dir)
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index e8bcc139702e2..8d8d4d70b39dd 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -49,7 +49,7 @@ class TestStatus(Enum):
>
>  kunit_start_re = re.compile(r'TAP version [0-9]+$')
>  kunit_end_re = re.compile('(List of all partitions:|'
> -                         'Kernel panic - not syncing: VFS:)')
> +                         'Kernel panic - not syncing: VFS:|reboot: System halted)')
>
>  def isolate_kunit_output(kernel_output) -> Iterator[str]:
>         started = False
> --
> 2.31.1.818.g46aad6cb9e-goog
>
