Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D40449AB2
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Nov 2021 18:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239249AbhKHR0N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Nov 2021 12:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239244AbhKHR0M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Nov 2021 12:26:12 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB05C061714
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Nov 2021 09:23:28 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id i12so17714119ila.12
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Nov 2021 09:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPGKd4TGs0XA53ASidhzNrF2fiRX7U5gxFXqgn9DTGg=;
        b=mmil4uIuW0TMFJfUrD8Awk1ufClyQY0B84wJmUVeU8dcqNzLmhiHK9a0H63pwIk8J6
         SHGq4db3QsIywsTOr7SIjKJdT6gjKBvr70pW5PIt18rOxFb0DxfP8OIUbqr4gvUqALRt
         GnwuUBXVKJ6SuOBxIamxE1lrg9o5LM87FdRjpT1IemhJa6UXXCPZFdjZ7i3yEVZmqXF0
         cZleouHPFCdQei12sI4+6ks2t9JSIR9zVLp0RZVt/cHQ9k8bd+qPcXOH1HIQOqdJ9Cmf
         707/4u6rBIKlFLUqBEO4kgeb/wW87bzFpktEuOdz3qUmkwp1Uuro+FzQcNkMJTZr+dBe
         5ShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPGKd4TGs0XA53ASidhzNrF2fiRX7U5gxFXqgn9DTGg=;
        b=1R53dy+H5ix4dlfR62ttdpR1k9KE2Xl18KEnaYhtQSCBOCR7WnfHeJ8S2fcOru1+2v
         KeMGNsy51xTb0UMvX1zE7YyDDmGlm4TOkCVmDv7UmN57kMIZVmHg3HRECP/h6rqtkBNt
         tjnE569nmb+kGDlaMTXdYP1c9DNa8eonHUriPG2QHtFgNNLhD4qGx7rPl9z2S9Rap6NS
         KzMAzvKaxU0lXl82YnYKXwvFAHXvhnVmAF0MRxx93mFHPFP9lIiIi+AxtgvUYcrg9sUG
         AG82/IlBL8DRDBj6A2W+SzHdYRb/jHXhYi5mEviivaE6oOTitDyLM417al4xvmixpfbl
         LKVg==
X-Gm-Message-State: AOAM532C90+KUZg3gPytqZm5FT9Z55DvrZ1+/PuppCTF0SlCSXHuP5dW
        ZLV4NT9++Re/w8O+Fftk0stmUc8QS6UNKHvKWMI5k9h2Flw=
X-Google-Smtp-Source: ABdhPJyq21dt4bsZMhivX/kONiVYXFOjQ5lZPDVxhT3N/tz/XXP/QLHoOjnYzwHNtmlH135DU+/ONIqIFBpneCSeAg4=
X-Received: by 2002:a05:6e02:20ea:: with SMTP id q10mr515654ilv.10.1636392207384;
 Mon, 08 Nov 2021 09:23:27 -0800 (PST)
MIME-Version: 1.0
References: <20211106013058.2621799-1-dlatypov@google.com> <20211106013058.2621799-2-dlatypov@google.com>
 <CABVgOSnQ9qGtu0nEKePH+Zb1oR2osmVh791zyQ9P61SNznryrw@mail.gmail.com>
In-Reply-To: <CABVgOSnQ9qGtu0nEKePH+Zb1oR2osmVh791zyQ9P61SNznryrw@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 8 Nov 2021 09:23:16 -0800
Message-ID: <CAGS_qxr3qd4b=00B76qN5GpFBa9aYa4UBFPvR505F3PbF5HSmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: tool: add --kconfig_add to allow easily
 tweaking kunitconfigs
To:     David Gow <davidgow@google.com>
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 5, 2021 at 9:07 PM David Gow <davidgow@google.com> wrote:
>
> On Sat, Nov 6, 2021 at 9:31 AM 'Daniel Latypov' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > E.g. run tests but with KASAN
> > $ ./tools/testing/kunit/kunit.py run --arch=x86_64 --kconfig_add=CONFIG_KASAN=y
>
> This is very neat, thank you. I'm definitely going to use this quite a bit.
>
> My only real note is that we'll need to add some documentation (but
> since the KUnit documentation is being reworked at the moment, I'm
> okay with doing that later to avoid merge conflicts).

Yeah, there's that and I was also unsure where exactly to mention it.
I'd also want there to be the caveat about how removing the option
won't trigger a rebuild.
The part where we have that right now is really early on and doesn't
need more stuff added there:
https://www.kernel.org/doc/html/latest/dev-tools/kunit/start.html#creating-a-kunitconfig

>
> > This also works with --kunitconfig
> > $ ./tools/testing/kunit/kunit.py run --arch=x86_64 --kunitconfig=fs/ext4 --kconfig_add=CONFIG_KASAN=y
>
> It's also worth noting that this can be appended multiple times to set
> multiple options, which is useful

Ah yeah, this could be called out in the commit desc if we want a v2.
Checking the examples in the link down below, TuxMake doesn't actually
include one with it being repeated.
I had been banking on readers of this message assuming that it could
be repeated either from previous familiarity with TuxMake or by
clicking that link.

But for tweaks that require multiple options, I'm personally going to
stick with --kunitconfig and heredocs.
E.g. coverage requires appending 3 kconfigs, so I'm sticking with

./tools/testing/kunit/kunit.py run --make_options=CC=/usr/bin/gcc-6
--kunitconfig /dev/stdin <<EOF
CONFIG_KUNIT=y
CONFIG_KUNIT_ALL_TESTS=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_INFO=y
CONFIG_GCOV=y
EOF

>
> > This flag is inspired by TuxMake's --kconfig-add, see
> > https://gitlab.com/Linaro/tuxmake#examples.
> >
> > Our version just uses "_" as the delimiter for consistency with
> > pre-existing flags like --build_dir, --make_options, --kernel_args, etc.
> >
> > Note: this does make it easier to run into a pre-existing edge case:
> > $ ./tools/testing/kunit/kunit.py run --arch=x86_64 --kconfig_add=CONFIG_KASAN=y
> > $ ./tools/testing/kunit/kunit.py run --arch=x86_64
> > This second invocation ^ still has KASAN enabled!
>
> This behaviour is quite useful, and actually means we can turn on
> individual items with
> $ ./tools/testing/kunit/kunit.py config --kconfig_add=<option>

Yes, that also works.
I didn't really want to call that out, however.

I ultimately would like this option to make it easier to have kunit
commands be more declarative and less dependent on state.

E.g. instead of
$ cp fs/ext4/.kunitconfig .kunit/.kunitconfig
$ echo "CONFIG_KASAN=y" >> .kunit/.kunitconfig
$ ./tools/testing/kunit/kunit.py run --arch=x86_64

it's now just one line and I'm less likely to miss a step, etc.
$ ./tools/testing/kunit/kunit.py run --arch=x86_64
--kunitconfig=fs/ext4 --kconfig_add=CONFIG_KASAN=y

A user could alternatively do this via
$ ./tools/testing/kunit/kunit.py config --arch=x86_64
--kunitconfig=fs/ext4 --kconfig_add=CONFIG_KASAN=y
$ ./tools/testing/kunit/kunit.py config --arch=x86_64
--kconfig_add=CONFIG_ANOTHER_OPTION=y
$ ./tools/testing/kunit/kunit.py build
$ ./tools/testing/kunit/kunit.py exec --arch=x86_64


>
> > kunit.py won't call olddefconfig if our current .config is already a
> > superset of the provided kunitconfig.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
>
> Looks good.
>
> Reviewed-by: David Gow <davidgow@google.com>
>
>
> > ---
> >  tools/testing/kunit/kunit.py           |  8 ++++++++
> >  tools/testing/kunit/kunit_kernel.py    |  5 +++++
> >  tools/testing/kunit/kunit_tool_test.py | 18 ++++++++++++++++++
> >  3 files changed, 31 insertions(+)
> >
> > diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> > index 68e6f461c758..be58f4c93806 100755
> > --- a/tools/testing/kunit/kunit.py
> > +++ b/tools/testing/kunit/kunit.py
> > @@ -280,6 +280,10 @@ def add_common_opts(parser) -> None:
> >                              ' If given a directory, (e.g. lib/kunit), "/.kunitconfig" '
> >                              'will get  automatically appended.',
> >                              metavar='kunitconfig')
> > +       parser.add_argument('--kconfig_add',
> > +                            help='Additional Kconfig options to append to the '
> > +                            '.kunitconfig, e.g. CONFIG_KASAN=y. Can be repeated.',
> > +                           action='append')
> >
> >         parser.add_argument('--arch',
> >                             help=('Specifies the architecture to run tests under. '
> > @@ -398,6 +402,7 @@ def main(argv, linux=None):
> >                 if not linux:
> >                         linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> >                                         kunitconfig_path=cli_args.kunitconfig,
> > +                                       kconfig_add=cli_args.kconfig_add,
> >                                         arch=cli_args.arch,
> >                                         cross_compile=cli_args.cross_compile,
> >                                         qemu_config_path=cli_args.qemu_config)
> > @@ -423,6 +428,7 @@ def main(argv, linux=None):
> >                 if not linux:
> >                         linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> >                                         kunitconfig_path=cli_args.kunitconfig,
> > +                                       kconfig_add=cli_args.kconfig_add,
> >                                         arch=cli_args.arch,
> >                                         cross_compile=cli_args.cross_compile,
> >                                         qemu_config_path=cli_args.qemu_config)
> > @@ -439,6 +445,7 @@ def main(argv, linux=None):
> >                 if not linux:
> >                         linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> >                                         kunitconfig_path=cli_args.kunitconfig,
> > +                                       kconfig_add=cli_args.kconfig_add,
> >                                         arch=cli_args.arch,
> >                                         cross_compile=cli_args.cross_compile,
> >                                         qemu_config_path=cli_args.qemu_config)
> > @@ -457,6 +464,7 @@ def main(argv, linux=None):
> >                 if not linux:
> >                         linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> >                                         kunitconfig_path=cli_args.kunitconfig,
> > +                                       kconfig_add=cli_args.kconfig_add,
> >                                         arch=cli_args.arch,
> >                                         cross_compile=cli_args.cross_compile,
> >                                         qemu_config_path=cli_args.qemu_config)
> > diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> > index 51ee6e5dae91..7d459d6d6ff2 100644
> > --- a/tools/testing/kunit/kunit_kernel.py
> > +++ b/tools/testing/kunit/kunit_kernel.py
> > @@ -224,6 +224,7 @@ class LinuxSourceTree(object):
> >               build_dir: str,
> >               load_config=True,
> >               kunitconfig_path='',
> > +             kconfig_add: Optional[List[str]]=None,
> >               arch=None,
> >               cross_compile=None,
> >               qemu_config_path=None) -> None:
> > @@ -249,6 +250,10 @@ class LinuxSourceTree(object):
> >                                 shutil.copyfile(DEFAULT_KUNITCONFIG_PATH, kunitconfig_path)
> >
> >                 self._kconfig = kunit_config.parse_file(kunitconfig_path)
> > +               if kconfig_add:
> > +                       kconfig = kunit_config.parse_from_string('\n'.join(kconfig_add))
> > +                       self._kconfig.merge_in_entries(kconfig)
> > +
> >
> >         def clean(self) -> bool:
> >                 try:
> > diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> > index 4ec70e41ec5a..7e42a7c27987 100755
> > --- a/tools/testing/kunit/kunit_tool_test.py
> > +++ b/tools/testing/kunit/kunit_tool_test.py
> > @@ -334,6 +334,10 @@ class LinuxSourceTreeTest(unittest.TestCase):
> >                                 pass
> >                         kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
> >
> > +       def test_kconfig_add(self):
> > +               tree = kunit_kernel.LinuxSourceTree('', kconfig_add=['CONFIG_NOT_REAL=y'])
> > +               self.assertIn(kunit_config.KconfigEntry('NOT_REAL', 'y'), tree._kconfig.entries())
> > +
> >         def test_invalid_arch(self):
> >                 with self.assertRaisesRegex(kunit_kernel.ConfigError, 'not a valid arch, options are.*x86_64'):
> >                         kunit_kernel.LinuxSourceTree('', arch='invalid')
> > @@ -540,6 +544,7 @@ class KUnitMainTest(unittest.TestCase):
> >                 # Just verify that we parsed and initialized it correctly here.
> >                 mock_linux_init.assert_called_once_with('.kunit',
> >                                                         kunitconfig_path='mykunitconfig',
> > +                                                       kconfig_add=None,
> >                                                         arch='um',
> >                                                         cross_compile=None,
> >                                                         qemu_config_path=None)
> > @@ -551,6 +556,19 @@ class KUnitMainTest(unittest.TestCase):
> >                 # Just verify that we parsed and initialized it correctly here.
> >                 mock_linux_init.assert_called_once_with('.kunit',
> >                                                         kunitconfig_path='mykunitconfig',
> > +                                                       kconfig_add=None,
> > +                                                       arch='um',
> > +                                                       cross_compile=None,
> > +                                                       qemu_config_path=None)
> > +
> > +       @mock.patch.object(kunit_kernel, 'LinuxSourceTree')
> > +       def test_run_kconfig_add(self, mock_linux_init):
> > +               mock_linux_init.return_value = self.linux_source_mock
> > +               kunit.main(['run', '--kconfig_add=CONFIG_KASAN=y', '--kconfig_add=CONFIG_KCSAN=y'])
> > +               # Just verify that we parsed and initialized it correctly here.
> > +               mock_linux_init.assert_called_once_with('.kunit',
> > +                                                       kunitconfig_path=None,
> > +                                                       kconfig_add=['CONFIG_KASAN=y', 'CONFIG_KCSAN=y'],
> >                                                         arch='um',
> >                                                         cross_compile=None,
> >                                                         qemu_config_path=None)
> > --
> > 2.34.0.rc0.344.g81b53c2807-goog
> >
> > --
> > You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20211106013058.2621799-2-dlatypov%40google.com.
