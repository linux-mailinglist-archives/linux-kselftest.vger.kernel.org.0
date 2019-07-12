Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB01676C7
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jul 2019 01:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbfGLXUV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Jul 2019 19:20:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728501AbfGLXUU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Jul 2019 19:20:20 -0400
Subject: Re: [GIT PULL] Kselftest update for Linux 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562973620;
        bh=0XcWBpqgQuvOqn2EDRQYoSHFPu3bWBf7oYAMFQSUJkY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=F0qaHWp10KLAHYCWPrbHbXXKgk08nO4pPRUr59QZdEDsk9cK95Q2My0Bpu3Cez7uV
         0XlMnZBv9Hcz3bNSB5Gd/3cvBTeqFkULsF6S7e1zQvi5xyQOIthRGUsLmxA8KzaxJu
         uas51RT3hvhPvlEhCNuZPUpJb3JqHLPgEpeucnb8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c5cd56e2-26ab-650b-581d-b3030ab31be4@linuxfoundation.org>
References: <c5cd56e2-26ab-650b-581d-b3030ab31be4@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c5cd56e2-26ab-650b-581d-b3030ab31be4@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.3-rc1
X-PR-Tracked-Commit-Id: ee8a84c60bcc1f1615bd9cb3edfe501e26cdc85b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8487d8229990e6eacaf1c854a113c9d16b7b596c
Message-Id: <156297362009.22922.7524407458441687990.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Jul 2019 23:20:20 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Fri, 12 Jul 2019 12:07:27 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8487d8229990e6eacaf1c854a113c9d16b7b596c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
