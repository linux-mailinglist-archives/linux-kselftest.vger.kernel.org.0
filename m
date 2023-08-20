Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004CA781F38
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Aug 2023 20:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjHTSQ4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 20 Aug 2023 14:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjHTSQw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 20 Aug 2023 14:16:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00841FE2
        for <linux-kselftest@vger.kernel.org>; Sun, 20 Aug 2023 11:13:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EFFD61B46
        for <linux-kselftest@vger.kernel.org>; Sun, 20 Aug 2023 18:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8F47C433C9;
        Sun, 20 Aug 2023 18:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692555205;
        bh=/kpJeZbH3cX6qT2GDtIuHy2iJvRa2GYhxoTx6CJOFFI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kXp8N2pS3j1Rb+VfljKd5QPj9dtcUAVoSDyX8WpiLtnSv1WfKXk/pxlvwrrxPNKE0
         RdPTNqZfetiHBrctAspxP8A3DeG2hNy24+GhnC9OLmJmtL/CGTTgYgwx0TDNgVYbgu
         47d8Qv7cuehiveyQEh0KfBf1IYgAcLpDghX+aB1cTQQUiFWIZRcHoAtxiIp5cichLv
         o9bZQZSRsuOMgMmtYMxrXEbdrbzBAFypjNfn4ujqTpdGP7EhB5yVz7PL7P4whhMS4p
         GqAvEjlrtFEGBfOP+Tsbq2QkAjewtUVL+BNOkmADfvSfpK6RS3JjXQ6PZt9KXrLTu7
         OyxF3113TiuYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1084E26D32;
        Sun, 20 Aug 2023 18:13:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] selftests/net: Add log.txt and tools to .gitignore
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169255520578.4244.2265053947731100162.git-patchwork-notify@kernel.org>
Date:   Sun, 20 Aug 2023 18:13:25 +0000
References: <20230818173702.216265-1-tuananhlfc@gmail.com>
In-Reply-To: <20230818173702.216265-1-tuananhlfc@gmail.com>
To:     Anh Tuan Phan <tuananhlfc@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 19 Aug 2023 00:37:02 +0700 you wrote:
> Update .gitignore to untrack tools directory and log.txt. "tools" is
> generated in "selftests/net/Makefile" and log.txt is generated in
> "selftests/net/gro.sh" when executing run_all_tests.
> 
> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
> ---
>  tools/testing/selftests/net/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [v1] selftests/net: Add log.txt and tools to .gitignore
    https://git.kernel.org/netdev/net/c/144e22e7569a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


