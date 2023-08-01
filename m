Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD6976AA10
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 09:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjHAHeW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 03:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjHAHeW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 03:34:22 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7171726;
        Tue,  1 Aug 2023 00:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1690875259;
        bh=qNGRHKsnBf+CzrhykXYrpIFs3s6raNyDUWsZW5CWNow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YLyJZJ8k1oRfvQd2F2WbhPPAW9vDexfyDyYd9i2aMcHbw1VWqzMRQEVc0VkK/nqfU
         sQU2bwlXxslCCqHQIt3pGKwZlwQlkH8vQ4n3lEvn5lf9BbOPKw1NNA+XbQUtgHzg5e
         STxXs07pQAXghKHPZ56wWLOGMZf5VNIvxcCx4JLA=
Date:   Tue, 1 Aug 2023 09:34:18 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH v2 06/10] selftests/nolibc: make functions static if
 possible
Message-ID: <bf97900a-98bb-45dc-9451-b9728173136e@t-8ch.de>
References: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
 <20230801-nolibc-warnings-v2-6-1ba5ca57bd9b@weissschuh.net>
 <ZMiro1pwVvAzNel5@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZMiro1pwVvAzNel5@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-08-01 08:52:19+0200, Willy Tarreau wrote:
> On Tue, Aug 01, 2023 at 07:30:13AM +0200, Thomas Weißschuh wrote:
> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > index 1555759bb164..53a3773c7790 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c

> [..]

> >  /* prepare what needs to be prepared for pid 1 (stdio, /dev, /proc, etc) */
> > -int prepare(void)
> > +static int prepare(void)
> >  {
> >  	struct stat stat_buf;
> >  
> > @@ -1208,7 +1208,7 @@ static const struct test test_names[] = {
> >  	{ 0 }
> >  };
>  
> For these ones it will prevent gcc from putting breakpoints there, which
> is counter-productive.

Indeed.

An alternative would be to add -g to CFLAGS (and remove -s from LDFLAGS).
This way we get full debugability including breakpoints for everything.

I didn't find the reasoning for -s in LDFLAGS.

Thomas
