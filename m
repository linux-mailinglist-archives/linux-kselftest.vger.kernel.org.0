Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F20810F4A9
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 02:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfLCBuR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Dec 2019 20:50:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:43766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfLCBuR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Dec 2019 20:50:17 -0500
Subject: Re: [GIT PULL] Kselftest fixes2 update for Linux 5.5.rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575337816;
        bh=Dk4m/U2lxvnyR0dGU+q/ENQ9jVd5AbvgdZJjTpY59tQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RALQRtHDlbxnxW13OwjsFbaYBJDKCHeBSKO3cmbjBywvqzqWAHRyy4hrTJFSSaOOx
         H2RokqLel4NPmChjZoSgqMfDxyBj7tRolV0hZVM+TKjgeBUZ/+28pkD76t1X+oxusT
         pNGS31vQK3Zun9CFdTj1PHKhW+L2UrMIHKTxcfRk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2b0d6a6e-d135-f5dd-f8e9-74b3130d5e9e@linuxfoundation.org>
References: <2b0d6a6e-d135-f5dd-f8e9-74b3130d5e9e@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2b0d6a6e-d135-f5dd-f8e9-74b3130d5e9e@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.5-rc1-fixes2
X-PR-Tracked-Commit-Id: f60b85e83659b5fbd3eb2c8f68d33ef4e35ebb2c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e30dbe50dc91d25dde251169b66d39f99bf45bad
Message-Id: <157533781677.21520.12132405560953166223.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Dec 2019 01:50:16 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Mon, 2 Dec 2019 09:12:48 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.5-rc1-fixes2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e30dbe50dc91d25dde251169b66d39f99bf45bad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
