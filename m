Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4538646C7AD
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 23:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhLGWuQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 17:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbhLGWuQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 17:50:16 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17DDC061746
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Dec 2021 14:46:45 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 137so391590pgg.3
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Dec 2021 14:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qo2gY9GkL4/3JxkwIdvL8NrT6jxwYuRAOPwQ/50yNqM=;
        b=fDXu9wWpReTzmmw0klosA3lK2h7JpNj+kabdgROoCxvh07v3DlpQzK9zRpYVgqpsDn
         Ee1V3C23ImrW6FmLBU2UhHrSHybZlyKUn/d9MmVhhx4UO8GpanF7FLi1DY7eZG+OO1uZ
         +0jusIKy7z+1cTdp2b3dTSIPPPW2FqKBarfv8tzDdaPkLtTzeG61Uj/97cJzEVn1v6i+
         vxF9l82YyhpgdALKZNV1L4pFvXqYgKwqwUEMwzi910eCHDEUuP30bhCZrFe2kuY9cpmq
         eX6LQdV0GhAfQB/Ec9ccBVKRDs/crCVdnUtswtQftX2NDL+PcGG/P5r2gzQTJa71YjC4
         zG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qo2gY9GkL4/3JxkwIdvL8NrT6jxwYuRAOPwQ/50yNqM=;
        b=tg5INcBeLdmIXBBckMPGTbvR72oJZMYmy8idH5tNYF7OwBWi2bckPlrbCi/oohC2+X
         ih+Oder3Asy+clodFsom9WneOZSgKIEytKpVpyr10AZfdNSHzXAemBpYZYyIrh16iBjT
         Yp+VF3CX5joJ/PuOO6Rz7+JcTcjKqjHuoGce8HS4XCKB2zV6kFTEbgGKBUCmrVXqhK+D
         yfmgj8bMcL0HfQ/ZhBLC/hvnMb4axTlxrqEDzrP9aQQiMzyjgVW3zHd/6LZ2gXFAODQ5
         qen9bDLDG3ax1Php8+NuBovErxeW/qWdqGE1DyglDITXXhS8FCR8gNGT+FmRy1PuVv3U
         JLVw==
X-Gm-Message-State: AOAM533+Q0QVYn21cc913iE05kDnsyP8aciqIdROIklGVi8AbeBYl5x4
        cbNhneda4xOtcpwEMExqPdvxQ66MIJKaNqR+xzaH0g==
X-Google-Smtp-Source: ABdhPJy+oA7nnc/C43NR8k9jnC+Den9LQj2xcpi0XhY+QR1GXKFlMHp+x7rUBtESBtf4d8/NY3VYxrBSaTQ7svxdN40=
X-Received: by 2002:aa7:96b7:0:b0:49f:df90:e4ae with SMTP id
 g23-20020aa796b7000000b0049fdf90e4aemr2159519pfk.24.1638917204948; Tue, 07
 Dec 2021 14:46:44 -0800 (PST)
MIME-Version: 1.0
References: <20211106013058.2621799-1-dlatypov@google.com> <20211106013058.2621799-2-dlatypov@google.com>
 <CABVgOSnQ9qGtu0nEKePH+Zb1oR2osmVh791zyQ9P61SNznryrw@mail.gmail.com>
 <CAGS_qxr3qd4b=00B76qN5GpFBa9aYa4UBFPvR505F3PbF5HSmg@mail.gmail.com> <CAGS_qxqhCHQEwoAKZ-ieEXtoC5SRjxwuceCqwF5eyfEDZ7YuBA@mail.gmail.com>
In-Reply-To: <CAGS_qxqhCHQEwoAKZ-ieEXtoC5SRjxwuceCqwF5eyfEDZ7YuBA@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Dec 2021 17:46:33 -0500
Message-ID: <CAFd5g45MyjJ4e0r=F77YHKcCP6hGSYmS+cP3NmvL_Yh0Ri+Wdg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: tool: add --kconfig_add to allow easily
 tweaking kunitconfigs
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 18, 2021 at 2:11 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Mon, Nov 8, 2021 at 9:23 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > On Fri, Nov 5, 2021 at 9:07 PM David Gow <davidgow@google.com> wrote:
> > >
> > > On Sat, Nov 6, 2021 at 9:31 AM 'Daniel Latypov' via KUnit Development
> > > <kunit-dev@googlegroups.com> wrote:
> > > >
> > > > E.g. run tests but with KASAN
> > > > $ ./tools/testing/kunit/kunit.py run --arch=x86_64 --kconfig_add=CONFIG_KASAN=y
> > >
> > > This is very neat, thank you. I'm definitely going to use this quite a bit.
> > >
> > > My only real note is that we'll need to add some documentation (but
> > > since the KUnit documentation is being reworked at the moment, I'm
> > > okay with doing that later to avoid merge conflicts).
> >
> > Yeah, there's that and I was also unsure where exactly to mention it.
> > I'd also want there to be the caveat about how removing the option
> > won't trigger a rebuild.
> > The part where we have that right now is really early on and doesn't
> > need more stuff added there:
> > https://www.kernel.org/doc/html/latest/dev-tools/kunit/start.html#creating-a-kunitconfig
> >
> > >
> > > > This also works with --kunitconfig
> > > > $ ./tools/testing/kunit/kunit.py run --arch=x86_64 --kunitconfig=fs/ext4 --kconfig_add=CONFIG_KASAN=y
> > >
> > > It's also worth noting that this can be appended multiple times to set
> > > multiple options, which is useful
> >
> > Ah yeah, this could be called out in the commit desc if we want a v2.
> > Checking the examples in the link down below, TuxMake doesn't actually
> > include one with it being repeated.
> > I had been banking on readers of this message assuming that it could
> > be repeated either from previous familiarity with TuxMake or by
> > clicking that link.
> >
> > But for tweaks that require multiple options, I'm personally going to
> > stick with --kunitconfig and heredocs.
> > E.g. coverage requires appending 3 kconfigs, so I'm sticking with
> >
> > ./tools/testing/kunit/kunit.py run --make_options=CC=/usr/bin/gcc-6
> > --kunitconfig /dev/stdin <<EOF
> > CONFIG_KUNIT=y
> > CONFIG_KUNIT_ALL_TESTS=y
> > CONFIG_DEBUG_KERNEL=y
> > CONFIG_DEBUG_INFO=y
> > CONFIG_GCOV=y
> > EOF
> >
> > >
> > > > This flag is inspired by TuxMake's --kconfig-add, see
> > > > https://gitlab.com/Linaro/tuxmake#examples.
> > > >
> > > > Our version just uses "_" as the delimiter for consistency with
> > > > pre-existing flags like --build_dir, --make_options, --kernel_args, etc.
> > > >
> > > > Note: this does make it easier to run into a pre-existing edge case:
> > > > $ ./tools/testing/kunit/kunit.py run --arch=x86_64 --kconfig_add=CONFIG_KASAN=y
> > > > $ ./tools/testing/kunit/kunit.py run --arch=x86_64
> > > > This second invocation ^ still has KASAN enabled!
> > >
> > > This behaviour is quite useful, and actually means we can turn on
> > > individual items with
> > > $ ./tools/testing/kunit/kunit.py config --kconfig_add=<option>
> >
> > Yes, that also works.
> > I didn't really want to call that out, however.
> >
> > I ultimately would like this option to make it easier to have kunit
> > commands be more declarative and less dependent on state.
>
> I've just proposed
> https://lore.kernel.org/linux-kselftest/20211118190329.1925388-1-dlatypov@google.com
>
> If that patch goes in, the use case described above *won't* work.
> I've been annoyed by the issue that removing lines from .kunitconfig
> doesn't do anything for a while.
>
> I really don't like the "stickiness" of options, since I think it's
> very much not what a user would initially expect. It can be useful in
> some situations, but I don't think it's worth the cost.

Yeah, I agree. It would be nice if commands weren't so stateful.
That's the reality of some things, but I think we are kind of in the
business of quick, repeatable, transient build/tests/environments.
From that standpoint, I like this flag, and I think it should not be
"sticky" as you describe.

> And I think the stickiness can be annoying to power users as well.
> Imagine you were trying to debug an issue that only showed up if some
> other Kconfig's are set.
> Now instead of iterating by adding diff --kconfig_add=<...>, you have
> to remember to delete .kunit/.config each time, lest you forget and go
> down a rabbit hole.
>
> >
> > E.g. instead of
> > $ cp fs/ext4/.kunitconfig .kunit/.kunitconfig
> > $ echo "CONFIG_KASAN=y" >> .kunit/.kunitconfig
> > $ ./tools/testing/kunit/kunit.py run --arch=x86_64
> >
> > it's now just one line and I'm less likely to miss a step, etc.
> > $ ./tools/testing/kunit/kunit.py run --arch=x86_64
> > --kunitconfig=fs/ext4 --kconfig_add=CONFIG_KASAN=y
> >
> > A user could alternatively do this via
> > $ ./tools/testing/kunit/kunit.py config --arch=x86_64
> > --kunitconfig=fs/ext4 --kconfig_add=CONFIG_KASAN=y
> > $ ./tools/testing/kunit/kunit.py config --arch=x86_64
> > --kconfig_add=CONFIG_ANOTHER_OPTION=y
> > $ ./tools/testing/kunit/kunit.py build
> > $ ./tools/testing/kunit/kunit.py exec --arch=x86_64
> >
> >
> > >
> > > > kunit.py won't call olddefconfig if our current .config is already a
> > > > superset of the provided kunitconfig.
> > > >
> > > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > >
> > > Looks good.
> > >
> > > Reviewed-by: David Gow <davidgow@google.com>
> > >
> > >
> > > > ---
> > > >  tools/testing/kunit/kunit.py           |  8 ++++++++
> > > >  tools/testing/kunit/kunit_kernel.py    |  5 +++++
> > > >  tools/testing/kunit/kunit_tool_test.py | 18 ++++++++++++++++++
> > > >  3 files changed, 31 insertions(+)
> > > >
> > > > diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> > > > index 68e6f461c758..be58f4c93806 100755
> > > > --- a/tools/testing/kunit/kunit.py
> > > > +++ b/tools/testing/kunit/kunit.py
> > > > @@ -280,6 +280,10 @@ def add_common_opts(parser) -> None:
> > > >                              ' If given a directory, (e.g. lib/kunit), "/.kunitconfig" '
> > > >                              'will get  automatically appended.',
> > > >                              metavar='kunitconfig')
> > > > +       parser.add_argument('--kconfig_add',
> > > > +                            help='Additional Kconfig options to append to the '
> > > > +                            '.kunitconfig, e.g. CONFIG_KASAN=y. Can be repeated.',
> > > > +                           action='append')
> > > >
> > > >         parser.add_argument('--arch',
> > > >                             help=('Specifies the architecture to run tests under. '
> > > > @@ -398,6 +402,7 @@ def main(argv, linux=None):
> > > >                 if not linux:
> > > >                         linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> > > >                                         kunitconfig_path=cli_args.kunitconfig,
> > > > +                                       kconfig_add=cli_args.kconfig_add,
> > > >                                         arch=cli_args.arch,
> > > >                                         cross_compile=cli_args.cross_compile,
> > > >                                         qemu_config_path=cli_args.qemu_config)
> > > > @@ -423,6 +428,7 @@ def main(argv, linux=None):
> > > >                 if not linux:
> > > >                         linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> > > >                                         kunitconfig_path=cli_args.kunitconfig,
> > > > +                                       kconfig_add=cli_args.kconfig_add,
> > > >                                         arch=cli_args.arch,
> > > >                                         cross_compile=cli_args.cross_compile,
> > > >                                         qemu_config_path=cli_args.qemu_config)
> > > > @@ -439,6 +445,7 @@ def main(argv, linux=None):
> > > >                 if not linux:
> > > >                         linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> > > >                                         kunitconfig_path=cli_args.kunitconfig,
> > > > +                                       kconfig_add=cli_args.kconfig_add,
> > > >                                         arch=cli_args.arch,
> > > >                                         cross_compile=cli_args.cross_compile,
> > > >                                         qemu_config_path=cli_args.qemu_config)
> > > > @@ -457,6 +464,7 @@ def main(argv, linux=None):
> > > >                 if not linux:
> > > >                         linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
> > > >                                         kunitconfig_path=cli_args.kunitconfig,
> > > > +                                       kconfig_add=cli_args.kconfig_add,
> > > >                                         arch=cli_args.arch,
> > > >                                         cross_compile=cli_args.cross_compile,
> > > >                                         qemu_config_path=cli_args.qemu_config)
> > > > diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> > > > index 51ee6e5dae91..7d459d6d6ff2 100644
> > > > --- a/tools/testing/kunit/kunit_kernel.py
> > > > +++ b/tools/testing/kunit/kunit_kernel.py
> > > > @@ -224,6 +224,7 @@ class LinuxSourceTree(object):
> > > >               build_dir: str,
> > > >               load_config=True,
> > > >               kunitconfig_path='',
> > > > +             kconfig_add: Optional[List[str]]=None,
> > > >               arch=None,
> > > >               cross_compile=None,
> > > >               qemu_config_path=None) -> None:
> > > > @@ -249,6 +250,10 @@ class LinuxSourceTree(object):
> > > >                                 shutil.copyfile(DEFAULT_KUNITCONFIG_PATH, kunitconfig_path)
> > > >
> > > >                 self._kconfig = kunit_config.parse_file(kunitconfig_path)
> > > > +               if kconfig_add:
> > > > +                       kconfig = kunit_config.parse_from_string('\n'.join(kconfig_add))
> > > > +                       self._kconfig.merge_in_entries(kconfig)
> > > > +
> > > >
> > > >         def clean(self) -> bool:
> > > >                 try:
> > > > diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> > > > index 4ec70e41ec5a..7e42a7c27987 100755
> > > > --- a/tools/testing/kunit/kunit_tool_test.py
> > > > +++ b/tools/testing/kunit/kunit_tool_test.py
> > > > @@ -334,6 +334,10 @@ class LinuxSourceTreeTest(unittest.TestCase):
> > > >                                 pass
> > > >                         kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
> > > >
> > > > +       def test_kconfig_add(self):
> > > > +               tree = kunit_kernel.LinuxSourceTree('', kconfig_add=['CONFIG_NOT_REAL=y'])
> > > > +               self.assertIn(kunit_config.KconfigEntry('NOT_REAL', 'y'), tree._kconfig.entries())
> > > > +
> > > >         def test_invalid_arch(self):
> > > >                 with self.assertRaisesRegex(kunit_kernel.ConfigError, 'not a valid arch, options are.*x86_64'):
> > > >                         kunit_kernel.LinuxSourceTree('', arch='invalid')
> > > > @@ -540,6 +544,7 @@ class KUnitMainTest(unittest.TestCase):
> > > >                 # Just verify that we parsed and initialized it correctly here.
> > > >                 mock_linux_init.assert_called_once_with('.kunit',
> > > >                                                         kunitconfig_path='mykunitconfig',
> > > > +                                                       kconfig_add=None,
> > > >                                                         arch='um',
> > > >                                                         cross_compile=None,
> > > >                                                         qemu_config_path=None)
> > > > @@ -551,6 +556,19 @@ class KUnitMainTest(unittest.TestCase):
> > > >                 # Just verify that we parsed and initialized it correctly here.
> > > >                 mock_linux_init.assert_called_once_with('.kunit',
> > > >                                                         kunitconfig_path='mykunitconfig',
> > > > +                                                       kconfig_add=None,
> > > > +                                                       arch='um',
> > > > +                                                       cross_compile=None,
> > > > +                                                       qemu_config_path=None)
> > > > +
> > > > +       @mock.patch.object(kunit_kernel, 'LinuxSourceTree')
> > > > +       def test_run_kconfig_add(self, mock_linux_init):
> > > > +               mock_linux_init.return_value = self.linux_source_mock
> > > > +               kunit.main(['run', '--kconfig_add=CONFIG_KASAN=y', '--kconfig_add=CONFIG_KCSAN=y'])
> > > > +               # Just verify that we parsed and initialized it correctly here.
> > > > +               mock_linux_init.assert_called_once_with('.kunit',
> > > > +                                                       kunitconfig_path=None,
> > > > +                                                       kconfig_add=['CONFIG_KASAN=y', 'CONFIG_KCSAN=y'],
> > > >                                                         arch='um',
> > > >                                                         cross_compile=None,
> > > >                                                         qemu_config_path=None)
> > > > --
> > > > 2.34.0.rc0.344.g81b53c2807-goog
> > > >
> > > > --
> > > > You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> > > > To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> > > > To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20211106013058.2621799-2-dlatypov%40google.com.
