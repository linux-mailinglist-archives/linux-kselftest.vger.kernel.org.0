Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCD72DBC99
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Dec 2020 09:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgLPIXI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Dec 2020 03:23:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:40554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgLPIXI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Dec 2020 03:23:08 -0500
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608106948;
        bh=ud87NcTtL2ZtYGVa9CgBAwaeW4b8Rfgv2MrZObh+9bk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sqQezJFETYElHGh0VcBkvEVkAE/CdKahQ+kpXvn1jgZVprQeZlguwYC7GIHQr7CbC
         uZHBReSpMeuuWiGdimtxEbLbGD5wVtEt4Mr5f+0DouzMqBLbBjvFiyD6uYit4Nezp3
         wwIwBcdEgKb259We6V2wmrQeDp481sRCcmRphx2A+p4eXX1EL693iSA0LBo40LkwZO
         /P2rTSU0MCY1rtYI8sNSilwGu0CRiw/+GfC8WKuuh814VIpVrBYK8+x6YFJcB7rYha
         guaDEmLLR7+A+4dH3anUnAB/WC3FM5WSa9B9n8tzcuIR7r9HXdx4tEMrn983gW+L5/
         veB6bQcKMi2ew==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <bd9a480f-80f9-5beb-2f1f-dbc28a7af80c@linuxfoundation.org>
References: <bd9a480f-80f9-5beb-2f1f-dbc28a7af80c@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <bd9a480f-80f9-5beb-2f1f-dbc28a7af80c@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.11-rc1
X-PR-Tracked-Commit-Id: 88f4ede44c585b24674dd99841040b2a1a856a76
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b80affe33fdd56c8e9f1f0f33ad99f9016a59195
Message-Id: <160810694801.6147.17868708282743846908.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 08:22:28 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 11:59:10 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b80affe33fdd56c8e9f1f0f33ad99f9016a59195

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
