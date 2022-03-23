Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E944E597A
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Mar 2022 21:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344517AbiCWUBf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Mar 2022 16:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344493AbiCWUBe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Mar 2022 16:01:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F4566F82;
        Wed, 23 Mar 2022 13:00:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06E1761478;
        Wed, 23 Mar 2022 20:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F925C340E8;
        Wed, 23 Mar 2022 20:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648065603;
        bh=FGcVGWS4iCPVuge2DtTwPl36N2a1kacRMzJBiOU2kpw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WDxsVf8XtzTHuNRpgZ89Mlj3kQqrmWYkXOFg/PNZd4hQcScMGGCJfvMk7aBSGeOhX
         6Ysg49Gc0iL6H+9ZjfiaqwhjToOyGL/XvqfAgTGg2MgcoF1aXD8dzwG0U4FMorV9l7
         B8MckUJPd3RcoOJg2ZytjbUN9fjUosGoQHNP6v23yo3BzT7DQ/F/62jRhci66KofDT
         eHH5GeGz96aQqj91Jlc5YdMOvPuaoRv7o9y3mcHF9dltHCJOC1Waqg73vrb2J4Vcf8
         dYaokSHQpBB67sH7lcfgMV86sWhfw9Lv2Au9NP/KlUU5rxJkwpqfbUn6UcELXb/62x
         yBbFjB8kukqSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3948AE6D402;
        Wed, 23 Mar 2022 20:00:03 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <fac10dac-f8e3-97b9-8d11-0ca2136991ed@linuxfoundation.org>
References: <fac10dac-f8e3-97b9-8d11-0ca2136991ed@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <fac10dac-f8e3-97b9-8d11-0ca2136991ed@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.18-rc1
X-PR-Tracked-Commit-Id: f6d344cd5fa6a15e1ec2da350470b35a3f55f74c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23d1dea55520c5cf89849279cd25de4da8392687
Message-Id: <164806560322.26344.11145189912068627846.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Mar 2022 20:00:03 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 19:31:54 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23d1dea55520c5cf89849279cd25de4da8392687

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
