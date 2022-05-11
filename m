Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E492B5240FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 01:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349281AbiEKXYX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 May 2022 19:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349463AbiEKXYI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 May 2022 19:24:08 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492406213F
        for <linux-kselftest@vger.kernel.org>; Wed, 11 May 2022 16:22:44 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w24so4289962edx.3
        for <linux-kselftest@vger.kernel.org>; Wed, 11 May 2022 16:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+W2uqkvSL6U5jn2MaeFHt2XSCx3i+exVEBv5pf2t0s=;
        b=p4EkiWxjIQeox8PBlqp+ZcAP4vTVS+9knd4t+eQLjFArs98erdGnkuCkI0BYQr18d4
         jWmPkNcqgWzRI5FA3YTcNLY36l+6T7Wes6hXHud08yyT2gAUlAhEVd7DAo2tT/PyK7l4
         aixSO7/N+eLnhVLPC20xZqDXAS3mHKX8lSDWnSM/59ETR7rTULy50JXLwCCOVnB0nniC
         d6L5cxLOUklG1Nup9A5SQx+C3KrfWWDOIK6eOWOvWXGaM4Qp5mmvM47tA+5wz0tdw4fJ
         i9y+3kj5Qd0AaHnvOGBtHzHo2bD569jg4Fh+BvbsTBsnIoxdLD89hv+JJlmFF+C7J7mA
         Sk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+W2uqkvSL6U5jn2MaeFHt2XSCx3i+exVEBv5pf2t0s=;
        b=VV7k+LSGlPeRmq15vmUqH6b01ooacJd0EJxJJMIpViSmD9F0zW+gqBLNxTwaNZfqHH
         zYFWRFDSAmcZ3wTtkj8LGdTCalA2KrXxxDbmzaBe6EhSX9W689Y5Ky7zqIThHT/uDmg5
         dtRIlbZ+b9E2jrah9s38EP0pM8ukHt2ksT68fusc+shpd03J27aTUPnkXfzYqkwdb8/1
         1Odm0oVzVwcbcIkxxgCjb2ggVxljEYRppUJisiS982SrEhBMg3Hc+fTrK0uT8mNxUBFU
         9uY1Qp0UTWha3fQNmgwTy4j7k7+ui9RnXQa05zBQ+tTrm/WoqcaH0XY+2WvGUmclsIZt
         4w2A==
X-Gm-Message-State: AOAM532q875mrtR7GIh4hY8OnCsCorPGlXLP/UEqOBwRLulHmYUUDJWJ
        btbnK26EiUusx9uyhCn8mLtwsK9v726UTYV8JLtjyA==
X-Google-Smtp-Source: ABdhPJxv3RcmiWoN4KAIHvKOv1TuEje4H2x0E+LVOK4OxIM31BAHdXVfcuy8yWPZJVH25UGhnVtvIlUyox6Q0kDGBm4=
X-Received: by 2002:a05:6402:1148:b0:416:a4fb:3c2e with SMTP id
 g8-20020a056402114800b00416a4fb3c2emr31968096edw.182.1652311362565; Wed, 11
 May 2022 16:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220420203020.1412886-1-dlatypov@google.com>
In-Reply-To: <20220420203020.1412886-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 11 May 2022 19:22:31 -0400
Message-ID: <CAFd5g454KM9-45NEjUN3JWTZmpajHY9to=CW7Ecg6z_5xorU+w@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: stop using a shell to run kernel under QEMU
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 20, 2022 at 4:30 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Note: this potentially breaks custom qemu_configs if people are using
> them! But the fix for them is simple, don't specify multiple arguments
> in one string and don't add on a redundant ''.
>
> It feels a bit iffy to be using a shell in the first place.
>
> There's the usual shenanigans where people could pass in arbitrary shell
> commands via --kernel_arg (since we're just adding '' around the
> kernel_cmdline) or via a custom qemu_config.
> This isn't too much of a concern given the nature of this script (and
> the qemu_config file is in python, you can do w/e you want already).
>
> But it does have some other drawbacks.
>
> One example of a kunit-specific pain point:
> If the relevant qemu binary is missing, we get output like this:
> > /bin/sh: line 1: qemu-system-aarch64: command not found
> This in turn results in our KTAP parser complaining about
> missing/invalid KTAP, but we don't directly show the error!
> It's even more annoying to debug when you consider --raw_output only
> shows KUnit output by default, i.e. you need --raw_output=all to see it.
>
> Whereas directly invoking the binary, Python will raise a
> FileNotFoundError for us, which is a noisier but more clear.
>
> Making this change requires
> * splitting parameters like ['-m 256'] into ['-m', '256'] in
>   kunit/qemu_configs/*.py
> * change [''] to [] in kunit/qemu_configs/*.py since otherwise
>   QEMU fails w/ 'Device needs media, but drive is empty'
> * dropping explicit quoting of the kernel cmdline
> * using shlex.quote() when we print what command we're running
>   so the user can copy-paste and run it
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

One issue I noticed below, otherwise:

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---
>  tools/testing/kunit/kunit_kernel.py         | 18 ++++++++++--------
>  tools/testing/kunit/qemu_configs/alpha.py   |  2 +-
>  tools/testing/kunit/qemu_configs/arm.py     |  2 +-
>  tools/testing/kunit/qemu_configs/arm64.py   |  2 +-
>  tools/testing/kunit/qemu_configs/i386.py    |  2 +-
>  tools/testing/kunit/qemu_configs/powerpc.py |  2 +-
>  tools/testing/kunit/qemu_configs/riscv.py   |  6 +++---
>  tools/testing/kunit/qemu_configs/s390.py    |  4 ++--
>  tools/testing/kunit/qemu_configs/sparc.py   |  2 +-
>  tools/testing/kunit/qemu_configs/x86_64.py  |  2 +-
>  10 files changed, 22 insertions(+), 20 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 483f78e15ce9..1b9c4922a675 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -11,6 +11,7 @@ import importlib.util
>  import logging
>  import subprocess
>  import os
> +import shlex
>  import shutil
>  import signal
>  import threading
> @@ -118,16 +119,17 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
>                                 '-nodefaults',
>                                 '-m', '1024',
>                                 '-kernel', kernel_path,
> -                               '-append', '\'' + ' '.join(params + [self._kernel_command_line]) + '\'',
> +                               '-append', ' '.join(params + [self._kernel_command_line]),
>                                 '-no-reboot',
>                                 '-nographic',
> -                               '-serial stdio'] + self._extra_qemu_params
> -               print('Running tests with:\n$', ' '.join(qemu_command))
> -               return subprocess.Popen(' '.join(qemu_command),
> -                                          stdin=subprocess.PIPE,
> -                                          stdout=subprocess.PIPE,
> -                                          stderr=subprocess.STDOUT,
> -                                          text=True, shell=True, errors='backslashreplace')
> +                               '-serial', 'stdio'] + self._extra_qemu_params
> +               # Note: shlex.join() does what we want, but requires python 3.8+.
> +               print('Running tests with:\n$', ' '.join(shlex.quote(arg) for arg in qemu_command))
> +               return subprocess.Popen(qemu_command,
> +                                       stdin=subprocess.PIPE,
> +                                       stdout=subprocess.PIPE,
> +                                       stderr=subprocess.STDOUT,
> +                                       text=True, errors='backslashreplace')
>
>  class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
>         """An abstraction over command line operations performed on a source tree."""
> diff --git a/tools/testing/kunit/qemu_configs/alpha.py b/tools/testing/kunit/qemu_configs/alpha.py
> index 5d0c0cff03bd..3ac846e03a6b 100644
> --- a/tools/testing/kunit/qemu_configs/alpha.py
> +++ b/tools/testing/kunit/qemu_configs/alpha.py
> @@ -7,4 +7,4 @@ CONFIG_SERIAL_8250_CONSOLE=y''',
>                            qemu_arch='alpha',
>                            kernel_path='arch/alpha/boot/vmlinux',
>                            kernel_command_line='console=ttyS0',
> -                          extra_qemu_params=[''])
> +                          extra_qemu_params=[])
> diff --git a/tools/testing/kunit/qemu_configs/arm.py b/tools/testing/kunit/qemu_configs/arm.py
> index b9c2a35e0296..db2160200566 100644
> --- a/tools/testing/kunit/qemu_configs/arm.py
> +++ b/tools/testing/kunit/qemu_configs/arm.py
> @@ -10,4 +10,4 @@ CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
>                            qemu_arch='arm',
>                            kernel_path='arch/arm/boot/zImage',
>                            kernel_command_line='console=ttyAMA0',
> -                          extra_qemu_params=['-machine virt'])
> +                          extra_qemu_params=['-machine', 'virt'])
> diff --git a/tools/testing/kunit/qemu_configs/arm64.py b/tools/testing/kunit/qemu_configs/arm64.py
> index 517c04459f47..67d04064f785 100644
> --- a/tools/testing/kunit/qemu_configs/arm64.py
> +++ b/tools/testing/kunit/qemu_configs/arm64.py
> @@ -9,4 +9,4 @@ CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
>                            qemu_arch='aarch64',
>                            kernel_path='arch/arm64/boot/Image.gz',
>                            kernel_command_line='console=ttyAMA0',
> -                          extra_qemu_params=['-machine virt', '-cpu cortex-a57'])
> +                          extra_qemu_params=['-machine', 'virt', '-cpu', 'cortex-a57'])
> diff --git a/tools/testing/kunit/qemu_configs/i386.py b/tools/testing/kunit/qemu_configs/i386.py
> index aed3ffd3937d..52b80be40e4b 100644
> --- a/tools/testing/kunit/qemu_configs/i386.py
> +++ b/tools/testing/kunit/qemu_configs/i386.py
> @@ -7,4 +7,4 @@ CONFIG_SERIAL_8250_CONSOLE=y''',
>                            qemu_arch='x86_64',
>                            kernel_path='arch/x86/boot/bzImage',
>                            kernel_command_line='console=ttyS0',
> -                          extra_qemu_params=[''])
> +                          extra_qemu_params=[])
> diff --git a/tools/testing/kunit/qemu_configs/powerpc.py b/tools/testing/kunit/qemu_configs/powerpc.py
> index 35e9de24f0db..6c901149726b 100644
> --- a/tools/testing/kunit/qemu_configs/powerpc.py
> +++ b/tools/testing/kunit/qemu_configs/powerpc.py
> @@ -9,4 +9,4 @@ CONFIG_HVC_CONSOLE=y''',
>                            qemu_arch='ppc64',
>                            kernel_path='vmlinux',
>                            kernel_command_line='console=ttyS0',
> -                          extra_qemu_params=['-M pseries', '-cpu power8'])
> +                          extra_qemu_params=['-M', ' pseries', '-cpu', 'power8'])

This should be '-M', 'pseries', not '-M', ' pseries', (you left an
extra space in.

Note this actually breaks QEMU on my machine.

> diff --git a/tools/testing/kunit/qemu_configs/riscv.py b/tools/testing/kunit/qemu_configs/riscv.py
> index 9e528087cd7c..b882fde39435 100644
> --- a/tools/testing/kunit/qemu_configs/riscv.py
> +++ b/tools/testing/kunit/qemu_configs/riscv.py
> @@ -26,6 +26,6 @@ CONFIG_SERIAL_EARLYCON_RISCV_SBI=y''',
>                            kernel_path='arch/riscv/boot/Image',
>                            kernel_command_line='console=ttyS0',
>                            extra_qemu_params=[
> -                                          '-machine virt',
> -                                          '-cpu rv64',
> -                                          '-bios opensbi-riscv64-generic-fw_dynamic.bin'])
> +                                          '-machine', 'virt',
> +                                          '-cpu', 'rv64',
> +                                          '-bios', 'opensbi-riscv64-generic-fw_dynamic.bin'])
> diff --git a/tools/testing/kunit/qemu_configs/s390.py b/tools/testing/kunit/qemu_configs/s390.py
> index e310bd521113..98fa4fb60c0a 100644
> --- a/tools/testing/kunit/qemu_configs/s390.py
> +++ b/tools/testing/kunit/qemu_configs/s390.py
> @@ -10,5 +10,5 @@ CONFIG_MODULES=y''',
>                            kernel_path='arch/s390/boot/bzImage',
>                            kernel_command_line='console=ttyS0',
>                            extra_qemu_params=[
> -                                          '-machine s390-ccw-virtio',
> -                                          '-cpu qemu',])
> +                                          '-machine', 's390-ccw-virtio',
> +                                          '-cpu', 'qemu',])
> diff --git a/tools/testing/kunit/qemu_configs/sparc.py b/tools/testing/kunit/qemu_configs/sparc.py
> index 27f474e7ad6e..e975c4331a7c 100644
> --- a/tools/testing/kunit/qemu_configs/sparc.py
> +++ b/tools/testing/kunit/qemu_configs/sparc.py
> @@ -7,4 +7,4 @@ CONFIG_SERIAL_8250_CONSOLE=y''',
>                            qemu_arch='sparc',
>                            kernel_path='arch/sparc/boot/zImage',
>                            kernel_command_line='console=ttyS0 mem=256M',
> -                          extra_qemu_params=['-m 256'])
> +                          extra_qemu_params=['-m', '256'])
> diff --git a/tools/testing/kunit/qemu_configs/x86_64.py b/tools/testing/kunit/qemu_configs/x86_64.py
> index 77ab1aeee8a3..dc7949076863 100644
> --- a/tools/testing/kunit/qemu_configs/x86_64.py
> +++ b/tools/testing/kunit/qemu_configs/x86_64.py
> @@ -7,4 +7,4 @@ CONFIG_SERIAL_8250_CONSOLE=y''',
>                            qemu_arch='x86_64',
>                            kernel_path='arch/x86/boot/bzImage',
>                            kernel_command_line='console=ttyS0',
> -                          extra_qemu_params=[''])
> +                          extra_qemu_params=[])
>
> base-commit: 59729170afcd4900e08997a482467ffda8d88c7f
> --
> 2.36.0.rc0.470.gd361397f0d-goog
>
