Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB526F1301
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Apr 2023 10:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345789AbjD1IJW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Apr 2023 04:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345483AbjD1IJL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Apr 2023 04:09:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF2430F4;
        Fri, 28 Apr 2023 01:09:09 -0700 (PDT)
Received: from [192.168.10.39] (unknown [39.37.187.173])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2791266032C3;
        Fri, 28 Apr 2023 09:09:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682669347;
        bh=j90SNX8gDxgMch3e8i0rNxBg5i2HnX4rEsOIw0VxQug=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=nI15zjo251FRTC5y40Ph5kANUL6OpwjTQHhBiCc1uYNex6zMsiHvISoE8uCrrfUDO
         CZnVGzeLa5xN2QyYXcoIMztjkby06Zm8lyrvdYl03Wv78nYdfG7+cLw3Bc7PEbKdyJ
         Wwekx7SqPnqQXON2mPROfZV+pjJvaPBOrV7zrvrWwJMuBoHDg9gVNYDqMMX8n7UAK+
         UEpK8FZlXwJOytRYk80h1vkjDKl6Odzin94OAbo8/pkXzvQaAFQSqVmO9XfPBiNy+Y
         hTUKl2JvxqKfdSiijdFoFtMUHNftbg8e0JO6bMfryIgGK9/jvAslyRWk/1XTeQsfbA
         5zW4Nyd2rTyQw==
Message-ID: <b0af0f17-907c-3905-faf8-1c1e43acbca2@collabora.com>
Date:   Fri, 28 Apr 2023 13:09:00 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/powerpc: Replace obsolete memalign() with
 posix_memalign()
Content-Language: en-US
To:     Deming Wang <wangdeming@inspur.com>, mpe@ellerman.id.au,
        shuah@kernel.org
References: <20230413010250.4254-1-wangdeming@inspur.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230413010250.4254-1-wangdeming@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/13/23 6:02 AM, Deming Wang wrote:
> memalign() is obsolete according to its manpage.
> 
> Replace memalign() with posix_memalign() and remove malloc.h include
> that was there for memalign().
Thanks for the patch.

> 
> As a pointer is passed into posix_memalign(), initialize *s to NULL
I'm unable to find this initialization below. Did you really mean to add
the initialization?

> to silence a warning about the function's return value being used as
> uninitialized (which is not valid anyway because the error is properly
> checked before s is returned).
> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>  tools/testing/selftests/powerpc/stringloops/strlen.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/powerpc/stringloops/strlen.c b/tools/testing/selftests/powerpc/stringloops/strlen.c
> index 9055ebc484d0..f9c1f9cc2d32 100644
> --- a/tools/testing/selftests/powerpc/stringloops/strlen.c
> +++ b/tools/testing/selftests/powerpc/stringloops/strlen.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <malloc.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <time.h>
> @@ -51,10 +50,11 @@ static void bench_test(char *s)
>  static int testcase(void)
>  {
>  	char *s;
> +	int ret;
>  	unsigned long i;
>  
> -	s = memalign(128, SIZE);
> -	if (!s) {
> +	ret = posix_memalign((void **)&s, 128, SIZE);
> +	if (ret < 0) {
Can we do if (!ret) instead? The page says:
posix_memalign()  returns zero on success.
>  		perror("memalign");
>  		exit(1);
>  	}

-- 
BR,
Muhammad Usama Anjum
