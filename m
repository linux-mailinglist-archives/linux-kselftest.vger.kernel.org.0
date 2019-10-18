Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C18C2DBB40
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 03:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409279AbfJRBMo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 21:12:44 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:44671 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392283AbfJRBMo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 21:12:44 -0400
Received: by mail-pf1-f182.google.com with SMTP id q21so2739019pfn.11
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2019 18:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jNYPA8gznA3jYZLZ7385Khpau1DRnbe9i1xiVhRqR9M=;
        b=g/Z51IRS35pE0Fo6TB+ZMt/RyA1rlcgUkgZDhQOanIoeaOjD7FHoFj9wKyk3aAuze1
         1WbqLJ8jywN8Pj0AHJM/2TOnVpT4XuZeSQ/UY5x0R9T0Yh70OL0K6HdtUBwwhEvPZcP3
         CrBXlpgsoXWH+ejiqr0QKXi46qY/nwG758lgrAeFgjIRejBHQ3GckR4fVF155/ee+x+m
         yCK/Klz86hzVr8u44kXjl+PvHZ0bNNkrEaogalyKfb2z70bMtt4cwzYZjk8nPtDH3QFs
         FXnnig4Wvo0Tl20X0DXkeoOe+cpNUW3skReKDswcJRW1BHLAdBOWXFfQo7NMPuU6Bfx/
         595g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jNYPA8gznA3jYZLZ7385Khpau1DRnbe9i1xiVhRqR9M=;
        b=mQTd/+q91ILvVdMkJ79XDsTSKCezkL7/fkIk2pmUKvqbuvi4sShUI1QlSfKiOvvtI6
         A1gP+RJkz8SN0acm4FPfL/SbtNNLVwLhaY7NytWhV2lGk+ncxwlIG4tKx3LqVNbwYfVt
         DaBxzWZGe5cBc4gGNvAJli8sMo/CYlQwmsORNv6kcHqr8OjY2nV16Nm+LX8KG4cRTGHg
         Ha6BidXjsALvaYJ4yLoeOE4dB0+HOKWkTWur990/vigQoV3nVPn67mSpYvhV/b+IbOwb
         ptRgFPIoT2LsY+6pYjPykIL3y5/jifaAsdKSab05/EDxrwwL4AT7NBbpLd3K1/Tnj3aR
         2Bzg==
X-Gm-Message-State: APjAAAXwlHfWgO9ELsIsLo0ZoviUj5pSicKXsSbuxGkoyW6aPV7IL1yT
        XSoylOi7p46reR94TBJiOe8+xL69/FyiPxZalBGEPQ==
X-Google-Smtp-Source: APXvYqz3tequT8LTnvnKH4cbtA5OYA+XHdZZp2QDo9czFiwq/fXL1UVEuUrgOW07BngIFUVO7AgL3O3jHebjuuUzw4A=
X-Received: by 2002:a63:3044:: with SMTP id w65mr7036026pgw.384.1571361161185;
 Thu, 17 Oct 2019 18:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191010023931.230475-1-yzaikin@google.com> <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
 <CAAXuY3qtSHENgy3S168_03ju_JwAucOAt5WEJGQ+pi5PfurP6g@mail.gmail.com>
 <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com>
 <20191011131902.GC16225@mit.edu> <CAFd5g45s1-=Z4JwJn4A1VDGu4oEGBisQ_0RFp4otUU3rKf1XpQ@mail.gmail.com>
 <1e6611e6-2fa6-6f7d-bc7f-0bc2243d9342@linuxfoundation.org>
 <20191017120833.GA25548@mit.edu> <ECADFF3FD767C149AD96A924E7EA6EAF977D0023@USCULXMSG01.am.sony.com>
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977D0023@USCULXMSG01.am.sony.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 17 Oct 2019 18:12:29 -0700
Message-ID: <CAFd5g44txp2j9May1YD9rq6bcNnCx_JKNNmnsrr+JG+cTX0chg@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v2] ext4: add kunit test for decoding
 extended timestamps
To:     "Bird, Timothy" <Tim.Bird@sony.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 17, 2019 at 3:25 PM <Tim.Bird@sony.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Theodore Y. Ts'o on October 17, 2019 2:09 AM
> >
> > On Wed, Oct 16, 2019 at 05:26:29PM -0600, Shuah Khan wrote:
> > >
> > > I don't really buy the argument that unit tests should be deterministic
> > > Possibly, but I would opt for having the ability to feed test data.
> >
> > I strongly believe that unit tests should be deterministic.
> > Non-deterministic tests are essentially fuzz tests.  And fuzz tests
> > should be different from unit tests.
>
> I'm not sure I have the entire context here, but I think deterministic
> might not be the right word, or it might not capture the exact meaning
> intended.
>
> I think there are multiple issues here:
>  1. Does the test enclose all its data, including working data and expected results?
> Or, does the test allow someone to provide working data?  This alternative
> implies that either the some of testcases or the results might be different depending on
> the data that is provided.  IMHO the test would be deterministic if it always produced
> the same results based on the same data inputs.  And if the input data was deterministic.
> I would call this a data-driven test.
>
> Since the results would be dependent on the data provided, the results
> from tests using different data would not be comparable.  Essentially,
> changing the input data changes the test so maybe it's best to consider
> this a different test.  Like 'test-with-data-A' and 'test-with-data-B'.

That kind of sound like parameterized tests[1]; it was a feature I was
thinking about adding to KUnit, but I think the general idea of
parameterized tests has fallen out of favor; I am not sure why. In any
case, I have used parameterized tests before and have found them
useful in certain circumstances.

> 2. Does the test automatically detect some attribute of the system, and adjust
> its operation based on that (does the test probe?)  This is actually quite common
> if you include things like when a test requires root access to run.  Sometimes such tests,
> when run without root privilege, run as many testcases as possible not as root, and skip
> the testcases that require root.
>
> In general, altering the test based on probed data is a form of data-driven test,
> except the data is not provided by the user.  Whether
> this is deterministic in the sense of (1) depends on whether the data that
> is probed is deterministic.  In the case or requiring root, then it should
> not change from run to run (and it should probably be reflected in the characterization
> of the results).
>
> Maybe neither of the above cases fall in the category of unit tests, but
> they are not necessarily fuzzing tests.  IMHO a fuzzing test is one which randomizes

Kind of sounds remotely similar to Haskell's QuickCheck[2]; it's sort
of a mix of unit testing and fuzz testing. I have used this style of
testing for other projects and it can be pretty useful. I actually
have a little experiment somewhere trying to port the idea to KUnit.

> the data for a data-driven test (hence using non-deterministic data).  Once the fuzzer
> has found a bug, and the data and code for a test is fixed into a reproducer program,
> then at that point it should be deterministic (modulo what I say about race condition
> tests below).
>
> >
> > We want unit tests to run quickly.  Fuzz tests need to be run for a
> > large number of passes (perhaps hours) in order to be sure that we've
> > hit any possible bad cases.  We want to be able to easily bisect fuzz
> > tests --- preferably, automatically.  And any kind of flakey test is
> > hell to bisect.
> Agreed.
>
> > It's bad enough when a test is flakey because of the underlying code.
> > But when a test is flakey because the test inputs are
> > non-deterministic, it's even worse.
> I very much agree on this as well.
>
> I'm not sure how one classes a program that seeks to invoke a race condition.
> This can take variable time, so in that sense it is not deterministic.   But it should
> produce the same result if the probabilities required for the race condition
> to be hit are fulfilled.  Probably (see what I did there :-), one needs to take
> a probabilistic approach to reproducing and bisecting such bugs.  The duration
> or iterations required to reproduce the bug (to some confidence level) may
> need to be included with the reproducer program.  I'm not sure if the syskaller
> reproducers do this or not, or if they just run forever.  One I looked at ran forever.
> But you would want to limit this in order to produce results with some confidence
> level (and not waste testing resources).
>
> ---
> The reason I want get clarity on the issue of data-driven tests is that I think
> data-driven tests and tests that probe are very much desirable.  This allows a
> test to be able to be more generalized and allows for specialization of the
> test for more scenarios without re-coding it.
> I'm not sure if this still qualifies as unit testing, but it's very useful as a means to
> extend the value of a test.  We haven't trod into the mocking parts of kunit,
> but I'm hoping that it may be possible to have that be data-driven (depending on
> what's being mocked), to make it easier to test more things using the same code.

I imagine it wouldn't be that hard to add that on as a feature of a
parameterized testing implementation.

> Finally, I think the issue of testing speed is orthogonal to whether a test is self-enclosed
> or data-driven.  Definitely fuzzers, which are experimenting with system interaction
> in a non-deterministic way, have speed problems.

[1] https://dzone.com/articles/junit-parameterized-test
[2] http://hackage.haskell.org/package/QuickCheck

Cheers!
