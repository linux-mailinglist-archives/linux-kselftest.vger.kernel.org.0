Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BBB799F39
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Sep 2023 20:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjIJSA0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 10 Sep 2023 14:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjIJSA0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 10 Sep 2023 14:00:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FB4184;
        Sun, 10 Sep 2023 11:00:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBAE2C433C9;
        Sun, 10 Sep 2023 18:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694368821;
        bh=aB2UE18ifINeruLLLa2U/ieX/8koQ+oI9z8xxKyuIvQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MvVSVRjqFOB3eCa3WcubwQYCaCUPa8zQFD7ptrdEGSvNLrohKfmSPe/ZoqVIpfsza
         JWpKaY2Y0z+Pj+aCXosA6wD2Jvq0w/hcp76ns+3cKuCwl8HMIFsy/t48QvymK0LV4j
         RfIMhUPofSTMLj8+c0JhugcTC6NZsHF5HPclEAeoPLPV8/WCvmJq6cuT8ofOei38iX
         Wogu5cxMObHF2bGyD31jaLAW/e7G8XUnJE3/xL6wIanepGr3H8Ndp9YywQAZd4Ekid
         NuBFJPRx5MF0YtvlMfpkht8e6j54EwLmd0nOZd8QZsZhbfai1OZWiRlzVUS7B7tHhD
         a8Els9WHw2rpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0E2EE505B7;
        Sun, 10 Sep 2023 18:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/net: Improve bind_bhash.sh to accommodate
 predictable network interface names
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169436882172.20878.148707165455399821.git-patchwork-notify@kernel.org>
Date:   Sun, 10 Sep 2023 18:00:21 +0000
References: <VI1P193MB0752FDA6D89743CF57FB600599EFA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <VI1P193MB0752FDA6D89743CF57FB600599EFA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
To:     Juntong Deng <juntong.deng@outlook.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
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

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  7 Sep 2023 00:26:03 +0800 you wrote:
> Starting with v197, systemd uses predictable interface network names,
> the traditional interface naming scheme (eth0) is deprecated, therefore
> it cannot be assumed that the eth0 interface exists on the host.
> 
> This modification makes the bind_bhash test program run in a separate
> network namespace and no longer needs to consider the name of the
> network interface on the host.
> 
> [...]

Here is the summary with links:
  - selftests/net: Improve bind_bhash.sh to accommodate predictable network interface names
    https://git.kernel.org/netdev/net/c/ced33ca07d8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


