Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D6C6AA097
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Mar 2023 21:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjCCU21 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Mar 2023 15:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjCCU20 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Mar 2023 15:28:26 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B33EF84
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Mar 2023 12:28:26 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id y14so2459118ilv.4
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Mar 2023 12:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1677875305;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7OqW9dETXddeF5fbNy2PbIT1mlnFH0XrIUOKKq1M14U=;
        b=NEROJfTxoQAz0iRImGyfO0Wj7JYu5c9NJvl3eR8Grt6zYNTR2ieuhNnq7VgRbzdTWr
         IMMzK73uWQEhCRETrcGlsinmBun2WgwmzYt6SBwhUgrTkOXGXK8iSnWtwTl/pHEQIVCj
         Sw2z9W6v2v9yKFR9bOD8jCsbaQsm6vvdR9rUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677875305;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OqW9dETXddeF5fbNy2PbIT1mlnFH0XrIUOKKq1M14U=;
        b=xnB9I4C1shzu03qqf5nRHbeuJX1OI4GvTj7+2YDpeCdTXHYx92uBAA/Frl19yqpBs5
         CVLTAYCgjywUqhwhHXgwjwESDbjTmUQtdUsfLdUoSUm/zAyYdKWh3D5rAEb7POxsKTGZ
         veHB7PCO6YaQkC7kW4xZWIGFQWSasMJ1HWB+trn9CWs7GMzZ2QNiPdz3HrjrxVg3Ag6d
         DIR7NVbjHI8nDkwjVZCyuzXVckHkJliooghYQYOMGd3Bn270U0Ht3QTtRYoEdhI1trnU
         EymNyWo4x0OLxsQbhh9A08Fs2xTUeaQn+Ov0UjJxaDllQm5Cq6JGcDkem5RZSMafLXJL
         /4gw==
X-Gm-Message-State: AO0yUKVCs2ZNbBd8UMnZ8Gk9lqYfaTaHNHev4XEIJB296Hgm6EnTEcUu
        MN+XUNUtRsvOvZfrF6PBGfzL+w==
X-Google-Smtp-Source: AK7set9IMWNg72no/9uOKQXT8LYXe8CZYeHN5jhbPAlbznAti/umremq4GFiYsOSj2PiAKyg8suZXw==
X-Received: by 2002:a05:6e02:13f4:b0:317:16bc:dc97 with SMTP id w20-20020a056e0213f400b0031716bcdc97mr1752407ilj.3.1677875305458;
        Fri, 03 Mar 2023 12:28:25 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id o2-20020a02b802000000b003e899e77027sm1023059jam.15.2023.03.03.12.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 12:28:24 -0800 (PST)
Message-ID: <b547ca5b-e9c4-a48c-5b2c-f0bfd6ce11e5@linuxfoundation.org>
Date:   Fri, 3 Mar 2023 13:28:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] replace 2&>1 by 2>&1
Content-Language: en-US
To:     Patrice Duroux <patrice.duroux@gmail.com>,
        linux-kselftest@vger.kernel.org
References: <CAGKjw9KHDnVgRz5bstJYkq4t0-bT5fvkuQZbEB48d-8jo4Q00g@mail.gmail.com>
 <20230303192056.18732-1-patrice.duroux@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230303192056.18732-1-patrice.duroux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/3/23 12:20, Patrice Duroux wrote:

Missing commit log and the commit summary doesn't include
the subsystem - try selftests/net:

Also say what this change is fixing instead of making that
the commit summary.

> Signed-off-by: Patrice Duroux <patrice.duroux@gmail.com>
> ---
>   .../testing/selftests/drivers/net/dsa/test_bridge_fdb_stress.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/dsa/test_bridge_fdb_stress.sh b/tools/testing/selftests/drivers/net/dsa/test_bridge_fdb_stress.sh
> index a1f269ee84da..92acab83fbe2 100755
> --- a/tools/testing/selftests/drivers/net/dsa/test_bridge_fdb_stress.sh
> +++ b/tools/testing/selftests/drivers/net/dsa/test_bridge_fdb_stress.sh
> @@ -31,7 +31,7 @@ trap 'cleanup' EXIT
>   
>   eth=${NETIFS[p1]}
>   
> -ip link del br0 2&>1 >/dev/null || :
> +ip link del br0 2>&1 >/dev/null || :
>   ip link add br0 type bridge && ip link set $eth master br0
>   
>   (while :; do

thanks,
-- Shuah
