Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21E438701B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 May 2021 05:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240640AbhERDDR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 May 2021 23:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238859AbhERDDQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 May 2021 23:03:16 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFE7C06175F
        for <linux-kselftest@vger.kernel.org>; Mon, 17 May 2021 20:01:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a4so8467053wrr.2
        for <linux-kselftest@vger.kernel.org>; Mon, 17 May 2021 20:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=prFdT1dQ2HQFGfpQl18+ytQ82tqJA0EOYgcl4wsuIgc=;
        b=Zm17ZW5gzs+hSxCoCwZvF59a3BNMhJoGP8e+YpLvq0yBzyvWePQRcTtjmTR+ANPjO3
         IWuEg+F1Pxu9axwyqMktPobr0O7fjBza55QWAOaCEw0owRQXmFC3rJrpab8Oe//DjtU5
         YI1ddSiwR00502niCiCIAeBR//BTKMvQIkp/bgnVRtVpz0wEeGFYF/fmw1v7AV25Mw+R
         /o0exomWezLaQzVsHRwTSDJjXauyPkwd9IM3Q1NR1k4KJSFni3N0SEJ6J67rlPEUimZO
         x+N5Y8rKZ2TNFLkWShDhrqDnCHqfnSaShGxzXh0QQVdgGZUhY8r6tZGJkI9QpF+2Xf0q
         LdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=prFdT1dQ2HQFGfpQl18+ytQ82tqJA0EOYgcl4wsuIgc=;
        b=f8hLxNWt6ogJYB/U+L9hIsrzyPdolqxQ7QpQUpCzQLFyb5wgc3DfpnB91jqdApR9K/
         ACc7OTb/4yRBbLqxFo5p/d0CVvQqVYYEgo4iibauQ7ajbXd/zjwcEo/fZwN7pFVoNmzI
         9wonJqSzZ1R7PjDhYMFO/U94kX5L7NrGNlwDMJw3pIavNy2cm4hcYnldf74AhAKGxB1L
         1PF+G3Sax08kCGEgcCaC5WL/5NgJxdr1AWomfhdPPcUvJrebI65GrPomhyHtRDLCOgwy
         AvLI3MO6iKRZUwARem02hUUFCDfh3wkZTtIB61LgcyaGWQE1IPR9YhjsVig55DSYsYGG
         V7kw==
X-Gm-Message-State: AOAM531p+jcujU02vIlIaOXv7LKft74zRTh8As/6g69ZkLcN7MVOQBFl
        ScqOn2IglDfxMMQyWNG+xK+wYA1ABWXGL7ILwjRfJg==
X-Google-Smtp-Source: ABdhPJyAJoy8Mtrq+wx7WKw+xrej8K0HKCsWnYJMnFl/mjhtViT4U+wFGHsHAVJFhMeX3mAjkzc7TFNo0rX6oDiGcWI=
X-Received: by 2002:adf:e58d:: with SMTP id l13mr3629520wrm.369.1621306915600;
 Mon, 17 May 2021 20:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210507213110.155492-1-brendanhiggins@google.com>
 <20210507213110.155492-4-brendanhiggins@google.com> <CABVgOSmEe32_kT9TR0-H8biuWGc1Rexne86DgLxths+GUHHgig@mail.gmail.com>
In-Reply-To: <CABVgOSmEe32_kT9TR0-H8biuWGc1Rexne86DgLxths+GUHHgig@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 18 May 2021 11:01:44 +0800
Message-ID: <CABVgOS=W-UhLJ5siu2u=Nus6g2zMEHM6c9ck2DHbHr0e5uCqSQ@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 15, 2021 at 3:59 PM David Gow <davidgow@google.com> wrote:
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

One thing I forgot to mention is that I'm not 100% sure about the
Kconfig fragments being embedded in the qemu_configs. I still kind-of
prefer the idea of them being in separate config files. While I don't
think this is necessarily a blocker, I did just realise that, by
default, kunit.py run --arch=<non-UM-arch> will pull its default
.kunitconfig from arch/um/configs/kunit_defconfig, which definitely
feels awkward when UML is not otherwise involved.

Some further thoughts below (which range a bit from "practical
suggestion" to "overcomplicated ponderings", so don't feel the
pressure to take all of them).

(...snip...)

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

This being in arch/um doesn't seem great if its being used for non-UML
builds. Is it worth either:
(a) moving this somewhere else (e.g., tools/testing/kunit/configs as
with the BROKEN_ALLCONFIG_PATH beflow), or
(b) giving each architecture its own kunit_defconfig, possibly in
place of the qemuconfig member of QemuArchParams

I'm leaning towards (b), which solves two different sources of
ugliness in one go, though it would appear to have the downside that
the default .kunitconfig could end up being architecture specific,
which isn't great.

> >  BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
> >  OUTFILE_PATH = 'test.log'
> > +ABS_TOOL_PATH = os.path.abspath(os.path.dirname(__file__))
> > +QEMU_CONFIGS_DIR = os.path.join(ABS_TOOL_PATH, 'qemu_configs')
> >

(...snip...)

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

As mentioned, I'm not thrilled about keeping the Kconfig inline here,
and would kind-of prefer it to be in another file. I could live with
it if I have to, though. Regardless, 'qemuconfig' is not a
super-descriptive name, particularly as it's not clear if this is
configuring QEMU (no, that's extra_qemu_params'), or configuring the
kernel for QEMU compatibility.

> > +                                              'qemu_arch',
> > +                                              'kernel_path',
> > +                                              'kernel_command_line',
> > +                                              'extra_qemu_params'])
> > +
>
> Nit: newline at end of file.
>
>
>
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

If these were in a separate file, they could be shared across alpha,
i386, x86_64, etc. Of course, that wouldn't gel well with putting them
in arch/.../config. If there were some way of listing multiple files,
it could form part of the config for several more architectures,
though that's probably overcomplicating things.

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

Similarly, if in a separate file and there were some multiple-file
mechanism, these could mostly be shared between arm & arm64 (ARCH_VIRT
being the only problem). Again, probably overcomplicating it at this
point though.

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
