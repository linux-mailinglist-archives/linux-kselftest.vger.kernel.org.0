Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3591F7A799B
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 12:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbjITKqx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 06:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbjITKqd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 06:46:33 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC50102
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 03:46:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9a9f139cd94so919605666b.2
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 03:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695206764; x=1695811564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1t+EHZZa+DoV/W1tEtqY5C53ytLGnx5U13L/26n+omc=;
        b=dihsdjvTnuQYMVrQxu4XvEe5UUGzkdkX1xMIDEIyoiJ5MUUGHoxrtS5OFHB+QGNLR8
         OZKCASHQ1EOpebv9O2YOnX9E2oPft2dRhZnuo7xLPfwndswi1cm/nAkWaIhzastVT5JR
         XMB2I+wSWXwwfCOkwQGmg6siCJMZGdapZ4GaXpBkpScOpKqf5hr4ZUhBWvQIJcOR24oP
         Wz/qlovKaRrEW4E8TcunpnmqowIv66sPyaYizBxKaDkI49Q3whEtdMBgyepmETQgkSoP
         IkZizwj3T32xwdDSH7uPq8pd3RLlmpsyC0o080c2F16HJ9gdpfszY13Ur2jI9GupJXTs
         KqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695206764; x=1695811564;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1t+EHZZa+DoV/W1tEtqY5C53ytLGnx5U13L/26n+omc=;
        b=I9JpgIs9MppsIs6WIiCuFS1Z6E2cmT25i1ZBiTluLu6TVg8mP3PP94OYhKTRlBu6G7
         wuMZ19Y+ZuiA+FVm5P7LRBdo+0aI44xwGM71sdX4Clw4YQR6dfVsrUE9SHbLALQUX5Z0
         EchHtTxpPn/udfe2Dd7qbUHyjEEForFG70As5QAJRqGc6wNsRUalzn/ql+4Sx4pCkNqC
         dYHkR6HkzhUH3J4+q8rLwotkpSzMYUx63GSVcHCdlJX719ZQjssMlA1/0p9fj6c7XMBo
         JKtj1DoUJh7Kkcu5ZAz+tJo1PGp2j2ptuSoyJ8tNZfHt9P97JAcMoaI0K8uwYSxexY4k
         XEeg==
X-Gm-Message-State: AOJu0YyL23afJVw0WApUiclkv2WKtCbmR3FXG/qGMKS7U3mp4YXi6dfY
        Or6kUnTvV+Hl+2L5snY3BQl6iA==
X-Google-Smtp-Source: AGHT+IEn9v5CmjikvnJiuR62Cfdh+Se8CP5j2IauqDOuNZIhLdU7Ki2o39Vo6T+KBU1ZVfagZsuX5g==
X-Received: by 2002:a17:907:77ca:b0:9a2:19ea:88f7 with SMTP id kz10-20020a17090777ca00b009a219ea88f7mr1801929ejc.64.1695206764525;
        Wed, 20 Sep 2023 03:46:04 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id qx9-20020a170906fcc900b0099d0a8ccb5fsm9183266ejb.152.2023.09.20.03.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 03:46:04 -0700 (PDT)
Message-ID: <1c12b8f2-b28b-f326-b24f-f1ea602832d7@blackwall.org>
Date:   Wed, 20 Sep 2023 13:46:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next v4 2/6] net: bridge: Set strict_start_type for
 br_policy
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
 <20230919-fdb_limit-v4-2-39f0293807b8@avm.de>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230919-fdb_limit-v4-2-39f0293807b8@avm.de>
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
> Set any new attributes added to br_policy to be parsed strictly, to
> prevent userspace from passing garbage.
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> ---
>   net/bridge/br_netlink.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 10f0d33d8ccf..505683ef9a26 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -1229,6 +1229,8 @@ static size_t br_port_get_slave_size(const struct net_device *brdev,
>   }
>   
>   static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
> +	[IFLA_BR_UNSPEC]	= { .strict_start_type =
> +				    IFLA_BR_MCAST_QUERIER_STATE + 1 },
>   	[IFLA_BR_FORWARD_DELAY]	= { .type = NLA_U32 },
>   	[IFLA_BR_HELLO_TIME]	= { .type = NLA_U32 },
>   	[IFLA_BR_MAX_AGE]	= { .type = NLA_U32 },
> 

instead of IFLA_BR_MCAST_QUERIER_STATE + 1, why not move around the 
patch and just use the new attribute name?
These are uapi, they won't change.
