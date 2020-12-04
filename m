Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF282CE6BD
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Dec 2020 04:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgLDD6B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Dec 2020 22:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgLDD6B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Dec 2020 22:58:01 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECFBC061A51
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Dec 2020 19:57:20 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id d20so5820903lfe.11
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Dec 2020 19:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9LvDpCFgpksA5duy2jWCVuigY6pzXW/Ezun4pZbZ3YQ=;
        b=n28a6x6LY836YObGGnzweojowvJaVHAuObQw8OsMsLkcoPO4vDtV8kEBa66AcY3NWx
         vOuP0fuxV2SdqrEWDwROhsd+okgUxE7K4RHSka5Zw/RPL313iQD/Khq/FFXKcx8/ZPNC
         0U+jaY90THYUebF942AZYH7o8KCjIrCRG98qgI43iI2vvxP5s7sd04kjQ9thJHXKDvkY
         oDSHeGzcQv7bMCPF8uI+x7KfPJSzpUrV5ZzgTHARwk1mEXJlh0JzTpUMCBKlgYRMR8Tu
         ns34Ig1JpI0gaGcdeVIuQppIi4+mHBTo8zwZC0+vp2gqRu7UsATQ1DzvCRrsRn87EUHb
         urew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9LvDpCFgpksA5duy2jWCVuigY6pzXW/Ezun4pZbZ3YQ=;
        b=b8wJAIcr/7BRfFxb6UQWKX4nmLbrEdg/BldkCbhkqCEFAP1zwFvN/XzPhTTIJUKDj2
         IfhkRGc3ZjD/do4GpU00GZKvMyWvHE6prMxFPpsQtTTY8VCHdyj9ARITh1cvWbQ1pXob
         nu593DUZbEdAtcXa5KMTOdQxR3IKuNdavrPOvNvqI8xLegr1vERfwqKOu2oQvJuYafIE
         pqZxsjEAy2KlVMWppsGDuPxPR13wcrx6fgb44t4rLk3UTu77DfL+ZWfsQ7NKRov4ebjU
         /rI1Tc1CPCGq4KDvOf6YLuskzf9zUBGzA+Y7mp+Z1PYCnXvlXi4D4x+tadVp9wSste/3
         W5bA==
X-Gm-Message-State: AOAM530tQAVlkOW5Pvtc2JUQY0Dk7l4wQ1P6BSKt06C2wrljwB5OicSr
        rSPU5rVQ1wDVXRsTR+jmDYQ1Gmic/AQkEPHpgF6lO4oSuCdE2+fhSbI=
X-Google-Smtp-Source: ABdhPJydPwKP3XFka948TBpWnXgE+btbuMdx5m8UtuFgsBY6I8gu9kiV/xbMWS/KwWqi0EzjP+uKeV9Ng41DWc3Kjdw=
X-Received: by 2002:a19:246:: with SMTP id 67mr2401523lfc.234.1607054238673;
 Thu, 03 Dec 2020 19:57:18 -0800 (PST)
MIME-Version: 1.0
References: <20201203194127.1813731-1-dlatypov@google.com> <20201203194127.1813731-3-dlatypov@google.com>
In-Reply-To: <20201203194127.1813731-3-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 4 Dec 2020 11:57:05 +0800
Message-ID: <CABVgOS=YfJdqmmU22XR4e84YyHudhksQc8X2rR1mz=6ukN=emA@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: tool: move kunitconfig parsing into __init__
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 4, 2020 at 3:41 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> LinuxSourceTree will unceremoniously crash if the user doesn't call
> read_kunitconfig() first in a number of functions.

This patch seems to partly be reverting the changes here, right:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/tools/testing/kunit?h=kunit&id=fcdb0bc08ced274078f371e1e0fe6421a97fa9f2
(That patch moved the reading of kunitconfig out of __init__)

My overall concern is that, really, there are some operations that
shouldn't need a kunitconfig (even if they do at the moment), so we'd
ideally want at least some of the operations currently under
LinuxSourceTree to be able to be run without first reading a
kunitconfig. Most notably, it'd be nice if kunit.py exec (and hence
LinuxSourceTree::run_kernel()) didn't need a kunitconfig, as the
kernel ought to already be built at this point.

Now, this is all a little bit hypothetical, as we haven't bothered to
make kunit.py exec work without a kunitconfig thus far, but I'm a
touch hesitant to make it harder to bypass the kunitconfig reading
anyway.

>
> Adn currently every place we create an instance, the caller also calls
> create_kunitconfig() and read_kunitconfig().
>
> Move these instead into __init__() so they can't be forgotten and to
> reduce copy-paste.

This seems to now be missing the create_kunitconfig() stuff (see below).
>
> The https://github.com/google/pytype type-checker complained that
> _config wasn't initialized. With this, kunit_tool now type checks
> under both pytype and mypy.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---
>  tools/testing/kunit/kunit.py        | 20 ++++----------------
>  tools/testing/kunit/kunit_kernel.py | 19 +++++++------------
>  2 files changed, 11 insertions(+), 28 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 08951a114654..b58fb3733cfa 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -256,10 +256,7 @@ def main(argv, linux=None):
>                         os.mkdir(cli_args.build_dir)
>
>                 if not linux:
> -                       linux = kunit_kernel.LinuxSourceTree()
> -
> -               linux.create_kunitconfig(cli_args.build_dir)
> -               linux.read_kunitconfig(cli_args.build_dir)
> +                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
>
>                 request = KunitRequest(cli_args.raw_output,
>                                        cli_args.timeout,
> @@ -277,10 +274,7 @@ def main(argv, linux=None):
>                         os.mkdir(cli_args.build_dir)
>
>                 if not linux:
> -                       linux = kunit_kernel.LinuxSourceTree()
> -
> -               linux.create_kunitconfig(cli_args.build_dir)
> -               linux.read_kunitconfig(cli_args.build_dir)
> +                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
>
>                 request = KunitConfigRequest(cli_args.build_dir,
>                                              cli_args.make_options)
> @@ -292,10 +286,7 @@ def main(argv, linux=None):
>                         sys.exit(1)
>         elif cli_args.subcommand == 'build':
>                 if not linux:
> -                       linux = kunit_kernel.LinuxSourceTree()
> -
> -               linux.create_kunitconfig(cli_args.build_dir)
> -               linux.read_kunitconfig(cli_args.build_dir)
> +                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
>
>                 request = KunitBuildRequest(cli_args.jobs,
>                                             cli_args.build_dir,
> @@ -309,10 +300,7 @@ def main(argv, linux=None):
>                         sys.exit(1)
>         elif cli_args.subcommand == 'exec':
>                 if not linux:
> -                       linux = kunit_kernel.LinuxSourceTree()
> -
> -               linux.create_kunitconfig(cli_args.build_dir)
> -               linux.read_kunitconfig(cli_args.build_dir)
> +                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
>
>                 exec_request = KunitExecRequest(cli_args.timeout,
>                                                 cli_args.build_dir,
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index bda7c4fd4d3e..79793031d2c4 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -129,10 +129,15 @@ def get_outfile_path(build_dir) -> str:
>  class LinuxSourceTree(object):
>         """Represents a Linux kernel source tree with KUnit tests."""
>
> -       def __init__(self) -> None:
> -               self._ops = LinuxSourceTreeOperations()
> +       def __init__(self, build_dir: str, defconfig=DEFAULT_KUNITCONFIG_PATH) -> None:
>                 signal.signal(signal.SIGINT, self.signal_handler)
>
> +               self._ops = LinuxSourceTreeOperations()
> +
> +               kunitconfig_path = get_kunitconfig_path(build_dir)
> +               self._kconfig = kunit_config.Kconfig()
> +               self._kconfig.read_from_file(kunitconfig_path)
> +
>         def clean(self) -> bool:
>                 try:
>                         self._ops.make_mrproper()
> @@ -141,16 +146,6 @@ class LinuxSourceTree(object):
>                         return False
>                 return True
>
> -       def create_kunitconfig(self, build_dir, defconfig=DEFAULT_KUNITCONFIG_PATH) -> None:
> -               kunitconfig_path = get_kunitconfig_path(build_dir)
> -               if not os.path.exists(kunitconfig_path):
> -                       shutil.copyfile(defconfig, kunitconfig_path)
> -

What happened to create_kunitconfig() here? With this patch, I can no
longer run .../kunit.py run with an empty build_dir and get results,
instead getting:
---
Traceback (most recent call last):
 File "./tools/testing/kunit/kunit.py", line 336, in <module>
   main(sys.argv[1:])
 File "./tools/testing/kunit/kunit.py", line 259, in main
   linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
 File "./tools/testing/kunit/kunit_kernel.py", line 139, in __init__
   self._kconfig.read_from_file(kunitconfig_path)
 File "./tools/testing/kunit/kunit_config.py", line 89, in read_from_file
   with open(path, 'r') as f:
FileNotFoundError: [Errno 2] No such file or directory: 'asdf/.kunitconfig'
---

Prior to this change, the defconfig is copied over, and the kernel is
built, tests run succesfully.


> -       def read_kunitconfig(self, build_dir) -> None:
> -               kunitconfig_path = get_kunitconfig_path(build_dir)
> -               self._kconfig = kunit_config.Kconfig()
> -               self._kconfig.read_from_file(kunitconfig_path)
> -
>         def validate_config(self, build_dir) -> bool:
>                 kconfig_path = get_kconfig_path(build_dir)
>                 validated_kconfig = kunit_config.Kconfig()
> --
> 2.29.2.576.ga3fc446d84-goog
>
