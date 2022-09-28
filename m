Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA105EDD28
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Sep 2022 14:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbiI1MvV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Sep 2022 08:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiI1MvT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Sep 2022 08:51:19 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B15425EA8;
        Wed, 28 Sep 2022 05:51:19 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so1613872pjh.3;
        Wed, 28 Sep 2022 05:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=f7TsWwxU/w6JewgZ7REDLJD+bdMWMCvX/uiUT6tA2rg=;
        b=jqXstJ8FNTK8Hqf3RFbWiBqHpZh2yMkTV8/GSaA2vjZ253Y4mX9LIqNdw5jnkk8dNR
         H2E71e67qQhHFRzwGBR8u+Jy+VivAnxwluGAuQfmaZp2nvSNpG7tU0+aZMQMPhFg+HOX
         6q1G1XIfaPaFUpP4ucTm55mluuuTPfCXYbCxt1sxVBMjifTp/W75WJnEb9IG+3VfneQm
         8GEamWvjKrbrwd/D5V/8QE6a5uuo1NLH4uDCQkn5zbi0NyVbCnwLB44MjRmOF88RKUP+
         2oGIuJrQ4Hd7doIcPmWfd+ZmF4FJWX+uUFs8aXbWLQvP4eUi3JwUhyjUrlA2RlXHlQnh
         TILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=f7TsWwxU/w6JewgZ7REDLJD+bdMWMCvX/uiUT6tA2rg=;
        b=3WG0nkuf3P/12M97nFauSVLneKwKvC5U8xbv7jw1zMVK1umhpb14eFD2DDzjBTme38
         vKfl3nCW8KFmnk8+2yKR18/8/+7Zq2fH3I2Bv8WP1pDr3D3SCwxNwr6OFezOVSg/BB+I
         NKuZyGr8YgU2LqxBRsdpo9HaCxArZp+OdhWc9AfiPCjOmAqPvFzS0wbgC+eQGEGzQskY
         Iz8ON+PsxFs0DxMO3aqKhqIiqDqBixArwGRJUPLXlokLn95T01wj4401I4vXi93E6rjW
         XRzpps4pmABQ71nWi5EXei0pYy3zT8FwLUHSE/zd1FL1Bt5yzwL5dhS7+JLWVTQi9Qg/
         qdGQ==
X-Gm-Message-State: ACrzQf0Iz5uYjFt/QqAiwMcIl94dYCSiYisr++AEuRtgfSOA9e0tgjGQ
        9GRprSUG6yIZ4fIpLRBR/bw=
X-Google-Smtp-Source: AMsMyM5WOS+DCvN6NZXTPIlyPGCHbxRC+zo9UUtJ2o1T1/nPGcvDzOaypZEUfsU1fY/ELxhNl+aRaA==
X-Received: by 2002:a17:902:d4c3:b0:178:1d5b:fb10 with SMTP id o3-20020a170902d4c300b001781d5bfb10mr32649954plg.108.1664369478601;
        Wed, 28 Sep 2022 05:51:18 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-28.three.co.id. [116.206.28.28])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902eccc00b0015e8d4eb219sm3714032plh.99.2022.09.28.05.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 05:51:17 -0700 (PDT)
Message-ID: <be928578-6453-5cf1-32da-322aebe2cee5@gmail.com>
Date:   Wed, 28 Sep 2022 19:51:09 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] Documentation: Kunit: Use full path to .kunitconfig
Content-Language: en-US
To:     Khalid Masum <khalid.masum.92@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220928040058.37422-1-khalid.masum.92@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220928040058.37422-1-khalid.masum.92@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/28/22 11:00, Khalid Masum wrote:
> The numbered list contains full path to every files that need to be
> modified or created in order to implement misc-example kunit test.
> Except for .kunitconfig. Which might make a newcommer confused about
> where the file exists. Since there are multiple .kunitconfig files.
> 
> Fix this by using the full path to .kunitconfig.
> 

Better say:

```
The fourth list item on writing test cases instructs adding Kconfig
fragments to .kunitconfig, which should have been full path to the file
(.kunit/.kunitconfig).
```

> -4. Add the following lines to ``.kunitconfig``:
> +4. Add the following lines to ``.kunit/.kunitconfig``:
>  
>  .. code-block:: none
>  

I think "Add the following lines" should be changed to something more
descriptive in regards to what these lines are about (which in this
case should be "Add following configuration fragments").

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
