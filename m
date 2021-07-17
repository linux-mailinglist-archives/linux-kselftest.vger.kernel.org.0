Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F1B3CC5F4
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jul 2021 21:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhGQT4d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 17 Jul 2021 15:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235133AbhGQT4c (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Jul 2021 15:56:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E966960FDB;
        Sat, 17 Jul 2021 19:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626551616;
        bh=AgBnn9OYYkTHpOM4uyS/maxhHtXhguSJBbj0XznMWOM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Tggic2QjSGflMlKNAr91jsf/9GJE+46edjb9hZYFumG07aISWZc1C3KAcpsrbcBWa
         1OmqqqTYmCCFN8UlGTqaIkLpt53lBVYHBhIU14q+v1nMP5DcPbj16Ku5yDMyrsPl7z
         RFQjXfrzfOnWECq6HfhwwjHZpeDAJmG/5vgQKekY+lpI+bgEyKfwVMmBraHNJMYILq
         JuKDo4PEIzS3Mj/OTIj9x5I4EpXp2fpUKGKbJxkFdNv3ZKTyTK8on1YHzeuVpSoP48
         g4TkEjwpYATHEpTk8MNaiPSuiaX/uoaADXClLbOjUpcDxwSTeJLES0RhMjYc13Q5BF
         AWOgd+xVhWMDw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DCD9160A0B;
        Sat, 17 Jul 2021 19:53:35 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit update for Linux 5.14-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9d9ebe39-8860-4d1a-2489-e6a1a1f0cbbb@linuxfoundation.org>
References: <9d9ebe39-8860-4d1a-2489-e6a1a1f0cbbb@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9d9ebe39-8860-4d1a-2489-e6a1a1f0cbbb@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.14-rc2
X-PR-Tracked-Commit-Id: df4b0807ca1a62822342d404b863eff933d15762
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ccbb22b9ab86a050584804b84007e0365242b034
Message-Id: <162655161589.18489.1139723975789923044.pr-tracker-bot@kernel.org>
Date:   Sat, 17 Jul 2021 19:53:35 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Fri, 16 Jul 2021 17:03:07 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.14-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ccbb22b9ab86a050584804b84007e0365242b034

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
