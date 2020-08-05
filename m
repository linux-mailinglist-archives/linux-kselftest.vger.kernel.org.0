Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E688323CFA0
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Aug 2020 21:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgHETXU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Aug 2020 15:23:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728732AbgHERdN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Aug 2020 13:33:13 -0400
Subject: Re: [GIT PULL] Kunit update for Linux 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596648793;
        bh=6FllN6phriNHqB/X+N9JSLf4qqJXCNgt3r42QZGk7uQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ojeo4NeUaf9uVgwzGXi8EwuR6CtZA0G4T1JZMFWdQpfhptIbfRfahXsmkZn0ByQln
         +LIAsk3RvVjXjj9hUnGiefUbAdTyMJs5mTqStlG/hfbc57YmWgVEDLOCz4CNSTKyPH
         Jny0qE5pDTFvCH1AzdNsvZFy+wxkwxBmmhz92t5A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8d43e88e-1356-cd63-9152-209b81b16746@linuxfoundation.org>
References: <8d43e88e-1356-cd63-9152-209b81b16746@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8d43e88e-1356-cd63-9152-209b81b16746@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.9-rc1
X-PR-Tracked-Commit-Id: d43c7fb05765152d4d4a39a8ef957c4ea14d8847
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 53e5504bdbdb16548e39a4834c97742693964197
Message-Id: <159664879356.18421.5932211195517412489.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Aug 2020 17:33:13 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        skhan@linuxfoundation.org,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Tue, 4 Aug 2020 14:59:29 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/53e5504bdbdb16548e39a4834c97742693964197

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
