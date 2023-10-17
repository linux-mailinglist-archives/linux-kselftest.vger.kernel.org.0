Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F77F7CBF82
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 11:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343534AbjJQJdm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 05:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343545AbjJQJdX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 05:33:23 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBB51703
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 02:32:05 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4065f29e933so57993755e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 02:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697535124; x=1698139924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3kgbT4HUwVO3dRrS+UXwvsR6kcnDepF12o+Z+tvmQWQ=;
        b=nxYSMDGOG9w29F2QiHmTHFiVkSFhxzTaskRmdCtMRrx6+16AQGUg/9P4k2ltm4iCGN
         lfeFGx5l7OqyrmMDClilNNQ/4//TWTAJFw1JqrMtSmDR1pNvChrAMmgGIuAtMfcYLlnY
         3LaTB1d8q5tSmdRdB8y3londsOy8T/nqxOfFOWOxkjJJmOjEmaAOwM6LrzRR5oRfwlRt
         y4IRUtrGZqjE34l35jhL0Koeo1T+Ugud3B90ZqcCegN2h5MvfrQv936h1TRxq0xLblcS
         nU5qJBd8s3/MF7oh7EfrqhmvetYJVnRVFgBJWlTCn6yEygHz2RLYeTAqsXWScAaqRZo6
         tF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697535124; x=1698139924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3kgbT4HUwVO3dRrS+UXwvsR6kcnDepF12o+Z+tvmQWQ=;
        b=JCW1G2aIezFaoCFd8PE8P1dflJ39Tk6JdeeGCfh6vgJd06Rr+jrGP39z0K8TjqN4wx
         XAUYY2cEjwpvOV3Jbdx0TEoHLsnWfO0hI7XyLP7LWTdlngpnnyZ00QZE9AKQkPfvu8h/
         P7L8q0FEE2fyje7c8RwaR5/kGnhLxUFH95jVZRW9W+6Gmb287SLezR98W+8ORdiQk2ZA
         6KK8INbuJY9WHvK3UjDtE7+8sASya42ieiNsWjcz/Ph+ciVS1N4ms1rBvAH/vkACBa/5
         voDxIQLFppQmZGYBIMevWbXQQbXxy/yRiO+YfFs7FIhZ8a9gwZdpZ0QDWRe7XF+XUoX6
         FZpA==
X-Gm-Message-State: AOJu0YzWx3TiBG3NYoLHq1XngHIxKroygAVX8EDIwa5HOmN3RTknt41e
        yYODrP1KrLr8llXZyVLTXmCKXSh45m8dn4253tz9nMd7lRtv4w==
X-Google-Smtp-Source: AGHT+IEFCAFLbJTRsa9Q+OR2Uc4qdYh8ECcQZKGv69/zvXpR+D7cI+ScKKATcZsdrGR677hHJRW8VA==
X-Received: by 2002:a05:600c:3595:b0:3ff:ca80:eda3 with SMTP id p21-20020a05600c359500b003ffca80eda3mr1240848wmq.10.1697535123998;
        Tue, 17 Oct 2023 02:32:03 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id a6-20020a05600c348600b0040652e8ca13sm9406919wmq.43.2023.10.17.02.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:32:03 -0700 (PDT)
Message-ID: <f4657a17-1b81-f8e3-a781-714f1dc5174f@blackwall.org>
Date:   Tue, 17 Oct 2023 12:32:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next v5 4/5] net: bridge: Set strict_start_type for
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
References: <20231016-fdb_limit-v5-0-32cddff87758@avm.de>
 <20231016-fdb_limit-v5-4-32cddff87758@avm.de>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016-fdb_limit-v5-4-32cddff87758@avm.de>
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
> Set any new attributes added to br_policy to be parsed strictly, to
> prevent userspace from passing garbage.
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> ---
>   net/bridge/br_netlink.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 0c3cf6e6dea2..5ad4abfcb7ba 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -1229,6 +1229,8 @@ static size_t br_port_get_slave_size(const struct net_device *brdev,
>   }
>   
>   static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
> +	[IFLA_BR_UNSPEC]	= { .strict_start_type =
> +				    IFLA_BR_FDB_N_LEARNED },
>   	[IFLA_BR_FORWARD_DELAY]	= { .type = NLA_U32 },
>   	[IFLA_BR_HELLO_TIME]	= { .type = NLA_U32 },
>   	[IFLA_BR_MAX_AGE]	= { .type = NLA_U32 },
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

