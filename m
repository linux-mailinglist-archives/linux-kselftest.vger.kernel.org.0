Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D582A3CC5F3
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jul 2021 21:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbhGQT4d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 17 Jul 2021 15:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234296AbhGQT4c (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Jul 2021 15:56:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DA9CB6115B;
        Sat, 17 Jul 2021 19:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626551615;
        bh=0getJaUh+DluUzLQ1dE6gcIChSlw9UutOhBGuNelQKw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=A0XcwSFumc/dDZ3Up0FeFBnWCTqIW8Du2GOHNMZjoYBflzTIskh42zhRvBF/htiT4
         xxC9VFS91g9R09DCdpdZmpE9Vzju0riKuJfd3qfSu2w0yWKklxUAI983wZr+1uGuwj
         cdxDI/CKeqm01Sio05aPdVIEArwDi2ijDk92dgFFZn5848417IuaEcxbgKd9dPWVNW
         N10GskPTAhEUko6KkEq4yKrQCK8x8eYkkMcXFd0HvF6rQiJ/xqc83WsYVE2kb71/wg
         LLfMmiCtZPugLEpOVebXbgy8M+mj9Laz57IozMHVfgkODLtuAD4bzxX3UeFOnEDhmo
         64oBnrZ9bYC7A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CDA8760A4E;
        Sat, 17 Jul 2021 19:53:35 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.14-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ae8c3cdd-8bc6-fd64-ce73-9a27a60a8820@linuxfoundation.org>
References: <ae8c3cdd-8bc6-fd64-ce73-9a27a60a8820@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ae8c3cdd-8bc6-fd64-ce73-9a27a60a8820@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.14-rc2
X-PR-Tracked-Commit-Id: 0c0f6299ba71faf610e311605e09e96331c45f28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00397e74e37a1285baee8678085297a330a6e2ce
Message-Id: <162655161583.18489.3863236889559715041.pr-tracker-bot@kernel.org>
Date:   Sat, 17 Jul 2021 19:53:35 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Fri, 16 Jul 2021 16:24:37 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.14-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00397e74e37a1285baee8678085297a330a6e2ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
