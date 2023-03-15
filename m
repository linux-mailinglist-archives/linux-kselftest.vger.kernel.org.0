Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00AB6BBD4D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 20:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjCOTd0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 15:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjCOTd0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 15:33:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ADC7DD2E;
        Wed, 15 Mar 2023 12:33:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3709B81F13;
        Wed, 15 Mar 2023 19:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C887C433EF;
        Wed, 15 Mar 2023 19:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678908800;
        bh=+2XMoGg6ymRXMsT0pfT+7Qtw+D27bg0qpFJW1pRbnAA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=V4ERdTl5zuOOWvS9JboGZJaT0YW8h3yd6kWvouJdjXAIh+Oyex2uB5WrAAeDkULDg
         3ZcJAahGV1JDgYumdI93Yxd3dRgWzGam5Y9Bkcguxn4ppij8MfABBcRb+LcwmlaLEi
         HObJYTyrhIB3g9KHpAf1edeGSMjqv7wohcY7Wsroa+diLtmwbshLRGLatihHDm/ZDO
         jPo45ermlvnjpS6NkACFbfmcJn64ShWy0yPIagpWzjRqLwa5HSncJUsK1ZYHDR0Qi/
         3Pd9Zb8ramv/fk7zWvk3CVnSR5yrQ3tP/dT0kHsrRwCG8PvoVgdAeelAETyC5J72VE
         GK29cl3wZcECg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61704E66CBA;
        Wed, 15 Mar 2023 19:33:20 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 6.3-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2628e459-597b-3ab7-f330-e0f4659f3efc@linuxfoundation.org>
References: <2628e459-597b-3ab7-f330-e0f4659f3efc@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <2628e459-597b-3ab7-f330-e0f4659f3efc@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.3-rc3
X-PR-Tracked-Commit-Id: 624c60f326c6e5a80b008e8a5c7feffe8c27dc72
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c1bec9c0b08abeac72ed6214b723adc224013bf
Message-Id: <167890880039.11733.1191821424667941921.pr-tracker-bot@kernel.org>
Date:   Wed, 15 Mar 2023 19:33:20 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Wed, 15 Mar 2023 13:13:43 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c1bec9c0b08abeac72ed6214b723adc224013bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
