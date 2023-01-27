Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF1267F031
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jan 2023 22:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjA0VOl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Jan 2023 16:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjA0VOj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Jan 2023 16:14:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD007834AC;
        Fri, 27 Jan 2023 13:14:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 856F7B821EA;
        Fri, 27 Jan 2023 21:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29782C4339E;
        Fri, 27 Jan 2023 21:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674854076;
        bh=kcg8KBnXfGrcZfKebs4or6jus6IX3PJEUEyRudlUS5A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dPtPUMCnT0/90t3WvV18jOidM2JyBbno16KPDx/je2qa3PMph+knh9oY/hbwybknR
         A1pdTH3ekWH5K/9D/066pQxppxy6P0EcDCM8zl7PL5t3d+rrLOBsJfyjPQ1A7mkBxn
         TEEczAxgynISUo1H24R8KQGk2dDB49b+vQwHC8e7ueD2i8TF8u1hnvL56OBTCwMWb/
         WRTmvGQ/h3eBkfwOKXTM1XQr1jh/PUa8xV/XDefU8lBkb5NpV4dDMOv0zLA/z0nvAx
         Kkks4qKzgVpHTqg/gGxxjUDJdPz8EzWGUQziKhQ15a5twthW8UM0AOHENA2nuLKWDu
         9uFUuAkj1hxwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 185BFE52504;
        Fri, 27 Jan 2023 21:14:36 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 6.2-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3bbe9344-4546-5bd1-52ae-ed6532528e6c@linuxfoundation.org>
References: <3bbe9344-4546-5bd1-52ae-ed6532528e6c@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <3bbe9344-4546-5bd1-52ae-ed6532528e6c@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.2-rc6
X-PR-Tracked-Commit-Id: a49fb7218ed84a4c5e6c56b9fd933498b9730912
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f4d0bd24e6b42555c02e137763f12c106572e63
Message-Id: <167485407609.14056.4513647288036865723.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Jan 2023 21:14:36 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-pm@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Thu, 26 Jan 2023 13:37:14 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.2-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f4d0bd24e6b42555c02e137763f12c106572e63

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
