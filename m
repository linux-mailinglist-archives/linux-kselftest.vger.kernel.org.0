Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A726768A4
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 21:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjAUUAl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 Jan 2023 15:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAUUAk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 Jan 2023 15:00:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FCC2197A;
        Sat, 21 Jan 2023 12:00:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26970601D4;
        Sat, 21 Jan 2023 20:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7175BC433EF;
        Sat, 21 Jan 2023 20:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674331238;
        bh=DpNSj+Nkw2FwX9r2GBevLWYvOlz7CprD9piaazEpfL0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YQh8aVXCLHjm0wmGhzQ9wZEMKj6kcervjMD22E/VaQ0u4SMEeiRWOGkBxaPXXWJH0
         hzzG0oGSgf9vSu4vmyX5t82SCKxl+BY1Y8ekNXohFQsKlwho5pCDaSLhBSKB/I5xe9
         NndJjnQJ9c/dsPER9763J2I+WiPbQfgJHhT0+hyIUBxOuJVGggsvooaNLHwu47pKsq
         0pWbPoo2hdgMMxv+6k4CvcEOvmgn7qtO7zH7sYKJ0JCEFRI/+k97BOsf9z6gNYpKvP
         0U6iq05isnEZpFcfxsg5jyKVnQOnfTCeUNbbjkkS9B/VCWZ9+brsmzVdb9bVR7bG8w
         DPRReGS1lpsEg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 12B2B5C06AB; Sat, 21 Jan 2023 12:00:38 -0800 (PST)
Date:   Sat, 21 Jan 2023 12:00:38 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH 0/2] selftests/nolibc: small simplification of test
 development phase
Message-ID: <20230121200038.GG2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230121085320.11712-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121085320.11712-1-w@1wt.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jan 21, 2023 at 09:53:18AM +0100, Willy Tarreau wrote:
> Hello Paul,
> 
> while developing and testing the recent changes for errno/environ/auxv, I
> found that I wasn't relying on the kernel that much and that I was mostly
> using qemu in userland only with my local kernel.
> 
> I figured that it was more convenient for this purpose than rebuilding an
> initramfs and kernel for a quick test, and decided to make this approach
> easier to use for everyone by adding a "run-user" target to the Makefile
> to do exactly this. E.g:
> 
> Native build:
>   $ time make -C tools/testing/selftests/nolibc run-user
>   ...
>   make: Entering directory '/g/public/linux/master/tools/testing/selftests/nolibc'
>     MKDIR   sysroot/x86/include
>   make[1]: Entering directory '/g/public/linux/master/tools/include/nolibc'
>   make[2]: Entering directory '/g/public/linux/master'
>   make[2]: Leaving directory '/g/public/linux/master'
>   make[2]: Entering directory '/g/public/linux/master'
>     INSTALL /g/public/linux/master/tools/testing/selftests/nolibc/sysroot/sysroot/include
>   make[2]: Leaving directory '/g/public/linux/master'
>   make[1]: Leaving directory '/g/public/linux/master/tools/include/nolibc'
>     CC      nolibc-test
>   18 chroot_root = -1 EPERM               [FAIL]
>   43 link_dir = -1 EACCES  != (-1 EPERM)  [FAIL]
>   See all results in /g/public/linux/master/tools/testing/selftests/nolibc/run.out
>   make: Leaving directory '/g/public/linux/master/tools/testing/selftests/nolibc'
> 
>   real    0m0.966s
>   user    0m0.731s
>   sys     0m0.164s
> 
> Cross build:
>   $ time make -C tools/testing/selftests/nolibc run-user ARCH=s390 CROSS_COMPILE=/f/tc/nolibc/gcc-11.3.0-nolibc/s390-linux/bin/s390-linux-
>   make: Entering directory '/g/public/linux/master/tools/testing/selftests/nolibc'
>     MKDIR   sysroot/s390/include
>   make[1]: Entering directory '/g/public/linux/master/tools/include/nolibc'
>   make[2]: Entering directory '/g/public/linux/master'
>   make[2]: Leaving directory '/g/public/linux/master'
>   make[2]: Entering directory '/g/public/linux/master'
>     INSTALL /g/public/linux/master/tools/testing/selftests/nolibc/sysroot/sysroot/include
>   make[2]: Leaving directory '/g/public/linux/master'
>   make[1]: Leaving directory '/g/public/linux/master/tools/include/nolibc'
>     CC      nolibc-test
>   18 chroot_root = -1 EPERM               [FAIL]
>   43 link_dir = -1 EACCES  != (-1 EPERM)  [FAIL]
>   See all results in /g/public/linux/master/tools/testing/selftests/nolibc/run.out
>   make: Leaving directory '/g/public/linux/master/tools/testing/selftests/nolibc'
> 
>   real    0m1.014s
>   user    0m0.732s
>   sys     0m0.183s
> 
> In addition, the "x86_64" value for ARCH= is now supported as I got caught
> too many times with it not working in this subdir while it's used for the
> rest of the kernel ("x86" is used instead as coming from subarch.include).
> Generally you don't type it as x86_64 probably is the native build for most
> users, but when you start to test toolchains it's a different thing.
> 
> There's no matter of urgency for these patches, they're just a bit of
> user-friendly stuff. As such, if you're fine with stacking them on top of
> what you already have for 6.3, that will be great, otherwise they can
> easily wait.
> 
> Thank you!
> Willy

Nice, thank you!

I have these placed on top of the -rcu "dev" branch initially for further
review and testing.  If things go well over the next week or so, I will
set it up for the upcoming merge window.

One dependency is of course qemu-x86_64, so in the meantime I will figure
out where I get that from.  ;-)

							Thanx, Paul

> [CCing Ammar who could benefit from this]
> 
> ---
> Willy Tarreau (2):
>   selftests/nolibc: support "x86_64" for arch name
>   selftests/nolibc: add a "run-user" target to test the program in user
>     land
> 
>  tools/testing/selftests/nolibc/Makefile | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> -- 
> 2.17.5
> 
