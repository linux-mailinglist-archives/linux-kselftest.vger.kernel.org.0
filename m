Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CC128FB16
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Oct 2020 00:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbgJOWTb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Oct 2020 18:19:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731787AbgJOWTa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Oct 2020 18:19:30 -0400
Subject: Re: [GIT PULL] Kunit fixes update for Linux 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602800370;
        bh=Mf4fM4L/Vxw62qPGaTAmFsbvXkUt/1LTYplx5bOa+WE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FiOLghuS4d2uXiY6ApsxWdu9rIs40e2pOW6SbpbG/u6OS8mKF9Fp7vaw3C/MREwo5
         T0y/YJo9/89HNqR1rCs0J2jYS+yqlDmf1NyUNrq4pyZyW9BxKSwopWDQYuJNBemeac
         JGHS6jrs7Go00eMjWQjg0bImuiW18MBWrLPlQPS8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <18ef2c05-5e4e-bdb3-560b-847aada816c3@linuxfoundation.org>
References: <18ef2c05-5e4e-bdb3-560b-847aada816c3@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <18ef2c05-5e4e-bdb3-560b-847aada816c3@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.10-rc1
X-PR-Tracked-Commit-Id: 1abdd39f14b25dd2d69096b624a4f86f158a9feb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 578a7155c5a1894a789d4ece181abf9d25dc6b0d
Message-Id: <160280037009.16623.3214734245182391802.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Oct 2020 22:19:30 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Thu, 15 Oct 2020 15:13:02 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/578a7155c5a1894a789d4ece181abf9d25dc6b0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
