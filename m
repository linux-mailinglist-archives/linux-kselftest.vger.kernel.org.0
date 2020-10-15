Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B5328FB1A
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Oct 2020 00:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731806AbgJOWTb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Oct 2020 18:19:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731784AbgJOWTa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Oct 2020 18:19:30 -0400
Subject: Re: [GIT PULL] Kselftest next update for Linux 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602800369;
        bh=7Hs2/c0SuTxv8FWOInF6Cyfz9wWihCf+MKtfTXYrqFM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RzgEgY1UsqLS3iXV1MELy/u5/omJbBTRidMkp7tgShxCOydF94imD8mWVFGoI8Iez
         AjFgtZLt5Qz8YL5arUn5Vd98MBvVtvxsJc78yuJu3wKJOn5L29RI6hLPrDq4+S0r2J
         MCqZK5UFULK+hc9vz1UiqloyJPkOPAMWSgFkROGc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e91227aa-4f7d-7a45-0b40-c6bbc72ea67f@linuxfoundation.org>
References: <e91227aa-4f7d-7a45-0b40-c6bbc72ea67f@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e91227aa-4f7d-7a45-0b40-c6bbc72ea67f@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.10-rc1
X-PR-Tracked-Commit-Id: 4c8511317b4ec75cc3868f80a7b9fddb8322e512
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0674324b16d40e14b9d8ea2d667627c010608c28
Message-Id: <160280036978.16623.14806471272884269061.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Oct 2020 22:19:29 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Thu, 15 Oct 2020 13:55:07 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0674324b16d40e14b9d8ea2d667627c010608c28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
