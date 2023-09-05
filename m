Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259E5793082
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 22:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244087AbjIEU6D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 16:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237380AbjIEU6C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 16:58:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6E9113;
        Tue,  5 Sep 2023 13:57:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611A7C433CA;
        Tue,  5 Sep 2023 20:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693947206;
        bh=McSbLrGFeETjic6sxW1tV/OSWfLMVGkO3zyx6fwzAD8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UmYaix6CMXspfjsBHFwu9TqeDcbAUtZLSJZhiKGh93y/eTW0vFVZJksebBSqKMjLO
         yIHp6jvY+64Ln8w9tABawpSdI/0EU98HLVDxShMib/n1t5txZ6egG1AnL0vai4ViSu
         bc1R5cApLR25xwhR+9zvoRBDokPdWly7zgnJNoDBsij3zR3yM7k3zlWR5T1GyCoXCg
         yVL+CAHlxjfdsaEbDjhooNsTX5623b7o58ClhAkBbfBcbIDHrVU4YzchWihT7JFr93
         jXgHIN+ALaNkt7RHe3guGRF88dO+XDHjysqWtho5zmrjGIwd42IgWry720IsAq+KNL
         bU8iSehESqm+A==
Date:   Tue, 5 Sep 2023 13:53:24 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Johannes Nixdorf <jnixdorf-oss@avm.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/6] net: bridge: Set BR_FDB_ADDED_BY_USER
 early in fdb_add_entry
Message-ID: <20230905135324.1b9f7be4@kernel.org>
In-Reply-To: <20230905-fdb_limit-v3-1-7597cd500a82@avm.de>
References: <20230905-fdb_limit-v3-0-7597cd500a82@avm.de>
        <20230905-fdb_limit-v3-1-7597cd500a82@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 05 Sep 2023 13:47:18 +0200 Johannes Nixdorf wrote:
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -1056,7 +1056,7 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>  		if (!(flags & NLM_F_CREATE))
>  			return -ENOENT;
>  
> -		fdb = fdb_create(br, source, addr, vid, 0);
> +		fdb = fdb_create(br, source, addr, vid, BIT(BR_FDB_ADDED_BY_USER));

Please try to wrap your code at 80 chars. Also:

## Form letter - net-next-closed

The merge window for v6.6 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Sept 11th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

