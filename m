Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A9D55C7AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jun 2022 14:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241202AbiF1Aoi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jun 2022 20:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241918AbiF1Aoh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jun 2022 20:44:37 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDF71054D;
        Mon, 27 Jun 2022 17:44:33 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e63so10635894pgc.5;
        Mon, 27 Jun 2022 17:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XA7DFTqbr9X5urT3XKeU0YT4OZz2Yx2/K+E0H5pxqfE=;
        b=qRWOKtBs21kkjvVmhO8v/oezgzYMGPFB+giLDOHXweFIiZlnIyKR10b1bFVictRmAI
         K32vbufhybPmwXCXLxV7PNPjZ8O6DGPSncf9jMPIK1bBDOZuw5z3iphMsAujn58s2fmN
         i7OK5TWb2pIVKEQbQklBJSCSP/NkJzkEUHpsvfDiEG5pkMQGSaU6gft8gIIeefffdWcH
         50mjO96+4TjvWdXYvQqgkTQEn0tEEs5AhvBCJuHtxj2MXbbxC+cMjLoVZCwbZRQ1puBs
         Q9WunOwLJ4cZNTQ45ELg/lq9wUe/QvIuoXcdHz0+hoJ5VQbeo6a51xpIMkqTHV8XCPma
         q3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XA7DFTqbr9X5urT3XKeU0YT4OZz2Yx2/K+E0H5pxqfE=;
        b=wSzEmg5oxlLweas8eUUGSr1/HYaOl8kSk0F3ab1eHJc2LNVqJlbPIiZm1ZH6HcY9dz
         1Rc8hxMzVr+cstGueakhkYiItehdk/KCO+GURPoMQgL9NqU5B0C6EvZA9j2alrE9AtKS
         HUzS0yM4wkKhDnHLwjFAby35MTQZVnXF3xZaFvWDKAf0wdDxwwC2evefydTFfIoCm6PW
         Pn00FFr3lf23ELSU77TG3RG5ZJ7DPdVzG7OLH98uNAr++hWBP5IR0Ke63X/RMs8ghrNi
         2yjPO/tofkDG1Sh4N9iDyYq7I05HizF3ihJeH3Z6hy4Zzo2N4URtGIPyA1sNGzaIqNIS
         Gt1g==
X-Gm-Message-State: AJIora+jBzb2TOrckuekUhcOOf+T3PDNaYDjNZ2j1WcnFjgfEFZ4qvsG
        8bj6OwUDupfSHi2n4vd3RQU=
X-Google-Smtp-Source: AGRyM1ssQgNExVuNX4aNgy4TBaSKIIza77cHWO85+n8VIGd+bQ7ZnYUFmfHimDcHshZ7DP629+TH4A==
X-Received: by 2002:a63:8549:0:b0:40d:2864:e3b6 with SMTP id u70-20020a638549000000b0040d2864e3b6mr14928103pgd.301.1656377073325;
        Mon, 27 Jun 2022 17:44:33 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-39.three.co.id. [116.206.12.39])
        by smtp.gmail.com with ESMTPSA id v4-20020a170902b7c400b0016223b5d228sm7765690plz.288.2022.06.27.17.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 17:44:32 -0700 (PDT)
Message-ID: <c32ff56e-b514-cba6-144b-7dcc1d7dc415@gmail.com>
Date:   Tue, 28 Jun 2022 07:44:28 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] Documentation: kunit: Cleanup run_wrapper, fix x-ref
Content-Language: en-US
To:     David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20220626101553.1885428-1-davidgow@google.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220626101553.1885428-1-davidgow@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/26/22 17:15, David Gow wrote:
> +If a special toolchain is required, it can be slightly more complicated:
> +
> +.. code-block:: bash
> +
> +	./tools/testing/kunit/kunit.py run \
> +		--arch=s390 \
> +		--cross_compile=s390x-linux-gnu-
> +

This describes cross-compiling usage, so the text should be "For
cross-compiling, pass --arch and --cross_compile flags:"

-- 
An old man doll... just what I always wanted! - Clara
