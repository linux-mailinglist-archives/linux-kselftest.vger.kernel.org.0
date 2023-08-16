Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FED77D811
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 04:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238830AbjHPCA5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 22:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241128AbjHPCAZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 22:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BEB2109;
        Tue, 15 Aug 2023 19:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08F4363077;
        Wed, 16 Aug 2023 02:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69EAFC433C8;
        Wed, 16 Aug 2023 02:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692151223;
        bh=NjdvKGLWlMm7qpdjzpjXl///wrEx0Ff//txitn47H6E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=n4WmCbWX27u+ZIh/p0eXrmuek2LsQQdNPS0U/QI/6cWhLa2g9/rVxXAaQ0oa9RHRY
         GoSi/cj3OWEY3pqR5zI1CxgzCuufiZHHCL5gC/6ckxkfTMKilg5UHqHQuQ+7EXvF/w
         CqgroMJYG/7eX4hyZ+TrWpb4JqUKleVFpBrF9OmiI6NWNIens27z5MKQZPT9mxN/Pv
         IIuFjXYsUoCd7FtKuTYjr1chLocxIgXDWgQ4+B45xDf2u4YQE9jeXdoTnUfa0Oqk7W
         sZ4SHJXAJgE9vqLH6VDUY6oODnA2oAeOy/laAwhZeIUwuPIrgqSS8tgmufCIpju5+U
         KmkxsPxRH+g+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53D55C39562;
        Wed, 16 Aug 2023 02:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v2 0/2] seg6: add NEXT-C-SID support for SRv6 End.X
 behavior
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169215122333.15326.393610409728204600.git-patchwork-notify@kernel.org>
Date:   Wed, 16 Aug 2023 02:00:23 +0000
References: <20230812180926.16689-1-andrea.mayer@uniroma2.it>
In-Reply-To: <20230812180926.16689-1-andrea.mayer@uniroma2.it>
To:     Andrea Mayer <andrea.mayer@uniroma2.it>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, dsahern@kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, stefano.salsano@uniroma2.it,
        paolo.lungaroni@uniroma2.it, ahabdels.dev@gmail.com,
        liuhangbin@gmail.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 12 Aug 2023 20:09:24 +0200 you wrote:
> In the Segment Routing (SR) architecture a list of instructions, called
> segments, can be added to the packet headers to influence the forwarding and
> processing of the packets in an SR enabled network.
> 
> Considering the Segment Routing over IPv6 data plane (SRv6) [1], the segment
> identifiers (SIDs) are IPv6 addresses (128 bits) and the segment list (SID
> List) is carried in the Segment Routing Header (SRH). A segment may correspond
> to a "behavior" that is executed by a node when the packet is received.
> The Linux kernel currently supports a large subset of the behaviors described
> in [2] (e.g., End, End.X, End.T and so on).
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] seg6: add NEXT-C-SID support for SRv6 End.X behavior
    https://git.kernel.org/netdev/net-next/c/7458575a07f1
  - [net-next,v2,2/2] selftests: seg6: add selftest for NEXT-C-SID flavor in SRv6 End.X behavior
    https://git.kernel.org/netdev/net-next/c/1c53717c8074

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


