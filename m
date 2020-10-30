Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B892A0B03
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Oct 2020 17:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgJ3QXM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Oct 2020 12:23:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:38766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgJ3QXM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Oct 2020 12:23:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604074989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=64gR4AhnvtOA27gAC9tqrXw7cMfiN953TiGFaLX23T4=;
        b=dWZtJF9lR4GPm6LH/wln66pxL5AkWykOesxPPHzfAIz0AC48Y/rs/Nr6Uph9uxvRrleQ/M
        AKKRSRSDGPmSQe4ehHkP8GWXObZDrWLZbU0rVZ5502SDCgceWgmKCkIf/M8Sw6EgD8yUsR
        eIjMtA0+CvpiSrJEth44Ygrpk1rFBKs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 64EC1ACF5;
        Fri, 30 Oct 2020 16:23:09 +0000 (UTC)
Date:   Fri, 30 Oct 2020 17:23:08 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>,
        Willy Tarreau <w@1wt.eu>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH 3/4] kselftest_module.h: add struct rnd_state and seed
 parameter
Message-ID: <20201030162308.GD20201@alley>
References: <20201025214842.5924-1-linux@rasmusvillemoes.dk>
 <20201025214842.5924-4-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201025214842.5924-4-linux@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun 2020-10-25 22:48:41, Rasmus Villemoes wrote:
> Some test suites make use of random numbers to increase the test
> coverage when the test suite gets run on different machines and
> increase the chance of some corner case bug being discovered - and I'm
> planning on extending some existing ones in that direction as
> well. However, should a bug be found this way, it's important that the
> exact same series of tests can be repeated to verify the bug is
> fixed. That means the random numbers must be obtained
> deterministically from a generator private to the test module.
> 
> To avoid adding boilerplate to various test modules, put some logic
> into kselftest_module.h: If the module declares that it will use
> random numbers, add a "seed" module parameter. If not explicitly given
> when the module is loaded (or via kernel command line), obtain a
> random one. In either case, print the seed used, and repeat that
> information if there was at least one test failing.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  tools/testing/selftests/kselftest_module.h | 35 ++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_module.h b/tools/testing/selftests/kselftest_module.h
> index c81c0b0c054befaf665b..43f3ca58fcd550b8ac83 100644
> --- a/tools/testing/selftests/kselftest_module.h
> +++ b/tools/testing/selftests/kselftest_module.h
> @@ -3,14 +3,31 @@
>  #define __KSELFTEST_MODULE_H
>  
>  #include <linux/module.h>
> +#include <linux/prandom.h>
> +#include <linux/random.h>
>  
>  /*
>   * Test framework for writing test modules to be loaded by kselftest.
>   * See Documentation/dev-tools/kselftest.rst for an example test module.
>   */
>  
> +/*
> + * If the test module makes use of random numbers, define KSTM_RANDOM
> + * to 1 before including this header. Then a module parameter "seed"
> + * will be defined. If not given, a random one will be obtained. In
> + * either case, the used seed is reported, so the exact same series of
> + * tests can be repeated by loading the module with that seed
> + * given.
> + */
> +
> +#ifndef KSTM_RANDOM
> +#define KSTM_RANDOM 0
> +#endif
> +
>  static unsigned int total_tests __initdata;
>  static unsigned int failed_tests __initdata;
> +static struct rnd_state rnd_state __initdata;
> +static u64 seed __initdata;
>  
>  #define KSTM_CHECK_ZERO(x) do {						\
>  	total_tests++;							\
> @@ -22,11 +39,13 @@ static unsigned int failed_tests __initdata;
>  
>  static inline int kstm_report(unsigned int total_tests, unsigned int failed_tests)
>  {
> -	if (failed_tests == 0)
> +	if (failed_tests == 0) {
>  		pr_info("all %u tests passed\n", total_tests);
> -	else
> +	} else {
>  		pr_warn("failed %u out of %u tests\n", failed_tests, total_tests);
> -
> +		if (KSTM_RANDOM)
> +			pr_info("random seed used was 0x%016llx\n", seed);

I have a bit mixed feelings about this. It is genial and dirty hack at the
same time ;-) Well, it is basically the same approach as with
IS_ENABLED(CONFIG_bla_bla).

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
