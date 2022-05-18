Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B0B52B3F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 09:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiERHnx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 03:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiERHnw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 03:43:52 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3CB646E
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 00:43:48 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m2-20020a1ca302000000b003943bc63f98so552559wme.4
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 00:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2HTxvo1kk2tFZF8qxCKrxGn1kKfuDGsgIu3o9brtrrM=;
        b=sBO3h8jE+avzr3bgpvys3cSiHWFd9iMk3i+qcpKqcqUn7Nn19qhCDm5AsvjWF/Q/P8
         kF+iS7Gz5TIy3N7nrh+3PYEzQUvIPJrSdTOaL3dJLUZhUkhFJyRYpRRuf68h5G3V7sQE
         fiNSwDPGxtfTXYzr+0L9JRszvW5ZBazCYW1s+S5OFTr4LkNJfMsr5VXV1iicuc6GuuAo
         z7T97WgDwN4fbdkwg7QkSCnmaZtBdjIMLpDTf/ECKNO46BYY0TnyejTKQ5+IbZ9qwBHM
         aByO2QpZFLXcStrC9sPnDIJ9aUXbBc7+0yJ6p0vIlBRGGHNulYCJLJVq6SwPyEC3a4YO
         m9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2HTxvo1kk2tFZF8qxCKrxGn1kKfuDGsgIu3o9brtrrM=;
        b=x23JX1mpslPX62SJfNbQ3Wkl5VOD+pvf/HAm4/+ioteJWLvxWtF59guTX6TnxdnOBt
         C4hju2ON8qndNS7XI/bY70uLJ2Uib/GM9LoA27Ix9MTrDY5cKlrvr0rZsXbTyyn8Mjxv
         71PQUEFSUSp9k0IWm9RX3L/sm1LhBjv8o7JpGPqJ4ddvNW5KdAAcsn4oeXJQIqsBF9M0
         yW0r1lFVP8Mtp/qqNXNGYqBZBUS1V4PLbVWS+pvFh2meU4Pp/lYiMPZ43UBo5TUv4ewy
         owriSMqkomdXXEuHIuN72T9E3QK7z0xYIfjJQSG+q/w/YtcqGsHJm1PcVCipKM9TJUGP
         nm2g==
X-Gm-Message-State: AOAM532oVaC5BrLKP1wv57kIvLk/eYd0U7Pfbvbi7gYU3YBeXrt8PAIm
        L8uSpjeOM9/vRm7vqXyVL83qUqSIXMluIb2Y7jckwg==
X-Google-Smtp-Source: ABdhPJxIHiugBvlwUCj64OAskvBu2AUMK9BnEh2e/D4SpnN6AOM8/2aK2DspwwNzxiximph9SeXVP2epflSJdfbMfp0=
X-Received: by 2002:a05:600c:1f08:b0:394:9060:bb54 with SMTP id
 bd8-20020a05600c1f0800b003949060bb54mr24868499wmb.73.1652859826622; Wed, 18
 May 2022 00:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220516194730.1546328-1-dlatypov@google.com> <20220516194730.1546328-2-dlatypov@google.com>
In-Reply-To: <20220516194730.1546328-2-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 18 May 2022 15:43:35 +0800
Message-ID: <CABVgOSn05eGd6mprJk+=czo4os-SSpNZkyqBWzQ+5V8DGaeFQA@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: tool: redo how we construct and mock LinuxSourceTree
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 17, 2022 at 3:48 AM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Our main function currently has an optional `linux` argument which is
> used to by our unit tests to inject a mock.
> We currently have the same code copy-pasted several times to do
>   if not linux:
>     linux = MakeRealInstance(cli_args.foo, cli_args.bar, ...)
>
> But in python, dependency injection isn't necessary or idiomatic when we
> can just use mock.patch() to mock things out.
>
> This change
> 1. adds a helper to create a LinuxSourceTree from the cli_args
> 2. drops the `linux` parameter in favor of mocking the __init__ func.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

This is much cleaner, thanks.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/kunit.py           |  49 ++++--------
>  tools/testing/kunit/kunit_tool_test.py | 103 ++++++++++++-------------
>  2 files changed, 65 insertions(+), 87 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 13bd72e47da8..8a90d80ee66e 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -365,7 +365,18 @@ def add_parse_opts(parser) -> None:
>                             'filename is specified',
>                             type=str, const='stdout', default=None, metavar='FILE')
>
> -def main(argv, linux=None):
> +
> +def tree_from_args(cli_args: argparse.Namespace) -> kunit_kernel.LinuxSourceTree:
> +       """Returns a LinuxSourceTree based on the user's arguments."""
> +       return kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> +                       kunitconfig_path=cli_args.kunitconfig,
> +                       kconfig_add=cli_args.kconfig_add,
> +                       arch=cli_args.arch,
> +                       cross_compile=cli_args.cross_compile,
> +                       qemu_config_path=cli_args.qemu_config)
> +
> +
> +def main(argv):
>         parser = argparse.ArgumentParser(
>                         description='Helps writing and running KUnit tests.')
>         subparser = parser.add_subparsers(dest='subcommand')
> @@ -412,14 +423,7 @@ def main(argv, linux=None):
>                 if not os.path.exists(cli_args.build_dir):
>                         os.mkdir(cli_args.build_dir)
>
> -               if not linux:
> -                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> -                                       kunitconfig_path=cli_args.kunitconfig,
> -                                       kconfig_add=cli_args.kconfig_add,
> -                                       arch=cli_args.arch,
> -                                       cross_compile=cli_args.cross_compile,
> -                                       qemu_config_path=cli_args.qemu_config)
> -
> +               linux = tree_from_args(cli_args)
>                 request = KunitRequest(build_dir=cli_args.build_dir,
>                                        make_options=cli_args.make_options,
>                                        jobs=cli_args.jobs,
> @@ -438,14 +442,7 @@ def main(argv, linux=None):
>                                 not os.path.exists(cli_args.build_dir)):
>                         os.mkdir(cli_args.build_dir)
>
> -               if not linux:
> -                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> -                                       kunitconfig_path=cli_args.kunitconfig,
> -                                       kconfig_add=cli_args.kconfig_add,
> -                                       arch=cli_args.arch,
> -                                       cross_compile=cli_args.cross_compile,
> -                                       qemu_config_path=cli_args.qemu_config)
> -
> +               linux = tree_from_args(cli_args)
>                 request = KunitConfigRequest(build_dir=cli_args.build_dir,
>                                              make_options=cli_args.make_options)
>                 result = config_tests(linux, request)
> @@ -455,14 +452,7 @@ def main(argv, linux=None):
>                 if result.status != KunitStatus.SUCCESS:
>                         sys.exit(1)
>         elif cli_args.subcommand == 'build':
> -               if not linux:
> -                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> -                                       kunitconfig_path=cli_args.kunitconfig,
> -                                       kconfig_add=cli_args.kconfig_add,
> -                                       arch=cli_args.arch,
> -                                       cross_compile=cli_args.cross_compile,
> -                                       qemu_config_path=cli_args.qemu_config)
> -
> +               linux = tree_from_args(cli_args)
>                 request = KunitBuildRequest(build_dir=cli_args.build_dir,
>                                             make_options=cli_args.make_options,
>                                             jobs=cli_args.jobs,
> @@ -474,14 +464,7 @@ def main(argv, linux=None):
>                 if result.status != KunitStatus.SUCCESS:
>                         sys.exit(1)
>         elif cli_args.subcommand == 'exec':
> -               if not linux:
> -                       linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> -                                       kunitconfig_path=cli_args.kunitconfig,
> -                                       kconfig_add=cli_args.kconfig_add,
> -                                       arch=cli_args.arch,
> -                                       cross_compile=cli_args.cross_compile,
> -                                       qemu_config_path=cli_args.qemu_config)
> -
> +               linux = tree_from_args(cli_args)
>                 exec_request = KunitExecRequest(raw_output=cli_args.raw_output,
>                                                 build_dir=cli_args.build_dir,
>                                                 json=cli_args.json,
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index b9158017ece6..baee11d96474 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -503,24 +503,25 @@ class KUnitMainTest(unittest.TestCase):
>                 self.print_mock = mock.patch('builtins.print').start()
>                 self.addCleanup(mock.patch.stopall)
>
> -               self.linux_source_mock = mock.Mock()
> -               self.linux_source_mock.build_reconfig = mock.Mock(return_value=True)
> -               self.linux_source_mock.build_kernel = mock.Mock(return_value=True)
> -               self.linux_source_mock.run_kernel = mock.Mock(return_value=all_passed_log)
> +               self.mock_linux_init = mock.patch.object(kunit_kernel, 'LinuxSourceTree').start()
> +               self.linux_source_mock = self.mock_linux_init.return_value
> +               self.linux_source_mock.build_reconfig.return_value = True
> +               self.linux_source_mock.build_kernel.return_value = True
> +               self.linux_source_mock.run_kernel.return_value = all_passed_log
>
>         def test_config_passes_args_pass(self):
> -               kunit.main(['config', '--build_dir=.kunit'], self.linux_source_mock)
> +               kunit.main(['config', '--build_dir=.kunit'])
>                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
>                 self.assertEqual(self.linux_source_mock.run_kernel.call_count, 0)
>
>         def test_build_passes_args_pass(self):
> -               kunit.main(['build'], self.linux_source_mock)
> +               kunit.main(['build'])
>                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
>                 self.linux_source_mock.build_kernel.assert_called_once_with(False, kunit.get_default_jobs(), '.kunit', None)
>                 self.assertEqual(self.linux_source_mock.run_kernel.call_count, 0)
>
>         def test_exec_passes_args_pass(self):
> -               kunit.main(['exec'], self.linux_source_mock)
> +               kunit.main(['exec'])
>                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 0)
>                 self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
> @@ -528,7 +529,7 @@ class KUnitMainTest(unittest.TestCase):
>                 self.print_mock.assert_any_call(StrContains('Testing complete.'))
>
>         def test_run_passes_args_pass(self):
> -               kunit.main(['run'], self.linux_source_mock)
> +               kunit.main(['run'])
>                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
>                 self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
> @@ -538,13 +539,13 @@ class KUnitMainTest(unittest.TestCase):
>         def test_exec_passes_args_fail(self):
>                 self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
>                 with self.assertRaises(SystemExit) as e:
> -                       kunit.main(['exec'], self.linux_source_mock)
> +                       kunit.main(['exec'])
>                 self.assertEqual(e.exception.code, 1)
>
>         def test_run_passes_args_fail(self):
>                 self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
>                 with self.assertRaises(SystemExit) as e:
> -                       kunit.main(['run'], self.linux_source_mock)
> +                       kunit.main(['run'])
>                 self.assertEqual(e.exception.code, 1)
>                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
>                 self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
> @@ -553,7 +554,7 @@ class KUnitMainTest(unittest.TestCase):
>         def test_exec_no_tests(self):
>                 self.linux_source_mock.run_kernel = mock.Mock(return_value=['TAP version 14', '1..0'])
>                 with self.assertRaises(SystemExit) as e:
> -                       kunit.main(['run'], self.linux_source_mock)
> +                       kunit.main(['run'])
>                 self.assertEqual(e.exception.code, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
>                         args=None, build_dir='.kunit', filter_glob='', timeout=300)
> @@ -561,7 +562,7 @@ class KUnitMainTest(unittest.TestCase):
>
>         def test_exec_raw_output(self):
>                 self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
> -               kunit.main(['exec', '--raw_output'], self.linux_source_mock)
> +               kunit.main(['exec', '--raw_output'])
>                 self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
>                 for call in self.print_mock.call_args_list:
>                         self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
> @@ -569,7 +570,7 @@ class KUnitMainTest(unittest.TestCase):
>
>         def test_run_raw_output(self):
>                 self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
> -               kunit.main(['run', '--raw_output'], self.linux_source_mock)
> +               kunit.main(['run', '--raw_output'])
>                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
>                 self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
>                 for call in self.print_mock.call_args_list:
> @@ -578,7 +579,7 @@ class KUnitMainTest(unittest.TestCase):
>
>         def test_run_raw_output_kunit(self):
>                 self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
> -               kunit.main(['run', '--raw_output=kunit'], self.linux_source_mock)
> +               kunit.main(['run', '--raw_output=kunit'])
>                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
>                 self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
>                 for call in self.print_mock.call_args_list:
> @@ -588,27 +589,27 @@ class KUnitMainTest(unittest.TestCase):
>         def test_run_raw_output_invalid(self):
>                 self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
>                 with self.assertRaises(SystemExit) as e:
> -                       kunit.main(['run', '--raw_output=invalid'], self.linux_source_mock)
> +                       kunit.main(['run', '--raw_output=invalid'])
>                 self.assertNotEqual(e.exception.code, 0)
>
>         def test_run_raw_output_does_not_take_positional_args(self):
>                 # --raw_output is a string flag, but we don't want it to consume
>                 # any positional arguments, only ones after an '='
>                 self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
> -               kunit.main(['run', '--raw_output', 'filter_glob'], self.linux_source_mock)
> +               kunit.main(['run', '--raw_output', 'filter_glob'])
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
>                         args=None, build_dir='.kunit', filter_glob='filter_glob', timeout=300)
>
>         def test_exec_timeout(self):
>                 timeout = 3453
> -               kunit.main(['exec', '--timeout', str(timeout)], self.linux_source_mock)
> +               kunit.main(['exec', '--timeout', str(timeout)])
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
>                         args=None, build_dir='.kunit', filter_glob='', timeout=timeout)
>                 self.print_mock.assert_any_call(StrContains('Testing complete.'))
>
>         def test_run_timeout(self):
>                 timeout = 3453
> -               kunit.main(['run', '--timeout', str(timeout)], self.linux_source_mock)
> +               kunit.main(['run', '--timeout', str(timeout)])
>                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
>                         args=None, build_dir='.kunit', filter_glob='', timeout=timeout)
> @@ -616,7 +617,7 @@ class KUnitMainTest(unittest.TestCase):
>
>         def test_run_builddir(self):
>                 build_dir = '.kunit'
> -               kunit.main(['run', '--build_dir=.kunit'], self.linux_source_mock)
> +               kunit.main(['run', '--build_dir=.kunit'])
>                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
>                         args=None, build_dir=build_dir, filter_glob='', timeout=300)
> @@ -624,60 +625,54 @@ class KUnitMainTest(unittest.TestCase):
>
>         def test_config_builddir(self):
>                 build_dir = '.kunit'
> -               kunit.main(['config', '--build_dir', build_dir], self.linux_source_mock)
> +               kunit.main(['config', '--build_dir', build_dir])
>                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
>
>         def test_build_builddir(self):
>                 build_dir = '.kunit'
>                 jobs = kunit.get_default_jobs()
> -               kunit.main(['build', '--build_dir', build_dir], self.linux_source_mock)
> +               kunit.main(['build', '--build_dir', build_dir])
>                 self.linux_source_mock.build_kernel.assert_called_once_with(False, jobs, build_dir, None)
>
>         def test_exec_builddir(self):
>                 build_dir = '.kunit'
> -               kunit.main(['exec', '--build_dir', build_dir], self.linux_source_mock)
> +               kunit.main(['exec', '--build_dir', build_dir])
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
>                         args=None, build_dir=build_dir, filter_glob='', timeout=300)
>                 self.print_mock.assert_any_call(StrContains('Testing complete.'))
>
> -       @mock.patch.object(kunit_kernel, 'LinuxSourceTree')
> -       def test_run_kunitconfig(self, mock_linux_init):
> -               mock_linux_init.return_value = self.linux_source_mock
> +       def test_run_kunitconfig(self):
>                 kunit.main(['run', '--kunitconfig=mykunitconfig'])
>                 # Just verify that we parsed and initialized it correctly here.
> -               mock_linux_init.assert_called_once_with('.kunit',
> -                                                       kunitconfig_path='mykunitconfig',
> -                                                       kconfig_add=None,
> -                                                       arch='um',
> -                                                       cross_compile=None,
> -                                                       qemu_config_path=None)
> -
> -       @mock.patch.object(kunit_kernel, 'LinuxSourceTree')
> -       def test_config_kunitconfig(self, mock_linux_init):
> -               mock_linux_init.return_value = self.linux_source_mock
> +               self.mock_linux_init.assert_called_once_with('.kunit',
> +                                               kunitconfig_path='mykunitconfig',
> +                                               kconfig_add=None,
> +                                               arch='um',
> +                                               cross_compile=None,
> +                                               qemu_config_path=None)
> +
> +       def test_config_kunitconfig(self):
>                 kunit.main(['config', '--kunitconfig=mykunitconfig'])
>                 # Just verify that we parsed and initialized it correctly here.
> -               mock_linux_init.assert_called_once_with('.kunit',
> -                                                       kunitconfig_path='mykunitconfig',
> -                                                       kconfig_add=None,
> -                                                       arch='um',
> -                                                       cross_compile=None,
> -                                                       qemu_config_path=None)
> -
> -       @mock.patch.object(kunit_kernel, 'LinuxSourceTree')
> -       def test_run_kconfig_add(self, mock_linux_init):
> -               mock_linux_init.return_value = self.linux_source_mock
> +               self.mock_linux_init.assert_called_once_with('.kunit',
> +                                               kunitconfig_path='mykunitconfig',
> +                                               kconfig_add=None,
> +                                               arch='um',
> +                                               cross_compile=None,
> +                                               qemu_config_path=None)
> +
> +       def test_run_kconfig_add(self):
>                 kunit.main(['run', '--kconfig_add=CONFIG_KASAN=y', '--kconfig_add=CONFIG_KCSAN=y'])
>                 # Just verify that we parsed and initialized it correctly here.
> -               mock_linux_init.assert_called_once_with('.kunit',
> -                                                       kunitconfig_path=None,
> -                                                       kconfig_add=['CONFIG_KASAN=y', 'CONFIG_KCSAN=y'],
> -                                                       arch='um',
> -                                                       cross_compile=None,
> -                                                       qemu_config_path=None)
> +               self.mock_linux_init.assert_called_once_with('.kunit',
> +                                               kunitconfig_path=None,
> +                                               kconfig_add=['CONFIG_KASAN=y', 'CONFIG_KCSAN=y'],
> +                                               arch='um',
> +                                               cross_compile=None,
> +                                               qemu_config_path=None)
>
>         def test_run_kernel_args(self):
> -               kunit.main(['run', '--kernel_args=a=1', '--kernel_args=b=2'], self.linux_source_mock)
> +               kunit.main(['run', '--kernel_args=a=1', '--kernel_args=b=2'])
>                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
>                       args=['a=1','b=2'], build_dir='.kunit', filter_glob='', timeout=300)
> @@ -699,7 +694,7 @@ class KUnitMainTest(unittest.TestCase):
>         @mock.patch.object(kunit, '_list_tests')
>         def test_run_isolated_by_suite(self, mock_tests):
>                 mock_tests.return_value = ['suite.test1', 'suite.test2', 'suite2.test1']
> -               kunit.main(['exec', '--run_isolated=suite', 'suite*.test*'], self.linux_source_mock)
> +               kunit.main(['exec', '--run_isolated=suite', 'suite*.test*'])
>
>                 # Should respect the user's filter glob when listing tests.
>                 mock_tests.assert_called_once_with(mock.ANY,
> @@ -712,7 +707,7 @@ class KUnitMainTest(unittest.TestCase):
>         @mock.patch.object(kunit, '_list_tests')
>         def test_run_isolated_by_test(self, mock_tests):
>                 mock_tests.return_value = ['suite.test1', 'suite.test2', 'suite2.test1']
> -               kunit.main(['exec', '--run_isolated=test', 'suite*'], self.linux_source_mock)
> +               kunit.main(['exec', '--run_isolated=test', 'suite*'])
>
>                 # Should respect the user's filter glob when listing tests.
>                 mock_tests.assert_called_once_with(mock.ANY,
> --
> 2.36.1.124.g0e6072fb45-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220516194730.1546328-2-dlatypov%40google.com.
