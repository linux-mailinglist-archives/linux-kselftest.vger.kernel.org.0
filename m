Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32D7446C4C
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Nov 2021 05:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhKFEJx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 6 Nov 2021 00:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhKFEJv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 6 Nov 2021 00:09:51 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541D2C061570
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Nov 2021 21:07:10 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 133so8688194wme.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Nov 2021 21:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rzyrOrH95MGAa/Xb2wtK18TKgOiah8NZUk7288mGLbk=;
        b=AjtsM3Dfda6lwb67+jWFgQj04f7+76UtqIxnYJUO8cY/vF3RuRn/W/5P/kABG3VHa7
         aidAwrnPOZ4A2HUgBHiGPTXExCBlMsAJ8Ty2XSr02P1H2DcHdEEW+s8B0ByFrerGuLxQ
         qkWgu7S9lAOd8+GirFVAvF+Avej32ES8mRFjs0oEbJYu49hLPR1U3n1/5OH0ovIOVl1n
         Lyy2QPlLLOlGeTkUulhZ+P40oNbm+RYitd52a4lqdRBVgC88vyphyaJfZ7h8NnoQENxW
         V81lVqVlHe5YuDE3+xgswef6Flm3ccI9OE0zVGP7GdGX5Q44YOa1Btob76FPQgl2Iddk
         C08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzyrOrH95MGAa/Xb2wtK18TKgOiah8NZUk7288mGLbk=;
        b=qb0ClppAEOrLNSfdtjUK3KEBy9RWAlsIFqN5BwlBos2T+E0XfrRTQRZ0RluS7kva4s
         arMzfqnUnSgSDPyafSamwwoIHr3tVO4shVIcU8fW422jANON5JiFe4Vc4go1xIshHXuV
         ojhBlQkZ5x/8PYhb8EoYG9FdEY1WQghcqjQwzlepqDGd6zz9q8DyFe9YWz+/2+flJOOc
         V7B9wgqdJqQGtoCuXrzGHuf/YZ+VJuVS/U98kHgFxuona/uOsDf9mqz5Boc4WFpczRln
         zMMGMkqLX+lVcPcT92fX6MNtZDEX4/cd34gClQ+RJPVc3K2RVHeRtcyCzShp07P/o9Bp
         vkfA==
X-Gm-Message-State: AOAM532JLJ5FGiZgx3JGQoqLcW3VZB6klSIVbFQ7nRVKogjhZ3AkhDIh
        DJpZpbf8rf60RZ2nQaS1tWWRv+IEk6RPDDClPvo2MZYMK30=
X-Google-Smtp-Source: ABdhPJw1yoX+ysGxdnypwYPWF0gLy1GCWIJim895Q3U5HbRv6csvaSJSKdZoBfJQ1MudTiYpxP11IyUpxvrbKk3JQOA=
X-Received: by 2002:a05:600c:4ed2:: with SMTP id g18mr24191580wmq.18.1636171628680;
 Fri, 05 Nov 2021 21:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211106013058.2621799-1-dlatypov@google.com> <20211106013058.2621799-2-dlatypov@google.com>
In-Reply-To: <20211106013058.2621799-2-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 6 Nov 2021 12:06:57 +0800
Message-ID: <CABVgOSnQ9qGtu0nEKePH+Zb1oR2osmVh791zyQ9P61SNznryrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: tool: add --kconfig_add to allow easily
 tweaking kunitconfigs
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Nov 6, 2021 at 9:31 AM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> E.g. run tests but with KASAN
> $ ./tools/testing/kunit/kunit.py run --arch=x86_64 --kconfig_add=CONFIG_KASAN=y

This is very neat, thank you. I'm definitely going to use this quite a bit.

My only real note is that we'll need to add some documentation (but
since the KUnit documentation is being reworked at the moment, I'm
okay with doing that later to avoid merge conflicts).

> This also works with --kunitconfig
> $ ./tools/testing/kunit/kunit.py run --arch=x86_64 --kunitconfig=fs/ext4 --kconfig_add=CONFIG_KASAN=y

It's also worth noting that this can be appended multiple times to set
multiple options, which is useful

> This flag is inspired by TuxMake's --kconfig-add, see
> https://gitlab.com/Linaro/tuxmake#examples.
>
> Our version just uses "_" as the delimiter for consistency with
> pre-existing flags like --build_dir, --make_options, --kernel_args, etc.
>
> Note: this does make it easier to run into a pre-existing edge case:
> $ ./tools/testing/kunit/kunit.py run --arch=x86_64 --kconfig_add=CONFIG_KASAN=y
> $ ./tools/testing/kunit/kunit.py run --arch=x86_64
> This second invocation ^ still has KASAN enabled!

This behaviour is quite useful, and actually means we can turn on
individual items with
$ ./tools/testing/kunit/kunit.py config --kconfig_add=<option>

> kunit.py won't call olddefconfig if our current .config is already a
> superset of the provided kunitconfig.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Looks good.

Reviewed-by: David Gow <davidgow@google.com>


> ---
>  tools/testing/kunit/kunit.py           |  8 ++++++++
>  tools/testing/kunit/kunit_kernel.py    |  5 +++++
>  tools/testing/kunit/kunit_tool_test.py | 18 ++++++++++++++++++
>  3 files changed, 31 insertions(+)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 68e6f461c758..be58f4c93806 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -280,6 +280,10 @@ def add_common_opts(parser) -> None:
>                              ' If given a directory, (e.g. lib/kunit), "/.kunitconfig" '
>                              'will get  automatically appended.',
>                              metavar='kunitconfig')
> +       parser.add_argument('--kconfig_add',
> +                            help='Additional Kconfig options to append to the '
> +                            '.kunitconfig, e.g. CONFIG_KASAN=y. Can be repeated.',
> +                           action='append')
>
>         parser.add_argument('--arch',
>                             help=('Specifies the architecture to run tests under. '
> @@ -398,6 +402,7 @@ def main(argv, linux=None):
>                 if not linux:
>                         linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
>                                         kunitconfig_path=cli_args.kunitconfig,
> +                                       kconfig_add=cli_args.kconfig_add,
>                                         arch=cli_args.arch,
>                                         cross_compile=cli_args.cross_compile,
>                                         qemu_config_path=cli_args.qemu_config)
> @@ -423,6 +428,7 @@ def main(argv, linux=None):
>                 if not linux:
>                         linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
>                                         kunitconfig_path=cli_args.kunitconfig,
> +                                       kconfig_add=cli_args.kconfig_add,
>                                         arch=cli_args.arch,
>                                         cross_compile=cli_args.cross_compile,
>                                         qemu_config_path=cli_args.qemu_config)
> @@ -439,6 +445,7 @@ def main(argv, linux=None):
>                 if not linux:
>                         linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
>                                         kunitconfig_path=cli_args.kunitconfig,
> +                                       kconfig_add=cli_args.kconfig_add,
>                                         arch=cli_args.arch,
>                                         cross_compile=cli_args.cross_compile,
>                                         qemu_config_path=cli_args.qemu_config)
> @@ -457,6 +464,7 @@ def main(argv, linux=None):
>                 if not linux:
>                         linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
>                                         kunitconfig_path=cli_args.kunitconfig,
> +                                       kconfig_add=cli_args.kconfig_add,
>                                         arch=cli_args.arch,
>                                         cross_compile=cli_args.cross_compile,
>                                         qemu_config_path=cli_args.qemu_config)
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 51ee6e5dae91..7d459d6d6ff2 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -224,6 +224,7 @@ class LinuxSourceTree(object):
>               build_dir: str,
>               load_config=True,
>               kunitconfig_path='',
> +             kconfig_add: Optional[List[str]]=None,
>               arch=None,
>               cross_compile=None,
>               qemu_config_path=None) -> None:
> @@ -249,6 +250,10 @@ class LinuxSourceTree(object):
>                                 shutil.copyfile(DEFAULT_KUNITCONFIG_PATH, kunitconfig_path)
>
>                 self._kconfig = kunit_config.parse_file(kunitconfig_path)
> +               if kconfig_add:
> +                       kconfig = kunit_config.parse_from_string('\n'.join(kconfig_add))
> +                       self._kconfig.merge_in_entries(kconfig)
> +
>
>         def clean(self) -> bool:
>                 try:
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 4ec70e41ec5a..7e42a7c27987 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -334,6 +334,10 @@ class LinuxSourceTreeTest(unittest.TestCase):
>                                 pass
>                         kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
>
> +       def test_kconfig_add(self):
> +               tree = kunit_kernel.LinuxSourceTree('', kconfig_add=['CONFIG_NOT_REAL=y'])
> +               self.assertIn(kunit_config.KconfigEntry('NOT_REAL', 'y'), tree._kconfig.entries())
> +
>         def test_invalid_arch(self):
>                 with self.assertRaisesRegex(kunit_kernel.ConfigError, 'not a valid arch, options are.*x86_64'):
>                         kunit_kernel.LinuxSourceTree('', arch='invalid')
> @@ -540,6 +544,7 @@ class KUnitMainTest(unittest.TestCase):
>                 # Just verify that we parsed and initialized it correctly here.
>                 mock_linux_init.assert_called_once_with('.kunit',
>                                                         kunitconfig_path='mykunitconfig',
> +                                                       kconfig_add=None,
>                                                         arch='um',
>                                                         cross_compile=None,
>                                                         qemu_config_path=None)
> @@ -551,6 +556,19 @@ class KUnitMainTest(unittest.TestCase):
>                 # Just verify that we parsed and initialized it correctly here.
>                 mock_linux_init.assert_called_once_with('.kunit',
>                                                         kunitconfig_path='mykunitconfig',
> +                                                       kconfig_add=None,
> +                                                       arch='um',
> +                                                       cross_compile=None,
> +                                                       qemu_config_path=None)
> +
> +       @mock.patch.object(kunit_kernel, 'LinuxSourceTree')
> +       def test_run_kconfig_add(self, mock_linux_init):
> +               mock_linux_init.return_value = self.linux_source_mock
> +               kunit.main(['run', '--kconfig_add=CONFIG_KASAN=y', '--kconfig_add=CONFIG_KCSAN=y'])
> +               # Just verify that we parsed and initialized it correctly here.
> +               mock_linux_init.assert_called_once_with('.kunit',
> +                                                       kunitconfig_path=None,
> +                                                       kconfig_add=['CONFIG_KASAN=y', 'CONFIG_KCSAN=y'],
>                                                         arch='um',
>                                                         cross_compile=None,
>                                                         qemu_config_path=None)
> --
> 2.34.0.rc0.344.g81b53c2807-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20211106013058.2621799-2-dlatypov%40google.com.
