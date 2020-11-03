Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227712A4AE0
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Nov 2020 17:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgKCQLu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Nov 2020 11:11:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:39334 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgKCQLu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Nov 2020 11:11:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604419907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=912wLAtwiZtWYV37HC58nqgMqZ/w1BjjSjMt3yAAK5w=;
        b=a1Td+VeGkIiIcno9Dj7Jd2v0kg+qdD3Pt42xSyd6f59CbcdUQHXTc/MrEQLv/OCIZcqnRi
        s091kK1dYeQsDk8ADWSOrSRExIAzzst6x/DZ1sjV3z8PMhj5829zcvgpCmyx52lxbUE5KZ
        a6Uo9j4S4OjGPTX5gPwldtU2W0HANfg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AEADDAD35;
        Tue,  3 Nov 2020 16:11:47 +0000 (UTC)
Date:   Tue, 3 Nov 2020 17:11:47 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Greg KH <gregkh@linuxfoundation.org>
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
Message-ID: <20201103160728.GQ20201@alley>
References: <20201103111049.51916-1-98.arpi@gmail.com>
 <20201103113353.GC4077@smile.fi.intel.com>
 <20201103115223.GA268796@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201103115223.GA268796@kroah.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue 2020-11-03 12:52:23, Greg KH wrote:
> On Tue, Nov 03, 2020 at 01:33:53PM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 03, 2020 at 04:40:49PM +0530, Arpitha Raghunandan wrote:
> > > Convert test lib/test_printf.c to KUnit. More information about
> > > KUnit can be found at:
> > > https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
> > > KUnit provides a common framework for unit tests in the kernel.
> > > KUnit and kselftest are standardizing around KTAP, converting this
> > > test to KUnit makes this test output in KTAP which we are trying to
> > > make the standard test result format for the kernel. More about
> > > the KTAP format can be found at:
> > > https://lore.kernel.org/linux-kselftest/CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com/.
> > > I ran both the original and converted tests as is to produce the
> > > output for success of the test in the two cases. I also ran these
> > > tests with a small modification to show the difference in the output
> > > for failure of the test in both cases. The modification I made is:
> > > - test("127.000.000.001|127.0.0.1", "%pi4|%pI4", &sa.sin_addr, &sa.sin_addr);
> > > + test("127-000.000.001|127.0.0.1", "%pi4|%pI4", &sa.sin_addr, &sa.sin_addr);
> > > 
> > > Original test success:
> > > [    0.540860] test_printf: loaded.
> > > [    0.540863] test_printf: random seed = 0x5c46c33837bc0619
> > > [    0.541022] test_printf: all 388 tests passed
> > > 
> > > Original test failure:
> > > [    0.537980] test_printf: loaded.
> > > [    0.537983] test_printf: random seed = 0x1bc1efd881954afb
> > > [    0.538029] test_printf: vsnprintf(buf, 256, "%pi4|%pI4", ...) wrote '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
> > > [    0.538030] test_printf: kvasprintf(..., "%pi4|%pI4", ...) returned '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
> > > [    0.538124] test_printf: failed 2 out of 388 tests
> > > [    0.538125] test_printf: random seed used was 0x1bc1efd881954afb
> > > 
> > > Converted test success:
> > >     # Subtest: printf
> > >     1..25
> > >     ok 1 - test_basic
> > >     ok 2 - test_number
> > >     ok 3 - test_string
> > >     ok 4 - plain
> > >     ok 5 - null_pointer
> > >     ok 6 - error_pointer
> > >     ok 7 - invalid_pointer
> > >     ok 8 - symbol_ptr
> > >     ok 9 - kernel_ptr
> > >     ok 10 - struct_resource
> > >     ok 11 - addr
> > >     ok 12 - escaped_str
> > >     ok 13 - hex_string
> > >     ok 14 - mac
> > >     ok 15 - ip
> > >     ok 16 - uuid
> > >     ok 17 - dentry
> > >     ok 18 - struct_va_format
> > >     ok 19 - time_and_date
> > >     ok 20 - struct_clk
> > >     ok 21 - bitmap
> > >     ok 22 - netdev_features
> > >     ok 23 - flags
> > >     ok 24 - errptr
> > >     ok 25 - fwnode_pointer
> > > ok 1 - printf
> > > 
> > > Converted test failure:
> > >     # Subtest: printf
> > >     1..25
> > >     ok 1 - test_basic
> > >     ok 2 - test_number
> > >     ok 3 - test_string
> > >     ok 4 - plain
> > >     ok 5 - null_pointer
> > >     ok 6 - error_pointer
> > >     ok 7 - invalid_pointer
> > >     ok 8 - symbol_ptr
> > >     ok 9 - kernel_ptr
> > >     ok 10 - struct_resource
> > >     ok 11 - addr
> > >     ok 12 - escaped_str
> > >     ok 13 - hex_string
> > >     ok 14 - mac
> > >     # ip: EXPECTATION FAILED at lib/printf_kunit.c:82
> > > vsnprintf(buf, 256, "%pi4|%pI4", ...) wrote '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
> > >     # ip: EXPECTATION FAILED at lib/printf_kunit.c:124
> > > kvasprintf(..., "%pi4|%pI4", ...) returned '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
> > >     not ok 15 - ip
> > >     ok 16 - uuid
> > >     ok 17 - dentry
> > >     ok 18 - struct_va_format
> > >     ok 19 - time_and_date
> > >     ok 20 - struct_clk
> > >     ok 21 - bitmap
> > >     ok 22 - netdev_features
> > >     ok 23 - flags
> > >     ok 24 - errptr
> > >     ok 25 - fwnode_pointer
> > > not ok 1 - printf
> > 
> > Better, indeed.
> > 
> > But can be this improved to have a cumulative statistics, like showing only
> > number of total, succeeded, failed with details of the latter ones?
> 
> Is that the proper test output format?  We have a standard...

What is the standard, please?

The original module produced:

[   48.577739] test_printf: loaded.
[   48.578046] test_printf: all 388 tests passed

It comes from KSTM_MODULE_LOADERS() macro that has been created
by the commit eebf4dd452377921e3a26 ("kselftest: Add test module
framework header"). There are 3 users:

$> git grep KSTM_MODULE_LOADERS
Documentation/dev-tools/kselftest.rst:   KSTM_MODULE_LOADERS(test_foo);
lib/test_bitmap.c:KSTM_MODULE_LOADERS(test_bitmap);
lib/test_printf.c:KSTM_MODULE_LOADERS(test_printf);
lib/test_strscpy.c:KSTM_MODULE_LOADERS(test_strscpy);
tools/testing/selftests/kselftest_module.h:#define KSTM_MODULE_LOADERS(__module)                        \


When I looked for similar strings then I see huge creativity:

drivers/firmware/psci/psci_checker.c:           pr_info("Hotplug tests passed OK\n");
drivers/firmware/psci/psci_checker.c:           pr_info("Suspend tests passed OK\n");
drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:            seq_printf(m, "ib ring tests passed.\n");
drivers/mtd/chips/jedec_probe.c:        /* all tests passed - mark  as success */
drivers/usb/host/xhci-mem.c:    xhci_dbg(xhci, "TRB math tests passed.\n");
fs/unicode/utf8-selftest.c:             pr_info("All %u tests passed\n", total_tests);
kernel/kcsan/selftest.c:        pr_info("selftest: %d/%d tests passed\n", passed, total);
lib/crc32test.c:                pr_info("crc32c: self tests passed, processed %d bytes in %lld nsec\n",
lib/crc32test.c:                pr_info("crc32c_combine: %d self tests passed\n", runs);
lib/crc32test.c:                pr_info("crc32: self tests passed, processed %d bytes in %lld nsec\n",
lib/crc32test.c:                pr_info("crc32_combine: %d self tests passed\n", runs);
lib/globtest.c:         KERN_INFO "glob: %u self-tests passed, %u failed\n";
lib/random32.c:         pr_info("prandom: %d self tests passed\n", runs);
lib/test_hash.c:        pr_notice("%u tests passed.", tests);
lib/test_hexdump.c:             pr_info("all %u tests passed\n", total_tests);
lib/test_ida.c: printk("IDA: %u of %u tests passed\n", tests_passed, tests_run);
lib/test_meminit.c:             pr_info("all %d tests passed!\n", num_tests);
lib/test_overflow.c:            pr_info("all tests passed\n");
lib/test_stackinit.c:           pr_info("all tests passed!\n");
lib/test_user_copy.c:           pr_info("tests passed.\n");
lib/test_uuid.c:                pr_info("all %u tests passed\n", total_tests);
lib/test_xarray.c:      printk("XArray: %u of %u tests passed\n", tests_passed, tests_run);
tools/bootconfig/test-bootconfig.sh:    echo "All tests passed"
Binary file tools/testing/kunit/test_data/test_is_test_passed-all_passed.log matches
Binary file tools/testing/kunit/test_data/test_is_test_passed-crash.log matches
Binary file tools/testing/kunit/test_data/test_is_test_passed-failure.log matches
Binary file tools/testing/kunit/test_data/test_output_isolated_correctly.log matches
tools/testing/selftests/bpf/test_tc_tunnel.sh:  echo "OK. All tests passed"
tools/testing/selftests/bpf/test_xdping.sh:echo "OK. All tests passed"
tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c:     printf("Ioctl compatibility tests passed\n");
tools/testing/selftests/kselftest_harness.h:    ksft_print_msg("%s: %u / %u tests passed.\n", ret ? "FAILED" : "PASSED",
tools/testing/selftests/kselftest_module.h:             pr_info("all %u tests passed\n", total_tests);
tools/testing/selftests/net/ipv6_flowlabel.sh:echo OK. All tests passed
tools/testing/selftests/net/msg_zerocopy.sh:    echo "OK. All tests passed"
tools/testing/selftests/net/psock_fanout.c:     printf("OK. All tests passed\n");
tools/testing/selftests/net/psock_snd.sh:echo "OK. All tests passed"
tools/testing/selftests/net/psock_tpacket.c:    printf("OK. All tests passed\n");
tools/testing/selftests/net/so_txtime.sh:echo OK. All tests passed
tools/testing/selftests/net/txtimestamp.sh:     echo "OK. All tests passed"



From my POV, KUnit is a framework that is supposed to actually
unify many tests.

There is alternative framework maintained by Shuah Khan. In compare
with KUnit, it prints the results in the userspace. The format
is quite similar, for example:

tools/testing/selftests/livepatch/# make run_tests
TAP version 13
1..5
# selftests: livepatch: test-livepatch.sh
# TEST: basic function patching ... ok
# TEST: multiple livepatches ... ok
# TEST: atomic replace livepatch ... ok
ok 1 selftests: livepatch: test-livepatch.sh
# selftests: livepatch: test-callbacks.sh
# TEST: target module before livepatch ... ok
# TEST: module_coming notifier ... ok
# TEST: module_going notifier ... ok
# TEST: module_coming and module_going notifiers ... ok
# TEST: target module not present ... ok
# TEST: pre-patch callback -ENODEV ... ok
# TEST: module_coming + pre-patch callback -ENODEV ... ok
# TEST: multiple target modules ... ok
# TEST: busy target module ... ok
# TEST: multiple livepatches ... ok
# TEST: atomic replace ... ok
ok 2 selftests: livepatch: test-callbacks.sh
# selftests: livepatch: test-shadow-vars.sh
# TEST: basic shadow variable API ... ok
ok 3 selftests: livepatch: test-shadow-vars.sh
# selftests: livepatch: test-state.sh
# TEST: system state modification ... ok
# TEST: taking over system state modification ... ok
# TEST: compatible cumulative livepatches ... ok
# TEST: incompatible cumulative livepatches ... ok
ok 4 selftests: livepatch: test-state.sh
# selftests: livepatch: test-ftrace.sh
# TEST: livepatch interaction with ftrace_enabled sysctl ... ok
ok 5 selftests: livepatch: test-ftrace.sh


I do not have strong meaning what format is better. But the format:

    "doing something ... ok"

is problematic in kernel log because it contains messages
from all kernel activity. As a result, many unrelated messages might
be added between "doing something ..." and "ok". It is much
more reliable with stdout/stderr in userspace.

For kernel, it is more reliable to print results when the test
finishes. And it seems to be "easy" to spot an error in KUnit
report.


That said, it would be nice to see some summary on the very last line.
It would be especially useful when the log is longer than one screen.

The result of every subtest might help to locate the problem when
the system freezes. It might be optional.

I am personally fine with the proposed output of printf_kunit.c.

Best Regards,
Petr
