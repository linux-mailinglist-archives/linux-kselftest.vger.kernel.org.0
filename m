Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 720FA17C8B5
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Mar 2020 00:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgCFXKG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Mar 2020 18:10:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:57622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbgCFXKG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Mar 2020 18:10:06 -0500
Subject: Re: [GIT PULL] Kselftest kunit update for Linux 5.6-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583536206;
        bh=/AEl4qQrhkL8nHvwdti83yHGuhtWR3kMmRyHrDN782w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OlUc9uD8rr01sNal94B3P7LjsziIkh3bcvAPxF32saRvi1PAwT8ip0xjdmMbqKLOP
         E8HT3ZovvGALOjVcvju+vSNZ04gC5q8aXa47PJqX80hHKmQ2ObAlIk3nF0y8+hT1fh
         ggZ8+83H6mj3hBWsRmC2UJUpv4osfAQYANydgr9Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4d298617-f061-dda0-bde0-901c48247b4a@linuxfoundation.org>
References: <4d298617-f061-dda0-bde0-901c48247b4a@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4d298617-f061-dda0-bde0-901c48247b4a@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.6-rc5
X-PR-Tracked-Commit-Id: f3a60268f5cec7dae0e9713f5fc65aecc3734c09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63849c8f410717eb2e6662f3953ff674727303e7
Message-Id: <158353620603.27308.12883486501359895204.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Mar 2020 23:10:06 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Fri, 6 Mar 2020 15:57:27 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63849c8f410717eb2e6662f3953ff674727303e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
