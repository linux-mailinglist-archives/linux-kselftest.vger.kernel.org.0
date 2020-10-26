Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1D329F5D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Oct 2020 21:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgJ2UFP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Oct 2020 16:05:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:56791 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgJ2UFP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Oct 2020 16:05:15 -0400
IronPort-SDR: DvnQS7pjwT8U6h22fpVM+eT75CPSMSGCBrLCCaEOAVUiQb7F13sNzK3wzUGxfvEa1ZuHErAdqj
 rQLbQo9lRqvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="156277324"
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="156277324"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 13:05:07 -0700
IronPort-SDR: 0x6eNbTjfT2Exx7ByBMS2lpf4lMHXre0tLXc/wcHuAQICnGw0AIlvpu1W16iEOxmL5jDlSFN+5
 B94Qbdep+aSw==
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="425151134"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 13:05:05 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1kYEBU-001UHj-4U; Thu, 29 Oct 2020 22:06:08 +0200
Date:   Mon, 26 Oct 2020 12:59:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>, Willy Tarreau <w@1wt.eu>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH 0/4] deterministic random testing
Message-ID: <20201026105927.GC4077@smile.fi.intel.com>
References: <20201025214842.5924-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201025214842.5924-1-linux@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Oct 25, 2020 at 10:48:38PM +0100, Rasmus Villemoes wrote:
> This is a bit of a mixed bag.
> 
> The background is that I have some sort() and list_sort() rework
> planned, but as part of that series I want to extend their their test
> suites somewhat to make sure I don't goof up - and I want to use lots
> of random list lengths with random contents to increase the chance of
> somebody eventually hitting "hey, sort() is broken when the length is
> 3 less than a power of 2 and only the last two elements are out of
> order". But when such a case is hit, it's vitally important that the
> developer can reproduce the exact same test case, which means using a
> deterministic sequence of random numbers.
> 
> Since Petr noticed [1] the non-determinism in test_printf in
> connection with Arpitha's work on rewriting it to kunit, this prompted
> me to use test_printf as a first place to apply that principle, and
> get the infrastructure in place that will avoid repeating the "module
> parameter/seed the rnd_state/report the seed used" boilerplate in each
> module.
> 
> Shuah, assuming the kselftest_module.h changes are ok, I think it's
> most natural if you carry these patches, though I'd be happy with any
> other route as well.

Completely in favour of this.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

One note though. AFAIU the global variables are always being used in the
modules that include the corresponding header. Otherwise we might have an extra
warning(s). I believe you have compiled with W=1 to exclude other cases.

> [1] https://lore.kernel.org/lkml/20200821113710.GA26290@alley/
> 
> 
> Rasmus Villemoes (4):
>   prandom.h: add *_state variant of prandom_u32_max
>   kselftest_module.h: unconditionally expand the KSTM_MODULE_GLOBALS()
>     macro
>   kselftest_module.h: add struct rnd_state and seed parameter
>   lib/test_printf.c: use deterministic sequence of random numbers
> 
>  Documentation/dev-tools/kselftest.rst      |  2 --
>  include/linux/prandom.h                    | 29 ++++++++++++++++
>  lib/test_bitmap.c                          |  3 --
>  lib/test_printf.c                          | 13 ++++---
>  lib/test_strscpy.c                         |  2 --
>  tools/testing/selftests/kselftest_module.h | 40 ++++++++++++++++++----
>  6 files changed, 72 insertions(+), 17 deletions(-)
> 
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


