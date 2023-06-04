Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375A6721536
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jun 2023 08:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjFDGqT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Jun 2023 02:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDGqS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Jun 2023 02:46:18 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67573CA;
        Sat,  3 Jun 2023 23:46:16 -0700 (PDT)
Date:   Sun, 4 Jun 2023 08:46:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1685861173; bh=Ne4F0pnUd4nHoSVuh0eJZuKjfE4h0WV37TMERYI1N3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oe8G5rESwI18KpMmkO7slyOr3AHLTgxLR2xACVrWtQMVLH0jPVK8v/w/SQ9xq5HXG
         V5hoBazXNS4NwwFruXI0rJCdtrUUY1g/r2CDLIOT5CK2W8BLie7kJWr3lDvqo2jQGV
         BRnIo3qb1YvEO4UjH/W5VCwxOA9ZFKqNwtMy4KK0=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 11/12] selftests/nolibc: add new gettimeofday test
 cases
Message-ID: <2fccaff5-2354-4ac0-8389-1004d47d8dc9@t-8ch.de>
References: <cover.1685777982.git.falcon@tinylab.org>
 <68dace9e2532316ff454894697ecfd99e419a523.1685777982.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68dace9e2532316ff454894697ecfd99e419a523.1685777982.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-06-03 16:16:07+0800, Zhangjin Wu wrote:
> These 2 test cases are added to cover the normal using scenes of
> gettimeofday().
> 
> They have been used to trigger and fix up such issue with nolibc:
> 
>     nolibc-test.c:(.text.gettimeofday+0x54): undefined reference to `__aeabi_ldivmod'
> 
> This issue happens while there is no "unsigned int" conversion in the
> coming new clock_gettime / clock_gettime64 syscall path of
> gettimeofday():
> 
>     tv->tv_usec = ts.tv_nsec / 1000;

As mentioned before this looks to me like an issue in the build setup.
Could you provide reproduction steps?

Nevertheless I guess the tests themselves are fine to have.

> Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
> Link: https://lore.kernel.org/linux-riscv/280867a8-7601-4a96-9b85-87668e1f1282@t-8ch.de/
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index bf63fc66e486..e68c5692ec54 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -533,6 +533,8 @@ static int test_stat_timestamps(void)
>   */
>  int run_syscall(int min, int max)
>  {
> +	struct timeval tv;
> +	struct timezone tz;
>  	struct stat stat_buf;
>  	int euid0;
>  	int proc;
> @@ -588,6 +590,8 @@ int run_syscall(int min, int max)
>  		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
>  		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;
>  		CASE_TEST(gettimeofday_null); EXPECT_SYSZR(1, gettimeofday(NULL, NULL)); break;
> +		CASE_TEST(gettimeofday_tv);   EXPECT_SYSZR(1, gettimeofday(&tv, NULL)); break;
> +		CASE_TEST(gettimeofday_tv_tz);EXPECT_SYSZR(1, gettimeofday(&tv, &tz)); break;
>  		CASE_TEST(getpagesize);       EXPECT_SYSZR(1, test_getpagesize()); break;
>  		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
>  		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
> -- 
> 2.25.1
> 
