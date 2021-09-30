Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D557E41DF15
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 18:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351165AbhI3Qcn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 12:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351408AbhI3Qch (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 12:32:37 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C53C06176C
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Sep 2021 09:30:54 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id d11so7532457ilc.8
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Sep 2021 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3GJDPU5FEHjM1zieJ1Pg3C9OcpkH8T3yE1WPI8iwRk=;
        b=jnQtQEZwbakpMbIrU6BktCG2/inzQOtpdpjQw9GFNM2cjvIUWX5NbltcFZLNuHvA2n
         omhiIhSvbsNelvHhOtQFFsCTqqUuoywrm+8tEsoIVpXGbDJBe1s5euVwfg7OpE0kQ5oi
         U6sG3boo6qm1Y6VL8sqwkGCkv+cwZa3ROsMZilOm7/tODkVJAYl752nAmoWYJ8kIt/pE
         YYwVNWWVaHW5nfQPrqcWHufwu23DOQLKGWovMl/Wg14RqRt8HcgIowWOQaGhLAOnh9mi
         9cVn+97H+OJmESUNQpp3DEBH17xNfM4bl6nWjmE00pDap7S5l94w358A1xg2uGLLNj8a
         nDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3GJDPU5FEHjM1zieJ1Pg3C9OcpkH8T3yE1WPI8iwRk=;
        b=NLjN93HAmIw5f0rsQ6WQnY49A4YytXfHmlqzEOCWtEdSx3qVDWZChcgnfLcqwYPXef
         /Ws1PCsGhe7OdJVLpoYHvuukZg0myFpsudXZ7M7FfXZC1nnn50V2WtgryOWKjzEcTeSZ
         prfvj9guulzPvWwdmd9Veqjzi/weh2xlgFMAZJnKVaV8MEmXplVzvjYWYo8uafRXDh0c
         tehBXyy4/v/pzf6aQjxEOux9wiYMw9atokT9D1gixutRvO4F7LzJykvNov9MAwwrLuED
         hd+2K4/6fyfM92GGxEmq2D/09tiFV9yB7XPtEh/Vr8DpKnJdBBysTNU3R5iZTRbjyyP8
         T5zg==
X-Gm-Message-State: AOAM5336uQw9ggcC+iplAjU8oPp/cjUiyP4PBJzfkJi65EABGaXuzOnw
        eyu8j3wYdrBBmFoWlY5M+Q8TfMhOk+7lHrWww/KMmw==
X-Google-Smtp-Source: ABdhPJzfvozwNzo0WYuTVzS114nYJ0s+7qbCvouyVk0V06G+G7nr7iHJZxVnz8fP2xlyKNTeJu7nQXzqNqzdvRj9+dI=
X-Received: by 2002:a92:b301:: with SMTP id p1mr4732412ilh.10.1633019453444;
 Thu, 30 Sep 2021 09:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210929195436.1405996-1-dlatypov@google.com> <20210929195436.1405996-5-dlatypov@google.com>
 <CABVgOSne4ymK6ajB8vT-=pptvKJNxBNppzA3X7Jv2mghjsf4RQ@mail.gmail.com>
In-Reply-To: <CABVgOSne4ymK6ajB8vT-=pptvKJNxBNppzA3X7Jv2mghjsf4RQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 30 Sep 2021 09:30:42 -0700
Message-ID: <CAGS_qxqRoMRDZBmdRFj_kQwoWxA2rd5LGNyrjS4rSeZaNGLXXw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] kunit: tool: support running each suite/test separately
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

On Wed, Sep 29, 2021 at 7:27 PM David Gow <davidgow@google.com> wrote:
>
> On Thu, Sep 30, 2021 at 3:54 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > The new --run_isolated flag makes the tool boot the kernel once per
> > suite or test, preventing leftover state from one suite to impact the
> > other. This can be useful as a starting point to debugging test
> > hermeticity issues.
> >
> > Note: it takes a lot longer, so people should not use it normally.
> >
> > Consider the following very simplified example:
> >
> >   bool disable_something_for_test = false;
> >   void function_being_tested() {
> >     ...
> >     if (disable_something_for_test) return;
> >     ...
> >   }
> >
> >   static void test_before(struct kunit *test)
> >   {
> >     disable_something_for_test = true;
> >     function_being_tested();
> >     /* oops, we forgot to reset it back to false */
> >   }
> >
> >   static void test_after(struct kunit *test)
> >   {
> >     /* oops, now "fixing" test_before can cause test_after to fail! */
> >     function_being_tested();
> >   }
> >
> > Presented like this, the issues are obvious, but it gets a lot more
> > complicated to track down as the amount of test setup and helper
> > functions increases.
> >
> > Another use case is memory corruption. It might not be surfaced as a
> > failure/crash in the test case or suite that caused it. I've noticed in
> > kunit's own unit tests, the 3rd suite after might be the one to finally
> > crash after an out-of-bounds write, for example.
> >
> > Example usage:
> >
> > Per suite:
> > $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=suite
> > ...
> > Starting KUnit Kernel (1/7)...
> > ============================================================
> > ======== [PASSED] kunit_executor_test ========
> > ....
> > Testing complete. 5 tests run. 0 failed. 0 crashed. 0 skipped.
> > Starting KUnit Kernel (2/7)...
> > ============================================================
> > ======== [PASSED] kunit-try-catch-test ========
> > ...
> >
> > Per test:
> > $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=test
> > Starting KUnit Kernel (1/23)...
> > ============================================================
> > ======== [PASSED] kunit_executor_test ========
> > [PASSED] parse_filter_test
> > ============================================================
> > Testing complete. 1 tests run. 0 failed. 0 crashed. 0 skipped.
> > Starting KUnit Kernel (2/23)...
> > ============================================================
> > ======== [PASSED] kunit_executor_test ========
> > [PASSED] filter_subsuite_test
> > ...
> >
> > It works with filters as well:
> > $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=suite example
> > ...
> > Starting KUnit Kernel (1/1)...
> > ============================================================
> > ======== [PASSED] example ========
> > ...
> >
> > It also handles test filters, '*.*skip*' runs these 3 tests:
> >   kunit_status.kunit_status_mark_skipped_test
> >   example.example_skip_test
> >   example.example_mark_skipped_test
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > Reviewed-by: David Gow <davidgow@google.com>
> > ---
>
> Thanks. This is good. A part of me still would've preferred the TAP
> header to have been altered, but it probably makes more sense to leave
> that until after Rae's parser rework patch anyway, which has better
> support for multiple possible TAP headers anyway.
>
> I did find an issue when running this under qemu/i386: a timing
> problem with interleaved lines. We could do something drastic, like
> having a marker at the start of every line to identify which ones are
> tests, but that does seem like overkill for a (hopefully) rare
> problem. Just ignoring obviously invalid lines should do it. Futher
> details below.
>
> -- David
>
> >  tools/testing/kunit/kunit.py           | 95 ++++++++++++++++++++------
> >  tools/testing/kunit/kunit_tool_test.py | 40 +++++++++++
> >  2 files changed, 114 insertions(+), 21 deletions(-)
> >
> > diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> > index 5e717594df5b..b9d63f558765 100755
> > --- a/tools/testing/kunit/kunit.py
> > +++ b/tools/testing/kunit/kunit.py
> > @@ -16,7 +16,7 @@ assert sys.version_info >= (3, 7), "Python version is too old"
> >
> >  from collections import namedtuple
> >  from enum import Enum, auto
> > -from typing import Iterable
> > +from typing import Iterable, List
> >
> >  import kunit_config
> >  import kunit_json
> > @@ -31,13 +31,13 @@ KunitBuildRequest = namedtuple('KunitBuildRequest',
> >                                ['jobs', 'build_dir', 'alltests',
> >                                 'make_options'])
> >  KunitExecRequest = namedtuple('KunitExecRequest',
> > -                              ['timeout', 'build_dir', 'alltests',
> > -                               'filter_glob', 'kernel_args'])
> > +                             ['timeout', 'build_dir', 'alltests',
> > +                              'filter_glob', 'kernel_args', 'run_isolated'])
> >  KunitParseRequest = namedtuple('KunitParseRequest',
> >                                ['raw_output', 'build_dir', 'json'])
> >  KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
> >                                            'build_dir', 'alltests', 'filter_glob',
> > -                                          'kernel_args', 'json', 'make_options'])
> > +                                          'kernel_args', 'run_isolated', 'json', 'make_options'])
> >
> >  KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
> >
> > @@ -91,23 +91,68 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
> >                            'built kernel successfully',
> >                            build_end - build_start)
> >
> > +def _list_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -> List[str]:
> > +       args = ['kunit.action=list']
> > +       if request.kernel_args:
> > +               args.extend(request.kernel_args)
> > +
> > +       output = linux.run_kernel(args=args,
> > +                          timeout=None if request.alltests else request.timeout,
> > +                          filter_glob=request.filter_glob,
> > +                          build_dir=request.build_dir)
> > +       lines = kunit_parser.extract_tap_lines(output)
> > +       # Hack! Drop the dummy TAP version header that the executor prints out.
> > +       lines.pop()
> > +       return list(lines)
> > +
> > +def _suites_from_test_list(tests: List[str]) -> List[str]:
> > +       """Extracts all the suites from an ordered list of tests."""
> > +       suites = []  # type: List[str]
> > +       for t in tests:
> > +               parts = t.split('.', maxsplit=2)
> > +               if len(parts) != 2:
> > +                       raise ValueError(f'internal KUnit error, test name should be of the form "<suite>.<test>", got "{t}"')
>
> It turns out that this can trigger on some machines/architectures if
> there are other lines of kernel output which either get interspersed
> in the test list, or -- more likely -- between the test list and the
> "Restarting System" line.
>
> On i386, under qemu, I'm seeing this output:
> $ qemu-system-x86_64 -nodefaults -m 1024 -kernel
> .kunit/arch/x86/boot/bzImage -append 'kunit.action=list mem=1G
> console=tty kunit_shutdown=halt console=ttyS0 kunit_shutdown=reboot'
> -no-reboot -nographic -serial stdio
> ...
> property-entry.pe_test_reference
> random: fast init done
> input: ImExPS/2 Generic Explorer Mouse as
> /devices/platform/i8042/serio1/input/input2
> reboot: Restarting system
> reboot: machine restart
>
> Which translates into the following kunit_tool error:
> $ ./tools/testing/kunit/kunit.py run --run_isolated=suite --arch=i386
> ...
>  File "./tools/testing/kunit/kunit.py", line 114, in _suites_from_test_list
>    raise ValueError(f'internal KUnit error, test name should be of the
> form "<suite>.<test>", got "{t}"')
> ValueError: internal KUnit error, test name should be of the form
> "<suite>.<test>", got "random: fast init done"
>
>
> Could we maybe ignore entries of the incorrect form?

I'm thinking we change _list_tests() above like
-       return list(lines)
+
+       # Filter out any extraneous non-test output that might have
gotten mixed in.
+       return [l for l in lines if re.match('^\w+\.\w+$', l)]

The problem with \w is that it doesn't match -.
So I'm thinking we maybe go with something very lax like
  '^[^\s.]+\.[^\s.]+$'

Since we don't have any requirements on the naming convention, I don't
know if we can be stricter.
Like, KUNIT_CASE() sorta enforces that test cases follow C identifier
naming rules, but users could always work around it fairly easily by
instantiating the struct directly.
