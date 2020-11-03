Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098612A4451
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Nov 2020 12:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgKCLc4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Nov 2020 06:32:56 -0500
Received: from mga03.intel.com ([134.134.136.65]:14320 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728343AbgKCLc4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Nov 2020 06:32:56 -0500
IronPort-SDR: nvumdhws0EpGVLuw31h7ukWkJ6xFYkekanZHBpJH+6EciIiiafqRv+fdf2gMR9pJa7zcJnxWn8
 QHPOdXhGe5ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="169142920"
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="scan'208";a="169142920"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 03:32:55 -0800
IronPort-SDR: Xok5TTeP53mEEvRa6eqBOm9Q6BAhXsqLRP6HUdxNB4KVHRwvcrLxzrf4GYr/wDyMoiNoif1IOM
 66dvYfuocakQ==
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="scan'208";a="320398888"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 03:32:52 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kZuZV-003T4k-PG; Tue, 03 Nov 2020 13:33:53 +0200
Date:   Tue, 3 Nov 2020 13:33:53 +0200
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
Subject: Re: [PATCH v3] lib: Convert test_printf.c to KUnit
Message-ID: <20201103113353.GC4077@smile.fi.intel.com>
References: <20201103111049.51916-1-98.arpi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201103111049.51916-1-98.arpi@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 03, 2020 at 04:40:49PM +0530, Arpitha Raghunandan wrote:
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
> [    0.540860] test_printf: loaded.
> [    0.540863] test_printf: random seed = 0x5c46c33837bc0619
> [    0.541022] test_printf: all 388 tests passed
> 
> Original test failure:
> [    0.537980] test_printf: loaded.
> [    0.537983] test_printf: random seed = 0x1bc1efd881954afb
> [    0.538029] test_printf: vsnprintf(buf, 256, "%pi4|%pI4", ...) wrote '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
> [    0.538030] test_printf: kvasprintf(..., "%pi4|%pI4", ...) returned '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
> [    0.538124] test_printf: failed 2 out of 388 tests
> [    0.538125] test_printf: random seed used was 0x1bc1efd881954afb
> 
> Converted test success:
>     # Subtest: printf
>     1..25
>     ok 1 - test_basic
>     ok 2 - test_number
>     ok 3 - test_string
>     ok 4 - plain
>     ok 5 - null_pointer
>     ok 6 - error_pointer
>     ok 7 - invalid_pointer
>     ok 8 - symbol_ptr
>     ok 9 - kernel_ptr
>     ok 10 - struct_resource
>     ok 11 - addr
>     ok 12 - escaped_str
>     ok 13 - hex_string
>     ok 14 - mac
>     ok 15 - ip
>     ok 16 - uuid
>     ok 17 - dentry
>     ok 18 - struct_va_format
>     ok 19 - time_and_date
>     ok 20 - struct_clk
>     ok 21 - bitmap
>     ok 22 - netdev_features
>     ok 23 - flags
>     ok 24 - errptr
>     ok 25 - fwnode_pointer
> ok 1 - printf
> 
> Converted test failure:
>     # Subtest: printf
>     1..25
>     ok 1 - test_basic
>     ok 2 - test_number
>     ok 3 - test_string
>     ok 4 - plain
>     ok 5 - null_pointer
>     ok 6 - error_pointer
>     ok 7 - invalid_pointer
>     ok 8 - symbol_ptr
>     ok 9 - kernel_ptr
>     ok 10 - struct_resource
>     ok 11 - addr
>     ok 12 - escaped_str
>     ok 13 - hex_string
>     ok 14 - mac
>     # ip: EXPECTATION FAILED at lib/printf_kunit.c:82
> vsnprintf(buf, 256, "%pi4|%pI4", ...) wrote '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
>     # ip: EXPECTATION FAILED at lib/printf_kunit.c:124
> kvasprintf(..., "%pi4|%pI4", ...) returned '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
>     not ok 15 - ip
>     ok 16 - uuid
>     ok 17 - dentry
>     ok 18 - struct_va_format
>     ok 19 - time_and_date
>     ok 20 - struct_clk
>     ok 21 - bitmap
>     ok 22 - netdev_features
>     ok 23 - flags
>     ok 24 - errptr
>     ok 25 - fwnode_pointer
> not ok 1 - printf

Better, indeed.

But can be this improved to have a cumulative statistics, like showing only
number of total, succeeded, failed with details of the latter ones?

> This patch is based on top of Andy's series that renames KUnit based
> tests in lib/ and Ramsus' series on deterministic random testing.

For the reference:
https://lore.kernel.org/linux-kselftest/20201016110836.52613-1-andriy.shevchenko@linux.intel.com/

...

> -static void __init
> -test_string(void)
> +static void
> +test_string(struct kunit *ktest)

I guess no need anymore to keep them on two lines, just combine to one line.

-- 
With Best Regards,
Andy Shevchenko


