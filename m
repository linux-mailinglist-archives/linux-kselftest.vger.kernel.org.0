Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28866321FF8
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Feb 2021 20:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbhBVTUO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Feb 2021 14:20:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:50608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233035AbhBVTQr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Feb 2021 14:16:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 420E964E4B;
        Mon, 22 Feb 2021 19:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614021127;
        bh=g0upDflBt5+bAoWqBvx1N6DXdS3ZNpE1r4oGb7SmNnI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n9B9irmBWof1EZneqBNVrm6RrZM4JkHn5AtEQYGqKed834+J2UVlDD60PeoWbdi38
         igGuYglgCmvdd7WIXYJXOtsKyO6fMGBz2JOrY6wXZCYk8g5d0NnLDorzRuTfUgXlgF
         Dt/ATCwC8KQ0USXdjiCvYfXXLTUAAsjUUa1xBRKWtnCnSk4l1hOJeTI3HLQ7Ueciqq
         brJU3Pyjm+U1Xyle2E5Na9BwoLjAAQYHXxhVxxmA+PE5EtVBafwIlOH3xw0N87q/PH
         ZHa/TwTFgnxZ3YYEDSxKGehkQxJqmmeWEFG8sdiZ6X4R2zsLXS//cQsQYnz9lrgRsH
         bouETWmf8vFDw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3DACE60963;
        Mon, 22 Feb 2021 19:12:07 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <448c2248-d217-c3fe-3b03-761fa4749b78@linuxfoundation.org>
References: <448c2248-d217-c3fe-3b03-761fa4749b78@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <448c2248-d217-c3fe-3b03-761fa4749b78@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.12-rc1
X-PR-Tracked-Commit-Id: e0c0840a46db9d50ba7391082d665d74f320c39f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80215095cefefa3bebf6e57971d0f1211e17153e
Message-Id: <161402112724.16114.11996725068293591149.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 19:12:07 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Wed, 17 Feb 2021 16:39:47 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80215095cefefa3bebf6e57971d0f1211e17153e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
