Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A48E76A353
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 23:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjGaVu1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 17:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjGaVu0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 17:50:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344EE173F;
        Mon, 31 Jul 2023 14:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AC3661300;
        Mon, 31 Jul 2023 21:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 830EEC433CA;
        Mon, 31 Jul 2023 21:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690840222;
        bh=HRUAYLY4xMp5A21cfdxIGXZgK/4NLgM8TKnmkB3vKl4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=J+oiR05Po6f7gdgEkH5gS0PcUNqJP2avdwKvcHmq8EI3N9+EDfRFntp+oTIxBnRTT
         Fa63T58zWEGqkBpOKeMRwjJ8ZUkZMDFDMGJFar2QowBOaIMY9Lmwv+Gq3k2D6oOL2T
         qnYPy/144SO6E38pnoEwmKjaKt8OCgVjUUjAbBbsJltvsiYA0NPd15nhcM7SrhP0zZ
         UU/7SKzlhf9htf1vjLQqn4ppEi3vHt7uIskHmU1qxDRSOL9yFnA8YcjVefwmvoXIaY
         jMo461lprdODQc0sIV5GxIw6fbGaEfNnv9etHoowiWkW/ZqfobV4qneSUu8god3Z6Q
         ejN+O6YPpUucg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58455C595C5;
        Mon, 31 Jul 2023 21:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH next 0/3] Connector/proc_filter test fixes 
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169084022235.13504.17826979255292322380.git-patchwork-notify@kernel.org>
Date:   Mon, 31 Jul 2023 21:50:22 +0000
References: <cover.1690564372.git.skhan@linuxfoundation.org>
In-Reply-To: <cover.1690564372.git.skhan@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, Liam.Howlett@oracle.com,
        anjali.k.kulkarni@oracle.com, naresh.kamboju@linaro.org,
        kuba@kernel.org, davem@davemloft.net, lkft-triage@lists.linaro.org,
        netdev@vger.kernel.org, llvm@lists.linux.dev,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, 28 Jul 2023 11:29:25 -0600 you wrote:
> This 3 patch series consists of fixes to proc_filter test
> found during linun-next testing.
> 
> The first patch fixes the LKFT reported compile error, second
> one adds .gitignore and the third fixes error paths to skip
> instead of fail (root check, and argument checks)
> 
> [...]

Here is the summary with links:
  - [next,1/3] selftests:connector: Fix Makefile to include KHDR_INCLUDES
    https://git.kernel.org/netdev/net-next/c/165f6890586e
  - [next,2/3] selftests:connector: Add .gitignore and poupulate it with test
    https://git.kernel.org/netdev/net-next/c/f4dcfa6fa1a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


