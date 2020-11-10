Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B832ADC42
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Nov 2020 17:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgKJQlO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Nov 2020 11:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgKJQlN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Nov 2020 11:41:13 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF36C0613D3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Nov 2020 08:41:13 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id m13so15025650oih.8
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Nov 2020 08:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=izOyzxAEdr+DI01iVm48YK7PFRjR8KW8FC4qJD6+q7g=;
        b=dfqAtJ6i1g/8zXDewDWAZzZC9ODZMAAauizp0O00z0plxOcWjiq0KhZFTkRW8WUpzD
         xJtbQbmovoOWkY7KEL8TmYp1Ps7mC/ncBjKhSQkRJuWbdQnVMMW7McBID1pKs2rM71Gb
         f2KQbU816XD5z+rw9xKdky5heu9LFFcInnynvZZhlddc+VabMKmKOLSe2s1FCMYk6npJ
         doLkpMOt1lcbPz2ZcvNYnJaGOySktBWJez1fFMmTo03xtQAAoOLV+LHqYcBLTZW6Sv/N
         qVaKQXRPvttdl4Viygj86GexG/+11Ow/QTyVxIw8mQmtGYRWwjZhMBLXwO7hhG+Ol1ik
         TKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=izOyzxAEdr+DI01iVm48YK7PFRjR8KW8FC4qJD6+q7g=;
        b=kyg0U6WRTmfp77ntr97kgkzfAOGMdrkV8dyrnaXHxacmcciI9uzY8NF4MUrQZkg9xn
         rTR1X6iAMeWmenLqbYJM2jiTXSb+7X+Tv1a35T9MYLe9a+uEa+FKhk1r+2Gomwnuujkw
         aMj0fYaWS7+4TnfiiMfhE+AXYKVmT9z2jzA7bCgBi3UQfLRL3JGMvUiZuNa+X1efcQqF
         PvS2xpvYp2zsKP5ya8Fyg0BZ0cnkp+LA5c9mQW4w4X5THW9G9SRsTzZK8dAXCZjb3Cok
         rfV/lbyl6mW3MQimmKZHbaE9vmEgQvYOZ8aq1G+keaSpKPLFSzngBk+vuBIDgpuW3Rk7
         u4dA==
X-Gm-Message-State: AOAM532vKY5EGjeLyp4ZjQxdfgM2LqdseUTsBvtCEILrlgzOQYN3nG8n
        unUFWZeBBwlAI4lkXFZi8yQPdB03yQ9pbhn4amNBxQ==
X-Google-Smtp-Source: ABdhPJx/HhVmD026aUKZNmLBW8yx2d6rLrKnKvoUbe5Vy8uCbDu9yQ+y4hcX1WCBNzuJSZLOuwTc032J2CVqt3vmDBA=
X-Received: by 2002:aca:6206:: with SMTP id w6mr3464315oib.121.1605026472655;
 Tue, 10 Nov 2020 08:41:12 -0800 (PST)
MIME-Version: 1.0
References: <20201106192154.51514-1-98.arpi@gmail.com> <CABVgOSkQ6+y7OGw2494cJa2b60EkSjncLNAgc9cJDbS=X9J3WA@mail.gmail.com>
 <CANpmjNNp2RUCE_ypp2R4MznikTYRYeCDuF7VMp+Hbh=55KWa3A@mail.gmail.com>
 <47a05c5a-485d-026b-c1c3-476ed1a97856@gmail.com> <CABVgOSkZ9k6bHPp=LVATWfokMSrEuD87jOfE5MiVYAEbZMmaQQ@mail.gmail.com>
 <CANpmjNMzNauQVNKK_ToWDKrwT1LKY7Tb+ApG8drX8wtBkBbWQQ@mail.gmail.com> <06106c1a-7e1b-c317-91f2-7f9c64072794@gmail.com>
In-Reply-To: <06106c1a-7e1b-c317-91f2-7f9c64072794@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 10 Nov 2020 17:41:00 +0100
Message-ID: <CANpmjNOjtU7v2tXKCESF53OMsrBYE8py1J42D-EjEqpe4XaeDA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] kunit: Support for Parameterized Testing
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     David Gow <davidgow@google.com>,
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

On Tue, 10 Nov 2020 at 17:32, Arpitha Raghunandan <98.arpi@gmail.com> wrote=
:
>
> On 10/11/20 4:05 pm, Marco Elver wrote:
> > On Tue, 10 Nov 2020 at 08:21, David Gow <davidgow@google.com> wrote:
> > [...]
> >>>>
> >>>> The previous attempt [1] at something similar failed because it seem=
s
> >>>> we'd need to teach kunit-tool new tricks [2], too.
> >>>> [1] https://lkml.kernel.org/r/20201105195503.GA2399621@elver.google.=
com
> >>>> [2] https://lkml.kernel.org/r/20201106123433.GA3563235@elver.google.=
com
> >>>>
> >>>> So if we go with a different format, we might need a patch before th=
is
> >>>> one to make kunit-tool compatible with that type of diagnostic.
> >>>>
> >>>> Currently I think we have the following proposals for a format:
> >>>>
> >>>> 1. The current "# [test_case->name]: param-[index] [ok|not ok]" --
> >>>> this works well, because no changes to kunit-tool are required, and =
it
> >>>> also picks up the diagnostic context for the case and displays that =
on
> >>>> test failure.
> >>>>
> >>>> 2. Your proposed "# [ok|not ok] - [test_case->name]:param-[index]".
> >>>> As-is, this needs a patch for kunit-tool as well. I just checked, an=
d
> >>>> if we change it to "# [ok|not ok] - [test_case->name]: param-[index]=
"
> >>>> (note the space after ':') it works without changing kunit-tool. ;-)
> >>>>
> >>>> 3. Something like "# [ok|not ok] param-[index] - [test_case->name]",
> >>>> which I had played with earlier but kunit-tool is definitely not yet
> >>>> happy with.
> >>>>
> >>>> So my current preference is (2) with the extra space (no change to
> >>>> kunit-tool required). WDYT?
> >>>>
> >>
> >> Hmm=E2=80=A6 that failure in kunit_tool is definitely a bug: we should=
n't care
> >> what comes after the comment character except if it's an explicit
> >> subtest declaration or a crash. I'll try to put a patch together to
> >> fix it, but I'd rather not delay this just for that.
> >>
> >> In any thought about this a bit more, It turns out that the proposed
> >> KTAP spec[1] discourages the use of ':', except as part of a subtest
> >> declaration, or perhaps an as-yet-unspecified fully-qualified test
> >> name. The latter is what I was going for, but if it's actively
> >> breaking kunit_tool, we might want to hold off on it.
> >>
> >> If we were to try to treat these as subtests in accordance with that
> >> spec, the way we'd want to use one of these options:
> >> A) "[ok|not ok] [index] - param-[index]" -- This doesn't mention the
> >> test case name, but otherwise treats things exactly the same way we
> >> treat existing subtests.
> >>
> >> B) "[ok|not ok] [index] - [test_case->name]" -- This doesn't name the
> >> "subtest", just gives repeated results with the same name.
> >>
> >> C) "[ok|not ok] [index] - [test_case->name][separator]param-[index]"
> >> -- This is equivalent to my suggestion with a separator of ":", or 2
> >> above with a separator of ": ". The in-progress spec doesn't yet
> >> specify how these fully-qualified names would work, other than that
> >> they'd use a colon somewhere, and if we comment it out, ": " is
> >> required.
> >>
> >>>
> >>> Which format do we finally go with?
> >>>
> >>
> >> I'm actually going to make another wild suggestion for this, which is
> >> a combination of (1) and (A):
> >> "# [test_case->name]: [ok|not ok] [index] - param-[index]"
> >>
> >> This gives us a KTAP-compliant result line, except prepended with "#
> >> [test_case->name]: ", which makes it formally a diagnostic line,
> >> rather than an actual subtest. Putting the test name at the start
> >> matches what kunit_tool is expecting at the moment. If we then want to
> >> turn it into a proper subtest, we can just get rid of that prefix (and
> >> add the appropriate counts elsewhere).
> >>
> >> Does that sound good?
> >
> > Sounds reasonable to me!  The repetition of [index] seems unnecessary
> > for now, but I think if we at some point have a way to get a string
> > representation of a param, we can substitute param-[index] with a
> > string that represents the param.
> >
>
> So, with this the inode-test.c will have the following output, right?
>
> TAP version 14
> 1..7
>     # Subtest: ext4_inode_test
>     1..1
>     # inode_test_xtimestamp_decoding: ok 0 - param-0

So the params should certainly be 0-indexed, but I think TAP starts
counting at 1, so maybe this should be:

    # inode_test_xtimestamp_decoding: ok 1 - param-0

and so on... ?

Right now it doesn't matter, but it will if we make these subsubtests
as David suggested.

>     # inode_test_xtimestamp_decoding: ok 1 - param-1
>     # inode_test_xtimestamp_decoding: ok 2 - param-2
>     # inode_test_xtimestamp_decoding: ok 3 - param-3
>     # inode_test_xtimestamp_decoding: ok 4 - param-4
>     # inode_test_xtimestamp_decoding: ok 5 - param-5
>     # inode_test_xtimestamp_decoding: ok 6 - param-6
>     # inode_test_xtimestamp_decoding: ok 7 - param-7
>     # inode_test_xtimestamp_decoding: ok 8 - param-8
>     # inode_test_xtimestamp_decoding: ok 9 - param-9
>     # inode_test_xtimestamp_decoding: ok 10 - param-10
>     # inode_test_xtimestamp_decoding: ok 11 - param-11
>     # inode_test_xtimestamp_decoding: ok 12 - param-12
>     # inode_test_xtimestamp_decoding: ok 13 - param-13
>     # inode_test_xtimestamp_decoding: ok 14 - param-14
>     # inode_test_xtimestamp_decoding: ok 15 - param-15
>     ok 1 - inode_test_xtimestamp_decoding
> ok 1 - ext4_inode_test
>
> I will send another patch with this change.
> Thanks!

Yes that looks right, but see the comment above ^

Thanks,
-- Marco
