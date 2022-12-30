Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCAC6593EE
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Dec 2022 02:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiL3BBJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Dec 2022 20:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbiL3BBI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Dec 2022 20:01:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893B56307;
        Thu, 29 Dec 2022 17:01:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CB69B81A68;
        Fri, 30 Dec 2022 01:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8623C433D2;
        Fri, 30 Dec 2022 01:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672362061;
        bh=ACIYf577nytQcWe6qRZudVfJ55Jsy5Fr98eWfNY3+RQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AjfB3WLVEd8obLUjMzWZRxHI++rYu83ZZ1mHlsrfqcAi6mzPrQht6uoud0i6K7Zbi
         E4DssbwFyb+tNLL1bXeoKQKATbP62XyayxiWVZSrdzS3C0dGuIEXbKfuNymqP1KY67
         MNxKawTeMwmKekLvGA5nR7ynpIy6SqYpwEybfVflDVN8S+QNjFmLdlkHT9vXGKVmIH
         pOZLPXwjcnetI+127wASGEthuvGAtIHct+nBtUq8HJYfiOw0gS14T/i1bOoV+3TFWP
         EykD9xJaNwUSg4pWBzYRr4gP1OFUdDOleoiR3eOPJfxha4tns0jrtTQU8TsianEFYC
         V39b46dJdo4gQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D03EBC197B4;
        Fri, 30 Dec 2022 01:01:01 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit fixes update for Linux 6.2-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <226f1d09-aed1-e1c7-1607-e71393cd3a51@linuxfoundation.org>
References: <226f1d09-aed1-e1c7-1607-e71393cd3a51@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <226f1d09-aed1-e1c7-1607-e71393cd3a51@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-6.2-rc2
X-PR-Tracked-Commit-Id: 93ef83050e597634d2c7dc838a28caf5137b9404
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69fb073b5ba6d7c9358a04115ed61b78c73790ce
Message-Id: <167236206183.9684.13615806757707381657.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Dec 2022 01:01:01 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Thu, 29 Dec 2022 16:07:21 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-6.2-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69fb073b5ba6d7c9358a04115ed61b78c73790ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
