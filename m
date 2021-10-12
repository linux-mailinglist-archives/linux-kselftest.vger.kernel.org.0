Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E847F429A72
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Oct 2021 02:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbhJLAco (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 20:32:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233977AbhJLAcm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 20:32:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9172160F38;
        Tue, 12 Oct 2021 00:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633998639;
        bh=o0XYx/TtTQRJDIzmhfYErBeC8HWB/1WDt0Mv5kvAkug=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Dl0+l9cDypAU4s1Ynsuk28k5MTI0IdYtc28MUwbflghBiGHR7AfhZJOueS77o+wZR
         UnRyJrOv7YZOHwglJItG77oPCYNHo5nOMC+di3e/SjDquRS0wVTVllMtiV7KcvIRYI
         r1cIYDPLNtBYdo+OrtYChifL77CKzcQq9uaygZkkYpFslA2bMiOc7+6OqzllzmzNqt
         jereGMcli+AE0KBiN/ruf4PUfGCYl3ibEVJcYdLPvnm9OfJyjnuZB4AzUowd8KzGLj
         O0dqMnKITMteFL61oyEzYuCJGgcb1Uv/NZa2H0eFJZ5t7sQmW/EeYXlq+xgQII9on8
         Lk9i3ihcevTpw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8AE70608FE;
        Tue, 12 Oct 2021 00:30:39 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit fixes update for Linux 5.15-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4972e6a4-54cd-ab86-757e-6078e9c66a30@linuxfoundation.org>
References: <4972e6a4-54cd-ab86-757e-6078e9c66a30@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4972e6a4-54cd-ab86-757e-6078e9c66a30@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.15-rc6
X-PR-Tracked-Commit-Id: 361b57df62de249dc0b2acbf48823662a5001bcd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa5878760579a9feaa1de3bb2396cd23beb439ca
Message-Id: <163399863956.7007.9522946157158893779.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Oct 2021 00:30:39 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Mon, 11 Oct 2021 17:07:54 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.15-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa5878760579a9feaa1de3bb2396cd23beb439ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
