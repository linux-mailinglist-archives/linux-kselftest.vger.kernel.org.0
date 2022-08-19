Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665CC599363
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 05:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343577AbiHSDM5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Aug 2022 23:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243368AbiHSDMr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Aug 2022 23:12:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDEDDC098;
        Thu, 18 Aug 2022 20:12:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66E43614AA;
        Fri, 19 Aug 2022 03:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC02CC433D7;
        Fri, 19 Aug 2022 03:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660878765;
        bh=e7vrg4QvO7FmyVAz4sNPRMun6YypfEtJK/1mvxkwBFw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eUagnhftcQcAPHMDM0S4Vcq7NlW5HhjIl1rO8Zu4cBxbwOLCGjLyUBbf03Ki7RIo8
         htmFLrfZ0sqkaI5jiLfbP8mKO0ssFTUjKrM/cZEySBFbnHDpcmW5Jqu01f8TqTGI8t
         gSTGaOX4YOTw9oxhWh1SF+MeW+5jPieo74yYkE9V1Ip0KRLaeUPg1yclVM2Rdyn76X
         xjA1ZDTrzcDnRt6AnwsEDFjWDDM+9Mmu3olM4/MMTm9aRcoMoralOr/fonH+9I2vVa
         zFulmYf5J+dIsTAwiEYPqqXtAaN3aCPLrlJ5Db1/NoLg06sjIBsZDofjUniiyR+NUc
         dfyWYoFwt/6PQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BAABCE2A04D;
        Fri, 19 Aug 2022 03:12:45 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest update for Linux 6.0-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a764f978-b13d-ec73-5538-6aa3cb1d13b4@linuxfoundation.org>
References: <a764f978-b13d-ec73-5538-6aa3cb1d13b4@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <a764f978-b13d-ec73-5538-6aa3cb1d13b4@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-6.0-rc2
X-PR-Tracked-Commit-Id: f1227dc7d0411ee9a9faaa1e80cfd9d6e5d6d63e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90b6b686c1e0273ce6d1724fab9b9651a276217e
Message-Id: <166087876575.25117.17314432004884995091.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Aug 2022 03:12:45 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?= =?UTF-8?Q?n?= <mic@digikod.net>,
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

The pull request you sent on Thu, 18 Aug 2022 10:23:11 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-6.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90b6b686c1e0273ce6d1724fab9b9651a276217e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
