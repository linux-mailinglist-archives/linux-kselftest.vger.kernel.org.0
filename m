Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D799370679D
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 14:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjEQMKY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 08:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjEQMKX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 08:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23839189
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 05:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA8E764645
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 12:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13809C433D2;
        Wed, 17 May 2023 12:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684325422;
        bh=WkffU6QPye9oDs/VVkB255WhFgC/yxBq7R2kpafb9/U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ce4sgn2KOIrAGUuiXkwrxDCfxUM12QLBpB3CzdV3rWiwYrq4k728hlB3ZIt5sqY3k
         8R4DRW7qZdz9kBHjoCUFen2QB4X2GoMu7JqUm1YQogBjnI4mfUjUzYpbFt+sljJIKu
         pnH5sVSLDwzJe9QCN0L54tZ/CsMThoJ5Ec35uFqEiCa1n+0MixP6P8q47hdCTR+wE+
         9xgmzB6z67YsFXLvxX0g4Ao6o5VSKKl+GrgW249hxpv1zNJxIT1br22AioLX9xtlra
         4GJ9igOJolLpDXBW2BFWGolCe4pzv+1cLuKAyh8iQuutCZRfQZsjiYeNVePXCsKL6v
         kOClqhcqZ9H6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E63B4E21EEC;
        Wed, 17 May 2023 12:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: selftests: Fix optstring
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168432542193.5953.5435718543306108946.git-patchwork-notify@kernel.org>
Date:   Wed, 17 May 2023 12:10:21 +0000
References: <20230516184924.153498-1-bpoirier@nvidia.com>
In-Reply-To: <20230516184924.153498-1-bpoirier@nvidia.com>
To:     Benjamin Poirier <bpoirier@nvidia.com>
Cc:     netdev@vger.kernel.org, amcohen@nvidia.com,
        linux-kselftest@vger.kernel.org, idosch@nvidia.com
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

On Tue, 16 May 2023 14:49:24 -0400 you wrote:
> The cited commit added a stray colon to the 'v' option. That makes the
> option work incorrectly.
> 
> ex:
> tools/testing/selftests/net# ./fib_nexthops.sh -v
> (should enable verbose mode, instead it shows help text due to missing arg)
> 
> [...]

Here is the summary with links:
  - [net] net: selftests: Fix optstring
    https://git.kernel.org/netdev/net/c/9ba9485b87ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


