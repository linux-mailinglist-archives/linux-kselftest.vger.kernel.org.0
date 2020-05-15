Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A741D5A97
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 May 2020 22:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgEOUPE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 May 2020 16:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgEOUPE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 May 2020 16:15:04 -0400
Subject: Re: [GIT PULL] Kselftest update for Linux 5.7-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589573703;
        bh=4gnhVAShCJYYFd9LGgl0TpihpjTE3xLvNuOuo6w89Zc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YJp2cwYxo5T+ED9qfAprMQ8NZMHSjcAVYJcEAECDvccyruSR//AEca7z9gKY8cXRh
         3XzDvL0ILrok9p5IY8QsNl9jzVwSRy1eTcaSjoYJLKx3t4aT3b+aeJSuKW068s1LZH
         +dRifEaiLqTHqr8DWhMy5i+giNoewsZFMSXSLi8A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0cb258e7-e5ef-b42d-ef9b-2ee979a91aa0@linuxfoundation.org>
References: <0cb258e7-e5ef-b42d-ef9b-2ee979a91aa0@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <0cb258e7-e5ef-b42d-ef9b-2ee979a91aa0@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.7-rc6
X-PR-Tracked-Commit-Id: 851c4df54dc1bcae41d07e46e3d89e035b0a7140
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce24729667cf8aaebf290613a6026a50a22c3eee
Message-Id: <158957370371.26450.14505996827121272311.pr-tracker-bot@kernel.org>
Date:   Fri, 15 May 2020 20:15:03 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     torvalds@linux-foundation.org,
        Shuah Khan <skhan@linuxfoundation.org>, mpe@ellerman.id.au,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, Kees Cook <keescook@chromium.org>,
        shuah <shuah@kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Fri, 15 May 2020 11:42:30 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.7-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce24729667cf8aaebf290613a6026a50a22c3eee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
