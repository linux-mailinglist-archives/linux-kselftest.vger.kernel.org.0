Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F9378F906
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Sep 2023 09:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjIAHUn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Sep 2023 03:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbjIAHUn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Sep 2023 03:20:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27FB10E7
        for <linux-kselftest@vger.kernel.org>; Fri,  1 Sep 2023 00:20:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 368FF62211
        for <linux-kselftest@vger.kernel.org>; Fri,  1 Sep 2023 07:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E952C433CA;
        Fri,  1 Sep 2023 07:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693552826;
        bh=DApnd1I1M7tPP3FQYmwz1hqYKhai3MSeYwUhC2rhgy4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Zu52ILoNar8ikR3tqWfK5BarfPmqJubjMqwAJiy/nETCUAAS41OrNLPuqtqo9ax3F
         EFeBoDV19D4AYGLACZmTLDHlTbSheHCclikpWdpk1mZX6XTpFr2lNNoGNAZqlMH7jL
         WrKYDGeO/UZWBaph6/JOt042WKof/eTlkjkAAmHFJHeDDhoEvK9HOLCwupGt1d3hEI
         0fSDZz9TlC3NJOi/X1OUUe5rYT2aCoTkbmbbSmqo5sg78doVBjNO5GYTVrQtxnnqPa
         uGZNSomhCtuPzh3HUBoiCgMFWCBlM1hIgiY8cjdI/YB2ToVcsig8UG1d3NxGL5gsws
         nYvEH+3RPofYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71348E29F3C;
        Fri,  1 Sep 2023 07:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/3] Avoid TCP resets when using ECMP for
 load-balancing between multiple servers.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169355282645.26042.10042992881944886575.git-patchwork-notify@kernel.org>
Date:   Fri, 01 Sep 2023 07:20:26 +0000
References: <20230831080332.2495-1-sriram.yagnaraman@est.tech>
In-Reply-To: <20230831080332.2495-1-sriram.yagnaraman@est.tech>
To:     Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com,
        shuah@kernel.org, petrm@nvidia.com
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

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 31 Aug 2023 10:03:29 +0200 you wrote:
> All packets in the same flow (L3/L4 depending on multipath hash policy)
> should be directed to the same target, but after [0]/[1] we see stray
> packets directed towards other targets. This, for instance, causes RST
> to be sent on TCP connections.
> 
> The first two patches solve the problem by ignoring route hints for
> destinations that are part of multipath group, by using new SKB flags
> for IPv4 and IPv6. The third patch is a selftest that tests the
> scenario.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/3] ipv4: ignore dst hint for multipath routes
    https://git.kernel.org/netdev/net/c/6ac66cb03ae3
  - [net,v5,2/3] ipv6: ignore dst hint for multipath routes
    https://git.kernel.org/netdev/net/c/8423be8926aa
  - [net,v5,3/3] selftests: fib_tests: Add multipath list receive tests
    https://git.kernel.org/netdev/net/c/8ae9efb859c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


