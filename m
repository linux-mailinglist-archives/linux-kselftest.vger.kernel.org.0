Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FAA7CA1A1
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 10:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjJPIaw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 04:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJPIav (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 04:30:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F61B4;
        Mon, 16 Oct 2023 01:30:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84196C43395;
        Mon, 16 Oct 2023 08:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697445049;
        bh=DOh/Dn4riXMOxmCe1w4Jo11cFO7dxLPkLHjXE2zEcCk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kFoPYwtUaMVqquLQ5hGcK1A+5tmvYUnKmXKP1eMBgsgPz5w5kD8Xokxi6r0PsGMcf
         yTTMCf/X3lx1V6Uhx4t4DEo2vH1FVAAdEUsmBef08Oo8Gl2/mPhXIxWyfxpjrSz3I0
         6EApIC4rJqC/6ZrhrhbX8BlSuxPbMxuQdGkYs+O6UU2loEuxeTj7gN4e6290PyDE39
         AYgKT20u93b+XlRzr0yDLHJ5M7ZKaP54ta8qkGJy98NsVvdolvAvW3EUYAUxJym0Ju
         zINUGoP/6rofMNwDEGf4cN+RMlQo82RtzVLq5kmE6PrACMxpYW/AXCbZGQ9ThCs7tb
         7yiJljvVP1QXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E695C43170;
        Mon, 16 Oct 2023 08:30:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests: net: remove unused variables
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169744504944.19592.15378403408237334163.git-patchwork-notify@kernel.org>
Date:   Mon, 16 Oct 2023 08:30:49 +0000
References: <20231016063039.3771-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20231016063039.3771-1-zhujun2@cmss.chinamobile.com>
To:     zhujun2 <zhujun2@cmss.chinamobile.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 15 Oct 2023 23:30:39 -0700 you wrote:
> These variables are never referenced in the code, just remove them
> 
> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/net/af_unix/scm_pidfd.c     | 1 -
>  tools/testing/selftests/net/af_unix/test_unix_oob.c | 2 --
>  tools/testing/selftests/net/nettest.c               | 5 +++--
>  3 files changed, 3 insertions(+), 5 deletions(-)

Here is the summary with links:
  - selftests: net: remove unused variables
    https://git.kernel.org/netdev/net-next/c/3c4fe89878fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


