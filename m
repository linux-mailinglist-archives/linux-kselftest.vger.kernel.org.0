Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7512C2133A2
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jul 2020 07:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgGCFkI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Jul 2020 01:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgGCFkI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Jul 2020 01:40:08 -0400
Subject: Re: [GIT PULL] Kunit fixes update for Linux 5.8-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593754808;
        bh=ocskdSa0KVruh+R4uOpgC7Tiw8alBDbBAnXQd6V/rgo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aLlOd09mgW6cNmxHE46hmJFdD1v51zC0bh8qFch1cg48R2Ablw0OJ/EAB1YaVuIG+
         62Egl+ck/HGUpYhbKbjCrmUbth84VjD6qxuK4xarH7I3yj8Ls6luivFQt86M0LDAGM
         Pop6aXruZ5uLlppr5b+56k2cv6pchjRHm34ryx4E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <39219b27-98db-609c-d77b-3db2eb64345a@linuxfoundation.org>
References: <39219b27-98db-609c-d77b-3db2eb64345a@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <39219b27-98db-609c-d77b-3db2eb64345a@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-kunit-fixes-5.8-rc4
X-PR-Tracked-Commit-Id: c63d2dd7e134ebddce4745c51f9572b3f0d92b26
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55844741a1e74bd41b4cea57502c2efedc99bf47
Message-Id: <159375480808.400.11761356366202390858.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jul 2020 05:40:08 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     torvalds@linux-foundation.org,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, skhan@linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Thu, 2 Jul 2020 09:23:55 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.8-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55844741a1e74bd41b4cea57502c2efedc99bf47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
