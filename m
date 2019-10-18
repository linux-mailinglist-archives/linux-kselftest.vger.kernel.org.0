Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE2CDCE0A
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 20:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394205AbfJRSfQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Oct 2019 14:35:16 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34401 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730701AbfJRSfQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Oct 2019 14:35:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id k7so3263983pll.1
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2019 11:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BG11tpM61sFH0R19SG0du9l0oPQAsIgiKufGof2sKxg=;
        b=TCDLyk7ZHyty+1w15maHEg8wiGEy1eVwnUBwMOJeZbLsZ8sl1II7Z44/7e2zgSSZvf
         NZxE+czwD0fq3n9M7vAQTBMry0HenHkOqZMQLwZizFximLLIOlE+IDqGWjEWj5yy3iEt
         mSvF9KcRddquGZfCa5fnVD3iEtU8+I94ZaobOhTx8Qkz0gkoP6r2kD7RQaVYBCtkBsr0
         S7F2HJSmFzbI5HjcCVki9LBlsxcTxuiVLXjSw8ATk0Pe0DhYbvroE/FN4V7J7DO53Oqd
         sLkAso3nd69FJ5d6g1s9aJvCjfxD6PucTCdEN7rEKA0OL+aNMKZd1mY984T9tvkYhn6z
         43rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BG11tpM61sFH0R19SG0du9l0oPQAsIgiKufGof2sKxg=;
        b=hedncjt2n+AJdXvICbd3pQ/twOdRkkSfwnfjGSB4OkERk18ii6YRfFJXXx48DdEwUY
         DU1MzdJjciCaGK2AXE3Dq76y4rao3RVjELgMrKmyJlYSIfCxBjR7Dc2Q4VWNizopIEy2
         k5bpasvAougDYTkLl7Do1sOnPeVSG/NBRpr/Vl9T1+FIH5PeBAN6CgiRdmdsIO608Yyk
         dPV5T2PLucH13/+C9uXgvvJCDJACM2M8510A3AFvU0cNNQmvtzGm6VWwRjnK4rA1bRXf
         cZzai6A7oZaFRafZuHzxCMdD4I+ccO9xKMN19HMOTf3WRbpDGP+CLWRpou5jxSNeHVbh
         r9+w==
X-Gm-Message-State: APjAAAUW93RGveBpiq/9mpZ6N5nmZ0nIChv2fyDVXL43d0vIXJ/Og22v
        WemSJXvtddfqsaJpgQnNvvygdNA5/xLYqOzRLX/SlA==
X-Google-Smtp-Source: APXvYqxdx5Aln6J3cgmn62Em539p2qXM3H5H1Y3fQw1gnIV7M4lgd12FAPekXbRXUHpumws/dGZCJdXUzh46tlA5s6E=
X-Received: by 2002:a17:902:8216:: with SMTP id x22mr11621945pln.232.1571423713326;
 Fri, 18 Oct 2019 11:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190913210247.GA86838@google.com> <20191014104243.GD16384@42.do-not-panic.com>
 <9212e0fb58683df4781c52e6ad0abd8eb496a452.camel@oracle.com>
 <869165ea-f7d6-10cf-c74a-14a33b584938@kernel.org> <40941b19855134b5032379ab4b8023a3299bd06a.camel@oracle.com>
 <20191016130857.GJ16384@42.do-not-panic.com> <345333a20601355202749b1e7de23360dc93126c.camel@oracle.com>
 <20191018094738.GA11244@42.do-not-panic.com>
In-Reply-To: <20191018094738.GA11244@42.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 18 Oct 2019 11:35:00 -0700
Message-ID: <CAFd5g46GXwUGYNe==-JN9duRfArQDrgXgepGOGXsmO5SQYo3HQ@mail.gmail.com>
Subject: Re: Plan for hybrid testing
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Knut Omang <knut.omang@oracle.com>, shuah <shuah@kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 18, 2019 at 2:47 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Thu, Oct 17, 2019 at 07:46:48PM +0200, Knut Omang wrote:
> > On Wed, 2019-10-16 at 13:08 +0000, Luis Chamberlain wrote:
> > > On Wed, Oct 16, 2019 at 12:52:12PM +0200, Knut Omang wrote:
> > > > On Mon, 2019-10-14 at 13:01 -0600, shuah wrote:
> > > > > On 10/14/19 12:38 PM, Knut Omang wrote:
> > > > > > On Mon, 2019-10-14 at 10:42 +0000, Luis Chamberlain wrote:
> > > > > > > On Fri, Sep 13, 2019 at 02:02:47PM -0700, Brendan Higgins wrote:
[...]
> > > So kselftest today implicates you know what you want to test. Or rather
> > > this is defined through what you enable and then you run *all* enabled
> > > kselftests.
> > >
> > > Similar logic follwos for kunit.
> >
> > The same applies to KTF.
> > The trivial default user application for KTF
> > (see https://lkml.org/lkml/2019/8/13/101,
> >  file tools/testing/selftests/ktf/user/ktfrun.cc)
> > would run all the kernel tests that has been enabled
> > (depending what test modules that have been inserted).
>
> I think this could be improved as well.
>
> IMHO if we are doing all these bells and whistles, ideally we should be
> able to only compile the userspace components which a target kernel
> needs. Not just the target kernel from which the code came from but also
> plugging that userspace test suites, say against another kernel and it
> figuring out what makes sense to expose, and allowing then one to only
> compile the test cases which make sense for that kernel.

Sorry, I don't think I understand what point you are trying to make
here. I don't see the problem with treating the kernel and userspace
component of a hybrid test as a unit where they are built and run
together. Is your point maybe in reference to new versions of
kselftest being used to test stable kernels?

> Also, even if one *can* compile and run a test, as you suggest, one may
> not want to run it. This has me thinking that perhaps using our own

That makes sense. I imagine that most developers will only run their
own tests over the course of normal development. Running all tests is
probably something that is mostly for CI/CD systems (or sad souls
doing large scale refactoring).

> kconfig entries for userspace targets / test cases to run makes sense.

That's my position at this point. For hybrid testing, it seems obvious
to me that userspace should be able to dictate when a test gets run
(since we have to have the two tests coordinate when they run, we
might as well have userspace - where it is easiest - take control of
the coordination). Nevertheless, I don't see why we cannot just lean
on Kconfigs or Kselftest for deciding which tests to run.

> > But if I just want to run a single test, or I want to randomize
> > the order the tests are run (to avoid unintended interdependencies),
> > or whatever other ideas people might have
> > outside the default setup, KTF offers that flexibility via netlink,
> > and allows use of a mature user land unit test suite to facilitate
> > those features, instead of having to reinvent the wheel in kernel code.
>
> There is a difference between saying generic netlink is a good option we
> should seriously consider for this problem Vs KTF's generic netlink
> implementation is suitable for this. I am stating only the former.
> The KTF netlink solution left much to be said and I am happy we are
> moving slowly with integration of what you had with KTF and what kunit
> is. For instance the level of documetnation could heavily be improved.
> My litmus test for a good generic netlink interface is to be docuemnted
> as well as say include/uapi/linux/nl80211.h.
>
> > > Yes, you can have scripts and your own tests infrastructure that knows
> > > what to test or avoid, but this is not nice for autonegotiation.
> >
> > We haven't really been setting out to do anything ambitions it this area
> > with KTF, except that we have been using simple naming of tests into
> > classes and used wilcards etc to run a subset of tests.
>
> Its a good start.
>
> One questions stand out to me based on what you say you had:
>
> Do we want to have an interface to have userspace send information to
> the kernel about what tests we want to run, or should userspace just run
> a test at a time using its own heuristics?
>
> One possible gain of having the kernel be informed of a series of tests
> is it would handle order, say if it wanted to parallelize things. But
> I think handling this in the kernel can be complex. Consider fixes to
> it, then we'd have to ensure a fix in the logic for this would have to
> be propagated as well. Userspace could just batch out tests, and if
> there issues with parallelizing them one can hope the kernel would know
> what it can or cannot do. This would allow the batching / gathering to
> done completely in userspace.

I guess that seems reasonable. We are still talking about hybrid
testing, right? If so, can we just rely on Kselftest for this
functionality? I am not saying that already does everything that we
need; I am just making the point that Kselftest seems like the obvious
place to orchestrate tests on a system that have a userspace
component. (Sorry if that is obvious, I just get the sense that we
have lost sight of that point.)

> > > Consider also the complexity of dealing with testing new tests on older
> > > kenrels. Today we address this on kselftests by striving to make sure
> > > the old scripts / tests work or yield for old kernel who don't have
> > > a feature. What if we want to really figure out what is there or not
> > > concretely?
> > >
> > > A generic netlink interface could easily allow for these
> > > sorts of things to grow and be auto negotiated.
> >
> > In general I agree that such types of negotiation is something that
> > can be explored. You can view the KTF code to set up network contexts as
> > something of a start in that sense. We have code in place that uses
> > such network context configuration to allow a unit test suite
> > to exchange address information as part of a single program multiple
> > data (SPMD) program, using MPI, to allow unit tests that requires
> > more than a single node to run.
>
> You went from one host to multiple hosts.. and MPI... I was just
> thinking about communications about what tests to run locally depending
> on the kernel. I'll ignore the MPI stuff for now.
>
> > > Then, collection of results: we have each kselftest desiging its own
> > > scatter/gather set of way to go and do what it can to test what it can
> > > and expose what should be tested, or in what order, or to allow knobs.
> > > A generic netlink interface allows a standard interface to be sketched
> > > up.
> >
> > I think we solve this by exposing flexibility to user space.
> > Why you would want to have the kernel involved in that instead of
> > just giving user mode enough info?
>
> Indeed, userspace is best for this.

Yeah, sounds pretty obvious to me too. I mean, if we have a test with
both a user space and kernel space component, we have to orchestrate
them from either kernel or user space. Since orchestration already has
to exist in userspace for kselftest, we might as well do the
orchestration for hybrid tests in the same place.

However, I feel like Knut is trying to make a point here beyond the
obvious, as I don't think anyone at anytime has suggested that the
orchestration for tests with a user space component should be done in
the kernel. Then again, maybe not; I just want to make sure we are on
the same page.

> > > I don't think the generic netlink interface implemented in the KTF
> > > patches accomplished any of this, but it at least moved the needle
> > > forward IMHO in terms of what we should consider long term.
> > >
> > > > It would be really good if more people had a closer look at the KTF patch
> > > > set before we embark on significant work of porting it to Kunit.
> > > >
> > > > For reference, the netlink code in KTF:
> > > > https://lkml.org/lkml/2019/8/13/92
> > >
> > > I read it, and it seems like a lot of stuff implemented but without
> > > a lot of proper justification and also without a lot of community
> > > feedback. Kind of like: too much done in house without proper feedback.
> > >
> > > Then it became bloated and once kunit was almost about to be merged
> > > you guys knee-jerk reacted and wanted to merge your stuff too...
> >
> > Again, just for the record, the fact is that we presented KTF
> > at LPC in 2017 (see https://lwn.net/Articles/735034/) and pushed
> > it to github for review and comments at the same time
> > (https://github.com/oracle/ktf).
> > Looking in the git repo, this was just a few weeks after the initial
> > refactoring from a project specific predecessor was complete.
> > I discussed collaboration with Brendan, who had a very early draft
> > of what later became Kunit with him, and expected from our conversation
> > that we would work together on a common proposal that covered both main
> > use cases.
>
> Alright, so kunit was just too late to lay the ground work in so far as
> upstream is concerned. Thanks for the corrections.

Huh? KUnit was too late to lay the groundwork for what?

I didn't respond to this previously because I didn't want to put fuel
on the fire that it looked like this thread was becoming.
Nevertheless, I don't think Knut's interpretation of what happened is
entirely fair. I recall quite well that Knut and I did talk after the
conference, and I remember that Knut was not interested in working
with upstream at the time, which was a pretty significant sticking
point with me. I thought that pretty much ended the collaboration
discussion. I also don't remember a common proposal; I just wanted to
start sending code upstream.

> > As to the features we added to KTF, they were in response to real test needs
> > (multithreaded test execution, override of return values to verify
> > error codepaths, the need for environment/node specific configuration like
> > different device presence/capabilities, different network configurations
> > of the test nodes, and so on..
>
> I see.. But the upstreaming never happened. Well at least the experience
> you have now with KTF can be leveraged for a proper upstream
> architecture.
>
> > > And the quality of code. Gosh, much to be said about that...
> >
> > We're of course happy to take constructive critics - do you have
> > any specifics in mind?
>
> Slowly but surely. I'm happy with where we stand on trying to blend the
> two kunit and KTF together. The generic netlink aspect of KTF however
> *does* strike me as important to scale long term, I wasn't to happy with
> its level of documentation though, I think that could be improved.

I'm still skeptical that netlink is the right approach. I imagine all
we need is just to be able to trigger testing events in the kernel
from user space and vice versa. I guess that could get pretty complex,
but I think it is best to start with something that isn't (as I hope
we have already identified in previous emails).

> > > So I think that asking to consolidate with kunit is the right thing
> > > at this point. Because we need to grow it in *community*. kunit itself
> > > has been heavily modifed to adjust to early feedback, for example, so
> > > its an example of evolution needed.
> > >
> > > > Note that unlike kunit, in KTF no tests are executed by default,
> > > > instead KTF provides an API to query about, set up and trigger execution of
> > > > tests and test parts in the kernel, and leave the actual initiation
> > > > to user space tools.
> > >
> > > This is all excellent. However baby steps. Let's demo it with a few
> > > simple tests, rather than trying to ensure it works with *all* the
> > > stuff you guys probably already have in house. That will probably have
> > > to be phased out in the future with whatever we grow *together*.

I think this is a really great point. I know it sucks building
something that you know will be thrown out on the way to the thing
that you actually want to build; however, it is unfortunately often
the right way to do things upstream. Unfortunate might not even be the
right word - you don't really know what your ideas will evolve into
when you throw them into such a large and varied community; maybe they
will go the direction that you expect and some of that work may in
fact be for naught; however, it is more likely that they will evolve
into something else.

So yeah, I think finding a simple case to start with that pairs down
the hybrid test orchestration/signaling bit as much as possible is the
right place to start.

> > Which brings me back to my original request for (constructive) feedback
> > on what we already have created.
>
> I think I've provided enough. My focus on this thread was that I am
> in hopes we don't loose sight of the possible gains of a generic netlink
> interface for testing. I think the discussions that have followed will
> help pave the way for if and how we start this.
>
> It leaves standing the question if we really need the generic netlink
> interface to figure out if a test is available or if we can just use
> header files for this as I mentioned.
>
> Can you think of a test / case where its needed and a header file may
> not suffice?

Do we really want to focus on this point now? I think it's better to
start off with something simple and evolve it. We already need to find
a way to interface KUnit to kselftest, which at this point neither are
intended to do. Netlink seems like a lot of unnecessary complexity to
introduce at the same time as trying to build up the other necessary
infrastructure in KUnit and kselftest.

Still, I don't feel that strongly about it. I don't actually really
care what mechanism we end up using to tie everything together, as
long as it doesn't add unnecessary complexity to standalone KUnit. I
just figure we can move faster if we start off really simple and
evolve it over time.

Cheers!
