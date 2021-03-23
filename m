Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3FB346667
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Mar 2021 18:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhCWRbE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Mar 2021 13:31:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230131AbhCWRaz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Mar 2021 13:30:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6C0CD619C0;
        Tue, 23 Mar 2021 17:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616520655;
        bh=eycOx1BeoQ2pQuj+vJzPyU/XcAl7jazYmdRJ4rSnWPM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mQds0wrEhq96nMkgcmKeMxrZKdhZAGf79b40N+IltVrpctdL/52o50giBqicVzbcV
         KGJVYhl0QV9TRMYNVgIUd9TDpN5wY1xHJpCimzaeGQnJ4c3FhChZb9py7eMwRVBK0m
         4GT4MO9lK8qXc/QkwZGpP+s3WgotF+xmnfiLUNBqqOn8iBqecIoAOmARa1vkfx+mUW
         T+QjEJIRWBXEZpexwqcB7PZ+r2scxZbNa11My5PeTTDUeFye6DR+tEs3CK15NFoTZx
         BYqGdzLEOOtg2Wi0isW/ALSba7IJ73MBav2vlTTjzuKzU77g5y5ruARAlD8ismdPjW
         lWqz3Hq3EX+ZA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5D8C56096E;
        Tue, 23 Mar 2021 17:30:55 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit fixes update for Linux 5.12-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <13097e8e-2877-b63d-cd44-6393c1744a66@linuxfoundation.org>
References: <13097e8e-2877-b63d-cd44-6393c1744a66@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <13097e8e-2877-b63d-cd44-6393c1744a66@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.12-rc5.1
X-PR-Tracked-Commit-Id: 7fd53f41f771d250eb08db08650940f017e37c26
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7acac4b3196caee5e21fb5ea53f8bc124e6a16fc
Message-Id: <161652065532.15490.5141116870216131494.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Mar 2021 17:30:55 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Tue, 23 Mar 2021 11:10:16 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.12-rc5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7acac4b3196caee5e21fb5ea53f8bc124e6a16fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
