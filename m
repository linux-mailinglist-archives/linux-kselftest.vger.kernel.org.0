Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2470388160
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 May 2021 22:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242055AbhERU3Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 May 2021 16:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241947AbhERU3X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 May 2021 16:29:23 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD19EC06175F
        for <linux-kselftest@vger.kernel.org>; Tue, 18 May 2021 13:28:03 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c17so8282536pfn.6
        for <linux-kselftest@vger.kernel.org>; Tue, 18 May 2021 13:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kGBPmocnJHC9r42BD5cSDGfOp9SQUetbvgKqWGaNlWA=;
        b=ovoiivCYmV1wLmUnZ8sdwbKkqqZtTyGsYrlKjLX+5oLFNBG/ILtTM30usG5jkGEsBZ
         R0clZFPU5XtAX28VD7tqAIUn/JlaaW/NHdrSZF2m81wQw3jm7RioH2rfr8RPpo6Y9IuP
         5I0DE8Q61YWhYZLy6qhdZlafDAXFqWoMWjRMssEPIsvGeMg5jnM0m+DkXpQaxzjcl5He
         4KCJai/RP6wNGin9nUQjvQLLIUlpj5WdyKrt7lSMBQL2+Q7pk3EOiR2arNl6KqLUjB5a
         QYhrg2a0jKGSmuCaNq3sVTxkrQsr4oqo3G8q13fffonwLG5J6zC/dcjwveO7FW8+0i7v
         bBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kGBPmocnJHC9r42BD5cSDGfOp9SQUetbvgKqWGaNlWA=;
        b=galtKXq9oKivI17gXNIJPR925pcSeQPEGdlxxkm4DrWT4fZo1HLNLdByj8saL79BGn
         gLrHM5zjedtfVnvPNQelhVRdJFOQQzNZTfYl+8cgfhi2hvjiXJsCrrqxlC1dp4qtZ0Yf
         zzHHb6quYHPHshqE/P6yySTw83f+GX/dAR/WZVuBLGUyJj2OJ6WzEyAc2rAVJkzCFM0V
         N65dBHXV6Nb2O9kth8myMpCcZVYvvk57uHxhOLnWCW2okHQVhUB+rnHs4se2UN4tzpJ1
         wz8YwUDgdctwo4A7c67Wp57tsD2RmLq9D6Gp0KUw3PQXGuIgvTykV1A8fIlFBvOrUvar
         YGAQ==
X-Gm-Message-State: AOAM532700UvH/WKNwaIVmTz/QWfq2qE4GVxE+QLWrb2ra3ADN3P7CE8
        Mxr3E4Rcp0U9mKisdVg1oF+Rt+RNVswz5JS8Erd9EpvXHvU=
X-Google-Smtp-Source: ABdhPJw0ocf03fMnV9QKxLnYs/7r4eUDyN8fOsKioKe+9iW6fKibhR69jTGttPrtjtP/nYdgCoHxSyS7lI32hcvrkh4=
X-Received: by 2002:a63:4f4a:: with SMTP id p10mr6967449pgl.384.1621369682835;
 Tue, 18 May 2021 13:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210507213110.155492-1-brendanhiggins@google.com>
 <20210507213110.155492-4-brendanhiggins@google.com> <CABVgOSmEe32_kT9TR0-H8biuWGc1Rexne86DgLxths+GUHHgig@mail.gmail.com>
In-Reply-To: <CABVgOSmEe32_kT9TR0-H8biuWGc1Rexne86DgLxths+GUHHgig@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 18 May 2021 13:27:51 -0700
Message-ID: <CAFd5g47s3EbLow6zZpX-vs2KMK+uQyiRjhNtqjQZWXH-ALki8Q@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] kunit: tool: add support for QEMU
To:     David Gow <davidgow@google.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 15, 2021 at 12:59 AM David Gow <davidgow@google.com> wrote:
>
> On Sat, May 8, 2021 at 5:31 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > Add basic support to run QEMU via kunit_tool. Add support for i386,
> > x86_64, arm, arm64, and a bunch more.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Tested-by: David Gow <davidgow@google.com>
> > ---
> >
> > Changes since last revision:
> >
> > - A number of minor obvious issues pointed out by David and Daniel.
> > - Added facility for merging Kconfigs at Daniel's suggestion.
> > - Broke out qemu_configs each into their own config file which is loaded
> >   dynamically - mostly at David's suggestion.
> >
> > ---
>
> This seems pretty good to me. I only have one real complaint --
> qemu_configs needing to be in a subdirectory of ./tools/testing/kunit
> -- but am able to tolerate that (even if I'd prefer not to have it) if
> it's documented properly.
>
> Otherwise, save for a couple of minor nitpicks, this seems good to go.
>
> Reviewed-by: David Gow <davidgow@google.com>
>
>
> >  tools/testing/kunit/kunit.py                |  57 ++++++-
> >  tools/testing/kunit/kunit_config.py         |   7 +-
> >  tools/testing/kunit/kunit_kernel.py         | 170 ++++++++++++++++----
> >  tools/testing/kunit/kunit_tool_test.py      |  18 ++-
> >  tools/testing/kunit/qemu_config.py          |  17 ++
> >  tools/testing/kunit/qemu_configs/alpha.py   |  10 ++
> >  tools/testing/kunit/qemu_configs/arm.py     |  13 ++
> >  tools/testing/kunit/qemu_configs/arm64.py   |  12 ++
> >  tools/testing/kunit/qemu_configs/i386.py    |  10 ++
> >  tools/testing/kunit/qemu_configs/powerpc.py |  12 ++
> >  tools/testing/kunit/qemu_configs/riscv.py   |  31 ++++
> >  tools/testing/kunit/qemu_configs/s390.py    |  14 ++
> >  tools/testing/kunit/qemu_configs/sparc.py   |  10 ++
> >  tools/testing/kunit/qemu_configs/x86_64.py  |  10 ++
> >  14 files changed, 350 insertions(+), 41 deletions(-)
> >  create mode 100644 tools/testing/kunit/qemu_config.py
> >  create mode 100644 tools/testing/kunit/qemu_configs/alpha.py
> >  create mode 100644 tools/testing/kunit/qemu_configs/arm.py
> >  create mode 100644 tools/testing/kunit/qemu_configs/arm64.py
> >  create mode 100644 tools/testing/kunit/qemu_configs/i386.py
> >  create mode 100644 tools/testing/kunit/qemu_configs/powerpc.py
> >  create mode 100644 tools/testing/kunit/qemu_configs/riscv.py
> >  create mode 100644 tools/testing/kunit/qemu_configs/s390.py
> >  create mode 100644 tools/testing/kunit/qemu_configs/sparc.py
> >  create mode 100644 tools/testing/kunit/qemu_configs/x86_64.py
> >
> > diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> > index 5da8fb3762f98..be8d8d4a4e08f 100755
> > --- a/tools/testing/kunit/kunit.py
> > +++ b/tools/testing/kunit/kunit.py
> > @@ -70,10 +70,10 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
> >         kunit_parser.print_with_timestamp('Building KUnit Kernel ...')
> >
> >         build_start = time.time()
> > -       success = linux.build_um_kernel(request.alltests,
> > -                                       request.jobs,
> > -                                       request.build_dir,
> > -                                       request.make_options)
> > +       success = linux.build_kernel(request.alltests,
> > +                                    request.jobs,
> > +                                    request.build_dir,
> > +                                    request.make_options)
> >         build_end = time.time()
> >         if not success:
> >                 return KunitResult(KunitStatus.BUILD_FAILURE,
> > @@ -189,6 +189,31 @@ def add_common_opts(parser) -> None:
> >                              'will get  automatically appended.',
> >                              metavar='kunitconfig')
> >
> > +       parser.add_argument('--arch',
> > +                           help=('Specifies the architecture to run tests under. '
> > +                                 'The architecture specified here must match the '
> > +                                 'string passed to the ARCH make param, '
> > +                                 'e.g. i386, x86_64, arm, um, etc. Non-UML '
> > +                                 'architectures run on QEMU.'),
> > +                           type=str, default='um', metavar='arch')
> > +
> > +       parser.add_argument('--cross_compile',
> > +                           help=('Sets make\'s CROSS_COMPILE variable; it should '
> > +                                 'be set to a toolchain path prefix (the prefix '
> > +                                 'of gcc and other tools in your toolchain, for '
> > +                                 'example `sparc64-linux-gnu-` if you have the '
> > +                                 'sparc toolchain installed on your system, or '
> > +                                 '`$HOME/toolchains/microblaze/gcc-9.2.0-nolibc/microblaze-linux/bin/microblaze-linux-` '
> Super-minor nit: is there a shorter example we can give that's not
> much longer than all the surrounding lines?

I wanted something which actually uses the paths that matches real gcc
toolchains and they don't get much shorter than this (I guess I could
drop $HOME/toolchains/microblaze, but it would still be very long).
Think maybe I should just drop this secondary example entirely? Anyone
trying to download and use a toolchain probably has better resources
to follow anyway.

> > +                                 'if you have downloaded the microblaze toolchain '
> > +                                 'from the 0-day website to a directory in your '
> > +                                 'home directory called `toolchains`).'),
> > +                           metavar='cross_compile')
> > +
> > +       parser.add_argument('--qemu_config',
> > +                           help=('Takes a path to a path to a file containing '
> > +                                 'a QemuArchParams object.'),
> > +                           type=str, metavar='qemu_config')
> > +
>
> If (as noted below) this file needs to be in a subdirectory of the
> kunit_tool directory, we should document this, or maybe make this path
> relative to the kunit_tool directory.

I'll go into more detail below, but I was able to change this to take
a config from anywhere.

> >  def add_build_opts(parser) -> None:
> >         parser.add_argument('--jobs',
> >                             help='As in the make command, "Specifies  the number of '
> > @@ -270,7 +295,11 @@ def main(argv, linux=None):
> >                         os.mkdir(cli_args.build_dir)
> >
> >                 if not linux:
> > -                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir, kunitconfig_path=cli_args.kunitconfig)
> > +                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> > +                                       kunitconfig_path=cli_args.kunitconfig,
> > +                                       arch=cli_args.arch,
> > +                                       cross_compile=cli_args.cross_compile,
> > +                                       qemu_config_path=cli_args.qemu_config)
> >
> >                 request = KunitRequest(cli_args.raw_output,
> >                                        cli_args.timeout,
> > @@ -289,7 +318,11 @@ def main(argv, linux=None):
> >                         os.mkdir(cli_args.build_dir)
> >
> >                 if not linux:
> > -                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir, kunitconfig_path=cli_args.kunitconfig)
> > +                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> > +                                       kunitconfig_path=cli_args.kunitconfig,
> > +                                       arch=cli_args.arch,
> > +                                       cross_compile=cli_args.cross_compile,
> > +                                       qemu_config_path=cli_args.qemu_config)
> >
> >                 request = KunitConfigRequest(cli_args.build_dir,
> >                                              cli_args.make_options)
> > @@ -301,7 +334,11 @@ def main(argv, linux=None):
> >                         sys.exit(1)
> >         elif cli_args.subcommand == 'build':
> >                 if not linux:
> > -                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir, kunitconfig_path=cli_args.kunitconfig)
> > +                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> > +                                       kunitconfig_path=cli_args.kunitconfig,
> > +                                       arch=cli_args.arch,
> > +                                       cross_compile=cli_args.cross_compile,
> > +                                       qemu_config_path=cli_args.qemu_config)
> >
> >                 request = KunitBuildRequest(cli_args.jobs,
> >                                             cli_args.build_dir,
> > @@ -315,7 +352,11 @@ def main(argv, linux=None):
> >                         sys.exit(1)
> >         elif cli_args.subcommand == 'exec':
> >                 if not linux:
> > -                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
> > +                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> > +                                       kunitconfig_path=cli_args.kunitconfig,
> > +                                       arch=cli_args.arch,
> > +                                       cross_compile=cli_args.cross_compile,
> > +                                       qemu_config_path=cli_args.qemu_config)
> >
> >                 exec_request = KunitExecRequest(cli_args.timeout,
> >                                                 cli_args.build_dir,
> > diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
> > index 1e2683dcc0e7a..c77c7d2ef6220 100644
> > --- a/tools/testing/kunit/kunit_config.py
> > +++ b/tools/testing/kunit/kunit_config.py
> > @@ -52,8 +52,13 @@ class Kconfig(object):
> >                                 return False
> >                 return True
> >
> > +       def merge_in_entries(self, other: 'Kconfig') -> None:
> > +               if other.is_subset_of(self):
> > +                       return
> > +               self._entries = list(self.entries().union(other.entries()))
> > +
> >         def write_to_file(self, path: str) -> None:
> > -               with open(path, 'w') as f:
> > +               with open(path, 'a+') as f:
> >                         for entry in self.entries():
> >                                 f.write(str(entry) + '\n')
> >
> > diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> > index e22ade9d91ad5..2bd196fd69e5c 100644
> > --- a/tools/testing/kunit/kunit_kernel.py
> > +++ b/tools/testing/kunit/kunit_kernel.py
> > @@ -6,23 +6,31 @@
> >  # Author: Felix Guo <felixguoxiuping@gmail.com>
> >  # Author: Brendan Higgins <brendanhiggins@google.com>
> >
> > +from __future__ import annotations
> > +import importlib.util
> >  import logging
> >  import subprocess
> >  import os
> >  import shutil
> >  import signal
> >  from typing import Iterator
> > +from typing import Optional
> >
> >  from contextlib import ExitStack
> >
> > +from collections import namedtuple
> > +
> >  import kunit_config
> >  import kunit_parser
> > +import qemu_config
> >
> >  KCONFIG_PATH = '.config'
> >  KUNITCONFIG_PATH = '.kunitconfig'
> >  DEFAULT_KUNITCONFIG_PATH = 'arch/um/configs/kunit_defconfig'
> >  BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
> >  OUTFILE_PATH = 'test.log'
> > +ABS_TOOL_PATH = os.path.abspath(os.path.dirname(__file__))
> > +QEMU_CONFIGS_DIR = os.path.join(ABS_TOOL_PATH, 'qemu_configs')
> >
> >  def get_file_path(build_dir, default):
> >         if build_dir:
> > @@ -40,6 +48,10 @@ class BuildError(Exception):
> >  class LinuxSourceTreeOperations(object):
> >         """An abstraction over command line operations performed on a source tree."""
> >
> > +       def __init__(self, linux_arch: str, cross_compile: Optional[str]):
> > +               self._linux_arch = linux_arch
> > +               self._cross_compile = cross_compile
> > +
> >         def make_mrproper(self) -> None:
> >                 try:
> >                         subprocess.check_output(['make', 'mrproper'], stderr=subprocess.STDOUT)
> > @@ -48,12 +60,21 @@ class LinuxSourceTreeOperations(object):
> >                 except subprocess.CalledProcessError as e:
> >                         raise ConfigError(e.output.decode())
> >
> > +       def make_arch_qemuconfig(self, kconfig: kunit_config.Kconfig) -> None:
> > +               pass
> > +
> > +       def make_allyesconfig(self, build_dir, make_options) -> None:
> > +               raise ConfigError('Only the "um" arch is supported for alltests')
> > +
> >         def make_olddefconfig(self, build_dir, make_options) -> None:
> > -               command = ['make', 'ARCH=um', 'olddefconfig']
> > +               command = ['make', 'ARCH=' + self._linux_arch, 'olddefconfig']
> > +               if self._cross_compile:
> > +                       command += ['CROSS_COMPILE=' + self._cross_compile]
> >                 if make_options:
> >                         command.extend(make_options)
> >                 if build_dir:
> >                         command += ['O=' + build_dir]
> > +               print('Populating config with:\n$', ' '.join(command))
> >                 try:
> >                         subprocess.check_output(command, stderr=subprocess.STDOUT)
> >                 except OSError as e:
> > @@ -61,6 +82,79 @@ class LinuxSourceTreeOperations(object):
> >                 except subprocess.CalledProcessError as e:
> >                         raise ConfigError(e.output.decode())
> >
> > +       def make(self, jobs, build_dir, make_options) -> None:
> > +               command = ['make', 'ARCH=' + self._linux_arch, '--jobs=' + str(jobs)]
> > +               if make_options:
> > +                       command.extend(make_options)
> > +               if self._cross_compile:
> > +                       command += ['CROSS_COMPILE=' + self._cross_compile]
> > +               if build_dir:
> > +                       command += ['O=' + build_dir]
> > +               print('Building with:\n$', ' '.join(command))
> > +               try:
> > +                       proc = subprocess.Popen(command,
> > +                                               stderr=subprocess.PIPE,
> > +                                               stdout=subprocess.DEVNULL)
> > +               except OSError as e:
> > +                       raise BuildError('Could not call execute make: ' + str(e))
> > +               except subprocess.CalledProcessError as e:
> > +                       raise BuildError(e.output)
> > +               _, stderr = proc.communicate()
> > +               if proc.returncode != 0:
> > +                       raise BuildError(stderr.decode())
> > +               if stderr:  # likely only due to build warnings
> > +                       print(stderr.decode())
> > +
> > +       def run(self, params, timeout, build_dir, outfile) -> None:
> > +               pass
> > +
> > +
> > +class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
> > +
> > +       def __init__(self, qemu_arch_params: qemu_config.QemuArchParams, cross_compile: Optional[str]):
> > +               super().__init__(linux_arch=qemu_arch_params.linux_arch,
> > +                                cross_compile=cross_compile)
> > +               self._qemuconfig = qemu_arch_params.qemuconfig
> > +               self._qemu_arch = qemu_arch_params.qemu_arch
> > +               self._kernel_path = qemu_arch_params.kernel_path
> > +               self._kernel_command_line = qemu_arch_params.kernel_command_line + ' kunit_shutdown=reboot'
> > +               self._extra_qemu_params = qemu_arch_params.extra_qemu_params
> > +
> > +       def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> None:
> > +               qemuconfig = kunit_config.Kconfig()
> > +               qemuconfig.parse_from_string(self._qemuconfig)
> > +               base_kunitconfig.merge_in_entries(qemuconfig)
> > +
> > +       def run(self, params, timeout, build_dir, outfile):
> > +               kernel_path = os.path.join(build_dir, self._kernel_path)
> > +               qemu_command = ['qemu-system-' + self._qemu_arch,
> > +                               '-nodefaults',
> > +                               '-m', '1024',
> > +                               '-kernel', kernel_path,
> > +                               '-append', '\'' + ' '.join(params + [self._kernel_command_line]) + '\'',
> > +                               '-no-reboot',
> > +                               '-nographic',
> > +                               '-serial stdio'] + self._extra_qemu_params
> > +               print('Running tests with:\n$', ' '.join(qemu_command))
> > +               with open(outfile, 'w') as output:
> > +                       process = subprocess.Popen(' '.join(qemu_command),
> > +                                                  stdin=subprocess.PIPE,
> > +                                                  stdout=output,
> > +                                                  stderr=subprocess.STDOUT,
> > +                                                  text=True, shell=True)
> > +               try:
> > +                       process.wait(timeout=timeout)
> > +               except Exception as e:
> > +                       print(e)
> > +                       process.terminate()
> > +               return process
> > +
> > +class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
> > +       """An abstraction over command line operations performed on a source tree."""
> > +
> > +       def __init__(self, cross_compile=None):
> > +               super().__init__(linux_arch='um', cross_compile=cross_compile)
> > +
> >         def make_allyesconfig(self, build_dir, make_options) -> None:
> >                 kunit_parser.print_with_timestamp(
> >                         'Enabling all CONFIGs for UML...')
> > @@ -83,32 +177,16 @@ class LinuxSourceTreeOperations(object):
> >                 kunit_parser.print_with_timestamp(
> >                         'Starting Kernel with all configs takes a few minutes...')
> >
> > -       def make(self, jobs, build_dir, make_options) -> None:
> > -               command = ['make', 'ARCH=um', '--jobs=' + str(jobs)]
> > -               if make_options:
> > -                       command.extend(make_options)
> > -               if build_dir:
> > -                       command += ['O=' + build_dir]
> > -               try:
> > -                       proc = subprocess.Popen(command,
> > -                                               stderr=subprocess.PIPE,
> > -                                               stdout=subprocess.DEVNULL)
> > -               except OSError as e:
> > -                       raise BuildError('Could not call make command: ' + str(e))
> > -               _, stderr = proc.communicate()
> > -               if proc.returncode != 0:
> > -                       raise BuildError(stderr.decode())
> > -               if stderr:  # likely only due to build warnings
> > -                       print(stderr.decode())
> > -
> > -       def linux_bin(self, params, timeout, build_dir) -> None:
> > +       def run(self, params, timeout, build_dir, outfile):
> >                 """Runs the Linux UML binary. Must be named 'linux'."""
> >                 linux_bin = get_file_path(build_dir, 'linux')
> >                 outfile = get_outfile_path(build_dir)
> >                 with open(outfile, 'w') as output:
> >                         process = subprocess.Popen([linux_bin] + params,
> > +                                                  stdin=subprocess.PIPE,
> >                                                    stdout=output,
> > -                                                  stderr=subprocess.STDOUT)
> > +                                                  stderr=subprocess.STDOUT,
> > +                                                  text=True)
> >                         process.wait(timeout)
> >
> >  def get_kconfig_path(build_dir) -> str:
> > @@ -120,13 +198,49 @@ def get_kunitconfig_path(build_dir) -> str:
> >  def get_outfile_path(build_dir) -> str:
> >         return get_file_path(build_dir, OUTFILE_PATH)
> >
> > +def get_source_tree_ops(arch: str, cross_compile: Optional[str]) -> LinuxSourceTreeOperations:
> > +       config_path = os.path.join(QEMU_CONFIGS_DIR, arch + '.py')
> > +       if arch == 'um':
> > +               return LinuxSourceTreeOperationsUml(cross_compile=cross_compile)
> > +       elif os.path.isfile(config_path):
> > +               return get_source_tree_ops_from_qemu_config(config_path, cross_compile)[1]
> > +       else:
> > +               raise ConfigError(arch + ' is not a valid arch')
> > +
> > +def get_source_tree_ops_from_qemu_config(config_path: str,
> > +                                        cross_compile: Optional[str]) -> tuple[
> > +                                                        str, LinuxSourceTreeOperations]:
> > +       abs_config_path = os.path.abspath(config_path)
> > +       if os.path.commonpath([ABS_TOOL_PATH, abs_config_path]) != ABS_TOOL_PATH:
> > +               raise ConfigError('Given QEMU config file is not in a child directory of KUnit tool.')
>
> I really don't like this requirement: it feels very arbitrary and
> undercuts the value of the --qemu_config option a bit: we almost might
> as well keep everything in the QEMU_CONFIG_DIR.
>
> I assume it's here because of the need to import the QemuArchParams
> definition: I take it there's no convenient way to do that?

I thought it was a requirement, but I was wrong. I was able to fix it.
In the next revision, no such requirement will exist.

> At the very least, let's document this restriction properly, as it was
> a bit of a weird one I wasn't expecting. Then people can either put
> their custom qemu configs in the qemu_configs/ directory, or in
> something like a custom_qemu_configs/ one. And if we later can work
> out a more convenient way of removing this restriction entirely, we
> can do so.

No worries, we won't have to have the configs live in any particular
location in future revisions.

> > +       relative_config_path = os.path.relpath(abs_config_path, ABS_TOOL_PATH)
> > +       spec = importlib.util.spec_from_file_location('.' + relative_config_path, config_path)
> > +       config = importlib.util.module_from_spec(spec)
> > +       # TODO(brendanhiggins@google.com): I looked this up and apparently other
> > +       # Python projects have noted that pytype complains that "No attribute
> > +       # 'exec_module' on _importlib_modulespec._Loader". Disabling for now.
> > +       spec.loader.exec_module(config) # pytype: disable=attribute-error
> > +       return config.QEMU_ARCH.linux_arch, LinuxSourceTreeOperationsQemu(
> > +                       config.QEMU_ARCH, cross_compile=cross_compile)
> > +
> >  class LinuxSourceTree(object):
> >         """Represents a Linux kernel source tree with KUnit tests."""
> >
> > -       def __init__(self, build_dir: str, load_config=True, kunitconfig_path='') -> None:
> > +       def __init__(
> > +             self,
> > +             build_dir: str,
> > +             load_config=True,
> > +             kunitconfig_path='',
> > +             arch=None,
> > +             cross_compile=None,
> > +             qemu_config_path=None) -> None:
> >                 signal.signal(signal.SIGINT, self.signal_handler)
> > -
> > -               self._ops = LinuxSourceTreeOperations()
> > +               if qemu_config_path:
> > +                       self._arch, self._ops = get_source_tree_ops_from_qemu_config(
> > +                                       qemu_config_path, cross_compile)
> > +               else:
> > +                       self._arch = 'um' if arch is None else arch
> > +                       self._ops = get_source_tree_ops(self._arch, cross_compile)
> >
> >                 if not load_config:
> >                         return
> > @@ -170,8 +284,9 @@ class LinuxSourceTree(object):
> >                 kconfig_path = get_kconfig_path(build_dir)
> >                 if build_dir and not os.path.exists(build_dir):
> >                         os.mkdir(build_dir)
> > -               self._kconfig.write_to_file(kconfig_path)
> >                 try:
> > +                       self._ops.make_arch_qemuconfig(self._kconfig)
> > +                       self._kconfig.write_to_file(kconfig_path)
> >                         self._ops.make_olddefconfig(build_dir, make_options)
> >                 except ConfigError as e:
> >                         logging.error(e)
> > @@ -184,6 +299,7 @@ class LinuxSourceTree(object):
> >                 if os.path.exists(kconfig_path):
> >                         existing_kconfig = kunit_config.Kconfig()
> >                         existing_kconfig.read_from_file(kconfig_path)
> > +                       self._ops.make_arch_qemuconfig(self._kconfig)
> >                         if not self._kconfig.is_subset_of(existing_kconfig):
> >                                 print('Regenerating .config ...')
> >                                 os.remove(kconfig_path)
> > @@ -194,7 +310,7 @@ class LinuxSourceTree(object):
> >                         print('Generating .config ...')
> >                         return self.build_config(build_dir, make_options)
> >
> > -       def build_um_kernel(self, alltests, jobs, build_dir, make_options) -> bool:
> > +       def build_kernel(self, alltests, jobs, build_dir, make_options) -> bool:
> >                 try:
> >                         if alltests:
> >                                 self._ops.make_allyesconfig(build_dir, make_options)
> > @@ -211,8 +327,8 @@ class LinuxSourceTree(object):
> >                 args.extend(['mem=1G', 'console=tty','kunit_shutdown=halt'])
> >                 if filter_glob:
> >                         args.append('kunit.filter_glob='+filter_glob)
> > -               self._ops.linux_bin(args, timeout, build_dir)
> >                 outfile = get_outfile_path(build_dir)
> > +               self._ops.run(args, timeout, build_dir, outfile)
> >                 subprocess.call(['stty', 'sane'])
> >                 with open(outfile, 'r') as file:
> >                         for line in file:
> > diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> > index 2e809dd956a77..a3b7f68e1cf9f 100755
> > --- a/tools/testing/kunit/kunit_tool_test.py
> > +++ b/tools/testing/kunit/kunit_tool_test.py
> > @@ -303,7 +303,7 @@ class KUnitMainTest(unittest.TestCase):
> >
> >                 self.linux_source_mock = mock.Mock()
> >                 self.linux_source_mock.build_reconfig = mock.Mock(return_value=True)
> > -               self.linux_source_mock.build_um_kernel = mock.Mock(return_value=True)
> > +               self.linux_source_mock.build_kernel = mock.Mock(return_value=True)
> >                 self.linux_source_mock.run_kernel = mock.Mock(return_value=all_passed_log)
> >
> >         def test_config_passes_args_pass(self):
> > @@ -314,7 +314,7 @@ class KUnitMainTest(unittest.TestCase):
> >         def test_build_passes_args_pass(self):
> >                 kunit.main(['build'], self.linux_source_mock)
> >                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 0)
> > -               self.linux_source_mock.build_um_kernel.assert_called_once_with(False, 8, '.kunit', None)
> > +               self.linux_source_mock.build_kernel.assert_called_once_with(False, 8, '.kunit', None)
> >                 self.assertEqual(self.linux_source_mock.run_kernel.call_count, 0)
> >
> >         def test_exec_passes_args_pass(self):
> > @@ -396,7 +396,7 @@ class KUnitMainTest(unittest.TestCase):
> >         def test_build_builddir(self):
> >                 build_dir = '.kunit'
> >                 kunit.main(['build', '--build_dir', build_dir], self.linux_source_mock)
> > -               self.linux_source_mock.build_um_kernel.assert_called_once_with(False, 8, build_dir, None)
> > +               self.linux_source_mock.build_kernel.assert_called_once_with(False, 8, build_dir, None)
> >
> >         def test_exec_builddir(self):
> >                 build_dir = '.kunit'
> > @@ -410,14 +410,22 @@ class KUnitMainTest(unittest.TestCase):
> >                 mock_linux_init.return_value = self.linux_source_mock
> >                 kunit.main(['run', '--kunitconfig=mykunitconfig'])
> >                 # Just verify that we parsed and initialized it correctly here.
> > -               mock_linux_init.assert_called_once_with('.kunit', kunitconfig_path='mykunitconfig')
> > +               mock_linux_init.assert_called_once_with('.kunit',
> > +                                                       kunitconfig_path='mykunitconfig',
> > +                                                       arch='um',
> > +                                                       cross_compile=None,
> > +                                                       qemu_config_path=None)
> >
> >         @mock.patch.object(kunit_kernel, 'LinuxSourceTree')
> >         def test_config_kunitconfig(self, mock_linux_init):
> >                 mock_linux_init.return_value = self.linux_source_mock
> >                 kunit.main(['config', '--kunitconfig=mykunitconfig'])
> >                 # Just verify that we parsed and initialized it correctly here.
> > -               mock_linux_init.assert_called_once_with('.kunit', kunitconfig_path='mykunitconfig')
> > +               mock_linux_init.assert_called_once_with('.kunit',
> > +                                                       kunitconfig_path='mykunitconfig',
> > +                                                       arch='um',
> > +                                                       cross_compile=None,
> > +                                                       qemu_config_path=None)
> >
> >  if __name__ == '__main__':
> >         unittest.main()
> > diff --git a/tools/testing/kunit/qemu_config.py b/tools/testing/kunit/qemu_config.py
> > new file mode 100644
> > index 0000000000000..aff1fe0442dbc
> > --- /dev/null
> > +++ b/tools/testing/kunit/qemu_config.py
> > @@ -0,0 +1,17 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Collection of configs for building non-UML kernels and running them on QEMU.
> > +#
> > +# Copyright (C) 2021, Google LLC.
> > +# Author: Brendan Higgins <brendanhiggins@google.com>
> > +
> > +from collections import namedtuple
> > +
> > +
> > +QemuArchParams = namedtuple('QemuArchParams', ['linux_arch',
> > +                                              'qemuconfig',
> > +                                              'qemu_arch',
> > +                                              'kernel_path',
> > +                                              'kernel_command_line',
> > +                                              'extra_qemu_params'])
> > +
>
> Nit: newline at end of file.

Thanks, will fix.

> > diff --git a/tools/testing/kunit/qemu_configs/alpha.py b/tools/testing/kunit/qemu_configs/alpha.py
> > new file mode 100644
> > index 0000000000000..2cc64f848ca2c
> > --- /dev/null
> > +++ b/tools/testing/kunit/qemu_configs/alpha.py
> > @@ -0,0 +1,10 @@
> > +from ..qemu_config import QemuArchParams
> > +
> > +QEMU_ARCH = QemuArchParams(linux_arch='alpha',
> > +                          qemuconfig='''
> > +CONFIG_SERIAL_8250=y
> > +CONFIG_SERIAL_8250_CONSOLE=y''',
> > +                          qemu_arch='alpha',
> > +                          kernel_path='arch/alpha/boot/vmlinux',
> > +                          kernel_command_line='console=ttyS0',
> > +                          extra_qemu_params=[''])
> > diff --git a/tools/testing/kunit/qemu_configs/arm.py b/tools/testing/kunit/qemu_configs/arm.py
> > new file mode 100644
> > index 0000000000000..29a043b0531a0
> > --- /dev/null
> > +++ b/tools/testing/kunit/qemu_configs/arm.py
> > @@ -0,0 +1,13 @@
> > +from ..qemu_config import QemuArchParams
> > +
> > +QEMU_ARCH = QemuArchParams(linux_arch='arm',
> > +                          qemuconfig='''
> > +CONFIG_ARCH_VIRT=y
> > +CONFIG_SERIAL_AMBA_PL010=y
> > +CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
> > +CONFIG_SERIAL_AMBA_PL011=y
> > +CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
> > +                          qemu_arch='arm',
> > +                          kernel_path='arch/arm/boot/zImage',
> > +                          kernel_command_line='console=ttyAMA0',
> > +                          extra_qemu_params=['-machine virt'])
> > diff --git a/tools/testing/kunit/qemu_configs/arm64.py b/tools/testing/kunit/qemu_configs/arm64.py
> > new file mode 100644
> > index 0000000000000..1ba200bc99f0f
> > --- /dev/null
> > +++ b/tools/testing/kunit/qemu_configs/arm64.py
> > @@ -0,0 +1,12 @@
> > +from ..qemu_config import QemuArchParams
> > +
> > +QEMU_ARCH = QemuArchParams(linux_arch='arm64',
> > +                          qemuconfig='''
> > +CONFIG_SERIAL_AMBA_PL010=y
> > +CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
> > +CONFIG_SERIAL_AMBA_PL011=y
> > +CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
> > +                          qemu_arch='aarch64',
> > +                          kernel_path='arch/arm64/boot/Image.gz',
> > +                          kernel_command_line='console=ttyAMA0',
> > +                          extra_qemu_params=['-machine virt', '-cpu cortex-a57'])
> > diff --git a/tools/testing/kunit/qemu_configs/i386.py b/tools/testing/kunit/qemu_configs/i386.py
> > new file mode 100644
> > index 0000000000000..3998af306468e
> > --- /dev/null
> > +++ b/tools/testing/kunit/qemu_configs/i386.py
> > @@ -0,0 +1,10 @@
> > +from ..qemu_config import QemuArchParams
> > +
> > +QEMU_ARCH = QemuArchParams(linux_arch='i386',
> > +                          qemuconfig='''
> > +CONFIG_SERIAL_8250=y
> > +CONFIG_SERIAL_8250_CONSOLE=y''',
> > +                          qemu_arch='x86_64',
> > +                          kernel_path='arch/x86/boot/bzImage',
> > +                          kernel_command_line='console=ttyS0',
> > +                          extra_qemu_params=[''])
> > diff --git a/tools/testing/kunit/qemu_configs/powerpc.py b/tools/testing/kunit/qemu_configs/powerpc.py
> > new file mode 100644
> > index 0000000000000..46292ce9e368e
> > --- /dev/null
> > +++ b/tools/testing/kunit/qemu_configs/powerpc.py
> > @@ -0,0 +1,12 @@
> > +from ..qemu_config import QemuArchParams
> > +
> > +QEMU_ARCH = QemuArchParams(linux_arch='powerpc',
> > +                          qemuconfig='''
> > +CONFIG_PPC64=y
> > +CONFIG_SERIAL_8250=y
> > +CONFIG_SERIAL_8250_CONSOLE=y
> > +CONFIG_HVC_CONSOLE=y''',
> > +                          qemu_arch='ppc64',
> > +                          kernel_path='vmlinux',
> > +                          kernel_command_line='console=ttyS0',
> > +                          extra_qemu_params=['-M pseries', '-cpu power8'])
> > diff --git a/tools/testing/kunit/qemu_configs/riscv.py b/tools/testing/kunit/qemu_configs/riscv.py
> > new file mode 100644
> > index 0000000000000..de8c62d465723
> > --- /dev/null
> > +++ b/tools/testing/kunit/qemu_configs/riscv.py
> > @@ -0,0 +1,31 @@
> > +from ..qemu_config import QemuArchParams
> > +import os
> > +import os.path
> > +import sys
> > +
> > +GITHUB_OPENSBI_URL = 'https://github.com/qemu/qemu/raw/master/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin'
> > +OPENSBI_FILE = os.path.basename(GITHUB_OPENSBI_URL)
> > +
> > +if not os.path.isfile(OPENSBI_FILE):
> > +       print('\n\nOpenSBI file is not in the current working directory.\n'
> > +             'Would you like me to download it for you from:\n' + GITHUB_OPENSBI_URL + ' ?\n')
> > +       response = input('yes/[no]: ')
> > +       if response.strip() == 'yes':
> > +               os.system('wget ' + GITHUB_OPENSBI_URL)
> > +       else:
> > +               sys.exit()
> > +
> > +QEMU_ARCH = QemuArchParams(linux_arch='riscv',
> > +                          qemuconfig='''
> > +CONFIG_SOC_VIRT=y
> > +CONFIG_SERIAL_8250=y
> > +CONFIG_SERIAL_8250_CONSOLE=y
> > +CONFIG_SERIAL_OF_PLATFORM=y
> > +CONFIG_SERIAL_EARLYCON_RISCV_SBI=y''',
> > +                          qemu_arch='riscv64',
> > +                          kernel_path='arch/riscv/boot/Image',
> > +                          kernel_command_line='console=ttyS0',
> > +                          extra_qemu_params=[
> > +                                          '-machine virt',
> > +                                          '-cpu rv64',
> > +                                          '-bios opensbi-riscv64-generic-fw_dynamic.bin'])
> > diff --git a/tools/testing/kunit/qemu_configs/s390.py b/tools/testing/kunit/qemu_configs/s390.py
> > new file mode 100644
> > index 0000000000000..04c90332f1098
> > --- /dev/null
> > +++ b/tools/testing/kunit/qemu_configs/s390.py
> > @@ -0,0 +1,14 @@
> > +from ..qemu_config import QemuArchParams
> > +
> > +QEMU_ARCH = QemuArchParams(linux_arch='s390',
> > +                          qemuconfig='''
> > +CONFIG_EXPERT=y
> > +CONFIG_TUNE_ZEC12=y
> > +CONFIG_NUMA=y
> > +CONFIG_MODULES=y''',
> > +                          qemu_arch='s390x',
> > +                          kernel_path='arch/s390/boot/bzImage',
> > +                          kernel_command_line='console=ttyS0',
> > +                          extra_qemu_params=[
> > +                                          '-machine s390-ccw-virtio',
> > +                                          '-cpu qemu',])
> > diff --git a/tools/testing/kunit/qemu_configs/sparc.py b/tools/testing/kunit/qemu_configs/sparc.py
> > new file mode 100644
> > index 0000000000000..f26b5f27cc5a1
> > --- /dev/null
> > +++ b/tools/testing/kunit/qemu_configs/sparc.py
> > @@ -0,0 +1,10 @@
> > +from ..qemu_config import QemuArchParams
> > +
> > +QEMU_ARCH = QemuArchParams(linux_arch='sparc',
> > +                          qemuconfig='''
> > +CONFIG_SERIAL_8250=y
> > +CONFIG_SERIAL_8250_CONSOLE=y''',
> > +                          qemu_arch='sparc',
> > +                          kernel_path='arch/sparc/boot/zImage',
> > +                          kernel_command_line='console=ttyS0 mem=256M',
> > +                          extra_qemu_params=['-m 256'])
> > diff --git a/tools/testing/kunit/qemu_configs/x86_64.py b/tools/testing/kunit/qemu_configs/x86_64.py
> > new file mode 100644
> > index 0000000000000..bd5ab733b92ac
> > --- /dev/null
> > +++ b/tools/testing/kunit/qemu_configs/x86_64.py
> > @@ -0,0 +1,10 @@
> > +from ..qemu_config import QemuArchParams
> > +
> > +QEMU_ARCH = QemuArchParams(linux_arch='x86_64',
> > +                          qemuconfig='''
> > +CONFIG_SERIAL_8250=y
> > +CONFIG_SERIAL_8250_CONSOLE=y''',
> > +                          qemu_arch='x86_64',
> > +                          kernel_path='arch/x86/boot/bzImage',
> > +                          kernel_command_line='console=ttyS0',
> > +                          extra_qemu_params=[''])
> > --
> > 2.31.1.607.g51e8a6a459-goog
> >
