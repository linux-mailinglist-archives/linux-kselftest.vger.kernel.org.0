Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAC472B3E7
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jun 2023 22:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjFKUKV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 11 Jun 2023 16:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFKUKV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 11 Jun 2023 16:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36A099
        for <linux-kselftest@vger.kernel.org>; Sun, 11 Jun 2023 13:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38B6161010
        for <linux-kselftest@vger.kernel.org>; Sun, 11 Jun 2023 20:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8848CC4339B;
        Sun, 11 Jun 2023 20:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686514219;
        bh=kxItdV2xrsIwVRSmOAfsIMjWriPh99MIZwn1F5ZwZF8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZevjjO+Nf8TtlDJhSLvOz4DyPMdocF3FHMGZx6GsYQTMtjfvtYYx/Do446ZH+CgBE
         G3//426I3HFJcjyUm4nbnnzCa5d2ZiHzW+bEI5i8ueLLJYatWplLv04H/LhViN8IE2
         OtFZthU3svUD5POde4Gjrvb79oozkKGM1ZmgBxij6zR6xrGqC1oC8b2Ny/z269b3PG
         rxHof8ax0P4+MqGE9khr2h+dWd73iU0odAQtKO6j7y/m0x+mrA3khL76ZxInjBP8m7
         tn1HNJ7b/+DJvL5hcod7C2FwmkPe3QiXKJIYDX1JBAPI64/0FayuKV5yO5/xJ+T8kB
         GflBQVHmn7uSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BFEFC43143;
        Sun, 11 Jun 2023 20:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests: net: vxlan: Fix selftest regression
 after changes in iproute2.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168651421943.22537.15519197522384035626.git-patchwork-notify@kernel.org>
Date:   Sun, 11 Jun 2023 20:10:19 +0000
References: <20230608064448.2437-1-vladimir@nikishkin.pw>
In-Reply-To: <20230608064448.2437-1-vladimir@nikishkin.pw>
To:     Vladimir Nikishkin <vladimir@nikishkin.pw>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        eng.alaamohamedsoliman.am@gmail.com, gnault@redhat.com,
        razor@blackwall.org, idosch@nvidia.com, liuhangbin@gmail.com,
        eyal.birger@gmail.com, jtoppins@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stephen@networkplumber.org
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

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  8 Jun 2023 14:44:48 +0800 you wrote:
> The iproute2 output that eventually landed upstream is different than
> the one used in this test, resulting in failures. Fix by adjusting the
> test to use iproute2's JSON output, which is more stable than regular
> output.
> 
> Fixes: 305c04189997 ("selftests: net: vxlan: Add tests for vxlan nolocalbypass option.")
> Signed-off-by: Vladimir Nikishkin <vladimir@nikishkin.pw>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests: net: vxlan: Fix selftest regression after changes in iproute2.
    https://git.kernel.org/netdev/net-next/c/26a4dd839eeb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


