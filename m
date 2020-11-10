Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2E62AE404
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Nov 2020 00:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbgKJX2I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Nov 2020 18:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgKJX2I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Nov 2020 18:28:08 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08ABC0613D3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Nov 2020 15:28:04 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id l2so631642lfk.0
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Nov 2020 15:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Or4R009+0xAwqncSLQ7leMAU40PnO86t6CdPE9/qh4k=;
        b=k/ezgD1o5+lqyyRN7hCLyW1xEKOHNTrZVXwF41loyBKssVhhOET5jjIhJfWfjMs7lv
         QdHT0tEKUZI0oIx7b/CwtdUluWv+IHZsNVB+ABWidOCCuzpEhpkjzuk3UQXjnewPl3bj
         unyMB60kskOiW3clwYUe4h7D7MERHxolHPSaFlIqDFG+ENasTAkeJly5JnzFZR9lGDoL
         f9ylzx75yHTLO61Z5S+LLkuNm8AgQ/728yCd6icXO1U5GzyyBz/V95CqO3j9NNT1g8Lm
         S2T1jh7116EB1g5MkjgcWsIzeC9yM9F5dvaeucEFIC/mLthOm3xDDSG7DTQWCkqX3bQJ
         JrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Or4R009+0xAwqncSLQ7leMAU40PnO86t6CdPE9/qh4k=;
        b=uchnk9a+lqd7kRBvPkjFwxFBKUNbeCHlyk/d8eECQTTNRlhf+ODv5Uhvkb5vNGraic
         8sSyfGiBHEDO4cpfoMSgEGo3CtoTI6e3Frs6CsjoCc7VOAfQ37XJp+Hy7fdZcEnH7HJA
         HvCW3auC6pu/oP4f/JM+5DEjeVaUrObiwJfsy7bE9JzAemcLNzKF7tiQTm6T2mFDhHoR
         Oy8RBgGo5IHVkGWn6QhlFS8fohCc7vrrDdYFRBSwlvOT7bMX5kyM+czYaj0INfW9DVzU
         BX6BBsbrJLRYOFuBaXOD/5GEnDn1n6oSEmCg6GA5zgfhUVCpJ+X5emSHC2Y0ioPndn+j
         9yFg==
X-Gm-Message-State: AOAM5315jvK5VVXcnU/GiMoxpF0A7rnPX7raPptpn07tdhusell9Gpf/
        tT2KrvpTlGnuxkX8sx9ntJ9GkmlnSD5uD5b68gtNRQ==
X-Google-Smtp-Source: ABdhPJxIrOWuYaxhwkKiw0b+VIN2LLtnnTSX9JBogbwi5Y5pCn2pYjtBTqjMIgCUrwVN6t0j+w8Hr7cFOqFe8bMsVuY=
X-Received: by 2002:ac2:59db:: with SMTP id x27mr5394024lfn.34.1605050875512;
 Tue, 10 Nov 2020 15:27:55 -0800 (PST)
MIME-Version: 1.0
References: <20201106192154.51514-1-98.arpi@gmail.com> <CABVgOSkQ6+y7OGw2494cJa2b60EkSjncLNAgc9cJDbS=X9J3WA@mail.gmail.com>
 <CANpmjNNp2RUCE_ypp2R4MznikTYRYeCDuF7VMp+Hbh=55KWa3A@mail.gmail.com>
 <47a05c5a-485d-026b-c1c3-476ed1a97856@gmail.com> <CABVgOSkZ9k6bHPp=LVATWfokMSrEuD87jOfE5MiVYAEbZMmaQQ@mail.gmail.com>
 <BY5PR13MB29336C5BE374D69939DCADABFDE90@BY5PR13MB2933.namprd13.prod.outlook.com>
In-Reply-To: <BY5PR13MB29336C5BE374D69939DCADABFDE90@BY5PR13MB2933.namprd13.prod.outlook.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 11 Nov 2020 07:27:43 +0800
Message-ID: <CABVgOSnJAgWvTTABaF082LuYjAoAWzrBsyu9sT7x4GGMVsOD6Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] kunit: Support for Parameterized Testing
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        Marco Elver <elver@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 11, 2020 at 1:02 AM Bird, Tim <Tim.Bird@sony.com> wrote:
>
>
>
> > -----Original Message-----
> > From: David Gow <davidgow@google.com>
> >
> > On Mon, Nov 9, 2020 at 2:49 PM Arpitha Raghunandan <98.arpi@gmail.com> =
wrote:
> > >
> > > On 07/11/20 3:36 pm, Marco Elver wrote:
> > > > On Sat, 7 Nov 2020 at 05:58, David Gow <davidgow@google.com> wrote:
> > > >> On Sat, Nov 7, 2020 at 3:22 AM Arpitha Raghunandan <98.arpi@gmail.=
com> wrote:
> > > >>>
> > > >>> Implementation of support for parameterized testing in KUnit.
> > > >>> This approach requires the creation of a test case using the
> > > >>> KUNIT_CASE_PARAM macro that accepts a generator function as input=
.
> > > >>> This generator function should return the next parameter given th=
e
> > > >>> previous parameter in parameterized tests. It also provides
> > > >>> a macro to generate common-case generators.
> > > >>>
> > > >>> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> > > >>> Co-developed-by: Marco Elver <elver@google.com>
> > > >>> Signed-off-by: Marco Elver <elver@google.com>
> > > >>> ---
> > > >>
> > > >> This looks good to me! A couple of minor thoughts about the output
> > > >> format below, but I'm quite happy to have this as-is regardless.
> > > >>
> > > >> Reviewed-by: David Gow <davidgow@google.com>
> > > >>
> > > >> Cheers,
> > > >> -- David
> > > >>
> > > >>> Changes v5->v6:
> > > >>> - Fix alignment to maintain consistency
> > > >>> Changes v4->v5:
> > > >>> - Update kernel-doc comments.
> > > >>> - Use const void* for generator return and prev value types.
> > > >>> - Add kernel-doc comment for KUNIT_ARRAY_PARAM.
> > > >>> - Rework parameterized test case execution strategy: each paramet=
er is executed
> > > >>>   as if it was its own test case, with its own test initializatio=
n and cleanup
> > > >>>   (init and exit are called, etc.). However, we cannot add new te=
st cases per TAP
> > > >>>   protocol once we have already started execution. Instead, log t=
he result of
> > > >>>   each parameter run as a diagnostic comment.
> > > >>> Changes v3->v4:
> > > >>> - Rename kunit variables
> > > >>> - Rename generator function helper macro
> > > >>> - Add documentation for generator approach
> > > >>> - Display test case name in case of failure along with param inde=
x
> > > >>> Changes v2->v3:
> > > >>> - Modifictaion of generator macro and method
> > > >>> Changes v1->v2:
> > > >>> - Use of a generator method to access test case parameters
> > > >>>
> > > >>>  include/kunit/test.h | 36 ++++++++++++++++++++++++++++++++++
> > > >>>  lib/kunit/test.c     | 46 +++++++++++++++++++++++++++++++-------=
------
> > > >>>  2 files changed, 69 insertions(+), 13 deletions(-)
> > > >>>
> > > >>> diff --git a/include/kunit/test.h b/include/kunit/test.h
> > > >>> index db1b0ae666c4..16616d3974f9 100644
> > > >>> --- a/include/kunit/test.h
> > > >>> +++ b/include/kunit/test.h
> > > >>> @@ -107,6 +107,7 @@ struct kunit;
> > > > [...]
> > > >>> -       kunit_suite_for_each_test_case(suite, test_case)
> > > >>> -               kunit_run_case_catch_errors(suite, test_case);
> > > >>> +       kunit_suite_for_each_test_case(suite, test_case) {
> > > >>> +               struct kunit test =3D { .param_value =3D NULL, .p=
aram_index =3D 0 };
> > > >>> +               bool test_success =3D true;
> > > >>> +
> > > >>> +               if (test_case->generate_params)
> > > >>> +                       test.param_value =3D test_case->generate_=
params(NULL);
> > > >>> +
> > > >>> +               do {
> > > >>> +                       kunit_run_case_catch_errors(suite, test_c=
ase, &test);
> > > >>> +                       test_success &=3D test_case->success;
> > > >>> +
> > > >>> +                       if (test_case->generate_params) {
> > > >>> +                               kunit_log(KERN_INFO, &test,
> > > >>> +                                         KUNIT_SUBTEST_INDENT
> > > >>> +                                         "# %s: param-%d %s",
> > > >>
> > > >> Would it make sense to have this imitate the TAP format a bit more=
?
> > > >> So, have "# [ok|not ok] - [name]" as the format? [name] could be
> > > >> something like "[test_case->name]:param-[index]" or similar.
> > > >> If we keep it commented out and don't indent it further, it won't
> > > >> formally be a nested test (though if we wanted to support those la=
ter,
> > > >> it'd be easy to add), but I think it would be nicer to be consiste=
nt
> > > >> here.
> > > >
> > > > The previous attempt [1] at something similar failed because it see=
ms
> > > > we'd need to teach kunit-tool new tricks [2], too.
> > > > [1] https://lkml.kernel.org/r/20201105195503.GA2399621@elver.google=
.com
> > > > [2] https://lkml.kernel.org/r/20201106123433.GA3563235@elver.google=
.com
> > > >
> > > > So if we go with a different format, we might need a patch before t=
his
> > > > one to make kunit-tool compatible with that type of diagnostic.
> > > >
> > > > Currently I think we have the following proposals for a format:
> > > >
> > > > 1. The current "# [test_case->name]: param-[index] [ok|not ok]" --
> > > > this works well, because no changes to kunit-tool are required, and=
 it
> > > > also picks up the diagnostic context for the case and displays that=
 on
> > > > test failure.
> > > >
> > > > 2. Your proposed "# [ok|not ok] - [test_case->name]:param-[index]".
> > > > As-is, this needs a patch for kunit-tool as well. I just checked, a=
nd
> > > > if we change it to "# [ok|not ok] - [test_case->name]: param-[index=
]"
> > > > (note the space after ':') it works without changing kunit-tool. ;-=
)
> > > >
> > > > 3. Something like "# [ok|not ok] param-[index] - [test_case->name]"=
,
> > > > which I had played with earlier but kunit-tool is definitely not ye=
t
> > > > happy with.
> > > >
> > > > So my current preference is (2) with the extra space (no change to
> > > > kunit-tool required). WDYT?
> > > >
> >
> > Hmm=E2=80=A6 that failure in kunit_tool is definitely a bug: we shouldn=
't care
> > what comes after the comment character except if it's an explicit
> > subtest declaration or a crash. I'll try to put a patch together to
> > fix it, but I'd rather not delay this just for that.
> >
> > In any thought about this a bit more, It turns out that the proposed
> > KTAP spec[1] discourages the use of ':', except as part of a subtest
> > declaration, or perhaps an as-yet-unspecified fully-qualified test
> > name. The latter is what I was going for, but if it's actively
> > breaking kunit_tool, we might want to hold off on it.
> >
> > If we were to try to treat these as subtests in accordance with that
> > spec, the way we'd want to use one of these options:
> > A) "[ok|not ok] [index] - param-[index]" -- This doesn't mention the
> > test case name, but otherwise treats things exactly the same way we
> > treat existing subtests.
> >
> > B) "[ok|not ok] [index] - [test_case->name]" -- This doesn't name the
> > "subtest", just gives repeated results with the same name.
> >
> > C) "[ok|not ok] [index] - [test_case->name][separator]param-[index]"
> > -- This is equivalent to my suggestion with a separator of ":", or 2
> > above with a separator of ": ". The in-progress spec doesn't yet
> > specify how these fully-qualified names would work, other than that
> > they'd use a colon somewhere, and if we comment it out, ": " is
> > required.
> >
> > >
> > > Which format do we finally go with?
> > >
> >
> > I'm actually going to make another wild suggestion for this, which is
> > a combination of (1) and (A):
> > "# [test_case->name]: [ok|not ok] [index] - param-[index]"
>
> I strongly object to putting actual testcase results in comments.
> I'd rather that we found a way to include the parameter in the
> sub-test-case name, rather than require all parsers to know about
> specially-formatted comments.  There are tools outside
> the kernel that parse these lines.
>

I wasn't intending to treat these as actual testcases yet: from
KUnit's point of view, they're definitely just supposed to be
human-readable diagnostic comments for the one combined testcase.

This largely stems from KUnit being pretty rigid in its test
hierarchy: it has test suites (the root-level testcases), which
contain tests (the first-level subtests). Basically, arbitrary nesting
of tests isn't supported at all by any of the KUnit tools, code,
documentation, etc. So, if we do actually want to treat these
individual parameters as sub-subtests, it'll require a lot of work on
the KUnit side to be able to parse and represent those results.

So, as planned at the moment, these lines won't be parsed at all (just
passed to the user), and should KUnit support more complicated test
hierarchies down the line, we can remove the "# [test_case->name]"
prefix, add the test plan lines, etc, and have this be picked up by
parsers then.


> >
> > This gives us a KTAP-compliant result line, except prepended with "#
> > [test_case->name]: ", which makes it formally a diagnostic line,
> > rather than an actual subtest. Putting the test name at the start
> > matches what kunit_tool is expecting at the moment. If we then want to
> > turn it into a proper subtest, we can just get rid of that prefix (and
> > add the appropriate counts elsewhere).
> >
> > Does that sound good?
> No.
>
> I strongly prefer option C above:
> "[ok|not ok] [index] - [test_case->name][separator]param-[index]"
>
> Except of course the second index is not the same as the first, so it
> would be:
> "[ok|not ok] [index] - [test_case->name][separator]param-[param-index]"

So, the second index would be the same as the first (at most with an
off-by-one to account for different indexing if we wished) in what I
was thinking.

I think this boils down to how we treat these tests and parameters:
- There is one TAP/KUnit test per-parameter, probably with a name like
"test_case:param-n". There's no "container" test.
- There is a test and result for the whole test, and per-parameter
tests and results are nested in that as subtests.
- There is a single test, and any per-parameter information is simply
diagnostic data for the one test, not to be parsed.

The current code follows the last of these options, and it was my view
that by having that diagnostic data be in a similar format to a test
result line, it'd be easier to convert this to the second option while
having a familiar format for people reading the results manually. Only
the first option should need separate indices for the result and the
parameter.

> If ':' is problematical as a separator, let's choose something else.
> What are the allowed and disallowed characters in the testcase name now?
> How bad would it be to use something like % or &?
>
> Unless the separator is #, I think most parsers are going to just treat t=
he whole
> string from after the '[index] -' to a following '#' as a testcase name, =
and it
> should get parsed (and presented) OK. I'm not sure what kunit_tool's prob=
lem is.
>

kunit_tool has a bug when parsing the comments / diagnostic lines,
which requires a ": " to be present. This is a bug, which is being
fixed[1], so while it's _nice_ to not trigger it, it's not really an
important long-term goal of the format. In any case, this kunit_tool
issue only affects the comment lines: if the per-parameter result line
is an actual result, rather than just a diagnostic, this shouldn't be
a problem.

In any case, I still prefer my proposed option for now -- noting that
these per-parameter results are not actually supposed to be parsed --
with then the possibility of expanding them to actual nested results
later should we wish. But if the idea of having TAP-like lines in
diagnostics seems too dangerous (e.g. because people will try to parse
them anyway), then I think the options we have are to stick to the
output format given in the current version of this patch (which
doesn't resemble a TAP result), make each parameterised version its
own test (without a "container test", which would require a bit of
extra work while computing test plans), or to hold this whole feature
back until we can support arbitrary test hierarchies in KUnit.
Personally, I'd rather not hold this feature back, and prefer to have
a single combined result available, so would just stick with v6 if
so...

Does that make sense?

Cheers,
-- David
