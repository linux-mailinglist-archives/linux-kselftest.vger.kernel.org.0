Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AE87D1870
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 23:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjJTVyO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 17:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjJTVyB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 17:54:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C31D45;
        Fri, 20 Oct 2023 14:54:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D63FFC433C7;
        Fri, 20 Oct 2023 21:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697838839;
        bh=Vwhfe4VIJe4aUcq3Edfp0oen9SwGVimJlxk5IypRw/0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OW0Ujpi1KAtNxYIdBMTbBouU+L7sBF7ttGzI/huyKztd/CPYjzrLk4ixX6xcamLrV
         FIo6TNQs2vWFtEtlf/9qmL2hiS5y7BUcfoyIkTQILBjV5hVtk/gQHpL6ddzVjUU0Qk
         1W1fUnk46fA9QCWpoFuq9FP3HGhY6e0ne97vH/bWUbywwL9s1u3vu3fHX1UvBm9wBE
         r/X/Z4y1rMXeHNBsBqZnYbOGYjorT56x2bqhPh3SqadJagO3jc5rg+XOa2SI4QJIpw
         6VZlX5VPpJJ9GS7jRR62zbkvZozP1W69MLha36rhAC5l1FrvX4fcggt/jRziPR6A84
         I4PQGz29B+KEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C285AC595CB;
        Fri, 20 Oct 2023 21:53:59 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 6.6-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <817898d0-dbe1-4016-af10-abd1731748ea@linuxfoundation.org>
References: <817898d0-dbe1-4016-af10-abd1731748ea@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <817898d0-dbe1-4016-af10-abd1731748ea@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest_active-fixes-6.6-rc7
X-PR-Tracked-Commit-Id: cf5a103c98a6fb9ee3164334cb5502df6360749b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 444ccf1b11a0dbc54e789d6d2634c2649dc27498
Message-Id: <169783883978.25290.9392450008606826589.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Oct 2023 21:53:59 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        shuah <shuah@kernel.org>, skhan@linuxfoundation.org,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Fri, 20 Oct 2023 11:20:00 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest_active-fixes-6.6-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/444ccf1b11a0dbc54e789d6d2634c2649dc27498

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
