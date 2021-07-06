Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1433BC9F8
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jul 2021 12:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhGFKep (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jul 2021 06:34:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:19772 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhGFKep (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jul 2021 06:34:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10036"; a="272938292"
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="272938292"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 03:32:07 -0700
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="410451609"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 03:32:05 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m0iMx-009HlJ-S2; Tue, 06 Jul 2021 13:31:59 +0300
Date:   Tue, 6 Jul 2021 13:31:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Trent Piepho <tpiepho@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] math: Make RATIONAL tristate
Message-ID: <YOQxH7mnEPEm4pFA@smile.fi.intel.com>
References: <20210706100945.3803694-1-geert@linux-m68k.org>
 <20210706100945.3803694-2-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706100945.3803694-2-geert@linux-m68k.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 06, 2021 at 12:09:44PM +0200, Geert Uytterhoeven wrote:
> All but one symbols that select RATIONAL are tristate, but RATIONAL
> itself is bool.  Change it to tristate, so the rational fractions
> support code can be modular if no builtin code relies on it.

Works for me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Exposed by commit b6c75c4afceb8bc0 ("lib/math/rational: add Kunit test
> cases") and CONFIG_KUNIT_ALL_TESTS=m.
> 
> v2:
>   - Drop compile-testing and help text.
> ---
>  lib/math/Kconfig    | 2 +-
>  lib/math/rational.c | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/math/Kconfig b/lib/math/Kconfig
> index f19bc9734fa7cc4b..0634b428d0cb7f86 100644
> --- a/lib/math/Kconfig
> +++ b/lib/math/Kconfig
> @@ -14,4 +14,4 @@ config PRIME_NUMBERS
>  	  If unsure, say N.
>  
>  config RATIONAL
> -	bool
> +	tristate
> diff --git a/lib/math/rational.c b/lib/math/rational.c
> index c0ab51d8fbb98d17..ec59d426ea638b0f 100644
> --- a/lib/math/rational.c
> +++ b/lib/math/rational.c
> @@ -13,6 +13,7 @@
>  #include <linux/export.h>
>  #include <linux/minmax.h>
>  #include <linux/limits.h>
> +#include <linux/module.h>
>  
>  /*
>   * calculate best rational approximation for a given fraction
> @@ -106,3 +107,5 @@ void rational_best_approximation(
>  }
>  
>  EXPORT_SYMBOL(rational_best_approximation);
> +
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


