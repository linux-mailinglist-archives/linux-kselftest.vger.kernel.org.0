Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8551B4C85
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Apr 2020 20:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgDVSPT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Apr 2020 14:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgDVSPT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Apr 2020 14:15:19 -0400
Subject: Re: [GIT PULL] Kselftest update for Linux 5.7-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587579318;
        bh=e9Q3gBUURQJn8W8fBnaU61Afh/GJO0gIlVx4jzwD4PI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=juP1go224cj0b5xV0V4xlcTKTbdtDIwpUMoPl6+Jq3WPMZrVlETcX3hML3Z70UANr
         krBH8YefgFTpy7c8XI4YsAu0By2bYrKh5P8qguUNpMSwtw5h/J2MmjTUCyDhbeMAfB
         /BhoWmADrPkrrMY4jeR7qCtROKGxajY51uGIkaaE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <853c91e8-83ba-3d37-7601-803485dbc8ed@linuxfoundation.org>
References: <853c91e8-83ba-3d37-7601-803485dbc8ed@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <853c91e8-83ba-3d37-7601-803485dbc8ed@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.7-rc3
X-PR-Tracked-Commit-Id: b87080eab4c1377706c113fc9c0157f19ea8fed1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c578ddb39e565139897124e74e5a43e56538cb33
Message-Id: <158757931892.21627.9574195646733662759.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Apr 2020 18:15:18 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     torvalds@linux-foundation.org, skhan@linuxfoundation.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Wed, 22 Apr 2020 10:57:31 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c578ddb39e565139897124e74e5a43e56538cb33

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
