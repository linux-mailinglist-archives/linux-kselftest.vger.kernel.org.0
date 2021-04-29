Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255A036F2ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Apr 2021 01:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhD2Xkw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Apr 2021 19:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhD2Xkv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Apr 2021 19:40:51 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB23C06138C
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Apr 2021 16:40:04 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a5so41560560ljk.0
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Apr 2021 16:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CrGhUSb1q9Od+TSm8iHyWQK/+YMBzLFLu4/a6FauF/k=;
        b=D7sbixqVvjvau1pLhlz+9m5EGOOPDfPYthgUBegXqvEaL66hZyiU6l8Sxhm63McGhV
         LsmmV36gjy1AO9nZLqBLVdjlsQUCW0vJyDVgbiyGe4JZAwsK777FRBh9n6KeiN4iVhib
         417ZEFablIUwzu1dBdY4TNmjlfHH/kn0O6bOjYGIjWRaIuJX612TXu1LfwSNz+9zDdWA
         3NN94EFT8yyoe+LB13R8Y2yOVEG8BVuIkBfW8r6ITc6umM75jZLbFTSVSAVjVHgc0G4H
         GPAwv8Tc4G8Sp6DVPFaoLtKJGeGJqhFQUKhGB1qqNHKRxhgIpgiEw/T/S3HKuBmPz/J7
         fNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CrGhUSb1q9Od+TSm8iHyWQK/+YMBzLFLu4/a6FauF/k=;
        b=FwRMAzpsT3EpI0yk8LVGTEQe0SbFmxgSKYBnVmRw0GPWMs19N+Tq+SEDDYzCZa4LHa
         KkIFje5hmLOwdj8jmY9zdFzIQI6BYsz5GCKjnXQp6T45D+hRN9QWMgRvI6zm6JZ7ubrD
         akijq4NERVPxUpFtGRRDc/fV33EbBlWmwFpGympZR5QYdcVDPl/66wSAyPyTsQEUpWjF
         8RWpBc9cEQ3XoUI9IPiEJEzd/p97DAdpgioqoQNn4OyD2nbNprQLxeKSYD9UWbSo9Cdf
         8ctwXGhTOyGS+r+OBN+y1zb883b7w5ydue8RC+RjsE6sKdwdI28hidDNc5VMlH8sbZsM
         maTg==
X-Gm-Message-State: AOAM531IOYWxKQvqP/8qUQ+z73yUcpxU8YBbPfBoNT+5tHaBzgSaXhxH
        zRLe5p/VAFfUZXiGmSZq3GrezG0+zJkAeYlIfYiGTQ==
X-Google-Smtp-Source: ABdhPJy/UNIkQj1U/RCmPSEyao0+wex5qJ5rVmzMAPCWrYNvLfhmalEFYCVXU8CKoRbmlV2tQMrhFBmsiTIy0h7jXC8=
X-Received: by 2002:a2e:b4a7:: with SMTP id q7mr1603489ljm.430.1619739602180;
 Thu, 29 Apr 2021 16:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210429205109.2847831-1-brendanhiggins@google.com> <20210429205109.2847831-4-brendanhiggins@google.com>
In-Reply-To: <20210429205109.2847831-4-brendanhiggins@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 29 Apr 2021 16:39:50 -0700
Message-ID: <CAGS_qxo3NA6o8R73q5NdfsC3nx6i4WJgXnHxH6-v=ybnvDTj6Q@mail.gmail.com>
Subject: Re: [RFC v2 3/4] kunit: tool: add support for QEMU
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 29, 2021 at 1:51 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Add basic support to run QEMU via kunit_tool. Add support for i386,
> x86_64, arm, arm64, and a bunch more.

Hmmm, I'm wondering if I'm seeing unrelated breakages.
Applied these patches on top of 55ba0fe059a5 ("Merge tag
'for-5.13-tag' of
git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux")

$ make mrproper
$ rm -rf .kunit/*   # just in case
$ ./tools/testing/kunit/kunit.py run --arch=3Darm64
...
ERROR:root:arch/arm64/Makefile:25: ld does not support
--fix-cortex-a53-843419; kernel may be susceptible to erratum
arch/arm64/Makefile:44: Detected assembler with broken .inst;
disassembly will be unreliable
gcc: error: unrecognized command-line option =E2=80=98-mlittle-endian=E2=80=
=99

So it seems like my version of ld might be out of date, but my gcc is 10.2.=
1
Is there a minimum version of the toolchain this would expect that we
can call out in the commit message (and in the Documentation)?

--arch=3Dx86_64 worked just fine for me, however, which is mainly what I
was interested in.

I've mainly just left some nits and comments regarding typechecking.

>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
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
>         build_start =3D time.time()
> -       success =3D linux.build_um_kernel(request.alltests,
> -                                       request.jobs,
> -                                       request.build_dir,
> -                                       request.make_options)
> +       success =3D linux.build_kernel(request.alltests,
> +                                    request.jobs,
> +                                    request.build_dir,
> +                                    request.make_options)
>         build_end =3D time.time()
>         if not success:
>                 return KunitResult(KunitStatus.BUILD_FAILURE,
> @@ -187,6 +187,14 @@ def add_common_opts(parser) -> None:
>                              help=3D'Path to Kconfig fragment that enable=
s KUnit tests',
>                              metavar=3D'kunitconfig')
>
> +       parser.add_argument('--arch',
> +                           help=3D'Specifies the architecture to run tes=
ts under.',

optional: perhaps add "(e.g. x86_64, um)"
Most people using this would be able to infer that, but I prefer
strings that are basically enums to document examples of useful
values.
(And x86 is probably the one most people want to use this flag for).

> +                           type=3Dstr, default=3D'um', metavar=3D'arch')
> +
> +       parser.add_argument('--cross_compile',
> +                           help=3D'Sets make\'s CROSS_COMPILE variable.'=
,
> +                           metavar=3D'cross_compile')
> +
>  def add_build_opts(parser) -> None:
>         parser.add_argument('--jobs',
>                             help=3D'As in the make command, "Specifies  t=
he number of '
> @@ -268,7 +276,10 @@ def main(argv, linux=3DNone):
>                         os.mkdir(cli_args.build_dir)
>
>                 if not linux:
> -                       linux =3D kunit_kernel.LinuxSourceTree(cli_args.b=
uild_dir, kunitconfig_path=3Dcli_args.kunitconfig)
> +                       linux =3D kunit_kernel.LinuxSourceTree(cli_args.b=
uild_dir,
> +                                       kunitconfig_path=3Dcli_args.kunit=
config,
> +                                       arch=3Dcli_args.arch,
> +                                       cross_compile=3Dcli_args.cross_co=
mpile)
>
>                 request =3D KunitRequest(cli_args.raw_output,
>                                        cli_args.timeout,
> @@ -287,7 +298,9 @@ def main(argv, linux=3DNone):
>                         os.mkdir(cli_args.build_dir)
>
>                 if not linux:
> -                       linux =3D kunit_kernel.LinuxSourceTree(cli_args.b=
uild_dir, kunitconfig_path=3Dcli_args.kunitconfig)
> +                       linux =3D kunit_kernel.LinuxSourceTree(cli_args.b=
uild_dir,
> +                                       kunitconfig_path=3Dcli_args.kunit=
config,
> +                                       arch=3Dcli_args.arch)
>
>                 request =3D KunitConfigRequest(cli_args.build_dir,
>                                              cli_args.make_options)
> @@ -299,7 +312,9 @@ def main(argv, linux=3DNone):
>                         sys.exit(1)
>         elif cli_args.subcommand =3D=3D 'build':
>                 if not linux:
> -                       linux =3D kunit_kernel.LinuxSourceTree(cli_args.b=
uild_dir, kunitconfig_path=3Dcli_args.kunitconfig)
> +                       linux =3D kunit_kernel.LinuxSourceTree(cli_args.b=
uild_dir,
> +                                       kunitconfig_path=3Dcli_args.kunit=
config,
> +                                       arch=3Dcli_args.arch)
>
>                 request =3D KunitBuildRequest(cli_args.jobs,
>                                             cli_args.build_dir,
> @@ -313,7 +328,9 @@ def main(argv, linux=3DNone):
>                         sys.exit(1)
>         elif cli_args.subcommand =3D=3D 'exec':
>                 if not linux:
> -                       linux =3D kunit_kernel.LinuxSourceTree(cli_args.b=
uild_dir)
> +                       linux =3D kunit_kernel.LinuxSourceTree(cli_args.b=
uild_dir,
> +                                       kunitconfig_path=3Dcli_args.kunit=
config,
> +                                       arch=3Dcli_args.arch)
>
>                 exec_request =3D KunitExecRequest(cli_args.timeout,
>                                                 cli_args.build_dir,
> diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/ku=
nit_config.py
> index 1e2683dcc0e7a..07d76be392544 100644
> --- a/tools/testing/kunit/kunit_config.py
> +++ b/tools/testing/kunit/kunit_config.py
> @@ -53,7 +53,7 @@ class Kconfig(object):
>                 return True
>
>         def write_to_file(self, path: str) -> None:
> -               with open(path, 'w') as f:
> +               with open(path, 'a+') as f:

I might be missing something, but do we need this?

w =3D> a means we wouldn't truncate the file if it exists. I can imagine
I'm missing something that makes it necessary.
+ =3D> opens for read/write: we don't do any reads with f afaict.

>                         for entry in self.entries():
>                                 f.write(str(entry) + '\n')
>
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/ku=
nit_kernel.py
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
>         """An abstraction over command line operations performed on a sou=
rce tree."""
>
> +       def __init__(self, linux_arch, cross_compile):

nit: let's annotate these as `linux_arch: str, cross_compile: str` (or
is it Optional[str] here?)
I can see a reader thinking arch might be an enum and that
cross_compile might be a bool.

> +               self._linux_arch =3D linux_arch
> +               self._cross_compile =3D cross_compile
> +
>         def make_mrproper(self) -> None:
>                 try:
>                         subprocess.check_output(['make', 'mrproper'], std=
err=3Dsubprocess.STDOUT)
> @@ -48,12 +54,18 @@ class LinuxSourceTreeOperations(object):
>                 except subprocess.CalledProcessError as e:
>                         raise ConfigError(e.output.decode())
>
> +       def make_arch_qemuconfig(self, build_dir):
> +               pass
> +
>         def make_olddefconfig(self, build_dir, make_options) -> None:
> -               command =3D ['make', 'ARCH=3Dum', 'olddefconfig']
> +               command =3D ['make', 'ARCH=3D' + self._linux_arch, 'oldde=
fconfig']
> +               if self._cross_compile:
> +                       command +=3D ['CROSS_COMPILE=3D' + self._cross_co=
mpile]
>                 if make_options:
>                         command.extend(make_options)
>                 if build_dir:
>                         command +=3D ['O=3D' + build_dir]
> +               print(' '.join(command))
>                 try:
>                         subprocess.check_output(command, stderr=3Dsubproc=
ess.STDOUT)
>                 except OSError as e:
> @@ -61,6 +73,154 @@ class LinuxSourceTreeOperations(object):
>                 except subprocess.CalledProcessError as e:
>                         raise ConfigError(e.output.decode())
>
> +       def make(self, jobs, build_dir, make_options) -> None:
> +               command =3D ['make', 'ARCH=3D' + self._linux_arch, '--job=
s=3D' + str(jobs)]
> +               if make_options:
> +                       command.extend(make_options)
> +               if self._cross_compile:
> +                       command +=3D ['CROSS_COMPILE=3D' + self._cross_co=
mpile]
> +               if build_dir:
> +                       command +=3D ['O=3D' + build_dir]
> +               print(' '.join(command))
> +               try:
> +                       proc =3D subprocess.Popen(command,
> +                                               stderr=3Dsubprocess.PIPE,
> +                                               stdout=3Dsubprocess.DEVNU=
LL)
> +               except OSError as e:
> +                       raise BuildError('Could not call execute make: ' =
+ e)

pytype complains about this.
You'd want `+ str(e)`


> +               except subprocess.CalledProcessError as e:
> +                       raise BuildError(e.output)
> +               _, stderr =3D proc.communicate()
> +               if proc.returncode !=3D 0:
> +                       raise BuildError(stderr.decode())
> +               if stderr:  # likely only due to build warnings
> +                       print(stderr.decode())
> +
> +       def run(self, params, timeout, build_dir, outfile) -> None:
> +               pass
> +
> +
> +QemuArchParams =3D namedtuple('QemuArchParams', ['linux_arch',
> +                                              'qemuconfig',
> +                                              'qemu_arch',
> +                                              'kernel_path',
> +                                              'kernel_command_line',
> +                                              'extra_qemu_params'])
> +
> +
> +QEMU_ARCHS =3D {
> +       'i386'          : QemuArchParams(linux_arch=3D'i386',
> +                               qemuconfig=3D'CONFIG_SERIAL_8250=3Dy\nCON=
FIG_SERIAL_8250_CONSOLE=3Dy',
> +                               qemu_arch=3D'x86_64',
> +                               kernel_path=3D'arch/x86/boot/bzImage',
> +                               kernel_command_line=3D'console=3DttyS0',
> +                               extra_qemu_params=3D['']),
> +       'x86_64'        : QemuArchParams(linux_arch=3D'x86_64',
> +                               qemuconfig=3D'CONFIG_SERIAL_8250=3Dy\nCON=
FIG_SERIAL_8250_CONSOLE=3Dy',
> +                               qemu_arch=3D'x86_64',
> +                               kernel_path=3D'arch/x86/boot/bzImage',
> +                               kernel_command_line=3D'console=3DttyS0',
> +                               extra_qemu_params=3D['']),
> +       'arm'           : QemuArchParams(linux_arch=3D'arm',
> +                               qemuconfig=3D'''CONFIG_ARCH_VIRT=3Dy
> +CONFIG_SERIAL_AMBA_PL010=3Dy
> +CONFIG_SERIAL_AMBA_PL010_CONSOLE=3Dy
> +CONFIG_SERIAL_AMBA_PL011=3Dy
> +CONFIG_SERIAL_AMBA_PL011_CONSOLE=3Dy''',
> +                               qemu_arch=3D'arm',
> +                               kernel_path=3D'arch/arm/boot/zImage',
> +                               kernel_command_line=3D'console=3DttyAMA0'=
,
> +                               extra_qemu_params=3D['-machine virt']),
> +       'arm64'         : QemuArchParams(linux_arch=3D'arm64',
> +                               qemuconfig=3D'''CONFIG_SERIAL_AMBA_PL010=
=3Dy
> +CONFIG_SERIAL_AMBA_PL010_CONSOLE=3Dy
> +CONFIG_SERIAL_AMBA_PL011=3Dy
> +CONFIG_SERIAL_AMBA_PL011_CONSOLE=3Dy''',
> +                               qemu_arch=3D'aarch64',
> +                               kernel_path=3D'arch/arm64/boot/Image.gz',
> +                               kernel_command_line=3D'console=3DttyAMA0'=
,
> +                               extra_qemu_params=3D['-machine virt', '-c=
pu cortex-a57']),
> +       'alpha'         : QemuArchParams(linux_arch=3D'alpha',
> +                               qemuconfig=3D'CONFIG_SERIAL_8250=3Dy\nCON=
FIG_SERIAL_8250_CONSOLE=3Dy',
> +                               qemu_arch=3D'alpha',
> +                               kernel_path=3D'arch/alpha/boot/vmlinux',
> +                               kernel_command_line=3D'console=3DttyS0',
> +                               extra_qemu_params=3D['']),
> +       'powerpc'       : QemuArchParams(linux_arch=3D'powerpc',
> +                               qemuconfig=3D'CONFIG_PPC64=3Dy\nCONFIG_SE=
RIAL_8250=3Dy\nCONFIG_SERIAL_8250_CONSOLE=3Dy\nCONFIG_HVC_CONSOLE=3Dy',
> +                               qemu_arch=3D'ppc64',
> +                               kernel_path=3D'vmlinux',
> +                               kernel_command_line=3D'console=3DttyS0',
> +                               extra_qemu_params=3D['-M pseries', '-cpu =
power8']),
> +       'riscv'         : QemuArchParams(linux_arch=3D'riscv',
> +                               qemuconfig=3D'CONFIG_SOC_VIRT=3Dy\nCONFIG=
_SERIAL_8250=3Dy\nCONFIG_SERIAL_8250_CONSOLE=3Dy\nCONFIG_SERIAL_OF_PLATFORM=
=3Dy\nCONFIG_SERIAL_EARLYCON_RISCV_SBI=3Dy',
> +                               qemu_arch=3D'riscv64',
> +                               kernel_path=3D'arch/riscv/boot/Image',
> +                               kernel_command_line=3D'console=3DttyS0',
> +                               extra_qemu_params=3D['-machine virt', '-c=
pu rv64', '-bios opensbi-riscv64-generic-fw_dynamic.bin']),
> +       's390'          : QemuArchParams(linux_arch=3D's390',
> +                               qemuconfig=3D'CONFIG_EXPERT=3Dy\nCONFIG_T=
UNE_ZEC12=3Dy\nCONFIG_NUMA=3Dy\nCONFIG_MODULES=3Dy',
> +                               qemu_arch=3D's390x',
> +                               kernel_path=3D'arch/s390/boot/bzImage',
> +                               kernel_command_line=3D'console=3DttyS0',
> +                               extra_qemu_params=3D[
> +                                               '-machine s390-ccw-virtio=
',
> +                                               '-cpu qemu',]),
> +       'sparc'         : QemuArchParams(linux_arch=3D'sparc',
> +                               qemuconfig=3D'CONFIG_SERIAL_8250=3Dy\nCON=
FIG_SERIAL_8250_CONSOLE=3Dy',
> +                               qemu_arch=3D'sparc',
> +                               kernel_path=3D'arch/sparc/boot/zImage',
> +                               kernel_command_line=3D'console=3DttyS0 me=
m=3D256M',
> +                               extra_qemu_params=3D['-m 256']),
> +}

Oh my.
I don't know enough to say if there's a better way of doing this.

But I think we should probably split this out into a separate python
file, if this mapping remains necessary.
E.g. in a qemu_configs.py file or the like.

> +
> +class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):

I've called out the two errors pytype gives already, but mypy is even
worse about this new class :(

$ mypy tools/testing/kunit/*.py
tools/testing/kunit/kunit_kernel.py:90: error: Unsupported operand
types for + ("str" and "OSError")
tools/testing/kunit/kunit_kernel.py:278: error: Incompatible types in
assignment (expression has type "LinuxSourceTreeOperationsQemu",
variable has type "Optional[LinuxSourceTreeOperationsUml]")
tools/testing/kunit/kunit_kernel.py:298: error: Item "None" of
"Optional[LinuxSourceTreeOperationsUml]" has no attribute
"make_mrproper"
tools/testing/kunit/kunit_kernel.py:324: error: Item "None" of
"Optional[LinuxSourceTreeOperationsUml]" has no attribute
"make_arch_qemuconfig"
tools/testing/kunit/kunit_kernel.py:325: error: Item "None" of
"Optional[LinuxSourceTreeOperationsUml]" has no attribute
"make_olddefconfig"
tools/testing/kunit/kunit_kernel.py:352: error: Item "None" of
"Optional[LinuxSourceTreeOperationsUml]" has no attribute
"make_allyesconfig"
tools/testing/kunit/kunit_kernel.py:353: error: Item "None" of
"Optional[LinuxSourceTreeOperationsUml]" has no attribute
"make_arch_qemuconfig"
tools/testing/kunit/kunit_kernel.py:354: error: Item "None" of
"Optional[LinuxSourceTreeOperationsUml]" has no attribute
"make_olddefconfig"
tools/testing/kunit/kunit_kernel.py:355: error: Item "None" of
"Optional[LinuxSourceTreeOperationsUml]" has no attribute "make"
tools/testing/kunit/kunit_kernel.py:368: error: Item "None" of
"Optional[LinuxSourceTreeOperationsUml]" has no attribute "run"

So to make up for mypy being less smart, we can do this and get it down 2 e=
rrors

diff --git a/tools/testing/kunit/kunit_kernel.py
b/tools/testing/kunit/kunit_kernel.py
index b8b3b76aaa17..a0aaa28db4c1 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -11,7 +11,7 @@ import subprocess
 import os
 import shutil
 import signal
-from typing import Iterator
+from typing import Iterator, Union

 from contextlib import ExitStack

@@ -269,15 +269,16 @@ class LinuxSourceTree(object):

        def __init__(self, build_dir: str, load_config=3DTrue,
kunitconfig_path=3D'', arch=3DNone, cross_compile=3DNone) -> None:
                signal.signal(signal.SIGINT, self.signal_handler)
-               self._ops =3D None
+               ops =3D None # type: Union[None,
LinuxSourceTreeOperationsUml, LinuxSourceTreeOperationsQemu]
                if arch is None or arch =3D=3D 'um':
                        self._arch =3D 'um'
-                       self._ops =3D LinuxSourceTreeOperationsUml()
+                       ops =3D LinuxSourceTreeOperationsUml()
                elif arch in QEMU_ARCHS:
                        self._arch =3D arch
-                       self._ops =3D
LinuxSourceTreeOperationsQemu(QEMU_ARCHS[arch],
cross_compile=3Dcross_compile)
+                       ops =3D
LinuxSourceTreeOperationsQemu(QEMU_ARCHS[arch],
cross_compile=3Dcross_compile)
                else:
                        raise ConfigError(arch + ' is not a valid arch')
+               self._ops =3D ops

                if not load_config:
                        return

> +
> +       def __init__(self, qemu_arch_params, cross_compile):
> +               super().__init__(linux_arch=3Dqemu_arch_params.linux_arch=
,
> +                                cross_compile=3Dcross_compile)
> +               self._qemuconfig =3D qemu_arch_params.qemuconfig
> +               self._qemu_arch =3D qemu_arch_params.qemu_arch
> +               self._kernel_path =3D qemu_arch_params.kernel_path
> +               print(self._kernel_path)
looks like a leftover debugging print statement?

> +               self._kernel_command_line =3D qemu_arch_params.kernel_com=
mand_line + ' kunit_shutdown=3Dreboot'
> +               self._extra_qemu_params =3D qemu_arch_params.extra_qemu_p=
arams
> +
> +       def make_arch_qemuconfig(self, build_dir):
> +               qemuconfig =3D kunit_config.Kconfig()
> +               qemuconfig.parse_from_string(self._qemuconfig)
> +               qemuconfig.write_to_file(get_kconfig_path(build_dir))
> +
> +       def run(self, params, timeout, build_dir, outfile):
> +               kernel_path =3D os.path.join(build_dir, self._kernel_path=
)
> +               qemu_command =3D ['qemu-system-' + self._qemu_arch,
> +                               '-nodefaults',
> +                               '-m', '1024',
> +                               '-kernel', kernel_path,
> +                               '-append', '\'' + ' '.join(params + [self=
._kernel_command_line]) + '\'',
> +                               '-no-reboot',
> +                               '-nographic',
> +                               '-serial stdio'] + self._extra_qemu_param=
s
> +               print(' '.join(qemu_command))

ditto, a debug statement?
Though this one could be useful to actually print out for the user if
we include some more context in the message.

> +               with open(outfile, 'w') as output:
> +                       process =3D subprocess.Popen(' '.join(qemu_comman=
d),
> +                                                  stdin=3Dsubprocess.PIP=
E,
> +                                                  stdout=3Doutput,
> +                                                  stderr=3Dsubprocess.ST=
DOUT,
> +                                                  text=3DTrue, shell=3DT=
rue)
> +               try:
> +                       process.wait(timeout=3Dtimeout)
> +               except Exception as e:
> +                       print(e)
> +                       process.terminate()
> +               return process
> +
> +class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
> +       """An abstraction over command line operations performed on a sou=
rce tree."""
> +
> +       def __init__(self):
> +               super().__init__(linux_arch=3D'um', cross_compile=3DNone)
> +
>         def make_allyesconfig(self, build_dir, make_options) -> None:
>                 kunit_parser.print_with_timestamp(
>                         'Enabling all CONFIGs for UML...')
> @@ -83,32 +243,16 @@ class LinuxSourceTreeOperations(object):
>                 kunit_parser.print_with_timestamp(
>                         'Starting Kernel with all configs takes a few min=
utes...')
>
> -       def make(self, jobs, build_dir, make_options) -> None:
> -               command =3D ['make', 'ARCH=3Dum', '--jobs=3D' + str(jobs)=
]
> -               if make_options:
> -                       command.extend(make_options)
> -               if build_dir:
> -                       command +=3D ['O=3D' + build_dir]
> -               try:
> -                       proc =3D subprocess.Popen(command,
> -                                               stderr=3Dsubprocess.PIPE,
> -                                               stdout=3Dsubprocess.DEVNU=
LL)
> -               except OSError as e:
> -                       raise BuildError('Could not call make command: ' =
+ str(e))
> -               _, stderr =3D proc.communicate()
> -               if proc.returncode !=3D 0:
> -                       raise BuildError(stderr.decode())
> -               if stderr:  # likely only due to build warnings
> -                       print(stderr.decode())
> -
> -       def linux_bin(self, params, timeout, build_dir) -> None:
> +       def run(self, params, timeout, build_dir, outfile):
>                 """Runs the Linux UML binary. Must be named 'linux'."""
>                 linux_bin =3D get_file_path(build_dir, 'linux')
>                 outfile =3D get_outfile_path(build_dir)
>                 with open(outfile, 'w') as output:
>                         process =3D subprocess.Popen([linux_bin] + params=
,
> +                                                  stdin=3Dsubprocess.PIP=
E,
>                                                    stdout=3Doutput,
> -                                                  stderr=3Dsubprocess.ST=
DOUT)
> +                                                  stderr=3Dsubprocess.ST=
DOUT,
> +                                                  text=3DTrue)
>                         process.wait(timeout)
>
>  def get_kconfig_path(build_dir) -> str:
> @@ -123,10 +267,17 @@ def get_outfile_path(build_dir) -> str:
>  class LinuxSourceTree(object):
>         """Represents a Linux kernel source tree with KUnit tests."""
>
> -       def __init__(self, build_dir: str, load_config=3DTrue, kunitconfi=
g_path=3D'') -> None:
> +       def __init__(self, build_dir: str, load_config=3DTrue, kunitconfi=
g_path=3D'', arch=3DNone, cross_compile=3DNone) -> None:
>                 signal.signal(signal.SIGINT, self.signal_handler)
> -
> -               self._ops =3D LinuxSourceTreeOperations()
> +               self._ops =3D None
> +               if arch is None or arch =3D=3D 'um':
> +                       self._arch =3D 'um'
> +                       self._ops =3D LinuxSourceTreeOperationsUml()
> +               elif arch in QEMU_ARCHS:
> +                       self._arch =3D arch
> +                       self._ops =3D LinuxSourceTreeOperationsQemu(QEMU_=
ARCHS[arch], cross_compile=3Dcross_compile)
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
>                         self._ops.make_olddefconfig(build_dir, make_optio=
ns)
>                 except ConfigError as e:
>                         logging.error(e)
> @@ -192,10 +344,13 @@ class LinuxSourceTree(object):
>                         print('Generating .config ...')
>                         return self.build_config(build_dir, make_options)
>
> -       def build_um_kernel(self, alltests, jobs, build_dir, make_options=
) -> bool:
> +       def build_kernel(self, alltests, jobs, build_dir, make_options) -=
> bool:
>                 try:
>                         if alltests:
> +                               if self._arch !=3D 'um':
> +                                       raise ConfigError('Only the "um" =
arch is supported for alltests')
>                                 self._ops.make_allyesconfig(build_dir, ma=
ke_options)

Minor note: pytype doesn't like this.
The code is correct, but pytype can't figure out that ops can't be the
QEMU variant.

Pytype recognizes comments like " # pytype: disable=3Dattribute-error"
but mypy doesn't.
So I don't know that there's a way we can make both of them happy :/


> +                       self._ops.make_arch_qemuconfig(build_dir)
>                         self._ops.make_olddefconfig(build_dir, make_optio=
ns)
>                         self._ops.make(jobs, build_dir, make_options)
>                 except (ConfigError, BuildError) as e:
> @@ -209,8 +364,8 @@ class LinuxSourceTree(object):
>                 args.extend(['mem=3D1G', 'console=3Dtty','kunit_shutdown=
=3Dhalt'])
>                 if filter_glob:
>                         args.append('kunit.filter_glob=3D'+filter_glob)
> -               self._ops.linux_bin(args, timeout, build_dir)
>                 outfile =3D get_outfile_path(build_dir)
> +               self._ops.run(args, timeout, build_dir, outfile)
>                 subprocess.call(['stty', 'sane'])
>                 with open(outfile, 'r') as file:
>                         for line in file:
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit=
/kunit_tool_test.py
> index 1ad3049e90698..25e8be95a575d 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -297,7 +297,7 @@ class KUnitMainTest(unittest.TestCase):
>
>                 self.linux_source_mock =3D mock.Mock()
>                 self.linux_source_mock.build_reconfig =3D mock.Mock(retur=
n_value=3DTrue)
> -               self.linux_source_mock.build_um_kernel =3D mock.Mock(retu=
rn_value=3DTrue)
> +               self.linux_source_mock.build_kernel =3D mock.Mock(return_=
value=3DTrue)
>                 self.linux_source_mock.run_kernel =3D mock.Mock(return_va=
lue=3Dall_passed_log)
>
>         def test_config_passes_args_pass(self):
> @@ -308,7 +308,7 @@ class KUnitMainTest(unittest.TestCase):
>         def test_build_passes_args_pass(self):
>                 kunit.main(['build'], self.linux_source_mock)
>                 self.assertEqual(self.linux_source_mock.build_reconfig.ca=
ll_count, 0)
> -               self.linux_source_mock.build_um_kernel.assert_called_once=
_with(False, 8, '.kunit', None)
> +               self.linux_source_mock.build_kernel.assert_called_once_wi=
th(False, 8, '.kunit', None)
>                 self.assertEqual(self.linux_source_mock.run_kernel.call_c=
ount, 0)
>
>         def test_exec_passes_args_pass(self):
> @@ -390,7 +390,7 @@ class KUnitMainTest(unittest.TestCase):
>         def test_build_builddir(self):
>                 build_dir =3D '.kunit'
>                 kunit.main(['build', '--build_dir', build_dir], self.linu=
x_source_mock)
> -               self.linux_source_mock.build_um_kernel.assert_called_once=
_with(False, 8, build_dir, None)
> +               self.linux_source_mock.build_kernel.assert_called_once_wi=
th(False, 8, build_dir, None)
>
>         def test_exec_builddir(self):
>                 build_dir =3D '.kunit'
> @@ -404,14 +404,19 @@ class KUnitMainTest(unittest.TestCase):
>                 mock_linux_init.return_value =3D self.linux_source_mock
>                 kunit.main(['run', '--kunitconfig=3Dmykunitconfig'])
>                 # Just verify that we parsed and initialized it correctly=
 here.
> -               mock_linux_init.assert_called_once_with('.kunit', kunitco=
nfig_path=3D'mykunitconfig')
> +               mock_linux_init.assert_called_once_with('.kunit',
> +                                                       kunitconfig_path=
=3D'mykunitconfig',
> +                                                       arch=3D'um',
> +                                                       cross_compile=3DN=
one)
>
>         @mock.patch.object(kunit_kernel, 'LinuxSourceTree')
>         def test_config_kunitconfig(self, mock_linux_init):
>                 mock_linux_init.return_value =3D self.linux_source_mock
>                 kunit.main(['config', '--kunitconfig=3Dmykunitconfig'])
>                 # Just verify that we parsed and initialized it correctly=
 here.
> -               mock_linux_init.assert_called_once_with('.kunit', kunitco=
nfig_path=3D'mykunitconfig')
> +               mock_linux_init.assert_called_once_with('.kunit',
> +                                                       kunitconfig_path=
=3D'mykunitconfig',
> +                                                       arch=3D'um')
>
>  if __name__ =3D=3D '__main__':
>         unittest.main()
> --
> 2.31.1.498.g6c1eba8ee3d-goog
>
