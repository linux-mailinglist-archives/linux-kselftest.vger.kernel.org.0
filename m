Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124BD64AC9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Dec 2022 01:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbiLMAwX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Dec 2022 19:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbiLMAwX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Dec 2022 19:52:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4CF167DC;
        Mon, 12 Dec 2022 16:52:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 883B5612DA;
        Tue, 13 Dec 2022 00:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBBCAC433F1;
        Tue, 13 Dec 2022 00:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670892741;
        bh=xYbKc7QOaSjwtVA3UU++51eUglbdcWfP3Zg64xtOuZc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=b6bGmwPaTSn9b+Djmiv91Cx5Wi8Oqkd7EWDxXsWPl3FlJ661+0KOvv574JVFsV2+Z
         GgE1784aNIYxBQTN76KomdCcWdgAhCahujfF6aAA1wEMM+1Ruk58Eou4F+G+GvBINX
         D1fh1RFqvKTX6dFeLbsX+J0ZpwhH5fz5ZFTFvDgpYo76ShqN0m+wuTwSegh659oOv9
         J4HNoSvQg3Fi+EAyy9Ujf8/8FVy0FivxCcAD0xxjMZdcZ1y4YzYo28SsU5IaDaMBs3
         /YNcMrxk4dqn4adsDfETVf0R+SkReW3tom9hiSDhDWKY5223pmCkj+KA7R0WmGHIjX
         jqy2bAaSP9KZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8F20C00445;
        Tue, 13 Dec 2022 00:52:20 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit next update for Linux 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8b11b434-51a6-0e4f-ebb5-220d49ca5bc5@linuxfoundation.org>
References: <8b11b434-51a6-0e4f-ebb5-220d49ca5bc5@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8b11b434-51a6-0e4f-ebb5-220d49ca5bc5@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-next-6.2-rc1
X-PR-Tracked-Commit-Id: 054be257f28ca8eeb8e3620766501b81ceb4b293
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2ed78d5d9ca07a2b9d158ebac366170a2d3083d
Message-Id: <167089274088.13252.2216125299220610597.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 00:52:20 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 15:07:05 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-next-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2ed78d5d9ca07a2b9d158ebac366170a2d3083d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
