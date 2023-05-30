Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26482715E06
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 13:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjE3Lzk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 07:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjE3Lzj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 07:55:39 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5578136;
        Tue, 30 May 2023 04:55:07 -0700 (PDT)
Date:   Tue, 30 May 2023 13:54:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1685447694; bh=UqHfY6pvD8b+bFqIKuJqQan4Cce1GKY1FGquG94I2d8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UZ7h5OhG3eoXlkYDEJRYfcVV84YDwXc1DiJBuT0uBabLN9aUHzG1GaBZ9zere+3Sd
         ugJ/BrTBkFDh+HDDLZ03XqEzFpiSS/1EcczCUtZU6skb1NUDXr7f2qXTzbNQ6s5s0C
         ReUYthiWCB4vip0x8eeppr1XjDDiRz/EB5Pfqjl4=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        w@1wt.eu
Subject: Re: [PATCH 1/2] selftests/nolibc: add new gettimeofday test cases
Message-ID: <48f6986e-cefb-49f5-bbbb-a029d5397017@t-8ch.de>
References: <96f1134d-ce6e-4d82-ae00-1cd4038809c4@t-8ch.de>
 <20230530112806.404017-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530112806.404017-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-05-30 19:28:06+0800, Zhangjin Wu wrote:
> > On 2023-05-30 14:37:49+0800, Zhangjin Wu wrote:
> > > These 3 test cases are added to cover the normal using scenes of
> > > gettimeofday().
> > > 
> > > They have been used to trigger and fix up such issue:
> > > 
> > >     nolibc-test.c:(.text.gettimeofday+0x54): undefined reference to `__aeabi_ldivmod'
> > > 
> > > This issue happens while there is no "unsigned int" conversion in the
> > > new clock_gettime / clock_gettime64 syscall path of gettimeofday():
> > > 
> > >     tv->tv_usec = ts.tv_nsec / 1000;
> > > 
> > > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > > ---
> > >  tools/testing/selftests/nolibc/nolibc-test.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > > index 8ba8c2fc71a0..20d184da9a2b 100644
> > > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > > @@ -533,6 +533,8 @@ static int test_stat_timestamps(void)
> > >   */
> > >  int run_syscall(int min, int max)
> > >  {
> > > +	struct timeval tv;
> > > +	struct timezone tz;
> > >  	struct stat stat_buf;
> > >  	int euid0;
> > >  	int proc;
> > > @@ -588,6 +590,9 @@ int run_syscall(int min, int max)
> > >  		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
> > >  		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;
> > >  		CASE_TEST(gettimeofday_null); EXPECT_SYSZR(1, gettimeofday(NULL, NULL)); break;
> > > +		CASE_TEST(gettimeofday_tv);   EXPECT_SYSZR(1, gettimeofday(&tv, NULL)); break;
> > > +		CASE_TEST(gettimeofday_tz);   EXPECT_SYSZR(1, gettimeofday(NULL, &tz)); break;
> > 
> > Calling gettimeofday(NULL, ...) will actually segfault on glibc.
> > It works when calling through the VDSO, but not the logic in glibc
> > itself, which is guess is allowed by POSIX.
> >
> 
> In low level gettimeofday syscall, it should be ok, will check the non-vdso
> code of glibc later. in musl, it returns 0 when it is NULL
> (src/time/gettimeofday.c).

It's fine for the Linux syscall, vdso, musl and nolibc.
It's not fine for glibc and gnulib.

> > I propose to avoid doing it :-)
> 
> Just checked it again, these two cases can also detect the issues (1):
> 
>     CASE_TEST(gettimeofday_tv);   EXPECT_SYSZR(1, gettimeofday(&tv, NULL)); break;
>     CASE_TEST(gettimeofday_tv_tz);EXPECT_SYSZR(1, gettimeofday(&tv, &tz)); break;
> 
>     (1) nolibc-test.c:(.text.gettimeofday+0x54): undefined reference to `__aeabi_ldivmod'

To be honest this does not look like a nolibc issue, more a compiler
setup problem. GCC generates calls to a function in libgcc that is not
linked for some reason.

Can you provide reproduction steps?

Also I guess a testcase that tests at runtime that the compilation has
worked is of limited use :-)
It either works or it never executes.

> we can directly remove the second one ;-)
> 
> > 
> > Either we gate the existing test in #ifdef NOLIBC or we remove it.
> 
> so, we still need to check the original gettimeofday_null test case for glibc?

The original testcase also needs adaption, yes.

> Thanks,
> Zhangjin
> 
> > 
> > > +		CASE_TEST(gettimeofday_tv_tz);EXPECT_SYSZR(1, gettimeofday(&tv, &tz)); break;
> > >  		CASE_TEST(getpagesize);       EXPECT_SYSZR(1, test_getpagesize()); break;
> > >  		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
> > >  		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
