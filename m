Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125C738CF71
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 May 2021 22:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhEUU7E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 May 2021 16:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhEUU7D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 May 2021 16:59:03 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D443C0613ED
        for <linux-kselftest@vger.kernel.org>; Fri, 21 May 2021 13:57:39 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g18so14120309pfr.2
        for <linux-kselftest@vger.kernel.org>; Fri, 21 May 2021 13:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kkPdjm35hDZxcrkK9GJ+jftqINU4WgEPUSzkOsfGeVE=;
        b=PvLCEIT5kZnZ1X1+moFDE18ipumIZcvdEqbTlzqtAUn+JdBjaJhxbOCV21+MDieqwo
         czmP3YUa5ZNnBk/+VysRzu34vFK/JXHaqcS+zRZTAkk/ZGQsDCezIBH0tlAjoPQmIIPD
         N1NRoe0mjK63AQqA1HNs4MckMmDbBMKVNiZR3ro3BVN8h5dRA0pu4MFHzSujTYwQPhx5
         rirn9j2qwKC8oREOwVu0MkxvTsD93mZv2zckGXbxMp7EItJwhc1ao2xISyepyC5P4xw0
         WAQ5ZHQtOlokD53E6UTkcb8nCGGXwjDCU6GBe6J0lvIXenWeqQeEch3YhjNOsanpXbiN
         CNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kkPdjm35hDZxcrkK9GJ+jftqINU4WgEPUSzkOsfGeVE=;
        b=sBgcbE+svbd2PhQs/nEqVW7dEyPCRJavoOw/S+hTf1JYJGDoojBPubU+B6rsUBjPOj
         LYCVaT17iCFu8l67WgejU0Bf0kfXUfTL6h4wt+1QTQJd4L9Nbk2zqAQgqq5farLMiDiZ
         50LWw4zgku8xNgfOnI4oCGioRQjLrCfZ9U6DAJ6LWMFrvmj/aZL0k/bHaUYX5x5DtFoQ
         043Bc2cgdQJMh5Pj7iJcBt420/LPCOzgU7eozJKdiRxzw92M9n5KHsUS+/cgd2uFN06O
         sFubd/PBe9otXc8cxbWvSeKLW1ePKKMhnkv9s5SxkMUiW6lNs53pU6ev1UYweIb4WrV2
         ojQA==
X-Gm-Message-State: AOAM530o9pMlPlxCK7tXqneH1bYdE0/oW8P8805AqxJ4+nmIXcCkKJAM
        g0fT2YW7QjJgvqW18Mxxi+Aba3iGU8/RQTtxsE9RNg==
X-Google-Smtp-Source: ABdhPJwRfx5r/R/iPGbnRRaSZSdn3+n2js532Xgebo45zkuDDoYmHiBMk+2wKNRwIbb3GJ/wTSZI/eOMGRkcLDaIxk4=
X-Received: by 2002:a05:6a00:224c:b029:28e:6004:d0a5 with SMTP id
 i12-20020a056a00224cb029028e6004d0a5mr12133806pfu.1.1621630658450; Fri, 21
 May 2021 13:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210507213110.155492-1-brendanhiggins@google.com>
 <20210507213110.155492-4-brendanhiggins@google.com> <CABVgOSmEe32_kT9TR0-H8biuWGc1Rexne86DgLxths+GUHHgig@mail.gmail.com>
 <CABVgOS=W-UhLJ5siu2u=Nus6g2zMEHM6c9ck2DHbHr0e5uCqSQ@mail.gmail.com>
 <CAFd5g46kOy=JtNSX6nhMO6TdHK7sAZfvD=UqLpFDXPVFw4M4fA@mail.gmail.com> <CABVgOSkXYHs=xfg_sKsm8RzKB2JdnCatE2AViCh8DJ4po+C=3Q@mail.gmail.com>
In-Reply-To: <CABVgOSkXYHs=xfg_sKsm8RzKB2JdnCatE2AViCh8DJ4po+C=3Q@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 21 May 2021 13:57:25 -0700
Message-ID: <CAFd5g45Vj59kMihhCVdY0AHcxWXsMVpSuy8po7staSOWzyX2xw@mail.gmail.com>
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

On Thu, May 20, 2021 at 8:53 PM David Gow <davidgow@google.com> wrote:
>
> On Wed, May 19, 2021 at 4:43 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Mon, May 17, 2021 at 8:01 PM David Gow <davidgow@google.com> wrote:
> > >
> > > On Sat, May 15, 2021 at 3:59 PM David Gow <davidgow@google.com> wrote:
> > > >
> > > > On Sat, May 8, 2021 at 5:31 AM Brendan Higgins
> > > > <brendanhiggins@google.com> wrote:
> > > > >
> > > > > Add basic support to run QEMU via kunit_tool. Add support for i386,
> > > > > x86_64, arm, arm64, and a bunch more.
> > > > >
> > > > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > > > Tested-by: David Gow <davidgow@google.com>
> > > > > ---
> > > > >
> > > > > Changes since last revision:
> > > > >
> > > > > - A number of minor obvious issues pointed out by David and Daniel.
> > > > > - Added facility for merging Kconfigs at Daniel's suggestion.
> > > > > - Broke out qemu_configs each into their own config file which is loaded
> > > > >   dynamically - mostly at David's suggestion.
> > > > >
> > > > > ---
> > > >
> > > > This seems pretty good to me. I only have one real complaint --
> > > > qemu_configs needing to be in a subdirectory of ./tools/testing/kunit
> > > > -- but am able to tolerate that (even if I'd prefer not to have it) if
> > > > it's documented properly.
> > > >
> > > > Otherwise, save for a couple of minor nitpicks, this seems good to go.
> > > >
> > > > Reviewed-by: David Gow <davidgow@google.com>
> > > >
> > > >
> > >
> > > One thing I forgot to mention is that I'm not 100% sure about the
> > > Kconfig fragments being embedded in the qemu_configs. I still kind-of
> > > prefer the idea of them being in separate config files. While I don't
> >
> > I don't feel strongly either way, but I don't have a good idea on how
> > to implement your idea well. How about we leave it for now, and if you
> > decide you really want to do something about it, you can do it?
> >
> > > think this is necessarily a blocker, I did just realise that, by
> > > default, kunit.py run --arch=<non-UM-arch> will pull its default
> > > .kunitconfig from arch/um/configs/kunit_defconfig, which definitely
> > > feels awkward when UML is not otherwise involved.
> >
> > Hmmm...this file is identical to
> > tools/testing/kunit/configs/all_tests.config. Maybe we should just use
> > that instead?
> >
>
> That sounds like a better plan. It looks like all_tests.config isn't
> used anywhere, anyway. I might rename it and replace the
> arch/um/.../kunit_defconfig version in another patch, then.
>
> > > Some further thoughts below (which range a bit from "practical
> > > suggestion" to "overcomplicated ponderings", so don't feel the
> > > pressure to take all of them).
> > >
> > > (...snip...)
> > >
> > > > > diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> > > > > index e22ade9d91ad5..2bd196fd69e5c 100644
> > > > > --- a/tools/testing/kunit/kunit_kernel.py
> > > > > +++ b/tools/testing/kunit/kunit_kernel.py
> > > > > @@ -6,23 +6,31 @@
> > > > >  # Author: Felix Guo <felixguoxiuping@gmail.com>
> > > > >  # Author: Brendan Higgins <brendanhiggins@google.com>
> > > > >
> > > > > +from __future__ import annotations
> > > > > +import importlib.util
> > > > >  import logging
> > > > >  import subprocess
> > > > >  import os
> > > > >  import shutil
> > > > >  import signal
> > > > >  from typing import Iterator
> > > > > +from typing import Optional
> > > > >
> > > > >  from contextlib import ExitStack
> > > > >
> > > > > +from collections import namedtuple
> > > > > +
> > > > >  import kunit_config
> > > > >  import kunit_parser
> > > > > +import qemu_config
> > > > >
> > > > >  KCONFIG_PATH = '.config'
> > > > >  KUNITCONFIG_PATH = '.kunitconfig'
> > > > >  DEFAULT_KUNITCONFIG_PATH = 'arch/um/configs/kunit_defconfig'
> > >
> > > This being in arch/um doesn't seem great if its being used for non-UML
> > > builds. Is it worth either:
> > > (a) moving this somewhere else (e.g., tools/testing/kunit/configs as
> > > with the BROKEN_ALLCONFIG_PATH beflow), or
> >
> > How about we use: tools/testing/kunit/configs/all_tests.config ? The
> > file is identical.
>
> Yeah: I'm not thrilled with the name all_tests.config, but since it
> doesn't appear to be being used anywhere, I might just rename it in
> another patch.
>
> > > (b) giving each architecture its own kunit_defconfig, possibly in
> > > place of the qemuconfig member of QemuArchParams
> > >
> > > I'm leaning towards (b), which solves two different sources of
> > > ugliness in one go, though it would appear to have the downside that
> > > the default .kunitconfig could end up being architecture specific,
> > > which isn't great.
> >
> > Yeah, I am not a fan of trying to solve that problem in this patchset.
> > This is sounding more and more like what should be follow-on work to
> > me.
>
> Yeah, I'm not sure exactly what that should look like yet, anyway.
>
> Let's keep things as they are in this patch. I'll put a follow-up
> patch to use all_tests.config rather than the arch/um one (possibly as
> part of my "default to ALL_TESTS" patchset), and if we think of
> something better that is more architecture specific, we'll do that.
>
> > > > >  BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
> > > > >  OUTFILE_PATH = 'test.log'
> > > > > +ABS_TOOL_PATH = os.path.abspath(os.path.dirname(__file__))
> > > > > +QEMU_CONFIGS_DIR = os.path.join(ABS_TOOL_PATH, 'qemu_configs')
> > > > >
> > >
> > > (...snip...)
> > >
> > > > > diff --git a/tools/testing/kunit/qemu_config.py b/tools/testing/kunit/qemu_config.py
> > > > > new file mode 100644
> > > > > index 0000000000000..aff1fe0442dbc
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/kunit/qemu_config.py
> > > > > @@ -0,0 +1,17 @@
> > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > +#
> > > > > +# Collection of configs for building non-UML kernels and running them on QEMU.
> > > > > +#
> > > > > +# Copyright (C) 2021, Google LLC.
> > > > > +# Author: Brendan Higgins <brendanhiggins@google.com>
> > > > > +
> > > > > +from collections import namedtuple
> > > > > +
> > > > > +
> > > > > +QemuArchParams = namedtuple('QemuArchParams', ['linux_arch',
> > > > > +                                              'qemuconfig',
> > >
> > > As mentioned, I'm not thrilled about keeping the Kconfig inline here,
> > > and would kind-of prefer it to be in another file. I could live with
> > > it if I have to, though. Regardless, 'qemuconfig' is not a
> >
> > It will be fixed in the next revision.
> >
> > > super-descriptive name, particularly as it's not clear if this is
> > > configuring QEMU (no, that's extra_qemu_params'), or configuring the
> > > kernel for QEMU compatibility.
> >
> > Any suggestions on a better name? qemu_build_config_path? These
> > configs contain configs for configuring, building, and running kernels
> > on QEMU.
>
> I don't think we need "qemu" in the name, as this is already part of
> the QemuArchParams struct, and isn't a qemu config, but a kernel one.
>
> Something along the lines of "kernel_config" (or just "kconfig") maybe?

Doh, I got lost at some point and in my last email I thought you were
talking about the name QemuArchParams, not the qemuconfig field within
that struct. Looking back it is entirely clear to me that that is what
you were talking about, but for some reason I had a brainfart in my
last response. So yes, your suggestion sounds very reasonable. Will
fix.

> > > > > +                                              'qemu_arch',
> > > > > +                                              'kernel_path',
> > > > > +                                              'kernel_command_line',
> > > > > +                                              'extra_qemu_params'])
> > > > > +
> > > >
> > > > Nit: newline at end of file.
> > > >
> > > >
> > > >
> > > > > diff --git a/tools/testing/kunit/qemu_configs/alpha.py b/tools/testing/kunit/qemu_configs/alpha.py
> > > > > new file mode 100644
> > > > > index 0000000000000..2cc64f848ca2c
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/kunit/qemu_configs/alpha.py
> > > > > @@ -0,0 +1,10 @@
> > > > > +from ..qemu_config import QemuArchParams
> > > > > +
> > > > > +QEMU_ARCH = QemuArchParams(linux_arch='alpha',
> > > > > +                          qemuconfig='''
> > > > > +CONFIG_SERIAL_8250=y
> > > > > +CONFIG_SERIAL_8250_CONSOLE=y''',
> > >
> > > If these were in a separate file, they could be shared across alpha,
> > > i386, x86_64, etc. Of course, that wouldn't gel well with putting them
> > > in arch/.../config. If there were some way of listing multiple files,
> > > it could form part of the config for several more architectures,
> > > though that's probably overcomplicating things.
> >
> > Yeah, like I said, I have sympathy for what you are saying here, but
> > it really feels like something that can and should be addressed in
> > follow on patches. We could totally address this issue later by
> > expanding this field to take either a string containing a Kconfig, or
> > a path to an external Kconfig; if we do so, it won't cause any
> > migration issues in the future.
> >
>
> Yeah: I think we can solve this if it actually becomes a problem. No
> need to change anything here.
>
> > > > > +                          qemu_arch='alpha',
> > > > > +                          kernel_path='arch/alpha/boot/vmlinux',
> > > > > +                          kernel_command_line='console=ttyS0',
> > > > > +                          extra_qemu_params=[''])
> > > > > diff --git a/tools/testing/kunit/qemu_configs/arm.py b/tools/testing/kunit/qemu_configs/arm.py
> > > > > new file mode 100644
> > > > > index 0000000000000..29a043b0531a0
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/kunit/qemu_configs/arm.py
> > > > > @@ -0,0 +1,13 @@
> > > > > +from ..qemu_config import QemuArchParams
> > > > > +
> > > > > +QEMU_ARCH = QemuArchParams(linux_arch='arm',
> > > > > +                          qemuconfig='''
> > > > > +CONFIG_ARCH_VIRT=y
> > > > > +CONFIG_SERIAL_AMBA_PL010=y
> > > > > +CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
> > > > > +CONFIG_SERIAL_AMBA_PL011=y
> > > > > +CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
> > >
> > > Similarly, if in a separate file and there were some multiple-file
> > > mechanism, these could mostly be shared between arm & arm64 (ARCH_VIRT
> > > being the only problem). Again, probably overcomplicating it at this
> > > point though.
> >
> > Right.
> >
> > > > > +                          qemu_arch='arm',
> > > > > +                          kernel_path='arch/arm/boot/zImage',
> > > > > +                          kernel_command_line='console=ttyAMA0',
> > > > > +                          extra_qemu_params=['-machine virt'])
> > > > > diff --git a/tools/testing/kunit/qemu_configs/arm64.py b/tools/testing/kunit/qemu_configs/arm64.py
> > > > > new file mode 100644
> > > > > index 0000000000000..1ba200bc99f0f
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/kunit/qemu_configs/arm64.py
> > > > > @@ -0,0 +1,12 @@
> > > > > +from ..qemu_config import QemuArchParams
> > > > > +
> > > > > +QEMU_ARCH = QemuArchParams(linux_arch='arm64',
> > > > > +                          qemuconfig='''
> > > > > +CONFIG_SERIAL_AMBA_PL010=y
> > > > > +CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
> > > > > +CONFIG_SERIAL_AMBA_PL011=y
> > > > > +CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
> > > > > +                          qemu_arch='aarch64',
> > > > > +                          kernel_path='arch/arm64/boot/Image.gz',
> > > > > +                          kernel_command_line='console=ttyAMA0',
> > > > > +                          extra_qemu_params=['-machine virt', '-cpu cortex-a57'])
> > > > > diff --git a/tools/testing/kunit/qemu_configs/i386.py b/tools/testing/kunit/qemu_configs/i386.py
> > > > > new file mode 100644
> > > > > index 0000000000000..3998af306468e
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/kunit/qemu_configs/i386.py
> > > > > @@ -0,0 +1,10 @@
> > > > > +from ..qemu_config import QemuArchParams
> > > > > +
> > > > > +QEMU_ARCH = QemuArchParams(linux_arch='i386',
> > > > > +                          qemuconfig='''
> > > > > +CONFIG_SERIAL_8250=y
> > > > > +CONFIG_SERIAL_8250_CONSOLE=y''',
> > > > > +                          qemu_arch='x86_64',
> > > > > +                          kernel_path='arch/x86/boot/bzImage',
> > > > > +                          kernel_command_line='console=ttyS0',
> > > > > +                          extra_qemu_params=[''])
> > > > > diff --git a/tools/testing/kunit/qemu_configs/powerpc.py b/tools/testing/kunit/qemu_configs/powerpc.py
> > > > > new file mode 100644
> > > > > index 0000000000000..46292ce9e368e
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/kunit/qemu_configs/powerpc.py
> > > > > @@ -0,0 +1,12 @@
> > > > > +from ..qemu_config import QemuArchParams
> > > > > +
> > > > > +QEMU_ARCH = QemuArchParams(linux_arch='powerpc',
> > > > > +                          qemuconfig='''
> > > > > +CONFIG_PPC64=y
> > > > > +CONFIG_SERIAL_8250=y
> > > > > +CONFIG_SERIAL_8250_CONSOLE=y
> > > > > +CONFIG_HVC_CONSOLE=y''',
> > > > > +                          qemu_arch='ppc64',
> > > > > +                          kernel_path='vmlinux',
> > > > > +                          kernel_command_line='console=ttyS0',
> > > > > +                          extra_qemu_params=['-M pseries', '-cpu power8'])
> > > > > diff --git a/tools/testing/kunit/qemu_configs/riscv.py b/tools/testing/kunit/qemu_configs/riscv.py
> > > > > new file mode 100644
> > > > > index 0000000000000..de8c62d465723
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/kunit/qemu_configs/riscv.py
> > > > > @@ -0,0 +1,31 @@
> > > > > +from ..qemu_config import QemuArchParams
> > > > > +import os
> > > > > +import os.path
> > > > > +import sys
> > > > > +
> > > > > +GITHUB_OPENSBI_URL = 'https://github.com/qemu/qemu/raw/master/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin'
> > > > > +OPENSBI_FILE = os.path.basename(GITHUB_OPENSBI_URL)
> > > > > +
> > > > > +if not os.path.isfile(OPENSBI_FILE):
> > > > > +       print('\n\nOpenSBI file is not in the current working directory.\n'
> > > > > +             'Would you like me to download it for you from:\n' + GITHUB_OPENSBI_URL + ' ?\n')
> > > > > +       response = input('yes/[no]: ')
> > > > > +       if response.strip() == 'yes':
> > > > > +               os.system('wget ' + GITHUB_OPENSBI_URL)
> > > > > +       else:
> > > > > +               sys.exit()
> > > > > +
> > > > > +QEMU_ARCH = QemuArchParams(linux_arch='riscv',
> > > > > +                          qemuconfig='''
> > > > > +CONFIG_SOC_VIRT=y
> > > > > +CONFIG_SERIAL_8250=y
> > > > > +CONFIG_SERIAL_8250_CONSOLE=y
> > > > > +CONFIG_SERIAL_OF_PLATFORM=y
> > > > > +CONFIG_SERIAL_EARLYCON_RISCV_SBI=y''',
> > > > > +                          qemu_arch='riscv64',
> > > > > +                          kernel_path='arch/riscv/boot/Image',
> > > > > +                          kernel_command_line='console=ttyS0',
> > > > > +                          extra_qemu_params=[
> > > > > +                                          '-machine virt',
> > > > > +                                          '-cpu rv64',
> > > > > +                                          '-bios opensbi-riscv64-generic-fw_dynamic.bin'])
> > > > > diff --git a/tools/testing/kunit/qemu_configs/s390.py b/tools/testing/kunit/qemu_configs/s390.py
> > > > > new file mode 100644
> > > > > index 0000000000000..04c90332f1098
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/kunit/qemu_configs/s390.py
> > > > > @@ -0,0 +1,14 @@
> > > > > +from ..qemu_config import QemuArchParams
> > > > > +
> > > > > +QEMU_ARCH = QemuArchParams(linux_arch='s390',
> > > > > +                          qemuconfig='''
> > > > > +CONFIG_EXPERT=y
> > > > > +CONFIG_TUNE_ZEC12=y
> > > > > +CONFIG_NUMA=y
> > > > > +CONFIG_MODULES=y''',
> > > > > +                          qemu_arch='s390x',
> > > > > +                          kernel_path='arch/s390/boot/bzImage',
> > > > > +                          kernel_command_line='console=ttyS0',
> > > > > +                          extra_qemu_params=[
> > > > > +                                          '-machine s390-ccw-virtio',
> > > > > +                                          '-cpu qemu',])
> > > > > diff --git a/tools/testing/kunit/qemu_configs/sparc.py b/tools/testing/kunit/qemu_configs/sparc.py
> > > > > new file mode 100644
> > > > > index 0000000000000..f26b5f27cc5a1
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/kunit/qemu_configs/sparc.py
> > > > > @@ -0,0 +1,10 @@
> > > > > +from ..qemu_config import QemuArchParams
> > > > > +
> > > > > +QEMU_ARCH = QemuArchParams(linux_arch='sparc',
> > > > > +                          qemuconfig='''
> > > > > +CONFIG_SERIAL_8250=y
> > > > > +CONFIG_SERIAL_8250_CONSOLE=y''',
> > > > > +                          qemu_arch='sparc',
> > > > > +                          kernel_path='arch/sparc/boot/zImage',
> > > > > +                          kernel_command_line='console=ttyS0 mem=256M',
> > > > > +                          extra_qemu_params=['-m 256'])
> > > > > diff --git a/tools/testing/kunit/qemu_configs/x86_64.py b/tools/testing/kunit/qemu_configs/x86_64.py
> > > > > new file mode 100644
> > > > > index 0000000000000..bd5ab733b92ac
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/kunit/qemu_configs/x86_64.py
> > > > > @@ -0,0 +1,10 @@
> > > > > +from ..qemu_config import QemuArchParams
> > > > > +
> > > > > +QEMU_ARCH = QemuArchParams(linux_arch='x86_64',
> > > > > +                          qemuconfig='''
> > > > > +CONFIG_SERIAL_8250=y
> > > > > +CONFIG_SERIAL_8250_CONSOLE=y''',
> > > > > +                          qemu_arch='x86_64',
> > > > > +                          kernel_path='arch/x86/boot/bzImage',
> > > > > +                          kernel_command_line='console=ttyS0',
> > > > > +                          extra_qemu_params=[''])
> > > > > --
> > > > > 2.31.1.607.g51e8a6a459-goog
> > > > >
