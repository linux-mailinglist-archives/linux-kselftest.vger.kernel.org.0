Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2066D2CAB40
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Dec 2020 20:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgLATAr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Dec 2020 14:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgLATAr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Dec 2020 14:00:47 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EE1C0613D4
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Dec 2020 11:00:07 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id y9so2767376ilb.0
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Dec 2020 11:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5WiGFwgTdyvLFhngVWRsy4uz/nVfgxKZUAGEzNFkY80=;
        b=AX405OszVeGEA2VJJpxsH/hn72j0e7jTzJhWLRs/b0RlYsxWA0D1/IdwNip05R1epM
         J8egUwok7Bf0bJM/L5ik7nLoz3dL08HQu9bujrshPjJj5LoRh7tw+Jc6w+YqMQmal1cL
         5WnunY2CJSWcBIgXAahiZA6rFjn12zm817D/nzl+I8TvmjgRr6TA0b7ivQfSWUJvISWz
         Z9sUqd91oXPSFs2fMh2ZLxh0/MZv9qKG1egjj3QnCWbFiQBMT5szcu0An+wEn6HA491r
         wFqrLJosGXP5eazDT1KtTy+Ia32vNuxYy4xB3ZhYzZgVBZws3uzdZ+A9K1JM88rDR9P6
         Ibyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5WiGFwgTdyvLFhngVWRsy4uz/nVfgxKZUAGEzNFkY80=;
        b=BdlG6yW1NgC4FpDeuywogW1rTEoevLjWS5RUFaZxRFO4s1bthzVBvzf0P0pswV1cVr
         7BqSzHh79jWjjUzo2Lx3Bvw4nQ7/+zcD2CbSMw02pYtLXr/pozwWdlDXrxOZme3pfaL2
         7iJIX18tW5iLuk9bz7YLCc5C26t444h+j1KVWBIsroSgTpRxzj5rEENwfrTvB4UtcUZd
         6VhLhJY1MavO1ZDmm7JqXlSjK/ljpD8rqGHqTv2ImRr/zOplUcqtjbpX2ZkP2/ZNmUCs
         iSSUP1yQl8xQHBj2MuOY/PC+hFgDXuaY8XerafafQLS2coKyrxQdzKow2u748nsw+8cO
         Nqyg==
X-Gm-Message-State: AOAM530cNaK1YZ0WNa4docc8IpHGzZVvjTacY/iwCAs09ANAJ40ZqjkO
        yyfIQj4l9Ft0i09ZDIK8A4TajTHUxGeOpkOLNUylKw==
X-Google-Smtp-Source: ABdhPJxmGG830IYXzUMXpFTTxu5CX/L/t5UT+1fCmZZZ4UmJ9S9qk+VJOtxjVoZs56Wmoi1sqnSSZvv6jSUZ3FaURGs=
X-Received: by 2002:a05:6e02:128b:: with SMTP id y11mr4148745ilq.75.1606849206187;
 Tue, 01 Dec 2020 11:00:06 -0800 (PST)
MIME-Version: 1.0
References: <20201130233242.78413-1-dlatypov@google.com> <20201130233242.78413-2-dlatypov@google.com>
 <CABVgOSmX3foOr6XJhQ_goYabFEg8qNYoQ+5O7JPRW=gLmh=OQA@mail.gmail.com>
In-Reply-To: <CABVgOSmX3foOr6XJhQ_goYabFEg8qNYoQ+5O7JPRW=gLmh=OQA@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 1 Dec 2020 10:59:54 -0800
Message-ID: <CAGS_qxpW=Q=x8WAR3WWhtYnJc+K43kpDw680x+6go1cAjW6oUQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] kunit: tool: fix unit test so it can run from
 non-root dir
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 30, 2020 at 11:33 PM David Gow <davidgow@google.com> wrote:
>
> On Tue, Dec 1, 2020 at 7:33 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > get_absolute_path() makes an attempt to allow for this.
> > But that doesn't work as soon as os.chdir() gets called.
>
> Can we explain why this doesn't work? It's because the test_data/
> files are accessed with relative paths, so chdir breaks access to
> them, right?

Correct.
Because it actually returns a relative path.

(I forgot that I called out that get_absolute_path() gives relative
paths in the last patch, and not this one. I can update the commit
desc if we want a v2 of this)

>
> >
> > So make it so that os.chdir() does nothing to avoid this.
> >
> > Note: mock.patch.object() doesn't seem to work in setUpModule(), hence
> > the introduction of a new base class instead.
> >
> > Fixes: 5578d008d9e0 ("kunit: tool: fix running kunit_tool from outside kernel tree")
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> I don't like this: disabling a real system call seems like overkill to
> work around a path issue like this.
>
> Wouldn't it be better to either:
> (a) stop kunit_tool from needing to chdir entirely; or

a) is doable, but would require plumbing cwd=get_kernel_root_path() to
all the subprocess calls to make, etc.
I'm not sure fixing a internal test-only issue necessarily justifies
taking that path instead of the easier "just add a chdir" we opted for
in 5578d008d9e0 ("kunit: tool: fix running kunit_tool from outside
kernel tree").

> (b) have get_absolute_path() / test_data_path() produce an absolute path.
>
> The latter really seems like the most sensible approach: have the
> script read its own path and read files relative to that.

b) is not that simple, sadly.

Say I invoke
$ python3 kunit_tool_test.py
then __file__ = kunit_tool_test.py.

So __file__ is a relative path, but the code assumed it was an
absolute one and any change of directory breaks things.
Working around that would require something like caching the result of
os.path.abspath(__file__) somewhere.

I can see the point about not mocking out something like os.chdir().
But on the other hand, do we have any other legitimate reason to call
it besides that one place in kunit.py?
If we do have something that relies on doing an os.chdir(), it should
ideally notice that it didn't work and manifest in a unit test failure
somehow.

Alternatively, we could make get_kernel_root_path() return ""/None to
avoid the chdir call.
kunit.py:       if get_kernel_root_path():
kunit.py:               os.chdir(get_kernel_root_path())

There'd be no adverse affects atm for stubbing that out, and I don't forsee any.
But if we want to be even safer, then perhaps we have

def chdir_to_kernel_root():
   ...

and mock out just that func in the unit test?

>
> Cheers,
> -- David
>
>
> >  tools/testing/kunit/kunit_tool_test.py | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> > index 3fbe1acd531a..9f1f1e1b772a 100755
> > --- a/tools/testing/kunit/kunit_tool_test.py
> > +++ b/tools/testing/kunit/kunit_tool_test.py
> > @@ -32,7 +32,13 @@ def tearDownModule():
> >  def get_absolute_path(path):
> >         return os.path.join(os.path.dirname(__file__), path)
> >
> > -class KconfigTest(unittest.TestCase):
> > +class KUnitTest(unittest.TestCase):
> > +       """Contains common setup, like stopping main() from calling chdir."""
> > +       def setUp(self):
> > +               mock.patch.object(os, 'chdir').start()
> > +               self.addCleanup(mock.patch.stopall)
> > +
> > +class KconfigTest(KUnitTest):
> >
> >         def test_is_subset_of(self):
> >                 kconfig0 = kunit_config.Kconfig()
> > @@ -88,7 +94,7 @@ class KconfigTest(unittest.TestCase):
> >                 self.assertEqual(actual_kconfig.entries(),
> >                                  expected_kconfig.entries())
> >
> > -class KUnitParserTest(unittest.TestCase):
> > +class KUnitParserTest(KUnitTest):
> >
> >         def assertContains(self, needle, haystack):
> >                 for line in haystack:
> > @@ -250,7 +256,7 @@ class KUnitParserTest(unittest.TestCase):
> >                                 result.status)
> >                         self.assertEqual('kunit-resource-test', result.suites[0].name)
> >
> > -class KUnitJsonTest(unittest.TestCase):
> > +class KUnitJsonTest(KUnitTest):
> >
> >         def _json_for(self, log_file):
> >                 with(open(get_absolute_path(log_file))) as file:
> > @@ -285,8 +291,9 @@ class StrContains(str):
> >         def __eq__(self, other):
> >                 return self in other
> >
> > -class KUnitMainTest(unittest.TestCase):
> > +class KUnitMainTest(KUnitTest):
> >         def setUp(self):
> > +               super().setUp()
> >                 path = get_absolute_path('test_data/test_is_test_passed-all_passed.log')
> >                 with open(path) as file:
> >                         all_passed_log = file.readlines()
> > --
> > 2.29.2.454.gaff20da3a2-goog
> >
