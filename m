Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6287EDB9F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 00:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438181AbfJQW4v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 18:56:51 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45783 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389846AbfJQW4v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 18:56:51 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9HMub5s002010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Oct 2019 18:56:38 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6D338420458; Thu, 17 Oct 2019 18:56:37 -0400 (EDT)
Date:   Thu, 17 Oct 2019 18:56:37 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Tim.Bird@sony.com
Cc:     skhan@linuxfoundation.org, brendanhiggins@google.com,
        yzaikin@google.com, linux-kselftest@vger.kernel.org,
        linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH linux-kselftest/test v2] ext4: add kunit test for
 decoding extended timestamps
Message-ID: <20191017225637.GB6371@mit.edu>
References: <20191010023931.230475-1-yzaikin@google.com>
 <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
 <CAAXuY3qtSHENgy3S168_03ju_JwAucOAt5WEJGQ+pi5PfurP6g@mail.gmail.com>
 <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com>
 <20191011131902.GC16225@mit.edu>
 <CAFd5g45s1-=Z4JwJn4A1VDGu4oEGBisQ_0RFp4otUU3rKf1XpQ@mail.gmail.com>
 <1e6611e6-2fa6-6f7d-bc7f-0bc2243d9342@linuxfoundation.org>
 <20191017120833.GA25548@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF977D0023@USCULXMSG01.am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977D0023@USCULXMSG01.am.sony.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 17, 2019 at 10:25:35PM +0000, Tim.Bird@sony.com wrote:
> 
> I'm not sure I have the entire context here, but I think deterministic
> might not be the right word, or it might not capture the exact meaning
> intended.
> 
> I think there are multiple issues here:
>  1. Does the test enclose all its data, including working data and expected results?
> Or, does the test allow someone to provide working data?  This
> alternative implies that either the some of testcases or the results
> might be different depending on the data that is provided.  IMHO the
> test would be deterministic if it always produced the same results
> based on the same data inputs.  And if the input data was
> deterministic.  I would call this a data-driven test.

Do you mean that the tester would provide the test data at the time
when they launch the test?  I don't think that would *ever* be
considered a unit test.

My definition of a unit test is something which runs quickly so you
can do make some quick edits, and then run something like "make
check", and find out whether or not you've made any screw ups.  Or it
might get used in an automated way, such that immediately after I push
to a Gerrit server, tests *automatically* get run, and within a minute
or two, I get notified if there are any test failures, and a -1 review
is automatically posted to the proposed change in the Web UI.

So this is not the sort of thing where the human will be providing
working data to change how the test behaves.  The idea is that you
type "make check", and hundreds of tests run, sanity checking basic
functional soundness of the changes which were just made.

Unit tests also tend to run on small pieces of code --- for example,
in how we encode 64-bit timestamps in ext4, to provide both 100ns
granularity timestamps as well as post-2038 encoding, where the "low"
32-bits are backwards compatible with traditional 32-bit time_t's.  It
turns doing this is complicated, and it's easy to screw it up (and in
fact, we have).  So now we have a set of unit tests for it.

The unit tests use a lot of reusable infrastructure, so that while
there are a series of tests to test each of the various different
boundary conditions, they are *driven* by test data.  So for example,
this is a test...

		{
			.test_case_name =
	  "2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit on.",
			.msb_set = true,
			.lower_bound = true,
			.extra_bits =  2,
			.expected = {.tv_sec = 0x180000000LL, .tv_nsec = 0L},
		},


... and this is a different test....

		{
			.test_case_name =
"2310-04-04 Upper bound of 32bit>=0 timestamp, hi extra sec bit 1. 1 ns bit 1.",
			.msb_set = false,
			.lower_bound = false,
			.extra_bits = 6,
			.expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 1L},
		},

So yes, it's very data-driven.  *But* all of the code, data, and
expected results are all encapsulated in fs/ext4/inode-test.c.

So when you say, "does the test allow someone to provide working
data", it's unclear what you mean by that.  How do you expect a user
to provide the working data?  And how do you make the test easy to
run?

> 2. Does the test automatically detect some attribute of the system,
> and adjust its operation based on that (does the test probe?)  This
> is actually quite common if you include things like when a test
> requires root access to run.  Sometimes such tests, when run without
> root privilege, run as many testcases as possible not as root, and
> skip the testcases that require root.

And if the test needs to do this, it's *automatically* not a unit
test.  It might be an integration test.  xfstests fall very squarely
into into that category.  Integration tests are heavier-weight.
You're not going to run them as lightly as you run unit tests, because
they take more resources, and more wall clock time before you get
results.

One of the main point of unit tests is that they are testing units of
code smaller than "the whole kernel".  When I'm testing how 64-bit
timestamps are encoding, "root" has no meaning, because the scope of
the test doesn't even really include the concept of a process, or user
privileges.

One of the other advantages of unit tests is that sometimes it's much
easier to test the corner cases of some internal abstraction because
you can have test mocks which are can simulate conditions which would
be very hard to simulate if you are running userspace code which can
talk to the kernel only via the system call interface.

> The reason I want get clarity on the issue of data-driven tests is
> that I think data-driven tests and tests that probe are very much
> desirable.  This allows a test to be able to be more generalized and
> allows for specialization of the test for more scenarios without
> re-coding it.  I'm not sure if this still qualifies as unit testing,
> but it's very useful as a means to extend the value of a test.  We
> haven't trod into the mocking parts of kunit, but I'm hoping that it
> may be possible to have that be data-driven (depending on what's
> being mocked), to make it easier to test more things using the same
> code.

So does this distinction help?

If you need to do things which involve system calls and whether the
system calls are run as root, it seems to me that the existing
kselftest infrastructure is the right thing to do.  If you are
interested in testing code below (and in some cases *well* below) the
system call interface, then kunit is the right approach.

I'd encourage you to take a look at Iiuri's fs/ext4/inode-test.c.  As
you can see, it is very data-driven.  But it is also, at the same
time, very self-contained, and which can be easily run, and run very
quickly.

Cheers,

						- Ted
