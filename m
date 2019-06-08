Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B71543A17C
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2019 21:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfFHTaJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Jun 2019 15:30:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbfFHTaI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Jun 2019 15:30:08 -0400
Subject: Re: [GIT PULL] Kselftest second fixes update for Linux 5.2-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560022208;
        bh=2xnhTkDgxhomcEYSC8TF3vXtQIupEjCcVUzdvPsc4z8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ktzuyIYCCEV8HNotX3YWMJhgKix88843hjJHjWG5LzcLgnlp4QbZvVFZTLLSkP/yE
         Uny8Dv/MwQw9ay3cjVDiJnpVlRscvjXNsF1LmwLDZRa/APgmZeYfiuTGPaWgmSYl+Z
         Tj5LUhjsDDRQT3GCqAMCtjEtMrOYUeDhYNA+flEs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f97f7947-db3b-07dd-157d-78ab9840a4dc@linuxfoundation.org>
References: <f97f7947-db3b-07dd-157d-78ab9840a4dc@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f97f7947-db3b-07dd-157d-78ab9840a4dc@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.2-rc4-2
X-PR-Tracked-Commit-Id: e2e88325f4bcaea51f454723971f7b5ee0e1aa80
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ad43e29b6e845758f0ceb80e3c1d1a9cebfad06
Message-Id: <156002220828.30045.6304967504343765394.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Jun 2019 19:30:08 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        skhan@linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Fri, 7 Jun 2019 20:11:05 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.2-rc4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ad43e29b6e845758f0ceb80e3c1d1a9cebfad06

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
