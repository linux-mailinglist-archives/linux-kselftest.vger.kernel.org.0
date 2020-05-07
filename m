Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5381C9A75
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 May 2020 21:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgEGTER (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 May 2020 15:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726367AbgEGTEQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 May 2020 15:04:16 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C84C05BD43
        for <linux-kselftest@vger.kernel.org>; Thu,  7 May 2020 12:04:16 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k18so3062291ion.0
        for <linux-kselftest@vger.kernel.org>; Thu, 07 May 2020 12:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3pqxVey+OpLP2Bd4SNRaSG1BkaFq4VbJOs0rt4HQddo=;
        b=gjcJAVkP4QIWorSEpDgbJkla5yA2OQ+73EvwbD1hpKkYsiLRkc2/DORutpA5dLKFyG
         ED5oRfQ5flpIt0TQKs0cqe1mx6aj4bcp0rL0SqdbUPeL4umAPqbcDEt1jgo2vq42J5yZ
         59SAeMEmtJeBFrq42klJ0Hny+A0ztCq9Wi7bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3pqxVey+OpLP2Bd4SNRaSG1BkaFq4VbJOs0rt4HQddo=;
        b=W+4vFZdU0QFVFLyGXOY1Yz8DMy7kcJMtnFI1BDn0FJhzir013NWyuQHRkauYmfg8+u
         63wDLz3Pu1LVkxiCOWTZioOKZtMU06fpFXJtVnfakpvjCOe2hLX03Nlhp/7dFFct8k6+
         kPNo+8KAHo/eKT2b0XjlQQYYoW27htOkYIrUrIQQU6Y8w8yrf9suecBpTlKl6yBb7jQM
         xvPH+dBhJSI5jUjpHgclZKEWrk03c9FMpnnlsWYEz06odmx7B46ctgUEK46NYS9ECJ9I
         RQ4D8IvlMScQ89jyIl2S95Reu4ovJuP6OcG4Vw7CWGiPGJj8Kd+Sjqy+SqZUX4Sl+b5G
         m2kw==
X-Gm-Message-State: AGi0PuZW3IvThPlLKFRMFENpYmY806xvWUcjLampQeD7G85lyVEBKzEZ
        i/0Dh66o7sGsqiBkwqOz996ksw==
X-Google-Smtp-Source: APiQypKAmsWHJ9r4kPgM/xipjiM5IY3/ett50IEt8gHhzgxgys03OYoPt0tQU/FkMuKkNI0xy0z9LQ==
X-Received: by 2002:a5d:8e0d:: with SMTP id e13mr15555692iod.132.1588878255676;
        Thu, 07 May 2020 12:04:15 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u17sm3087269ilb.86.2020.05.07.12.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 12:04:14 -0700 (PDT)
Subject: Re: [PATCH] tools/testing: Replace zero-length array with
 flexible-array
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200507185608.GA14779@embeddedor>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <94b19470-9ade-5fcc-00c7-324056d049de@linuxfoundation.org>
Date:   Thu, 7 May 2020 13:04:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507185608.GA14779@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/7/20 12:56 PM, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>          int stuff;
>          struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   tools/testing/selftests/nsfs/pidns.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/nsfs/pidns.c b/tools/testing/selftests/nsfs/pidns.c
> index e0d86e1668c0..e3c772c6a7c7 100644
> --- a/tools/testing/selftests/nsfs/pidns.c
> +++ b/tools/testing/selftests/nsfs/pidns.c
> @@ -27,7 +27,7 @@
>   #define __stack_aligned__	__attribute__((aligned(16)))
>   struct cr_clone_arg {
>   	char stack[128] __stack_aligned__;
> -	char stack_ptr[0];
> +	char stack_ptr[];
>   };
>   
>   static int child(void *args)
> 

Thanks for the patch. I will pull this in for 5.7-rc6

thanks,
-- Shuah
