Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9762964DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Oct 2020 20:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369737AbgJVSvO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Oct 2020 14:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S369614AbgJVSvO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Oct 2020 14:51:14 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC020C0613CF
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Oct 2020 11:51:13 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n16so1460768pgv.13
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Oct 2020 11:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JK95h1Bz6+JkKSL1J/k5X9Qfj1Cu3gdnHRpEmCdWMtM=;
        b=gMKlu+toLxgxSilhSxYek3K/UIfDPbIjZEHWZPsUSj6bRomfbjZ6L7slD8DEMbY6qX
         EghuDwI2t4lzc5VJUx8gXV7nixUZptPVx/tj0TFRyncIKuYcSrFPO8eS6UXXsJxd8LzC
         Wr8DPMCBGawepMI+IsFiMi5ti1nnXhmQyNVXRBLyRZrX3eFVAD6kSiMjKCyqQqvYc3PJ
         lAk97Q1VgVdZIDB3hvddGBV+TTvPhnqm/bkQpXhWSyoF0mZEosje+/c4o8Mt6x3pN21R
         GRpFVM3dEk29yCq9K1fl+ZEiE/Nz+CLGS2jRp8su58g5c2taVy0XtDrRrPfwMzsXAzV8
         UNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JK95h1Bz6+JkKSL1J/k5X9Qfj1Cu3gdnHRpEmCdWMtM=;
        b=oGrrqjAmJuJXh0LMqAZBgFQav+2Xiahp+/qjYoWN236luT/oWLeJuHxTedAc+Fn0kV
         Yc1ItoVkuYJ4Vz2In0EcwlBBbFiDTh3nj92nR2XUJem5+NSJAQXSkHlbF49v4wngeH8d
         61RGAStYFCT8A8MiFIi1jh327xLS6oYCK9Q/rSMG2KdoEfTAvRbM7UUc2MXqBKf2ouBL
         x9juN05kS6Ibv/ON8Dq7r15dFoE6i1LPdHHuutCdqjE5CamxqxLcAUrp1kX5m/A/JZIL
         dOj0TJ3PEMNl2lZbK8RazeOFOzkNNW9o9lyF++L06f38ZfRoGnzwdASPMzzthEXRV4T+
         FjIw==
X-Gm-Message-State: AOAM5319PEN8qp2DI5awfjNEgOx0ycNF+yS2kxKjlwRXyPTC7qn3luZB
        sw62KkND8UB94kkRRHCRHPQSrUFa3sbOUnv9GL/xSQ==
X-Google-Smtp-Source: ABdhPJxzylxcvLsdO5wye2keV0/RW2IJbgAG0fWwVUNv2a0EM8i9p5Bg12aAnJpFb3B0/T8JYhNlydHZkFoFkMeAb2U=
X-Received: by 2002:a63:b0e:: with SMTP id 14mr3215269pgl.384.1603392672965;
 Thu, 22 Oct 2020 11:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201019224556.3536790-1-dlatypov@google.com> <CABVgOS=Kucf3QV=jpo3cLDgG38WvnuKpzEdP_RkBtRwHHPLe3Q@mail.gmail.com>
 <CAGS_qxpX0Do+z-wzCC=twbt-htL=Jkqvrk4L4rKTtXFPfX-TCA@mail.gmail.com>
 <20201022150648.GH4077@smile.fi.intel.com> <CAGS_qxogKfYBr=5jPsON60NTAoqqSK2y+dQodnZ5r0Uo0ecJ3Q@mail.gmail.com>
In-Reply-To: <CAGS_qxogKfYBr=5jPsON60NTAoqqSK2y+dQodnZ5r0Uo0ecJ3Q@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 22 Oct 2020 11:51:01 -0700
Message-ID: <CAFd5g44aNYTKwadaGD74MEn-xr_fPnPPRL9dfn9eY8ogyYm11g@mail.gmail.com>
Subject: Re: [PATCH] lib: add basic KUnit test for lib/math
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 22, 2020 at 9:26 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Thu, Oct 22, 2020 at 8:06 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Wed, Oct 21, 2020 at 10:47:50AM -0700, Daniel Latypov wrote:
> > > On Tue, Oct 20, 2020 at 8:40 PM David Gow <davidgow@google.com> wrote:
> > > > On Tue, Oct 20, 2020 at 6:46 AM Daniel Latypov <dlatypov@google.com> wrote:
> > > > >
> > > > > Add basic test coverage for files that don't require any config options:
> > > > > * gcd.c
> > > > > * lcm.c
> > > > > * int_sqrt.c
> > > > > * reciprocal_div.c
> > > > > (Ignored int_pow.c since it's a simple textbook algorithm.)
> > > > >
> > > > I don't see a particular reason why int_pow.c being a simple algorithm
> > > > means it shouldn't be tested. I'm not saying it has to be tested by
> > > > this particular change -- and I doubt the test would be
> > > > earth-shatteringly interesting -- but there's no real reason against
> > > > testing it.
> > >
> > > Agreed on principle, but int_pow() feels like a special case.
> > > I've written it the exact same way (modulo variable names+types)
> > > several times in personal projects.
> > > Even the spacing matched exactly in a few of those...
> >
> > But if you would like to *teach* somebody by this exemplary piece of code, you
> > better do it close to ideal.
> >
> > > > > These tests aren't particularly interesting, but
> > > > > * they're chosen as easy to understand examples of how to write tests
> > > > > * provides a place to add tests for any new files in this dir
> > > > > * written so adding new test cases to cover edge cases should be easy
> > > >
> > > > I think these tests can stand on their own merits, rather than just as
> > > > examples (though I do think they do make good additional examples for
> > > > how to test these sorts of functions).
> > > > So, I'd treat this as an actual test of the maths functions (and
> > > > you've got what seems to me a decent set of test cases for that,
> > > > though there are a couple of comments below) first, and any use it
> > > > gains as an example is sort-of secondary to that (anything that makes
> > > > it a better example is likely to make it a better test anyway).
> > > >
> > > > In any case, modulo the comments below, this seems good to me.
> > >
> > > Ack.
> > > I'll wait on Andy's input before deciding whether or not to push out a
> > > v2 with the changes.
> >
> > You need to put detailed comments in the code to have it as real example how to
> > create the KUnit test. But hey, it will mean that documentation sucks. So,
>
> Out of curiosity
> * By "it will mean that documentation sucks," do you mean that the
> documentation will rot faster if people are using the existing in-tree
> tests as their entrypoint?
> * What level of detailed comments? On the level of kunit-example-test.c?
>   * More concretely, then we'd have a comment block linking to the
> example and then describing table driven unit testing?
>   * And then maybe another block about invariants instead of the
> perhaps too-terse /* gcd(a,b) == gcd(b,a) */ ?
>
> > please update documentation to cover issues that you found and which motivated
> > you to create these test cases.
> >
> > Summarize this, please create usable documentation first.
>
> Sounds good.
> I'm generally wary people not reading the docs, and of documentation
> examples becoming bitrotted faster than actual code.
> But so far KUnit seems to be doing relatively well on both fronts.
>
> usage.rst is currently the best place for this, but it felt like it
> would quickly become a dumping ground for miscellaneous tips and
> tricks.

Yeah, I think it has already started to become a dumping ground for
everything; it already has everything except: getting started, FAQ,
API reference, and some minor details about the command line tool.

> I'll spend some time thinking if we want a new file or not, based on
> how much I want to write about the things this test demonstrated
> (EXPECT_*MSG, table driven tests, testing invariants, etc).
>
> In offline discussions with David, the idea had come up with having a
> set of (relatively) simple tests in tree that the documentation could
> point to as examples of these things. That would keep the line count
> in usage.rst down a bit.
> (But then it would necessitate more tests like this math_test.c)

I do like the idea of having as much example code as possible in a
place where it actually gets compiled occasionally. One of the biggest
bitrot issues we have had in KUnit documentation so far is example
code falling out of date; that's less likely to happen if the examples
get compiled.

It would be super cool if there was some way to have example code in
the documentation that also gets compiled and run, but I don't believe
that that would be a feasible thing to do right now.

In any case, not to sound hypocritical or lazy, but when I use other
people's code I tend to trust the code a lot more than I trust the
docs. Even if we do an absolutely stellar job with our docs, I suspect
other devs will feel the same.
