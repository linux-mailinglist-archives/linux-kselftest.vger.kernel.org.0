Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28EC7A98B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 19:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjIURvo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 13:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjIURvZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 13:51:25 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1547946DF7
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Sep 2023 10:25:57 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40535597f01so9206045e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Sep 2023 10:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695317154; x=1695921954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oet/D+JdIKmqqEXMeGgkoE2/3Tw5UCJOvyH76c8x0dQ=;
        b=qxj6vJrFg99h2//xNWVEafXUbt8d7YfAKtjvPItx5YArVcXqayk6YCLzWKBk1lukxC
         Tf+QWaKfrUG0TPvQD839tTg0Lm1Xi254GdfVGawC+VigQmZbpZ7c+QIKZX8wPj+YrJEo
         N+0spPtfs+WrOktVOulQbr6E5UaOzL7fk4ghbZTGHYLB2+XrccAIdCKTV18kJ6SZ9C2k
         kDEkl3aOh3FMylB3Eam+jXqOh5uMCfrw6McJFQ8GQutQR7p9W0w9CtS8VIpcmkZAmFLG
         fU1DwCQMGp/GrJNquShZyBqbNzeyxqAvttDrd5X0ZFcLNUwpUQuwjfSpdPhlPc+REhlD
         hftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317154; x=1695921954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oet/D+JdIKmqqEXMeGgkoE2/3Tw5UCJOvyH76c8x0dQ=;
        b=FSM72M3T1dang7OJb4duSugBO7EdzLs6niJx9fOTjzsLyWBP6W6vcMSRySupfKu0PX
         ntr//NVU7FHbcSJYCT2STUIv8qSvOOsQehrL6lRridd7i4ThAHs9OfryIEFg+pVMcEAj
         GcHh7E3kMWagKLj9K2LNPH8ukAEM3dn5Q/egpsoBvHPprjMtdVzFeIutuFXbviIhIUWZ
         LrvFy+LM1P26u8F6dUgvH0HeyrsFkeDGi1c7dV15Du3Ii7OHHNaDpbYWAcKN7Zpm4KQs
         zy+Bo8CcSIbmJ3+GZg+qPga5/hg4B9sEJeHXG4MIrh5VaazhJ1jBsN40XGa11Arp5H2j
         74Aw==
X-Gm-Message-State: AOJu0YxXxa32xSZYJABoB/eGQqa6W/Xa8cQksUBRhQui7VUhEZu0O98a
        HSkwkS4DaERRO9A/MUuKlnYpCSgrnMqQfktmfAEL2lXz
X-Google-Smtp-Source: AGHT+IGSqpABR6NJIutspbmDVZEhOKpxYfh5Gelph+0yVDatq2aZ3E+NWHnq2oOH1AMJw/MFATUt/Q==
X-Received: by 2002:ac2:5b1c:0:b0:503:314f:affe with SMTP id v28-20020ac25b1c000000b00503314faffemr4577024lfn.17.1695291285601;
        Thu, 21 Sep 2023 03:14:45 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id ay15-20020a056402202f00b00532c32e2b2dsm622021edb.18.2023.09.21.03.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 03:14:45 -0700 (PDT)
Message-ID: <ab1130bb-38ce-1804-7981-6a4532d6ff7b@blackwall.org>
Date:   Thu, 21 Sep 2023 13:14:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next v4 2/6] net: bridge: Set strict_start_type for
 br_policy
Content-Language: en-US
To:     Johannes Nixdorf <jnixdorf-oss@avm.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-2-39f0293807b8@avm.de>
 <1c12b8f2-b28b-f326-b24f-f1ea602832d7@blackwall.org>
 <ZQvvgiz4rE8u6vba@u-jnixdorf.ads.avm.de>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZQvvgiz4rE8u6vba@u-jnixdorf.ads.avm.de>
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

On 9/21/23 10:23, Johannes Nixdorf wrote:
> On Wed, Sep 20, 2023 at 01:46:02PM +0300, Nikolay Aleksandrov wrote:
>> On 9/19/23 11:12, Johannes Nixdorf wrote:
>>> Set any new attributes added to br_policy to be parsed strictly, to
>>> prevent userspace from passing garbage.
>>>
>>> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
>>> ---
>>>    net/bridge/br_netlink.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
>>> index 10f0d33d8ccf..505683ef9a26 100644
>>> --- a/net/bridge/br_netlink.c
>>> +++ b/net/bridge/br_netlink.c
>>> @@ -1229,6 +1229,8 @@ static size_t br_port_get_slave_size(const struct net_device *brdev,
>>>    }
>>>    static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
>>> +	[IFLA_BR_UNSPEC]	= { .strict_start_type =
>>> +				    IFLA_BR_MCAST_QUERIER_STATE + 1 },
>>>    	[IFLA_BR_FORWARD_DELAY]	= { .type = NLA_U32 },
>>>    	[IFLA_BR_HELLO_TIME]	= { .type = NLA_U32 },
>>>    	[IFLA_BR_MAX_AGE]	= { .type = NLA_U32 },
>>>
>>
>> instead of IFLA_BR_MCAST_QUERIER_STATE + 1, why not move around the patch
>> and just use the new attribute name?
>> These are uapi, they won't change.
> 
> I wanted to avoid having a state between the two commits where the new
> attributes are already added, but not yet strictly verified. Otherwise
> they would present a slightly different UAPI at that one commit boundary
> than after this commit.
> 

That's not really a problem, the attribute is the same.

> This is also not the only place in the kernel where strict_start_type
> is specified that way. See e.g. commit c00041cf1cb8 ("net: bridge: Set
> strict_start_type at two policies"), even though that seems mostly be
> done to turn on strict_start_type preemtively, not in the same series
> that adds the new attribute.

Please, just use the new attribute to be more explicit where the strict 
parsing starts.

Thanks,
  Nik


