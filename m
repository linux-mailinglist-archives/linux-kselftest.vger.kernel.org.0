Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85F7555417
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jun 2022 21:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377737AbiFVTO5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Jun 2022 15:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377757AbiFVTOx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Jun 2022 15:14:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C613703F;
        Wed, 22 Jun 2022 12:14:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C756A61D62;
        Wed, 22 Jun 2022 19:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38BC8C34114;
        Wed, 22 Jun 2022 19:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655925291;
        bh=Id5z2BkLhTt4HDe/GbTD9ZNLRjpG4ID1XDPaAYl54Rw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=S4tO6JlUV55hYtScpr8J0l7kr7PJH1v5urz4q1aKjhr2JpZ4J7ogD1GZIJOfQ15vR
         fAly8+uPItDKvgOS4cS+8oh3wXcfdnkBv3h5uXwVRsmsz4ctErcYI4rd05F7reNQLL
         HjMTjP3Z7890LPmtCmOHjHbx5sOnQxWSR3LIHxt8LD11aUJjNcX9J08EZjm506DYYz
         J/JWcWj57MpIeLS26eQjzkEhyP/vTerb4Hd8+IklSigVkemuX8nJQI7wdZRa06rGBI
         UXb0uaqt3ztzmoZ9Z6oG2X11UnR+4VPOIYRcRubfwwpR0p8lbXO73L6uSHlMZ8SUSm
         bDFLFdEbBZMWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 229B3E737E8;
        Wed, 22 Jun 2022 19:14:51 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <477c2f03-a733-cd05-2551-759de9273cff@linuxfoundation.org>
References: <477c2f03-a733-cd05-2551-759de9273cff@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <477c2f03-a733-cd05-2551-759de9273cff@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.19-rc4
X-PR-Tracked-Commit-Id: 9b4d5c01eb234f66a15a746b1c73e10209edb199
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de5c208d533a46a074eb46ea17f672cc005a7269
Message-Id: <165592529112.24085.16229356649270243724.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Jun 2022 19:14:51 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Wed, 22 Jun 2022 11:58:27 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.19-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de5c208d533a46a074eb46ea17f672cc005a7269

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
