Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F99177E75F
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 19:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345131AbjHPROc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 13:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345164AbjHPROR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 13:14:17 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C95526A4
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 10:14:14 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-34a99690da7so649795ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 10:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692206053; x=1692810853;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bClHJc1J09Uc597SKqIse7SwNgjMDo77yl9cKdngn9U=;
        b=DXtlJjZUp2yZCW7rYDuyQyY/VXeK1fLyOGPHYMN3WPoUPLdyMOyqdK7Fr8rjhkw+PS
         nPlufPtvLecFrzr25J/fklFN09Om16H3OYExbNY3VFtVfbJ4pxIU7gUNcV2uY2YUWJDo
         ZrvHgKxNd+8PhFmOzx3fJ+hfzEfkslslI7igE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692206053; x=1692810853;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bClHJc1J09Uc597SKqIse7SwNgjMDo77yl9cKdngn9U=;
        b=jcX8Z8k1hPeiUfzjO6TwYnrCIgkr/bV3IArEGqAEBbEJYZ4kjqORK9V/Xm5hPCvQVn
         6Mkk/uelu+j3tdRRgbNtiZrfLiJPcbjtU/Aj76EE9hkLPnNaxeQP6skoMoZ7J2uYM6iq
         b6Z/emqZypfl7fyGjO/vwW5Em1GO1tY+ZH7siY2TwIc0c06a5xIxSQ1ceouBAeBPkfZ3
         zA11OkUriyjk7tjWcJpdO/WruBUbZmFoNhGUpp0gSVgyhpXtTertT/EK6NGTL43KIg3K
         4RoGivgE1L7/Jm+dV/B0TPB2uFyr6OHPYSki+BBOWZtRe+VBihqwWmaD3xubzWq0upuc
         o8LA==
X-Gm-Message-State: AOJu0YxkQkOPmk9c4w3L0dZpY2CihnBlnUuQqxKXxf3ZI6y8J+3rJkit
        THB45B/g7uEdVyxd5tZgKVhuFQ==
X-Google-Smtp-Source: AGHT+IGmANeZ6j/J0szq/EhG3Ckfna1QYShnyfqDtKVX0ELxpzdZHjr0F7+ELeUG7nsvIrvSOF3MKA==
X-Received: by 2002:a92:cf4a:0:b0:341:c98a:529 with SMTP id c10-20020a92cf4a000000b00341c98a0529mr3482713ilr.0.1692206053696;
        Wed, 16 Aug 2023 10:14:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id n2-20020a92dd02000000b00348880831fdsm4678665ilm.58.2023.08.16.10.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 10:14:13 -0700 (PDT)
Message-ID: <111cdd72-05bc-5811-092f-419937a9f1e0@linuxfoundation.org>
Date:   Wed, 16 Aug 2023 11:14:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] selftests: cachestat: properly link in librt
Content-Language: en-US
To:     Andre Przywara <andre.przywara@arm.com>,
        Shuah Khan <shuah@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230815155612.2535947-1-andre.przywara@arm.com>
 <20230815155612.2535947-2-andre.przywara@arm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230815155612.2535947-2-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/15/23 09:56, Andre Przywara wrote:
> Libraries should be listed last on the compiler's command line, so that
> the linker can look for and find still unresolved symbols. The librt
> library, required for the shm_* functions, was announced using CFLAGS,
> which puts the library *before* the source files, and fails compilation
> on my system:
> ======================
> gcc -isystem /src/linux-selftests/usr/include -Wall -lrt test_cachestat.c
>    -o /src/linux-selftests/kselftest/cachestat/test_cachestat
> /usr/bin/ld: /tmp/cceQWO3u.o: in function `test_cachestat_shmem':
> test_cachestat.c:(.text+0x890): undefined reference to `shm_open'
> /usr/bin/ld: test_cachestat.c:(.text+0x99c): undefined reference to `shm_unlink'
> collect2: error: ld returned 1 exit status
> make[4]: *** [../lib.mk:181: /src/linux-selftests/kselftest/cachestat/test_cachestat] Error 1
> ======================
> 
> Announce the library using the LDLIBS variable, which ensures the proper
> ordering on the command line.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>   tools/testing/selftests/cachestat/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/cachestat/Makefile b/tools/testing/selftests/cachestat/Makefile
> index fca73aaa7d141..778b54ebb0364 100644
> --- a/tools/testing/selftests/cachestat/Makefile
> +++ b/tools/testing/selftests/cachestat/Makefile
> @@ -3,6 +3,6 @@ TEST_GEN_PROGS := test_cachestat
>   
>   CFLAGS += $(KHDR_INCLUDES)
>   CFLAGS += -Wall
> -CFLAGS += -lrt
> +LDLIBS += -lrt
>   
>   include ../lib.mk

Thank you. Applied to linux-kselftest next for Linux 6.6-rc1

thanks,
-- Shuah

