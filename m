Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659D178BCA9
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 04:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbjH2CKg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 22:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbjH2CKd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 22:10:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831911B6;
        Mon, 28 Aug 2023 19:10:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 122BA63E5A;
        Tue, 29 Aug 2023 02:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D719C433CA;
        Tue, 29 Aug 2023 02:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693275027;
        bh=iz8X+hmF9aRa6D52fCf277nD+b96VLQbFO4UuTAMOGw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nbWl2DUJjH2Cy6VeMXKKUn97lEbsQN+xG1FuDqa0Zva4qfqPQntN6I4VQ+PAHUW+6
         2PbktZNKSYEE1kJmsHBmCLD4aSof9MANtkQXPWR0HHwDUC4w3F8ZfK1T90M+DEGyAD
         dJHQn55Xiim+fJeXlWVbLnBAPiZEMKYA3dGF6gW54Bzwz1pCgchMRSR0jTDVrpk1Hx
         fIKuOmwn3ix8YqOtfAP394ybvkWAyWdPvQp0I7xoOSK9vQcKiYAPzxV3QsdM9Uf0CR
         Njg8/AZdrKzrLPOAzGPVhZvqh6kEi1OgQuZpXZouceCo8bsnsjGDrQ5AZg/DZkP+j4
         iACZoPizvEVmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 516EEC3959E;
        Tue, 29 Aug 2023 02:10:27 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit next update for Linux 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f786a4f9-93f3-716b-3f7f-a3f7b4c889f4@linuxfoundation.org>
References: <f786a4f9-93f3-716b-3f7f-a3f7b4c889f4@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f786a4f9-93f3-716b-3f7f-a3f7b4c889f4@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-6.6-rc1
X-PR-Tracked-Commit-Id: 25e324bc9cf2ee956eec1db384c39c1a17b7c44a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 815c24a085dd8ab9bb7381e455afdb3f9c260e38
Message-Id: <169327502732.1632.18267886333295849373.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 02:10:27 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 10:21:36 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/815c24a085dd8ab9bb7381e455afdb3f9c260e38

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
