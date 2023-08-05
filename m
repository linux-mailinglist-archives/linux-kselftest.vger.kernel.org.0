Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67BC77107F
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 18:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjHEQUG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 12:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHEQUF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 12:20:05 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7F8F10F8;
        Sat,  5 Aug 2023 09:20:02 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 375GJT91022197;
        Sat, 5 Aug 2023 18:19:29 +0200
Date:   Sat, 5 Aug 2023 18:19:29 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH v3 05/14] tools/nolibc: stdint: use int for size_t on
 32bit
Message-ID: <20230805161929.GA15284@1wt.eu>
References: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
 <20230803-nolibc-warnings-v3-5-bcc1a096ae02@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230803-nolibc-warnings-v3-5-bcc1a096ae02@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Thomas,

On Thu, Aug 03, 2023 at 09:28:49AM +0200, Thomas Weiﬂschuh wrote:
> Otherwise both gcc and clang may generate warnings about type
> mismatches:
> 
> sysroot/mips/include/string.h:12:14: warning: mismatch in argument 1 type of built-in function 'malloc'; expected 'unsigned int' [-Wbuiltin-declaration-mismatch]
>    12 | static void *malloc(size_t len);
>       |              ^~~~~~
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  tools/include/nolibc/stdint.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
> index 4b282435a59a..0f390c3028d8 100644
> --- a/tools/include/nolibc/stdint.h
> +++ b/tools/include/nolibc/stdint.h
> @@ -15,7 +15,11 @@ typedef unsigned int       uint32_t;
>  typedef   signed int        int32_t;
>  typedef unsigned long long uint64_t;
>  typedef   signed long long  int64_t;
> +#if __SIZE_WIDTH__ == 64
>  typedef unsigned long        size_t;
> +#else
> +typedef unsigned int         size_t;
> +#endif

This one breaks gcc < 7 for me because __SIZE_WIDTH__ is not defined
there. However I could trace __SIZE_TYPE__ to be defined since at least
gcc-3.4 so instead we can do this, which will always match the type set
by the compiler (either "unsigned int" or "unsigned long int") :

  #ifdef __SIZE_TYPE__
  typedef __SIZE_TYPE__ size_t;
  #else
  typedef unsigned long size_t;
  #endif

Please just let me know if you want me to modify your patch accordingly.
I'm still continuing the tests.

Thanks,
Willy
