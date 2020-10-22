Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1C129651F
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Oct 2020 21:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370012AbgJVTPN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Oct 2020 15:15:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:30131 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S370000AbgJVTPK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Oct 2020 15:15:10 -0400
IronPort-SDR: f1H3hf6YHCo1EcHhyx1IVDfMwb9ZoxPxXAh6G7abiiKH0gFz05mOsZ7uyQLerC75ndNM7y+n4N
 4gXX27t3hAXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="229215773"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="229215773"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 12:15:08 -0700
IronPort-SDR: ikuR3ejjhRqsf9EID/IMJ0obREYf/JtrZzlUpYE5mee0KjLJQvZVSG0edSKvbt5S1vtBNjdJFZ
 ZBzyAhpHco0A==
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="359362854"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 12:15:04 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kVg4E-00DVpH-VO; Thu, 22 Oct 2020 22:16:06 +0300
Date:   Thu, 22 Oct 2020 22:16:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk,
        alexandre.belloni@bootlin.com, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, idryomov@gmail.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] lib: Convert test_printf.c to KUnit
Message-ID: <20201022191606.GQ4077@smile.fi.intel.com>
References: <20201022151349.47436-1-98.arpi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022151349.47436-1-98.arpi@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 22, 2020 at 08:43:49PM +0530, Arpitha Raghunandan wrote:
> Convert test lib/test_printf.c to KUnit. More information about
> KUnit can be found at:
> https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
> KUnit provides a common framework for unit tests in the kernel.
> KUnit and kselftest are standardizing around KTAP, converting this
> test to KUnit makes this test output in KTAP which we are trying to
> make the standard test result format for the kernel. More about
> the KTAP format can be found at:
> https://lore.kernel.org/linux-kselftest/CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com/.
> I ran both the original and converted tests as is to produce the
> output for success of the test in the two cases. I also ran these
> tests with a small modification to show the difference in the output
> for failure of the test in both cases. The modification I made is:
> - test("127.000.000.001|127.0.0.1", "%pi4|%pI4", &sa.sin_addr, &sa.sin_addr);
> + test("127-000.000.001|127.0.0.1", "%pi4|%pI4", &sa.sin_addr, &sa.sin_addr);
> 
> Original test success:
> [    0.591262] test_printf: loaded.
> [    0.591409] test_printf: all 388 tests passed
> 
> Original test failure:
> [    0.619345] test_printf: loaded.
> [    0.619394] test_printf: vsnprintf(buf, 256, "%piS|%pIS", ...)
> wrote '127.000.000.001|127.0.0.1', expected
> '127-000.000.001|127.0.0.1'
> [    0.619395] test_printf: vsnprintf(buf, 25, "%piS|%pIS", ...) wrote
> '127.000.000.001|127.0.0.', expected '127-000.000.001|127.0.0.'
> [    0.619396] test_printf: kvasprintf(..., "%piS|%pIS", ...) returned
> '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
> [    0.619495] test_printf: failed 3 out of 388 tests
> 
> Converted test success:
>     # Subtest: printf-kunit-test
>     1..1
>     ok 1 - selftest
> ok 1 - printf-kunit-test
> 
> Converted test failure:
>     # Subtest: printf-kunit-test
>     1..1
>     # selftest: EXPECTATION FAILED at lib/printf_kunit.c:82
> vsnprintf(buf, 256, "%pi4|%pI4", ...) wrote
> '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
>     # selftest: EXPECTATION FAILED at lib/printf_kunit.c:82
> vsnprintf(buf, 5, "%pi4|%pI4", ...) wrote '127.', expected '127-'
>     # selftest: EXPECTATION FAILED at lib/printf_kunit.c:118
> kvasprintf(..., "%pi4|%pI4", ...) returned
> '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
>     not ok 1 - selftest
> not ok 1 - printf-kunit-test

Not bad. Rasmus, what do you think?

> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> ---
> Changes v1->v2:
> - Retain the control flow (early returns) in do_test()
> - Display less irrelevant information on test failure
> - A more detailed commit message
> 
>  lib/Kconfig.debug                     |  7 +--
>  lib/Makefile                          |  2 +-
>  lib/{test_printf.c => printf_kunit.c} | 76 +++++++++++++--------------
>  3 files changed, 43 insertions(+), 42 deletions(-)
>  rename lib/{test_printf.c => printf_kunit.c} (91%)

I would based this on top of my series that renames existing KUnit based tests
in lib/.

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 66d44d35cc97..e82ca893ed5b 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2053,9 +2053,6 @@ config TEST_STRSCPY
>  config TEST_KSTRTOX
>  	tristate "Test kstrto*() family of functions at runtime"
>  
> -config TEST_PRINTF
> -	tristate "Test printf() family of functions at runtime"
> -
>  config TEST_BITMAP
>  	tristate "Test bitmap_*() family of functions at runtime"
>  	help
> @@ -2282,6 +2279,10 @@ config BITS_TEST
>  
>  	  If unsure, say N.
>  
> +config PRINTF_KUNIT_TEST
> +	tristate "KUnit test for printf() family of functions at runtime"
> +	depends on KUNIT
> +
>  config TEST_UDELAY
>  	tristate "udelay test driver"
>  	help
> diff --git a/lib/Makefile b/lib/Makefile
> index ce45af50983a..c323447022b7 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -84,7 +84,6 @@ obj-$(CONFIG_TEST_SORT) += test_sort.o
>  obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
>  obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
>  obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
> -obj-$(CONFIG_TEST_PRINTF) += test_printf.o
>  obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
>  obj-$(CONFIG_TEST_STRSCPY) += test_strscpy.o
>  obj-$(CONFIG_TEST_UUID) += test_uuid.o
> @@ -352,3 +351,4 @@ obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
>  obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
>  obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
>  obj-$(CONFIG_BITS_TEST) += test_bits.o
> +obj-$(CONFIG_PRINTF_KUNIT_TEST) += printf_kunit.o
> diff --git a/lib/test_printf.c b/lib/printf_kunit.c
> similarity index 91%
> rename from lib/test_printf.c
> rename to lib/printf_kunit.c
> index 7ac87f18a10f..e4dc1b1c8972 100644
> --- a/lib/test_printf.c
> +++ b/lib/printf_kunit.c
> @@ -5,6 +5,7 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <kunit/test.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -30,64 +31,57 @@
>  #define PAD_SIZE 16
>  #define FILL_CHAR '$'
>  
> -static unsigned total_tests __initdata;
> -static unsigned failed_tests __initdata;
>  static char *test_buffer __initdata;
>  static char *alloced_buffer __initdata;
> +struct kunit *kunittest;
>  
> -static int __printf(4, 0) __init
> +static void __printf(4, 0) __init
>  do_test(int bufsize, const char *expect, int elen,
>  	const char *fmt, va_list ap)
>  {
>  	va_list aq;
>  	int ret, written;
>  
> -	total_tests++;
> -
>  	memset(alloced_buffer, FILL_CHAR, BUF_SIZE + 2*PAD_SIZE);
>  	va_copy(aq, ap);
>  	ret = vsnprintf(test_buffer, bufsize, fmt, aq);
>  	va_end(aq);
>  
>  	if (ret != elen) {
> -		pr_warn("vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d\n",
> +		KUNIT_FAIL(kunittest, "vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d\n",
>  			bufsize, fmt, ret, elen);
> -		return 1;
> +		return;
>  	}
>  
>  	if (memchr_inv(alloced_buffer, FILL_CHAR, PAD_SIZE)) {
> -		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote before buffer\n", bufsize, fmt);
> -		return 1;
> +		KUNIT_FAIL(kunittest, "vsnprintf(buf, %d, \"%s\", ...) wrote before buffer\n", bufsize, fmt);
> +		return;
>  	}
>  
>  	if (!bufsize) {
> -		if (memchr_inv(test_buffer, FILL_CHAR, BUF_SIZE + PAD_SIZE)) {
> -			pr_warn("vsnprintf(buf, 0, \"%s\", ...) wrote to buffer\n",
> -				fmt);
> -			return 1;
> -		}
> -		return 0;
> +		if (memchr_inv(test_buffer, FILL_CHAR, BUF_SIZE + PAD_SIZE))
> +			KUNIT_FAIL(kunittest, "vsnprintf(buf, 0, \"%s\", ...) wrote to buffer\n", fmt);
> +		return;
>  	}
>  
>  	written = min(bufsize-1, elen);
>  	if (test_buffer[written]) {
> -		pr_warn("vsnprintf(buf, %d, \"%s\", ...) did not nul-terminate buffer\n",
> +		KUNIT_FAIL(kunittest, "vsnprintf(buf, %d, \"%s\", ...) did not nul-terminate buffer\n",
>  			bufsize, fmt);
> -		return 1;
> +		return;
>  	}
>  
>  	if (memchr_inv(test_buffer + written + 1, FILL_CHAR, BUF_SIZE + PAD_SIZE - (written + 1))) {
> -		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator\n",
> +		KUNIT_FAIL(kunittest, "vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator\n",
>  			bufsize, fmt);
> -		return 1;
> +		return;
>  	}
>  
>  	if (memcmp(test_buffer, expect, written)) {
> -		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expected '%.*s'\n",
> +		KUNIT_FAIL(kunittest, "vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expected '%.*s'\n",
>  			bufsize, fmt, test_buffer, written, expect);
> -		return 1;
> +		return;
>  	}
> -	return 0;
>  }
>  
>  static void __printf(3, 4) __init
> @@ -98,9 +92,8 @@ __test(const char *expect, int elen, const char *fmt, ...)
>  	char *p;
>  
>  	if (elen >= BUF_SIZE) {
> -		pr_err("error in test suite: expected output length %d too long. Format was '%s'.\n",
> +		KUNIT_FAIL(kunittest, "error in test suite: expected output length %d too long. Format was '%s'.\n",
>  		       elen, fmt);
> -		failed_tests++;
>  		return;
>  	}
>  
> @@ -112,19 +105,17 @@ __test(const char *expect, int elen, const char *fmt, ...)
>  	 * enough and 0), and then we also test that kvasprintf would
>  	 * be able to print it as expected.
>  	 */
> -	failed_tests += do_test(BUF_SIZE, expect, elen, fmt, ap);
> +	do_test(BUF_SIZE, expect, elen, fmt, ap);
>  	rand = 1 + prandom_u32_max(elen+1);
>  	/* Since elen < BUF_SIZE, we have 1 <= rand <= BUF_SIZE. */
> -	failed_tests += do_test(rand, expect, elen, fmt, ap);
> -	failed_tests += do_test(0, expect, elen, fmt, ap);
> +	do_test(rand, expect, elen, fmt, ap);
> +	do_test(0, expect, elen, fmt, ap);
>  
>  	p = kvasprintf(GFP_KERNEL, fmt, ap);
>  	if (p) {
> -		total_tests++;
>  		if (memcmp(p, expect, elen+1)) {
> -			pr_warn("kvasprintf(..., \"%s\", ...) returned '%s', expected '%s'\n",
> +			KUNIT_FAIL(kunittest, "kvasprintf(..., \"%s\", ...) returned '%s', expected '%s'\n",
>  				fmt, p, expect);
> -			failed_tests++;
>  		}
>  		kfree(p);
>  	}
> @@ -303,16 +294,13 @@ plain(void)
>  
>  	err = plain_hash();
>  	if (err) {
> -		pr_warn("plain 'p' does not appear to be hashed\n");
> -		failed_tests++;
> +		KUNIT_FAIL(kunittest, "plain 'p' does not appear to be hashed\n");
>  		return;
>  	}
>  
>  	err = plain_format();
> -	if (err) {
> -		pr_warn("hashing plain 'p' has unexpected format\n");
> -		failed_tests++;
> -	}
> +	if (err)
> +		KUNIT_FAIL(kunittest, "hashing plain 'p' has unexpected format\n");
>  }
>  
>  static void __init
> @@ -696,8 +684,9 @@ test_pointer(void)
>  	fwnode_pointer();
>  }
>  
> -static void __init selftest(void)
> +static void __init selftest(struct kunit *ktest)
>  {
> +	kunittest = ktest;
>  	alloced_buffer = kmalloc(BUF_SIZE + 2*PAD_SIZE, GFP_KERNEL);
>  	if (!alloced_buffer)
>  		return;
> @@ -711,6 +700,17 @@ static void __init selftest(void)
>  	kfree(alloced_buffer);
>  }
>  
> -KSTM_MODULE_LOADERS(test_printf);
> +static struct kunit_case printf_test_cases[] = {
> +	KUNIT_CASE(selftest),
> +	{}
> +};
> +
> +static struct kunit_suite printf_test_suite = {
> +	.name = "printf-kunit-test",
> +	.test_cases = printf_test_cases,
> +};
> +
> +kunit_test_suite(printf_test_suite);
> +
>  MODULE_AUTHOR("Rasmus Villemoes <linux@rasmusvillemoes.dk>");
>  MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


