Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8762133A4
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jul 2020 07:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgGCFkM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Jul 2020 01:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgGCFkI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Jul 2020 01:40:08 -0400
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 5.8-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593754808;
        bh=1PQoSFGeykjYBraSRM8kS0DiUCQhGPxof6Uw1hWDvQc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AwMbDadJMS8hNPexaeV4AFen14i+AZsKTII1MUWNkKB65+KOagJhMPvrbQYbW3lae
         wlAnhESpgFnefBcIggyNjcBZ/OC5XeB2WYjWGiyo/WT9u+hak9q0Wvi8YDhwt2kd8F
         U8hrPJPTYD6NizNYO612OOcz9T89VT/6k/9Fm93s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c97a669c-02d8-24c6-3bbf-295124d8261a@linuxfoundation.org>
References: <c97a669c-02d8-24c6-3bbf-295124d8261a@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c97a669c-02d8-24c6-3bbf-295124d8261a@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-fixes-5.8-rc4
X-PR-Tracked-Commit-Id: 377ff83083c953dd58c5a030b3c9b5b85d8cc727
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0dce88451f9c1cc5f1b73818e0608d5f84499e9a
Message-Id: <159375480825.400.6437519329876320973.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jul 2020 05:40:08 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Thu, 2 Jul 2020 10:26:58 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.8-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0dce88451f9c1cc5f1b73818e0608d5f84499e9a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
