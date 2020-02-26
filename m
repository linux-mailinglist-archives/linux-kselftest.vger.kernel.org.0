Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC766170808
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2020 19:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgBZSuK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Feb 2020 13:50:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:40850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbgBZSuK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Feb 2020 13:50:10 -0500
Subject: Re: [GIT PULL] Kselftest update for Linux 5.6-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582743009;
        bh=J8JivntGkGXXIoeXOAZoYbIRHjybbES5Vcu8sVB4hfg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GM79bs2Wetji73op+qrOlHc5QNEzCdbZVqTkJyYq2wnArQMe+2gIV7fBvlWaNB5yr
         dEhR/Q3N9152hruOEvr+zv1UrCx/BFf9OrUiALMF0FLroLg2Qzy8Cz9oIey37NXBkY
         MRK2HMUqcAxgf6GFjoKzPM78v6s8StnGW6S4C6K0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <94b64a48-a337-63c4-c504-7e9b0c29a7c6@linuxfoundation.org>
References: <94b64a48-a337-63c4-c504-7e9b0c29a7c6@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <94b64a48-a337-63c4-c504-7e9b0c29a7c6@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.6-rc4
X-PR-Tracked-Commit-Id: ef89d0545132d685f73da6f58b7e7fe002536f91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2fcc74178f6dc06ecffcd1f601ca3a3e87b3012c
Message-Id: <158274300961.12298.6557434011719328786.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Feb 2020 18:50:09 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Tue, 25 Feb 2020 16:26:42 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.6-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2fcc74178f6dc06ecffcd1f601ca3a3e87b3012c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
