Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CC62B28A3
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Nov 2020 23:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgKMWiF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Nov 2020 17:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgKMWiB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Nov 2020 17:38:01 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC52C0617A7
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Nov 2020 14:37:59 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id u19so10134655lfr.7
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Nov 2020 14:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RqE3OxR3fLcJWt0UMFEVkW0qslrVCHrDJ2Sqt24Sbmw=;
        b=jCHLj6m4MAR++j5GWyqwiUgqQkCrp6edW1xtrSvfyHy7GSWTtP57EosXjkqRhtCDO8
         C4mm7llFtnvUt7UuFBahHdZfnnhomfadwWqltIQTwecnAEcuDA9chCda27/u6M7kfgQB
         m0UuTrU4gDAWtTaqCmW6qfpMb8Cdq1hWDZK3VKq664GrmSL1/IF7I8vjMjBhhcpRARzI
         lWdwIi3b/Di/irsVzk0JtS60CYgS50uBaPhntG53+Fxn4zWC7Ei/pjZYbJ1STYZXTJOr
         MiaW7mHMyoWViWHjv2Bw3ZXNS42ueUMTd6xZFCJ9WGnhhFA4PDVgK2SgFFiDJg/4LFvC
         2Izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RqE3OxR3fLcJWt0UMFEVkW0qslrVCHrDJ2Sqt24Sbmw=;
        b=iZBiLetLoMVpkerigXuSsCdr9uWJ+34ou2G39MvpCUmM7/G2XiEEZWyPvz+2t+TsHy
         EPnlPkRConon/zlhPqGNGAVXPUUZeQ0v8BZv2WgtRDSMAG2KOlZZgVGBC2U3ny14lQ19
         py8KTRGXrlCDNCofgHYJ42UqkvbLf40z9qC+aeYGK4238rScsNHqruQ40HFg3OMS9oft
         zMTXqgIn7lEv1cTRoi4XendIIJcFlJrHW7DSkqEoJNfCMVcO1VOUiM+cwfxdE6tllWPC
         IGIKuuAnuBnlQCcO8FUIW2vSlcDqQbWvbwqYPBH58TbuCyjOU32uHlrLrk/ve2Mvg9Ql
         OlVg==
X-Gm-Message-State: AOAM530fHegF042CI9ns/qPgQsjYILiPPUW+qqCsbn81UkUhhgqFTt9u
        jAxodSKqOLM1/sy8XyqKmOxhbdPPtmHQKYk6oeUD+g==
X-Google-Smtp-Source: ABdhPJxJAEyX+ydr8CN7N/Sw1lhvdBBhlUsqRFkfdnSMyxGFrSDS5AkroJKzK9ugEaBcjyZePeaDFG10stqa5Md7RD4=
X-Received: by 2002:ac2:5c01:: with SMTP id r1mr1815912lfp.436.1605307077210;
 Fri, 13 Nov 2020 14:37:57 -0800 (PST)
MIME-Version: 1.0
References: <CABVgOSkQ6+y7OGw2494cJa2b60EkSjncLNAgc9cJDbS=X9J3WA@mail.gmail.com>
 <CANpmjNNp2RUCE_ypp2R4MznikTYRYeCDuF7VMp+Hbh=55KWa3A@mail.gmail.com>
 <47a05c5a-485d-026b-c1c3-476ed1a97856@gmail.com> <CABVgOSkZ9k6bHPp=LVATWfokMSrEuD87jOfE5MiVYAEbZMmaQQ@mail.gmail.com>
 <BY5PR13MB29336C5BE374D69939DCADABFDE90@BY5PR13MB2933.namprd13.prod.outlook.com>
 <CABVgOSnJAgWvTTABaF082LuYjAoAWzrBsyu9sT7x4GGMVsOD6Q@mail.gmail.com>
 <BY5PR13MB293305FE7ED35EC2B2C81AF1FDE80@BY5PR13MB2933.namprd13.prod.outlook.com>
 <CABVgOSn0vUvHFTPPnFGCmg0pEotwr6TQXQieRV=EMqs1QmFYUw@mail.gmail.com>
 <20201112123706.GA2457520@elver.google.com> <CABVgOSkjExNtGny=CDT1WVaXUVgSEaf7hwx8=VY4atN5ot10KQ@mail.gmail.com>
 <20201113103056.GA1568882@elver.google.com>
In-Reply-To: <20201113103056.GA1568882@elver.google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 14 Nov 2020 06:37:44 +0800
Message-ID: <CABVgOS=0Qm-Aa5qgh3PRxbcV0-2ZZaQCm-4HY0dx8597oY+yXw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] kunit: Support for Parameterized Testing
To:     Marco Elver <elver@google.com>
Cc:     "Bird, Tim" <Tim.Bird@sony.com>,
        Arpitha Raghunandan <98.arpi@gmail.com>,
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
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 13, 2020 at 6:31 PM Marco Elver <elver@google.com> wrote:
>
> On Fri, Nov 13, 2020 at 01:17PM +0800, David Gow wrote:
> > On Thu, Nov 12, 2020 at 8:37 PM Marco Elver <elver@google.com> wrote:
> [...]
> > > > (It also might be a little tricky with the current implementation to
> > > > produce the test plan, as the parameters come from a generator, and I
> > > > don't think there's a way of getting the number of parameters ahead of
> > > > time. That's a problem with the sub-subtest model, too, though at
> > > > least there it's a little more isolated from other tests.)
> > >
> > > The whole point of generators, as I envisage it, is to also provide the
> > > ability for varying parameters dependent on e.g. environment,
> > > configuration, number of CPUs, etc. The current array-based generator is
> > > the simplest possible use-case.
> > >
> > > However, we *can* require generators generate a deterministic number of
> > > parameters when called multiple times on the same system.
> >
> > I think this is a reasonable compromise, though it's not actually
> > essential. As I understand the TAP spec, the test plan is actually
> > optional (and/or can be at the end of the sequence of tests), though
> > kunit_tool currently only supports having it at the beginning (which
> > is strongly preferred by the spec anyway). I think we could get away
> > with having it at the bottom of the subtest results though, which
> > would save having to run the generator twice, when subtest support is
> > added to kunit_tool.
>
> I can't find this in the TAP spec, where should I look? Perhaps we
> shouldn't venture too far off the beaten path, given we might not be the
> only ones that want to parse this output.
>

It's in the "Test Lines and the Plan" section:
"The plan is optional but if there is a plan before the test points it
must be the first non-diagnostic line output by the test file. In
certain instances a test file may not know how many test points it
will ultimately be running. In this case the plan can be the last
non-diagnostic line in the output. The plan cannot appear in the
middle of the output, nor can it appear more than once."

My only concern with running through the generator multiple times to
get the count is that it might be slow and/or more difficult if
someone uses a more complicated generator. I can't think of anything
specific yet, though, so we can always do it for now and change it
later if a problematic case occurs.

> > > To that end, I propose a v7 (below) that takes care of getting number of
> > > parameters (and also displays descriptions for each parameter where
> > > available).
> > >
> > > Now it is up to you how you want to turn the output from diagnostic
> > > lines into something TAP compliant, because now we have the number of
> > > parameters and can turn it into a subsubtest. But I think kunit-tool
> > > doesn't understand subsubtests yet, so I suggest we take these patches,
> > > and then somebody can prepare kunit-tool.
> > >
> >
> > This sounds good to me. The only thing I'm not sure about is the
> > format of the parameter description: thus far test names be valid C
> > identifier names, due to the fact they're named after the test
> > function. I don't think there's a fundamental reason parameters (and
> > hence, potentially, subsubtests) need to follow that convention as
> > well, but it does look a bit odd.  Equally, the square brackets around
> > the description shouldn't be necessary according to the TAP spec, but
> > do seem to make things a little more readable, particuarly with the
> > names in the ext4 inode test. I'm not too worried about either of
> > those, though: I'm sure it'll look fine once I've got used to it.
>
> The parameter description doesn't need to be a C identifier. At least
> that's what I could immediately glean from TAP v13 spec (I'm looking
> here: https://testanything.org/tap-version-13-specification.html and see
> e.g. "ok 1 - Input file opened" ...).
>

Yeah: it looked a bit weird for everything else to be an identifier
(given that KUnit does require it for tests), but these parameter
descriptions not to be. It's not a problem, though, so let's go ahead
with it.

> [...]
> > > > In any case, I'm happy to leave the final decision here to Arpitha and
> > > > Marco, so long as we don't actually violate the TAP/KTAP spec and
> > > > kunit_tool is able to read at least the top-level result. My
> > > > preference is still to go either with the "# [test_case->name]:
> > > > [ok|not ok] [index] - param-[index]", or to get rid of the
> > > > per-parameter results entirely for now (or just print out a diagnostic
> > > > message on failure). In any case, it's a decision we can revisit once
> > > > we have support for named parameters, better tooling, or a better idea
> > > > of how people are actually using this.
> > >
> > > Right, so I think we'll be in a better place if we implement: 1)
> > > parameter to description conversion support, 2) counting parameters. So
> > > I decided to see what it looks like, and it wasn't too bad. I just don't
> > > know how you want to fix kunit-tool to make these non-diagnostic lines
> > > and not complain, but as I said, it'd be good to not block these
> > > patches.
> >
> > Yup, I tried this v7, and it looks good to me. The kunit_tool work
> > will probably be a touch more involved, so I definitely don't want to
> > hold up supporting this on that.
> >
> > My only thoughts on the v7 patch are:
> > - I don't think we actually need the parameter count yet (or perhaps
> > ever if we go with subtests as planned), so I be okay with getting rid
> > of that.
>
> As noted above, perhaps we should keep it for compatibility with other
> parsers and CI systems we don't have much control over. It'd be a shame
> if 99% of KUnit output can be parsed by some partially compliant parser,
> yet this would break it.

KUnit has only started providing the test plans in some cases pretty
recently, and the spec does make it optional, so I'm not particularly
worried about this breaking parsers. I'm not too worried about it
causing problems to have it either, though, so if you'd rather keep
it, that's fine by me as well.

> > - It'd be a possibility to get rid of the square brackets from the
> > output, and if we still want them, make them part of the test itself:
> > if this were TAP formatted, those brackets would be part of the
> > subsubtest name.
>
> I don't mind. It's just that we can't prescribe a format, and as
> seen below the descriptions include characters -<>=,. which can be
> confusing. But perhaps you're right, so let's remove them.
>
> But as noted, TAP doesn't seem to care. So let's remove them.
>

Yeah: I have a slight preference for removing them, as TAP parsers
would otherwise include them in the parameter name, which looks a
little weird.
Of course, the point is moot until we actually fix kunit_tool and make
these subtests, so there's no fundamental reason we couldn't leave
them in for now, and remove them then if you thought it was
significantly more readable. (Personally, I'd still err on the side of
removing them to avoid any unnecessary churn.)

Cheers,
-- David
