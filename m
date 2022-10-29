Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D4A612237
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Oct 2022 12:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiJ2Kfm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Oct 2022 06:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ2Kfl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Oct 2022 06:35:41 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EF465270;
        Sat, 29 Oct 2022 03:35:37 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4MzwmS53sKz9sNb;
        Sat, 29 Oct 2022 10:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1667039736; bh=FXaHqBE8piSKzUlN37PhlW9f3D/eAeB2qZPMLHzY81I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TKQ5FX5ibcUaOFSPmJ9Q1n6X2B40QXNxU1UBHkGTgE6aomi5mfdan7Dj20O4HdjAl
         u+o1RfminOXOyZOsdi/7Ro4d2Zc6uQghv8SUBTb747uA8DwR1d4Dy0a8xSbjzvztWQ
         En6a56lT7INEBsx+6BeYdhvKQIT/OpetgE9CxIss=
X-Riseup-User-ID: 5E46FA78F9295AE62B12862AC84E9FF8FC4711671C71289E7AA556C21037FE7C
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4MzwmQ2qyqz5vRh;
        Sat, 29 Oct 2022 10:35:34 +0000 (UTC)
Message-ID: <383a94bf-e9f1-49a9-9df9-1e72c51b5444@riseup.net>
Date:   Sat, 29 Oct 2022 07:35:30 -0300
MIME-Version: 1.0
Subject: Re: [PATCH] kunit: alloc_string_stream_fragment error handling bug
 fix
To:     "YoungJun.park" <her0gyugyu@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>
Cc:     David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
References: <20221028144241.634012-1-her0gyugyu@gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20221028144241.634012-1-her0gyugyu@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/28/22 11:42, YoungJun.park wrote:
> When it fails to allocate fragment, it does not free and return error.
> And check the pointer inappropriately.
> 
> Signed-off-by: YoungJun.park <her0gyugyu@gmail.com>
> ---
>  lib/kunit/string-stream.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> index 72659a9773e3..0228fe814e96 100644
> --- a/lib/kunit/string-stream.c
> +++ b/lib/kunit/string-stream.c
> @@ -23,8 +23,10 @@ static struct string_stream_fragment *alloc_string_stream_fragment(
>  		return ERR_PTR(-ENOMEM);
>  
>  	frag->fragment = kunit_kmalloc(test, len, gfp);
> -	if (!frag->fragment)
> +	if (!frag->fragment) {
> +		kunit_kfree(test, frag);

I don't believe that kunit_kfree is necessary here, because
kunit_kmalloc is like kmalloc, but the allocation is test managed, which
means that the allocation is managed by the test case and is
automatically cleaned up after the test case concludes.

So, the original version seems correct: if the allocation fails,
alloc_string_stream_fragment will return NULL and string_stream_vadd
will check if frag_container is different than NULL.

Best Regards,
- Maíra Canal

>  		return ERR_PTR(-ENOMEM);
> +	}
>  
>  	return frag;
>  }
> @@ -56,7 +58,7 @@ int string_stream_vadd(struct string_stream *stream,
>  	frag_container = alloc_string_stream_fragment(stream->test,
>  						      len,
>  						      stream->gfp);
> -	if (!frag_container)
> +	if (IS_ERR(frag_container))
>  		return -ENOMEM;
>  
>  	len = vsnprintf(frag_container->fragment, len, fmt, args);
