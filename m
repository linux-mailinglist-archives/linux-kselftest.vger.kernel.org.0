Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206CE7A9B29
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 20:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjIUSyu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 14:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbjIUSyk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 14:54:40 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863E7D2053
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Sep 2023 11:41:34 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53136a13cd4so1533136a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Sep 2023 11:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695321693; x=1695926493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fv18euYIHxUyDyU2umf2N7sAa5N8tvwc+B+kdZWr598=;
        b=g5eLE0uAtMdyuDGiM1URIED9vABaRCGof0yeQVTe5DQcNJtA5KKP/Id6NR1d0dzJJT
         OdT/WNczk47SDhmPqTL8E2p1/zqCtC/d2RiLhLsPg9Eo/hD1diNXG82v1td05F4cQLhH
         spknhsxhkvx3mfQhES4RUdoScajaHJDtpDyLJPLD+pQNbTqml+xG+jyF7ON7LLuuRvTq
         DDHvlVftS3kW2WBmy8Wi2qd6otvGRruIXbAM0Yk4FfWSO4fHkld1yVdZKor49GHEdcdS
         ifbYn1iE+N4k8iNtfmAbQzgMsQ5St/hfGwEuLrxxN9GvOx2hWXavegEadCHtJdNx6Mwn
         HZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321693; x=1695926493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fv18euYIHxUyDyU2umf2N7sAa5N8tvwc+B+kdZWr598=;
        b=WWRh1jS/GlmIaUm/DpJ2t3Ey+vgxtPXLd7oGs0g/NgwrIRE54xdHyCMab86m3BorWf
         5NQvKh6MjQrOXcKPs0hgkeSQsB7rcz1rgI5xY+Oy0htGbNzTs5zeIHrPjYm0mgV4cmPT
         Rdk/BudpxvY8Z5byRxyPNK/xEIDVY69CR9jdt/Yrpvr9QBrzXqQzvDiETw8RYA2l8vfk
         sdpm+kW2bjy9XEnUemXFK7Vm/dboKJc9JOJ+125PTxphGFTgt1RWd9CGwdMAq9Xv1aLs
         jbwDFJ7l7cLHNTrAeWrhgV1LTro7W9DvAJiwaQwmOtpebGijw7w4rMdRTTGPuRf9387R
         L5gQ==
X-Gm-Message-State: AOJu0Yx5Jn1dPgMXh3C4UfDg0C5z4Jjl7dmZAhSrFg1NrVzPKYUZMDSs
        qyj5ooCZXNT1Ugl9/oyjU8NbJEWa/J5zD+WStZ2a/Qi1
X-Google-Smtp-Source: AGHT+IF7yqREQn2rdmQ5jUsI6c21sqgqAn9leaUuvmmsTe+epR2XbZ0CTk+dmINmAhslhc7LZaZeeg==
X-Received: by 2002:a17:906:9b94:b0:9a1:debe:6b9b with SMTP id dd20-20020a1709069b9400b009a1debe6b9bmr6177440ejc.35.1695300113099;
        Thu, 21 Sep 2023 05:41:53 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id i22-20020a17090671d600b0099bcdfff7cbsm991440ejk.160.2023.09.21.05.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 05:41:52 -0700 (PDT)
Message-ID: <0ae67e4d-0d51-5290-1255-1fe1b699ca14@blackwall.org>
Date:   Thu, 21 Sep 2023 15:41:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next v4 4/6] net: bridge: Add netlink knobs for number
 / max learned FDB entries
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
 <20230919-fdb_limit-v4-4-39f0293807b8@avm.de>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230919-fdb_limit-v4-4-39f0293807b8@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/19/23 11:12, Johannes Nixdorf wrote:
> The previous patch added accounting and a limit for the number of
> dynamically learned FDB entries per bridge. However it did not provide
> means to actually configure those bounds or read back the count. This
> patch does that.
> 
> Two new netlink attributes are added for the accounting and limit of
> dynamically learned FDB entries:
>   - IFLA_BR_FDB_N_LEARNED (RO) for the number of entries accounted for
>     a single bridge.
>   - IFLA_BR_FDB_MAX_LEARNED (RW) for the configured limit of entries for
>     the bridge.
> 
> The new attributes are used like this:
> 
>   # ip link add name br up type bridge fdb_max_learned 256
>   # ip link add name v1 up master br type veth peer v2
>   # ip link set up dev v2
>   # mausezahn -a rand -c 1024 v2
>   0.01 seconds (90877 packets per second
>   # bridge fdb | grep -v permanent | wc -l
>   256
>   # ip -d link show dev br
>   13: br: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 [...]
>       [...] fdb_n_learned 256 fdb_max_learned 256
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> ---
>   include/uapi/linux/if_link.h |  2 ++
>   net/bridge/br_netlink.c      | 15 ++++++++++++++-
>   2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index ce3117df9cec..0486f314c176 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -510,6 +510,8 @@ enum {
>   	IFLA_BR_VLAN_STATS_PER_PORT,
>   	IFLA_BR_MULTI_BOOLOPT,
>   	IFLA_BR_MCAST_QUERIER_STATE,
> +	IFLA_BR_FDB_N_LEARNED,
> +	IFLA_BR_FDB_MAX_LEARNED,
>   	__IFLA_BR_MAX,
>   };
>   
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 505683ef9a26..f5d49a05e61b 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -1267,6 +1267,8 @@ static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
>   	[IFLA_BR_VLAN_STATS_PER_PORT] = { .type = NLA_U8 },
>   	[IFLA_BR_MULTI_BOOLOPT] =
>   		NLA_POLICY_EXACT_LEN(sizeof(struct br_boolopt_multi)),
> +	[IFLA_BR_FDB_N_LEARNED] = { .type = NLA_U32 },
> +	[IFLA_BR_FDB_MAX_LEARNED] = { .type = NLA_U32 },
>   };
>   
>   static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
> @@ -1541,6 +1543,12 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
>   			return err;
>   	}
>   
> +	if (data[IFLA_BR_FDB_MAX_LEARNED]) {
> +		u32 val = nla_get_u32(data[IFLA_BR_FDB_MAX_LEARNED]);
> +
> +		WRITE_ONCE(br->fdb_max_learned, val);
> +	}
> +
>   	return 0;
>   }
>   
> @@ -1595,6 +1603,8 @@ static size_t br_get_size(const struct net_device *brdev)
>   	       nla_total_size_64bit(sizeof(u64)) + /* IFLA_BR_TOPOLOGY_CHANGE_TIMER */
>   	       nla_total_size_64bit(sizeof(u64)) + /* IFLA_BR_GC_TIMER */
>   	       nla_total_size(ETH_ALEN) +       /* IFLA_BR_GROUP_ADDR */
> +	       nla_total_size(sizeof(u32)) +    /* IFLA_BR_FDB_N_LEARNED */
> +	       nla_total_size(sizeof(u32)) +    /* IFLA_BR_FDB_MAX_LEARNED */
>   #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
>   	       nla_total_size(sizeof(u8)) +     /* IFLA_BR_MCAST_ROUTER */
>   	       nla_total_size(sizeof(u8)) +     /* IFLA_BR_MCAST_SNOOPING */
> @@ -1670,7 +1680,10 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
>   	    nla_put_u8(skb, IFLA_BR_TOPOLOGY_CHANGE_DETECTED,
>   		       br->topology_change_detected) ||
>   	    nla_put(skb, IFLA_BR_GROUP_ADDR, ETH_ALEN, br->group_addr) ||
> -	    nla_put(skb, IFLA_BR_MULTI_BOOLOPT, sizeof(bm), &bm))
> +	    nla_put(skb, IFLA_BR_MULTI_BOOLOPT, sizeof(bm), &bm) ||
> +	    nla_put_u32(skb, IFLA_BR_FDB_N_LEARNED,
> +			atomic_read(&br->fdb_n_learned)) ||
> +	    nla_put_u32(skb, IFLA_BR_FDB_MAX_LEARNED, br->fdb_max_learned))
>   		return -EMSGSIZE;
>   
>   #ifdef CONFIG_BRIDGE_VLAN_FILTERING
> 

Actually you're using atomic for counting, but using a u32 for the 
limit, you should cap it because the count can overflow. Or you should
use atomic64 for the counting.



