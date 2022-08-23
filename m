Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8942D59EDBE
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 22:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbiHWUsc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Aug 2022 16:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiHWUsT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Aug 2022 16:48:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD1A32050;
        Tue, 23 Aug 2022 13:42:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E2F26151E;
        Tue, 23 Aug 2022 20:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B412BC433C1;
        Tue, 23 Aug 2022 20:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661287378;
        bh=4iRajjHOIsJ/FTt3tzy+3B+pUo+9MWxZod1cB+gJxmE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dlmrc5Jcc2HO2/O67EZclluGAlwn/yb0xDn0XOn8RV/m4a4TKXU07sz7YenKoDdg1
         KHAdilrN/qs1qSvlWuxMtybX4h0fj+duki2ytoouRuc2zCV5sHa11LHy+EDoBIJtey
         cnPonUoX69KnyAQADevBW23310n8m/i4ev5HZcq+Uq+aaBMx7riiT06OMZG2CB0LNW
         JY1QDILbk7Mo0N5Y02YB+7mRyA1H+ZFH8B7Wksy38ToBjRqsarhfE6fDU1TCEaRWiw
         PHSqjr2MGKzzOiP4cCJHMxq+HQt9yZCIm0npLJI1gWVEDRtw/16c+MOKQfmalx6wkk
         3rGQPlfx1zebg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9CC99C004EF;
        Tue, 23 Aug 2022 20:42:58 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest update for Linux 6.0-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2ccb5e70-2130-827a-5f05-c0264f1e3cf8@linuxfoundation.org>
References: <2ccb5e70-2130-827a-5f05-c0264f1e3cf8@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2ccb5e70-2130-827a-5f05-c0264f1e3cf8@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.0-rc3
X-PR-Tracked-Commit-Id: bdbf0617bbc3641af158d1aeffeebb1505f76263
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ee3d984102bc4e0ae4c3cbd67c80c0d61514100
Message-Id: <166128737863.14227.6887771571843137452.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Aug 2022 20:42:58 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Mon, 22 Aug 2022 15:51:16 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ee3d984102bc4e0ae4c3cbd67c80c0d61514100

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
