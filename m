Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEAE4FA0EF
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Apr 2022 03:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239904AbiDIBLW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 21:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239330AbiDIBLU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 21:11:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A605337A92;
        Fri,  8 Apr 2022 18:09:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D68EB82DFB;
        Sat,  9 Apr 2022 01:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09B38C385A3;
        Sat,  9 Apr 2022 01:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649466553;
        bh=FQuzKu6yg787WQYGd+91H/VL60/wz5Prh4W0gVs0DZ0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NB4vcqorZS5LH7gNVbozsE6T7hKOnplij5N3YcDIUI2pJGZJAtWaCabR420QdBN4q
         C3lSPlZX8C9vLgiiHrN6M+yM/46CsWMBUT8YbgDQgOjiapP7P87T/Ipj5GEQZha4h/
         hwQGOajE4QGfxrOxE21tZ3AEN35UQAizmE40BD5TD1ECo9kFZasva9OF09c8LkHpCG
         KoZwuDVlD/0yvFGou9oefHKBl6mmz6Aqi4vRAeVQEBj2m/5y+7yxNHeFvNU3+BpVYz
         KjcMq9GBlsxPatndjqkA3Dh+L2wcyo5FFTvMrBOxI1d4hLpd30mmBLxdji0+16+BU8
         4I7/DK/j0GAag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E6E49E8DCCE;
        Sat,  9 Apr 2022 01:09:12 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit update for Linux 5.18-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f8e5687f-958b-c97b-4ddb-7bbfbdfa036f@linuxfoundation.org>
References: <f8e5687f-958b-c97b-4ddb-7bbfbdfa036f@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f8e5687f-958b-c97b-4ddb-7bbfbdfa036f@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.18-rc2
X-PR-Tracked-Commit-Id: 02c7efa43627163e489a8db87882445a0ff381f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c7376da23587738ab0e84b8b90b6cc02db5181e
Message-Id: <164946655294.8314.14661504987868871783.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Apr 2022 01:09:12 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Fri, 8 Apr 2022 12:55:58 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.18-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c7376da23587738ab0e84b8b90b6cc02db5181e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
