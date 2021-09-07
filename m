Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F253840254F
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Sep 2021 10:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241555AbhIGIoB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Sep 2021 04:44:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:27286 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236858AbhIGIoB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Sep 2021 04:44:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="305697790"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="305697790"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 01:42:55 -0700
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="448910336"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 01:42:51 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 07 Sep 2021 11:42:49 +0300
Date:   Tue, 7 Sep 2021 11:42:49 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: Fixing up at least some fallout from '-Werror'
Message-ID: <YTcmCT9rz0Uvapot@lahna>
References: <CAHk-=wgd2eJrkQCb2Pd0Fzh3mX1AjMHXAjjYxOPdCNCRDx2oYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgd2eJrkQCb2Pd0Fzh3mX1AjMHXAjjYxOPdCNCRDx2oYg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 06, 2021 at 01:00:48PM -0700, Linus Torvalds wrote:
> So I just committed these three fixes:
> 
>    4b93c544e90e ("thunderbolt: test: split up test cases in
> tb_test_credit_alloc_all")
>    ba7b1f861086 ("lib/test_scanf: split up number parsing test routines")
>    1476ff21abb4 ("iwl: fix debug printf format strings")
> 
> for the fallout from -Werror that I could easily check (mainly i386
> 'allyesconfig' - a situation I don't normally test).
> 
> The printk format string one was trivial and I hopefully didn't screw
> anything up, but I'd ask people to look at and verify the two other
> ones. I tried to be very careful, and organizing the code movement in
> such a way that 'git diff' shows that it's doing the same thing before
> and after, but hey, mistakes happen.
> 
> I found those two test-based ones somewhat annoying, because they both
> showed how little the test infrastructure tries to follow kernel
> rules. I bet those warnings have been showing up for a long long time,
> and people went "that's not a relevant configuration" or had some
> other reason to ignore them.
> 
> No, the test cases may not be relevant in most situations, but it's
> not a good thing when something that is supposed to verify kernel
> behavior then violates some very fundamental and core kernel rules.
> 
> And maybe it was simply missed. The one thing that was clear when I
> did that thunderbolt thing in particular is how easy it is to create
> variations of those 'struct some-assertion-struct' things on stack as
> part of the KUNIT infrastructure. That's unfortunate. It is possible
> that the solution to the kernel stack usage might have been to make
> those structures static instead, but I didn't check whether the
> description structs really can be.

Thanks for doing this! I certainly have received few mails from the
kbuildbot about this but haven't figured how to fix them properly.
Splitting the test to several small functions sounds like a good way to
do this. I'll keep this in mind in the future when adding more test
cases.
