Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE76160BCFC
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 00:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiJXWDT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Oct 2022 18:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiJXWCr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Oct 2022 18:02:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0302F9C00;
        Mon, 24 Oct 2022 13:16:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8998C615BA;
        Mon, 24 Oct 2022 20:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAFF0C433C1;
        Mon, 24 Oct 2022 20:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666642018;
        bh=ZHu+cqAeK1kalG/F9/zzh8eMHDvcM1A6oI6sYTcXkLk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fgc2rZAr0pi+Oc+QC/tA1mY4TXYbCFrf2Nmzgn4/H9CO5znxUjNtHlbM2mTVuR3fl
         6MGQx5H0biEIeRWXsQt30J97bs+ri6OuJiE1tQdpNKAd6duqZag73PTAnBSItZ4PTu
         l/LNedPp9hMnXRVWTfCC+2c1dKKArBxUalZJrcDKj1oUy+c5ILtmSCQYAkX6SioHNg
         mSv+lh2DUMxAV+NrHv7mYeesea8KGZ3XX/no9moGmYpfmWdEuePWzGg5D5R35AIMp9
         MfAr05xgTRHyaDnJAfiPJr+rVjFXd43J/NAf64l4L+qMzVB27nbmnZqzbD52k37Gj2
         eIxQnN0Ai2wpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6277E29F30;
        Mon, 24 Oct 2022 20:06:57 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 6.1-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b9c14ec8-b410-c742-3cb4-0067e2bf7100@linuxfoundation.org>
References: <b9c14ec8-b410-c742-3cb4-0067e2bf7100@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b9c14ec8-b410-c742-3cb4-0067e2bf7100@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.1-rc3
X-PR-Tracked-Commit-Id: cb05c81ada76a30a25a5f79b249375e33473af33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 21c92498e9b86b5b3e91818e13ce7943da8496a4
Message-Id: <166664201787.4311.1201622408202250233.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Oct 2022 20:06:57 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Mon, 24 Oct 2022 10:35:43 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/21c92498e9b86b5b3e91818e13ce7943da8496a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
