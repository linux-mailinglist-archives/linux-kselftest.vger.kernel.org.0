Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351D72AD3DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Nov 2020 11:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgKJKfY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Nov 2020 05:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgKJKfY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Nov 2020 05:35:24 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E34C0613D3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Nov 2020 02:35:23 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id j14so12035917ots.1
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Nov 2020 02:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O9J78ygcMCgUaBelKJGuBDpmTHHQsSZqL7xxo9X1FXA=;
        b=iihJcLKgP4TSrgi/XOpJJLxcsC62DsZSrPSTjA7lSmML5YPgIbfpXonIcaUFoZ4xND
         ol7Q40wpQdgn6+48hn4iIVJ6RPMWatx/ll/y5aX3iBAd7l/30optiS9wz43TMfCYv+h2
         3LULW2nv89gzaqh0QYHdlgFn2P0+LzgIU90KRsO6wMHpQ0w8DsUOkkgMf0fXnRBMJxed
         HtTMfxmVjzq/58yo17tXXg3HgGhrb84M40048Zb30zqZibfvPSs5A6k35uGVuJ4lFW8e
         8EoBkoS3jGroVu5o/+71qHhYl/uiJ51xqICPvfWaZ+TSea4oO2tjl6O2lwl0D7vgzrKB
         BI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O9J78ygcMCgUaBelKJGuBDpmTHHQsSZqL7xxo9X1FXA=;
        b=G+OajvTjfnGDclF//2FN8e+5+ubq6GF9DJ0n1riTFaqZ5nDAVMLzSuEnwMocbX7JvT
         1j1IjLXgEEjVSw4PDd3NR3KjsoRuHkHmVMqbgMWiVXd4C6l00dg3cMniO/eN6PpB8iYf
         5wpg2Ajk5uOxxqcwiY6pSydoyyHqS09/jye9DuRZaIxLMi7bSz7C0FXXr94iameCW/Fv
         q6V2w6+t/7ZZMWrsyQ9U2yyL0iPI6BVZo+LKGDf+ozlN1QAZR69EuI5tzAgQHbx5R5WO
         0N7JmTloO/UvXSFbL+3uLPxV9S1i9ecBXGSQ3uioJ3kg6AQWDEf0IdhopYet4MpA6WcL
         XkyA==
X-Gm-Message-State: AOAM531NJaO22FSPHy0UqK6sj9xMwhfgVMVWdhhp01E23ICxm0siROSu
        tRo8hF4JLObsnp6H1nB4bQGkP6oQUwAojWkhMGSbw6cqkew=
X-Google-Smtp-Source: ABdhPJwnxEs/Uy6X8cWrXNv3gk8aEzJNoK265lQPtFA5Tp98fsZsbenX9qhYvw3oT3pOA4i1EhG2MWTej8+yAivp6AM=
X-Received: by 2002:a9d:f44:: with SMTP id 62mr14385069ott.17.1605004522694;
 Tue, 10 Nov 2020 02:35:22 -0800 (PST)
MIME-Version: 1.0
References: <20201106192154.51514-1-98.arpi@gmail.com> <CABVgOSkQ6+y7OGw2494cJa2b60EkSjncLNAgc9cJDbS=X9J3WA@mail.gmail.com>
 <CANpmjNNp2RUCE_ypp2R4MznikTYRYeCDuF7VMp+Hbh=55KWa3A@mail.gmail.com>
 <47a05c5a-485d-026b-c1c3-476ed1a97856@gmail.com> <CABVgOSkZ9k6bHPp=LVATWfokMSrEuD87jOfE5MiVYAEbZMmaQQ@mail.gmail.com>
In-Reply-To: <CABVgOSkZ9k6bHPp=LVATWfokMSrEuD87jOfE5MiVYAEbZMmaQQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 10 Nov 2020 11:35:11 +0100
Message-ID: <CANpmjNMzNauQVNKK_ToWDKrwT1LKY7Tb+ApG8drX8wtBkBbWQQ@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 10 Nov 2020 at 08:21, David Gow <davidgow@google.com> wrote:
[...]
> > >
> > > The previous attempt [1] at something similar failed because it seems
> > > we'd need to teach kunit-tool new tricks [2], too.
> > > [1] https://lkml.kernel.org/r/20201105195503.GA2399621@elver.google.c=
om
> > > [2] https://lkml.kernel.org/r/20201106123433.GA3563235@elver.google.c=
om
> > >
> > > So if we go with a different format, we might need a patch before thi=
s
> > > one to make kunit-tool compatible with that type of diagnostic.
> > >
> > > Currently I think we have the following proposals for a format:
> > >
> > > 1. The current "# [test_case->name]: param-[index] [ok|not ok]" --
> > > this works well, because no changes to kunit-tool are required, and i=
t
> > > also picks up the diagnostic context for the case and displays that o=
n
> > > test failure.
> > >
> > > 2. Your proposed "# [ok|not ok] - [test_case->name]:param-[index]".
> > > As-is, this needs a patch for kunit-tool as well. I just checked, and
> > > if we change it to "# [ok|not ok] - [test_case->name]: param-[index]"
> > > (note the space after ':') it works without changing kunit-tool. ;-)
> > >
> > > 3. Something like "# [ok|not ok] param-[index] - [test_case->name]",
> > > which I had played with earlier but kunit-tool is definitely not yet
> > > happy with.
> > >
> > > So my current preference is (2) with the extra space (no change to
> > > kunit-tool required). WDYT?
> > >
>
> Hmm=E2=80=A6 that failure in kunit_tool is definitely a bug: we shouldn't=
 care
> what comes after the comment character except if it's an explicit
> subtest declaration or a crash. I'll try to put a patch together to
> fix it, but I'd rather not delay this just for that.
>
> In any thought about this a bit more, It turns out that the proposed
> KTAP spec[1] discourages the use of ':', except as part of a subtest
> declaration, or perhaps an as-yet-unspecified fully-qualified test
> name. The latter is what I was going for, but if it's actively
> breaking kunit_tool, we might want to hold off on it.
>
> If we were to try to treat these as subtests in accordance with that
> spec, the way we'd want to use one of these options:
> A) "[ok|not ok] [index] - param-[index]" -- This doesn't mention the
> test case name, but otherwise treats things exactly the same way we
> treat existing subtests.
>
> B) "[ok|not ok] [index] - [test_case->name]" -- This doesn't name the
> "subtest", just gives repeated results with the same name.
>
> C) "[ok|not ok] [index] - [test_case->name][separator]param-[index]"
> -- This is equivalent to my suggestion with a separator of ":", or 2
> above with a separator of ": ". The in-progress spec doesn't yet
> specify how these fully-qualified names would work, other than that
> they'd use a colon somewhere, and if we comment it out, ": " is
> required.
>
> >
> > Which format do we finally go with?
> >
>
> I'm actually going to make another wild suggestion for this, which is
> a combination of (1) and (A):
> "# [test_case->name]: [ok|not ok] [index] - param-[index]"
>
> This gives us a KTAP-compliant result line, except prepended with "#
> [test_case->name]: ", which makes it formally a diagnostic line,
> rather than an actual subtest. Putting the test name at the start
> matches what kunit_tool is expecting at the moment. If we then want to
> turn it into a proper subtest, we can just get rid of that prefix (and
> add the appropriate counts elsewhere).
>
> Does that sound good?

Sounds reasonable to me!  The repetition of [index] seems unnecessary
for now, but I think if we at some point have a way to get a string
representation of a param, we can substitute param-[index] with a
string that represents the param.

Note that once we want to make it a real subtest, we'd need to run the
generator twice, once to get the number of params and then to run the
tests. If we require that param generators are deterministic in the
number of params generated, this is not a problem.

Thanks,
-- Marco
