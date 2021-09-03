Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A0040081E
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Sep 2021 01:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350523AbhICXNu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Sep 2021 19:13:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350493AbhICXNt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Sep 2021 19:13:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5B8656108E;
        Fri,  3 Sep 2021 23:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630710769;
        bh=p6G1vkLrv2YaM8jldj5azhr+cqm9a1fWmWV0HXgENnY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=V56VxafSmwC1bXHsBfW7/R7ruSCtPDmuVuTOGhPmqX8R8ktUE3WGdTaRSxoWfC8Xo
         oqiAIytu3awvZYrroA+czynUQFCiNl6gESjpyH46kTs2LwPZifN8JehWVt/bGbVb+7
         Yi0tAJieH26BAwixYU3OjhFUVJNWQsZsF3ydYY1830yPsZLm/NaKOjUQZqgsZndtfw
         2t3qn66TsPTdrOemL4No+JtmNP36r7xyimNLVfsYT7ID83VWBvACuTg/ygSOLaibeB
         N7u5KsGpWx7N4v2a+8x6Rry14cEwKyiMTvNREVJzBcKH6LBjcxhrziZETE7q6JhV//
         gSJHCuJovSZSg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5610960A2F;
        Fri,  3 Sep 2021 23:12:49 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <81223355-a515-b5c7-ed54-bb65482aec9f@linuxfoundation.org>
References: <81223355-a515-b5c7-ed54-bb65482aec9f@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <81223355-a515-b5c7-ed54-bb65482aec9f@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.15-rc1
X-PR-Tracked-Commit-Id: 67d6d80d90fb27b3cc7659f464fa3b87fd67bc14
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1583cb1be35c23df60b1c39e3e7e6704d749d0b
Message-Id: <163071076934.25061.14982335061011900842.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Sep 2021 23:12:49 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Fri, 3 Sep 2021 13:51:08 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1583cb1be35c23df60b1c39e3e7e6704d749d0b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
