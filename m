Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D714A4A91EE
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Feb 2022 02:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356477AbiBDBQg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Feb 2022 20:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238979AbiBDBQe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Feb 2022 20:16:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84357C061714;
        Thu,  3 Feb 2022 17:16:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43531B81E57;
        Fri,  4 Feb 2022 01:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12CFDC340E8;
        Fri,  4 Feb 2022 01:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643937392;
        bh=Cyt3I3EBMavNFow1QRriz9SViu1nkBRsjpVOO+ycS+I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=X9VAtBBnW8BhgxZ3xzaECd0M5Vw9Zk1Bva5rCUCczmdoG6+rJT/i+ZMa/+UiRUtsj
         NbBcZngkD4r7Npg/g4x+4ooAjhqRRZBIh2E3tdY5XUa+qxWKwST6D+cCJBQ3de9e37
         PDhdgjmz5dJ0UXJ3L5onK4vqHQ9xOfiGsawkE5A2AxmQeqddQj43CTLZTvSporBMCZ
         wlFE640yUF/8fs4gEkR41iFpfPDSyoWQxLAl7rzGf4+wgfc8T/bIJy7+W/KQ379i6B
         bVmJ5gQVOn1NHi12oQ6gOAqBkMb5rz0UAr1DmRrgm/LhiAr5GLynIdulyHA1zW21Bk
         pt3ERWVNg7Vdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02E73E5D08C;
        Fri,  4 Feb 2022 01:16:32 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 5.17-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b82319f7-14d7-6a37-7b11-c53d90cadc4a@linuxfoundation.org>
References: <b82319f7-14d7-6a37-7b11-c53d90cadc4a@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b82319f7-14d7-6a37-7b11-c53d90cadc4a@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.17-rc3
X-PR-Tracked-Commit-Id: ec049891b2dc16591813eacaddc476b3d27c8c14
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25b20ae8151b3d5289896f4f200ff790d2cdf4bf
Message-Id: <164393739200.12311.15807559014449375931.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Feb 2022 01:16:32 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Thu, 3 Feb 2022 13:35:26 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.17-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25b20ae8151b3d5289896f4f200ff790d2cdf4bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
