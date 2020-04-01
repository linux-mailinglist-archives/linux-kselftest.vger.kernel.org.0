Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64D8719B8E1
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Apr 2020 01:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387514AbgDAXUQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Apr 2020 19:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387443AbgDAXUP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Apr 2020 19:20:15 -0400
Subject: Re: [GIT PULL] Kselftest update for Linux 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585783215;
        bh=7tNhRCZfYIn2yNu4FIznmAyGvHlVuSygoY2293d/oo8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HCdlwL1G0pIXDuby7iAD8s9BwEVs2gbuuL78T/0WYrakL1uPEtfwXteRli03tCGmH
         2hYSjt5cYGOB8XKactbgnYVS/ArAPe3RbUizkBV8opPww79a6wUCl1yMTKWwFEp9FL
         gGPB9a3X2ExZdkyzIi61ecBkgug5ySNsQKQvdKmI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <fd5d86b2-34d2-54a8-9c44-7f22266202cf@linuxfoundation.org>
References: <fd5d86b2-34d2-54a8-9c44-7f22266202cf@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <fd5d86b2-34d2-54a8-9c44-7f22266202cf@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.7-rc1
X-PR-Tracked-Commit-Id: 1056d3d2c97e47397d0037cbbdf24235ae8f88cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 397a97946798890b9bdaa6122fcfad7147690670
Message-Id: <158578321524.12544.9703235378833574287.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Apr 2020 23:20:15 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     torvalds@linux-foundation.org, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Wed, 1 Apr 2020 10:44:57 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/397a97946798890b9bdaa6122fcfad7147690670

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
