Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026F53085EA
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Jan 2021 07:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhA2GfJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Jan 2021 01:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbhA2GeH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Jan 2021 01:34:07 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB03C061574
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Jan 2021 22:33:26 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id h7so11004096lfc.6
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Jan 2021 22:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MtLkYMuRmxB6MJaILElvuKaD5giM9yGaN3cva3cz1IY=;
        b=qBWjM7pwDDtCVOvC3PcV+zb2Kova9HNV/xBm7ugYebcvc1UmvGXCAQUYv6rn24fiBX
         9rqLN/By7Vc92s/959tocE7xe/ExTRx5hk0kVP4s+Lj+5DTf6nOs2855oA18p/r3Bdtc
         tpcTeAjS0sXRPYPpgywVrWc1brO7Y0QLSrcDP97//83/kMqGpB8x9gIRTZ2A3+tpwbMa
         AJ344rZqOlbtzhgvV/mqlyJAgZlHVEzllNY+UFlchqZukMMb3TFnZ1IAzvZXk4vBeS7Y
         JiVqLybCGC3NebmxGd9GyilCJbeVWyzyUsp/17UCV5I1defyOO+cBIcEn2Df5PiJ8W33
         AlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MtLkYMuRmxB6MJaILElvuKaD5giM9yGaN3cva3cz1IY=;
        b=R/LkvjZ6vedcfEDP/HXIVFz6HoPR8Oiew++k9e21XSYzV5RfWeWfGO+kFx+CfpcR4V
         29BEFDGSBZiOHDhbWvGaIqaQrb5po5IC5nRJsBGul/8l2oF6LXOKeKBIYbmv52dcfdUi
         qG8XqpKhUSjDuQ90foLcHpKMRZa53JDqvne67dMgJLF4TjfNGsm+UMHWqkjxL/wGWWGd
         mZauhe+EH9FWdNOACAF2ohoFYjhtcPCbdRtr0aG92ETZwvpXd3RqRGhMybsamG6jn8rt
         CVCFGSC8DARiMN+ywUGC4IJyxX/o4YcE+oZED3Vp706TgDjICzVHrOj4qa5hRUwFnryK
         QIyA==
X-Gm-Message-State: AOAM533AWkq5MZ7Rej2QQv20Q1GNsQlqgiJLFYnQN3CycyVYs7MQaKTR
        vQo0ZYATvqzHprzVYNqo6djIBczJcZthEVt5pkzAgg==
X-Google-Smtp-Source: ABdhPJx6PY9lXl2+/4eClbTud9+pmveaoe+s0oX505s39i3QMK7rAuNjK8MB5EOZ42a3aPDguskGqbBs0V4/+kW8q0c=
X-Received: by 2002:a19:c20b:: with SMTP id l11mr1321295lfc.47.1611902005080;
 Thu, 28 Jan 2021 22:33:25 -0800 (PST)
MIME-Version: 1.0
References: <20210123001743.1379894-1-dlatypov@google.com>
In-Reply-To: <20210123001743.1379894-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 29 Jan 2021 14:33:12 +0800
Message-ID: <CABVgOSkksFz62F4fGeCd8hO_hHPDaQ5AB=VRo9tSWVdrE=nPow@mail.gmail.com>
Subject: Re: [PATCH] kunit: make kunit_tool accept optional path to
 .kunitconfig fragment
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jan 23, 2021 at 8:17 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently running tests via KUnit tool means tweaking a .kunitconfig
> file, which you'd keep around locally and never commit.
> This changes makes it so users can pass in a path to a kunitconfig.
>
> One of the imagined use cases is having kunitconfig fragments in-tree
> to formalize interesting sets of tests for features/subsystems, e.g.
>   $ ./tools/testing/kunit/kunit.py run fs/ext4/kunitconfig
>
> For now, this hypothetical fs/ext4/kunitconfig would contain
>   CONFIG_KUNIT=y
>   CONFIG_EXT4_FS=y
>   CONFIG_EXT4_KUNIT_TESTS=y
>
> At the moment, it's not hard to manually whip up this file, but as more
> and more tests get added, this will get tedious.
>
> It also opens the door to documenting how to run all the tests relevant
> to a specific subsystem or feature as a simple one-liner.
>
> This can be seen as an analogue to tools/testing/selftests/*/config
> But in the case of KUnit, the tests live in the same directory as the
> code-under-test, so it feels more natural to allow the kunitconfig
> fragments to live anywhere. (Though, people could create a separate
> directory if wanted; this patch imposes no restrictions on the path).
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Really glad this is finally happening. I tried it out, and it seemed
to work pretty well.

I was wondering whether a positional argument like this was best, or
whether it'd be better to have an explicitly named argument
(--kunitconfig=path). Thinking about it though, I'm quite happy with
having this as-is: the only real other contender for a coveted
positional argument spot would've been the name of a test or test
suite (e.g., kunit.py run ext4_inode_test), and that's not really
possible with the kunit_tool architecture as-is.

One other comment below (should this work for kunit.py config?),
otherwise it looks good.

-- David

>  tools/testing/kunit/kunit.py           |  9 ++++++---
>  tools/testing/kunit/kunit_kernel.py    | 12 ++++++++----
>  tools/testing/kunit/kunit_tool_test.py | 25 +++++++++++++++++++++++++
>  3 files changed, 39 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index e808a47c839b..3204a23bd16e 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -188,6 +188,9 @@ def add_build_opts(parser) -> None:
>                             help='As in the make command, "Specifies  the number of '
>                             'jobs (commands) to run simultaneously."',
>                             type=int, default=8, metavar='jobs')
> +       parser.add_argument('kunitconfig',
> +                            help='Path to Kconfig fragment that enables KUnit tests',
> +                            type=str, nargs='?', metavar='kunitconfig')
>

Should this maybe be in add_common_opts()? I'd assume that we want
kunit.py config to accept this custom kunitconfig path as well.

>  def add_exec_opts(parser) -> None:
>         parser.add_argument('--timeout',
> @@ -256,7 +259,7 @@ def main(argv, linux=None):
>                         os.mkdir(cli_args.build_dir)
>
>                 if not linux:
> -                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
> +                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir, kunitconfig_path=cli_args.kunitconfig)
>
>                 request = KunitRequest(cli_args.raw_output,
>                                        cli_args.timeout,
> @@ -274,7 +277,7 @@ def main(argv, linux=None):
>                         os.mkdir(cli_args.build_dir)
>
>                 if not linux:
> -                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
> +                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir, kunitconfig_path=cli_args.kunitconfig)
>
>                 request = KunitConfigRequest(cli_args.build_dir,
>                                              cli_args.make_options)
> @@ -286,7 +289,7 @@ def main(argv, linux=None):
>                         sys.exit(1)
>         elif cli_args.subcommand == 'build':
>                 if not linux:
> -                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
> +                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir, kunitconfig_path=cli_args.kunitconfig)
>
>                 request = KunitBuildRequest(cli_args.jobs,
>                                             cli_args.build_dir,
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 2076a5a2d060..0b461663e7d9 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -123,7 +123,7 @@ def get_outfile_path(build_dir) -> str:
>  class LinuxSourceTree(object):
>         """Represents a Linux kernel source tree with KUnit tests."""
>
> -       def __init__(self, build_dir: str, load_config=True, defconfig=DEFAULT_KUNITCONFIG_PATH) -> None:
> +       def __init__(self, build_dir: str, load_config=True, kunitconfig_path='') -> None:
>                 signal.signal(signal.SIGINT, self.signal_handler)
>
>                 self._ops = LinuxSourceTreeOperations()
> @@ -131,9 +131,13 @@ class LinuxSourceTree(object):
>                 if not load_config:
>                         return
>
> -               kunitconfig_path = get_kunitconfig_path(build_dir)
> -               if not os.path.exists(kunitconfig_path):
> -                       shutil.copyfile(defconfig, kunitconfig_path)
> +               if kunitconfig_path:
> +                       if not os.path.exists(kunitconfig_path):
> +                               raise ConfigError(f'Specified kunitconfig ({kunitconfig_path}) does not exist')
> +               else:
> +                       kunitconfig_path = get_kunitconfig_path(build_dir)
> +                       if not os.path.exists(kunitconfig_path):
> +                               shutil.copyfile(DEFAULT_KUNITCONFIG_PATH, kunitconfig_path)
>
>                 self._kconfig = kunit_config.Kconfig()
>                 self._kconfig.read_from_file(kunitconfig_path)
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index b593f4448e83..533fe41b5123 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -12,6 +12,7 @@ from unittest import mock
>  import tempfile, shutil # Handling test_tmpdir
>
>  import json
> +import signal
>  import os
>
>  import kunit_config
> @@ -250,6 +251,23 @@ class KUnitParserTest(unittest.TestCase):
>                                 result.status)
>                         self.assertEqual('kunit-resource-test', result.suites[0].name)
>
> +class LinuxSourceTreeTest(unittest.TestCase):
> +
> +       def setUp(self):
> +               mock.patch.object(signal, 'signal').start()
> +               self.addCleanup(mock.patch.stopall)
> +
> +       def test_invalid_kunitconfig(self):
> +               with self.assertRaisesRegex(kunit_kernel.ConfigError, 'nonexistent.* does not exist'):
> +                       kunit_kernel.LinuxSourceTree('', kunitconfig_path='/nonexistent_file')
> +
> +       def test_valid_kunitconfig(self):
> +               with tempfile.NamedTemporaryFile('wt') as kunitconfig:
> +                       tree = kunit_kernel.LinuxSourceTree('', kunitconfig_path=kunitconfig.name)
> +
> +       # TODO: add more test cases.
> +
> +
>  class KUnitJsonTest(unittest.TestCase):
>
>         def _json_for(self, log_file):
> @@ -399,5 +417,12 @@ class KUnitMainTest(unittest.TestCase):
>                 self.linux_source_mock.run_kernel.assert_called_once_with(build_dir=build_dir, timeout=300)
>                 self.print_mock.assert_any_call(StrContains('Testing complete.'))
>
> +       @mock.patch.object(kunit_kernel, 'LinuxSourceTree')
> +       def test_run_kunitconfig(self, mock_linux_init):
> +               mock_linux_init.return_value = self.linux_source_mock
> +               kunit.main(['run', 'mykunitconfig'])
> +               # Just verify that we parsed and initialized it correctly here.
> +               mock_linux_init.assert_called_once_with('.kunit', kunitconfig_path='mykunitconfig')
> +
>  if __name__ == '__main__':
>         unittest.main()
>
> base-commit: 2b8fdbbf1c616300312f71fe5b21fe8f03129950
> --
> 2.30.0.280.ga3ce27912f-goog
>
