Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2718576A767
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 05:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjHADU1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 23:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjHADUZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 23:20:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F631BC7;
        Mon, 31 Jul 2023 20:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F0C361407;
        Tue,  1 Aug 2023 03:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7D3DC4339A;
        Tue,  1 Aug 2023 03:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690860023;
        bh=iTMikfldINqWqsR1JIcAlJUaV/udL2WHA91wXWhrUS8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sA6emx7gv3Ox5ESHA264b0zyShHx16gwFx3Ufigr4DxORTc5k4jis0tIwiJ4z0Uv4
         kATRdooJbVronWNxx70GsiKwEitMCCGsANs2gc9Dxya76CWAxbNsBAGoVPx5cGipOO
         QCWyrYMa9yUOOO05JJprHuL/JiebhuMk1kaOOwTV5qRJ6Du+vwtgL/8QEnsLvA0cgT
         tJZZXEv4EL5Kv7mIl9QzeCOL0yztqkMAehvg+LnnPmQG/17iM/IbN8jH1CojIbQNAw
         kXqrpxzNkOA9FPR5PCxDLeYknq+KFr9GWrTDLialzQrUe+pIvvPOrK1dx1lfAxW0UB
         A+Jrm0hoUU/hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A88DCC64458;
        Tue,  1 Aug 2023 03:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH v2] selftests:connector: Fix input argument error paths
 to skip
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169086002368.11962.9239503173923058781.git-patchwork-notify@kernel.org>
Date:   Tue, 01 Aug 2023 03:20:23 +0000
References: <20230729002403.4278-1-skhan@linuxfoundation.org>
In-Reply-To: <20230729002403.4278-1-skhan@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, Liam.Howlett@oracle.com,
        anjali.k.kulkarni@oracle.com, kuba@kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Jul 2023 18:24:03 -0600 you wrote:
> Fix input argument parsing paths to skip from their error legs.
> This fix helps to avoid false test failure reports without running
> the test.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> v2: Removed root check based on Anjali's review comments.
> Add netdev to RESEND
> 
> [...]

Here is the summary with links:
  - [RESEND,v2] selftests:connector: Fix input argument error paths to skip
    https://git.kernel.org/netdev/net-next/c/04786c0659db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


