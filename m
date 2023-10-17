Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E099B7CBF7F
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 11:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbjJQJd2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 05:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbjJQJdM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 05:33:12 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FB1199D
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 02:31:41 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c5028e5b88so57322611fa.3
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 02:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697535100; x=1698139900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fsrKPD/7qupxjLmT8Mi5PT6TYfrkzaLblWhZdBHfHxE=;
        b=OmC2ctuyf4EpEhDr2vGENxl4NdGoytJEkDc/RFkkAW/bc+s6KDd8LBDne6867rE+FT
         rvpoHYNpUF5xUK8RQcB5e8gM6RbKULDSm5d6Lb31qpI9eaY3HRoFu1/3oYgbk5r56rwR
         kk7OA4LzeSLCqasHCHX9umQ1+OFKFS/KczcIm3X0dgVXMEEvcAwzjxkE1oE7I+vINVI5
         8Rx0nra3c69UEvNqPkuTCYw40TN4FX9AWRJ6E6G4d1SDqzIwZkdFe5ejN6tvVdlUqZhU
         V39MZmWw6FApHfbmc7bLJtO8N4JfaqXLnCIckD1Pk00NpAgAwsFO8GEgjGDvRrSuWa84
         hF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697535100; x=1698139900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fsrKPD/7qupxjLmT8Mi5PT6TYfrkzaLblWhZdBHfHxE=;
        b=K8Wjv0tqTmEniE0SiT7539wurEoZ+p/7bsyl29hLTNeoFIKfWa0B/AtPmelF3Ddkmk
         WI/gT4jwdhjU6Fk0ToARUw4Wp+62uJVKfpEZaQs61CmCLyj7iwa02jsMzJa2ikr1RLUm
         5/SYLOp5PV/lxtUy7XAxmUO65535xuXmC2nUXAJhH6VVfn4lNPC6vE2QPz348GAEo2jc
         3q9b5Qlz4FAlV1ZdK5nFoJ4jF6IO3xM1XZNFrhokFUhwJCeeTbd/JaLqqX7E/rGtwSQd
         lfNn4DQ/zkNQl/71h6KxFU6mVn2DqgbxN9x5qI2b7h1BCy8YGGxCQ0XaMKw07wPL/0/C
         cbpw==
X-Gm-Message-State: AOJu0YyRQca4P/x+1HRsr/F6pIb+MAqHawfITwW0tRpm9aq2uwwN8e6v
        RdNtXofNgLO4h2aeY4/MB8TSlA==
X-Google-Smtp-Source: AGHT+IGzWf/WEPHpLeoowdpeEwKEiGcC14iNGScA2CK7eBKsOPCa8z2I7ioO6L1QMCV6+SIZy+/6yQ==
X-Received: by 2002:a2e:3c08:0:b0:2c5:1900:47a4 with SMTP id j8-20020a2e3c08000000b002c5190047a4mr1310758lja.0.1697535100199;
        Tue, 17 Oct 2023 02:31:40 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id t7-20020a1c7707000000b0040586360a36sm9267266wmi.17.2023.10.17.02.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:31:39 -0700 (PDT)
Message-ID: <6f679d47-f099-7345-0d97-6e07bfd7ceec@blackwall.org>
Date:   Tue, 17 Oct 2023 12:31:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next v5 3/5] net: bridge: Add netlink knobs for number
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
References: <20231016-fdb_limit-v5-0-32cddff87758@avm.de>
 <20231016-fdb_limit-v5-3-32cddff87758@avm.de>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016-fdb_limit-v5-3-32cddff87758@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/16/23 16:27, Johannes Nixdorf wrote:
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

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


