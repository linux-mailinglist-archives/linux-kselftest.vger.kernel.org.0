Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E921FBF43
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jun 2020 21:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbgFPTol (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jun 2020 15:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728518AbgFPTol (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jun 2020 15:44:41 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F61C061573
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 12:44:41 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id z63so9074479pfb.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 12:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F56cyQheS9nDNFVlJ/4WRy+BhlNATC6O3TmssNhkL8A=;
        b=uHxHjpK07EclsDuBvONLo5rOiIEiZ7kgMocY8DSr//2va03wpG+ak4dmbrGqDbBNII
         N72Ok6sGKSnHUPLF6LEuGQp9waCtBlAOfkWzpSVxKG7Q3u7EAbUCHnNGQA98fmbahdb7
         rBn1qsfzkJOJoyZ7NHi+K9qTsKRUaa9DeqxzR5Na7wTt1AKNY38/Mf+/Q711iFcTKD8x
         Xy+T4ntp9VsDiXqKcAt47xvJN43gyrYQchLCLNOWhlxL7J8VWZQGkweNqQ8vu0Lmztzx
         8yO/PGPmvsWRrdNenpIjpHwvjmY80jqrdlG57llDMuf0tQ4NFUCXQ9pSLG8CFRLq4vEz
         hidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F56cyQheS9nDNFVlJ/4WRy+BhlNATC6O3TmssNhkL8A=;
        b=bT8KUi+hQxCq5+u1W7808X8brGwDZPk20SxYCIDqqwZYWD212TdSaiDydVvX2T7Ifc
         OmL8j8PO0l9UVXmasMIbCgSwq+Zmh/bK5b5wmzTneSRIXhA2RxxhPl+jRzQ63skE7Co5
         2zBBu8LeJi7bIAuL6tQjPnBzlHhm8MLmTt7OagLN3AGZTPCHe58zNYp9Tf/VAoxgVP/4
         zpcfukxH4WCA/JRKtT0/7upVFztQmfCI8Kd+25V5n31CqbgW8Y/24z0nBVzvF5j+XLVY
         e87FtA6NeFMDO/tij6ByxI5AlZ+QB/CYoCw8iDXVoVXVC6PmapMi71gvX+ZecnUYVT14
         SPyg==
X-Gm-Message-State: AOAM533B6KmIilmSLnWjv1RpI6erQFXRTBKBTRdD2Xl+adiu8GoquVf0
        LL7Fcx37Zz8b6sK+S1Pte8PDveaOH7x/8/8a/WLxrw==
X-Google-Smtp-Source: ABdhPJzbS6ysZyKv26dphua26KNlY3fp+PQBcQtAfJn5B628lO3AluGA8zYw0WwEue4n6eXYt/vitciHV97AwELV9J4=
X-Received: by 2002:a63:d04b:: with SMTP id s11mr3140205pgi.384.1592336680021;
 Tue, 16 Jun 2020 12:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006141120.96FF8C5@keescook> <CY4PR13MB11757D57CD441C5CAEC3F257FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <7161fadb-45ba-c4c0-8bbb-cb47d2dd0265@redhat.com> <CY4PR13MB11755F5A6879CA3FFD005426FD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
In-Reply-To: <CY4PR13MB11755F5A6879CA3FFD005426FD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 16 Jun 2020 12:44:28 -0700
Message-ID: <CAFd5g454n4ZPgCdWaAxezFueG47TztqBx4L7x4oYwgPAR3BZNA@mail.gmail.com>
Subject: Re: RFC - kernel selftest result documentation (KTAP)
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 16, 2020 at 9:42 AM Bird, Tim <Tim.Bird@sony.com> wrote:

Apologies for taking so long to get to this. I have been busy with
some stuff internally at Google.

> > -----Original Message-----
> > From: Paolo Bonzini <pbonzini@redhat.com>
> >
> > On 15/06/20 21:07, Bird, Tim wrote:
> > >> Note: making the plan line required differs from TAP13 and TAP14. I
> > >> think it's the right choice, but we should be clear.
> >
> > As an aside, where is TAP14?
> By TAP14, I was referring to the current, undocumented, KUnit
> conventions.

Not so. TAP14 is the proposed next version of TAP13:

https://github.com/TestAnything/testanything.github.io/pull/36
https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-14-specification.md

Based on the discussion, it seems like most of the things we wanted
from TAP14 would probably make it in if TAP ever accepts another pull
request.

Our only real extension is how we print out a violated exception/assertion.

> > > With regards to making it optional or not, I don't have a strong
> > > preference.  The extra info seems helpful in some circumstances.
> > > I don't know if it's too onerous to make it a requirement or not.
> > > I'd prefer if it was always there (either at the beginning or the end),
> > > but if there is some situation where it's quite difficult to calculate,
> > > then it would be best not to mandate it. I can't think of any impossible
> > > situations at the moment.
> >
> > I think making the plan mandatory is a good idea.  "Late plans" work
> > very well for cases where you cannot know in advance the number of tests
> > (for example in filters that produce TAP from other output), and provide
> > an additional safety net.
> >
> > >> "Bail out!" to be moved to "optional" elements, since it may not appear.
> > >> And we should clarify TAP13 and TAP14's language to say it should only
> > >> appear when the test is aborting without running later tests -- for this
> > >> reason, I think the optional "description" following "Bail out!" should
> > >> be made required. I.e. it must be: "Bail out! $reason"
> > >
> > > I'll make sure this is listed as optional.
> > > I like adding a mandatory reason.
> >
> > +1.
> >
> > >> TAP13/14 makes description optional, are we making it required (I think
> > >> we should). There seems to be a TAP13/14 "convention" of starting
> > >> <description> with "- ", which I'm on the fence about it. It does make
> > >> parsing maybe a little easier.
> > >
> > > I would like the description to be required.
> > > I don't have a strong opinion on the dash.  I'm OK with either one (dash
> > > or no dash), but we should make kselftest and KUnit consistent.
> >
> > I think no mandatory dash is better (or even mandatory no-dash!).  We
> > can suggest removing it when formatting TAP output.
>
> My personal preference is to have the dash.  I think it's more human readable.
> I note that the TAP spec has examples of result lines both with and without
> the dash, so even the spec is ambiguous on this.   I think not mandating it
> either way is probably best.  For regex parsers, it's easy to ignore with '[-]?'
> outside the pattern groups that grab the number and description.

I don't think we care, because we don't use it.

> >
> > >>> Finally, it is possible to use a test directive to indicate another
> > >>> possible outcome for a test: that it was skipped.  To report that
> > >>> a test case was skipped, the result line should start with the
> > >>> result "not ok", and the directive "# SKIP" should be placed after
> > >>> the test description. (Note that this deviates from the TAP13
> > >>> specification).
> >
> > How so?  The description comes first, but there can be a description of
> > the directive.
> None of the examples of skips in the TAP13 spec have a test descriptions before
> the '# SKIP' directive.  But maybe I read too much into the examples. There is a
> format example, and a list of items in a result line that both have the test description
> before the directive.  So maybe I read this wrong.
>
> >
> >      not ok 4 - Summarized correctly # TODO Not written yet
> >
> > >>> It is usually helpful if a diagnostic message is emitted to explain
> > >>> the reasons for the skip.  If the message is a single line and is
> > >>> short, the diagnostic message may be placed after the '# SKIP'
> > >>> directive on the same line as the test result.  However, if it is
> > >>> not on the test result line, it should precede the test line (see
> > >>> diagnostic data, next).
> > >>>
> > >>> Bail out!
> > >>> ---------
> > >>> If a line in the test output starts with 'Bail out!', it indicates
> > >>> that the test was aborted for some reason.  It indicates that
> > >>> the test is unable to proceed, and no additional tests will be
> > >>> performed.
> > >>>
> > >>> This can be used at the very beginning of a test, or anywhere in the
> > >>> middle of the test, to indicate that the test can not continue.
> > >>
> > >> I think the required syntax should be:
> > >>
> > >> Bail out! <reason>
> > >>
> > >> And to make it clear that this is optionally used to indicate an early
> > >> abort. (Though with a leading plan line, a parser should be able to
> > >> determine this on its own.)
> >
> > True.  However, "Bail out!" allow to distinguish issues with the harness
> > (such as ENOSPC) from test aborts.
> >
> > >>>  - TODO directive
> > >>
> > >> Agreed: SKIP should cover everything TODO does.
> >
> > XFAIL/XPASS are different from SKIP.  I personally don't have a need for
> > them, but kselftests includes XFAIL/XPASS exit codes and they aren't
> > reflected into selftests/kselftest/runner.sh.
> >
> > Likewise, kselftest.h has ksft_inc_xfail_cnt but not
> > ksft_test_result_xfail/ksft_test_result_xpass.
> >
> > It's important to notice in the spec that the TODO directive inverts the
> > direction of ok/not-ok (i.e. XFAIL, the "good" result, is represented by
> > "not ok # TODO").
>
> The TAP13 spec is not explicit about the result for TODO (and only provides
> one example), but the text *does* say a TODO can represent a bug to be fixed.
> This makes it the equivalent of XFAIL.  I hadn't noticed this before.  Thanks.
>
> >
> > >>>  - test identifier
> > >>>     - multiple parts, separated by ':'
> > >>
> > >> This is interesting... is the goal to be able to report test status over
> > >> time by name?
> >
> > What about "/" instead?
> In my experience, / is used in a lot of test descriptions (when quoting
> file paths) (not in kselftest, but in lots of other tests).  Both Fuego
> and KernelCI use colons, and that's what kselftest already uses,
> so it seems like a good choice.
>
> >
> > >>> Finally,
> > >>>   - Should a SKIP result be 'ok' (TAP13 spec) or 'not ok' (current kselftest practice)?
> > >>> See https://testanything.org/tap-version-13-specification.html
> > >>
> > >> Oh! I totally missed this. Uhm. I think "not ok" makes sense to me "it
> > >> did not run successfully". ... but ... Uhhh ... how do XFAIL and SKIP
> > >> relate? Neither SKIP nor XFAIL count toward failure, though, so both
> > >> should be "ok"? I guess we should change it to "ok".
> >
> > See above for XFAIL.
> >
> > I initially raised the issue with "SKIP" because I have a lot of tests
> > that depend on hardware availability---for example, a test that does not
> > run on some processor kinds (e.g. on AMD, or old Intel)---and for those
> > SKIP should be considered a success.
> >
> > Paolo
> >
> > > I have the same initial impression.  In my mind, a skip is "not ok", since
> > > the test didn't run. However, a SKIP and should be treated differently
> > > from either "ok" or "not ok" by the results interpreter, so I don't think it
> > > matters.  Originally I was averse to changing the SKIP result to "ok"
> > > (as suggested by Paulo Bonzini [1]), but I checked and it's pretty trivial to
> > > change the parser in Fuego, and it would make the kernel results format
> > > match the TAP13 spec.  I don't see a strong reason for us to be different
> > > from TAP13 here.
> > >
> > > I raised this issue on our automated testing conference call last week
> > > (which includes people from the CKI, Fuego, KernelCI and LKFT projects), and
> > > so people should be chiming in if their parser will have a problem with this change.)
> > >
> > > [1]  https://lkml.kernel.org/lkml/20200610154447.15826-1-pbonzini@redhat.com/T/
> > >
> > > Thanks very much for the feedback.
> > >  -- Tim
> > >
>
