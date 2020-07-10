Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC1E21BF8B
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jul 2020 00:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgGJWKE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jul 2020 18:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbgGJWKE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jul 2020 18:10:04 -0400
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 5.8-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594419003;
        bh=DXUdo8CRGnVX/RDYtjZ/JAgmkzNGabAQlQmalQpqyNk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zZ3nm5aaezj567WZkMx5SQOOXIiXemRkTy0Eb/KwR6wlUsJTQ26wjmZaKJgyss3tR
         Ze7/aIg8z2r9Eb51mM+VRS1q69Agqc03sSq76p2FsqnczKQIIJTBzaPd5SlDwIqkwS
         htAyL05zBkBq39ObbIxdAWptj3kNOMg2BHS3jZLg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f4297017-1d27-741d-3abc-36b6918801f6@linuxfoundation.org>
References: <f4297017-1d27-741d-3abc-36b6918801f6@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f4297017-1d27-741d-3abc-36b6918801f6@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-fixes-5.8-rc5
X-PR-Tracked-Commit-Id: 3c01655ac82eb6d1cc2cfe9507031f1b5e0a6df1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f318cba1e08a2e18494eec847f6caf94f13129b
Message-Id: <159441900372.20268.2729613587724365084.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jul 2020 22:10:03 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Fri, 10 Jul 2020 10:39:36 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f318cba1e08a2e18494eec847f6caf94f13129b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
