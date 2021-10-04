Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79BA421990
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Oct 2021 00:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhJDWFu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Oct 2021 18:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230517AbhJDWFu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Oct 2021 18:05:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8B02261248;
        Mon,  4 Oct 2021 22:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633385040;
        bh=ptPjZamrSRz75pgEjsbsvW8bq613ATjRZtw+WHXkg6s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=A4t+dqU6YbHzkyq82ovgnGv9BwpGyyRC7B88wqb9YIRg4857cQi7BVQo+aZsCbEgC
         JLwSHJiifVxruUt15RGPqmgc7vsXUieSzbhlrk4fYkn5DPsEOmIgBK3eQmmpOIcSin
         wAyDO+5VvCG//a1EUjOX2KZBzBSnPeAFlG0iT6PRyyIsDcfZnQnnkTjNaLFQdjQlJG
         2Y8M2WYxpAvV8TuGbis7i+45MSAltIEvhnIqk+0SncV2NTnpsG58oZCZdUUMZqG90p
         D5DX2q4Sswmolujzg2MTq5JuN5OoCCyVLaUWf1fBgUlJsCo9+lnSkdfCmFa3YKmzJI
         +AFsqGT7MY+SA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 785F9609D8;
        Mon,  4 Oct 2021 22:04:00 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 5.15-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6c737cda-28aa-0ac7-c07c-5115d0968bd9@linuxfoundation.org>
References: <6c737cda-28aa-0ac7-c07c-5115d0968bd9@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6c737cda-28aa-0ac7-c07c-5115d0968bd9@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.15-rc5
X-PR-Tracked-Commit-Id: 2f9602870886af74d97bac23ee6db5f5466d0a49
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6274b06e326d8471cdfb52595f989a90f5e888f
Message-Id: <163338504042.6107.2760751247423903309.pr-tracker-bot@kernel.org>
Date:   Mon, 04 Oct 2021 22:04:00 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Mon, 4 Oct 2021 15:15:09 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.15-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6274b06e326d8471cdfb52595f989a90f5e888f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
