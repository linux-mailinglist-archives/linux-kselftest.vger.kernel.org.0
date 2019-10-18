Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C55FDCF3C
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 21:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505961AbfJRTXD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Oct 2019 15:23:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35758 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505957AbfJRTXC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Oct 2019 15:23:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id p30so3901756pgl.2
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2019 12:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IanxoaVY763Ukx5U/AZTS6k++T2PnSZjX9dbsWcnFw8=;
        b=NxpQsamnMm5LLNR8yV7O2SMiItL3xstmoxbF9D14YqKmaWNJhwizH9Oofm47mIkN6D
         FniENeOCPxd9FKAM7EkNXsIwr4V8liDFhgrfux1IKczrXZcssfBVWQoGP/gXloJcSLpv
         D8CEwzPfP0hrJXaZlUJJr/rMHS2BxHGRFq4r+Iqx2alePuWxnJkRxZBgL1wCTWis1UJ5
         I9PPDi4/E3NCIYlLtaqhhJX+M3OGTEQKTF7gbUwi1t/ckHLpSdgprSdc9cQBc5Jfoes6
         itrMk1v1dtTbt39A8dLC7Aedux9S+UvkQB2Z+Q8EpTLL+LhDTywweq7Opn7IPubYX5jJ
         gEhA==
X-Gm-Message-State: APjAAAUwuUWYymfTOOsRXRfqzlefCXF0hEMsWufh26EuhwYOXoKE8x86
        yLiJqhSfMztrvyUKhMgQ6AY=
X-Google-Smtp-Source: APXvYqzydqvTIWcTgckXv2/JDn4Wuyyi7ZAjAyiYgRSBG9ov/HIa7N6JNgC5ZkaqtRq/6VWLUowpZg==
X-Received: by 2002:a17:90a:8592:: with SMTP id m18mr13218612pjn.118.1571426580716;
        Fri, 18 Oct 2019 12:23:00 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id q42sm6603176pja.16.2019.10.18.12.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 12:22:58 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 015EB4042C; Fri, 18 Oct 2019 19:22:57 +0000 (UTC)
Date:   Fri, 18 Oct 2019 19:22:57 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Knut Omang <knut.omang@oracle.com>, shuah <shuah@kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: Re: Plan for hybrid testing
Message-ID: <20191018192257.GF11244@42.do-not-panic.com>
References: <20190913210247.GA86838@google.com>
 <20191014104243.GD16384@42.do-not-panic.com>
 <9212e0fb58683df4781c52e6ad0abd8eb496a452.camel@oracle.com>
 <869165ea-f7d6-10cf-c74a-14a33b584938@kernel.org>
 <40941b19855134b5032379ab4b8023a3299bd06a.camel@oracle.com>
 <20191016130857.GJ16384@42.do-not-panic.com>
 <345333a20601355202749b1e7de23360dc93126c.camel@oracle.com>
 <20191018094738.GA11244@42.do-not-panic.com>
 <CAFd5g46GXwUGYNe==-JN9duRfArQDrgXgepGOGXsmO5SQYo3HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g46GXwUGYNe==-JN9duRfArQDrgXgepGOGXsmO5SQYo3HQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 18, 2019 at 11:35:00AM -0700, Brendan Higgins wrote:
> On Fri, Oct 18, 2019 at 2:47 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Thu, Oct 17, 2019 at 07:46:48PM +0200, Knut Omang wrote:
> > > On Wed, 2019-10-16 at 13:08 +0000, Luis Chamberlain wrote:
> > > > On Wed, Oct 16, 2019 at 12:52:12PM +0200, Knut Omang wrote:
> > > > > On Mon, 2019-10-14 at 13:01 -0600, shuah wrote:
> > > > > > On 10/14/19 12:38 PM, Knut Omang wrote:
> > > > > > > On Mon, 2019-10-14 at 10:42 +0000, Luis Chamberlain wrote:
> > > > > > > > On Fri, Sep 13, 2019 at 02:02:47PM -0700, Brendan Higgins wrote:
> Is your point maybe in reference to new versions of
> kselftest being used to test stable kernels?

Yes, that's exactly right.

Today we deal with this by ensuring that selftests *should* in
theory bail gracefully if a feature was not present in older
kernels.

Also, we have two ways to run selftests:

  * run all tests
  * user runs a test manually

There's no configuration for trying to see which tests we should try
to run, for instance. There is no handy orchestration infrastructure.

In fact, each test also has its own series of orchestration tidbits,
for instance the kmod test has a series of tests cases to run and a
number of times it should run. Similarly, sysctl has its own
nomenclature for this. For each refer to ALL_TESTS:

tools/testing/selftests/sysctl/sysctl.sh
------------------------------------------------------------------------
# This represents                                                               
#                                                                               
# TEST_ID:TEST_COUNT:ENABLED:TARGET                                             
#                                                                               
# TEST_ID: is the test id number                                                
# TEST_COUNT: number of times we should run the test                            
# ENABLED: 1 if enabled, 0 otherwise                                            
# TARGET: test target file required on the test_sysctl module                   
#                                                                               
# Once these are enabled please leave them as-is. Write your own test,          
# we have tons of space.                                                        
ALL_TESTS="0001:1:1:int_0001"                                                   
ALL_TESTS="$ALL_TESTS 0002:1:1:string_0001"                                     
ALL_TESTS="$ALL_TESTS 0003:1:1:int_0002"                                        
ALL_TESTS="$ALL_TESTS 0004:1:1:uint_0001"                                       
ALL_TESTS="$ALL_TESTS 0005:3:1:int_0003"                                        
ALL_TESTS="$ALL_TESTS 0006:50:1:bitmap_0001" 
------------------------------------------------------------------------

tools/testing/selftests/kmod/kmod.sh
------------------------------------------------------------------------
# This represents                                                               
#                                                                               
# TEST_ID:TEST_COUNT:ENABLED                                                    
#                                                                               
# TEST_ID: is the test id number                                                
# TEST_COUNT: number of times we should run the test                            
# ENABLED: 1 if enabled, 0 otherwise                                            
#                                                                               
# Once these are enabled please leave them as-is. Write your own test,          
# we have tons of space.                                                        
ALL_TESTS="0001:3:1"                                                            
ALL_TESTS="$ALL_TESTS 0002:3:1"                                                 
ALL_TESTS="$ALL_TESTS 0003:1:1"                                                 
ALL_TESTS="$ALL_TESTS 0004:1:1"                                                 
ALL_TESTS="$ALL_TESTS 0005:10:1"                                                
ALL_TESTS="$ALL_TESTS 0006:10:1"                                                
ALL_TESTS="$ALL_TESTS 0007:5:1"                                                 
ALL_TESTS="$ALL_TESTS 0008:150:1"                                               
ALL_TESTS="$ALL_TESTS 0009:150:1"    
------------------------------------------------------------------------

A while ago we decided it didn't make sense sharing an infrastructure
to specify this. But now is a good time to ask ourselves this, given
that this seems part of "orchestration".

> > Also, even if one *can* compile and run a test, as you suggest, one may
> > not want to run it. This has me thinking that perhaps using our own
> 
> That makes sense. I imagine that most developers will only run their
> own tests over the course of normal development. Running all tests is
> probably something that is mostly for CI/CD systems (or sad souls
> doing large scale refactoring).
> 
> > kconfig entries for userspace targets / test cases to run makes sense.
> 
> That's my position at this point. For hybrid testing, it seems obvious
> to me that userspace should be able to dictate when a test gets run
> (since we have to have the two tests coordinate when they run, we
> might as well have userspace - where it is easiest - take control of
> the coordination). Nevertheless, I don't see why we cannot just lean
> on Kconfigs or Kselftest for deciding which tests to run.

We can, its just not there yet. There is a difference between say
enabling CONFIG_TEST_KMOD and running the resepctive test, we don't
currently have a userspace configuration mechanism, and while it
seems kconfig seems trivial for this, it is important to point out
that if we want to consider this as a path forward we may want to
consider allowing for this configuration to be *independent* from
the kernel. This would allow allowing a tarball of new selftests
be deployed on another kernel let's say, and you just run 'make
menuconig' for the test suite.

It doesn't *need* to be independent, however I see the possibility of
detachment as a gain. Its also rather slightly odd to consider say
having CONFIG_SELFTEST_KMOD or something like that on a kernel config.

Doing this is rather easy, however it just would need to be discussed
eventually if we want it.

> > > But if I just want to run a single test, or I want to randomize
> > > the order the tests are run (to avoid unintended interdependencies),
> > > or whatever other ideas people might have
> > > outside the default setup, KTF offers that flexibility via netlink,
> > > and allows use of a mature user land unit test suite to facilitate
> > > those features, instead of having to reinvent the wheel in kernel code.
> >
> > There is a difference between saying generic netlink is a good option we
> > should seriously consider for this problem Vs KTF's generic netlink
> > implementation is suitable for this. I am stating only the former.
> > The KTF netlink solution left much to be said and I am happy we are
> > moving slowly with integration of what you had with KTF and what kunit
> > is. For instance the level of documetnation could heavily be improved.
> > My litmus test for a good generic netlink interface is to be docuemnted
> > as well as say include/uapi/linux/nl80211.h.
> >
> > > > Yes, you can have scripts and your own tests infrastructure that knows
> > > > what to test or avoid, but this is not nice for autonegotiation.
> > >
> > > We haven't really been setting out to do anything ambitions it this area
> > > with KTF, except that we have been using simple naming of tests into
> > > classes and used wilcards etc to run a subset of tests.
> >
> > Its a good start.
> >
> > One questions stand out to me based on what you say you had:
> >
> > Do we want to have an interface to have userspace send information to
> > the kernel about what tests we want to run, or should userspace just run
> > a test at a time using its own heuristics?
> >
> > One possible gain of having the kernel be informed of a series of tests
> > is it would handle order, say if it wanted to parallelize things. But
> > I think handling this in the kernel can be complex. Consider fixes to
> > it, then we'd have to ensure a fix in the logic for this would have to
> > be propagated as well. Userspace could just batch out tests, and if
> > there issues with parallelizing them one can hope the kernel would know
> > what it can or cannot do. This would allow the batching / gathering to
> > done completely in userspace.
> 
> I guess that seems reasonable. We are still talking about hybrid
> testing, right?

Yes

> If so, can we just rely on Kselftest for this
> functionality? I am not saying that already does everything that we
> need; I am just making the point that Kselftest seems like the obvious
> place to orchestrate tests on a system that have a userspace
> component. (Sorry if that is obvious, I just get the sense that we
> have lost sight of that point.)

Yes it is just that selftests lets you test all or you run your own
test that see fit, it has no orchestration.

> > > > Consider also the complexity of dealing with testing new tests on older
> > > > kenrels. Today we address this on kselftests by striving to make sure
> > > > the old scripts / tests work or yield for old kernel who don't have
> > > > a feature. What if we want to really figure out what is there or not
> > > > concretely?
> > > >
> > > > A generic netlink interface could easily allow for these
> > > > sorts of things to grow and be auto negotiated.
> > >
> > > In general I agree that such types of negotiation is something that
> > > can be explored. You can view the KTF code to set up network contexts as
> > > something of a start in that sense. We have code in place that uses
> > > such network context configuration to allow a unit test suite
> > > to exchange address information as part of a single program multiple
> > > data (SPMD) program, using MPI, to allow unit tests that requires
> > > more than a single node to run.
> >
> > You went from one host to multiple hosts.. and MPI... I was just
> > thinking about communications about what tests to run locally depending
> > on the kernel. I'll ignore the MPI stuff for now.
> >
> > > > Then, collection of results: we have each kselftest desiging its own
> > > > scatter/gather set of way to go and do what it can to test what it can
> > > > and expose what should be tested, or in what order, or to allow knobs.
> > > > A generic netlink interface allows a standard interface to be sketched
> > > > up.
> > >
> > > I think we solve this by exposing flexibility to user space.
> > > Why you would want to have the kernel involved in that instead of
> > > just giving user mode enough info?
> >
> > Indeed, userspace is best for this.
> 
> Yeah, sounds pretty obvious to me too. I mean, if we have a test with
> both a user space and kernel space component, we have to orchestrate
> them from either kernel or user space. Since orchestration already has
> to exist in userspace for kselftest, we might as well do the
> orchestration for hybrid tests in the same place.
> 
> However, I feel like Knut is trying to make a point here beyond the
> obvious, as I don't think anyone at anytime has suggested that the
> orchestration for tests with a user space component should be done in
> the kernel. Then again, maybe not; I just want to make sure we are on
> the same page.

Knut was pointing out the generic netlink interface from KTF allowed
userspace to figure out what to orchestrate.

> > > > I don't think the generic netlink interface implemented in the KTF
> > > > patches accomplished any of this, but it at least moved the needle
> > > > forward IMHO in terms of what we should consider long term.
> > > >
> > > > > It would be really good if more people had a closer look at the KTF patch
> > > > > set before we embark on significant work of porting it to Kunit.
> > > > >
> > > > > For reference, the netlink code in KTF:
> > > > > https://lkml.org/lkml/2019/8/13/92
> > > >
> > > > I read it, and it seems like a lot of stuff implemented but without
> > > > a lot of proper justification and also without a lot of community
> > > > feedback. Kind of like: too much done in house without proper feedback.
> > > >
> > > > Then it became bloated and once kunit was almost about to be merged
> > > > you guys knee-jerk reacted and wanted to merge your stuff too...
> > >
> > > Again, just for the record, the fact is that we presented KTF
> > > at LPC in 2017 (see https://lwn.net/Articles/735034/) and pushed
> > > it to github for review and comments at the same time
> > > (https://github.com/oracle/ktf).
> > > Looking in the git repo, this was just a few weeks after the initial
> > > refactoring from a project specific predecessor was complete.
> > > I discussed collaboration with Brendan, who had a very early draft
> > > of what later became Kunit with him, and expected from our conversation
> > > that we would work together on a common proposal that covered both main
> > > use cases.
> >
> > Alright, so kunit was just too late to lay the ground work in so far as
> > upstream is concerned. Thanks for the corrections.
> 
> Huh? KUnit was too late to lay the groundwork for what?

I meant KTF.

> > > As to the features we added to KTF, they were in response to real test needs
> > > (multithreaded test execution, override of return values to verify
> > > error codepaths, the need for environment/node specific configuration like
> > > different device presence/capabilities, different network configurations
> > > of the test nodes, and so on..
> >
> > I see.. But the upstreaming never happened. Well at least the experience
> > you have now with KTF can be leveraged for a proper upstream
> > architecture.
> >
> > > > And the quality of code. Gosh, much to be said about that...
> > >
> > > We're of course happy to take constructive critics - do you have
> > > any specifics in mind?
> >
> > Slowly but surely. I'm happy with where we stand on trying to blend the
> > two kunit and KTF together. The generic netlink aspect of KTF however
> > *does* strike me as important to scale long term, I wasn't to happy with
> > its level of documentation though, I think that could be improved.
> 
> I'm still skeptical that netlink is the right approach. I imagine all
> we need is just to be able to trigger testing events in the kernel
> from user space and vice versa. I guess that could get pretty complex,
> but I think it is best to start with something that isn't (as I hope
> we have already identified in previous emails).

Simplicity is king, however I don't think Knut did sufficient justice
to that one possible gain of it that I saw from it. Consider that Knut
also has an infrastructure for testing already which relies on
orchestration -- that means an alternative is needed anyway, which
is why I figured I'd him in, to point out at least one value I see
from it.

Whether or not we embrace generic netlink *should be still be debated*,
however if we *don't* go with it, Knut will need a way to figure out
a way to allow orchestration.

> > > Which brings me back to my original request for (constructive) feedback
> > > on what we already have created.
> >
> > I think I've provided enough. My focus on this thread was that I am
> > in hopes we don't loose sight of the possible gains of a generic netlink
> > interface for testing. I think the discussions that have followed will
> > help pave the way for if and how we start this.
> >
> > It leaves standing the question if we really need the generic netlink
> > interface to figure out if a test is available or if we can just use
> > header files for this as I mentioned.
> >
> > Can you think of a test / case where its needed and a header file may
> > not suffice?
> 
> Do we really want to focus on this point now? I think it's better to
> start off with something simple and evolve it.

Addressing it can help simplfiy things long term, as perhaps we really
don't need something like generic netlink to orchestrate.

  Luis
