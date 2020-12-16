Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75972DBC9D
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Dec 2020 09:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgLPIXY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Dec 2020 03:23:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:40596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgLPIXX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Dec 2020 03:23:23 -0500
Subject: Re: [GIT PULL] Kselftest update for Linux 5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608106948;
        bh=Yj6g/Ny5EtD0geFpnmDc9pgrgcBa76vLLAjhFiORkD4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JlBEUeoo9OOiMDe2CO2qSCcZ2xV4d7TGlrp1ko5hPubvJsZmKpbxyY2OEGukocjqY
         kBiNYujjDYWOPXVv4Ub8d2jM9pAY45FL1xoFuOm4723KKthO8s0PYnX6cHE3VzWTMv
         2Zu9U9TFxLZ3bNXOCP8U6Uo0OhDq73hzYrLWgnDuoZxBNSg1JkyJ3pXVbA2Hk5se4o
         U99bekYoxQ2KFC8w6sohzJ657o9ZDZwHJm1W6k3Ansvz2PTsD+UAmn7tR5DdBKBG/Z
         U8RWe+0kAvrMhCN3KPpjzxuqmapRA2QAQ1lq1hjoRMXiTs9IC8rs/wsOoch0AOU7bm
         67619lsWEHsyA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <60d232d5-30d8-3878-b525-491c4640d02c@linuxfoundation.org>
References: <60d232d5-30d8-3878-b525-491c4640d02c@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <60d232d5-30d8-3878-b525-491c4640d02c@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.11-rc1
X-PR-Tracked-Commit-Id: c2e46f6b3e3551558d44c4dc518b9667cb0d5f8b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7194850efa47c8dac6e805087dd23c7b03af019d
Message-Id: <160810694835.6147.16425384459693347516.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 08:22:28 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 13:35:31 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7194850efa47c8dac6e805087dd23c7b03af019d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
