Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F6076A88A
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 07:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjHAF5o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 01:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHAF5n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 01:57:43 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA22E7D;
        Mon, 31 Jul 2023 22:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1690869460;
        bh=Sxb7+n6qZ5PmXQo2k8+b+wVoId3QKcNBSJ9E1tXXK2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fdZ7kCZKtxF1tZF8GLScdjKNlezKsMqyMZsYb7pLy9VMxko0bOOCEgeXm0Zx25nO0
         /y/f/zaj23bQEh7tEIlItAm1HtMRr5LQGtpWZaOFW7EyPi7i88+CXxkJnFE2Rjlj6f
         arfTjkTtWsZJUQ7DUfGvXZ83k5dmZqri0bsvyQ7M=
Date:   Tue, 1 Aug 2023 07:57:39 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, tanyuan@tinylab.org, w@1wt.eu
Subject: Re: [PATCH v2 08/10] selftests/nolibc: avoid sign-compare warnings
Message-ID: <54502a41-5c35-4c79-812f-263d5e24f056@t-8ch.de>
References: <20230801-nolibc-warnings-v2-8-1ba5ca57bd9b@weissschuh.net>
 <20230801054819.37659-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230801054819.37659-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin!

On 2023-08-01 13:48:19+0800, Zhangjin Wu wrote:
> > These warnings will be enabled later so avoid triggering them.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  tools/testing/selftests/nolibc/nolibc-test.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > index cb17cccd0bc7..82714051c72f 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -749,7 +749,7 @@ static int test_mmap_munmap(void)
> >  	};
> >  
> >  	page_size = getpagesize();
> > -	if (page_size < 0)
> > +	if (page_size == 0)
> >  		return -1;
> >
> 
> It was my mistake before, but do we need to align with the one used in
> test_getpagesize():
> 
>     static int test_getpagesize(void)
>     {
>             long x = getpagesize();
>             int c;
>     
>             if (x < 0)
>                     return x;
> 
> Use 'long' instead of 'size_t' to declare page_size?

Good point.

Given that getpagesize() is documented as returning "int" I guess we
should actually change the implementation in nolibc.

> Thanks,
> Zhangjin
> 
> >  	/* find a right file to mmap, existed and accessible */
> > @@ -998,7 +998,7 @@ static int run_stdlib(int min, int max)
> >  #define EXPECT_VFPRINTF(c, expected, fmt, ...)				\
> >  	ret += expect_vfprintf(llen, c, expected, fmt, ##__VA_ARGS__)
> >  
> > -static int expect_vfprintf(int llen, size_t c, const char *expected, const char *fmt, ...)
> > +static int expect_vfprintf(int llen, int c, const char *expected, const char *fmt, ...)
> >  {
> >  	int ret, fd, w, r;
> >  	char buf[100];
> > 
> > -- 
> > 2.41.0
