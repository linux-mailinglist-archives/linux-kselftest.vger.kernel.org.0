Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C4E7D5019
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 14:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjJXMnM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 08:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjJXMnL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 08:43:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 411E9133;
        Tue, 24 Oct 2023 05:43:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 188B92F4;
        Tue, 24 Oct 2023 05:43:50 -0700 (PDT)
Received: from [10.57.5.116] (unknown [10.57.5.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 309D03F64C;
        Tue, 24 Oct 2023 05:43:08 -0700 (PDT)
Message-ID: <7161219e-0223-d699-d6f3-81abd9abf13b@arm.com>
Date:   Tue, 24 Oct 2023 13:43:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/4] selftests: core: remove duplicate defines
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org
References: <20231006100743.1631334-1-usama.anjum@collabora.com>
 <20231006100743.1631334-3-usama.anjum@collabora.com>
From:   Aishwarya TCV <aishwarya.tcv@arm.com>
In-Reply-To: <20231006100743.1631334-3-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 06/10/2023 11:07, Muhammad Usama Anjum wrote:
> Remove duplicate defines which are already defined in kernel headers and
> re-definition isn't required.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---

Hi Muhammad,

Currently when building kselftest against next-master with arm64 arch
and defconfig+kselftest  “error: 'CLOSE_RANGE_UNSHARE' undeclared (first
use in this function)” is observed.

The bisect log is below and a full log from a failing test job can be
seen here:

https://storage.kernelci.org/next/master/next-20231023/arm64/defconfig+kselftest/gcc-10/logs/kselftest.log

close_range_test.c: In function 'close_range_unshare':
close_range_test.c:111:11: error: 'CLOSE_RANGE_UNSHARE' undeclared
(first use in this function)
  111 |           CLOSE_RANGE_UNSHARE);
      |           ^~~~~~~~~~~~~~~~~~~
close_range_test.c:111:11: note: each undeclared identifier is reported
only once for each function it appears in
close_range_test.c: In function 'close_range_unshare_capped':
close_range_test.c:200:11: error: 'CLOSE_RANGE_UNSHARE' undeclared
(first use in this function)
  200 |           CLOSE_RANGE_UNSHARE);
      |           ^~~~~~~~~~~~~~~~~~~
close_range_test.c: In function 'close_range_cloexec':
close_range_test.c:234:36: error: 'CLOSE_RANGE_CLOEXEC' undeclared
(first use in this function)
  234 |  ret = sys_close_range(1000, 1000, CLOSE_RANGE_CLOEXEC);
      |                                    ^~~~~~~~~~~~~~~~~~~
close_range_test.c: In function 'close_range_cloexec_unshare':
close_range_test.c:302:36: error: 'CLOSE_RANGE_CLOEXEC' undeclared
(first use in this function)
  302 |  ret = sys_close_range(1000, 1000, CLOSE_RANGE_CLOEXEC);
      |                                    ^~~~~~~~~~~~~~~~~~~
close_range_test.c:317:32: error: 'CLOSE_RANGE_UNSHARE' undeclared
(first use in this function)
  317 |          CLOSE_RANGE_CLOEXEC | CLOSE_RANGE_UNSHARE);
      |                                ^~~~~~~~~~~~~~~~~~~
close_range_test.c: In function 'close_range_cloexec_syzbot':
close_range_test.c:378:33: error: 'CLOSE_RANGE_CLOEXEC' undeclared
(first use in this function)
  378 |   ret = sys_close_range(3, ~0U, CLOSE_RANGE_CLOEXEC);
      |                                 ^~~~~~~~~~~~~~~~~~~
close_range_test.c: In function 'close_range_cloexec_unshare_syzbot':
close_range_test.c:472:34: error: 'CLOSE_RANGE_UNSHARE' undeclared
(first use in this function)
  472 |    ret = sys_close_range(3, ~0U, CLOSE_RANGE_UNSHARE |
      |                                  ^~~~~~~~~~~~~~~~~~~
close_range_test.c:473:13: error: 'CLOSE_RANGE_CLOEXEC' undeclared
(first use in this function)
  473 |             CLOSE_RANGE_CLOEXEC);
      |             ^~~~~~~~~~~~~~~~~~~
make[4]: *** [../lib.mk:181:
/tmp/kci/linux/build/kselftest/core/close_range_test] Error 1


git bisect log
git bisect start
# good: [58720809f52779dc0f08e53e54b014209d13eebb] Linux 6.6-rc6
git bisect good 58720809f52779dc0f08e53e54b014209d13eebb
# bad: [2030579113a1b1b5bfd7ff24c0852847836d8fd1] Add linux-next
specific files for 20231020
git bisect bad 2030579113a1b1b5bfd7ff24c0852847836d8fd1
# good: [aa531ca5bb35637b6d235df5feba57ed94d3a462] Merge branch
'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
git bisect good aa531ca5bb35637b6d235df5feba57ed94d3a462
# good: [37a9b505514f0ed4447757452f1e39d3a373df59] Merge branch
'for-next' of
https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git
git bisect good 37a9b505514f0ed4447757452f1e39d3a373df59
# good: [695ee55348f6c3c7ec5f953ab297b4db9501962b] Merge branch
'for-next' of
git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
git bisect good 695ee55348f6c3c7ec5f953ab297b4db9501962b
# skip: [150dc54505f3395010784d2a5c8b2e0e9b2b2f37] Merge branch
'counter-next' of
git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git
git bisect skip 150dc54505f3395010784d2a5c8b2e0e9b2b2f37
# good: [bae023765199bef243b49c0f8860a3290a5c9f6d] staging: iio:
resolver: ad2s1210: implement hysteresis as channel attr
git bisect good bae023765199bef243b49c0f8860a3290a5c9f6d
# good: [337c88ee5fb65f9c34ca7bb129915cb59de687b3] Merge branch 'next'
of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
git bisect good 337c88ee5fb65f9c34ca7bb129915cb59de687b3
# good: [248f0927e11e09e6285383938b5c4b87079ee5a7] Merge branch
'for-next' of
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
git bisect good 248f0927e11e09e6285383938b5c4b87079ee5a7
# bad: [3e2f5dfe32e1a8fbd034b1060bd30b9b1179b4c7] Merge branch
'rtc-next' of
git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git
git bisect bad 3e2f5dfe32e1a8fbd034b1060bd30b9b1179b4c7
# bad: [1f6421f11948d0de9216b8f1c439c21dbc90da91] Merge branch 'next' of
git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
git bisect bad 1f6421f11948d0de9216b8f1c439c21dbc90da91
# bad: [34dce23f7e405ffb4eca04e83ee10c03a4cffb9b] selftests/clone3:
Report descriptive test names
git bisect bad 34dce23f7e405ffb4eca04e83ee10c03a4cffb9b
# bad: [d3772e7badd2cd3813e2efba0034f6e39aecc97f] selftests/mm:
Substitute attribute with a macro
git bisect bad d3772e7badd2cd3813e2efba0034f6e39aecc97f
# good: [071af0c9e582bc47e379e39490a2bc1adfe4ec68] selftests: timers:
Convert posix_timers test to generate KTAP output
git bisect good 071af0c9e582bc47e379e39490a2bc1adfe4ec68
# bad: [2531f374f922e77ba51f24d1aa6fa11c7f4c36b8] Documentation:
kselftests: Remove references to bpf tests
git bisect bad 2531f374f922e77ba51f24d1aa6fa11c7f4c36b8
# good: [44eebacd6b8f633eb3a38a6db093658636b844e8] selftests: clone3:
remove duplicate defines
git bisect good 44eebacd6b8f633eb3a38a6db093658636b844e8
# bad: [ec54424923cf943b51dd5bf75fcbe27b0ca2c6ef] selftests: core:
remove duplicate defines
git bisect bad ec54424923cf943b51dd5bf75fcbe27b0ca2c6ef
# first bad commit: [ec54424923cf943b51dd5bf75fcbe27b0ca2c6ef]
selftests: core: remove duplicate defines

Thanks,
Aishwarya
