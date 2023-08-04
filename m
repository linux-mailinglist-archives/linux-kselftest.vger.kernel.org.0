Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5157704EB
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 17:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjHDPiN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 11:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjHDPiH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 11:38:07 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339D73C3D;
        Fri,  4 Aug 2023 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1691163484; bh=YCbKHizJ+96nxExfEuzM8vhUtwP+5zZPbpekUwhOb7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lfUcUpnH3shhL1FXfjVogI81OKWhvuhs7Ruut8ydPey3oxsL/M99hKz75DNWtZeCD
         2ciDYSG78xRw+3tJi2yFcuidBrpdCXJ2dFWioGSmVFftMC4yAs4+A/WUyaLBak4lH3
         Wqx74oplKu68ERNBAp5PBRmkUFqtCdXbXcM0dS9k=
Date:   Fri, 4 Aug 2023 17:38:03 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org
Subject: Re: [PATCH v1 3/3] tools/nolibc: stackprotector.h: make
 __stack_chk_init static
Message-ID: <34bf8710-0571-4f69-87bc-b3776264744b@t-8ch.de>
References: <cover.1691073180.git.falcon@tinylab.org>
 <d5eb12e6b9238dcb85935cf6af3ed12ff043f900.1691073180.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5eb12e6b9238dcb85935cf6af3ed12ff043f900.1691073180.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-08-03 22:47:01+0800, Zhangjin Wu wrote:
> This allows to generate smaller text/data/dec size.
> 
> As the _start_c() function added by crt.h, __stack_chk_init() is called
> from _start_c() instead of the assembly _start. So, it is able to mark
> it with static now.
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
>  tools/include/nolibc/crt.h            | 2 +-
>  tools/include/nolibc/stackprotector.h | 5 ++---
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
> index 32e128b0fb62..a5f33fef1672 100644
> --- a/tools/include/nolibc/crt.h
> +++ b/tools/include/nolibc/crt.h
> @@ -10,7 +10,7 @@
>  char **environ __attribute__((weak));
>  const unsigned long *_auxv __attribute__((weak));
>  
> -void __stack_chk_init(void);
> +static void __stack_chk_init(void);
>  static void exit(int);
>  
>  void _start_c(long *sp)
> diff --git a/tools/include/nolibc/stackprotector.h b/tools/include/nolibc/stackprotector.h
> index b620f2b9578d..13f1d0e60387 100644
> --- a/tools/include/nolibc/stackprotector.h
> +++ b/tools/include/nolibc/stackprotector.h
> @@ -37,8 +37,7 @@ void __stack_chk_fail_local(void)
>  __attribute__((weak,section(".data.nolibc_stack_chk")))
>  uintptr_t __stack_chk_guard;
>  
> -__attribute__((weak,section(".text.nolibc_stack_chk"))) __no_stack_protector
> -void __stack_chk_init(void)
> +static __no_stack_protector void __stack_chk_init(void)
>  {
>  	my_syscall3(__NR_getrandom, &__stack_chk_guard, sizeof(__stack_chk_guard), 0);
>  	/* a bit more randomness in case getrandom() fails, ensure the guard is never 0 */
> @@ -46,7 +45,7 @@ void __stack_chk_init(void)
>  		__stack_chk_guard ^= (uintptr_t) &__stack_chk_guard;
>  }
>  #else /* !defined(_NOLIBC_STACKPROTECTOR) */
> -__inline__ void __stack_chk_init(void) {}
> +static void __stack_chk_init(void) {}
>  #endif /* defined(_NOLIBC_STACKPROTECTOR) */
>  
>  #endif /* _NOLIBC_STACKPROTECTOR_H */
> -- 
> 2.25.1
> 
