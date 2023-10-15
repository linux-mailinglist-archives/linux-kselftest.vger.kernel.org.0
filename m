Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB7C7C9AED
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Oct 2023 21:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjJOTKZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Oct 2023 15:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjJOTKZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Oct 2023 15:10:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482EFC5;
        Sun, 15 Oct 2023 12:10:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0DDCC433C9;
        Sun, 15 Oct 2023 19:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697397023;
        bh=J0G7xRI+dz2lTSms94crS+csF2xB8Yy166ftDr4IzeQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XV0FMx51MAmZZfEBnjzqC1LDBIYC4D4Pd4tjm/N31D575+enfcobi4zEFwa7FS6sJ
         Gm7F/kqTFNAzuUJf4d2lVbNUVH8DIBJAYmWZL7jbdxzuQ0HyIq97fFNrIxxduWwo2s
         YIJB183jxCePradMObglbjCmPxBqciqgcyEODSN4sHfMT5gRgD0eq/zoAK12DWIBNL
         SKdUGkmWIaihA63qpbTkMyn4evBOWKGbyZHBMyNpIAkLxQkASf5j1/7tgm76eROcux
         igu8pHzzr1KOzDBX8ckggJRfx57qycd7ushTCKkYB3byZ/UjEXjexZw2+ZKGBIzERS
         83mqjl0lYjUxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2125C691EF;
        Sun, 15 Oct 2023 19:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/4] selftests: openvswitch: Minor fixes for some
 systems
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169739702379.16848.2168367864052155252.git-patchwork-notify@kernel.org>
Date:   Sun, 15 Oct 2023 19:10:23 +0000
References: <20231011194939.704565-1-aconole@redhat.com>
In-Reply-To: <20231011194939.704565-1-aconole@redhat.com>
To:     Aaron Conole <aconole@redhat.com>
Cc:     netdev@vger.kernel.org, dev@openvswitch.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        pshelar@ovn.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, amorenoz@redhat.com,
        echaudro@redhat.com, shuah@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 11 Oct 2023 15:49:35 -0400 you wrote:
> A number of corner cases were caught when trying to run the selftests on
> older systems.  Missed skip conditions, some error cases, and outdated
> python setups would all report failures but the issue would actually be
> related to some other condition rather than the selftest suite.
> 
> Address these individual cases.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/4] selftests: openvswitch: Add version check for pyroute2
    https://git.kernel.org/netdev/net/c/92e37f20f20a
  - [net,v2,2/4] selftests: openvswitch: Catch cases where the tests are killed
    https://git.kernel.org/netdev/net/c/af846afad5ca
  - [net,v2,3/4] selftests: openvswitch: Skip drop testing on older kernels
    https://git.kernel.org/netdev/net/c/76035fd12cb9
  - [net,v2,4/4] selftests: openvswitch: Fix the ct_tuple for v4
    https://git.kernel.org/netdev/net/c/8eff0e062201

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


