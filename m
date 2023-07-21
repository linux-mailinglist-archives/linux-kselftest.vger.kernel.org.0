Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B64975BCCA
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jul 2023 05:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjGUDa0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 23:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjGUDaZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 23:30:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985B01726;
        Thu, 20 Jul 2023 20:30:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 349666010E;
        Fri, 21 Jul 2023 03:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84A23C433CA;
        Fri, 21 Jul 2023 03:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689910223;
        bh=UAskOFtaZ+TaZ2/xO+ZiGvJ2EWkR0CxM8zJi0SrkADU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=agwpxmdPttVsCQyM7MND/000TMAOFOo7V5oRqxEaVolkfsLcPH4CnRf7z1bCSk2kC
         Qfe1cngTCpiH+Y0Pr/IHoktM6seCA7KPLjTrbaD+m9gi7m9AiPOnVOIoyNab3HpMHv
         IrkGK3xz9riRF5qffNGkuUGFvCuj3QHDBn8c4jEGc/j3E0aR0OftNk3SwsKf7uhGfe
         KSEE1BlbK/kTzRSsZHXJ1vuDdXcJK6LDBwLxy/7/WJ/ZjEUH+MMpHbIjATWmjQJur3
         ER9ND27Ow3EJET4FqRTNNbpYv89AuGO7iLVVzmZCrqmJnmxK0qCGJ+YtWyYx6zffkJ
         e9uHa6uhdUUng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65A00C595C5;
        Fri, 21 Jul 2023 03:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] nexthop: Refactor and fix nexthop selection
 for multipath routes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168991022341.12176.7087140976082292516.git-patchwork-notify@kernel.org>
Date:   Fri, 21 Jul 2023 03:30:23 +0000
References: <20230719-nh_select-v2-0-04383e89f868@nvidia.com>
In-Reply-To: <20230719-nh_select-v2-0-04383e89f868@nvidia.com>
To:     Benjamin Poirier <bpoirier@nvidia.com>
Cc:     dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Jul 2023 13:57:06 +0000 you wrote:
> In order to select a nexthop for multipath routes, fib_select_multipath()
> is used with legacy nexthops and nexthop_select_path_hthr() is used with
> nexthop objects. Those two functions perform a validity test on the
> neighbor related to each nexthop but their logic is structured differently.
> This causes a divergence in behavior and nexthop_select_path_hthr() may
> return a nexthop that failed the neighbor validity test even if there was
> one that passed.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] nexthop: Factor out hash threshold fdb nexthop selection
    https://git.kernel.org/netdev/net-next/c/eedd47a6ec9f
  - [net-next,v2,2/4] nexthop: Factor out neighbor validity check
    https://git.kernel.org/netdev/net-next/c/4bb5239b4334
  - [net-next,v2,3/4] nexthop: Do not return invalid nexthop object during multipath selection
    https://git.kernel.org/netdev/net-next/c/75f5f04c7bd2
  - [net-next,v2,4/4] selftests: net: Add test cases for nexthop groups with invalid neighbors
    https://git.kernel.org/netdev/net-next/c/c7e95bbda822

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


