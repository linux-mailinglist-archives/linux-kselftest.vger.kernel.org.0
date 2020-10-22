Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C363C29650A
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Oct 2020 21:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508758AbgJVTJi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Oct 2020 15:09:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:21154 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506725AbgJVTJi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Oct 2020 15:09:38 -0400
IronPort-SDR: Ff/hZ0+/AddE7/qZCT7SEnAHCWuGkzjd+zJfaIv6sfAQBp01jsog7Mv7DAjrzvrHA5c8wI0j7A
 h/fBE4vv7mNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="164088659"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="164088659"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 12:09:36 -0700
IronPort-SDR: W1R0GRAtLqpAxOBISos56NOpQPeE4ZH0sdvOMxFivwvIE6wNBHgXY4yLsqnJTYB2t+J5VpL8DQ
 JM9QY6Jn95gA==
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="534087053"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 12:09:35 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kVfyw-00DVdO-3Y; Thu, 22 Oct 2020 22:10:38 +0300
Date:   Thu, 22 Oct 2020 22:10:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] lib: add basic KUnit test for lib/math
Message-ID: <20201022191038.GO4077@smile.fi.intel.com>
References: <20201019224556.3536790-1-dlatypov@google.com>
 <CABVgOS=Kucf3QV=jpo3cLDgG38WvnuKpzEdP_RkBtRwHHPLe3Q@mail.gmail.com>
 <CAGS_qxpX0Do+z-wzCC=twbt-htL=Jkqvrk4L4rKTtXFPfX-TCA@mail.gmail.com>
 <20201022150648.GH4077@smile.fi.intel.com>
 <CAGS_qxogKfYBr=5jPsON60NTAoqqSK2y+dQodnZ5r0Uo0ecJ3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGS_qxogKfYBr=5jPsON60NTAoqqSK2y+dQodnZ5r0Uo0ecJ3Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 22, 2020 at 09:26:45AM -0700, Daniel Latypov wrote:
> On Thu, Oct 22, 2020 at 8:06 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Oct 21, 2020 at 10:47:50AM -0700, Daniel Latypov wrote:

...

> > You need to put detailed comments in the code to have it as real example how to
> > create the KUnit test. But hey, it will mean that documentation sucks. So,
> 
> Out of curiosity
> * By "it will mean that documentation sucks," do you mean that the
> documentation will rot faster if people are using the existing in-tree
> tests as their entrypoint?

Yes. And it will discourage to write documentation as well and read.
Good documentation is like a good book. I like how doc.python.org works for me
when I need something new to get about it, for example.

> * What level of detailed comments? On the level of kunit-example-test.c?
>   * More concretely, then we'd have a comment block linking to the

Something like explaining each line with KUNIT / kunit in it.
What it does and why it's written in the given form. Something like that.

> example and then describing table driven unit testing?
>   * And then maybe another block about invariants instead of the
> perhaps too-terse /* gcd(a,b) == gcd(b,a) */ ?

Right.

> > please update documentation to cover issues that you found and which motivated
> > you to create these test cases.
> >
> > Summarize this, please create usable documentation first.
> 
> Sounds good.
> I'm generally wary people not reading the docs, and of documentation
> examples becoming bitrotted faster than actual code.
> But so far KUnit seems to be doing relatively well on both fronts.

Dunno. As I told, I have created first unit test based on documentation (okay,
I looked at the code, but you may read this as ratio was 90% doc / 10% existing
code).

> usage.rst is currently the best place for this, but it felt like it
> would quickly become a dumping ground for miscellaneous tips and
> tricks.
> I'll spend some time thinking if we want a new file or not, based on
> how much I want to write about the things this test demonstrated
> (EXPECT_*MSG, table driven tests, testing invariants, etc).

Thanks!

> In offline discussions with David, the idea had come up with having a
> set of (relatively) simple tests in tree that the documentation could
> point to as examples of these things. That would keep the line count
> in usage.rst down a bit.
> (But then it would necessitate more tests like this math_test.c)

-- 
With Best Regards,
Andy Shevchenko


