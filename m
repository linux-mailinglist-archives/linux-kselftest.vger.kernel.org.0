Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C185D715D2D
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 13:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjE3L2Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 07:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjE3L2X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 07:28:23 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D68BEC;
        Tue, 30 May 2023 04:28:20 -0700 (PDT)
X-QQ-mid: bizesmtp76t1685446091t9abaw5r
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 19:28:10 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: XBN7tc9DADKii40bmE5sGvtC9c0wjUbBTZsZYzSjmYPV8vlhi9Gaaau5lxU9Y
        VTD/sTXRqUNm4xb+xV2+n6bSiwl3xsLACPXec0+JjoGtlQVen+X1tH8BaeqO1+6e25w/rlN
        FdRYkVmuF+8GeqTl/XcwvcEESpcnyUJ/8nmwIEVkGHgNAOyVU2Bj9n3TqGdqla6LQFxFDyv
        PbDiwIHF+QICRgIaj2BJbTjjeHbd0SvzOV9x2dGn1vsCJaKxOgX05lma3EgTm7tr/FD3WEy
        HTkE8Mpj/PMx29MLjWCTTqneLmWEwEk/iOqBJjQ4gXDlnAg78B5Uu3QQSueDQG7EJGi1J7l
        tM70IjevvjLxTMAcZILaYQgQ2333gVqt8+82iixCfiLbAbiHuI6L0wC7dua5dAk4NQ/+Gsn
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16639300519272177696
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        w@1wt.eu
Subject: Re: [PATCH 1/2] selftests/nolibc: add new gettimeofday test cases
Date:   Tue, 30 May 2023 19:28:06 +0800
Message-Id: <20230530112806.404017-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <96f1134d-ce6e-4d82-ae00-1cd4038809c4@t-8ch.de>
References: <96f1134d-ce6e-4d82-ae00-1cd4038809c4@t-8ch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On 2023-05-30 14:37:49+0800, Zhangjin Wu wrote:
> > These 3 test cases are added to cover the normal using scenes of
> > gettimeofday().
> > 
> > They have been used to trigger and fix up such issue:
> > 
> >     nolibc-test.c:(.text.gettimeofday+0x54): undefined reference to `__aeabi_ldivmod'
> > 
> > This issue happens while there is no "unsigned int" conversion in the
> > new clock_gettime / clock_gettime64 syscall path of gettimeofday():
> > 
> >     tv->tv_usec = ts.tv_nsec / 1000;
> > 
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/testing/selftests/nolibc/nolibc-test.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > index 8ba8c2fc71a0..20d184da9a2b 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -533,6 +533,8 @@ static int test_stat_timestamps(void)
> >   */
> >  int run_syscall(int min, int max)
> >  {
> > +	struct timeval tv;
> > +	struct timezone tz;
> >  	struct stat stat_buf;
> >  	int euid0;
> >  	int proc;
> > @@ -588,6 +590,9 @@ int run_syscall(int min, int max)
> >  		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
> >  		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;
> >  		CASE_TEST(gettimeofday_null); EXPECT_SYSZR(1, gettimeofday(NULL, NULL)); break;
> > +		CASE_TEST(gettimeofday_tv);   EXPECT_SYSZR(1, gettimeofday(&tv, NULL)); break;
> > +		CASE_TEST(gettimeofday_tz);   EXPECT_SYSZR(1, gettimeofday(NULL, &tz)); break;
> 
> Calling gettimeofday(NULL, ...) will actually segfault on glibc.
> It works when calling through the VDSO, but not the logic in glibc
> itself, which is guess is allowed by POSIX.
>

In low level gettimeofday syscall, it should be ok, will check the non-vdso
code of glibc later. in musl, it returns 0 when it is NULL
(src/time/gettimeofday.c).

> I propose to avoid doing it :-)

Just checked it again, these two cases can also detect the issues (1):

    CASE_TEST(gettimeofday_tv);   EXPECT_SYSZR(1, gettimeofday(&tv, NULL)); break;
    CASE_TEST(gettimeofday_tv_tz);EXPECT_SYSZR(1, gettimeofday(&tv, &tz)); break;

    (1) nolibc-test.c:(.text.gettimeofday+0x54): undefined reference to `__aeabi_ldivmod'

we can directly remove the second one ;-)

> 
> Either we gate the existing test in #ifdef NOLIBC or we remove it.

so, we still need to check the original gettimeofday_null test case for glibc?

Thanks,
Zhangjin

> 
> > +		CASE_TEST(gettimeofday_tv_tz);EXPECT_SYSZR(1, gettimeofday(&tv, &tz)); break;
> >  		CASE_TEST(getpagesize);       EXPECT_SYSZR(1, test_getpagesize()); break;
> >  		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
> >  		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
