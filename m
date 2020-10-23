Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBFA297656
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Oct 2020 20:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754099AbgJWSBb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Oct 2020 14:01:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:45252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751571AbgJWSBb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Oct 2020 14:01:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603476089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sYUk+0wycss9Jl0gKNB2yEmVhQdLfD7n3Pwk615mRNM=;
        b=CMmDJhXLdr4v34TFV74GJpYPkNLP/3sz72znUpUXn8YraRmTUzHPLy3Ews0zDjr2T5aT6F
        iurpC+lgJYf97fHUy5GbDZInAwgvI1IszR0td2RXcFYnO3Kgx4AR+u6rk+aIo1kjm1i4RI
        5BF7Soa/Fw5L/+ebqcn+fJQEWEuovMc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CBE6EAC54;
        Fri, 23 Oct 2020 18:01:28 +0000 (UTC)
Date:   Fri, 23 Oct 2020 20:01:28 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        alexandre.belloni@bootlin.com, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, idryomov@gmail.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] lib: Convert test_printf.c to KUnit
Message-ID: <20201023180128.GB13609@alley>
References: <20201022151349.47436-1-98.arpi@gmail.com>
 <20201022191606.GQ4077@smile.fi.intel.com>
 <0ab618c7-8c5c-00ae-8e08-0c1b99f3bf5c@rasmusvillemoes.dk>
 <01f8ca45-60d1-ad67-f8eb-354dec411a78@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01f8ca45-60d1-ad67-f8eb-354dec411a78@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri 2020-10-23 19:13:00, Arpitha Raghunandan wrote:
> On 23/10/20 4:36 pm, Rasmus Villemoes wrote:
> > On 22/10/2020 21.16, Andy Shevchenko wrote:
> >> On Thu, Oct 22, 2020 at 08:43:49PM +0530, Arpitha Raghunandan wrote:
> >>> Converted test failure:
> >>>     # Subtest: printf-kunit-test
> >>>     1..1
> >>>     # selftest: EXPECTATION FAILED at lib/printf_kunit.c:82
> >>> vsnprintf(buf, 256, "%pi4|%pI4", ...) wrote
> >>> '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
> >>>     # selftest: EXPECTATION FAILED at lib/printf_kunit.c:82
> >>> vsnprintf(buf, 5, "%pi4|%pI4", ...) wrote '127.', expected '127-'
> >>>     # selftest: EXPECTATION FAILED at lib/printf_kunit.c:118
> >>> kvasprintf(..., "%pi4|%pI4", ...) returned
> >>> '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
> >>>     not ok 1 - selftest
> >>> not ok 1 - printf-kunit-test
> >>
> >> Not bad. Rasmus, what do you think?
> > 
> > Much better, but that '1..1' and reporting the entire test suite as 1
> > single (failing or passing) test is (also) a regression. Look at the
> > original
> > 
> >>> [    0.591409] test_printf: all 388 tests passed
> > 
> > or
> > 
> >>> [    0.619495] test_printf: failed 3 out of 388 tests
> > 
> > That's far more informative, and I'd prefer if the summary information
> > (whether in the all-good case or some-failing) included something like
> > this. In particular, I have at some point spotted that I failed to
> > properly hook up a new test case (or perhaps failed to re-compile, or
> > somehow still ran the old kernel binary, don't remember which it was) by
> > noticing that the total number of tests hadn't increased. The new output
> > would not help catch such PEBKACs.
> > 
> > Rasmus
> > 
> 
> Splitting the test into multiple test cases in KUnit will display
> the number and name of tests that pass or fail. This will be similar
> to the lib/list-test.c test as can be seen here:
> https://elixir.bootlin.com/linux/latest/source/lib/list-test.c.
> I will work on this for the next version of this patch.

We should probably agree on the granularity first.

It looks like an overkill to split the tests into 388 functions
and define KUNIT_CASE() lines. It might be possible to hide
this into macros but macros are hell for debugging.

I suggest to split it by the current functions that do more test()
call inside. I mean to define something like:

static struct kunit_case printf_test_cases[] = {
	KUNIT_CASE(basic),
	KUNIT_CASE(number),
	KUNIT_CASE(string),
	KUNIT_CASE(plain_pointer),
	KUNIT_CASE(null_poiter),
	KUNIT_CASE(error_pointer),
	KUNIT_CASE(addr),
	KUNIT_CASE(struct_resource),
	KUNIT_CASE(dentry),
	KUNIT_CASE(pointer_addr),
	 ...,
	{}
};

Best Regards,
Petr
