Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19AA7AF064
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 18:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbjIZQOo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 12:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbjIZQOl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 12:14:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6192D121;
        Tue, 26 Sep 2023 09:14:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07141C433C8;
        Tue, 26 Sep 2023 16:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695744875;
        bh=5xKmk0CcCoVRMJJtil99H2uIupYcJanN33b2o/YlHnI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=saaIYBGVjthPNY0XUpFzC6wK5L1PONVq9UYqP1zfFmj4AVM+FxZpxfo6ZIxYvXbVJ
         5rgF32jOWK/rfWV2WJ+nmUkrQBFoBZCQkdwTBRxWv//sHCmZyJM8gPtV2aOjJKfgtj
         00joKcW7tBxEEvatIbUjLd6NQ0ld/7TsAC/xhwCsT/e5e56eThqjviYntW07QvXzm0
         fngox1VfiYz0vouQRirJlf+EeQjewXEJKfMnKzdFm3+53PAKGk+0233fSChem8BtMD
         fwhDjDYGkBwDJDg3kdYnB1zq1SFQh7SAnWVkN35/z0VLJvnT4pWhTBdXM3NmpToO96
         ex//hR0bR+daQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3BCCE29AFF;
        Tue, 26 Sep 2023 16:14:34 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 6.6-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f7b2da1d-6e47-0599-03d1-c1786ff69998@linuxfoundation.org>
References: <f7b2da1d-6e47-0599-03d1-c1786ff69998@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <f7b2da1d-6e47-0599-03d1-c1786ff69998@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.6-rc4
X-PR-Tracked-Commit-Id: 8ed99af4a266a3492d773b5d85c3f8e9f81254b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50768a425b46ad7d98f6d88c22d41aa026c463cf
Message-Id: <169574487492.15087.17689670232595153581.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Sep 2023 16:14:34 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Tue, 26 Sep 2023 09:24:47 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.6-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50768a425b46ad7d98f6d88c22d41aa026c463cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
