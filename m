Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BCE53431D
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 May 2022 20:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343817AbiEYSh7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 May 2022 14:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343797AbiEYShc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 May 2022 14:37:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17824B41F5;
        Wed, 25 May 2022 11:37:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5E11618D1;
        Wed, 25 May 2022 18:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14CB9C34114;
        Wed, 25 May 2022 18:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653503850;
        bh=qOWTPtEiVRfX+Lgfmy1mQ2GIqJKomvsln3phClC9/WM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ksmwy6HVHnr/nV6h5YUlp+3XZRHMyC99h5naWdV9z4fIimIvcQoagAISpO5fZsXtg
         3FxgU4JzzCawpJb+F1qptkSeGVdn8HlxEolW57mBw520tg/bskca0xEwnxOIR/KU0r
         YnpjsW4DbZ0gY0XLaMXFniyqM3WGVHGeJhZBGrsFikQV3ndtSotePQ3hqZBth8PL1A
         SyqqwplX2Gxw3IWJoqjPD8fQGz8ZLv5Gziv62vIwtLaqdSOPB/hQXh27A7tzGIWdZ/
         ZN0HNp8Ae7lLk4QnLWM0uI8Cfj/FMAL/9J06oQZrOh49YEcgzJANTh7LVpbFMuXEH6
         O7Dm9o1XV9gww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE56AE8DBDA;
        Wed, 25 May 2022 18:37:29 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4ffe7200-734b-f1f9-fcab-6510b0ecbfa7@linuxfoundation.org>
References: <4ffe7200-734b-f1f9-fcab-6510b0ecbfa7@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <4ffe7200-734b-f1f9-fcab-6510b0ecbfa7@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.19-rc1
X-PR-Tracked-Commit-Id: 15477b31db104bc795dd1acccb3e9b89465fff01
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c6d2ead87e94f3d2bacb0c4539686ea7a92d50b
Message-Id: <165350384996.15754.3577490605453244316.pr-tracker-bot@kernel.org>
Date:   Wed, 25 May 2022 18:37:29 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 13:12:37 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c6d2ead87e94f3d2bacb0c4539686ea7a92d50b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
