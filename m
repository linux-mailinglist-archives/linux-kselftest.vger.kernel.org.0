Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9607823D30D
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Aug 2020 22:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbgHEUdS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Aug 2020 16:33:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbgHEUdM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Aug 2020 16:33:12 -0400
Subject: Re: Re: [GIT PULL] Kselftest update for Linux 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596659591;
        bh=TXYQwMoPGaRbjNI+FnM5hefOLkB+Sak6ssnj/0O33dM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YVwwam73RCK6mJPHLIogcdtJo60I2RbxcwXDoNpD8r1nU6cthc7s6X8Gj2chqqZX0
         qc1wLAC831Dwe1CrPirjeieWHMNxeNWICzXFU/TT5z7Ui1kiPT1b3v+NPIG1/jy5SH
         1ZQmrI23qk6uyKlJnL2DlO8XNbx2LXQCH3tkV14g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8d894cb3-83ac-66bc-48ec-dc273d1afcbe@linuxfoundation.org>
References: <0e3a9c1f-7ac6-33e2-ed11-5a56659fc5f7@linuxfoundation.org>
 <CAHk-=wi4iDwuazgXQ-1yvM_JMTBepi9rc-zfSMeyjfDgSS2fgA@mail.gmail.com> <8d894cb3-83ac-66bc-48ec-dc273d1afcbe@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <8d894cb3-83ac-66bc-48ec-dc273d1afcbe@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.9-rc1
X-PR-Tracked-Commit-Id: 850d0cc64c8e2e0895acf735ac0a53c78b80dbe5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4834ce9d8e074bb7ae197632e0708219b9f389b5
Message-Id: <159665959176.13939.287196953712072463.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Aug 2020 20:33:11 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Shuah Khan <skhan@linuxfoundation.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Wed, 5 Aug 2020 08:13:44 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4834ce9d8e074bb7ae197632e0708219b9f389b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
