Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2678F2DBCA0
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Dec 2020 09:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgLPIXY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Dec 2020 03:23:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:40598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgLPIXX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Dec 2020 03:23:23 -0500
Subject: Re: [GIT PULL] KUnit update for Linux 5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608106948;
        bh=MAxkcc2T4pvNHNFzM9yul6oUiKb4Mks1V0T+fqMaXmc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kDdQ3bzSuJE/ZHLq4PtBMhvyGYkMGsgajLYflaE/Jc0Ujgi9jvUca52VTjbqNV24a
         tWY/S1+f7EOhUHtxZICpHoWNlugZDNGuHT2mfT2NTA3Jt2P9y1mBlBlLDaTSDmhQ8w
         mbet+FMU6TkFsrCWFjELzT+1f65kezJMEFeY1JPIrU4cb0tcDSP9JXq4FcxlGCDJBE
         fZhgyLaur+C2MFdV9eaWV8KaFukk3nAI/tSJ+zflfKwWN6QUpFhneM+bChPoHHxnj0
         OR8Po+qmnQlZaC+Jk73e88diPsCKuxMFraSziJtmasom1ouQr/uEWq4lHWVxk1e9jE
         d5RAhijTfyCqA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e68b976c-0966-b26e-bb53-d80111eab8bd@linuxfoundation.org>
References: <e68b976c-0966-b26e-bb53-d80111eab8bd@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <e68b976c-0966-b26e-bb53-d80111eab8bd@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.11-rc1
X-PR-Tracked-Commit-Id: 5f6b99d0287de2c2d0b5e7abcb0092d553ad804a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 706451d47b3716c24e0553dfdefba11d202effc1
Message-Id: <160810694864.6147.6246308365891660205.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 08:22:28 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 14:52:11 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/706451d47b3716c24e0553dfdefba11d202effc1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
