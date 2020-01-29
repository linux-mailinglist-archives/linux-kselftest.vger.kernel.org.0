Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8734114D3B6
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2020 00:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgA2XfJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jan 2020 18:35:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:56412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbgA2XfI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jan 2020 18:35:08 -0500
Subject: Re: [GIT PULL] Kselftest update for Linux 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580340908;
        bh=K6TRPGvOjdtaQ8i5m+wxoXfKwpgVTDkn5LNBnjJbi8o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JsGZH4sVBaO9yJZ/dGo8AtjONxWKnesTGrfIQjhtjyFctkdkGDn7SBqi2rLcCI1dl
         SsIgwo+MYPnd8IOfeeOCwS/OwC8BLxDPj8FJdXclvNCr7q6Ft+M5X5OKFTaKv76Tw9
         besncl6boDC5vR4UEi1pqViyH1/Dibf+QHhlNPE0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7ecbedec-d72c-62cb-3fd4-192910a8043d@linuxfoundation.org>
References: <7ecbedec-d72c-62cb-3fd4-192910a8043d@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <7ecbedec-d72c-62cb-3fd4-192910a8043d@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.6-rc1
X-PR-Tracked-Commit-Id: af4ddd607dff7aabd466a4a878e01b9f592a75ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce7ae9d9fe4391413db680ce0732da2144b6f4a3
Message-Id: <158034090845.30341.12650320254178497764.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jan 2020 23:35:08 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Wed, 29 Jan 2020 08:44:48 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce7ae9d9fe4391413db680ce0732da2144b6f4a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
