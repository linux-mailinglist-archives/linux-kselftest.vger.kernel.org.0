Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37425701971
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 May 2023 21:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjEMTKX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 13 May 2023 15:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjEMTKW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 13 May 2023 15:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE9D26BE
        for <linux-kselftest@vger.kernel.org>; Sat, 13 May 2023 12:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9D3B61016
        for <linux-kselftest@vger.kernel.org>; Sat, 13 May 2023 19:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2B74C4339B;
        Sat, 13 May 2023 19:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684005021;
        bh=rMzEObVo1+RV026mKGwqGYRDOXtkjJwNnU5edhhv5SA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bf6d9fqb/C0NeZO26Q11fQve2+yJW4EkNsrpz2CbUqLVQPVk/V+DiaamgNc8jDGHg
         0hCUmd9wRezE+dqGISTQXOvlUu0yW97mF2bursoRfSUeblu2lcom35RuYJ9jHNYXZa
         VfLErewtzpAsP6H9YMl/PgjbhASt338MOgpEJgCYvOIEN5sV9zRUJ7wgvw29W1moYK
         F1wRb6YvwyfFKh6kKo8ZDOORM4O5OJXMPk9qvDDnb6g+rUvYF9XFcNpokCm3u4/GK4
         yLja2iaMtJnG7yXiPJme3gncxaZWzcc11bnSCsuU8UoL2dSrPuWxSh55rbvceZeEKG
         ujrFka4V4RVUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3993E450BB;
        Sat, 13 May 2023 19:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 1/2] net: vxlan: Add nolocalbypass option to
 vxlan.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168400502086.13341.13192654722542171149.git-patchwork-notify@kernel.org>
Date:   Sat, 13 May 2023 19:10:20 +0000
References: <20230512034034.16778-1-vladimir@nikishkin.pw>
In-Reply-To: <20230512034034.16778-1-vladimir@nikishkin.pw>
To:     Vladimir Nikishkin <vladimir@nikishkin.pw>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        eng.alaamohamedsoliman.am@gmail.com, gnault@redhat.com,
        razor@blackwall.org, idosch@nvidia.com, liuhangbin@gmail.com,
        eyal.birger@gmail.com, jtoppins@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
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

On Fri, 12 May 2023 11:40:33 +0800 you wrote:
> If a packet needs to be encapsulated towards a local destination IP, the
> packet will undergo a "local bypass" and be injected into the Rx path as
> if it was received by the target VXLAN device without undergoing
> encapsulation. If such a device does not exist, the packet will be
> dropped.
> 
> There are scenarios where we do not want to perform such a bypass, but
> instead want the packet to be encapsulated and locally received by a
> user space program for post-processing.
> 
> [...]

Here is the summary with links:
  - [net-next,v9,1/2] net: vxlan: Add nolocalbypass option to vxlan.
    https://git.kernel.org/netdev/net-next/c/69474a8a5837
  - [net-next,v9,2/2] selftests: net: vxlan: Add tests for vxlan nolocalbypass option.
    https://git.kernel.org/netdev/net-next/c/305c04189997

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


