Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336963EBF43
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Aug 2021 03:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbhHNBMz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Aug 2021 21:12:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236038AbhHNBMz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Aug 2021 21:12:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 32E8A6109D;
        Sat, 14 Aug 2021 01:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628903548;
        bh=jCtPAJRypDQBzXlmJwDbG2/A5Fb/1o9M5CDasKbqzEc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=p+MAKuY61nj5Jx4XA4ktaBoNKAn2iWsEGnrNBct5kVRW9AeOij6vP+fJulzd/cPdN
         2sb8/CDZqeCB0n8XUHyjGRre7gsPZSIoaPQfChgB+nztPU3L8x+BTNd2MXOEzESjEe
         WZZDxd0+/aTLv+vx6eOmxDss4K/6HUMVfRhA8t2t+ksrTxI3sUO6RfhXMcznKb0wN4
         DCW50stYV+HJ5l4Fxmtj6KSdA721r5Ae8kysFBdIoQtT6GcoM4m6XwTU4qJt0i8LCx
         LRK2XIZAwQ4WGU0X+71lSI71AvHmzKPgVDREZbJcB1v3qqQd44UwYXZJI0v/9idLXX
         AvPvwq7jTxgkQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2CC26609AF;
        Sat, 14 Aug 2021 01:12:28 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.14-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f27686fd-6fb5-a906-b2d0-1e07cdf83594@linuxfoundation.org>
References: <f27686fd-6fb5-a906-b2d0-1e07cdf83594@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <f27686fd-6fb5-a906-b2d0-1e07cdf83594@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.14-rc6
X-PR-Tracked-Commit-Id: 567c39047dbee341244fe3bf79fea24ee0897ff9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a83ed2257774071e2d821ec361954782a7c01f8f
Message-Id: <162890354817.25277.15076177438444208700.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Aug 2021 01:12:28 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Fri, 13 Aug 2021 14:28:50 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.14-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a83ed2257774071e2d821ec361954782a7c01f8f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
