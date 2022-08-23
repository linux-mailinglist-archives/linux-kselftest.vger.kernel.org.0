Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5E359EDBC
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 22:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiHWUsn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Aug 2022 16:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbiHWUsT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Aug 2022 16:48:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812256159;
        Tue, 23 Aug 2022 13:43:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35C01B820F0;
        Tue, 23 Aug 2022 20:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D51F3C43141;
        Tue, 23 Aug 2022 20:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661287378;
        bh=DxS6qBeae/nePoGYBnFrqZR4KJ+gs5XuYmLPbGUIa6c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AarG56I9AjHFdsFKUtKmYEkKOxvCIHAWXuQkJIamTB/+mhqJoCwZiW0kSDvfxRh2U
         ZmqI3sXeTFXTzJNsfi2cIAJBONnU/FVvSm+uISVuQn9Of1PXvv13Hh4nVMH4XNIYJY
         CEm9wUQWDHkz9cgbi0hRcsFNZjETzMOMYBQ9h34+biGlWDZwROvaKrZnjJNpfHoMUH
         FScnQqzcSwbbOe5YUCw6yzgJ+Ep6Jcjz0UmIcBR8qxjm7fFxEb2nakQlwzLF839hfU
         mSAmEOP2TlsOR6pwMtNPxlN5V6ETNzdEfiZimuJWkQ8X57AaJtSWfe+M3ZGqE5euHc
         hpFzURjR67Mtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD08FC0C3EC;
        Tue, 23 Aug 2022 20:42:58 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit fixes update for Linux 6.0-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <83371a8c-9f40-3947-51d0-07efc15bdae2@linuxfoundation.org>
References: <83371a8c-9f40-3947-51d0-07efc15bdae2@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <83371a8c-9f40-3947-51d0-07efc15bdae2@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-6.0-rc3
X-PR-Tracked-Commit-Id: 41a55567b9e31cb852670684404654ec4fd0d8d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6234806f8c9fe93f8db99cb47fc079ce78aabbd5
Message-Id: <166128737876.14227.11742603700002979475.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Aug 2022 20:42:58 +0000
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

The pull request you sent on Mon, 22 Aug 2022 16:08:31 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-6.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6234806f8c9fe93f8db99cb47fc079ce78aabbd5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
