Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49D661878A
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 19:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiKCScl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 14:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiKCSc0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 14:32:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDD321818;
        Thu,  3 Nov 2022 11:31:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44680B82929;
        Thu,  3 Nov 2022 18:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E71BCC433C1;
        Thu,  3 Nov 2022 18:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667500292;
        bh=Bva7m858nZhZHiWUAdOaHVh13dWtpM3OyRnd8z4cZmo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WO22BxK+RhhclVLylTz8Z/yMgsCOAWTYwxHNrLGjga4eXtXPdKniulpeDAKIckaHo
         mLIB5PWC7VyiiE+4wEysHeB1hrd0qlPnXzOg++lpoCzZh22mCfVkJpFshAG1uD68L+
         StV17zXvct8IHI/71KSPkzWuOrwnw5AkxPft252PEONqnNITM4+ApTXwtAsvBXQ3Zt
         j0IuUPyJ7WSHW/O4ZZGtqj9hEzuStFuTyGyNMFZbUPe7MJ7f4HGMYstGtpnJrSd4D/
         htW1Tr4mqapyUoCK29PbCe2eX3zgGNhG6Y9wYl19HXq5gi1t6I0VQPh6F0v7vLxjzN
         6vxe+AxIV62fg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3ABBE270EA;
        Thu,  3 Nov 2022 18:31:32 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 6.1-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6eae8f0b-2050-3c0f-828d-8b87262b1cef@linuxfoundation.org>
References: <6eae8f0b-2050-3c0f-828d-8b87262b1cef@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <6eae8f0b-2050-3c0f-828d-8b87262b1cef@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.1-rc4
X-PR-Tracked-Commit-Id: 89c1017aac67ca81973b7c8eac5d021315811a93
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5fdf9c45473569e87cc4206e80f186fc85b9eff9
Message-Id: <166750029286.3912.1180871745760604600.pr-tracker-bot@kernel.org>
Date:   Thu, 03 Nov 2022 18:31:32 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Thu, 3 Nov 2022 07:33:57 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.1-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5fdf9c45473569e87cc4206e80f186fc85b9eff9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
