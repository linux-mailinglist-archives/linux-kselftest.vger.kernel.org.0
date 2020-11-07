Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4442AA457
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Nov 2020 11:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgKGKGn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Nov 2020 05:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbgKGKGm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Nov 2020 05:06:42 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49CEC0613D2
        for <linux-kselftest@vger.kernel.org>; Sat,  7 Nov 2020 02:06:40 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id m143so4303170oig.7
        for <linux-kselftest@vger.kernel.org>; Sat, 07 Nov 2020 02:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TErsauc9tpAzI6S5cYpbCRvl4twcQzw2HKSJ2d2Z+Qg=;
        b=cFZKFASwAfugNcZhz/FuAFmwgIJgslvWVTlXGObXW4GVaiNx5l+4SITTnhwIes3oiJ
         reYnqBcoLt6G3wNTxTLRdKwgOg7Ns7cE5FqN5L4rV7tMFTjEp2540lKCJlUvc52aoVKR
         0YjZ0+zMCT0aW++pNadjtwASHdwbGcnxya4d7uBY6bTaj1NGc6B9kOGdHCcbOMUKZvXf
         bJd1gYeIAayqwjDTVfshWKIZxHJX7MEwCH3td/atGMHmO6tHjcBdloKYwzPy6HyHIlWy
         +nIGIc8yTT0VDKRsKtvKA7fit+ZKdqNJdSHlD/fEWKCd9D7kRQN5jIMqPlF0YA+MdZGz
         t+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TErsauc9tpAzI6S5cYpbCRvl4twcQzw2HKSJ2d2Z+Qg=;
        b=CwWaficmckuLQxpoUeWHmFfrIdfqidLOVCnIcVEajqKNQXhbsadfG8sw2TuSu9HIdX
         ge06aGx21NXsZ476JFGHWaSW3yEmJyFJF42IwUxaA/HfESsgB/WBouBKgn43MepYdfit
         mgJ8maMvgKdwCLJEdhAHVlUT0y7ZnfdAnZs2VDTXXjpNsaj2RzfuHmfW90ssj1BeraYt
         ivfptqlCWYUvYgRsvUYPqUmzqeAazZkoglSzCxeNowNOf+wbyrTZjDkXJLXCHWknoX0f
         RGfXUPpZSlXFUeHqhE0jDm8vw8I6XoCiih+dQgM+kLdH2pdTVQtio4jguhJJZQUfGrmx
         OxUQ==
X-Gm-Message-State: AOAM53184l31AsYbgXiTLYPdAz5vrpZ8LrkTQJzsi4yOvKMpNxkCOQg4
        wGAwppL7oVOg/Adn4F+eNuyA7GxxqVE2LSV4ONTAOg==
X-Google-Smtp-Source: ABdhPJxb+xfOZ9jVhfWoVlbABCI67vL5rewh1ARjZCLWNyu463apeEQlWxjA1SZroi07HqVGkXthuRthzuku33QQCxw=
X-Received: by 2002:aca:6206:: with SMTP id w6mr3818129oib.121.1604743599913;
 Sat, 07 Nov 2020 02:06:39 -0800 (PST)
MIME-Version: 1.0
References: <20201106192154.51514-1-98.arpi@gmail.com> <CABVgOSkQ6+y7OGw2494cJa2b60EkSjncLNAgc9cJDbS=X9J3WA@mail.gmail.com>
In-Reply-To: <CABVgOSkQ6+y7OGw2494cJa2b60EkSjncLNAgc9cJDbS=X9J3WA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Sat, 7 Nov 2020 11:06:28 +0100
Message-ID: <CANpmjNNp2RUCE_ypp2R4MznikTYRYeCDuF7VMp+Hbh=55KWa3A@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] kunit: Support for Parameterized Testing
To:     David Gow <davidgow@google.com>
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 7 Nov 2020 at 05:58, David Gow <davidgow@google.com> wrote:
> On Sat, Nov 7, 2020 at 3:22 AM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
> >
> > Implementation of support for parameterized testing in KUnit.
> > This approach requires the creation of a test case using the
> > KUNIT_CASE_PARAM macro that accepts a generator function as input.
> > This generator function should return the next parameter given the
> > previous parameter in parameterized tests. It also provides
> > a macro to generate common-case generators.
> >
> > Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> > Co-developed-by: Marco Elver <elver@google.com>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
>
> This looks good to me! A couple of minor thoughts about the output
> format below, but I'm quite happy to have this as-is regardless.
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> Cheers,
> -- David
>
> > Changes v5->v6:
> > - Fix alignment to maintain consistency
> > Changes v4->v5:
> > - Update kernel-doc comments.
> > - Use const void* for generator return and prev value types.
> > - Add kernel-doc comment for KUNIT_ARRAY_PARAM.
> > - Rework parameterized test case execution strategy: each parameter is executed
> >   as if it was its own test case, with its own test initialization and cleanup
> >   (init and exit are called, etc.). However, we cannot add new test cases per TAP
> >   protocol once we have already started execution. Instead, log the result of
> >   each parameter run as a diagnostic comment.
> > Changes v3->v4:
> > - Rename kunit variables
> > - Rename generator function helper macro
> > - Add documentation for generator approach
> > - Display test case name in case of failure along with param index
> > Changes v2->v3:
> > - Modifictaion of generator macro and method
> > Changes v1->v2:
> > - Use of a generator method to access test case parameters
> >
> >  include/kunit/test.h | 36 ++++++++++++++++++++++++++++++++++
> >  lib/kunit/test.c     | 46 +++++++++++++++++++++++++++++++-------------
> >  2 files changed, 69 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index db1b0ae666c4..16616d3974f9 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -107,6 +107,7 @@ struct kunit;
[...]
> > -       kunit_suite_for_each_test_case(suite, test_case)
> > -               kunit_run_case_catch_errors(suite, test_case);
> > +       kunit_suite_for_each_test_case(suite, test_case) {
> > +               struct kunit test = { .param_value = NULL, .param_index = 0 };
> > +               bool test_success = true;
> > +
> > +               if (test_case->generate_params)
> > +                       test.param_value = test_case->generate_params(NULL);
> > +
> > +               do {
> > +                       kunit_run_case_catch_errors(suite, test_case, &test);
> > +                       test_success &= test_case->success;
> > +
> > +                       if (test_case->generate_params) {
> > +                               kunit_log(KERN_INFO, &test,
> > +                                         KUNIT_SUBTEST_INDENT
> > +                                         "# %s: param-%d %s",
>
> Would it make sense to have this imitate the TAP format a bit more?
> So, have "# [ok|not ok] - [name]" as the format? [name] could be
> something like "[test_case->name]:param-[index]" or similar.
> If we keep it commented out and don't indent it further, it won't
> formally be a nested test (though if we wanted to support those later,
> it'd be easy to add), but I think it would be nicer to be consistent
> here.

The previous attempt [1] at something similar failed because it seems
we'd need to teach kunit-tool new tricks [2], too.
[1] https://lkml.kernel.org/r/20201105195503.GA2399621@elver.google.com
[2] https://lkml.kernel.org/r/20201106123433.GA3563235@elver.google.com

So if we go with a different format, we might need a patch before this
one to make kunit-tool compatible with that type of diagnostic.

Currently I think we have the following proposals for a format:

1. The current "# [test_case->name]: param-[index] [ok|not ok]" --
this works well, because no changes to kunit-tool are required, and it
also picks up the diagnostic context for the case and displays that on
test failure.

2. Your proposed "# [ok|not ok] - [test_case->name]:param-[index]".
As-is, this needs a patch for kunit-tool as well. I just checked, and
if we change it to "# [ok|not ok] - [test_case->name]: param-[index]"
(note the space after ':') it works without changing kunit-tool. ;-)

3. Something like "# [ok|not ok] param-[index] - [test_case->name]",
which I had played with earlier but kunit-tool is definitely not yet
happy with.

So my current preference is (2) with the extra space (no change to
kunit-tool required). WDYT?

> My other suggestion -- albeit one outside the scope of this initial
> version -- would be to allow the "param-%d" name to be overridden
> somehow by a test. For example, the ext4 inode test has names for all
> its test cases: it'd be nice to be able to display those instead (even
> if they're not formatted as identifiers as-is).

Right, I was thinking about this, but it'd need a way to optionally
pass another function that converts const void* params to readable
strings. But as you say, we should do that as a follow-up patch later
because it might require a few more iterations.

[...]

Thanks,
-- Marco
