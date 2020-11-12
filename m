Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DAA2B0121
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Nov 2020 09:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgKLITC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Nov 2020 03:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgKLITB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Nov 2020 03:19:01 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4CFC0613D1
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Nov 2020 00:18:59 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id i6so7057816lfd.1
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Nov 2020 00:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5aHTSQC0BeuDbp2ZokcqdL4Jx8wmpgI50tXPIURmz1U=;
        b=knJ2Z+RucZCjoE45rF0cXawvQCs4xUlGSHgFAdQG6YGT1s8T7TU3QliUE3iEqezuN8
         0cfwj0IkTyWrSYO5Vo/5JznNmX+iS2/W4/dDH/BSdJhFtCZhX8c6RIE9AJq2cpM64lf3
         NGUqDc/8DevPc6avVvX5SVwqOD7GAznj/w2YVur2REL8EilrqV6MWTAYUnKj6GAcixFF
         +T3i6upnMWitzxGSuGZpetx2kgCvfRR/5RVuB4DfoCr5QEkDD0WkJPmKMxQ7Di8jQFol
         j7j/+cSbJWQrr0sjR/+y9Py/Nmpg/nZRnt4QOspx09sEnVUe3wKISWoDd9XhiOejJXNP
         tC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5aHTSQC0BeuDbp2ZokcqdL4Jx8wmpgI50tXPIURmz1U=;
        b=OSSDxjlXp1q4f44aqeoS9+B8TPbMm5vwUNtYr4Lj0bEB00CuA8lvjwynsxIkDIuE5Z
         ccroTDxPHJgmhiyflkoCUM4RLOfxZYHERR3rl7CGVZzWJ4ABe20uLxdCcDxfIdQad4R9
         g5qzdgXtzPIZy28ejheBlJdEfLrtm5fkipWXiUYrfkyHl7tLU5nsP6uRQw52QIFjlK6Q
         uolw7zuzKJxoBn+ZNGL0JM+jvZJ43UOVrJG8et7TIKBFPDD6DuFMBy9ap3e47K3U/Mec
         Ss7BveNn19Hb3s4cB4gagdiIgUeOgig3RjYxhse0yVJo4WRqqIckuuFKioItqMPbRmyD
         MHtg==
X-Gm-Message-State: AOAM532ydA+Lr5OetzunObMRH721LrMY0gf3/69pdTLpk/87/EmJBgWx
        IGjD0slH4ibs8INwkaE90A70tYrSLqqhvFA8mKyb0A==
X-Google-Smtp-Source: ABdhPJxJ5hMS9vBMPi6XvArVAcOnQsSMA69TzysgSxt7HChl1SXitveirlZCGiG1Qh4d8tjBa3F4zgWehuPNPje/IPc=
X-Received: by 2002:a19:357:: with SMTP id 84mr10228049lfd.243.1605169137736;
 Thu, 12 Nov 2020 00:18:57 -0800 (PST)
MIME-Version: 1.0
References: <20201106192154.51514-1-98.arpi@gmail.com> <CABVgOSkQ6+y7OGw2494cJa2b60EkSjncLNAgc9cJDbS=X9J3WA@mail.gmail.com>
 <CANpmjNNp2RUCE_ypp2R4MznikTYRYeCDuF7VMp+Hbh=55KWa3A@mail.gmail.com>
 <47a05c5a-485d-026b-c1c3-476ed1a97856@gmail.com> <CABVgOSkZ9k6bHPp=LVATWfokMSrEuD87jOfE5MiVYAEbZMmaQQ@mail.gmail.com>
 <BY5PR13MB29336C5BE374D69939DCADABFDE90@BY5PR13MB2933.namprd13.prod.outlook.com>
 <CABVgOSnJAgWvTTABaF082LuYjAoAWzrBsyu9sT7x4GGMVsOD6Q@mail.gmail.com> <BY5PR13MB293305FE7ED35EC2B2C81AF1FDE80@BY5PR13MB2933.namprd13.prod.outlook.com>
In-Reply-To: <BY5PR13MB293305FE7ED35EC2B2C81AF1FDE80@BY5PR13MB2933.namprd13.prod.outlook.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 12 Nov 2020 16:18:45 +0800
Message-ID: <CABVgOSn0vUvHFTPPnFGCmg0pEotwr6TQXQieRV=EMqs1QmFYUw@mail.gmail.com>
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

On Thu, Nov 12, 2020 at 12:55 AM Bird, Tim <Tim.Bird@sony.com> wrote:
>
>
>
> > -----Original Message-----
> > From: David Gow <davidgow@google.com>
> >
> > On Wed, Nov 11, 2020 at 1:02 AM Bird, Tim <Tim.Bird@sony.com> wrote:
> > >
> > > > -----Original Message-----
> > > > From: David Gow <davidgow@google.com>
> > > >
> > > > On Mon, Nov 9, 2020 at 2:49 PM Arpitha Raghunandan <98.arpi@gmail.c=
om> wrote:
> > > > >
> > > > > On 07/11/20 3:36 pm, Marco Elver wrote:
> > > > > > On Sat, 7 Nov 2020 at 05:58, David Gow <davidgow@google.com> wr=
ote:
> > > > > >> On Sat, Nov 7, 2020 at 3:22 AM Arpitha Raghunandan <98.arpi@gm=
ail.com> wrote:
> > > > > >>>
> > > > > >>> Implementation of support for parameterized testing in KUnit.
> > > > > >>> This approach requires the creation of a test case using the
> > > > > >>> KUNIT_CASE_PARAM macro that accepts a generator function as i=
nput.
> > > > > >>> This generator function should return the next parameter give=
n the
> > > > > >>> previous parameter in parameterized tests. It also provides
> > > > > >>> a macro to generate common-case generators.
> > > > > >>>
> > > > > >>> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> > > > > >>> Co-developed-by: Marco Elver <elver@google.com>
> > > > > >>> Signed-off-by: Marco Elver <elver@google.com>
> > > > > >>> ---
> > > > > >>
> > > > > >> This looks good to me! A couple of minor thoughts about the ou=
tput
> > > > > >> format below, but I'm quite happy to have this as-is regardles=
s.
> > > > > >>
> > > > > >> Reviewed-by: David Gow <davidgow@google.com>
> > > > > >>
> > > > > >> Cheers,
> > > > > >> -- David
> > > > > >>
> > > > > >>> Changes v5->v6:
> > > > > >>> - Fix alignment to maintain consistency
> > > > > >>> Changes v4->v5:
> > > > > >>> - Update kernel-doc comments.
> > > > > >>> - Use const void* for generator return and prev value types.
> > > > > >>> - Add kernel-doc comment for KUNIT_ARRAY_PARAM.
> > > > > >>> - Rework parameterized test case execution strategy: each par=
ameter is executed
> > > > > >>>   as if it was its own test case, with its own test initializ=
ation and cleanup
> > > > > >>>   (init and exit are called, etc.). However, we cannot add ne=
w test cases per TAP
> > > > > >>>   protocol once we have already started execution. Instead, l=
og the result of
> > > > > >>>   each parameter run as a diagnostic comment.
> > > > > >>> Changes v3->v4:
> > > > > >>> - Rename kunit variables
> > > > > >>> - Rename generator function helper macro
> > > > > >>> - Add documentation for generator approach
> > > > > >>> - Display test case name in case of failure along with param =
index
> > > > > >>> Changes v2->v3:
> > > > > >>> - Modifictaion of generator macro and method
> > > > > >>> Changes v1->v2:
> > > > > >>> - Use of a generator method to access test case parameters
> > > > > >>>
> > > > > >>>  include/kunit/test.h | 36 ++++++++++++++++++++++++++++++++++
> > > > > >>>  lib/kunit/test.c     | 46 +++++++++++++++++++++++++++++++---=
----------
> > > > > >>>  2 files changed, 69 insertions(+), 13 deletions(-)
> > > > > >>>
> > > > > >>> diff --git a/include/kunit/test.h b/include/kunit/test.h
> > > > > >>> index db1b0ae666c4..16616d3974f9 100644
> > > > > >>> --- a/include/kunit/test.h
> > > > > >>> +++ b/include/kunit/test.h
> > > > > >>> @@ -107,6 +107,7 @@ struct kunit;
> > > > > > [...]
> > > > > >>> -       kunit_suite_for_each_test_case(suite, test_case)
> > > > > >>> -               kunit_run_case_catch_errors(suite, test_case)=
;
> > > > > >>> +       kunit_suite_for_each_test_case(suite, test_case) {
> > > > > >>> +               struct kunit test =3D { .param_value =3D NULL=
, .param_index =3D 0 };
> > > > > >>> +               bool test_success =3D true;
> > > > > >>> +
> > > > > >>> +               if (test_case->generate_params)
> > > > > >>> +                       test.param_value =3D test_case->gener=
ate_params(NULL);
> > > > > >>> +
> > > > > >>> +               do {
> > > > > >>> +                       kunit_run_case_catch_errors(suite, te=
st_case, &test);
> > > > > >>> +                       test_success &=3D test_case->success;
> > > > > >>> +
> > > > > >>> +                       if (test_case->generate_params) {
> > > > > >>> +                               kunit_log(KERN_INFO, &test,
> > > > > >>> +                                         KUNIT_SUBTEST_INDEN=
T
> > > > > >>> +                                         "# %s: param-%d %s"=
,
> > > > > >>
> > > > > >> Would it make sense to have this imitate the TAP format a bit =
more?
> > > > > >> So, have "# [ok|not ok] - [name]" as the format? [name] could =
be
> > > > > >> something like "[test_case->name]:param-[index]" or similar.
> > > > > >> If we keep it commented out and don't indent it further, it wo=
n't
> > > > > >> formally be a nested test (though if we wanted to support thos=
e later,
> > > > > >> it'd be easy to add), but I think it would be nicer to be cons=
istent
> > > > > >> here.
> > > > > >
> > > > > > The previous attempt [1] at something similar failed because it=
 seems
> > > > > > we'd need to teach kunit-tool new tricks [2], too.
> > > > > > [1] https://lkml.kernel.org/r/20201105195503.GA2399621@elver.go=
ogle.com
> > > > > > [2] https://lkml.kernel.org/r/20201106123433.GA3563235@elver.go=
ogle.com
> > > > > >
> > > > > > So if we go with a different format, we might need a patch befo=
re this
> > > > > > one to make kunit-tool compatible with that type of diagnostic.
> > > > > >
> > > > > > Currently I think we have the following proposals for a format:
> > > > > >
> > > > > > 1. The current "# [test_case->name]: param-[index] [ok|not ok]"=
 --
> > > > > > this works well, because no changes to kunit-tool are required,=
 and it
> > > > > > also picks up the diagnostic context for the case and displays =
that on
> > > > > > test failure.
> > > > > >
> > > > > > 2. Your proposed "# [ok|not ok] - [test_case->name]:param-[inde=
x]".
> > > > > > As-is, this needs a patch for kunit-tool as well. I just checke=
d, and
> > > > > > if we change it to "# [ok|not ok] - [test_case->name]: param-[i=
ndex]"
> > > > > > (note the space after ':') it works without changing kunit-tool=
. ;-)
> > > > > >
> > > > > > 3. Something like "# [ok|not ok] param-[index] - [test_case->na=
me]",
> > > > > > which I had played with earlier but kunit-tool is definitely no=
t yet
> > > > > > happy with.
> > > > > >
> > > > > > So my current preference is (2) with the extra space (no change=
 to
> > > > > > kunit-tool required). WDYT?
> > > > > >
> > > >
> > > > Hmm=E2=80=A6 that failure in kunit_tool is definitely a bug: we sho=
uldn't care
> > > > what comes after the comment character except if it's an explicit
> > > > subtest declaration or a crash. I'll try to put a patch together to
> > > > fix it, but I'd rather not delay this just for that.
> > > >
> > > > In any thought about this a bit more, It turns out that the propose=
d
> > > > KTAP spec[1] discourages the use of ':', except as part of a subtes=
t
> > > > declaration, or perhaps an as-yet-unspecified fully-qualified test
> > > > name. The latter is what I was going for, but if it's actively
> > > > breaking kunit_tool, we might want to hold off on it.
> > > >
> > > > If we were to try to treat these as subtests in accordance with tha=
t
> > > > spec, the way we'd want to use one of these options:
> > > > A) "[ok|not ok] [index] - param-[index]" -- This doesn't mention th=
e
> > > > test case name, but otherwise treats things exactly the same way we
> > > > treat existing subtests.
> > > >
> > > > B) "[ok|not ok] [index] - [test_case->name]" -- This doesn't name t=
he
> > > > "subtest", just gives repeated results with the same name.
> > > >
> > > > C) "[ok|not ok] [index] - [test_case->name][separator]param-[index]=
"
> > > > -- This is equivalent to my suggestion with a separator of ":", or =
2
> > > > above with a separator of ": ". The in-progress spec doesn't yet
> > > > specify how these fully-qualified names would work, other than that
> > > > they'd use a colon somewhere, and if we comment it out, ": " is
> > > > required.
> > > >
> > > > >
> > > > > Which format do we finally go with?
> > > > >
> > > >
> > > > I'm actually going to make another wild suggestion for this, which =
is
> > > > a combination of (1) and (A):
> > > > "# [test_case->name]: [ok|not ok] [index] - param-[index]"
> > >
> > > I strongly object to putting actual testcase results in comments.
> > > I'd rather that we found a way to include the parameter in the
> > > sub-test-case name, rather than require all parsers to know about
> > > specially-formatted comments.  There are tools outside
> > > the kernel that parse these lines.
> > >
> >
> > I wasn't intending to treat these as actual testcases yet: from
> > KUnit's point of view, they're definitely just supposed to be
> > human-readable diagnostic comments for the one combined testcase.
> >
> > This largely stems from KUnit being pretty rigid in its test
> > hierarchy: it has test suites (the root-level testcases), which
> > contain tests (the first-level subtests). Basically, arbitrary nesting
> > of tests isn't supported at all by any of the KUnit tools, code,
> > documentation, etc. So, if we do actually want to treat these
> > individual parameters as sub-subtests, it'll require a lot of work on
> > the KUnit side to be able to parse and represent those results.
> >
> > So, as planned at the moment, these lines won't be parsed at all (just
> > passed to the user), and should KUnit support more complicated test
> > hierarchies down the line, we can remove the "# [test_case->name]"
> > prefix, add the test plan lines, etc, and have this be picked up by
> > parsers then.
> >
> >
> > > >
> > > > This gives us a KTAP-compliant result line, except prepended with "=
#
> > > > [test_case->name]: ", which makes it formally a diagnostic line,
> > > > rather than an actual subtest. Putting the test name at the start
> > > > matches what kunit_tool is expecting at the moment. If we then want=
 to
> > > > turn it into a proper subtest, we can just get rid of that prefix (=
and
> > > > add the appropriate counts elsewhere).
> > > >
> > > > Does that sound good?
> > > No.
> > >
> > > I strongly prefer option C above:
> > > "[ok|not ok] [index] - [test_case->name][separator]param-[index]"
> > >
> > > Except of course the second index is not the same as the first, so it
> > > would be:
> > > "[ok|not ok] [index] - [test_case->name][separator]param-[param-index=
]"
> >
> > So, the second index would be the same as the first (at most with an
> > off-by-one to account for different indexing if we wished) in what I
> > was thinking.
> >
> > I think this boils down to how we treat these tests and parameters:
> > - There is one TAP/KUnit test per-parameter, probably with a name like
> > "test_case:param-n". There's no "container" test.
> > - There is a test and result for the whole test, and per-parameter
> > tests and results are nested in that as subtests.
> > - There is a single test, and any per-parameter information is simply
> > diagnostic data for the one test, not to be parsed.
> >
> > The current code follows the last of these options, and it was my view
> > that by having that diagnostic data be in a similar format to a test
> > result line, it'd be easier to convert this to the second option while
> > having a familiar format for people reading the results manually. Only
> > the first option should need separate indices for the result and the
> > parameter.
> >
> > > If ':' is problematical as a separator, let's choose something else.
> > > What are the allowed and disallowed characters in the testcase name n=
ow?
> > > How bad would it be to use something like % or &?
> > >
> > > Unless the separator is #, I think most parsers are going to just tre=
at the whole
> > > string from after the '[index] -' to a following '#' as a testcase na=
me, and it
> > > should get parsed (and presented) OK. I'm not sure what kunit_tool's =
problem is.
> > >
> >
> > kunit_tool has a bug when parsing the comments / diagnostic lines,
> > which requires a ": " to be present. This is a bug, which is being
> > fixed[1], so while it's _nice_ to not trigger it, it's not really an
> > important long-term goal of the format. In any case, this kunit_tool
> > issue only affects the comment lines: if the per-parameter result line
> > is an actual result, rather than just a diagnostic, this shouldn't be
> > a problem.
> >
> > In any case, I still prefer my proposed option for now -- noting that
> > these per-parameter results are not actually supposed to be parsed --
> > with then the possibility of expanding them to actual nested results
> > later should we wish. But if the idea of having TAP-like lines in
> > diagnostics seems too dangerous (e.g. because people will try to parse
> > them anyway), then I think the options we have are to stick to the
> > output format given in the current version of this patch (which
> > doesn't resemble a TAP result), make each parameterised version its
> > own test (without a "container test", which would require a bit of
> > extra work while computing test plans), or to hold this whole feature
> > back until we can support arbitrary test hierarchies in KUnit.
> It seems like you're missing a 4th option, which is just tack the paramet=
er
> name on, without using a colon, and have these testcases treated
> as unique within the context of the super-test.  Is there some reason
> these can't be expressed as individual testcases in the parent test?
>

No: there's no fundamental reason why we couldn't do that, though
there are some things which make it suboptiomal, IMHO.

Firstly, there could be a lot of parameters, and that by not grouping
them together it could make dealing with the results a little
unwieldy. The other side of that is that it'll result in tests being
split up and renamed as they're ported to use this, whereas if the
whole test shows up once (with subtests or without), the old test name
can still be there, with a single PASS/FAIL for the whole test.

(It also might be a little tricky with the current implementation to
produce the test plan, as the parameters come from a generator, and I
don't think there's a way of getting the number of parameters ahead of
time. That's a problem with the sub-subtest model, too, though at
least there it's a little more isolated from other tests.)

> > Personally, I'd rather not hold this feature back, and prefer to have
> > a single combined result available, so would just stick with v6 if
> > so...
> >
> > Does that make sense?
>
> I understand what you are saying, but this seems like a step backwards.
> We already know that having just numbers to represent a test case is not
> very human friendly. The same will go for these parameter case numbers.
> I admit to not following this kunit test parameterization effort, so I do=
n't
> know the background of how the numbers relate to the parameters.
> But there must be some actual semantic meaning to each of the parameter
> cases.  Not conveying that meaning as part of the test case name seems li=
ke
> a missed opportunity.

Yeah: I'm not a big fan of just numbering the parameters either: the
plan is to eventually support naming these. Basically, the goal is to
be able to run the same test code repeatedly with different inputs
(which may be programmatically generated): depending on the testcase /
parameter generator in question, the numbers may mean something
specific, but it's not necessarily the case. Certainly in most cases,
the order of these parameters is unlikely to matter, so having the
number be part of the test name isn't ideal there: it's unlikely to
have semantic meaning, and worst-case could be unstable due to code
changes.


>
> I'm at a little of a loss as to why, if you have valid testcase results, =
you would
> shy away from putting them into a format that is machine-readable.  If it=
's because
> the tooling is not there, then IMHO you should fix the tooling.

I think the real disconnect here is the ambiguity between treating
each run-through with a different parameter as its own test case,
versus an implementation detail of the single "meta testcase". Since
parameters are not really named/ordered properly, (and the example is
replacing a single test) it feels more like an implementation detail
to me.

> I realize that perfect is the enemy of good enough, and that there's valu=
e for humans
> to see these testcase results and manually interpret them, even if they a=
re put into
> a syntax that automated parsers will ignore.  However, I do think there's=
 a danger that
> this syntax will get canonicalized. Personally, I'd rather see the testca=
ses
> with parameters show up in the parsable results.  I'd rather sacrifice th=
e hierarchy
> than the results.

With the state of things at the moment, I don't think the individual
results for given parameters are as useful as the overall result for
the test (run over all parameters), so for me the hierarchy is more
important than the actual results. There are certainly a lot of things
we can do to make the results more useful (supporting named
parameters, for one), and actually supporting the extra level of
nesting in the tooling would make it possible to have both.

There is of course another possibility -- to just not print the
individual parameter results at all (the parameters will likely show
up in the assertion messages of failures anyway -- especially if, as
in the example, the _MSG() variants are used). That's probably
slightly easier to read than a huge list of parameters which are all
"ok" anyway...

In any case, I'm happy to leave the final decision here to Arpitha and
Marco, so long as we don't actually violate the TAP/KTAP spec and
kunit_tool is able to read at least the top-level result. My
preference is still to go either with the "# [test_case->name]:
[ok|not ok] [index] - param-[index]", or to get rid of the
per-parameter results entirely for now (or just print out a diagnostic
message on failure). In any case, it's a decision we can revisit once
we have support for named parameters, better tooling, or a better idea
of how people are actually using this.

Thanks,
-- David
