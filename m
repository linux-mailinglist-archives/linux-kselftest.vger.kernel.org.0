Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC46836F252
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Apr 2021 23:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbhD2Vxs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Apr 2021 17:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbhD2Vxs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Apr 2021 17:53:48 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C3BC06138B
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Apr 2021 14:53:00 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id z23so31791897lji.4
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Apr 2021 14:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EjH+o6UjzQ/Am12P1LLl5WjEAhv3JEtTZEWuxrZg3O0=;
        b=Ha119dA0JNsUpBFRKqGtG4fA4JtuHTwk8w90di3c/eFv5DMhUhzO57V9YFQxD4FY5K
         n4Fe5wb3RYCw45myOLUdo03vx35EIK+pOxiKRb+Ayw7IR6G1nlz52lsoP9A87rRrLNr7
         mx6/ijMStfVsrI+xm5w54lnWMAQW1+TDC5SdURI60f4mSfFmwZVM7SVxl/Kjw2Pa6deJ
         Zq06mpnFSUmlAcgRS0qxLJ1yC8mZMiy8BiVrQc09cbBgfk9j2Mqbtm+F8hiA0/VSrZ0L
         cGMHC6wSiS9mLjtLHxpWPUTJm6W1X3nfw33//OOz4L2TsSL5o161R/vkTJvG36xqhULu
         M+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EjH+o6UjzQ/Am12P1LLl5WjEAhv3JEtTZEWuxrZg3O0=;
        b=gZGJ1nwfaG1HqSnCVaqv4vgvjxKG3ErC+ptsWittrLg0/PRtik+Wl/RCyAoHOmj1WX
         yFr8DxZ+oOSmRGTAFrz/Z0Jlv791nI8aREvJtDDscYH7nVEIXeIrF3fnf8vuhQxY9t0H
         AQYhir3kO7/IqG3JJqpyzGo7nnDlJhoQBEUstgW6CDM1P7UXMBLvXsPCwrbbYGL8eENC
         oqfhiHqX0IovhofLeyHsqp4UWylF9pqf/XuUZ3GxZONAj10r50bRM1ljH3YDCsVd9izn
         rG6KH4Czi3TS2zRriwONGhdtRt7zNSu5hUe4j0WRQOrUkL78eF3mIewqCewkiF6ywrgg
         23gQ==
X-Gm-Message-State: AOAM531yW0pJSTEGnjULb3usnzd9HwWET5Bltz+B4y6jfANDZDEf05uo
        coJ6SITNPiCUu4ciwiI4uExtn+puMYvShddGcHkcDQ==
X-Google-Smtp-Source: ABdhPJz2vZyb8EjDXoBz5aJqdCJaHJxbASKD9ocqOG9byUNYhtvhV1GrDtGe3hly7FxSRBKHBFr6Xffa/kBY7R2DNFo=
X-Received: by 2002:a2e:9357:: with SMTP id m23mr1266773ljh.446.1619733179148;
 Thu, 29 Apr 2021 14:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210429205109.2847831-1-brendanhiggins@google.com> <20210429205109.2847831-2-brendanhiggins@google.com>
In-Reply-To: <20210429205109.2847831-2-brendanhiggins@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 29 Apr 2021 14:52:48 -0700
Message-ID: <CAGS_qxp+ToCmvhT=HWy=pzOczL4ayqKAdhTFbBVaXTc9Dbwm2Q@mail.gmail.com>
Subject: Re: [RFC v2 1/4] kunit: Add 'kunit_shutdown' option
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     shuah@kernel.org, David Gow <davidgow@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Kees Cook <keescook@chromium.org>, frowand.list@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 29, 2021 at 1:51 PM Brendan Higgins
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

Tested-By: Daniel Latypov <dlatypov@google.com>

Testing this out, I think this also helps fix coverage on UML.
I used to have to hack in something like this:

diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index 07327425d06e..e13763faedd9 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -146,7 +146,7 @@ void os_dump_core(void)
        while ((pid = waitpid(-1, NULL, WNOHANG | __WALL)) > 0)
                os_kill_ptraced_process(pid, 0);

-       uml_abort();
+       exit(127);
 }

 void um_early_printk(const char *s, unsigned int n)

And afaict, this patch removes the need to do so.
(But I made a few mistakes when initially trying to test that out, so
I'm not 100% certain I didn't make another).

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
> index f309a33256cd3..7d5b77967d48f 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -206,7 +206,7 @@ class LinuxSourceTree(object):
>         def run_kernel(self, args=None, build_dir='', filter_glob='', timeout=None) -> Iterator[str]:
>                 if not args:
>                         args = []
> -               args.extend(['mem=1G', 'console=tty'])
> +               args.extend(['mem=1G', 'console=tty','kunit_shutdown=halt'])
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
> 2.31.1.498.g6c1eba8ee3d-goog
>
