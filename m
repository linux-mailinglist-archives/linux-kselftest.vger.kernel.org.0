Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E5472237D
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 12:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjFEKa3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 06:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjFEKa2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 06:30:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1879FD
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 03:30:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F93262260
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 10:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7B8BC4339B;
        Mon,  5 Jun 2023 10:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685961025;
        bh=2L2uK0B49nA6JvrAKIky0xpu2CygDXxBs5ZD6P03gvo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qdAYBpcdi+Zx+xbnjtmDBFfQEQdyaURz/1UR9jpGjYErT8Wqm29ZdSziK0S212mgl
         BRUvQ+8dNuTNKw/KHVaw6pQVqrns5H5O7w6GtCWnvH2yRvffSHTD8/ZpNPib6TA9oP
         WS+PKZg0Zu/yXLX6vNNNCPNSvGYS7DbNGMTeAO/jjltYjm4Nwao5y5LxU1He9wxOuf
         iurizaIFFnobsNdZYKJBle6MuAuMVQUtaHLG3K5LwB/FaiG23A8qK1GYzy49+M6pnf
         EvK7J1zgh+qVssHHlia9QBOj3eMY5l7W6ZWYv1ir5LtAde/mZOnXUdTggfFiZc7x09
         wnCXOA20n1cFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6F28E49FA8;
        Mon,  5 Jun 2023 10:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] mlxsw, selftests: Cleanups
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168596102474.26938.22774406358566950.git-patchwork-notify@kernel.org>
Date:   Mon, 05 Jun 2023 10:30:24 +0000
References: <cover.1685720841.git.petrm@nvidia.com>
In-Reply-To: <cover.1685720841.git.petrm@nvidia.com>
To:     Petr Machata <petrm@nvidia.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
        amcohen@nvidia.com, danieller@nvidia.com,
        linux-kselftest@vger.kernel.org, mlxsw@nvidia.com
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
by David S. Miller <davem@davemloft.net>:

On Fri, 2 Jun 2023 18:20:04 +0200 you wrote:
> This patchset consolidates a number of disparate items that can all be
> considered cleanups. They are all related to mlxsw in that they are
> directly in mlxsw code, or in selftests that mlxsw heavily uses.
> 
> - patch #1 fixes a comment, patch #2 propagates an extack
> 
> - patches #3 and #4 tweak several loops to query a resource once and cache
>   in a local variable instead of querying on each iteration
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] mlxsw: spectrum_router: Clarify a comment
    https://git.kernel.org/netdev/net-next/c/be35db17c872
  - [net-next,2/8] mlxsw: spectrum_router: Use extack in mlxsw_sp~_rif_ipip_lb_configure()
    https://git.kernel.org/netdev/net-next/c/5afef6748c19
  - [net-next,3/8] mlxsw: spectrum_router: Do not query MAX_RIFS on each iteration
    https://git.kernel.org/netdev/net-next/c/3903249ee1af
  - [net-next,4/8] mlxsw: spectrum_router: Do not query MAX_VRS on each iteration
    https://git.kernel.org/netdev/net-next/c/75426cc0b316
  - [net-next,5/8] selftests: mlxsw: ingress_rif_conf_1d: Fix the diagram
    https://git.kernel.org/netdev/net-next/c/204cc3d04fe2
  - [net-next,6/8] selftests: mlxsw: egress_vid_classification: Fix the diagram
    https://git.kernel.org/netdev/net-next/c/34ad708d1b43
  - [net-next,7/8] selftests: router_bridge_vlan: Add a diagram
    https://git.kernel.org/netdev/net-next/c/812de4dfab98
  - [net-next,8/8] selftests: router_bridge_vlan: Set vlan_default_pvid 0 on the bridge
    https://git.kernel.org/netdev/net-next/c/f5136877f421

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


