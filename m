Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538605FCE78
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Oct 2022 00:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiJLWdn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Oct 2022 18:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiJLWdg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Oct 2022 18:33:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7FAD25AF;
        Wed, 12 Oct 2022 15:33:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C23B61646;
        Wed, 12 Oct 2022 22:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C13E4C433C1;
        Wed, 12 Oct 2022 22:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665614014;
        bh=ZYK0nH5s4tSTY01O7vEpeu7RdEGrlsKSoQjQsJlqj2M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fi0R12OV3SqGVI8peK/+2HKn3ijf13o2lN6kD0IuweTLiNcHGvkCYFpRqtB4KhYtI
         whyp/JqBk8ZYNBOdZT503VWSNsXZBo9TZvFqN9qKvWEfluwuslx9yKsPxGeZZvKiPj
         HkIMfSwIx2CE3qKjy8Ztu0ao85g5ryPNIoYxWAkAaHb9cJNDcAA/1Nfk5eLkQhtd/C
         BlULb63xx9hOQ9YGPawpx1vKASMAIAvs5PUqAYh1ZRgj+ag1AZdvQC55SddXzH/4Hj
         xDmaYN8Q9yiNQybsBosivwiSdcjWMYIaeGi/fu6y2izd34aT7US/qRUvD3BKOQFSTs
         0r/nTfa67VcnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE7BDE29F35;
        Wed, 12 Oct 2022 22:33:34 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest second update for Linux 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b78559c9-0ccd-5c25-bd51-bf3f80904c65@linuxfoundation.org>
References: <b78559c9-0ccd-5c25-bd51-bf3f80904c65@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b78559c9-0ccd-5c25-bd51-bf3f80904c65@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-6.1-rc1-2
X-PR-Tracked-Commit-Id: 6a24247132db8122600dc5523e3a62fa8fd28367
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 661e00960f072a63bb956836e65f2ce3a1ca8793
Message-Id: <166561401471.16489.2978702722774056698.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Oct 2022 22:33:34 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Wed, 12 Oct 2022 11:32:29 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-6.1-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/661e00960f072a63bb956836e65f2ce3a1ca8793

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
