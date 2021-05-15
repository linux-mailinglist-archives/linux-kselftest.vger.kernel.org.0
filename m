Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE20B3816B8
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 May 2021 09:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhEOIBK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 May 2021 04:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbhEOIA4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 May 2021 04:00:56 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E578FC061760
        for <linux-kselftest@vger.kernel.org>; Sat, 15 May 2021 00:59:43 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id b7so227008wmh.5
        for <linux-kselftest@vger.kernel.org>; Sat, 15 May 2021 00:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JgrtmwCJmN4xeD0hp9ATQx8p2yXzijrNuCQXjnpGuhQ=;
        b=v6q2v1SSt16oCmQM5EHOrncSMHZogNtSFmWeiHdrQev8qQl2eoGUc0d6m3hGKMmJy4
         Hs44+ed43xauO+DI1QAkD68wL2wiDbE56XzoxgrV3/arMn64ehJWH3SZteBAeZ4dj+DX
         8y0jEOrDszZBrYB9IFZ046FifeWudKPAjtBul05ItUdcg3ZvOXOXPhvwPCitXmDb0/yX
         WDhzhIItbrHsOUQqUeh4pQxqd/LFhEruSVly3OKTPOxh2+Q+qmnMDACWqjXxK4egKsUk
         zV51ywxOrLVOIPcW5v9m94our9fsrEzLHKpHtAW6JiNVZMrWGzFBfKRpk+t4Co1NDqSz
         Fwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JgrtmwCJmN4xeD0hp9ATQx8p2yXzijrNuCQXjnpGuhQ=;
        b=g2mwM+7IGh7mZB8P35iy/wP2c1idIRvkrPt8PKDY7vQSA89pTUXqlatEP9l+ybCshX
         Ua8rNUTCCoNDJc1Xi/g5iMtQXcf4UD8wlE+x0jnsjFem5K27MyhvOJs1td9kJZDUZC1K
         ap4eSZDKm16stM5tVk8kSIs0BeZ7VI7ljtKz3gbHwgPCzAeuEJOq6taedUiX2jA052jD
         F95WGIaWon290aQU+pyVb5tsYuFhXJ6PblyJuA15DGwqVijmBnrY0zcqN10tD7HKt8d9
         DfxTEMBlu/9hEceGtQH1i2iHMZeTDp9mpeCvXtFftWsG5zxr7GAl4Ub7/9zYczoFbfe4
         eT3g==
X-Gm-Message-State: AOAM530NIsgCJ0sFwIkAplR05DRgHpvMHnw9R03PGonWfLUOgSpigDsg
        xPS3B6ZWckgjPU3GZiQJkV3i52/iambSbxHx7Xi8GA==
X-Google-Smtp-Source: ABdhPJxaUfWjFYCBa+DjxCQY7G0UW7RjBjx0hWP8VmTT3dq99ytSSlYqhZDNIHo3hd4xoRQmTBPadmi/GpK+1avWGHo=
X-Received: by 2002:a1c:a3c3:: with SMTP id m186mr1814751wme.39.1621065582319;
 Sat, 15 May 2021 00:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210507213110.155492-1-brendanhiggins@google.com> <20210507213110.155492-4-brendanhiggins@google.com>
In-Reply-To: <20210507213110.155492-4-brendanhiggins@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 15 May 2021 15:59:30 +0800
Message-ID: <CABVgOSmEe32_kT9TR0-H8biuWGc1Rexne86DgLxths+GUHHgig@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] kunit: tool: add support for QEMU
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000393a6805c259beeb"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000393a6805c259beeb
Content-Type: text/plain; charset="UTF-8"

On Sat, May 8, 2021 at 5:31 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Add basic support to run QEMU via kunit_tool. Add support for i386,
> x86_64, arm, arm64, and a bunch more.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Tested-by: David Gow <davidgow@google.com>
> ---
>
> Changes since last revision:
>
> - A number of minor obvious issues pointed out by David and Daniel.
> - Added facility for merging Kconfigs at Daniel's suggestion.
> - Broke out qemu_configs each into their own config file which is loaded
>   dynamically - mostly at David's suggestion.
>
> ---

This seems pretty good to me. I only have one real complaint --
qemu_configs needing to be in a subdirectory of ./tools/testing/kunit
-- but am able to tolerate that (even if I'd prefer not to have it) if
it's documented properly.

Otherwise, save for a couple of minor nitpicks, this seems good to go.

Reviewed-by: David Gow <davidgow@google.com>


>  tools/testing/kunit/kunit.py                |  57 ++++++-
>  tools/testing/kunit/kunit_config.py         |   7 +-
>  tools/testing/kunit/kunit_kernel.py         | 170 ++++++++++++++++----
>  tools/testing/kunit/kunit_tool_test.py      |  18 ++-
>  tools/testing/kunit/qemu_config.py          |  17 ++
>  tools/testing/kunit/qemu_configs/alpha.py   |  10 ++
>  tools/testing/kunit/qemu_configs/arm.py     |  13 ++
>  tools/testing/kunit/qemu_configs/arm64.py   |  12 ++
>  tools/testing/kunit/qemu_configs/i386.py    |  10 ++
>  tools/testing/kunit/qemu_configs/powerpc.py |  12 ++
>  tools/testing/kunit/qemu_configs/riscv.py   |  31 ++++
>  tools/testing/kunit/qemu_configs/s390.py    |  14 ++
>  tools/testing/kunit/qemu_configs/sparc.py   |  10 ++
>  tools/testing/kunit/qemu_configs/x86_64.py  |  10 ++
>  14 files changed, 350 insertions(+), 41 deletions(-)
>  create mode 100644 tools/testing/kunit/qemu_config.py
>  create mode 100644 tools/testing/kunit/qemu_configs/alpha.py
>  create mode 100644 tools/testing/kunit/qemu_configs/arm.py
>  create mode 100644 tools/testing/kunit/qemu_configs/arm64.py
>  create mode 100644 tools/testing/kunit/qemu_configs/i386.py
>  create mode 100644 tools/testing/kunit/qemu_configs/powerpc.py
>  create mode 100644 tools/testing/kunit/qemu_configs/riscv.py
>  create mode 100644 tools/testing/kunit/qemu_configs/s390.py
>  create mode 100644 tools/testing/kunit/qemu_configs/sparc.py
>  create mode 100644 tools/testing/kunit/qemu_configs/x86_64.py
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 5da8fb3762f98..be8d8d4a4e08f 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -70,10 +70,10 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
>         kunit_parser.print_with_timestamp('Building KUnit Kernel ...')
>
>         build_start = time.time()
> -       success = linux.build_um_kernel(request.alltests,
> -                                       request.jobs,
> -                                       request.build_dir,
> -                                       request.make_options)
> +       success = linux.build_kernel(request.alltests,
> +                                    request.jobs,
> +                                    request.build_dir,
> +                                    request.make_options)
>         build_end = time.time()
>         if not success:
>                 return KunitResult(KunitStatus.BUILD_FAILURE,
> @@ -189,6 +189,31 @@ def add_common_opts(parser) -> None:
>                              'will get  automatically appended.',
>                              metavar='kunitconfig')
>
> +       parser.add_argument('--arch',
> +                           help=('Specifies the architecture to run tests under. '
> +                                 'The architecture specified here must match the '
> +                                 'string passed to the ARCH make param, '
> +                                 'e.g. i386, x86_64, arm, um, etc. Non-UML '
> +                                 'architectures run on QEMU.'),
> +                           type=str, default='um', metavar='arch')
> +
> +       parser.add_argument('--cross_compile',
> +                           help=('Sets make\'s CROSS_COMPILE variable; it should '
> +                                 'be set to a toolchain path prefix (the prefix '
> +                                 'of gcc and other tools in your toolchain, for '
> +                                 'example `sparc64-linux-gnu-` if you have the '
> +                                 'sparc toolchain installed on your system, or '
> +                                 '`$HOME/toolchains/microblaze/gcc-9.2.0-nolibc/microblaze-linux/bin/microblaze-linux-` '
Super-minor nit: is there a shorter example we can give that's not
much longer than all the surrounding lines?

> +                                 'if you have downloaded the microblaze toolchain '
> +                                 'from the 0-day website to a directory in your '
> +                                 'home directory called `toolchains`).'),
> +                           metavar='cross_compile')
> +
> +       parser.add_argument('--qemu_config',
> +                           help=('Takes a path to a path to a file containing '
> +                                 'a QemuArchParams object.'),
> +                           type=str, metavar='qemu_config')
> +

If (as noted below) this file needs to be in a subdirectory of the
kunit_tool directory, we should document this, or maybe make this path
relative to the kunit_tool directory.

>  def add_build_opts(parser) -> None:
>         parser.add_argument('--jobs',
>                             help='As in the make command, "Specifies  the number of '
> @@ -270,7 +295,11 @@ def main(argv, linux=None):
>                         os.mkdir(cli_args.build_dir)
>
>                 if not linux:
> -                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir, kunitconfig_path=cli_args.kunitconfig)
> +                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> +                                       kunitconfig_path=cli_args.kunitconfig,
> +                                       arch=cli_args.arch,
> +                                       cross_compile=cli_args.cross_compile,
> +                                       qemu_config_path=cli_args.qemu_config)
>
>                 request = KunitRequest(cli_args.raw_output,
>                                        cli_args.timeout,
> @@ -289,7 +318,11 @@ def main(argv, linux=None):
>                         os.mkdir(cli_args.build_dir)
>
>                 if not linux:
> -                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir, kunitconfig_path=cli_args.kunitconfig)
> +                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> +                                       kunitconfig_path=cli_args.kunitconfig,
> +                                       arch=cli_args.arch,
> +                                       cross_compile=cli_args.cross_compile,
> +                                       qemu_config_path=cli_args.qemu_config)
>
>                 request = KunitConfigRequest(cli_args.build_dir,
>                                              cli_args.make_options)
> @@ -301,7 +334,11 @@ def main(argv, linux=None):
>                         sys.exit(1)
>         elif cli_args.subcommand == 'build':
>                 if not linux:
> -                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir, kunitconfig_path=cli_args.kunitconfig)
> +                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> +                                       kunitconfig_path=cli_args.kunitconfig,
> +                                       arch=cli_args.arch,
> +                                       cross_compile=cli_args.cross_compile,
> +                                       qemu_config_path=cli_args.qemu_config)
>
>                 request = KunitBuildRequest(cli_args.jobs,
>                                             cli_args.build_dir,
> @@ -315,7 +352,11 @@ def main(argv, linux=None):
>                         sys.exit(1)
>         elif cli_args.subcommand == 'exec':
>                 if not linux:
> -                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
> +                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> +                                       kunitconfig_path=cli_args.kunitconfig,
> +                                       arch=cli_args.arch,
> +                                       cross_compile=cli_args.cross_compile,
> +                                       qemu_config_path=cli_args.qemu_config)
>
>                 exec_request = KunitExecRequest(cli_args.timeout,
>                                                 cli_args.build_dir,
> diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
> index 1e2683dcc0e7a..c77c7d2ef6220 100644
> --- a/tools/testing/kunit/kunit_config.py
> +++ b/tools/testing/kunit/kunit_config.py
> @@ -52,8 +52,13 @@ class Kconfig(object):
>                                 return False
>                 return True
>
> +       def merge_in_entries(self, other: 'Kconfig') -> None:
> +               if other.is_subset_of(self):
> +                       return
> +               self._entries = list(self.entries().union(other.entries()))
> +
>         def write_to_file(self, path: str) -> None:
> -               with open(path, 'w') as f:
> +               with open(path, 'a+') as f:
>                         for entry in self.entries():
>                                 f.write(str(entry) + '\n')
>
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index e22ade9d91ad5..2bd196fd69e5c 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -6,23 +6,31 @@
>  # Author: Felix Guo <felixguoxiuping@gmail.com>
>  # Author: Brendan Higgins <brendanhiggins@google.com>
>
> +from __future__ import annotations
> +import importlib.util
>  import logging
>  import subprocess
>  import os
>  import shutil
>  import signal
>  from typing import Iterator
> +from typing import Optional
>
>  from contextlib import ExitStack
>
> +from collections import namedtuple
> +
>  import kunit_config
>  import kunit_parser
> +import qemu_config
>
>  KCONFIG_PATH = '.config'
>  KUNITCONFIG_PATH = '.kunitconfig'
>  DEFAULT_KUNITCONFIG_PATH = 'arch/um/configs/kunit_defconfig'
>  BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
>  OUTFILE_PATH = 'test.log'
> +ABS_TOOL_PATH = os.path.abspath(os.path.dirname(__file__))
> +QEMU_CONFIGS_DIR = os.path.join(ABS_TOOL_PATH, 'qemu_configs')
>
>  def get_file_path(build_dir, default):
>         if build_dir:
> @@ -40,6 +48,10 @@ class BuildError(Exception):
>  class LinuxSourceTreeOperations(object):
>         """An abstraction over command line operations performed on a source tree."""
>
> +       def __init__(self, linux_arch: str, cross_compile: Optional[str]):
> +               self._linux_arch = linux_arch
> +               self._cross_compile = cross_compile
> +
>         def make_mrproper(self) -> None:
>                 try:
>                         subprocess.check_output(['make', 'mrproper'], stderr=subprocess.STDOUT)
> @@ -48,12 +60,21 @@ class LinuxSourceTreeOperations(object):
>                 except subprocess.CalledProcessError as e:
>                         raise ConfigError(e.output.decode())
>
> +       def make_arch_qemuconfig(self, kconfig: kunit_config.Kconfig) -> None:
> +               pass
> +
> +       def make_allyesconfig(self, build_dir, make_options) -> None:
> +               raise ConfigError('Only the "um" arch is supported for alltests')
> +
>         def make_olddefconfig(self, build_dir, make_options) -> None:
> -               command = ['make', 'ARCH=um', 'olddefconfig']
> +               command = ['make', 'ARCH=' + self._linux_arch, 'olddefconfig']
> +               if self._cross_compile:
> +                       command += ['CROSS_COMPILE=' + self._cross_compile]
>                 if make_options:
>                         command.extend(make_options)
>                 if build_dir:
>                         command += ['O=' + build_dir]
> +               print('Populating config with:\n$', ' '.join(command))
>                 try:
>                         subprocess.check_output(command, stderr=subprocess.STDOUT)
>                 except OSError as e:
> @@ -61,6 +82,79 @@ class LinuxSourceTreeOperations(object):
>                 except subprocess.CalledProcessError as e:
>                         raise ConfigError(e.output.decode())
>
> +       def make(self, jobs, build_dir, make_options) -> None:
> +               command = ['make', 'ARCH=' + self._linux_arch, '--jobs=' + str(jobs)]
> +               if make_options:
> +                       command.extend(make_options)
> +               if self._cross_compile:
> +                       command += ['CROSS_COMPILE=' + self._cross_compile]
> +               if build_dir:
> +                       command += ['O=' + build_dir]
> +               print('Building with:\n$', ' '.join(command))
> +               try:
> +                       proc = subprocess.Popen(command,
> +                                               stderr=subprocess.PIPE,
> +                                               stdout=subprocess.DEVNULL)
> +               except OSError as e:
> +                       raise BuildError('Could not call execute make: ' + str(e))
> +               except subprocess.CalledProcessError as e:
> +                       raise BuildError(e.output)
> +               _, stderr = proc.communicate()
> +               if proc.returncode != 0:
> +                       raise BuildError(stderr.decode())
> +               if stderr:  # likely only due to build warnings
> +                       print(stderr.decode())
> +
> +       def run(self, params, timeout, build_dir, outfile) -> None:
> +               pass
> +
> +
> +class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
> +
> +       def __init__(self, qemu_arch_params: qemu_config.QemuArchParams, cross_compile: Optional[str]):
> +               super().__init__(linux_arch=qemu_arch_params.linux_arch,
> +                                cross_compile=cross_compile)
> +               self._qemuconfig = qemu_arch_params.qemuconfig
> +               self._qemu_arch = qemu_arch_params.qemu_arch
> +               self._kernel_path = qemu_arch_params.kernel_path
> +               self._kernel_command_line = qemu_arch_params.kernel_command_line + ' kunit_shutdown=reboot'
> +               self._extra_qemu_params = qemu_arch_params.extra_qemu_params
> +
> +       def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> None:
> +               qemuconfig = kunit_config.Kconfig()
> +               qemuconfig.parse_from_string(self._qemuconfig)
> +               base_kunitconfig.merge_in_entries(qemuconfig)
> +
> +       def run(self, params, timeout, build_dir, outfile):
> +               kernel_path = os.path.join(build_dir, self._kernel_path)
> +               qemu_command = ['qemu-system-' + self._qemu_arch,
> +                               '-nodefaults',
> +                               '-m', '1024',
> +                               '-kernel', kernel_path,
> +                               '-append', '\'' + ' '.join(params + [self._kernel_command_line]) + '\'',
> +                               '-no-reboot',
> +                               '-nographic',
> +                               '-serial stdio'] + self._extra_qemu_params
> +               print('Running tests with:\n$', ' '.join(qemu_command))
> +               with open(outfile, 'w') as output:
> +                       process = subprocess.Popen(' '.join(qemu_command),
> +                                                  stdin=subprocess.PIPE,
> +                                                  stdout=output,
> +                                                  stderr=subprocess.STDOUT,
> +                                                  text=True, shell=True)
> +               try:
> +                       process.wait(timeout=timeout)
> +               except Exception as e:
> +                       print(e)
> +                       process.terminate()
> +               return process
> +
> +class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
> +       """An abstraction over command line operations performed on a source tree."""
> +
> +       def __init__(self, cross_compile=None):
> +               super().__init__(linux_arch='um', cross_compile=cross_compile)
> +
>         def make_allyesconfig(self, build_dir, make_options) -> None:
>                 kunit_parser.print_with_timestamp(
>                         'Enabling all CONFIGs for UML...')
> @@ -83,32 +177,16 @@ class LinuxSourceTreeOperations(object):
>                 kunit_parser.print_with_timestamp(
>                         'Starting Kernel with all configs takes a few minutes...')
>
> -       def make(self, jobs, build_dir, make_options) -> None:
> -               command = ['make', 'ARCH=um', '--jobs=' + str(jobs)]
> -               if make_options:
> -                       command.extend(make_options)
> -               if build_dir:
> -                       command += ['O=' + build_dir]
> -               try:
> -                       proc = subprocess.Popen(command,
> -                                               stderr=subprocess.PIPE,
> -                                               stdout=subprocess.DEVNULL)
> -               except OSError as e:
> -                       raise BuildError('Could not call make command: ' + str(e))
> -               _, stderr = proc.communicate()
> -               if proc.returncode != 0:
> -                       raise BuildError(stderr.decode())
> -               if stderr:  # likely only due to build warnings
> -                       print(stderr.decode())
> -
> -       def linux_bin(self, params, timeout, build_dir) -> None:
> +       def run(self, params, timeout, build_dir, outfile):
>                 """Runs the Linux UML binary. Must be named 'linux'."""
>                 linux_bin = get_file_path(build_dir, 'linux')
>                 outfile = get_outfile_path(build_dir)
>                 with open(outfile, 'w') as output:
>                         process = subprocess.Popen([linux_bin] + params,
> +                                                  stdin=subprocess.PIPE,
>                                                    stdout=output,
> -                                                  stderr=subprocess.STDOUT)
> +                                                  stderr=subprocess.STDOUT,
> +                                                  text=True)
>                         process.wait(timeout)
>
>  def get_kconfig_path(build_dir) -> str:
> @@ -120,13 +198,49 @@ def get_kunitconfig_path(build_dir) -> str:
>  def get_outfile_path(build_dir) -> str:
>         return get_file_path(build_dir, OUTFILE_PATH)
>
> +def get_source_tree_ops(arch: str, cross_compile: Optional[str]) -> LinuxSourceTreeOperations:
> +       config_path = os.path.join(QEMU_CONFIGS_DIR, arch + '.py')
> +       if arch == 'um':
> +               return LinuxSourceTreeOperationsUml(cross_compile=cross_compile)
> +       elif os.path.isfile(config_path):
> +               return get_source_tree_ops_from_qemu_config(config_path, cross_compile)[1]
> +       else:
> +               raise ConfigError(arch + ' is not a valid arch')
> +
> +def get_source_tree_ops_from_qemu_config(config_path: str,
> +                                        cross_compile: Optional[str]) -> tuple[
> +                                                        str, LinuxSourceTreeOperations]:
> +       abs_config_path = os.path.abspath(config_path)
> +       if os.path.commonpath([ABS_TOOL_PATH, abs_config_path]) != ABS_TOOL_PATH:
> +               raise ConfigError('Given QEMU config file is not in a child directory of KUnit tool.')

I really don't like this requirement: it feels very arbitrary and
undercuts the value of the --qemu_config option a bit: we almost might
as well keep everything in the QEMU_CONFIG_DIR.

I assume it's here because of the need to import the QemuArchParams
definition: I take it there's no convenient way to do that?

At the very least, let's document this restriction properly, as it was
a bit of a weird one I wasn't expecting. Then people can either put
their custom qemu configs in the qemu_configs/ directory, or in
something like a custom_qemu_configs/ one. And if we later can work
out a more convenient way of removing this restriction entirely, we
can do so.

> +       relative_config_path = os.path.relpath(abs_config_path, ABS_TOOL_PATH)
> +       spec = importlib.util.spec_from_file_location('.' + relative_config_path, config_path)
> +       config = importlib.util.module_from_spec(spec)
> +       # TODO(brendanhiggins@google.com): I looked this up and apparently other
> +       # Python projects have noted that pytype complains that "No attribute
> +       # 'exec_module' on _importlib_modulespec._Loader". Disabling for now.
> +       spec.loader.exec_module(config) # pytype: disable=attribute-error
> +       return config.QEMU_ARCH.linux_arch, LinuxSourceTreeOperationsQemu(
> +                       config.QEMU_ARCH, cross_compile=cross_compile)
> +
>  class LinuxSourceTree(object):
>         """Represents a Linux kernel source tree with KUnit tests."""
>
> -       def __init__(self, build_dir: str, load_config=True, kunitconfig_path='') -> None:
> +       def __init__(
> +             self,
> +             build_dir: str,
> +             load_config=True,
> +             kunitconfig_path='',
> +             arch=None,
> +             cross_compile=None,
> +             qemu_config_path=None) -> None:
>                 signal.signal(signal.SIGINT, self.signal_handler)
> -
> -               self._ops = LinuxSourceTreeOperations()
> +               if qemu_config_path:
> +                       self._arch, self._ops = get_source_tree_ops_from_qemu_config(
> +                                       qemu_config_path, cross_compile)
> +               else:
> +                       self._arch = 'um' if arch is None else arch
> +                       self._ops = get_source_tree_ops(self._arch, cross_compile)
>
>                 if not load_config:
>                         return
> @@ -170,8 +284,9 @@ class LinuxSourceTree(object):
>                 kconfig_path = get_kconfig_path(build_dir)
>                 if build_dir and not os.path.exists(build_dir):
>                         os.mkdir(build_dir)
> -               self._kconfig.write_to_file(kconfig_path)
>                 try:
> +                       self._ops.make_arch_qemuconfig(self._kconfig)
> +                       self._kconfig.write_to_file(kconfig_path)
>                         self._ops.make_olddefconfig(build_dir, make_options)
>                 except ConfigError as e:
>                         logging.error(e)
> @@ -184,6 +299,7 @@ class LinuxSourceTree(object):
>                 if os.path.exists(kconfig_path):
>                         existing_kconfig = kunit_config.Kconfig()
>                         existing_kconfig.read_from_file(kconfig_path)
> +                       self._ops.make_arch_qemuconfig(self._kconfig)
>                         if not self._kconfig.is_subset_of(existing_kconfig):
>                                 print('Regenerating .config ...')
>                                 os.remove(kconfig_path)
> @@ -194,7 +310,7 @@ class LinuxSourceTree(object):
>                         print('Generating .config ...')
>                         return self.build_config(build_dir, make_options)
>
> -       def build_um_kernel(self, alltests, jobs, build_dir, make_options) -> bool:
> +       def build_kernel(self, alltests, jobs, build_dir, make_options) -> bool:
>                 try:
>                         if alltests:
>                                 self._ops.make_allyesconfig(build_dir, make_options)
> @@ -211,8 +327,8 @@ class LinuxSourceTree(object):
>                 args.extend(['mem=1G', 'console=tty','kunit_shutdown=halt'])
>                 if filter_glob:
>                         args.append('kunit.filter_glob='+filter_glob)
> -               self._ops.linux_bin(args, timeout, build_dir)
>                 outfile = get_outfile_path(build_dir)
> +               self._ops.run(args, timeout, build_dir, outfile)
>                 subprocess.call(['stty', 'sane'])
>                 with open(outfile, 'r') as file:
>                         for line in file:
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 2e809dd956a77..a3b7f68e1cf9f 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -303,7 +303,7 @@ class KUnitMainTest(unittest.TestCase):
>
>                 self.linux_source_mock = mock.Mock()
>                 self.linux_source_mock.build_reconfig = mock.Mock(return_value=True)
> -               self.linux_source_mock.build_um_kernel = mock.Mock(return_value=True)
> +               self.linux_source_mock.build_kernel = mock.Mock(return_value=True)
>                 self.linux_source_mock.run_kernel = mock.Mock(return_value=all_passed_log)
>
>         def test_config_passes_args_pass(self):
> @@ -314,7 +314,7 @@ class KUnitMainTest(unittest.TestCase):
>         def test_build_passes_args_pass(self):
>                 kunit.main(['build'], self.linux_source_mock)
>                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 0)
> -               self.linux_source_mock.build_um_kernel.assert_called_once_with(False, 8, '.kunit', None)
> +               self.linux_source_mock.build_kernel.assert_called_once_with(False, 8, '.kunit', None)
>                 self.assertEqual(self.linux_source_mock.run_kernel.call_count, 0)
>
>         def test_exec_passes_args_pass(self):
> @@ -396,7 +396,7 @@ class KUnitMainTest(unittest.TestCase):
>         def test_build_builddir(self):
>                 build_dir = '.kunit'
>                 kunit.main(['build', '--build_dir', build_dir], self.linux_source_mock)
> -               self.linux_source_mock.build_um_kernel.assert_called_once_with(False, 8, build_dir, None)
> +               self.linux_source_mock.build_kernel.assert_called_once_with(False, 8, build_dir, None)
>
>         def test_exec_builddir(self):
>                 build_dir = '.kunit'
> @@ -410,14 +410,22 @@ class KUnitMainTest(unittest.TestCase):
>                 mock_linux_init.return_value = self.linux_source_mock
>                 kunit.main(['run', '--kunitconfig=mykunitconfig'])
>                 # Just verify that we parsed and initialized it correctly here.
> -               mock_linux_init.assert_called_once_with('.kunit', kunitconfig_path='mykunitconfig')
> +               mock_linux_init.assert_called_once_with('.kunit',
> +                                                       kunitconfig_path='mykunitconfig',
> +                                                       arch='um',
> +                                                       cross_compile=None,
> +                                                       qemu_config_path=None)
>
>         @mock.patch.object(kunit_kernel, 'LinuxSourceTree')
>         def test_config_kunitconfig(self, mock_linux_init):
>                 mock_linux_init.return_value = self.linux_source_mock
>                 kunit.main(['config', '--kunitconfig=mykunitconfig'])
>                 # Just verify that we parsed and initialized it correctly here.
> -               mock_linux_init.assert_called_once_with('.kunit', kunitconfig_path='mykunitconfig')
> +               mock_linux_init.assert_called_once_with('.kunit',
> +                                                       kunitconfig_path='mykunitconfig',
> +                                                       arch='um',
> +                                                       cross_compile=None,
> +                                                       qemu_config_path=None)
>
>  if __name__ == '__main__':
>         unittest.main()
> diff --git a/tools/testing/kunit/qemu_config.py b/tools/testing/kunit/qemu_config.py
> new file mode 100644
> index 0000000000000..aff1fe0442dbc
> --- /dev/null
> +++ b/tools/testing/kunit/qemu_config.py
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Collection of configs for building non-UML kernels and running them on QEMU.
> +#
> +# Copyright (C) 2021, Google LLC.
> +# Author: Brendan Higgins <brendanhiggins@google.com>
> +
> +from collections import namedtuple
> +
> +
> +QemuArchParams = namedtuple('QemuArchParams', ['linux_arch',
> +                                              'qemuconfig',
> +                                              'qemu_arch',
> +                                              'kernel_path',
> +                                              'kernel_command_line',
> +                                              'extra_qemu_params'])
> +

Nit: newline at end of file.



> diff --git a/tools/testing/kunit/qemu_configs/alpha.py b/tools/testing/kunit/qemu_configs/alpha.py
> new file mode 100644
> index 0000000000000..2cc64f848ca2c
> --- /dev/null
> +++ b/tools/testing/kunit/qemu_configs/alpha.py
> @@ -0,0 +1,10 @@
> +from ..qemu_config import QemuArchParams
> +
> +QEMU_ARCH = QemuArchParams(linux_arch='alpha',
> +                          qemuconfig='''
> +CONFIG_SERIAL_8250=y
> +CONFIG_SERIAL_8250_CONSOLE=y''',
> +                          qemu_arch='alpha',
> +                          kernel_path='arch/alpha/boot/vmlinux',
> +                          kernel_command_line='console=ttyS0',
> +                          extra_qemu_params=[''])
> diff --git a/tools/testing/kunit/qemu_configs/arm.py b/tools/testing/kunit/qemu_configs/arm.py
> new file mode 100644
> index 0000000000000..29a043b0531a0
> --- /dev/null
> +++ b/tools/testing/kunit/qemu_configs/arm.py
> @@ -0,0 +1,13 @@
> +from ..qemu_config import QemuArchParams
> +
> +QEMU_ARCH = QemuArchParams(linux_arch='arm',
> +                          qemuconfig='''
> +CONFIG_ARCH_VIRT=y
> +CONFIG_SERIAL_AMBA_PL010=y
> +CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
> +CONFIG_SERIAL_AMBA_PL011=y
> +CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
> +                          qemu_arch='arm',
> +                          kernel_path='arch/arm/boot/zImage',
> +                          kernel_command_line='console=ttyAMA0',
> +                          extra_qemu_params=['-machine virt'])
> diff --git a/tools/testing/kunit/qemu_configs/arm64.py b/tools/testing/kunit/qemu_configs/arm64.py
> new file mode 100644
> index 0000000000000..1ba200bc99f0f
> --- /dev/null
> +++ b/tools/testing/kunit/qemu_configs/arm64.py
> @@ -0,0 +1,12 @@
> +from ..qemu_config import QemuArchParams
> +
> +QEMU_ARCH = QemuArchParams(linux_arch='arm64',
> +                          qemuconfig='''
> +CONFIG_SERIAL_AMBA_PL010=y
> +CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
> +CONFIG_SERIAL_AMBA_PL011=y
> +CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
> +                          qemu_arch='aarch64',
> +                          kernel_path='arch/arm64/boot/Image.gz',
> +                          kernel_command_line='console=ttyAMA0',
> +                          extra_qemu_params=['-machine virt', '-cpu cortex-a57'])
> diff --git a/tools/testing/kunit/qemu_configs/i386.py b/tools/testing/kunit/qemu_configs/i386.py
> new file mode 100644
> index 0000000000000..3998af306468e
> --- /dev/null
> +++ b/tools/testing/kunit/qemu_configs/i386.py
> @@ -0,0 +1,10 @@
> +from ..qemu_config import QemuArchParams
> +
> +QEMU_ARCH = QemuArchParams(linux_arch='i386',
> +                          qemuconfig='''
> +CONFIG_SERIAL_8250=y
> +CONFIG_SERIAL_8250_CONSOLE=y''',
> +                          qemu_arch='x86_64',
> +                          kernel_path='arch/x86/boot/bzImage',
> +                          kernel_command_line='console=ttyS0',
> +                          extra_qemu_params=[''])
> diff --git a/tools/testing/kunit/qemu_configs/powerpc.py b/tools/testing/kunit/qemu_configs/powerpc.py
> new file mode 100644
> index 0000000000000..46292ce9e368e
> --- /dev/null
> +++ b/tools/testing/kunit/qemu_configs/powerpc.py
> @@ -0,0 +1,12 @@
> +from ..qemu_config import QemuArchParams
> +
> +QEMU_ARCH = QemuArchParams(linux_arch='powerpc',
> +                          qemuconfig='''
> +CONFIG_PPC64=y
> +CONFIG_SERIAL_8250=y
> +CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_HVC_CONSOLE=y''',
> +                          qemu_arch='ppc64',
> +                          kernel_path='vmlinux',
> +                          kernel_command_line='console=ttyS0',
> +                          extra_qemu_params=['-M pseries', '-cpu power8'])
> diff --git a/tools/testing/kunit/qemu_configs/riscv.py b/tools/testing/kunit/qemu_configs/riscv.py
> new file mode 100644
> index 0000000000000..de8c62d465723
> --- /dev/null
> +++ b/tools/testing/kunit/qemu_configs/riscv.py
> @@ -0,0 +1,31 @@
> +from ..qemu_config import QemuArchParams
> +import os
> +import os.path
> +import sys
> +
> +GITHUB_OPENSBI_URL = 'https://github.com/qemu/qemu/raw/master/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin'
> +OPENSBI_FILE = os.path.basename(GITHUB_OPENSBI_URL)
> +
> +if not os.path.isfile(OPENSBI_FILE):
> +       print('\n\nOpenSBI file is not in the current working directory.\n'
> +             'Would you like me to download it for you from:\n' + GITHUB_OPENSBI_URL + ' ?\n')
> +       response = input('yes/[no]: ')
> +       if response.strip() == 'yes':
> +               os.system('wget ' + GITHUB_OPENSBI_URL)
> +       else:
> +               sys.exit()
> +
> +QEMU_ARCH = QemuArchParams(linux_arch='riscv',
> +                          qemuconfig='''
> +CONFIG_SOC_VIRT=y
> +CONFIG_SERIAL_8250=y
> +CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_SERIAL_OF_PLATFORM=y
> +CONFIG_SERIAL_EARLYCON_RISCV_SBI=y''',
> +                          qemu_arch='riscv64',
> +                          kernel_path='arch/riscv/boot/Image',
> +                          kernel_command_line='console=ttyS0',
> +                          extra_qemu_params=[
> +                                          '-machine virt',
> +                                          '-cpu rv64',
> +                                          '-bios opensbi-riscv64-generic-fw_dynamic.bin'])
> diff --git a/tools/testing/kunit/qemu_configs/s390.py b/tools/testing/kunit/qemu_configs/s390.py
> new file mode 100644
> index 0000000000000..04c90332f1098
> --- /dev/null
> +++ b/tools/testing/kunit/qemu_configs/s390.py
> @@ -0,0 +1,14 @@
> +from ..qemu_config import QemuArchParams
> +
> +QEMU_ARCH = QemuArchParams(linux_arch='s390',
> +                          qemuconfig='''
> +CONFIG_EXPERT=y
> +CONFIG_TUNE_ZEC12=y
> +CONFIG_NUMA=y
> +CONFIG_MODULES=y''',
> +                          qemu_arch='s390x',
> +                          kernel_path='arch/s390/boot/bzImage',
> +                          kernel_command_line='console=ttyS0',
> +                          extra_qemu_params=[
> +                                          '-machine s390-ccw-virtio',
> +                                          '-cpu qemu',])
> diff --git a/tools/testing/kunit/qemu_configs/sparc.py b/tools/testing/kunit/qemu_configs/sparc.py
> new file mode 100644
> index 0000000000000..f26b5f27cc5a1
> --- /dev/null
> +++ b/tools/testing/kunit/qemu_configs/sparc.py
> @@ -0,0 +1,10 @@
> +from ..qemu_config import QemuArchParams
> +
> +QEMU_ARCH = QemuArchParams(linux_arch='sparc',
> +                          qemuconfig='''
> +CONFIG_SERIAL_8250=y
> +CONFIG_SERIAL_8250_CONSOLE=y''',
> +                          qemu_arch='sparc',
> +                          kernel_path='arch/sparc/boot/zImage',
> +                          kernel_command_line='console=ttyS0 mem=256M',
> +                          extra_qemu_params=['-m 256'])
> diff --git a/tools/testing/kunit/qemu_configs/x86_64.py b/tools/testing/kunit/qemu_configs/x86_64.py
> new file mode 100644
> index 0000000000000..bd5ab733b92ac
> --- /dev/null
> +++ b/tools/testing/kunit/qemu_configs/x86_64.py
> @@ -0,0 +1,10 @@
> +from ..qemu_config import QemuArchParams
> +
> +QEMU_ARCH = QemuArchParams(linux_arch='x86_64',
> +                          qemuconfig='''
> +CONFIG_SERIAL_8250=y
> +CONFIG_SERIAL_8250_CONSOLE=y''',
> +                          qemu_arch='x86_64',
> +                          kernel_path='arch/x86/boot/bzImage',
> +                          kernel_command_line='console=ttyS0',
> +                          extra_qemu_params=[''])
> --
> 2.31.1.607.g51e8a6a459-goog
>

--000000000000393a6805c259beeb
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnAYJKoZIhvcNAQcCoIIPjTCCD4kCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz2MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
ILbFHw0h01NI0v+AeczGMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwgZoGCCsGAQUF
BwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9nc2F0
bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNv
bS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouseLHIb
0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vY2Ev
Z3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQCNr3LBERPjVctGdVEb
/hN6/N6F2eUWxZLSUbuV7fOle0OvI8xz2AUBrOYQLp94ox9LqmsATKPsBl2uiktsvfs/AXNMcmOz
qsWHzfqp4XlvNgQsC/UyUMWxZoEyTDfTSat09yQjkFJ7viwzrqqscmTx5oTZz8TPRt0mbxwx3qry
wDzYxadSUQXNpNnfi0FBDYUUfuCLFWPsPsAXmgh483u0RbNik9OY/ozNq1Gvg/U0jQOlJf2IiKbE
kUL5Vq8gDDu6bETx5bHmRmSjHhwo7eVbxywczpzdFsU3dauZ3BzqhLy2pRGGzZybSH/3mf7o9y15
gmRHE7WzPLrsULHG/TM8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xv
YmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAyMDIw
AhABm/kO+4pd09krN7Fjk8ypMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB4ZFqT
YJNNBHNoVmPcSFYdpENMDQhcooNRt9NyTsjt2TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yMTA1MTUwNzU5NDJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqG
SIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAmFkRbYxKpN50KvmdLbiFVdI/
WhbAGic38R8F5d9XW0MxUqR924zIOQqrc7q8m0XuOlgt6D+6vMzhfAKH5YqrGvGrn69dRiPGXbbc
/Z3mDxCN68IS1KzFjft77CH1BYHE3gAcJ8guPlZ5i4eAAPZuPdbLn+WsDuh6CzFKyX4+751TT1G3
OetGJ9dqQ4JEZkopfLgOxuqpSzIvETr4sqQrDYf+gz+8SQSLPoPe71JVrsmpuODAcOfJ/l9rmdxk
K8mUwKhJQLHs8xtC33xgZsBww5WrSPio8MmUVbJcxdZ8bg07TStFn/F/3LFfylWUcBh76GrHXVZ6
0xLro8fnITW7Cg==
--000000000000393a6805c259beeb--
