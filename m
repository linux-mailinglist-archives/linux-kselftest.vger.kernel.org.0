Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C942B6916
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Nov 2020 16:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgKQPvd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Nov 2020 10:51:33 -0500
Received: from mga03.intel.com ([134.134.136.65]:56264 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgKQPvc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Nov 2020 10:51:32 -0500
IronPort-SDR: WNRW3/kM6oZbruqeH4iVTgxPnPlYUWwUfIkXvgPHWF9XYXISo93YJYmxOLxxLPL9zVDcwCIXvb
 b5OUrUlKUZpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="171048493"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="171048493"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 07:51:19 -0800
IronPort-SDR: Cv3lruze8b3N6ng5La45QtfJkKs8xiHueQMBdK7RWayj8xN443vrPVb3Zo+kYoYJ5SjrDj7mXI
 y9Sz9Pmcqyaw==
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="362547403"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 07:51:17 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kf3HG-007MJ0-Ub; Tue, 17 Nov 2020 17:52:18 +0200
Date:   Tue, 17 Nov 2020 17:52:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     David Gow <davidgow@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Mark Brown <broonie@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v4 6/6] lib/cmdline_kunit: Add a new test suite for
 cmdline API
Message-ID: <20201117155218.GP4077@smile.fi.intel.com>
References: <20201112180732.75589-1-andriy.shevchenko@linux.intel.com>
 <20201112180732.75589-6-andriy.shevchenko@linux.intel.com>
 <20201112191025.bd5df6a1f1f6b0419980da1a@linux-foundation.org>
 <20201116095309.GR4077@smile.fi.intel.com>
 <20201116104131.GV4077@smile.fi.intel.com>
 <CABVgOS=2qKw6OBSWMnAMf5un3akkoWej=98zTd=e1dgpqnGTGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOS=2qKw6OBSWMnAMf5un3akkoWej=98zTd=e1dgpqnGTGQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 17, 2020 at 07:43:28AM +0800, David Gow wrote:
> On Mon, Nov 16, 2020 at 6:40 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, Nov 16, 2020 at 11:53:09AM +0200, Andy Shevchenko wrote:
> > > On Thu, Nov 12, 2020 at 07:10:25PM -0800, Andrew Morton wrote:
> > > > On Thu, 12 Nov 2020 20:07:32 +0200 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > > Test get_option() for a starter which is provided by cmdline.c.
> > > > >
> > > > > ...
> > > > >
> > > > >  lib/cmdline_kunit.c | 98 +++++++++++++++++++++++++++++++++++++++++++++
> > >
> > > First of all, thanks for taking care of this!
> > >
> > > > The spectacular warning storm which this produces makes me wonder if
> > > > you sent the correct version?  I mean, the cmdline_test_values[]
> > > > definition wasn't even close.
> > >
> > > This now puzzles me, what happened. I will check my branches, because certainly
> > > I was not only compiled that, but actually run those test cases.
> >
> > David, Brendan, can we somehow make those warnings visible when run test suite
> > via kunit Python wrapper?
> 
> There's a patch in the kunit-fixes branch which should fix this this:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit-fixes&id=390881448b1ff1e9d82896abbbda7cdb8e0be27c

Good we have a fix!

> > It seems to me that I run test cases only via wrapper and I have got no
> > warnings which are ones that must be fixed before submission. It's actual
> > disadvantage of the framework (use of it via wrapper) that makes me feel
> > like I would rather not hurry up with KUnit.
> 
> Yeah: it's a pain, and I've been hit by it a couple of times recently,
> too. If you're not able to pick up the changes in the kunit-fixes
> branch above, then it's definitely best to also manually build a
> kernel to get the build logs.
> 
> In any case, that fix should be merged for 5.10.
> 
> Sorry for the inconvenience!

No problem, I will keep above in mind, thanks.

-- 
With Best Regards,
Andy Shevchenko


