Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7C210A784
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2019 01:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfK0AdG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Nov 2019 19:33:06 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33066 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfK0AdG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Nov 2019 19:33:06 -0500
Received: by mail-io1-f66.google.com with SMTP id j13so22865168ioe.0
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Nov 2019 16:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zkJ+1YZ12dyKxvf1FEiFS42XMH3hvkZb3rnIHE1McJw=;
        b=ZWWbUs6B+DYR9eFCLz9tEL3Li/ZDFZq5fQKXSOG4oLIoDrtTV5KbMqX0/EfpSrrw1O
         fLsQ+/ED919boJLaVd7KfCZXeMCfq6/ga5FRDfQidty3ec3cqoMb2DQAKrJIqT49Bzx/
         aYPuUxUZ3/VK5gty4VPMnx1NljrXhdSRFTz0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zkJ+1YZ12dyKxvf1FEiFS42XMH3hvkZb3rnIHE1McJw=;
        b=s40la8SFHuFw1AiksNKCTQhLmPJwCr51diVg+jv/p2deyotG3NosNgimjfzpsyKg6E
         5XCKezBf2kxizK5B5/u23NFXRFEDevShSwtCoSiUfpqJX9ALBGKUZE84stMq3C/uqAtD
         yxE7yXOdH5lJHMcMfQGiWP3p5IMTDbYW6i4sT4ZyIVJxEcna0NXuBHhDi3vLMYDjQLKY
         swODCSqX7RAysT3Qq6oxgeN2OcfAKGYwzYCThgX9iS75pamj66EzIbhd1Pj0CKQKBcR9
         wxj2U3yk5Yeizm7PxSNdF/iUJSOanJl6iIKvVzFFpK0LvqJ5SKGy5HuVO5DT7pqdjIQh
         pRcg==
X-Gm-Message-State: APjAAAVKIL7jdHlltmX1fMR5tZwuUnoRUtoG0rNDoRDVYM+NN6LFLWLo
        lEgUpeKaPj2IgW7CmJC/vvHrFob+mTw=
X-Google-Smtp-Source: APXvYqybjLh/4bVvgCkGZ4FY8OUKcM8i8Ghxufp5Uw93bnv/klz3SQHO8hoWPSJAClwMMh/OJWdZVA==
X-Received: by 2002:a6b:c389:: with SMTP id t131mr34249670iof.50.1574814785531;
        Tue, 26 Nov 2019 16:33:05 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e5sm3711298ilq.77.2019.11.26.16.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2019 16:33:04 -0800 (PST)
Subject: Re: [PATCH] fs/ext4/inode-test: Fix inode test on 32 bit platforms.
To:     Iurii Zaikin <yzaikin@google.com>, brendanhiggins@google.com,
        tytso@mit.edu, geert@linux-m68k.org
Cc:     linux-ext4@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20191127001023.63271-1-yzaikin@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <41d22ac8-7907-6bcf-883f-27518506b87f@linuxfoundation.org>
Date:   Tue, 26 Nov 2019 17:33:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191127001023.63271-1-yzaikin@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/26/19 5:10 PM, Iurii Zaikin wrote:
> Fixes the issue caused by the fact that in C in the expression
> of the form -1234L only 1234L is the actual literal, the unary
> minus is an operation applied to the literal. Which means that
> to express the lower bound for the type one has to negate the
> upper bound and subtract 1.
> 
> Signed-off-by: Iurii Zaikin <yzaikin@google.com>

Thanks for sending the patch quickly.

Please add Reported-by for Geert and also include the error he is
seeing in the commit log.
> ---
>   fs/ext4/inode-test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
> index 92a9da1774aa..bbce1c328d85 100644
> --- a/fs/ext4/inode-test.c
> +++ b/fs/ext4/inode-test.c
> @@ -25,7 +25,7 @@
>    * For constructing the negative timestamp lower bound value.
>    * binary: 10000000 00000000 00000000 00000000
>    */
> -#define LOWER_MSB_1 (-0x80000000L)
> +#define LOWER_MSB_1 (-(UPPER_MSB_0) - 1L)  /* avoid overflow */
>   /*
>    * For constructing the negative timestamp upper bound value.
>    * binary: 11111111 11111111 11111111 11111111
> --
> 2.24.0.432.g9d3f5f5b63-goog
> 

thanks,
-- Shuah
