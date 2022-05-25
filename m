Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1572D534319
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 May 2022 20:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237806AbiEYShy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 May 2022 14:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343970AbiEYShx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 May 2022 14:37:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9117BB8BC8;
        Wed, 25 May 2022 11:37:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21060618D5;
        Wed, 25 May 2022 18:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 880D3C34117;
        Wed, 25 May 2022 18:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653503857;
        bh=JJ7SNvRNw6d5RG0y1pp2M4hVPW74mYFMePRx0hXsCUw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tl3w2bPIJ+bswz/gKaoGkTaY1C/t6/zU4j0n9joWYvMXFspkfBx6EJgYFnPHGgkUL
         1X489hG+BAjfGZPMTjg/BJkmZ12FuHoMjdd8FgmyK5SOF2EJgXss1eHm3GH7BiHiWj
         /FfdYEneT/AbLQZJz/3xJJHvy2L8YdyWIdJm5C7spYOeCAPdg3eP8VuepQR0INODKb
         s504RJ2f7dGBMHDQcdm8WXS66RarWySAwwR/hC8E34KzFIUjdDqEwKTC8dnJcdbhGA
         nfwKzxJulOWi/W+3m+A67eeVSExWv6BTehPZZ7b+/1Pc3B5N9Sz/CreS8/S9Y4JjYd
         5xdGwyMk0EkLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 706DFE8DBDA;
        Wed, 25 May 2022 18:37:37 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit update for Linux 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <76e8af6c-9757-4367-1407-84fbad96cc8d@linuxfoundation.org>
References: <76e8af6c-9757-4367-1407-84fbad96cc8d@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <76e8af6c-9757-4367-1407-84fbad96cc8d@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.19-rc1
X-PR-Tracked-Commit-Id: e7eaffce47b7db72b077630dbe836f0c4132496d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64e34b50d7aeee7082287ec39f9d34d4e60f3a04
Message-Id: <165350385745.15754.7197891709928038387.pr-tracker-bot@kernel.org>
Date:   Wed, 25 May 2022 18:37:37 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        shuah <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 12:21:27 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64e34b50d7aeee7082287ec39f9d34d4e60f3a04

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
