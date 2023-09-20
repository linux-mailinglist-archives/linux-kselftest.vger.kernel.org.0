Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D717A79EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 13:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbjITLBU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 07:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbjITLBU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 07:01:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32601D3
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 04:01:14 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52c4d3ff424so8393265a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 04:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695207672; x=1695812472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fFCnzCVFLsbuhvtZ9EHw9SNjPT4ld8559k/OSp8m+oI=;
        b=0znRomiutZ2eIGc65iJ/S7ilbpslzEmVEOOVmqie/ulpkTpD0kFFdccUKxRqJL4+rt
         LXxHLipcu0e5avdRoEAkO/2pU7tZt1N9CpYQwpj6CzSO9peXSehnNNrNovnT/yapd3tu
         7DAPbecOOwVyZWkKMoGXvc5+WQDUls9Q0AsV51/MALOvqp0CH2jqa28xWb/aXGjM5ZvF
         cTWnUBfv7+CdLZ/aADHKKE3z2z7R9swELk8P4bEPaEY7TXMie/gIVPFAdQOt7QCkgGpK
         n8HsqASiz7S2caHNhmVjX4IjkDFviRLf3b30onCvrubo6wQTR7Ku2Y+PLlTKUW7NJkMI
         ZUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695207672; x=1695812472;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fFCnzCVFLsbuhvtZ9EHw9SNjPT4ld8559k/OSp8m+oI=;
        b=RfqqXSH7/pXhA3zlNpEAf1zSIIQ0glTTlgK8UggeEyJXXqDzwzkTQm4mR61l2oM120
         dUsSuCYQYEl6qj5lQEq/M7mok2T/DeMlCd5etlGdxmZ59s0Zh4f98Hy2k8SePtyX/qm3
         vrR0AviLRmH61CbKK+DwqpLaQZhXjwaa3Y2vi7X55zhav5sRpXJKodHBvKN6tS20f1Qu
         QzBB4hs9nrcCU0JzEJXuE9Xc9djSvKgtlk1ygkLZ43YyuBkctpauj0luU1VeXCMg+TbW
         ymIuPIYHADcMOZ6MY44dmkDkl82D1zPyQAeHOwBILv9oYOHqG6ctXsyXYxK5A1HRYXiO
         G9Ug==
X-Gm-Message-State: AOJu0YwqsReJzeo3w94wO2KjX8KAtfd2RQ9jUCJJVlnZIC7vS70ubnVa
        XT1GtIwjAVM7dUcYufs0ZsBFaA==
X-Google-Smtp-Source: AGHT+IG3UkUHhXRFKHx1etLPK3jZZNjDhVAwE4UIfgjnZzVOtLR39Gca5U0GPsI8uvAEiDai68jh1Q==
X-Received: by 2002:a17:907:a087:b0:9aa:186:959a with SMTP id hu7-20020a170907a08700b009aa0186959amr1644862ejc.31.1695207672595;
        Wed, 20 Sep 2023 04:01:12 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id o2-20020a1709062e8200b009ad8338aafasm9320070eji.13.2023.09.20.04.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 04:01:12 -0700 (PDT)
Message-ID: <e1c0f5ac-a0bc-dc2c-0638-c580498670e4@blackwall.org>
Date:   Wed, 20 Sep 2023 14:01:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next v4 6/6] selftests: forwarding:
 bridge_fdb_learning_limit: Add a new selftest
Content-Language: en-US
To:     Johannes Nixdorf <jnixdorf-oss@avm.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-6-39f0293807b8@avm.de>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230919-fdb_limit-v4-6-39f0293807b8@avm.de>
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

On 9/19/23 11:12, Johannes Nixdorf wrote:
> Add a suite covering the fdb_n_learned and fdb_max_learned bridge
> features, touching all special cases in accounting at least once.
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> ---
>   tools/testing/selftests/net/forwarding/Makefile    |   3 +-
>   .../net/forwarding/bridge_fdb_learning_limit.sh    | 283 +++++++++++++++++++++
>   2 files changed, 285 insertions(+), 1 deletion(-)
> 

Always nice to see new tests. Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


