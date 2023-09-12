Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA5579D5F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 18:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbjILQON (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 12:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbjILQOM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 12:14:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C5010E5;
        Tue, 12 Sep 2023 09:14:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BF94C433C9;
        Tue, 12 Sep 2023 16:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694535248;
        bh=4iVZQlyyLI8D6ifT58jydY93uN6NvcxJoFr6tBOHMUQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MDq5cICM9G0gx33ACWqe6/8uebYVO2Xo4K/dWChXbUN5SxRBvv8QWl60Xaj6T0A5O
         kdARR5vfqENfVD5INwanFHFmMOjvmx+Bpptk3fWJkXLDjm7TGWMmgWe3gmIamyEMbL
         x16hxQku6PBR1O2LH7bDR5h087mxU1HjdnSRLLqIt8cxeMCgqMBDW9amnNq5+EmDsW
         iPYkpAqe664iqQhpV9v+/pkElY1SH2o7zKrtpozu0psLMIw9KVRkMiy26+d3RlY9WH
         0m/d4A3SSGPH509Sn4ywH1X/0nHLfu6WoKKpsqksSSJNvi2m29GD8Lz4JtT23cfc+M
         0wMRuJRIWwHfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3449EC04DD9;
        Tue, 12 Sep 2023 16:14:08 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 6.6-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d08e3af8-b48d-ee6f-9e9c-b9a0129de405@linuxfoundation.org>
References: <d08e3af8-b48d-ee6f-9e9c-b9a0129de405@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d08e3af8-b48d-ee6f-9e9c-b9a0129de405@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-6.6-rc2
X-PR-Tracked-Commit-Id: 3f3f384139ed147c71e1d770accf610133d5309b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a747acc0b752f6c3911be539a2d3ca42b4424844
Message-Id: <169453524821.14950.4762831079454195251.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Sep 2023 16:14:08 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Mon, 11 Sep 2023 11:24:02 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-6.6-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a747acc0b752f6c3911be539a2d3ca42b4424844

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
