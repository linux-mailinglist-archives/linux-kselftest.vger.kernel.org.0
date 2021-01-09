Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421BB2EFCA7
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Jan 2021 02:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbhAIBVm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jan 2021 20:21:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbhAIBVm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jan 2021 20:21:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id AE20523A74;
        Sat,  9 Jan 2021 01:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610155261;
        bh=Fl04ikQm+OPcluJ49Z0NFqO4b7GiyEZW6dzIuN+SVJ4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rIBvPbEAT/ZJxFMnV7Lykuy82AQl6hOxF7HkNp000PRRgZ7EGlsCkWd/nnVcQLYcM
         Sc/nc2S/EYoxWz05v0z4OpVO8O/FmTX3G22v8xn/wc/Kwe0cfTbGarOPpOyvMlJmb0
         krsRcoC5aThVI1XegAdW6JnmR0cxNZxDLszgQxvZb8ox3aXmylQAQuLnzCVVfPe5uG
         37KfVmrMQCyDCkb8FDYXRYMALybdsfzIolAdvbWrGQc6PLrzl9r4aqtOn2J9NFaorW
         iDtmZYA+mlH79Ym3t3NgIuGh6veZt1KdPaGKDnFbAtrCj4KyDA3hstsSy7k+GQ7npF
         fq3j+hhedss7A==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 9C79A60157;
        Sat,  9 Jan 2021 01:21:01 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes for Linux 5.11-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2f3c419c-89ea-8a53-c2a4-ef8fa6312f23@linuxfoundation.org>
References: <2f3c419c-89ea-8a53-c2a4-ef8fa6312f23@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <2f3c419c-89ea-8a53-c2a4-ef8fa6312f23@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.11-rc3
X-PR-Tracked-Commit-Id: df00d02989024d193a6efd1a85513a5658c6a10f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f3d8491d03594823a7f7d71d5063e1bcd03c75c
Message-Id: <161015526157.8938.5510946217227398814.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Jan 2021 01:21:01 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Fri, 8 Jan 2021 11:14:39 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.11-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f3d8491d03594823a7f7d71d5063e1bcd03c75c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
