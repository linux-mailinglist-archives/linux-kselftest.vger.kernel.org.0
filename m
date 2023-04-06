Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D186D9FC3
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 20:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240147AbjDFS03 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 14:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240136AbjDFS01 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 14:26:27 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94BD983FB;
        Thu,  6 Apr 2023 11:26:23 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 336IQ9Q4005908;
        Thu, 6 Apr 2023 20:26:09 +0200
Date:   Thu, 6 Apr 2023 20:26:09 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Mark Brown <broonie@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tools/nolibc/stdio: Implement vprintf()
Message-ID: <ZC8OwUPAC4s413jP@1wt.eu>
References: <20230405-kselftest-nolibc-v2-0-2ac2495814b5@kernel.org>
 <20230405-kselftest-nolibc-v2-1-2ac2495814b5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405-kselftest-nolibc-v2-1-2ac2495814b5@kernel.org>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 06, 2023 at 05:19:10PM +0100, Mark Brown wrote:
> vprintf() is equivalent to vfprintf() to stdout so implement it as a simple
> wrapper for the existing vfprintf(), allowing us to build kselftest.h.
> 
> Suggested-by: Willy Tarreau <w@1wt.eu>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/include/nolibc/stdio.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
> index 96ac8afc5aee..6cbbb52836a0 100644
> --- a/tools/include/nolibc/stdio.h
> +++ b/tools/include/nolibc/stdio.h
> @@ -273,6 +273,12 @@ int vfprintf(FILE *stream, const char *fmt, va_list args)
>  	return written;
>  }
>  
> +static __attribute__((unused))
> +int vprintf(const char *fmt, va_list args)
> +{
> +	return vfprintf(stdout, fmt, args);
> +}
> +
>  static __attribute__((unused, format(printf, 2, 3)))
>  int fprintf(FILE *stream, const char *fmt, ...)
>  {

Perfect, thank you Mark, I'm glad that it simplified the rest of
your series.

Acked-by: Willy Tarreau <w@1wt.eu>

Paul, feel free to directly queue this one for 6.5. If you prefer I
can as well queue it on my side and send it later, it's just that I
have exactly zero extra value on top of this one ;-)

Thanks,
Willy
