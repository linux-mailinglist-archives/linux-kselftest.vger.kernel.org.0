Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D1F2B1911
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Nov 2020 11:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgKMKbP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Nov 2020 05:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgKMKbP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Nov 2020 05:31:15 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCC7C0613D6
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Nov 2020 02:31:04 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 33so9199901wrl.7
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Nov 2020 02:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P5UyDjLS/2j5NOQXFG9JlqktY1ORdwFsk3E8r8jdx9g=;
        b=QvmfEZp1GR7cR7jYyHNvp7jmshkyLAUcvw5UZ+tIfWrp8FdnIuBQq+HeYxeqR2YQM2
         B3v3dfgtwwRQNo0hZCXSfLg2gYHq7gUiuWRqXtdLDvbnF6zqM5f2PhftiYLGdccFQKbs
         1hABKGykYHD3amk32f2xyTBU+B+D1eAEsX2cOVOteH5cbapv2opX9/VNFGZOZN1BKzbh
         eutWT0ipfgBRukbd8eH9VZSSxMafzAa8oMeRZ9MHDKSfjA5MYDLvxLqk7xn/dkGAGWcu
         OfYGPkF5dYxT8VyWSa6iiz/Ppb7ORagfg5GZ8y7iVkvNlacT2tvgmGVZmS8ORLVEWCe8
         VJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P5UyDjLS/2j5NOQXFG9JlqktY1ORdwFsk3E8r8jdx9g=;
        b=eo6SJu3n6+Fjg0ovDKLceBh+0yoBfEq9HVag8jRx06iCZou6CGYYerKiiLOD4th3UD
         UVvX5jfigdtJqoWNDHPXsdBVXcPrBwF6VzWOWylu6797Z3FvYtLaWYCtq+U2sewjtoKR
         mgakgCmxXFRIuATJjEWTLl5U18kuFJwZWjlHx9UxGXaYI9L5rMRmcWUhv4I234HfByHo
         4TnbTw3HI45UmrWnPpOnaVOJgLad0Lo7rabKTFmtEoUWoPwXozjY1VKAfnCsmxe2Ncp9
         SaM/6DJMI9nP8GQRY7Fm/s1eYb/j5Ph2j7KgT/WlCNlmHfZ9HZ7MBDmG2ku0kkJicL1c
         t7eQ==
X-Gm-Message-State: AOAM533VfdWmQF2CGUwS8H/Q8xTU8C56xAio6IUkzuh5WNnxfWwqRw+j
        xC5QcjSCWEWSjPISf5R1EpJavA==
X-Google-Smtp-Source: ABdhPJzSamfywisqfvIkrQffiLHRG8vrI4VkRiZPKk9wtZObNBU9jFTVzdIxhEcKMyLlAFoPY6RWUg==
X-Received: by 2002:adf:eb4c:: with SMTP id u12mr2687568wrn.73.1605263463113;
        Fri, 13 Nov 2020 02:31:03 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id n23sm9713848wmk.24.2020.11.13.02.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 02:31:01 -0800 (PST)
Date:   Fri, 13 Nov 2020 11:30:56 +0100
From:   Marco Elver <elver@google.com>
To:     David Gow <davidgow@google.com>
Cc:     "Bird, Tim" <Tim.Bird@sony.com>,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] kunit: Support for Parameterized Testing
Message-ID: <20201113103056.GA1568882@elver.google.com>
References: <CABVgOSkQ6+y7OGw2494cJa2b60EkSjncLNAgc9cJDbS=X9J3WA@mail.gmail.com>
 <CANpmjNNp2RUCE_ypp2R4MznikTYRYeCDuF7VMp+Hbh=55KWa3A@mail.gmail.com>
 <47a05c5a-485d-026b-c1c3-476ed1a97856@gmail.com>
 <CABVgOSkZ9k6bHPp=LVATWfokMSrEuD87jOfE5MiVYAEbZMmaQQ@mail.gmail.com>
 <BY5PR13MB29336C5BE374D69939DCADABFDE90@BY5PR13MB2933.namprd13.prod.outlook.com>
 <CABVgOSnJAgWvTTABaF082LuYjAoAWzrBsyu9sT7x4GGMVsOD6Q@mail.gmail.com>
 <BY5PR13MB293305FE7ED35EC2B2C81AF1FDE80@BY5PR13MB2933.namprd13.prod.outlook.com>
 <CABVgOSn0vUvHFTPPnFGCmg0pEotwr6TQXQieRV=EMqs1QmFYUw@mail.gmail.com>
 <20201112123706.GA2457520@elver.google.com>
 <CABVgOSkjExNtGny=CDT1WVaXUVgSEaf7hwx8=VY4atN5ot10KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSkjExNtGny=CDT1WVaXUVgSEaf7hwx8=VY4atN5ot10KQ@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 13, 2020 at 01:17PM +0800, David Gow wrote:
> On Thu, Nov 12, 2020 at 8:37 PM Marco Elver <elver@google.com> wrote:
[...]
> > > (It also might be a little tricky with the current implementation to
> > > produce the test plan, as the parameters come from a generator, and I
> > > don't think there's a way of getting the number of parameters ahead of
> > > time. That's a problem with the sub-subtest model, too, though at
> > > least there it's a little more isolated from other tests.)
> >
> > The whole point of generators, as I envisage it, is to also provide the
> > ability for varying parameters dependent on e.g. environment,
> > configuration, number of CPUs, etc. The current array-based generator is
> > the simplest possible use-case.
> >
> > However, we *can* require generators generate a deterministic number of
> > parameters when called multiple times on the same system.
> 
> I think this is a reasonable compromise, though it's not actually
> essential. As I understand the TAP spec, the test plan is actually
> optional (and/or can be at the end of the sequence of tests), though
> kunit_tool currently only supports having it at the beginning (which
> is strongly preferred by the spec anyway). I think we could get away
> with having it at the bottom of the subtest results though, which
> would save having to run the generator twice, when subtest support is
> added to kunit_tool.

I can't find this in the TAP spec, where should I look? Perhaps we
shouldn't venture too far off the beaten path, given we might not be the
only ones that want to parse this output.

> > To that end, I propose a v7 (below) that takes care of getting number of
> > parameters (and also displays descriptions for each parameter where
> > available).
> >
> > Now it is up to you how you want to turn the output from diagnostic
> > lines into something TAP compliant, because now we have the number of
> > parameters and can turn it into a subsubtest. But I think kunit-tool
> > doesn't understand subsubtests yet, so I suggest we take these patches,
> > and then somebody can prepare kunit-tool.
> >
> 
> This sounds good to me. The only thing I'm not sure about is the
> format of the parameter description: thus far test names be valid C
> identifier names, due to the fact they're named after the test
> function. I don't think there's a fundamental reason parameters (and
> hence, potentially, subsubtests) need to follow that convention as
> well, but it does look a bit odd.  Equally, the square brackets around
> the description shouldn't be necessary according to the TAP spec, but
> do seem to make things a little more readable, particuarly with the
> names in the ext4 inode test. I'm not too worried about either of
> those, though: I'm sure it'll look fine once I've got used to it.

The parameter description doesn't need to be a C identifier. At least
that's what I could immediately glean from TAP v13 spec (I'm looking
here: https://testanything.org/tap-version-13-specification.html and see
e.g. "ok 1 - Input file opened" ...).

[...]
> > > In any case, I'm happy to leave the final decision here to Arpitha and
> > > Marco, so long as we don't actually violate the TAP/KTAP spec and
> > > kunit_tool is able to read at least the top-level result. My
> > > preference is still to go either with the "# [test_case->name]:
> > > [ok|not ok] [index] - param-[index]", or to get rid of the
> > > per-parameter results entirely for now (or just print out a diagnostic
> > > message on failure). In any case, it's a decision we can revisit once
> > > we have support for named parameters, better tooling, or a better idea
> > > of how people are actually using this.
> >
> > Right, so I think we'll be in a better place if we implement: 1)
> > parameter to description conversion support, 2) counting parameters. So
> > I decided to see what it looks like, and it wasn't too bad. I just don't
> > know how you want to fix kunit-tool to make these non-diagnostic lines
> > and not complain, but as I said, it'd be good to not block these
> > patches.
> 
> Yup, I tried this v7, and it looks good to me. The kunit_tool work
> will probably be a touch more involved, so I definitely don't want to
> hold up supporting this on that.
> 
> My only thoughts on the v7 patch are:
> - I don't think we actually need the parameter count yet (or perhaps
> ever if we go with subtests as planned), so I be okay with getting rid
> of that.

As noted above, perhaps we should keep it for compatibility with other
parsers and CI systems we don't have much control over. It'd be a shame
if 99% of KUnit output can be parsed by some partially compliant parser,
yet this would break it.

> - It'd be a possibility to get rid of the square brackets from the
> output, and if we still want them, make them part of the test itself:
> if this were TAP formatted, those brackets would be part of the
> subsubtest name.

I don't mind. It's just that we can't prescribe a format, and as
seen below the descriptions include characters -<>=,. which can be
confusing. But perhaps you're right, so let's remove them.

But as noted, TAP doesn't seem to care. So let's remove them.

[...]
> > I hope this is a reasonable compromise for now.
> 
> Yeah: this seems like a great compromise until kunit_tool is improved.

Thank you!

-- Marco
