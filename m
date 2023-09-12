Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BA479D5F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 18:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbjILQOO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 12:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbjILQON (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 12:14:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E8010EB;
        Tue, 12 Sep 2023 09:14:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71CB7C433CB;
        Tue, 12 Sep 2023 16:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694535248;
        bh=/FjwSFPnmjxyH/07JZ7vLlixqqmmPb4pIEr8nop5Bcc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ajfA3yRTK9NhJIypz2zP5sQA/phlH1oyBlYt8nCGXb23lFqEwHK3HrFz0s+RZ97h5
         8Cqk/tXH7tqdvWJT/jYKepGtHB/j/C0MvkBKsvtMB/JUPo714GAJ7VaopOmoKYIeJj
         mj44koUFbcmH7RavQomZ3lFfCcM8U35E/IwW8e40LfUovzx03FxQSoKKuTGWIaN8il
         WF60C3bSithRaGWZIOA3oExRXo0tNQWqTSavmvIRLCYX7Tmw4Thf1J8ALgDPKV/eYm
         8J3r+UclePxultWyRcfowiOEmme3JvTFKzuF8BKnNXNPskSH6DUJJpUnqpYRTxo8jg
         lt1Ak1IDLY0Tg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D7ACE1C280;
        Tue, 12 Sep 2023 16:14:08 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit fixes update for Linux 6.6-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4928e6cd-f45e-20e9-08f6-acdb1281a2e6@linuxfoundation.org>
References: <4928e6cd-f45e-20e9-08f6-acdb1281a2e6@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4928e6cd-f45e-20e9-08f6-acdb1281a2e6@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-6.6-rc2
X-PR-Tracked-Commit-Id: 9076bc476d7ebf0565903c4b048442131825c1c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb52c87a06324e3a9223bf7bb3b087557524f96e
Message-Id: <169453524837.14950.3380264296964637016.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Sep 2023 16:14:08 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Mon, 11 Sep 2023 10:20:43 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-6.6-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb52c87a06324e3a9223bf7bb3b087557524f96e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
