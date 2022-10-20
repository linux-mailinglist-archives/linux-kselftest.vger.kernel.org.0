Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC153606B88
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Oct 2022 00:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiJTWsD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Oct 2022 18:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiJTWr6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Oct 2022 18:47:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FF810326E;
        Thu, 20 Oct 2022 15:47:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C14ABB821C7;
        Thu, 20 Oct 2022 22:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74229C433D6;
        Thu, 20 Oct 2022 22:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666306073;
        bh=t0QeRp+bmsd+crwzB+xELXeH4SEX3TRlOBC4DHlL3hc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rj5hFTyMnXGQSiWPCkaiAMahSPmFo+tOkv+I/HWMbbvcIxTSaMFdNafcQNgOGVZAg
         54RuNX1sf8vhAiaUvll10OptBthPVysNGteFyunypwgPKYjOhMchXy3VoVfphe0/U6
         STLsSdVD4vwNw8GAIF+Jh10yopFMr4n+ozxoHHcvigk7Lvw1WxdhoC6hg9zXX4IcYP
         bjh9NVZAW7Ckz1jsImsDr7eUVccnB84m52N8w99cUNtF9emPjOdkI6Dujgk03X8ejH
         Voc6fk4axx8JKEhCEIU2GnJQxjWKrJaZd/d+QaTPvJ5uWw/qzFgSAp0dyYwHkRahn+
         HXhXL3m2353dQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1AA9B5C1109; Thu, 20 Oct 2022 15:47:53 -0700 (PDT)
Date:   Thu, 20 Oct 2022 15:47:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        kernel test robot <lkp@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools/nolibc: fix missing strlen() definition and
 infinite loop with gcc-12
Message-ID: <20221020224753.GB5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221009151939.28270-1-w@1wt.eu>
 <20221009182936.29125-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009182936.29125-1-w@1wt.eu>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Oct 09, 2022 at 08:29:36PM +0200, Willy Tarreau wrote:
> When built at -Os, gcc-12 recognizes an strlen() pattern in nolibc_strlen()
> and replaces it with a jump to strlen(), which is not defined as a symbol
> and breaks compilation. Worse, when the function is called strlen(), the
> function is simply replaced with a jump to itself, hence becomes an
> infinite loop.
> 
> One way to avoid this is to always set -ffreestanding, but the calling
> code doesn't know this and there's no way (either via attributes or
> pragmas) to globally enable it from include files, effectively leaving
> a painful situation for the caller.
> 
> Alexey suggested to place an empty asm() statement inside the loop to
> stop gcc from recognizing a well-known pattern, which happens to work
> pretty fine. At least it allows us to make sure our local definition
> is not replaced with a self jump.
> 
> The function only needs to be renamed back to strlen() so that the symbol
> exists, which implies that nolibc_strlen() which is used on variable
> strings has to be declared as a macro that points back to it before the
> strlen() macro is redifined.
> 
> It was verified to produce valid code with gcc 3.4 to 12.1 at different
> optimization levels, and both with constant and variable strings.
> 
> In case this problem surfaces again in the future, an alternate approach
> consisting in adding an optimize("no-tree-loop-distribute-patterns")
> function attribute for gcc>=12 worked as well but is less pretty.
> 
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Link: https://lore.kernel.org/r/202210081618.754a77db-yujie.liu@intel.com
> Fixes: 66b6f755ad45 ("rcutorture: Import a copy of nolibc")
> Fixes: 96980b833a21 ("tools/nolibc/string: do not use __builtin_strlen() at -O0")
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Signed-off-by: Willy Tarreau <w@1wt.eu>

Hearing no objections, I have pulled this one in for review and testing,
thank you!

							Thanx, Paul

> ---
> v2: dropped the attribute(optimize) in favor of an empty asm() statement
> 
> ---
>  tools/include/nolibc/string.h | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
> index bef35bee9c44..718a405ffbc3 100644
> --- a/tools/include/nolibc/string.h
> +++ b/tools/include/nolibc/string.h
> @@ -125,14 +125,18 @@ char *strcpy(char *dst, const char *src)
>  }
>  
>  /* this function is only used with arguments that are not constants or when
> - * it's not known because optimizations are disabled.
> + * it's not known because optimizations are disabled. Note that gcc 12
> + * recognizes an strlen() pattern and replaces it with a jump to strlen(),
> + * thus itself, hence the asm() statement below that's meant to disable this
> + * confusing practice.
>   */
>  static __attribute__((unused))
> -size_t nolibc_strlen(const char *str)
> +size_t strlen(const char *str)
>  {
>  	size_t len;
>  
> -	for (len = 0; str[len]; len++);
> +	for (len = 0; str[len]; len++)
> +		asm("");
>  	return len;
>  }
>  
> @@ -140,13 +144,12 @@ size_t nolibc_strlen(const char *str)
>   * the two branches, then will rely on an external definition of strlen().
>   */
>  #if defined(__OPTIMIZE__)
> +#define nolibc_strlen(x) strlen(x)
>  #define strlen(str) ({                          \
>  	__builtin_constant_p((str)) ?           \
>  		__builtin_strlen((str)) :       \
>  		nolibc_strlen((str));           \
>  })
> -#else
> -#define strlen(str) nolibc_strlen((str))
>  #endif
>  
>  static __attribute__((unused))
> -- 
> 2.35.3
> 
