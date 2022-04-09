Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879F34FA0ED
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Apr 2022 03:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237480AbiDIBLT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 21:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238680AbiDIBLT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 21:11:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E5637A92;
        Fri,  8 Apr 2022 18:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 846C8621BB;
        Sat,  9 Apr 2022 01:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E838AC385A1;
        Sat,  9 Apr 2022 01:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649466552;
        bh=slwUthlbtJFP504ndOrMg0gfY1MxpkP2Rj4g5JgbMWA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tb29OFpy8a8YcB9RbsHrLHLVkZi+RD60WCGHyOGT4S/eQJ5tHZb09Kgj6QbpaXFEC
         kWIXDwaWtq9B0BOvqGv/7zvUB5ZfjkbzpdUQtMk+64HQwuCN5wvW6EnRNOTpVTKVFR
         Ce2PXTpbtTKLSDknDj4Hc/gSdkuvxSU8t7JDQroeWVX5fa+FVNqX2K/GHPr2ssvnOO
         5oUk0otfK9w/rNs/T24dxI3kFzJRlMQ4YHOMr4ECDN5KvIYdVsh0CyMZVeSD0/2/oB
         SXovXiczGA++QLlDJ8DpHV++PAKzvCnnfgeQ0pM5caEJv+X9uWDod4DVidoHJlMwrB
         mYYme6b+sh3vg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5609E85B76;
        Sat,  9 Apr 2022 01:09:12 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.18-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e4798810-fdb4-d436-ed19-0d0d38138002@linuxfoundation.org>
References: <e4798810-fdb4-d436-ed19-0d0d38138002@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e4798810-fdb4-d436-ed19-0d0d38138002@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.18-rc2
X-PR-Tracked-Commit-Id: 79ee8aa31d518c1fd5f3b1b1ac39dd1fb4dc7039
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9abb16bad5d802e4a1fce3a498d5ee6a334e84a4
Message-Id: <164946655286.8314.11620926656499077754.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Apr 2022 01:09:12 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
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

The pull request you sent on Fri, 8 Apr 2022 12:36:38 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.18-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9abb16bad5d802e4a1fce3a498d5ee6a334e84a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
