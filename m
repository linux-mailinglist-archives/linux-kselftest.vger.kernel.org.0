Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB7452E4DF
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 May 2022 08:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245460AbiETGNE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 May 2022 02:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbiETGND (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 May 2022 02:13:03 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089F99968E
        for <linux-kselftest@vger.kernel.org>; Thu, 19 May 2022 23:13:00 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u27so9219992wru.8
        for <linux-kselftest@vger.kernel.org>; Thu, 19 May 2022 23:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2a5uEC0I+eQQ36RMpqflkcJ8J7VU8SrCMNYo2pSbjSs=;
        b=j5upEAmBSQhrLPAicuPaDyzks7Ws6gBDgFKQ5/z5AnRxh9LJMg8Ng0FjujudjLRRP7
         cPczvd8jrvnEPufmfqvjjXR2SQBQi6Neo29t/bp3iZE0mC7psGVcSlo0qASbhcssQOPT
         qd699Q9OXLvIheQYsRxTyskx39wlJd6EbYjj8jIWXII1hQ33wIL8XUf+4pdOg+9VWm/Q
         IOga9qLc1f9nZv+OFkkwrZbNGS05cwA/BOHp8amGDEB55ag7kJCnCVii5ajUo+OFLdvz
         Auxwep+dV2izccOj55BBekkHdsZk00YkIV3qmIAoEs3/RuCYVLQ3Hp1NWbh/8m0Na3hG
         gUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2a5uEC0I+eQQ36RMpqflkcJ8J7VU8SrCMNYo2pSbjSs=;
        b=wJGoVEbGmS6wCFTF5+jlqWmM/ot2gBk69IbhlyqoEAogy9oqWbyqSQDx2M82LshAbb
         qanSTNYODQG0Lu8OmSfxmUL/I/vHaR3PsQOId4DkpZo0dl6av43+615ZHsIP+EcPEJCg
         gQNTGJuryLxq2hUPQlkfbSICVL/xPVGMxo7Yb9qUit3ijFloQXBPD85kcjLpnFwnmf3o
         znKA5sOmcc/hANlmGM2XED/KoehPnN9yKtw416UYGsRi+eKrC6PiNBCYM259eRVJCqKs
         Fzyr6g5g5Y34LXpF4WzCZkHwR7d2FTtfnhIPMAO5FsjbWzk6NZaUQVBfLoc8TZB2Vt9A
         Li0A==
X-Gm-Message-State: AOAM530j3/wFx8HDOSXwRr9VW9OLbXuswkjIGSq/IwuzVzdJIxp9fJol
        wTCVOfTA+jE3ZVM3zYF0oHsTh7PHjKjdg2gUsMdGRg==
X-Google-Smtp-Source: ABdhPJwBnBFoLrQxUGsEHH09sdgE9kbISOKCa/G+4XY2BqTlfUUsek3Akx2eeRK6c8jiTe7DieEquwvXfFgWHLzaLkI=
X-Received: by 2002:a5d:6041:0:b0:20d:8e4:7bb8 with SMTP id
 j1-20020a5d6041000000b0020d08e47bb8mr6742438wrt.652.1653027178404; Thu, 19
 May 2022 23:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220519164512.3180360-1-dlatypov@google.com>
In-Reply-To: <20220519164512.3180360-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 20 May 2022 14:12:47 +0800
Message-ID: <CABVgOSnooocLsy2=a8rm7Y_m3DpffKtDam5_uYou+Y2tUkumRw@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: refactor internal kconfig handling, allow overriding
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ccf9a505df6b6154"
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

--000000000000ccf9a505df6b6154
Content-Type: text/plain; charset="UTF-8"

On Fri, May 20, 2022 at 12:45 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently, you cannot ovewrwrite what's in your kunitconfig via
> --kconfig_add.
> Nor can you override something in a qemu_config via either means.
>
> This patch makes it so we have this level of priority
> * --kconfig_add
> * kunitconfig file (the default or the one from --kunitconfig)
> * qemu_config
>
> The rationale for this order is that the more "dynamic" sources of
> kconfig options should take priority.
>
> --kconfig_add is obviously the most dynamic.
> And for kunitconfig, users probably tweak the file manually or specify
> --kunitconfig more often than they delve into qemu_config python files.
>
> And internally, we convert the kconfigs from a python list into a set or
> dict fairly often. We should just use a dict internally.
> We exposed the set transform in the past since we didn't define __eq__,
> so also take the chance to shore up the kunit_kconfig.Kconfig interface.
>
> Example
> =======
>
> Let's consider the unrealistic example where someone would want to
> disable CONFIG_KUNIT.
> I.e. they run
> $ ./tools/testing/kunit/kunit.py config --kconfig_add=CONFIG_KUNIT=n
>
> Before
> ------
> We'd write the following
> > # CONFIG_KUNIT is not set
> > CONFIG_KUNIT_ALL_TESTS=y
> > CONFIG_KUNIT_TEST=y
> > CONFIG_KUNIT=y
> > CONFIG_KUNIT_EXAMPLE_TEST=y
>
> And we'd error out with
> > ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
> > This is probably due to unsatisfied dependencies.
> > Missing: # CONFIG_KUNIT is not set
>
> After
> -----
> We'd write the following
> > # CONFIG_KUNIT is not set
> > CONFIG_KUNIT_TEST=y
> > CONFIG_KUNIT_ALL_TESTS=y
> > CONFIG_KUNIT_EXAMPLE_TEST=y
>
> And we'd error out with
> > ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
> > This is probably due to unsatisfied dependencies.
> > Missing: CONFIG_KUNIT_EXAMPLE_TEST=y, CONFIG_KUNIT_TEST=y, CONFIG_KUNIT_ALL_TESTS=y
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

I like this, but do think there are a few gaps this doesn't handle
properly. (Though exactly how we'd deal with them, I'm not yet sure.)

In particular, it's not possible to disable a pair of options where
one depends on the other: disabling the parent option will result in
the child one not being present in the generated config. This will
conflict both with "=y" and "=n/not set": we'd need a way to _remove_
a kconfig option for that to work.

The ideal thing would be for us to work out what the default value is,
and remove the option automatically if it matches, but that seems like
it'd be quite difficult. Otherwise, I guess a
--kconfig_{remove,delete,etc} option would work.

Otherwise, this seems okay at first glance, but I haven't had the time
to fully review it in detail yet...

Cheers,
-- David

>  tools/testing/kunit/kunit_config.py    | 49 +++++++++++++++-----------
>  tools/testing/kunit/kunit_kernel.py    | 21 ++++++-----
>  tools/testing/kunit/kunit_tool_test.py | 45 ++++++++++-------------
>  3 files changed, 59 insertions(+), 56 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
> index 75a8dc1683d4..89443400b17e 100644
> --- a/tools/testing/kunit/kunit_config.py
> +++ b/tools/testing/kunit/kunit_config.py
> @@ -8,7 +8,7 @@
>
>  from dataclasses import dataclass
>  import re
> -from typing import List, Set
> +from typing import Dict, Iterable, Set
>
>  CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_(\w+) is not set$'
>  CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+|".*")$'
> @@ -32,35 +32,46 @@ class Kconfig:
>         """Represents defconfig or .config specified using the Kconfig language."""
>
>         def __init__(self) -> None:
> -               self._entries = []  # type: List[KconfigEntry]
> +               self._entries = {}  # type: Dict[str, str]
>
> -       def entries(self) -> Set[KconfigEntry]:
> -               return set(self._entries)
> +       def __eq__(self, other) -> bool:
> +               if not isinstance(other, self.__class__):
> +                       return False
> +               return self._entries == other._entries
>
> -       def add_entry(self, entry: KconfigEntry) -> None:
> -               self._entries.append(entry)
> +       def __repr__(self) -> str:
> +               return ','.join(str(e) for e in self._as_entries())
> +
> +
> +       def _as_entries(self) -> Iterable[KconfigEntry]:
> +               for name, value in self._entries.items():
> +                       yield KconfigEntry(name, value)
> +
> +       def add_entry(self, name: str, value: str) -> None:
> +               self._entries[name] = value
>
>         def is_subset_of(self, other: 'Kconfig') -> bool:
> -               other_dict = {e.name: e.value for e in other.entries()}
> -               for a in self.entries():
> -                       b = other_dict.get(a.name)
> +               for name, value in self._entries.items():
> +                       b = other._entries.get(name)
>                         if b is None:
> -                               if a.value == 'n':
> +                               if value == 'n':
>                                         continue
>                                 return False
> -                       if a.value != b:
> +                       if value != b:
>                                 return False
>                 return True
>
> +       def set_diff(self, other: 'Kconfig') -> Set[KconfigEntry]:
> +               return set(self._as_entries()) - set(other._as_entries())
> +
>         def merge_in_entries(self, other: 'Kconfig') -> None:
> -               if other.is_subset_of(self):
> -                       return
> -               self._entries = list(self.entries().union(other.entries()))
> +               for name, value in other._entries.items():
> +                       self._entries[name] = value
>
>         def write_to_file(self, path: str) -> None:
>                 with open(path, 'a+') as f:
> -                       for entry in self.entries():
> -                               f.write(str(entry) + '\n')
> +                       for e in self._as_entries():
> +                               f.write(str(e) + '\n')
>
>  def parse_file(path: str) -> Kconfig:
>         with open(path, 'r') as f:
> @@ -78,14 +89,12 @@ def parse_from_string(blob: str) -> Kconfig:
>
>                 match = config_matcher.match(line)
>                 if match:
> -                       entry = KconfigEntry(match.group(1), match.group(2))
> -                       kconfig.add_entry(entry)
> +                       kconfig.add_entry(match.group(1), match.group(2))
>                         continue
>
>                 empty_match = is_not_set_matcher.match(line)
>                 if empty_match:
> -                       entry = KconfigEntry(empty_match.group(1), 'n')
> -                       kconfig.add_entry(entry)
> +                       kconfig.add_entry(empty_match.group(1), 'n')
>                         continue
>
>                 if line[0] == '#':
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 3539efaf99ba..ebd2d91af710 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -53,8 +53,8 @@ class LinuxSourceTreeOperations:
>                 except subprocess.CalledProcessError as e:
>                         raise ConfigError(e.output.decode())
>
> -       def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> None:
> -               pass
> +       def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
> +               return base_kunitconfig
>
>         def make_allyesconfig(self, build_dir: str, make_options) -> None:
>                 raise ConfigError('Only the "um" arch is supported for alltests')
> @@ -109,9 +109,10 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
>                 self._kernel_command_line = qemu_arch_params.kernel_command_line + ' kunit_shutdown=reboot'
>                 self._extra_qemu_params = qemu_arch_params.extra_qemu_params
>
> -       def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> None:
> +       def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
>                 kconfig = kunit_config.parse_from_string(self._kconfig)
> -               base_kunitconfig.merge_in_entries(kconfig)
> +               kconfig.merge_in_entries(base_kunitconfig)
> +               return kconfig
>
>         def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
>                 kernel_path = os.path.join(build_dir, self._kernel_path)
> @@ -265,9 +266,10 @@ class LinuxSourceTree:
>         def validate_config(self, build_dir: str) -> bool:
>                 kconfig_path = get_kconfig_path(build_dir)
>                 validated_kconfig = kunit_config.parse_file(kconfig_path)
> -               if self._kconfig.is_subset_of(validated_kconfig):
> +               invalid = self._kconfig.set_diff(validated_kconfig)
> +               if not invalid:
>                         return True
> -               invalid = self._kconfig.entries() - validated_kconfig.entries()
> +
>                 message = 'Not all Kconfig options selected in kunitconfig were in the generated .config.\n' \
>                           'This is probably due to unsatisfied dependencies.\n' \
>                           'Missing: ' + ', '.join([str(e) for e in invalid])
> @@ -282,7 +284,7 @@ class LinuxSourceTree:
>                 if build_dir and not os.path.exists(build_dir):
>                         os.mkdir(build_dir)
>                 try:
> -                       self._ops.make_arch_qemuconfig(self._kconfig)
> +                       self._kconfig = self._ops.make_arch_qemuconfig(self._kconfig)
>                         self._kconfig.write_to_file(kconfig_path)
>                         self._ops.make_olddefconfig(build_dir, make_options)
>                 except ConfigError as e:
> @@ -303,7 +305,7 @@ class LinuxSourceTree:
>                         return True
>
>                 old_kconfig = kunit_config.parse_file(old_path)
> -               return old_kconfig.entries() != self._kconfig.entries()
> +               return old_kconfig != self._kconfig
>
>         def build_reconfig(self, build_dir: str, make_options) -> bool:
>                 """Creates a new .config if it is not a subset of the .kunitconfig."""
> @@ -313,7 +315,8 @@ class LinuxSourceTree:
>                         return self.build_config(build_dir, make_options)
>
>                 existing_kconfig = kunit_config.parse_file(kconfig_path)
> -               self._ops.make_arch_qemuconfig(self._kconfig)
> +               self._kconfig = self._ops.make_arch_qemuconfig(self._kconfig)
> +
>                 if self._kconfig.is_subset_of(existing_kconfig) and not self._kunitconfig_changed(build_dir):
>                         return True
>                 print('Regenerating .config ...')
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 25a2eb3bf114..3a8f638ff092 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -45,7 +45,7 @@ class KconfigTest(unittest.TestCase):
>                 self.assertTrue(kconfig0.is_subset_of(kconfig0))
>
>                 kconfig1 = kunit_config.Kconfig()
> -               kconfig1.add_entry(kunit_config.KconfigEntry('TEST', 'y'))
> +               kconfig1.add_entry('TEST', 'y')
>                 self.assertTrue(kconfig1.is_subset_of(kconfig1))
>                 self.assertTrue(kconfig0.is_subset_of(kconfig1))
>                 self.assertFalse(kconfig1.is_subset_of(kconfig0))
> @@ -56,40 +56,28 @@ class KconfigTest(unittest.TestCase):
>                 kconfig = kunit_config.parse_file(kconfig_path)
>
>                 expected_kconfig = kunit_config.Kconfig()
> -               expected_kconfig.add_entry(
> -                       kunit_config.KconfigEntry('UML', 'y'))
> -               expected_kconfig.add_entry(
> -                       kunit_config.KconfigEntry('MMU', 'y'))
> -               expected_kconfig.add_entry(
> -                       kunit_config.KconfigEntry('TEST', 'y'))
> -               expected_kconfig.add_entry(
> -                       kunit_config.KconfigEntry('EXAMPLE_TEST', 'y'))
> -               expected_kconfig.add_entry(
> -                       kunit_config.KconfigEntry('MK8', 'n'))
> -
> -               self.assertEqual(kconfig.entries(), expected_kconfig.entries())
> +               expected_kconfig.add_entry('UML', 'y')
> +               expected_kconfig.add_entry('MMU', 'y')
> +               expected_kconfig.add_entry('TEST', 'y')
> +               expected_kconfig.add_entry('EXAMPLE_TEST', 'y')
> +               expected_kconfig.add_entry('MK8', 'n')
> +
> +               self.assertEqual(kconfig, expected_kconfig)
>
>         def test_write_to_file(self):
>                 kconfig_path = os.path.join(test_tmpdir, '.config')
>
>                 expected_kconfig = kunit_config.Kconfig()
> -               expected_kconfig.add_entry(
> -                       kunit_config.KconfigEntry('UML', 'y'))
> -               expected_kconfig.add_entry(
> -                       kunit_config.KconfigEntry('MMU', 'y'))
> -               expected_kconfig.add_entry(
> -                       kunit_config.KconfigEntry('TEST', 'y'))
> -               expected_kconfig.add_entry(
> -                       kunit_config.KconfigEntry('EXAMPLE_TEST', 'y'))
> -               expected_kconfig.add_entry(
> -                       kunit_config.KconfigEntry('MK8', 'n'))
> +               expected_kconfig.add_entry('UML', 'y')
> +               expected_kconfig.add_entry('MMU', 'y')
> +               expected_kconfig.add_entry('TEST', 'y')
> +               expected_kconfig.add_entry('EXAMPLE_TEST', 'y')
> +               expected_kconfig.add_entry('MK8', 'n')
>
>                 expected_kconfig.write_to_file(kconfig_path)
>
>                 actual_kconfig = kunit_config.parse_file(kconfig_path)
> -
> -               self.assertEqual(actual_kconfig.entries(),
> -                                expected_kconfig.entries())
> +               self.assertEqual(actual_kconfig, expected_kconfig)
>
>  class KUnitParserTest(unittest.TestCase):
>
> @@ -381,8 +369,11 @@ class LinuxSourceTreeTest(unittest.TestCase):
>                         kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
>
>         def test_kconfig_add(self):
> +               want_kconfig = kunit_config.Kconfig()
> +               want_kconfig.add_entry('NOT_REAL', 'y')
> +
>                 tree = kunit_kernel.LinuxSourceTree('', kconfig_add=['CONFIG_NOT_REAL=y'])
> -               self.assertIn(kunit_config.KconfigEntry('NOT_REAL', 'y'), tree._kconfig.entries())
> +               self.assertFalse(want_kconfig.set_diff(tree._kconfig))
>
>         def test_invalid_arch(self):
>                 with self.assertRaisesRegex(kunit_kernel.ConfigError, 'not a valid arch, options are.*x86_64'):
>
> base-commit: 1b11063d32d7e11366e48be64215ff517ce32217
> --
> 2.36.1.124.g0e6072fb45-goog
>

--000000000000ccf9a505df6b6154
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
G7p3AiuB2sgfq6cOpbO5MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBsL34EJkCtu9Nu
2+R6l1Qzno5Gl+N2Cm6/YLujukDGYa1JW27txXiilR9dGP7yl60HYyG2Exd5i6fiLDlaNEw0SqzE
dw9ZSIak3Qvm2UybR8zcnB0deCUiwahqh7ZncEPlhnPpB08ETEUtwBEqCEnndNEkIN67yz4kniCZ
jZstNF/BUnI3864fATiXSbnNqBwlJS3YkoaCTpbI9qNTrf5VIvnbryT69xJ6f25yfmxrXNJJe5OG
ncB34Cwnb7xQyk+uRLZ465yUBkbjk9pC/yamL0O7SOGYUclrQl2c5zzGuVBD84YcQGDOK6gSPj6w
QuBfOooZPOyZZZ8AMih7J980MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC/
alf0qaXwa20cjHl888c+ckgVjj3r/4QIXHtOCpkX+jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA1MjAwNjEyNThaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAhea78VUkmCPriMjXG7gY
wZKAEUMaDbDmjU433BIMS9HyTz3UbGme/MJyvutC5SvX2W8NWcwDvIaH3ayvfG/vTwffUKZsyE6n
kidcLA3Vp/DLV5H4HAlQrIcl3DVO+5aJg0M9I3cbWiAzxj4IVWFi3FjE+cBdmYG1wE0F/IvAS0HK
NpD8XGjIWwTt4lwhIGRlgr2qI/qp08UcDlPcuMqd/7whP0NkRorRGbYsmHw1Kd6390rGxulNaHvB
I9QxeZTcTYz1+hO2W3TTaZ3tXXiImjgG7Eb2BEb2tq7oPykghja6I/7Pc9oCR9r0+bRSxL6Zv1Yl
2YQSKrXTNp8lPIKKqw==
--000000000000ccf9a505df6b6154--
