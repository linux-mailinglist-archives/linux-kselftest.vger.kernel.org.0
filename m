Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6630292057
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Oct 2020 23:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgJRVuy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 18 Oct 2020 17:50:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728626AbgJRVuw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 18 Oct 2020 17:50:52 -0400
Subject: Re: [GIT PULL] Kunit next update for Linux 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603057852;
        bh=OONxpZ4lLl+2dRTh7eTE+DiPk7aK2MS+QcpVO1lUiMs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nwrBa2otNo99IzzPbP66HyThUMr91gpHxOvfbL5rH5eobuTrO1kF6oSoxif+hnvRF
         Kss2FHZtFKhUJ5Ktu510rgUi0wEou/I8vLkTZYSX3WU4cUSnAB9JESImyiV9nigD40
         EcBFEtaWbQOeUzWu7OEVc/mig+BuVLKUzDR6EgoE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6ad05bbb-d437-57b8-25a6-fed80852ecec@linuxfoundation.org>
References: <6ad05bbb-d437-57b8-25a6-fed80852ecec@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6ad05bbb-d437-57b8-25a6-fed80852ecec@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.10-rc1
X-PR-Tracked-Commit-Id: 294a7f1613ee49a608361bd319519561c0ca7e72
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cf726a59435301046250c42131554d9ccc566b8
Message-Id: <160305785211.15396.13890876442366284978.pr-tracker-bot@kernel.org>
Date:   Sun, 18 Oct 2020 21:50:52 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Sun, 18 Oct 2020 15:33:53 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cf726a59435301046250c42131554d9ccc566b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
