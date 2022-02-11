Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3DC4B1A13
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 01:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346083AbiBKAHR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 19:07:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346121AbiBKAHP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 19:07:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346C526DA;
        Thu, 10 Feb 2022 16:07:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAB01B82562;
        Fri, 11 Feb 2022 00:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B990CC340EE;
        Fri, 11 Feb 2022 00:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644538033;
        bh=sS/KxknNfnAlRSFto3kxAOr8xBRA0HnfiFsNfw8+PqE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=L5bKHQ1SP42nuyX3gzNbPjjbwn/Y/q82aUjHLgIWcUKTMPlGhc73fw2kRG4DPyICR
         Yla4uIRAW1KwmWK4DDwwohl208NTOFWM1gCCEcuiTOp/ZoN65YpTlq6HRmR0IADpqA
         leAezCw5C9x6XX19qYSbS6cq2SQiDQSmrnRXegtIAMBXfeJMb3DYimoRBznOWsjl+1
         h1haHoZ3WDQ4O2cOSJPSAnpPvDiN5xgK2RUyCF9zUO26Sz+MGQ4+/DNA02aAfsE0cn
         TtgYt1QFyhR3setVEbpheGE3Xdpsqt4krwf/dHBq0eMCnZLSZqTiNeyRybAJgEWZRD
         XF1SzFNHzHyaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7F2BE6BB38;
        Fri, 11 Feb 2022 00:07:13 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit fixes update for Linux 5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3a0311b2-33af-d13e-e92b-111bfb357a19@linuxfoundation.org>
References: <3a0311b2-33af-d13e-e92b-111bfb357a19@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3a0311b2-33af-d13e-e92b-111bfb357a19@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.17-rc4
X-PR-Tracked-Commit-Id: 92a68053c3468705e2c7c752c9a3f256304a35a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff00854812b216e06e92191f036eb0bd1596b2d4
Message-Id: <164453803367.1838.3016325287793000503.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Feb 2022 00:07:13 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Thu, 10 Feb 2022 13:02:20 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.17-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff00854812b216e06e92191f036eb0bd1596b2d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
