Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 989B7DB718
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2019 21:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfJQTMP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 15:12:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbfJQTMP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 15:12:15 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1FFE21835;
        Thu, 17 Oct 2019 19:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571339534;
        bh=mrDc1qsN5Uk7keD2UThEat8yHn+wzHlNuDbe17s+eLg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lxrjKYHX04umrNE6w0GVjozLch8lnyc2yDXgRZQJEdA0b0rqPOYlWqkVnr/4yAJZN
         idbW18N+vVSjHbI5tcf9aykbeY+Wlnz9TqTYcOjK42d+HyWBnLz0MiYVVB4XGpIlD/
         emzKG2itWrAKZbOms10Hp1XXtxLyYwUO+5mpPIDo=
Subject: Re: Plan for hybrid testing
To:     Knut Omang <knut.omang@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        shuah <shuah@kernel.org>
References: <20190913210247.GA86838@google.com>
 <20191014104243.GD16384@42.do-not-panic.com>
 <9212e0fb58683df4781c52e6ad0abd8eb496a452.camel@oracle.com>
 <869165ea-f7d6-10cf-c74a-14a33b584938@kernel.org>
 <40941b19855134b5032379ab4b8023a3299bd06a.camel@oracle.com>
 <20191016130857.GJ16384@42.do-not-panic.com>
 <345333a20601355202749b1e7de23360dc93126c.camel@oracle.com>
From:   shuah <shuah@kernel.org>
Message-ID: <babdb6b8-f53c-549a-6845-bec12bdedc88@kernel.org>
Date:   Thu, 17 Oct 2019 13:11:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <345333a20601355202749b1e7de23360dc93126c.camel@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/17/19 11:46 AM, Knut Omang wrote:
> On Wed, 2019-10-16 at 13:08 +0000, Luis Chamberlain wrote:
>> On Wed, Oct 16, 2019 at 12:52:12PM +0200, Knut Omang wrote:
>>> On Mon, 2019-10-14 at 13:01 -0600, shuah wrote:
>>>> On 10/14/19 12:38 PM, Knut Omang wrote:
>>>>> On Mon, 2019-10-14 at 10:42 +0000, Luis Chamberlain wrote:
>>>>>> On Fri, Sep 13, 2019 at 02:02:47PM -0700, Brendan Higgins wrote:
>>>>>>> Hey Knut and Shuah,
>>>>>>>
>>>>>>> Following up on our offline discussion on Wednesday night:
>>>>>>>
>>>>>>> We decided that it would make sense for Knut to try to implement Hybrid
>>>>>>> Testing (testing that crosses the kernel userspace boundary) that he
>>>>>>> introduced here[1] on top of the existing KUnit infrastructure.
>>>>>>>
>>>>>>> We discussed several possible things in the kernel that Knut could test
>>>>>>> with the new Hybrid Testing feature as an initial example. Those were
>>>>>>> (in reverse order of expected difficulty):
>>>>>>>
>>>>>>> 1. RDS (Reliable Datagram Sockets) - We decided that, although this was
>>>>>>>      one of the more complicated subsystems to work with, it was probably
>>>>>>>      the best candidate for Knut to start with because it was in desperate
>>>>>>>      need of better testing, much of the testing would require crossing
>>>>>>>      the kernel userspace boundary to be effective, and Knut has access to
>>>>>>>      RDS (since he works at Oracle).
>>>>>>>
>>>>
>>>> Any update on if you are able to explore this work.
>>>
>>> I am working on this, but it's going to take some time, as this ties in
>>> with internal projects at Oracle. Basing work on RDS or RDS related tests
>>> (such as generic socket etc) is the best option for us, since that allows
>>> progress on our internal deliverables as well ;-)
>>>
>>>>>>> 2. KMOD - Probably much simpler than RDS, and the maintainer, Luis
>>>>>>>      Chamberlain (CC'ed) would like to see better testing here, but
>>>>>>>      probably still not as good as RDS because it is in less dire need of
>>>>>>>      testing, collaboration on this would be more difficult, and Luis is
>>>>>>>      currently on an extended vacation. Luis and I had already been
>>>>>>>      discussing testing KMOD here[2].
>>>>>>
>>>>>> I'm back!
>>>>>>
>>>>>> I'm also happy and thrilled to help review the infrastructure in great
>>>>>> detail given I have lofty future objectives with testing in the kernel.
>>>>>> Also, kmod is a bit more complex to test, if Knut wants a simpler *easy*
>>>>>> target I think test_sysctl.c would be a good target. I think the goal
>>>>>> there would be to add probes for a few of the sysctl callers, and then
>>>>>> test them through userspace somehow, for instance?
>>>>>
>>>>> That sounds like a good case for the hybrid tests.
>>>>> The challenge in a kunit setting would be that it relies on a significant
>>>>> part of KTF to work as we have used it so far:
>>>>>
>>>>> - module support - Alan has been working on this
>>>>
>>>> I see the patches. Thanks for working on this.
>>>>
>>>>> - netlink approach from KTF (to allow user space execution of kernel
>>>>>     part of test, and gathering reporting in one place)
>>>>> - probe infrastructure
>>>>>
>>>>>> The complexities with testing kmod is the threading aspect. So that is
>>>>>> more of a challenge for a test infrastructure as a whole. However kmod
>>>>>> also already has a pretty sound kthread solution which could be used
>>>>>> as basis for any sound kernel multithread test solution.
>>>>>>
>>>>>> Curious, what was decided with the regards to the generic netlink approach?
>>>>
>>>> Can this work be be done without netlink approach? At least some of it.
>>>> I would like to see some patches and would like to get a better feel
>>>> for the dependency on generic netlink.
>>>
>>> A flexible out-of-band communication channel is needed for several of the
>>> features, and definitely for hybrid tests. It does not need to be netlink
>>> in principle, but that has served the purpose well so far in KTF, and
>>> reimplementing something will be at the cost of the core task of getting more
>>> and better tests, which after all is the goal of this effort.
>>
>> I don't think you did justice to *why* netlink would be good, but in
>> principle I suspect its the right thing long term if we want a nice
>> interface to decide what to test and how.
> 
> I tried to do that in my response here to Brendan:
> 
> https://lore.kernel.org/linux-kselftest/644ff48481f3dd7295798dcef88b4abcc8695260.camel@oracle.com/
> 
>> So kselftest today implicates you know what you want to test. Or rather
>> this is defined through what you enable and then you run *all* enabled
>> kselftests.
>>
>> Similar logic follwos for kunit.
> 
> The same applies to KTF.
> The trivial default user application for KTF
> (see https://lkml.org/lkml/2019/8/13/101,
>   file tools/testing/selftests/ktf/user/ktfrun.cc)
> would run all the kernel tests that has been enabled
> (depending what test modules that have been inserted).
> 
> But if I just want to run a single test, or I want to randomize
> the order the tests are run (to avoid unintended interdependencies),
> or whatever other ideas people might have
> outside the default setup, KTF offers that flexibility via netlink,
> and allows use of a mature user land unit test suite to facilitate
> those features, instead of having to reinvent the wheel in kernel code.
> 
>> Yes, you can have scripts and your own tests infrastructure that knows
>> what to test or avoid, but this is not nice for autonegotiation.
> 
> We haven't really been setting out to do anything ambitions it this area
> with KTF, except that we have been using simple naming of tests into
> classes and used wilcards etc to run a subset of tests.
> 
>> Consider also the complexity of dealing with testing new tests on older
>> kenrels. Today we address this on kselftests by striving to make sure
>> the old scripts / tests work or yield for old kernel who don't have
>> a feature. What if we want to really figure out what is there or not
>> concretely?
>>
>> A generic netlink interface could easily allow for these
>> sorts of things to grow and be auto negotiated.
> 
> In general I agree that such types of negotiation is something that
> can be explored. You can view the KTF code to set up network contexts as
> something of a start in that sense. We have code in place that uses
> such network context configuration to allow a unit test suite
> to exchange address information as part of a single program multiple
> data (SPMD) program, using MPI, to allow unit tests that requires
> more than a single node to run.
> 
>> Then, collection of results: we have each kselftest desiging its own
>> scatter/gather set of way to go and do what it can to test what it can
>> and expose what should be tested, or in what order, or to allow knobs.
>> A generic netlink interface allows a standard interface to be sketched
>> up.
> 
> I think we solve this by exposing flexibility to user space.
> Why you would want to have the kernel involved in that instead of
> just giving user mode enough info?
> 
>> I don't think the generic netlink interface implemented in the KTF
>> patches accomplished any of this, but it at least moved the needle
>> forward IMHO in terms of what we should consider long term.
>>
>>> It would be really good if more people had a closer look at the KTF patch
>>> set before we embark on significant work of porting it to Kunit.
>>>
>>> For reference, the netlink code in KTF:
>>> https://lkml.org/lkml/2019/8/13/92
>>
>> I read it, and it seems like a lot of stuff implemented but without
>> a lot of proper justification and also without a lot of community
>> feedback. Kind of like: too much done in house without proper feedback.
>>
>> Then it became bloated and once kunit was almost about to be merged
>> you guys knee-jerk reacted and wanted to merge your stuff too...
> 
> Again, just for the record, the fact is that we presented KTF
> at LPC in 2017 (see https://lwn.net/Articles/735034/) and pushed
> it to github for review and comments at the same time
> (https://github.com/oracle/ktf).
> Looking in the git repo, this was just a few weeks after the initial
> refactoring from a project specific predecessor was complete.
> I discussed collaboration with Brendan, who had a very early draft
> of what later became Kunit with him, and expected from our conversation
> that we would work together on a common proposal that covered both main
> use cases.
> 
> As to the features we added to KTF, they were in response to real test needs
> (multithreaded test execution, override of return values to verify
> error codepaths, the need for environment/node specific configuration like
> different device presence/capabilities, different network configurations
> of the test nodes, and so on..
> 
>> And the quality of code. Gosh, much to be said about that...
> 
> We're of course happy to take constructive critics - do you have
> any specifics in mind?
> 
>> So I think that asking to consolidate with kunit is the right thing
>> at this point. Because we need to grow it in *community*. kunit itself
>> has been heavily modifed to adjust to early feedback, for example, so
>> its an example of evolution needed.
>>
>>> Note that unlike kunit, in KTF no tests are executed by default,
>>> instead KTF provides an API to query about, set up and trigger execution of
>>> tests and test parts in the kernel, and leave the actual initiation
>>> to user space tools.
>>
>> This is all excellent. However baby steps. Let's demo it with a few
>> simple tests, rather than trying to ensure it works with *all* the
>> stuff you guys probably already have in house. That will probably have
>> to be phased out in the future with whatever we grow *together*.
> 
> Which brings me back to my original request for (constructive) feedback
> on what we already have created.
> 

Knut,

You have gotten some review comments and we talked about it in a
couple of offline discussion as mentioned in the email that started
this thread.

I mentioned to you that adding the ability to trigger KUNit tests from
user-space is feature I am interested in.

Is that netlink? I don't know.

That is why I asked you to start with a KUnit test for RDS or kmod with
user-space trigger for us to review. This will help add and evolve
the KUnit hybrid testing. My recollection is that you are open to
working on it.

It appears we might be back to square one, you asking us to review
KFT as is.

thanks,
-- Shuah




