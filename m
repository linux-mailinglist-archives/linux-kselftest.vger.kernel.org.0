Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C82748196
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jul 2023 12:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjGEKA1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jul 2023 06:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjGEKA0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jul 2023 06:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2021723;
        Wed,  5 Jul 2023 03:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15155614EC;
        Wed,  5 Jul 2023 10:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7181EC433CA;
        Wed,  5 Jul 2023 10:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688551223;
        bh=rfKwXHw/MObGrKQHHxQ3kXk+3dEtPedetkvV200qdBA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=i7DLBNU9u74goYVpIpur4MOnr3DPPgafPqv3zyjUTrOLo7DxhosmRCu1pbSZ7PvSL
         3Kdc6u+SuLg6v45+2FkhX37ZL0sRcMtxEuJWFVDrncyYySTIR07gr6wC67EaNlKaPp
         voua6jvdKjCC7vLHuyP6p45Re2YdZQ4O53jfYTzham6f1Rh+4VbPMWs3Iw5RjBBPEh
         nKmUBWhxKP9nCiUK/ksgfvIBWlN/+b6RMRa44F4cOhMsS7vJP8R7WoA/zg150hmlGN
         70LtwZSQShBCSkwxtgHIS/a+54rAzVyfoB4OGO9DGIcpdWyqM2AMYi83blCE0P1OKL
         OqLKfBnuiz05A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E528C0C40E;
        Wed,  5 Jul 2023 10:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/9] mptcp: fixes for v6.5
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168855122331.15504.15239551564077359539.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Jul 2023 10:00:23 +0000
References: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-0-d7e67c274ca5@tessares.net>
In-Reply-To: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-0-d7e67c274ca5@tessares.net>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     mptcp@lists.linux.dev, martineau@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        shuah@kernel.org, fw@strlen.de, kishen.maloor@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        cpaasch@apple.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 04 Jul 2023 22:44:32 +0200 you wrote:
> Here is a first batch of fixes for v6.5 and older.
> 
> The fixes are not linked to each others.
> 
> Patch 1 ensures subflows are unhashed before cleaning the backlog to
> avoid races. This fixes another recent fix from v6.4.
> 
> [...]

Here is the summary with links:
  - [net,1/9] mptcp: ensure subflow is unhashed before cleaning the backlog
    https://git.kernel.org/netdev/net/c/3fffa15bfef4
  - [net,2/9] mptcp: do not rely on implicit state check in mptcp_listen()
    https://git.kernel.org/netdev/net/c/0226436acf24
  - [net,3/9] selftests: mptcp: connect: fail if nft supposed to work
    https://git.kernel.org/netdev/net/c/221e4550454a
  - [net,4/9] selftests: mptcp: sockopt: use 'iptables-legacy' if available
    https://git.kernel.org/netdev/net/c/a5a5990c099d
  - [net,5/9] selftests: mptcp: sockopt: return error if wrong mark
    https://git.kernel.org/netdev/net/c/9ac4c28eb70c
  - [net,6/9] selftests: mptcp: userspace_pm: use correct server port
    https://git.kernel.org/netdev/net/c/d8566d0e0392
  - [net,7/9] selftests: mptcp: userspace_pm: report errors with 'remove' tests
    https://git.kernel.org/netdev/net/c/966c6c3adfb1
  - [net,8/9] selftests: mptcp: depend on SYN_COOKIES
    https://git.kernel.org/netdev/net/c/6c8880fcaa5c
  - [net,9/9] selftests: mptcp: pm_nl_ctl: fix 32-bit support
    https://git.kernel.org/netdev/net/c/61d965805026

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


