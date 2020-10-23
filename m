Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EEB297852
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Oct 2020 22:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756225AbgJWUiD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Oct 2020 16:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756222AbgJWUiD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Oct 2020 16:38:03 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C678C0613CE
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Oct 2020 13:38:03 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b26so2351040pff.3
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Oct 2020 13:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2JS/43RkHHZdrt2VaZ0K3TX0I2NKFh2fkNnuPhPw8uw=;
        b=UXEz+yk8+LHf0mYTiGAPZWQuKMF0sE8GoPkG6vUgoAyayAN1OrqvBlrqfaVKpPv6q+
         qIaE2lNGlg+OijT5fJFF3x2KF62lf7m255c3qrk6vBINnnOVAJj3FzaQO3KnqU3SPKuy
         XUkKeS+rin3Yh3NxB4p2CAmEIvjwLzk+gcvUr+81zOMMc9EG/PQq15DHwYTzTqxTJSuh
         4lgI08KBrdp8g1IHVDOTPqRHJ0/6ISGGKtoo2LHvjs+hg+hTMV9Dfa5u4ZG+XtDNCMG+
         aKi0UbLhe+kqS4ELTyL2OF/CGABRfriHsP4M0QOooUwMlsXKLRITbAl7o0BEZ0aqoFhb
         efrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2JS/43RkHHZdrt2VaZ0K3TX0I2NKFh2fkNnuPhPw8uw=;
        b=m/Cn3P6G5yMjyYKef4ClWQYWtNrjzL0KxQ5nzeVG6jZrNZhUcBOc1NrUmhlElZI97j
         y5c5N0/CnHsamFm11uYfkWHxXZ/sDIDDLsA+TO8GNqoP6I6tP4xfCkHQn0bUffyBPqwX
         2/y5BU3SJ11XDUszDQlXMy3DYBaE2iYt9UnWa1w/7w/d+qIf6sH9kCg3AM+L6WOqcLzQ
         JbI9OfFcuqN3zMjClxN+Z2xUuy7dzgoG7aFyYoZLvSPCL2rqaZX+4OAUZuK/9SCfHFa2
         /0FQMoiuiICVfJkmO/EUI5ZjNaO9LXOWGCgcN4cVVnIH1I3NS5zLNsOm/whfC6X3R3ll
         wcOA==
X-Gm-Message-State: AOAM530d9tgvZKCKWX7OLhRJIutfF/lJ79qAQVuDhhfVUiGcZcNhzxM4
        FUQ23tmXex0h6dNoa274sO0djyEBpge8z7v9/vyT10+ON3rb5Q==
X-Google-Smtp-Source: ABdhPJwDciR0rTrETjtWab+QaY+RDdTWAFzzE5jBHW04I3LU3xEPpdw6p/VacNixmvq0oJ1QfXUYufp1pqxSTaneEfI=
X-Received: by 2002:a62:3782:0:b029:15d:2c3e:ca14 with SMTP id
 e124-20020a6237820000b029015d2c3eca14mr894881pfa.38.1603485482581; Fri, 23
 Oct 2020 13:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201015152348.65147-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20201015152348.65147-1-andriy.shevchenko@linux.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 23 Oct 2020 13:37:50 -0700
Message-ID: <CAFd5g44yjHcEEA-5XEPjqFn2DdS6V9T3bB7qo_c5XEQd5bAHfg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] kunit: Do not pollute source directory with
 generated files (.kunitconfig)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 15, 2020 at 8:23 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> When --build_dir is provided use it and do not pollute source directory
> which even can be mounted over network or read-only.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>

One minor nit below:

> ---
>  tools/testing/kunit/kunit.py        | 25 ++++++++++++-------------
>  tools/testing/kunit/kunit_kernel.py | 24 +++++++++++++++++++-----
>  2 files changed, 31 insertions(+), 18 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index ebf5f5763dee..1907bf9aacac 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -11,7 +11,6 @@ import argparse
>  import sys
>  import os
>  import time
> -import shutil
>
>  from collections import namedtuple
>  from enum import Enum, auto
> @@ -44,11 +43,6 @@ class KunitStatus(Enum):
>         BUILD_FAILURE = auto()
>         TEST_FAILURE = auto()
>
> -def create_default_kunitconfig():
> -       if not os.path.exists(kunit_kernel.kunitconfig_path):
> -               shutil.copyfile('arch/um/configs/kunit_defconfig',
> -                               kunit_kernel.kunitconfig_path)
> -
>  def get_kernel_root_path():
>         parts = sys.argv[0] if not __file__ else __file__
>         parts = os.path.realpath(parts).split('tools/testing/kunit')
> @@ -61,7 +55,6 @@ def config_tests(linux: kunit_kernel.LinuxSourceTree,
>         kunit_parser.print_with_timestamp('Configuring KUnit Kernel ...')
>
>         config_start = time.time()
> -       create_default_kunitconfig()
>         success = linux.build_reconfig(request.build_dir, request.make_options)
>         config_end = time.time()
>         if not success:
> @@ -262,12 +255,12 @@ def main(argv, linux=None):
>                 if not os.path.exists(cli_args.build_dir):
>                         os.mkdir(cli_args.build_dir)
>
> -               if not os.path.exists(kunit_kernel.kunitconfig_path):
> -                       create_default_kunitconfig()
> -
>                 if not linux:
>                         linux = kunit_kernel.LinuxSourceTree()
>
> +               linux.create_unitconfig(cli_args.build_dir)
> +               linux.read_unitconfig(cli_args.build_dir)
> +
>                 request = KunitRequest(cli_args.raw_output,
>                                        cli_args.timeout,
>                                        cli_args.jobs,
> @@ -283,12 +276,12 @@ def main(argv, linux=None):
>                                 not os.path.exists(cli_args.build_dir)):
>                         os.mkdir(cli_args.build_dir)
>
> -               if not os.path.exists(kunit_kernel.kunitconfig_path):
> -                       create_default_kunitconfig()
> -
>                 if not linux:
>                         linux = kunit_kernel.LinuxSourceTree()
>
> +               linux.create_unitconfig(cli_args.build_dir)
> +               linux.read_unitconfig(cli_args.build_dir)
> +
>                 request = KunitConfigRequest(cli_args.build_dir,
>                                              cli_args.make_options)
>                 result = config_tests(linux, request)
> @@ -301,6 +294,9 @@ def main(argv, linux=None):
>                 if not linux:
>                         linux = kunit_kernel.LinuxSourceTree()
>
> +               linux.create_unitconfig(cli_args.build_dir)
> +               linux.read_unitconfig(cli_args.build_dir)
> +
>                 request = KunitBuildRequest(cli_args.jobs,
>                                             cli_args.build_dir,
>                                             cli_args.alltests,
> @@ -315,6 +311,9 @@ def main(argv, linux=None):
>                 if not linux:
>                         linux = kunit_kernel.LinuxSourceTree()
>
> +               linux.create_unitconfig(cli_args.build_dir)
> +               linux.read_unitconfig(cli_args.build_dir)
> +
>                 exec_request = KunitExecRequest(cli_args.timeout,
>                                                 cli_args.build_dir,
>                                                 cli_args.alltests)
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index b557b1e93f98..412dc5e3102b 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -6,10 +6,10 @@
>  # Author: Felix Guo <felixguoxiuping@gmail.com>
>  # Author: Brendan Higgins <brendanhiggins@google.com>
>
> -
>  import logging
>  import subprocess
>  import os
> +import shutil
>  import signal
>
>  from contextlib import ExitStack
> @@ -18,7 +18,8 @@ import kunit_config
>  import kunit_parser
>
>  KCONFIG_PATH = '.config'
> -kunitconfig_path = '.kunitconfig'
> +KUNITCONFIG_PATH = '.kunitconfig'
> +DEFAULT_KUNITCONFIG_PATH = 'arch/um/configs/kunit_defconfig'
>  BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
>
>  class ConfigError(Exception):
> @@ -99,19 +100,22 @@ class LinuxSourceTreeOperations(object):
>                                                    stderr=subprocess.STDOUT)
>                         process.wait(timeout)
>
> -
>  def get_kconfig_path(build_dir):
>         kconfig_path = KCONFIG_PATH
>         if build_dir:
>                 kconfig_path = os.path.join(build_dir, KCONFIG_PATH)
>         return kconfig_path
>
> +def get_kunitconfig_path(build_dir):
> +       kunitconfig_path = KUNITCONFIG_PATH
> +       if build_dir:
> +               kunitconfig_path = os.path.join(build_dir, KUNITCONFIG_PATH)
> +       return kunitconfig_path
> +
>  class LinuxSourceTree(object):
>         """Represents a Linux kernel source tree with KUnit tests."""
>
>         def __init__(self):
> -               self._kconfig = kunit_config.Kconfig()
> -               self._kconfig.read_from_file(kunitconfig_path)
>                 self._ops = LinuxSourceTreeOperations()
>                 signal.signal(signal.SIGINT, self.signal_handler)
>
> @@ -123,6 +127,16 @@ class LinuxSourceTree(object):
>                         return False
>                 return True
>
> +       def create_unitconfig(self, build_dir, defconfig=DEFAULT_KUNITCONFIG_PATH):

nit: I think this should be create_kunitconfig() since everything else
refers to it as kunitconfig.

> +               kunitconfig_path = get_kunitconfig_path(build_dir)
> +               if not os.path.exists(kunitconfig_path):
> +                       shutil.copyfile(defconfig, kunitconfig_path)
> +
> +       def read_unitconfig(self, build_dir):

nit: Same as above: s/read_unitconfig/read_kunitconfig/.

> +               kunitconfig_path = get_kunitconfig_path(build_dir)
> +               self._kconfig = kunit_config.Kconfig()
> +               self._kconfig.read_from_file(kunitconfig_path)
> +
>         def validate_config(self, build_dir):
>                 kconfig_path = get_kconfig_path(build_dir)
>                 validated_kconfig = kunit_config.Kconfig()
> --
> 2.28.0
