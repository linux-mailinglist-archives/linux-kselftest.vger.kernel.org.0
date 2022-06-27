Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41B855C46D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jun 2022 14:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241506AbiF0W5T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jun 2022 18:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbiF0W5S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jun 2022 18:57:18 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A6D18E3A
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jun 2022 15:57:17 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id p136so13043029ybg.4
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jun 2022 15:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gE/xA3Wye8hViJbK5UhmsnlZGnHWRGC3pMXvtMOoCt8=;
        b=qyWovt3H2/S/PREhNpP70FSfQjvs5rJ9G6pZ9vtVfiXj25owaRv8/RaJ0lYbcK3hXj
         Hpx1SebchV1O8NiX5BqxRmohGd2DVncnDboXcCprOeaTlqQ3uL+W+X7FSi+RnRp9bJ8x
         cyaOL9ZtGbulxrb7IOaOwrsNBW1ivz/vuZ5V6XflcJFBMZl5V6+hCAyn2iFrYFpW8tNg
         VIKFhgF4FnkYrBKdyOf+KcQ2owAWUgwlGLSRxK9X3eI2JdZe3gnhep1PieuPS0xrf1aR
         cpVrmSqsNUmJUmZ/3YIxYnROIoiRRBrja3H/bKgRKmaeFIhn9wCADinruX/7Ufkgw8sc
         NLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gE/xA3Wye8hViJbK5UhmsnlZGnHWRGC3pMXvtMOoCt8=;
        b=UH7aAfz5sq8oRpZ28xyhhWIcc7tewb5RMgctEiaJnAocrlT2VkPwe54+RM8z+VMfG+
         Mc4JqLAnaJDtHeJSN7rXBQRInFWiKQwwGKbtB/ZoSHSAQ6w5qhuekMHEUWFnS0OnD3+V
         7n+mLqG/oHGcKcmeltUH8VP/7gnrx6D2PIx80aCaWxkWqtw2OEV3y25n2Tw7GxTGLMWc
         nptioX/hgdwTgGeFYpCyxYPOKGCCmWimS4/IqXjBNYv2RXTdNRUb+LhPjv8h6wB1KAHc
         rAQ+7eauwevdkxlwc9tqK1UYnFKEeUYAb60ZsMTaJNINxmQQAX2wo98PMPkmiYIKrms6
         1AyA==
X-Gm-Message-State: AJIora/o4ULj+SE4Al1Pf9FOrOQRcUYWvbHmsWEBm1d7ieTFpRDLbTqr
        WKbMa6rjqaxqRM3BneEVbSB/EhpSEXKjt6YSoUjsMg==
X-Google-Smtp-Source: AGRyM1s8sgQ1jy0T7pu+ThAN9hgK9CCpf9A/jyg2Ut9Ur1TU10fbA438D/Xn3CjhSHa1NR5i/KdpOTMGIr7jPm5vCok=
X-Received: by 2002:a25:a401:0:b0:664:7d19:5fc6 with SMTP id
 f1-20020a25a401000000b006647d195fc6mr15794134ybi.400.1656370636629; Mon, 27
 Jun 2022 15:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220624084400.1454579-1-davidgow@google.com>
In-Reply-To: <20220624084400.1454579-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 27 Jun 2022 15:57:04 -0700
Message-ID: <CAGS_qxqrcyEH+C=63R8uT+K2opkXm6Da1wa4pyNupLUsy1iAKw@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Enable virtio/PCI by default on UML
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 24, 2022 at 1:44 AM David Gow <davidgow@google.com> wrote:
>
> There are several tests which depend on PCI, and hence need a bunch of
> extra options to run under UML. This makes it awkward to give
> configuration instructions (whether in documentation, or as part of a
> .kunitconfig file), as two separate, incompatible sets of config options
> are required for UML and "most other architectures".
>
> For non-UML architectures, it's possible to add default kconfig options
> via the qemu_config python files, but there's no equivalent for UML. Add
> a new tools/testing/kunit/configs/arch_uml.config file containing extra
> kconfig options to use on UML.
>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> NOTE: This has dependencies on the 'make --kunitconfig repeatable'
> series:
> https://lore.kernel.org/linux-kselftest/20220624001247.3255978-1-dlatypov@google.com/
> which, in turn, depends on:
> https://lore.kernel.org/linux-kselftest/20220520224200.3764027-1-dlatypov@google.com/
> Please apply those first.
>
> Changes since RFC:
> https://lore.kernel.org/linux-kselftest/20220622035326.759935-1-davidgow@google.com/
> - Rebase on top of the previous kconfig patches.
> - Fix a missing make_arch_qemuconfig->make_arch_config rename (Thanks
>   Brendan)
> - Fix the tests to use the base LinuxSourceTreeOperations class, which
>   has no default kconfig options (and so won't conflict with those set
>   in the tests). Only test_build_reconfig_existing_config actually
>   failed, but I updated a few more in case the defaults changed.
>
>
> ---
>  tools/testing/kunit/configs/arch_uml.config |  5 +++++
>  tools/testing/kunit/kunit_kernel.py         | 14 ++++++++++----
>  tools/testing/kunit/kunit_tool_test.py      | 12 ++++++++++++
>  3 files changed, 27 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/kunit/configs/arch_uml.config
>
> diff --git a/tools/testing/kunit/configs/arch_uml.config b/tools/testing/kunit/configs/arch_uml.config
> new file mode 100644
> index 000000000000..e824ce43b05a
> --- /dev/null
> +++ b/tools/testing/kunit/configs/arch_uml.config
> @@ -0,0 +1,5 @@
> +# Config options which are added to UML builds by default
> +
> +# Enable virtio/pci, as a lot of tests require it.
> +CONFIG_VIRTIO_UML=y
> +CONFIG_UML_PCI_OVER_VIRTIO=y
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index fc415ff7530e..127598fb994b 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -26,6 +26,7 @@ KUNITCONFIG_PATH = '.kunitconfig'
>  OLD_KUNITCONFIG_PATH = 'last_used_kunitconfig'
>  DEFAULT_KUNITCONFIG_PATH = 'tools/testing/kunit/configs/default.config'
>  BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
> +UML_KCONFIG_PATH = 'tools/testing/kunit/configs/arch_uml.config'
>  OUTFILE_PATH = 'test.log'
>  ABS_TOOL_PATH = os.path.abspath(os.path.dirname(__file__))
>  QEMU_CONFIGS_DIR = os.path.join(ABS_TOOL_PATH, 'qemu_configs')
> @@ -53,7 +54,7 @@ class LinuxSourceTreeOperations:
>                 except subprocess.CalledProcessError as e:
>                         raise ConfigError(e.output.decode())
>
> -       def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
> +       def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
>                 return base_kunitconfig
>
>         def make_allyesconfig(self, build_dir: str, make_options) -> None:
> @@ -109,7 +110,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
>                 self._kernel_command_line = qemu_arch_params.kernel_command_line + ' kunit_shutdown=reboot'
>                 self._extra_qemu_params = qemu_arch_params.extra_qemu_params
>
> -       def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
> +       def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
>                 kconfig = kunit_config.parse_from_string(self._kconfig)
>                 kconfig.merge_in_entries(base_kunitconfig)
>                 return kconfig
> @@ -138,6 +139,11 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
>         def __init__(self, cross_compile=None):
>                 super().__init__(linux_arch='um', cross_compile=cross_compile)
>
> +       def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
> +               kconfig = kunit_config.parse_file(UML_KCONFIG_PATH)
> +               kconfig.merge_in_entries(base_kunitconfig)
> +               return kconfig
> +
>         def make_allyesconfig(self, build_dir: str, make_options) -> None:
>                 kunit_parser.print_with_timestamp(
>                         'Enabling all CONFIGs for UML...')
> @@ -297,7 +303,7 @@ class LinuxSourceTree:
>                 if build_dir and not os.path.exists(build_dir):
>                         os.mkdir(build_dir)
>                 try:
> -                       self._kconfig = self._ops.make_arch_qemuconfig(self._kconfig)
> +                       self._kconfig = self._ops.make_arch_config(self._kconfig)
>                         self._kconfig.write_to_file(kconfig_path)
>                         self._ops.make_olddefconfig(build_dir, make_options)
>                 except ConfigError as e:
> @@ -328,7 +334,7 @@ class LinuxSourceTree:
>                         return self.build_config(build_dir, make_options)
>
>                 existing_kconfig = kunit_config.parse_file(kconfig_path)
> -               self._kconfig = self._ops.make_arch_qemuconfig(self._kconfig)
> +               self._kconfig = self._ops.make_arch_config(self._kconfig)
>
>                 if self._kconfig.is_subset_of(existing_kconfig) and not self._kunitconfig_changed(build_dir):
>                         return True
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index e21ae1331350..08cb2dc8ef7d 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -430,6 +430,10 @@ class LinuxSourceTreeTest(unittest.TestCase):
>                                 f.write('CONFIG_KUNIT=y')
>
>                         tree = kunit_kernel.LinuxSourceTree(build_dir)
> +                       # Stub out the source tree operations, so we don't have
> +                       # the defaults for any given architecture get in the
> +                       # way.
> +                       tree._ops = kunit_kernel.LinuxSourceTreeOperations(None, None)

This runs and typechecks under mypy, but not under pytype.
The problem is that the first argument is type str, not Optional[str].

I think a fix would be to just use LinuxSourceTreeOperationsUml() instead here.

Since you recently switched machines, you might want to run:
$ pip install pytype

And then
$ ./tools/testing/kunit/run_checks.py
would run pytype and show you the complaints here.



>                         mock_build_config = mock.patch.object(tree, 'build_config').start()
>
>                         # Should generate the .config
> @@ -447,6 +451,10 @@ class LinuxSourceTreeTest(unittest.TestCase):
>                                 f.write('CONFIG_KUNIT=y\nCONFIG_KUNIT_TEST=y')
>
>                         tree = kunit_kernel.LinuxSourceTree(build_dir)
> +                       # Stub out the source tree operations, so we don't have
> +                       # the defaults for any given architecture get in the
> +                       # way.
> +                       tree._ops = kunit_kernel.LinuxSourceTreeOperations(None, None)
>                         mock_build_config = mock.patch.object(tree, 'build_config').start()
>
>                         self.assertTrue(tree.build_reconfig(build_dir, make_options=[]))
> @@ -463,6 +471,10 @@ class LinuxSourceTreeTest(unittest.TestCase):
>                                 f.write('CONFIG_KUNIT=y\nCONFIG_KUNIT_TEST=y')
>
>                         tree = kunit_kernel.LinuxSourceTree(build_dir)
> +                       # Stub out the source tree operations, so we don't have
> +                       # the defaults for any given architecture get in the
> +                       # way.
> +                       tree._ops = kunit_kernel.LinuxSourceTreeOperations(None, None)
>                         mock_build_config = mock.patch.object(tree, 'build_config').start()
>
>                         # ... so we should trigger a call to build_config()
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
