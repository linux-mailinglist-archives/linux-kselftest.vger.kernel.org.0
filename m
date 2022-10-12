Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02595FCE76
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Oct 2022 00:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJLWdn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Oct 2022 18:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiJLWdi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Oct 2022 18:33:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751C3103D83;
        Wed, 12 Oct 2022 15:33:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28F6FB81C27;
        Wed, 12 Oct 2022 22:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7E5DC433D6;
        Wed, 12 Oct 2022 22:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665614014;
        bh=NRwQVmcxuR/tZKbHXK5KTa5IwUsIuw5nUbHBMa9mBGc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jEoDwFBSYdyfAzOrLN91YWhpiuNbtBc28nL/0OeEwO/ry7M31yQx1cNOkycjL49Aa
         UqcCgF4kJqxMUd7In5UuLz3ODxSDgj1Rfm/OdLS6NevL0siiiJxWEb4wwyig43MyHh
         wXP6tdIEzx72a5pJrSzmJbKXtppow0CMLFlSocEzSobSCVvYLWdu9jcHCd+rTUg4K3
         EyK7GzquB+wuQ6GDb6PZ0WBuDOOmwVS0AV7uMQ8R6LAotYfi2w1pVLX/Col3aGB+yb
         TD/RSkq1Pji4M0s32xvSMEHOr/GBziCLbOO29Sk/+9/jNFadFIsK1meQDmgiAcf5TW
         sP+Y305aObXJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3E13E29F37;
        Wed, 12 Oct 2022 22:33:34 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit second update for Linux 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4de26e59-3ea8-a434-96ff-171c4616069e@linuxfoundation.org>
References: <4de26e59-3ea8-a434-96ff-171c4616069e@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4de26e59-3ea8-a434-96ff-171c4616069e@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-6.1-rc1-2
X-PR-Tracked-Commit-Id: e98c4f6afc5e21507737066433699f225a180db7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a185a0995518a3355c8623c95c36aaaae489de10
Message-Id: <166561401486.16489.7948642865645924814.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Oct 2022 22:33:34 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Wed, 12 Oct 2022 12:58:31 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-6.1-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a185a0995518a3355c8623c95c36aaaae489de10

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
