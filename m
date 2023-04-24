Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B470B6ED583
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Apr 2023 21:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjDXTtu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Apr 2023 15:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbjDXTti (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Apr 2023 15:49:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2615FD8;
        Mon, 24 Apr 2023 12:49:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A54F260BA9;
        Mon, 24 Apr 2023 19:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 181BEC433EF;
        Mon, 24 Apr 2023 19:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682365742;
        bh=12kGOa1J6czg/R/bQBOnNQ6HgKMG+Kwix9Xg9YdqYlA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aMSWDH+HUL+dnCrmwGky/sCMhl0E4dc+czhv7wThivmwUZlCCT9Iivcpcy8h3l+uA
         9Iessn+Og9GEK/fb9RWqN37I+zagg5avDynDMCR2v0pAvHxTuZAhWTwYbRxfuxcqNZ
         cTkGk4GrNd2PWT79DB2TJab7V3b12fath57MQRLX6eTZVLfMTtTAk8V8BblUCxKsZ/
         PtdQyjnfTaGwXJrIbKm2pPhukCtXLWcq051EYK76n5u86Uxz8yty7fYpRCr246pShB
         D4lRSVGTLcjGCe5qn4uT2e3eQzx7q8+mCc/W5Jox8vQaiCvt/7Azp0tZucOCu/nVc6
         gWmEngmxKeKSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F07DFE5FFC7;
        Mon, 24 Apr 2023 19:49:01 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest update for Linux 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <323a124b-a06b-9b93-072a-b054a5515e28@linuxfoundation.org>
References: <323a124b-a06b-9b93-072a-b054a5515e28@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <323a124b-a06b-9b93-072a-b054a5515e28@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-6.4-rc1
X-PR-Tracked-Commit-Id: 50ad2fb7ec2b18186b8a4fa1c0e00f78b3de5119
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f50767d7e380618f81134a62e9a753dea2aecfb
Message-Id: <168236574198.6990.2086297874008547779.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Apr 2023 19:49:01 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        skhan@linuxfoundation.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Sun, 23 Apr 2023 10:32:02 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f50767d7e380618f81134a62e9a753dea2aecfb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
