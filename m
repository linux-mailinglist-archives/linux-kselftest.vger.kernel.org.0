Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941662B1550
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Nov 2020 06:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgKMFRW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Nov 2020 00:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgKMFRW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Nov 2020 00:17:22 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893B7C0613D1
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Nov 2020 21:17:21 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id d17so11980046lfq.10
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Nov 2020 21:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+INEfGGZXNHSOmr0KJz0TjhHBab12YSaK6rBcZVOv6g=;
        b=jnA8QCNOmppuZyCzgPGu7usknCJvYC0/HJdLzVUepnnGowEIREq0sZJFvB3oXkHLAG
         E0x8uAPx20/DUeT1GtuvzlZtaQWL9wVew4E1so1+2kTPpOpZcQh1bb0Z9cY1hbgxN3ww
         QqBUx49Bj+g4TmLNlKIq8KSKfSBKJi7tRqwOF9VeCX2L/0PqxV08P/fWwcyzqKum1X1X
         CgpnzgFUcimZG9p+e5NYJq+518pine24+RAVj7lXINQrnlioOfqXCWjBvEC1aXPTggPm
         AWxr5NRQ6cgOn+cdONF9x/K7LtJQ0s4SPDdw21hYyfrsomJXYYvV1m4kLRIWiC4sN8xF
         JKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+INEfGGZXNHSOmr0KJz0TjhHBab12YSaK6rBcZVOv6g=;
        b=FZwFUW7CC6p13xjn4Xxlb+YWaC/uTDd3eCZoUQAytpUMyRMEcA01YX6lgEqTzYXWM5
         j+hF/7Bd1Pe3GgP1RTMIxPc7UdiLldEqzFQCpj4l4B/nSwRx2rIDHnBYTfBI9RoV4JM6
         zRnPLw+bN86IwWXFdJYRj6Y6sNYkdX/RFfAGoJYX79vejQ2nb0cEgKxoyHHQIwVEy7uX
         nLPvJLCEWvIcJSlJ2NcC9AMvcmxNfp6o/4Hyltd3JFip/O8RdW9IE283M1tg385SBnzZ
         zsmHelg/vNZmavY+f63SsE4pL1gbnU2AuEBjPUNs8rB4VZJ3q4ixsWWBq6phaG+iwMqd
         EnQw==
X-Gm-Message-State: AOAM533xWY9FWG78GAEQbcGhGR4y0Tq78VVMuof0HBptH4/V3RA1ZkHE
        hXu34gzxCx2wbcHoTN9CaQNWz1uAvJY7Xnv071dgvA==
X-Google-Smtp-Source: ABdhPJyMb4jJfS3OkZr9RkF6eOui00I3gCtolwBMMh3hqbFXCWjmd4Kkp+93U4uDoS6+5P9cYgeKfj9wlN94lP0NmsQ=
X-Received: by 2002:a05:6512:683:: with SMTP id t3mr179573lfe.234.1605244639627;
 Thu, 12 Nov 2020 21:17:19 -0800 (PST)
MIME-Version: 1.0
References: <20201106192154.51514-1-98.arpi@gmail.com> <CABVgOSkQ6+y7OGw2494cJa2b60EkSjncLNAgc9cJDbS=X9J3WA@mail.gmail.com>
 <CANpmjNNp2RUCE_ypp2R4MznikTYRYeCDuF7VMp+Hbh=55KWa3A@mail.gmail.com>
 <47a05c5a-485d-026b-c1c3-476ed1a97856@gmail.com> <CABVgOSkZ9k6bHPp=LVATWfokMSrEuD87jOfE5MiVYAEbZMmaQQ@mail.gmail.com>
 <BY5PR13MB29336C5BE374D69939DCADABFDE90@BY5PR13MB2933.namprd13.prod.outlook.com>
 <CABVgOSnJAgWvTTABaF082LuYjAoAWzrBsyu9sT7x4GGMVsOD6Q@mail.gmail.com>
 <BY5PR13MB293305FE7ED35EC2B2C81AF1FDE80@BY5PR13MB2933.namprd13.prod.outlook.com>
 <CABVgOSn0vUvHFTPPnFGCmg0pEotwr6TQXQieRV=EMqs1QmFYUw@mail.gmail.com> <20201112123706.GA2457520@elver.google.com>
In-Reply-To: <20201112123706.GA2457520@elver.google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 13 Nov 2020 13:17:07 +0800
Message-ID: <CABVgOSkjExNtGny=CDT1WVaXUVgSEaf7hwx8=VY4atN5ot10KQ@mail.gmail.com>
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

On Thu, Nov 12, 2020 at 8:37 PM Marco Elver <elver@google.com> wrote:
>
> On Thu, Nov 12, 2020 at 04:18PM +0800, David Gow wrote:
> > On Thu, Nov 12, 2020 at 12:55 AM Bird, Tim <Tim.Bird@sony.com> wrote:
> [...]
> > > > kunit_tool has a bug when parsing the comments / diagnostic lines,
> > > > which requires a ": " to be present. This is a bug, which is being
> > > > fixed[1], so while it's _nice_ to not trigger it, it's not really an
> > > > important long-term goal of the format. In any case, this kunit_tool
> > > > issue only affects the comment lines: if the per-parameter result line
> > > > is an actual result, rather than just a diagnostic, this shouldn't be
> > > > a problem.
> > > >
> > > > In any case, I still prefer my proposed option for now -- noting that
> > > > these per-parameter results are not actually supposed to be parsed --
> > > > with then the possibility of expanding them to actual nested results
> > > > later should we wish. But if the idea of having TAP-like lines in
> > > > diagnostics seems too dangerous (e.g. because people will try to parse
> > > > them anyway), then I think the options we have are to stick to the
> > > > output format given in the current version of this patch (which
> > > > doesn't resemble a TAP result), make each parameterised version its
> > > > own test (without a "container test", which would require a bit of
> > > > extra work while computing test plans), or to hold this whole feature
> > > > back until we can support arbitrary test hierarchies in KUnit.
> > > It seems like you're missing a 4th option, which is just tack the parameter
> > > name on, without using a colon, and have these testcases treated
> > > as unique within the context of the super-test.  Is there some reason
> > > these can't be expressed as individual testcases in the parent test?
> > >
> >
> > No: there's no fundamental reason why we couldn't do that, though
> > there are some things which make it suboptiomal, IMHO.
> >
> > Firstly, there could be a lot of parameters, and that by not grouping
> > them together it could make dealing with the results a little
> > unwieldy. The other side of that is that it'll result in tests being
> > split up and renamed as they're ported to use this, whereas if the
> > whole test shows up once (with subtests or without), the old test name
> > can still be there, with a single PASS/FAIL for the whole test.
>
> Agree, it's suboptimal and having the parameterized not be absorbed by
> the whole suite would be strongly preferred.
>
> > (It also might be a little tricky with the current implementation to
> > produce the test plan, as the parameters come from a generator, and I
> > don't think there's a way of getting the number of parameters ahead of
> > time. That's a problem with the sub-subtest model, too, though at
> > least there it's a little more isolated from other tests.)
>
> The whole point of generators, as I envisage it, is to also provide the
> ability for varying parameters dependent on e.g. environment,
> configuration, number of CPUs, etc. The current array-based generator is
> the simplest possible use-case.
>
> However, we *can* require generators generate a deterministic number of
> parameters when called multiple times on the same system.

I think this is a reasonable compromise, though it's not actually
essential. As I understand the TAP spec, the test plan is actually
optional (and/or can be at the end of the sequence of tests), though
kunit_tool currently only supports having it at the beginning (which
is strongly preferred by the spec anyway). I think we could get away
with having it at the bottom of the subtest results though, which
would save having to run the generator twice, when subtest support is
added to kunit_tool.

> To that end, I propose a v7 (below) that takes care of getting number of
> parameters (and also displays descriptions for each parameter where
> available).
>
> Now it is up to you how you want to turn the output from diagnostic
> lines into something TAP compliant, because now we have the number of
> parameters and can turn it into a subsubtest. But I think kunit-tool
> doesn't understand subsubtests yet, so I suggest we take these patches,
> and then somebody can prepare kunit-tool.
>

This sounds good to me. The only thing I'm not sure about is the
format of the parameter description: thus far test names be valid C
identifier names, due to the fact they're named after the test
function. I don't think there's a fundamental reason parameters (and
hence, potentially, subsubtests) need to follow that convention as
well, but it does look a bit odd.  Equally, the square brackets around
the description shouldn't be necessary according to the TAP spec, but
do seem to make things a little more readable, particuarly with the
names in the ext4 inode test. I'm not too worried about either of
those, though: I'm sure it'll look fine once I've got used to it.



> Or did I miss something else?
>
> > > > Personally, I'd rather not hold this feature back, and prefer to have
> > > > a single combined result available, so would just stick with v6 if
> > > > so...
> > > >
> > > > Does that make sense?
> > >
> > > I understand what you are saying, but this seems like a step backwards.
> > > We already know that having just numbers to represent a test case is not
> > > very human friendly. The same will go for these parameter case numbers.
> > > I admit to not following this kunit test parameterization effort, so I don't
> > > know the background of how the numbers relate to the parameters.
> > > But there must be some actual semantic meaning to each of the parameter
> > > cases.  Not conveying that meaning as part of the test case name seems like
> > > a missed opportunity.
> >
> > Yeah: I'm not a big fan of just numbering the parameters either: the
> > plan is to eventually support naming these. Basically, the goal is to
> > be able to run the same test code repeatedly with different inputs
> > (which may be programmatically generated): depending on the testcase /
> > parameter generator in question, the numbers may mean something
> > specific, but it's not necessarily the case. Certainly in most cases,
> > the order of these parameters is unlikely to matter, so having the
> > number be part of the test name isn't ideal there: it's unlikely to
> > have semantic meaning, and worst-case could be unstable due to code
> > changes.
>
> We can name them. Probably a good idea to do it while we can, as I think
> the best design is changing the generator function signature.
>

This works for me. I was thinking of having a separate
parameter_to_string() function, but I think this is better.

> > > I'm at a little of a loss as to why, if you have valid testcase results, you would
> > > shy away from putting them into a format that is machine-readable.  If it's because
> > > the tooling is not there, then IMHO you should fix the tooling.
> >
> > I think the real disconnect here is the ambiguity between treating
> > each run-through with a different parameter as its own test case,
> > versus an implementation detail of the single "meta testcase". Since
> > parameters are not really named/ordered properly, (and the example is
> > replacing a single test) it feels more like an implementation detail
> > to me.
> >
> > > I realize that perfect is the enemy of good enough, and that there's value for humans
> > > to see these testcase results and manually interpret them, even if they are put into
> > > a syntax that automated parsers will ignore.  However, I do think there's a danger that
> > > this syntax will get canonicalized. Personally, I'd rather see the testcases
> > > with parameters show up in the parsable results.  I'd rather sacrifice the hierarchy
> > > than the results.
> >
> > With the state of things at the moment, I don't think the individual
> > results for given parameters are as useful as the overall result for
> > the test (run over all parameters), so for me the hierarchy is more
> > important than the actual results. There are certainly a lot of things
> > we can do to make the results more useful (supporting named
> > parameters, for one), and actually supporting the extra level of
> > nesting in the tooling would make it possible to have both.
>
> Named parameters are supported in my proposed v7 (see below). I think
> it's now up to you what the format should be, as now it's just a matter
> of changing 2 prints' formats to some non-diagnostic TAP compliant
> output (but I have no idea what ;-)).

Thanks -- I think the changes from this v7 to a TAP compliant format
should mostly just be replacing the "# [test_name]" with an extra
level of indentation. We'll just have to add support for it to
kunit_tool's parser (which has been in need of work anyway.)

> > There is of course another possibility -- to just not print the
> > individual parameter results at all (the parameters will likely show
> > up in the assertion messages of failures anyway -- especially if, as
> > in the example, the _MSG() variants are used). That's probably
> > slightly easier to read than a huge list of parameters which are all
> > "ok" anyway...
>
> To me this is not acceptable, as I'd like to see some progress feedback
> for long tests.

Hopefully most tests don't take long enough that this level of
feedback is necessary (and those that do could always log diagnostic
lines themselves), but I'm also happy with these being printed out
here.

> > In any case, I'm happy to leave the final decision here to Arpitha and
> > Marco, so long as we don't actually violate the TAP/KTAP spec and
> > kunit_tool is able to read at least the top-level result. My
> > preference is still to go either with the "# [test_case->name]:
> > [ok|not ok] [index] - param-[index]", or to get rid of the
> > per-parameter results entirely for now (or just print out a diagnostic
> > message on failure). In any case, it's a decision we can revisit once
> > we have support for named parameters, better tooling, or a better idea
> > of how people are actually using this.
>
> Right, so I think we'll be in a better place if we implement: 1)
> parameter to description conversion support, 2) counting parameters. So
> I decided to see what it looks like, and it wasn't too bad. I just don't
> know how you want to fix kunit-tool to make these non-diagnostic lines
> and not complain, but as I said, it'd be good to not block these
> patches.

Yup, I tried this v7, and it looks good to me. The kunit_tool work
will probably be a touch more involved, so I definitely don't want to
hold up supporting this on that.

My only thoughts on the v7 patch are:
- I don't think we actually need the parameter count yet (or perhaps
ever if we go with subtests as planned), so I be okay with getting rid
of that.
- It'd be a possibility to get rid of the square brackets from the
output, and if we still want them, make them part of the test itself:
if this were TAP formatted, those brackets would be part of the
subsubtest name.

>
> It currently looks like this:
>
> | TAP version 14
> | 1..6
> |     # Subtest: ext4_inode_test
> |     1..1
> |     # inode_test_xtimestamp_decoding: Test with 1..16 params
> |     # inode_test_xtimestamp_decoding: ok 1 - [1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits]
> |     # inode_test_xtimestamp_decoding: ok 2 - [1969-12-31 Upper bound of 32bit < 0 timestamp, no extra bits]
> |     # inode_test_xtimestamp_decoding: ok 3 - [1970-01-01 Lower bound of 32bit >=0 timestamp, no extra bits]
> |     # inode_test_xtimestamp_decoding: ok 4 - [2038-01-19 Upper bound of 32bit >=0 timestamp, no extra bits]
> |     # inode_test_xtimestamp_decoding: ok 5 - [2038-01-19 Lower bound of 32bit <0 timestamp, lo extra sec bit on]
> |     # inode_test_xtimestamp_decoding: ok 6 - [2106-02-07 Upper bound of 32bit <0 timestamp, lo extra sec bit on]
> |     # inode_test_xtimestamp_decoding: ok 7 - [2106-02-07 Lower bound of 32bit >=0 timestamp, lo extra sec bit on]
> |     # inode_test_xtimestamp_decoding: ok 8 - [2174-02-25 Upper bound of 32bit >=0 timestamp, lo extra sec bit on]
> |     # inode_test_xtimestamp_decoding: ok 9 - [2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit on]
> |     # inode_test_xtimestamp_decoding: ok 10 - [2242-03-16 Upper bound of 32bit <0 timestamp, hi extra sec bit on]
> |     # inode_test_xtimestamp_decoding: ok 11 - [2242-03-16 Lower bound of 32bit >=0 timestamp, hi extra sec bit on]
> |     # inode_test_xtimestamp_decoding: ok 12 - [2310-04-04 Upper bound of 32bit >=0 timestamp, hi extra sec bit on]
> |     # inode_test_xtimestamp_decoding: ok 13 - [2310-04-04 Upper bound of 32bit>=0 timestamp, hi extra sec bit 1. 1 ns]
> |     # inode_test_xtimestamp_decoding: ok 14 - [2378-04-22 Lower bound of 32bit>= timestamp. Extra sec bits 1. Max ns]
> |     # inode_test_xtimestamp_decoding: ok 15 - [2378-04-22 Lower bound of 32bit >=0 timestamp. All extra sec bits on]
> |     # inode_test_xtimestamp_decoding: ok 16 - [2446-05-10 Upper bound of 32bit >=0 timestamp. All extra sec bits on]
> |     ok 1 - inode_test_xtimestamp_decoding
> | ok 1 - ext4_inode_test
>
> Changing the format of the 2 prints to something else TAP-compliant
> should be easy enough once kunit-tool supports subsubtests. :-)
>
> I hope this is a reasonable compromise for now.

Yeah: this seems like a great compromise until kunit_tool is improved.

Thanks a bunch,
-- David
