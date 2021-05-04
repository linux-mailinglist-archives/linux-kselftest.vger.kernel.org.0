Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508223725AD
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 May 2021 08:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhEDGJu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 May 2021 02:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhEDGJu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 May 2021 02:09:50 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C2CC061574
        for <linux-kselftest@vger.kernel.org>; Mon,  3 May 2021 23:08:55 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t11so10145208lfl.11
        for <linux-kselftest@vger.kernel.org>; Mon, 03 May 2021 23:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=smrtQV0eGOd9JGw9ZOSg3aICKiYwtkeGAJlfhVahilM=;
        b=vdrafqS9vjgyhM+XOOZP0XOadi/peJgrbaVxsFgx8cd3JT8CW/t5wC+F4lzRnmXzQW
         /PFl7L4MqR9GA6qyaHlTUSeAMGH3SyU0BeXHHg7OQTMrrhFtT+DpWaX9YBT+WmYFOkJF
         6BrREplvtRdXAL7johItASWWvHBlWS48W3BQAetZhpa8b0j51AEW94G9hjjxXBmc6l8d
         zxDHzSa3f3xXcZLb2WfCj5Bmz1sNqJ2AgjzIMZpv8SvHTSiuHVd7dO+nqiFsi0AD/oyy
         7Ns347QT5PD4SjtI8ncHLVDehsznN8dSs1fGmqRSmWAY/O5Li/G0MqKO2TTcvBJaqepP
         JnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=smrtQV0eGOd9JGw9ZOSg3aICKiYwtkeGAJlfhVahilM=;
        b=P1qwi3KhyVizwWyXUthMrCtpO88YKp6FhUgUfUkgOt7psT3ljH8Ok1UiOi1hlBJfYr
         /nfOGS/n9WctqhFPqm0g0p4tO74jqq+ma9RxpD9kcbBgw5xPf1o04G6Ozqb4BquG0jj7
         jslwObddyGg2COuJPZdNs/J5NVYnCbkWGHdQuO8feoSv0kKIbtOJTIw2lAscuGlco9HK
         7QQ7IrQKBHGb2C+n0nI5hPkPQpILGRONheU9NdqZbWyiILG3Llm4HmDoVANb3fkB+UCb
         AeQYjInbrJJHIGxwCW8KVwdHuWPlYCZ1gryeM3L0n+Iaz9tER4xX78+q1W1q1W1Lxusu
         tVLw==
X-Gm-Message-State: AOAM530Bg9z32UdrPRohFRYhr8sMhVsllun75B8EXPZ7Nb30scSTLirx
        iZgaTzImAQagZt3S6fy2vFuMruVBzrdMDxJCCJgWWw==
X-Google-Smtp-Source: ABdhPJyqHO3VjYp0AaAmQnSzWjkvrbuDCupAMUvddb8b1UluCkeiJ+J81qKrvfQqV166FMp9XdKveBO8My0iBjGrrqs=
X-Received: by 2002:a05:6512:b0f:: with SMTP id w15mr16271438lfu.333.1620108533242;
 Mon, 03 May 2021 23:08:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210429205109.2847831-1-brendanhiggins@google.com> <20210429205109.2847831-4-brendanhiggins@google.com>
In-Reply-To: <20210429205109.2847831-4-brendanhiggins@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 4 May 2021 14:08:41 +0800
Message-ID: <CABVgOSnrSD64aTRsBqTTB4A26whcxegT0_DK3MjThsHnWeFdqA@mail.gmail.com>
Subject: Re: [RFC v2 3/4] kunit: tool: add support for QEMU
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 30, 2021 at 4:51 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Add basic support to run QEMU via kunit_tool. Add support for i386,
> x86_64, arm, arm64, and a bunch more.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

I've tested this out on a few architectures (x86-32, ppc64, etc), and
it all seems to work pretty well. I've got quite a few comments below.
The main one -- the location of the qemu configs -- is basically
echoing what Daniel said and what you've done on the Gerrit version,
but I felt was worth having on the record.

Otherwise, a bunch of nitpicks around missing places cross_compile
should be supported.

Still, great to see this happening: it's nice to be able to test on
non-UML architectures more easily.

Tested-by: David Gow <davidgow@google.com>

-- David

> ---
>  tools/testing/kunit/kunit.py           |  33 +++-
>  tools/testing/kunit/kunit_config.py    |   2 +-
>  tools/testing/kunit/kunit_kernel.py    | 207 +++++++++++++++++++++----
>  tools/testing/kunit/kunit_tool_test.py |  15 +-
>  4 files changed, 217 insertions(+), 40 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index d5144fcb03acd..07ef80062873b 100755
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
> @@ -187,6 +187,14 @@ def add_common_opts(parser) -> None:
>                              help='Path to Kconfig fragment that enables KUnit tests',
>                              metavar='kunitconfig')
>
> +       parser.add_argument('--arch',
> +                           help='Specifies the architecture to run tests under.',
> +                           type=str, default='um', metavar='arch')

It'd be nice to note explicitly that non-'um' values here will run under qemu.

> +
> +       parser.add_argument('--cross_compile',
> +                           help='Sets make\'s CROSS_COMPILE variable.',
> +                           metavar='cross_compile')
> +

It'd be nice to have a slightly more detailed description here (that
its the compiler name's prefix or something).

>  def add_build_opts(parser) -> None:
>         parser.add_argument('--jobs',
>                             help='As in the make command, "Specifies  the number of '
> @@ -268,7 +276,10 @@ def main(argv, linux=None):
>                         os.mkdir(cli_args.build_dir)
>
>                 if not linux:
> -                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir, kunitconfig_path=cli_args.kunitconfig)
> +                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> +                                       kunitconfig_path=cli_args.kunitconfig,
> +                                       arch=cli_args.arch,
> +                                       cross_compile=cli_args.cross_compile)
>
>                 request = KunitRequest(cli_args.raw_output,
>                                        cli_args.timeout,
> @@ -287,7 +298,9 @@ def main(argv, linux=None):
>                         os.mkdir(cli_args.build_dir)
>
>                 if not linux:
> -                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir, kunitconfig_path=cli_args.kunitconfig)
> +                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> +                                       kunitconfig_path=cli_args.kunitconfig,
> +                                       arch=cli_args.arch)
>
>                 request = KunitConfigRequest(cli_args.build_dir,
>                                              cli_args.make_options)
> @@ -299,7 +312,9 @@ def main(argv, linux=None):
>                         sys.exit(1)
>         elif cli_args.subcommand == 'build':
>                 if not linux:
> -                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir, kunitconfig_path=cli_args.kunitconfig)
> +                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> +                                       kunitconfig_path=cli_args.kunitconfig,
> +                                       arch=cli_args.arch)

Why aren't we passing cross_compile through here? It's pretty
important for the 'build' step.

>
>                 request = KunitBuildRequest(cli_args.jobs,
>                                             cli_args.build_dir,
> @@ -313,7 +328,9 @@ def main(argv, linux=None):
>                         sys.exit(1)
>         elif cli_args.subcommand == 'exec':
>                 if not linux:
> -                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
> +                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> +                                       kunitconfig_path=cli_args.kunitconfig,
> +                                       arch=cli_args.arch)
>
>                 exec_request = KunitExecRequest(cli_args.timeout,
>                                                 cli_args.build_dir,
> diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
> index 1e2683dcc0e7a..07d76be392544 100644
> --- a/tools/testing/kunit/kunit_config.py
> +++ b/tools/testing/kunit/kunit_config.py
> @@ -53,7 +53,7 @@ class Kconfig(object):
>                 return True
>
>         def write_to_file(self, path: str) -> None:
> -               with open(path, 'w') as f:
> +               with open(path, 'a+') as f:
>                         for entry in self.entries():
>                                 f.write(str(entry) + '\n')
>
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 7d5b77967d48f..b8b3b76aaa17e 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -15,6 +15,8 @@ from typing import Iterator
>
>  from contextlib import ExitStack
>
> +from collections import namedtuple
> +
>  import kunit_config
>  import kunit_parser
>
> @@ -40,6 +42,10 @@ class BuildError(Exception):
>  class LinuxSourceTreeOperations(object):
>         """An abstraction over command line operations performed on a source tree."""
>
> +       def __init__(self, linux_arch, cross_compile):
> +               self._linux_arch = linux_arch
> +               self._cross_compile = cross_compile
> +
>         def make_mrproper(self) -> None:
>                 try:
>                         subprocess.check_output(['make', 'mrproper'], stderr=subprocess.STDOUT)
> @@ -48,12 +54,18 @@ class LinuxSourceTreeOperations(object):
>                 except subprocess.CalledProcessError as e:
>                         raise ConfigError(e.output.decode())
>
> +       def make_arch_qemuconfig(self, build_dir):
> +               pass
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
> +               print(' '.join(command))
>                 try:
>                         subprocess.check_output(command, stderr=subprocess.STDOUT)
>                 except OSError as e:
> @@ -61,6 +73,154 @@ class LinuxSourceTreeOperations(object):
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
> +               print(' '.join(command))
> +               try:
> +                       proc = subprocess.Popen(command,
> +                                               stderr=subprocess.PIPE,
> +                                               stdout=subprocess.DEVNULL)
> +               except OSError as e:
> +                       raise BuildError('Could not call execute make: ' + e)
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
> +QemuArchParams = namedtuple('QemuArchParams', ['linux_arch',
> +                                              'qemuconfig',
> +                                              'qemu_arch',
> +                                              'kernel_path',
> +                                              'kernel_command_line',
> +                                              'extra_qemu_params'])
> +
> +
> +QEMU_ARCHS = {
> +       'i386'          : QemuArchParams(linux_arch='i386',
> +                               qemuconfig='CONFIG_SERIAL_8250=y\nCONFIG_SERIAL_8250_CONSOLE=y',

I'm not keen on these configs being condensed like this in the source.
As mentioned below, moving the QemuArchParams to a separate file
helps, but even then it'd be nice to at least have each entry on a
separate line like with 'arm' below.

The other option would be to have this as a path to a separate
Kconfig/.kunitconfig file with these configs, rather than having them
inline here. I fear that could lead to every architecture needing
several support files, though some (e.g. x86/x86_64/alpha/sparc) could
share a file.

> +                               qemu_arch='x86_64',
> +                               kernel_path='arch/x86/boot/bzImage',
> +                               kernel_command_line='console=ttyS0',
> +                               extra_qemu_params=['']),
> +       'x86_64'        : QemuArchParams(linux_arch='x86_64',
> +                               qemuconfig='CONFIG_SERIAL_8250=y\nCONFIG_SERIAL_8250_CONSOLE=y',
> +                               qemu_arch='x86_64',
> +                               kernel_path='arch/x86/boot/bzImage',
> +                               kernel_command_line='console=ttyS0',
> +                               extra_qemu_params=['']),
> +       'arm'           : QemuArchParams(linux_arch='arm',
> +                               qemuconfig='''CONFIG_ARCH_VIRT=y
> +CONFIG_SERIAL_AMBA_PL010=y
> +CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
> +CONFIG_SERIAL_AMBA_PL011=y
> +CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
> +                               qemu_arch='arm',
> +                               kernel_path='arch/arm/boot/zImage',
> +                               kernel_command_line='console=ttyAMA0',
> +                               extra_qemu_params=['-machine virt']),
> +       'arm64'         : QemuArchParams(linux_arch='arm64',
> +                               qemuconfig='''CONFIG_SERIAL_AMBA_PL010=y
> +CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
> +CONFIG_SERIAL_AMBA_PL011=y
> +CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
> +                               qemu_arch='aarch64',
> +                               kernel_path='arch/arm64/boot/Image.gz',
> +                               kernel_command_line='console=ttyAMA0',
> +                               extra_qemu_params=['-machine virt', '-cpu cortex-a57']),
> +       'alpha'         : QemuArchParams(linux_arch='alpha',
> +                               qemuconfig='CONFIG_SERIAL_8250=y\nCONFIG_SERIAL_8250_CONSOLE=y',
> +                               qemu_arch='alpha',
> +                               kernel_path='arch/alpha/boot/vmlinux',
> +                               kernel_command_line='console=ttyS0',
> +                               extra_qemu_params=['']),
> +       'powerpc'       : QemuArchParams(linux_arch='powerpc',
> +                               qemuconfig='CONFIG_PPC64=y\nCONFIG_SERIAL_8250=y\nCONFIG_SERIAL_8250_CONSOLE=y\nCONFIG_HVC_CONSOLE=y',
> +                               qemu_arch='ppc64',
> +                               kernel_path='vmlinux',
> +                               kernel_command_line='console=ttyS0',
> +                               extra_qemu_params=['-M pseries', '-cpu power8']),
> +       'riscv'         : QemuArchParams(linux_arch='riscv',
> +                               qemuconfig='CONFIG_SOC_VIRT=y\nCONFIG_SERIAL_8250=y\nCONFIG_SERIAL_8250_CONSOLE=y\nCONFIG_SERIAL_OF_PLATFORM=y\nCONFIG_SERIAL_EARLYCON_RISCV_SBI=y',
> +                               qemu_arch='riscv64',
> +                               kernel_path='arch/riscv/boot/Image',
> +                               kernel_command_line='console=ttyS0',
> +                               extra_qemu_params=['-machine virt', '-cpu rv64', '-bios opensbi-riscv64-generic-fw_dynamic.bin']),
> +       's390'          : QemuArchParams(linux_arch='s390',
> +                               qemuconfig='CONFIG_EXPERT=y\nCONFIG_TUNE_ZEC12=y\nCONFIG_NUMA=y\nCONFIG_MODULES=y',
> +                               qemu_arch='s390x',
> +                               kernel_path='arch/s390/boot/bzImage',
> +                               kernel_command_line='console=ttyS0',
> +                               extra_qemu_params=[
> +                                               '-machine s390-ccw-virtio',
> +                                               '-cpu qemu',]),
> +       'sparc'         : QemuArchParams(linux_arch='sparc',
> +                               qemuconfig='CONFIG_SERIAL_8250=y\nCONFIG_SERIAL_8250_CONSOLE=y',
> +                               qemu_arch='sparc',
> +                               kernel_path='arch/sparc/boot/zImage',
> +                               kernel_command_line='console=ttyS0 mem=256M',
> +                               extra_qemu_params=['-m 256']),
> +}

So, as mentioned, I agree with Daniel in thinking that this really
doesn't belong here. Ideally, I think these configs should be
specified somewhere else, either as a (alas, very long) series of
command-line arguments, or in a separate file. Moving them to a single
'qemu_configs.py' as Daniel mentioned would be an improvement, but
IMHO still falls well short of ideal. I think each config should be in
its own file, as there are several reasons someone might want to have
multiple different configs for a given architecture and we'll want
people to be able to add/remove these easily in their own
environments.

The proposed solution of having each config in a separate file --
which we discussed offline -- is a big improvement:
https://kunit-review.googlesource.com/c/linux/+/4489

I still think that the python format here is a bit verbose and ugly,
but it's probably worth it compared to adding a parser for a whole new
type of config file. Similarly, I'm not sure about keeping a separate
qemu_configs.py around with the builtin defaults rather than just
having them all as separate files all the time. (Even appreciating
that that requires some filename magic to find the correct file.)
These are all more nitpicky though.

> +
> +class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
> +
> +       def __init__(self, qemu_arch_params, cross_compile):
> +               super().__init__(linux_arch=qemu_arch_params.linux_arch,
> +                                cross_compile=cross_compile)
> +               self._qemuconfig = qemu_arch_params.qemuconfig
> +               self._qemu_arch = qemu_arch_params.qemu_arch
> +               self._kernel_path = qemu_arch_params.kernel_path
> +               print(self._kernel_path)
> +               self._kernel_command_line = qemu_arch_params.kernel_command_line + ' kunit_shutdown=reboot'
> +               self._extra_qemu_params = qemu_arch_params.extra_qemu_params
> +
> +       def make_arch_qemuconfig(self, build_dir):
> +               qemuconfig = kunit_config.Kconfig()
> +               qemuconfig.parse_from_string(self._qemuconfig)
> +               qemuconfig.write_to_file(get_kconfig_path(build_dir))
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
> +               print(' '.join(qemu_command))
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
> +       def __init__(self):
> +               super().__init__(linux_arch='um', cross_compile=None)
> +

Why is cross_compile None here? Shouldn't it be possible to cross
compile UML kernels? (This should, I think, be possible for i386 on an
x86_64 host, for instance.)


>         def make_allyesconfig(self, build_dir, make_options) -> None:
>                 kunit_parser.print_with_timestamp(
>                         'Enabling all CONFIGs for UML...')
> @@ -83,32 +243,16 @@ class LinuxSourceTreeOperations(object):
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
> @@ -123,10 +267,17 @@ def get_outfile_path(build_dir) -> str:
>  class LinuxSourceTree(object):
>         """Represents a Linux kernel source tree with KUnit tests."""
>
> -       def __init__(self, build_dir: str, load_config=True, kunitconfig_path='') -> None:
> +       def __init__(self, build_dir: str, load_config=True, kunitconfig_path='', arch=None, cross_compile=None) -> None:
>                 signal.signal(signal.SIGINT, self.signal_handler)
> -
> -               self._ops = LinuxSourceTreeOperations()
> +               self._ops = None
> +               if arch is None or arch == 'um':
> +                       self._arch = 'um'
> +                       self._ops = LinuxSourceTreeOperationsUml()

Again, we should probably pass cross_compile through here.

> +               elif arch in QEMU_ARCHS:
> +                       self._arch = arch
> +                       self._ops = LinuxSourceTreeOperationsQemu(QEMU_ARCHS[arch], cross_compile=cross_compile)
> +               else:
> +                       raise ConfigError(arch + ' is not a valid arch')
>
>                 if not load_config:
>                         return
> @@ -170,6 +321,7 @@ class LinuxSourceTree(object):
>                         os.mkdir(build_dir)
>                 self._kconfig.write_to_file(kconfig_path)
>                 try:
> +                       self._ops.make_arch_qemuconfig(build_dir)
>                         self._ops.make_olddefconfig(build_dir, make_options)
>                 except ConfigError as e:
>                         logging.error(e)
> @@ -192,10 +344,13 @@ class LinuxSourceTree(object):
>                         print('Generating .config ...')
>                         return self.build_config(build_dir, make_options)
>
> -       def build_um_kernel(self, alltests, jobs, build_dir, make_options) -> bool:
> +       def build_kernel(self, alltests, jobs, build_dir, make_options) -> bool:
>                 try:
>                         if alltests:
> +                               if self._arch != 'um':
> +                                       raise ConfigError('Only the "um" arch is supported for alltests')
>                                 self._ops.make_allyesconfig(build_dir, make_options)
> +                       self._ops.make_arch_qemuconfig(build_dir)
>                         self._ops.make_olddefconfig(build_dir, make_options)
>                         self._ops.make(jobs, build_dir, make_options)
>                 except (ConfigError, BuildError) as e:
> @@ -209,8 +364,8 @@ class LinuxSourceTree(object):
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
> index 1ad3049e90698..25e8be95a575d 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -297,7 +297,7 @@ class KUnitMainTest(unittest.TestCase):
>
>                 self.linux_source_mock = mock.Mock()
>                 self.linux_source_mock.build_reconfig = mock.Mock(return_value=True)
> -               self.linux_source_mock.build_um_kernel = mock.Mock(return_value=True)
> +               self.linux_source_mock.build_kernel = mock.Mock(return_value=True)
>                 self.linux_source_mock.run_kernel = mock.Mock(return_value=all_passed_log)
>
>         def test_config_passes_args_pass(self):
> @@ -308,7 +308,7 @@ class KUnitMainTest(unittest.TestCase):
>         def test_build_passes_args_pass(self):
>                 kunit.main(['build'], self.linux_source_mock)
>                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 0)
> -               self.linux_source_mock.build_um_kernel.assert_called_once_with(False, 8, '.kunit', None)
> +               self.linux_source_mock.build_kernel.assert_called_once_with(False, 8, '.kunit', None)
>                 self.assertEqual(self.linux_source_mock.run_kernel.call_count, 0)
>
>         def test_exec_passes_args_pass(self):
> @@ -390,7 +390,7 @@ class KUnitMainTest(unittest.TestCase):
>         def test_build_builddir(self):
>                 build_dir = '.kunit'
>                 kunit.main(['build', '--build_dir', build_dir], self.linux_source_mock)
> -               self.linux_source_mock.build_um_kernel.assert_called_once_with(False, 8, build_dir, None)
> +               self.linux_source_mock.build_kernel.assert_called_once_with(False, 8, build_dir, None)
>
>         def test_exec_builddir(self):
>                 build_dir = '.kunit'
> @@ -404,14 +404,19 @@ class KUnitMainTest(unittest.TestCase):
>                 mock_linux_init.return_value = self.linux_source_mock
>                 kunit.main(['run', '--kunitconfig=mykunitconfig'])
>                 # Just verify that we parsed and initialized it correctly here.
> -               mock_linux_init.assert_called_once_with('.kunit', kunitconfig_path='mykunitconfig')
> +               mock_linux_init.assert_called_once_with('.kunit',
> +                                                       kunitconfig_path='mykunitconfig',
> +                                                       arch='um',
> +                                                       cross_compile=None)
>
>         @mock.patch.object(kunit_kernel, 'LinuxSourceTree')
>         def test_config_kunitconfig(self, mock_linux_init):
>                 mock_linux_init.return_value = self.linux_source_mock
>                 kunit.main(['config', '--kunitconfig=mykunitconfig'])
>                 # Just verify that we parsed and initialized it correctly here.
> -               mock_linux_init.assert_called_once_with('.kunit', kunitconfig_path='mykunitconfig')
> +               mock_linux_init.assert_called_once_with('.kunit',
> +                                                       kunitconfig_path='mykunitconfig',
> +                                                       arch='um')
>
>  if __name__ == '__main__':
>         unittest.main()
> --
> 2.31.1.498.g6c1eba8ee3d-goog
>
