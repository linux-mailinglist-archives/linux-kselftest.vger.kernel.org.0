Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D751FBFB2
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jun 2020 22:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731526AbgFPUED (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jun 2020 16:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731521AbgFPUEB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jun 2020 16:04:01 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F25CC06174E
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 13:04:00 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id j1so10038176pfe.4
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 13:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PcKcTI71/72Z5LusZBKeuvf2zDZMH6lCdqMCjtZxjwc=;
        b=mhkQFSPqCeGpOT0cbLkwdiGHPXeN7e9QIZLrglRjXTVOQifhguxDV02anrCqwxtl7h
         4N48CTPDGYlTGp6UphGBwN+Y5IPbJEI4OPBTBxvoImbA96C64tRGa1diHs+he0JiOfQH
         QGSm/1M4IBXVEaqOpIwXn8e1IQrEw5hfTRTGxaO6X8kIydnz+Vpy6l5ycOLnV5TmDK5d
         aLt1CQ+yDvEdhwTmhqd3X126epigpwW/ypD1cHwWEC6Vzjs90XQdyoweV9FI/25F0CuQ
         ttV3D3Yp/VdEd8bV7cH6uJUJpG08MqUEtyA7qqsFYHCYocWWlw+8vGgr+AMhjC9maPIv
         mbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PcKcTI71/72Z5LusZBKeuvf2zDZMH6lCdqMCjtZxjwc=;
        b=ViqZlBYsPAOYFonei55EavfKYlbNy97yeUcosmQpPrYEripSnIryfaAflKB1smP0ZJ
         F37+S8ky6TNJbFr6yvOAL56AtTN9yI5TS9Mwlpo1pbeuc8jI7u65GFdOR9h9/60mfTAY
         VuQ5FO51kk9yxmrWD/vB3dk+Xabgf8P5LRW8/FeKKesf867ALoZP9j7moLE7lclFjVcv
         YJKrHLV5xpFBnfWLNlOpY57nZGZM0w0PbqFrSouT31I8KiPXB9b0cbLuUkVnBOJH+ZJ0
         hTsE1eo8+Te2qM85yTdQOCF8UoU8GCabW5nRZk4MWg4vqv3jDykpPBHRhXmXrgporjiy
         fLfA==
X-Gm-Message-State: AOAM531imPW7AmwHwmeHYmVPFoL1tsj317+1JqRbZifvPzNgvN1czXed
        usAK1zbr4t3DAsIMF8j+UAlEJTpcmb+DglIHSNQh1qr3SiQ=
X-Google-Smtp-Source: ABdhPJw8ocFg3s1TY82EK5borDAuqQjIW4etwVrp+zuqvsNl5PYp2Dxf8c3z8vk9md9yQDxs5xkUIFheF5n3JER+IdU=
X-Received: by 2002:a63:d04b:: with SMTP id s11mr3190992pgi.384.1592337839520;
 Tue, 16 Jun 2020 13:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <CABVgOSkrKHs_uWLZ++_fBC_mfe3RgDxmCvnkcyn1P_wjXTV9Og@mail.gmail.com> <CY4PR13MB11756803217A9D20456E826FFD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
In-Reply-To: <CY4PR13MB11756803217A9D20456E826FFD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 16 Jun 2020 13:03:48 -0700
Message-ID: <CAFd5g458XTDftQAOm-K4Squ5-ZuZnZcFdVUG0JtUWF56cODOVg@mail.gmail.com>
Subject: Re: RFC - kernel selftest result documentation (KTAP)
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     David Gow <davidgow@google.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 15, 2020 at 10:34 AM Bird, Tim <Tim.Bird@sony.com> wrote:
>
> > -----Original Message-----
> > From: David Gow <davidgow@google.com>
> >
> > On Thu, Jun 11, 2020 at 2:11 AM Bird, Tim <Tim.Bird@sony.com> wrote:
[...]
> > KUnit is currently outputting "TAP version 14", as we were hoping some
> > of our changes would get into the TAP14 spec. (Any comments, Brendan?)
> > Maybe this should end up saying "KTAP version 1" or something?
>
> I don't know if this will break any existing results parsers or not.
> I hesitate to use "TAP version 14", as TAP appears to be a dormant
> initiative at the moment, and there's no guarantee that the kernel's
> changes will get adopted into an official spec.

We were using "TAP version 14" since the "extensions" we are using
were all proposed among the TAP people to go into the next version of
TAP. Based on discussions among them they seem to like the subtest
stuff:

https://github.com/TestAnything/testanything.github.io/pull/36

Anyway, I can still appreciate that they might change their minds.

> If we are a strict super-set of TAP, then I suppose we could just
> start using TAP version 14, and unilaterally declare that our changes
> make a new spec.  But since we don't control the web site this feels
> like a hostile takeover.

I just thought it was okay because it was already in their proposed
TAP14 spec, but yeah, if we just decide amongst ourselves to use it,
we should probably do something else.

> I'm most comfortable with calling our thing KTAP, and just
> referencing TAP as inspiration.  I don't have a strong opinion on

I am cool with that.

> KTAP vs TAP, but I do feel strongly that kselftest and kunit should use the
> same version line (if we can get them to use the same conventions).

Yeah, I agree: it would be better if there was just one version of
(K)TAP in the kernel.

> > > Test plan line
> > > --------------
> > > The test plan indicates the number of individual test cases intended to
> > > be executed by the test. It always starts with "1.." and is followed
> > > by the number of tests cases.  In the example above, 1..1", indicates
> > > that this test reports only 1 test case.
> > >
> > > The test plan line can be placed in two locations:
> > >  * the second line of test output, when the number of test cases is known
> > >    in advance
> > >  * as the last line of test output, when the number of test cases is not
> > >    known in advance.
> > >
> > > Most often, the number of test cases is known in advance, and the test plan
> > > line appears as the second line of test output, immediately following
> > > the output version line.  The number of test cases might not be known
> > > in advance if the number of tests is calculated from runtime data.
> > > In this case, the test plan line is emitted as the last line of test
> > > output.
> >
> > KUnit is currently including the test plan line only for subtests, as
> > the current version doesn't actually know how many test suites will
> > run in advance.
> > This is something there's work underway to fix, though.
> Sounds good.  You can just put the line at the bottom if it's
> obnoxious to calculate ahead of time.

I thought that is not in the TAP spec?

I kind of like printing out ahead of time how many tests we expect to
run, so if we crash we know how many tests weren't run.

In any case, until we get the change in that David is referencing, we
cannot print out the test plan for the "super test" before or after
because KUnit doesn't know when it is "done". So moving it to the
bottom doesn't really help us.

> Does this mean that KUnit treats each sub-test as an individual test case
> of the "super-test"?

Yes.

At the top level, we have all test suites. Each subtest in TAP is a
test suite in KUnit. Each case in each subtest in TAP is a test case
in KUnit.

> In results summaries for a super-test, are all sub-test cases counted,
> or just the list of sub-tests?

Just the sub-tests. Each subtest is responsible for counting it's own cases:

https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-14-specification.md#subtests

Cheers
