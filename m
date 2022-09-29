Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D44E5EF308
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Sep 2022 12:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbiI2KH5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Sep 2022 06:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbiI2KHz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Sep 2022 06:07:55 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97E813EAE5
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Sep 2022 03:07:53 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id j17so970188vsp.5
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Sep 2022 03:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=BrMQoSol7K6DhOSdulwu9y2PQXXRfDL3A0/GroayiYY=;
        b=Ehe+/nCX8lJ0dofFHMXEXEpxd/b+EVDdR4Fx8q93vnq6DFeVACWdCOy+K+3dg5qIcR
         ocKjzyxrn33sxArHFWrGu3d2d7OhIfmj0QyCkrsOpJYOnJ91n1XjPKI6ve7MApIqzRoi
         tnUlx5/1xAkf6nzBdvtFqxLiUmlGh4FF+uaE7q4qejoRTdigZxbEOkXC8Vu/k6zzFz2Y
         /WaE6Ou0SGSkBlSzBD4gjZyy01MDA21XNgWUuoUocRgLV271of043I2ZLTe9r61GHB5l
         6b0ch9t0kAgJI+6U3/pnuDz0NK4AfZFGp75y4P84ePfe/MIR4JPi+/rsjs0jlKT02/3q
         Clxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=BrMQoSol7K6DhOSdulwu9y2PQXXRfDL3A0/GroayiYY=;
        b=dpZb0Wh35qD6HmFWtcbugi4eWyocRHcFR6uMoK0L3xBRc2r01IOCI98IPE6deQFi2n
         5TW/CH5U0wCnCVnKBxQOO3Bj17wRR+xK9aNlrCQsOiBtzr5tIrXf2e7QkcdUM+4HO+rB
         ybWQ0YEduwHz+fvQz6tz0gX4hZTC0XuaRQtL+xdeHVVFdKlxn+2huZ9ie2itUlN5v3wr
         AeeKTzhLFAspil9BfhSr4yhh5INUoyp9eAhpZgXE7W0XmQysaT/2vA5yNofFeEuaw/lm
         6McrAi5NkiDdziIzWmut/NTNlAvDz7XgDjRfSeprHTCe7dvHf8aZMs8/cUr7sa/VuCbA
         tuug==
X-Gm-Message-State: ACrzQf1BFjJztSd/HDkUEP5vVbBZ3RoV9UEXkCdwhWgx4LQB+wPTsuSc
        qbRAZqdIhddtQYxT/ZZRew6IRcZ6QJnO87tjXAI9Vie+miE=
X-Google-Smtp-Source: AMsMyM55K+uiZW5OwpOjoF0sMgqcJH4gw/pUqwVGf2i69LO18dGMRN07sLh4r83mQo6wIKtwof37YX4PICNkpn7XXd8=
X-Received: by 2002:a67:e04d:0:b0:397:f787:7880 with SMTP id
 n13-20020a67e04d000000b00397f7877880mr1018597vsl.71.1664446072897; Thu, 29
 Sep 2022 03:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220902202248.3061262-1-dlatypov@google.com> <20220902202248.3061262-2-dlatypov@google.com>
In-Reply-To: <20220902202248.3061262-2-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 29 Sep 2022 18:07:41 +0800
Message-ID: <CABVgOSnzFN22YtW0_914CLwGrhRRMzPxmt65dM20r_-HOXKxPw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: tool: rename all_test_uml.config, use it for --alltests
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Sep 3, 2022 at 4:22 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Context:
> 1. all_tests_uml.config used to be UML specific back when users to
>    manually specify CONFIG_VIRTIO_UML=y to enable CONFIG_PCI=y.
> 2. --alltests used allyesconfig along with a curated list of options to
>    disable. It's only ever worked for brief periods of time and has
>    perennially been broken due to compile issues.
>
> Now all_tests_uml.config should work across ~all architectures.
> Let's instead use this to implement --alltests.
>
> Note: if anyone was using all_tests_uml.config, this change breaks them.
> I think that's unlikely since it was added in 5.19 and was a lot to
> type: --kunitconfig=tools/testing/kunit/configs/all_tests_uml.config.
> We could make it a symlink to the new name, but I don't think the
> caution is warranted here.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Thanks: this looks good to me. As much as I liked the idea of using
make allyesconfig, this is both much simpler, and actually works, so
is a definite improvement.

We should also update the documentation, though.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  ...{all_tests_uml.config => all_tests.config} |  0
>  .../kunit/configs/broken_on_uml.config        | 44 -------------------
>  tools/testing/kunit/kunit.py                  | 24 +++++-----
>  tools/testing/kunit/kunit_kernel.py           | 29 +-----------
>  tools/testing/kunit/kunit_tool_test.py        | 26 ++++++++---
>  5 files changed, 33 insertions(+), 90 deletions(-)
>  rename tools/testing/kunit/configs/{all_tests_uml.config => all_tests.config} (100%)
>  delete mode 100644 tools/testing/kunit/configs/broken_on_uml.config
>
> diff --git a/tools/testing/kunit/configs/all_tests_uml.config b/tools/testing/kunit/configs/all_tests.config
> similarity index 100%
> rename from tools/testing/kunit/configs/all_tests_uml.config
> rename to tools/testing/kunit/configs/all_tests.config
> diff --git a/tools/testing/kunit/configs/broken_on_uml.config b/tools/testing/kunit/configs/broken_on_uml.config
> deleted file mode 100644
> index 690870043ac0..000000000000
> --- a/tools/testing/kunit/configs/broken_on_uml.config
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -# These are currently broken on UML and prevent allyesconfig from building
> -# CONFIG_STATIC_LINK is not set
> -# CONFIG_UML_NET_VECTOR is not set
> -# CONFIG_UML_NET_VDE is not set
> -# CONFIG_UML_NET_PCAP is not set
> -# CONFIG_NET_PTP_CLASSIFY is not set
> -# CONFIG_IP_VS is not set
> -# CONFIG_BRIDGE_EBT_BROUTE is not set
> -# CONFIG_BRIDGE_EBT_T_FILTER is not set
> -# CONFIG_BRIDGE_EBT_T_NAT is not set
> -# CONFIG_MTD_NAND_CADENCE is not set
> -# CONFIG_MTD_NAND_NANDSIM is not set
> -# CONFIG_BLK_DEV_NULL_BLK is not set
> -# CONFIG_BLK_DEV_RAM is not set
> -# CONFIG_SCSI_DEBUG is not set
> -# CONFIG_NET_VENDOR_XILINX is not set
> -# CONFIG_NULL_TTY is not set
> -# CONFIG_PTP_1588_CLOCK is not set
> -# CONFIG_PINCTRL_EQUILIBRIUM is not set
> -# CONFIG_DMABUF_SELFTESTS is not set
> -# CONFIG_COMEDI is not set
> -# CONFIG_XIL_AXIS_FIFO is not set
> -# CONFIG_EXFAT_FS is not set
> -# CONFIG_STM_DUMMY is not set
> -# CONFIG_FSI_MASTER_ASPEED is not set
> -# CONFIG_JFS_FS is not set
> -# CONFIG_UBIFS_FS is not set
> -# CONFIG_CRAMFS is not set
> -# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
> -# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
> -# CONFIG_KCOV is not set
> -# CONFIG_LKDTM is not set
> -# CONFIG_REED_SOLOMON_TEST is not set
> -# CONFIG_TEST_RHASHTABLE is not set
> -# CONFIG_TEST_MEMINIT is not set
> -# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
> -# CONFIG_DEBUG_INFO_BTF is not set
> -# CONFIG_PTP_1588_CLOCK_INES is not set
> -# CONFIG_QCOM_CPR is not set
> -# CONFIG_RESET_BRCMSTB_RESCAL is not set
> -# CONFIG_RESET_INTEL_GW is not set
> -# CONFIG_ADI_AXI_ADC is not set
> -# CONFIG_DEBUG_PAGEALLOC is not set
> -# CONFIG_PAGE_POISONING is not set
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index e132b0654029..eca3ebe1d3a9 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -44,7 +44,6 @@ class KunitConfigRequest:
>  @dataclass
>  class KunitBuildRequest(KunitConfigRequest):
>         jobs: int
> -       alltests: bool
>
>  @dataclass
>  class KunitParseRequest:
> @@ -55,7 +54,6 @@ class KunitParseRequest:
>  class KunitExecRequest(KunitParseRequest):
>         build_dir: str
>         timeout: int
> -       alltests: bool
>         filter_glob: str
>         kernel_args: Optional[List[str]]
>         run_isolated: Optional[str]
> @@ -90,8 +88,7 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
>         stdout.print_with_timestamp('Building KUnit Kernel ...')
>
>         build_start = time.time()
> -       success = linux.build_kernel(request.alltests,
> -                                    request.jobs,
> +       success = linux.build_kernel(request.jobs,
>                                      request.build_dir,
>                                      request.make_options)
>         build_end = time.time()
> @@ -118,7 +115,7 @@ def _list_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest)
>                 args.extend(request.kernel_args)
>
>         output = linux.run_kernel(args=args,
> -                          timeout=None if request.alltests else request.timeout,
> +                          timeout=request.timeout,
>                            filter_glob=request.filter_glob,
>                            build_dir=request.build_dir)
>         lines = kunit_parser.extract_tap_lines(output)
> @@ -165,7 +162,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
>                 test_start = time.time()
>                 run_result = linux.run_kernel(
>                         args=request.kernel_args,
> -                       timeout=None if request.alltests else request.timeout,
> +                       timeout=request.timeout,
>                         filter_glob=filter_glob,
>                         build_dir=request.build_dir)
>
> @@ -288,7 +285,7 @@ def add_common_opts(parser) -> None:
>                             help='X=Y make option, can be repeated.',
>                             action='append', metavar='X=Y')
>         parser.add_argument('--alltests',
> -                           help='Run all KUnit tests through allyesconfig',
> +                           help='Run all KUnit tests via tools/testing/kunit/configs/all_tests.config',
>                             action='store_true')
>         parser.add_argument('--kunitconfig',
>                              help='Path to Kconfig fragment that enables KUnit tests.'
> @@ -381,8 +378,14 @@ def tree_from_args(cli_args: argparse.Namespace) -> kunit_kernel.LinuxSourceTree
>                 for arg in cli_args.qemu_args:
>                         qemu_args.extend(shlex.split(arg))
>
> +       kunitconfigs = cli_args.kunitconfig if cli_args.kunitconfig else []
> +       if cli_args.alltests:
> +               # Prepend so user-specified options take prio if we ever allow
> +               # --kunitconfig options to have differing options.
> +               kunitconfigs = [kunit_kernel.ALL_TESTS_CONFIG_PATH] + kunitconfigs
> +
>         return kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> -                       kunitconfig_paths=cli_args.kunitconfig,
> +                       kunitconfig_paths=kunitconfigs,
>                         kconfig_add=cli_args.kconfig_add,
>                         arch=cli_args.arch,
>                         cross_compile=cli_args.cross_compile,
> @@ -441,7 +444,6 @@ def main(argv):
>                 request = KunitRequest(build_dir=cli_args.build_dir,
>                                        make_options=cli_args.make_options,
>                                        jobs=cli_args.jobs,
> -                                      alltests=cli_args.alltests,
>                                        raw_output=cli_args.raw_output,
>                                        json=cli_args.json,
>                                        timeout=cli_args.timeout,
> @@ -469,8 +471,7 @@ def main(argv):
>                 linux = tree_from_args(cli_args)
>                 request = KunitBuildRequest(build_dir=cli_args.build_dir,
>                                             make_options=cli_args.make_options,
> -                                           jobs=cli_args.jobs,
> -                                           alltests=cli_args.alltests)
> +                                           jobs=cli_args.jobs)
>                 result = config_and_build_tests(linux, request)
>                 stdout.print_with_timestamp((
>                         'Elapsed time: %.3fs\n') % (
> @@ -483,7 +484,6 @@ def main(argv):
>                                                 build_dir=cli_args.build_dir,
>                                                 json=cli_args.json,
>                                                 timeout=cli_args.timeout,
> -                                               alltests=cli_args.alltests,
>                                                 filter_glob=cli_args.filter_glob,
>                                                 kernel_args=cli_args.kernel_args,
>                                                 run_isolated=cli_args.run_isolated)
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index f5c26ea89714..eb62a9b035cb 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -25,7 +25,7 @@ KCONFIG_PATH = '.config'
>  KUNITCONFIG_PATH = '.kunitconfig'
>  OLD_KUNITCONFIG_PATH = 'last_used_kunitconfig'
>  DEFAULT_KUNITCONFIG_PATH = 'tools/testing/kunit/configs/default.config'
> -BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
> +ALL_TESTS_CONFIG_PATH = 'tools/testing/kunit/configs/all_tests.config'
>  UML_KCONFIG_PATH = 'tools/testing/kunit/configs/arch_uml.config'
>  OUTFILE_PATH = 'test.log'
>  ABS_TOOL_PATH = os.path.abspath(os.path.dirname(__file__))
> @@ -57,9 +57,6 @@ class LinuxSourceTreeOperations:
>         def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
>                 return base_kunitconfig
>
> -       def make_allyesconfig(self, build_dir: str, make_options) -> None:
> -               raise ConfigError('Only the "um" arch is supported for alltests')
> -
>         def make_olddefconfig(self, build_dir: str, make_options) -> None:
>                 command = ['make', 'ARCH=' + self._linux_arch, 'O=' + build_dir, 'olddefconfig']
>                 if self._cross_compile:
> @@ -144,26 +141,6 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
>                 kconfig.merge_in_entries(base_kunitconfig)
>                 return kconfig
>
> -       def make_allyesconfig(self, build_dir: str, make_options) -> None:
> -               stdout.print_with_timestamp(
> -                       'Enabling all CONFIGs for UML...')
> -               command = ['make', 'ARCH=um', 'O=' + build_dir, 'allyesconfig']
> -               if make_options:
> -                       command.extend(make_options)
> -               process = subprocess.Popen(
> -                       command,
> -                       stdout=subprocess.DEVNULL,
> -                       stderr=subprocess.STDOUT)
> -               process.wait()
> -               stdout.print_with_timestamp(
> -                       'Disabling broken configs to run KUnit tests...')
> -
> -               with open(get_kconfig_path(build_dir), 'a') as config:
> -                       with open(BROKEN_ALLCONFIG_PATH, 'r') as disable:
> -                               config.write(disable.read())
> -               stdout.print_with_timestamp(
> -                       'Starting Kernel with all configs takes a few minutes...')
> -
>         def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
>                 """Runs the Linux UML binary. Must be named 'linux'."""
>                 linux_bin = os.path.join(build_dir, 'linux')
> @@ -343,10 +320,8 @@ class LinuxSourceTree:
>                 os.remove(kconfig_path)
>                 return self.build_config(build_dir, make_options)
>
> -       def build_kernel(self, alltests, jobs, build_dir: str, make_options) -> bool:
> +       def build_kernel(self, jobs, build_dir: str, make_options) -> bool:
>                 try:
> -                       if alltests:
> -                               self._ops.make_allyesconfig(build_dir, make_options)
>                         self._ops.make_olddefconfig(build_dir, make_options)
>                         self._ops.make(jobs, build_dir, make_options)
>                 except (ConfigError, BuildError) as e:
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 446ac432d9a4..e2cd2cc2e98f 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -549,7 +549,7 @@ class KUnitMainTest(unittest.TestCase):
>         def test_build_passes_args_pass(self):
>                 kunit.main(['build'])
>                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
> -               self.linux_source_mock.build_kernel.assert_called_once_with(False, kunit.get_default_jobs(), '.kunit', None)
> +               self.linux_source_mock.build_kernel.assert_called_once_with(kunit.get_default_jobs(), '.kunit', None)
>                 self.assertEqual(self.linux_source_mock.run_kernel.call_count, 0)
>
>         def test_exec_passes_args_pass(self):
> @@ -664,7 +664,7 @@ class KUnitMainTest(unittest.TestCase):
>                 build_dir = '.kunit'
>                 jobs = kunit.get_default_jobs()
>                 kunit.main(['build', '--build_dir', build_dir])
> -               self.linux_source_mock.build_kernel.assert_called_once_with(False, jobs, build_dir, None)
> +               self.linux_source_mock.build_kernel.assert_called_once_with(jobs, build_dir, None)
>
>         def test_exec_builddir(self):
>                 build_dir = '.kunit'
> @@ -695,6 +695,18 @@ class KUnitMainTest(unittest.TestCase):
>                                                 qemu_config_path=None,
>                                                 extra_qemu_args=[])
>
> +       def test_config_alltests(self):
> +               kunit.main(['config', '--kunitconfig=mykunitconfig', '--alltests'])
> +               # Just verify that we parsed and initialized it correctly here.
> +               self.mock_linux_init.assert_called_once_with('.kunit',
> +                                               kunitconfig_paths=[kunit_kernel.ALL_TESTS_CONFIG_PATH, 'mykunitconfig'],
> +                                               kconfig_add=None,
> +                                               arch='um',
> +                                               cross_compile=None,
> +                                               qemu_config_path=None,
> +                                               extra_qemu_args=[])
> +
> +
>         @mock.patch.object(kunit_kernel, 'LinuxSourceTree')
>         def test_run_multiple_kunitconfig(self, mock_linux_init):
>                 mock_linux_init.return_value = self.linux_source_mock
> @@ -712,7 +724,7 @@ class KUnitMainTest(unittest.TestCase):
>                 kunit.main(['run', '--kconfig_add=CONFIG_KASAN=y', '--kconfig_add=CONFIG_KCSAN=y'])
>                 # Just verify that we parsed and initialized it correctly here.
>                 self.mock_linux_init.assert_called_once_with('.kunit',
> -                                               kunitconfig_paths=None,
> +                                               kunitconfig_paths=[],
>                                                 kconfig_add=['CONFIG_KASAN=y', 'CONFIG_KCSAN=y'],
>                                                 arch='um',
>                                                 cross_compile=None,
> @@ -723,7 +735,7 @@ class KUnitMainTest(unittest.TestCase):
>                 kunit.main(['run', '--arch=x86_64', '--qemu_args', '-m 2048'])
>                 # Just verify that we parsed and initialized it correctly here.
>                 self.mock_linux_init.assert_called_once_with('.kunit',
> -                                               kunitconfig_paths=None,
> +                                               kunitconfig_paths=[],
>                                                 kconfig_add=None,
>                                                 arch='x86_64',
>                                                 cross_compile=None,
> @@ -742,7 +754,7 @@ class KUnitMainTest(unittest.TestCase):
>                 self.linux_source_mock.run_kernel.return_value = ['TAP version 14', 'init: random output'] + want
>
>                 got = kunit._list_tests(self.linux_source_mock,
> -                                    kunit.KunitExecRequest(None, None, '.kunit', 300, False, 'suite*', None, 'suite'))
> +                                    kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*', None, 'suite'))
>
>                 self.assertEqual(got, want)
>                 # Should respect the user's filter glob when listing tests.
> @@ -757,7 +769,7 @@ class KUnitMainTest(unittest.TestCase):
>
>                 # Should respect the user's filter glob when listing tests.
>                 mock_tests.assert_called_once_with(mock.ANY,
> -                                    kunit.KunitExecRequest(None, None, '.kunit', 300, False, 'suite*.test*', None, 'suite'))
> +                                    kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*.test*', None, 'suite'))
>                 self.linux_source_mock.run_kernel.assert_has_calls([
>                         mock.call(args=None, build_dir='.kunit', filter_glob='suite.test*', timeout=300),
>                         mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test*', timeout=300),
> @@ -770,7 +782,7 @@ class KUnitMainTest(unittest.TestCase):
>
>                 # Should respect the user's filter glob when listing tests.
>                 mock_tests.assert_called_once_with(mock.ANY,
> -                                    kunit.KunitExecRequest(None, None, '.kunit', 300, False, 'suite*', None, 'test'))
> +                                    kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*', None, 'test'))
>                 self.linux_source_mock.run_kernel.assert_has_calls([
>                         mock.call(args=None, build_dir='.kunit', filter_glob='suite.test1', timeout=300),
>                         mock.call(args=None, build_dir='.kunit', filter_glob='suite.test2', timeout=300),
> --
> 2.37.2.789.g6183377224-goog
>
