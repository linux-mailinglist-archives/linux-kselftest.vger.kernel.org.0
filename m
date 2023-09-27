Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2407AFDB7
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 10:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjI0ILC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 04:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjI0IK7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 04:10:59 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FE91AC
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Sep 2023 01:10:54 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3215f19a13aso10382356f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Sep 2023 01:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695802252; x=1696407052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBmOuCvdW9NVL1Xq7Sds9uqW+w+rqXLS8qDFF1herE8=;
        b=wplplTF1qcvKMbJrwn1Up67yl4q8GxN9VnoEY272AHk86WK/sOU4wbRm4Y9FAogAoQ
         eImV/fbNYtpo2HL0K7yxzJyKyTPKeDaTCSCf4AQrkEzFyA2RuPy3u76vQ8fIfB8Z0Iuf
         /t5SQ3aQmPr61OTfAYiTa2RZQOs7+WJf8p+VfuMaIrVh6VglkS7o0pbKgUkjKz7+pjxL
         rmbL/QW49h5uqH2X8F3ooS6BuGhYhXvf/UmJaR0maQ99yYEFX0tM0csmjJkNSY58EKB6
         RIXGd79Xxyp+k+NPsDDPZey3GRYQHx9/IRCUCUc8qxNFdAeh3POlzRgwQtOE9rRu6qYb
         CMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695802252; x=1696407052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBmOuCvdW9NVL1Xq7Sds9uqW+w+rqXLS8qDFF1herE8=;
        b=JGf2aXEB0ogTpveaLDDG3GNZJShSZYKxVA53c/r2Pnl5kUiECzF1cskMGsQYtIbV2Z
         ayw9OQzyJAgZSgMQBvNn8C4H35dnvgZdg57Vj/XQOxIQfo94SWK/kT4gvagXuPyP0lLx
         nrNyH5aLg38yVBcQrkbojk0ph3YOBCcLd3O3Q6ruBjlv2nL4vFfA7BTMio1AUpNi6sgd
         9Kpx+vTVhqUPq1LVtDmhuYSE1saEwohrTDqeSok5w8GOr/QCf8wjVdFSxQ8y7Hx7lnPo
         Y6KcSktD6fNc/aE01f3isHzC1Os8r59PSjmBlewUAB55Nj4pmLrEqa4uU7YVTSoXT8yG
         GgTA==
X-Gm-Message-State: AOJu0YysTlwSq9p0oFdSX648pe1mQRPzmfOTE7ENkwJlhqyK1/uizvBc
        ZdqypXC+YmfGDTnbVetfBJ2ceg==
X-Google-Smtp-Source: AGHT+IEKTsuknU2uuQEZaxLZtK8OwodOqhENja8RJX6uJxZpy29yQQXcdMSM3cppVDtiu8cEn9yLww==
X-Received: by 2002:adf:fe49:0:b0:314:350a:6912 with SMTP id m9-20020adffe49000000b00314350a6912mr1190372wrs.36.1695802252428;
        Wed, 27 Sep 2023 01:10:52 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id m16-20020a056000009000b0031c71693449sm16622619wrx.1.2023.09.27.01.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 01:10:52 -0700 (PDT)
Message-ID: <3dccacd8-4249-87f8-690c-6083374dc9d1@blackwall.org>
Date:   Wed, 27 Sep 2023 11:10:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] bridge: MTU auto tuning ignores IFLA_MTU on NEWLINK
Content-Language: en-US
To:     Trent Lloyd <trent.lloyd@canonical.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230927075713.1253681-1-trent.lloyd@canonical.com>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230927075713.1253681-1-trent.lloyd@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/27/23 10:57, Trent Lloyd wrote:
> Commit 804b854d374e ("net: bridge: disable bridge MTU auto tuning if it
> was set manually") disabled auto-tuning of the bridge MTU when the MTU
> was explicitly set by the user, however that would only happen when the
> MTU was set after creation. This commit ensures auto-tuning is also
> disabled when the MTU is set during bridge creation.
> 
> Currently when the br_netdev_ops br_change_mtu function is called, the
> flag BROPT_MTU_SET_BY_USER is set. However this function is only called
> when the MTU is changed after interface creation and is not called if
> the MTU is specified during creation with IFLA_MTU (br_dev_newlink).
> 
> br_change_mtu also does not get called if the MTU is set to the same
> value it currently has, which makes it difficult to work around this
> issue (especially for the default MTU of 1500) as you have to first
> change the MTU to some other value and then back to the desired value.
> 

Yep, I think I also described this in the commit message of my patch.

> Add new selftests to ensure the bridge MTU is handled correctly:
>   - Bridge created with user-specified MTU (1500)
>   - Bridge created with user-specified MTU (2000)
>   - Bridge created without user-specified MTU
>   - Bridge created with user-specified MTU set after creation (2000)
> 
> Regression risk: Any workload which erroneously specified an MTU during
> creation but accidentally relied upon auto-tuning to a different value
> may be broken by this change.
> 

Hmm, you're right. There's a risk of regression. Also it acts 
differently when set to 1500 as you've mentioned. I think they should 
act the same, also bridge's fake rtable RTAX_MTU is not set.

> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2034099
> Fixes: 804b854d374e ("net: bridge: disable bridge MTU auto tuning if it was set manually")
> Signed-off-by: Trent Lloyd <trent.lloyd@canonical.com>
> ---

