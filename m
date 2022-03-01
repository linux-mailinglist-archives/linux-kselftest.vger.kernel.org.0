Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A6F4C8F16
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Mar 2022 16:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbiCAPaH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Mar 2022 10:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbiCAPaG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Mar 2022 10:30:06 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B1317078
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Mar 2022 07:29:20 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id c18so18818628ioc.6
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Mar 2022 07:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JLpzyiylffXpYKOI4/wAJpbR1EAOvSqSarR62ILfzxg=;
        b=h/wWCF7mJ71VhkAmufHh/jZRBTnW8Ap+8K0IssvuDfBRN/sRD4jRPUFLvR6LmX84e9
         GswDevPUad3Q4j2uZ2lre3MssU18K2ziQWstwFFOCKPyTqG0uDg8EFFEQ2SM8tVb1jIN
         TykcNl20dBaBkYEzkHTvxxQSyK5anbq4ZVe+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JLpzyiylffXpYKOI4/wAJpbR1EAOvSqSarR62ILfzxg=;
        b=QWMryVv5DoPd18Q04GclueFYfzQpridbcwVP7hK6/pIayuBtqzXJT9Fdh1LCt6gOBb
         jsf7CKmZLgGzsQmoahqg024NxUWlHT+TvxhnuvsbUjOO2SfT3SsKpEWp/BmlMD331koH
         ANi6NtvyKpHXnUfWXKOlGy7KtlVREIKZf8Nm07L1QiGA5JEsOyn/r+B326Cw2l4YHe9o
         PuEWMT8ibV9qgEJIRwEYsUbMdtrFS0rbGGXlrUr6XBPLP+ubBFhVZe82abxanhXKTGVv
         Ytc6QbCvxxaA7zQIoRfXN0cg+8XUjHkhRDTtbttJNsSFFapIPwvzxuaRbUGqOpeAQsYi
         ZDQw==
X-Gm-Message-State: AOAM531cQ5VTxmD1fWrQvSR0vrYD0WX1K1+sZbpB49GKFXojp312Svuc
        Xz3OnD+wN7+3Gays0Q0+8fwjFg==
X-Google-Smtp-Source: ABdhPJyItWAaR2S2fFhZiwhlqaYDrGakTJS0a+yeNdq+94aUuWcwG7Z8OmCFwTybYus7Kg+BORZ8Mw==
X-Received: by 2002:a5e:df41:0:b0:642:8c0:ce78 with SMTP id g1-20020a5edf41000000b0064208c0ce78mr18726025ioq.142.1646148560263;
        Tue, 01 Mar 2022 07:29:20 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id i16-20020a056e02055000b002c2877213bdsm8118473ils.3.2022.03.01.07.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 07:29:19 -0800 (PST)
Subject: Re: [PATCH] selftests: vm: remove duplicated macro and use swap() to
 make code cleaner
To:     cgel.zte@gmail.com, akpm@linux-foundation.org
Cc:     shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lv Ruyi (CGEL ZTE)" <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220301014404.2052655-1-lv.ruyi@zte.com.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9d6ae3b1-3f36-8196-c136-fa2d07dbca5d@linuxfoundation.org>
Date:   Tue, 1 Mar 2022 08:29:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220301014404.2052655-1-lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/28/22 6:44 PM, cgel.zte@gmail.com wrote:
> From: "Lv Ruyi (CGEL ZTE)" <lv.ruyi@zte.com.cn>
> 
> The macro is duplicated, so remove one. And use swap to make code cleaner.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi (CGEL ZTE) <lv.ruyi@zte.com.cn>
> ---
>   tools/testing/selftests/vm/userfaultfd.c | 13 ++-----------
>   1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index ab394e6bff43..100f08362164 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -121,9 +121,6 @@ struct uffd_stats {
>   #define swap(a, b) \
>   	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
>   
> -#define swap(a, b) \
> -	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
> -
>   const char *examples =
>       "# Run anonymous memory test on 100MiB region with 99999 bounces:\n"
>       "./userfaultfd anon 100 99999\n\n"
> @@ -1424,7 +1421,6 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
>   static int userfaultfd_stress(void)
>   {
>   	void *area;
> -	char *tmp_area;
>   	unsigned long nr;
>   	struct uffdio_register uffdio_register;
>   	struct uffd_stats uffd_stats[nr_cpus];
> @@ -1535,13 +1531,8 @@ static int userfaultfd_stress(void)
>   					    count_verify[nr], nr);
>   
>   		/* prepare next bounce */
> -		tmp_area = area_src;
> -		area_src = area_dst;
> -		area_dst = tmp_area;
> -
> -		tmp_area = area_src_alias;
> -		area_src_alias = area_dst_alias;
> -		area_dst_alias = tmp_area;
> +		swap(area_src, area_dst);
> +		swap(area_src_alias, area_dst_alias);

Where is swap() defined? Does this patch compile? I reverted a
change like this one reported by Zeal Robot recently. Let's
make sure this change compiles and runs.

>   
>   		uffd_stats_report(uffd_stats, nr_cpus);
>   	}
> 

thanks,
-- Shuah
