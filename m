Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C877F4A7773
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Feb 2022 19:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346410AbiBBSEQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Feb 2022 13:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345599AbiBBSEO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Feb 2022 13:04:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA18AC061714;
        Wed,  2 Feb 2022 10:04:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B53BBB83221;
        Wed,  2 Feb 2022 18:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86333C004E1;
        Wed,  2 Feb 2022 18:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643825051;
        bh=hwNErT/P+d3qAAdID9nFQiqbwceJr26YwPgPSy5DWuc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JNP/LEK3/M+Ecv3GOYlT2ARVNMNkANvIwQ884reEVMifBvUhIzPvEyZ+VltD2s7LD
         ox3g03WM7VElU+fKy+Q6NOzqTfIEULGDyVOmgpGCqpz+75ZVr9lHXWpRxqc+rBl62x
         51Rau+l2XY+nWQOlCNYhk/QMDB7tJt8kMkAb14fJn1bcaZ4763bbHCTKU9lV1LmNAp
         fRYcsWpLDrbRmM3JnPMxG4SeYZZaUP3Ao6EWgUAb+5G4pkceWAym+ukrKa5GxYlMu3
         w09V2njZ2/XAng6XO9qh+Sr2STH1MmOBrfvle0u/0GCZQyLwJjOff7eiksGPe6W6di
         ol69B7d2/dYzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75AC8E5D07E;
        Wed,  2 Feb 2022 18:04:11 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit fixes update for Linux 5.17-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <714c5db3-dcf8-86ba-4e87-49c9a36f9862@linuxfoundation.org>
References: <714c5db3-dcf8-86ba-4e87-49c9a36f9862@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <714c5db3-dcf8-86ba-4e87-49c9a36f9862@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.17-rc3
X-PR-Tracked-Commit-Id: 235528072f28b3b0a1446279b7eaddda36dbf743
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27bb0b18c208ecd4c0deda6aad28616d73e4133d
Message-Id: <164382505147.25739.5469509160674846918.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Feb 2022 18:04:11 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Tue, 1 Feb 2022 15:12:16 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.17-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27bb0b18c208ecd4c0deda6aad28616d73e4133d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
