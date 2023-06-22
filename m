Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205F5739A1F
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 10:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjFVIkk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Jun 2023 04:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjFVIk2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Jun 2023 04:40:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4081FF5
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Jun 2023 01:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C5146179C
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Jun 2023 08:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDECCC433C0;
        Thu, 22 Jun 2023 08:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687423220;
        bh=mHsfH1YWMYkA8WbtKOS2o31G1h9+Y07sYPDLLUVEuUk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uvHDVWMZq9G7tCMWeTiehspYxEEAIUlqiwivVqsUVZxMUG58NefALXpHp7hh42KSB
         a21VK7wMvnzbLzP7tRtjyRx++6dY5Fi5eqvwq/3huwVi7Zk+NMJgahQN4u5MB0nOuO
         jFuPQqmAOPdwG1B6QjyZG8wWW7z+EARBIa5k33knzizmluzkHRzYxsfX8SBFjgZQJ0
         xwqpIGcI4ApQdXfWhQghMGGT6HbJPcSpX87qjQHei+24weELRBvQpnr4Tc3qy/FlzL
         LjyOAMYJyytQIma8iywAtOeW0bw8VmYzmyaw1+lloR42gXvidSsL0QideZ7hTx5EyG
         rurfpOKXSRJ7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9BA57C691EF;
        Thu, 22 Jun 2023 08:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: forwarding: Fix race condition in mirror
 installation
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168742322063.10780.9759813024046689173.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Jun 2023 08:40:20 +0000
References: <268816ac729cb6028c7a34d4dda6f4ec7af55333.1687264607.git.petrm@nvidia.com>
In-Reply-To: <268816ac729cb6028c7a34d4dda6f4ec7af55333.1687264607.git.petrm@nvidia.com>
To:     Petr Machata <petrm@nvidia.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org, danieller@nvidia.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, mlxsw@nvidia.com
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
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 20 Jun 2023 14:45:15 +0200 you wrote:
> From: Danielle Ratson <danieller@nvidia.com>
> 
> When mirroring to a gretap in hardware the device expects to be
> programmed with the egress port and all the encapsulating headers. This
> requires the driver to resolve the path the packet will take in the
> software data path and program the device accordingly.
> 
> [...]

Here is the summary with links:
  - [net] selftests: forwarding: Fix race condition in mirror installation
    https://git.kernel.org/netdev/net/c/c7c059fba6fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


