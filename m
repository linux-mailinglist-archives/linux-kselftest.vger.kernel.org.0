Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61A93BA493
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jul 2021 22:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhGBUQO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jul 2021 16:16:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230116AbhGBUQO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jul 2021 16:16:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6CCD361411;
        Fri,  2 Jul 2021 20:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625256821;
        bh=XL9X1e8EwMMbHJIDKpf8Sr9cnB8yO1NXl9uBqok0bfg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oP6RaKo00TO9K1T1VSLb01VfWpGlcCw7K04EIZBAKIbZ9Dq3A8mK534pRbmC90eze
         VVSfsvNR3SASCwN7EdTC+t8kuQDBb4wmf+eHszpIzI8CjU6tvd6/RRmC6LYl8byM3f
         YzIyT6aDZM7yeCIr8HG3EJ1GcUxuLay7oa4Br8nlclBUlHmDXoydJww7ySrDCytBon
         C/sdhcgdYu42o5wEOJ+PfMpF3s1SwdlfSL+Jrq3ZUvQBafRsNfD1ZQC10uYL157bKe
         TwvvkHBaWYombit4AISHCAV8jgs/Fuq1sbblSet4NgubqBg24ocHijxnZEcJApIIsP
         Zt40QJCC2imLw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6792460283;
        Fri,  2 Jul 2021 20:13:41 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <933f7ca8-71ae-6af3-64bb-b43795a98290@linuxfoundation.org>
References: <933f7ca8-71ae-6af3-64bb-b43795a98290@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <933f7ca8-71ae-6af3-64bb-b43795a98290@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.14-rc1
X-PR-Tracked-Commit-Id: 4896df9d53ae5521f3ce83751e828ad70bc65c80
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35e43538af8fd2cb39d58caca1134a87db173f75
Message-Id: <162525682141.6172.662590435660832075.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Jul 2021 20:13:41 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Fri, 2 Jul 2021 11:44:55 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35e43538af8fd2cb39d58caca1134a87db173f75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
