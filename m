Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CAE60BE93
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 01:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJXXax (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Oct 2022 19:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiJXXaR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Oct 2022 19:30:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3BACF864;
        Mon, 24 Oct 2022 14:51:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 553E7B811F2;
        Mon, 24 Oct 2022 20:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EC91C433B5;
        Mon, 24 Oct 2022 20:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666642018;
        bh=3S5hiFhvcjejjJEBiIjk2JUBGQpO0l+zlfJvpwMCaLI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XVNFKP5bPz2hJM6LYKdigT1JaLJo5WZPHXPu89RLoUYmwpN5u5NY/p+ebZkUvdv2P
         qPIQagqHv3do0KgxV0DkvAiZbOTB9gHjHV51qeP9quw1oVGB/sMt0xc136bUFSY+7M
         JWS8faOOBqnw+fqbDdRzhorNwQML0L2c31j900o51mgt6ThT2l9GRG5oWglmHrSE6m
         li1AMqqUGcr2zeRW6kAkjyDyszmrKXe0NQgbMoeQV9hU5L8hH3ZfuTlMIwXrUMRzFo
         pSoSsL0Ez8ap2Z1nTq2f1iB4qR9vy9QoGEl8ywVzagXTBge93rZGiqkTJbty8Mi96A
         0z09kMAwYoC9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA8BEC4166D;
        Mon, 24 Oct 2022 20:06:57 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit fixes update for Linux 6.1-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f2934916-9b69-9603-9ae3-580b0c3eb97d@linuxfoundation.org>
References: <f2934916-9b69-9603-9ae3-580b0c3eb97d@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f2934916-9b69-9603-9ae3-580b0c3eb97d@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-6.1-rc3
X-PR-Tracked-Commit-Id: 618887768bb71f0a475334fa5a4fba7dc98d7ab5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a91e897c0e199f5d4cdc1a15f948133b15ec1f3
Message-Id: <166664201795.4311.8265466644045694797.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Oct 2022 20:06:57 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Mon, 24 Oct 2022 10:49:08 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-6.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a91e897c0e199f5d4cdc1a15f948133b15ec1f3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
