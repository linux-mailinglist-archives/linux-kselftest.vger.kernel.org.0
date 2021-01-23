Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B8830183C
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Jan 2021 21:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbhAWUKO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 23 Jan 2021 15:10:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:44358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbhAWUGV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 23 Jan 2021 15:06:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 5B69722D50;
        Sat, 23 Jan 2021 20:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611432341;
        bh=3ZTywdWdqrGsz5Rn8KHjIVQ7QhRug7vMT37OCc3/rw8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tjQxDrts9pWIqpF77NOHrfWh55dbxoUXWhfHU5Cn5EnEMchoK85BvCvKqBKoCUwjk
         I/m7pdyIEmU1Z95pwvF7tINlqlQWPecdyB9uLJIkRWrNtzbNbEgkHdc7J1UHKIJsJz
         gbTbZYDu6CWjL5DKlb8Dc6rMc2HecjT3AN7D7SC7zapsbD1WfaidK7vL94b72eKjiO
         +qKhb1e1Nr87Xf8SAYWPmZ8bAZ67UXWoiLCFnP0GDEKxn++eev80mDsoJA7UF+dZlF
         sFk62dawnrO2l3xzmX9oEtwlbjbLBrdiunQ4RmqHqeJ1imQEqfZX9RSo3ZLkML+rmi
         tVi/9XLR075pA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 452E2652E4;
        Sat, 23 Jan 2021 20:05:41 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit update for Linux 5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <137b3eea-4bfe-9026-e647-1861bc62ccf9@linuxfoundation.org>
References: <137b3eea-4bfe-9026-e647-1861bc62ccf9@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <137b3eea-4bfe-9026-e647-1861bc62ccf9@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.11-rc5
X-PR-Tracked-Commit-Id: 2b8fdbbf1c616300312f71fe5b21fe8f03129950
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 929b979611f5d2a264a2c1b9fe84baa975828522
Message-Id: <161143234119.8668.3268381626699589378.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Jan 2021 20:05:41 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Fri, 22 Jan 2021 17:43:04 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.11-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/929b979611f5d2a264a2c1b9fe84baa975828522

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
