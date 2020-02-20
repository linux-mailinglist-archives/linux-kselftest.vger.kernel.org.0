Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0627B165440
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2020 02:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgBTBaS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Feb 2020 20:30:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:36780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbgBTBaS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Feb 2020 20:30:18 -0500
Subject: Re: [GIT PULL] Kselftest update for Linux 5.6-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582162217;
        bh=EpRXWJGGUUbhRf9VzBEnFF/3XdEE4MhQdUCQ0mtrK0E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dN7OJdhiFY5BsWz1ezqX84nhsMxOV3svROfrcS5wNwfHdsGHgk5/d5h3lSfhYIbYH
         d0Nd3qMKSFJmRg/WquMkPRHaJ5hBQUOv+7s55nVbTmjP6LelBuqTHiWCuwQAdru3uD
         66EYbTUXJZlc4XsKcpVPxM+jwjZfNoa620GWDW4I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a95f0345-405b-82f4-85cd-c0b80ba700e7@linuxfoundation.org>
References: <a95f0345-405b-82f4-85cd-c0b80ba700e7@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a95f0345-405b-82f4-85cd-c0b80ba700e7@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.6-rc3
X-PR-Tracked-Commit-Id: 9a0584f05687947d5a0b87f046bcd2592a55e67c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca7e1fd1026c5af6a533b4b5447e1d2f153e28f2
Message-Id: <158216221756.30253.5687014824412252935.pr-tracker-bot@kernel.org>
Date:   Thu, 20 Feb 2020 01:30:17 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Wed, 19 Feb 2020 15:33:51 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca7e1fd1026c5af6a533b4b5447e1d2f153e28f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
