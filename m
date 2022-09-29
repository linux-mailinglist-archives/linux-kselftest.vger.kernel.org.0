Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36275EF5EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Sep 2022 15:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbiI2NB0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Sep 2022 09:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbiI2NBU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Sep 2022 09:01:20 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2EB1138E4;
        Thu, 29 Sep 2022 06:01:19 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a29so1381540pfk.5;
        Thu, 29 Sep 2022 06:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=IBZE1hFfhBGN3UywvDFOxrxFFMC7GkT93wKps7ObEyo=;
        b=bSUqoliqIKzIQSfn4j/ybe5t18kl4PMccoPLTaLm+iOFeymFXcqx57dk027sgeoqfp
         uh8KPj2/vSH10NNistKFI88UIVX7RQDziTWOwXRI4MNzVByTN/flOV4LjtHb5PJrSvTr
         9FOQ66MDYcWLEdWIkm9gFjEFuZMdOjCKNAAwPCjlfScnxVZR8qZGbxZaP8Q7jRPh1bua
         I8czg8VukJD11kNDlBagnIaa+mpybXNktErreHcUVP4v3ybWPb19MCjPRHBQcHsMf8ew
         /gsxjE+XFSzWB9LRh1bpgPRMFjssd4atXYI7wtJ1TYE83r9UuTkwg13W7BWdrkSL69br
         Twdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IBZE1hFfhBGN3UywvDFOxrxFFMC7GkT93wKps7ObEyo=;
        b=tNq4ZJ5npRx/o5oz4rd5ePIfu25kaBPMy//aI8W2rUHkftXDLsX6zMN08MAA/zKtRF
         dv93ElsZTM2YF+SKLJB/gY1+E7cjzul036hKZSNv15SUcvfIXxMPa9saN4Pepn8H0jwt
         jMo2QATLReSzMdv1aYCQOkLSEYzT6hpbiSwGMRCRl1WUkWc9BMpYyPPsCecKp/st+2sd
         Oql38ehCgEi++sgZjMe6nKH6EnimXRtgjXJRmnR4hxJPH7c4ykJdmpOTdGJ33lX5ia3S
         XahKp595yixD4lyieVZeebNT6i0a0Xy4ismK+cCWegC+MoBqqo45RicWOztaXeVrbOmm
         jXYw==
X-Gm-Message-State: ACrzQf1JVM/zYnTFIikPOqaEkrvHYhPowoRy3EzLt/LcIM5uxsSnLLsJ
        Rmsg3NTgpP4u34sB4GBeHLii+RT38ImjyA==
X-Google-Smtp-Source: AMsMyM5FN5a727uJ0p9wFhcFR4cJT5yuVdgH9rrTUo5YNQEnIpH1p8u5kVRLprTieR/CxXAuhF6YFQ==
X-Received: by 2002:a05:6a00:16c4:b0:535:890:d52 with SMTP id l4-20020a056a0016c400b0053508900d52mr3489010pfc.9.1664456478438;
        Thu, 29 Sep 2022 06:01:18 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-55.three.co.id. [116.206.28.55])
        by smtp.gmail.com with ESMTPSA id z15-20020a63e10f000000b004340d105fd4sm5550315pgh.21.2022.09.29.06.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 06:01:18 -0700 (PDT)
Message-ID: <a0545ea0-2ce5-68d1-4cbd-bfaa3ff453b5@gmail.com>
Date:   Thu, 29 Sep 2022 20:00:40 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] Documentation: kunit: rewrite writing first test
 instructions
Content-Language: en-US
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Khalid Masum <khalid.masum.92@gmail.com>,
        Sadiya Kazi <sadiyakazi@google.com>
References: <20220929125458.52979-1-bagasdotme@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220929125458.52979-1-bagasdotme@gmail.com>
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

On 9/29/22 19:54, Bagas Sanjaya wrote:
>  Writing Your First Test
>  =======================
> -In your kernel repository, let's add some code that we can test.
> +In your kernel repository, let's add some code that we can test. For this
> +purpose, we are going to add simple addition driver.
>  
> -1. Create a file ``drivers/misc/example.h``, which includes:
> +1. Write the feature that will be tested. First, write the declaration
> +   for ``misc_example_add()`` in ``drivers/misc/example.h``:
>  
> -.. code-block:: c
> +   .. code-block:: c
>  
>  	int misc_example_add(int left, int right);
>  
> -2. Create a file ``drivers/misc/example.c``, which includes:
> +   Then implement the function in ``drivers/misc/example.c``:
>  
> -.. code-block:: c
> +   .. code-block:: c
>  
>  	#include <linux/errno.h>
>  
> @@ -152,24 +154,25 @@ In your kernel repository, let's add some code that we can test.
>  		return left + right;
>  	}
>  
> -3. Add the following lines to ``drivers/misc/Kconfig``:
> +3. Add Kconfig menu entry for the feature to ``drivers/misc/Kconfig``:
>  

The numbering looks jumped. Please ignore this patch as I'll resend shortly.

-- 
An old man doll... just what I always wanted! - Clara
