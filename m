Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF550741325
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 16:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjF1N7i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 09:59:38 -0400
Received: from bg4.exmail.qq.com ([43.154.54.12]:32819 "EHLO bg4.exmail.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230270AbjF1N7i (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 09:59:38 -0400
X-QQ-mid: bizesmtp81t1687960768txfbx7ok
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 28 Jun 2023 21:59:27 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 3M0okmaRx3gDav7CaNYoc8l+gmSORKcvAWMjW8AYWgV1jU5Cu6ZsaZwBaB68o
        WDWE0r+dSiN0x+n3VgqosM3HGI/3cZAsOnoUeGBXRXE91kEo6cx+oj3gGeAV8AtOiIuFge/
        YH/PQ8SvRi/6iaEuxLVPTi2sEg2H1+3vFa78BrUIxt9mNxf2ZEOdKyGjePmvTMTHm7k4zK9
        xc1A1TFNJ15UKf4YfFJMQJgHStQTDvG+pPE7SqGDp682hXeP7TnY8IbrileQdKVjq+jwlRF
        rEp+YO8Aon5IAJA65PldOBwyY/67znldtuDH1KmC9gLa0mbzqj4ygh35T0HwR3OfwgboAV0
        Rdm1yCF1xLaXgxkesOKe9tXO2qZ38CT+KjHI44uQCWVAZhVlteIZ7IWUddcMG+ZqgC8slOA
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5794258169231260803
From:   Zhangjin Wu <falcon@tinylab.org>
To:     falcon@tinylab.org, thomas@t-8ch.de
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: [PATCH v1 05/17] selftests/nolibc: stat_timestamps: remove procfs dependency
Date:   Wed, 28 Jun 2023 21:59:22 +0800
Message-Id: <20230628135922.97298-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5f80f3dae60f77c6b746578113e56c8fa6454143.1687344643.git.falcon@tinylab.org>
References: <5f80f3dae60f77c6b746578113e56c8fa6454143.1687344643.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas

I'm preparing a revision for this series, in the past days, when I was
working on testing our new 'minimal' kernel config support for all of
the architectures, the time cost (and wait) is really appreciable and the
repeated develop and test is really a big pain, I can also image when you
was working on stack-protector and Willy was working on lots of old
features ;-)

As you explained before, I knew the idea of using '/proc/self' here is
important to not using a fixed-time file, besides our proposed method (make
sure it at least not fail, just skip for !procfs):

    - CASE_TEST(stat_timestamps);   EXPECT_SYSZR(1, test_stat_timestamps()); break;
    + CASE_TEST(stat_timestamps);   EXPECT_SYSZR(proc, test_stat_timestamps()); break;

To further avoid skip it for !procfs (I don't mean relaly disable it for the
default tinyconfig support, which need more discuss, at least provide the
possibility to pass without procfs), do you like this change? it doesn't depend
on 'proc' now.

    -	if (stat("/proc/self/", &st))
    +	if (stat("/proc/self/", &st) && stat("/init", &st) && stat("/", &st))

The "/init" is compiled for 'run' target every time, so, the time stamp should
be dynamic enough, for libc-test, the /proc/self should be always there (if
still not enough, we can reuse the init file list here), the "/" here is only
for the worst-case scene ;-)

Thanks,
Zhangjin

> Since it is not really necessary to use /proc/self here, instead of
> adding a condition check, we use the always existing '/' path instead of
> /proc/self, this eventually let it work without procfs.
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index ebec948ec808..2ef44176f7a9 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -520,7 +520,7 @@ static int test_stat_timestamps(void)
>  	if (sizeof(st.st_atim.tv_sec) != sizeof(st.st_atime))
>  		return 1;
>  
> -	if (stat("/proc/self/", &st))
> +	if (stat("/", &st))
>  		return 1;
>  
>  	if (st.st_atim.tv_sec != st.st_atime || st.st_atim.tv_nsec > 1000000000)
> -- 
> 2.25.1
