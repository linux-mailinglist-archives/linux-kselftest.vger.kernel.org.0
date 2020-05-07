Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8A51C9ED6
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 May 2020 01:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgEGXAG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 May 2020 19:00:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgEGXAF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 May 2020 19:00:05 -0400
Subject: Re: [GIT PULL] Kselftest update for Linux 5.7-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588892404;
        bh=e1Pue7LzbDO9XPzNxivk6GPgnsB6JCC0JqS1+Y5F2ZY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LEnetE5xKRd8T0aJuAp/jzmjROWEbRIx8fGaMy2J+jJV4zBO+3d5RiD2C+P6WY2ri
         IRBPITpJbGgnQl3CkuDP7tVxUv6m2Qv31yGS6Z++8Lcf53SC6UsYO2mngYJwRPEAA5
         S0qMCSwQR/kCwOc819O2pQYHLirmYtXFtZKcbF9Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <357f0c72-ecb3-021e-4f5a-7ddc649688f2@linuxfoundation.org>
References: <357f0c72-ecb3-021e-4f5a-7ddc649688f2@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <357f0c72-ecb3-021e-4f5a-7ddc649688f2@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.7-rc5
X-PR-Tracked-Commit-Id: 66d69e081b526b6a6031f0d3ca8ddff71e5707a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ecc4d775f61fb3fd26a1b8cc70a56a98b3b40d3
Message-Id: <158889240492.3631.5791202315097987288.pr-tracker-bot@kernel.org>
Date:   Thu, 07 May 2020 23:00:04 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Thu, 7 May 2020 12:23:39 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.7-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ecc4d775f61fb3fd26a1b8cc70a56a98b3b40d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
