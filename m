Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E12142C8F
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2019 18:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438193AbfFLQpJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jun 2019 12:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438189AbfFLQpJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jun 2019 12:45:09 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FCD2208C2;
        Wed, 12 Jun 2019 16:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560357908;
        bh=77vakB6qo+hE7HfaddElys4psa6K+2Nt+ndsTMsIUF0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=id6pePVeFhlcHqOEy/6CxcrM6u3JpOWGrFSVkg5MfGfAkjmQgL5BNaaBPoSA6whMq
         XPv2JhpRLlprohFzXjiJg1C+/KiA0Ftoc02xeriQjIc2X9Q/VDTywfc8QX7R68t/iC
         37c4JJhWPqMfOWJZeJ4ORTXNKYrD1aQ/I5X/LpcU=
Subject: Re: kselftest build broken?
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     linux-kselftest@vger.kernel.org, shuah <shuah@kernel.org>
References: <CACT4Y+Z4naaxx4N2B2t1hn4A99dfk=6yTY2yAZM=aJ05VCPLFQ@mail.gmail.com>
 <54bc80f8-71aa-1c04-5908-01923247832e@kernel.org>
 <CACT4Y+YUBw=t3CkbLeKLFAeAbzVZXoG09HARR+nsOTW4gkdLOw@mail.gmail.com>
 <6d5e0484-4dbc-d122-1ae4-9cce44c2d668@kernel.org>
 <CACT4Y+aE841JzvEVFmAevgmBO0eOssz0MFydWiuoAp18nr=_DA@mail.gmail.com>
 <CACT4Y+abfa9xVg+3S_tgpOA3cZ2bexe51d0FEZyBCGn0M-6DiA@mail.gmail.com>
 <CACT4Y+aiDUV4_JrvKct98mKvPwEQXSZFXae3qweSmotpzCAGTw@mail.gmail.com>
 <CACT4Y+a8zK7st7LUTkD=AaUBZGsn5hqLt5NXHHvJ0dg1Jds6Nw@mail.gmail.com>
 <CACT4Y+YKf3BFi-9J7Ag0yPtEWYrsPZXY1qUw21yRkNYu51wBWg@mail.gmail.com>
 <CACT4Y+bfz2F-p4xODb_=rU0+F-FJCC66MJW7q9DXd0UHoUfgwg@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <1e2cc74d-a6c2-0a73-ede5-c72df28e96b2@kernel.org>
Date:   Wed, 12 Jun 2019 10:44:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bfz2F-p4xODb_=rU0+F-FJCC66MJW7q9DXd0UHoUfgwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> >> I've deleted the test that caused reboot for now and the
> run_kselftest.sh script finished running, but I can't understand the
> result. Is it all passed? Or something failed? What failed?
> The output is as follows:
> 
> ... screens of output ...
> # make swap with zram device(s)
> [ 5335.215175] Adding 1020k swap on /dev/zram0.  Priority:-2 extents:1
> across:1020k SSFS
> # done with /dev/zram0
> # zram making zram mkswap and swapon: OK
> # zram swapoff: OK
> # zram cleanup
> [ 5335.420825] zram0: detected capacity change from 1048576 to 0
> # zram02 : [PASS]
> ok 1 selftests: zram: zram.sh
> ~/kselftest#
> 
Hi Dmitry,

This is the 6th email from you in a span of 3 hours! I am just going to
respond this last one. Please try to summarize your questions instead of
sending email storm, so it will be easier to parse and more productive
for both of us.

I am not sure what you are asking here. kselftest has bunch of tests,
and you have to look at individual test results to see if they passed
or failed. If you are looking for aggregate result, ksefltest doesn't
keep track of that.

> 
> docs say:
> 
> "The above commands by default run the tests and print full pass/fail report.
> Kselftest supports "summary" option to make it easier to understand the test
> results....
>    $ make summary=1 kselftest
> "
>
If you want to build and run tests on the same test system use
the following commands, after building kernel and rebooting the newly
installed kernel:

make kselftest or make -C tools/testing/selftests run_tests

If you want to just build and install to default location run:
make -C tools/testing/selftests install
This installs under tools/testing/selftests/install and creates
run_kselftest.sh

You can specify INSTALL_PATH as follows:

export INSTALL_PATH=/tmp/kselftest;
make -C tools/testing/selftest/install

I am seeing an error

/bin/sh: 1: llvm-readelf: not found
make[1]: *** No rule to make target 'emit_tests'.  Stop.
chmod u+x /tmp/kselftest/run_kselftest.sh

in both of the above. Something broke and I will look into it.
This doesn't break the install and run_kselftest.sh generation

About summary option:

make  -C tools/testing/selftests/ summary=1 install
probably should generate summary from emit_tests target, but I am
not sure if it is working.

thanks,
-- Shuah
