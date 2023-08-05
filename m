Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851F4770D0C
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 03:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjHEBa0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 21:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHEBaZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 21:30:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD411E72;
        Fri,  4 Aug 2023 18:30:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BA6662190;
        Sat,  5 Aug 2023 01:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAE76C433C7;
        Sat,  5 Aug 2023 01:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691199023;
        bh=pwzAgcSEzJzd2+U8fbKBX1WqagT3Y+bBXKBHZ+l48ik=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Rk6zzPclZOXAqHBB9oE9EW3EBuB+mRQuzXf9wjdj2z9h6HX+j3vJcAA/1FpQJ1isg
         JmQaxURcpZBXDymoODynt/ZuEAVaEjh6PO/iJk6Ts0IrxA3lgzuBgoqooHs/b2ROtL
         WedU6u4N7KAEDtjzTVQmCABKU8QD51L4EYk6++VjqF4Dl5MDWUREDOhvulqvYkcuOP
         Z+G/3ca34QpjBz1TU0DDA3VRmlc2/Q7c/F/6VBUEr6aWJTpxB3wmcxe9AMmigb0r6R
         KhztBNIkq70iQInZkKpqkEIjG+ykj7NKIUOGLNM5tpD+023v0txob46a0BQ0ZG9/0D
         UcxsIkRjI4lxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1DE6C64458;
        Sat,  5 Aug 2023 01:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] mptcp: more fixes for v6.5
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169119902365.19124.7615476498177445087.git-patchwork-notify@kernel.org>
Date:   Sat, 05 Aug 2023 01:30:23 +0000
References: <20230803-upstream-net-20230803-misc-fixes-6-5-v1-0-6671b1ab11cc@tessares.net>
In-Reply-To: <20230803-upstream-net-20230803-misc-fixes-6-5-v1-0-6671b1ab11cc@tessares.net>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     mptcp@lists.linux.dev, martineau@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        shuah@kernel.org, geliang.tang@suse.com, aclaudi@redhat.com,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        cpaasch@apple.com
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
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 03 Aug 2023 18:27:26 +0200 you wrote:
> Here is a new batch of fixes related to MPTCP for v6.5 and older.
> 
> Patches 1 and 2 fix issues with MPTCP Join selftest when manually
> launched with '-i' parameter to use 'ip mptcp' tool instead of the
> dedicated one (pm_nl_ctl). The issues have been there since v5.18.
> 
> Thank you Andrea for your first contributions to MPTCP code in the
> upstream kernel!
> 
> [...]

Here is the summary with links:
  - [net,1/4] selftests: mptcp: join: fix 'delete and re-add' test
    https://git.kernel.org/netdev/net/c/aaf2123a5cf4
  - [net,2/4] selftests: mptcp: join: fix 'implicit EP' test
    https://git.kernel.org/netdev/net/c/c8c101ae390a
  - [net,3/4] mptcp: avoid bogus reset on fallback close
    https://git.kernel.org/netdev/net/c/ff18f9ef30ee
  - [net,4/4] mptcp: fix disconnect vs accept race
    https://git.kernel.org/netdev/net/c/511b90e39250

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


