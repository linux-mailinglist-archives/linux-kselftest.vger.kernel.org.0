Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1D63FF492
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Sep 2021 22:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245379AbhIBUGW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Sep 2021 16:06:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235049AbhIBUGV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Sep 2021 16:06:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 276B661054;
        Thu,  2 Sep 2021 20:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630613123;
        bh=RdL1odMNenwPL7RSxFhTQ9QSrch8Y9ej51FAiKjhs5Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RRbOpnSlj9fX6k/lwwHyQfOj926Z8hhFVxDh63cQJx1exi/3SwlJyuIR49Tn+O8rP
         v688tkWDX9qzOJC7nQUd0JDL8Eo4xlvHX7bsVqEXNECMEWZ6/3/rsKbKwEh7EzxGtY
         2aT4NQjh0Z0CQvnzM7Lbsb3Gyj7NXJhny9fsNBs1b951fcOxWjJwwDSporcEaIRd/m
         DutUpMSI+Z+LADjMKHeQTQDRjgYDLgmex8j0GICNqIau6EwTxt3y/84TRwncw7Al0O
         rYiQ4eexhkP1z2FtE3DHABag3lgAVpI/0AC3Zu2cQ7J9NIrzGjcU+9I8leNbzwEV3G
         BfTeQ8XAwqjjw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 217B660A0C;
        Thu,  2 Sep 2021 20:05:23 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit update for Linux 5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <78c09ebd-7377-00f7-2f2e-fbdf30309f18@linuxfoundation.org>
References: <78c09ebd-7377-00f7-2f2e-fbdf30309f18@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <78c09ebd-7377-00f7-2f2e-fbdf30309f18@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.15-rc1
X-PR-Tracked-Commit-Id: acd8e8407b8fcc3229d6d8558cac338bea801aed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c815f04ba94940fbc303a6ea9669e7da87f8e77d
Message-Id: <163061312313.10011.3778879444941453498.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Sep 2021 20:05:23 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Tue, 31 Aug 2021 16:19:18 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c815f04ba94940fbc303a6ea9669e7da87f8e77d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
