Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04AA559462
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jun 2022 09:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiFXHzx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jun 2022 03:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiFXHzw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jun 2022 03:55:52 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3B0680A7
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jun 2022 00:55:50 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u12-20020a05600c210c00b003a02b16d2b8so1037824wml.2
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jun 2022 00:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FuPdwaJOumry1o+OEMMb2mukBqvVhMmTbNzsrTUe5YI=;
        b=TJaEglpDw1/MHB3uZR0QuWMJiBEuvjdje3LQ56H40Dxm1P8ZTgQIHBO4MGHOJOGomi
         AySSUUGTj7ELjYjAz8MU7406R82/yV+gmilzClngfqBy0zrFN/KnuTtkGiRhbS2Z1irr
         C88MNOUl0kUaB+a4sZ7m89DLWcAr7AcAEWcOZ12pnVGU3dDOQLzt3IiRkqilY0Y7jkZb
         C1+0VpDElCGJNrU5A5B3HXLW3z1m7KFw/dVKbCoYoz6AJk+K7RWCQodnYP4YV4Q3T5Q1
         3LEmAIWp1uu4Z8+jSnhfSrpJ3q/97w3Tc4GzlXDtYmVvMtzXmMUh8Km+mpTY3BPIS6Fx
         whnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FuPdwaJOumry1o+OEMMb2mukBqvVhMmTbNzsrTUe5YI=;
        b=qaZFnZUIdjkXIcSBoPhEMPbfjhUvby6JxW6L7ztjuNs+ja4lFgD02i9rq+UlNxVAPF
         c2tq9NOhv3BJ1dE5vxg7sDvZ9Lfv/GgiDNhiJVqc9AWfFi13x/hkdhFcyg7biQ7UvNe1
         x3siI3/yqE3xVW6yhmuWcrECUvRLAiKEPcrHqwfRI0uV36HtZ9e2gtEfmFWYQjupb1Zp
         KsCX1slml06jwDYQ79EwZyvJHICl8YLTEntO8c7tQXr2s+yzFs/joQGqHpllPPCTbPGB
         ug4tkQjb6cNMJMTmTzkVJoY56t+oeJLuY3JhE1g9GNEdvAs7UcyR+RUwVGYvtQLKnaih
         xXrQ==
X-Gm-Message-State: AJIora9rbmrIhdoyqKpecBVkDlSUDBPewgBOdSCLV8ttkAFM7MJ/EV1t
        n90NY39LEstvCxFHvxH8O4EfpHEoY/lAtkhx0z3+xw==
X-Google-Smtp-Source: AGRyM1v/QpULA4/qkE8ntvsbvz8gO2EKn6ZdJ2sQuiUV31Fmzj4sFTiL0oxIKy6l7CtBqdvV2IrThFjbW5wf0FTI5RM=
X-Received: by 2002:a05:600c:34ce:b0:3a0:3b4b:9022 with SMTP id
 d14-20020a05600c34ce00b003a03b4b9022mr1958165wmq.66.1656057349105; Fri, 24
 Jun 2022 00:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220624001247.3255978-1-dlatypov@google.com>
In-Reply-To: <20220624001247.3255978-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 24 Jun 2022 15:55:37 +0800
Message-ID: <CABVgOS=Df6uWE3O82Ypair5fMCA6zOkVQg7tS9Acv+bAiwXhDg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: tool: make --kunitconfig repeatable, blindly concat
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000000bc93305e22ce650"
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

--0000000000000bc93305e22ce650
Content-Type: text/plain; charset="UTF-8"

On Fri, Jun 24, 2022 at 8:12 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> It's come up a few times that it would be useful to have --kunitconfig
> be repeatable [1][2].
>
> This could be done before with a bit of shell-fu, e.g.
>   $ find fs/ -name '.kunitconfig' -exec cat {} + | \
>     ./tools/testing/kunit/kunit.py run --kunitconfig=/dev/stdin
> or equivalently:
>   $ cat fs/ext4/.kunitconfig fs/fat/.kunitconfig | \
>     ./tools/testing/kunit/kunit.py run --kunitconfig=/dev/stdin
>
> But this can be fairly clunky to use in practice.
>
> And having explicit support in kunit.py opens the door to having more
> config fragments of interest, e.g. options for PCI on UML [1], UML
> coverage [2], variants of tests [3].
> There's another argument to be made that users can just use multiple
> --kconfig_add's, but this gets very clunky very fast (e.g. [2]).
>
> Note: there's a big caveat here that some kconfig options might be
> incompatible. We try to give a clearish error message in the simple case
> where the same option appears multiple times with conflicting values,
> but more subtle ones (e.g. mutually exclusive options) will be
> potentially very confusing for the user. I don't know we can do better.
>
> Note 2: if you want to combine a --kunitconfig with the default, you
> either have to do to specify the current build_dir
> > --kunitconfig=.kunit --kunitconfig=additional.config
> or
> > --kunitconfig=tools/testing/kunit/configs/default.config --kunitconifg=additional.config
> each of which have their downsides (former depends on --build_dir,
> doesn't work if you don't have a .kunitconfig yet), etc.
>
> Example with conflicting values:
> > $ ./tools/testing/kunit/kunit.py config --kunitconfig=lib/kunit --kunitconfig=/dev/stdin <<EOF
> > CONFIG_KUNIT_TEST=n
> > CONFIG_KUNIT=m
> > EOF
> > ...
> > kunit_kernel.ConfigError: Multiple values specified for 2 options in kunitconfig:
> > CONFIG_KUNIT=y
> >   vs from /dev/stdin
> > CONFIG_KUNIT=m
> >
> > CONFIG_KUNIT_TEST=y
> >   vs from /dev/stdin
> > # CONFIG_KUNIT_TEST is not set
>
> [1] https://lists.freedesktop.org/archives/dri-devel/2022-June/357616.html
> [2] https://lore.kernel.org/linux-kselftest/CAFd5g45f3X3xF2vz2BkTHRqOC4uW6GZxtUUMaP5mwwbK8uNVtA@mail.gmail.com/
> [3] https://lore.kernel.org/linux-kselftest/CANpmjNOdSy6DuO6CYZ4UxhGxqhjzx4tn0sJMbRqo2xRFv9kX6Q@mail.gmail.com/
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---
>
> NOTE: this series is based on https://lore.kernel.org/linux-kselftest/20220520224200.3764027-1-dlatypov@google.com/
> That patch redoes kunitconfig parsing, so we'd have merge conflicts
> either way we order these.
>
> ---

This looks good, and works for me (and is proving useful already).

I do think we're approaching a level of confusion with the number of
different ways kconfig options are added, so we'll need to update the
documentation once all of these related patches land.

In particular, we now have the following sources of kconfig options:
- defaults in the actual Kconfig files (and, potentially, kernel
architecture defconfigs)
- kunit_tool architecture specific (e.g. qemu_config) Kconfig entries
- the "default" kunitconfig, which is copied into the build dir, and
that copy is only used if --kunitconfig is not passed.
- other kunitconfig(s) passed with --kunitconfig, some of which live
in tools/testing/kunit/configs, some of which live in
subsystem-specific directories
- command-line --kconfig_add options

Exactly when each of these apply, whether they error if they conflict,
or override each other, and when to use them is not always obvious.
Still, it's working pretty well in practice, so I think the solution
is probably going to be having good examples and documentation, and
responding well to any questions.

In any case, the code for this looks good to me -- my only minor
annoyance is the churn renaming kunitconfig_path -> kunitconfig_paths
gives, and that's a temporary inconvenience -- so this is:
Reviewed-by: David Gow <davidgow@google.com>


Cheers,
-- David



>  tools/testing/kunit/kunit.py           | 13 ++++---
>  tools/testing/kunit/kunit_config.py    | 11 +++++-
>  tools/testing/kunit/kunit_kernel.py    | 38 ++++++++++++------
>  tools/testing/kunit/kunit_tool_test.py | 54 +++++++++++++++++++++++---
>  4 files changed, 91 insertions(+), 25 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 13bd72e47da8..163f6b8ac464 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -291,8 +291,9 @@ def add_common_opts(parser) -> None:
>         parser.add_argument('--kunitconfig',
>                              help='Path to Kconfig fragment that enables KUnit tests.'
>                              ' If given a directory, (e.g. lib/kunit), "/.kunitconfig" '
> -                            'will get  automatically appended.',
> -                            metavar='PATH')
> +                            'will get  automatically appended. If repeated, the files '
> +                            'blindly concatenated, which might not work in all cases.',
> +                            action='append', metavar='PATHS')
>         parser.add_argument('--kconfig_add',
>                              help='Additional Kconfig options to append to the '
>                              '.kunitconfig, e.g. CONFIG_KASAN=y. Can be repeated.',
> @@ -414,7 +415,7 @@ def main(argv, linux=None):
>
>                 if not linux:
>                         linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> -                                       kunitconfig_path=cli_args.kunitconfig,
> +                                       kunitconfig_paths=cli_args.kunitconfig,
>                                         kconfig_add=cli_args.kconfig_add,
>                                         arch=cli_args.arch,
>                                         cross_compile=cli_args.cross_compile,
> @@ -440,7 +441,7 @@ def main(argv, linux=None):
>
>                 if not linux:
>                         linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> -                                       kunitconfig_path=cli_args.kunitconfig,
> +                                       kunitconfig_paths=cli_args.kunitconfig,
>                                         kconfig_add=cli_args.kconfig_add,
>                                         arch=cli_args.arch,
>                                         cross_compile=cli_args.cross_compile,
> @@ -457,7 +458,7 @@ def main(argv, linux=None):
>         elif cli_args.subcommand == 'build':
>                 if not linux:
>                         linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> -                                       kunitconfig_path=cli_args.kunitconfig,
> +                                       kunitconfig_paths=cli_args.kunitconfig,
>                                         kconfig_add=cli_args.kconfig_add,
>                                         arch=cli_args.arch,
>                                         cross_compile=cli_args.cross_compile,
> @@ -476,7 +477,7 @@ def main(argv, linux=None):
>         elif cli_args.subcommand == 'exec':
>                 if not linux:
>                         linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> -                                       kunitconfig_path=cli_args.kunitconfig,
> +                                       kunitconfig_paths=cli_args.kunitconfig,
>                                         kconfig_add=cli_args.kconfig_add,
>                                         arch=cli_args.arch,
>                                         cross_compile=cli_args.cross_compile,
> diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
> index 89443400b17e..05b129030c6e 100644
> --- a/tools/testing/kunit/kunit_config.py
> +++ b/tools/testing/kunit/kunit_config.py
> @@ -8,7 +8,7 @@
>
>  from dataclasses import dataclass
>  import re
> -from typing import Dict, Iterable, Set
> +from typing import Dict, Iterable, List, Set, Tuple
>
>  CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_(\w+) is not set$'
>  CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+|".*")$'
> @@ -64,6 +64,15 @@ class Kconfig:
>         def set_diff(self, other: 'Kconfig') -> Set[KconfigEntry]:
>                 return set(self._as_entries()) - set(other._as_entries())
>
> +       def differing_options(self, other: 'Kconfig') -> List[Tuple[KconfigEntry, KconfigEntry]]:
> +               diff = []  # type: List[Tuple[KconfigEntry, KconfigEntry]]
> +               for name, value in self._entries.items():
> +                       b = other._entries.get(name)
> +                       if b and value != b:
> +                               pair = (KconfigEntry(name, value), KconfigEntry(name, b))
> +                               diff.append(pair)
> +               return diff
> +
>         def merge_in_entries(self, other: 'Kconfig') -> None:
>                 for name, value in other._entries.items():
>                         self._entries[name] = value
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 6d994bb24999..fc415ff7530e 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -176,6 +176,30 @@ def get_kunitconfig_path(build_dir: str) -> str:
>  def get_old_kunitconfig_path(build_dir: str) -> str:
>         return os.path.join(build_dir, OLD_KUNITCONFIG_PATH)
>
> +def get_parsed_kunitconfig(build_dir: str,
> +                          kunitconfig_paths: Optional[List[str]]=None) -> kunit_config.Kconfig:
> +       if not kunitconfig_paths:
> +               path = get_kunitconfig_path(build_dir)
> +               if not os.path.exists(path):
> +                       shutil.copyfile(DEFAULT_KUNITCONFIG_PATH, path)
> +               return kunit_config.parse_file(path)
> +
> +       merged = kunit_config.Kconfig()
> +
> +       for path in kunitconfig_paths:
> +               if os.path.isdir(path):
> +                       path = os.path.join(path, KUNITCONFIG_PATH)
> +               if not os.path.exists(path):
> +                       raise ConfigError(f'Specified kunitconfig ({path}) does not exist')
> +
> +               partial = kunit_config.parse_file(path)
> +               diff = merged.differing_options(partial)
> +               if diff:
> +                       diff_str = '\n\n'.join(f'{a}\n  vs from {path}\n{b}' for a, b in diff)
> +                       raise ConfigError(f'Multiple values specified for {len(diff)} options in kunitconfig:\n{diff_str}')
> +               merged.merge_in_entries(partial)
> +       return merged
> +
>  def get_outfile_path(build_dir: str) -> str:
>         return os.path.join(build_dir, OUTFILE_PATH)
>
> @@ -221,7 +245,7 @@ class LinuxSourceTree:
>               self,
>               build_dir: str,
>               load_config=True,
> -             kunitconfig_path='',
> +             kunitconfig_paths: Optional[List[str]]=None,
>               kconfig_add: Optional[List[str]]=None,
>               arch=None,
>               cross_compile=None,
> @@ -237,17 +261,7 @@ class LinuxSourceTree:
>                 if not load_config:
>                         return
>
> -               if kunitconfig_path:
> -                       if os.path.isdir(kunitconfig_path):
> -                               kunitconfig_path = os.path.join(kunitconfig_path, KUNITCONFIG_PATH)
> -                       if not os.path.exists(kunitconfig_path):
> -                               raise ConfigError(f'Specified kunitconfig ({kunitconfig_path}) does not exist')
> -               else:
> -                       kunitconfig_path = get_kunitconfig_path(build_dir)
> -                       if not os.path.exists(kunitconfig_path):
> -                               shutil.copyfile(DEFAULT_KUNITCONFIG_PATH, kunitconfig_path)
> -
> -               self._kconfig = kunit_config.parse_file(kunitconfig_path)
> +               self._kconfig = get_parsed_kunitconfig(build_dir, kunitconfig_paths)
>                 if kconfig_add:
>                         kconfig = kunit_config.parse_from_string('\n'.join(kconfig_add))
>                         self._kconfig.merge_in_entries(kconfig)
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 3a8f638ff092..e21ae1331350 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -356,17 +356,46 @@ class LinuxSourceTreeTest(unittest.TestCase):
>
>         def test_invalid_kunitconfig(self):
>                 with self.assertRaisesRegex(kunit_kernel.ConfigError, 'nonexistent.* does not exist'):
> -                       kunit_kernel.LinuxSourceTree('', kunitconfig_path='/nonexistent_file')
> +                       kunit_kernel.LinuxSourceTree('', kunitconfig_paths=['/nonexistent_file'])
>
>         def test_valid_kunitconfig(self):
>                 with tempfile.NamedTemporaryFile('wt') as kunitconfig:
> -                       kunit_kernel.LinuxSourceTree('', kunitconfig_path=kunitconfig.name)
> +                       kunit_kernel.LinuxSourceTree('', kunitconfig_paths=[kunitconfig.name])
>
>         def test_dir_kunitconfig(self):
>                 with tempfile.TemporaryDirectory('') as dir:
>                         with open(os.path.join(dir, '.kunitconfig'), 'w'):
>                                 pass
> -                       kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
> +                       kunit_kernel.LinuxSourceTree('', kunitconfig_paths=[dir])
> +
> +       def test_multiple_kunitconfig(self):
> +               want_kconfig = kunit_config.Kconfig()
> +               want_kconfig.add_entry('KUNIT', 'y')
> +               want_kconfig.add_entry('KUNIT_TEST', 'm')
> +
> +               with tempfile.TemporaryDirectory('') as dir:
> +                       other = os.path.join(dir, 'otherkunitconfig')
> +                       with open(os.path.join(dir, '.kunitconfig'), 'w') as f:
> +                               f.write('CONFIG_KUNIT=y')
> +                       with open(other, 'w') as f:
> +                               f.write('CONFIG_KUNIT_TEST=m')
> +                               pass
> +
> +                       tree = kunit_kernel.LinuxSourceTree('', kunitconfig_paths=[dir, other])
> +                       self.assertFalse(want_kconfig.set_diff(tree._kconfig))
> +
> +
> +       def test_multiple_kunitconfig_invalid(self):
> +               with tempfile.TemporaryDirectory('') as dir:
> +                       other = os.path.join(dir, 'otherkunitconfig')
> +                       with open(os.path.join(dir, '.kunitconfig'), 'w') as f:
> +                               f.write('CONFIG_KUNIT=y')
> +                       with open(other, 'w') as f:
> +                               f.write('CONFIG_KUNIT=m')
> +
> +                       with self.assertRaisesRegex(kunit_kernel.ConfigError, '(?s)Multiple values.*CONFIG_KUNIT'):
> +                               kunit_kernel.LinuxSourceTree('', kunitconfig_paths=[dir, other])
> +
>
>         def test_kconfig_add(self):
>                 want_kconfig = kunit_config.Kconfig()
> @@ -637,7 +666,7 @@ class KUnitMainTest(unittest.TestCase):
>                 kunit.main(['run', '--kunitconfig=mykunitconfig'])
>                 # Just verify that we parsed and initialized it correctly here.
>                 mock_linux_init.assert_called_once_with('.kunit',
> -                                                       kunitconfig_path='mykunitconfig',
> +                                                       kunitconfig_paths=['mykunitconfig'],
>                                                         kconfig_add=None,
>                                                         arch='um',
>                                                         cross_compile=None,
> @@ -649,19 +678,32 @@ class KUnitMainTest(unittest.TestCase):
>                 kunit.main(['config', '--kunitconfig=mykunitconfig'])
>                 # Just verify that we parsed and initialized it correctly here.
>                 mock_linux_init.assert_called_once_with('.kunit',
> -                                                       kunitconfig_path='mykunitconfig',
> +                                                       kunitconfig_paths=['mykunitconfig'],
>                                                         kconfig_add=None,
>                                                         arch='um',
>                                                         cross_compile=None,
>                                                         qemu_config_path=None)
>
> +       @mock.patch.object(kunit_kernel, 'LinuxSourceTree')
> +       def test_run_multiple_kunitconfig(self, mock_linux_init):
> +               mock_linux_init.return_value = self.linux_source_mock
> +               kunit.main(['run', '--kunitconfig=mykunitconfig', '--kunitconfig=other'])
> +               # Just verify that we parsed and initialized it correctly here.
> +               mock_linux_init.assert_called_once_with('.kunit',
> +                                                       kunitconfig_paths=['mykunitconfig', 'other'],
> +                                                       kconfig_add=None,
> +                                                       arch='um',
> +                                                       cross_compile=None,
> +                                                       qemu_config_path=None)
> +
> +
>         @mock.patch.object(kunit_kernel, 'LinuxSourceTree')
>         def test_run_kconfig_add(self, mock_linux_init):
>                 mock_linux_init.return_value = self.linux_source_mock
>                 kunit.main(['run', '--kconfig_add=CONFIG_KASAN=y', '--kconfig_add=CONFIG_KCSAN=y'])
>                 # Just verify that we parsed and initialized it correctly here.
>                 mock_linux_init.assert_called_once_with('.kunit',
> -                                                       kunitconfig_path=None,
> +                                                       kunitconfig_paths=None,
>                                                         kconfig_add=['CONFIG_KASAN=y', 'CONFIG_KCSAN=y'],
>                                                         arch='um',
>                                                         cross_compile=None,
> --
> 2.37.0.rc0.104.g0611611a94-goog
>

--0000000000000bc93305e22ce650
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDo
KCsfPJSxT/6h0YwSDu4yT/6ui8owz5LuuJiE5IbQWzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA2MjQwNzU1NDlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAjSZcZdYyf7lFJXk8J6SZ
9YA5DnV+NtfQokwfS7PriFId2GNrL0POyjpOM/CWVzTzFp5zO6BjQq7WIB3wxmNXzMz9boBLPiRk
jn0wbGTwchYqdhmuyKn9k0bsEqFr7akqBOGKMNzBnwQqEL9thC6UMs/ONdqoGacGoZR5s2n4A/Yq
3vauKNpd7pBPBZoA5HADj7rtey/I8sSkwDgpfBRHdTv+g/8AIn3rt33jE0GSTd2nPMmTIlzEE8ay
IG1RkJDtePBY1DWcUVS1MDpvgSYilqUeVV8Ea8Qq68ytsmGWwFE7nN2hxEuPCDhKxk56KhDOU4kU
dk0mZHN1/knnOMQ3zg==
--0000000000000bc93305e22ce650--
