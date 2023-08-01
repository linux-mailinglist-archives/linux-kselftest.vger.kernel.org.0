Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4F476A765
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 05:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjHADU0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 23:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjHADUZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 23:20:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA061BC6;
        Mon, 31 Jul 2023 20:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D825613FB;
        Tue,  1 Aug 2023 03:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8C53C433CC;
        Tue,  1 Aug 2023 03:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690860023;
        bh=R8XNStQlp0EGvcCW2i6RmASh0PhlCiaHydE7HfXLJAM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Xd07znuSPk7MFrc1XPZdYEZoztNRaA8V+w/ZC+G/02NXKBhcOtAFn6s/2IRnTxsah
         elGSCoytQQW94+1jrAYGBicvotO0lsekIJYMwh7F1Pa1xcEhfi9hCEWNwDF4tOgojv
         UOKBwPYjAP3fnsB2omtgSKxM+BDVOz4JxnzpLG7CZkmrA4xxeY3VhUdfq46bClW0DQ
         C0d5EQLWuEoCdmHWpqx9CspAaaQ7kJHUzKSUy07iVV0s+CKXSDQ6KYfPNCB3e2kKIV
         k+iDBa7/v12q+KsCpNMTWUZjEx9P4NUJtQ/DFFQQKnj6GmQSu/SPMJlPQK7GEjy1jm
         B5sVHyxIhszEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94D86E96AD8;
        Tue,  1 Aug 2023 03:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] mptcp: cleanup and improvements in the
 selftests
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169086002360.11962.11662635682041144649.git-patchwork-notify@kernel.org>
Date:   Tue, 01 Aug 2023 03:20:23 +0000
References: <20230730-upstream-net-next-20230728-mptcp-selftests-misc-v1-0-7e9cc530a9cd@tessares.net>
In-Reply-To: <20230730-upstream-net-next-20230728-mptcp-selftests-misc-v1-0-7e9cc530a9cd@tessares.net>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     mptcp@lists.linux.dev, martineau@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 30 Jul 2023 10:05:14 +0200 you wrote:
> This small series of 4 patches adds some improvements in MPTCP
> selftests:
> 
> - Patch 1 reworks the detailed report of mptcp_join.sh selftest to
>   better display what went well or wrong per test.
> 
> - Patch 2 adds colours (if supported, forced and/or not disabled) in
>   mptcp_join.sh selftest output to help spotting issues.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] selftests: mptcp: join: rework detailed report
    https://git.kernel.org/netdev/net-next/c/03668c65d153
  - [net-next,2/4] selftests: mptcp: join: colored results
    https://git.kernel.org/netdev/net-next/c/9466df1a27d5
  - [net-next,3/4] selftests: mptcp: pm_nl_ctl: always look for errors
    https://git.kernel.org/netdev/net-next/c/1dc88d241f92
  - [net-next,4/4] selftests: mptcp: userspace_pm: unmute unexpected errors
    https://git.kernel.org/netdev/net-next/c/6a5c8c69a4c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


