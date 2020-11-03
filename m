Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755C72A4B31
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Nov 2020 17:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgKCQWu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Nov 2020 11:22:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:50922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728465AbgKCQWt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Nov 2020 11:22:49 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD20222264;
        Tue,  3 Nov 2020 16:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604420568;
        bh=gNW+h5DOIiV/dxUEaY1kydqcdJamrMbNqm9JY9C56q8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WUKVXSG3khtp4Yf4WUZpTfy0Y9iWx6ybhNNctAFmoxLEi52dvnqIgfh+iYxE5kJWo
         CzEIwnSeDsWYpTSK/1nRVa5PDm32bD2vuFp/gkvJmcWoeXU+JjGOj4xm3fIsUhguKF
         yS1WboPIBw2wGnujbFmMRgrGn70ic2vj5d3Krxo0=
Date:   Tue, 3 Nov 2020 17:23:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        linux@rasmusvillemoes.dk, alexandre.belloni@bootlin.com,
        rdunlap@infradead.org, idryomov@gmail.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3] lib: Convert test_printf.c to KUnit
Message-ID: <20201103162340.GA281002@kroah.com>
References: <20201103111049.51916-1-98.arpi@gmail.com>
 <20201103113353.GC4077@smile.fi.intel.com>
 <20201103115223.GA268796@kroah.com>
 <20201103160728.GQ20201@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201103160728.GQ20201@alley>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 03, 2020 at 05:11:47PM +0100, Petr Mladek wrote:
> On Tue 2020-11-03 12:52:23, Greg KH wrote:
> > On Tue, Nov 03, 2020 at 01:33:53PM +0200, Andy Shevchenko wrote:
> > > On Tue, Nov 03, 2020 at 04:40:49PM +0530, Arpitha Raghunandan wrote:
> > > > Convert test lib/test_printf.c to KUnit. More information about
> > > > KUnit can be found at:
> > > > https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
> > > > KUnit provides a common framework for unit tests in the kernel.
> > > > KUnit and kselftest are standardizing around KTAP, converting this
> > > > test to KUnit makes this test output in KTAP which we are trying to
> > > > make the standard test result format for the kernel. More about
> > > > the KTAP format can be found at:
> > > > https://lore.kernel.org/linux-kselftest/CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com/.
> > > > I ran both the original and converted tests as is to produce the
> > > > output for success of the test in the two cases. I also ran these
> > > > tests with a small modification to show the difference in the output
> > > > for failure of the test in both cases. The modification I made is:
> > > > - test("127.000.000.001|127.0.0.1", "%pi4|%pI4", &sa.sin_addr, &sa.sin_addr);
> > > > + test("127-000.000.001|127.0.0.1", "%pi4|%pI4", &sa.sin_addr, &sa.sin_addr);
> > > > 
> > > > Original test success:
> > > > [    0.540860] test_printf: loaded.
> > > > [    0.540863] test_printf: random seed = 0x5c46c33837bc0619
> > > > [    0.541022] test_printf: all 388 tests passed
> > > > 
> > > > Original test failure:
> > > > [    0.537980] test_printf: loaded.
> > > > [    0.537983] test_printf: random seed = 0x1bc1efd881954afb
> > > > [    0.538029] test_printf: vsnprintf(buf, 256, "%pi4|%pI4", ...) wrote '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
> > > > [    0.538030] test_printf: kvasprintf(..., "%pi4|%pI4", ...) returned '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
> > > > [    0.538124] test_printf: failed 2 out of 388 tests
> > > > [    0.538125] test_printf: random seed used was 0x1bc1efd881954afb
> > > > 
> > > > Converted test success:
> > > >     # Subtest: printf
> > > >     1..25
> > > >     ok 1 - test_basic
> > > >     ok 2 - test_number
> > > >     ok 3 - test_string
> > > >     ok 4 - plain
> > > >     ok 5 - null_pointer
> > > >     ok 6 - error_pointer
> > > >     ok 7 - invalid_pointer
> > > >     ok 8 - symbol_ptr
> > > >     ok 9 - kernel_ptr
> > > >     ok 10 - struct_resource
> > > >     ok 11 - addr
> > > >     ok 12 - escaped_str
> > > >     ok 13 - hex_string
> > > >     ok 14 - mac
> > > >     ok 15 - ip
> > > >     ok 16 - uuid
> > > >     ok 17 - dentry
> > > >     ok 18 - struct_va_format
> > > >     ok 19 - time_and_date
> > > >     ok 20 - struct_clk
> > > >     ok 21 - bitmap
> > > >     ok 22 - netdev_features
> > > >     ok 23 - flags
> > > >     ok 24 - errptr
> > > >     ok 25 - fwnode_pointer
> > > > ok 1 - printf
> > > > 
> > > > Converted test failure:
> > > >     # Subtest: printf
> > > >     1..25
> > > >     ok 1 - test_basic
> > > >     ok 2 - test_number
> > > >     ok 3 - test_string
> > > >     ok 4 - plain
> > > >     ok 5 - null_pointer
> > > >     ok 6 - error_pointer
> > > >     ok 7 - invalid_pointer
> > > >     ok 8 - symbol_ptr
> > > >     ok 9 - kernel_ptr
> > > >     ok 10 - struct_resource
> > > >     ok 11 - addr
> > > >     ok 12 - escaped_str
> > > >     ok 13 - hex_string
> > > >     ok 14 - mac
> > > >     # ip: EXPECTATION FAILED at lib/printf_kunit.c:82
> > > > vsnprintf(buf, 256, "%pi4|%pI4", ...) wrote '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
> > > >     # ip: EXPECTATION FAILED at lib/printf_kunit.c:124
> > > > kvasprintf(..., "%pi4|%pI4", ...) returned '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
> > > >     not ok 15 - ip
> > > >     ok 16 - uuid
> > > >     ok 17 - dentry
> > > >     ok 18 - struct_va_format
> > > >     ok 19 - time_and_date
> > > >     ok 20 - struct_clk
> > > >     ok 21 - bitmap
> > > >     ok 22 - netdev_features
> > > >     ok 23 - flags
> > > >     ok 24 - errptr
> > > >     ok 25 - fwnode_pointer
> > > > not ok 1 - printf
> > > 
> > > Better, indeed.
> > > 
> > > But can be this improved to have a cumulative statistics, like showing only
> > > number of total, succeeded, failed with details of the latter ones?
> > 
> > Is that the proper test output format?  We have a standard...
> 
> What is the standard, please?

The TAP format should be the standard, no reason the kernel can not spit
out the same test message format that the userspace tests do, right?

thanks,

greg k-h
