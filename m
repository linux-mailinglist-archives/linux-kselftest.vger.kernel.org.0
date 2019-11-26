Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78E7F1097B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2019 03:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfKZCPG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Nov 2019 21:15:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbfKZCPG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Nov 2019 21:15:06 -0500
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 5.5.rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574734505;
        bh=Yg5y6XK5exzyqkIXwlNbhLwM9M2YtuNymQUC03+OnUE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Xd2xeDfQoq5O+JD9snhyHupb1RDIRjdtKzLw/ZSEDp6s64Anur1qE8mTd4dP18O0z
         OWfm8/N72trUrRpSoXM+l3FaE2hVEIkIOdI9KG++6BaNxqan34TfSf1uXvgxsnKqMn
         iei0WdVnF3gH+yCQoTpEmyGvNHtAFhbNhONLhOD8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ab38f85c-cd96-d79a-b359-32d599203c25@linuxfoundation.org>
References: <ab38f85c-cd96-d79a-b359-32d599203c25@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ab38f85c-cd96-d79a-b359-32d599203c25@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.5-rc1-fixes
X-PR-Tracked-Commit-Id: ed2d8fa734e7759ac3788a19f308d3243d0eb164
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db7d275415d774de3d2151d6885bf61c33243419
Message-Id: <157473450562.11733.13735431578713069444.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 02:15:05 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Fri, 22 Nov 2019 12:41:57 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.5-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db7d275415d774de3d2151d6885bf61c33243419

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
