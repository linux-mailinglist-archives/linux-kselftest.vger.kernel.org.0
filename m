Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC8441851D
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Sep 2021 01:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhIYXH2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Sep 2021 19:07:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230078AbhIYXH1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Sep 2021 19:07:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 581CA60F11;
        Sat, 25 Sep 2021 23:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632611152;
        bh=94G+dgxkTN8VYNOdcEgfUaAAK9rai2YwwNQVMJVC4Xk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=INLPHmprrM0E067eeQbYS1k+8ghhqE03Trxuov7V5Fls74L0oFCPmJ5zsNVJ7+Umj
         PutK6iGMM/dfSvkOvJ/AePjTvVTD31lbr4ZYR2dSM3FrbU5WXuDJO8fSiaHItgWeLa
         VWK00OdYHRMTCUfpMHUENpoENRE7B/jetRa6bHcmmDLMfU+MVjJS2ul8flOX0l2UmU
         lHgEXd9/yEwvxO4ZryW96/5suLQGQPVcmooFwrWwefd/09BYTMImMAD2WLhsUtN3xb
         A5rxPi38CJhWPH2HBy3Pp3NRhOx0X9KQ3iST886jldkdgN9r8emm23QAflAFwxB36v
         /wIlR7S+NLMrw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 433F960976;
        Sat, 25 Sep 2021 23:05:52 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 5.15-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <61a77c13-1963-1dd5-d9bb-806cc8435326@linuxfoundation.org>
References: <61a77c13-1963-1dd5-d9bb-806cc8435326@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <61a77c13-1963-1dd5-d9bb-806cc8435326@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.15-rc3
X-PR-Tracked-Commit-Id: f5013d412a43662b63f3d5f3a804d63213acd471
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90316e6ea0f0d63dab4cc84f71a8e199ee4b9b6c
Message-Id: <163261115221.2532.8047374408133344042.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Sep 2021 23:05:52 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Fri, 24 Sep 2021 14:22:59 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.15-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90316e6ea0f0d63dab4cc84f71a8e199ee4b9b6c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
