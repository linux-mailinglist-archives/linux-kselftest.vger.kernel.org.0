Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9877534F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 10:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbjGNIUX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 04:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbjGNIUW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 04:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217339B
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jul 2023 01:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E13361C83
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jul 2023 08:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD753C433CD;
        Fri, 14 Jul 2023 08:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689322820;
        bh=H9U0qqTJn3MA7ez4KLxI1hnCbYJTzbxfSNFtUYz2bQA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eXsySg3bh+pEtmDg/kffaWOVJMavb0GIx+XtnBjEdtgBZVMKPNnMjZxLw+debCFFu
         tetpQ6GSbhf1N7zM45/9YL6fqgtW5xWZC0B19/yEbM4lHNPQd8uy35G6pY8wzHsnDO
         FaQwqDhLF+2A53hExfjIuPPW1rTUBaTeP0Fu3DVO7wIlEuc0IN2b/g0AbLhxlHwiIJ
         NT+Mx166u5mGIu7CknVI40k7pjPu0aKX6ub8D401AeymWInR6JYwwiYicc5JQzcwrS
         MfBfcfkie6PT2WFkCckhcr+tpDX+Ghr5i8Qw6+NkS2/nq+CNVIrZH4FYgeM3HqkxxX
         SPOtVAlgnzQww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CAF9BE49BBF;
        Fri, 14 Jul 2023 08:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] add MACsec offload selftests
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168932282082.1632.13701675853325201374.git-patchwork-notify@kernel.org>
Date:   Fri, 14 Jul 2023 08:20:20 +0000
References: <cover.1689173906.git.sd@queasysnail.net>
In-Reply-To: <cover.1689173906.git.sd@queasysnail.net>
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     netdev@vger.kernel.org, kuba@kernel.org, simon.horman@corigine.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 13 Jul 2023 15:20:22 +0200 you wrote:
> Patch 1 adds MACsec offload to netdevsim (unchanged from v2).
> 
> Patch 2 adds a corresponding selftest to the rtnetlink testsuite.
> 
> Sabrina Dubroca (2):
>   netdevsim: add dummy macsec offload
>   selftests: rtnetlink: add MACsec offload tests
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] netdevsim: add dummy macsec offload
    https://git.kernel.org/netdev/net-next/c/02b34d03a24b
  - [net-next,v3,2/2] selftests: rtnetlink: add MACsec offload tests
    https://git.kernel.org/netdev/net-next/c/3b5222e2ac57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


