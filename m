Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E7B76AA44
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 09:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjHAHtD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 03:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjHAHtD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 03:49:03 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38509E48;
        Tue,  1 Aug 2023 00:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1690876140;
        bh=qsbOXFqF2xX1Cj3m1X+7zylT1KmXCgIpush39Cl5JtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bWUrDjWULaOlHXTqUu5UmVfeqHLaTpy2k1zUYBvlYy/zWGzYpIIMO0odL2xdqMWub
         89KhGnUxOqLLpURKST/RRSaw1vdZ1EdRxudJofu/e9vi61Fh4nfRHnNV15aI6Hh4oV
         BRIeXzkTP9f9pOIBvRo8C0a7UzmQscMANtzRGTTc=
Date:   Tue, 1 Aug 2023 09:48:59 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH v2 09/10] selftests/nolibc: test return value of read()
 in test_vfprintf
Message-ID: <ba29aabd-042b-473f-b395-efdb9db4c152@t-8ch.de>
References: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
 <20230801-nolibc-warnings-v2-9-1ba5ca57bd9b@weissschuh.net>
 <ZMitRWU94SzCBNdd@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZMitRWU94SzCBNdd@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-08-01 08:59:17+0200, Willy Tarreau wrote:
> On Tue, Aug 01, 2023 at 07:30:16AM +0200, Thomas Weißschuh wrote:
> > If read() fails and returns -1 buf would be accessed out of bounds.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  tools/testing/selftests/nolibc/nolibc-test.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > index 82714051c72f..a334f8450a34 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -1031,6 +1031,12 @@ static int expect_vfprintf(int llen, int c, const char *expected, const char *fm
> >  	lseek(fd, 0, SEEK_SET);
> >  
> >  	r = read(fd, buf, sizeof(buf) - 1);
> > +	if (r == -1) {
> > +		llen += printf(" read() = %s", errorname(errno));
> > +		result(llen, FAIL);
> > +		return 1;
> > +	}
> > +
> >  	buf[r] = '\0';
> 
> In fact given the nature of this file (test if we properly implemented
> our syscalls), I think that a more conservative approach is deserved
> because if we messed up on read() we can have anything on return and we
> don't want to trust that. As such I would suggest that we declare r as
> ssize_t and verify that it's neither negative nor larger than
> sizeof(buf)-1, which becomes:
> 
>         if ((size_t)r >= sizeof(buf)) {
>             ... fail ...
>         }

As r == w is validated just below anyways we could move the assignment
buf[r] = '\0' after that check and then we don't need a new block.

> You'll also have to turn w to ssize_t then due to the test later BTW.

Will do in any case.
