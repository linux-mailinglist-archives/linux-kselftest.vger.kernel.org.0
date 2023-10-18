Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F687CD18A
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 03:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjJRBAe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 21:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJRBAd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 21:00:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB81AFA;
        Tue, 17 Oct 2023 18:00:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82988C433C8;
        Wed, 18 Oct 2023 01:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697590830;
        bh=K2deq/2Shw6UljQTvW98Mv2vAHt3FhdhO48jhYtDOe0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ieSaQVIw+2LuuWrOLgLuT6P47pVmVQWtB8kbHsCga2zN1FQ/8Rl3JpJilDrPGIPqA
         5NUO9MQ4dFBc5vNL2F6LMf75HlvClX9LqGCDaxVWOXtZKHZqonemfs7CKX3s55QLVw
         J6DOPhXgp83P39Jkzj3QQRt6ny65alLAjPSP7MdCBRXoYkhSGp1YzGfXLDi7AXkJTT
         /DVnVUXuAwJVL9gOwGF0wYqwUcwv3akELOxAum53WRBmSOA0Ndjc7mpSCCXAwbaXou
         du4HVJ+vF++TDFWu6730dICpFCQ2ja/IUnyl2baBWDn7DMbWXLdL8+yH0WC7/R+Rs7
         8iCA+NUI/quxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6ACB9E4E9DD;
        Wed, 18 Oct 2023 01:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/5] bridge: Add a limit on learned FDB entries
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169759083043.18882.3734658950123094755.git-patchwork-notify@kernel.org>
Date:   Wed, 18 Oct 2023 01:00:30 +0000
References: <20231016-fdb_limit-v5-0-32cddff87758@avm.de>
In-Reply-To: <20231016-fdb_limit-v5-0-32cddff87758@avm.de>
To:     Johannes Nixdorf <jnixdorf-oss@avm.de>
Cc:     davem@davemloft.net, andrew@lunn.ch, dsahern@gmail.com,
        edumazet@google.com, f.fainelli@gmail.com, idosch@nvidia.com,
        kuba@kernel.org, razor@blackwall.org, linux@rempel-privat.de,
        pabeni@redhat.com, roopa@nvidia.com, shuah@kernel.org,
        vladimir.oltean@nxp.com, bridge@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Oct 2023 15:27:19 +0200 you wrote:
> Introduce a limit on the amount of learned FDB entries on a bridge,
> configured by netlink with a build time default on bridge creation in
> the kernel config.
> 
> For backwards compatibility the kernel config default is disabling the
> limit (0).
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/5] net: bridge: Set BR_FDB_ADDED_BY_USER early in fdb_add_entry
    https://git.kernel.org/netdev/net-next/c/cbf51acbc5d5
  - [net-next,v5,2/5] net: bridge: Track and limit dynamically learned FDB entries
    https://git.kernel.org/netdev/net-next/c/bdb4dfda3b41
  - [net-next,v5,3/5] net: bridge: Add netlink knobs for number / max learned FDB entries
    https://git.kernel.org/netdev/net-next/c/ddd1ad68826d
  - [net-next,v5,4/5] net: bridge: Set strict_start_type for br_policy
    https://git.kernel.org/netdev/net-next/c/19297c3ab23c
  - [net-next,v5,5/5] selftests: forwarding: bridge_fdb_learning_limit: Add a new selftest
    https://git.kernel.org/netdev/net-next/c/6f84090333bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


