Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47880559466
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jun 2022 09:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiFXHzr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jun 2022 03:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiFXHzr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jun 2022 03:55:47 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6A662C10
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jun 2022 00:55:45 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n1so1967378wrg.12
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jun 2022 00:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=494sNG0jevsQ5eOF+sLvhxDwHulFbH8XJnEXla+m4HU=;
        b=I3ejSyihi/m7OoYsbyggmk6X2olMLvPVBAuSR9QVPfdsfuOqXCDomd4tSosIHwj/Au
         l4A6Q03Y4WMFR2iG15RsKfqCIT1pL/JCRtJe5pqR4F9PXQrEB9zD4WBGQkwYUXqBLd9X
         E5DBcHVsWNbaVhq//sE3SbKPpInHidVWpwWcGQmBTU2JZqVcSThPqlM6B7zFWSALcnJi
         oAQFlEwIbJ+A3GIKonGtNsF0VNNcSV8PnAt90NUVClscpKXQsQneHi4gER3KB5dZ2vIx
         XoUQbNY7yLSiLim2cuw+pw8obkw/d7ddqE2yq6obf7/X0cIEXcoT+yr2HTzkie0sYtQd
         GGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=494sNG0jevsQ5eOF+sLvhxDwHulFbH8XJnEXla+m4HU=;
        b=YmtfZoUuRW59R3rXktn+VzcxLuSiNdQONnL30/xsfv2vr0QTv0vg3qqiQJFM2HhCRt
         tvjiwmfpcoqj5lIr9kR3K9KudJOlHMiaq9unOlmpV+pMLi4kxqHvRzVZwpTpahwmDb2E
         ru7MVaPpV1j90rBvUAPMqbmyk5MSyphMYmsNcne5WoyY217er2C/eG/Ip92cDQqwNGMM
         dcJPJq40c6FcOHuoXykOy6bU0bxfeUwFdSxGkGJLqaoPVJJbIebyevp+7BlUgRV+NyOv
         rBNPhSOSDR16s9zjQDKjEEjwuAoOnP0dNJN5YNP7YyC7qyNos7mtS+SuS9UgdNZHz5dJ
         OToQ==
X-Gm-Message-State: AJIora8FeNS9hqiBHfdM6iMJx8uFZ0HCIK+V705kTGri3wdImKlVEsfC
        29V92aS772WW/6kaewF+pXPS9eAQOwV5cZNoXo0qBQ==
X-Google-Smtp-Source: AGRyM1usWU7CCeqhf/IlV/e39Lb0dB62vZjneQm38QAt5Is6f/MCE3sH9uco3E57rekjp74gR4OMHROnsEIDsM867yY=
X-Received: by 2002:a05:6000:144d:b0:21b:b3cc:162e with SMTP id
 v13-20020a056000144d00b0021bb3cc162emr1832894wrx.433.1656057343566; Fri, 24
 Jun 2022 00:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220520224200.3764027-1-dlatypov@google.com>
In-Reply-To: <20220520224200.3764027-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 24 Jun 2022 15:55:32 +0800
Message-ID: <CABVgOSkNpaY1HsygqkWC8LVO+XTqGwNxFNgne-ajoTiPqCnrkg@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: refactor internal kconfig handling, allow overriding
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b8762a05e22ce5ee"
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

--000000000000b8762a05e22ce5ee
Content-Type: text/plain; charset="UTF-8"

On Sat, May 21, 2022 at 6:42 AM Daniel Latypov <dlatypov@google.com> wrote:
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
> v1 -> v2: fix validate_config() func.
> There was a bug found by David, see
> https://lore.kernel.org/linux-kselftest/CAGS_qxpF338dvbB+6QW1n8_agddeS10+nkTQNmT+0UcvoE1gBw@mail.gmail.com/
> ---

Sorry for the delay, finally getting around to reviewing this version.

It looks good to me, and works well enough in testing that I've got no
real complaints. A couple of minor comments below, but nothing
actually worth doing a new version for, IMO.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/kunit_config.py    | 49 +++++++++++++++-----------
>  tools/testing/kunit/kunit_kernel.py    | 18 +++++-----
>  tools/testing/kunit/kunit_tool_test.py | 45 ++++++++++-------------
>  3 files changed, 57 insertions(+), 55 deletions(-)
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

It took me a couple of goes to realise that this was looking at the
difference between sets, not trying to set the difference. Maybe
different_entries() or something like that'd be clearer, but I can't
say it bothers me enough to be worth a new version.

Then again (as noted below), the direct set difference isn't exactly
what we want, it's more the equivalent of is_subset_of(). The
follow-up repeated-kunitconfig patch adds differing_options(), which
is closer to what we'd want, I think:
https://lore.kernel.org/linux-kselftest/20220624001247.3255978-1-dlatypov@google.com/

Probably easiest to accept this patch as-is, followed by those
follow-up ones, and adjust it then, if that's worth doing, though...

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
> index 3539efaf99ba..6d994bb24999 100644
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
> @@ -267,7 +268,7 @@ class LinuxSourceTree:
>                 validated_kconfig = kunit_config.parse_file(kconfig_path)
>                 if self._kconfig.is_subset_of(validated_kconfig):
>                         return True
> -               invalid = self._kconfig.entries() - validated_kconfig.entries()
> +               invalid = self._kconfig.set_diff(validated_kconfig)

The fact that the set 'invalid' is not actually equal to the set of
conflicting entries is_subset_of() finds bothers me slightly, though
due to the early return, I don't think it should ever be a problem in
pracitce.

Maybe having a 'subset_of' function, instead of set_diff, which does
the whole "not set" is equivalent to "n" check would be better?

Not worth changing this now, though: let's leave anything too heroic
for the next bout of kconfig-related stuff. (For example, there are
plans afoot to actually user CONFIG_x=n instead of is not set in the
files:
https://lore.kernel.org/lkml/CA+icZUXkd=dtbBX3UKLRzGiVSKC=TeW7ATiRKD9dnYtmm6RZqg@mail.gmail.com/T/


)

>                 message = 'Not all Kconfig options selected in kunitconfig were in the generated .config.\n' \
>                           'This is probably due to unsatisfied dependencies.\n' \
>                           'Missing: ' + ', '.join([str(e) for e in invalid])
> @@ -282,7 +283,7 @@ class LinuxSourceTree:
>                 if build_dir and not os.path.exists(build_dir):
>                         os.mkdir(build_dir)
>                 try:
> -                       self._ops.make_arch_qemuconfig(self._kconfig)
> +                       self._kconfig = self._ops.make_arch_qemuconfig(self._kconfig)
>                         self._kconfig.write_to_file(kconfig_path)
>                         self._ops.make_olddefconfig(build_dir, make_options)
>                 except ConfigError as e:
> @@ -303,7 +304,7 @@ class LinuxSourceTree:
>                         return True
>
>                 old_kconfig = kunit_config.parse_file(old_path)
> -               return old_kconfig.entries() != self._kconfig.entries()
> +               return old_kconfig != self._kconfig
>
>         def build_reconfig(self, build_dir: str, make_options) -> bool:
>                 """Creates a new .config if it is not a subset of the .kunitconfig."""
> @@ -313,7 +314,8 @@ class LinuxSourceTree:
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

--000000000000b8762a05e22ce5ee
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
z/tQRXr3iPeVmZCr7nttMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAx+EQjLATc/sze
VoZkH7OLz+/no1+y31x4BQ3wjW7lKfay9DAAVym896b7ECttSo95GEvS7pYMikzud57WypK7Bjpi
ep8YLarLRDrvyyvBuYtyDrIewkuASHtV1oy5E6QZZe2VOxMm6e2oJnFFjbflot4A08D3SwqDwV0i
OOYwT0BUtHYR/3903Dmdx5Alq+NDvUHDjozgo0f6oIkwDXT3yBV36utQ/jFisd36C8RD5mM+NFpu
3aqLXARRbKtxw29ErCwulof2dcAonG7cd5j+gmS84sLhKU+BhL1OQVXnJ5tj7xZ5Ri5I23brcwk0
lk/gWqfgs3ppT9Xk7zVit9q8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAQ
BfC5un9kwKMTEt13+jVIrGf651/ynmfrfnUJ9d8m8DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA2MjQwNzU1NDRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAKAdWiEqCtnAA1ZJOJurA
kOvRzgSwre8Oxl/P82i3UZkXuxHebrJLExBTmqfUSncXP0qm82uC3HIIEo88PHNtAnXe8im/XPPa
exXrW6rtcw5p3L597H9nq9CXI8yPmGEcS8gFm7mIvNCck5TxpbuVfAGLMdiwadXRC1DrDIzHe/2y
1HMyAyaRHdx4V/bTP2dogYoNbfcdEItauAH6L+Ts8jSn4vJA8F4O2HvYDe8qOJmOVXTk9I+4D4gb
JMQcL5QPSmTocQZ5lGJtynwcRkys+Z1KeZA4IKnCVk2tIqSaLUEzEInSMAAMOAMpoXWX/E9hL7zo
PcpI7DUkRhzP7Wcumg==
--000000000000b8762a05e22ce5ee--
