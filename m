Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913792EFCAA
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Jan 2021 02:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbhAIBVm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jan 2021 20:21:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbhAIBVm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jan 2021 20:21:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id CAC5D23AAA;
        Sat,  9 Jan 2021 01:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610155261;
        bh=WVjRRUCW/OP4Qg8uW8TFFxhREg5Zs84hORUyHlFnrtE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=U5/vxs6ekC6QAn6r5Lcf78jkNa50M4019uEpqLWISI3d9hUmSuBoMYP89jIUzw0Na
         /P+QRzoNkKlUYMrZ03vzdApaPv/oYsNbQJgO5FS3dbHGt6n80gxWMNBYDOLxHGiYYp
         cW33JVqwRQWxLA48M4x21qzsZEn2j01KhQ+deHwcEOPGcwrC5jQHpcrtumWulNkpna
         xRGUSN8KpQC184lJ6UJ2Ky5VXJWll9sYKhbFFPVJTfHH6g55+NTtsvLYi0pSOvgA4Y
         lh6nKOWyY0iT/DDP+tbnWr5vfcKbeFwfLtJCjRT88pb7ckBmfKyJYm0wQhtue5EI5X
         MFw31ed/Xf2gQ==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id C1602605AC;
        Sat,  9 Jan 2021 01:21:01 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit update for Linux 5.11-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7410da21-2442-1bb9-1dc9-0ec79483e9d3@linuxfoundation.org>
References: <7410da21-2442-1bb9-1dc9-0ec79483e9d3@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <7410da21-2442-1bb9-1dc9-0ec79483e9d3@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.11-rc3
X-PR-Tracked-Commit-Id: 65a4e5299739abe0888cda0938d21f8ea3b5c606
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 263da3330f6c0e4af603ec62f291e43eb3001f7b
Message-Id: <161015526178.8938.9637776178639980491.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Jan 2021 01:21:01 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Fri, 8 Jan 2021 11:57:56 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.11-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/263da3330f6c0e4af603ec62f291e43eb3001f7b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
