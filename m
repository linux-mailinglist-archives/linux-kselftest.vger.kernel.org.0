Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403292F6D98
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jan 2021 22:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbhANV5k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jan 2021 16:57:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:52260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730574AbhANV5k (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jan 2021 16:57:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A2D1A221FE;
        Thu, 14 Jan 2021 21:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610661421;
        bh=Sgo2hVgJxVHB3Mq2ELkZbnq9XqbXPqamKoDEtQ2VTuo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pwlTzSGirpQEoLotOCxJAF72abXIy+Vye5K/vfj0lz1j8e1qi3QWYYU3wDzHlOn4r
         JstEJKcpcLabjDEbNUjTNsBPhTN0QMAAlZjTlj5YQQQqBxsLaRTY5RcLtYjKAZIoar
         hEx7wok0PZap989HADw4VRa0x6ViYXaIW+Cb+nqx6lME4+gf4Jq96E9yjDxippSybl
         gMbTozVDy4nFimo+gJY9YQycB512Bf0pQgvxhHhtjYrUMViS/Y0yGulQWAFewi9up/
         yzQHO7xG2/JpZoipfy3sA9dHASiYioVj4Nt54ub7T/szRBpxUYTPXXUt1dVr6gXy67
         6wZKIPCUWa3ow==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 98B7360156;
        Thu, 14 Jan 2021 21:57:01 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes for Linux 5.11-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e60bdae0-2df1-9401-a8e0-3949884a7db0@linuxfoundation.org>
References: <e60bdae0-2df1-9401-a8e0-3949884a7db0@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e60bdae0-2df1-9401-a8e0-3949884a7db0@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.11-rc4
X-PR-Tracked-Commit-Id: 7a6eb7c34a78498742b5f82543b7a68c1c443329
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 146620506274bd24d52fb1c589110a30eed8240b
Message-Id: <161066142161.29276.112396109387657003.pr-tracker-bot@kernel.org>
Date:   Thu, 14 Jan 2021 21:57:01 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Thu, 14 Jan 2021 13:52:41 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.11-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/146620506274bd24d52fb1c589110a30eed8240b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
