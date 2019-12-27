Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60F2A12BAC4
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2019 20:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfL0TpJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Dec 2019 14:45:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:47608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbfL0TpI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Dec 2019 14:45:08 -0500
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 5.5-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577475908;
        bh=C63oD4ICeNPveLiYWEQiRy+FpGhGFjr0TTRjtKvKbMI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Qr11t/Excj1jV6Kecm5PIH5GSah7xvhYAYaJKVY0S5uU7tUfbT3ngnY25Jrt+qIJ1
         q/IXLjgg64g/R1INZy88mPhKCyenLMSswviDAHimvCqmGDvFnItkvsswZZCCbmHigs
         y54yy4obDzeAQMb/c1JuuYZpO7tIosUUJk5Tua34=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ff093d74-a232-8dfc-d632-196a7a13b611@linuxfoundation.org>
References: <ff093d74-a232-8dfc-d632-196a7a13b611@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ff093d74-a232-8dfc-d632-196a7a13b611@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.5-rc4
X-PR-Tracked-Commit-Id: 2a1f40adfb54ca65dc4c93bad444dd23b800a76e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4b3974602a5b527b22c3a0dc61ba71190ea2aa5
Message-Id: <157747590826.1730.14816195214826236390.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Dec 2019 19:45:08 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Thu, 26 Dec 2019 14:27:27 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.5-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4b3974602a5b527b22c3a0dc61ba71190ea2aa5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
