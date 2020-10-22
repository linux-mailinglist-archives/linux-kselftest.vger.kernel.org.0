Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789EB296168
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Oct 2020 17:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507870AbgJVPFy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Oct 2020 11:05:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:16215 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2507864AbgJVPFy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Oct 2020 11:05:54 -0400
IronPort-SDR: jGLKn9jVCYCzuc714i2A5p3okMZKclyjAdgRsw1Efo0gcl5SI2WE1Y5cIiK6IsA74vIYg3Fdhj
 EQzxFQYt5Upw==
X-IronPort-AV: E=McAfee;i="6000,8403,9781"; a="155326398"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="155326398"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 08:05:47 -0700
IronPort-SDR: DnmKSl2doFkSe4e5/aQAyrAEi/WAuS5/1ZSXNRx0fGbgtOg5YM2+9nD5dFXl0cs9pP3wWNgJBB
 D0w/4/ruMU8w==
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="524308747"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 08:05:45 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kVcAy-00DMeS-90; Thu, 22 Oct 2020 18:06:48 +0300
Date:   Thu, 22 Oct 2020 18:06:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] lib: add basic KUnit test for lib/math
Message-ID: <20201022150648.GH4077@smile.fi.intel.com>
References: <20201019224556.3536790-1-dlatypov@google.com>
 <CABVgOS=Kucf3QV=jpo3cLDgG38WvnuKpzEdP_RkBtRwHHPLe3Q@mail.gmail.com>
 <CAGS_qxpX0Do+z-wzCC=twbt-htL=Jkqvrk4L4rKTtXFPfX-TCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGS_qxpX0Do+z-wzCC=twbt-htL=Jkqvrk4L4rKTtXFPfX-TCA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 21, 2020 at 10:47:50AM -0700, Daniel Latypov wrote:
> On Tue, Oct 20, 2020 at 8:40 PM David Gow <davidgow@google.com> wrote:
> > On Tue, Oct 20, 2020 at 6:46 AM Daniel Latypov <dlatypov@google.com> wrote:
> > >
> > > Add basic test coverage for files that don't require any config options:
> > > * gcd.c
> > > * lcm.c
> > > * int_sqrt.c
> > > * reciprocal_div.c
> > > (Ignored int_pow.c since it's a simple textbook algorithm.)
> > >
> > I don't see a particular reason why int_pow.c being a simple algorithm
> > means it shouldn't be tested. I'm not saying it has to be tested by
> > this particular change -- and I doubt the test would be
> > earth-shatteringly interesting -- but there's no real reason against
> > testing it.
> 
> Agreed on principle, but int_pow() feels like a special case.
> I've written it the exact same way (modulo variable names+types)
> several times in personal projects.
> Even the spacing matched exactly in a few of those...

But if you would like to *teach* somebody by this exemplary piece of code, you
better do it close to ideal.

> > > These tests aren't particularly interesting, but
> > > * they're chosen as easy to understand examples of how to write tests
> > > * provides a place to add tests for any new files in this dir
> > > * written so adding new test cases to cover edge cases should be easy
> >
> > I think these tests can stand on their own merits, rather than just as
> > examples (though I do think they do make good additional examples for
> > how to test these sorts of functions).
> > So, I'd treat this as an actual test of the maths functions (and
> > you've got what seems to me a decent set of test cases for that,
> > though there are a couple of comments below) first, and any use it
> > gains as an example is sort-of secondary to that (anything that makes
> > it a better example is likely to make it a better test anyway).
> >
> > In any case, modulo the comments below, this seems good to me.
> 
> Ack.
> I'll wait on Andy's input before deciding whether or not to push out a
> v2 with the changes.

You need to put detailed comments in the code to have it as real example how to
create the KUnit test. But hey, it will mean that documentation sucks. So,
please update documentation to cover issues that you found and which motivated
you to create these test cases.

Summarize this, please create usable documentation first.

-- 
With Best Regards,
Andy Shevchenko


