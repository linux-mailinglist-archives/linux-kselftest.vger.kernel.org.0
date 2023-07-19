Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D218758A44
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 02:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjGSAuo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 20:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGSAul (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 20:50:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2159D1FCD;
        Tue, 18 Jul 2023 17:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DA23615A3;
        Wed, 19 Jul 2023 00:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AC50C4166B;
        Wed, 19 Jul 2023 00:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689727820;
        bh=gomJX7WZdIUn68JJd90qXrXndp2wVZptSNcutFvLGKs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uVTdgyI5kMXIHt3XZ5QWbBsfkCUbUvfcohqCsRY6YVU47cLpcONHkbTF/zuXGezNH
         TGEVSgEefb7zRCbUkhwPiwxajL5rAI+pwRr87n4Q0ZdUd6GDvDJFe/ZHvoRJ0q0sXS
         kT5xyBe/doy3VevxJOdcXGxWXlT1TymE4a8r0Gp8X9q8LRpa+vMigCHaRpAjy6oS55
         opHckKe3sa8vI3+OX1OqHXCJZalUYtKZsyzTmOnHtLcfAJJFCdTlINXC18UiegyJZ4
         Qrz9uwebFi+PBiM/e73C1WZJll34/cG/W0AStfU0mBOoUWRiCpxvwR9qoGV5YHHNCm
         FRgKJEQto1elw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C364C64458;
        Wed, 19 Jul 2023 00:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] selftests/net: replace manual array size calc with
 ARRAYSIZE macro.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168972782004.15840.17484255346823026.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Jul 2023 00:50:20 +0000
References: <20230716184349.2124858-1-mahmoudmatook.mm@gmail.com>
In-Reply-To: <20230716184349.2124858-1-mahmoudmatook.mm@gmail.com>
To:     Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
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
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 16 Jul 2023 22:43:49 +0400 you wrote:
> fixes coccinelle WARNING: Use ARRAY_SIZE
> 
> Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
> ---
> changelog since v3:
>  - move changelog outside commit message.
> 
> [...]

Here is the summary with links:
  - [v4] selftests/net: replace manual array size calc with ARRAYSIZE macro.
    https://git.kernel.org/netdev/net-next/c/3645c71b582b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


