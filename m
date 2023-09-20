Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C1D7A79AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 12:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbjITKty (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 06:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjITKte (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 06:49:34 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5EB110
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 03:49:05 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a9f139cd94so920001766b.2
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 03:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695206943; x=1695811743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WfoVQLFTyBMz6qdJ4HQf6iMKbD5VVKNiCRlsodiIXlQ=;
        b=RazleXos7/k53GEoTRbGsHzMX9JT1DA51tFBZ3TYPXQeK02nojwcfEvtKhThwk0g8M
         OvIua8Ana6XbAIrjagYg9R65I2oLsi7VatOXOqZ/jp05kJJcCaQnlsjCvKjtgaSKniBp
         kdQ00CxPkWdHRmAtTG6Vohb/MtRvmFibKLunTXsfkCgE7cjy/qQZPjKENA7TsO4kg7xs
         8XL9ldy45vWFtAsw00TZrwTXm4dAS/8Yn5FvAUNhsJhNPad8JF8Pg6pgAnkC3+2amoNk
         iCvx+vmSwo8oBuBTyg9JsgwKcw2UCn03NpVnskrr2UciHNjkIZk7ImQ2yoMBbrFXudxc
         D8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695206943; x=1695811743;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WfoVQLFTyBMz6qdJ4HQf6iMKbD5VVKNiCRlsodiIXlQ=;
        b=pNmT+GXacYlz1AMcz7ynUupvbL5CpcJqG9u9grBe6FidE1fiFDx/GfJLALE2t/xwBj
         HN1YhbXg95Es0rkDxDZrLUThICglBI3WmeXQJjWtr3bVNwj+AKEuQIHv/CUZV2XBliaL
         h/FdrOCxSNiAnxY0Arq5cqE0yNgBxdeEAmAYiErTHa+V/tPk7ngCGuhB4cdBr5VnyAuO
         aK3nSn+LEEustPeEf4d22qC0Afe8VbTRur/oDVObxpEB4j8ZM6BDQx/ZoRj2/yuhyXzj
         dqO72c1ukBKgQaCIqKSp4sB0RSAQfSW9z/NS2p799coy19T6fBRHIBsoMe+GUyOQw9fs
         uJnw==
X-Gm-Message-State: AOJu0Yyk++atkWfr5I9EtNxX5dWb3TKPvzZvd07VHsZ2x5n5owmkolEl
        LgO3IdjeoAKzfwfEaQbnTo7v7g==
X-Google-Smtp-Source: AGHT+IGslN7faGmGQ7juByj4DUF+MXgyDiNwHsBIRgLgzDq+FEqRLW5HdrbYvzX5gsw4DZWdgtvfyw==
X-Received: by 2002:a17:906:3d21:b0:9a2:1e14:86bd with SMTP id l1-20020a1709063d2100b009a21e1486bdmr1622513ejf.65.1695206943489;
        Wed, 20 Sep 2023 03:49:03 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id qb18-20020a1709077e9200b009adc5802d08sm8191805ejc.190.2023.09.20.03.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 03:49:03 -0700 (PDT)
Message-ID: <5146e687-f5b8-86b2-e4e3-29871fe4fa5c@blackwall.org>
Date:   Wed, 20 Sep 2023 13:49:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next v4 3/6] net: bridge: Track and limit dynamically
 learned FDB entries
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
 <20230919-fdb_limit-v4-3-39f0293807b8@avm.de>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230919-fdb_limit-v4-3-39f0293807b8@avm.de>
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
> A malicious actor behind one bridge port may spam the kernel with packets
> with a random source MAC address, each of which will create an FDB entry,
> each of which is a dynamic allocation in the kernel.
> 
> There are roughly 2^48 different MAC addresses, further limited by the
> rhashtable they are stored in to 2^31. Each entry is of the type struct
> net_bridge_fdb_entry, which is currently 128 bytes big. This means the
> maximum amount of memory allocated for FDB entries is 2^31 * 128B =
> 256GiB, which is too much for most computers.
> 
> Mitigate this by maintaining a per bridge count of those automatically
> generated entries in fdb_n_learned, and a limit in fdb_max_learned. If
> the limit is hit new entries are not learned anymore.
> 
> For backwards compatibility the default setting of 0 disables the limit.
> 
> User-added entries by netlink or from bridge or bridge port addresses
> are never blocked and do not count towards that limit.
> 
> Introduce a new fdb entry flag BR_FDB_DYNAMIC_LEARNED to keep track of
> whether an FDB entry is included in the count. The flag is enabled for
> dynamically learned entries, and disabled for all other entries. This
> should be equivalent to BR_FDB_ADDED_BY_USER and BR_FDB_LOCAL being unset,
> but contrary to the two flags it can be toggled atomically.
> 
> Atomicity is required here, as there are multiple callers that modify the
> flags, but are not under a common lock (br_fdb_update is the exception
> for br->hash_lock, br_fdb_external_learn_add for RTNL).
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> ---
>   net/bridge/br_fdb.c     | 35 +++++++++++++++++++++++++++++++++--
>   net/bridge/br_private.h |  4 ++++
>   2 files changed, 37 insertions(+), 2 deletions(-)
> 

I think this is a good counting start. :) It'd be nice to get
more eyes on this one.
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


