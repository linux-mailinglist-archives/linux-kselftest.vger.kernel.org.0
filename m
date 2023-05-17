Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B78C7070C5
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 20:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjEQSaE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 14:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjEQSaD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 14:30:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630034680;
        Wed, 17 May 2023 11:30:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAB4B64404;
        Wed, 17 May 2023 18:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A060C433EF;
        Wed, 17 May 2023 18:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684348201;
        bh=pJxm1lAoyUrFH+Lq7DqbstSHgNTv3VzNE9ymy8CKO+g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NqGOPOp53izpjxSoCrU/Nvfj6DZMyydsQgBrjZK1L3dmttKzaYxsbKw7RXeJd0OQH
         L8KLUzFhFnWcDC8tAq84CKyoDxeyFi8eI/OhpbmPFXBPZff4WRVQEUxMeq6ox3Tw/m
         mauMPM+wE30waCssFj8I0ou91gtnUgjzIihZOo1iQS9BlAXGWNabeGns9MH14r3cZT
         RNYy2bDu8EGgiv+6nzTkkjTGTVnG4zP5xkfdcGgIs8vpILNsgUGvCjdkhbp+U6+Non
         L1+xtwVoQlWPE++NY5lU7bgLh0BNfPj6lXK9ESlBIn1cBvpVzpcNyW8UDWJau2KbXZ
         13eSJOOUNuSdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4432CE5421C;
        Wed, 17 May 2023 18:30:01 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 6.4-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <eadfd317-7a66-2cf7-72ca-ee9b8b0aea91@linuxfoundation.org>
References: <eadfd317-7a66-2cf7-72ca-ee9b8b0aea91@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <eadfd317-7a66-2cf7-72ca-ee9b8b0aea91@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.4-rc3
X-PR-Tracked-Commit-Id: dbcf76390eb9a65d5d0c37b0cd57335218564e37
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d6d4c7f541d7027beed4fb86eb2c451bd8d6fff
Message-Id: <168434820126.28641.158182043734203418.pr-tracker-bot@kernel.org>
Date:   Wed, 17 May 2023 18:30:01 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     torvalds@linux-foundation.org, skhan@linuxfoundation.org,
        shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Wed, 17 May 2023 11:51:13 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d6d4c7f541d7027beed4fb86eb2c451bd8d6fff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
