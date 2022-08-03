Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36BF588602
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Aug 2022 05:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbiHCDX3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Aug 2022 23:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237484AbiHCDX0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Aug 2022 23:23:26 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB174F64B;
        Tue,  2 Aug 2022 20:23:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6C328CE224D;
        Wed,  3 Aug 2022 03:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5154C43140;
        Wed,  3 Aug 2022 03:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659497001;
        bh=/8SWf9ElFN1K2ndDbbvMcoeSLuQ1di2F4bgMwhzVFFc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JKh+dojAW10nYAlFNa/1+FmzdUT6GG3wKILXkfDl91iRQU+/k8d72DSo+7xjB9n9B
         PCeuLCoMgR8jNWCmvp2LMr0l6yliQTFpJqR6N7qiXkpg70CT2CNbKYG1ADxqz+c8CB
         AsVCKXQebDy/yeRTaeB/pEyTxLvnRpd+ZgcrrCwS5Lj7rhT3w1GVm1d10Wl2E4/wnr
         xRBMGpa/tUW6O/FVZVoxtpWIpVGPCB2JyzjHi2ISvBYkzYw7aXCtlyWsz7ZtSsQm8m
         3rD8CEVbQ4y2jtCO4WLk/8BBsnl93KQEXujf8NNwjUEV7ojH2x5SB2ySTs700ODq8w
         q4tFb7CmVpJIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A42FEC43140;
        Wed,  3 Aug 2022 03:23:21 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit update for Linux 5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e0b61c0e-3b02-2681-3175-ad17501f3c2a@linuxfoundation.org>
References: <e0b61c0e-3b02-2681-3175-ad17501f3c2a@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e0b61c0e-3b02-2681-3175-ad17501f3c2a@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.20-rc1
X-PR-Tracked-Commit-Id: 4c392516accfe51a1aaf80ed163517646f8f0476
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 665fe72a7d4f0ad17923e0a5ff2e6cc64d57c970
Message-Id: <165949700166.31205.13905119651001568791.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Aug 2022 03:23:21 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Gow <davidgow@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 15:26:02 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/665fe72a7d4f0ad17923e0a5ff2e6cc64d57c970

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
