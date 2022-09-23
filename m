Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1A65E7FAF
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Sep 2022 18:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbiIWQ0I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Sep 2022 12:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbiIWQZ6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Sep 2022 12:25:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC3911ED69;
        Fri, 23 Sep 2022 09:25:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28A7FB82409;
        Fri, 23 Sep 2022 16:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2C9FC433D6;
        Fri, 23 Sep 2022 16:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663950354;
        bh=vhlZJqRt/3pyA8ACDMYA/71Prb86Rx2Gv4n2gGjPHaw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kSHs5oGlyhhqezHlROkyg/quDX0qpY0uABsluJ4tEMItUcSPCQPI/4VLt71STHcxl
         jEWQ5geGUHzKlCEIK6mBYzIe4HmV+ushtkPMJ4ro7WwKmaSCzILG/haZsKpkjPxtO6
         OYl6xobqIvjQJpJxXLQkcnEipDOYhv5bAfv4JE3LriwO18IFID7JlkrHm65W/V+0i+
         fuF3l3SNv+skvT5P6JABZU854ZSSg+g2P54JzRj3rLFkIj2T55fGvcaGip5JMHvQOc
         EnXqUdHtV7GfBJd1eb8X+QTUT6R3mT8h/Wy8xbrQNSSxz+y04wopsE4klo47xwlQLM
         A2zEfGlRbs9Nw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B055AE4D03A;
        Fri, 23 Sep 2022 16:25:54 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock fix for v6.0 #2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220923104322.3182116-1-mic@digikod.net>
References: <20220923104322.3182116-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220923104322.3182116-1-mic@digikod.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.0-rc7
X-PR-Tracked-Commit-Id: a52540522c9541bfa3e499d2edba7bc0ca73a4ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9395cd7cef45698a7fd64f53cf97ce511e1334ba
Message-Id: <166395035471.8411.15162186263999480923.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Sep 2022 16:25:54 +0000
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Anders Roxell <anders.roxell@linaro.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Fri, 23 Sep 2022 12:43:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9395cd7cef45698a7fd64f53cf97ce511e1334ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
