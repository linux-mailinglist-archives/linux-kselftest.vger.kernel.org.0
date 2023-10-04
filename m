Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C057B8AF5
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 20:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243832AbjJDSn6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 14:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244511AbjJDSn5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 14:43:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A664BC0;
        Wed,  4 Oct 2023 11:43:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FED7C433C7;
        Wed,  4 Oct 2023 18:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445033;
        bh=q6rPdNZq2baoRk03GMOMmw78KZ96Xo8RT5Mm1ER+Mbg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YLX6rXReXVApojdKEA0yjQ0pbPi+A57grQ56rfnR5SpFo60rzIIAiZo+Nd/fruNyo
         Tv/jXZlXP9sHgjxMZO5xHg25KgXGhthpq4Ts5pvkqlF3u1UWZ7eZh4aJwfxLaoDZFE
         GT6YY+CNzjRa2duYrgcZIr49rl2om/F+A06sp4MmPtorsh8FeYh2+d8sUSuqQamgP4
         ezMInO3AyoFuyDJevnZbHeQr16NHF+B0XpGjJFDLKJUhI4px5HWMcFi8+lP8CpIWxq
         93Hd7gfl4AsqVJpw7fuUQZ8QsBmyq7C2Zgsx8HsTWkXmbIrAyM9TP0SWslCraHdFwH
         yy2cB2nKA/czw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2383CC395EC;
        Wed,  4 Oct 2023 18:43:53 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 6.6-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e9f9ee91-9e18-4a00-90a0-19b8ac47bbb3@linuxfoundation.org>
References: <e9f9ee91-9e18-4a00-90a0-19b8ac47bbb3@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e9f9ee91-9e18-4a00-90a0-19b8ac47bbb3@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.6-rc5
X-PR-Tracked-Commit-Id: 6f874fa021dfc7bf37f4f37da3a5aaa41fe9c39c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba7d997a2a29ee3fa766fee912c65796e0c21903
Message-Id: <169644503313.9683.18263879073120982789.pr-tracker-bot@kernel.org>
Date:   Wed, 04 Oct 2023 18:43:53 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Wed, 4 Oct 2023 09:46:00 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba7d997a2a29ee3fa766fee912c65796e0c21903

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
