Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362AB5F8BF2
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Oct 2022 17:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiJIPTa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 9 Oct 2022 11:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiJIPT3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 9 Oct 2022 11:19:29 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AED5B2A973;
        Sun,  9 Oct 2022 08:19:26 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 299FJ5YN028180;
        Sun, 9 Oct 2022 17:19:05 +0200
Date:   Sun, 9 Oct 2022 17:19:05 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     lkp@lists.01.org, lkp@intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [selftests/nolibc] 362aecb2d8: kernel-selftests.nolibc.make_fail
Message-ID: <20221009151905.GA28148@1wt.eu>
References: <202210081618.754a77db-yujie.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210081618.754a77db-yujie.liu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Sat, Oct 08, 2022 at 04:57:43PM +0800, kernel test robot wrote:
(...)
> 2022-10-02 10:04:53 make TARGETS=nolibc
> make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-362aecb2d8cfad0268d6c0ae5f448e9b6eee7ffb/tools/testing/selftests/nolibc'
>   CC      nolibc-test
> /usr/bin/ld: /tmp/cccOWbdp.o: in function `printf':
> nolibc-test.c:(.text+0x369): undefined reference to `strlen'
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:31: nolibc-test] Error 1
> make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-362aecb2d8cfad0268d6c0ae5f448e9b6eee7ffb/tools/testing/selftests/nolibc'
> make: *** [Makefile:155: all] Error 2
> 2022-10-02 10:04:53 make -C nolibc
> make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-362aecb2d8cfad0268d6c0ae5f448e9b6eee7ffb/tools/testing/selftests/nolibc'
>   CC      nolibc-test
> /usr/bin/ld: /tmp/lkp/ccP4fovP.o: in function `printf':
> nolibc-test.c:(.text+0x369): undefined reference to `strlen'
> collect2: error: ld returned 1 exit status
> make: *** [Makefile:31: nolibc-test] Error 1
> make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-362aecb2d8cfad0268d6c0ae5f448e9b6eee7ffb/tools/testing/selftests/nolibc'
> 2022-10-02 10:04:54 make quicktest=1 run_tests -C nolibc
> make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-362aecb2d8cfad0268d6c0ae5f448e9b6eee7ffb/tools/testing/selftests/nolibc'
> make: *** No rule to make target 'run_tests'.  Stop.
> make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-362aecb2d8cfad0268d6c0ae5f448e9b6eee7ffb/tools/testing/selftests/nolibc'
> 
> 
> This error only happens when build with gcc-12, while gcc-11 and gcc-9
> build fine. We are not sure whether this is a compiler issue or a kernel
> code issue, so we send this report FYI. Below link may be helpful for
> analysis:
> 
> https://www.spinics.net/lists/fedora-devel/msg296395.html
(...)

Many thanks for the detailed report and hints. Since we're only providing
include files we don't always have the luxury of enforcing build options
on the caller, so it took me quite some trial and error but I finally
found a way around it. I'm sending a updated patch to Paul for merging.

Thanks again,
Willy
