Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 919497B46C
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2019 22:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbfG3Ukb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Jul 2019 16:40:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387404AbfG3UkV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Jul 2019 16:40:21 -0400
Subject: Re: [GIT PULL] Kselftest update for Linux 5.3-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564519220;
        bh=HSlx0d/cPvgoJG3la7Dojvd4y52cxHYRfIqdF7GDmqE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=k61qCgxYzWfHkQMVciipzygFz1bIoCF9Rqux7NLkt+I9JYEQ+eQ9TwvNm0tppJcUL
         8b8dPhHxyj3l3X/MRW2AzM/UoGOY1spIulXlkJ63CGZLmIhSSkkU9eCU+vT8OcW/9o
         legK71ZfAgc4mqKtVE0D/evZ4IYxxNltxnk0PCmw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9b7fa63d-7c3f-bb3a-663b-e5279a0a0086@linuxfoundation.org>
References: <9b7fa63d-7c3f-bb3a-663b-e5279a0a0086@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9b7fa63d-7c3f-bb3a-663b-e5279a0a0086@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.3-rc3
X-PR-Tracked-Commit-Id: 527d37e9e575bc0e9024de9b499385e7bb31f1ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f6f0a996218cdd9d275aac41828f54367e6fa28
Message-Id: <156451922037.18459.15117834535691114931.pr-tracker-bot@kernel.org>
Date:   Tue, 30 Jul 2019 20:40:20 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        joe.lawrence@redhat.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Tue, 30 Jul 2019 10:33:47 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f6f0a996218cdd9d275aac41828f54367e6fa28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
