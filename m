Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928E324D41C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Aug 2020 13:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgHULha (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Aug 2020 07:37:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:38010 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbgHULhX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Aug 2020 07:37:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7F617B800;
        Fri, 21 Aug 2020 11:37:39 +0000 (UTC)
Date:   Fri, 21 Aug 2020 13:37:10 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>, brendanhiggins@google.com,
        skhan@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] lib: Convert test_printf.c to KUnit
Message-ID: <20200821113710.GA26290@alley>
References: <20200817043028.76502-1-98.arpi@gmail.com>
 <f408efbd-10f7-f1dd-9baa-0f1233cafffc@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f408efbd-10f7-f1dd-9baa-0f1233cafffc@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon 2020-08-17 09:06:32, Rasmus Villemoes wrote:
> On 17/08/2020 06.30, Arpitha Raghunandan wrote:
> > Converts test lib/test_printf.c to KUnit.
> > More information about KUnit can be found at
> > https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
> > KUnit provides a common framework for unit tests in the kernel.
> 
> So I can continue to build a kernel with some appropriate CONFIG set to
> y, boot it under virt-me, run dmesg and see if I broke printf? That's
> what I do now, and I don't want to have to start using some enterprisy
> framework.

I had the same concern. I have tried it. It compiled a module called
printf_kunit.c.

    #> modprobe printf_kunit

produced the following in dmesg:

[   60.931175] printf_kunit: module verification failed: signature and/or required key missing - tainting kernel
[   60.942209] TAP version 14
[   60.945197]     # Subtest: printf-kunit-test
[   60.945200]     1..1
[   60.951092]     ok 1 - selftest
[   60.953414] ok 1 - printf-kunit-test

I could live with the above. Then I tried to break a test by the following change:


diff --git a/lib/printf_kunit.c b/lib/printf_kunit.c
index 68ac5f9b8d28..1689dadd70a3 100644
--- a/lib/printf_kunit.c
+++ b/lib/printf_kunit.c
@@ -395,7 +395,7 @@ ip4(struct kunit *kunittest)
        sa.sin_port = cpu_to_be16(12345);
        sa.sin_addr.s_addr = cpu_to_be32(0x7f000001);
 
-       test(kunittest, "127.000.000.001|127.0.0.1", "%pi4|%pI4", &sa.sin_addr, &sa.sin_addr);
+       test(kunittest, "127-000.000.001|127.0.0.1", "%pi4|%pI4", &sa.sin_addr, &sa.sin_addr);
        test(kunittest, "127.000.000.001|127.0.0.1", "%piS|%pIS", &sa, &sa);
        sa.sin_addr.s_addr = cpu_to_be32(0x01020304);
        test(kunittest, "001.002.003.004:12345|1.2.3.4:12345", "%piSp|%pISp", &sa, &sa);


It produced::

[   56.786858] TAP version 14
[   56.787493]     # Subtest: printf-kunit-test
[   56.787494]     1..1
[   56.788612]     # selftest: EXPECTATION FAILED at lib/printf_kunit.c:76
                   Expected memcmp(test_buffer, expect, written) == 0, but
                       memcmp(test_buffer, expect, written) == 1
                       0 == 0
               vsnprintf(buf, 256, "%pi4|%pI4", ...) wrote '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
[   56.795433]     # selftest: EXPECTATION FAILED at lib/printf_kunit.c:76
                   Expected memcmp(test_buffer, expect, written) == 0, but
                       memcmp(test_buffer, expect, written) == 1
                       0 == 0
               vsnprintf(buf, 20, "%pi4|%pI4", ...) wrote '127.000.000.001|127', expected '127-000.000.001|127'
[   56.800909]     # selftest: EXPECTATION FAILED at lib/printf_kunit.c:108
                   Expected memcmp(p, expect, elen+1) == 0, but
                       memcmp(p, expect, elen+1) == 1
                       0 == 0
               kvasprintf(..., "%pi4|%pI4", ...) returned '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
[   56.806497]     not ok 1 - selftest
[   56.806497] not ok 1 - printf-kunit-test

while the original code would have written the following error messages:

[   95.859225] test_printf: loaded.
[   95.860031] test_printf: vsnprintf(buf, 256, "%pi4|%pI4", ...) wrote '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
[   95.862630] test_printf: vsnprintf(buf, 6, "%pi4|%pI4", ...) wrote '127.0', expected '127-0'
[   95.864118] test_printf: kvasprintf(..., "%pi4|%pI4", ...) returned '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
[   95.866589] test_printf: failed 3 out of 388 tests


Even the error output is acceptable for me. I am just curious why
the 2nd failure is different:

   + original code: vsnprintf(buf, 6, "%pi4|%pI4", ...) wrote '127.0', expected '127-0'
   + kunit code: vsnprintf(buf, 20, "%pi4|%pI4", ...) wrote '127.000.000.001|127', expected '127-000.000.001|127'   


I am also a bit scared by the following note at
https://www.kernel.org/doc/html/latest/dev-tools/kunit/start.html#running-tests-without-the-kunit-wrapper

   "KUnit is not designed for use in a production system, and it’s
   possible that tests may reduce the stability or security of the
   system."

What does it mean thay it might reduce stability or security?
Is it because the tests might cause problems?
Or because the kunit framework modifies functionality of the running
system all the time?


Best Regards,
Petr

PS: I still have to look at the code. Anwyay, the comments from Rasmus make
sense.
