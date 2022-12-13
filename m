Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB83B64AC9E
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Dec 2022 01:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbiLMAwY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Dec 2022 19:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiLMAwY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Dec 2022 19:52:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5128F1704D;
        Mon, 12 Dec 2022 16:52:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE7BCB80B7C;
        Tue, 13 Dec 2022 00:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CFA7C433EF;
        Tue, 13 Dec 2022 00:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670892740;
        bh=g12ydhiVYbuuMQpkjwoMNz6NzoGBI6BscB2FvUL4mi8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aIykkxKbNILbzxBFbXJ3O8WGP1lq5ce1lXG0DsNnBDaQAmdtkucGTFQ8ImA0eMX37
         SLd3A143Av5+mc4qPrfp9NsvQte9laYXvYcnlQYUijowDZOKwmw05q+X1hOZ6Jw9jD
         sIofKrfzL/fDpQVB/S5D/3UNEY2MoIKdYmw/RbrmG/QU+x+jYrJGlfvKhYMD20mA4y
         g9B6Rhw5HZTvqy3UbWljTRd1CuhLpcYtgHTcrQXESSI1gIHw2rCfguCWJDZheE91u7
         YwRaAEzyQcLncU2dRDknVz9LCuf8O+T/qjyPlgOC0iuAxEnCY8kWa3vKprQOPo87GB
         MubjDcWlYNd3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E2C1C00445;
        Tue, 13 Dec 2022 00:52:20 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest update for Linux 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e9e2d930-b24b-bf70-e5de-6a683da97d9c@linuxfoundation.org>
References: <e9e2d930-b24b-bf70-e5de-6a683da97d9c@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e9e2d930-b24b-bf70-e5de-6a683da97d9c@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-6.2-rc1
X-PR-Tracked-Commit-Id: d5ba85d6d8be7da660d4ac25761a48c74ade958d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23a68d14def8247735b66a14b370b42d8fcedb47
Message-Id: <167089274050.13252.3570915835384681911.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 00:52:20 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 12:59:15 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23a68d14def8247735b66a14b370b42d8fcedb47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
