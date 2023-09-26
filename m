Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E894B7AEB5D
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 13:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjIZLW5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 07:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjIZLW5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 07:22:57 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737D3EB;
        Tue, 26 Sep 2023 04:22:50 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 17C8E320047A;
        Tue, 26 Sep 2023 07:22:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 26 Sep 2023 07:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695727367; x=1695813767; bh=+JlMwL7peYxkx
        bAOj7Omdxd33gxKlbj7HQtEwxgZzWE=; b=cKtLQu23NwBKm/8ULa+QXLjcUNspZ
        wW75f+V9km5/McnePuQ8zxBaVc1EUavIkjlNmr9ed6/0nWKDmB4t69EI62hnQoLc
        OskoRIIVRcs/cxPjRZEwX2ImPVQW9hhZwPpYj9xjZ7oeNn5lgrH+jQ7eG08rltjm
        rMhcL4q6EyFQBDBqnd5IyIwz8/dU3sDJNE2GRvWwTZySynVdwcrqnbAB1Sf9kFBV
        6bIVnKw1vm3EHdIKD7MKO2ZJ0X+b1oXfWN8h8wz8unZoTYmwDVAJC0A2iz2HGsZV
        Mmkj8R8N8S4nyOPEbc1r2u5jUqrj23+6L1OunXCD8vjqbQf29o5/pHH+w==
X-ME-Sender: <xms:Br8SZZnRxR3i8BF83N90OG3khcU2X-wsCZ5RfY4-jZiXSnJbnLmeoQ>
    <xme:Br8SZU3Qi5ZG2GquKPSJ8JWIr8k2FTWitHdwElYmImeZmc-qQPTIyKAi5H7HmJWQW
    MJVHH-6CNlmMmA>
X-ME-Received: <xmr:Br8SZfo2CXtSl-oPJW0pmWV2HRnV0rU4NhIdPUzY_smwJdQxwXlOuKAnFdshKTVNEaRPgGI6M5L3-SQs2Nwn7UvJPL0JxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtddtgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:B78SZZlwrGnrRS4gZwpkpdDoNQdPEydVfSlgKf47CizoL5_RzgYHXg>
    <xmx:B78SZX0r5aKMHBoJbvq8ShHhKXTL7k900RBssAZlJeayAfY470Ti8g>
    <xmx:B78SZYtuyD6OlsdcDI9GCNlDzO9VPwfWeUfbKXh-A4yK7q3dovLt8w>
    <xmx:B78SZe3j76nG1OCKI-nGeo_DuePqsApH62Pfn_zmrL1hKJ5UFZRNpg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Sep 2023 07:22:46 -0400 (EDT)
Date:   Tue, 26 Sep 2023 14:22:42 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Johannes Nixdorf <jnixdorf-oss@avm.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/6] net: bridge: Track and limit dynamically
 learned FDB entries
Message-ID: <ZRK/ArWPNHgjVvWA@shredder>
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-3-39f0293807b8@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919-fdb_limit-v4-3-39f0293807b8@avm.de>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 19, 2023 at 10:12:50AM +0200, Johannes Nixdorf wrote:
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

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
