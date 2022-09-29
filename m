Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353EF5EF5DC
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Sep 2022 14:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiI2M6G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Sep 2022 08:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbiI2M6F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Sep 2022 08:58:05 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509F71684ED;
        Thu, 29 Sep 2022 05:58:04 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 129so1380150pgc.5;
        Thu, 29 Sep 2022 05:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=3YFANs5KOBBvjTf0E3nXBdofeBJevKykUZZCZ3oiBSE=;
        b=KBDfIxCUnv/KK5ZKEau7sPU8QDp/Cpf3WFuBZhYp+eWQYP1l6NyM4EzsCEQ7AKTWo+
         sRUigibTuwd4oRiW8sQfe2Xdcs6sjI5v6zIXjjyrmP07SMpczd6cQsuANQgPSnmU10ZV
         avaHZSjfD+myi7RBTULpGLewx9508pMcW14wj/ybMJDByT6g4unGKlWt7ScMfvPcVyL5
         zs9uaKA+48d6TighEUA6mQYaUQGa46UAXjCZNpTfa7KSo6R+iJd6/MYb510nWR9+Nys8
         ZCsLzoXwbCabwFczTsNYJCdugD4zY37z4xZeUXNN6OJcOZWpyBiJaTQtM4Wtrlxru9sR
         qv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3YFANs5KOBBvjTf0E3nXBdofeBJevKykUZZCZ3oiBSE=;
        b=A17xmhnRpPEIxsOEl/XrazW6UmarsbVeL8CmRhKyALxxIQ7gjpW078rQuT3b143CkC
         ruC9KZdU14GPaDL0wxLgWJz6fWwCDxpwd7tQUKfHb9nN1q11RkNj3u+tNZo7zKDBdnrs
         ZBQGaxIC01h5mjRXtrPqD1qW69Cpy2IvK1NLmXcSWkCj9YWxuAprPYlp6fo5z3vLioNS
         F4cvoJYCxECMr7o31H5FIs/nUL63uTuXbXdKdq73hrOh7AO4NNI9knETT/m5KC3gsgHP
         6Wu+HQ7OZxyKjfM3rSL3zSmNlothYjryhn/1/Srq0Whux8e65CgDPM6Vr7OCBpYPRj8I
         UTKg==
X-Gm-Message-State: ACrzQf0UCvO5QXufG9h6ZQnPoibUG438/IWj8XMl1lmXbIeAfA46VMlv
        C2INlXsFeDgoOccccu7TeFI=
X-Google-Smtp-Source: AMsMyM6B3vttmenuE5dtCT96heOK6boTPtp9W4yf6L3Wa5MBGIfrgfdkXML9rOPYCd1doLcBpG//Ug==
X-Received: by 2002:a65:6e05:0:b0:439:ebfb:1169 with SMTP id bd5-20020a656e05000000b00439ebfb1169mr2781927pgb.492.1664456283823;
        Thu, 29 Sep 2022 05:58:03 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-55.three.co.id. [116.206.28.55])
        by smtp.gmail.com with ESMTPSA id u8-20020a170903124800b00178b717a143sm6010566plh.126.2022.09.29.05.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 05:58:03 -0700 (PDT)
Message-ID: <af104afb-7273-bdb9-9f8f-9f5c80fd2f7c@gmail.com>
Date:   Thu, 29 Sep 2022 19:57:59 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] Documentation: Kunit: Use full path to .kunitconfig
Content-Language: en-US
To:     Khalid Masum <khalid.masum.92@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sadiya Kazi <sadiyakazi@google.com>
References: <20220929085332.4155-1-khalid.masum.92@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220929085332.4155-1-khalid.masum.92@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/29/22 15:53, Khalid Masum wrote:
> The fourth list item on writing test cases instructs adding Kconfig
> fragments to .kunitconfig, which should have been full path to the file
> (.kunit/.kunitconfig).
> 
> Cc: Sadiya Kazi <sadiyakazi@google.com>
> Cc: David Gow <davidgow@google.com>
> Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
> ---
> Changes since v1:
> - Update commit message
> - Make the instruction more descriptive
> 
>  Documentation/dev-tools/kunit/start.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index 867a4bba6bf6..69361065cda6 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -217,7 +217,7 @@ Now we are ready to write the test cases.
>  
>  	obj-$(CONFIG_MISC_EXAMPLE_TEST) += example_test.o
>  
> -4. Add the following lines to ``.kunitconfig``:
> +4. Add following configuration fragments to ``.kunit/.kunitconfig``:
>  
>  .. code-block:: none
>  

Looks OK, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
