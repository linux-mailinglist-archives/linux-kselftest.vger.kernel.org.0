Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7005D9202
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 15:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391748AbfJPNJA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 09:09:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40233 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391745AbfJPNJA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 09:09:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so14703426pfb.7
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2019 06:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MOUBBaO9KO8nd823Qaauf2eNYiWpNoCHlDdNzLYD1+s=;
        b=clDq503oBc+F5ld6vAwsxRrOtAJOsPyeLdbXyekoBi7m5cENN3HDHnAEMPs0ybQYed
         HKzQL6LX6Q4fZbmohL7qvyhPPjzAvim2bnVG7U4OaXL912d37aIhRHDdRfv2n7MWL63i
         UfILYIA9/nfO15DKMcwwhvjG2BooEr+OSBoQGJIIbTOj1wVw7QxPmenf8I3enaqvoz5P
         9GbyElRp1VIwkyMnH6wa6QndYPGDTtLB15QxXb3tkK2JnnuCEVPFdo4DVLLWp4neA59z
         43csAlFw9/vn2MXnXUk8Rpl7jGj36KFTJ07TIJIp6i9Q27++ks65GVAcjbd+rf93tCZj
         OWoA==
X-Gm-Message-State: APjAAAVrtC4v8umEmq0TejdjjNRmgIuckVs6aCOVxqqkbYXkDPc2+BT4
        bgHDTAwJQpEDG1oKITYTOvw=
X-Google-Smtp-Source: APXvYqwhRjef9wIfJek3ewHj0Ug67dVC9LzYvPm46GxvCftoMwAnbNr6fV3MxreXd6Qg8I8fmzB8/A==
X-Received: by 2002:a63:2701:: with SMTP id n1mr25567975pgn.187.1571231339236;
        Wed, 16 Oct 2019 06:08:59 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id m2sm24254755pff.154.2019.10.16.06.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 06:08:57 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 3B13340251; Wed, 16 Oct 2019 13:08:57 +0000 (UTC)
Date:   Wed, 16 Oct 2019 13:08:57 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Knut Omang <knut.omang@oracle.com>
Cc:     shuah <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: Re: Plan for hybrid testing
Message-ID: <20191016130857.GJ16384@42.do-not-panic.com>
References: <20190913210247.GA86838@google.com>
 <20191014104243.GD16384@42.do-not-panic.com>
 <9212e0fb58683df4781c52e6ad0abd8eb496a452.camel@oracle.com>
 <869165ea-f7d6-10cf-c74a-14a33b584938@kernel.org>
 <40941b19855134b5032379ab4b8023a3299bd06a.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40941b19855134b5032379ab4b8023a3299bd06a.camel@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 16, 2019 at 12:52:12PM +0200, Knut Omang wrote:
> On Mon, 2019-10-14 at 13:01 -0600, shuah wrote:
> > On 10/14/19 12:38 PM, Knut Omang wrote:
> > > On Mon, 2019-10-14 at 10:42 +0000, Luis Chamberlain wrote:
> > > > On Fri, Sep 13, 2019 at 02:02:47PM -0700, Brendan Higgins wrote:
> > > > > Hey Knut and Shuah,
> > > > > 
> > > > > Following up on our offline discussion on Wednesday night:
> > > > > 
> > > > > We decided that it would make sense for Knut to try to implement Hybrid
> > > > > Testing (testing that crosses the kernel userspace boundary) that he
> > > > > introduced here[1] on top of the existing KUnit infrastructure.
> > > > > 
> > > > > We discussed several possible things in the kernel that Knut could test
> > > > > with the new Hybrid Testing feature as an initial example. Those were
> > > > > (in reverse order of expected difficulty):
> > > > > 
> > > > > 1. RDS (Reliable Datagram Sockets) - We decided that, although this was
> > > > >     one of the more complicated subsystems to work with, it was probably
> > > > >     the best candidate for Knut to start with because it was in desperate
> > > > >     need of better testing, much of the testing would require crossing
> > > > >     the kernel userspace boundary to be effective, and Knut has access to
> > > > >     RDS (since he works at Oracle).
> > > > > 
> > 
> > Any update on if you are able to explore this work.
> 
> I am working on this, but it's going to take some time, as this ties in 
> with internal projects at Oracle. Basing work on RDS or RDS related tests
> (such as generic socket etc) is the best option for us, since that allows 
> progress on our internal deliverables as well ;-)
> 
> > > > > 2. KMOD - Probably much simpler than RDS, and the maintainer, Luis
> > > > >     Chamberlain (CC'ed) would like to see better testing here, but
> > > > >     probably still not as good as RDS because it is in less dire need of
> > > > >     testing, collaboration on this would be more difficult, and Luis is
> > > > >     currently on an extended vacation. Luis and I had already been
> > > > >     discussing testing KMOD here[2].
> > > > 
> > > > I'm back!
> > > > 
> > > > I'm also happy and thrilled to help review the infrastructure in great
> > > > detail given I have lofty future objectives with testing in the kernel.
> > > > Also, kmod is a bit more complex to test, if Knut wants a simpler *easy*
> > > > target I think test_sysctl.c would be a good target. I think the goal
> > > > there would be to add probes for a few of the sysctl callers, and then
> > > > test them through userspace somehow, for instance?
> > > 
> > > That sounds like a good case for the hybrid tests.
> > > The challenge in a kunit setting would be that it relies on a significant part of KTF
> > > to work as we have used it so far:
> > > 
> > > - module support - Alan has been working on this
> > 
> > I see the patches. Thanks for working on this.
> > 
> > > - netlink approach from KTF (to allow user space execution of kernel
> > >    part of test, and gathering reporting in one place)
> > > - probe infrastructure
> > > 
> > > > The complexities with testing kmod is the threading aspect. So that is
> > > > more of a challenge for a test infrastructure as a whole. However kmod
> > > > also already has a pretty sound kthread solution which could be used
> > > > as basis for any sound kernel multithread test solution.
> > > > 
> > > > Curious, what was decided with the regards to the generic netlink approach?
> > 
> > Can this work be be done without netlink approach? At least some of it.
> > I would like to see some patches and would like to get a better feel
> > for the dependency on generic netlink.
> 
> A flexible out-of-band communication channel is needed for several of the 
> features, and definitely for hybrid tests. It does not need to be netlink 
> in principle, but that has served the purpose well so far in KTF, and
> reimplementing something will be at the cost of the core task of getting more 
> and better tests, which after all is the goal of this effort.

I don't think you did justice to *why* netlink would be good, but in
principle I suspect its the right thing long term if we want a nice
interface to decide what to test and how.

So kselftest today implicates you know what you want to test. Or rather
this is defined through what you enable and then you run *all* enabled
kselftests.

Similar logic follwos for kunit.

Yes, you can have scripts and your own tests infrastructure that knows
what to test or avoid, but this is not nice for autonegotiation.
Consider also the complexity of dealing with testing new tests on older
kenrels. Today we address this on kselftests by striving to make sure
the old scripts / tests work or yield for old kernel who don't have
a feature. What if we want to really figure out what is there or not
concretely? A generic netlink interface could easily allow for these
sorts of things to grow and be auto negotiated.

Then, collection of results: we have each kselftest desiging its own
scatter/gather set of way to go and do what it can to test what it can
and expose what should be tested, or in what order, or to allow knobs.
A generic netlink interface allows a standard interface to be sketched
up.

I don't think the generic netlink interface implemented in the KTF
patches accomplished any of this, but it at least moved the needle
forward IMHO in terms of what we should consider long term.

> It would be really good if more people had a closer look at the KTF patch 
> set before we embark on significant work of porting it to Kunit.
> 
> For reference, the netlink code in KTF:
> https://lkml.org/lkml/2019/8/13/92

I read it, and it seems like a lot of stuff implemented but without
a lot of proper justification and also without a lot of community
feedback. Kind of like: too much done in house without proper feedback.
Then it became bloated and once kunit was almost about to be merged
you guys knee-jerk reacted and wanted to merge your stuff too...

And the quality of code. Gosh, much to be said about that...

So I think that asking to consolidate with kunit is the right thing
at this point. Because we need to grow it in *community*. kunit itself
has been heavily modifed to adjust to early feedback, for example, so
its an example of evolution needed.

> Note that unlike kunit, in KTF no tests are executed by default, 
> instead KTF provides an API to query about, set up and trigger execution of 
> tests and test parts in the kernel, and leave the actual initiation 
> to user space tools.

This is all excellent. However baby steps. Let's demo it with a few
simple tests, rather than trying to ensure it works with *all* the
stuff you guys probably already have in house. That will probably have
to be phased out in the future with whatever we grow *together*.

  Luis
