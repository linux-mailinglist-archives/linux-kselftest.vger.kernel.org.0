Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3CF74037E
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 20:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjF0Sfm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 14:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjF0Sfd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 14:35:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2EF3580;
        Tue, 27 Jun 2023 11:35:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 838CC61221;
        Tue, 27 Jun 2023 18:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2F59C433C9;
        Tue, 27 Jun 2023 18:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687890789;
        bh=34O3TQn/POIkecVm+3UqPNbUOUj7cbmmabl2q1xjxag=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KsgkyQ6/ya1/IUpiRYsu3KRTgvbONlTNt92wMFY0BJst28yvuQoTMaq9Uno0pZnuO
         vgdyrHOhSusIR1D4vrQgzlaZS7sceAKMH/2YVmiNASIV+6/1o8jOiAxOVWpPQd+Low
         raXp7CyHyPVaSuSrux8EwtzJNEooAd0VdSESTox+2O1JxIZi9Ld+wotdR01WSCp64f
         p3JNNgoweaC0gyw9NAfX2UdZyI65HdNvN0Oh+ql77fcoSGupoQOzHMv4TgxNP0VrhE
         0lbEXkkosOkmJUjfOCWk+oRdIphiTl1iT8FCI4C3BpdiHhBRrxCWLKbVnKK4xHl0/R
         dRIESImeXfTGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF940E53807;
        Tue, 27 Jun 2023 18:33:08 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit next update for Linux 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c9649721-c9c1-8dd8-232f-98d6d035f780@linuxfoundation.org>
References: <c9649721-c9c1-8dd8-232f-98d6d035f780@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c9649721-c9c1-8dd8-232f-98d6d035f780@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-6.5-rc1
X-PR-Tracked-Commit-Id: 2e66833579ed759d7b7da1a8f07eb727ec6e80db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ba92dc1de0a25e72b0cddb30386bf611e6cb46e
Message-Id: <168789078884.29279.15126044718891714158.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 18:33:08 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
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

The pull request you sent on Sun, 25 Jun 2023 09:20:59 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ba92dc1de0a25e72b0cddb30386bf611e6cb46e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
