Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36ABE42D019
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Oct 2021 03:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhJNB5P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Oct 2021 21:57:15 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]:38528 "EHLO
        codeconstruct.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJNB5P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Oct 2021 21:57:15 -0400
Received: from [172.16.66.209] (unknown [49.255.141.98])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8B8072012D;
        Thu, 14 Oct 2021 09:55:08 +0800 (AWST)
Message-ID: <0f85025124359304c8a2a97d007b66d5655645c1.camel@codeconstruct.com.au>
Subject: Re: [RFC PATCH] kunit: flatten kunit_suite*** to kunit_suite** in
 executor
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Date:   Thu, 14 Oct 2021 09:55:07 +0800
In-Reply-To: <CAGS_qxoziNGNVpsUfvUfOReADY0PdriV2gJJ7+LUzzd+7BU-Ow@mail.gmail.com>
References: <20211013191320.2490913-1-dlatypov@google.com>
         <CAFd5g47=aO3e8d4_GGcgY9BK43Z0Oo6SGD-2e5rJDp5r3k4XXQ@mail.gmail.com>
         <CAGS_qxoziNGNVpsUfvUfOReADY0PdriV2gJJ7+LUzzd+7BU-Ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Daniel,

> > I like it! This seems to make a lot of logic simpler (and from the
> > sounds makes Jeremy's proposed module patch easier?).
> 
> This would make the subsequent cleanup easier.
> 
> Jemery, correct me if I misread, but it sounded like you were thinking
> of leaving the current kunit_suite*** layout until afterwards. Then
> we'd flatten it as a cleanup.

Yep, that was my rough plan. From the current situation:

An object (module or built-in) defines a:

    kunit_test_suite(my_suite)

[or, equivalently, a kunit_test_suites(&my_suite). The only place that I
can see where we add more than one suite through kunit_test_suites is
the kunit code, so let's ignore that for now..]

That expands to:

    static struct kunit_suite *unique_array[] = { &my_suite, NULL };
    static struct kunit_suite **unique_suites
    __used __section(".kunit_test_suites") = unique_array;

[assume actual unique values for unique_array & unique_suites]

So the .kunit_test_suites section content ends up being: an array of
pointers to (null-terminated) arrays of pointers to struct kunit_suite.
But those latter arrays only have one entry anyway.

Once we're reading the suites out of the section, we have the section
size too, so can determine the number of "things"
(suites/arrays-of-suites/whatever) from that.

So, given we only have one entry in the array, we can probably drop the
null-termination, and expand the kunit_test_suite() macro to:

    kunit_test_suite(my_suite) ->

	static struct kunit_suite *unique_array[] = { &my_suite };
	kunit_test_suites_for_module(unique_array);
	static struct kunit_suite **unique_suites
	__used __section(".kunit_test_suites") = unique_array;

Then, the array becomes pretty pointless, so we can reduce that to:

    kunit_test_suite(my_suite) ->

	static struct kunit_suite *unique_array = &my_suite;
	kunit_test_suites_for_module(unique_array);
	static struct kunit_suite *unique_suites
	__used __section(".kunit_test_suites") = unique_array;

But then there's no need for the double pointers, so we could just do:

    kunit_test_suite(my_suite) ->

	static struct kunit_suite *unique_suite
	__used __section(".kunit_test_suites") = &my_suite;

Resulting in the .kunit_test_suites section just being a set of
contiguous pointers to struct kunit_suite. We get the number of suites
from the section size.

[We could go one step further and put the suites themselves in
.kunit_test_suites, rather than the pointers. However, the downside
there is that we'd need macros for the suite declarations, which isn't
as clean]

Modules with multiple suites (currently: kunit itself) can just have
multiple occurrences of kunit_test_suite(), as they no longer conflict,
and we'd no longer need kunit_test_suites() at all.

That was my thinking, anyway. I think it probably makes sense to do that
cleanup after the section patch, as that means we don't need any
post-processing on the suites arrays.

Cheers,


Jeremy

