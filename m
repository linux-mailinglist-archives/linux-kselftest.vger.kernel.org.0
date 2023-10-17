Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189F87CC17C
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 13:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbjJQLGU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 07:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbjJQLGS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 07:06:18 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E989AFC;
        Tue, 17 Oct 2023 04:06:14 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3A5CB5C0308;
        Tue, 17 Oct 2023 07:06:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 17 Oct 2023 07:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697540774; x=1697627174; bh=gk4uH597iCVOZ
        ZIrN/RdNf7XGlip0tVQ+qETf0YnWnM=; b=uub9dAtaSbqCsb5DHt/7NzLuERclT
        ci/W/XwyQ6GgWFzejlhKNAEcIuZ4ZVgq9dUL7DthXYE+X7aBjqhXvIqbq8kGeTXz
        xaQD+E9I1513hcuio8WWpWBhicj9ER/J/7T5dQN+kiRahW5hIFHLfOkaHsi1+Vb1
        /cC1UcSp9TZ+GgrF7sCUWRE2QGVcTRDdS2GEt0EYzFj7/Fb5Xwu3II2IDc+yxs03
        9ZLzu19qbcYUJ2WDf7lJV2JDSAu+6V3qHY+aplIaRSoTPWM/x7BZyr4/Qd8MTV2r
        N45iHMctDsCZharssV6oaB9TFaMQZOOplSOC9ApQl94xCq7lqNiqSuL6g==
X-ME-Sender: <xms:pWouZfyC30nDYgKei5x4q2ult-hfe1uovSMU8Jcks8o3XSX-_uAcfg>
    <xme:pWouZXRJH9RYHFyr8qT9WOlhN6k5NNQtYw7yYIaw6c2S8sZhdoU2r_zbRpDAB9Elo
    gPBAUW3SJxdS9w>
X-ME-Received: <xmr:pWouZZXWoLPz3OgbvniINxQD1w8FRz9NbkhqRuYmcWJMC95t9OzrzD5E2C_eROi9zW3mGOmb6eoyPwKTgm3FA_ZIKJucyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:pWouZZinhEjKprpqjCn_Q6M_45y6YXUt3GG3UShyf8c5ss-fYPpgxQ>
    <xmx:pWouZRCwcZuVDGxXSQeQ_AU2p7BGSH60Z39MfgZbM36iB2qlOj_eOg>
    <xmx:pWouZSLzPAM3iLZRbNQjnA_GdEzJdSnd-O9xnH8sZZ2t9J9PG_U4KQ>
    <xmx:pmouZbSK5L9yxQI7I4oQ3NPPUHZ2_uP9ygtjzvDhCZac0mKM7oxu-Q>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Oct 2023 07:06:12 -0400 (EDT)
Date:   Tue, 17 Oct 2023 14:06:07 +0300
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
Subject: Re: [PATCH net-next v5 3/5] net: bridge: Add netlink knobs for
 number / max learned FDB entries
Message-ID: <ZS5qn0cv8InB/qn+@shredder>
References: <20231016-fdb_limit-v5-0-32cddff87758@avm.de>
 <20231016-fdb_limit-v5-3-32cddff87758@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-fdb_limit-v5-3-32cddff87758@avm.de>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 16, 2023 at 03:27:22PM +0200, Johannes Nixdorf wrote:
> The previous patch added accounting and a limit for the number of
> dynamically learned FDB entries per bridge. However it did not provide
> means to actually configure those bounds or read back the count. This
> patch does that.
> 
> Two new netlink attributes are added for the accounting and limit of
> dynamically learned FDB entries:
>  - IFLA_BR_FDB_N_LEARNED (RO) for the number of entries accounted for
>    a single bridge.
>  - IFLA_BR_FDB_MAX_LEARNED (RW) for the configured limit of entries for
>    the bridge.
> 
> The new attributes are used like this:
> 
>  # ip link add name br up type bridge fdb_max_learned 256
>  # ip link add name v1 up master br type veth peer v2
>  # ip link set up dev v2
>  # mausezahn -a rand -c 1024 v2
>  0.01 seconds (90877 packets per second
>  # bridge fdb | grep -v permanent | wc -l
>  256
>  # ip -d link show dev br
>  13: br: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 [...]
>      [...] fdb_n_learned 256 fdb_max_learned 256
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
