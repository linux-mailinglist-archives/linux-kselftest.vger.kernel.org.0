Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8771D7A79E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 13:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbjITLAj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 07:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjITLAi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 07:00:38 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA149CA
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 04:00:30 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bf3f59905so897542966b.3
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 04:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695207629; x=1695812429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AEvvL7wq7MhG98C7oNkHR86nxOx9QCzBZgqGLXsj1BY=;
        b=Xbk+ldP6J7bssSmts5jVEYVEoEwzAZsUatq2VDzg0Mc5HYFU/qGkrOujXyRew1h+Xc
         oLGWI1TaN/Wehwo6nNbP6b4ALrvnw2bCZMmCIg3TLJyCT07jj0R4GtFm+39C9Q2aAJrY
         /2cjqYnQ31d8cCB88t4SU1pQYbzTNMP0jFNh0MOhikTlUUUh5F7oKl4qDS1uTWkbYoDD
         zBF4ZJCd0okdx7uDkeDLPw53IdaSgJbY1JuT95JDo2IHML3iXOLxF6ELgK+duQmFC1DR
         2VezFrkEJlnLL0XKgzQuqcd9f1XjFkWqNFdKGaus2+kDjZ3WoImZuay6+2DtuJ+47gWi
         Ivvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695207629; x=1695812429;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEvvL7wq7MhG98C7oNkHR86nxOx9QCzBZgqGLXsj1BY=;
        b=Ra9Q4oFsWkb/u2SoUEfpoP0/XjQZQ2MNnNT0sh2APX99NceJoqB4iBjrwNhYkAyVEm
         cLLt1/XA3nQxaA/iITryFDYil/wOQQrQBO0hdyMhE6+sZCO22BWAO5BL/3OOvHY69jXA
         44P6T35fygwaVbXzUKBT3giLU3O9ftu+cxCQ0WT5/yoNkpc2yOgA5USaPuHSMuclMj5w
         RckAlp7DSdfy0EHD9PxIhIn6m8daMUq3EFRxxZ9GXAq5K2PpScOKu9dunMIzd+x6vc2l
         eTHy+xEceY9jeqIhGH9APz//MsoOTyrIXzajVPr9UpYLVg2yj5HeGFf6BiH6QCODz53G
         hyTA==
X-Gm-Message-State: AOJu0YzWSwDVQgjMo4zd7MzqmkxkVwtAd5gp52rLYAPQxD2w4hUEupkB
        Lv8ZT0Rbr8jYAFpRmydmGM0oLA==
X-Google-Smtp-Source: AGHT+IHZRGAJ8bXIHQMw7UiAB7gVCRXdBqDtsNv5um0prvMS5i4MV874e/3AQCZ9kJa8prT8L6JIYA==
X-Received: by 2002:a17:906:92:b0:9a1:c0e9:58ff with SMTP id 18-20020a170906009200b009a1c0e958ffmr1669524ejc.11.1695207629279;
        Wed, 20 Sep 2023 04:00:29 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id se17-20020a170907a39100b009adc86b75d5sm7857126ejc.189.2023.09.20.04.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 04:00:29 -0700 (PDT)
Message-ID: <cc14cd4a-f3bb-3d6f-5b38-ec73cad32570@blackwall.org>
Date:   Wed, 20 Sep 2023 14:00:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next v4 5/6] net: bridge: Add a configurable default
 FDB learning limit
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
 <20230919-fdb_limit-v4-5-39f0293807b8@avm.de>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230919-fdb_limit-v4-5-39f0293807b8@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/19/23 11:12, Johannes Nixdorf wrote:
> Add a Kconfig option to configure a default FDB learning limit system
> wide, so a distributor building a special purpose kernel can limit all
> created bridges by default.
> 
> The limit is only a soft default setting and overrideable on a per bridge
> basis using netlink.
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> ---
>   net/bridge/Kconfig     | 13 +++++++++++++
>   net/bridge/br_device.c |  2 ++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/net/bridge/Kconfig b/net/bridge/Kconfig
> index 3c8ded7d3e84..c0d9c08088c4 100644
> --- a/net/bridge/Kconfig
> +++ b/net/bridge/Kconfig
> @@ -84,3 +84,16 @@ config BRIDGE_CFM
>   	  Say N to exclude this support and reduce the binary size.
>   
>   	  If unsure, say N.
> +
> +config BRIDGE_DEFAULT_FDB_MAX_LEARNED
> +	int "Default FDB learning limit"
> +	default 0
> +	depends on BRIDGE
> +	help
> +	  Sets a default limit on the number of learned FDB entries on
> +	  new bridges. This limit can be overwritten via netlink on a
> +	  per bridge basis.
> +
> +	  The default of 0 disables the limit.
> +
> +	  If unsure, say 0.
> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index 9a5ea06236bd..3214391c15a0 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -531,6 +531,8 @@ void br_dev_setup(struct net_device *dev)
>   	br->bridge_ageing_time = br->ageing_time = BR_DEFAULT_AGEING_TIME;
>   	dev->max_mtu = ETH_MAX_MTU;
>   
> +	br->fdb_max_learned = CONFIG_BRIDGE_DEFAULT_FDB_MAX_LEARNED;
> +
>   	br_netfilter_rtable_init(br);
>   	br_stp_timer_init(br);
>   	br_multicast_init(br);
> 

This one I'm not sure about at all. Distributions can just create the 
bridge with a predefined limit. This is not flexible and just adds
one more kconfig option that is rather unnecessary. Why having a kconfig
knob is better than bridge creation time limit setting? You still have
to create the bridge, so why not set the limit then?
