Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B1673CD3D
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 00:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjFXWUW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 24 Jun 2023 18:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFXWUV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 24 Jun 2023 18:20:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7F010D3
        for <linux-kselftest@vger.kernel.org>; Sat, 24 Jun 2023 15:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B3F960AB3
        for <linux-kselftest@vger.kernel.org>; Sat, 24 Jun 2023 22:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6658C433CA;
        Sat, 24 Jun 2023 22:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687645219;
        bh=K57FsvDdDsQvc6eBxw1iMwtDiWoqnphia826r61uT3o=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LWwO3NiN57OSRe0PXPNoDLEGDLODcTDgVclO3tqyFra50+dzMYefFaWh3Rbud03c/
         gOpfDQeJP12RdvWeDdirshZPJsjdytVxvYExw5459Y3P1WQYru2QYjt/ujKxzWrOIM
         o+lA6MlPNO9qdb7wvNkfqNc4isEoWCP4XkN99bzO7kBqkAEIkYE4JjPHOBJJyDOJGG
         yjG7igaqr/UXYWmtLlPDED+F+GxffcI/ox4Rpj3MLmR1EbNbadqg5tEDhCgnHreSnB
         2R8BPvr0kR6ysI+B8eOE0HVdZftW6wHRO6UMSw5KYH7UbkxSPLnjFDOVBlu9bxc5+k
         Ujs5R4IygvAXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88599C43157;
        Sat, 24 Jun 2023 22:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: rtnetlink: remove netdevsim device after ipsec
 offload test
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168764521955.22804.7450435784531069720.git-patchwork-notify@kernel.org>
Date:   Sat, 24 Jun 2023 22:20:19 +0000
References: <e1cb94f4f82f4eca4a444feec4488a1323396357.1687466906.git.sd@queasysnail.net>
In-Reply-To: <e1cb94f4f82f4eca4a444feec4488a1323396357.1687466906.git.sd@queasysnail.net>
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     netdev@vger.kernel.org, jiri@resnulli.us, shuah@kernel.org,
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

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jun 2023 23:03:34 +0200 you wrote:
> On systems where netdevsim is built-in or loaded before the test
> starts, kci_test_ipsec_offload doesn't remove the netdevsim device it
> created during the test.
> 
> Fixes: e05b2d141fef ("netdevsim: move netdev creation/destruction to dev probe")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> 
> [...]

Here is the summary with links:
  - [net] selftests: rtnetlink: remove netdevsim device after ipsec offload test
    https://git.kernel.org/netdev/net/c/5f789f103671

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


