Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D815B3EB3
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 20:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiIISRG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 14:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiIISQp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 14:16:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B7410B011;
        Fri,  9 Sep 2022 11:16:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1605F620B3;
        Fri,  9 Sep 2022 18:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D13CC433D6;
        Fri,  9 Sep 2022 18:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662747403;
        bh=Ir95EY4ql4acrnL9tllvFhQtCORvvTC1cnvM0vYUjXA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eG/qW4oiUk4yanCsNVIN4iMQOL5ZjQZUYYSF6s0jL6jafCeI5i9X4aGV8U8/HGMwJ
         tPIgdvWOdB0DkmWmLcdidQ9Vncm8rqCVGnzbGDwke0FtuHplnH5nWly6DGlVc/2vU2
         fH8p4+gCRNhSMdWpi/c7ELgUdoM+FWKVy5UyyqoHFPO6PLhxwmlvJEIpBveGJxa52Q
         Ltiw+0bYijaIMLAJNlDYMCJlhSWlRpourdHH7BHPKxiHTMRBZknIlsoarDl5K3B4KV
         ZOfB8UxAXlMPhd6JWsNmMi2zeW5FqaYYbJ+2Ri6yy2/FN9n8o96h8XzB3njVtXBMJB
         K/Sy0r3ekKYeQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A28FC4166E;
        Fri,  9 Sep 2022 18:16:43 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit fixes update for Linux 6.0-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <daa35f0a-afca-ec6c-82d1-8c71b4250d7c@linuxfoundation.org>
References: <daa35f0a-afca-ec6c-82d1-8c71b4250d7c@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <daa35f0a-afca-ec6c-82d1-8c71b4250d7c@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-6.0-rc5
X-PR-Tracked-Commit-Id: 2a2dfc869d3345ccdd91322b023f4b0da84acbe7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e35ff25f9fda4385249f909bce21c8f759bc46d4
Message-Id: <166274740342.9705.13723870578047429849.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Sep 2022 18:16:43 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
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

The pull request you sent on Fri, 9 Sep 2022 11:21:58 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-6.0-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e35ff25f9fda4385249f909bce21c8f759bc46d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
