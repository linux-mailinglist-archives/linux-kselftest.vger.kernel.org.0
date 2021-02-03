Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5CB30E390
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Feb 2021 20:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhBCTuK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Feb 2021 14:50:10 -0500
Received: from mga17.intel.com ([192.55.52.151]:36180 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230064AbhBCTuI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Feb 2021 14:50:08 -0500
IronPort-SDR: eox42Z1I8dZkZSrqEFzQYjS5jgMXir8k4zfEnN7MbLmWC2tPhptw0613WLmy+4NpCM/p8hFrDU
 ZfABerDT+P4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="160864595"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="160864595"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 11:48:22 -0800
IronPort-SDR: Nn3btFmbNQgkQcCGrpkegt1Xb82z1ML67A8IrZNitVLVjbNEEm6P9neiDDdTQ/U4tq83BkWnNq
 BCggf+TYtOlA==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="356873921"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 11:48:19 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l7O8O-001iQL-KW; Wed, 03 Feb 2021 21:48:16 +0200
Date:   Wed, 3 Feb 2021 21:48:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v4 4/4] selftests: lib: Add wrapper script for test_scanf
Message-ID: <YBr+AMFt/1d09wxs@smile.fi.intel.com>
References: <20210203165009.6299-1-rf@opensource.cirrus.com>
 <20210203165009.6299-4-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203165009.6299-4-rf@opensource.cirrus.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 03, 2021 at 04:50:09PM +0000, Richard Fitzgerald wrote:
> Adds a wrapper shell script for the test_scanf module.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
>  tools/testing/selftests/lib/Makefile | 2 +-
>  tools/testing/selftests/lib/config   | 1 +
>  tools/testing/selftests/lib/scanf.sh | 4 ++++
>  3 files changed, 6 insertions(+), 1 deletion(-)
>  create mode 100755 tools/testing/selftests/lib/scanf.sh
> 
> diff --git a/tools/testing/selftests/lib/Makefile b/tools/testing/selftests/lib/Makefile
> index a105f094676e..ee71fc99d5b5 100644
> --- a/tools/testing/selftests/lib/Makefile
> +++ b/tools/testing/selftests/lib/Makefile
> @@ -4,6 +4,6 @@
>  # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
>  all:
>  
> -TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh strscpy.sh
> +TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh scanf.sh strscpy.sh
>  
>  include ../lib.mk
> diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
> index b80ee3f6e265..776c8c42e78d 100644
> --- a/tools/testing/selftests/lib/config
> +++ b/tools/testing/selftests/lib/config
> @@ -1,4 +1,5 @@
>  CONFIG_TEST_PRINTF=m
> +CONFIG_TEST_SCANTF=m
>  CONFIG_TEST_BITMAP=m
>  CONFIG_PRIME_NUMBERS=m
>  CONFIG_TEST_STRSCPY=m
> diff --git a/tools/testing/selftests/lib/scanf.sh b/tools/testing/selftests/lib/scanf.sh
> new file mode 100755
> index 000000000000..b59b8ba561c3
> --- /dev/null
> +++ b/tools/testing/selftests/lib/scanf.sh
> @@ -0,0 +1,4 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# Tests the scanf infrastructure using test_scanf kernel module.
> +$(dirname $0)/../kselftest/module.sh "scanf" test_scanf
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


