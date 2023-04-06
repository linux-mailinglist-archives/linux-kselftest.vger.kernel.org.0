Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA4A6DA028
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 20:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240360AbjDFSqN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 14:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240299AbjDFSqM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 14:46:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3D47A8F;
        Thu,  6 Apr 2023 11:46:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5DA964A84;
        Thu,  6 Apr 2023 18:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 215F5C4339C;
        Thu,  6 Apr 2023 18:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680806770;
        bh=hhNSlaVbSeukuMAJEcA+XsSzZ9JGtqV3MLqVy+hqxeQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OdYhpVTjJDxSytRW3FWSJnIFrnv1AgSQssgmxx5Hci9L8c5M/JzJZURckLbJG41i2
         E2kcnm79ku/kb+BPsdJpcxJqhrP5gj2IH458AMUv4yTBeYGr5uCsLDEL/rJHOfSIbG
         su+QRY+0tXshkGiYvxZ3PJ6Bm+/4/ymw8oZnR4QTUYuO7gBp79hCq/WREVKeXVa4es
         9g3syYL9LRI1Rck6LvivMzuwlK3MRLv8qZTiF0VXsBLuXAS6SZ/839xVGUSH2+y4rb
         0P9LDEJgb4rTxMA2Or+ktt2eW9Z8s9j94w4EE5490Sqo6rCTOaelI3+i3GhMg/1dJ9
         iD8X45hjrDaSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DBEBC4167B;
        Thu,  6 Apr 2023 18:46:10 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 6.3-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f9f22f65-3151-6361-871b-a4a119fde11d@linuxfoundation.org>
References: <f9f22f65-3151-6361-871b-a4a119fde11d@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <f9f22f65-3151-6361-871b-a4a119fde11d@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.3-rc6
X-PR-Tracked-Commit-Id: f1594bc676579133a3cd906d7d27733289edfb86
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f2e1a855b47fa9fd936eafa617a7ab4582bd916
Message-Id: <168080677004.24406.8542515462141061376.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Apr 2023 18:46:10 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        shuah <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, tuananhlfc@gmail.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Thu, 6 Apr 2023 09:15:47 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.3-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f2e1a855b47fa9fd936eafa617a7ab4582bd916

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
