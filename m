Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AED52B855F
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Nov 2020 21:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgKRUNx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Nov 2020 15:13:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:46688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgKRUNw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Nov 2020 15:13:52 -0500
Subject: Re: [GIT PULL] Kunit fixes update for Linux 5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605730432;
        bh=VGBwAOj9dmxVzYx5SXFGZSMOYC0NFNyZiGS3lwZpKUM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eIdnMOV3EgLt5qgEdyIr3rtQqUlX+/fFIpN2FpxUmsktcPa0BkoWEF91f51Eq9vjE
         UxZfn0uXgdkukGfXjBvb0G+rPkwlJqxPTcYZKoCsUI1Cz0Xf3IVD4YyWvRjnt8+oCa
         +tXli+aTiehsyEOHmjRzAPu7Eq/r/X0fPOKSv4g8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0edb729f-b8bb-43ef-0d38-03d0f318cf2b@linuxfoundation.org>
References: <0edb729f-b8bb-43ef-0d38-03d0f318cf2b@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <0edb729f-b8bb-43ef-0d38-03d0f318cf2b@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.10-rc5
X-PR-Tracked-Commit-Id: 3084db0e0d5076cd48408274ab0911cd3ccdae88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f86fee1845eec29bed735e7120e6993ad8c4e295
Message-Id: <160573043243.16719.8325434404074128015.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Nov 2020 20:13:52 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Tue, 17 Nov 2020 15:59:23 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.10-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f86fee1845eec29bed735e7120e6993ad8c4e295

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
