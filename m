Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A300EDB448
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2019 19:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441018AbfJQRrA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 13:47:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38632 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441001AbfJQRq7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 13:46:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HHiOWE142340;
        Thu, 17 Oct 2019 17:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2019-08-05;
 bh=94Lq8GFx8YZfAX1NU7HphLxEBRNUZVG5DP+LSA+DRAk=;
 b=iyYEN6s1RSrkRRS9+Tt2G0CpYRQHogJdGpI4PjvfFKap0ZSse+5RorHK0DFZZrM62/Bt
 GP3X9Z5sIhypct232bZwh4igiH39Fu/cU0s2e3YolexIBAzdgiESMgy2J3CLCR13RQsB
 r+Mv6MnFMHJm0lazPLknY/PC0oF0Vs2lWcF3IMC09ivZ6VIDXIznHkQor3v5Ks7NSoD5
 NK5iRJ8iSgjC/gCQKEdBtc6zWyVG72UVXO7jJQGmSAl3ASgru1N9Hi4pi4DlHjhSqtYt
 wcQ9kHXGJkwd+KLv5q5A7FqvzLreNRoQHKpNNwClqd7GlvHC8W8nc3sKPHFEPlnMR9Z/ 3Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vk68v00x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 17:46:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HHhLvp167822;
        Thu, 17 Oct 2019 17:46:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2vpf14ckxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 17:46:52 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9HHkpnv032653;
        Thu, 17 Oct 2019 17:46:51 GMT
Received: from asu (/92.220.18.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 17:46:51 +0000
Message-ID: <345333a20601355202749b1e7de23360dc93126c.camel@oracle.com>
Subject: Re: Plan for hybrid testing
From:   Knut Omang <knut.omang@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     shuah <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Date:   Thu, 17 Oct 2019 19:46:48 +0200
In-Reply-To: <20191016130857.GJ16384@42.do-not-panic.com>
References: <20190913210247.GA86838@google.com>
         <20191014104243.GD16384@42.do-not-panic.com>
         <9212e0fb58683df4781c52e6ad0abd8eb496a452.camel@oracle.com>
         <869165ea-f7d6-10cf-c74a-14a33b584938@kernel.org>
         <40941b19855134b5032379ab4b8023a3299bd06a.camel@oracle.com>
         <20191016130857.GJ16384@42.do-not-panic.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170160
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2019-10-16 at 13:08 +0000, Luis Chamberlain wrote:
> On Wed, Oct 16, 2019 at 12:52:12PM +0200, Knut Omang wrote:
> > On Mon, 2019-10-14 at 13:01 -0600, shuah wrote:
> > > On 10/14/19 12:38 PM, Knut Omang wrote:
> > > > On Mon, 2019-10-14 at 10:42 +0000, Luis Chamberlain wrote:
> > > > > On Fri, Sep 13, 2019 at 02:02:47PM -0700, Brendan Higgins wrote:
> > > > > > Hey Knut and Shuah,
> > > > > > 
> > > > > > Following up on our offline discussion on Wednesday night:
> > > > > > 
> > > > > > We decided that it would make sense for Knut to try to implement Hybrid
> > > > > > Testing (testing that crosses the kernel userspace boundary) that he
> > > > > > introduced here[1] on top of the existing KUnit infrastructure.
> > > > > > 
> > > > > > We discussed several possible things in the kernel that Knut could test
> > > > > > with the new Hybrid Testing feature as an initial example. Those were
> > > > > > (in reverse order of expected difficulty):
> > > > > > 
> > > > > > 1. RDS (Reliable Datagram Sockets) - We decided that, although this was
> > > > > >     one of the more complicated subsystems to work with, it was probably
> > > > > >     the best candidate for Knut to start with because it was in desperate
> > > > > >     need of better testing, much of the testing would require crossing
> > > > > >     the kernel userspace boundary to be effective, and Knut has access to
> > > > > >     RDS (since he works at Oracle).
> > > > > > 
> > > 
> > > Any update on if you are able to explore this work.
> > 
> > I am working on this, but it's going to take some time, as this ties in 
> > with internal projects at Oracle. Basing work on RDS or RDS related tests
> > (such as generic socket etc) is the best option for us, since that allows 
> > progress on our internal deliverables as well ;-)
> > 
> > > > > > 2. KMOD - Probably much simpler than RDS, and the maintainer, Luis
> > > > > >     Chamberlain (CC'ed) would like to see better testing here, but
> > > > > >     probably still not as good as RDS because it is in less dire need of
> > > > > >     testing, collaboration on this would be more difficult, and Luis is
> > > > > >     currently on an extended vacation. Luis and I had already been
> > > > > >     discussing testing KMOD here[2].
> > > > > 
> > > > > I'm back!
> > > > > 
> > > > > I'm also happy and thrilled to help review the infrastructure in great
> > > > > detail given I have lofty future objectives with testing in the kernel.
> > > > > Also, kmod is a bit more complex to test, if Knut wants a simpler *easy*
> > > > > target I think test_sysctl.c would be a good target. I think the goal
> > > > > there would be to add probes for a few of the sysctl callers, and then
> > > > > test them through userspace somehow, for instance?
> > > > 
> > > > That sounds like a good case for the hybrid tests.
> > > > The challenge in a kunit setting would be that it relies on a significant 
> > > > part of KTF to work as we have used it so far:
> > > > 
> > > > - module support - Alan has been working on this
> > > 
> > > I see the patches. Thanks for working on this.
> > > 
> > > > - netlink approach from KTF (to allow user space execution of kernel
> > > >    part of test, and gathering reporting in one place)
> > > > - probe infrastructure
> > > > 
> > > > > The complexities with testing kmod is the threading aspect. So that is
> > > > > more of a challenge for a test infrastructure as a whole. However kmod
> > > > > also already has a pretty sound kthread solution which could be used
> > > > > as basis for any sound kernel multithread test solution.
> > > > > 
> > > > > Curious, what was decided with the regards to the generic netlink approach?
> > > 
> > > Can this work be be done without netlink approach? At least some of it.
> > > I would like to see some patches and would like to get a better feel
> > > for the dependency on generic netlink.
> > 
> > A flexible out-of-band communication channel is needed for several of the 
> > features, and definitely for hybrid tests. It does not need to be netlink 
> > in principle, but that has served the purpose well so far in KTF, and
> > reimplementing something will be at the cost of the core task of getting more 
> > and better tests, which after all is the goal of this effort.
> 
> I don't think you did justice to *why* netlink would be good, but in
> principle I suspect its the right thing long term if we want a nice
> interface to decide what to test and how.

I tried to do that in my response here to Brendan:

https://lore.kernel.org/linux-kselftest/644ff48481f3dd7295798dcef88b4abcc8695260.camel@oracle.com/

> So kselftest today implicates you know what you want to test. Or rather
> this is defined through what you enable and then you run *all* enabled
> kselftests.
> 
> Similar logic follwos for kunit.

The same applies to KTF.
The trivial default user application for KTF 
(see https://lkml.org/lkml/2019/8/13/101, 
 file tools/testing/selftests/ktf/user/ktfrun.cc)
would run all the kernel tests that has been enabled 
(depending what test modules that have been inserted).

But if I just want to run a single test, or I want to randomize 
the order the tests are run (to avoid unintended interdependencies), 
or whatever other ideas people might have
outside the default setup, KTF offers that flexibility via netlink,
and allows use of a mature user land unit test suite to facilitate 
those features, instead of having to reinvent the wheel in kernel code.

> Yes, you can have scripts and your own tests infrastructure that knows
> what to test or avoid, but this is not nice for autonegotiation.

We haven't really been setting out to do anything ambitions it this area 
with KTF, except that we have been using simple naming of tests into 
classes and used wilcards etc to run a subset of tests. 

> Consider also the complexity of dealing with testing new tests on older
> kenrels. Today we address this on kselftests by striving to make sure
> the old scripts / tests work or yield for old kernel who don't have
> a feature. What if we want to really figure out what is there or not
> concretely? 
>
> A generic netlink interface could easily allow for these
> sorts of things to grow and be auto negotiated.

In general I agree that such types of negotiation is something that
can be explored. You can view the KTF code to set up network contexts as
something of a start in that sense. We have code in place that uses 
such network context configuration to allow a unit test suite 
to exchange address information as part of a single program multiple 
data (SPMD) program, using MPI, to allow unit tests that requires 
more than a single node to run.

> Then, collection of results: we have each kselftest desiging its own
> scatter/gather set of way to go and do what it can to test what it can
> and expose what should be tested, or in what order, or to allow knobs.
> A generic netlink interface allows a standard interface to be sketched
> up.

I think we solve this by exposing flexibility to user space.
Why you would want to have the kernel involved in that instead of 
just giving user mode enough info?

> I don't think the generic netlink interface implemented in the KTF
> patches accomplished any of this, but it at least moved the needle
> forward IMHO in terms of what we should consider long term.
> 
> > It would be really good if more people had a closer look at the KTF patch 
> > set before we embark on significant work of porting it to Kunit.
> > 
> > For reference, the netlink code in KTF:
> > https://lkml.org/lkml/2019/8/13/92
> 
> I read it, and it seems like a lot of stuff implemented but without
> a lot of proper justification and also without a lot of community
> feedback. Kind of like: too much done in house without proper feedback.
>
> Then it became bloated and once kunit was almost about to be merged
> you guys knee-jerk reacted and wanted to merge your stuff too...

Again, just for the record, the fact is that we presented KTF 
at LPC in 2017 (see https://lwn.net/Articles/735034/) and pushed 
it to github for review and comments at the same time 
(https://github.com/oracle/ktf). 
Looking in the git repo, this was just a few weeks after the initial
refactoring from a project specific predecessor was complete.
I discussed collaboration with Brendan, who had a very early draft 
of what later became Kunit with him, and expected from our conversation 
that we would work together on a common proposal that covered both main 
use cases.

As to the features we added to KTF, they were in response to real test needs 
(multithreaded test execution, override of return values to verify 
error codepaths, the need for environment/node specific configuration like 
different device presence/capabilities, different network configurations 
of the test nodes, and so on..

> And the quality of code. Gosh, much to be said about that...

We're of course happy to take constructive critics - do you have 
any specifics in mind?

> So I think that asking to consolidate with kunit is the right thing
> at this point. Because we need to grow it in *community*. kunit itself
> has been heavily modifed to adjust to early feedback, for example, so
> its an example of evolution needed.
>
> > Note that unlike kunit, in KTF no tests are executed by default, 
> > instead KTF provides an API to query about, set up and trigger execution of 
> > tests and test parts in the kernel, and leave the actual initiation 
> > to user space tools.
> 
> This is all excellent. However baby steps. Let's demo it with a few
> simple tests, rather than trying to ensure it works with *all* the
> stuff you guys probably already have in house. That will probably have
> to be phased out in the future with whatever we grow *together*.

Which brings me back to my original request for (constructive) feedback
on what we already have created.

Thanks,
Knut




