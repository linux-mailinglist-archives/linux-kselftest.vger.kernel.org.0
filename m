Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB6D48A0E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jan 2022 21:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343633AbiAJUWg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jan 2022 15:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343584AbiAJUWg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jan 2022 15:22:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE048C06173F;
        Mon, 10 Jan 2022 12:22:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EC7F6140F;
        Mon, 10 Jan 2022 20:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0A1CC36B01;
        Mon, 10 Jan 2022 20:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641846154;
        bh=Xp6ilqgfH77DmSJc/Xcq0GohHk6tPugP9TQHGTCqsts=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OQMuzp4dDx7SLD7Vy/xA3LNX58p22Z+nxITwctyUsy/3ZoIxVoUpKle1i+JyNjYDh
         Fxt1+IeHPvMpXcU63Oa1kcq64uwObbIBYplXbuUVZGenG5GdFzyNoWrOySHC9llUI7
         /Q0I8mjzhKsK0tayIoptLac9Uh3OgpI97pYpRFwoQYWdvf/NPHY34d5aL6sqDWMu0T
         R2E9iMQ06a4yXrvQCtOIVLg20orC93M7zKMGcXPCYmitDc9HR6AfUkvM0kb04A/Gc8
         6nRUrCxSm7SFQvIHZW02R9qi/CrG0WLCMxk70hETmC3AZRXXvl33VLv8mvBc46VrEv
         tt8xRttOvF8XQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE6F4F6078D;
        Mon, 10 Jan 2022 20:22:34 +0000 (UTC)
Subject: Re: [GIT PULL] seccomp updates for v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202201050919.9DF1B7D60@keescook>
References: <202201050919.9DF1B7D60@keescook>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <202201050919.9DF1B7D60@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.17-rc1
X-PR-Tracked-Commit-Id: 1e6d69c7b9cd7735bbf4c6754ccbb9cce8bd8ff4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d3a1e0a88e76bcb914e269cba0bfed6f4584a5e
Message-Id: <164184615477.11936.15309237751276558425.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 20:22:34 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org, Will Drewry <wad@chromium.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Wed, 5 Jan 2022 09:20:59 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d3a1e0a88e76bcb914e269cba0bfed6f4584a5e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
