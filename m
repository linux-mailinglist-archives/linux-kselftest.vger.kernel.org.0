Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2532C74572E
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 10:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjGCIU2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 04:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjGCIUY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 04:20:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4233E43;
        Mon,  3 Jul 2023 01:20:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4663360E8C;
        Mon,  3 Jul 2023 08:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0F15C433BD;
        Mon,  3 Jul 2023 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688372422;
        bh=srJPRWMRNrhN7YZBUsB92axNpYSklojC0gn01qIJrmo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QxJUcip0A87b7bz6WFNxon3cN1V4hDMzgrbfR+ZCSGdokK1vsrBXaOpGhxgdfwbYH
         CjS2tmUY6Ib21C/bLkeP3Ium9eQXHscn35XMnKBaopaqGAQImR7gjbrfCJikEXNOoq
         aVVAYKsDhET8qVN9SQT+lfQp2N+HG88C6VKNcNJOUHUPyEynHcsRKt7xSMwG6FTkNL
         kva3+GJCRCYuXm1txi0Vh0pzLKEM5b4dwbLZY1irwRUbUpb3/Z2bYaKZTilaq7Wryl
         XoO2238lt1ZTYpGrb40391jPvEusoPn3b8rpBMM3voFaO2WCc3DucHaquAg7JsGN+W
         KbWy75qhWpWDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D853C691EF;
        Mon,  3 Jul 2023 08:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/net: Add xt_policy config for xfrm_policy test
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168837242251.9798.901827370226067728.git-patchwork-notify@kernel.org>
Date:   Mon, 03 Jul 2023 08:20:22 +0000
References: <20230701044103.1096039-1-daniel.diaz@linaro.org>
In-Reply-To: <20230701044103.1096039-1-daniel.diaz@linaro.org>
To:     =?utf-8?q?Daniel_D=C3=ADaz_=3Cdaniel=2Ediaz=40linaro=2Eorg=3E?=@ci.codeaurora.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 30 Jun 2023 22:41:03 -0600 you wrote:
> When running Kselftests with the current selftests/net/config
> the following problem can be seen with the net:xfrm_policy.sh
> selftest:
> 
>   # selftests: net: xfrm_policy.sh
>   [   41.076721] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
>   [   41.094787] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
>   [   41.107635] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
>   # modprobe: FATAL: Module ip_tables not found in directory /lib/modules/6.1.36
>   # iptables v1.8.7 (legacy): can't initialize iptables table `filter': Table does not exist (do you need to insmod?)
>   # Perhaps iptables or your kernel needs to be upgraded.
>   # modprobe: FATAL: Module ip_tables not found in directory /lib/modules/6.1.36
>   # iptables v1.8.7 (legacy): can't initialize iptables table `filter': Table does not exist (do you need to insmod?)
>   # Perhaps iptables or your kernel needs to be upgraded.
>   # SKIP: Could not insert iptables rule
>   ok 1 selftests: net: xfrm_policy.sh # SKIP
> 
> [...]

Here is the summary with links:
  - selftests/net: Add xt_policy config for xfrm_policy test
    https://git.kernel.org/netdev/net/c/f56d1eeaeabf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


