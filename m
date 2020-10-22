Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35752964E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Oct 2020 20:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369694AbgJVSyD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Oct 2020 14:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2902353AbgJVSyD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Oct 2020 14:54:03 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1FBC0613CF
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Oct 2020 11:54:02 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id h7so1734829pfn.2
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Oct 2020 11:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kgzi+g1ki8/8D0IVfdBW9d0VukE2gz0oMmxOEAh2jy0=;
        b=RLsEyXfQqINT56bd+1ghDSJy/112xAsquJHcPYpL8rpw6gfrYXws7WLQf3HRsb46HW
         9kfE6Ss/NsZd/+pqBGNuDdOBEGOo/tJ99p/1P3aylPmASezmvMrXGj5x/yVHwUK74P20
         LevQtLmGQcK5svBypPaci4LQCMU1uVX0SoMO/R+SFiMvqkAbMJXvYj/jyIaHcbo2oDbK
         70AzOyunOzKb1tUQAyuqIuddZCw3KA/2dzhUt4+oRm9pcAFz4z4XxHnYjn6DngMvO6v2
         67MUAdJ0k4cubC08bM79nUadhQzqwqqZNSvhnKQV1NcGaKJDuG/WO8bQldQsrBtvCy4z
         l+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kgzi+g1ki8/8D0IVfdBW9d0VukE2gz0oMmxOEAh2jy0=;
        b=QS9lW0Qk1WZ/Hyl2bBUtDBuVXzVdVlojyhtaI2OgVnhrcfi/WyFw43EWiWUo067+xj
         vIaX9h/5huUSGgdiQYmfPtMRfgx37PfRe5amcPgAxhz/pj6JecYFGmlWWpsHasOuSE2K
         YeSZJibI2Ft/qYEUgP5qKwE2FBp0QSzys7JEn1by4xt9tE7E8O7Gy1+mwH4HdE/NPcqc
         17wpbs2wSc5V8mICfpG8cLCi+8bMEUL6w4ryna8GjTCvrxxM8lLWGEAM1upqJUvJdA0/
         jKBNqTbb29AGZM6uH4qkSGWzxp9Q+9OxEdU3VdjM9hSo3D9GOHnIE+uHtK1osuzihceM
         0skA==
X-Gm-Message-State: AOAM532eGTxEjVdHsTJ+LFSIwUgy7EbMp+xO7AFXBI7bS3lhWsrI0xLM
        92CKgTBHnpUA/ZHgHcHz8PK+dB1SLl/qaEwLp+w0ow==
X-Google-Smtp-Source: ABdhPJztuiJc4LFHMI3/T4e2afibm+hWy2ErB/jBpMUMTHX73yqhbl+YzrOi/hNiNzxGw6rXhip6gAwQJy45WiGD7GY=
X-Received: by 2002:a17:90a:3e4e:: with SMTP id t14mr3665884pjm.217.1603392841690;
 Thu, 22 Oct 2020 11:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201019224556.3536790-1-dlatypov@google.com> <CABVgOS=Kucf3QV=jpo3cLDgG38WvnuKpzEdP_RkBtRwHHPLe3Q@mail.gmail.com>
 <CAGS_qxpX0Do+z-wzCC=twbt-htL=Jkqvrk4L4rKTtXFPfX-TCA@mail.gmail.com> <20201022150648.GH4077@smile.fi.intel.com>
In-Reply-To: <20201022150648.GH4077@smile.fi.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 22 Oct 2020 11:53:50 -0700
Message-ID: <CAFd5g45o2G-bUvHNk2ehNuCsK6zVjN+rp88TyNmuJpfLbQi07g@mail.gmail.com>
Subject: Re: [PATCH] lib: add basic KUnit test for lib/math
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 22, 2020 at 8:06 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Oct 21, 2020 at 10:47:50AM -0700, Daniel Latypov wrote:
> > On Tue, Oct 20, 2020 at 8:40 PM David Gow <davidgow@google.com> wrote:
> > > On Tue, Oct 20, 2020 at 6:46 AM Daniel Latypov <dlatypov@google.com> wrote:
> > > >
> > > > Add basic test coverage for files that don't require any config options:
> > > > * gcd.c
> > > > * lcm.c
> > > > * int_sqrt.c
> > > > * reciprocal_div.c
> > > > (Ignored int_pow.c since it's a simple textbook algorithm.)
> > > >
> > > I don't see a particular reason why int_pow.c being a simple algorithm
> > > means it shouldn't be tested. I'm not saying it has to be tested by
> > > this particular change -- and I doubt the test would be
> > > earth-shatteringly interesting -- but there's no real reason against
> > > testing it.
> >
> > Agreed on principle, but int_pow() feels like a special case.
> > I've written it the exact same way (modulo variable names+types)
> > several times in personal projects.
> > Even the spacing matched exactly in a few of those...
>
> But if you would like to *teach* somebody by this exemplary piece of code, you
> better do it close to ideal.
>
> > > > These tests aren't particularly interesting, but
> > > > * they're chosen as easy to understand examples of how to write tests
> > > > * provides a place to add tests for any new files in this dir
> > > > * written so adding new test cases to cover edge cases should be easy
> > >
> > > I think these tests can stand on their own merits, rather than just as
> > > examples (though I do think they do make good additional examples for
> > > how to test these sorts of functions).
> > > So, I'd treat this as an actual test of the maths functions (and
> > > you've got what seems to me a decent set of test cases for that,
> > > though there are a couple of comments below) first, and any use it
> > > gains as an example is sort-of secondary to that (anything that makes
> > > it a better example is likely to make it a better test anyway).
> > >
> > > In any case, modulo the comments below, this seems good to me.
> >
> > Ack.
> > I'll wait on Andy's input before deciding whether or not to push out a
> > v2 with the changes.
>
> You need to put detailed comments in the code to have it as real example how to
> create the KUnit test. But hey, it will mean that documentation sucks. So,
> please update documentation to cover issues that you found and which motivated
> you to create these test cases.

I don't entirely disagree; leaning too heavily on code examples can be
detrimental to docs. That being said, when I use other people's code,
I often don't even look at the docs. So, I think the ideal is to have
both.

> Summarize this, please create usable documentation first.
