Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1AC3BA494
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jul 2021 22:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhGBUQS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jul 2021 16:16:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231187AbhGBUQN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jul 2021 16:16:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0A2426141C;
        Fri,  2 Jul 2021 20:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625256821;
        bh=VopiB5rCK+T7qanTmP87Yf4lXIxo30oQC8iOgWB/LNw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QB6W3HsaVyRlJh1u+FIWdYEtRYdmosorKcpPLyZYvaQpnjzBszk5nHXOl2A75ik50
         wXUFHYGMYkZB+QCodrpMc6o5iuI/f+7SckdFzEamFtUHyCG1ikIRsfa8t5mnxjuCQ+
         JGwntMrgPPmwgDbZ6FfQGLIqFDB93gCBWCalaP3pRFflp8hZ8QZPS9izfMTNOWfwyG
         Kj8wZcE6/KEup5yqNNKA6UKABQlfQWQVJn9FBgNqbMKZ62fVqcpLPaIVCes1zlQ+tB
         7vLQYdzqYLmeFHMQ9TTETwtCADoRembvTzv3AaGgeYu1JmKDV6QnYzUJNHBSdo0WNS
         fOX71UyTA2BtA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 02620609E4;
        Fri,  2 Jul 2021 20:13:41 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit update for Linux 5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1ce88df5-31ca-7aba-d96d-92757b035d9a@linuxfoundation.org>
References: <1ce88df5-31ca-7aba-d96d-92757b035d9a@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1ce88df5-31ca-7aba-d96d-92757b035d9a@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.14-rc1
X-PR-Tracked-Commit-Id: 1d71307a6f94df3750f8f884545a769e227172fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a48ad6e7a35dc3f3b521249204daf4c9427628e5
Message-Id: <162525682100.6172.7302478241444343458.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Jul 2021 20:13:41 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Fri, 2 Jul 2021 10:09:18 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a48ad6e7a35dc3f3b521249204daf4c9427628e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
