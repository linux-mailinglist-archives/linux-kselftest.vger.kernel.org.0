Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144C936D06B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Apr 2021 04:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbhD1CG3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Apr 2021 22:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235984AbhD1CG3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Apr 2021 22:06:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3F18D6140B;
        Wed, 28 Apr 2021 02:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619575545;
        bh=oQqedJog3wc5B2hhq+GKgVa3Ko5IeReoVr12d59OuDk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F89CPb1CASJJg8Xq4XWKk4StpaoGYeyXZMP6sQdqVppk3L8t2INHfyVuD8eBuB3zM
         cB+I8eJVAd7FRe5K+fNDvoVtJdRaoBIYQDK7ppOSjupi+qVJzsy4SpFrJ0C1tk82Hm
         p28VuOynxSV1hgjZxo8B6dit8f5AwtAP+cCvZPzfNJYPIXUyu/5YLVND2U4NRWxo1U
         oa4pClRu81SN8JgqdZT7j/Aq14x9tEjkl+zEkGavKCip7louTqhQwy4qmOsbk/5bQv
         62rL9GPFC44FCBAELnRDWFi8vEp5tpE5v5Sh0TpcU2hKo5RKkNlkLbqbNVtARH52xe
         +THWlY4SqVT9g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3792A60A23;
        Wed, 28 Apr 2021 02:05:45 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit update for Linux 5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2ea97361-c509-d40e-5caf-ee17a4b41a77@linuxfoundation.org>
References: <2ea97361-c509-d40e-5caf-ee17a4b41a77@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2ea97361-c509-d40e-5caf-ee17a4b41a77@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.13-rc1
X-PR-Tracked-Commit-Id: de2fcb3e62013738f22bbb42cbd757d9a242574e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e9599dfc47a171f7ba76a9651fe86baab364af5
Message-Id: <161957554522.21925.1151467727161372536.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Apr 2021 02:05:45 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Tue, 27 Apr 2021 18:03:42 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e9599dfc47a171f7ba76a9651fe86baab364af5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
