Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB1D443CC8
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Nov 2021 06:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhKCFl1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Nov 2021 01:41:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230326AbhKCFlX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Nov 2021 01:41:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 55E5161108;
        Wed,  3 Nov 2021 05:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635917927;
        bh=YEe8g2H9+10wRJ6hkPSXljQ2IW5sFrabAYmc/8V4RtQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Bvb6BmatXzGPxaT7d9UUoESZHYvm9Bu3HGZf3f2OtVhytWVfdeV0pxbxA2txst7nJ
         i5uEhIpsbUF/kD6eeelwFU74eO8wJagoIVBWfLNd6qvfBU8uHUT6178uh5x6WJlX3k
         iO6dZE24WDrXDQ6BGIt9std4zYdBkZq+YHsx7qkI6w9AjhBCL3X2yuh3usRaHCPq38
         a4qE43zsQBKSfOn02DawxbpaSCl+pfCXOO3Oax+NeSENqcyvsHMsgg1AhWbl7aDI/s
         DYU86iIZew25vHH09tiiiP/dw5NRGHat2b73upwxOKsqMc8MYugrCz6Vs9voDQolUA
         wH8PLsgsKdC2A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4D9FC60173;
        Wed,  3 Nov 2021 05:38:47 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest next update for Linux 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5ee0a2b3-d5c1-5664-cb02-c24a7f4cdeaa@linuxfoundation.org>
References: <5ee0a2b3-d5c1-5664-cb02-c24a7f4cdeaa@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <5ee0a2b3-d5c1-5664-cb02-c24a7f4cdeaa@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.16-rc1
X-PR-Tracked-Commit-Id: f35dcaa0a8a29188ed61083d153df1454cf89d08
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84924e2e620f4395466d772767313fff0de1dad7
Message-Id: <163591792731.8140.6941329903411486649.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Nov 2021 05:38:47 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Tue, 2 Nov 2021 11:56:07 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84924e2e620f4395466d772767313fff0de1dad7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
