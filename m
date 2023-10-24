Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B837D5CCD
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 23:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344361AbjJXVA3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 17:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344353AbjJXVA2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 17:00:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B423D10E3;
        Tue, 24 Oct 2023 14:00:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3334DC433C7;
        Tue, 24 Oct 2023 21:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698181225;
        bh=XbwDDDHUb0TA4KMbid2Sc5GNAmeqnpv06E3h35HAe2Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iQe7s8kcbk8ZcKnDqSaIOceVTtM1SeTE6Uaa02iRv2eigyxoTvCbpSD7n6ua42ToO
         oBwV129sirJDu3F0qx3jEhYJiuzRw8qEkfzEIx2b9w8uNluycdGIW1DQJpID1aQyah
         u/b1VLGfbY13zgc5ase9/xd5AKdPQsUulDyzLcXbAZcc6MwFILXT+KHo9qa7eFbPk7
         QqfZKRheWk0KIa+iyXP/S7/Oj8W3lPJHyapuL97z7nsqgkHdKtD3ujbpcwRBngYPfg
         AjOZ+zzpoVCbyGHvvqXk9TbKjxrslq4AcLrfwv6OQ4jinwGMZPVexB2xGcDnpT2B1R
         whlmqJsfBeFow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0ECADC3959F;
        Tue, 24 Oct 2023 21:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests:net change ifconfig with ip command
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169818122505.23262.9878970940813907976.git-patchwork-notify@kernel.org>
Date:   Tue, 24 Oct 2023 21:00:25 +0000
References: <20231023123422.2895-1-swarupkotikalapudi@gmail.com>
In-Reply-To: <20231023123422.2895-1-swarupkotikalapudi@gmail.com>
To:     Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Cc:     davem@davemloft.net, jiri@resnulli.us, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Oct 2023 18:04:22 +0530 you wrote:
> Change ifconfig with ip command,
> on a system where ifconfig is
> not used this script will not
> work correcly.
> 
> Test result with this patchset:
> 
> [...]

Here is the summary with links:
  - [v2] selftests:net change ifconfig with ip command
    https://git.kernel.org/netdev/net-next/c/37a38e439d4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


