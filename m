Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FFA3EA937
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Aug 2021 19:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbhHLROO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Aug 2021 13:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbhHLRON (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Aug 2021 13:14:13 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407ABC061756
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Aug 2021 10:13:48 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id 188so9375331ioa.8
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Aug 2021 10:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C+kw6KEtW6hmma6EoO3CJHDh9sg5PN6QFZ9PAKAzm0Q=;
        b=Rr8e0EBvWZ+YbwgmhRww1PZdSx8dyi2XQ+4O+T6zKcZnPJ/rsWfWp8MsHHFGhohoR5
         DKtBawbVRfJg0+hXv/ZCSYAbs/NvZLksGeVRFN/pKWcKwSQhCu315QWDrhEoE5S+6hD/
         C0WQygVgR/3CfOUWtKDurnIrpDOwv2HuaNehWTEa+n7a9bUrPd1Om0v1oY8PTjekd3dh
         wIgZF2zPHwEvPsB0zahLuv6fNfS0wd55Gasu4nKTJSrBz+OGn134foQRq4EXsT2iuGkc
         bOAmajGlvCwbFS2Bq691IqrAIWZnX2bpaEQOTZOSx/a1WFBzFnIGTFdNDjjI1x8KrEKy
         VFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C+kw6KEtW6hmma6EoO3CJHDh9sg5PN6QFZ9PAKAzm0Q=;
        b=r3FGrv8UItCW20yn/1NURU+ynEPo8V6MPwWnochKVPdpOOmmhaG0/FZA/yQLg2TQL4
         Ylh+2yMkCKqy0S1ynoGbdhw6apPHB2P9BfZErrQyk6UZJBkLafTvzRDR1862WY/6YTyk
         o+g1zL2uUDGhTKYZogt0bdoxJWZUe15C5IjzTJ2FaHPN65WwNtxfLZyvL5GHuT8OJho3
         GFQg/rzOH+OCREq9NlpcglI18gJqKpSgXz6Vo4RO0TyWXW6ZjiHj7pv8CFy+HIs7lNF7
         +j2P06ivVzIClNB8u2/JE0ZH/+q4EOHmLmCoqqtwzu4FO5/XZDwvVDILMdAdRMGgQPgN
         WvDA==
X-Gm-Message-State: AOAM532LkS78h8ax0DaHrGBtpZFmVufPyiqgvycrtBjAJpQX2EGZ8Xgc
        EuhpfagPzTEwy6Ws2ooZDvVbnWiGDSx5aY+43qsigw==
X-Google-Smtp-Source: ABdhPJxWAOKK3OAmEb2NC2KNtZMoGydS8sA/K3D7jRGe71nWWLOTTrhfL+kQGmHq2X/baJMtVWzdSMNitYRNE6TG/nM=
X-Received: by 2002:a02:6a24:: with SMTP id l36mr4650319jac.4.1628788427511;
 Thu, 12 Aug 2021 10:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210805235145.2528054-1-dlatypov@google.com> <CABVgOS=u9sOEbS-m63HtBmiBSqDdsX+kRgBMUWzx4T8_VXvZ8g@mail.gmail.com>
In-Reply-To: <CABVgOS=u9sOEbS-m63HtBmiBSqDdsX+kRgBMUWzx4T8_VXvZ8g@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 12 Aug 2021 10:13:36 -0700
Message-ID: <CAGS_qxqVZy4QvP3X3H1Ww=pFZD-j=hgYzYSXz-az+QMJ+CxdgQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kunit: tool: make --raw_output support only
 showing kunit output
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 11, 2021 at 11:48 PM David Gow <davidgow@google.com> wrote:
>
> On Fri, Aug 6, 2021 at 7:51 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > --raw_output is nice, but it would be nicer if could show only output
> > after KUnit tests have started.
> >
> > So change the flag to allow specifying a string ('kunit').
> > Make it so `--raw_output` alone will default to `--raw_output=all` and
> > have the same original behavior.
> >
> > Drop the small kunit_parser.raw_output() function since it feels wrong
> > to put it in "kunit_parser.py" when the point of it is to not parse
> > anything.
> >
> > E.g.
> >
> > $ ./tools/testing/kunit/kunit.py run --raw_output=kunit
> > ...
> > [15:24:07] Starting KUnit Kernel ...
> > TAP version 14
> > 1..1
> >     # Subtest: example
> >     1..3
> >     # example_simple_test: initializing
> >     ok 1 - example_simple_test
> >     # example_skip_test: initializing
> >     # example_skip_test: You should not see a line below.
> >     ok 2 - example_skip_test # SKIP this test should be skipped
> >     # example_mark_skipped_test: initializing
> >     # example_mark_skipped_test: You should see a line below.
> >     # example_mark_skipped_test: You should see this line.
> >     ok 3 - example_mark_skipped_test # SKIP this test should be skipped
> > ok 1 - example
> > [15:24:10] Elapsed time: 6.487s total, 0.001s configuring, 3.510s building, 0.000s running
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> Thanks: this is something I've secretly wanted for a long time, and I
> really like the interface here of "--raw_output=kunit". I do wonder if
> we want to make this behaviour the default, though...

I personally would like it to be, but I don't really know who else is
using --raw_output and why.
Maybe they want to see non-KUnit output since they're debugging
something not coming up on UML, etc.

>
> The only other note I'd have, though this was a problem with the
> previous version as well, is that the output still includes the other
> kunit_tool output lines, e.g.:
> [23:42:01] Configuring KUnit Kernel ...
> [23:42:01] Building KUnit Kernel ...
>
> This means that the "raw" output still can't easily just be redirected
> elsewhere and used. That's probably a separate fix though, and I still
> think this is a massive improvement over what we have.

Yes, this is an annoyance to me as well.
I was wondering if we should make those go to stderr or something so
users could pipe just stdout?

But yeah, it feels like a change for another patch.
I was not hindered by this in making the hacky shell script in the
second patch (to run each suite individually), but other consumers of
the output might be.

>
> Reviewed-by: David Gow <davidgow@google.com>
>
> -- David
>
> >  Documentation/dev-tools/kunit/kunit-tool.rst |  9 ++++++---
> >  tools/testing/kunit/kunit.py                 | 20 +++++++++++++++-----
> >  tools/testing/kunit/kunit_parser.py          |  4 ----
> >  tools/testing/kunit/kunit_tool_test.py       |  9 +++++++++
> >  4 files changed, 30 insertions(+), 12 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
> > index c7ff9afe407a..ae52e0f489f9 100644
> > --- a/Documentation/dev-tools/kunit/kunit-tool.rst
> > +++ b/Documentation/dev-tools/kunit/kunit-tool.rst
> > @@ -114,9 +114,12 @@ results in TAP format, you can pass the ``--raw_output`` argument.
> >
> >         ./tools/testing/kunit/kunit.py run --raw_output
> >
> > -.. note::
> > -       The raw output from test runs may contain other, non-KUnit kernel log
> > -       lines.
> > +The raw output from test runs may contain other, non-KUnit kernel log
> > +lines. You can see just KUnit output with ``--raw_output=kunit``:
> > +
> > +.. code-block:: bash
> > +
> > +       ./tools/testing/kunit/kunit.py run --raw_output=kunit
> >
> >  If you have KUnit results in their raw TAP format, you can parse them and print
> >  the human-readable summary with the ``parse`` command for kunit_tool. This
> > diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> > index 7174377c2172..5a931456e718 100755
> > --- a/tools/testing/kunit/kunit.py
> > +++ b/tools/testing/kunit/kunit.py
> > @@ -16,6 +16,7 @@ assert sys.version_info >= (3, 7), "Python version is too old"
> >
> >  from collections import namedtuple
> >  from enum import Enum, auto
> > +from typing import Iterable
> >
> >  import kunit_config
> >  import kunit_json
> > @@ -114,7 +115,16 @@ def parse_tests(request: KunitParseRequest) -> KunitResult:
> >                                               'Tests not Parsed.')
> >
> >         if request.raw_output:
> > -               kunit_parser.raw_output(request.input_data)
> > +               output: Iterable[str] = request.input_data
> > +               if request.raw_output == 'all':
> > +                       pass
> > +               elif request.raw_output == 'kunit':
> > +                       output = kunit_parser.extract_tap_lines(output)
> > +               else:
> > +                       print(f'Unknown --raw_output option "{request.raw_output}"', file=sys.stderr)
> > +               for line in output:
> > +                       print(line.rstrip())
> > +
> >         else:
> >                 test_result = kunit_parser.parse_run_tests(request.input_data)
> >         parse_end = time.time()
> > @@ -135,7 +145,6 @@ def parse_tests(request: KunitParseRequest) -> KunitResult:
> >         return KunitResult(KunitStatus.SUCCESS, test_result,
> >                                 parse_end - parse_start)
> >
> > -
> >  def run_tests(linux: kunit_kernel.LinuxSourceTree,
> >               request: KunitRequest) -> KunitResult:
> >         run_start = time.time()
> > @@ -181,7 +190,7 @@ def add_common_opts(parser) -> None:
> >         parser.add_argument('--build_dir',
> >                             help='As in the make command, it specifies the build '
> >                             'directory.',
> > -                            type=str, default='.kunit', metavar='build_dir')
> > +                           type=str, default='.kunit', metavar='build_dir')
> >         parser.add_argument('--make_options',
> >                             help='X=Y make option, can be repeated.',
> >                             action='append')
> > @@ -246,8 +255,9 @@ def add_exec_opts(parser) -> None:
> >                              action='append')
> >
> >  def add_parse_opts(parser) -> None:
> > -       parser.add_argument('--raw_output', help='don\'t format output from kernel',
> > -                           action='store_true')
> > +       parser.add_argument('--raw_output', help='If set don\'t format output from kernel. '
> > +                           'If set to --raw_output=kunit, filters to just KUnit output.',
> > +                           type=str, nargs='?', const='all', default=None)
> >         parser.add_argument('--json',
> >                             nargs='?',
> >                             help='Stores test results in a JSON, and either '
> > diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> > index b88db3f51dc5..84938fefbac0 100644
> > --- a/tools/testing/kunit/kunit_parser.py
> > +++ b/tools/testing/kunit/kunit_parser.py
> > @@ -106,10 +106,6 @@ def extract_tap_lines(kernel_output: Iterable[str]) -> LineStream:
> >                                 yield line_num, line[prefix_len:]
> >         return LineStream(lines=isolate_kunit_output(kernel_output))
> >
> > -def raw_output(kernel_output) -> None:
> > -       for line in kernel_output:
> > -               print(line.rstrip())
> > -
> >  DIVIDER = '=' * 60
> >
> >  RESET = '\033[0;0m'
> > diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> > index 628ab00f74bc..619c4554cbff 100755
> > --- a/tools/testing/kunit/kunit_tool_test.py
> > +++ b/tools/testing/kunit/kunit_tool_test.py
> > @@ -399,6 +399,15 @@ class KUnitMainTest(unittest.TestCase):
> >                         self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
> >                         self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
> >
> > +       def test_run_raw_output_kunit(self):
> > +               self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
> > +               kunit.main(['run', '--raw_output=kunit'], self.linux_source_mock)
> > +               self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
> > +               self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
> > +               for call in self.print_mock.call_args_list:
> > +                       self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
> > +                       self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
> > +
>
> This is basically identical to test_run_raw_output(). Is there an easy
> way of making sure this test can distinguish between them?

It is identical.
And the answer is no, not really right now.

We'd have to redo the other test to be more thorough in order to
distinguish the two different flag values, which is a bit more than I
wanted to go into this particular patch.

>
> >         def test_exec_timeout(self):
> >                 timeout = 3453
> >                 kunit.main(['exec', '--timeout', str(timeout)], self.linux_source_mock)
> >
> > base-commit: f684616e08e9cd9db3cd53fe2e068dfe02481657
> > --
> > 2.32.0.605.g8dce9f2422-goog
> >
