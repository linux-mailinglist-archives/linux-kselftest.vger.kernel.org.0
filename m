Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9167675824B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 18:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjGRQkV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 12:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjGRQkQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 12:40:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943CB173D;
        Tue, 18 Jul 2023 09:40:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EE706167A;
        Tue, 18 Jul 2023 16:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3A14C433C8;
        Tue, 18 Jul 2023 16:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689698408;
        bh=uoA58m02LSpcuj3DQye9YAld0pAf5vI1qOUhtbUDyGY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ATHWnSMNywQas/zrvMV9VQcykF9QBUc/tZSrlcibWw1kLV9N0HhmgOHZd/ZosXQOW
         lzGfuP3vuSRuPgc5SQv0KzYHEgK282x/hlljE5TAGXcQUb7GEe+bPshLiq9AANNB+T
         A311xIitwUoPxgTkt998YJpdCuvXM7KZx9dCQShWvrLFTTsO23EJe1ct+UEjKMKlOn
         Bto356bfvPS/Qvyvs5BcK+GZnkN125CSzsuHOjN9VmYAvgRtLpiUTtXl3xf30QhFev
         vLX3Itkplz7bv4XGvY8d7loJLAcH1R+u82xqS0Ka1GiMKPshWiFp5HRt5F5Nyp+Uiw
         08ENuBvFdGztg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7EEFE22AE0;
        Tue, 18 Jul 2023 16:40:08 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 6.5-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0d655122-a978-93ce-405c-c1eb1d264708@linuxfoundation.org>
References: <0d655122-a978-93ce-405c-c1eb1d264708@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <0d655122-a978-93ce-405c-c1eb1d264708@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.5-rc3
X-PR-Tracked-Commit-Id: 569f8b501b177f21121d483a96491716ab8905f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74f1456c4a5f3d7da4102ecae5c20370f89c6ed1
Message-Id: <168969840874.16296.14023976258207980916.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Jul 2023 16:40:08 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        shuah <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Tue, 18 Jul 2023 09:17:00 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.5-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74f1456c4a5f3d7da4102ecae5c20370f89c6ed1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
