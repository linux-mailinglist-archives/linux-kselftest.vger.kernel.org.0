Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C40C76A993
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 08:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjHAG7l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 02:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjHAG7k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 02:59:40 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48A591BD;
        Mon, 31 Jul 2023 23:59:39 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3716xHHu030364;
        Tue, 1 Aug 2023 08:59:17 +0200
Date:   Tue, 1 Aug 2023 08:59:17 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH v2 09/10] selftests/nolibc: test return value of read()
 in test_vfprintf
Message-ID: <ZMitRWU94SzCBNdd@1wt.eu>
References: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
 <20230801-nolibc-warnings-v2-9-1ba5ca57bd9b@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230801-nolibc-warnings-v2-9-1ba5ca57bd9b@weissschuh.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 01, 2023 at 07:30:16AM +0200, Thomas Weiﬂschuh wrote:
> If read() fails and returns -1 buf would be accessed out of bounds.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 82714051c72f..a334f8450a34 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -1031,6 +1031,12 @@ static int expect_vfprintf(int llen, int c, const char *expected, const char *fm
>  	lseek(fd, 0, SEEK_SET);
>  
>  	r = read(fd, buf, sizeof(buf) - 1);
> +	if (r == -1) {
> +		llen += printf(" read() = %s", errorname(errno));
> +		result(llen, FAIL);
> +		return 1;
> +	}
> +
>  	buf[r] = '\0';

In fact given the nature of this file (test if we properly implemented
our syscalls), I think that a more conservative approach is deserved
because if we messed up on read() we can have anything on return and we
don't want to trust that. As such I would suggest that we declare r as
ssize_t and verify that it's neither negative nor larger than
sizeof(buf)-1, which becomes:

        if ((size_t)r >= sizeof(buf)) {
            ... fail ...
        }

You'll also have to turn w to ssize_t then due to the test later BTW.

Willy
