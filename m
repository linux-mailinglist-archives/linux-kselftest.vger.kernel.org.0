Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0FBBDCFAD
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 21:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbfJRT6P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Oct 2019 15:58:15 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:43487 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440148AbfJRT6P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Oct 2019 15:58:15 -0400
Received: by mail-pl1-f179.google.com with SMTP id f21so3343062plj.10
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2019 12:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7jP3jHGxgPtTm7Q9OjyWwIuFs1r9B51AIY1KfevA13M=;
        b=IQqejC3mM2g5/7wzEGaI5utod3b851MzLrn2bkTdSddasHVmCy7S7iEN8HHcNdceaT
         z7JhmE/9JnVkXVblHdzNNlQcHJlaKrelwfhLHp5cZWaAGcBfcbulu+u5OE6W4SCyx3HR
         3y43hVUevxai6PikNMQMJaVsAqUKVJoI3ly9MCbiibLgb+iRDHqY+Oe1PSk9CDq5+WjO
         BPicHPegMBu4T1X4d6TeNZgJNgQNpkvj8pG1+ANPkf73MKplBNBr8KAWK5EO73GzU6iT
         hOlpcwydiudRUc6lzxgC7sc3xkFXuolBgZ6NBjWMxCAiWMZguHQ37ojpebiJqhJcxd8A
         UkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7jP3jHGxgPtTm7Q9OjyWwIuFs1r9B51AIY1KfevA13M=;
        b=U/IjslDaM1Tg8KIsMnKrXjrLJ9JRkmBLnwJ1M3+SjC55awtCBlOVS5BuB8R0vTIxBg
         Hr+Xh/jAFqcyYc1KJyiWjNAFjapGZsTvnl+2t0rioD6IvH+yvOTNFRhGCqrdTZmlgOj7
         v6siKU0n9hZz+jci4B9vgPgzIle2XNl4AfLcSim/ALTdtEkP8YZMktdodR84F7TVS+YV
         r2cet5/OiQlyrAGaNarfhNchlsweWJAVNSGXcZnPUZu2SN6y0D7ibHwFj74lMT0w2q2x
         ftCsLj8nnbbzWAZbNmi2qkcz9uUhvAu6ozB0aBYYeKtwL28hd7kTnFPLaa4JAzsY5Pys
         se4g==
X-Gm-Message-State: APjAAAWMxhpWlmcfx00EGPzjcjJol3rHKRKGiaI3IB0+scZ8sAl3rzK0
        slPvELHmF+Cs9OJp2KsOXjwa65dBV5HqP+he0bJS+Q==
X-Google-Smtp-Source: APXvYqyDDF+gUmqnAqrSYpny8Hym4gK+sEgSs4t8Un9k3hx83YArnBWXF1Ml3bhkE8b7NfB6utHrVkHOrVY1T9ZCl+s=
X-Received: by 2002:a17:902:7282:: with SMTP id d2mr9853237pll.325.1571428692997;
 Fri, 18 Oct 2019 12:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190913210247.GA86838@google.com> <20191014104243.GD16384@42.do-not-panic.com>
 <9212e0fb58683df4781c52e6ad0abd8eb496a452.camel@oracle.com>
 <869165ea-f7d6-10cf-c74a-14a33b584938@kernel.org> <40941b19855134b5032379ab4b8023a3299bd06a.camel@oracle.com>
 <20191016130857.GJ16384@42.do-not-panic.com> <345333a20601355202749b1e7de23360dc93126c.camel@oracle.com>
 <20191018094738.GA11244@42.do-not-panic.com> <CAFd5g46GXwUGYNe==-JN9duRfArQDrgXgepGOGXsmO5SQYo3HQ@mail.gmail.com>
 <20191018192257.GF11244@42.do-not-panic.com>
In-Reply-To: <20191018192257.GF11244@42.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 18 Oct 2019 12:58:01 -0700
Message-ID: <CAFd5g459xmO+=QPhnnXVO8+dB_t1PViXxK-Fz6Zp+sp5suJZ2w@mail.gmail.com>
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

On Fri, Oct 18, 2019 at 12:23 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Fri, Oct 18, 2019 at 11:35:00AM -0700, Brendan Higgins wrote:
> > On Fri, Oct 18, 2019 at 2:47 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Thu, Oct 17, 2019 at 07:46:48PM +0200, Knut Omang wrote:
> > > > On Wed, 2019-10-16 at 13:08 +0000, Luis Chamberlain wrote:
> > > > > On Wed, Oct 16, 2019 at 12:52:12PM +0200, Knut Omang wrote:
> > > > > > On Mon, 2019-10-14 at 13:01 -0600, shuah wrote:
> > > > > > > On 10/14/19 12:38 PM, Knut Omang wrote:
> > > > > > > > On Mon, 2019-10-14 at 10:42 +0000, Luis Chamberlain wrote:
> > > > > > > > > On Fri, Sep 13, 2019 at 02:02:47PM -0700, Brendan Higgins wrote:
> > Is your point maybe in reference to new versions of
> > kselftest being used to test stable kernels?
>
> Yes, that's exactly right.
>
> Today we deal with this by ensuring that selftests *should* in
> theory bail gracefully if a feature was not present in older
> kernels.
>
> Also, we have two ways to run selftests:
>
>   * run all tests
>   * user runs a test manually
>
> There's no configuration for trying to see which tests we should try
> to run, for instance. There is no handy orchestration infrastructure.
>
> In fact, each test also has its own series of orchestration tidbits,
> for instance the kmod test has a series of tests cases to run and a
> number of times it should run. Similarly, sysctl has its own
> nomenclature for this. For each refer to ALL_TESTS:
>
> tools/testing/selftests/sysctl/sysctl.sh
> ------------------------------------------------------------------------
> # This represents
> #
> # TEST_ID:TEST_COUNT:ENABLED:TARGET
> #
> # TEST_ID: is the test id number
> # TEST_COUNT: number of times we should run the test
> # ENABLED: 1 if enabled, 0 otherwise
> # TARGET: test target file required on the test_sysctl module
> #
> # Once these are enabled please leave them as-is. Write your own test,
> # we have tons of space.
> ALL_TESTS="0001:1:1:int_0001"
> ALL_TESTS="$ALL_TESTS 0002:1:1:string_0001"
> ALL_TESTS="$ALL_TESTS 0003:1:1:int_0002"
> ALL_TESTS="$ALL_TESTS 0004:1:1:uint_0001"
> ALL_TESTS="$ALL_TESTS 0005:3:1:int_0003"
> ALL_TESTS="$ALL_TESTS 0006:50:1:bitmap_0001"
> ------------------------------------------------------------------------
>
> tools/testing/selftests/kmod/kmod.sh
> ------------------------------------------------------------------------
> # This represents
> #
> # TEST_ID:TEST_COUNT:ENABLED
> #
> # TEST_ID: is the test id number
> # TEST_COUNT: number of times we should run the test
> # ENABLED: 1 if enabled, 0 otherwise
> #
> # Once these are enabled please leave them as-is. Write your own test,
> # we have tons of space.
> ALL_TESTS="0001:3:1"
> ALL_TESTS="$ALL_TESTS 0002:3:1"
> ALL_TESTS="$ALL_TESTS 0003:1:1"
> ALL_TESTS="$ALL_TESTS 0004:1:1"
> ALL_TESTS="$ALL_TESTS 0005:10:1"
> ALL_TESTS="$ALL_TESTS 0006:10:1"
> ALL_TESTS="$ALL_TESTS 0007:5:1"
> ALL_TESTS="$ALL_TESTS 0008:150:1"
> ALL_TESTS="$ALL_TESTS 0009:150:1"
> ------------------------------------------------------------------------
>
> A while ago we decided it didn't make sense sharing an infrastructure
> to specify this. But now is a good time to ask ourselves this, given
> that this seems part of "orchestration".

Got it. Okay, that makes a lot of sense.

So given we need orchestration for hybrid tests and orchestration for
the already existing kselftest. Would it maybe be easier to solve the
orchestration problem for regular kselftests first? Sorry, I don't
mean to totally derail the conversation, but it seems that those two
things should work together and hybrid test orchestration is a much
bigger, harder problem.

I am also realizing that I think we are talking about two things under
orchestration:

1) We are talking about deciding which tests to run, how, and when.

2) We are talking about signaling within a test between the kernel and
user space components.

I feel like the two points are related, but (1) is applicable to all
of kselftest, whereas (2) is only applicable to hybrid testing.

> > > Also, even if one *can* compile and run a test, as you suggest, one may
> > > not want to run it. This has me thinking that perhaps using our own
> >
> > That makes sense. I imagine that most developers will only run their
> > own tests over the course of normal development. Running all tests is
> > probably something that is mostly for CI/CD systems (or sad souls
> > doing large scale refactoring).
> >
> > > kconfig entries for userspace targets / test cases to run makes sense.
> >
> > That's my position at this point. For hybrid testing, it seems obvious
> > to me that userspace should be able to dictate when a test gets run
> > (since we have to have the two tests coordinate when they run, we
> > might as well have userspace - where it is easiest - take control of
> > the coordination). Nevertheless, I don't see why we cannot just lean
> > on Kconfigs or Kselftest for deciding which tests to run.
>
> We can, its just not there yet. There is a difference between say
> enabling CONFIG_TEST_KMOD and running the resepctive test, we don't
> currently have a userspace configuration mechanism, and while it
> seems kconfig seems trivial for this, it is important to point out
> that if we want to consider this as a path forward we may want to
> consider allowing for this configuration to be *independent* from
> the kernel. This would allow allowing a tarball of new selftests
> be deployed on another kernel let's say, and you just run 'make
> menuconig' for the test suite.

Got it. That makes sense.

I like your idea of a kconfig like configuration for kselftest that
is, well at least somewhat, independent. Maybe we could have a
separate kselftest configuration mechanism that is able to depend on
the in kernel kconfig and some of the relevant information can be
stored in the kernel and then extracted at runtime by kselftest? I
guess we already have the kconfig the kernel was configured with
available in sysfs.

Man, this is a pretty deep problem. On one hand you definitely need to
involve existing Kconfig/Kbuild for the in-kernel stuff (even if KUnit
was configured separately, it still depends on what code is compiled
into the kernel), but I also see the point of wanting to configure
outside of the kernel for kselftest. Netlink or not, this seems like a
pretty massive problem that we could have a thread about all on its
own.

> It doesn't *need* to be independent, however I see the possibility of
> detachment as a gain. Its also rather slightly odd to consider say
> having CONFIG_SELFTEST_KMOD or something like that on a kernel config.

Right.

> Doing this is rather easy, however it just would need to be discussed
> eventually if we want it.

I don't know about that; this seems like a pretty substantial
undertaking, but then again, it sounds like you have thought about
this a lot more than me :-)

> > > > But if I just want to run a single test, or I want to randomize
> > > > the order the tests are run (to avoid unintended interdependencies),
> > > > or whatever other ideas people might have
> > > > outside the default setup, KTF offers that flexibility via netlink,
> > > > and allows use of a mature user land unit test suite to facilitate
> > > > those features, instead of having to reinvent the wheel in kernel code.
> > >
> > > There is a difference between saying generic netlink is a good option we
> > > should seriously consider for this problem Vs KTF's generic netlink
> > > implementation is suitable for this. I am stating only the former.
> > > The KTF netlink solution left much to be said and I am happy we are
> > > moving slowly with integration of what you had with KTF and what kunit
> > > is. For instance the level of documetnation could heavily be improved.
> > > My litmus test for a good generic netlink interface is to be docuemnted
> > > as well as say include/uapi/linux/nl80211.h.
> > >
> > > > > Yes, you can have scripts and your own tests infrastructure that knows
> > > > > what to test or avoid, but this is not nice for autonegotiation.
> > > >
> > > > We haven't really been setting out to do anything ambitions it this area
> > > > with KTF, except that we have been using simple naming of tests into
> > > > classes and used wilcards etc to run a subset of tests.
> > >
> > > Its a good start.
> > >
> > > One questions stand out to me based on what you say you had:
> > >
> > > Do we want to have an interface to have userspace send information to
> > > the kernel about what tests we want to run, or should userspace just run
> > > a test at a time using its own heuristics?
> > >
> > > One possible gain of having the kernel be informed of a series of tests
> > > is it would handle order, say if it wanted to parallelize things. But
> > > I think handling this in the kernel can be complex. Consider fixes to
> > > it, then we'd have to ensure a fix in the logic for this would have to
> > > be propagated as well. Userspace could just batch out tests, and if
> > > there issues with parallelizing them one can hope the kernel would know
> > > what it can or cannot do. This would allow the batching / gathering to
> > > done completely in userspace.
> >
> > I guess that seems reasonable. We are still talking about hybrid
> > testing, right?
>
> Yes
>
> > If so, can we just rely on Kselftest for this
> > functionality? I am not saying that already does everything that we
> > need; I am just making the point that Kselftest seems like the obvious
> > place to orchestrate tests on a system that have a userspace
> > component. (Sorry if that is obvious, I just get the sense that we
> > have lost sight of that point.)
>
> Yes it is just that selftests lets you test all or you run your own
> test that see fit, it has no orchestration.

Got it. Sorry, for the unnecessary comment.

> > > > > Consider also the complexity of dealing with testing new tests on older
> > > > > kenrels. Today we address this on kselftests by striving to make sure
> > > > > the old scripts / tests work or yield for old kernel who don't have
> > > > > a feature. What if we want to really figure out what is there or not
> > > > > concretely?
> > > > >
> > > > > A generic netlink interface could easily allow for these
> > > > > sorts of things to grow and be auto negotiated.
> > > >
> > > > In general I agree that such types of negotiation is something that
> > > > can be explored. You can view the KTF code to set up network contexts as
> > > > something of a start in that sense. We have code in place that uses
> > > > such network context configuration to allow a unit test suite
> > > > to exchange address information as part of a single program multiple
> > > > data (SPMD) program, using MPI, to allow unit tests that requires
> > > > more than a single node to run.
> > >
> > > You went from one host to multiple hosts.. and MPI... I was just
> > > thinking about communications about what tests to run locally depending
> > > on the kernel. I'll ignore the MPI stuff for now.
> > >
> > > > > Then, collection of results: we have each kselftest desiging its own
> > > > > scatter/gather set of way to go and do what it can to test what it can
> > > > > and expose what should be tested, or in what order, or to allow knobs.
> > > > > A generic netlink interface allows a standard interface to be sketched
> > > > > up.
> > > >
> > > > I think we solve this by exposing flexibility to user space.
> > > > Why you would want to have the kernel involved in that instead of
> > > > just giving user mode enough info?
> > >
> > > Indeed, userspace is best for this.
> >
> > Yeah, sounds pretty obvious to me too. I mean, if we have a test with
> > both a user space and kernel space component, we have to orchestrate
> > them from either kernel or user space. Since orchestration already has
> > to exist in userspace for kselftest, we might as well do the
> > orchestration for hybrid tests in the same place.
> >
> > However, I feel like Knut is trying to make a point here beyond the
> > obvious, as I don't think anyone at anytime has suggested that the
> > orchestration for tests with a user space component should be done in
> > the kernel. Then again, maybe not; I just want to make sure we are on
> > the same page.
>
> Knut was pointing out the generic netlink interface from KTF allowed
> userspace to figure out what to orchestrate.

Cool. Sorry again.

> > > > > I don't think the generic netlink interface implemented in the KTF
> > > > > patches accomplished any of this, but it at least moved the needle
> > > > > forward IMHO in terms of what we should consider long term.
> > > > >
> > > > > > It would be really good if more people had a closer look at the KTF patch
> > > > > > set before we embark on significant work of porting it to Kunit.
> > > > > >
> > > > > > For reference, the netlink code in KTF:
> > > > > > https://lkml.org/lkml/2019/8/13/92
> > > > >
> > > > > I read it, and it seems like a lot of stuff implemented but without
> > > > > a lot of proper justification and also without a lot of community
> > > > > feedback. Kind of like: too much done in house without proper feedback.
> > > > >
> > > > > Then it became bloated and once kunit was almost about to be merged
> > > > > you guys knee-jerk reacted and wanted to merge your stuff too...
> > > >
> > > > Again, just for the record, the fact is that we presented KTF
> > > > at LPC in 2017 (see https://lwn.net/Articles/735034/) and pushed
> > > > it to github for review and comments at the same time
> > > > (https://github.com/oracle/ktf).
> > > > Looking in the git repo, this was just a few weeks after the initial
> > > > refactoring from a project specific predecessor was complete.
> > > > I discussed collaboration with Brendan, who had a very early draft
> > > > of what later became Kunit with him, and expected from our conversation
> > > > that we would work together on a common proposal that covered both main
> > > > use cases.
> > >
> > > Alright, so kunit was just too late to lay the ground work in so far as
> > > upstream is concerned. Thanks for the corrections.
> >
> > Huh? KUnit was too late to lay the groundwork for what?
>
> I meant KTF.

Okay, that makes a lot more sense. Nevermind. Sorry about the tangent.

> > > > As to the features we added to KTF, they were in response to real test needs
> > > > (multithreaded test execution, override of return values to verify
> > > > error codepaths, the need for environment/node specific configuration like
> > > > different device presence/capabilities, different network configurations
> > > > of the test nodes, and so on..
> > >
> > > I see.. But the upstreaming never happened. Well at least the experience
> > > you have now with KTF can be leveraged for a proper upstream
> > > architecture.
> > >
> > > > > And the quality of code. Gosh, much to be said about that...
> > > >
> > > > We're of course happy to take constructive critics - do you have
> > > > any specifics in mind?
> > >
> > > Slowly but surely. I'm happy with where we stand on trying to blend the
> > > two kunit and KTF together. The generic netlink aspect of KTF however
> > > *does* strike me as important to scale long term, I wasn't to happy with
> > > its level of documentation though, I think that could be improved.
> >
> > I'm still skeptical that netlink is the right approach. I imagine all
> > we need is just to be able to trigger testing events in the kernel
> > from user space and vice versa. I guess that could get pretty complex,
> > but I think it is best to start with something that isn't (as I hope
> > we have already identified in previous emails).
>
> Simplicity is king, however I don't think Knut did sufficient justice
> to that one possible gain of it that I saw from it. Consider that Knut
> also has an infrastructure for testing already which relies on
> orchestration -- that means an alternative is needed anyway, which
> is why I figured I'd him in, to point out at least one value I see
> from it.

Fair enough.

> Whether or not we embrace generic netlink *should be still be debated*,
> however if we *don't* go with it, Knut will need a way to figure out
> a way to allow orchestration.

Absolutely. I wasn't trying to shut the conversation down entirely. I
just figured the scope of what we were thinking about was swelling
pretty dramatically. I thought Shuah, Knut, and myself had an
executable plan to work from, and here we were pretty significantly
expanding the scope. Nevertheless, I guess those two things are not
exclusive. We can start out with something simple while also
concurrently discussing what the long term plan is.

> > > > Which brings me back to my original request for (constructive) feedback
> > > > on what we already have created.
> > >
> > > I think I've provided enough. My focus on this thread was that I am
> > > in hopes we don't loose sight of the possible gains of a generic netlink
> > > interface for testing. I think the discussions that have followed will
> > > help pave the way for if and how we start this.
> > >
> > > It leaves standing the question if we really need the generic netlink
> > > interface to figure out if a test is available or if we can just use
> > > header files for this as I mentioned.
> > >
> > > Can you think of a test / case where its needed and a header file may
> > > not suffice?
> >
> > Do we really want to focus on this point now? I think it's better to
> > start off with something simple and evolve it.
>
> Addressing it can help simplfiy things long term, as perhaps we really
> don't need something like generic netlink to orchestrate.

Sure, I just think it sounds like we don't need it for a lot of
things, so if something significantly simpler exists, maybe we should
just start there. But yeah, starting that discussion here and now
doesn't hurt as long as we don't lose sight of something concrete in
the short term.

Cool, sounds like we are on the same page then.

Thanks!
