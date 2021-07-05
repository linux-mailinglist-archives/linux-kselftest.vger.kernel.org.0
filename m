Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938B83BBE7C
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jul 2021 16:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhGEOz5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jul 2021 10:55:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:44623 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230504AbhGEOz5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jul 2021 10:55:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10036"; a="208808208"
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; 
   d="scan'208";a="208808208"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2021 07:53:20 -0700
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; 
   d="scan'208";a="646796742"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2021 07:53:17 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m0PyC-008hjo-83; Mon, 05 Jul 2021 17:53:12 +0300
Date:   Mon, 5 Jul 2021 17:53:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Trent Piepho <tpiepho@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] math: Make RATIONAL tristate
Message-ID: <YOMc2PZTur+qyhH9@smile.fi.intel.com>
References: <20210705114633.1500710-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705114633.1500710-1-geert@linux-m68k.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 05, 2021 at 01:46:33PM +0200, Geert Uytterhoeven wrote:
> All but one symbols that select RATIONAL are tristate, but RATIONAL
> itself is bool.  Change it to tristate, so the rational fractions
> support code can be modular if no builtin code relies on it.
> 
> While at it, add support for compile-testing and provide a help text.

...

> Exposed by commit b6c75c4afceb8bc0 ("lib/math/rational: add Kunit test
> cases") and CONFIG_KUNIT_ALL_TESTS=m.
> 
> I'm not so happy RATIONAL_KUNIT_TEST selects RATIONAL, as test code
> should depend on the presence of the feature to test.  Else enabling
> a test may add unneeded code to a production kernel.
> Perhaps the "if COMPILE_TEST" should be dropped, making RATIONAL
> visible, so RATIONAL_KUNIT_TEST can depend on RATIONAL instead?

...

> +	tristate "Rational fractions support" if COMPILE_TEST

Making it tristate is okay, but visible (even for COMPILE_TEST)... why?
Just on purpose to be dependent on for test case? I understand your
justification above, but it will bring all hidden symbols to be unhidden
(due to test cases) and this is not the right thing to do in my opinion.

Why not to complain to KUnit people to fix their infra to avoid tests that
tries non-selected feature(s)?

-- 
With Best Regards,
Andy Shevchenko


