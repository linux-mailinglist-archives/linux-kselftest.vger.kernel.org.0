Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE68558948
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jun 2022 21:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiFWTk7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jun 2022 15:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiFWTkk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jun 2022 15:40:40 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9460A8053A
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jun 2022 12:30:27 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u15so232525ejc.10
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jun 2022 12:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ktnWgaGfXlUyFzw3WYN81yNQBxVyn7TH3IijN8+TCrE=;
        b=aJ0D63AMYWj9xoBmF2Uc/pS/uPixVK/1MLddTgFsNKqRD+Lk+NJHrr6NSGwldNE+5Q
         WHSA2c2914/o7IpqT1HL51cyNIhbTT8XQkhVbOvP1giW7+Hlgl3eHFAoCdl34bwTbHyE
         XP3eu4e1KkJVQCNEqa/zfcs4jy0SP2quGM82d4725Tc2a4UX0doDO+80a5YDecWbD/8g
         XieTMxDtT5YIrnq7xcNoaoSQ2KY0VhUzaYdhFnbfgdLw3dUz+vqaIquROp0e09Un/w90
         Iv5MMK0mMghkDT+4yB21UWHHW+lF7cF0XColTMLyM3JvCRNSisAytOu2u6ByU+t1r4eX
         v/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ktnWgaGfXlUyFzw3WYN81yNQBxVyn7TH3IijN8+TCrE=;
        b=NJVHhEAtpKzsxAfcNNxGKetIIrXtt1J6UYn6MMcb6TgTJ3zB2woaDmOJOy42vIK2Dj
         IaDp42n1/hjc/DDN7tuCTdYjZxjUAe4/c4foM9Lr08jy5La1dtm2UTWYxY0kwOtGZ6ZU
         /sy71y5+rCH0zGO0slygtQr1N1E8GeF3Zd1Y9XFpyouGMbHp6vtd0SfzmvTd+GVxMDrv
         RD+y5y3zIaX8U20qmQ9FTcFoL9DsL/y+OlsuW6B7zToBvzjvS4atRcrwpK1+shvVkdUJ
         U97jwdTCot2EpyESFJLhJ0wd8laFwoE9bHVS9fm4wUyB7Yq9/i/pmE7o790weuTVmwPu
         VFSg==
X-Gm-Message-State: AJIora9L1cGNQ0xX7Yi2bKKhs/2OFZeTa13YOsl4Tqoiu8wwer/Dv9r2
        vtYsqB/bmNL9LRKQxq7f6Zj/Fca2sI8n+7lOXWr8nw==
X-Google-Smtp-Source: AGRyM1uGkfkSYAQGAKnZkLaETtz7YP/UT5QGMtV/dduPQuz1fa4n/cyMWGF0MVETAjU6nAYfsHYFSS6AUPCmQoDQHd4=
X-Received: by 2002:a17:907:9715:b0:726:2a3b:9f84 with SMTP id
 jg21-20020a170907971500b007262a3b9f84mr3195116ejc.414.1656012625972; Thu, 23
 Jun 2022 12:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220622035326.759935-1-davidgow@google.com>
In-Reply-To: <20220622035326.759935-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 23 Jun 2022 12:30:14 -0700
Message-ID: <CAFd5g45VTbQ+tR9Bh0nNCA_cc3myLyDSYwLwEQb1FmkwaEd2Ow@mail.gmail.com>
Subject: Re: [RFC PATCH] kunit: tool: Enable virtio/PCI by default on UML
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
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

On Tue, Jun 21, 2022 at 8:53 PM David Gow <davidgow@google.com> wrote:
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
> It's really ugly to have to type:
>         --kconfig_add CONFIG_VIRTIO_UML=y
>         --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=y
> when running many tests under UML, particularly since it isn't required
> on other architectures.
>
> This came up in discussion with Daniel this morning, and while the
> ability to repeat the --kunitconfig flag would go some way to alleviate
> this, having to add:
>         --kunitconfig ./tools/testing/kunit/config/uml_pci.kunitconfig
> isn't all that much better.
>
> So it seems like adding something by default would be nice.
>
> This implementation is not perfect (in particular, there's no easy way
> of _disabling_ these options now, though [1] probably will help). The
> 'arch_uml.config' filename can be bikeshedded, too.
>
> Thoughts?

I am supportive of adding the PCI dependency as a default for UML; I
agree that there is a common desire to use PCI for tests and enabling
it on UML is wonky.

One additional note: It looks like this patch breaks kunit_tool:
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/21871

The python error in the log seems legitimate:
https://storage.googleapis.com/oss-prow/pr-logs/pull/linux-review.googlesource.com_linux_kernel_git_torvalds_linux/21871/linux-kernel-mailing-list-presubmit/1539456886976286720/build-log.txt

This line in particular:

AttributeError: 'LinuxSourceTreeOperationsUml' object has no attribute
'make_arch_qemuconfig'

> ---
>  tools/testing/kunit/configs/arch_uml.config |  5 +++++
>  tools/testing/kunit/kunit_kernel.py         | 11 ++++++++---
>  2 files changed, 13 insertions(+), 3 deletions(-)
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
> index 3539efaf99ba..05e7b1e188d7 100644
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
> -       def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> None:
> +       def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> None:
>                 pass
>
>         def make_allyesconfig(self, build_dir: str, make_options) -> None:
> @@ -109,7 +110,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
>                 self._kernel_command_line = qemu_arch_params.kernel_command_line + ' kunit_shutdown=reboot'
>                 self._extra_qemu_params = qemu_arch_params.extra_qemu_params
>
> -       def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> None:
> +       def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> None:
>                 kconfig = kunit_config.parse_from_string(self._kconfig)
>                 base_kunitconfig.merge_in_entries(kconfig)
>
> @@ -137,6 +138,10 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
>         def __init__(self, cross_compile=None):
>                 super().__init__(linux_arch='um', cross_compile=cross_compile)
>
> +       def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> None:
> +               kconfig = kunit_config.parse_file(UML_KCONFIG_PATH)
> +               base_kunitconfig.merge_in_entries(kconfig)
> +
>         def make_allyesconfig(self, build_dir: str, make_options) -> None:
>                 kunit_parser.print_with_timestamp(
>                         'Enabling all CONFIGs for UML...')
> @@ -313,7 +318,7 @@ class LinuxSourceTree:
>                         return self.build_config(build_dir, make_options)
>
>                 existing_kconfig = kunit_config.parse_file(kconfig_path)
> -               self._ops.make_arch_qemuconfig(self._kconfig)
> +               self._ops.make_arch_config(self._kconfig)
>                 if self._kconfig.is_subset_of(existing_kconfig) and not self._kunitconfig_changed(build_dir):
>                         return True
>                 print('Regenerating .config ...')
> --
> 2.37.0.rc0.104.g0611611a94-goog
>
