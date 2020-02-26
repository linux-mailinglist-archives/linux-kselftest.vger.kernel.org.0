Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F069517080B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2020 19:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgBZSuN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Feb 2020 13:50:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbgBZSuM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Feb 2020 13:50:12 -0500
Subject: Re: [GIT PULL] Kselftest kunit update for Linux 5.6-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582743012;
        bh=tJW1oOsWNoTrZtaLgkEA4Sai3rshOgIGuK3SViztHlk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VBYpoxFwDT5Ef3Ah25D4ToSXgufKvpWytWkfodTqhKfa9z8Lx2Uf4SQsVJQLMogUa
         KuAVH1F/uMLOdtoO/KFmYiJN5mBF3SQtjkymBuRtX/lWIx3YakJ92pZwdahbxKkuyr
         sCgDoVuPLsTxiezDMSboPuqaXGXtsKKD4EqYnuD4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <728b8941-6687-d3b3-2156-1d74ee4dc3db@linuxfoundation.org>
References: <728b8941-6687-d3b3-2156-1d74ee4dc3db@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <728b8941-6687-d3b3-2156-1d74ee4dc3db@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-kunit-5.6-rc4
X-PR-Tracked-Commit-Id: be886ba90cce2fb2f5a4dbcda8f3be3fd1b2f484
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b98cce1ef5c5ecb8028531ec2305c4591c9b6ca1
Message-Id: <158274301232.12298.14700150603953349438.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Feb 2020 18:50:12 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Tue, 25 Feb 2020 17:33:30 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.6-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b98cce1ef5c5ecb8028531ec2305c4591c9b6ca1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
