Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEF0F14D3B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2020 00:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgA2XfK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jan 2020 18:35:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbgA2XfK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jan 2020 18:35:10 -0500
Subject: Re: [GIT PULL] Kselftest kunit update for Linux 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580340909;
        bh=CRHoM1bttD5ePrzojwwnwIxVos1znwcMOdr2HLYJqvs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WsNsb4KsMf5XGWBAUWSlwuuD/DCQT0mRrMrUnc8v5ha8wZ4Ix5s32BFZ2y+aYIMLy
         HL5YyE8L5fHjbHIGz3cy4FtYWGbqdTwDZ8JD5yiVg9tZCWDUMAj5lmfafl5w1hl6Qn
         EDwauioEIJeo13vwNL3y/iuNLUTlo2ZNJFP9oww0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5d0a37f1-f857-eadf-5e20-872ca6c7f656@linuxfoundation.org>
References: <5d0a37f1-f857-eadf-5e20-872ca6c7f656@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <5d0a37f1-f857-eadf-5e20-872ca6c7f656@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.6-rc1-kunit
X-PR-Tracked-Commit-Id: 35c57fc3f8eac81b38664a0fe160e267b908d8b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 08a3ef8f6b0b1341c670caba35f782c9a452d488
Message-Id: <158034090976.30341.6706812193591598185.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jan 2020 23:35:09 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Mike Salvatore <mike.salvatore@canonical.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Wed, 29 Jan 2020 11:48:07 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.6-rc1-kunit

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/08a3ef8f6b0b1341c670caba35f782c9a452d488

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
