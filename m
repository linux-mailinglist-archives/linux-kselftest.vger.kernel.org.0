Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F5A742AE1
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jun 2023 18:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjF2Q4v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 12:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjF2Q4t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 12:56:49 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F852134;
        Thu, 29 Jun 2023 09:56:48 -0700 (PDT)
Date:   Thu, 29 Jun 2023 18:56:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1688057805; bh=4elotnmXGpe3V3SJ//1GuCSRqBeSHWMIR5YI5hTtzS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K1MvRxqnvqIUKvTQoMgfm5QYAlTAXP1HyZqpNC4Q4Ic9UcorZnRD0KS7A+fo6cfbG
         T0yCsDOGaILA4iyiuGDxnJsOEm9dRnUhUgDKixMRSxRvJ2HH9c2be1cFTSFPHZBeXP
         Vulmrd3isXtcEA94fE7C2egvupwB1Ox5QsToVUkg=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v1 05/17] selftests/nolibc: stat_timestamps: remove
 procfs dependency
Message-ID: <df1f8ba1-3040-465c-804e-495f046dba7a@t-8ch.de>
References: <5f80f3dae60f77c6b746578113e56c8fa6454143.1687344643.git.falcon@tinylab.org>
 <20230628135922.97298-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628135922.97298-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On 2023-06-28 21:59:22+0800, Zhangjin Wu wrote:
> I'm preparing a revision for this series, in the past days, when I was
> working on testing our new 'minimal' kernel config support for all of
> the architectures, the time cost (and wait) is really appreciable and the
> repeated develop and test is really a big pain, I can also image when you
> was working on stack-protector and Willy was working on lots of old
> features ;-)

To be honest I almost never built a kernel.
Most of the time I tested my stuff with qemu-user.
This made the dev-cycle really fast, especially with a binfmt setup that
launches foreign binaries automatically with qemu-user.

> As you explained before, I knew the idea of using '/proc/self' here is
> important to not using a fixed-time file, besides our proposed method (make
> sure it at least not fail, just skip for !procfs):
> 
>     - CASE_TEST(stat_timestamps);   EXPECT_SYSZR(1, test_stat_timestamps()); break;
>     + CASE_TEST(stat_timestamps);   EXPECT_SYSZR(proc, test_stat_timestamps()); break;
> 
> To further avoid skip it for !procfs (I don't mean relaly disable it for the
> default tinyconfig support, which need more discuss, at least provide the
> possibility to pass without procfs), do you like this change? it doesn't depend
> on 'proc' now.
> 
>     -	if (stat("/proc/self/", &st))
>     +	if (stat("/proc/self/", &st) && stat("/init", &st) && stat("/", &st))
> 
> The "/init" is compiled for 'run' target every time, so, the time stamp should
> be dynamic enough, for libc-test, the /proc/self should be always there (if
> still not enough, we can reuse the init file list here), the "/" here is only
> for the worst-case scene ;-)

Both aproaches seem fine. Just skipping on !proc seems good enough.

As for enabling proc in the test configs I just tested a plain
tinyconfig vs one with CONFIG_PROC_FS enabled:

tinyconfig:                  375.06user 53.21system 2:05.80elapsed
tinyconfig + CONFIG_PROC_FS: 397.77user 56.84system 2:09.24elapsed

The overhead seems acceptable.


Note as for disabling memfd:

It seems currently MEMFD_CREATE is hardwired to only be enabled when
either TMPFS or HUGETLBFS is enabled.

But the memfd code and syscalls seem to work perfectly fine with those
options disabled. I'll send a patch to fix up the Kconfigs to enable
that usecase.

> Thanks,
> Zhangjin
> 
> > Since it is not really necessary to use /proc/self here, instead of
> > adding a condition check, we use the always existing '/' path instead of
> > /proc/self, this eventually let it work without procfs.
> > 
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > index ebec948ec808..2ef44176f7a9 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -520,7 +520,7 @@ static int test_stat_timestamps(void)
> >  	if (sizeof(st.st_atim.tv_sec) != sizeof(st.st_atime))
> >  		return 1;
> >  
> > -	if (stat("/proc/self/", &st))
> > +	if (stat("/", &st))
> >  		return 1;
> >  
> >  	if (st.st_atim.tv_sec != st.st_atime || st.st_atim.tv_nsec > 1000000000)
> > -- 
> > 2.25.1
