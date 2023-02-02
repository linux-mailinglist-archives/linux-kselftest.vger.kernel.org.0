Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFF86888D3
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Feb 2023 22:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjBBVNr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Feb 2023 16:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjBBVNq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Feb 2023 16:13:46 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9844E305FC;
        Thu,  2 Feb 2023 13:13:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B836CCE2D3C;
        Thu,  2 Feb 2023 21:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02885C433EF;
        Thu,  2 Feb 2023 21:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675372422;
        bh=DKKQ+tO1tgUDhfOzAilnNw6xkdKEGwuR0VfCl8xyi7k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jxblM3GCdPnj9KQDW8gNRYlVOiAA9CYH75MvwCyqk/9Q7YFlCYj088gWiQSDbr4i9
         Zf99r4vUKlVJvxJFwVYnbX7NJbW/pHmWkdLcwFVmpqaXUszKfx6pKv6RpfTw+Bza7h
         Vf0YfMNZ4Xqmii52w21Ido/xcFwoDtTqsE6fctBEqx+mMkEaX6YCLW4x9uC/HF9PKt
         pNARatfZcjFIElLWb55rSc/J9t6cL+1oAvQxSyVVPFDsPFCww5iuke2qWi6Oe78izc
         pJA1/zctd0Hwl47lmjTWHmlUmzHG4yXamnw8DKyfaF89lpVVNLZMxAu17o1N/BGA0J
         ayY8c0wKUju1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E471CC0C40E;
        Thu,  2 Feb 2023 21:13:41 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit fixes update for Linux 6.2-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3e3c7d22-6338-87e0-314a-883429ba8ff0@linuxfoundation.org>
References: <3e3c7d22-6338-87e0-314a-883429ba8ff0@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <3e3c7d22-6338-87e0-314a-883429ba8ff0@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-6.2-rc7
X-PR-Tracked-Commit-Id: 254c71374a70051a043676b67ba4f7ad392b5fe6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e7368fd30165ced757d64da48e2091c83815ce5c
Message-Id: <167537242192.8208.5727111116445732117.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Feb 2023 21:13:41 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah <shuah@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Thu, 2 Feb 2023 08:54:45 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-6.2-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e7368fd30165ced757d64da48e2091c83815ce5c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
