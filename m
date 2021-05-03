Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D34937225E
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 May 2021 23:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhECVUo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 May 2021 17:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhECVUo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 May 2021 17:20:44 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC43CC061573
        for <linux-kselftest@vger.kernel.org>; Mon,  3 May 2021 14:19:50 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id b15so5294159pfl.4
        for <linux-kselftest@vger.kernel.org>; Mon, 03 May 2021 14:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yceMbfuMe0LpHdlMjCg9uNAqiz9PqXs7W+bbHB3dVNg=;
        b=lhfwPfdhxJtHhPnI4ckbIAgRtIJperDk2qcljZzzfZlr/B6mUmWQ/TR6zAsWCU8wPN
         26bQ4z9wssZ8Hi8+eMgcP6fqUeAnn0yDgY5Vu19m44uFX8t467mphV7zZNIsMVPyRa+y
         o7LbRGJnvzyzcMepXG8z5OlxL1yDMIGf53rBIYdXKMl6F5Q1s45zxQ2Ue+bl0lBjek1y
         vgI1RjBpNzzsn6UWJqsqMMUaSfnPM9KUGsAVmoOnMa6gOVJ7zEHMHqs0NnjvXlJoGn9z
         hT27bfWXhcf18Ijj/XhMUGBYj9riU55IMg/Q7TE9+fvUHm7KZhJl67jsKeS0cNRPEXHd
         Jd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yceMbfuMe0LpHdlMjCg9uNAqiz9PqXs7W+bbHB3dVNg=;
        b=i+nCfjqKLv8FKXGbJDPCG8VxPefzIUkHUJAk5Xaf69PQil55o1PNRD2HxSQY0xbpOT
         t1WJ27xtXFr2lqNtCLV5xqxGYUTq6CsAHOfs503TBw3DeBogeWzXtwl4xteAG9fBQZUV
         H7XClQhab5zHgViT3TTbUzkgWLq8whwreqr412PK9jioGq8eVY7hltTPQUr4gCdlQ0lM
         GOWnhXKA52JOJ5HJD8zhbJWsaFS+sJT6mdvO8uFJo22Cfj7Bj0H7i6+tGREucBRBznFG
         IJWT5KLdxoMQWQ2qWOb6pUp7HqTOny7IMWbIa/CMpxxuYd3B9XkJQ0daefpakVGwj8Lj
         1t1w==
X-Gm-Message-State: AOAM532RR4O6MYUn8pdELByS6QHaVNc30P0ObfuCYjSxmR0eNcSiYE5R
        ObPY9rRqbZYb/tIWXhmZi5ijnw==
X-Google-Smtp-Source: ABdhPJwgA1rV8UoR/D3oERz/rQz3RqU1+4C5dbctqKkTD+dr5PkRo/I9dfZMmNeRHJwCToUTg0zK2g==
X-Received: by 2002:a17:90a:9511:: with SMTP id t17mr707351pjo.235.1620076790030;
        Mon, 03 May 2021 14:19:50 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:201:aabe:5118:32ad:74bd])
        by smtp.gmail.com with ESMTPSA id x23sm9783186pfc.170.2021.05.03.14.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 14:19:49 -0700 (PDT)
Date:   Mon, 3 May 2021 14:19:43 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Daniel Latypov <dlatypov@google.com>
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
Subject: Re: [RFC v2 3/4] kunit: tool: add support for QEMU
Message-ID: <YJBo797fPy0DDQjS@google.com>
References: <20210429205109.2847831-1-brendanhiggins@google.com>
 <20210429205109.2847831-4-brendanhiggins@google.com>
 <CAGS_qxo3NA6o8R73q5NdfsC3nx6i4WJgXnHxH6-v=ybnvDTj6Q@mail.gmail.com>
 <CAFd5g44OL0BQ74ZGEnYzsLYVXEbOB-hBiNAf1+VLO=DoZwKOvA@mail.gmail.com>
 <CAGS_qxp0++OzvZTuLAFdBqe0gY+P0bQdKsTLiqHycLb9kvz81g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGS_qxp0++OzvZTuLAFdBqe0gY+P0bQdKsTLiqHycLb9kvz81g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 30, 2021 at 01:14:29PM -0700, Daniel Latypov wrote:
> On Fri, Apr 30, 2021 at 1:01 PM 'Brendan Higgins' via KUnit
> Development <kunit-dev@googlegroups.com> wrote:
> >
> > On Thu, Apr 29, 2021 at 4:40 PM Daniel Latypov <dlatypov@google.com> wrote:
> > >
> > > On Thu, Apr 29, 2021 at 1:51 PM Brendan Higgins
> > > <brendanhiggins@google.com> wrote:
> > > >
> > > > Add basic support to run QEMU via kunit_tool. Add support for i386,
> > > > x86_64, arm, arm64, and a bunch more.
> > >
> > > Hmmm, I'm wondering if I'm seeing unrelated breakages.
> > > Applied these patches on top of 55ba0fe059a5 ("Merge tag
> > > 'for-5.13-tag' of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux")
> > >
> > > $ make mrproper
> > > $ rm -rf .kunit/*   # just in case
> > > $ ./tools/testing/kunit/kunit.py run --arch=arm64
> > > ...
> >
> > Huh, did you use a arm64 cross compiler? Maybe that's your issue.
> 
> I didn't (and realized that like 2 minutes after I sent the email).
> Please disregard.

As I mention below, I had a conversation offline with David regarding
the problem of figuring out the best way to specify qemu_configs, and I
wanted to post the fruits of that discussion to get some early feedback
on it. I am still working on addressing your other comments, but I think
most of those are pretty straightforward and probably won't require much
discussion.

[...]
> > > > +
> > > > +QemuArchParams = namedtuple('QemuArchParams', ['linux_arch',
> > > > +                                              'qemuconfig',
> > > > +                                              'qemu_arch',
> > > > +                                              'kernel_path',
> > > > +                                              'kernel_command_line',
> > > > +                                              'extra_qemu_params'])
> > > > +
> > > > +
> > > > +QEMU_ARCHS = {
> > > > +       'i386'          : QemuArchParams(linux_arch='i386',
> > > > +                               qemuconfig='CONFIG_SERIAL_8250=y\nCONFIG_SERIAL_8250_CONSOLE=y',
> > > > +                               qemu_arch='x86_64',
> > > > +                               kernel_path='arch/x86/boot/bzImage',
> > > > +                               kernel_command_line='console=ttyS0',
> > > > +                               extra_qemu_params=['']),
> > > > +       'x86_64'        : QemuArchParams(linux_arch='x86_64',
> > > > +                               qemuconfig='CONFIG_SERIAL_8250=y\nCONFIG_SERIAL_8250_CONSOLE=y',
> > > > +                               qemu_arch='x86_64',
> > > > +                               kernel_path='arch/x86/boot/bzImage',
> > > > +                               kernel_command_line='console=ttyS0',
> > > > +                               extra_qemu_params=['']),
> > > > +       'arm'           : QemuArchParams(linux_arch='arm',
> > > > +                               qemuconfig='''CONFIG_ARCH_VIRT=y
> > > > +CONFIG_SERIAL_AMBA_PL010=y
> > > > +CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
> > > > +CONFIG_SERIAL_AMBA_PL011=y
> > > > +CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
> > > > +                               qemu_arch='arm',
> > > > +                               kernel_path='arch/arm/boot/zImage',
> > > > +                               kernel_command_line='console=ttyAMA0',
> > > > +                               extra_qemu_params=['-machine virt']),
> > > > +       'arm64'         : QemuArchParams(linux_arch='arm64',
> > > > +                               qemuconfig='''CONFIG_SERIAL_AMBA_PL010=y
> > > > +CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
> > > > +CONFIG_SERIAL_AMBA_PL011=y
> > > > +CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
> > > > +                               qemu_arch='aarch64',
> > > > +                               kernel_path='arch/arm64/boot/Image.gz',
> > > > +                               kernel_command_line='console=ttyAMA0',
> > > > +                               extra_qemu_params=['-machine virt', '-cpu cortex-a57']),
> > > > +       'alpha'         : QemuArchParams(linux_arch='alpha',
> > > > +                               qemuconfig='CONFIG_SERIAL_8250=y\nCONFIG_SERIAL_8250_CONSOLE=y',
> > > > +                               qemu_arch='alpha',
> > > > +                               kernel_path='arch/alpha/boot/vmlinux',
> > > > +                               kernel_command_line='console=ttyS0',
> > > > +                               extra_qemu_params=['']),
> > > > +       'powerpc'       : QemuArchParams(linux_arch='powerpc',
> > > > +                               qemuconfig='CONFIG_PPC64=y\nCONFIG_SERIAL_8250=y\nCONFIG_SERIAL_8250_CONSOLE=y\nCONFIG_HVC_CONSOLE=y',
> > > > +                               qemu_arch='ppc64',
> > > > +                               kernel_path='vmlinux',
> > > > +                               kernel_command_line='console=ttyS0',
> > > > +                               extra_qemu_params=['-M pseries', '-cpu power8']),
> > > > +       'riscv'         : QemuArchParams(linux_arch='riscv',
> > > > +                               qemuconfig='CONFIG_SOC_VIRT=y\nCONFIG_SERIAL_8250=y\nCONFIG_SERIAL_8250_CONSOLE=y\nCONFIG_SERIAL_OF_PLATFORM=y\nCONFIG_SERIAL_EARLYCON_RISCV_SBI=y',
> > > > +                               qemu_arch='riscv64',
> > > > +                               kernel_path='arch/riscv/boot/Image',
> > > > +                               kernel_command_line='console=ttyS0',
> > > > +                               extra_qemu_params=['-machine virt', '-cpu rv64', '-bios opensbi-riscv64-generic-fw_dynamic.bin']),
> > > > +       's390'          : QemuArchParams(linux_arch='s390',
> > > > +                               qemuconfig='CONFIG_EXPERT=y\nCONFIG_TUNE_ZEC12=y\nCONFIG_NUMA=y\nCONFIG_MODULES=y',
> > > > +                               qemu_arch='s390x',
> > > > +                               kernel_path='arch/s390/boot/bzImage',
> > > > +                               kernel_command_line='console=ttyS0',
> > > > +                               extra_qemu_params=[
> > > > +                                               '-machine s390-ccw-virtio',
> > > > +                                               '-cpu qemu',]),
> > > > +       'sparc'         : QemuArchParams(linux_arch='sparc',
> > > > +                               qemuconfig='CONFIG_SERIAL_8250=y\nCONFIG_SERIAL_8250_CONSOLE=y',
> > > > +                               qemu_arch='sparc',
> > > > +                               kernel_path='arch/sparc/boot/zImage',
> > > > +                               kernel_command_line='console=ttyS0 mem=256M',
> > > > +                               extra_qemu_params=['-m 256']),
> > > > +}
> > >
> > > Oh my.
> > > I don't know enough to say if there's a better way of doing this.
> >
> > Yeah, I know it's gross, but I did not want to put too much effort
> > into until I got some feedback on it.
> >
> > > But I think we should probably split this out into a separate python
> > > file, if this mapping remains necessary.
> > > E.g. in a qemu_configs.py file or the like.
> >
> > Definitely an improvement. Any other thoughts on how to make this look
> > less gross?
> 
> Unfortunately not. Like you, I'm hoping someone else might have some
> better ideas how we can maybe push this config out of python.
> 
> But if we don't find anything else, I think having the hard-coding
> isolated into its own package is fine, tbh.

So I chatted offline with David and one idea that came up was to keep
the configs in Python, but make the configs dynamically loaded somehow
with some kind of predefined format so that they are simple to add,
*and* more importantly that adding new ones that don't go upstream won't
be a burden to maintain. Basically a developer could have a QEMU config
that is customized for her usecase, and is no way dependent on any kinds
of changes to any upstream kunit_tool files.

So here is what I came up with: We have these qemu_config files which
can be specified anywhere within (subdirectories included) the
kunit_tool root directory. The qemu_config is a Python file that imports
the `QemuArchParams` object (above) defined by kunit_tool. It specifies
one variable: `QEMU_ARCH` which is of type `QemuArchParams` which is
then used as the arch listed above.

Below I have a proof-of-concept diff, you can see view the proposed
change on Gerrit here:

https://kunit-review.googlesource.com/c/linux/+/4489


diff --git a/tools/testing/kunit/__init__.py b/tools/testing/kunit/__init__.py
new file mode 100644
index 0000000000000..e69de29bb2d1d
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index f89def9e14dcd..eb9daf6896194 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -198,6 +198,11 @@ def add_common_opts(parser) -> None:
 			    help='Sets make\'s CROSS_COMPILE variable.',
 			    metavar='cross_compile')
 
+	parser.add_argument('--qemu_config',
+			    help=('Takes a path to a path to a file containing '
+				  'a QemuArchParams object.'),
+			    type=str, metavar='qemu_config')
+
 def add_build_opts(parser) -> None:
 	parser.add_argument('--jobs',
 			    help='As in the make command, "Specifies  the number of '
@@ -282,7 +287,8 @@ def main(argv, linux=None):
 			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
 					kunitconfig_path=cli_args.kunitconfig,
 					arch=cli_args.arch,
-					cross_compile=cli_args.cross_compile)
+					cross_compile=cli_args.cross_compile,
+					qemu_config_path=cli_args.qemu_config)
 
 		request = KunitRequest(cli_args.raw_output,
 				       cli_args.timeout,
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 64d0fffc5b86e..bc9b847bda658 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -6,6 +6,7 @@
 # Author: Felix Guo <felixguoxiuping@gmail.com>
 # Author: Brendan Higgins <brendanhiggins@google.com>
 
+import importlib.util
 import logging
 import subprocess
 import os
@@ -20,7 +21,7 @@ from collections import namedtuple
 
 import kunit_config
 import kunit_parser
-import qemu_configs
+import qemu_config
 
 KCONFIG_PATH = '.config'
 KUNITCONFIG_PATH = '.kunitconfig'
@@ -107,7 +108,7 @@ class LinuxSourceTreeOperations(object):
 
 class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
 
-	def __init__(self, qemu_arch_params: qemu_configs.QemuArchParams, cross_compile: Optional[str]):
+	def __init__(self, qemu_arch_params: qemu_config.QemuArchParams, cross_compile: Optional[str]):
 		super().__init__(linux_arch=qemu_arch_params.linux_arch,
 				 cross_compile=cross_compile)
 		self._qemuconfig = qemu_arch_params.qemuconfig
@@ -197,19 +198,34 @@ def get_outfile_path(build_dir) -> str:
 def get_source_tree_ops(arch: str, cross_compile: Optional[str]) -> LinuxSourceTreeOperations:
 	if arch == 'um':
 		return LinuxSourceTreeOperationsUml()
-	elif arch in qemu_configs.QEMU_ARCHS:
-		return LinuxSourceTreeOperationsQemu(qemu_configs.QEMU_ARCHS[arch],
+	elif arch in qemu_config.QEMU_ARCHS:
+		return LinuxSourceTreeOperationsQemu(qemu_config.QEMU_ARCHS[arch],
 						     cross_compile=cross_compile)
 	else:
 		raise ConfigError(arch + ' is not a valid arch')
 
+def get_source_tree_ops_from_qemu_config(config_path: str, cross_compile: Optional[str]) -> qemu_config.QemuArchParams:
+	abs_tool_path = os.path.abspath(os.path.dirname(__file__))
+	abs_config_path = os.path.abspath(config_path)
+	if os.path.commonpath([abs_tool_path, abs_config_path]) != abs_tool_path:
+		raise ConfigError('Given QEMU config file is not in a child directory of KUnit tool.')
+	relative_config_path = os.path.relpath(abs_config_path, abs_tool_path)
+	spec = importlib.util.spec_from_file_location('.' + relative_config_path, config_path)
+	config = importlib.util.module_from_spec(spec)
+	spec.loader.exec_module(config)
+	return config.QEMU_ARCH.linux_arch, LinuxSourceTreeOperationsQemu(
+			config.QEMU_ARCH, cross_compile=cross_compile)
+
 class LinuxSourceTree(object):
 	"""Represents a Linux kernel source tree with KUnit tests."""
 
-	def __init__(self, build_dir: str, load_config=True, kunitconfig_path='', arch=None, cross_compile=None) -> None:
+	def __init__(self, build_dir: str, load_config=True, kunitconfig_path='', arch=None, cross_compile=None, qemu_config_path=None) -> None:
 		signal.signal(signal.SIGINT, self.signal_handler)
-		self._arch = 'um' if arch is None else arch
-		self._ops = get_source_tree_ops(self._arch, cross_compile)
+		if qemu_config_path:
+			self._arch, self._ops = get_source_tree_ops_from_qemu_config(qemu_config_path, cross_compile)
+		else:
+			self._arch = 'um' if arch is None else arch
+			self._ops = get_source_tree_ops(self._arch, cross_compile)
 
 		if not load_config:
 			return
diff --git a/tools/testing/kunit/qemu_configs.py b/tools/testing/kunit/qemu_config.py
similarity index 100%
rename from tools/testing/kunit/qemu_configs.py
rename to tools/testing/kunit/qemu_config.py
diff --git a/tools/testing/kunit/qemu_configs/__init__.py b/tools/testing/kunit/qemu_configs/__init__.py
new file mode 100644
index 0000000000000..e69de29bb2d1d
diff --git a/tools/testing/kunit/qemu_configs/i386.py b/tools/testing/kunit/qemu_configs/i386.py
new file mode 100644
index 0000000000000..7f079db044cc7
--- /dev/null
+++ b/tools/testing/kunit/qemu_configs/i386.py
@@ -0,0 +1,8 @@
+from ..qemu_config import QemuArchParams
+
+QEMU_ARCH = QemuArchParams(linux_arch='i386',
+			   qemuconfig='CONFIG_SERIAL_8250=y\nCONFIG_SERIAL_8250_CONSOLE=y',
+			   qemu_arch='x86_64',
+			   kernel_path='arch/x86/boot/bzImage',
+			   kernel_command_line='console=ttyS0',
+			   extra_qemu_params=[''])

An example of how kunit_tool with the above change could be invoked is
as follows:

tools/testing/kunit/kunit.py run --timeout=60 --jobs=12 --qemu_config=./tools/testing/kunit/qemu_configs/i386.py

Let me know wha'cha think!

[...]
