Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8011C202642
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jun 2020 21:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgFTTzX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 Jun 2020 15:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728666AbgFTTzX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 Jun 2020 15:55:23 -0400
Subject: Re: [GIT PULL] Kselftest update for Linux 5.8-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592682923;
        bh=Gyi0m8AG9kJtsE/Yi1oOG4tLKcnblnj8pAS1EfJmFoE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=O5rZDXz65ufCmt8yxy5TUQHzWMgvqEph2QZFjKbVquBsjys8VxwH9nbaEpwFolqI9
         3sl6IAY8ZEQ9iC8Lz4Uy8qeZd+iJ1UoN72a0/kj8HJOBI5B1+XhvuOCb43nPCNZaTW
         pwQuQqk8gGz1lVnnrJuNFy2sxSfJT3NRmbo1W+3A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3d0e22cc-af15-c142-1ee9-6f3c18a10557@linuxfoundation.org>
References: <3d0e22cc-af15-c142-1ee9-6f3c18a10557@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3d0e22cc-af15-c142-1ee9-6f3c18a10557@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.8-rc2
X-PR-Tracked-Commit-Id: 1b8eec510ba641418573eacc98a7e9c07726af30
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27c2760561c0c68595b60a084c317b34e85e7c73
Message-Id: <159268292311.15446.8213048131415498108.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Jun 2020 19:55:23 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Fri, 19 Jun 2020 10:52:49 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27c2760561c0c68595b60a084c317b34e85e7c73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
