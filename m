Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A19623A154
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Aug 2020 10:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgHCI51 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Aug 2020 04:57:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:51372 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgHCI50 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Aug 2020 04:57:26 -0400
IronPort-SDR: 7fUg7uEm7MtdQAe5vwUgi0R/xAYEtx4a19YRhi5c0Eo+QXTGePYKfLE1pC1viTxF+fY2yng/Km
 bxnPfx97SgSA==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="132126589"
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="132126589"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 01:57:25 -0700
IronPort-SDR: JK5u0nRI6ANficLgflI38qkeaJUkSIEq5iob74fmR3fksiXcD3CCwuq0KTyBu2bO7ciksosoe+
 J9ZAbCPwSYbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="323978428"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 03 Aug 2020 01:57:22 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k2WHZ-005tfH-PH; Mon, 03 Aug 2020 11:57:21 +0300
Date:   Mon, 3 Aug 2020 11:57:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Vitor Massaru Iha <vitor@massaru.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, fkostenzer@live.at,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] lib: kunit: Convert test_sort to KUnit test
Message-ID: <20200803085721.GX3703480@smile.fi.intel.com>
References: <20200729191151.476368-1-vitor@massaru.org>
 <20200729191948.GZ3703480@smile.fi.intel.com>
 <CAFd5g47MGZTo0k4s1ohRNT09D=NrsBQHOHQwLVq=uh8ezCuAQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g47MGZTo0k4s1ohRNT09D=NrsBQHOHQwLVq=uh8ezCuAQA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 29, 2020 at 12:59:28PM -0700, Brendan Higgins wrote:
> On Wed, Jul 29, 2020 at 12:19 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Jul 29, 2020 at 04:11:51PM -0300, Vitor Massaru Iha wrote:

...

> > >  lib/{test_sort.c => sort_kunit.c} | 31 +++++++++++++++----------------
> >
> > Still opened question why kunit is a suffix? Can't we leave same name? Can't we
> > do it rather prefix?
> 
> Sorry to jump in now; I thought Vitor's reply with a link to the new
> proposed documentation[1] addressed this. The naming convention issue
> came up about a month ago[2]. The people in the discussion (including
> myself) came to an agreement on _kunit.c. That being said, the
> documentation hasn't been accepted yet, so if you really feel strongly
> about it, now is the time to change it.

My argument is to do something like

  - ls .../test* vs. ls .../*_kunit.c

  - use shell completion vs. no completion when looking if there is a test
    module for something

But I agree that this is matter of style.

> All that being said, I would rather not discuss that issue here for
> the benefit of the participants in the preceding discussions.
> 
> I posted lore links for the relevant threads, which should be easy
> enough to In-Reply-To your way into. Nevertheless, if it makes it
> easier, let me know and I can CC you into the discussions.

No need. I think you have enough clever folks and good ideas behind this. Just
put a reference to all these conversion patches to the summary of pros and cons
of renaming.

> [1] https://lore.kernel.org/linux-kselftest/20200620054944.167330-1-davidgow@google.com/T/#u
> [2] https://lore.kernel.org/linux-kselftest/202006141005.BA19A9D3@keescook/t/#u

-- 
With Best Regards,
Andy Shevchenko


