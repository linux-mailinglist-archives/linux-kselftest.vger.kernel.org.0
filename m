Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C778978BCA7
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 04:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjH2CKf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 22:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjH2CKd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 22:10:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003D21AE;
        Mon, 28 Aug 2023 19:10:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D113863D34;
        Tue, 29 Aug 2023 02:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42626C433C7;
        Tue, 29 Aug 2023 02:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693275027;
        bh=7u7Fn1KRwrCyVSJc7SMMrkMvqleCtoKnRlQL2Mz/7aQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Cjih29VyuLlcjGTscjGuk+DG64OEz/+c+1EK3NpFE0r+6xMZacRdUIWPT3+HJIzH8
         902PpehEV+MZZakwPuD+SLSX0GT7R5IUhBbk8+lw4eK33T8+vhp9rI2XrFY+cRg3rc
         yOAHymw0nDrMfTmEM1f8PJtSn+lDReuOt+VKzhEURBAU0/s7cL4XFwMH/lPXl7kpgV
         tilbGKyFXvWVB8o7pt4F1eyVXuyIXtfaPvjUrDV9bXqVI4zoE0GA72Vol9Hqu9aEuJ
         4wJLrRQS1RUkd2V1j8BzWm6X9ox67gKvU7w7DdaQ9KZQRcw5OmbU/zwOPwUIW7V9tj
         fKfN4IDvD7N9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2211BE301F2;
        Tue, 29 Aug 2023 02:10:27 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest update for Linux 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <60f2cdf4-8d85-58ee-eb6c-ba15bb97d783@linuxfoundation.org>
References: <60f2cdf4-8d85-58ee-eb6c-ba15bb97d783@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <60f2cdf4-8d85-58ee-eb6c-ba15bb97d783@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-6.6-rc1
X-PR-Tracked-Commit-Id: 9b1db732866bee060b9bca9493e5ebf5e8874c48
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a31cc7297072a7266a910ca5266b640d27803b4
Message-Id: <169327502711.1632.5479243668876158647.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 02:10:27 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, shuah@kernel.org,
        skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 09:18:10 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a31cc7297072a7266a910ca5266b640d27803b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
