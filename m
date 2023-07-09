Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE7174C775
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Jul 2023 20:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjGIStO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 9 Jul 2023 14:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGIStO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 9 Jul 2023 14:49:14 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098F2D7;
        Sun,  9 Jul 2023 11:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1688928551; bh=FoY/caXNRdYDmaJ1xfS/LuWYYdu7mCfD+WNi2/Kt04Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ljATuSj1ccUDXLhjWnl9zkI4bOyIOV3PgRjyyInsu0Mclr0CtBamEXVVHEcylLWVV
         KIu3Id3f6q1f20Cx8c31H5S/y2sxzC5P/MqY49zVJNauV/NsIonRpMlbq+RH9BJeRN
         C0filRcInhNEjGDFaIuSk59snA3QDs2S9685rNKg=
Date:   Sun, 9 Jul 2023 20:49:10 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 04/12] tools/nolibc: crt.h: add _start_c
Message-ID: <4e23cc1c-2fe0-413e-9fe1-a9428c0861b9@t-8ch.de>
References: <cover.1688828139.git.falcon@tinylab.org>
 <ccc8c9b850c03ef236ab05e919fea2bf9af2556a.1688828139.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccc8c9b850c03ef236ab05e919fea2bf9af2556a.1688828139.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-08 23:29:58+0800, Zhangjin Wu wrote:
> As the environ and _auxv support added for nolibc, the assembly _start
> function becomes more and more complex and therefore makes the porting
> of nolibc to new architectures harder and harder.
> 
> To simplify portability, this c version of _start_c() is added to do
> most of the assembly start operations in C, which reduces the complexity
> a lot and will eventually simplify the porting of nolibc to the new
> architectures.
> 
> The new _start_c() only requires a stack pointer argument, it will find
> argv, envp and _auxv for us, and then call main(), finally, it exit()
> with main's return status. With this new _start_c(), the future new
> architectures only require to add very few assembly instructions.

I like it!

A quick test indicates that the initialization of the stackprotectors
could also be moved into the C function.

It also seems like a good opportunity to add some tests for
argv/environment variable passing.

And as general note to the full series I think that splitting the arch
files is not necessary and confusing.

> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/include/nolibc/crt.h | 44 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
> index 221b7c5346ca..b269294e9664 100644
> --- a/tools/include/nolibc/crt.h
> +++ b/tools/include/nolibc/crt.h
> @@ -13,4 +13,48 @@
>  char **environ __attribute__((weak));

The old code seems to avoid putting "environ" into the global symbol
namespace. Could this declaration be moved into the function like in
getenv()?

>  const unsigned long *_auxv __attribute__((weak));
>  
> +int main(int argc, char *argv[], char **envp);

This will lead to conflicting declarations if the users use a different
signature. I'm not (yet?) sure how to work around this.

Also how is the case handled where main() returns "void"?
I'm not sure how this is currently handled or if the compiler takes core
of returning 0 in this case.

> +static void exit(int);
> +
> +void _start_c(long *sp)
> +{
> +	int argc, i;
> +	char **argv;
> +	char **envp;
> +
> +	/*
> +	 * sp  :  argc          <-- argument count, required by main()
> +	 * argv:  argv[0]       <-- argument vector, required by main()
> +	 *        argv[1]
> +	 *        ...
> +	 *        argv[argc-1]
> +	 *        null
> +	 * envp:  envp[0]       <-- environment variables, required by main() and getenv()
> +	 *        envp[1]
> +	 *        ...
> +	 *        null
> +	 * _auxv: auxv[0]       <-- auxiliary vector, required by getauxval()
> +	 *        auxv[1]
> +	 *        ...
> +	 *        null
> +	 */
> +
> +	/* assign argc and argv */
> +	argc = sp[0];
> +	argv = (void *)(sp + 1);
> +
> +	/* find envp */
> +	envp = argv + argc + 1;
> +	environ = envp;
> +
> +	/* find auxv */
> +	i = 0;
> +	while (envp[i])
> +		i++;
> +	_auxv = (void *)(envp + i + 1);
> +
> +	/* go to application */
> +	exit(main(argc, argv, envp));
> +}
> +
>  #endif /* _NOLIBC_CRT_H */
> -- 
> 2.25.1
> 
