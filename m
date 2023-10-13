Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F255F7C8277
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 11:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjJMJuZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 05:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjJMJuY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 05:50:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C4BBE
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Oct 2023 02:50:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED200C433C9;
        Fri, 13 Oct 2023 09:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697190623;
        bh=8nZNXYCM0kCl/5zssxdd495/7tDEM/Zl1DBgwKO+mmw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ay8gvoa1BD8zDqp7CU3WvJSywdU3nCfwv3EODuYxEKQMDT4DhwdfXgd5Wj+0E8MPu
         BGyLYTXVqXz3KvyXQ4+DKsMsbd/Dw8I/lGbomatw8RPG7n0ZNb6du7bzbCA04PSMMw
         qbKuEAlIFDBnHezNUShWEoBb3oQ6fNgKl7/eDeeOsdXwEsnCQ1BOPszLraQ4rHh3jR
         r14odgm5PHHInsqerLuJMwKn8t6D5xSlCykdRYoFCSW+AvMN+BV6hXcd0VONPE5IJM
         nGAI6ORdCI7PxpDzpkmPKk7gkGod8ZCcg3BDZglFwkUubNxQZnQcOVdn1LrNqekLQc
         /gQRqpoO8bfpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D969BE11F41;
        Fri, 13 Oct 2023 09:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next] selftests: netdevsim: use suitable existing dummy
 file for flash test
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169719062288.23782.6011707693421892911.git-patchwork-notify@kernel.org>
Date:   Fri, 13 Oct 2023 09:50:22 +0000
References: <20231010144400.211191-1-jiri@resnulli.us>
In-Reply-To: <20231010144400.211191-1-jiri@resnulli.us>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
        davem@davemloft.net, shuah@kernel.org, pavan.chebbi@broadcom.com,
        linux-kselftest@vger.kernel.org
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
by David S. Miller <davem@davemloft.net>:

On Tue, 10 Oct 2023 16:44:00 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> The file name used in flash test was "dummy" because at the time test
> was written, drivers were responsible for file request and as netdevsim
> didn't do that, name was unused. However, the file load request is
> now done in devlink code and therefore the file has to exist.
> Use first random file from /lib/firmware for this purpose.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: netdevsim: use suitable existing dummy file for flash test
    https://git.kernel.org/netdev/net-next/c/6151ff9c7521

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


