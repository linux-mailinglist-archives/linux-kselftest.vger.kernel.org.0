Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BAD76A980
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 08:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjHAGus (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 02:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjHAGur (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 02:50:47 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701E495;
        Mon, 31 Jul 2023 23:50:45 -0700 (PDT)
X-QQ-mid: bizesmtp67t1690872639tqjbcrnc
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 01 Aug 2023 14:50:38 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: 3M0okmaRx3jHCUGWX0NFc/lpwh5f04eUaebW1W4RbmvC2G8nXw6LSBKroHVAu
        Mu8g7QXSKsVRY9mvCtEHRMsyZZ8KC/sktUtndOVfue2kWOOCMcoKK3PS426Ci0LIOCiqcWo
        KhTv68PSsm8/y0j8nnYlqnefYo6eMfqexWtBOS5baX7u6Xi6ALvP7C0OnBrAcXQ+UCFVKvd
        gG4oPsS+u2Hx3Q4IYWp7LQ0/3EvFB84K/mxlY7ittwR9prU7S/v9CfOJwN6dRVymYBZOkBg
        P3ZsJV94zUc/AShNCTekKts1j76hX2zRlR4ttappGneZzZBhXAHbKQsfUXxdiN6NxHVliC7
        maXHptPHWsfsOvTPAZxG1m7gtlWKba6XU02MVCI1UVdCYrL5F9fbgphenf4gAaV9Dt5QXtb
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6169436343876631260
From:   Zhangjin Wu <falcon@tinylab.org>
To:     linux@weissschuh.net
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        tanyuan@tinylab.org, w@1wt.eu
Subject: Re: [PATCH v2 08/10] selftests/nolibc: avoid sign-compare warnings
Date:   Tue,  1 Aug 2023 14:50:37 +0800
Message-Id: <20230801065037.38519-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <54502a41-5c35-4c79-812f-263d5e24f056@t-8ch.de>
References: <54502a41-5c35-4c79-812f-263d5e24f056@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On 2023-08-01 13:48:19+0800, Zhangjin Wu wrote:
> > > These warnings will be enabled later so avoid triggering them.
> > > 
> > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > ---
> > >  tools/testing/selftests/nolibc/nolibc-test.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > > index cb17cccd0bc7..82714051c72f 100644
> > > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > > @@ -749,7 +749,7 @@ static int test_mmap_munmap(void)
> > >  	};
> > >  
> > >  	page_size = getpagesize();
> > > -	if (page_size < 0)
> > > +	if (page_size == 0)
> > >  		return -1;
> > >
> > 
> > It was my mistake before, but do we need to align with the one used in
> > test_getpagesize():
> > 
> >     static int test_getpagesize(void)
> >     {
> >             long x = getpagesize();
> >             int c;
> >     
> >             if (x < 0)
> >                     return x;
> > 
> > Use 'long' instead of 'size_t' to declare page_size?
> 
> Good point.
> 
> Given that getpagesize() is documented as returning "int" I guess we
> should actually change the implementation in nolibc.
>

Yes, it is documented at [1], perhaps Willy looked at this line before:

   This interface, returning an int, may have problems representing appropriate values in the future. Applications should use the sysconf() function instead.

[1]: https://pubs.opengroup.org/onlinepubs/7908799/xsh/getpagesize.html

> > Thanks,
> > Zhangjin
