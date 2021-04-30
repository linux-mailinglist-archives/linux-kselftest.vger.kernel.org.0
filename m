Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF7D3701E5
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Apr 2021 22:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhD3UPc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Apr 2021 16:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbhD3UPc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Apr 2021 16:15:32 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0015C06138B
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Apr 2021 13:14:42 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r9so107036272ejj.3
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Apr 2021 13:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bLEryQpjwvbo54ItiF17Fa9vz3LLIVlmwaTFOvOEzQ0=;
        b=u1Co8OFoZGn6pKhyb0C1Mb6XfOMxj+Ca9EKkFWy04Bdo/Wv6b2uUs6tf2sALYNQ/pW
         T+h5bmKIdDkz6BITGAZmDpNg93JADZQXJnw7NqzYOe4BmuiLXrV61JXsCPyMZJ39Ndxp
         qibybF3oybJJ0dQuGOeTBQKqQYqAMu20Zg5zwS6rUApj3nPg2ZfDRxhnjsVwOaRTDfI9
         cfAMc6UQKqKanbFqq10pze4RRznJDxLU5IKp3CgPnPULBE1kEKTFoUR7EOBIU6avCAwt
         LdTkRWeEb4mVeOx7KYiCXiu4Dn+nSm+oh26MVy5kB3/1ptx+WNCUJ3EqtqP4igl4GMlZ
         u1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bLEryQpjwvbo54ItiF17Fa9vz3LLIVlmwaTFOvOEzQ0=;
        b=OLHsoSJjR3SLsfeOfex6+xiyNNjKtK8P86yoOi3P0YA7NLOGADsIAeMpLixhTm6aEc
         6sD6Hh5Fw2eyqhSpZmbBWtUGck3CBiU2co8GVUbLLzymUiPRRxNBl+7XaCU0sDsPzY1E
         QN5rqX9p59aVrizLcFnV9Iqz6kZ5ewj/vkLJYW5RZABbzV+ddZuR1pWhlfoVbbXhwZ5C
         ow33s3v8K1gRGrBa/E5+m+fdt1PF82GDXFKLCedM0hIwU5frZAB8taIAY4iE7mHH+02D
         MCnzmIqnA50JsmqQ9Bd9Vt7maklOTd5+AQYGsPZ+yuWV+OS4mT5Lr+RgGLtKzSNJkPiQ
         bZvQ==
X-Gm-Message-State: AOAM533GElVS/72vS/h4y/Uni2VDeg4U4gF3+45sm2EVErYTLh50E7Md
        +AHWg/aE+O4WYEXONlWIhCMs7EM83fbnOpMYWRzWiA==
X-Google-Smtp-Source: ABdhPJwNb8COjBZuCRqs+HBnICz2RhD0TReKL/Yh48fShg42tiu3V/DAr1cYDCnNNJDuH+gdHv2wNuMt9ur44zBVE6M=
X-Received: by 2002:a17:906:7257:: with SMTP id n23mr6393792ejk.412.1619813681014;
 Fri, 30 Apr 2021 13:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210429205109.2847831-1-brendanhiggins@google.com>
 <20210429205109.2847831-4-brendanhiggins@google.com> <CAGS_qxo3NA6o8R73q5NdfsC3nx6i4WJgXnHxH6-v=ybnvDTj6Q@mail.gmail.com>
 <CAFd5g44OL0BQ74ZGEnYzsLYVXEbOB-hBiNAf1+VLO=DoZwKOvA@mail.gmail.com>
In-Reply-To: <CAFd5g44OL0BQ74ZGEnYzsLYVXEbOB-hBiNAf1+VLO=DoZwKOvA@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 30 Apr 2021 13:14:29 -0700
Message-ID: <CAGS_qxp0++OzvZTuLAFdBqe0gY+P0bQdKsTLiqHycLb9kvz81g@mail.gmail.com>
Subject: Re: [RFC v2 3/4] kunit: tool: add support for QEMU
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 30, 2021 at 1:01 PM 'Brendan Higgins' via KUnit
Development <kunit-dev@googlegroups.com> wrote:
>
> On Thu, Apr 29, 2021 at 4:40 PM Daniel Latypov <dlatypov@google.com> wrot=
e:
> >
> > On Thu, Apr 29, 2021 at 1:51 PM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > Add basic support to run QEMU via kunit_tool. Add support for i386,
> > > x86_64, arm, arm64, and a bunch more.
> >
> > Hmmm, I'm wondering if I'm seeing unrelated breakages.
> > Applied these patches on top of 55ba0fe059a5 ("Merge tag
> > 'for-5.13-tag' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux")
> >
> > $ make mrproper
> > $ rm -rf .kunit/*   # just in case
> > $ ./tools/testing/kunit/kunit.py run --arch=3Darm64
> > ...
>
> Huh, did you use a arm64 cross compiler? Maybe that's your issue.

I didn't (and realized that like 2 minutes after I sent the email).
Please disregard.

>
> > ERROR:root:arch/arm64/Makefile:25: ld does not support
> > --fix-cortex-a53-843419; kernel may be susceptible to erratum
> > arch/arm64/Makefile:44: Detected assembler with broken .inst;
> > disassembly will be unreliable
> > gcc: error: unrecognized command-line option =E2=80=98-mlittle-endian=
=E2=80=99
> >
> > So it seems like my version of ld might be out of date, but my gcc is 1=
0.2.1
> > Is there a minimum version of the toolchain this would expect that we
> > can call out in the commit message (and in the Documentation)?
> >
> > --arch=3Dx86_64 worked just fine for me, however, which is mainly what =
I
> > was interested in.
> >
> > I've mainly just left some nits and comments regarding typechecking.
> >
> > >
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > ---
> > >  tools/testing/kunit/kunit.py           |  33 +++-
> > >  tools/testing/kunit/kunit_config.py    |   2 +-
> > >  tools/testing/kunit/kunit_kernel.py    | 207 +++++++++++++++++++++--=
--
> > >  tools/testing/kunit/kunit_tool_test.py |  15 +-
> > >  4 files changed, 217 insertions(+), 40 deletions(-)
> > >
> > > diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit=
.py
> > > index d5144fcb03acd..07ef80062873b 100755
> > > --- a/tools/testing/kunit/kunit.py
> > > +++ b/tools/testing/kunit/kunit.py
> > > @@ -70,10 +70,10 @@ def build_tests(linux: kunit_kernel.LinuxSourceTr=
ee,
> > >         kunit_parser.print_with_timestamp('Building KUnit Kernel ...'=
)
> > >
> > >         build_start =3D time.time()
> > > -       success =3D linux.build_um_kernel(request.alltests,
> > > -                                       request.jobs,
> > > -                                       request.build_dir,
> > > -                                       request.make_options)
> > > +       success =3D linux.build_kernel(request.alltests,
> > > +                                    request.jobs,
> > > +                                    request.build_dir,
> > > +                                    request.make_options)
> > >         build_end =3D time.time()
> > >         if not success:
> > >                 return KunitResult(KunitStatus.BUILD_FAILURE,
> > > @@ -187,6 +187,14 @@ def add_common_opts(parser) -> None:
> > >                              help=3D'Path to Kconfig fragment that en=
ables KUnit tests',
> > >                              metavar=3D'kunitconfig')
> > >
> > > +       parser.add_argument('--arch',
> > > +                           help=3D'Specifies the architecture to run=
 tests under.',
> >
> > optional: perhaps add "(e.g. x86_64, um)"
> > Most people using this would be able to infer that, but I prefer
> > strings that are basically enums to document examples of useful
> > values.
>
> Good point, probably want to mention that I take the string name from
> the argument passed into the ARCH make variable.
>
> > (And x86 is probably the one most people want to use this flag for).
>
> Yep, but Linux refers to it as i386. Just trying to be consistent.

Sorry, I meant to say x86_64 there. i386 is what we should call it, yeah.

>
> > > +                           type=3Dstr, default=3D'um', metavar=3D'ar=
ch')
> > > +
> > > +       parser.add_argument('--cross_compile',
> > > +                           help=3D'Sets make\'s CROSS_COMPILE variab=
le.',
> > > +                           metavar=3D'cross_compile')
> > > +
> > >  def add_build_opts(parser) -> None:
> > >         parser.add_argument('--jobs',
> > >                             help=3D'As in the make command, "Specifie=
s  the number of '
> > > @@ -268,7 +276,10 @@ def main(argv, linux=3DNone):
> > >                         os.mkdir(cli_args.build_dir)
> > >
> > >                 if not linux:
> > > -                       linux =3D kunit_kernel.LinuxSourceTree(cli_ar=
gs.build_dir, kunitconfig_path=3Dcli_args.kunitconfig)
> > > +                       linux =3D kunit_kernel.LinuxSourceTree(cli_ar=
gs.build_dir,
> > > +                                       kunitconfig_path=3Dcli_args.k=
unitconfig,
> > > +                                       arch=3Dcli_args.arch,
> > > +                                       cross_compile=3Dcli_args.cros=
s_compile)
> > >
> > >                 request =3D KunitRequest(cli_args.raw_output,
> > >                                        cli_args.timeout,
> > > @@ -287,7 +298,9 @@ def main(argv, linux=3DNone):
> > >                         os.mkdir(cli_args.build_dir)
> > >
> > >                 if not linux:
> > > -                       linux =3D kunit_kernel.LinuxSourceTree(cli_ar=
gs.build_dir, kunitconfig_path=3Dcli_args.kunitconfig)
> > > +                       linux =3D kunit_kernel.LinuxSourceTree(cli_ar=
gs.build_dir,
> > > +                                       kunitconfig_path=3Dcli_args.k=
unitconfig,
> > > +                                       arch=3Dcli_args.arch)
> > >
> > >                 request =3D KunitConfigRequest(cli_args.build_dir,
> > >                                              cli_args.make_options)
> > > @@ -299,7 +312,9 @@ def main(argv, linux=3DNone):
> > >                         sys.exit(1)
> > >         elif cli_args.subcommand =3D=3D 'build':
> > >                 if not linux:
> > > -                       linux =3D kunit_kernel.LinuxSourceTree(cli_ar=
gs.build_dir, kunitconfig_path=3Dcli_args.kunitconfig)
> > > +                       linux =3D kunit_kernel.LinuxSourceTree(cli_ar=
gs.build_dir,
> > > +                                       kunitconfig_path=3Dcli_args.k=
unitconfig,
> > > +                                       arch=3Dcli_args.arch)
> > >
> > >                 request =3D KunitBuildRequest(cli_args.jobs,
> > >                                             cli_args.build_dir,
> > > @@ -313,7 +328,9 @@ def main(argv, linux=3DNone):
> > >                         sys.exit(1)
> > >         elif cli_args.subcommand =3D=3D 'exec':
> > >                 if not linux:
> > > -                       linux =3D kunit_kernel.LinuxSourceTree(cli_ar=
gs.build_dir)
> > > +                       linux =3D kunit_kernel.LinuxSourceTree(cli_ar=
gs.build_dir,
> > > +                                       kunitconfig_path=3Dcli_args.k=
unitconfig,
> > > +                                       arch=3Dcli_args.arch)
> > >
> > >                 exec_request =3D KunitExecRequest(cli_args.timeout,
> > >                                                 cli_args.build_dir,
> > > diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kuni=
t/kunit_config.py
> > > index 1e2683dcc0e7a..07d76be392544 100644
> > > --- a/tools/testing/kunit/kunit_config.py
> > > +++ b/tools/testing/kunit/kunit_config.py
> > > @@ -53,7 +53,7 @@ class Kconfig(object):
> > >                 return True
> > >
> > >         def write_to_file(self, path: str) -> None:
> > > -               with open(path, 'w') as f:
> > > +               with open(path, 'a+') as f:
> >
> > I might be missing something, but do we need this?
> >
> > w =3D> a means we wouldn't truncate the file if it exists. I can imagin=
e
> > I'm missing something that makes it necessary.
> > + =3D> opens for read/write: we don't do any reads with f afaict.
>
> Yeah, probably only needs to be a, not a+. But we do want append for
> adding the arch configs. Idea is that we want to append those onto
> whatever a base kunitconfig.
>
> Nevertheless, your concern is valid, might be a better way to do this. Th=
oughts?

Would it be cleaner to operate on Kconfig objects directly instead of
having the write_to_file() function do appends?
I'm worried this might lead to unintentional statefulness in other cases.

>
> > >                         for entry in self.entries():
> > >                                 f.write(str(entry) + '\n')
> > >
> > > diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kuni=
t/kunit_kernel.py
> > > index 7d5b77967d48f..b8b3b76aaa17e 100644
> > > --- a/tools/testing/kunit/kunit_kernel.py
> > > +++ b/tools/testing/kunit/kunit_kernel.py
> > > @@ -15,6 +15,8 @@ from typing import Iterator
> > >
> > >  from contextlib import ExitStack
> > >
> > > +from collections import namedtuple
> > > +
> > >  import kunit_config
> > >  import kunit_parser
> > >
> > > @@ -40,6 +42,10 @@ class BuildError(Exception):
> > >  class LinuxSourceTreeOperations(object):
> > >         """An abstraction over command line operations performed on a=
 source tree."""
> > >
> > > +       def __init__(self, linux_arch, cross_compile):
> >
> > nit: let's annotate these as `linux_arch: str, cross_compile: str` (or
> > is it Optional[str] here?)
> > I can see a reader thinking arch might be an enum and that
> > cross_compile might be a bool.
>
> Fair. Will do.
>
> > > +               self._linux_arch =3D linux_arch
> > > +               self._cross_compile =3D cross_compile
> > > +
> > >         def make_mrproper(self) -> None:
> > >                 try:
> > >                         subprocess.check_output(['make', 'mrproper'],=
 stderr=3Dsubprocess.STDOUT)
> > > @@ -48,12 +54,18 @@ class LinuxSourceTreeOperations(object):
> > >                 except subprocess.CalledProcessError as e:
> > >                         raise ConfigError(e.output.decode())
> > >
> > > +       def make_arch_qemuconfig(self, build_dir):
> > > +               pass
> > > +
> > >         def make_olddefconfig(self, build_dir, make_options) -> None:
> > > -               command =3D ['make', 'ARCH=3Dum', 'olddefconfig']
> > > +               command =3D ['make', 'ARCH=3D' + self._linux_arch, 'o=
lddefconfig']
> > > +               if self._cross_compile:
> > > +                       command +=3D ['CROSS_COMPILE=3D' + self._cros=
s_compile]
> > >                 if make_options:
> > >                         command.extend(make_options)
> > >                 if build_dir:
> > >                         command +=3D ['O=3D' + build_dir]
> > > +               print(' '.join(command))
> > >                 try:
> > >                         subprocess.check_output(command, stderr=3Dsub=
process.STDOUT)
> > >                 except OSError as e:
> > > @@ -61,6 +73,154 @@ class LinuxSourceTreeOperations(object):
> > >                 except subprocess.CalledProcessError as e:
> > >                         raise ConfigError(e.output.decode())
> > >
> > > +       def make(self, jobs, build_dir, make_options) -> None:
> > > +               command =3D ['make', 'ARCH=3D' + self._linux_arch, '-=
-jobs=3D' + str(jobs)]
> > > +               if make_options:
> > > +                       command.extend(make_options)
> > > +               if self._cross_compile:
> > > +                       command +=3D ['CROSS_COMPILE=3D' + self._cros=
s_compile]
> > > +               if build_dir:
> > > +                       command +=3D ['O=3D' + build_dir]
> > > +               print(' '.join(command))
> > > +               try:
> > > +                       proc =3D subprocess.Popen(command,
> > > +                                               stderr=3Dsubprocess.P=
IPE,
> > > +                                               stdout=3Dsubprocess.D=
EVNULL)
> > > +               except OSError as e:
> > > +                       raise BuildError('Could not call execute make=
: ' + e)
> >
> > pytype complains about this.
> > You'd want `+ str(e)`
>
> Got it. Will do. (I should probably also run pytype.)
>
> > > +               except subprocess.CalledProcessError as e:
> > > +                       raise BuildError(e.output)
> > > +               _, stderr =3D proc.communicate()
> > > +               if proc.returncode !=3D 0:
> > > +                       raise BuildError(stderr.decode())
> > > +               if stderr:  # likely only due to build warnings
> > > +                       print(stderr.decode())
> > > +
> > > +       def run(self, params, timeout, build_dir, outfile) -> None:
> > > +               pass
> > > +
> > > +
> > > +QemuArchParams =3D namedtuple('QemuArchParams', ['linux_arch',
> > > +                                              'qemuconfig',
> > > +                                              'qemu_arch',
> > > +                                              'kernel_path',
> > > +                                              'kernel_command_line',
> > > +                                              'extra_qemu_params'])
> > > +
> > > +
> > > +QEMU_ARCHS =3D {
> > > +       'i386'          : QemuArchParams(linux_arch=3D'i386',
> > > +                               qemuconfig=3D'CONFIG_SERIAL_8250=3Dy\=
nCONFIG_SERIAL_8250_CONSOLE=3Dy',
> > > +                               qemu_arch=3D'x86_64',
> > > +                               kernel_path=3D'arch/x86/boot/bzImage'=
,
> > > +                               kernel_command_line=3D'console=3DttyS=
0',
> > > +                               extra_qemu_params=3D['']),
> > > +       'x86_64'        : QemuArchParams(linux_arch=3D'x86_64',
> > > +                               qemuconfig=3D'CONFIG_SERIAL_8250=3Dy\=
nCONFIG_SERIAL_8250_CONSOLE=3Dy',
> > > +                               qemu_arch=3D'x86_64',
> > > +                               kernel_path=3D'arch/x86/boot/bzImage'=
,
> > > +                               kernel_command_line=3D'console=3DttyS=
0',
> > > +                               extra_qemu_params=3D['']),
> > > +       'arm'           : QemuArchParams(linux_arch=3D'arm',
> > > +                               qemuconfig=3D'''CONFIG_ARCH_VIRT=3Dy
> > > +CONFIG_SERIAL_AMBA_PL010=3Dy
> > > +CONFIG_SERIAL_AMBA_PL010_CONSOLE=3Dy
> > > +CONFIG_SERIAL_AMBA_PL011=3Dy
> > > +CONFIG_SERIAL_AMBA_PL011_CONSOLE=3Dy''',
> > > +                               qemu_arch=3D'arm',
> > > +                               kernel_path=3D'arch/arm/boot/zImage',
> > > +                               kernel_command_line=3D'console=3DttyA=
MA0',
> > > +                               extra_qemu_params=3D['-machine virt']=
),
> > > +       'arm64'         : QemuArchParams(linux_arch=3D'arm64',
> > > +                               qemuconfig=3D'''CONFIG_SERIAL_AMBA_PL=
010=3Dy
> > > +CONFIG_SERIAL_AMBA_PL010_CONSOLE=3Dy
> > > +CONFIG_SERIAL_AMBA_PL011=3Dy
> > > +CONFIG_SERIAL_AMBA_PL011_CONSOLE=3Dy''',
> > > +                               qemu_arch=3D'aarch64',
> > > +                               kernel_path=3D'arch/arm64/boot/Image.=
gz',
> > > +                               kernel_command_line=3D'console=3DttyA=
MA0',
> > > +                               extra_qemu_params=3D['-machine virt',=
 '-cpu cortex-a57']),
> > > +       'alpha'         : QemuArchParams(linux_arch=3D'alpha',
> > > +                               qemuconfig=3D'CONFIG_SERIAL_8250=3Dy\=
nCONFIG_SERIAL_8250_CONSOLE=3Dy',
> > > +                               qemu_arch=3D'alpha',
> > > +                               kernel_path=3D'arch/alpha/boot/vmlinu=
x',
> > > +                               kernel_command_line=3D'console=3DttyS=
0',
> > > +                               extra_qemu_params=3D['']),
> > > +       'powerpc'       : QemuArchParams(linux_arch=3D'powerpc',
> > > +                               qemuconfig=3D'CONFIG_PPC64=3Dy\nCONFI=
G_SERIAL_8250=3Dy\nCONFIG_SERIAL_8250_CONSOLE=3Dy\nCONFIG_HVC_CONSOLE=3Dy',
> > > +                               qemu_arch=3D'ppc64',
> > > +                               kernel_path=3D'vmlinux',
> > > +                               kernel_command_line=3D'console=3DttyS=
0',
> > > +                               extra_qemu_params=3D['-M pseries', '-=
cpu power8']),
> > > +       'riscv'         : QemuArchParams(linux_arch=3D'riscv',
> > > +                               qemuconfig=3D'CONFIG_SOC_VIRT=3Dy\nCO=
NFIG_SERIAL_8250=3Dy\nCONFIG_SERIAL_8250_CONSOLE=3Dy\nCONFIG_SERIAL_OF_PLAT=
FORM=3Dy\nCONFIG_SERIAL_EARLYCON_RISCV_SBI=3Dy',
> > > +                               qemu_arch=3D'riscv64',
> > > +                               kernel_path=3D'arch/riscv/boot/Image'=
,
> > > +                               kernel_command_line=3D'console=3DttyS=
0',
> > > +                               extra_qemu_params=3D['-machine virt',=
 '-cpu rv64', '-bios opensbi-riscv64-generic-fw_dynamic.bin']),
> > > +       's390'          : QemuArchParams(linux_arch=3D's390',
> > > +                               qemuconfig=3D'CONFIG_EXPERT=3Dy\nCONF=
IG_TUNE_ZEC12=3Dy\nCONFIG_NUMA=3Dy\nCONFIG_MODULES=3Dy',
> > > +                               qemu_arch=3D's390x',
> > > +                               kernel_path=3D'arch/s390/boot/bzImage=
',
> > > +                               kernel_command_line=3D'console=3DttyS=
0',
> > > +                               extra_qemu_params=3D[
> > > +                                               '-machine s390-ccw-vi=
rtio',
> > > +                                               '-cpu qemu',]),
> > > +       'sparc'         : QemuArchParams(linux_arch=3D'sparc',
> > > +                               qemuconfig=3D'CONFIG_SERIAL_8250=3Dy\=
nCONFIG_SERIAL_8250_CONSOLE=3Dy',
> > > +                               qemu_arch=3D'sparc',
> > > +                               kernel_path=3D'arch/sparc/boot/zImage=
',
> > > +                               kernel_command_line=3D'console=3DttyS=
0 mem=3D256M',
> > > +                               extra_qemu_params=3D['-m 256']),
> > > +}
> >
> > Oh my.
> > I don't know enough to say if there's a better way of doing this.
>
> Yeah, I know it's gross, but I did not want to put too much effort
> into until I got some feedback on it.
>
> > But I think we should probably split this out into a separate python
> > file, if this mapping remains necessary.
> > E.g. in a qemu_configs.py file or the like.
>
> Definitely an improvement. Any other thoughts on how to make this look
> less gross?

Unfortunately not. Like you, I'm hoping someone else might have some
better ideas how we can maybe push this config out of python.

But if we don't find anything else, I think having the hard-coding
isolated into its own package is fine, tbh.

>
> >
> > > +
> > > +class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
> >
> > I've called out the two errors pytype gives already, but mypy is even
> > worse about this new class :(
> >
> > $ mypy tools/testing/kunit/*.py
> > tools/testing/kunit/kunit_kernel.py:90: error: Unsupported operand
> > types for + ("str" and "OSError")
> > tools/testing/kunit/kunit_kernel.py:278: error: Incompatible types in
> > assignment (expression has type "LinuxSourceTreeOperationsQemu",
> > variable has type "Optional[LinuxSourceTreeOperationsUml]")
> > tools/testing/kunit/kunit_kernel.py:298: error: Item "None" of
> > "Optional[LinuxSourceTreeOperationsUml]" has no attribute
> > "make_mrproper"
> > tools/testing/kunit/kunit_kernel.py:324: error: Item "None" of
> > "Optional[LinuxSourceTreeOperationsUml]" has no attribute
> > "make_arch_qemuconfig"
> > tools/testing/kunit/kunit_kernel.py:325: error: Item "None" of
> > "Optional[LinuxSourceTreeOperationsUml]" has no attribute
> > "make_olddefconfig"
> > tools/testing/kunit/kunit_kernel.py:352: error: Item "None" of
> > "Optional[LinuxSourceTreeOperationsUml]" has no attribute
> > "make_allyesconfig"
> > tools/testing/kunit/kunit_kernel.py:353: error: Item "None" of
> > "Optional[LinuxSourceTreeOperationsUml]" has no attribute
> > "make_arch_qemuconfig"
> > tools/testing/kunit/kunit_kernel.py:354: error: Item "None" of
> > "Optional[LinuxSourceTreeOperationsUml]" has no attribute
> > "make_olddefconfig"
> > tools/testing/kunit/kunit_kernel.py:355: error: Item "None" of
> > "Optional[LinuxSourceTreeOperationsUml]" has no attribute "make"
> > tools/testing/kunit/kunit_kernel.py:368: error: Item "None" of
> > "Optional[LinuxSourceTreeOperationsUml]" has no attribute "run"
> >
> > So to make up for mypy being less smart, we can do this and get it down=
 2 errors
>
> Sounds good. Will do.
>
> > diff --git a/tools/testing/kunit/kunit_kernel.py
> > b/tools/testing/kunit/kunit_kernel.py
> > index b8b3b76aaa17..a0aaa28db4c1 100644
> > --- a/tools/testing/kunit/kunit_kernel.py
> > +++ b/tools/testing/kunit/kunit_kernel.py
> > @@ -11,7 +11,7 @@ import subprocess
> >  import os
> >  import shutil
> >  import signal
> > -from typing import Iterator
> > +from typing import Iterator, Union
> >
> >  from contextlib import ExitStack
> >
> > @@ -269,15 +269,16 @@ class LinuxSourceTree(object):
> >
> >         def __init__(self, build_dir: str, load_config=3DTrue,
> > kunitconfig_path=3D'', arch=3DNone, cross_compile=3DNone) -> None:
> >                 signal.signal(signal.SIGINT, self.signal_handler)
> > -               self._ops =3D None
> > +               ops =3D None # type: Union[None,
> > LinuxSourceTreeOperationsUml, LinuxSourceTreeOperationsQemu]
> >                 if arch is None or arch =3D=3D 'um':
> >                         self._arch =3D 'um'
> > -                       self._ops =3D LinuxSourceTreeOperationsUml()
> > +                       ops =3D LinuxSourceTreeOperationsUml()
> >                 elif arch in QEMU_ARCHS:
> >                         self._arch =3D arch
> > -                       self._ops =3D
> > LinuxSourceTreeOperationsQemu(QEMU_ARCHS[arch],
> > cross_compile=3Dcross_compile)
> > +                       ops =3D
> > LinuxSourceTreeOperationsQemu(QEMU_ARCHS[arch],
> > cross_compile=3Dcross_compile)
> >                 else:
> >                         raise ConfigError(arch + ' is not a valid arch'=
)
> > +               self._ops =3D ops
> >
> >                 if not load_config:
> >                         return
> >
> > > +
> > > +       def __init__(self, qemu_arch_params, cross_compile):
> > > +               super().__init__(linux_arch=3Dqemu_arch_params.linux_=
arch,
> > > +                                cross_compile=3Dcross_compile)
> > > +               self._qemuconfig =3D qemu_arch_params.qemuconfig
> > > +               self._qemu_arch =3D qemu_arch_params.qemu_arch
> > > +               self._kernel_path =3D qemu_arch_params.kernel_path
> > > +               print(self._kernel_path)
> > looks like a leftover debugging print statement?
>
> Oh yeah. Whoops.
>
> > > +               self._kernel_command_line =3D qemu_arch_params.kernel=
_command_line + ' kunit_shutdown=3Dreboot'
> > > +               self._extra_qemu_params =3D qemu_arch_params.extra_qe=
mu_params
> > > +
> > > +       def make_arch_qemuconfig(self, build_dir):
> > > +               qemuconfig =3D kunit_config.Kconfig()
> > > +               qemuconfig.parse_from_string(self._qemuconfig)
> > > +               qemuconfig.write_to_file(get_kconfig_path(build_dir))
> > > +
> > > +       def run(self, params, timeout, build_dir, outfile):
> > > +               kernel_path =3D os.path.join(build_dir, self._kernel_=
path)
> > > +               qemu_command =3D ['qemu-system-' + self._qemu_arch,
> > > +                               '-nodefaults',
> > > +                               '-m', '1024',
> > > +                               '-kernel', kernel_path,
> > > +                               '-append', '\'' + ' '.join(params + [=
self._kernel_command_line]) + '\'',
> > > +                               '-no-reboot',
> > > +                               '-nographic',
> > > +                               '-serial stdio'] + self._extra_qemu_p=
arams
> > > +               print(' '.join(qemu_command))
> >
> > ditto, a debug statement?
> > Though this one could be useful to actually print out for the user if
> > we include some more context in the message.
>
> Yeah, this was initially a debug, but then I ended up finding it
> pretty useful since it spits out a full qemu command that you can just
> run outside of the tool, so I left it in.

Yeah, I think this one was quite useful after running it a bit.
Maybe something like
  print('Running tests with:\n$', ' '.join(qemu_command))

>
> > > +               with open(outfile, 'w') as output:
> > > +                       process =3D subprocess.Popen(' '.join(qemu_co=
mmand),
> > > +                                                  stdin=3Dsubprocess=
.PIPE,
> > > +                                                  stdout=3Doutput,
> > > +                                                  stderr=3Dsubproces=
s.STDOUT,
> > > +                                                  text=3DTrue, shell=
=3DTrue)
> > > +               try:
> > > +                       process.wait(timeout=3Dtimeout)
> > > +               except Exception as e:
> > > +                       print(e)
> > > +                       process.terminate()
> > > +               return process
> > > +
> > > +class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
> > > +       """An abstraction over command line operations performed on a=
 source tree."""
> > > +
> > > +       def __init__(self):
> > > +               super().__init__(linux_arch=3D'um', cross_compile=3DN=
one)
> > > +
> > >         def make_allyesconfig(self, build_dir, make_options) -> None:
> > >                 kunit_parser.print_with_timestamp(
> > >                         'Enabling all CONFIGs for UML...')
> > > @@ -83,32 +243,16 @@ class LinuxSourceTreeOperations(object):
> > >                 kunit_parser.print_with_timestamp(
> > >                         'Starting Kernel with all configs takes a few=
 minutes...')
> > >
> > > -       def make(self, jobs, build_dir, make_options) -> None:
> > > -               command =3D ['make', 'ARCH=3Dum', '--jobs=3D' + str(j=
obs)]
> > > -               if make_options:
> > > -                       command.extend(make_options)
> > > -               if build_dir:
> > > -                       command +=3D ['O=3D' + build_dir]
> > > -               try:
> > > -                       proc =3D subprocess.Popen(command,
> > > -                                               stderr=3Dsubprocess.P=
IPE,
> > > -                                               stdout=3Dsubprocess.D=
EVNULL)
> > > -               except OSError as e:
> > > -                       raise BuildError('Could not call make command=
: ' + str(e))
> > > -               _, stderr =3D proc.communicate()
> > > -               if proc.returncode !=3D 0:
> > > -                       raise BuildError(stderr.decode())
> > > -               if stderr:  # likely only due to build warnings
> > > -                       print(stderr.decode())
> > > -
> > > -       def linux_bin(self, params, timeout, build_dir) -> None:
> > > +       def run(self, params, timeout, build_dir, outfile):
> > >                 """Runs the Linux UML binary. Must be named 'linux'."=
""
> > >                 linux_bin =3D get_file_path(build_dir, 'linux')
> > >                 outfile =3D get_outfile_path(build_dir)
> > >                 with open(outfile, 'w') as output:
> > >                         process =3D subprocess.Popen([linux_bin] + pa=
rams,
> > > +                                                  stdin=3Dsubprocess=
.PIPE,
> > >                                                    stdout=3Doutput,
> > > -                                                  stderr=3Dsubproces=
s.STDOUT)
> > > +                                                  stderr=3Dsubproces=
s.STDOUT,
> > > +                                                  text=3DTrue)
> > >                         process.wait(timeout)
> > >
> > >  def get_kconfig_path(build_dir) -> str:
> > > @@ -123,10 +267,17 @@ def get_outfile_path(build_dir) -> str:
> > >  class LinuxSourceTree(object):
> > >         """Represents a Linux kernel source tree with KUnit tests."""
> > >
> > > -       def __init__(self, build_dir: str, load_config=3DTrue, kunitc=
onfig_path=3D'') -> None:
> > > +       def __init__(self, build_dir: str, load_config=3DTrue, kunitc=
onfig_path=3D'', arch=3DNone, cross_compile=3DNone) -> None:
> > >                 signal.signal(signal.SIGINT, self.signal_handler)
> > > -
> > > -               self._ops =3D LinuxSourceTreeOperations()
> > > +               self._ops =3D None
> > > +               if arch is None or arch =3D=3D 'um':
> > > +                       self._arch =3D 'um'
> > > +                       self._ops =3D LinuxSourceTreeOperationsUml()
> > > +               elif arch in QEMU_ARCHS:
> > > +                       self._arch =3D arch
> > > +                       self._ops =3D LinuxSourceTreeOperationsQemu(Q=
EMU_ARCHS[arch], cross_compile=3Dcross_compile)
> > > +               else:
> > > +                       raise ConfigError(arch + ' is not a valid arc=
h')
> > >
> > >                 if not load_config:
> > >                         return
> > > @@ -170,6 +321,7 @@ class LinuxSourceTree(object):
> > >                         os.mkdir(build_dir)
> > >                 self._kconfig.write_to_file(kconfig_path)
> > >                 try:
> > > +                       self._ops.make_arch_qemuconfig(build_dir)
> > >                         self._ops.make_olddefconfig(build_dir, make_o=
ptions)
> > >                 except ConfigError as e:
> > >                         logging.error(e)
> > > @@ -192,10 +344,13 @@ class LinuxSourceTree(object):
> > >                         print('Generating .config ...')
> > >                         return self.build_config(build_dir, make_opti=
ons)
> > >
> > > -       def build_um_kernel(self, alltests, jobs, build_dir, make_opt=
ions) -> bool:
> > > +       def build_kernel(self, alltests, jobs, build_dir, make_option=
s) -> bool:
> > >                 try:
> > >                         if alltests:
> > > +                               if self._arch !=3D 'um':
> > > +                                       raise ConfigError('Only the "=
um" arch is supported for alltests')
> > >                                 self._ops.make_allyesconfig(build_dir=
, make_options)
> >
> > Minor note: pytype doesn't like this.
> > The code is correct, but pytype can't figure out that ops can't be the
> > QEMU variant.
> >
> > Pytype recognizes comments like " # pytype: disable=3Dattribute-error"
> > but mypy doesn't.
> > So I don't know that there's a way we can make both of them happy :/
>
> Hmmm...I could just add make_allyesconfig() to the base class and make
> it raise. That might be cleaner too.

Hmm, that's probably a good idea.

Side note: I think we might want to keep the existing check as well
just so it's more obvious to a reader that only uml is supported, even
at the cost of some duplication. But that's just personal preference.

>
> >
> > > +                       self._ops.make_arch_qemuconfig(build_dir)
> > >                         self._ops.make_olddefconfig(build_dir, make_o=
ptions)
> > >                         self._ops.make(jobs, build_dir, make_options)
> > >                 except (ConfigError, BuildError) as e:
> > > @@ -209,8 +364,8 @@ class LinuxSourceTree(object):
> > >                 args.extend(['mem=3D1G', 'console=3Dtty','kunit_shutd=
own=3Dhalt'])
> > >                 if filter_glob:
> > >                         args.append('kunit.filter_glob=3D'+filter_glo=
b)
> > > -               self._ops.linux_bin(args, timeout, build_dir)
> > >                 outfile =3D get_outfile_path(build_dir)
> > > +               self._ops.run(args, timeout, build_dir, outfile)
> > >                 subprocess.call(['stty', 'sane'])
> > >                 with open(outfile, 'r') as file:
> > >                         for line in file:
> > > diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/k=
unit/kunit_tool_test.py
> > > index 1ad3049e90698..25e8be95a575d 100755
> > > --- a/tools/testing/kunit/kunit_tool_test.py
> > > +++ b/tools/testing/kunit/kunit_tool_test.py
> > > @@ -297,7 +297,7 @@ class KUnitMainTest(unittest.TestCase):
> > >
> > >                 self.linux_source_mock =3D mock.Mock()
> > >                 self.linux_source_mock.build_reconfig =3D mock.Mock(r=
eturn_value=3DTrue)
> > > -               self.linux_source_mock.build_um_kernel =3D mock.Mock(=
return_value=3DTrue)
> > > +               self.linux_source_mock.build_kernel =3D mock.Mock(ret=
urn_value=3DTrue)
> > >                 self.linux_source_mock.run_kernel =3D mock.Mock(retur=
n_value=3Dall_passed_log)
> > >
> > >         def test_config_passes_args_pass(self):
> > > @@ -308,7 +308,7 @@ class KUnitMainTest(unittest.TestCase):
> > >         def test_build_passes_args_pass(self):
> > >                 kunit.main(['build'], self.linux_source_mock)
> > >                 self.assertEqual(self.linux_source_mock.build_reconfi=
g.call_count, 0)
> > > -               self.linux_source_mock.build_um_kernel.assert_called_=
once_with(False, 8, '.kunit', None)
> > > +               self.linux_source_mock.build_kernel.assert_called_onc=
e_with(False, 8, '.kunit', None)
> > >                 self.assertEqual(self.linux_source_mock.run_kernel.ca=
ll_count, 0)
> > >
> > >         def test_exec_passes_args_pass(self):
> > > @@ -390,7 +390,7 @@ class KUnitMainTest(unittest.TestCase):
> > >         def test_build_builddir(self):
> > >                 build_dir =3D '.kunit'
> > >                 kunit.main(['build', '--build_dir', build_dir], self.=
linux_source_mock)
> > > -               self.linux_source_mock.build_um_kernel.assert_called_=
once_with(False, 8, build_dir, None)
> > > +               self.linux_source_mock.build_kernel.assert_called_onc=
e_with(False, 8, build_dir, None)
> > >
> > >         def test_exec_builddir(self):
> > >                 build_dir =3D '.kunit'
> > > @@ -404,14 +404,19 @@ class KUnitMainTest(unittest.TestCase):
> > >                 mock_linux_init.return_value =3D self.linux_source_mo=
ck
> > >                 kunit.main(['run', '--kunitconfig=3Dmykunitconfig'])
> > >                 # Just verify that we parsed and initialized it corre=
ctly here.
> > > -               mock_linux_init.assert_called_once_with('.kunit', kun=
itconfig_path=3D'mykunitconfig')
> > > +               mock_linux_init.assert_called_once_with('.kunit',
> > > +                                                       kunitconfig_p=
ath=3D'mykunitconfig',
> > > +                                                       arch=3D'um',
> > > +                                                       cross_compile=
=3DNone)
> > >
> > >         @mock.patch.object(kunit_kernel, 'LinuxSourceTree')
> > >         def test_config_kunitconfig(self, mock_linux_init):
> > >                 mock_linux_init.return_value =3D self.linux_source_mo=
ck
> > >                 kunit.main(['config', '--kunitconfig=3Dmykunitconfig'=
])
> > >                 # Just verify that we parsed and initialized it corre=
ctly here.
> > > -               mock_linux_init.assert_called_once_with('.kunit', kun=
itconfig_path=3D'mykunitconfig')
> > > +               mock_linux_init.assert_called_once_with('.kunit',
> > > +                                                       kunitconfig_p=
ath=3D'mykunitconfig',
> > > +                                                       arch=3D'um')
> > >
> > >  if __name__ =3D=3D '__main__':
> > >         unittest.main()
> > > --
> > > 2.31.1.498.g6c1eba8ee3d-goog
> > >
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/CAFd5g44OL0BQ74ZGEnYzsLYVXEbOB-hBiNAf1%2BVLO%3DDoZwKOvA%40mail.=
gmail.com.
