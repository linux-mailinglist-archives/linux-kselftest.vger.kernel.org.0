Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248776CCB7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 22:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjC1Ud3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 16:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC1Ud2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 16:33:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6B01980;
        Tue, 28 Mar 2023 13:33:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32C5861935;
        Tue, 28 Mar 2023 20:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 942DBC4339B;
        Tue, 28 Mar 2023 20:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680035606;
        bh=xoUQ8heJUKR1gfQojFX4cGjO09qlemnHscHZY0fD21I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=c4YdbJY868JTt6lCioMmvQhGlGYZ5prlAE9KrLP+ExfHD8GnK9EfGFeSl9CreKfCv
         U63y6mprevgcwmrFJCrFxYnOwSCkSbhtTu0txYShTI90NL9URGEnxXXiTs/w8XhXwE
         b889reUJmyDCxDXx4Ua9fvyZ8a/hRK0RpzJToKewo09sz+1BW3X0E62W9Pi7u+5fIQ
         yIQ5ODhI0UPCNcfLE85KuZmGSwiSS3+Fdg9/7shMQZfyapcdshexXH4TbI1NnSjukM
         rzyH/frGVgSha46d4EKomqYT5ELk2opTugvJDBedJjPs46aCzHGoBDmIzCzHJdD/ue
         z++6fmfkgtwBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 76492E4D01A;
        Tue, 28 Mar 2023 20:33:26 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 6.3-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <dd25109e-5e5b-1233-31ba-f2fc19cc97bf@linuxfoundation.org>
References: <dd25109e-5e5b-1233-31ba-f2fc19cc97bf@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <dd25109e-5e5b-1233-31ba-f2fc19cc97bf@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.3-rc5
X-PR-Tracked-Commit-Id: 05107edc910135d27fe557267dc45be9630bf3dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 756c1a0593e7d26bd7dc6332e9490607cd106c4f
Message-Id: <168003560648.432.6870497184018163524.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Mar 2023 20:33:26 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        skhan@linuxfoundation.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Tue, 28 Mar 2023 10:20:34 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/756c1a0593e7d26bd7dc6332e9490607cd106c4f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
