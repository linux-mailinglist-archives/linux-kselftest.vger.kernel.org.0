Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA017A7982
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 12:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjITKo1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 06:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbjITKo0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 06:44:26 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C749CCF
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 03:44:19 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a65f9147ccso876180366b.1
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 03:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695206658; x=1695811458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7O7mWyhJga1IYEYoLQcrmnzYFbmyVRQyHT7Q+TKsjdE=;
        b=E2hk2cM20Acvnfd3/3r7bxco2Xyc0iWlKaxvEDn66gMvg4j+yLaCjLxSS/1XLzeztT
         0GcjIrAB0g+8dMRdvSv7aWe5QgdE6XIrv2MCva65kYwn7SKMr2RiOOM325asIkrK3rNW
         mHnSubkPq1b1fmG0LeLgvEeUvm4V26zsB5rCSkGRAY8nId+FCUl13RTZasWpJkx3AfWR
         v3+IQz9WtWFjdzvBYZ5k0Epw1IqS3o13qrHRlXsvSKBJ94uhop8fRmAeKiW38UrvmI+9
         leITM0vDHseACWXK2MYiHb5qOYCOFS9m/0hrG+umiugsv3ZtC1xmAtm7JaGW85q2k907
         14og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695206658; x=1695811458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7O7mWyhJga1IYEYoLQcrmnzYFbmyVRQyHT7Q+TKsjdE=;
        b=d6BjbAYtQ5h5Pn6CyPWiVingy4ravjD1voJFuM/up4oHH38NfSu/khX0pAWvWKGr7b
         iVoc+hC1nQf0HtfrWI5QNoqqOmb5NezERzMhKdbTGLi6RtM4ts3C2yeRIPaBArOaVz5N
         IWwpQLSpO92OAgZwJ/hYLHxpnVYahw9mFsFiOISbO6eYHYjk1/FSCwrqq24YXpv0y7oR
         wW6kSwpCiLH1XW+EichJibwOcyPyfVhxyHOzbMCz4kdOhJXG5puQhBbeQSBsev6r2/t/
         IR1VmlwWLsanxUdqz/k6xtbxEJNiFSEpEO98ZmrOyLvTPTkP3pE8PVuql99VUd0T/o8S
         QwuA==
X-Gm-Message-State: AOJu0YwgKtjo+NS6Yn8GVW6n//Z/Gj/JVP7PLSYLkcnNKZlFxxpWx7rZ
        y7TP2+pQDhmu98mXmCk9YJMqnQ==
X-Google-Smtp-Source: AGHT+IGO3lncIOMxzIVaRUoIoQXNjIcQ22mCx46sIDTt+vAiLFg+skIRbs2SUmaSDzWxxnF2blZYPA==
X-Received: by 2002:a17:907:75c2:b0:9aa:25f5:8d95 with SMTP id jl2-20020a17090775c200b009aa25f58d95mr1711323ejc.59.1695206658146;
        Wed, 20 Sep 2023 03:44:18 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id i13-20020a170906114d00b00992afee724bsm8979517eja.76.2023.09.20.03.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 03:44:17 -0700 (PDT)
Message-ID: <a2a5ede9-c93e-915d-61be-c2c2fab18479@blackwall.org>
Date:   Wed, 20 Sep 2023 13:44:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next v4 1/6] net: bridge: Set BR_FDB_ADDED_BY_USER
 early in fdb_add_entry
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
 <20230919-fdb_limit-v4-1-39f0293807b8@avm.de>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230919-fdb_limit-v4-1-39f0293807b8@avm.de>
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
> In preparation of the following fdb limit for dynamically learned entries,
> allow fdb_create to detect that the entry was added by the user. This
> way it can skip applying the limit in this case.
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> ---
>   net/bridge/br_fdb.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index e69a872bfc1d..f517ea92132c 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -1056,7 +1056,8 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>   		if (!(flags & NLM_F_CREATE))
>   			return -ENOENT;
>   
> -		fdb = fdb_create(br, source, addr, vid, 0);
> +		fdb = fdb_create(br, source, addr, vid,
> +				 BIT(BR_FDB_ADDED_BY_USER));
>   		if (!fdb)
>   			return -ENOMEM;
>   
> @@ -1069,6 +1070,8 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>   			WRITE_ONCE(fdb->dst, source);
>   			modified = true;
>   		}
> +
> +		set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
>   	}
>   
>   	if (fdb_to_nud(br, fdb) != state) {
> @@ -1100,8 +1103,6 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>   	if (fdb_handle_notify(fdb, notify))
>   		modified = true;
>   
> -	set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
> -
>   	fdb->used = jiffies;
>   	if (modified) {
>   		if (refresh)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

