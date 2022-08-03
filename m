Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8979588600
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Aug 2022 05:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbiHCDXY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Aug 2022 23:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbiHCDXX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Aug 2022 23:23:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2654F64B;
        Tue,  2 Aug 2022 20:23:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E56B61261;
        Wed,  3 Aug 2022 03:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF26FC43141;
        Wed,  3 Aug 2022 03:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659497001;
        bh=B06fmTbjeLa/iOPUM837Qeo/Oih92Ecw7mXQ7rxkr18=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TwBZAFo4kf5rDURmvsf45M82vKwAbZ+yFVp0CDDd29AspP/vNSGZraMpWuYvypiWm
         RC0TbuyJhye3KrJUCjk2xyjySgKYy8l6kBx+lf1a1OGcM1ZT1hAwokhjyS4gl50kQC
         at1SPi6fFrpCOHvyvXy+J1aU9jXQd7H3rmJcnBo4gOLoirJZIBknj7bhMMrHnzLBvN
         6WDyvRMCaxgLCTxYMXBPJEtzBIXA+EmtigR5sKVg6TP/VNiJfloT/g23QRtbJ5h2gt
         FNYLdRx9K3oMlBvmv+hohj5fLMwKZwroYFn7H+JzHYLTJuizw0T2M0OVjmlH567dtv
         w8alf4rO7P0hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CDEDDC43142;
        Wed,  3 Aug 2022 03:23:21 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <430ef132-2ac7-e1be-68ed-3d9c27382143@linuxfoundation.org>
References: <430ef132-2ac7-e1be-68ed-3d9c27382143@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <430ef132-2ac7-e1be-68ed-3d9c27382143@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.20-rc1
X-PR-Tracked-Commit-Id: 4062eba9f3d072e72645860fbc5d160428a75c50
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e05d5b9c5bbea80313d8f58c3a80a18839b25480
Message-Id: <165949700183.31205.10301826504205188519.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Aug 2022 03:23:21 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 16:03:40 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e05d5b9c5bbea80313d8f58c3a80a18839b25480

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
