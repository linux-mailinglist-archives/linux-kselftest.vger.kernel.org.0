Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A8036D06A
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Apr 2021 04:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbhD1CG3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Apr 2021 22:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235422AbhD1CG3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Apr 2021 22:06:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E2F2C61408;
        Wed, 28 Apr 2021 02:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619575544;
        bh=/jVsjF2cK235GrhnfA4npgZ/2bxzPacRVS/JKgDnHjo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dy3SJSsh48d19yybAVha4daDEQcyrV6ie3fe9E5e9sWsWkUBOcWA0jIiUz09NV/M7
         QCN7r3gGWL2ae7bdmZDSyr0j1j8aIHxLHDLaDK5cAb/mrWBfqcVFmUM7b8muLvm2PA
         1oJCt6XnIhmtcfKBtlvrfVa/P6BvQMR0ZJTc9dEHhPlzmY8rg7dbDqUPE4i/H/clMW
         fSzFSOiAtL92g15rloNkYMSQLS3iiffa3tnznoEtpNtnozBn0VaSCIEqZWcy4qnqsd
         0RPVIULimWYPLGsPOIvpzoOKyhC9tdMpFpT0ZyqNhhKt5m9Y+r2RqMhXZO58wRIdkW
         ufimyJYIHJfVA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DD8E560A24;
        Wed, 28 Apr 2021 02:05:44 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <aea4049e-6de5-f27d-c23e-ca098d78f79f@linuxfoundation.org>
References: <aea4049e-6de5-f27d-c23e-ca098d78f79f@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aea4049e-6de5-f27d-c23e-ca098d78f79f@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.13-rc1
X-PR-Tracked-Commit-Id: e75074781f1735c1976bc551e29ccf2ba9a4b17f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a68c268a18317a013961e8faf6eaabc81a94e6b
Message-Id: <161957554490.21925.14940488069071577353.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Apr 2021 02:05:44 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Tue, 27 Apr 2021 17:13:02 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a68c268a18317a013961e8faf6eaabc81a94e6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
