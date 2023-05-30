Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F75F715FFC
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 14:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjE3Mhe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 08:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjE3MhH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 08:37:07 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDA3E62;
        Tue, 30 May 2023 05:36:14 -0700 (PDT)
Date:   Tue, 30 May 2023 14:35:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1685450155; bh=b3RCf6QIsO9f8zMyCggnyJj6PukOHn5wfBsC9TyQ1dE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aaUm6cUuHuaFhYQTwVcQ8AU/Wy8mBIiJ/R3mHoNxiPxQz1KzFcDN1HXTfFZMb/siM
         W1SeYr2d2cqcmrKpifP1LvSyQYqpsBn/xM+fCTxjMDhGX2sH3Zk+q4IC8VDq6AfPD9
         BcTjuZ7qSBbMWtGpL7dezm09CozCCIVVxioGDLA8=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Zhangjin Wu <falcon@tinylab.org>, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/2] selftests/nolibc: add new gettimeofday test cases
Message-ID: <280867a8-7601-4a96-9b85-87668e1f1282@t-8ch.de>
References: <cover.1685428087.git.falcon@tinylab.org>
 <bfc3dba52300dcce03ae1c7c41f2bb8984cf459b.1685428087.git.falcon@tinylab.org>
 <96f1134d-ce6e-4d82-ae00-1cd4038809c4@t-8ch.de>
 <ZHXmbNg4BdJNd4cO@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHXmbNg4BdJNd4cO@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-05-30 14:05:00+0200, Willy Tarreau wrote:
> On Tue, May 30, 2023 at 12:59:31PM +0200, Thomas Weißschuh wrote:
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
> 
> Then that's shocking, because the man page says:
> 
>        If either tv or tz is NULL, the corresponding structure is not  set  or
>        returned.   (However, compilation warnings will result if tv is NULL.)
> 
> I'd expect glibc to at least support what'd documented in the man
> page :-/

That is gettimeofday(2), which comes from the Linux man-pages project.

gettimeofday(3p) which specifies the posix function does not have that wording.
It also specifies that there is no way to indicate errors...

Seems to be a weird situation.

> > I propose to avoid doing it :-)
> 
> If you're certain that's the case, then I agree.
> 
> > Either we gate the existing test in #ifdef NOLIBC or we remove it.
> 
> Better not keep tests specific to nolibc if they aim at verifying some
> compatibliity.

Thomas
